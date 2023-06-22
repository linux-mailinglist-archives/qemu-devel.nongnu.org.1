Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A4A73A6D7
	for <lists+qemu-devel@lfdr.de>; Thu, 22 Jun 2023 19:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCNda-0006nH-P2; Thu, 22 Jun 2023 12:58:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCNdP-0006gN-5C; Thu, 22 Jun 2023 12:58:19 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=yb1G=CK=kaod.org=clg@ozlabs.org>)
 id 1qCNdM-0004Tt-OZ; Thu, 22 Jun 2023 12:58:14 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4Qn64v3v6Cz4x48;
 Fri, 23 Jun 2023 02:58:07 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Qn64t0gGzz4x3k;
 Fri, 23 Jun 2023 02:58:05 +1000 (AEST)
Message-ID: <7884eabd-8e4b-3858-d76b-5c8967e742ca@kaod.org>
Date: Thu, 22 Jun 2023 18:58:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/2] pnv/xive2: Add a get_config() method on the
 presenter class
Content-Language: en-US
To: Frederic Barrat <fbarrat@linux.ibm.com>, danielhb413@gmail.com,
 qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20230622162527.1118350-1-fbarrat@linux.ibm.com>
 <20230622162527.1118350-2-fbarrat@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230622162527.1118350-2-fbarrat@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=yb1G=CK=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_MED=-2.3,
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

On 6/22/23 18:25, Frederic Barrat wrote:
> The presenters for xive on P9 and P10 are mostly similar but the
> behavior can be tuned through a few CQ registers. This patch adds a
> "get_config" method, which will allow to access that config from the
> presenter in a later patch.
> For now, just define the config for the TIMA version.
> 
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

> ---
>   hw/intc/pnv_xive.c    | 11 +++++++++++
>   hw/intc/pnv_xive2.c   | 12 ++++++++++++
>   hw/intc/spapr_xive.c  | 16 ++++++++++++++++
>   hw/intc/xive.c        |  7 +++++++
>   include/hw/ppc/xive.h |  3 +++
>   5 files changed, 49 insertions(+)
> 
> diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
> index 622f9d28b7..e536b3ec26 100644
> --- a/hw/intc/pnv_xive.c
> +++ b/hw/intc/pnv_xive.c
> @@ -479,6 +479,16 @@ static int pnv_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>       return count;
>   }
>   
> +static uint32_t pnv_xive_presenter_get_config(XivePresenter *xptr)
> +{
> +    uint32_t cfg = 0;
> +
> +    /* TIMA GEN1 is all P9 knows */
> +    cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;
> +
> +    return cfg;
> +}
> +
>   static uint8_t pnv_xive_get_block_id(XiveRouter *xrtr)
>   {
>       return pnv_xive_block_id(PNV_XIVE(xrtr));
> @@ -1991,6 +2001,7 @@ static void pnv_xive_class_init(ObjectClass *klass, void *data)
>   
>       xnc->notify = pnv_xive_notify;
>       xpc->match_nvt  = pnv_xive_match_nvt;
> +    xpc->get_config = pnv_xive_presenter_get_config;
>   };
>   
>   static const TypeInfo pnv_xive_info = {
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index ec1edeb385..59534f6843 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -501,6 +501,17 @@ static int pnv_xive2_match_nvt(XivePresenter *xptr, uint8_t format,
>       return count;
>   }
>   
> +static uint32_t pnv_xive2_presenter_get_config(XivePresenter *xptr)
> +{
> +    PnvXive2 *xive = PNV_XIVE2(xptr);
> +    uint32_t cfg = 0;
> +
> +    if (xive->cq_regs[CQ_XIVE_CFG >> 3] & CQ_XIVE_CFG_GEN1_TIMA_OS) {
> +        cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;
> +    }
> +    return cfg;
> +}
> +
>   static uint8_t pnv_xive2_get_block_id(Xive2Router *xrtr)
>   {
>       return pnv_xive2_block_id(PNV_XIVE2(xrtr));
> @@ -1987,6 +1998,7 @@ static void pnv_xive2_class_init(ObjectClass *klass, void *data)
>       xnc->notify    = pnv_xive2_notify;
>   
>       xpc->match_nvt  = pnv_xive2_match_nvt;
> +    xpc->get_config = pnv_xive2_presenter_get_config;
>   };
>   
>   static const TypeInfo pnv_xive2_info = {
> diff --git a/hw/intc/spapr_xive.c b/hw/intc/spapr_xive.c
> index dc641cc604..8bcab2846c 100644
> --- a/hw/intc/spapr_xive.c
> +++ b/hw/intc/spapr_xive.c
> @@ -475,6 +475,21 @@ static int spapr_xive_match_nvt(XivePresenter *xptr, uint8_t format,
>       return count;
>   }
>   
> +static uint32_t spapr_xive_presenter_get_config(XivePresenter *xptr)
> +{
> +    uint32_t cfg = 0;
> +
> +    /*
> +     * Let's claim GEN1 TIMA format. If running with KVM on P10, the
> +     * correct answer is deep in the hardware and not accessible to
> +     * us.  But it shouldn't matter as it only affects the presenter
> +     * as seen by a guest OS.
> +     */
> +    cfg |= XIVE_PRESENTER_GEN1_TIMA_OS;

On POWER10, real HW, a Gen2 TIMA layout is exposed to the OS, HV and guest.
Gen2 and Gen1 being compatible, it is not a problem since Linux (this might
not be true for other OS) doesn't use any of the new Gen2 bits. There is a
larger bitfield for VP CAM, but that's HV world.

Nevertheless, it might be good to expose a Gen2 OS layout when on POWER10
to be closer to reality, with a "property" may be. Who knows, one might
implement the new Gen2 bits, but as of today, there is no difference in
the OS ring of QEMU. No hurries.

Thanks,

C.


> +
> +    return cfg;
> +}
> +
>   static uint8_t spapr_xive_get_block_id(XiveRouter *xrtr)
>   {
>       return SPAPR_XIVE_BLOCK_ID;
> @@ -832,6 +847,7 @@ static void spapr_xive_class_init(ObjectClass *klass, void *data)
>       sicc->post_load = spapr_xive_post_load;
>   
>       xpc->match_nvt  = spapr_xive_match_nvt;
> +    xpc->get_config = spapr_xive_presenter_get_config;
>       xpc->in_kernel  = spapr_xive_in_kernel_xptr;
>   }
>   
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 5204c14b87..34a868b185 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -461,6 +461,13 @@ static void xive_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>       }
>   }
>   
> +static __attribute__((unused)) uint32_t xive_presenter_get_config(XivePresenter *xptr)
> +{
> +    XivePresenterClass *xpc = XIVE_PRESENTER_GET_CLASS(xptr);
> +
> +    return xpc->get_config(xptr);
> +}
> +
>   /*
>    * Define a mapping of "special" operations depending on the TIMA page
>    * offset and the size of the operation.
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index f7eea4ca81..3dfb06e002 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -430,6 +430,8 @@ typedef struct XivePresenterClass XivePresenterClass;
>   DECLARE_CLASS_CHECKERS(XivePresenterClass, XIVE_PRESENTER,
>                          TYPE_XIVE_PRESENTER)
>   
> +#define XIVE_PRESENTER_GEN1_TIMA_OS     0x1
> +
>   struct XivePresenterClass {
>       InterfaceClass parent;
>       int (*match_nvt)(XivePresenter *xptr, uint8_t format,
> @@ -437,6 +439,7 @@ struct XivePresenterClass {
>                        bool cam_ignore, uint8_t priority,
>                        uint32_t logic_serv, XiveTCTXMatch *match);
>       bool (*in_kernel)(const XivePresenter *xptr);
> +    uint32_t (*get_config)(XivePresenter *xptr);
>   };
>   
>   int xive_presenter_tctx_match(XivePresenter *xptr, XiveTCTX *tctx,


