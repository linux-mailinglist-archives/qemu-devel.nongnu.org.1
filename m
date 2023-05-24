Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5645870F8E3
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 16:39:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pcc-0007G3-Vg; Wed, 24 May 2023 10:37:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1q1pcY-0007Fm-Kl
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:37:47 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1q1pcM-0007qn-Ub
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:37:43 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3f60e536250so13561415e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1684939047; x=1687531047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=4CLXJNIE8AnmMaFUz3EhGB103d1OicktN0ykzKSWRh4=;
 b=Hj0wevK72gW+XsAwSRhyF8trZpIHmYzZcutuX/wyrQGksai1u5tdtnPPmGaeZ+rNUT
 uboIIWFgoL3lv/UQJpn1OWNUsiMbWtzpAPVLOgs89Mg7Y/bIgvjRWJ7tIzs7EEm7Jb5e
 2os8Dauy94DwVPNXZhsdVZz1NPIEJf2uUw1UweuPFdVs8CPla7FXgT3KWSH4W7nRQr/9
 FYc8Lf/yVSy/S9+93dR4W/8cPv/FDuVcYEsIZkh9GNBrfuEKyqMPK9tBlAQhTIFJiWC+
 RXhBA8ejqbcb8zScMDgABftgsh68uISAlZ3TyENthx45ocLVngLB4vyTjB9jSjac1Y/V
 4hLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684939047; x=1687531047;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4CLXJNIE8AnmMaFUz3EhGB103d1OicktN0ykzKSWRh4=;
 b=iG4eFInHpl/Nv3cOnY4f3vkTwRYtT08AlsKkatgjAFbsO2UFft+q4HMj/1Yw0BajZi
 B+R+Xy3jVT0hgexrodeQ0H2SjHrPwuGc5eIdx2dFKKesbV/NkoUDko/I2xE6QvuVfaw7
 Ak/RWfORPu2YwO1jQm0ZAogqexj1tjfrcgLyFHAHi239e6cERqW7xfjB80iQTZwsfq12
 R5HIU6OHw2/MqfxegPmqfTEuVSwGhHmv6qRADITxdUOAe5mKKcR1UfSrlbwPskdatueo
 qCsf9p3g5aFl/ecyX4B0r2zjoXZfNlKm5D6wc8MFjlc4axnvzL/zwxFg74uJKcpn68pO
 J1DQ==
X-Gm-Message-State: AC+VfDxMYNJh7tCObf7HmS8epwkBZVrM0cMUI2DKwR94/ZYcPd2j0dEK
 5ouRFqwkRlm2KwDEiW3lIsMhwXxoHvVKoUyADrE=
X-Google-Smtp-Source: ACHHUZ48GSFwR24EznQBGHlJE9tbfiYWWgdkstT+h4hJCLjaLM7ICSKl9FdxX9hkcJl1oo54KQV/jQ==
X-Received: by 2002:a5d:6e8f:0:b0:2ff:801b:dec6 with SMTP id
 k15-20020a5d6e8f000000b002ff801bdec6mr13440148wrz.20.1684939047378; 
 Wed, 24 May 2023 07:37:27 -0700 (PDT)
Received: from chigot-Dell.home ([2a01:cb15:8123:8100:c59d:d6:6f27:fde6])
 by smtp.gmail.com with ESMTPSA id
 q9-20020adffec9000000b002ceacff44c7sm14669319wrs.83.2023.05.24.07.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 May 2023 07:37:26 -0700 (PDT)
From: =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, edgar.iglesias@gmail.com, alistair@alistair23.me,
 peter.maydell@linaro.org,
 =?UTF-8?q?Cl=C3=A9ment=20Chigot?= <chigot@adacore.com>
Subject: [PATCH] hw/arm/xlnx-zynqmp: fix unsigned error when checking the RPUs
 number
Date: Wed, 24 May 2023 16:37:14 +0200
Message-Id: <20230524143714.565792-1-chigot@adacore.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=chigot@adacore.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

When passing --smp with a number lower than XLNX_ZYNQMP_NUM_APU_CPUS,
the expression (ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS) will result
in a positive number as ms->smp.cpus is a unsigned int.
This will raise the following error afterwards, as Qemu will try to
instantiate some additional RPUs.
  | $ qemu-system-aarch64 --smp 1 -M xlnx-zcu102
  | **
  | ERROR:../src/tcg/tcg.c:777:tcg_register_thread:
  |   assertion failed: (n < tcg_max_ctxs)

Signed-off-by: Clément Chigot <chigot@adacore.com>
---
 hw/arm/xlnx-zynqmp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
index 335cfc417d..5905a33015 100644
--- a/hw/arm/xlnx-zynqmp.c
+++ b/hw/arm/xlnx-zynqmp.c
@@ -213,7 +213,7 @@ static void xlnx_zynqmp_create_rpu(MachineState *ms, XlnxZynqMPState *s,
                                    const char *boot_cpu, Error **errp)
 {
     int i;
-    int num_rpus = MIN(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS,
+    int num_rpus = MIN((int)(ms->smp.cpus - XLNX_ZYNQMP_NUM_APU_CPUS),
                        XLNX_ZYNQMP_NUM_RPU_CPUS);
 
     if (num_rpus <= 0) {
-- 
2.25.1


