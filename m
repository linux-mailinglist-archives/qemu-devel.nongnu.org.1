Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30DD9808671
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 12:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBCHT-0002fK-ST; Thu, 07 Dec 2023 06:11:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBCHO-0002et-SA
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 06:10:55 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBCHM-0004fc-DM
 for qemu-devel@nongnu.org; Thu, 07 Dec 2023 06:10:54 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-33350fcb2c7so554241f8f.2
 for <qemu-devel@nongnu.org>; Thu, 07 Dec 2023 03:10:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701947450; x=1702552250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dXjSCK34R3h3M/dmvhhSfTZBGg4aHS/PwIXNQt3mFHo=;
 b=xCi6Avti5xKEQm9LD9/SfZn/y2orBbrDkWY8PCl2PyFh+dD01GFD1BMxW0rlc3BVJy
 NtFMiz5OkmEf6i9rVtX0kZes/PXAdqcG6hkODhDU7bwrQPTc1vRhC99bjnTtv7A3ae3c
 gAw4Acd8ruucS9yKDlsXfeAVEiTGWkT7PBY7KZxv197oxrMRPWyhcCfvOMJIeU/rbusK
 /t9hVGqfBQjOQPAhRAL57iOK9/bMvCSfMqHeXpydgXfFOs/uLVI5eXeFBzlMDRJ+YP8x
 4jkaY9QLOB+YSMlxOwQGyJenC8nXWx+cNI4xVKWLPllhz0op6J9cuBsqVMdfqDGF/6cb
 4S8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701947450; x=1702552250;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXjSCK34R3h3M/dmvhhSfTZBGg4aHS/PwIXNQt3mFHo=;
 b=rK4fhlf3OtvwzmAXaOgEAMuGMZCKau8XwPFeDpJOIjlFh7kDj7KUtIxOzVR5Isml7h
 9hgrMpUr+GgnJU8PqWOjovALrWCRDCRUVqm6x8y4nw6Y3eWub1w+e0yihlx+PmIT0zzy
 OIzugZv4bp6fBlUWBf4c/Kw3FPriGb15g44YewU6ICgHupbEAky+r/eJW39G77cQZlZp
 YLG2PBZ89Ooz6VVRw12W5CXtaO3WnI+LuFe9liNGAAG8CWDoGARWGDCEsW2bdRMDjKeD
 fYaySyfSBwj0TbeQAcPL3mQ18Cb+nu9QaXFdgB0750XPD2G+DLYXnYrFfSjfYz1vr+xd
 8MBA==
X-Gm-Message-State: AOJu0YzhRhUBtPoHeA8ZFuo4ErXFihpp8sRTFvFA1iOpRgzoQ5coc5tT
 CGGMHAUmmIAUDPtk8uKr+UeXbE4H0DFnNcRz0Ho=
X-Google-Smtp-Source: AGHT+IGDzvoxJKYv0VrwfJCWpSQOGCJ1BYf3WcTdNe1ai2rwhhVxV93ov5MtzW7LMftESmmiyTzJ+g==
X-Received: by 2002:adf:fac2:0:b0:333:2fd2:816a with SMTP id
 a2-20020adffac2000000b003332fd2816amr1413317wrs.135.1701947450369; 
 Thu, 07 Dec 2023 03:10:50 -0800 (PST)
Received: from m1x-phil.lan ([176.187.202.111])
 by smtp.gmail.com with ESMTPSA id
 dh8-20020a0560000a8800b00334b3208700sm1163670wrb.49.2023.12.07.03.10.49
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Thu, 07 Dec 2023 03:10:50 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH] target/arm: Restrict ARM_FEATURE_PMU to system emulation
Date: Thu,  7 Dec 2023 12:10:48 +0100
Message-ID: <20231207111048.50568-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

ARM Performance Monitor Unit is not reachable from user
emulation, restrict it to system emulation.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 target/arm/cpu.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/target/arm/cpu.c b/target/arm/cpu.c
index 51f57fd5b4..60cf747fd6 100644
--- a/target/arm/cpu.c
+++ b/target/arm/cpu.c
@@ -1410,6 +1410,7 @@ static Property arm_cpu_pmsav7_dregion_property =
                                            pmsav7_dregion,
                                            qdev_prop_uint32, uint32_t);
 
+#ifndef CONFIG_USER_ONLY
 static bool arm_get_pmu(Object *obj, Error **errp)
 {
     ARMCPU *cpu = ARM_CPU(obj);
@@ -1432,6 +1433,7 @@ static void arm_set_pmu(Object *obj, bool value, Error **errp)
     }
     cpu->has_pmu = value;
 }
+#endif
 
 unsigned int gt_cntfrq_period_ns(ARMCPU *cpu)
 {
@@ -1592,12 +1594,12 @@ void arm_cpu_post_init(Object *obj)
     if (arm_feature(&cpu->env, ARM_FEATURE_EL2)) {
         qdev_property_add_static(DEVICE(obj), &arm_cpu_has_el2_property);
     }
-#endif
 
     if (arm_feature(&cpu->env, ARM_FEATURE_PMU)) {
         cpu->has_pmu = true;
         object_property_add_bool(obj, "pmu", arm_get_pmu, arm_set_pmu);
     }
+#endif
 
     /*
      * Allow user to turn off VFP and Neon support, but only for TCG --
-- 
2.41.0


