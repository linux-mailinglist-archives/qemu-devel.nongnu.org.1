Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 34E0DB1E2FF
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Aug 2025 09:18:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ukHMS-0001yI-DZ; Fri, 08 Aug 2025 03:17:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLi-0007T0-5F
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ukHLf-0007Qn-9m
 for qemu-devel@nongnu.org; Fri, 08 Aug 2025 03:17:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754637426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JGz+pEiXmUMAsQVHsZAatBKd/T5a110fAjdAVhA6b0c=;
 b=Bg4yrTiTSQBDFvPNxT6yZ/gN7SGZGkC8fgC3l9Iny2vn0lUX14CBatRskfKarWEbHeRhCR
 QBx7TmcmRuUpTcB/Mm0hWcoUfAZsAu5B7Y7VfTNIVaFAUND7nSuUXtCvu/qd5E2VFQ7DoR
 yMe+JYH5/K2hUU06WtjmFbh/J65Fy3s=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-_eYIjW-6Py2L3TCIwAj9-g-1; Fri, 08 Aug 2025 03:17:04 -0400
X-MC-Unique: _eYIjW-6Py2L3TCIwAj9-g-1
X-Mimecast-MFC-AGG-ID: _eYIjW-6Py2L3TCIwAj9-g_1754637423
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-3211b736a11so4057664a91.0
 for <qemu-devel@nongnu.org>; Fri, 08 Aug 2025 00:17:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754637423; x=1755242223;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JGz+pEiXmUMAsQVHsZAatBKd/T5a110fAjdAVhA6b0c=;
 b=NyjfSIwc3KD+q+CyWj6WpamBpKUI7CdX3nBKtRXB7ls4TTCdCpt2VXfzXDdBvHEMm4
 JbuvrfY78JOfi0KM76hzG106Jl2/V2qCAzUKnWzUgQcRf/lJ5WVtdhHDCsiVbGjSCRq+
 MwGjg3XsdvCavfnvr74YNOxPHn7HRSVF17bhe9ku5TPTsE9SrIRvXkhAirCnHgBBg3ad
 5BCGvHEW3kdO8xK2Wxr/ADFUbE1q1xbA0I81E+DXk8uQmClIM9ATAMVDaIiPDnYBrjcv
 I9uJzJ5Ofy9WpKW/9j53VVaLYLnTWqiI9GhYWdJs16NKeEsgRIxKqG42NztcoKuhwks1
 RHKQ==
X-Gm-Message-State: AOJu0YztyrmWRMXGnqVKH9kFKCG9q8ozIR+yUjWuL0SlGXdWB5HQieCP
 C41OcQHHiXppKUHGJeQvZla1NrX592hamkl09eoDTdnMAyhNxJEr6QW+SpyCfF8aBT+nQmXjC3B
 Sjxy0YxcZi4YSdFvkO23SnCtaNxV4f5CUBL2b2E4i0Jf0qwasMryTgAmf
X-Gm-Gg: ASbGncsEP+Fk8mHiIAsgUb7SgfaFQCBFZ+dIecSpfPr49hAJVAiEJ57KK+6OfVHZKBU
 iKuwrB1GVq6V+HnDiPpdg50COGEdQTQTZRrIGfFQuLj8ftVKYbdA4zCW8QnkVMMP5pZKyY5YTvC
 TuR9png9koRq1GcwYPvMQYwGve0nhSJkFFGD1pX+po8WK3BbxoGsZ3kfkZZY4i389ekeZzFRqp0
 TXSuutZHxVYvjq842JOdz6LxTtGFilAvjLzbHlDXBjzWwiZgSUIDrxtk25RF5AJfmdrDXqTZQum
 vdfX0V9tzsAa2bwIxwxIkzCpv3MZReuqeU4GUBO7L6/GH1QaludKZg==
X-Received: by 2002:a17:903:1a44:b0:23c:7c59:c74e with SMTP id
 d9443c01a7336-242c19aaf6dmr26443445ad.0.1754637423459; 
 Fri, 08 Aug 2025 00:17:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqNBLtNYG5TbfwSVJqO+yyHBT8LSNhXqnEktVEw9A8ooWaxYEORAIWhZJeOMlayjJ36TpS8A==
X-Received: by 2002:a17:903:1a44:b0:23c:7c59:c74e with SMTP id
 d9443c01a7336-242c19aaf6dmr26443125ad.0.1754637423088; 
 Fri, 08 Aug 2025 00:17:03 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.101.237])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241e899d347sm199659385ad.140.2025.08.08.00.16.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Aug 2025 00:17:02 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Fri, 08 Aug 2025 12:43:42 +0530
Subject: [PATCH v10 16/27] migration: push Error **errp into
 loadvm_postcopy_handle_listen()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250808-propagate_tpm_error-v10-16-3e81a1d419b2@redhat.com>
References: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
In-Reply-To: <20250808-propagate_tpm_error-v10-0-3e81a1d419b2@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, 
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Steve Sistare <steven.sistare@oracle.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>, 
 qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, 
 Hailiang Zhang <zhanghailiang@xfusion.com>, 
 Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, 
 Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2705; i=armenon@redhat.com;
 h=from:subject:message-id; bh=vBw3qJ6drqDLoD5OBi9CYCpF6NZ6n0rBrGUXpYaRnMA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8bUxVcnsvtHuG/QVt2jcbpgwpedZ999rz3CfNZow8I1v
 oITXh9S6ihlYRDjYpAVU2Rp+Bog2xRQGBFp+/I6zBxWJpAhDFycAjARzQKGf2YLZ0/4vnhehZCH
 dYIA6ztlq/R45kYvFyNdbvuwGXcSGBj+u1YfjU6qMzuwPrN+/pKZ3vMeHH5cs9w5a2n+c5vTYZN
 P8gAA
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
index 69c482b6fef5afca9ca02f9ac86339ffe1524e2a..d5082ee1cbce6a870871aaf78ed47707787ffaed 100644
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
 
@@ -2624,11 +2625,7 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
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
2.50.1


