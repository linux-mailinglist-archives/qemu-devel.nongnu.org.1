Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A6D82A18D
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 20:55:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNee0-0006pH-6D; Wed, 10 Jan 2024 14:53:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNedw-0006jo-LO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:53:40 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNedt-0001gH-Ph
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 14:53:39 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e461c1f5bso40911865e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Jan 2024 11:53:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704916414; x=1705521214; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/RA9V/zCbq1dSQvPyx7TCs/GRQQWLNyObGfqv1alXII=;
 b=P7AhKunDyxnN32Cc0aWzr9mxOhXH9X2cdg8xS45UZzaXUtSmj5w/qZKMt+3L7tMq1I
 vyEsP5jjzG9MV+kyC9So+z3fUP3tG+MWuurYXZ8VSXbtgoKLzwKvaryTdUvmHJN5EEfh
 d/2LXHdRlBX5o1Nz7F3QuakLZOw/1lroTFSeL2XvujZ5peCs1/TK84/FNHxe6q71FG7d
 keIURUpkhbiRvLUlU45V5Po74B7Py5R2RT6taoB65CeZ6z4JfkBFD22qkJm3NnpO3KDv
 9uxdBfa9AgLb+1m8V5MxFnfqPhBKFwHwIEYhmgahpQiMqXZPBnhXOha/iXzsfK71xn+P
 R0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704916414; x=1705521214;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/RA9V/zCbq1dSQvPyx7TCs/GRQQWLNyObGfqv1alXII=;
 b=KYa7fDFG4K2eG4bWLKa+ipMjfOr7nJmjQcuXEErA+bIYu9y3wxCmEWJnJ/Cy1cUafZ
 AYjuTB3IL3+9jtAiFrSM3CDX+y4bLPr+cK1l9tIuGTN8ZP95kOjAW4sMJ4kGLesLdmmP
 K4rUcejsp4rJDFSsdyPEcgngmKsqAQ7JGD+0/9JCjSi/qb1/WXY2Ersd69zd1lj37NTI
 mjQuHTQBDOLk4nW3izkpAlVT+W2OA9JH6d00263yKmdVgiaidrHm7bg4PRghG0aBDbYk
 sZQ5ffMnhA7QCuZK/SyYlgrw00SgNIedR/WCqA/uyUofzTcTnzOReIHzJyu5gprEDZIr
 L86g==
X-Gm-Message-State: AOJu0YxjJPJCGeH4yPsCDuhHdVMHRYPffFFhBr/gEPg3y2lDL2kyo7cf
 ls/4+oj+RDC0eLWinBFjvd18faXYgiCCOIXVq6hYpjC2Ofg=
X-Google-Smtp-Source: AGHT+IH75f3fRe/h9eX7yhRc+unepzpKSCQQF9HqYRtos34o4cYydlRxioKN8J5zeGuJWrjDz1MVXA==
X-Received: by 2002:a05:600c:927:b0:40e:4912:18c9 with SMTP id
 m39-20020a05600c092700b0040e491218c9mr755519wmp.168.1704916413668; 
 Wed, 10 Jan 2024 11:53:33 -0800 (PST)
Received: from m1x-phil.lan (vau06-h02-176-184-43-236.dsl.sta.abo.bbox.fr.
 [176.184.43.236]) by smtp.gmail.com with ESMTPSA id
 q14-20020adfcd8e000000b003368c8d120fsm5565422wrj.7.2024.01.10.11.53.31
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 10 Jan 2024 11:53:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-arm@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Rob Herring <robh@kernel.org>,
 Markus Armbruster <armbru@redhat.com>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 00/14] hw/arm: Prefer arm_feature() over
 object_property_find()
Date: Wed, 10 Jan 2024 20:53:14 +0100
Message-ID: <20240110195329.3995-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

Since v2 [2]:
- Dropped "Simplify checking A64_MTE bit in FEATURE_ID register"
- Correct object_property_get_bool() uses
- Update ARM_FEATURE_AARCH64 && aa64_mte

Since RFC [1]:
- Split one patch per feature
- Addressed Peter's review comments

[1] https://lore.kernel.org/qemu-devel/20231214171447.44025-1-philmd@linaro.org/
[2] https://lore.kernel.org/qemu-devel/20240109180930.90793-1-philmd@linaro.org/

Based-on: <20231123143813.42632-1-philmd@linaro.org>
  "hw: Simplify accesses to CPUState::'start-powered-off' property"

Philippe Mathieu-Daudé (14):
  hw/arm/armv7m: Introduce cpudev variable in armv7m_realize()
  hw/arm/armv7m: Ensure requested CPU type implements ARM_FEATURE_M
  hw/arm/armv7m: Move code setting 'start-powered-off' property around
  hw/arm/armv7m: Always set 'init-nsvtor' property for Cortex-M CPUs
  hw/arm: Prefer arm_feature(M_SECURITY) over object_property_find()
  hw/arm: Prefer arm_feature(THUMB_DSP) over object_property_find(dsp)
  hw/arm: Prefer arm_feature(V7) over
    object_property_find(pmsav7-dregion)
  hw/arm: Prefer arm_feature(EL3) over object_property_find(has_el3)
  hw/arm: Prefer arm_feature(EL2) over object_property_find(has_el2)
  hw/arm: Prefer arm_feature(CBAR*) over
    object_property_find(reset-cbar)
  hw/arm: Prefer arm_feature(PMU) over object_property_find(pmu)
  hw/arm: Prefer arm_feature(GENERIC_TMR) over 'kvm-no-adjvtime'
    property
  hw/arm: Prefer arm_feature(AARCH64) over object_property_find(aarch64)
  hw/arm: Prefer cpu_isar_feature(aa64_mte) over
    property_find(tag-memory)

 hw/arm/armv7m.c       | 36 ++++++++++++++++--------------------
 hw/arm/exynos4210.c   |  4 ++--
 hw/arm/highbank.c     |  3 ++-
 hw/arm/integratorcp.c |  5 ++---
 hw/arm/realview.c     |  2 +-
 hw/arm/sbsa-ref.c     |  3 ++-
 hw/arm/versatilepb.c  |  5 ++---
 hw/arm/vexpress.c     |  6 ++++--
 hw/arm/virt.c         | 26 +++++++++++++-------------
 hw/arm/xilinx_zynq.c  |  2 +-
 hw/cpu/a15mpcore.c    | 23 +++++++++++++++--------
 hw/cpu/a9mpcore.c     |  9 +++++----
 12 files changed, 65 insertions(+), 59 deletions(-)

-- 
2.41.0


