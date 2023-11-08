Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DFE7E5016
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 06:38:58 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0bG2-0003eN-1M; Wed, 08 Nov 2023 00:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bFz-0003dx-DN
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:37:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r0bFw-0004Iy-SG
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699421855;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/vMzrrk6DjAH++GRcwkybchFQgT9uHeR63ZD5WMLvEc=;
 b=NmfTyGQEGBWrZPWevnrk9vARK4Rl0umEvStppzS4Bgef8ntwAxIddGoe7A7BxTyFXFxvO7
 EE+TIlgCDa5W7NR+lLt4Hh2SYvnnSQiMhdwsDUXc/0iQaWiRDJ7TX1uUNI0Z0c06mfBwQd
 u9ofj8NtUbnGkUIgWRhufK6NGcgHxOQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-85-hv87ejKzNaGmTQU0FMsjhQ-1; Wed, 08 Nov 2023 00:37:32 -0500
X-MC-Unique: hv87ejKzNaGmTQU0FMsjhQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5E056185A784;
 Wed,  8 Nov 2023 05:37:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3AD6D492BFA;
 Wed,  8 Nov 2023 05:37:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A14E21E6A28; Wed,  8 Nov 2023 06:37:31 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stephen.s.brennan@oracle.com, marcandre.lureau@redhat.com,
 berrange@redhat.com
Subject: [PATCH 2/2] dump: Fix HMP dump-guest-memory -z without -R
Date: Wed,  8 Nov 2023 06:37:31 +0100
Message-ID: <20231108053731.112043-3-armbru@redhat.com>
In-Reply-To: <20231108053731.112043-1-armbru@redhat.com>
References: <20231108053731.112043-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

-z without -R has no effect: the dump format remains @elf.  Fix the
logic error so it becomes @kdump-zlib.

Fixes: e6549197f7ed (dump: Add command interface for kdump-raw formats)
Fixes: CID 1523841
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump-hmp-cmds.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/dump/dump-hmp-cmds.c b/dump/dump-hmp-cmds.c
index b428ec33df..d9340427c3 100644
--- a/dump/dump-hmp-cmds.c
+++ b/dump/dump-hmp-cmds.c
@@ -41,7 +41,7 @@ void hmp_dump_guest_memory(Monitor *mon, const QDict *qdict)
         dump_format = DUMP_GUEST_MEMORY_FORMAT_WIN_DMP;
     }
 
-    if (zlib && raw) {
+    if (zlib) {
         if (raw) {
             dump_format = DUMP_GUEST_MEMORY_FORMAT_KDUMP_RAW_ZLIB;
         } else {
-- 
2.41.0


