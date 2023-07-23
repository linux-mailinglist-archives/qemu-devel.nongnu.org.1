Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 85B5675E523
	for <lists+qemu-devel@lfdr.de>; Sun, 23 Jul 2023 23:59:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNh5f-0004r3-Jo; Sun, 23 Jul 2023 17:58:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <4strangepeople@gmail.com>)
 id 1qNgFL-0007U5-LJ
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 17:04:07 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <4strangepeople@gmail.com>)
 id 1qNgFK-00014M-09
 for qemu-devel@nongnu.org; Sun, 23 Jul 2023 17:04:07 -0400
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-31757edd9edso354818f8f.2
 for <qemu-devel@nongnu.org>; Sun, 23 Jul 2023 14:04:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690146243; x=1690751043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DFv8PboMD59YwLs+wHdPDanYAqXjRATO16wSPfSHkHc=;
 b=bPOcMN1NdIQvWZOJ6NR6j4rf1ONanCc5C1IHn6m4RP1afeKf+RYPuFnho7amGQuZm2
 WngKcksxU+7tTqzS+AnFehfx6tT1V7VArlvTQVjEb1GU19G8MBbA7gDokiHG65f9sD8q
 engd6LcTnZrLaVbBhmDRjoA1/pf7lPqHbPYpVOfg1Boza63Kzunsf5brwtE7P1ZjQM8h
 RLJEU3AGP0pY/18Y0Rz3q6/+qYBJswsitc03i4TaWvUJbWuhyvMwoWEG/nFgaiv4m3gd
 S058DDKSNY5OvIvrnJOGaueGv+OO7qZeDe1Mtg+65PXiNNZ7O0SrObuwXK9zmuwFCgYL
 HcIg==
X-Gm-Message-State: ABy/qLbWcieX4jonRwuMkfZqvo7sy+7jQ61CB02Z0JIzS8jQdibUMzvt
 YNkXiTe+PST5Boq2Wj+1HZ0XvRiL6OE=
X-Google-Smtp-Source: APBJJlH+EK+BIln1QofaCdhqX5OYCOc3i/aVEjRlCLCgRIsmPlTxAzPBvfv837A0OqZTsNmscmUMHA==
X-Received: by 2002:a7b:ce98:0:b0:3fb:ba04:6d5d with SMTP id
 q24-20020a7bce98000000b003fbba046d5dmr4817588wmj.12.1690146243302; 
 Sun, 23 Jul 2023 14:04:03 -0700 (PDT)
Received: from kotebook.zasenko.name ([91.123.151.221])
 by smtp.gmail.com with ESMTPSA id
 s19-20020a1cf213000000b003fbaade072dsm8410243wmc.23.2023.07.23.14.04.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Jul 2023 14:04:02 -0700 (PDT)
From: Sergii Zasenko <sergii@zasenko.name>
To: qemu-devel@nongnu.org
Cc: Sergii Zasenko <sergii@zasenko.name>
Subject: [PATCH] Allow UNIX socket for VNC websocket
Date: Mon, 24 Jul 2023 00:03:56 +0300
Message-Id: <20230723210355.28717-1-sergii@zasenko.name>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.53;
 envelope-from=4strangepeople@gmail.com; helo=mail-wr1-f53.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sun, 23 Jul 2023 17:58:07 -0400
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

Signed-off-by: Sergii Zasenko <sergii@zasenko.name>
---
 ui/vnc.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/ui/vnc.c b/ui/vnc.c
index 92964dc..dea1414 100644
--- a/ui/vnc.c
+++ b/ui/vnc.c
@@ -3715,11 +3715,6 @@ static int vnc_display_get_address(const char *addrstr,
         addr->type = SOCKET_ADDRESS_TYPE_UNIX;
         addr->u.q_unix.path = g_strdup(addrstr + 5);
 
-        if (websocket) {
-            error_setg(errp, "UNIX sockets not supported with websock");
-            goto cleanup;
-        }
-
         if (to) {
             error_setg(errp, "Port range not support with UNIX socket");
             goto cleanup;
-- 
2.39.2


