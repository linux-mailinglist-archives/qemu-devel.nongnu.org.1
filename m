Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92EE07AE7E6
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 10:19:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql3H9-0007im-9X; Tue, 26 Sep 2023 04:18:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ql3H6-0007hZ-Ge
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:18:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1ql3H1-0001vp-DH
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 04:18:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695716306;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6Wzw4SQfPxs/XjxkrnqaSx2l/A7EaKVMLJSpj6tRTPM=;
 b=aqjslhBllQ/65dH9Yon7pdbQGmWSkvCUqilifLib6hwpgFeEXBUIe5ubHiZEqsxeeakscN
 jh0cUAGxLSLOMqRMf46RA1EjJoqCCOwJRAqnOcBlBpgQet7xX+LRxkP8CAFMZkpIkBXuiu
 v65Tcn6Ro+RMlk/FoBxNlOca7KMO1yg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-350-WhZaskeeOCiAuq_aw6RJZA-1; Tue, 26 Sep 2023 04:18:23 -0400
X-MC-Unique: WhZaskeeOCiAuq_aw6RJZA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5F037185A790
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 08:18:23 +0000 (UTC)
Received: from localhost (unknown [10.39.208.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 726EAC158BA;
 Tue, 26 Sep 2023 08:18:22 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 John Snow <jsnow@redhat.com>, Cleber Rosa <crosa@redhat.com>
Subject: [PATCH] analyze-migration: ignore RAM_SAVE_FLAG_MULTIFD_FLUSH
Date: Tue, 26 Sep 2023 12:18:19 +0400
Message-ID: <20230926081819.433631-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Traceback (most recent call last):
  File "scripts/analyze-migration.py", line 605, in <module>
    dump.read(dump_memory = args.memory)
  File "scripts/analyze-migration.py", line 542, in read
    section.read()
  File "scripts/analyze-migration.py", line 214, in read
    raise Exception("Unknown RAM flags: %x" % flags)
Exception: Unknown RAM flags: 200

See commit 77c259a4cb ("multifd: Create property multifd-flush-after-each-section")

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 scripts/analyze-migration.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index b82a1b0c58..082424558b 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -111,6 +111,8 @@ class RamSection(object):
     RAM_SAVE_FLAG_CONTINUE = 0x20
     RAM_SAVE_FLAG_XBZRLE   = 0x40
     RAM_SAVE_FLAG_HOOK     = 0x80
+    RAM_SAVE_FLAG_COMPRESS_PAGE = 0x100
+    RAM_SAVE_FLAG_MULTIFD_FLUSH = 0x200
 
     def __init__(self, file, version_id, ramargs, section_key):
         if version_id != 4:
@@ -205,6 +207,8 @@ def read(self):
                 raise Exception("XBZRLE RAM compression is not supported yet")
             elif flags & self.RAM_SAVE_FLAG_HOOK:
                 raise Exception("RAM hooks don't make sense with files")
+            if flags & self.RAM_SAVE_FLAG_MULTIFD_FLUSH:
+                continue
 
             # End of RAM section
             if flags & self.RAM_SAVE_FLAG_EOS:
-- 
2.41.0


