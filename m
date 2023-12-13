Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EC7B811A9E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Dec 2023 18:14:42 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDSnA-0002qY-Jc; Wed, 13 Dec 2023 12:13:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDSn8-0002qJ-UV
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:13:02 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rDSn7-0006B1-6M
 for qemu-devel@nongnu.org; Wed, 13 Dec 2023 12:13:02 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-548ce39b101so9868282a12.2
 for <qemu-devel@nongnu.org>; Wed, 13 Dec 2023 09:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702487579; x=1703092379; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ohAuAXAUDvxSXP+S/F60txeSzIFypiKunEroHwRI7Qk=;
 b=n7AMloTlgcW9oJDqN3QZzYZkY3a1ipDiBh0XS50CAmRgjLR2VJp6r3s2ChTkC8qY6Y
 gjkjdg2lvhYeFYoD0oZqMGrjQNzn+fCi+vl0gZnE0jWuCVgu4+QFd2xd5I8LbBWcW8Xw
 +GLUzkWoAFBc84VTpDsOMZ/dcR1nifwoz+OpbGzHMdd854+ypbipSrxL+JlERzok8nQd
 dzGgBJ+dMvtHYVcpbrUOQ3t/kgERXnwlyPJFTVoOZCbcpwDXIg+oVcHZM5IXcxt2xPs+
 uw9IyAHfKvrChf9AmhxSdAQrAXU/AFmradbGGtBSCnDpyGLwH7WSRdZJPVGeDvqXAwmm
 GiaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702487579; x=1703092379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ohAuAXAUDvxSXP+S/F60txeSzIFypiKunEroHwRI7Qk=;
 b=YhlUpG2aBdo9/tVJhq59p4tZPpf71HxbKxYohafDvNOxqMORZLZHofgTp597ImZp5u
 LTxsUHD8L5JE7wNCkg1u/Yc5eS1bijmO8MBPuDD4Iz0oWtRFuSiyuGbngi2JxFxpv/tH
 HNLlDn9xxcprJqv8ZwfySs2JaKemd4C47XB/IjgmG7Ag9T0BAtRkk1CPg/UJ/pFf7r5e
 4Y8GkDBedvVv6JTVor8QEXHuGzvfSP2HfpWHPfkp6YVjB/veLgyTZePcLb2gt0sxaloa
 By/KZpMbxghSpFupaZIO4iMHmtojtHlGHt3dn/8uWisP0Wed+3x/jG+B4adgrb0DDNF2
 q7sw==
X-Gm-Message-State: AOJu0YzzkIlP0IQKfa/1RuPQZA7i3sxGMsQ1p1p/xsmSCVIXdT1RYspP
 hHYqjiam+AMEOSILR2wV+A1/+w0LWKLWdZIg2P8DTg==
X-Google-Smtp-Source: AGHT+IHBAIelc7dsl9rOIi+YZRK3oPJYhIx32Iyq1VL/JceuIg9rlKUnS6pb7sSl5yT1nOZIqBg6s9cqg5SAW2OBZnk=
X-Received: by 2002:a50:cbcd:0:b0:54c:b889:9c11 with SMTP id
 l13-20020a50cbcd000000b0054cb8899c11mr3115043edi.98.1702487578923; Wed, 13
 Dec 2023 09:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20231213014932.1748323-1-linux@roeck-us.net>
In-Reply-To: <20231213014932.1748323-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Dec 2023 17:12:20 +0000
Message-ID: <CAFEAcA9KU855jn8xDQtbf58Byg0NCq-aB3tPcf8sB6YLyLkvWQ@mail.gmail.com>
Subject: Re: [PATCH] hw/sd/pxa2xx_mmci: Disable reentrancy detection
To: Guenter Roeck <linux@roeck-us.net>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 13 Dec 2023 at 01:49, Guenter Roeck <linux@roeck-us.net> wrote:
>
> All tests using pxa2xx_mmc to access mmc cards on pxa2xx platforms
> such as borzoi fail starting with commit a2e1753b80 ("memory: prevent
> dma-reentracy issues"). Disable reentrancy guard to fix the problem.
>
> Fixes: a2e1753b80 ("memory: prevent dma-reentracy issues")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
>  hw/sd/pxa2xx_mmci.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
> index 5e8ea69188..27ae8f2888 100644
> --- a/hw/sd/pxa2xx_mmci.c
> +++ b/hw/sd/pxa2xx_mmci.c
> @@ -555,6 +555,8 @@ static void pxa2xx_mmci_instance_init(Object *obj)
>      qdev_init_gpio_out_named(dev, &s->rx_dma, "rx-dma", 1);
>      qdev_init_gpio_out_named(dev, &s->tx_dma, "tx-dma", 1);
>
> +    s->iomem.disable_reentrancy_guard = true;
> +

All patches that set this flag should include a comment which
explains what the device access path that triggers the reentrancy
is, please.

thanks
-- PMM

