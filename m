Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9F777EC8B5
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 17:38:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3Ity-0006Vf-OC; Wed, 15 Nov 2023 11:38:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r3Its-0006Tr-DF
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:38:00 -0500
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1r3Itm-0000rZ-Vo
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 11:37:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1700066266; bh=T6+Tz1kIgVc2RrwUBu8VQcuOG2g4nDQuX1z3OdnjClk=;
 h=From:Subject:Date:To:Cc:From;
 b=kcObhRpJEwnzh2hnUsZO9IxNUx3NPFusPPhFrvM1aGKxEkZG2bTQv5IE3KGPCl+6/
 1gTXexXkjWHFCJth3IE2vnc4u+C35iOJ/RrMsd5WuDRDyzKBHXFvurjvPymukteVMb
 ABnx0I9VtNK4UABrTtgI1lYi5oyaZxS/WhRyID7Y=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH 0/2] linux-user: two fixes to coredump generation
Date: Wed, 15 Nov 2023 17:37:38 +0100
Message-Id: <20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANLzVGUC/x3MSwqAMAwA0atI1gYaq0K9irioNmrAb0tFEO9uc
 TmLNw8E9sIBmuwBz5cE2bcUlGcwzHabGMWlhkIVmogqPHmNGJNCF9fD9gujK40ZlDY1KQ0JHp5
 Huf9p273vB0eHCwhkAAAA
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1700066266; l=473;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=T6+Tz1kIgVc2RrwUBu8VQcuOG2g4nDQuX1z3OdnjClk=;
 b=qNTDyEPC05GTfYlGH4clp8yJyG2I7is8gQey6dlPbkoiqYNUex2D1Pt+lDD1SvLQKY8mpVEys
 9u5l5hJms10CiUkUWsWwHp/PtO34NVNb6rpsnGywSAPOnMXd+Ef/ljp
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=2a01:4f8:c010:41de::1;
 envelope-from=thomas@t-8ch.de; helo=todd.t-8ch.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Thomas Weißschuh <thomas@t-8ch.de>
---
Thomas Weißschuh (2):
      linux-user/elfload: test return value of getrlimit
      linux-user/elfload: check PR_GET_DUMPABLE before creating coredump

 linux-user/elfload.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)
---
base-commit: 9c673a41eefc50f1cb2fe3c083e7de842c7d276a
change-id: 20231115-qemu-user-dumpable-d499c0396103

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


