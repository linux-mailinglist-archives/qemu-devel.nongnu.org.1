Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 02903A22DE4
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Jan 2025 14:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdUhH-0002kg-FK; Thu, 30 Jan 2025 08:35:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUhE-0002hT-8p; Thu, 30 Jan 2025 08:35:04 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tdUhB-0002Xz-6S; Thu, 30 Jan 2025 08:35:03 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0738BE3045;
 Thu, 30 Jan 2025 16:34:19 +0300 (MSK)
Received: from gandalf.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EB4AC1A7F8C;
 Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
Received: by gandalf.tls.msk.ru (Postfix, from userid 1000)
 id D38035240E; Thu, 30 Jan 2025 16:34:47 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-trivial@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 7/7] hw/i386/pc: Remove unused pc_compat_2_3 declarations
Date: Thu, 30 Jan 2025 16:34:47 +0300
Message-Id: <20250130133447.873566-8-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250130133447.873566-1-mjt@tls.msk.ru>
References: <20250130133447.873566-1-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

We removed the implementations in commit 46a2bd52571
("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
but forgot to remove the declarations. Do it now.

Fixes: 46a2bd52571 ("hw/i386/pc: Remove deprecated pc-i440fx-2.3 machine")
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
---
 include/hw/i386/pc.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index a558705cb9..103b54301f 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -302,9 +302,6 @@ extern const size_t pc_compat_2_5_len;
 extern GlobalProperty pc_compat_2_4[];
 extern const size_t pc_compat_2_4_len;
 
-extern GlobalProperty pc_compat_2_3[];
-extern const size_t pc_compat_2_3_len;
-
 #define DEFINE_PC_MACHINE(suffix, namestr, initfn, optsfn) \
     static void pc_machine_##suffix##_class_init(ObjectClass *oc, void *data) \
     { \
-- 
2.39.5


