Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898B17DBAF9
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:38:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSSa-0003bq-8r; Mon, 30 Oct 2023 09:37:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSO-0003bL-0M
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSM-0005qq-FM
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698673045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DvVipr8Z3l451FNUoLiPJg94i3KgFBashzkt34tySl8=;
 b=MtgbtSP1lwkfZKj2nRU52Z9WI+kSB1NUykIx23RVM6p9Io11gvmBxZZQ2X+rIuPyarlDVJ
 Yph/quX5EmGCmserpF/zhVmybTUdMPSvOh3pgTR7MU1lqa2kpMQ9ElcqR4jjRFP2ErDkx0
 uAz6hzPriyUsIJt93885pKpkjkYv/3o=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-U918FyPgPwa3o203vVjbRA-1; Mon,
 30 Oct 2023 09:37:14 -0400
X-MC-Unique: U918FyPgPwa3o203vVjbRA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 114D53C000B4
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E45D5C1596C
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEB7421E691F; Mon, 30 Oct 2023 14:37:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH 4/5] dump: Improve some dump-guest-memory error messages
Date: Mon, 30 Oct 2023 14:37:11 +0100
Message-ID: <20231030133712.2822276-5-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-1-armbru@redhat.com>
References: <20231030133712.2822276-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
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

Zero @length is rejected with "Invalid parameter 'length'".  Improve
to "Parameter 'length' expects a non-zero length".

@protocol values not starting with "fd:" or "file:" are rejected with
"Invalid parameter 'protocol'".  Improve to "parameter 'protocol' must
start with 'file:' or 'fd:'".

While there, make the conditional checking @protocol a little more
obvious.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index a5e9a06ef1..d888e4bd3c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -1812,7 +1812,8 @@ static void dump_init(DumpState *s, int fd, bool has_format,
 
     s->fd = fd;
     if (has_filter && !length) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "length");
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "length",
+                   "a non-zero size");
         goto cleanup;
     }
     s->filter_area_begin = begin;
@@ -2072,7 +2073,7 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
 {
     ERRP_GUARD();
     const char *p;
-    int fd = -1;
+    int fd;
     DumpState *s;
     bool detach_p = false;
 
@@ -2135,18 +2136,15 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
         if (fd == -1) {
             return;
         }
-    }
-
-    if  (strstart(protocol, "file:", &p)) {
+    } else if  (strstart(protocol, "file:", &p)) {
         fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
         if (fd < 0) {
             error_setg_file_open(errp, errno, p);
             return;
         }
-    }
-
-    if (fd == -1) {
-        error_setg(errp, QERR_INVALID_PARAMETER, "protocol");
+    } else {
+        error_setg(errp,
+                   "parameter 'protocol' must start with 'file:' or 'fd:'");
         return;
     }
 
-- 
2.41.0


