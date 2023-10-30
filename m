Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 123FC7DBAFE
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 14:38:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxSSL-0003a9-J2; Mon, 30 Oct 2023 09:37:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSI-0003ZR-Fy
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxSSE-0005pK-Jt
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 09:37:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698673035;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9cm/Iq/KUDxEZtqhyDszpnt2bY4BZ2vZ76UDYe25tTY=;
 b=TkdneSgYNxaooRKsqAgmNo65cqkPz5+QCu94jcU8i/mpm38Mh8kwwJJ7goShm0WW/oIu9R
 7LsQBBf/dhpgfMBnQLZr/vGqzvORiXtdkdmf5C2HFNNWN6i3reYyR1ldfK/uywzYs1wY5c
 pOS6UKVrjSXMNT6oVW8P8A0cetfoYeo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-anwYmyGXOfqkSoOsvjhBcg-1; Mon, 30 Oct 2023 09:37:14 -0400
X-MC-Unique: anwYmyGXOfqkSoOsvjhBcg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 119CB185A785
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E4EE8C1596E
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 13:37:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CBBDF21E6A37; Mon, 30 Oct 2023 14:37:12 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: marcandre.lureau@redhat.com
Subject: [PATCH 3/5] dump: Recognize "fd:" protocols on Windows hosts
Date: Mon, 30 Oct 2023 14:37:10 +0100
Message-ID: <20231030133712.2822276-4-armbru@redhat.com>
In-Reply-To: <20231030133712.2822276-1-armbru@redhat.com>
References: <20231030133712.2822276-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

A few QMP command can work with named file descriptors.

The only way to create a named file descriptor used to be QMP command
getfd, which only works on POSIX hosts.  Thus, named file descriptors
were actually usable only there.

They became usable on Windows hosts when we added QMP command
get-win32-socket (commit 4cda177c601 "qmp: add 'get-win32-socket'").

Except in dump-guest-memory, because qmp_dump_guest_memory() compiles
its named file descriptor code only #if !defined(WIN32).

Compile it unconditionally, like we do for the other commands
supporting them.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 dump/dump.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/dump/dump.c b/dump/dump.c
index d8ea364af2..a5e9a06ef1 100644
--- a/dump/dump.c
+++ b/dump/dump.c
@@ -2130,14 +2130,12 @@ void qmp_dump_guest_memory(bool paging, const char *protocol,
         return;
     }
 
-#if !defined(WIN32)
     if (strstart(protocol, "fd:", &p)) {
         fd = monitor_get_fd(monitor_cur(), p, errp);
         if (fd == -1) {
             return;
         }
     }
-#endif
 
     if  (strstart(protocol, "file:", &p)) {
         fd = qemu_open_old(p, O_WRONLY | O_CREAT | O_TRUNC | O_BINARY, S_IRUSR);
-- 
2.41.0


