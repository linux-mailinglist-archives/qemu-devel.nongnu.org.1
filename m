Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F00A27161EF
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 15:31:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3zNT-0007Al-Ld; Tue, 30 May 2023 09:27:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMy-0005hi-A9
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:37 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q3zMr-0001Qa-U2
 for qemu-devel@nongnu.org; Tue, 30 May 2023 09:26:34 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-4f3a873476bso4839210e87.1
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 06:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685453188; x=1688045188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=IfqETY10NL24k2y0dAUDA/KqEV1DZL6li15ZpnxHU7o=;
 b=S+ouF65k7Pd1naM6RjDAD5yL6mvQm/P3DADR52v22t3nWJ1p5KIQJ4tzN+4YQFgH2Y
 1FGFXS3BvDNoyJDCEQ15egpNSvU/MWF2Zxu4zBwR/mRvaaGJWQc3O/O8GTxnSxmtIH+t
 sxW7b4xI06eAL5SbcY6bTXXOKfRxw4Rp7ibSNRXy/9n/6A0dy8ki6JIjfUvWJ4PRmOw8
 639BrHW0fBPn3MO/H/b63i5YTc9Fa+BjAKWnrOooZlp+/zfTH1s8XUX0Hn6LVpLQyYf4
 ylQECk0NHWAtnecNvtycjCzOBrSYXSJZtlgIwSFFOOb2XjpFCYQNBZjArWQnBv3IH6Lj
 KNUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685453188; x=1688045188;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IfqETY10NL24k2y0dAUDA/KqEV1DZL6li15ZpnxHU7o=;
 b=YJKOeyphrEb972p/XOxm6QUEzDQswe4CizceXb0b1jR12LPst6i0cjWfD1oX+dMLQ+
 kQzwwxF878++NEnKmyA0Uu/H1GnR06Pso8j3D6NppxrQx516dKZZN5Bra+jpqhJGGnw8
 NfgAqMUfumgp60yvuFfrAkRo/2WDRF2Oe0soBk4xYEnTyvyNWjaMYSoJ7LtW28rzk55n
 qfLqTFDNV+ybvfpobMr3M7xHQ/eiqi8Zg8zzTRFYunkCPsKsCKmUO3uRRj6YBr2YTXeM
 BYAsP/+gPHULHEAGOBbK6yVO8j6SObpdYjNsoK+CJkJXhZOZsVrujQKC2PVuuyCDrJ53
 Ywbg==
X-Gm-Message-State: AC+VfDwwhdGLHva5FnKK6HwLZbJvdzthyFgzhbAeen0OVBnkueA5Mi2t
 ILQU4tPzcp8TvjmATR79xSB5tDCb+kUYqirlV90=
X-Google-Smtp-Source: ACHHUZ6GvWoK7n2mPVhuWj1KknUPBh4kgfhIVkSipxjSSr27TiX8/HQb7Q66fIk0kiOc3NF2vFGcdQ==
X-Received: by 2002:ac2:5e8d:0:b0:4f4:b5a8:c24a with SMTP id
 b13-20020ac25e8d000000b004f4b5a8c24amr778061lfq.50.1685453188274; 
 Tue, 30 May 2023 06:26:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a1c7413000000b003f60e143d38sm17463615wmc.11.2023.05.30.06.26.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 May 2023 06:26:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 14/21] tests/qtest: Run arm-specific tests only if the required
 machine is available
Date: Tue, 30 May 2023 14:26:13 +0100
Message-Id: <20230530132620.1583658-15-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530132620.1583658-1-peter.maydell@linaro.org>
References: <20230530132620.1583658-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

From: Thomas Huth <thuth@redhat.com>

pflash-cfi02-test.c always uses the "musicpal" machine for testing,
test-arm-mptimer.c always uses the "vexpress-a9" machine, and
microbit-test.c requires the "microbit" machine, so we should only
run these tests if the machines have been enabled in the configuration.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Message-id: 20230524080600.1618137-1-thuth@redhat.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 tests/qtest/meson.build | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
index 4c5585ac0f6..087f2dc9d7c 100644
--- a/tests/qtest/meson.build
+++ b/tests/qtest/meson.build
@@ -198,14 +198,15 @@ qtests_arm = \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_DUALTIMER') ? ['cmsdk-apb-dualtimer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_TIMER') ? ['cmsdk-apb-timer-test'] : []) + \
   (config_all_devices.has_key('CONFIG_CMSDK_APB_WATCHDOG') ? ['cmsdk-apb-watchdog-test'] : []) + \
-  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') ? ['pflash-cfi02-test'] : []) +         \
+  (config_all_devices.has_key('CONFIG_PFLASH_CFI02') and
+   config_all_devices.has_key('CONFIG_MUSICPAL') ? ['pflash-cfi02-test'] : []) + \
   (config_all_devices.has_key('CONFIG_ASPEED_SOC') ? qtests_aspeed : []) + \
   (config_all_devices.has_key('CONFIG_NPCM7XX') ? qtests_npcm7xx : []) + \
   (config_all_devices.has_key('CONFIG_GENERIC_LOADER') ? ['hexloader-test'] : []) + \
   (config_all_devices.has_key('CONFIG_TPM_TIS_I2C') ? ['tpm-tis-i2c-test'] : []) + \
+  (config_all_devices.has_key('CONFIG_VEXPRESS') ? ['test-arm-mptimer'] : []) + \
+  (config_all_devices.has_key('CONFIG_MICROBIT') ? ['microbit-test'] : []) + \
   ['arm-cpu-features',
-   'microbit-test',
-   'test-arm-mptimer',
    'boot-serial-test']
 
 # TODO: once aarch64 TCG is fixed on ARM 32 bit host, make bios-tables-test unconditional
-- 
2.34.1


