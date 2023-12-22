Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A23681C767
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:39:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbzh-0000Be-D4; Fri, 22 Dec 2023 04:39:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGbzQ-0000B5-Fy
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:38:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGbzE-00078E-A1
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:38:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703237910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/NPXkc+ZqVZCNO6BnvmDKBzJhiCBAoVEp/+ZmXA8Bys=;
 b=eq5avBbes5dysPuuDnjtWGNERs+3Fza5I8dGRC7C+tFOKaxdB1IWMiOTxwaaJPZo+VfUNx
 W4IStPM5GEdD01BaKO+PfHPZGJco6+AnvFy2zL4ojyf3IfCh8jcfUIKESEUjBVJLjp1UAp
 10K2IPOHOY0G2AJdqzhvAV/KxDGzEek=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-sLwDubhoPkCgY0cSv5h_Pw-1; Fri, 22 Dec 2023 04:38:29 -0500
X-MC-Unique: sLwDubhoPkCgY0cSv5h_Pw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B984087B2A0;
 Fri, 22 Dec 2023 09:38:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 97DC7492BC6;
 Fri, 22 Dec 2023 09:38:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7B85B21E6925; Fri, 22 Dec 2023 10:38:27 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 1/1] dump: Fix HMP dump-guest-memory -z without -R
Date: Fri, 22 Dec 2023 10:38:27 +0100
Message-ID: <20231222093827.951039-2-armbru@redhat.com>
In-Reply-To: <20231222093827.951039-1-armbru@redhat.com>
References: <20231222093827.951039-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.061,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Reviewed-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
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
2.43.0


