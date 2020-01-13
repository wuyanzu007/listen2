enum PlatformsEnum { MI_GU, QQ, NETEASE, BI_LI_BI_LI }

extension PlatformsExtension on PlatformsEnum {
  String get name {
    switch (this) {
      case PlatformsEnum.MI_GU:
        return "咪咕";
      case PlatformsEnum.QQ:
        return "QQ";
      case PlatformsEnum.NETEASE:
        return "网易云";
      case PlatformsEnum.BI_LI_BI_LI:
        return "bilibili";
    }
    return "";
  }
}

enum PlayModelEnum { ORDER, RANDOM, SINGLE_CYCLE }
