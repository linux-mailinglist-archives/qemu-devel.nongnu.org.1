Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 806B47AB588
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 18:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjigH-0001lw-7f; Fri, 22 Sep 2023 12:07:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjig8-0001BX-RW
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:06:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1qjig6-00088r-6V
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 12:06:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695398809;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HvaN0nDMvAHNOVOyU7iVBv5Ha46YoKQ9tPYoZMx8uQk=;
 b=UjerWt3OYuV9KFP4Ejr7IgD44faL/QUvTAkMvNwXRdG8aX/xwvgVSoY7jylouK2AiAk+9R
 sVaBFm069W3Og2/nWzaAOIHbNS5eFu5zzBjzJ5haEukbJLH7QvkMWKTZeoPc647rx2YetD
 t8DgNWAzNizuzRjLKlleeKFKMzDmPtI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-641-EvHw838PNimBV7AgYcKPuw-1; Fri, 22 Sep 2023 12:06:47 -0400
X-MC-Unique: EvHw838PNimBV7AgYcKPuw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 81E173C108EF
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 16:06:47 +0000 (UTC)
Received: from toolbox.redhat.com (unknown [10.42.28.51])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DD4B240C2064;
 Fri, 22 Sep 2023 16:06:46 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/2] seccomp: avoid shadowing of 'action' variable
Date: Fri, 22 Sep 2023 17:06:44 +0100
Message-ID: <20230922160644.438631-3-berrange@redhat.com>
In-Reply-To: <20230922160644.438631-1-berrange@redhat.com>
References: <20230922160644.438631-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

This is confusing as one 'action' variable is used for storing
a SCMP_ enum value, while the other 'action' variable is used
for storing a SECCOMP_ enum value.

Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
---
 softmmu/qemu-seccomp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/softmmu/qemu-seccomp.c b/softmmu/qemu-seccomp.c
index d66a2a1226..4d7439e7f7 100644
--- a/softmmu/qemu-seccomp.c
+++ b/softmmu/qemu-seccomp.c
@@ -283,9 +283,9 @@ static uint32_t qemu_seccomp_update_action(uint32_t action)
     if (action == SCMP_ACT_TRAP) {
         static int kill_process = -1;
         if (kill_process == -1) {
-            uint32_t action = SECCOMP_RET_KILL_PROCESS;
+            uint32_t testaction = SECCOMP_RET_KILL_PROCESS;
 
-            if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) == 0) {
+            if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &testaction) == 0) {
                 kill_process = 1;
             } else {
                 kill_process = 0;
-- 
2.41.0


