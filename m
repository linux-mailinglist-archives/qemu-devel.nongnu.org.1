Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A3F575797D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 12:46:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLiE5-0005JN-7B; Tue, 18 Jul 2023 06:46:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLiDx-00055u-9S
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:46:33 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qLiDv-0002Yr-BI
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 06:46:33 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-3fbc5d5742bso55169215e9.2
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 03:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689677189; x=1692269189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=y7oUZ4n1mUCX7pEZw4Et8W3HYEPkB8j81LvGnYRlU10=;
 b=uCBxGDgNC5ROxe9CKZiICcvaDx1kNIeGWsXIGBEXsvYHlljBk+9h2FsMq97BoUIiUi
 FsUcl8AUz7gqqgpP6eZnC6qSBUd8osu6rkmg/qbtyfF9WYOGZGIx7lMr4tet6k86o58W
 CdnRSsSTNXm0canCRzwGHBlk+WcYVSx9gj5aD91NiYzSFqjET2eSTQUZGSNKVbTVdlAw
 RqR4CqIhyQ7lwXk8jt5OSIuz9LKddn+XRM+lwZHFAJg5TgCxgMBIsOJE35/DbXOVpEXV
 pKWGFQ+D+6YReD2z09k7F6MXUe6hboxK7pQI6XHwJSWfMf2qzjyuY+DLnw6CJvxlY3NU
 zdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689677189; x=1692269189;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=y7oUZ4n1mUCX7pEZw4Et8W3HYEPkB8j81LvGnYRlU10=;
 b=RQuOS8imjHFlria7UTN6yVrOq8SS/uMD5S3NLIxLuA9Q3G28xkK5hN8Pp7P3QMwgm5
 iVb81i9dhV/ryupvZArEYHUUePb5JhUQ10Ci1jCRQyem1xyayptUlkQs2+TnWCA/ilTd
 HwTipk/vXYTYKp1zrz547gUYP4dE8srCgGXfVUdcn5ezj4+P9fs50PB3gV/55TPDTcI9
 aavebc/NIhAq3j3CX6WLBRfRutjqQF8kS1SoK/EqQB9LXeIhiotqjHNvgKWySZQktEEy
 8Q+cLyKLVVjuYV2/aPXC82FuowjfgMS+h1q5fATPs9e++pEJdbFPXrbsT2V7wniCeR1e
 MB/Q==
X-Gm-Message-State: ABy/qLYBcxs5afjHDxU1ske1nzVZr0LPV8b8fmz8GvVeMnNH9k4w3nhY
 dUlelIKZ0JKoP77m3f3dlszD2A==
X-Google-Smtp-Source: APBJJlFJJ3UnCCHYJOgHFycl2oGdbFziXjiYD8yOELyVmBrD460rsbQznZBPajhVuXTkj0w4MchoUg==
X-Received: by 2002:a05:600c:21c2:b0:3fb:e1ed:7f83 with SMTP id
 x2-20020a05600c21c200b003fbe1ed7f83mr1541724wmj.33.1689677189495; 
 Tue, 18 Jul 2023 03:46:29 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 s26-20020a7bc39a000000b003fbb06af219sm1799123wmj.32.2023.07.18.03.46.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jul 2023 03:46:29 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH] target/arm/tcg: Don't build AArch64 decodetree files for
 qemu-system-arm
Date: Tue, 18 Jul 2023 11:46:28 +0100
Message-Id: <20230718104628.1137734-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

Currently we list all the Arm decodetree files together and add them
unconditionally to arm_ss.  This means we build them for both
qemu-system-aarch64 and qemu-system-arm.  However, some of them are
AArch64-specific, so there is no need to build them for
qemu-system-arm.  (Meson is smart enough to notice that the generated
.c.inc file is not used by any objects that go into qemu-system-arm,
so we only unnecessarily run decodetree, not anything more
heavyweight like a recompile or relink, but it's still unnecessary
work.)

Split gen into gen_a32 and gen_a64, and only add gen_a64 for
TARGET_AARCH64 compiles.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/arm/tcg/meson.build | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/target/arm/tcg/meson.build b/target/arm/tcg/meson.build
index bdcab564899..6fca38f2ccb 100644
--- a/target/arm/tcg/meson.build
+++ b/target/arm/tcg/meson.build
@@ -1,7 +1,11 @@
-gen = [
+gen_a64 = [
+  decodetree.process('a64.decode', extra_args: ['--static-decode=disas_a64']),
   decodetree.process('sve.decode', extra_args: '--decode=disas_sve'),
   decodetree.process('sme.decode', extra_args: '--decode=disas_sme'),
   decodetree.process('sme-fa64.decode', extra_args: '--static-decode=disas_sme_fa64'),
+]
+
+gen_a32 = [
   decodetree.process('neon-shared.decode', extra_args: '--decode=disas_neon_shared'),
   decodetree.process('neon-dp.decode', extra_args: '--decode=disas_neon_dp'),
   decodetree.process('neon-ls.decode', extra_args: '--decode=disas_neon_ls'),
@@ -13,10 +17,10 @@ gen = [
   decodetree.process('a32-uncond.decode', extra_args: '--static-decode=disas_a32_uncond'),
   decodetree.process('t32.decode', extra_args: '--static-decode=disas_t32'),
   decodetree.process('t16.decode', extra_args: ['-w', '16', '--static-decode=disas_t16']),
-  decodetree.process('a64.decode', extra_args: ['--static-decode=disas_a64']),
 ]
 
-arm_ss.add(gen)
+arm_ss.add(gen_a32)
+arm_ss.add(when: 'TARGET_AARCH64', if_true: gen_a64)
 
 arm_ss.add(files(
   'cpu32.c',
-- 
2.34.1


