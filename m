Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C14AB37C51
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Aug 2025 09:56:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urB04-0005IH-0c; Wed, 27 Aug 2025 03:55:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB02-0005Hm-75
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1urB00-0001ws-2j
 for qemu-devel@nongnu.org; Wed, 27 Aug 2025 03:55:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756281314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dxJQpFbbYeRuHliRU7B9j87TQVdGAHwNZ/OGelceeqA=;
 b=HUbxTDgU2K9S1UaIrsvxrEmLD3xsjUlVPbTba/LFvHYm0TFsv/ZSsS42dRTjiS0x/S1BXv
 ALfPuL7gc3jBSVOSJMWokfbFSOQzk29lG5/SR3OwImse8XXrA6SNKCCDxqJtIMz5h9cW1S
 02X8KzkK1XEkiu9l3fOE01h6Un7ARUY=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-gzTC59JCNXym-dykcLn9JA-1; Wed,
 27 Aug 2025 03:55:10 -0400
X-MC-Unique: gzTC59JCNXym-dykcLn9JA-1
X-Mimecast-MFC-AGG-ID: gzTC59JCNXym-dykcLn9JA_1756281309
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4689819560A2; Wed, 27 Aug 2025 07:55:09 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.40])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 808B41955F24; Wed, 27 Aug 2025 07:55:05 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 05/31] tests/functional: Use more fine-grained locking when
 looking for free ports
Date: Wed, 27 Aug 2025 09:54:15 +0200
Message-ID: <20250827075443.559712-6-thuth@redhat.com>
In-Reply-To: <20250827075443.559712-1-thuth@redhat.com>
References: <20250827075443.559712-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Thomas Huth <thuth@redhat.com>

Currently, we have one lock that is held while a test is looking for
free ports. However, we are also using different ranges for looking
for free ports nowadays (PORTS_START is based on the PID of the process),
so instead of using only one lock, we should rather use a lock per
range instead. This should help to allow running more tests in parallel.

While we're at it, also create the lock files without executable bit
(mode is 0o777 by default).

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
Message-ID: <20250821094735.804210-1-thuth@redhat.com>
---
 tests/functional/qemu_test/ports.py | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tests/functional/qemu_test/ports.py b/tests/functional/qemu_test/ports.py
index 631b77abf6b..81174a61532 100644
--- a/tests/functional/qemu_test/ports.py
+++ b/tests/functional/qemu_test/ports.py
@@ -23,8 +23,9 @@ class Ports():
     PORTS_END = PORTS_START + PORTS_RANGE_SIZE
 
     def __enter__(self):
-        lock_file = os.path.join(BUILD_DIR, "tests", "functional", "port_lock")
-        self.lock_fh = os.open(lock_file, os.O_CREAT)
+        lock_file = os.path.join(BUILD_DIR, "tests", "functional",
+                                 f".port_lock.{self.PORTS_START}")
+        self.lock_fh = os.open(lock_file, os.O_CREAT, mode=0o666)
         fcntl.flock(self.lock_fh, fcntl.LOCK_EX)
         return self
 
-- 
2.50.1


