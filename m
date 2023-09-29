Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5797B3426
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 16:04:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmE5t-0003Pd-JV; Fri, 29 Sep 2023 10:03:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1qmE5h-0003HL-JG
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:03:38 -0400
Received: from pharaoh.lmichel.fr ([149.202.28.74])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luc@lmichel.fr>) id 1qmE5f-0001JZ-Ef
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 10:03:37 -0400
Received: from michell-laptop.home.lmichel.fr (sekoia-laptop.home.lmichel.fr
 [192.168.61.102])
 by pharaoh.lmichel.fr (Postfix) with ESMTPS id 022BBC600FF;
 Fri, 29 Sep 2023 16:03:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lmichel.fr; s=pharaoh; 
 t=1695996209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=LhRz6359UdVBGyW3ObX+vNGGzthOFtuV8PfpI4o9k7c=;
 b=hKyc82f4/a9mBAR/CAnq7xnigCL4WW0VewNitHTsdP1JKciYm5Z3yRyol0Zo/MzSelKDnP
 pkGKrimjQTUqAH2tgc9dds468AUYDDxbRF5Q6Vca0YFehQZPSoE7sG0m6rDxPm3E96vM9y
 4wc72WToUyjceEy0huXFgfZbfWs0gGJJEhb2l5Wks3Bew3E3KDdW7MxWx9d6zncQugD/05
 ZeWJJREbjoAou+/dNbDqBUpSCi/W/KGl6YRP6jLurxfPV3bXn3M5AGNBaHBob6X5rY/1E3
 XjG2a6RrnLZLx+AcVmJ63OUbsEvoQV4fiXkopxKXti+MK6Ic9iR1cfamdqbopQ==
From: Luc Michel <luc@lmichel.fr>
To: qemu-devel@nongnu.org
Cc: Luc Michel <luc@lmichel.fr>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2] mailmap: update email addresses for Luc Michel
Date: Fri, 29 Sep 2023 16:03:27 +0200
Message-ID: <20230929140326.2056658-2-luc@lmichel.fr>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=149.202.28.74; envelope-from=luc@lmichel.fr;
 helo=pharaoh.lmichel.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Map my old and now invalid work email addresses to my personal one.

Signed-off-by: Luc Michel <luc@lmichel.fr>
---
Please ignore v1 sent with wrong e-mail address.
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 64ef9f4de6..49f581bafd 100644
--- a/.mailmap
+++ b/.mailmap
@@ -65,10 +65,13 @@ Greg Kurz <groug@kaod.org> <gkurz@linux.vnet.ibm.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhc@lemote.com>
 Huacai Chen <chenhuacai@kernel.org> <chenhuacai@loongson.cn>
 James Hogan <jhogan@kernel.org> <james.hogan@imgtec.com>
 Leif Lindholm <quic_llindhol@quicinc.com> <leif.lindholm@linaro.org>
 Leif Lindholm <quic_llindhol@quicinc.com> <leif@nuviainc.com>
+Luc Michel <luc@lmichel.fr> <luc.michel@git.antfield.fr>
+Luc Michel <luc@lmichel.fr> <luc.michel@greensocs.com>
+Luc Michel <luc@lmichel.fr> <lmichel@kalray.eu>
 Radoslaw Biernacki <rad@semihalf.com> <radoslaw.biernacki@linaro.org>
 Paul Brook <paul@nowt.org> <paul@codesourcery.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@mips.com>
 Paul Burton <paulburton@kernel.org> <paul.burton@imgtec.com>
 Paul Burton <paulburton@kernel.org> <paul@archlinuxmips.org>
-- 
2.42.0


