Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 26600B1BA20
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Aug 2025 20:34:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ujMTo-0000kn-9E; Tue, 05 Aug 2025 14:33:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMQ1-0008Dt-Cj
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1ujMPw-0004Ci-TZ
 for qemu-devel@nongnu.org; Tue, 05 Aug 2025 14:29:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754418583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TaboU7zUyZ+wdmC/AvAgIvsj62POPl+ga+Ly2TPzv14=;
 b=F9njDh7M4uddISmGHjuVmssRuc9bEHR7jL9TASK4gZSfLT+FhIS2mhCACYlvdr68LBOcLW
 AnF7DUmsPbJKmnUtzxu2xGhWsncAMv2m/SZDyBsY5bEom0EAYzBnD0M1muFQajprz71Bwz
 FQuNMpSBiELt+bgckd0ytI6jbvfVQrY=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-sbaXyPQYOnaEL-O2rQDAAw-1; Tue, 05 Aug 2025 14:29:42 -0400
X-MC-Unique: sbaXyPQYOnaEL-O2rQDAAw-1
X-Mimecast-MFC-AGG-ID: sbaXyPQYOnaEL-O2rQDAAw_1754418582
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-24011c9da24so1069175ad.1
 for <qemu-devel@nongnu.org>; Tue, 05 Aug 2025 11:29:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754418582; x=1755023382;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=TaboU7zUyZ+wdmC/AvAgIvsj62POPl+ga+Ly2TPzv14=;
 b=K3GL2pl/5AeOauVQJl0NvYFwHbM54IZvU5qFFIoX4Hd1VOjeIPV9ybOWf4cV0Qey5H
 2SaI7ORzsz3tX3y2iLgJNHreGUOZCmH/ayrRR2+ZZMZSO/4he4lnciNrOzMAkc8ThpMM
 Iqt92gRFM6ATZRl4cP6PACLnLwu9UVckRibpNmkC3kjSfivCpx2HiiCyz7k1TTh7t2wP
 S2terzojPLWPCJhLaVIz4bqDuLKUJaKl96wlB1xwa9oLLkrHsDR2KzMCE02m5Qdnrtng
 o5LbXNiiLTMIa+ugfpN26AlHXjxZiXw+ojfUnJj7Csgp/yNv9UVr0r0Re6YmCRVs9OeD
 6omw==
X-Gm-Message-State: AOJu0Ywn94GZHoSsHV1SWY3dHxCyewrrpxvO8yM3XnP14TrcYU1xE1l3
 T8QgRu/OBpNE44LpgnCr5Vv+OnXBaHQFrWYoVaJhxEFW3mkEoyZXRJbUZbCgrOfetmfW2pVnsnK
 9v36CMsrn+GGVbRDpxkwpQM65xPEkzeiUv72BTq40uuFHOY1n6DnlnQSy
X-Gm-Gg: ASbGncv8c1d3ypComUWeHe3B2D0+Q/5eHt9YmGDq6iUUVsBQC0eUJb0xzcPBZw0aOd/
 AOT8WLUoz4D8YKzxwi3QBjK7xtUya82S1w+LTY3d2aEfQkzjPqFUamIkYurQrAXLww3Yv+5dHvo
 JsMojdR9s+3hCgH2ltgb1Zs4BocYjwlzAtrsd05bniWKnQFoMm+2jgIKgGuoJ0agGsLQc7k/5V/
 SfZOKNykyJr2w8AhoIQOoJf7vexRqRlq36GQ1kKhzlOE8+fZa0j14e6ykIRzmxyu4h+S3a/CwxX
 PkpHLxpvEj+JFX5v58GIwTyY8pmRVXjgkUyV8I9oxVi3yLth7Q==
X-Received: by 2002:a17:903:124e:b0:240:3dfd:99a2 with SMTP id
 d9443c01a7336-24288d74a21mr62595445ad.10.1754418581593; 
 Tue, 05 Aug 2025 11:29:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqu9Kykyd4AfdZypou/4mY571iuPVCTMk+FVJMc45wzitHv6QRniDilM5RDJg5dTGHNu46Vw==
X-Received: by 2002:a17:903:124e:b0:240:3dfd:99a2 with SMTP id
 d9443c01a7336-24288d74a21mr62595115ad.10.1754418581187; 
 Tue, 05 Aug 2025 11:29:41 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.36.99.3])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-241d1f0e585sm139200115ad.40.2025.08.05.11.29.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Aug 2025 11:29:40 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Tue, 05 Aug 2025 23:55:19 +0530
Subject: [PATCH v9 12/27] migration: Update qemu_file_get_return_path()
 docs and remove dead checks
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250805-propagate_tpm_error-v9-12-123450810db7@redhat.com>
References: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
In-Reply-To: <20250805-propagate_tpm_error-v9-0-123450810db7@redhat.com>
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
 Stefan Berger <stefanb@linux.vnet.ibm.com>, Arun Menon <armenon@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3858; i=armenon@redhat.com;
 h=from:subject:message-id; bh=/2xULR40zKIsjfAF1Au17FEoqrqB3ypLerXyx922t84=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8YkX5m8TKa1N5NiIr8qtL8OTypY28bSvqlnKt+E/AMrZ
 6bt1gvqKGVhEONikBVTZGn4GiDbFFAYEWn78jrMHFYmkCEMXJwCMBHnfob/7gVOLzZuiX04fdNF
 eeNVL/uXpm1W1tgTruvs+1OrZYvZR0aGp/uXTi31Vwk02v1yV8G3mlfTO5uYH7T63lXwuPSR5/h
 RXgA=
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The documentation of qemu_file_get_return_path() states that it can
return NULL on failure. However, a review of the current implementation
reveals that it is guaranteed that it will always succeed and will never
return NULL.

As a result, the NULL checks post calling the function become redundant.
This commit updates the documentation for the function and removes all
NULL checks throughout the migration code.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/colo.c      |  4 ----
 migration/migration.c | 12 ++----------
 migration/qemu-file.c |  1 -
 migration/savevm.c    |  4 ----
 4 files changed, 2 insertions(+), 19 deletions(-)

diff --git a/migration/colo.c b/migration/colo.c
index a96e4dba15516b71d1b315c736c3b4879ff04e58..71842c798a1dbbea6a7ccf8cb64e2c836c0f574c 100644
--- a/migration/colo.c
+++ b/migration/colo.c
@@ -850,10 +850,6 @@ static void *colo_process_incoming_thread(void *opaque)
     failover_init_state();
 
     mis->to_src_file = qemu_file_get_return_path(mis->from_src_file);
-    if (!mis->to_src_file) {
-        error_report("COLO incoming thread: Open QEMUFile to_src_file failed");
-        goto out;
-    }
     /*
      * Note: the communication between Primary side and Secondary side
      * should be sequential, we set the fd to unblocked in migration incoming
diff --git a/migration/migration.c b/migration/migration.c
index bb7d5e1dee52692cbea1d2c8fdca541e6a75bedb..6962dc7d7f3e0121d28994c98f12f9f2258343d7 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2647,12 +2647,9 @@ out:
     return NULL;
 }
 
-static int open_return_path_on_source(MigrationState *ms)
+static void open_return_path_on_source(MigrationState *ms)
 {
     ms->rp_state.from_dst_file = qemu_file_get_return_path(ms->to_dst_file);
-    if (!ms->rp_state.from_dst_file) {
-        return -1;
-    }
 
     trace_open_return_path_on_source();
 
@@ -2661,8 +2658,6 @@ static int open_return_path_on_source(MigrationState *ms)
     ms->rp_state.rp_thread_created = true;
 
     trace_open_return_path_on_source_continue();
-
-    return 0;
 }
 
 /* Return true if error detected, or false otherwise */
@@ -4011,10 +4006,7 @@ void migration_connect(MigrationState *s, Error *error_in)
      * QEMU uses the return path.
      */
     if (migrate_postcopy_ram() || migrate_return_path()) {
-        if (open_return_path_on_source(s)) {
-            error_setg(&local_err, "Unable to open return-path for postcopy");
-            goto fail;
-        }
+        open_return_path_on_source(s);
     }
 
     /*
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index b6ac190034f777dbde0da1598483a892089d7538..f9ccee9a1091ecbd37e6b7d2081a4446442b544d 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -125,7 +125,6 @@ static QEMUFile *qemu_file_new_impl(QIOChannel *ioc, bool is_writable)
 
 /*
  * Result: QEMUFile* for a 'return path' for comms in the opposite direction
- *         NULL if not available
  */
 QEMUFile *qemu_file_get_return_path(QEMUFile *f)
 {
diff --git a/migration/savevm.c b/migration/savevm.c
index 1b93df7894dd332aea25da91e24d02fa16e73363..b6b3f3fae742ae9d72d3af6e68440e14ffd30b0c 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2588,10 +2588,6 @@ static int loadvm_process_command(QEMUFile *f, Error **errp)
             return 0;
         }
         mis->to_src_file = qemu_file_get_return_path(f);
-        if (!mis->to_src_file) {
-            error_report("CMD_OPEN_RETURN_PATH failed");
-            return -1;
-        }
 
         /*
          * Switchover ack is enabled but no device uses it, so send an ACK to

-- 
2.50.1


