Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C2BB3CCAF
	for <lists+qemu-devel@lfdr.de>; Sat, 30 Aug 2025 18:12:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usNd7-0000tM-IP; Sat, 30 Aug 2025 11:36:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5LV-0005Wt-9u
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:05:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1us5LS-0004x3-75
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 16:05:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756497909;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wm02YWFPgXK6tLalWRdl7gepF4qWtk92F6eyDxpJHBE=;
 b=eHq1xw9tq5jUwlNmIm5jqkM1bK0tzqrhpfVou42+H1rJDVAcXJHXiZrrxFxr/NVqIKkvlE
 N7z0drgMKlFbQgf1EfQesVprn8y+BvdRzAeDs3qo3qvcoLuBPevwEEOsT4TwCEaJPAb6A/
 kdryxZMRIcuj2JB+TbanTbzHrDeXMpE=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-108-xxBHHK7OMbC31dCVouphoQ-1; Fri, 29 Aug 2025 16:05:07 -0400
X-MC-Unique: xxBHHK7OMbC31dCVouphoQ-1
X-Mimecast-MFC-AGG-ID: xxBHHK7OMbC31dCVouphoQ_1756497906
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-3259ff53c2eso3589053a91.1
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 13:05:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756497906; x=1757102706;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Wm02YWFPgXK6tLalWRdl7gepF4qWtk92F6eyDxpJHBE=;
 b=okKN5cCYlqMZmXelrVmeUqQtZ1aHX99KO96LEM+csHBKtqUgkKsegmA2g461G6h5j3
 BDRKxbpwSdT5IQsyz+19TOK/i7H34VUrGpDOrf5iu2h2UVA0gr5VmWmwTRKZg05mR9Xo
 644smQz8OW+kwi9KCaITDABLp4OtfFMUOB/NJ+mjnqw6vMeRhpxi6FevvAVT/CG95zsD
 U3YAfKKPLiGm0h7SEk4H4/URf82eh4Bdd2Q5otg7tS6VkqeHRr6AzqI4qcHkl3INZdMt
 e49OBTrRLvejQ90KXMAlq3xme10Lxrhg8h9M5RKeupY9e8Edta1ZSLh85prThS0bnDSH
 gdpA==
X-Gm-Message-State: AOJu0YzFRFLbgczIPsH1/lPs0+8gjyOIPg26Szh3CxP6H+/gzcXmC9mt
 O2r0p1mxXSgOyEsjrXJdmppMH/txjRqlijrCXFey0RI95+to5mrzvlZtWxotcPf6gkNxXdqSe53
 rPFRwpWyU2iCycAdLm5zbTx1ivvt5vTWOP1+fHUao0FMtCtz2a+ohOOiN
X-Gm-Gg: ASbGncv8dbcOvJikgcpikdDbIY2jLfPtWzXtEoXSIyoluQUdeK6MHw/lMC5ghxr4eOA
 MGvuO2DKlHkCZKlyuVUCNbgiJuW6IhjDQylHCOso1ZJ1myUMOhHYWFDNRDdqoWRxQpd3uRGUmDB
 ozf9ORd7r/eqPY1leU323z8W98piYRQAnIplbx/ymmUiLLSEbnjidOomkInQkgSV7pIOFWVjvKn
 1EY1EnHmdiuHXEO7m6YXiefpqiv4LauNjERc+SLDUk1WesIWO3pCs6ctImt1D9O/r3Qke2XALMo
 kydpo1tWfDMsi2vFnEbuMoOcaxbHOJooRVtXviMvGm2wJaexo6F5yA==
X-Received: by 2002:a17:90b:5627:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-32515eaafdcmr40744262a91.19.1756497906038; 
 Fri, 29 Aug 2025 13:05:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGlLHP+tT/LriDsdFC737V2EcYVvDdYR+0Tbu/PHzwEggq5Qw/fGkv9NeBWXVjw8VDQTAu+TQ==
X-Received: by 2002:a17:90b:5627:b0:31e:ec58:62e2 with SMTP id
 98e67ed59e1d1-32515eaafdcmr40744196a91.19.1756497905451; 
 Fri, 29 Aug 2025 13:05:05 -0700 (PDT)
Received: from armenon-kvm.bengluru.csb ([49.47.195.108])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-327d8f66f16sm3570543a91.0.2025.08.29.13.04.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:05:05 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
Date: Sat, 30 Aug 2025 01:31:51 +0530
Subject: [PATCH v13 11/27] migration: push Error **errp into
 qemu_loadvm_section_part_end()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20250830-propagate_tpm_error-v13-11-a4e777b7eb2c@redhat.com>
References: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
In-Reply-To: <20250830-propagate_tpm_error-v13-0-a4e777b7eb2c@redhat.com>
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
 Arun Menon <armenon@redhat.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3094; i=armenon@redhat.com;
 h=from:subject:message-id; bh=CgLPVCj6slw8FkUxePJRDJzlIhYmWPhKwDSIMzJ0/CA=;
 b=owGbwMvMwCWWVaVqcZPfqI/xtFoSQ8Ymdl/Wz1qhOT+auW8d+f9ap8nmVEhhjPdL9elLNTIWq
 6xUT9/ZUcrCIMbFICumyNLwNUC2KaAwItL25XWYOaxMIEMYuDgFYCKxfYwMB3VWZS44I7HwT/Id
 jy23q1+evpa53SNFfdGSSl+3JxazLzL8M4097hE54+Zc3/a+Da3nju5385pxLfMur13Z70zdDCM
 FHgA=
X-Developer-Key: i=armenon@redhat.com; a=openpgp;
 fpr=80F5501D82507158593DE9D76A7A2538D90F328E
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
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
It is ensured that qemu_loadvm_section_part_end() must report an error
in errp, in case of failure.
This patch also removes the setting of errp when errp is NULL in the
out section as it is no longer required in the series.

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Arun Menon <armenon@redhat.com>
---
 migration/savevm.c | 18 +++++++-----------
 1 file changed, 7 insertions(+), 11 deletions(-)

diff --git a/migration/savevm.c b/migration/savevm.c
index 01e1a9739aa784d90f80bf2b561fd62f5e4678f8..c8234f2ef7f413b207aebae7192c82f1f4d6d91d 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2803,21 +2803,19 @@ qemu_loadvm_section_start_full(QEMUFile *f, uint8_t type, Error **errp)
 }
 
 static int
-qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
+qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type, Error **errp)
 {
     bool trace_downtime = (type == QEMU_VM_SECTION_END);
     int64_t start_ts, end_ts;
     uint32_t section_id;
     SaveStateEntry *se;
     int ret;
-    Error *local_err = NULL;
 
     section_id = qemu_get_be32(f);
 
     ret = qemu_file_get_error(f);
     if (ret) {
-        error_report("%s: Failed to read section ID: %d",
-                     __func__, ret);
+        error_setg(errp, "Failed to read section ID: %d", ret);
         return ret;
     }
 
@@ -2828,7 +2826,7 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         }
     }
     if (se == NULL) {
-        error_report("Unknown savevm section %d", section_id);
+        error_setg(errp, "Unknown section %d", section_id);
         return -EINVAL;
     }
 
@@ -2836,9 +2834,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
         start_ts = qemu_clock_get_us(QEMU_CLOCK_REALTIME);
     }
 
-    ret = vmstate_load(f, se, &local_err);
+    ret = vmstate_load(f, se, errp);
     if (ret < 0) {
-        error_report_err(local_err);
         return ret;
     }
 
@@ -2849,6 +2846,8 @@ qemu_loadvm_section_part_end(QEMUFile *f, uint8_t type)
     }
 
     if (!check_section_footer(f, se)) {
+        error_setg(errp, "Section footer error, section_id: %d",
+                   section_id);
         return -EINVAL;
     }
 
@@ -3108,7 +3107,7 @@ retry:
             break;
         case QEMU_VM_SECTION_PART:
         case QEMU_VM_SECTION_END:
-            ret = qemu_loadvm_section_part_end(f, section_type);
+            ret = qemu_loadvm_section_part_end(f, section_type, errp);
             if (ret < 0) {
                 goto out;
             }
@@ -3132,9 +3131,6 @@ retry:
 
 out:
     if (ret < 0) {
-        if (*errp == NULL) {
-            error_setg(errp, "Loading VM state failed: %d", ret);
-        }
         qemu_file_set_error(f, ret);
 
         /* Cancel bitmaps incoming regardless of recovery */

-- 
2.51.0


