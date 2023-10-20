Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A56017D0B1C
	for <lists+qemu-devel@lfdr.de>; Fri, 20 Oct 2023 11:08:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtlUZ-0003NQ-K0; Fri, 20 Oct 2023 05:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlU4-0003AZ-4y
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:08:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1qtlU1-0005D9-Jh
 for qemu-devel@nongnu.org; Fri, 20 Oct 2023 05:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697792872;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hNFk4YkCAqeJIsXVRuOEkZafNahxDTxT32DWNknVNck=;
 b=JR1XCSihaZei9cL3nql1wc/Q5Y4LEq6WjM63e89GtziAzV6gLUMdoeExbIa+1oOJjB06Sp
 7GT14MS3VSeqH0Uu8G7Dbqgm1+Lkwvo08EwO0MpVEqm5wVG8WXQqqIeGqL4ZgLOZN32ERn
 vSyE76od7GkrM2IBYYHOp83Zdu2vByQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-172-7-RHZQqDMhCaaY-T5CnLUQ-1; Fri, 20 Oct 2023 05:07:44 -0400
X-MC-Unique: 7-RHZQqDMhCaaY-T5CnLUQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1D1D487A9F3;
 Fri, 20 Oct 2023 09:07:43 +0000 (UTC)
Received: from secure.mitica (unknown [10.39.194.127])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0C5E92166B28;
 Fri, 20 Oct 2023 09:07:37 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Eric Farman <farman@linux.ibm.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Gibson <david@gibson.dropbear.id.au>,
 Corey Minyard <cminyard@mvista.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Peter Xu <peterx@redhat.com>, Corey Minyard <minyard@acm.org>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Juan Quintela <quintela@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Halil Pasic <pasic@linux.ibm.com>, Leonardo Bras <leobras@redhat.com>,
 John Snow <jsnow@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Jason Wang <jasowang@redhat.com>,
 qemu-block@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefan Weil <sw@weilnetz.de>, Stefan Berger <stefanb@linux.ibm.com>
Subject: [PATCH v2 01/13] migration: Create vmstate_register_any()
Date: Fri, 20 Oct 2023 11:07:19 +0200
Message-ID: <20231020090731.28701-2-quintela@redhat.com>
In-Reply-To: <20231020090731.28701-1-quintela@redhat.com>
References: <20231020090731.28701-1-quintela@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
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

We have lots of cases where we are using an instance_id==0 when we
should be using VMSTATE_INSTANCE_ID_ANY (-1).  Basically everything
that can have more than one needs to have a proper instance_id or -1
and the system will take one for it.

vmstate_register_any(): We register with -1.

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/vmstate.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 1a31fb7293..9ca7e9cc48 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -1230,6 +1230,23 @@ static inline int vmstate_register(VMStateIf *obj, int instance_id,
                                           opaque, -1, 0, NULL);
 }
 
+/**
+ * vmstate_register_any() - legacy function to register state
+ * serialisation description and let the function choose the id
+ *
+ * New code shouldn't be using this function as QOM-ified devices have
+ * dc->vmsd to store the serialisation description.
+ *
+ * Returns: 0 on success, -1 on failure
+ */
+static inline int vmstate_register_any(VMStateIf *obj,
+                                       const VMStateDescription *vmsd,
+                                       void *opaque)
+{
+    return vmstate_register_with_alias_id(obj, VMSTATE_INSTANCE_ID_ANY, vmsd,
+                                          opaque, -1, 0, NULL);
+}
+
 void vmstate_unregister(VMStateIf *obj, const VMStateDescription *vmsd,
                         void *opaque);
 
-- 
2.41.0


