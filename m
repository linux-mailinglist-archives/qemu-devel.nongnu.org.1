Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FFC5741B26
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 23:51:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEd3T-0001LJ-RV; Wed, 28 Jun 2023 17:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3H-0001J6-MV
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qEd3G-0008PB-7M
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 17:50:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687989012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nfLmUWQ8pB+Gq1IgpYYS03S4VtZKbHTf8LZ4fkY7mg=;
 b=ED6avEs1BlOzh3tGUAmH0+oCtHs68jqlqsKmiFtP3obg9udSiZ7IG/BAZ6IzowGs0ZV3xC
 QmtBfQiF6LZk489aRK3II/UhewELudaMGFyaOHJsaUiAnWz9E/mVXKmhY27JrmHL29sJPF
 l8bNgtB9dO2DQIt5qKd3OsMGtfvlUjI=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-aK1qlQawNOCC42VJGncZEw-1; Wed, 28 Jun 2023 17:50:11 -0400
X-MC-Unique: aK1qlQawNOCC42VJGncZEw-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-401df9d2dc4so49461cf.0
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 14:50:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687989010; x=1690581010;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nfLmUWQ8pB+Gq1IgpYYS03S4VtZKbHTf8LZ4fkY7mg=;
 b=WrDQwdZLRF8nBf/Cc3lNpQjbLwOuXM+INh8Pgtr58XjMHesYJGWeKmdrqJc+CPger+
 JXNh+Zkog1lgVq7T9v2r692Rm7j2w63yufj8D9X00ZP1AYHVEmQ2MHTKjQhmNdzuqNwP
 2YioiSjy6S/O0h0rHxe6FXVbSmoBzx8Eceoqj1rW8PnHPzhxWbGOhSvImxq/X9pZJRDE
 gfpcgUB5RCBLJl79OyH/O/h/S3Vl/PWSw1uzSy1bQS2tjB6LEt+GHuDq6r9UNqhDT1pL
 GPNy1JXRFywLPBgB15vGyTA2h0PYmiLCX5ESCUzbmY1Dn+vfx1ymPlgOCg5Zo0klri3Z
 mKAA==
X-Gm-Message-State: AC+VfDzfdpE/wDAKKIEsJXAsf6/ALKvOgp73r5m6QEKy3Y4hvGLAjr+A
 qosexMECHaANM99qN+jdMG1j+WZ9K+Xijn4wVAlFtBIOSagplVNBWMWpL1fx3HRpvEcYqI4RMY4
 07sDRBV1tn1ft1aDmHH994j63TESteqWR13bZ2xjvxNQXLZMIAUCnp5qFBXUn7bvJqpkYIGvP
X-Received: by 2002:ac8:7d83:0:b0:400:990c:8f7c with SMTP id
 c3-20020ac87d83000000b00400990c8f7cmr14882219qtd.0.1687989010498; 
 Wed, 28 Jun 2023 14:50:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6n8+yg0+ZfD7+yh4o1pn41UJz8kT4F7tMRXN2TIPJxZnGGz0H2kOEzHAwKv2f5E3iLxSPBmw==
X-Received: by 2002:ac8:7d83:0:b0:400:990c:8f7c with SMTP id
 c3-20020ac87d83000000b00400990c8f7cmr14882199qtd.0.1687989010097; 
 Wed, 28 Jun 2023 14:50:10 -0700 (PDT)
Received: from x1n.. (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 w29-20020ac84d1d000000b004032d9209a0sm255552qtv.50.2023.06.28.14.50.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 14:50:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 6/7] qemufile: Always return a verbose error
Date: Wed, 28 Jun 2023 17:50:01 -0400
Message-ID: <20230628215002.73546-7-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230628215002.73546-1-peterx@redhat.com>
References: <20230628215002.73546-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index acc282654a..419b4092e7 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -156,15 +156,24 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
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


