Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9251B7B9713
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xM-0004ID-AD; Wed, 04 Oct 2023 18:03:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xJ-0004Hk-JF
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xH-0003vE-9E
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:02:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VxO3OdtMyeeaxOri15W9iSHPGH8x5n6UYkaAADCs9aY=;
 b=PU4BTCNgpmB/2q7FUjc+QPP/RxiDoiKdrsJinNp2AdrgeOPPpWaLBjic9LUWYzoCSpkDYm
 M6gVQvzs7yFT9on9A9xicvc5/8TpIZf4e1VkTgP808goHaErxGBoenbJlsa+/FZdGVchvv
 GTdP+8Fcf9ZIYeCcjMwSjpe4Z6eKiE8=
Received: from mail-yb1-f197.google.com (mail-yb1-f197.google.com
 [209.85.219.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-KMXCoxP9MuiO117iMjonug-1; Wed, 04 Oct 2023 18:02:48 -0400
X-MC-Unique: KMXCoxP9MuiO117iMjonug-1
Received: by mail-yb1-f197.google.com with SMTP id
 3f1490d57ef6-d868c33252fso84847276.0
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456967; x=1697061767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VxO3OdtMyeeaxOri15W9iSHPGH8x5n6UYkaAADCs9aY=;
 b=UoHXlYDuB2Prprzy2nFvBqSbSM77qHUVZCaTsRY2zHGN66nDnSMXXu8R7J2lAPg8p4
 U5vS911yR2zXL9+24NGAQoiRetHTeRso98prw0ORUNtIJdxfvZq2kJ2R5z1X/GnWbjpD
 vG91+kDEVzQZGgapLUtiTsRgm6Awjn1rV5AySwIFsdxe9Xj2Sd5rqsM1jccwFYfljcXT
 rbhEIFQrDPBquK1gVh2+Sy+AYAfLmCSCZhc/0CSmI21DakWzyVHJPVuDd/qoqeK6syVR
 UspX1Msw5VgT5rLZz0NYZ2eeM2MXgTO8AEaRa/5GLi0sF860UESeQHtNCdLwEup2EVsu
 Qvow==
X-Gm-Message-State: AOJu0YzzebdfSEBVciO1pd1RN+9RCoVuVtW1BTWOzKXvjlG4f/KLlMqS
 WPs9pURZFq8LBhDs67qGGYqSeIVQhG5C2KIoQDhNoSmKxWWX6EZyzDMIjlZbvRK+2xZ1wyBgOCm
 XHOxBit5iFfI2/Bk5fjdKfOsrwg2irjpUzWUPFMpSYemF2dHbwBhrvZxAFuPoXgtFXn6zUypk
X-Received: by 2002:a25:ab89:0:b0:d89:49a4:448c with SMTP id
 v9-20020a25ab89000000b00d8949a4448cmr3045214ybi.2.1696456967596; 
 Wed, 04 Oct 2023 15:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEnxSiwfWYLW/ZHB7DxsuTQvAij8OoTSqeyXHt9U/MpvsqSowozeRhP8Ag3z849Hsx1Eq3b2Q==
X-Received: by 2002:a25:ab89:0:b0:d89:49a4:448c with SMTP id
 v9-20020a25ab89000000b00d8949a4448cmr3045195ybi.2.1696456967275; 
 Wed, 04 Oct 2023 15:02:47 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:46 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 05/10] qemufile: Always return a verbose error
Date: Wed,  4 Oct 2023 18:02:35 -0400
Message-ID: <20231004220240.167175-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231004220240.167175-1-peterx@redhat.com>
References: <20231004220240.167175-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

There're a lot of cases where we only have an errno set in last_error but
without a detailed error description.  When this happens, try to generate
an error contains the errno as a descriptive error.

This will be helpful in cases where one relies on the Error*.  E.g.,
migration state only caches Error* in MigrationState.error.  With this,
we'll display correct error messages in e.g. query-migrate when the error
was only set by qemu_file_set_error().

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index ffa9c0a48a..c12a905a34 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -142,15 +142,24 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
  *
  * Return negative error value if there has been an error on previous
  * operations, return 0 if no error happened.
- * Optional, it returns Error* in errp, but it may be NULL even if return value
- * is not 0.
  *
+ * If errp is specified, a verbose error message will be copied over.
  */
 int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
 {
+    if (!f->last_error) {
+        return 0;
+    }
+
+    /* There is an error */
     if (errp) {
-        *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
+        if (f->last_error_obj) {
+            *errp = error_copy(f->last_error_obj);
+        } else {
+            error_setg_errno(errp, -f->last_error, "Channel error");
+        }
     }
+
     return f->last_error;
 }
 
-- 
2.41.0


