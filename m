Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 838157DBAF8
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:38:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSSd-0003cl-FY; Mon, 30 Oct 2023 09:37:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSO-0003bc-Mc
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSN-0005qu-0S
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698673046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oq0lWctSVa3/3897g4nCYpHn0n5Zdm88YbJL1HmTP7I=;
 b=SRDeOE2U0YlBbISd4hRbgBMtmK1kAKondbPaBHqcL31gp6VFhzohEuBtEzfqxwZZBuP1PN
 6pyB725I4vesO1s72akPAoMG83lfAdQK0QhKwuIZvOt2pENSrhg+VijCcyYRr3XqfG5EDN
 gpC1SxprHNduQpUgvcRRxjihI1mI/Do=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-OjntsvlOMfWWMg9fbQp1VA-1; Mon, 30 Oct 2023 09:37:14 -0400
X-MC-Unique: OjntsvlOMfWWMg9fbQp1VA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 11CF7811E86
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E50B41C060AE
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8C5E21E6A28; Mon, 30 Oct 2023 14:37:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH 2/5] dump: Fix g_array_unref(NULL) in dump-guest-memory
Date: Mon, 30 Oct 2023 14:37:09 +0100
Message-ID: <20231030133712.2822276-3-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-1-armbru@redhat.com>
References: <20231030133712.2822276-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

When dump_init()'s check for non-zero @length fails, dump_cleanup()
passes null s->string_table_buf to g_array_unref(), which spews "GLib:
g_array_unref: assertion 'array' failed" to stderr.

Guard the g_array_unref().

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/dump/dump.c b/dump/dump.c
index a1fad17f9c..d8ea364af2 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -100,7 +100,9 @@ static int dump_cleanup(DumpState *s)
     memory_mapping_list_free(&s->list);
     close(s->fd);
     g_free(s->guest_note);
-    g_array_unref(s->string_table_buf);
+    if (s->string_table_buf) {
+        g_array_unref(s->string_table_buf);
+    }
     s->guest_note = NULL;
     if (s->resume) {
         if (s->detached) {
-- 
2.41.0


