Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B0D9572A2A1
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 20:53:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7hDE-00010Y-Lx; Fri, 09 Jun 2023 14:51:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hDC-000106-CB; Fri, 09 Jun 2023 14:51:50 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hDA-0002uX-Vv; Fri, 09 Jun 2023 14:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k5+VVrnWZpXPXGUGnpL17cwo8bJr6WXkTyeLJYavsoo=; b=uLFAf1Dbvl/qSfl6Gp+uuXW4G1
 3oL76T/7SJOTg1awHj8DFIlIOOVDZ8YTPVwZCXNpCY2fRDpYcjb2llhiSST6PRd5KEvseGPBLKELT
 lYysWGBJRPOq+KRjiq5gIGr1yRW/oc5V470SozPYTMOcvXkiaPJEhUQlqy1ygSA0ZnGWN8b4gtIX5
 YFJ+dnke46VGfUh+CuZufJQiB3je2w43zI4M5cfN4sq9RoIW4PcuAN/leJThKR0VCbQXRDYSEljOO
 +ZeP10Z1osjFArSK8No9Q2hJ9yZcaHQuVL0U/93l0K7U3felUgCd8uGb/mnoVaN9bEb/Jk0UXycBU
 epa/WgEIUd7h5iYgA+ZeB69XWZp5dGgQTu2xPfD5tLLQlYhGbThz3KTtAUnoJkHaoB6Xwno19rGmU
 olYv3lH2Y/El4EU39y35bnl3ElXUHzOlez39lRLiLw4JdQu/i9qfQE0+TnqvAT55/LNGITs2h2Cgc
 fTffhrzqr3arusyfZpZwUoxuEFXndfABTCTGt5UjloW4nNqZ95vKaVfDB6F/5C+XOgsii8TBgKuJF
 uiyV2hNDgxVd5Mkpwq44j2tm4VvLlnTtlMDk4SU4CY40F8jSCe5hlFj0WNULx0xuZI3NLySfwa3kk
 exKOtpXaRVuJqDE12PqvEm2z2I4YNlkpNLwXD1L+4=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q7hD2-0000p5-LW; Fri, 09 Jun 2023 19:51:44 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: jsnow@redhat.com, shentey@gmail.com, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Date: Fri,  9 Jun 2023 19:51:18 +0100
Message-Id: <20230609185119.691152-5-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
References: <20230609185119.691152-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH 4/5] cmd646: rename cmd646_bmdma_ops to bmdma_ops
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on mail.ilande.co.uk)
Received-SPF: pass client-ip=2001:41c9:1:41f::167;
 envelope-from=mark.cave-ayland@ilande.co.uk; helo=mail.ilande.co.uk
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

This is to allow us to use the cmd646_bmdma_ops name for the CMD646
device-specific registers in the next commit.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/ide/cmd646.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ide/cmd646.c b/hw/ide/cmd646.c
index a3e227fba7..9103da581f 100644
--- a/hw/ide/cmd646.c
+++ b/hw/ide/cmd646.c
@@ -158,7 +158,7 @@ static void bmdma_write(void *opaque, hwaddr addr,
     }
 }
 
-static const MemoryRegionOps cmd646_bmdma_ops = {
+static const MemoryRegionOps bmdma_ops = {
     .read = bmdma_read,
     .write = bmdma_write,
 };
@@ -171,7 +171,7 @@ static void bmdma_setup_bar(PCIIDEState *d)
     memory_region_init(&d->bmdma_bar, OBJECT(d), "cmd646-bmdma", 16);
     for (i = 0; i < 2; i++) {
         bm = &d->bmdma[i];
-        memory_region_init_io(&bm->extra_io, OBJECT(d), &cmd646_bmdma_ops, bm,
+        memory_region_init_io(&bm->extra_io, OBJECT(d), &bmdma_ops, bm,
                               "cmd646-bmdma-bus", 4);
         memory_region_add_subregion(&d->bmdma_bar, i * 8, &bm->extra_io);
         memory_region_init_io(&bm->addr_ioport, OBJECT(d),
-- 
2.30.2


