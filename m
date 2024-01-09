Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C02828B90
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 18:55:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGIt-0003E8-DD; Tue, 09 Jan 2024 12:54:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNGIi-00038r-4P
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:54:08 -0500
Received: from frasgout.his.huawei.com ([185.176.79.56])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonathan.cameron@huawei.com>)
 id 1rNGIe-00052W-SF
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 12:54:07 -0500
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4T8dlc5qyPz67NNV;
 Wed, 10 Jan 2024 01:51:24 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
 by mail.maildlp.com (Postfix) with ESMTPS id 82EC21400D4;
 Wed, 10 Jan 2024 01:53:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Tue, 9 Jan
 2024 17:53:59 +0000
Date: Tue, 9 Jan 2024 17:53:58 +0000
To: Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC: Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>, "Michael
 S . Tsirkin" <mst@redhat.com>, <linux-cxl@vger.kernel.org>,
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v2 3/4] hw/cxl/mbox: replace sanitize_running() with
 cxl_dev_media_disabled()
Message-ID: <20240109175358.00007c48@Huawei.com>
In-Reply-To: <20231222090051.3265307-4-42.hyeyoo@gmail.com>
References: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
 <20231222090051.3265307-4-42.hyeyoo@gmail.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
Received-SPF: pass client-ip=185.176.79.56;
 envelope-from=jonathan.cameron@huawei.com; helo=frasgout.his.huawei.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Fri, 22 Dec 2023 18:00:50 +0900
Hyeonggon Yoo <42.hyeyoo@gmail.com> wrote:

> The spec states that reads/writes should have no effect and a part of
> commands should be ignored when the media is disabled, not when the
> sanitize command is running.qq
> 
> Introduce cxl_dev_media_disabled() to check if the media is disabled and
> replace sanitize_running() with it.
> 
> Make sure that the media has been correctly disabled during sanitation
> by adding an assert to __toggle_media(). Now, enabling when already
> enabled or vice versa results in an assert() failure.
> 
> Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
> Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

This applies to

hw/cxl: Add get scan media capabilities cmd support.

Should I just squash it with that patch in my tree?
For now I'm holding it immediately on top of that, but I'm not keen to
send messy code upstream unless there is a good reason to retain the
history.

If you are doing this sort of fix series in future, please call out
what they fix explicitly.  Can't use fixes tags as the commit ids
are unstable, but can mention the patch to make my life easier!

Thanks,

Jonathan


> ---
>  hw/cxl/cxl-mailbox-utils.c  |  6 ++++--
>  hw/mem/cxl_type3.c          |  4 ++--
>  include/hw/cxl/cxl_device.h | 11 ++++++-----
>  3 files changed, 12 insertions(+), 9 deletions(-)
> 
> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> index 11ec8b648b..efeb5f8174 100644
> --- a/hw/cxl/cxl-mailbox-utils.c
> +++ b/hw/cxl/cxl-mailbox-utils.c
> @@ -2248,6 +2248,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>      int ret;
>      const struct cxl_cmd *cxl_cmd;
>      opcode_handler h;
> +    CXLDeviceState *cxl_dstate = &CXL_TYPE3(cci->intf)->cxl_dstate;
> +
>  
>      *len_out = 0;
>      cxl_cmd = &cci->cxl_cmd_set[set][cmd];
> @@ -2268,8 +2270,8 @@ int cxl_process_cci_message(CXLCCI *cci, uint8_t set, uint8_t cmd,
>          return CXL_MBOX_BUSY;
>      }
>  
> -    /* forbid any selected commands while overwriting */
> -    if (sanitize_running(cci)) {
> +    /* forbid any selected commands while the media is disabled */
> +    if (cxl_dev_media_disabled(cxl_dstate)) {
>          if (h == cmd_events_get_records ||
>              h == cmd_ccls_get_partition_info ||
>              h == cmd_ccls_set_lsa ||
> diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> index 85fc08f118..ecb525a608 100644
> --- a/hw/mem/cxl_type3.c
> +++ b/hw/mem/cxl_type3.c
> @@ -1286,7 +1286,7 @@ MemTxResult cxl_type3_read(PCIDevice *d, hwaddr host_addr, uint64_t *data,
>          return MEMTX_ERROR;
>      }
>  
> -    if (sanitize_running(&ct3d->cci)) {
> +    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
>          qemu_guest_getrandom_nofail(data, size);
>          return MEMTX_OK;
>      }
> @@ -1314,7 +1314,7 @@ MemTxResult cxl_type3_write(PCIDevice *d, hwaddr host_addr, uint64_t data,
>          return MEMTX_ERROR;
>      }
>  
> -    if (sanitize_running(&ct3d->cci)) {
> +    if (cxl_dev_media_disabled(&ct3d->cxl_dstate)) {
>          return MEMTX_OK;
>      }
>  
> diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> index b318d94b36..5618061ebe 100644
> --- a/include/hw/cxl/cxl_device.h
> +++ b/include/hw/cxl/cxl_device.h
> @@ -411,6 +411,7 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>      dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
>      dev_status_reg = FIELD_DP64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS,
>                                  val);
> +    assert(dev_status_reg != cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS]);
>      cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS] = dev_status_reg;
>  }
>  #define cxl_dev_disable_media(cxlds)                    \
> @@ -418,14 +419,14 @@ static inline void __toggle_media(CXLDeviceState *cxl_dstate, int val)
>  #define cxl_dev_enable_media(cxlds)                     \
>          do { __toggle_media((cxlds), 0x1); } while (0)
>  
> -static inline bool scan_media_running(CXLCCI *cci)
> +static inline bool cxl_dev_media_disabled(CXLDeviceState *cxl_dstate)
>  {
> -    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
> +    uint64_t dev_status_reg = cxl_dstate->mbox_reg_state64[R_CXL_MEM_DEV_STS];
> +    return FIELD_EX64(dev_status_reg, CXL_MEM_DEV_STS, MEDIA_STATUS) == 0x3;
>  }
> -
> -static inline bool sanitize_running(CXLCCI *cci)
> +static inline bool scan_media_running(CXLCCI *cci)
>  {
> -    return !!cci->bg.runtime && cci->bg.opcode == 0x4400;
> +    return !!cci->bg.runtime && cci->bg.opcode == 0x4304;
>  }
>  
>  typedef struct CXLError {


