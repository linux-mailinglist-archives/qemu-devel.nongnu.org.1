Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 673307DCB16
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 11:46:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmFh-0007Kf-0U; Tue, 31 Oct 2023 06:45:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmFe-0007KJ-Qo
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:45:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmFc-0000xD-LD
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 06:45:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698749135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hDNcH1XZk9AyuYPLuWhvZ/1Mcf1HW41OywfsAGutPo4=;
 b=WNXUgaDnwCFm/ryoN45xqumzzaIStow0lH0WOoBBuJSdIDJKy92E0rJkJgufU094ToQO2P
 tiXXqG8SyN9UHpcHIccdFNnW1Qg+WGE8XBxHV5bHPf1jp48npyMEiHgsgBgd9emELZis45
 2XTIgSACSTaATmpev74cK5p8ceYGlqg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-6X15FQgKO8CqZ77VIxFX_A-1; Tue, 31 Oct 2023 06:45:32 -0400
X-MC-Unique: 6X15FQgKO8CqZ77VIxFX_A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 646EB185A782;
 Tue, 31 Oct 2023 10:45:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4266C1121306;
 Tue, 31 Oct 2023 10:45:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C14621E6A26; Tue, 31 Oct 2023 11:45:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com,
	philmd@linaro.org
Subject: [PATCH v2 1/5] dump: Rename qmp_dump_guest_memory() parameter to
 match QAPI schema
Date: Tue, 31 Oct 2023 11:45:27 +0100
Message-ID: <20231031104531.3169721-2-armbru@redhat.com>
In-Reply-To: <20231031104531.3169721-1-armbru@redhat.com>
References: <20231031104531.3169721-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
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

The name of the second parameter differs between QAPI schema and C
implementation: it's @protocol in the former and @file in the latter.
Potentially confusing.  Change the C implementation to match the QAPI
schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 dump/dump.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d355ada62e..a1fad17f9c 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2061,11 +2061,12 @@ DumpQueryResult *qmp_query_dump(Error **errp)
     return result;
 }
 
-void qmp_dump_guest_memory(bool paging, const char *file,
+void qmp_dump_guest_memory(bool paging, const char *protocol,
                            bool has_detach, bool detach,
-                           bool has_begin, int64_t begin, bool has_length,
-                           int64_t length, bool has_format,
-                           DumpGuestMemoryFormat format, Error **errp)
+                           bool has_begin, int64_t begin,
+                           bool has_length, int64_t length,
+                           bool has_format, DumpGuestMemoryFormat format,
+                           Error **errp)
 {
     ERRP_GUARD();
     const char *p;
@@ -2128,7 +2129,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     }
 
 #if !defined(WIN32)
-    if (strstart(file, "fd:", &p)) {
+    if (strstart(protocol, "fd:", &p)) {
         fd = monitor_get_fd(monitor_cur(), p, errp);
         if (fd == -1) {
             return;
@@ -2136,7 +2137,7 @@ void qmp_dump_guest_memory(bool paging, const char *file,
     }
 #endif
 
-    if  (strstart(file, "file:", &p)) {
+    if  (strstart(protocol, "file:", &p)) {
         fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
         if (fd < 0) {
             error_setg_file_open(errp, errno, p);
-- 
2.41.0


