Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CAB0A0900F
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Jan 2025 13:15:26 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWDua-0001Ud-L0; Fri, 10 Jan 2025 07:14:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuX-0001Tw-7E
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:45 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tWDuU-0003MI-F8
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 07:14:44 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2EC00210F2;
 Fri, 10 Jan 2025 12:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tzeGvdH6vS8A/LD9lQ2r4g2j6uBmkgNsdhpSzn+ovU=;
 b=Y1bQ1buxWNrb9DjLT+iPWudD2j1JiVWVJ/4qC78Tt3fsYAIvEo1GaK5VXS1O9ZYjFJ7IO9
 YtOtkK4PQo/oykDjGfrh0eXgYXB1ZDEqA3yDiXBYvPsN1a7hdnYr1G9ypy1N8krg5Q+mpO
 I5ckBOtHBJisJGdeLqCiA9u9jZs5r4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tzeGvdH6vS8A/LD9lQ2r4g2j6uBmkgNsdhpSzn+ovU=;
 b=k5tiMcYwVBOBEr6OwmYP2TTuUkNBONcXXF75VZ5Gsx3/bvSWH6nWqPljYZ+CWFgiMdPXBd
 bQL8uyr1duyVIRBw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736511281; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tzeGvdH6vS8A/LD9lQ2r4g2j6uBmkgNsdhpSzn+ovU=;
 b=Y1bQ1buxWNrb9DjLT+iPWudD2j1JiVWVJ/4qC78Tt3fsYAIvEo1GaK5VXS1O9ZYjFJ7IO9
 YtOtkK4PQo/oykDjGfrh0eXgYXB1ZDEqA3yDiXBYvPsN1a7hdnYr1G9ypy1N8krg5Q+mpO
 I5ckBOtHBJisJGdeLqCiA9u9jZs5r4Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736511281;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+tzeGvdH6vS8A/LD9lQ2r4g2j6uBmkgNsdhpSzn+ovU=;
 b=k5tiMcYwVBOBEr6OwmYP2TTuUkNBONcXXF75VZ5Gsx3/bvSWH6nWqPljYZ+CWFgiMdPXBd
 bQL8uyr1duyVIRBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 326B713A86;
 Fri, 10 Jan 2025 12:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yJa3OS8PgWdURwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 10 Jan 2025 12:14:39 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: [PULL 16/25] migration: Add more error handling to
 analyze-migration.py
Date: Fri, 10 Jan 2025 09:14:04 -0300
Message-Id: <20250110121413.12336-17-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250110121413.12336-1-farosas@suse.de>
References: <20250110121413.12336-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Score: -2.80
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

The analyze-migration script was seen failing in s390x in misterious
ways. It seems we're reaching the VMSDFieldStruct constructor without
any fields, which would indicate an empty .subsection entry, a
VMSTATE_STRUCT with no fields or a vmsd with no fields. We don't have
any of those, at least not without the unmigratable flag set, so this
should never happen.

Add some debug statements so that we can see what's going on the next
time the issue happens.

Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20250109185249.23952-2-farosas@suse.de>
Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 scripts/analyze-migration.py | 75 +++++++++++++++++++++---------------
 1 file changed, 45 insertions(+), 30 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 8a254a5b6a..f2457b1dde 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -429,6 +429,9 @@ def __init__(self, desc, file):
         super(VMSDFieldStruct, self).__init__(desc, file)
         self.data = collections.OrderedDict()
 
+        if 'fields' not in self.desc['struct']:
+            raise Exception("No fields in struct. VMSD:\n%s" % self.desc)
+
         # When we see compressed array elements, unfold them here
         new_fields = []
         for field in self.desc['struct']['fields']:
@@ -477,6 +480,10 @@ def read(self):
                     raise Exception("Subsection %s not found at offset %x" % ( subsection['vmsd_name'], self.file.tell()))
                 name = self.file.readstr()
                 version_id = self.file.read32()
+
+                if not subsection:
+                    raise Exception("Empty description for subsection: %s" % name)
+
                 self.data[name] = VMSDSection(self.file, version_id, subsection, (name, 0))
                 self.data[name].read()
 
@@ -574,10 +581,13 @@ def __init__(self, filename):
         }
         self.filename = filename
         self.vmsd_desc = None
+        self.vmsd_json = ""
 
-    def read(self, desc_only = False, dump_memory = False, write_memory = False):
+    def read(self, desc_only = False, dump_memory = False,
+             write_memory = False):
         # Read in the whole file
         file = MigrationFile(self.filename)
+        self.vmsd_json = file.read_migration_debug_json()
 
         # File magic
         data = file.read32()
@@ -635,9 +645,11 @@ def read(self, desc_only = False, dump_memory = False, write_memory = False):
         file.close()
 
     def load_vmsd_json(self, file):
-        vmsd_json = file.read_migration_debug_json()
-        self.vmsd_desc = json.loads(vmsd_json, object_pairs_hook=collections.OrderedDict)
+        self.vmsd_desc = json.loads(self.vmsd_json,
+                                    object_pairs_hook=collections.OrderedDict)
         for device in self.vmsd_desc['devices']:
+            if 'fields' not in device:
+                raise Exception("vmstate for device %s has no fields" % device['name'])
             key = (device['name'], device['instance_id'])
             value = ( VMSDSection, device )
             self.section_classes[key] = value
@@ -666,31 +678,34 @@ def default(self, o):
 
 jsonenc = JSONEncoder(indent=4, separators=(',', ': '))
 
-if args.extract:
-    dump = MigrationDump(args.file)
-
-    dump.read(desc_only = True)
-    print("desc.json")
-    f = open("desc.json", "w")
-    f.truncate()
-    f.write(jsonenc.encode(dump.vmsd_desc))
-    f.close()
-
-    dump.read(write_memory = True)
-    dict = dump.getDict()
-    print("state.json")
-    f = open("state.json", "w")
-    f.truncate()
-    f.write(jsonenc.encode(dict))
-    f.close()
-elif args.dump == "state":
-    dump = MigrationDump(args.file)
-    dump.read(dump_memory = args.memory)
-    dict = dump.getDict()
-    print(jsonenc.encode(dict))
-elif args.dump == "desc":
-    dump = MigrationDump(args.file)
-    dump.read(desc_only = True)
-    print(jsonenc.encode(dump.vmsd_desc))
-else:
+if not any([args.extract, args.dump == "state", args.dump == "desc"]):
     raise Exception("Please specify either -x, -d state or -d desc")
+
+try:
+    dump = MigrationDump(args.file)
+
+    if args.extract:
+        dump.read(desc_only = True)
+
+        print("desc.json")
+        f = open("desc.json", "w")
+        f.truncate()
+        f.write(jsonenc.encode(dump.vmsd_desc))
+        f.close()
+
+        dump.read(write_memory = True)
+        dict = dump.getDict()
+        print("state.json")
+        f = open("state.json", "w")
+        f.truncate()
+        f.write(jsonenc.encode(dict))
+        f.close()
+    elif args.dump == "state":
+        dump.read(dump_memory = args.memory)
+        dict = dump.getDict()
+        print(jsonenc.encode(dict))
+    elif args.dump == "desc":
+        dump.read(desc_only = True)
+        print(jsonenc.encode(dump.vmsd_desc))
+except Exception:
+    raise Exception("Full JSON dump:\n%s", dump.vmsd_json)
-- 
2.35.3


