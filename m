Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C12A08042
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Jan 2025 19:55:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVxes-0002V3-CS; Thu, 09 Jan 2025 13:53:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeV-0002Ig-Hn
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:07 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tVxeT-0005uk-L6
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 13:53:07 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id DE5871F452;
 Thu,  9 Jan 2025 18:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xM3gMRzVTAD12fLEuR8kTRKDEdCv5qtOPkpDwA+xDQU=;
 b=zWBJrvv+k4eBF6XJXWdK90EGnQCwYA7tuE9gpO9ZEDu6CYGCgeAuP3/Ea8Ovn05BTgzrbl
 5HizU9wdDjrRQZuKwOQC9gU83kdoJLTm0+MuFSZCMgzSit32nv4qvVGR8esAi5jmw6DCpL
 lFx0BACNFpHPrUJ9hQwpvvMsh97EHeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xM3gMRzVTAD12fLEuR8kTRKDEdCv5qtOPkpDwA+xDQU=;
 b=8QVgZfs7k1rzcUwrKsx5yYYVEgJ9Dcwe1hUunAFa8snRHj95jFabxCqbWJUQx8xtB7kh2W
 ndY8P15Ky2Mzg1Bg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=zWBJrvv+;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=8QVgZfs7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1736448783; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xM3gMRzVTAD12fLEuR8kTRKDEdCv5qtOPkpDwA+xDQU=;
 b=zWBJrvv+k4eBF6XJXWdK90EGnQCwYA7tuE9gpO9ZEDu6CYGCgeAuP3/Ea8Ovn05BTgzrbl
 5HizU9wdDjrRQZuKwOQC9gU83kdoJLTm0+MuFSZCMgzSit32nv4qvVGR8esAi5jmw6DCpL
 lFx0BACNFpHPrUJ9hQwpvvMsh97EHeQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1736448783;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xM3gMRzVTAD12fLEuR8kTRKDEdCv5qtOPkpDwA+xDQU=;
 b=8QVgZfs7k1rzcUwrKsx5yYYVEgJ9Dcwe1hUunAFa8snRHj95jFabxCqbWJUQx8xtB7kh2W
 ndY8P15Ky2Mzg1Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA61E139AB;
 Thu,  9 Jan 2025 18:53:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IKuHGw4bgGdcMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Thu, 09 Jan 2025 18:53:02 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v3 6/7] migration: Fix arrays of pointers in JSON writer
Date: Thu,  9 Jan 2025 15:52:48 -0300
Message-Id: <20250109185249.23952-7-farosas@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250109185249.23952-1-farosas@suse.de>
References: <20250109185249.23952-1-farosas@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DE5871F452
X-Spam-Score: -3.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
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

Currently, if an array of pointers contains a NULL pointer, that
pointer will be encoded as '0' in the stream. Since the JSON writer
doesn't define a "pointer" type, that '0' will now be an uint8, which
is different from the original type being pointed to, e.g. struct.

(we're further calling uint8 "nullptr", but that's irrelevant to the
issue)

That mixed-type array shouldn't be compressed, otherwise data is lost
as the code currently makes the whole array have the type of the first
element:

css = {NULL, NULL, ..., 0x5555568a7940, NULL};

{"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
 "version": 1, "fields": [
    ...,
    {"name": "css", "array_len": 256, "type": "nullptr", "size": 1},
    ...,
]}

In the above, the valid pointer at position 254 got lost among the
compressed array of nullptr.

While we could disable the array compression when a NULL pointer is
found, the JSON part of the stream still makes part of downtime, so we
should avoid writing unecessary bytes to it.

Keep the array compression in place, but if NULL and non-NULL pointers
are mixed break the array into several type-contiguous pieces :

css = {NULL, NULL, ..., 0x5555568a7940, NULL};

{"name": "s390_css", "instance_id": 0, "vmsd_name": "s390_css",
 "version": 1, "fields": [
     ...,
     {"name": "css", "array_len": 254, "type": "nullptr", "size": 1},
     {"name": "css", "type": "struct", "struct": {"vmsd_name": "s390_css_img", ... }, "size": 768},
     {"name": "css", "type": "nullptr", "size": 1},
     ...,
]}

Now each type-discontiguous region will become a new JSON entry. The
reader should interpret this as a concatenation of values, all part of
the same field.

Parsing the JSON with analyze-script.py now shows the proper data
being pointed to at the places where the pointer is valid and
"nullptr" where there's NULL:

"s390_css (14)": {
    ...
    "css": [
        "nullptr",
        "nullptr",
        ...
        "nullptr",
        {
            "chpids": [
            {
                "in_use": "0x00",
                "type": "0x00",
                "is_virtual": "0x00"
            },
            ...
            ]
        },
        "nullptr",
    }

Signed-off-by: Fabiano Rosas <farosas@suse.de>
---
 migration/vmstate.c          | 33 ++++++++++++++++++++++++++++++++-
 scripts/analyze-migration.py | 26 ++++++++++++++++++--------
 2 files changed, 50 insertions(+), 9 deletions(-)

diff --git a/migration/vmstate.c b/migration/vmstate.c
index 52704c822c..82bd005a83 100644
--- a/migration/vmstate.c
+++ b/migration/vmstate.c
@@ -425,15 +425,19 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
             int size = vmstate_size(opaque, field);
             uint64_t old_offset, written_bytes;
             JSONWriter *vmdesc_loop = vmdesc;
+            bool is_prev_null = false;
 
             trace_vmstate_save_state_loop(vmsd->name, field->name, n_elems);
             if (field->flags & VMS_POINTER) {
                 first_elem = *(void **)first_elem;
                 assert(first_elem || !n_elems || !size);
             }
+
             for (i = 0; i < n_elems; i++) {
                 void *curr_elem = first_elem + size * i;
                 const VMStateField *inner_field;
+                bool is_null;
+                int max_elems = n_elems - i;
 
                 old_offset = qemu_file_transferred(f);
                 if (field->flags & VMS_ARRAY_OF_POINTER) {
@@ -448,12 +452,39 @@ int vmstate_save_state_v(QEMUFile *f, const VMStateDescription *vmsd,
                      * not follow.
                      */
                     inner_field = vmsd_create_fake_nullptr_field(field);
+                    is_null = true;
                 } else {
                     inner_field = field;
+                    is_null = false;
+                }
+
+                /*
+                 * Due to the fake nullptr handling above, if there's mixed
+                 * null/non-null data, it doesn't make sense to emit a
+                 * compressed array representation spanning the entire array
+                 * because the field types will be different (e.g. struct
+                 * vs. nullptr). Search ahead for the next null/non-null element
+                 * and start a new compressed array if found.
+                 */
+                if (field->flags & VMS_ARRAY_OF_POINTER &&
+                    is_null != is_prev_null) {
+
+                    is_prev_null = is_null;
+                    vmdesc_loop = vmdesc;
+
+                    for (int j = i + 1; j < n_elems; j++) {
+                        void *elem = *(void **)(first_elem + size * j);
+                        bool elem_is_null = !elem && size;
+
+                        if (is_null != elem_is_null) {
+                            max_elems = j - i;
+                            break;
+                        }
+                    }
                 }
 
                 vmsd_desc_field_start(vmsd, vmdesc_loop, inner_field,
-                                      i, n_elems);
+                                      i, max_elems);
 
                 if (inner_field->flags & VMS_STRUCT) {
                     ret = vmstate_save_state(f, inner_field->vmsd,
diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 923f174f1b..8e1fbf4c9d 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -502,15 +502,25 @@ def read(self):
             field['data'] = reader(field, self.file)
             field['data'].read()
 
-            if 'index' in field:
-                if field['name'] not in self.data:
-                    self.data[field['name']] = []
-                a = self.data[field['name']]
-                if len(a) != int(field['index']):
-                    raise Exception("internal index of data field unmatched (%d/%d)" % (len(a), int(field['index'])))
-                a.append(field['data'])
+            fname = field['name']
+            fdata = field['data']
+
+            # The field could be:
+            # i) a single data entry, e.g. uint64
+            # ii) an array, indicated by it containing the 'index' key
+            #
+            # However, the overall data after parsing the whole
+            # stream, could be a mix of arrays and single data fields,
+            # all sharing the same field name due to how QEMU breaks
+            # up arrays with NULL pointers into multiple compressed
+            # array segments.
+            if fname not in self.data:
+                self.data[fname] = fdata
+            elif type(self.data[fname]) == list:
+                self.data[fname].append(fdata)
             else:
-                self.data[field['name']] = field['data']
+                tmp = self.data[fname]
+                self.data[fname] = [tmp, fdata]
 
         if 'subsections' in self.desc['struct']:
             for subsection in self.desc['struct']['subsections']:
-- 
2.35.3


