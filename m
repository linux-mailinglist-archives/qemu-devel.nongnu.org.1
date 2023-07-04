Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 627A6747475
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 16:51:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGhMJ-0003UP-0W; Tue, 04 Jul 2023 10:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhMC-0003Tn-Tm
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:20 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qGhM9-0002oP-1Q
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 10:50:20 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3144098df56so802599f8f.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 07:50:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688482215; x=1691074215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=pC0y5hAXJgyUcYLTNDTBx7JZb6mKEWfua2iOK72cNaw=;
 b=nSeygWQeZ21e3K8oFC58vn3T4ynGyGkDkFheP6pon28GDZh1b12d1HcPGJz7KFJ4ua
 Let5dm9yNOiABp3FI59ZMyIrrf/fRymJrIZQHW1EbVZ6QlH5PjuLBc+6NQZLoDJqxp3J
 CSCB1Xf1UzeXYITlWHoinW2se5han4JAtZp2rL5ALKKVzOvU34vAsK7H2l7axsvY6PJM
 Vo605Ol/EF6/j9O1/+7rdw5Jr+fD612a6/iS8xr2FP5oW5boVLTjL+EfxFbQFs3mvW1k
 t3C0udpkiIx/YaALTVDorTlOXXaSdD8XJl6DsBSpCaQLh/uyln0O/IxKBuhY/ELAlMuP
 lZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688482215; x=1691074215;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pC0y5hAXJgyUcYLTNDTBx7JZb6mKEWfua2iOK72cNaw=;
 b=dR9JziF3nxtUgC7gymBN/MB+0+GkaKZ4Vrgup7IAI13tYpfnEgIyeeBQAcjZYIaMe6
 jqtKUWC2W4Ox65astX1SfM9uIa6H+LJ0UXF/Jn2zteFoIYh08MOBs5UxvS6fQDD9V4RB
 3pmL5hose2kyjDRpVtLDWCOGS5P7r4aDEeCYBKiX/jumKJeo53C1a+bJdWKJjfmyQUdk
 Ty30HdDL9zd5uI5K2UoC5KkTA/+URv/8K+V5v3k3RVvIQVZ8RkP9knUwjHjCuYkS0Rhr
 fz4gVsWRKXxfpnu7STj5DmKt+7tUGkZcj5KqxmMLLNfw49q+pTS7RV702x9LYppMMnjs
 5p9g==
X-Gm-Message-State: ABy/qLZknHiFsVSEmke87qWRKHtbDJFbIQglXFo2mp3DEbToSEcm27U2
 DfzpDxfZomR6/JPTSEfkgFwclcvIYSrgX21ta6Q=
X-Google-Smtp-Source: APBJJlHXoGUDe3r1Hk7TE0hwx3jHxkRtykNud2/OwM9CJgwKBah72NaI2roaYB30mudWBc0dWwJyUQ==
X-Received: by 2002:adf:f60c:0:b0:313:fcea:db06 with SMTP id
 t12-20020adff60c000000b00313fceadb06mr12618889wrp.12.1688482215219; 
 Tue, 04 Jul 2023 07:50:15 -0700 (PDT)
Received: from localhost.localdomain ([176.176.157.122])
 by smtp.gmail.com with ESMTPSA id
 b7-20020a5d4b87000000b00314374145e0sm5678432wrt.67.2023.07.04.07.50.14
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 04 Jul 2023 07:50:14 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Sergey Kambalin <serg.oker@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 00/19] hw/timer/arm_timer: QOM'ify ARM_TIMER and correct
 sysbus/irq in ICP_PIT
Date: Tue,  4 Jul 2023 16:49:53 +0200
Message-Id: <20230704145012.49870-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

This series converts the ARM_TIMER model to QOM.

Doing so we also correct an abuse of SysBus IRQ in
the ICP PIT model.

Since v1:
- Added pm215's R-b tags
- Addressed Mark/Peter review comments
  - Drop '*State' suffix from structure names
  - Use OR-IRQ gate
  - Drop sp804_unrealize()
  - Implement Resettable API
- MMIO-map timer regions into parents

Regards,

Phil.

Philippe Mathieu-Daudé (19):
  hw/timer/arm_timer: Declare QOM types using DEFINE_TYPES() macro
  hw/timer/arm_timer: Remove pointless cast from void *
  hw/timer/arm_timer: Move SP804 code around
  hw/timer/arm_timer: CamelCase rename icp_pit_state -> IntegratorPIT
  hw/timer/arm_timer: CamelCase rename arm_timer_state -> ArmTimer
  hw/timer/arm_timer: Rename SP804State -> SP804Timer
  hw/timer/arm_timer: Rename TYPE_SP804 -> TYPE_SP804_TIMER
  hw/timer/arm_timer: Extract arm_timer_reset_hold()
  hw/timer/arm_timer: Convert read/write handlers to MemoryRegionOps
    ones
  hw/timer/arm_timer: Rename arm_timer_init() -> arm_timer_new()
  hw/timer/arm_timer: Convert ArmTimer::freq to uint32_t type
  hw/timer/arm_timer: Use array of frequency in SP804Timer
  hw/timer/arm_timer: Iterate on timers using for() loop statement
  hw/timer/arm_timer: Pass timer output IRQ as parameter to
    arm_timer_new
  hw/timer/arm_timer: Fix misuse of SysBus IRQ in IntegratorPIT
  hw/timer/arm_timer: Extract icp_pit_realize() from icp_pit_init()
  hw/timer/arm_timer: QDev'ify ARM_TIMER
  hw/timer/arm_timer: Map ARM_TIMER MMIO regions into IntegratorPIT
  hw/timer/arm_timer: Map ARM_TIMER MMIO regions into SP804Timer

 hw/timer/arm_timer.c | 353 +++++++++++++++++++++++++------------------
 hw/timer/Kconfig     |   1 +
 2 files changed, 203 insertions(+), 151 deletions(-)

-- 
2.38.1


