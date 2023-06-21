Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC59737DE7
	for <lists+qemu-devel@lfdr.de>; Wed, 21 Jun 2023 10:56:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBtbo-0001xq-4f; Wed, 21 Jun 2023 04:54:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbl-0001x9-Hs
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:33 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbk-0004Af-5v
 for qemu-devel@nongnu.org; Wed, 21 Jun 2023 04:54:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:Cc:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dGA6TvJ9RkMAIMqnKUXOKS5DXTkn63/tgtvw4J7l2B8=; b=LLTMff4KAnEOcuWxpnz0/fBXq/
 bjvqZQOHiDegqFKKL2jkY0YAKOr/R83gAt15wFeIOjjY03APGlMVj01e/ghkt34jPSfM8C/PlM6NQ
 wfO6ARopTy0W7M8P505ibCq1rOtusUunWGZpM8zEBL6dikohBLC6mL/nCRD5WtHuMKdBgjaUpObBa
 3brd2WuPQRlImrWdkHyUVr4PdiJw7l+Dmr0f1FHXVMWS/KEMPPyuI7YrniMip5nllOsYlGf2cnSeb
 p5kxlAu7AgN9DwBlBNBoES4XM+fozEw2YsC+L09GDUi5Z3GkhGO23j0oq2BX0veBzKlBKoOBz9/3H
 nje/X6Vfnwd8DFA1fFjmR5EEJhujQ+E0bIBp6DWqtO4MCsw11WQQf1C4RgA5+MY1wFKbzpMETGanY
 74yYaIJMKoj9C3LAxILlAIpoQYnRpgZjJXvIuCGB8g+E2rWq9YmvrlEhA+p4PbCFOQS9yrpL/uy6C
 oE332/NIdlS3c/CABu4x3wDh6ns0VXoNx6Z6cy32ZhqmsHjfJrbtyHjhBtWka09OeI3sykTS6/uK3
 hgM+95puQEhwcgSJT6rSYmQMevACKuJu4YWOIAp8ryqToGVc+H3qLspJ0scXvsA6g+Se5zqg6mcGz
 v6nNoOzvnOkqrG339KkiEfMS0+f1K/k3P42lmxqgo=;
Received: from host86-130-37-216.range86-130.btcentralplus.com
 ([86.130.37.216] helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1qBtbc-0001ZB-Hp; Wed, 21 Jun 2023 09:54:24 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Wed, 21 Jun 2023 09:53:37 +0100
Message-Id: <20230621085353.113233-9-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
References: <20230621085353.113233-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 86.130.37.216
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v4 08/24] q800-glue.c: switch TypeInfo registration to use
 DEFINE_TYPES() macro
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

The use of the DEFINE_TYPES() macro will soon be recommended over the use of
calling type_init() directly.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
---
 hw/m68k/q800-glue.c | 29 +++++++++++++----------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/hw/m68k/q800-glue.c b/hw/m68k/q800-glue.c
index e81f9438f1..34c4f0e987 100644
--- a/hw/m68k/q800-glue.c
+++ b/hw/m68k/q800-glue.c
@@ -231,22 +231,19 @@ static void glue_class_init(ObjectClass *klass, void *data)
     nc->nmi_monitor_handler = glue_nmi;
 }
 
-static const TypeInfo glue_info = {
-    .name = TYPE_GLUE,
-    .parent = TYPE_SYS_BUS_DEVICE,
-    .instance_size = sizeof(GLUEState),
-    .instance_init = glue_init,
-    .instance_finalize = glue_finalize,
-    .class_init = glue_class_init,
-    .interfaces = (InterfaceInfo[]) {
-         { TYPE_NMI },
-         { }
+static const TypeInfo glue_info_types[] = {
+    {
+        .name = TYPE_GLUE,
+        .parent = TYPE_SYS_BUS_DEVICE,
+        .instance_size = sizeof(GLUEState),
+        .instance_init = glue_init,
+        .instance_finalize = glue_finalize,
+        .class_init = glue_class_init,
+        .interfaces = (InterfaceInfo[]) {
+             { TYPE_NMI },
+             { }
+        },
     },
 };
 
-static void glue_register_types(void)
-{
-    type_register_static(&glue_info);
-}
-
-type_init(glue_register_types)
+DEFINE_TYPES(glue_info_types)
-- 
2.30.2


