Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B407EAF6E
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 12:44:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2rpL-0004JJ-OT; Tue, 14 Nov 2023 06:43:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2rpJ-0004Ij-3A
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:43:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1r2rpH-0005jg-Ep
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 06:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699962206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y4jGDhpxGQqtCVxRgTqyp8eoMzusO9SHhM1krnx2M3g=;
 b=UmhXcfcN0XoYNKANrXbFz6ATojsqYPv0QLghqCuAGB2v+CtUq7SKRSQ+MNQJ+iw+FLrAAG
 jqPVMXi5SYhKjYYUip7+HAsAX0svWc+4SBVQ0h7E+2VDqli9JqweBaGAyGPDLEI8AnmbOl
 bA9vF1I1VWAFxXKLikxw7FgxQgQL6Ko=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-L160dXjBPSyAxDPj76piXw-1; Tue, 14 Nov 2023 06:43:25 -0500
X-MC-Unique: L160dXjBPSyAxDPj76piXw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B7F63185A780;
 Tue, 14 Nov 2023 11:43:24 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 290BD2026D4C;
 Tue, 14 Nov 2023 11:43:23 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 2/3] dump: Add arch cleanup function
Date: Tue, 14 Nov 2023 12:43:17 +0100
Message-ID: <20231114114318.158226-3-thuth@redhat.com>
In-Reply-To: <20231114114318.158226-1-thuth@redhat.com>
References: <20231114114318.158226-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Janosch Frank <frankja@linux.ibm.com>

Some architectures (s390x) need to cleanup after a failed dump to be
able to continue to run the vm. Add a cleanup function pointer and
call it if it's set.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Message-ID: <20231109120443.185979-3-frankja@linux.ibm.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 include/sysemu/dump-arch.h | 1 +
 dump/dump.c                | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/include/sysemu/dump-arch.h b/include/sysemu/dump-arch.h
index 59bbc9be38..743916e46c 100644
--- a/include/sysemu/dump-arch.h
+++ b/include/sysemu/dump-arch.h
@@ -24,6 +24,7 @@ typedef struct ArchDumpInfo {
     void (*arch_sections_add_fn)(DumpState *s);
     uint64_t (*arch_sections_write_hdr_fn)(DumpState *s, uint8_t *buff);
     int (*arch_sections_write_fn)(DumpState *s, uint8_t *buff);
+    void (*arch_cleanup_fn)(DumpState *s);
 } ArchDumpInfo;
 
 struct GuestPhysBlockList; /* memory_mapping.h */
diff --git a/dump/dump.c b/dump/dump.c
index ad5294e853..4819050764 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -96,6 +96,10 @@ uint64_t cpu_to_dump64(DumpState *s, uint64_t val)
 
 static int dump_cleanup(DumpState *s)
 {
+    if (s->dump_info.arch_cleanup_fn) {
+        s->dump_info.arch_cleanup_fn(s);
+    }
+
     guest_phys_blocks_free(&s->guest_phys_blocks);
     memory_mapping_list_free(&s->list);
     close(s->fd);
-- 
2.41.0


