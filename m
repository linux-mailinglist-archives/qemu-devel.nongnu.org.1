Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898BC828C02
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 19:10:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNGXy-0002Pu-OZ; Tue, 09 Jan 2024 13:09:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXq-0002PC-Kn
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:48 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rNGXm-0003sC-Oj
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 13:09:46 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-40d8902da73so30909435e9.2
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 10:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704823774; x=1705428574; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ih59QO5Uf+GiDwqnPD0KnU4KBtIrojXxz4NGhpA5s9c=;
 b=hU8X55hks41EC19p8gbY4fFRpk62n3XQSPlVLcNIAhjUlTTMOyCWGO8qVFZZ1vBwF4
 YJPBwglN00ssXAb/+y4M1tqAZpv5/Xpr991GMZVjFOumzJOPcQbYaHM8PjEEpzOeIz6J
 mKkgBfFeLr2egySuH6S+kmrWhTM8vFTMJIB0PRrWAubpl3ise1IXwPIzobRN66rbhoSY
 7Xn+2Zj4XcJvcLxU/HFt4baJ8pwy/a1ZkMD36tzoQba5QBYB+VgtL18Z4tPSsPmbyt86
 +2+uqu4u2EKCR9GtlsRYQ6vgXf6y2JwGmyXJ95uFtCF6tR5NQf9MaqKq6js5PJ/d801K
 5Hng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704823774; x=1705428574;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ih59QO5Uf+GiDwqnPD0KnU4KBtIrojXxz4NGhpA5s9c=;
 b=BTAkzufGBPiOdGvPAWZVKgwJW1tmx5sQ0ldnNiXItatJ9h7/wNlNXYTi9KbBLR4nu8
 rus1yWbFnijZoLtxv0Ry/zRYxcr5hcxqCtko6ecNIT9T60jub3oVxlqoHs9pQw3BU6M1
 s7xxZDHsyvjM2fceimTRoHstPRvVr3gJcEJf0i/zQd4L3ljvXDPXFQUpXSZEaWfoyqgZ
 J4WhJOFXFrBea4vIVKUS7cdkOuDIUWwHVf36VFQLQwLIBFoCJpdEDbIzL5rB9Hg9rsVV
 UrZkFOgmmAPG9o5AwP36wtAG8BdRlEXrW0WPIee52qNiXIhySxdKFkgrqlHmUH6KKyKo
 LXuQ==
X-Gm-Message-State: AOJu0YyG0z+U0pWgXipHtWPwzKcB2/n9Pkm7E1da+jM6LpDM+laX6aSI
 OZoW8kviG89/oKdtDu5TyYCHnX66U6HobKe1FG4VAX5+X8VEIw==
X-Google-Smtp-Source: AGHT+IHrifeKELkHacXcTTxsVDBQKHRYqMM2IGqnfqAvppq0dVY/cV5k/wMH1c+qfpdCnDfx78L/Ng==
X-Received: by 2002:a05:600c:4f14:b0:40d:85a0:d0f3 with SMTP id
 l20-20020a05600c4f1400b0040d85a0d0f3mr3027381wmq.51.1704823773988; 
 Tue, 09 Jan 2024 10:09:33 -0800 (PST)
Received: from m1x-phil.lan (rsa59-h02-176-184-32-47.dsl.sta.abo.bbox.fr.
 [176.184.32.47]) by smtp.gmail.com with ESMTPSA id
 bi26-20020a05600c3d9a00b0040d53588d94sm15630529wmb.46.2024.01.09.10.09.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 09 Jan 2024 10:09:33 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>, Kevin Wolf <kwolf@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>, Rob Herring <robh@kernel.org>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/14] hw/arm: Prefer arm_feature() over
 object_property_find()
Date: Tue,  9 Jan 2024 19:09:15 +0100
Message-ID: <20240109180930.90793-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

Since RFC [*]:
- Split one patch per feature
- Addressed Peter's review comments

[*] https://lore.kernel.org/qemu-devel/20231214171447.44025-1-philmd@linaro.org/

Based-on: <20231123143813.42632-1-philmd@linaro.org>
  "hw: Simplify accesses to CPUState::'start-powered-off' property"

Philippe Mathieu-Daudé (14):
  target/arm/cpu: Simplify checking A64_MTE bit in FEATURE_ID register
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
  hw/arm: Prefer cpu_isar_feature(aa64_mte) over
    property_find(tag-memory)
  hw/arm: Prefer arm_feature(GENERIC_TMR) over 'kvm-no-adjvtime'
    property

 hw/arm/armv7m.c       | 36 ++++++++++++++++--------------------
 hw/arm/exynos4210.c   |  4 ++--
 hw/arm/highbank.c     |  3 ++-
 hw/arm/integratorcp.c |  5 ++---
 hw/arm/realview.c     |  2 +-
 hw/arm/sbsa-ref.c     |  3 ++-
 hw/arm/versatilepb.c  |  5 ++---
 hw/arm/vexpress.c     |  6 ++++--
 hw/arm/virt.c         | 24 ++++++++++++------------
 hw/arm/xilinx_zynq.c  |  2 +-
 hw/cpu/a15mpcore.c    | 17 +++++++++++------
 hw/cpu/a9mpcore.c     |  6 +++---
 target/arm/cpu.c      |  3 +--
 13 files changed, 59 insertions(+), 57 deletions(-)

-- 
2.41.0


