Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F3B963F43
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Aug 2024 10:56:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sjavl-00064G-30; Thu, 29 Aug 2024 04:55:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=t/gt=P4=kaod.org=clg@ozlabs.org>)
 id 1sjavi-00061l-DR; Thu, 29 Aug 2024 04:54:58 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=t/gt=P4=kaod.org=clg@ozlabs.org>)
 id 1sjavf-0001Mr-Lh; Thu, 29 Aug 2024 04:54:58 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4WvZpy29vLz4x7F;
 Thu, 29 Aug 2024 18:54:50 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (Client did not present a certificate)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4WvZpw02XCz4x21;
 Thu, 29 Aug 2024 18:54:47 +1000 (AEST)
Message-ID: <230d7652-4ef1-4376-93a9-4eb2db5cd9ab@kaod.org>
Date: Thu, 29 Aug 2024 10:54:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/13] ppc/xive2: Dump the VP-group and crowd tables with
 'info pic'
To: Michael Kowal <kowal@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, fbarrat@linux.ibm.com, npiggin@gmail.com,
 milesg@linux.ibm.com
References: <20240801203008.11224-1-kowal@linux.ibm.com>
 <20240801203008.11224-7-kowal@linux.ibm.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240801203008.11224-7-kowal@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=t/gt=P4=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 8/1/24 22:30, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
> 
> The 'info pic' HMP command dumps the state of the interrupt controller.
> Add the dump of the NVG and NVC tables to its output to ease debug.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>   include/hw/ppc/xive2.h      | 12 ++++++
>   include/hw/ppc/xive2_regs.h |  6 +++
>   hw/intc/pnv_xive2.c         | 56 ++++++++++++++++++++++++--
>   hw/intc/xive2.c             | 80 +++++++++++++++++++++++++++++++++++++
>   4 files changed, 151 insertions(+), 3 deletions(-)
> 
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index 654f485e9b..b7a7c33ddd 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -53,6 +53,12 @@ typedef struct Xive2RouterClass {
>                      Xive2Nvp *nvp);
>       int (*write_nvp)(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
>                        Xive2Nvp *nvp, uint8_t word_number);
> +    int (*get_nvgc)(Xive2Router *xrtr, bool crowd,
> +                    uint8_t nvgc_blk, uint32_t nvgc_idx,
> +                    Xive2Nvgc *nvgc);
> +    int (*write_nvgc)(Xive2Router *xrtr, bool crowd,
> +                      uint8_t nvgc_blk, uint32_t nvgc_idx,
> +                      Xive2Nvgc *nvgc);
>       uint8_t (*get_block_id)(Xive2Router *xrtr);
>       uint32_t (*get_config)(Xive2Router *xrtr);
>   } Xive2RouterClass;
> @@ -67,6 +73,12 @@ int xive2_router_get_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
>                           Xive2Nvp *nvp);
>   int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
>                             Xive2Nvp *nvp, uint8_t word_number);
> +int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
> +                          uint8_t nvgc_blk, uint32_t nvgc_idx,
> +                          Xive2Nvgc *nvgc);
> +int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
> +                            uint8_t nvgc_blk, uint32_t nvgc_idx,
> +                            Xive2Nvgc *nvgc);
>   uint32_t xive2_router_get_config(Xive2Router *xrtr);
>   
>   void xive2_router_notify(XiveNotifier *xn, uint32_t lisn, bool pq_checked);
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index d71a54f9ff..99840e88a8 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -212,6 +212,7 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf);
>   typedef struct Xive2Nvgc {
>           uint32_t        w0;
>   #define NVGC2_W0_VALID             PPC_BIT32(0)
> +#define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
>           uint32_t        w1;
>           uint32_t        w2;
>           uint32_t        w3;
> @@ -221,4 +222,9 @@ typedef struct Xive2Nvgc {
>           uint32_t        w7;
>   } Xive2Nvgc;
>   
> +#define xive2_nvgc_is_valid(nvgc)    (be32_to_cpu((nvgc)->w0) & NVGC2_W0_VALID)
> +
> +void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx,
> +                               GString *buf);
> +
>   #endif /* PPC_XIVE2_REGS_H */
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 4740c56347..5959e2df3a 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -490,6 +490,35 @@ static int pnv_xive2_write_nvp(Xive2Router *xrtr, uint8_t blk, uint32_t idx,
>                                 word_number);
>   }
>   
> +static int pnv_xive2_get_nvgc(Xive2Router *xrtr, bool crowd,
> +                              uint8_t blk, uint32_t idx,
> +                              Xive2Nvgc *nvgc)
> +{
> +    int type;

May be define type with :

        int type = crowd ? VST_NVC : VST_NVG;

or use directly the ternary operation in the pnv_xive2_vst_read() call below.

> +
> +    if (crowd) {
> +        type = VST_NVC;
> +    } else {
> +        type = VST_NVG;
> +    }
> +    return pnv_xive2_vst_read(PNV_XIVE2(xrtr), type, blk, idx, nvgc);
> +}
> +
> +static int pnv_xive2_write_nvgc(Xive2Router *xrtr, bool crowd,
> +                                uint8_t blk, uint32_t idx,
> +                                Xive2Nvgc *nvgc)
> +{
> +    int type;
> +
> +    if (crowd) {
> +        type = VST_NVC;
> +    } else {
> +        type = VST_NVG;
> +    }
> +    return pnv_xive2_vst_write(PNV_XIVE2(xrtr), type, blk, idx, nvgc,
> +                               XIVE_VST_WORD_ALL);
> +}
> +
>   static int pnv_xive2_nxc_to_table_type(uint8_t nxc_type, uint32_t *table_type)
>   {
>       switch (nxc_type) {
> @@ -2407,6 +2436,8 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
>       xrc->write_end = pnv_xive2_write_end;
>       xrc->get_nvp   = pnv_xive2_get_nvp;
>       xrc->write_nvp = pnv_xive2_write_nvp;
> +    xrc->get_nvgc   = pnv_xive2_get_nvgc;
> +    xrc->write_nvgc = pnv_xive2_write_nvgc;
>       xrc->get_config  = pnv_xive2_get_config;
>       xrc->get_block_id = pnv_xive2_get_block_id;
>   
> @@ -2497,8 +2528,9 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
>       Xive2Eas eas;
>       Xive2End end;
>       Xive2Nvp nvp;
> +    Xive2Nvgc nvgc;
>       int i;
> -    uint64_t xive_nvp_per_subpage;
> +    uint64_t entries_per_subpage;
>   
>       g_string_append_printf(buf, "XIVE[%x] Source %08x .. %08x\n",
>                              blk, srcno0, srcno0 + nr_esbs - 1);
> @@ -2530,10 +2562,28 @@ void pnv_xive2_pic_print_info(PnvXive2 *xive, GString *buf)
>   
>       g_string_append_printf(buf, "XIVE[%x] #%d NVPT %08x .. %08x\n",
>                              chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
> -    xive_nvp_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
> -    for (i = 0; i < XIVE2_NVP_COUNT; i += xive_nvp_per_subpage) {
> +    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVP);
> +    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
>           while (!xive2_router_get_nvp(xrtr, blk, i, &nvp)) {
>               xive2_nvp_pic_print_info(&nvp, i++, buf);
>           }
>       }
> +
> +    g_string_append_printf(buf, "XIVE[%x] #%d NVGT %08x .. %08x\n",
> +                           chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
> +    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVG);
> +    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
> +        while (!xive2_router_get_nvgc(xrtr, false, blk, i, &nvgc)) {
> +            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
> +        }
> +    }
> +
> +    g_string_append_printf(buf, "XIVE[%x] #%d NVCT %08x .. %08x\n",
> +                          chip_id, blk, 0, XIVE2_NVP_COUNT - 1);
> +    entries_per_subpage = pnv_xive2_vst_per_subpage(xive, VST_NVC);
> +    for (i = 0; i < XIVE2_NVP_COUNT; i += entries_per_subpage) {
> +        while (!xive2_router_get_nvgc(xrtr, true, blk, i, &nvgc)) {
> +            xive2_nvgc_pic_print_info(&nvgc, i++, buf);
> +        }
> +    }
>   }
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 034baabf1e..9d19273bc8 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -43,6 +43,51 @@ static uint64_t xive2_nvp_reporting_addr(Xive2Nvp *nvp)
>       return cache_addr;
>   }
>   
> +static uint32_t xive2_nvgc_get_backlog(Xive2Nvgc *nvgc, uint8_t priority)
> +{
> +    uint32_t val = 0;
> +    uint8_t *ptr, i;
> +
> +    if (priority > 7) {
> +        return 0;
> +    }
> +
> +    /*
> +     * The per-priority backlog counters are 24-bit and the structure
> +     * is stored in big endian
> +     */
> +    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
> +    for (i = 0; i < 3; i++, ptr++) {
> +        val = (val << 8) + *ptr;

I see these values are not word aligned. Using be32_to_cpu() would have
been clearer though.

> +    }
> +    return val;
> +}
> +
> +__attribute__((unused))
> +static void  xive2_nvgc_set_backlog(Xive2Nvgc *nvgc, uint8_t priority,
> +                                   uint32_t val)

please drop this routine if unused.

> +{
> +    uint8_t *ptr, i;
> +    uint32_t shift;
> +
> +    if (priority > 7) {
> +        return;
> +    }
> +
> +    if (val > 0xFFFFFF) {
> +        val = 0xFFFFFF;
> +    }
> +    /*
> +     * The per-priority backlog counters are 24-bit and the structure
> +     * is stored in big endian
> +     */
> +    ptr = (uint8_t *)&nvgc->w2 + priority * 3;
> +    for (i = 0; i < 3; i++, ptr++) {
> +        shift = 8 * (2 - i);
> +        *ptr = (val >> shift) & 0xFF;
> +    }
> +}
> +
>   void xive2_eas_pic_print_info(Xive2Eas *eas, uint32_t lisn, GString *buf)
>   {
>       if (!xive2_eas_is_valid(eas)) {
> @@ -189,6 +234,23 @@ void xive2_nvp_pic_print_info(Xive2Nvp *nvp, uint32_t nvp_idx, GString *buf)
>       g_string_append_c(buf, '\n');
>   }
>   
> +void xive2_nvgc_pic_print_info(Xive2Nvgc *nvgc, uint32_t nvgc_idx, GString *buf)
> +{
> +    uint8_t i;
> +
> +    if (!xive2_nvgc_is_valid(nvgc)) {
> +        return;
> +    }
> +
> +    g_string_append_printf(buf, "  %08x PGoNext:%02x bklog: ", nvgc_idx,
> +                           xive_get_field32(NVGC2_W0_PGONEXT, nvgc->w0));
> +    for (i = 0; i <= XIVE_PRIORITY_MAX; i++) {
> +        g_string_append_printf(buf, "[%d]=0x%x ",
> +                               i, xive2_nvgc_get_backlog(nvgc, i));
> +    }
> +    g_string_append_printf(buf, "\n");
> +}
> +
>   static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>   {
>       uint64_t qaddr_base = xive2_end_qaddr(end);
> @@ -600,6 +662,24 @@ int xive2_router_write_nvp(Xive2Router *xrtr, uint8_t nvp_blk, uint32_t nvp_idx,
>      return xrc->write_nvp(xrtr, nvp_blk, nvp_idx, nvp, word_number);
>   }
>   
> +int xive2_router_get_nvgc(Xive2Router *xrtr, bool crowd,
> +                          uint8_t nvgc_blk, uint32_t nvgc_idx,
> +                          Xive2Nvgc *nvgc)
> +{
> +   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
> +
> +   return xrc->get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
> +}
> +
> +int xive2_router_write_nvgc(Xive2Router *xrtr, bool crowd,
> +                            uint8_t nvgc_blk, uint32_t nvgc_idx,
> +                            Xive2Nvgc *nvgc)
> +{
> +   Xive2RouterClass *xrc = XIVE2_ROUTER_GET_CLASS(xrtr);
> +
> +   return xrc->write_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, nvgc);
> +}
> +
>   /*
>    * The thread context register words are in big-endian format.
>    */



Thanks,

C.



