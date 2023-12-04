Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DE80368D
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 15:27:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rA9tG-0000ix-9c; Mon, 04 Dec 2023 09:25:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9tE-0000iS-7h
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:25:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1rA9tC-0003I6-FT
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 09:25:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701699937;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HYv2SIXJPtw7/LHW2gjfuxRnEMPbXSjUGOtXXAYkOeQ=;
 b=JjP1h2H3Qo5avEthFCXINQyiZrTMqcbJyVO4F1LIAmBZizvy24UxVIIE8u3gPHfS3JYdgq
 GDtHp+Ld/9lPHXAtvKwk/FgYbYdavpWSwGM5hQ8bVLRkP1RIKChLcmcN7H4r63iSdS55IA
 E8oVVq53QktVd8qFPj3Wvd+3j+GobM0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-9luKiccSOK6oLhVDtl3gwQ-1; Mon, 04 Dec 2023 09:25:36 -0500
X-MC-Unique: 9luKiccSOK6oLhVDtl3gwQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CCBED185A781
 for <qemu-devel@nongnu.org>; Mon,  4 Dec 2023 14:25:35 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0D3212166B26;
 Mon,  4 Dec 2023 14:25:34 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 1/3] tests/qemu-iotests/149: Use more inclusive language in
 this test
Date: Mon,  4 Dec 2023 15:25:30 +0100
Message-ID: <20231204142532.581730-2-thuth@redhat.com>
In-Reply-To: <20231204142532.581730-1-thuth@redhat.com>
References: <20231204142532.581730-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Let's use 'unsupported_configs' and 'tested_configs' here
instead of non-inclusive words.

Message-ID: <20231122084000.809696-1-thuth@redhat.com>
Reviewed-by: "Daniel P. Berrangé" <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 tests/qemu-iotests/149     | 16 +++++++++-------
 tests/qemu-iotests/149.out |  8 ++++----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/tests/qemu-iotests/149 b/tests/qemu-iotests/149
index 2ae318f16f..c13343d7ef 100755
--- a/tests/qemu-iotests/149
+++ b/tests/qemu-iotests/149
@@ -518,7 +518,7 @@ configs = [
 
 ]
 
-blacklist = [
+unsupported_configs = [
     # We don't have a cast-6 cipher impl for QEMU yet
     "cast6-256-xts-plain64-sha1",
     "cast6-128-xts-plain64-sha1",
@@ -528,17 +528,19 @@ blacklist = [
     "twofish-192-xts-plain64-sha1",
 ]
 
-whitelist = []
+# Optionally test only the configurations in the LUKS_CONFIG
+# environment variable
+tested_configs = None
 if "LUKS_CONFIG" in os.environ:
-    whitelist = os.environ["LUKS_CONFIG"].split(",")
+    tested_configs = os.environ["LUKS_CONFIG"].split(",")
 
 for config in configs:
-    if config.name in blacklist:
-        iotests.log("Skipping %s in blacklist" % config.name)
+    if config.name in unsupported_configs:
+        iotests.log("Skipping %s (config not supported)" % config.name)
         continue
 
-    if len(whitelist) > 0 and config.name not in whitelist:
-        iotests.log("Skipping %s not in whitelist" % config.name)
+    if tested_configs is not None and config.name not in tested_configs:
+        iotests.log("Skipping %s (by user request)" % config.name)
         continue
 
     test_once(config, qemu_img=False)
diff --git a/tests/qemu-iotests/149.out b/tests/qemu-iotests/149.out
index 2cc5b82f7c..72ca847159 100644
--- a/tests/qemu-iotests/149.out
+++ b/tests/qemu-iotests/149.out
@@ -470,7 +470,7 @@ sudo cryptsetup -q -v luksClose qiotest-145-cast5-128-cbc-plain64-sha1
 # Delete image
 unlink TEST_DIR/luks-cast5-128-cbc-plain64-sha1.img
 
-Skipping cast6-256-xts-plain64-sha1 in blacklist
+Skipping cast6-256-xts-plain64-sha1 (config not supported)
 # ================= dm-crypt aes-256-cbc-plain-sha1 =================
 # Create image
 truncate TEST_DIR/luks-aes-256-cbc-plain-sha1.img --size 4194304MB
@@ -1297,7 +1297,7 @@ sudo cryptsetup -q -v luksClose qiotest-145-twofish-128-xts-plain64-sha1
 # Delete image
 unlink TEST_DIR/luks-twofish-128-xts-plain64-sha1.img
 
-Skipping twofish-192-xts-plain64-sha1 in blacklist
+Skipping twofish-192-xts-plain64-sha1 (config not supported)
 # ================= dm-crypt serpent-128-xts-plain64-sha1 =================
 # Create image
 truncate TEST_DIR/luks-serpent-128-xts-plain64-sha1.img --size 4194304MB
@@ -1534,8 +1534,8 @@ sudo cryptsetup -q -v luksClose qiotest-145-serpent-192-xts-plain64-sha1
 # Delete image
 unlink TEST_DIR/luks-serpent-192-xts-plain64-sha1.img
 
-Skipping cast6-128-xts-plain64-sha1 in blacklist
-Skipping cast6-192-xts-plain64-sha1 in blacklist
+Skipping cast6-128-xts-plain64-sha1 (config not supported)
+Skipping cast6-192-xts-plain64-sha1 (config not supported)
 # ================= dm-crypt aes-256-xts-plain64-sha224 =================
 # Create image
 truncate TEST_DIR/luks-aes-256-xts-plain64-sha224.img --size 4194304MB
-- 
2.42.0


