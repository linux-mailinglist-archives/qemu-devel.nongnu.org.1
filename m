Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 900A67986F0
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 14:17:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeaPn-0006OM-Si; Fri, 08 Sep 2023 08:16:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaPi-0006Kk-PV
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:16:45 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qeaPg-00057a-5r
 for qemu-devel@nongnu.org; Fri, 08 Sep 2023 08:16:42 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-522bd411679so2671392a12.0
 for <qemu-devel@nongnu.org>; Fri, 08 Sep 2023 05:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694175398; x=1694780198; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eJFV3k9sG9fZcxBlzsNxMg5ieLD1/LoHcz9Lyc+RwLM=;
 b=Ct/9U32uhGH/W8NMykCd6Poso++vZtdESKooEJPLnpVn58RSO0s/0E6hI03KoJeuK+
 pD8B8SyOSoOWghJ8j/wruCfkQ8HC+iS/R5ip/JHCFI0tX7FDKXj0bHOiSI+BbF4xkJkZ
 ZC9afpLBdmwoP8I5kb9idVNBTZhLmokxReuQ2skZhrSK/0gLvYnrRPRP/ejjMJVNOcNL
 py5mae3yWh6mf6rH2sTbbm3N0cvV5b0Z/f+nawLx0IZ3tj9pxafHg3OiCRvfFJTIEbKk
 z2sGGOTwCNG7frqWNwGCXAylF+T2D+52xcC/QZ324A+h1PQUkKb+sXGMDawFxWoojjiT
 J3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694175398; x=1694780198;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eJFV3k9sG9fZcxBlzsNxMg5ieLD1/LoHcz9Lyc+RwLM=;
 b=RGRyJFiLQPEhUl9+PbB4HSsmm+bwDz3mOGTNOYWPkjRnf5/jKO3CtkfCD8QOEaqF3O
 1D1q6Wyk1ayM3MBWm5+P1ZpMbTg19poGJO4ilWy2RrYaVdkIqvkm4qtEfbIsiBkXYhgF
 MicBrnHmYwWXAL+85L4pcEzWxgLsM8eislQGSyO5vDQpalzPARJ3AUcJDVygSYBVIgJW
 kmDtoCso4liEBgWE6L387hfAbBcPxxCbxt1yZMSmEXgcUtkpq+ZYWaAvmVjWyBQFoFtf
 r+RNeFIc8kix++P9giGUyBMhef/7V6G4H0/CbRWdDxfVZHeeMQfkTAtjg1YD1eZ8Ipr3
 tIsA==
X-Gm-Message-State: AOJu0YzSj2yBkxoX04ch7asxiu98HIiTibK36zoIW5PLk5RHwc3dWeQb
 eJYcxQNV+XWJw13N+fENw98XRk5epNyLTWBtDlYyOw==
X-Google-Smtp-Source: AGHT+IFSlpBulbgAytJz0cTvf2QYsCHyE1mAoXwoCMAVMpu9ix/3I6WnMzsmcqgPDD6XaElZFlq+9iESfJX/eyT8QH4=
X-Received: by 2002:aa7:c696:0:b0:522:cef7:83c3 with SMTP id
 n22-20020aa7c696000000b00522cef783c3mr1879740edq.8.1694175398379; Fri, 08 Sep
 2023 05:16:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230905145651.8199-1-philmd@linaro.org>
In-Reply-To: <20230905145651.8199-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Sep 2023 13:16:27 +0100
Message-ID: <CAFEAcA_6c90YC-Dg7SBhgx=0UMLEe1zjcHHQDgufC5CPQHwhhw@mail.gmail.com>
Subject: Re: [PATCH] hw/intc/arm_gicv3: Simplify gicv3_class_name() logic
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 5 Sept 2023 at 15:56, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Simplify gicv3_class_name() logic. No functional change intended.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/intc/arm_gicv3_common.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
>
> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index 2ebf880ead..8863f06b67 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -612,13 +612,12 @@ type_init(register_types)
>
>  const char *gicv3_class_name(void)
>  {
> -    if (kvm_irqchip_in_kernel()) {
> -        return "kvm-arm-gicv3";
> -    } else {
> -        if (kvm_enabled()) {
> +    if (kvm_enabled()) {
> +        if (!kvm_irqchip_in_kernel()) {
>              error_report("Userspace GICv3 is not supported with KVM");
>              exit(1);
>          }
> -        return "arm-gicv3";
> +        return "kvm-arm-gicv3";
>      }
> +    return "arm-gicv3";
>  }

This doesn't seem to me to be obviously clearer or
simpler than the current code, which is the same basic
logic as the GICv2 gic_class_name(), but with the extra
condition of "report the error for the case we don't
support yet". In particular the major condition for
"should we be using kvm-arm-gicv3" is not "are we
using KVM?" but "are we using the KVM in-kernel irqchip?".

thanks
-- PMM

