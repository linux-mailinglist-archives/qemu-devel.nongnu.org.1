Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3754C7B8078
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 15:15:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo1hi-0006hV-1v; Wed, 04 Oct 2023 09:14:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1hI-0006dR-Ek
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:13:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo1hG-0001c3-C8
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 09:13:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696425229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+E8fYpbb8ncGc3U9mYCKCyFZn4aX85S9z4TeFI0ash8=;
 b=H/oOwzKJyUypEBdgbkIbeU7RQ9Cu7tQkPMzBqPeIka3A5IR+8VuHbAkkW7DkKQaU2KMop2
 +NQpjtYr+zDY6CFYKbQjFd1B+lMN8QlATbspdYNsIVt+R9zq08UMHyfCQnR49NTMELRc2R
 bez7ilm7RvO1cw4VEwxCYvZfdqWMtu8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-8SJuIeA_PSmshVCFfuYpuw-1; Wed, 04 Oct 2023 09:13:41 -0400
X-MC-Unique: 8SJuIeA_PSmshVCFfuYpuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9461811E86;
 Wed,  4 Oct 2023 13:13:40 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.194.172])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E2E0B40C2015;
 Wed,  4 Oct 2023 13:13:39 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>,
	qemu-trivial@nongnu.org
Subject: [PATCH] dump: Silence compiler warning in dump code when compiling
 with -Wshadow
Date: Wed,  4 Oct 2023 15:13:38 +0200
Message-ID: <20231004131338.215081-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Rename a variable to make this code compilable with -Wshadow.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 dump/dump.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d4ef713cd0..d3578ddc62 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1872,20 +1872,20 @@ static void dump_init(DumpState *s, int fd, bool has_format,
     if (vmci) {
         uint64_t addr, note_head_size, name_size, desc_size;
         uint32_t size;
-        uint16_t format;
+        uint16_t guest_format;
 
         note_head_size = dump_is_64bit(s) ?
             sizeof(Elf64_Nhdr) : sizeof(Elf32_Nhdr);
 
-        format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
+        guest_format = le16_to_cpu(vmci->vmcoreinfo.guest_format);
         size = le32_to_cpu(vmci->vmcoreinfo.size);
         addr = le64_to_cpu(vmci->vmcoreinfo.paddr);
         if (!vmci->has_vmcoreinfo) {
             warn_report("guest note is not present");
         } else if (size < note_head_size || size > MAX_GUEST_NOTE_SIZE) {
             warn_report("guest note size is invalid: %" PRIu32, size);
-        } else if (format != FW_CFG_VMCOREINFO_FORMAT_ELF) {
-            warn_report("guest note format is unsupported: %" PRIu16, format);
+        } else if (guest_format != FW_CFG_VMCOREINFO_FORMAT_ELF) {
+            warn_report("guest note format is unsupported: %" PRIu16, guest_format);
         } else {
             s->guest_note = g_malloc(size + 1); /* +1 for adding \0 */
             cpu_physical_memory_read(addr, s->guest_note, size);
-- 
2.41.0


