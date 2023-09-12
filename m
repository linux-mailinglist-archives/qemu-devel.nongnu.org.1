Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A64279DBD1
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlf-0007pA-JI; Tue, 12 Sep 2023 18:21:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlc-0007n2-Fq
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBla-0003HK-85
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YAzT2eHRbTEBEbzmQG0Ajv8gsQX/6uCZfW69b400/b4=;
 b=Bl7EQbLHpgnu2EgWIQgOjZ6ODZQvl4AzquD+Tm9QHBWgpKyaK+VAZYTFB885EJY8D+xwnN
 ih0oG61anYFjPYwtYQzNiCj3Ga/FDlW1Tw7uJ9fuvzG80hRf55Cl5rwpF3q8bY4l+ZE+t/
 7/NrU+pHxVo1Dc5+Y/9qzsFzgmYpE7k=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-195-2hIiWnFpPnKL9z7FToVOxA-1; Tue, 12 Sep 2023 18:21:52 -0400
X-MC-Unique: 2hIiWnFpPnKL9z7FToVOxA-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-76f0d1c4045so92480185a.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557311; x=1695162111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YAzT2eHRbTEBEbzmQG0Ajv8gsQX/6uCZfW69b400/b4=;
 b=UMT7nmFp6bYOJa5eu5ne06uFS5DCcJDguFxeCjCSIpUJD/BvPpT9DN2VlWvaQkT/4o
 1FhKS0quU8PDLxflY9nbZf0uBJMBQLPyuraevpciBSp0hzQxArjFukj1hnGrGKiFoaYy
 v6leZwLbCJmuxMtZG98Xx5RxW3Q13JeiFEAqQIlZYMtIqaQYMUrINn46nPjypPnpedx4
 5222nneCW8tcLwr2uZDvNC9s3inX3V36vHXSqgJ8v6oZgpGLQtQUtrW5YL4j0jS7pRDw
 Uh5B+L7ypLCorYHhS67ryNHTy+xbN2a0iUF6TQug1289As0YlMRvLEkAhLAdQxNwQdqn
 jYrw==
X-Gm-Message-State: AOJu0YxBTH+nibnTCxKR+AgFHed1gfchI2loWL+CSeX/TLD+XF++iVVi
 G0A+PTi6YwCLyQ6bTjD5sllN4cjez3K91yrEzGL84sUdjd8Eu/HdzcVxyzaLXjUpY9qqvLWQ+jF
 5HRqWV3LB7JzDJLa9IuSN5ccJVpVFMeXeNHB45IpNg1R/XJ/vduODLkqmxd4ae7DyV0tjx+Oo
X-Received: by 2002:a05:620a:4590:b0:76d:9f3e:de94 with SMTP id
 bp16-20020a05620a459000b0076d9f3ede94mr736155qkb.5.1694557311593; 
 Tue, 12 Sep 2023 15:21:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJm4DOpTI2eoqqGKYRSHgD3A5TdGx47o/QaM5dHzAsTKgcV9r628yjhuAGXL5SBh4Xu8j5Ww==
X-Received: by 2002:a05:620a:4590:b0:76d:9f3e:de94 with SMTP id
 bp16-20020a05620a459000b0076d9f3ede94mr736143qkb.5.1694557311205; 
 Tue, 12 Sep 2023 15:21:51 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 05/11] migration: Deliver return path file error to migrate
 state too
Date: Tue, 12 Sep 2023 18:21:39 -0400
Message-ID: <20230912222145.731099-6-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230912222145.731099-1-peterx@redhat.com>
References: <20230912222145.731099-1-peterx@redhat.com>
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

We've already did this for most of the return path thread errors, but not
yet for the IO errors happened on the return path qemufile.  Do that too.

Remember to reset "err" always, because the ownership is not us anymore,
otherwise we're prone to use-after-free later after recovered.

Re-export qemu_file_get_error_obj().

Reviewed-by: Fabiano Rosas <farosas@suse.de>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.h | 1 +
 migration/migration.c | 7 +++++++
 migration/qemu-file.c | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 47015f5201..bc6edc5c39 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -129,6 +129,7 @@ void qemu_file_skip(QEMUFile *f, int size);
 void qemu_file_credit_transfer(QEMUFile *f, size_t size);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index 825d8a71d4..216d0e871f 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2038,6 +2038,13 @@ out:
 
     res = qemu_file_get_error(rp);
     if (res) {
+        /* We have forwarded any error in "err" already, reuse "error" */
+        assert(err == NULL);
+        /* Try to deliver this file error to migration state */
+        qemu_file_get_error_obj(rp, &err);
+        migrate_set_error(ms, err);
+        err = NULL;
+
         if (res && migration_in_postcopy()) {
             /*
              * Maybe there is something we can do: it looks like a
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 19c33c9985..eea7171192 100644
--- a/migration/qemu-file.c
+++ b/migration/qemu-file.c
@@ -146,7 +146,7 @@ void qemu_file_set_hooks(QEMUFile *f, const QEMUFileHooks *hooks)
  * is not 0.
  *
  */
-static int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp)
 {
     if (errp) {
         *errp = f->last_error_obj ? error_copy(f->last_error_obj) : NULL;
-- 
2.41.0


