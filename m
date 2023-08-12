Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D5777A002
	for <lists+qemu-devel@lfdr.de>; Sat, 12 Aug 2023 14:49:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUo2Z-0001SO-Sz; Sat, 12 Aug 2023 08:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUo2V-0001Rx-6d
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:48:19 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUo2T-0005m1-CZ
 for qemu-devel@nongnu.org; Sat, 12 Aug 2023 08:48:18 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 7505D19FAB
 for <qemu-devel@nongnu.org>; Sat, 12 Aug 2023 15:48:17 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id AADAD1DF67;
 Sat, 12 Aug 2023 15:48:06 +0300 (MSK)
Received: (nullmailer pid 2881129 invoked by uid 1000);
 Sat, 12 Aug 2023 12:48:06 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>
Subject: [PATCH RFC 1/7] include/sysemu/os-posix.h: move *daemonize*
 declaration together
Date: Sat, 12 Aug 2023 15:47:55 +0300
Message-Id: <2321b2404d3bc9b12ac1605dd59b221f61e294b8.1691843673.git.mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1691843673.git.mjt@tls.msk.ru>
References: <cover.1691843673.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/sysemu/os-posix.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
index 1030d39904..65b9c94e91 100644
--- a/include/sysemu/os-posix.h
+++ b/include/sysemu/os-posix.h
@@ -47,13 +47,12 @@ void os_set_line_buffering(void);
 void os_setup_early_signal_handling(void);
 void os_set_proc_name(const char *s);
 void os_setup_signal_handling(void);
+int os_set_daemonize(bool d);
+bool is_daemonized(void);
 void os_daemonize(void);
 void os_setup_post(void);
 int os_mlock(void);
 
-int os_set_daemonize(bool d);
-bool is_daemonized(void);
-
 /**
  * qemu_alloc_stack:
  * @sz: pointer to a size_t holding the requested usable stack size
-- 
2.39.2


