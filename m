Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDB87475AA
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:53:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiL3-0008Ek-1q; Tue, 04 Jul 2023 11:53:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGiKx-0008E3-WC
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:53:08 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGiKt-00088j-94
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:53:05 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-3fbca8935bfso44204185e9.3
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688485979; x=1691077979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jhbXWYXdRueLJUJ2eQFxreMzfFVD4pK44TuW66CNXUQ=;
 b=SMQzlfs8e47k2WiWX+wz5RyOK6vo04wdFIwlDt0KUujH8Uw7wVi+/bMlzMFqdhhLBn
 wbLOlDe+/xmo4VW4Yk0Oh6IdyG1NFiDqLlouo9kSWBDTL684hCPrXSieeOb46OI+p37P
 nfpx4W+85+JLS0xm3UupAKEPm0V5onY2vG1Tk1f+4HNPKpliE9p3qPlLN7Grx4OeN7rh
 VyZLTC6AqpirAytu9C6+dv/9bIapWenKIWqRiYKu44dTj5ab6EeYCyTOTBk+QSR83d+/
 8MAYMRot8cMwVLGxzSgIzOYkEF/HVBNEqCwcGMTFutorgf6uNOKEXAvqKOkYAj890vRi
 w43g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688485979; x=1691077979;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jhbXWYXdRueLJUJ2eQFxreMzfFVD4pK44TuW66CNXUQ=;
 b=VC+b9w1jR8KCPSf4xUiI4qLXzd/RkmoflyE2O7jqQL+3UhYEdDrjwOo87krj3Ur9A2
 DRk5HaJF5GjiOCNPwp3zFL9jHnLroYf89Aylwu/eTOK9QH+hSl5GeTqb2CRYGo+Bu3/C
 xRNKBzlW2j3IlYwCR68O335xZDB53GDw8GpbxM1lcWSKZMBhDmpTW1LizbDtyw2ICxPh
 eSli76l2Eip4gVjDN4EHKG7T20d8SEzY551smdXgEF3YihP36++TzdV3+h9cJkik21OA
 sn5uwHsMopAPHMy/SDe/xd253VCD48jiTvtJWJ3OmEh/UlNEWqiarXa3y2vjr9SK92u1
 PpFQ==
X-Gm-Message-State: AC+VfDyuFgUaM84QaaOijgmzZDxLjN6jEBmftmuBbVO+IuBZmRx3J2r/
 FUDCCemY3dTr38fxNzWfcGXJzA==
X-Google-Smtp-Source: ACHHUZ5AEdXe+4CsiEgK6mEH9sa8WJii03W/djYmmaVn43e1Ut+E0aVV9r9gx3iCVIWrC/JqEJa/XQ==
X-Received: by 2002:a7b:cd17:0:b0:3fa:99d6:47a4 with SMTP id
 f23-20020a7bcd17000000b003fa99d647a4mr11175780wmj.22.1688485979311; 
 Tue, 04 Jul 2023 08:52:59 -0700 (PDT)
Received: from [192.168.1.102] ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 t14-20020a5d460e000000b0031433760a92sm7102025wrq.115.2023.07.04.08.52.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 08:52:59 -0700 (PDT)
Message-ID: <a96bffba-9653-95b3-4b7c-8787646f1f21@linaro.org>
Date: Tue, 4 Jul 2023 17:52:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH] target/arm: Avoid over-length shift in
 arm_cpu_sve_finalize() error case
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20230704154332.3014896-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230704154332.3014896-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 4/7/23 17:43, Peter Maydell wrote:
> If you build QEMU with the clang sanitizer enabled, you can see it
> fire when running the arm-cpu-features test:
> 
> $ QTEST_QEMU_BINARY=./build/arm-clang/qemu-system-aarch64 ./build/arm-clang/tests/qtest/arm-cpu-features
> [...]
> ../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is too large for 64-bit type 'unsigned long long'
> [...]
> 
> This happens because the user can specify some incorrect SVE
> properties that result in our calculating a max_vq of 0.  We catch
> this and error out, but before we do that we calculate
> 
>   vq_mask = MAKE_64BIT_MASK(0, max_vq);$
> 
> and the MAKE_64BIT_MASK() call is only valid for lengths that are
> greater than zero, so we hit the undefined behaviour.

Can we fix it generically?

-- >8 --
--- a/include/qemu/bitops.h
+++ b/include/qemu/bitops.h
@@ -28,3 +28,3 @@
  #define MAKE_64BIT_MASK(shift, length) \
-    (((~0ULL) >> (64 - (length))) << (shift))
+    ((length) ? (((~0ULL) >> (64 - (length))) << (shift)) : 0)

---

> 
> Change the logic so that if max_vq is 0 we specifically set vq_mask
> to 0 without going via MAKE_64BIT_MASK().  This lets us drop the
> max_vq check from the error-exit logic, because if max_vq is 0 then
> vq_map must now be 0.
> 
> The UB only happens in the case where the user passed us an incorrect
> set of SVE properties, so it's not a big problem in practice.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   target/arm/cpu64.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
> index 6eaf8e32cfa..6012e4ef549 100644
> --- a/target/arm/cpu64.c
> +++ b/target/arm/cpu64.c
> @@ -122,10 +122,10 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
>           vq = ctz32(tmp) + 1;
>   
>           max_vq = vq <= ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
> -        vq_mask = MAKE_64BIT_MASK(0, max_vq);
> +        vq_mask = max_vq > 0 ? MAKE_64BIT_MASK(0, max_vq) : 0;
>           vq_map = vq_supported & ~vq_init & vq_mask;
>   
> -        if (max_vq == 0 || vq_map == 0) {
> +        if (vq_map == 0) {
>               error_setg(errp, "cannot disable sve%d", vq * 128);
>               error_append_hint(errp, "Disabling sve%d results in all "
>                                 "vector lengths being disabled.\n",

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


