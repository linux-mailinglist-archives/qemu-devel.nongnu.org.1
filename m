Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 698C57313B5
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 11:28:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9jGe-000589-Le; Thu, 15 Jun 2023 05:27:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <postmaster@kaiser.cx>)
 id 1q9jGc-00057I-J9; Thu, 15 Jun 2023 05:27:46 -0400
Received: from viti.kaiser.cx ([2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <postmaster@kaiser.cx>)
 id 1q9jGb-0003Xe-3x; Thu, 15 Jun 2023 05:27:46 -0400
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
 (envelope-from <martin@viti.kaiser.cx>)
 id 1q9jGS-0008PF-KZ; Thu, 15 Jun 2023 11:27:36 +0200
Date: Thu, 15 Jun 2023 11:27:36 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] imx_serial: set wake bit when we receive a data byte
Message-ID: <20230615092736.jsdurv6dvv4mxofk@viti.kaiser.cx>
References: <20230608154129.133169-1-martin@kaiser.cx>
 <239a543f-6d97-eb14-ba4f-284093fccfba@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <239a543f-6d97-eb14-ba4f-284093fccfba@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Received-SPF: none client-ip=2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f;
 envelope-from=postmaster@kaiser.cx; helo=viti.kaiser.cx
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hi Philippe,

thanks for reviewing my patch.

Philippe Mathieu-Daudé (philmd@linaro.org) wrote:

> Shouldn't we mask this bit for interruptions now?

yes, we should support interrupts from the wake bit. I'll add your
snippet and send a v2.

Thanks,
Martin

> -- >8 --
> diff --git a/include/hw/char/imx_serial.h b/include/hw/char/imx_serial.h
> index 91c9894ad5..b823f94519 100644
> --- a/include/hw/char/imx_serial.h
> +++ b/include/hw/char/imx_serial.h
> @@ -71,6 +71,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(IMXSerialState, IMX_SERIAL)

>  #define UCR4_DREN       BIT(0)    /* Receive Data Ready interrupt enable */
>  #define UCR4_TCEN       BIT(3)    /* TX complete interrupt enable */
> +#define UCR4_WKEN       BIT(7)    /* WAKE interrupt enable */

>  #define UTS1_TXEMPTY    (1<<6)
>  #define UTS1_RXEMPTY    (1<<5)
> diff --git a/hw/char/imx_serial.c b/hw/char/imx_serial.c
> index ee1375e26d..c8ec247350 100644
> --- a/hw/char/imx_serial.c
> +++ b/hw/char/imx_serial.c
> @@ -80,7 +80,7 @@ static void imx_update(IMXSerialState *s)
>       * TCEN and TXDC are both bit 3
>       * RDR and DREN are both bit 0
>       */
> -    mask |= s->ucr4 & (UCR4_TCEN | UCR4_DREN);
> +    mask |= s->ucr4 & (UCR4_WKEN | UCR4_TCEN | UCR4_DREN);

>      usr2 = s->usr2 & mask;
> ---

