Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963E9747587
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 17:44:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGiBn-0000HZ-J3; Tue, 04 Jul 2023 11:43:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGiBl-0000Gv-ML
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:43:37 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGiBk-0006EG-3F
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 11:43:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31427ddd3fbso4315296f8f.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 08:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688485414; x=1691077414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=ygTlGglnECShwUVIe7MpU8KSDdPM2zi5lkhBBqOyaMs=;
 b=tdp5jZQ0XfrL0uyp09kCyzGEBDquBP11sTjXswWfaeGNYqUcy1yQyUtUhZPBUHypA2
 YdlwloU+m8gnPxRYMaHEVEyQ4ZMkME5mDGwqPE3BbDf4llFrQXWeW+cd9EUg2hHoBpOH
 /cduyymkMFNzkkQZsTy3kFCL/Va9iRp2pI3MNR2zxrYtRNT4R+DrI9SaNa8pAp76thDI
 IuuToxFqin6n9SVcR1XFqfgdtK4V0fQ3Rl2Osdx9p2cw5K+IHHQF7JCiACX/CzDnV/8a
 wAwwjpAzVwEvZo13Ghx9P9vKdYG4m+UyD/GACgK8jQ2ZcD/VSHMhE5Rb9xR0Zx7IW52G
 8Fjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688485414; x=1691077414;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygTlGglnECShwUVIe7MpU8KSDdPM2zi5lkhBBqOyaMs=;
 b=blAlkPMSZ2ySZwWUeowayn0IX+up1BFdoW7vBfqf7aetAlbKJ7CWEZs2A48/upYOuC
 KFJq7C7/hwn+O+lyzUGSEzmHEUx9S6e5BBJoM9snBy3A5r4kWgM/zTsMTdfjZteW9N7D
 rALQEhS6dUqFbDPHtrlccRk/vDIDLF6zJZEaUqMO+qu5ftyTmwnigMqWbxDLrKElCVcu
 kkC+W3s1f5hb0gGiEM+P5ZeYkTfOhTYQkTDt5RH+Qsn5Ipt/KLaL0Dls4h8OAtgPxl0y
 3EqQmCT3x3xhKd0J7QDu28k91Y2Ye0yy7uoTomF9NTSnZxOk62ybVPwKEZOz+QYqCami
 BRSQ==
X-Gm-Message-State: ABy/qLaDhFXNttaNaXDgKBhB7ckMElhHT+Ewqjr1BQ5u7eth0V+xgQHL
 5HayJDLTwcjldMj6i0pQs2rFielzNMR7dbToWA0=
X-Google-Smtp-Source: APBJJlHjH4hffBDStn4BpOXTR88ViaIJRZVEXrFnGyCBAxrmLEhm3O7N/q64muAehzfEdVBLWCvLyQ==
X-Received: by 2002:adf:f20d:0:b0:313:e80b:2273 with SMTP id
 p13-20020adff20d000000b00313e80b2273mr10912590wro.46.1688485414428; 
 Tue, 04 Jul 2023 08:43:34 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 l1-20020adff481000000b003113ed02080sm28472427wro.95.2023.07.04.08.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 08:43:34 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm: Avoid over-length shift in arm_cpu_sve_finalize()
 error case
Date: Tue,  4 Jul 2023 16:43:32 +0100
Message-Id: <20230704154332.3014896-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

If you build QEMU with the clang sanitizer enabled, you can see it
fire when running the arm-cpu-features test:

$ QTEST_QEMU_BINARY=./build/arm-clang/qemu-system-aarch64 ./build/arm-clang/tests/qtest/arm-cpu-features
[...]
../../target/arm/cpu64.c:125:19: runtime error: shift exponent 64 is too large for 64-bit type 'unsigned long long'
[...]

This happens because the user can specify some incorrect SVE
properties that result in our calculating a max_vq of 0.  We catch
this and error out, but before we do that we calculate

 vq_mask = MAKE_64BIT_MASK(0, max_vq);$

and the MAKE_64BIT_MASK() call is only valid for lengths that are
greater than zero, so we hit the undefined behaviour.

Change the logic so that if max_vq is 0 we specifically set vq_mask
to 0 without going via MAKE_64BIT_MASK().  This lets us drop the
max_vq check from the error-exit logic, because if max_vq is 0 then
vq_map must now be 0.

The UB only happens in the case where the user passed us an incorrect
set of SVE properties, so it's not a big problem in practice.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/cpu64.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/arm/cpu64.c b/target/arm/cpu64.c
index 6eaf8e32cfa..6012e4ef549 100644
--- a/target/arm/cpu64.c
+++ b/target/arm/cpu64.c
@@ -122,10 +122,10 @@ void arm_cpu_sve_finalize(ARMCPU *cpu, Error **errp)
         vq = ctz32(tmp) + 1;
 
         max_vq = vq <= ARM_MAX_VQ ? vq - 1 : ARM_MAX_VQ;
-        vq_mask = MAKE_64BIT_MASK(0, max_vq);
+        vq_mask = max_vq > 0 ? MAKE_64BIT_MASK(0, max_vq) : 0;
         vq_map = vq_supported & ~vq_init & vq_mask;
 
-        if (max_vq == 0 || vq_map == 0) {
+        if (vq_map == 0) {
             error_setg(errp, "cannot disable sve%d", vq * 128);
             error_append_hint(errp, "Disabling sve%d results in all "
                               "vector lengths being disabled.\n",
-- 
2.34.1


