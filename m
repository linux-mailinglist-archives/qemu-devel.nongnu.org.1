Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A3B972826B
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 16:12:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7GMf-0000uV-P3; Thu, 08 Jun 2023 10:11:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GMc-0000tv-Uf
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:11:47 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7GMa-0000Jg-Kn
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 10:11:46 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5169f614977so1171242a12.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 07:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686233503; x=1688825503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=P7nwgmLeW6QklNbBeX+2s5YD3VvWqzUl7W4rQ6KY9gs=;
 b=Fn6IpD8FBA+4Uebewj94ViA5063CtqO503cr47hpUyC9GclyztzNVqr2M/Y7IfnxCj
 JHnOzSAArizhLtT5d2ZRe73E2FXI6qA4fvjbpH2m5JiOPQrraA6u+mhZNFKeqwsT23/w
 dNVPD+8TCRKXy+9gIWKOwnUOofqO7LxWGyVDf1iPRUSe94gOWv3YY1pnuirXXFodqS/0
 2upVtkrBVXQpF6Gmc2siXocUyUmgu65U+obUMu3OEvNp0Vvny6o7+n8x25ttD2tQX6ih
 Zc4ZY0/rnMhG4grTdIJPgbc1CV6tiga55XYmABlaJa5XN0tH9msyK1oi8iDDTdcfQSBk
 E9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686233503; x=1688825503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=P7nwgmLeW6QklNbBeX+2s5YD3VvWqzUl7W4rQ6KY9gs=;
 b=bJrp/rc8lbNUrZjDhmvoRwBtPrJHHsnSkUzTrrMZn/tKb9oYDCOdOO+lQ1tmxbPL5A
 fjl1QS0GUfiPrdNleNZwqefUV4THyMYiPIAYxYF/bvCIKZoQ4ACC6YMKGWNDcs96bywv
 bGyUrZwXr1BUKOQwOkEvc4Bl2zC7ihADaaYe6frLS005b1xPoI16JH6n0pJY+OZQV8j/
 XWO4mvWQSGuGc8NKxcZUkx+F7FkoF99hCix7PFSezDuZ2dMEXfKBcnkyQDfgUkpA8zLm
 9WNR0xGaqwkudyAYdxk+W0TiNe8ODPXIlKWnF3wrJKYh1vS7SEQSYSBoSs4NpOJjn8aj
 TY2Q==
X-Gm-Message-State: AC+VfDzlkGTvb6cHO1c5fhZvp699TvCkap+iqt5Fc55RjwMjkpRlhwUu
 NLpHcnniguK0StC5RUoCORFnpzB+8+Samye60Gv3Cg==
X-Google-Smtp-Source: ACHHUZ48RcnprxuzCyC8nYOwlk4ygyS+vnlrpK7mxMiLcQROFpD64VHicjVaL5ZI7IsaJQPXpRZ4TfTdbYHBZI5zIrg=
X-Received: by 2002:a50:fb8f:0:b0:514:a4c9:e43b with SMTP id
 e15-20020a50fb8f000000b00514a4c9e43bmr105564edq.5.1686233502931; Thu, 08 Jun
 2023 07:11:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230517081204.30333-1-m.elsayed4420@gmail.com>
 <20230517081204.30333-8-m.elsayed4420@gmail.com>
In-Reply-To: <20230517081204.30333-8-m.elsayed4420@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 15:11:32 +0100
Message-ID: <CAFEAcA9R-R3QZfy6ufDNUSzSAYu3ssXPqbLwuVexsPhLnUG6_g@mail.gmail.com>
Subject: Re: [PATCH 7/8] tiva c board documentation
To: Mohamed ElSayed <m.elsayed4420@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 17 May 2023 at 09:13, Mohamed ElSayed <m.elsayed4420@gmail.com> wrote:
>
> Signed-off-by: Mohamed ElSayed <m.elsayed4420@gmail.com>
> ---
>  docs/system/arm/tivac.rst | 47 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 docs/system/arm/tivac.rst

This is missing the line to add this new file to the
docs:

--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -105,6 +105,7 @@ undocumented; you can get a complete list by running
    arm/sx1
    arm/stellaris
    arm/stm32
+   arm/tivac
    arm/virt
    arm/xlnx-versal-virt

Without this Sphinx will complain, which should cause a build
failure. Check that you're really building the docs
(passing --enable-docs to configure will make it fail if
you don't have the necessary tools installed to build docs).

> diff --git a/docs/system/arm/tivac.rst b/docs/system/arm/tivac.rst
> new file mode 100644
> index 0000000000..8e78726c01
> --- /dev/null
> +++ b/docs/system/arm/tivac.rst
> @@ -0,0 +1,47 @@
> +Texas Instruments EK-TM4C123GXL Evaluation Board, ``Tiva C``
> +========================================================================================

Underlines below titles should be the same length as the title-text,
not over-length.

> +
> +The `Tiva C`_ board is an evaluation platform for ARM Cortex-M4-based microcontrollers.

See remarks on board naming from patch 1.

> +Its based on the `TM4C123GH6PM`_ microcontroller by Texas Instruments.

"It is"

> +
> +.. _Tiva C: https://www.ti.com/tool/EK-TM4C123GXL
> +.. _TM4C123GH6PM: https://www.ti.com/product/TM4C123GH6PM
> +
> +Supported modules
> +-----------------
> +
> + * ARM Cortex-M4
> + * General Purpose Input/Output (GPIO)
> + * General Purpose Timers (GPTM)
> + * Serial Ports (USART)
> + * System Control (SYSCTL)
> + * Watchdog Timers (WDT)
> +
> +Missing modules
> +---------------
> +
> + * Dynamic Memory Access (uDMA)
> + * Analog to Digital Converter (ADC)
> + * Synchronous Serial Interface (SSI)
> + * Inter-Integrated Circuit Interface (I2C)
> + * Controller Area Network (CAN)
> + * USB Controller
> + * Analog Comparators
> + * Pulse Width Modulator (PWM)
> + * Quadrature Encoder Interface (QEI)
> +
> +Boot options
> +------------
> +
> +The Tiva C machines could be started using the ``-kernel`` option to load a binary file.

"can be started"

> +
> +.. code-block:: bash
> +
> +  $ qemu-system-arm -M tivac -kernel binary.elf -s -S

Are there any standard/well-known guest binaries that run on the board
that we could point to? (If not, that's fine.)

> +
> +The ``-s -S`` switches are for debugging, in another terminal window you can do:
> +
> +.. code-block:: bash
> +
> +   $ arm-none-eabi-gdb binary.elf
> +   (gdb) target remote :1234

The -s and -S stuff is standard, so you don't need to mention
it here.

thanks
-- PMM

