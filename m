Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7548F773BD9
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 17:56:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTP3z-0003LV-C5; Tue, 08 Aug 2023 11:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qTP3v-0003Jg-CL
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:55:59 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qTP3p-0003xz-AO
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 11:55:55 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52328e96869so5004589a12.1
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 08:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691510150; x=1692114950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=aJ0UsCgUCLRkzlKNN3fii+ReD7qN5JFOHoDMNfD8JZw=;
 b=CXxiYgZdMz2LXSHL4IlP4GaS09u5ib2oVSfpzTenJjGV8m+ijczcaZrhlScwIAglTn
 Fh7rKSZYZWgGQafVT/CayG9K6TUZtVwWuA8PbmYzogDaEpag7gOFhEHE8a5Sj+LJg0PD
 Vlu0Cxt3BZKIpPsjW62X8soniMXhQhYanTiclWebJWe/z+cutgAvAE/2bOxeTIdj9BJK
 uWZ/4wyda2oGXIZH1+ijCAvf52VSVO26qRNXOQk29N43Hl4QVEFQ4HNtiGTy1y+Oh/ja
 qZqq3uMWhhYSnY7wSRYbKXM3Y+yAuf2Yau+TBFcUicZGili+2VU7XW4RUE0lb4WF8epD
 iFDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691510150; x=1692114950;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aJ0UsCgUCLRkzlKNN3fii+ReD7qN5JFOHoDMNfD8JZw=;
 b=Gb40ehWso3I9NNxWwbjns9ASEwuUk9wvjQhhgFKV2701Y46VdimlHFjW/zHSxaZPH1
 Tt3qtmRXGnDOO/85s/9Qss68ChmrLtRjSXQEbS3XeUpXeyyU7d9J/05xiF25t3XPds6P
 091g/+2Zcfl7q9i6BkJbTETutUgVEIycHILCiUjgiu5To860MbxdsffTttjQBZ5TGk4l
 hLrQpLAhmH3WhsJsUW0gePH4772ldgZUfp7Z83f0RDZSin+raR8dNsmvg2yrtyDANpnc
 1AwUFveFrbJQ0bXcusflLZ0bOxoReHH+Qp9o+N5gIdfV8zelz12qhq8LBIVVQLLlYzMl
 JWaQ==
X-Gm-Message-State: AOJu0Yz81FucUk8Z1D0KYWLsox93Ibx18hlynR2rZMj1fsvfUXaiPExP
 slaoqDMx2U9iffluINvGqj7kNvd6wLaiNlY+VWmjBw==
X-Google-Smtp-Source: AGHT+IHJKYMuHmEub1RNwIwtkMPh4r4CE2dABsGYUBghBUgPkD70WLTt31emiAcDUZI2nWPdQt4RxKVnEArv/j+YX8g=
X-Received: by 2002:aa7:dbd3:0:b0:51e:5322:a642 with SMTP id
 v19-20020aa7dbd3000000b0051e5322a642mr159616edt.27.1691510150265; Tue, 08 Aug
 2023 08:55:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230808031143.50925-1-richard.henderson@linaro.org>
 <20230808031143.50925-3-richard.henderson@linaro.org>
In-Reply-To: <20230808031143.50925-3-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Aug 2023 16:55:39 +0100
Message-ID: <CAFEAcA8ORUejjC3iVdjYSkX1St6ntxXbDPtTC0tuv5C_5rQ8xQ@mail.gmail.com>
Subject: Re: [PATCH 02/24] tcg: Use tcg_gen_negsetcond_*
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, 
 qemu-riscv@nongnu.org, qemu-s390x@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 SUSPICIOUS_RECIPS=2.51 autolearn=no autolearn_force=no
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

On Tue, 8 Aug 2023 at 04:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/tcg-op-gvec.c | 6 ++----
>  tcg/tcg-op.c      | 6 ++----
>  2 files changed, 4 insertions(+), 8 deletions(-)
>
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index a062239804..e260a07c61 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -3692,8 +3692,7 @@ static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>      for (i = 0; i < oprsz; i += 4) {
>          tcg_gen_ld_i32(t0, cpu_env, aofs + i);
>          tcg_gen_ld_i32(t1, cpu_env, bofs + i);
> -        tcg_gen_setcond_i32(cond, t0, t0, t1);
> -        tcg_gen_neg_i32(t0, t0);
> +        tcg_gen_negsetcond_i32(cond, t0, t0, t1);
>          tcg_gen_st_i32(t0, cpu_env, dofs + i);
>      }

Is it not possible for the optimizer to notice "you did
a setcond followed by a neg, let me turn it into negsetcond
for you" ?

thanks
-- PMM

