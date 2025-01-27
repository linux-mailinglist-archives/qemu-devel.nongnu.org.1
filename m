Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA0FA1D834
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Jan 2025 15:24:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPxG-00005n-96; Mon, 27 Jan 2025 09:19:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPxD-0008WK-UN; Mon, 27 Jan 2025 09:19:07 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1tcPxC-0002OZ-4x; Mon, 27 Jan 2025 09:19:07 -0500
Received: from localhost.tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by isrv.corpit.ru (Postfix) with ESMTP id 3CFCCE0E32;
 Mon, 27 Jan 2025 17:18:40 +0300 (MSK)
Received: by localhost.tls.msk.ru (Postfix, from userid 1000)
 id A644851DA3; Mon, 27 Jan 2025 17:18:03 +0300 (MSK)
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>,
 zhenwei pi <pizhenwei@bytedance.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-9.2.1 31/41] backends/cryptodev-vhost-user: Fix local_error
 leaks
Date: Mon, 27 Jan 2025 17:17:45 +0300
Message-Id: <20250127141803.3514882-31-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
References: <qemu-stable-9.2.1-20250127154029@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

From: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>

Do not propagate error to the upper, directly output the error
to avoid leaks.

Fixes: 2fda101de07 ("virtio-crypto: Support asynchronous mode")
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2714
Signed-off-by: Gabriel Barrantes <gabriel.barrantes.dev@outlook.com>
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <DM8PR13MB50781054A4FDACE6F4FB6469B30F2@DM8PR13MB5078.namprd13.prod.outlook.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
(cherry picked from commit 78b0c15a563ac4be5afb0375602ca0a3adc6c442)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev-vhost-user.c b/backends/cryptodev-vhost-user.c
index e33fb78521..bb8b2c29b9 100644
--- a/backends/cryptodev-vhost-user.c
+++ b/backends/cryptodev-vhost-user.c
@@ -281,8 +281,7 @@ static int cryptodev_vhost_user_create_session(
         break;
 
     default:
-        error_setg(&local_error, "Unsupported opcode :%" PRIu32 "",
-                   sess_info->op_code);
+        error_report("Unsupported opcode :%" PRIu32 "", sess_info->op_code);
         return -VIRTIO_CRYPTO_NOTSUPP;
     }
 
-- 
2.39.5


