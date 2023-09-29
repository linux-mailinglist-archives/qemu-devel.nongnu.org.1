Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C26657B2EC4
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 11:01:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qm9Mf-0001n7-3E; Fri, 29 Sep 2023 05:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MT-0001l8-QQ
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qm9MP-0008CA-Jq
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 05:00:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695978033;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fuyo5yYtGJxUI4HalBHeJ6YEV/j2IPp/nq6KI3/C+Ac=;
 b=WA1hbI8wC0sKYaJnXzu1Mhn79jhozZMzq8TMam/Bi/6zGniMVwhcItKpM9SvcKrH6cY4Lu
 0LQMzr4or51pZ0qaADFJDlqrRlTM9SVCDCCorDywd2R8gxgMRHpT7FJF2ROcKvTSxOc4le
 tEHpjtd/+DQ3w2uAhGVq19/IfozgVjU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-mZU6g1TtPz6t2Vuuczh-Bw-1; Fri, 29 Sep 2023 05:00:28 -0400
X-MC-Unique: mZU6g1TtPz6t2Vuuczh-Bw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9A8801DD35D3;
 Fri, 29 Sep 2023 09:00:28 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.25])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 757E2492B16;
 Fri, 29 Sep 2023 09:00:28 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F3BB921E68AC; Fri, 29 Sep 2023 10:50:53 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, Klaus Jensen <k.jensen@samsung.com>,
 Jesper Wendel Devantier <j.devantier@samsung.com>
Subject: [PULL 55/56] hw/nvme: Clean up local variable shadowing in
 nvme_ns_init()
Date: Fri, 29 Sep 2023 10:50:52 +0200
Message-ID: <20230929085053.2789105-56-armbru@redhat.com>
In-Reply-To: <20230929085053.2789105-1-armbru@redhat.com>
References: <20230929085053.2789105-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Klaus Jensen <k.jensen@samsung.com>

Fix local variable shadowing in nvme_ns_init().

Reported-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Klaus Jensen <k.jensen@samsung.com>
Message-ID: <20230925-fix-local-shadowing-v1-1-3a1172132377@samsung.com>
Reviewed-by: Jesper Wendel Devantier <j.devantier@samsung.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/nvme/ns.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/nvme/ns.c b/hw/nvme/ns.c
index 44aba8f4d9..0eabcf5cf5 100644
--- a/hw/nvme/ns.c
+++ b/hw/nvme/ns.c
@@ -107,7 +107,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 
     ns->pif = ns->params.pif;
 
-    static const NvmeLBAF lbaf[16] = {
+    static const NvmeLBAF defaults[16] = {
         [0] = { .ds =  9           },
         [1] = { .ds =  9, .ms =  8 },
         [2] = { .ds =  9, .ms = 16 },
@@ -120,7 +120,7 @@ static int nvme_ns_init(NvmeNamespace *ns, Error **errp)
 
     ns->nlbaf = 8;
 
-    memcpy(&id_ns->lbaf, &lbaf, sizeof(lbaf));
+    memcpy(&id_ns->lbaf, &defaults, sizeof(defaults));
 
     for (i = 0; i < ns->nlbaf; i++) {
         NvmeLBAF *lbaf = &id_ns->lbaf[i];
-- 
2.41.0


