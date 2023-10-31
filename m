Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2557DCB7F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 12:12:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxmeQ-0004Gm-53; Tue, 31 Oct 2023 07:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeM-00044d-KG
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qxmeL-0006yE-4F
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 07:11:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698750668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNIgHrPt9JhOHk+Y2mehidionIz89QnAOqiaB1F8Coc=;
 b=bADBkZzIZ+Mi/Ny/k3bFDu8piIFI7VFQEN42I6Zd2zqysJ+WiHUCsN7723QsLh03CKGyKL
 YQ5+329B0PbstBaG0ybtSCYaYed0cNuZJmklV32E2wipot2CXiPOG1tRn/dZb3uYLOWUnA
 b83VpN1Jh4Tq4yr680ftomf9ZhTlPgY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-599-SilIjqvNML2kc1H4_bOHtg-1; Tue, 31 Oct 2023 07:11:02 -0400
X-MC-Unique: SilIjqvNML2kc1H4_bOHtg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 58B8588D58A;
 Tue, 31 Oct 2023 11:11:02 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 334382166B26;
 Tue, 31 Oct 2023 11:11:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F121E21E6922; Tue, 31 Oct 2023 12:10:59 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org,
 david@gibson.dropbear.id.au, harshpb@linux.ibm.com, dave@treblig.org,
 jasowang@redhat.com, michael.roth@amd.com, kkostiuk@redhat.com,
 mst@redhat.com, david@redhat.com, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-ppc@nongnu.org
Subject: [PATCH 6/7] balloon: Fix a misleading error message
Date: Tue, 31 Oct 2023 12:10:58 +0100
Message-ID: <20231031111059.3407803-7-armbru@redhat.com>
In-Reply-To: <20231031111059.3407803-1-armbru@redhat.com>
References: <20231031111059.3407803-1-armbru@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

The error message

    {"execute": "balloon", "arguments":{"value": -1}}
    {"error": {"class": "GenericError", "desc": "Parameter 'target' expects a size"}}

points to 'target' instead of 'value'.  Fix:

    {"error": {"class": "GenericError", "desc": "Parameter 'value' expects a size"}}

Root cause: qmp_balloon()'s parameter is named @target.  Rename it to
@value to match the QAPI schema.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 system/balloon.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/system/balloon.c b/system/balloon.c
index e0e8969a4b..fda7af832e 100644
--- a/system/balloon.c
+++ b/system/balloon.c
@@ -90,17 +90,17 @@ BalloonInfo *qmp_query_balloon(Error **errp)
     return info;
 }
 
-void qmp_balloon(int64_t target, Error **errp)
+void qmp_balloon(int64_t value, Error **errp)
 {
     if (!have_balloon(errp)) {
         return;
     }
 
-    if (target <= 0) {
-        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "target", "a size");
+    if (value <= 0) {
+        error_setg(errp, QERR_INVALID_PARAMETER_VALUE, "value", "a size");
         return;
     }
 
-    trace_balloon_event(balloon_opaque, target);
-    balloon_event_fn(balloon_opaque, target);
+    trace_balloon_event(balloon_opaque, value);
+    balloon_event_fn(balloon_opaque, value);
 }
-- 
2.41.0


