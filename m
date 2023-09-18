Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 106507A4790
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Sep 2023 12:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qiBqP-0003OP-0f; Mon, 18 Sep 2023 06:51:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBqM-0003Nu-Md
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:51:06 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qiBqK-00082d-Uw
 for qemu-devel@nongnu.org; Mon, 18 Sep 2023 06:51:06 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5310aec4121so1188887a12.2
 for <qemu-devel@nongnu.org>; Mon, 18 Sep 2023 03:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695034263; x=1695639063; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=MCea+cPnXQZepFawOaWfxklAww0JB/UOufYVRczS6P8=;
 b=meO+q8r59K3jvtk7N958twVl9CIlsllHo74ntA3mhmsI37/kbANThmA5QeFJ23QwOp
 4KizsXSdfnGkWVfk1bQ2tA8Os6eyhLVvfyrHKSC7MWMPephmYF4JobmZa6LT4DB7G1Pi
 bJsteY2EsXjScglcZkQeTQsduVW7mlFcACmYgGW6/Rcz1xu2LohUijgOnJoal4WB+/1H
 36ybLyZosSI/tVCD1ZTi2IgbAudCjPWDPM+BlPFk2R4POWH3i4QqmPIiFX2Zm5SaO4Su
 JzuRNzN6hDnkLX1MSCESaOSePmXmE/Q0FVJlNbo9dVOFPD6YG1lZ9Mis4odQ378V/cuN
 KCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695034263; x=1695639063;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MCea+cPnXQZepFawOaWfxklAww0JB/UOufYVRczS6P8=;
 b=pT7het8h0GJNuLZ+b8Vg5cY9vEH+mNhHSADfvDVFNUxFlcAWnGuaJ1NS3pWnc2xsGo
 R+AwCfAJIA2pPFcLOHrOt7h2rPLzBgwntKrp+y5kPizGvXyJQkanxTa9M6VBOVu2XUOy
 VxqVhnxUCepfrlVHnm89RTT81bDwM/xzAsmCHS0hpkT7YAciiEKmy0tdI6NI2HHwZwuo
 +GV5kK301gV0B2DY8F2AKTsplDAL23sAL7UyCMmhlf7lcI+SdEXJjsCqLeDbCiPelCEH
 o2Zbz1D8UFpmTM4b3yPGLlZcQF1dwGoRQl7+mYaPH2H/+aHVn4DDmi7buTVMCbxu42GG
 HhtA==
X-Gm-Message-State: AOJu0YyJF4w4d22qAjXulVifidafwfnhRSLqMphGjC9yew6AM0yPJWht
 ktUFyCpZtTW8EYxG4qAMCCdbOmHfqXqJYIsEPOuheQ==
X-Google-Smtp-Source: AGHT+IGH9fKpRD7V8rf1befC0jvYqxAA+stgktPX+julwvduAHv7BCECRJPbIW6pnh27wCw6fBNFxTbHE7FcCZk8MvY=
X-Received: by 2002:aa7:dcc6:0:b0:51d:f5bd:5a88 with SMTP id
 w6-20020aa7dcc6000000b0051df5bd5a88mr7560485edu.38.1695034263341; Mon, 18 Sep
 2023 03:51:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230913140610.214893-1-marcin.juszkiewicz@linaro.org>
 <20230913140610.214893-2-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20230913140610.214893-2-marcin.juszkiewicz@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 18 Sep 2023 11:50:44 +0100
Message-ID: <CAFEAcA8S8WYYgCzb93712z3itMBfTi4oV30fEn3KCM2MNc1_uA@mail.gmail.com>
Subject: Re: [PATCH 1/1] sbsa-ref: add non-secure EL2 virtual timer
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Wed, 13 Sept 2023 at 15:06, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> Armv8.1+ cpus have Virtual Host Extension (VHE) which added non-secure
> EL2 virtual timer.
>
> This change adds it to fullfil Arm BSA (Base System Architecture)
> requirements.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> ---
>  hw/arm/sbsa-ref.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
> index bc89eb4806..3c7dfcd6dc 100644
> --- a/hw/arm/sbsa-ref.c
> +++ b/hw/arm/sbsa-ref.c
> @@ -61,6 +61,7 @@
>  #define ARCH_TIMER_S_EL1_IRQ   13
>  #define ARCH_TIMER_NS_EL1_IRQ  14
>  #define ARCH_TIMER_NS_EL2_IRQ  10
> +#define ARCH_TIMER_NS_EL2_VIRT_IRQ  12
>
>  enum {
>      SBSA_FLASH,
> @@ -489,6 +490,7 @@ static void create_gic(SBSAMachineState *sms, MemoryRegion *mem)
>              [GTIMER_VIRT] = ARCH_TIMER_VIRT_IRQ,
>              [GTIMER_HYP]  = ARCH_TIMER_NS_EL2_IRQ,
>              [GTIMER_SEC]  = ARCH_TIMER_S_EL1_IRQ,
> +            [GTIMER_HYPVIRT] = ARCH_TIMER_NS_EL2_VIRT_IRQ,
>          };
>
>          for (irq = 0; irq < ARRAY_SIZE(timer_irq); irq++) {
> --

This is correct, so I've applied it to target-arm.next. We also
need something similar for the virt board (where there is an
additional complication that we need to also report it in the dtb
and the ACPI tables, ideally only if the CPU has the feature).

thanks
-- PMM

