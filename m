Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34FDD70F987
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 17:00:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1pxk-0006Iu-Tt; Wed, 24 May 2023 10:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxa-0006G7-19
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:30 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q1pxS-0006E9-UY
 for qemu-devel@nongnu.org; Wed, 24 May 2023 10:59:25 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30a1fdde3d6so923579f8f.0
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 07:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684940349; x=1687532349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u+I66XzF83QGfQRczDmREp33WLCVxh4y1YWigeQWiZY=;
 b=jeWWkeNLDAYu+p0La/YDqVv1DGE470Bv0h6Y0xE6uBRuYo91XJvlFHKV1EL6vNOLtE
 57/7SI3Zk0FocY+q1XErC/UPNah2mOFQHKr7AQ5dHugxuaSrhV2f3uI02sbyFXp+6L8o
 cs59vMW6UBtpwhYSQuBuOhZJn7Zmt1yyZdIIZggs8BFfi1qsbpN0UEE8qig7gCGmGiNE
 OwslX2ohnOJpkgR4970AM1VwiK4W5afnngzle8g1Ccrd8BjeuU2APjAdDswvLVlbgsqM
 pZHALrIU8E7ZK7TLEUyIxauOGFV+VpTQIKmAiF8WauWkYLkUIWrEF6uZ4+XFVlzlFGg7
 7r3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684940349; x=1687532349;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u+I66XzF83QGfQRczDmREp33WLCVxh4y1YWigeQWiZY=;
 b=XuFs2uTwTTWnYuw9QJ0qX8qcJ+LBPNrP7FLwE+000aEZPCm4SSOAX8+Li1lWPHhDtl
 GiLFWZmDpSvBUv+zoygTgAYBoiy3vT/Sq9FhiqoV9+zudXX9NSy6tSXUq7Y6q2t0qDDe
 DLJXm6yB3a9A3gxRTHwIjxsvhl5diIbzuH8DVuMCLzcDOmv80i/pMBBNFyaqJMByH4uJ
 tB5h3TB8aFr8pf/7b1b6cMDLwR/rMnItaCY1k/F471DoWukY68n9NkriUin6j1ZVr3y+
 AMaQME53NSMxik85a4+c9ZD2DUpYj1GUOE89933UqwY8H5oa+Ak/tBxVnHO1aKedAftc
 H5gQ==
X-Gm-Message-State: AC+VfDxB7BqX8Q+8aMphN/0MGWDoRiQTJmtK2Tj0qIU9pFbNKcJzB/LM
 MlAAcTTlIQt68zpW85Gap6KqCnVv2I35giULypWrjQ==
X-Google-Smtp-Source: ACHHUZ6TbDmHZzVAHp7I3aAv1WejrAeUaR/onE78uld1DpJX/ljo/K0YsVVCN9GcCvfbCWcrjfyONQ==
X-Received: by 2002:a05:6000:1246:b0:306:2fd3:2edb with SMTP id
 j6-20020a056000124600b003062fd32edbmr38452wrx.61.1684940348943; 
 Wed, 24 May 2023 07:59:08 -0700 (PDT)
Received: from localhost.localdomain
 (fac34-h02-176-184-31-193.dsl.sta.abo.bbox.fr. [176.184.31.193])
 by smtp.gmail.com with ESMTPSA id
 j15-20020a5d464f000000b00307d58b3da9sm14700936wrs.25.2023.05.24.07.59.07
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 24 May 2023 07:59:08 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH 00/10] hw/arm/realview: Introduce abstract RealviewMachineClass
Date: Wed, 24 May 2023 16:58:56 +0200
Message-Id: <20230524145906.33156-1-philmd@linaro.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

Probably still spring housekeeping stuff.
QOM'ify Realview machines further by introducing a common
(abstract) MachineClass, and set the read-only fields in
the class_init() instead of machine_init() method.

At least the diff-stat is negative :)

Philippe Mathieu-Daudé (10):
  hw/arm/realview: Simplify using 'break' statement
  hw/arm/realview: Declare QOM types using DEFINE_TYPES() macro
  hw/arm/realview: Introduce abstract RealviewMachineClass
  hw/arm/realview: Factor realview_common_class_init() out
  hw/arm/realview: Move 'board_id' to RealviewMachineClass
  hw/arm/realview: Move 'is_pb' to RealviewMachineClass
  hw/arm/realview: Move 'mpcore_periphbase' to RealviewMachineClass
  hw/arm/realview: Move 'loader_start' to RealviewMachineClass
  hw/arm/realview: Use generic realview_common_machine_init()
  hw/arm/realview: Set MachineClass::default_nic in machine_class_init()

 hw/arm/realview.c | 177 +++++++++++++++++++---------------------------
 1 file changed, 74 insertions(+), 103 deletions(-)

-- 
2.38.1


