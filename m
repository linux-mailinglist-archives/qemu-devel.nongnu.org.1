Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D127D023F
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 21:10:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtYOr-0008Vp-P5; Thu, 19 Oct 2023 15:09:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtYOn-0008PC-W3
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:09:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtYOm-0004yV-Fl
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 15:09:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697742575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=51VRLWfDh449V7/e8LGXIVSHszK25iDX1Q+NJ/45GiY=;
 b=DxNEmT6so/N08V67eG5CstoDUx/q61fwlLt43k2bwyxB+lIV1jTl3p3HPbMbrAsVspcTNr
 9lfp25Hr9/G/6jjQncpXOb3wt0yEtceZaz2PUXGRsAndCF6wbpp/AEQDJjc/4pbEI3pZuN
 3qnAxgu47AxmaKQH5aXreULE0o3KaU8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-184-binT-E-HOoKTkGI9wVNpyA-1; Thu, 19 Oct 2023 15:09:29 -0400
X-MC-Unique: binT-E-HOoKTkGI9wVNpyA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E9A528E6D2F;
 Thu, 19 Oct 2023 19:09:27 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1DFF3111D794;
 Thu, 19 Oct 2023 19:09:21 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Corey Minyard <cminyard@mvista.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Farman <farman@linux.ibm.com>,
 Peter Xu <peterx@redhat.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>, qemu-arm@nongnu.org,
 Juan Quintela <quintela@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Corey Minyard <minyard@acm.org>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Halil Pasic <pasic@linux.ibm.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>
Subject: [PATCH 09/13] migration: Check in savevm_state_handler_insert for dups
Date: Thu, 19 Oct 2023 21:08:27 +0200
Message-ID: <20231019190831.20363-10-quintela@redhat.com>
In-Reply-To: <20231019190831.20363-1-quintela@redhat.com>
References: <20231019190831.20363-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From: Peter Xu <peterx@redhat.com>

Before finally register one SaveStateEntry, we detect for duplicated
entries.  This could be helpful to notify us asap instead of get
silent migration failures which could be hard to diagnose.

For example, this patch will generate a message like this (if without
previous fixes on x2apic) as long as we wants to boot a VM instance
with "-smp 200,maxcpus=288,sockets=2,cores=72,threads=2" and QEMU will
bail out even before VM starts:

savevm_state_handler_insert: Detected duplicate SaveStateEntry: id=apic, instance_id=0x0

Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Juan Quintela <quintela@redhat.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 migration/savevm.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8622f229e5..e26833eaae 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -237,6 +237,8 @@ static SaveState savevm_state = {
     .global_section_id = 0,
 };
 
+static SaveStateEntry *find_se(const char *idstr, uint32_t instance_id);
+
 static bool should_validate_capability(int capability)
 {
     assert(capability >= 0 && capability < MIGRATION_CAPABILITY__MAX);
@@ -716,6 +718,18 @@ static void savevm_state_handler_insert(SaveStateEntry *nse)
 
     assert(priority <= MIG_PRI_MAX);
 
+    /*
+     * This should never happen otherwise migration will probably fail
+     * silently somewhere because we can be wrongly applying one
+     * object properties upon another one.  Bail out ASAP.
+     */
+    if (find_se(nse->idstr, nse->instance_id)) {
+        error_report("%s: Detected duplicate SaveStateEntry: "
+                     "id=%s, instance_id=0x%"PRIx32, __func__,
+                     nse->idstr, nse->instance_id);
+        exit(EXIT_FAILURE);
+    }
+
     for (i = priority - 1; i >= 0; i--) {
         se = savevm_state.handler_pri_head[i];
         if (se != NULL) {
-- 
2.41.0


