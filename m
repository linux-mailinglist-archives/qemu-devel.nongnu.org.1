Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F998833687
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 22:47:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRJA1-0006tb-FS; Sat, 20 Jan 2024 16:45:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rRJ9z-0006su-MJ
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 16:45:51 -0500
Received: from todd.t-8ch.de ([159.69.126.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thomas@t-8ch.de>) id 1rRJ9v-00089q-Mt
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 16:45:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
 t=1705787141; bh=VHbKu6UCe0NttHrFFX9ITBcfvJ1sraAsfNyNRV3siB0=;
 h=From:Subject:Date:To:Cc:From;
 b=LtcaICOzUkbebBx8iXv2IXw9Av+EgZF9WDhEbkDqopoah2YutgJCCmGwbcrpx/rFK
 V0VZK2ybkXl4Q8maHJAdFUJIuOrvNwNgK0tNj/BOPnzuz+M2o8uTw5WsTzCJfktAim
 dGKRVhOYI0D3N7i544zNjg8/YMQo1qmxiFXbPVsU=
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>
Subject: [PATCH v3 0/2] linux-user: two fixes to coredump generation
Date: Sat, 20 Jan 2024 22:45:23 +0100
Message-Id: <20240120-qemu-user-dumpable-v3-0-6aa410c933f1@t-8ch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAPM+rGUC/33NTQrCMBCG4auUrB2ZJK21rryHuGiSiQ3YH5M2K
 KV3Ny0ILsTlO/A9M7NA3lFgp2xmnqILru9SyF3GdFN3NwJnUjOBQnLOC3hQO8GUVmCmdqjVncD
 kVaVRVgeOkqXh4Mm654ZerqkbF8bev7Yfka/Xv1zkgEBGUWnRKoXiPMJRN3tDbNWi+Ag5cix/C
 iIJRU5SaasRdfUlLMvyBnNkkuT1AAAA
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
 Richard Henderson <richard.henderson@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705787141; l=837;
 i=thomas@t-8ch.de; s=20221212; h=from:subject:message-id;
 bh=VHbKu6UCe0NttHrFFX9ITBcfvJ1sraAsfNyNRV3siB0=;
 b=pgb4vGnMaKZpbTv9y9vzmSsi0IUNSjkwysvivkYsWzKCRmvqJ5slg+Uo6mWdJ4Yl3J+EI1VAL
 xgUHueTz89WDrwIUh0la4Gjnw3k+/3CwMU5c6CmlqGDE5wrgSG+G+52
X-Developer-Key: i=thomas@t-8ch.de; a=ed25519;
 pk=KcycQgFPX2wGR5azS7RhpBqedglOZVgRPfdFSPB1LNw=
Received-SPF: pass client-ip=159.69.126.157; envelope-from=thomas@t-8ch.de;
 helo=todd.t-8ch.de
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
Changes in v3:
- Add braces to if statements
- Add Reviewed-by from Richard
- Link to v2: https://lore.kernel.org/r/20240107-qemu-user-dumpable-v2-0-54e3bcfc00c9@t-8ch.de

Changes in v2:
- Rebase on 8.2 master
- Resend after closed tree and holidays
- Link to v1: https://lore.kernel.org/r/20231115-qemu-user-dumpable-v1-0-edbe7f0fbb02@t-8ch.de

---
Thomas Weißschuh (2):
      linux-user/elfload: test return value of getrlimit
      linux-user/elfload: check PR_GET_DUMPABLE before creating coredump

 linux-user/elfload.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)
---
base-commit: 3f2a357b95845ea0bf7463eff6661e43b97d1afc
change-id: 20231115-qemu-user-dumpable-d499c0396103

Best regards,
-- 
Thomas Weißschuh <thomas@t-8ch.de>


