Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3B2D80EC5B
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 13:44:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD27r-0005kI-I1; Tue, 12 Dec 2023 07:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD27V-0005gb-Ca
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:44:17 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rD27S-0003bv-9X
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 07:44:16 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-551d13f6752so187803a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702385050; x=1702989850; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=e5iB/PHCoobu7SNfT0J0S59RKmgWVYHc3e45dwNtZ/M=;
 b=wY50PajuDmYLCvJ9d5ixpyvwCfAcV6hqKVE6qyJipRJbnUeW9PQU78OXZafCvBYw+w
 hBdhSr1o+voonJteWSDe7VQjN16RFyAA4kibmBbDvgjHHGwvqLaLYmk1IIKF+Xmma43Y
 PjrTCTTsUf2wDR9hCP8wIl7Wih1VhAkx5fnj5jEXGCZbCtT9+KKKnufKAiNvuIQw7Ln6
 h526qqIMBvBx1emy0r/qoVHZvOfwxHoM6h3lP9f1PeNXYSMjNtyHZYbgDpjreQPo64oS
 rsWVy/JK4FA/CSybbX8ODCCDn4Tm7YWIt3xRcKO/svp86OyM8iprcEMvFtEOfTrLUO6r
 gOow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702385050; x=1702989850;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=e5iB/PHCoobu7SNfT0J0S59RKmgWVYHc3e45dwNtZ/M=;
 b=KvsbBenpHsqho5cA3Qjg3c5CPlHIAN2JBtbXMfkfoyCD5diR3OO++OcyTzmLfXpEBP
 kU7IboGc2wIC87B3T0HbW1FldRFgv2/FnHhIqHdA7QTEukYmk7b31+H6WIe3EJuQIGhs
 abk9wcvuNPeezfgrTIVzvv/jfZQirNr7901wUPWcn5eSn8UJ/j6nLa8OQywNeUEDL4xY
 i8ttjvPCmUz0ILmgqfNsw0AtuSw8mgEX0/BV0sCS3ZZq4q4BnPu8l053q2G9XhUKQSxq
 m2B1a1UTg33zur4MDQknxmNrBRLkxUdYR7Eco6eDynITga2zS0CB4tAUtR56UXXzznJM
 luGQ==
X-Gm-Message-State: AOJu0YwkKlPlIuxPc/oAuAUJ6zssxGsudXonq5fwj/AYv/1n/hfzFjy2
 ilOkVkY2x9lhVvRsGs7tnrlTk5Lplsvw9hwVosaxbqnWPpeEc0w/
X-Google-Smtp-Source: AGHT+IFsjWMvk++mX4cEtdUN614qKUryvjPmFfBl32u822cyZoumSjLNC2++ZIaGhCssP8sNrF+YWfDu8mGH3jYadio=
X-Received: by 2002:a50:a6d7:0:b0:548:e54a:dbdd with SMTP id
 f23-20020a50a6d7000000b00548e54adbddmr3035659edc.37.1702385050647; Tue, 12
 Dec 2023 04:44:10 -0800 (PST)
MIME-Version: 1.0
References: <20231122121655.20818-1-m.tyutin@yadro.com>
In-Reply-To: <20231122121655.20818-1-m.tyutin@yadro.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 12 Dec 2023 12:43:59 +0000
Message-ID: <CAFEAcA-fP0UTaPLHgYcxrS7haXN868tescbnNqgCk-j67AR=Zw@mail.gmail.com>
Subject: Re: [PATCH] accel/tcg: Expose translation block flags to plugins
To: Mikhail Tyutin <m.tyutin@yadro.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, pbonzini@redhat.com, 
 alex.bennee@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52f.google.com
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

On Wed, 22 Nov 2023 at 12:17, Mikhail Tyutin <m.tyutin@yadro.com> wrote:
>
> In system mode emulation, some of translation blocks could be
> interrupted on memory I/O operation. That leads to artificial
> construction of another translation block that contains memory
> operation only. If TCG plugin is not aware of that TB kind, it
> attempts to insert execution callbacks either on translation
> block or instruction, which is silently ignored. As the result
> it leads to potentially inconsistent processing of execution and
> memory callbacks by the plugin.
> Exposing appropriate translation block flag allows plugins to
> handle "memory only" blocks in appropriate way.
>
> Signed-off-by: Mikhail Tyutin <m.tyutin@yadro.com>
> ---
>  include/qemu/qemu-plugin.h   | 29 ++++++++++++++++++++++++++++-
>  plugins/api.c                | 14 ++++++++++++++
>  plugins/qemu-plugins.symbols |  1 +
>  3 files changed, 43 insertions(+), 1 deletion(-)
>
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 4daab6efd2..5f07fa497c 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -54,7 +54,7 @@ typedef uint64_t qemu_plugin_id_t;
>
>  extern QEMU_PLUGIN_EXPORT int qemu_plugin_version;
>
> -#define QEMU_PLUGIN_VERSION 1
> +#define QEMU_PLUGIN_VERSION 2
>
>  /**
>   * struct qemu_info_t - system information for plugins
> @@ -236,6 +236,21 @@ enum qemu_plugin_cb_flags {
>      QEMU_PLUGIN_CB_RW_REGS,
>  };
>
> +/**
> + * enum qemu_plugin_tb_flags - type of translation block
> + *
> + * @QEMU_PLUGIN_TB_MEM_ONLY:
> + *  TB is special block to perform memory I/O operation only.
> + *  Block- and instruction- level callbacks have no effect.
> + * @QEMU_PLUGIN_TB_MEM_OPS:
> + *  TB has at least one instruction that access memory.
> + *  Memory callbacks are applicable to this TB.
> + */
> +enum qemu_plugin_tb_flags {
> +    QEMU_PLUGIN_TB_MEM_ONLY = 0x01,
> +    QEMU_PLUGIN_TB_MEM_OPS = 0x02
> +};
>

If we do go for this, can we pick a different naming
than "TB flags", please? QEMU already has a "TB flags"
concept for TCG -- it's the target-specific flags that
encode bits of the CPU state that we baked into the
generated code. Those flags are strictly TCG internal
and we definitely don't want to expose them to a plugin
because they're not a stable interface. So we should
call these flags something else so we don't get confused.

thanks
-- PMM

