Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B54F8AA170
	for <lists+qemu-devel@lfdr.de>; Thu, 18 Apr 2024 19:51:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxVur-0001X8-UR; Thu, 18 Apr 2024 13:51:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuk-0001SB-UG; Thu, 18 Apr 2024 13:51:15 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1rxVuj-0007eV-7C; Thu, 18 Apr 2024 13:51:14 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A28ED5FD72;
 Thu, 18 Apr 2024 20:50:03 +0300 (MSK)
Received: from tls.msk.ru (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with SMTP id 10D1AB934C;
 Thu, 18 Apr 2024 20:50:01 +0300 (MSK)
Received: (nullmailer pid 947857 invoked by uid 1000);
 Thu, 18 Apr 2024 17:49:55 -0000
From: Michael Tokarev <mjt@tls.msk.ru>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zheyu Ma <zheyuma97@gmail.com>, zhenwei pi <pizhenwei@bytedance.com>,
 Michael Tokarev <mjt@tls.msk.ru>
Subject: [Stable-8.2.3 105/116] backends/cryptodev: Do not abort for invalid
 session ID
Date: Thu, 18 Apr 2024 20:49:35 +0300
Message-Id: <20240418174955.947730-18-mjt@tls.msk.ru>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
References: <qemu-stable-8.2.3-20240418204921@cover.tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Instead of aborting when a session ID is invalid,
return VIRTIO_CRYPTO_INVSESS ("Invalid session id").

Reproduced using:

  $ cat << EOF | qemu-system-i386 -display none \
     -machine q35,accel=qtest -m 512M -nodefaults \
     -object cryptodev-backend-builtin,id=cryptodev0 \
     -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
     -qtest stdio
  outl 0xcf8 0x80000804
  outw 0xcfc 0x06
  outl 0xcf8 0x80000820
  outl 0xcfc 0xe0008000
  write 0x10800e 0x1 0x01
  write 0xe0008016 0x1 0x01
  write 0xe0008020 0x4 0x00801000
  write 0xe0008028 0x4 0x00c01000
  write 0xe000801c 0x1 0x01
  write 0x110000 0x1 0x05
  write 0x110001 0x1 0x04
  write 0x108002 0x1 0x11
  write 0x108008 0x1 0x48
  write 0x10800c 0x1 0x01
  write 0x108018 0x1 0x10
  write 0x10801c 0x1 0x02
  write 0x10c002 0x1 0x01
  write 0xe000b005 0x1 0x00
  EOF
  Assertion failed: (session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]),
  function cryptodev_builtin_close_session, file cryptodev-builtin.c, line 430.

Cc: qemu-stable@nongnu.org
Reported-by: Zheyu Ma <zheyuma97@gmail.com>
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2274
Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Reviewed-by: zhenwei pi <pizhenwei@bytedance.com>
Message-Id: <20240409094757.9127-1-philmd@linaro.org>
(cherry picked from commit eaf2bd29538d039df80bb4b1584de33a61312bc6)
Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

diff --git a/backends/cryptodev-builtin.c b/backends/cryptodev-builtin.c
index 39d0455280..a514bbb310 100644
--- a/backends/cryptodev-builtin.c
+++ b/backends/cryptodev-builtin.c
@@ -427,7 +427,9 @@ static int cryptodev_builtin_close_session(
                       CRYPTODEV_BACKEND_BUILTIN(backend);
     CryptoDevBackendBuiltinSession *session;
 
-    assert(session_id < MAX_NUM_SESSIONS && builtin->sessions[session_id]);
+    if (session_id >= MAX_NUM_SESSIONS || !builtin->sessions[session_id]) {
+        return -VIRTIO_CRYPTO_INVSESS;
+    }
 
     session = builtin->sessions[session_id];
     if (session->cipher) {
-- 
2.39.2


