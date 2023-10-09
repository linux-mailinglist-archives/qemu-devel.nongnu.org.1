Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C806F7BE9F6
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:44:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvEL-0007gn-6u; Mon, 09 Oct 2023 14:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEI-0007fw-JU
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:46 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEH-0000nL-16
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:46 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B48A81F38D;
 Mon,  9 Oct 2023 18:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877023; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6DtYIBIKXIIAG12wBUaJfL9grCmQLGHkvwNS8pZV40=;
 b=IwXjSk0CfQEshPBl0O1XZRkNed1gibFowilTZ4/jX4Fo/lV/rb8pCEka2aRcxZf1lB8NDx
 AYpZRLD+Gb2pTtuZutYTzJ2zvzv0li4f/tHjy/5+bdLDHvle+Z5sevRu/DwT9VdAEvnXdX
 qP1n8kyKX3u5w+kvozz5G7bG+8H7dKo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877023;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+6DtYIBIKXIIAG12wBUaJfL9grCmQLGHkvwNS8pZV40=;
 b=CaA//KYv/AxzzDnmjRet+h1wICvOqNsnwMyj4AzUGoxLzxBj0wBH5dq5ye7YT8YmT7JZSY
 RR8DVYmG2UvNY8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 8FFAA13586;
 Mon,  9 Oct 2023 18:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QD9HFt1JJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:41 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v2 5/6] migration: Fix analyze-migration read operation
 signedness
Date: Mon,  9 Oct 2023 15:43:25 -0300
Message-Id: <20231009184326.15777-6-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009184326.15777-1-farosas@suse.de>
References: <20231009184326.15777-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The migration code uses unsigned values for 16, 32 and 64-bit
operations. Fix the script to do the same.

This was causing an issue when parsing the migration stream generated
on the ppc64 target because one of instance_ids was larger than the
32bit signed maximum:

Traceback (most recent call last):
  File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 658, in <module>
    dump.read(dump_memory = args.memory)
  File "/home/fabiano/kvm/qemu/build/scripts/analyze-migration.py", line 592, in read
    classdesc = self.section_classes[section_key]
KeyError: ('spapr_iommu', -2147483648)

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 56ab04dd2d..de506cb8bf 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -38,13 +38,13 @@ def __init__(self, filename):
         self.file = open(self.filename, "rb")
 
     def read64(self):
-        return int.from_bytes(self.file.read(8), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(8), byteorder='big', signed=False)
 
     def read32(self):
-        return int.from_bytes(self.file.read(4), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(4), byteorder='big', signed=False)
 
     def read16(self):
-        return int.from_bytes(self.file.read(2), byteorder='big', signed=True)
+        return int.from_bytes(self.file.read(2), byteorder='big', signed=False)
 
     def read8(self):
         return int.from_bytes(self.file.read(1), byteorder='big', signed=True)
-- 
2.35.3


