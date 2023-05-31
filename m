Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABD171856B
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 16:59:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4NHn-0001xk-C5; Wed, 31 May 2023 10:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@xora.org.uk>)
 id 1q4NHk-0001vt-4u; Wed, 31 May 2023 10:58:49 -0400
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <graeme@xora.org.uk>)
 id 1q4NHi-0001j7-5p; Wed, 31 May 2023 10:58:47 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
 by mailout.west.internal (Postfix) with ESMTP id 7E8D132008FF;
 Wed, 31 May 2023 10:58:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute1.internal (MEProxy); Wed, 31 May 2023 10:58:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=xora.org.uk; h=
 cc:cc:content-type:content-type:date:date:from:from:in-reply-to
 :in-reply-to:message-id:mime-version:references:reply-to:sender
 :subject:subject:to:to; s=fm2; t=1685545120; x=1685631520; bh=Oh
 R5/jat6FquAXiGkzrUM7T9u4aDN/xANNdyZnNqCEg=; b=gCoB6Or8pM2pUktdLw
 OYhVk6VPwpfsa6OLaoy8qaTuARmay/zOBUzFxzXTBbkx+a3H1CO8KWw0zOoiTtzE
 TKGv3ncIq7QCnoKCz+znQJaEyDLXqXnT17f8xnX5NawZJG6YhrLeonamVA2MglQC
 5CoCezBfBppl7fG44YLMuaaglMgIqTFras+kN5gKcN/WPNiNoX5YedZ/WswzYSOl
 Uo/fV3Au4ikWI5xZi1kJZBZ6wJYPWmxgTAvIZXqgbadGl+O/dViZxNgxHfUjbtRU
 LR5MnQauT6nzxGfc3J65IfXxjZuhZWwS9tEzP0mrUvMRY1oAelcTvDbL/gkF7Nbe
 wJtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-type:content-type:date:date
 :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
 :message-id:mime-version:references:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1685545120; x=1685631520; bh=OhR5/jat6FquA
 XiGkzrUM7T9u4aDN/xANNdyZnNqCEg=; b=N5hUfTRPEbkMNDjCinijNzmFJToW9
 Q4xDvaICPjgi4Vhy0I2MOnwBQYMq5ewpfM/6pU9Ja34iT2w+Xx1048TXIr15AlZu
 HRAZTeXWnr+y/cIJJAW9EYvTZZSUKEJ/q0kaf0x47KBhQg+6hkiWGdV71wCFULG3
 MteIGv7n8vO9QabnctskTtAYWxtpswM2DYDt59+O10E3/klqjX2TucHgKeNOK3YD
 dPVsXytLUbhryvG3omY/kHcOvFt4DeBTfIcPJGKQQsl8LYEqCu1H9r11S9s3/BD9
 F4Hg0oY0++g6mn1kI0ecIf303KJWRyzK7FRgyWHdWD8Dg/xpvJU6DwDHg==
X-ME-Sender: <xms:n2B3ZP_9dIQPQg3UtQ7IFIbbOA5X6WlJIx8b8_LCtdWv_2ZFvwYrrg>
 <xme:n2B3ZLtbDRMk5RSASN7VBq01d01Y2sPn1NdKYHxEyqDbVMIy2tqQCiFTx7o31LjTG
 ZBKTpBiOKxUBuCoxQ>
X-ME-Received: <xmr:n2B3ZNBo3s5DS1W8ve8ueFEjkVBPz2Z7JUFKE7Ky9CheIAklxR5tRM2i>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekledgkedvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttd
 fstddttddvnecuhfhrohhmpefirhgrvghmvgcuifhrvghgohhrhicuoehgrhgrvghmvges
 gihorhgrrdhorhhgrdhukheqnecuggftrfgrthhtvghrnhepgfeigeeijeetleetueelhf
 ffieeihffflefhffehgffhveetvdfhueelvdektedtnecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepghhrrggvmhgvseigohhrrgdrohhrghdruh
 hk
X-ME-Proxy: <xmx:n2B3ZLfsgCudcwbXThVEop8nFbTK-wJK7h5sSTZM_emp2STwRs4YmQ>
 <xmx:n2B3ZEP4iIEI8saTIFjYQNgBSVt8pvJIgu8YSqgnP0Z3M7ZkZWcNsg>
 <xmx:n2B3ZNmCCK9oHpY4EJhpNITbP5ZLyc4vSxvUEObEQRFMJyZlstYKrA>
 <xmx:oGB3ZBp_PZMic2NHUqd5btx1BnwSeGzEY5tQKEmhtE66C7CRbJj5ew>
Feedback-ID: i62f7400e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 31 May 2023 10:58:38 -0400 (EDT)
Date: Wed, 31 May 2023 15:58:35 +0100
From: Graeme Gregory <graeme@xora.org.uk>
To: wangyuquan1236@phytium.com.cn
Cc: peter.maydell@linaro.org, quic_llindhol@quicinc.com, 
 chenbaozi@phytium.com.cn, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/1] hw/arm/sbsa-ref: use XHCI to replace EHCI
Message-ID: <lfcmvvqjp64wngrdk33bvkb3k7op53l24lcoslah2evsyh3esc@at7jnsnrto7h>
References: <20230531070229.334124-1-wangyuquan1236@phytium.com.cn>
 <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230531070229.334124-2-wangyuquan1236@phytium.com.cn>
Received-SPF: pass client-ip=64.147.123.25; envelope-from=graeme@xora.org.uk;
 helo=wout2-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 03:02:29PM +0800, wangyuquan1236@phytium.com.cn wrote:
> From: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> 
> The current sbsa-ref cannot use EHCI controller which is only
> able to do 32-bit DMA, since sbsa-ref doesn't have RAM above 4GB.
> Hence, this uses XHCI to provide a usb controller with 64-bit
> DMA capablity instead of EHCI.
> 

Should this be below 4G?

Also has EHCI never worked, or has it worked in some modes and so this
change should be versioned?

Graeme

> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> Change-Id: I1376f8bbc0e25dcd9d8a22b6e061cb56b3486394
> ---
>  hw/arm/sbsa-ref.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index 792371fdce..f9c0647353 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -81,7 +81,7 @@ enum {
>      SBSA_SECURE_UART_MM,
>      SBSA_SECURE_MEM,
>      SBSA_AHCI,
> -    SBSA_EHCI,
> +    SBSA_XHCI,
>  };
>  
>  struct SBSAMachineState {
> @@ -118,7 +118,7 @@ static const MemMapEntry sbsa_ref_memmap[] = {
>      [SBSA_SMMU] =               { 0x60050000, 0x00020000 },
>      /* Space here reserved for more SMMUs */
>      [SBSA_AHCI] =               { 0x60100000, 0x00010000 },
> -    [SBSA_EHCI] =               { 0x60110000, 0x00010000 },
> +    [SBSA_XHCI] =               { 0x60110000, 0x00010000 },
>      /* Space here reserved for other devices */
>      [SBSA_PCIE_PIO] =           { 0x7fff0000, 0x00010000 },
>      /* 32-bit address PCIE MMIO space */
> @@ -138,7 +138,7 @@ static const int sbsa_ref_irqmap[] = {
>      [SBSA_SECURE_UART] = 8,
>      [SBSA_SECURE_UART_MM] = 9,
>      [SBSA_AHCI] = 10,
> -    [SBSA_EHCI] = 11,
> +    [SBSA_XHCI] = 11,
>      [SBSA_SMMU] = 12, /* ... to 15 */
>      [SBSA_GWDT_WS0] = 16,
>  };
> @@ -558,12 +558,12 @@ static void create_ahci(const SBSAMachineState *sms)
>      }
>  }
>  
> -static void create_ehci(const SBSAMachineState *sms)
> +static void create_xhci(const SBSAMachineState *sms)
>  {
> -    hwaddr base = sbsa_ref_memmap[SBSA_EHCI].base;
> -    int irq = sbsa_ref_irqmap[SBSA_EHCI];
> +    hwaddr base = sbsa_ref_memmap[SBSA_XHCI].base;
> +    int irq = sbsa_ref_irqmap[SBSA_XHCI];
>  
> -    sysbus_create_simple("platform-ehci-usb", base,
> +    sysbus_create_simple("sysbus-xhci", base,
>                           qdev_get_gpio_in(sms->gic, irq));
>  }
>  
> @@ -785,7 +785,7 @@ static void sbsa_ref_init(MachineState *machine)
>  
>      create_ahci(sms);
>  
> -    create_ehci(sms);
> +    create_xhci(sms);
>  
>      create_pcie(sms);
>  
> -- 
> 2.34.1
> 
> 

