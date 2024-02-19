Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0597D85A976
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Feb 2024 18:00:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc6zV-00020E-RN; Mon, 19 Feb 2024 11:59:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6zS-000203-7R
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:59:38 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rc6zP-0006uf-I8
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 11:59:37 -0500
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TdpYt1Y7Qz6J9yl;
 Tue, 20 Feb 2024 00:55:14 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id C5411140FB6;
 Tue, 20 Feb 2024 00:59:28 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Mon, 19 Feb
 2024 16:59:28 +0000
Date: Mon, 19 Feb 2024 16:59:27 +0000
To: <shiju.jose@huawei.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>,
 <tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v4 3/3] hw/cxl/cxl-mailbox-utils: Add device DDR5 ECS
 control feature
Message-ID: <20240219165927.00006fd8@Huawei.com>
In-Reply-To: <20240219150025.1531-4-shiju.jose@huawei.com>
References: <20240219150025.1531-1-shiju.jose@huawei.com>
 <20240219150025.1531-4-shiju.jose@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-to:  Jonathan Cameron <Jonathan.Cameron@Huawei.com>
From:  Jonathan Cameron via <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, 19 Feb 2024 23:00:25 +0800
<shiju.jose@huawei.com> wrote:

> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.2 describes the DDR5 Error Check Scrub (ECS)
> control feature.
> 
> The Error Check Scrub (ECS) is a feature defined in JEDEC DDR5 SDRAM
> Specification (JESD79-5) and allows the DRAM to internally read, correct
> single-bit errors, and write back corrected data bits to the DRAM array
> while providing transparency to error counts. The ECS control feature
> allows the request to configure ECS input configurations during system
> boot or at run-time.
> 
> The ECS control allows the requester to change the log entry type, the ECS
> threshold count provided that the request is within the definition
> specified in DDR5 mode registers, change mode between codeword mode and
> row count mode, and reset the ECS counter.
> 
> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> Reviewed-by: Fan Ni <fan.ni@samsung.com>
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>

Same thing about it being per device, not global. 

Otherwise, just a few minor comments inline.

> ---
>  hw/cxl/cxl-mailbox-utils.c | 100 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 99 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 908ce16642..2277418c07 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -998,6 +998,7 @@ typedef struct CXLSupportedFeatureEntry {
>  
>  enum CXL_SUPPORTED_FEATURES_LIST {
>      CXL_FEATURE_PATROL_SCRUB = 0,
> +    CXL_FEATURE_ECS,
>      CXL_FEATURE_MAX
>  };
>  
> @@ -1070,6 +1071,43 @@ typedef struct CXLMemPatrolScrubSetFeature {
>  } QEMU_PACKED QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
>  static CXLMemPatrolScrubReadAttrs cxl_memdev_ps_feat_attrs;
>  
> +/*
> + * CXL r3.1 section 8.2.9.9.11.2:
> + * DDR5 Error Check Scrub (ECS) Control Feature
> + */
> +static const QemuUUID ecs_uuid = {
> +    .data = UUID(0xe5b13f22, 0x2328, 0x4a14, 0xb8, 0xba,
> +                 0xb9, 0x69, 0x1e, 0x89, 0x33, 0x86)
> +};
> +
> +#define CXL_ECS_GET_FEATURE_VERSION    0x01
> +#define CXL_ECS_SET_FEATURE_VERSION    0x01
> +#define CXL_ECS_LOG_ENTRY_TYPE_DEFAULT    0x01
> +#define CXL_ECS_REALTIME_REPORT_CAP_DEFAULT    1
> +#define CXL_ECS_THRESHOLD_COUNT_DEFAULT    3 /* 3: 256, 4: 1024, 5: 4096 */
> +#define CXL_ECS_MODE_DEFAULT    0
> +
> +#define CXL_ECS_NUM_MEDIA_FRUS   3
> +
> +/* CXL memdev DDR5 ECS control attributes */
> +typedef struct CXLMemECSReadAttrs {
> +        uint8_t ecs_log_cap;
> +        uint8_t ecs_cap;
> +        uint16_t ecs_config;
> +        uint8_t ecs_flags;
> +} QEMU_PACKED CXLMemECSReadAttrs;
> +
> +typedef struct CXLMemECSWriteAttrs {
> +    uint8_t ecs_log_cap;
> +    uint16_t ecs_config;
> +} QEMU_PACKED CXLMemECSWriteAttrs;
> +
> +typedef struct CXLMemECSSetFeature {
> +        CXLSetFeatureInHeader hdr;
> +        CXLMemECSWriteAttrs feat_data[];
> +} QEMU_PACKED QEMU_ALIGNED(16) CXLMemECSSetFeature;
> +static CXLMemECSReadAttrs cxl_ecs_feat_attrs[CXL_ECS_NUM_MEDIA_FRUS];

This should be device instance specific.

> +
>  /* CXL r3.1 section 8.2.9.6.1: Get Supported Features (Opcode 0500h) */
>  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>                                               uint8_t *payload_in,
> @@ -1088,7 +1126,7 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>          CXLSupportedFeatureHeader hdr;
>          CXLSupportedFeatureEntry feat_entries[];
>      } QEMU_PACKED QEMU_ALIGNED(16) * get_feats_out = (void *)payload_out;
> -    uint16_t index;
> +    uint16_t count, index;
>      uint16_t entry, req_entries;
>      uint16_t feat_entries = 0;
>  
> @@ -1130,6 +1168,35 @@ static CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
>              cxl_memdev_ps_feat_attrs.scrub_flags =
>                                  CXL_MEMDEV_PS_ENABLE_DEFAULT;
>              break;
> +        case  CXL_FEATURE_ECS:
> +            /* Fill supported feature entry for device DDR5 ECS control */
> +            get_feats_out->feat_entries[entry] =
> +                         (struct CXLSupportedFeatureEntry) {
> +                .uuid = ecs_uuid,
> +                .feat_index = index,
> +                .get_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
> +                                    sizeof(CXLMemECSReadAttrs),
> +                .set_feat_size = CXL_ECS_NUM_MEDIA_FRUS *
> +                                    sizeof(CXLMemECSWriteAttrs),
> +                .attr_flags = 0x1,
> +                .get_feat_version = CXL_ECS_GET_FEATURE_VERSION,
> +                .set_feat_version = CXL_ECS_SET_FEATURE_VERSION,
> +                .set_feat_effects = 0,
I think spec says Immediate config change for this one.Plus the CEL bit
should be set (bit 9)

Check this for the other features as well.
 
> +            };
> +            feat_entries++;

Why update this mid setting up the record?  I briefly thought this wrote
two different records (which was odd!)

We don't have gaps in the features - we probably won't ever provide that
degree of control of the QEMU model, so feat_entries will be
req_entries - get_feats_in->start_index
No need to keep a count.

> +            /* Set default value for DDR5 ECS read attributes */
> +            for (count = 0; count < CXL_ECS_NUM_MEDIA_FRUS; count++) {
> +                cxl_ecs_feat_attrs[count].ecs_log_cap =
> +                                    CXL_ECS_LOG_ENTRY_TYPE_DEFAULT;
> +                cxl_ecs_feat_attrs[count].ecs_cap =
> +                                    CXL_ECS_REALTIME_REPORT_CAP_DEFAULT;
> +                cxl_ecs_feat_attrs[count].ecs_config =
> +                                    CXL_ECS_THRESHOLD_COUNT_DEFAULT |
> +                                    (CXL_ECS_MODE_DEFAULT << 3);
> +                /* Reserved */
> +                cxl_ecs_feat_attrs[count].ecs_flags = 0;
> +            }
> +            break;
>          default:
>              break;
>          }


