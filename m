Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D74879D0CF
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 14:14:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg2GO-0004mp-0h; Tue, 12 Sep 2023 08:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qg2GE-0004l1-WD
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:12:58 -0400
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1qg2GB-0003pd-0s
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 08:12:54 -0400
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RlMql1k9pz6HJmy;
 Tue, 12 Sep 2023 20:10:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Tue, 12 Sep
 2023 13:12:38 +0100
Date: Tue, 12 Sep 2023 13:12:37 +0100
To: Gregory Price <gourry.memverge@gmail.com>
CC: <qemu-devel@nongnu.org>, <linux-cxl@vger.kernel.org>, <junhee.ryu@sk.com>, 
 <kwangjin.ko@sk.com>, Gregory Price <gregory.price@memverge.com>
Subject: Re: [PATCH v3 1/6] cxl/mailbox: move mailbox effect definitions to
 a header
Message-ID: <20230912131237.00003e33@Huawei.com>
In-Reply-To: <20230906001517.324380-2-gregory.price@memverge.com>
References: <20230906001517.324380-1-gregory.price@memverge.com>
 <20230906001517.324380-2-gregory.price@memverge.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500001.china.huawei.com (7.191.163.213) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue,  5 Sep 2023 20:15:12 -0400
Gregory Price <gourry.memverge@gmail.com> wrote:

> Preparation for allowing devices to define their own CCI commands
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
I've updated this because I've queued up Davidlohr's
scan media work ahead of this so there is one more usage.

Will push a tree out with both on just as soon as I've finished
working through rest of this series.

Thanks,

Jonathan

> ---
>  hw/cxl/cxl-mailbox-utils.c   | 30 +++++++++++++-----------------
>  include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
>  2 files changed, 31 insertions(+), 17 deletions(-)
>  create mode 100644 include/hw/cxl/cxl_mailbox.h
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 4e8651ebe2..b64bbdf45d 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -12,6 +12,7 @@
>  #include "hw/pci/msix.h"
>  #include "hw/cxl/cxl.h"
>  #include "hw/cxl/cxl_events.h"
> +#include "hw/cxl/cxl_mailbox.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci-bridge/cxl_upstream_port.h"
>  #include "qemu/cutils.h"
> @@ -1561,28 +1562,21 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
>      return CXL_MBOX_SUCCESS;
>  }
>  
> -#define IMMEDIATE_CONFIG_CHANGE (1 << 1)
> -#define IMMEDIATE_DATA_CHANGE (1 << 2)
> -#define IMMEDIATE_POLICY_CHANGE (1 << 3)
> -#define IMMEDIATE_LOG_CHANGE (1 << 4)
> -#define SECURITY_STATE_CHANGE (1 << 5)
> -#define BACKGROUND_OPERATION (1 << 6)
> -
>  static const struct cxl_cmd cxl_cmd_set[256][256] = {
>      [EVENTS][GET_RECORDS] = { "EVENTS_GET_RECORDS",
>          cmd_events_get_records, 1, 0 },
>      [EVENTS][CLEAR_RECORDS] = { "EVENTS_CLEAR_RECORDS",
> -        cmd_events_clear_records, ~0, IMMEDIATE_LOG_CHANGE },
> +        cmd_events_clear_records, ~0, CXL_MBOX_IMMEDIATE_LOG_CHANGE },
>      [EVENTS][GET_INTERRUPT_POLICY] = { "EVENTS_GET_INTERRUPT_POLICY",
>                                        cmd_events_get_interrupt_policy, 0, 0 },
>      [EVENTS][SET_INTERRUPT_POLICY] = { "EVENTS_SET_INTERRUPT_POLICY",
>                                        cmd_events_set_interrupt_policy,
> -                                      ~0, IMMEDIATE_CONFIG_CHANGE },
> +                                      ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE },
>      [FIRMWARE_UPDATE][GET_INFO] = { "FIRMWARE_UPDATE_GET_INFO",
>          cmd_firmware_update_get_info, 0, 0 },
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
> -                         IMMEDIATE_POLICY_CHANGE },
> +                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0, 0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
>      [IDENTIFY][MEMORY_DEVICE] = { "IDENTIFY_MEMORY_DEVICE",
> @@ -1591,9 +1585,11 @@ static const struct cxl_cmd cxl_cmd_set[256][256] = {
>          cmd_ccls_get_partition_info, 0, 0 },
>      [CCLS][GET_LSA] = { "CCLS_GET_LSA", cmd_ccls_get_lsa, 8, 0 },
>      [CCLS][SET_LSA] = { "CCLS_SET_LSA", cmd_ccls_set_lsa,
> -        ~0, IMMEDIATE_CONFIG_CHANGE | IMMEDIATE_DATA_CHANGE },
> +        ~0, CXL_MBOX_IMMEDIATE_CONFIG_CHANGE | CXL_MBOX_IMMEDIATE_DATA_CHANGE },
>      [SANITIZE][OVERWRITE] = { "SANITIZE_OVERWRITE", cmd_sanitize_overwrite, 0,
> -        IMMEDIATE_DATA_CHANGE | SECURITY_STATE_CHANGE | BACKGROUND_OPERATION },
> +        (CXL_MBOX_IMMEDIATE_DATA_CHANGE |
> +         CXL_MBOX_SECURITY_STATE_CHANGE |
> +         CXL_MBOX_BACKGROUND_OPERATION)},
>      [PERSISTENT_MEM][GET_SECURITY_STATE] = { "GET_SECURITY_STATE",
>          cmd_get_security_state, 0, 0 },
>      [MEDIA_AND_POISON][GET_POISON_LIST] = { "MEDIA_AND_POISON_GET_POISON_LIST",
> @@ -1612,10 +1608,10 @@ static const struct cxl_cmd cxl_cmd_set_dcd[256][256] = {
>          8, 0 },
>      [DCD_CONFIG][ADD_DYN_CAP_RSP] = {
>          "ADD_DCD_DYNAMIC_CAPACITY_RESPONSE", cmd_dcd_add_dyn_cap_rsp,
> -        ~0, IMMEDIATE_DATA_CHANGE },
> +        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
>      [DCD_CONFIG][RELEASE_DYN_CAP] = {
>          "RELEASE_DCD_DYNAMIC_CAPACITY", cmd_dcd_release_dyn_cap,
> -        ~0, IMMEDIATE_DATA_CHANGE },
> +        ~0, CXL_MBOX_IMMEDIATE_DATA_CHANGE },
>  };
>  
>  static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> @@ -1628,7 +1624,7 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
>       */
>      [TIMESTAMP][GET] = { "TIMESTAMP_GET", cmd_timestamp_get, 0, 0 },
>      [TIMESTAMP][SET] = { "TIMESTAMP_SET", cmd_timestamp_set, 8,
> -                         IMMEDIATE_POLICY_CHANGE },
> +                         CXL_MBOX_IMMEDIATE_POLICY_CHANGE },
>      [LOGS][GET_SUPPORTED] = { "LOGS_GET_SUPPORTED", cmd_logs_get_supported, 0,
>                                0 },
>      [LOGS][GET_LOG] = { "LOGS_GET_LOG", cmd_logs_get_log, 0x18, 0 },
> @@ -1670,7 +1666,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>      }
>  
>      /* Only one bg command at a time */
> -    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> +    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
>          cci->bg.runtime > 0) {
>          return CXL_MBOX_BUSY;
>      }
> @@ -1691,7 +1687,7 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>      }
>  
>      ret = (*h)(cxl_cmd, pl_in, len_in, pl_out, len_out, cci);
> -    if ((cxl_cmd->effect & BACKGROUND_OPERATION) &&
> +    if ((cxl_cmd->effect & CXL_MBOX_BACKGROUND_OPERATION) &&
>          ret == CXL_MBOX_BG_STARTED) {
>          *bg_started = true;
>      } else {
> diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> new file mode 100644
> index 0000000000..beb048052e
> --- /dev/null
> +++ b/include/hw/cxl/cxl_mailbox.h
> @@ -0,0 +1,18 @@
> +/*
> + * QEMU CXL Mailbox
> + *
> + * This work is licensed under the terms of the GNU GPL, version 2. See the
> + * COPYING file in the top-level directory.
> + */
> +
> +#ifndef CXL_MAILBOX_H
> +#define CXL_MAILBOX_H
> +
> +#define CXL_MBOX_IMMEDIATE_CONFIG_CHANGE (1 << 1)
> +#define CXL_MBOX_IMMEDIATE_DATA_CHANGE (1 << 2)
> +#define CXL_MBOX_IMMEDIATE_POLICY_CHANGE (1 << 3)
> +#define CXL_MBOX_IMMEDIATE_LOG_CHANGE (1 << 4)
> +#define CXL_MBOX_SECURITY_STATE_CHANGE (1 << 5)
> +#define CXL_MBOX_BACKGROUND_OPERATION (1 << 6)
> +
> +#endif


