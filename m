Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BB17A956D
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 17:05:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjLE6-0007y9-Ka; Thu, 21 Sep 2023 11:04:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjLE4-0007xN-S5
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:04:20 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qjLE3-0003zH-1M
 for qemu-devel@nongnu.org; Thu, 21 Sep 2023 11:04:20 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-530fa34ab80so4787524a12.0
 for <qemu-devel@nongnu.org>; Thu, 21 Sep 2023 08:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695308657; x=1695913457; darn=nongnu.org;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZTK1H1bUdqQ7gWN7sjQJRsSILWGa8uEA2Dtkliuxyqg=;
 b=AllDDRR6ddhcBohdHcgPSKF3sJKNFvyle9HXZg9cQjFLftcJ675OedPyRdWtB+FwC6
 qq2QMXD0fsNb4UPtvYPxpaN+d6O9E7TsVvf3g+M3OsBhA4yYtXp64frOK3zFOtGwaweQ
 SovpJlgHUgS+c8fuqZQ8aRzlf+lq4nvwK9ZjgGqQYdG95iyVS6KZEGwhq7hDx52qxLac
 2ci0kYUjhT94UvjlOkCMNtfKislk4OKwySfZgf7iSjhUV5JT31eedy+lJa7kFG3TaMoS
 154HzJ44IiMLDgUKJy+MgH90NJVs2uUUxH41+q8iRoR49ncxFRsvP7qC7BX7K64NWF6y
 7g+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695308657; x=1695913457;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZTK1H1bUdqQ7gWN7sjQJRsSILWGa8uEA2Dtkliuxyqg=;
 b=lYZ1HjKF/fDV/zyIhZ171HkqPcgXRta/Nu8vlg1kxm5VXtPy4/tBYzUNZCa0Q9tiDu
 AdOToi16H91vNzfoBNFysmsGzNYux62WXMaQ4w3KwgviBMEx5KoK+6s72VxZ4XYoBsa2
 ki2N5FFMn9ihL2ZIo7F7qSv8SmxQrsfIB6aabPg/h7okotJsfNLh7GImFeir1sjsJ4XR
 uLw9yFBP/HaHVe1wrOcvm99YuTdicPGDM2Q2O4/zLMH9qi+TNMgzHAXO12IQBrHnkt+x
 J5skucT7+D+HSlCwHi+B9IBkHYSx+xxuTJrz2jZitLuQ+JfWQxp2SGe5j35og6V/+Ydo
 9arw==
X-Gm-Message-State: AOJu0YyfScPNWCE2YTUwf3itpL+dy/+pWlQO0D2nheWXp36TSg4/x136
 FvFVXV9YX0bhgqIFIvUR0sd2JEg6fOnVqzIrriU4n+nv7f+XcRb6vuU=
X-Google-Smtp-Source: AGHT+IGvMAh75ZDa8k16vVZwvUdfkB1Z/8kK9F90v78CKVpn5oWiMEQeSHrkF5vFeHuBk450n2n1uLTHgGtgFJAZg9U=
X-Received: by 2002:aa7:cb42:0:b0:522:4764:8baa with SMTP id
 w2-20020aa7cb42000000b0052247648baamr8545972edt.12.1695308657276; Thu, 21 Sep
 2023 08:04:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230911135340.1139553-1-peter.maydell@linaro.org>
 <20230911135340.1139553-7-peter.maydell@linaro.org>
In-Reply-To: <20230911135340.1139553-7-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 21 Sep 2023 16:03:58 +0100
Message-ID: <CAFEAcA9FjmE4QTnnGpzjaV3bVPO8U4yr-527RahAZA9tXbGXEA@mail.gmail.com>
Subject: Re: [PATCH 6/7] target/arm: Update user-mode ID reg mask values
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 11 Sept 2023 at 14:53, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> For user-only mode we reveal a subset of the AArch64 ID registers
> to the guest, to emulate the kernel's trap-and-emulate-ID-regs
> handling. Update the feature bit masks to match upstream kernel
> commit a48fa7efaf1161c1c.
>
> None of these features are yet implemented by QEMU, so this
> doesn't yet have a behavioural change, but implementation of
> FEAT_MOPS and FEAT_HBC is imminent.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

I forgot to update tests/tcg/aarch64/sysregs.c to indicate
that the new fields are permitted to be visible to userspace.
This patch needs the following squashed in:

diff --git a/tests/tcg/aarch64/sysregs.c b/tests/tcg/aarch64/sysregs.c
index d8eb06abcf2..f7a055f1d5f 100644
--- a/tests/tcg/aarch64/sysregs.c
+++ b/tests/tcg/aarch64/sysregs.c
@@ -126,7 +126,7 @@ int main(void)
      */
     get_cpu_reg_check_mask(id_aa64isar0_el1, _m(f0ff,ffff,f0ff,fff0));
     get_cpu_reg_check_mask(id_aa64isar1_el1, _m(00ff,f0ff,ffff,ffff));
-    get_cpu_reg_check_mask(SYS_ID_AA64ISAR2_EL1, _m(0000,0000,0000,ffff));
+    get_cpu_reg_check_mask(SYS_ID_AA64ISAR2_EL1, _m(00ff,0000,00ff,ffff));
     /* TGran4 & TGran64 as pegged to -1 */
     get_cpu_reg_check_mask(id_aa64mmfr0_el1, _m(f000,0000,ff00,0000));
     get_cpu_reg_check_mask(id_aa64mmfr1_el1, _m(0000,f000,0000,0000));
@@ -138,7 +138,7 @@ int main(void)
     get_cpu_reg_check_mask(id_aa64dfr0_el1,  _m(0000,0000,0000,0006));
     get_cpu_reg_check_zero(id_aa64dfr1_el1);
     get_cpu_reg_check_mask(SYS_ID_AA64ZFR0_EL1,  _m(0ff0,ff0f,00ff,00ff));
-    get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(80f1,00fd,0000,0000));
+    get_cpu_reg_check_mask(SYS_ID_AA64SMFR0_EL1, _m(8ff1,fcff,0000,0000));

     get_cpu_reg_check_zero(id_aa64afr0_el1);
     get_cpu_reg_check_zero(id_aa64afr1_el1);

to avoid check-tcg failing when the new features like FEAT_MOPS
or FEAT_HBC are present in 'max'.

-- PMM

