Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62ABFB172F2
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Jul 2025 16:14:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhU29-0007ev-Np; Thu, 31 Jul 2025 10:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGR-0003Sb-LI
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1uhTGO-0008Nq-Ib
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 09:24:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753968243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXKa1lb2J45tpdGDnPkjHF2vXdNA+ZMoJFnBI21EA70=;
 b=GcQK/9W/m9QGFNupyniiluKNdd4JNfu8v+nnQ4Ugmug15qKcri/W83mmho2aepdjiH2bco
 4aty4h0W2eHRNgnC+kHjrbGbn+K/epVzFmUqkyZtbdCz/e8c6gUwXQryv0RCxRwouTE6Fc
 BU0DXumotmS4ns4r3GZThuI4MleI/VI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-301-gPXL4tYbNVWScnA1nBy0lA-1; Thu, 31 Jul 2025 09:24:02 -0400
X-MC-Unique: gPXL4tYbNVWScnA1nBy0lA-1
X-Mimecast-MFC-AGG-ID: gPXL4tYbNVWScnA1nBy0lA_1753968241
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-31f3b65ce07so751743a91.1
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 06:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753968241; x=1754573041;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GXKa1lb2J45tpdGDnPkjHF2vXdNA+ZMoJFnBI21EA70=;
 b=OlEKfsD/QMbAUk+RAOcPNOsfGq5HQgNiHmfEj1FSYCThpC4sq7Le2Frry15gOJGjPG
 pjQpQCOE5N8HeB4Pi+yB40gQoXWFhiHmpBlJEIAEiLod2o5/BYU77L4jpUg50dMTub+p
 nKoLThaKz6Hb1Xg7/nJuu4gfkMP/APAp349pkAEt7B3H9+9Yh5H8bY5ElPDOuqihsHrw
 hU0Fhl89Ybjara2aXUfHRg+nxi3jRGIJtpHkyk0vQjj+RIpQrAy6uHwmRCECn8naa1X+
 0NHjFBF4OahPDn8IY3+dS+TaS7pt19dv/zcmzB2FrhtpUrMgnfFTnWkMu7ACb4aj7oPO
 vX2A==
X-Gm-Message-State: AOJu0Yw0Sn8anxEPzBe60SYrWGGUG1P+I+tt7ezMEL+EmEUKcK0fgrMg
 OHFwlQLnJK11j38XrnuRIbNvPEs1SHC5Dz9ijj1fWWm9sfUQflI3aTu6B64TpYl1ReuBQ6IIlzm
 HdqShG932c8wT56f66KWJewN7hCdNjud8w3gb6jyL5wbBEaMa4g7hGtPVCM0uW/MKOVyoPIKrOw
 xWxq7Cs1/UPz2NvY84NCd6+FFHQtYG8LdvQ8ssWGJ2sA==
X-Gm-Gg: ASbGncvHUfnBGltEGwzpY2G+tDOA0/OPuYZS0FP7NqrBDOBL7XMBhF0wrYy7j0145Uu
 dQLEcfOTws8mVd0tMikvlZ/bs4wHVXEbl0Zl6XNICGGpWL7RC9BGr3rj9vJYz4ACdob3KlD1U20
 KLGLZJz6QIjeP2EP62aVp9HEdBu89gR/afbZiDejBzlCPRNnDQxj+zScCKP8dVgakNIQcziCwnY
 +lpEFwYxynOpp72qjH5eBEz/lwROP39kc3CfhbWzuGO3l5Ym2LNu46QvxwFwMn3FlMbWnOxjGvQ
 GFgGx+rvSaHfhYf4OyLi3IrgZSTpF8DKjm6Vj1CskbR7K2Txzs3j
X-Received: by 2002:a17:90b:184b:b0:31f:20a:b52c with SMTP id
 98e67ed59e1d1-31f5dcb65b7mr11628033a91.0.1753968240974; 
 Thu, 31 Jul 2025 06:24:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFqYUnWDnKMNcEOKyhBRRKFiZH+sRye9HY1hb24NyJhTSuR6314ALdO0uRURK/Pqp3MFrnogw==
X-Received: by 2002:a17:90b:184b:b0:31f:20a:b52c with SMTP id
 98e67ed59e1d1-31f5dcb65b7mr11627958a91.0.1753968240514; 
 Thu, 31 Jul 2025 06:24:00 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.139])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3209a84d115sm2007034a91.36.2025.07.31.06.23.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Jul 2025 06:23:59 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Thu, 31 Jul 2025 18:50:53 +0530
Subject: [PATCH v8 13/27] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250731-propagate_tpm_error-v8-13-28fd82fdfdb2@redhat.com>
References: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
In-Reply-To: <20250731-propagate_tpm_error-v8-0-28fd82fdfdb2@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Steve Sistare <steven.sistare@oracle.com>, qemu-s390x@nongnu.org, 
 qemu-ppc@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=armenon@redhat.com;
 h=from:subject:message-id; bh=2gJKFMIUThLwW1sVnjuy/TtcWWXZtfyR/RkhmK0ZQq0=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ0Z37jPtQKmJgjwZr7nVP+xuqU1tcXr8ddOHBctPdRj/2
 JX/ZF1nRykLgxgXg6yYIkvD1wDZpoDCiEjbl9dh5rAygQxh4OIUgIl0dDL8lb6i+jrh2kbl4xap
 jwuvtt59K5KTfK5jWsqMR9nzl7x7EcDwV/7Ycybpq4Zxq76uvfx+Nt9zb/5XdRJ9r5/vCQ1+N23
 tP1YA
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is an incremental step in converting vmstate loading
code to report error via Error objects instead of directly
printing it to console/monitor.
It is ensured that loadvm_postcopy_handle_listen() must report an error
in errp, in case of failure.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index dd1629069444f20b035aeffa948b8edcd7ea6919..c9ca0628183312e19fc72c06f791dc4d53566c16 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2181,15 +2181,16 @@ static void *postcopy_ram_listen_thread(void *opaque)
 }
 
 /* After this message we must be able to immediately receive postcopy data */
-static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
+static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis,
+                                         Error **errp)
 {
     PostcopyState ps = postcopy_state_set(POSTCOPY_INCOMING_LISTENING);
-    Error *local_err = NULL;
 
     trace_loadvm_postcopy_handle_listen("enter");
 
     if (ps != POSTCOPY_INCOMING_ADVISE && ps != POSTCOPY_INCOMING_DISCARD) {
-        error_report("CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
+        error_setg(errp,
+                   "CMD_POSTCOPY_LISTEN in wrong postcopy state (%d)", ps);
         return -1;
     }
     if (ps == POSTCOPY_INCOMING_ADVISE) {
@@ -2212,14 +2213,14 @@ static int loadvm_postcopy_handle_listen(MigrationIncomingState *mis)
     if (migrate_postcopy_ram()) {
         if (postcopy_ram_incoming_setup(mis)) {
             postcopy_ram_incoming_cleanup(mis);
+            error_setg(errp, "Failed to setup incoming postcopy RAM blocks");
             return -1;
         }
     }
 
     trace_loadvm_postcopy_handle_listen("after uffd");
 
-    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, &local_err)) {
-        error_report_err(local_err);
+    if (postcopy_notify(POSTCOPY_NOTIFY_INBOUND_LISTEN, errp)) {
         return -1;
     }
 
@@ -2621,11 +2622,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
         return loadvm_postcopy_handle_advise(mis, len, errp);
 
     case MIG_CMD_POSTCOPY_LISTEN:
-        ret = loadvm_postcopy_handle_listen(mis);
-        if (ret < 0) {
-            error_setg(errp, "Failed to load device state command: %d", ret);
-        }
-        return ret;
+        return loadvm_postcopy_handle_listen(mis, errp);
 
     case MIG_CMD_POSTCOPY_RUN:
         ret = loadvm_postcopy_handle_run(mis);

-- 
2.50.0


