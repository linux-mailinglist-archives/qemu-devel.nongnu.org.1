Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ADE778D036
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:18:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mw-0000jX-L7; Tue, 29 Aug 2023 19:06:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U6-0006Lk-Vq
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U4-0000ht-EQ
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6uAjHfWVV5l02g/VMaRfP8rGJHV6qapnjAjrMo0sFg=;
 b=Ama8xN7uLvHm7M/NjH6xrsSsvzEjBdwFy7vVVKWyZa4xJR3iIfzXlT/ErUyLDCuizU2ofh
 n4C/0wjPHT/u0b00mG0k4abipoDRFpH1Cly63LnHDcENdClwWN2dnNJQQ90YapB1fWV1ix
 qNNdxwDCN3L5u6LFWFOyqoDnA4Wy0cU=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-248-RSUVXUJ4OYiAlT1LCxzNYA-1; Tue, 29 Aug 2023 17:42:46 -0400
X-MC-Unique: RSUVXUJ4OYiAlT1LCxzNYA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-1c55535c088so1582310fac.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345365; x=1693950165;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6uAjHfWVV5l02g/VMaRfP8rGJHV6qapnjAjrMo0sFg=;
 b=XcIoKz7jBCUh09Idsv/XjPUdpTvtCVuyXXSOwqAKePsZpBjbXYywijeWS5PIuCXcOv
 fB2LUzqQ4eb3KXLoSM3G0oV42b1lfq/ADqg3zWb6apZcPSjEF9vjRg0blDDTYRrWsMzf
 R+/4nmaCHIbyIhVDT0tE/jEjIpg374lLTxHA5hF1TaZPMYRVGABebXbQtemOhsbBS1OE
 VIFzSeuCALL+zxKhCxbT+sd+nd82nZagm6Lneki3QVjIaeQ+MzzEFy5ahiSE7MbZXnWK
 M4X6QsxwOgRClzd12EhB8Pr3miwnUWw9awGz4gpFP6ZfZ2FCTJvGxflAVLTtOgRCU/E0
 T2pQ==
X-Gm-Message-State: AOJu0YySK8TyYE4ZmlZFbEA2l18PKD66MwHXY6jDKy3bKSSMnOA97XbP
 zbhD8wfszj8m0u1suCamsElJyi73IBT6o1GbXctApu5eKL94DEHgof1UDrnFHYjfAcPwqxnlOUd
 npcbQ6bm8Z8JECI0nHDxbDq4zMuxmwGUYXJ+dDLxDPS94EGVQZDC1qG0vs3C/XLt1f6dSPbbW
X-Received: by 2002:a05:6830:459d:b0:6bc:a824:2750 with SMTP id
 az29-20020a056830459d00b006bca8242750mr297214otb.2.1693345365735; 
 Tue, 29 Aug 2023 14:42:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH7A+paXKHllIsacA1/7iMHXlIvhD23pCPCRJtHI6qnDDKBOH+bI4Q3+C8blQTJuhxBO65HuQ==
X-Received: by 2002:a05:6830:459d:b0:6bc:a824:2750 with SMTP id
 az29-20020a056830459d00b006bca8242750mr297201otb.2.1693345365337; 
 Tue, 29 Aug 2023 14:42:45 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:44 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 6/9] qemufile: Always return a verbose error
Date: Tue, 29 Aug 2023 17:42:32 -0400
Message-ID: <20230829214235.69309-7-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230829214235.69309-1-peterx@redhat.com>
References: <20230829214235.69309-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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
index eea7171192..3e64e900c9 100644
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


