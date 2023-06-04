Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A53C72174E
	for <lists+qemu-devel@lfdr.de>; Sun,  4 Jun 2023 15:17:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q5nZg-0004vv-V9; Sun, 04 Jun 2023 09:15:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZd-0004vM-HP
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:10 -0400
Received: from mail.ilande.co.uk ([2001:41c9:1:41f::167])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZc-00039K-2A
 for qemu-devel@nongnu.org; Sun, 04 Jun 2023 09:15:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=ilande.co.uk; s=20220518; h=Subject:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:Reply-To:
 Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MJBJHbWsV58rgXcVZCGJHmGb2yKop8kK0XAJfFHj7cA=; b=VFyOkleTUr+jLdfpuD49tELPmb
 ipuqUIIHc5yLVt9S+vu44pjNNhjIka24qtuevg10gE8OAaGgvp/MgtYBQutbXDdYkga6grUAKGBvQ
 hl/j2zYgSO4nN7cdTsFecchsu26I3mRFowcbOUjnJNttAnu0zdrA+49+4Ujk4EBtzMzOQYGWQV+0S
 OA4kSTGtenmD4IC2jvNPWR8zYy00QTaQeZ4WIQJ/T2N5V66wGnIaz3OMZl0nUG+1nUS7Ie0hFsiWe
 geaYqbic5kO34qTflX7uQmCU8vaaPU1W3Mmp/b35S6gA+55uHLGCFnftotdAbTPEFktfg9lm5L/yB
 FupegbPWLGzpNtUjOXpdy5M2QB3pRDKTRQPAHGqbSlwRPLebsyEznuttuq8IaV5gfLLZKN8KKLeoI
 v14kNPQfe8Fu/rdAsA2uiksHdFnW6ZFt0Nd5wdlU9XPPS0eXQYNK4vNX/F4vNByYHtsi7aFlX11lz
 JU+D2zSGRWfPVV7dgw7FNc9lZeI1f8ZohjjN/sWU7r6VC9r7Qe0AF3lIKXe3GbJ9pgsEEbVCkopRR
 X4WsxZNMEAcIBgFalzIB8C97ehaKZpN9Xumgnn0R/p4kvM2dfJ8OFksoqVQMVJxcqE3Y3u78J33MZ
 YDKMq1BexqYvcTVNXSFN59xDh9TPKZj42E6KJhBuE=;
Received: from [2a00:23c4:8bac:6900:b726:cf58:4c12:f013] (helo=kentang.home)
 by mail.ilande.co.uk with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <mark.cave-ayland@ilande.co.uk>)
 id 1q5nZQ-0005pb-5d; Sun, 04 Jun 2023 14:15:00 +0100
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
To: laurent@vivier.eu,
	qemu-devel@nongnu.org
Date: Sun,  4 Jun 2023 14:14:29 +0100
Message-Id: <20230604131450.428797-3-mark.cave-ayland@ilande.co.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
References: <20230604131450.428797-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a00:23c4:8bac:6900:b726:cf58:4c12:f013
X-SA-Exim-Mail-From: mark.cave-ayland@ilande.co.uk
Subject: [PATCH v3 02/23] q800: add missing space after parent object in
 GLUEState
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

This brings GLUEState in line with our current QOM guidelines.

Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/m68k/q800.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/m68k/q800.c b/hw/m68k/q800.c
index 1aead224e2..bb9e857632 100644
--- a/hw/m68k/q800.c
+++ b/hw/m68k/q800.c
@@ -100,6 +100,7 @@ OBJECT_DECLARE_SIMPLE_TYPE(GLUEState, GLUE)
 
 struct GLUEState {
     SysBusDevice parent_obj;
+
     M68kCPU *cpu;
     uint8_t ipr;
     uint8_t auxmode;
-- 
2.30.2


