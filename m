Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FBC87BE9F7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 20:44:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpvEH-0007fY-Ep; Mon, 09 Oct 2023 14:43:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEF-0007ey-NY
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qpvEE-0000mq-7N
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 14:43:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 259421F390;
 Mon,  9 Oct 2023 18:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1696877021; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsCvIjXfKnHMN1cb/Cl4zVpz7bH5qr8lGFAlyAjW/ko=;
 b=y4mVEF8UwZ4UrnE5JBIMv7Ey5MzzQqXGGjzJQeja49O8EcwI2oEXc6dqYXOZCT48v+bmlk
 uBS3nwtEdFyzKPpTlFlXekVWSRUoFC5jy9laQAaMmhoMTjtfYP08hPLVyQXcb4Uz+naTjT
 z5wPpkaP4pxHKyph/Shcwe+/knBh/BA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1696877021;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QsCvIjXfKnHMN1cb/Cl4zVpz7bH5qr8lGFAlyAjW/ko=;
 b=0LrTRAQjub196bfCk3ItNiXgn6EmsOtr0f3MzlL3QtbqUFd81uSkepJ8QSxOjMUV/V6dyB
 z+JbA6knmbISRsBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F423313586;
 Mon,  9 Oct 2023 18:43:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id MHMKL9pJJGWFEgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 09 Oct 2023 18:43:38 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>, John Snow <jsnow@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Subject: [PATCH v2 4/6] migration: Fix analyze-migration.py when ignore-shared
 is used
Date: Mon,  9 Oct 2023 15:43:24 -0300
Message-Id: <20231009184326.15777-5-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231009184326.15777-1-farosas@suse.de>
References: <20231009184326.15777-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

The script is currently broken when the x-ignore-shared capability is
used:

Traceback (most recent call last):
  File "./scripts/analyze-migration.py", line 656, in <module>
    dump.read(dump_memory = args.memory)
  File "./scripts/analyze-migration.py", line 593, in read
    section.read()
  File "./scripts/analyze-migration.py", line 163, in read
    self.name = self.file.readstr(len = namelen)
  File "./scripts/analyze-migration.py", line 53, in readstr
    return self.readvar(len).decode('utf-8')
UnicodeDecodeError: 'utf-8' codec can't decode byte 0x82 in position 55: invalid start byte

We're currently adding data to the middle of the ram section depending
on the presence of the capability. As a consequence, any code loading
the ram section needs to know about capabilities so it can interpret
the stream.

Skip the byte that's added when x-ignore-shared is used to fix the
script.

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index c700fed64d..56ab04dd2d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -123,6 +123,7 @@ def __init__(self, file, version_id, ramargs, section_key):
         self.TARGET_PAGE_SIZE = ramargs['page_size']
         self.dump_memory = ramargs['dump_memory']
         self.write_memory = ramargs['write_memory']
+        self.ignore_shared = ramargs['ignore_shared']
         self.sizeinfo = collections.OrderedDict()
         self.data = collections.OrderedDict()
         self.data['section sizes'] = self.sizeinfo
@@ -169,6 +170,8 @@ def read(self):
                         f.truncate(0)
                         f.truncate(len)
                         self.files[self.name] = f
+                    if self.ignore_shared:
+                        mr_addr = self.file.read64()
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
             if flags & self.RAM_SAVE_FLAG_COMPRESS:
@@ -572,6 +575,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
         ramargs['page_size'] = self.vmsd_desc['page_size']
         ramargs['dump_memory'] = dump_memory
         ramargs['write_memory'] = write_memory
+        ramargs['ignore_shared'] = False
         self.section_classes[('ram',0)][1] = ramargs
 
         while True:
@@ -582,6 +586,7 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
                 config_desc = self.vmsd_desc.get('configuration')
                 section = ConfigurationSection(file, config_desc)
                 section.read()
+                ramargs['ignore_shared'] = section.has_capability('x-ignore-shared')
             elif section_type == self.QEMU_VM_SECTION_START or section_type == self.QEMU_VM_SECTION_FULL:
                 section_id = file.read32()
                 name = file.readstr()
-- 
2.35.3


