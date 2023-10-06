Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8B187BB6C6
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 13:43:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoj9Q-0005BR-Il; Fri, 06 Oct 2023 07:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj93-00053A-03
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qoj8z-0000EG-00
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 07:37:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696592239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0dtR46yIS7jXolrgD1WN+gaptLFT0kHhKgLq1QGGCo0=;
 b=eTOzGT5Sor6ltL5OesStRPoCFl0lojXJ5NOgGCIHBMXc89FyozaTDKH+lxpYxKbO2HUQ7p
 WyqPZNYv4tg9ig/974DwocfSb5xl2At020q4E0HSf5+eVeURNmA7SklV7j/6Fay3xa/UHq
 xj9g670dEbk3A1bxDuBDQqzAwz+5OQM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-402-q2-fD7H_NrOTxltfrv0DvQ-1; Fri, 06 Oct 2023 07:37:01 -0400
X-MC-Unique: q2-fD7H_NrOTxltfrv0DvQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F0234811E7E;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BC3F4140E964;
 Fri,  6 Oct 2023 11:37:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A5A2B21E6890; Fri,  6 Oct 2023 13:36:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Laurent Vivier <laurent@vivier.eu>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 28/32] linux-user/flatload: clean up local variable shadowing
Date: Fri,  6 Oct 2023 13:36:53 +0200
Message-ID: <20231006113657.3803180-29-armbru@redhat.com>
In-Reply-To: <20231006113657.3803180-1-armbru@redhat.com>
References: <20231006113657.3803180-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Laurent Vivier <laurent@vivier.eu>

Fix following warnings:

.../linux-user/flatload.c: In function 'load_flt_binary':
.../linux-user/flatload.c:758:23: warning: declaration of 'p' shadows a previous local [-Wshadow=compatible-local]
  758 |             abi_ulong p;
      |                       ^
../../../Projects/qemu/linux-user/flatload.c:722:15: note: shadowed declaration is here
  722 |     abi_ulong p;
      |               ^

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Message-ID: <20230925151029.461358-2-laurent@vivier.eu>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 linux-user/flatload.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/flatload.c b/linux-user/flatload.c
index 4331a11bf0..fdcc4610fa 100644
--- a/linux-user/flatload.c
+++ b/linux-user/flatload.c
@@ -755,15 +755,15 @@ int load_flt_binary(struct linux_binprm *bprm, struct image_info *info)
     /* Update data segment pointers for all libraries */
     for (i=0; i<MAX_SHARED_LIBS; i++) {
         if (libinfo[i].loaded) {
-            abi_ulong p;
-            p = libinfo[i].start_data;
+            abi_ulong seg;
+            seg = libinfo[i].start_data;
             for (j=0; j<MAX_SHARED_LIBS; j++) {
-                p -= 4;
+                seg -= 4;
                 /* FIXME - handle put_user() failures */
                 if (put_user_ual(libinfo[j].loaded
                                  ? libinfo[j].start_data
                                  : UNLOADED_LIB,
-                                 p))
+                                 seg))
                     return -EFAULT;
             }
         }
-- 
2.41.0


