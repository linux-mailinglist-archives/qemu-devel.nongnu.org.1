Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F49078D01F
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:15:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nA-0000tm-Hr; Tue, 29 Aug 2023 19:06:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U5-0006LN-Vv
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qb6U3-0000hV-Iw
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:42:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693345367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2E6l8x7Sp00nkmEU9RfahHRwq3/Xa7iqj96y/AxDuAA=;
 b=JTVfWYfrRe/AtrX4EkPdGMAQyfMyXcVSJ/6HBKvMIFBR8yhymgDwyZmDTGmwnR68qEvs0G
 8tTBiRg2woq0Q4g4d0bYcF7BZTWVRevsqyoogZu/bhJ6i7XmqKuVxSnv3aB0vrMeg0Dax+
 9KBzUAs1TTrnuGOPt5yBTeCcUMD5pe4=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-w_mIKy1vPby66Hywk-YbrA-1; Tue, 29 Aug 2023 17:42:45 -0400
X-MC-Unique: w_mIKy1vPby66Hywk-YbrA-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso14275451cf.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693345364; x=1693950164;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2E6l8x7Sp00nkmEU9RfahHRwq3/Xa7iqj96y/AxDuAA=;
 b=gbPpwZ+l6Exm0/5qIXPNgeatGKnleici69uZYRzh13oUUemcD8zyqlrBECr4/GCkWH
 3Ik+H8F1072FzDE19jYzRM8IBI4WsjLZK4HOIUmQU58IuGwEvwLuTKT6X7OfVPamrlz8
 yJWCmmqKb7Tqs/oqoKicrXynyP8BAxjh8J+mCwQzzxN3w037BBST5WeaBm22ZCEusTSF
 cS4B/bE0DUEgjkwgzduK1GfMv6sn2wDCS4xnE1nXkTw97BAAN+6lgCjIUZerPeTpMl6C
 JAsqk5fotXxJeMx7Y0go/LGsDOJQGaxFP5h5QyTmcio8ityEhMt/L+DOQPVD1L3RLoPr
 Y9aQ==
X-Gm-Message-State: AOJu0YxLHeX74HcrOGdbIa/rPDq0En7T3EiACbVltDtVS1XWuK/z51tR
 WyJOzwPZyF7PrABbHE8O8tpZq/4rn08J75bp1gcAUN34uFpx1EDii7dFwdZvh1yDWEEXxM2sGxu
 p2TFCUGsHGZKnYqALerE0WcSYs+BtacXGF7AD7qmXOhqGh/mQe+iAHy5K27pni876OAJ+2LEf
X-Received: by 2002:a05:622a:1a25:b0:412:2dd3:e0ed with SMTP id
 f37-20020a05622a1a2500b004122dd3e0edmr321549qtb.0.1693345364415; 
 Tue, 29 Aug 2023 14:42:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGR/5fjheWPYmokwC6Ugo2jm44MuSXbl2mJRATJHnWR2Y29JCfk3KbrbZYjY3Bf0WNv4jCDUA==
X-Received: by 2002:a05:622a:1a25:b0:412:2dd3:e0ed with SMTP id
 f37-20020a05622a1a2500b004122dd3e0edmr321536qtb.0.1693345364161; 
 Tue, 29 Aug 2023 14:42:44 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 b18-20020ac86bd2000000b0040f8ac751a5sm3260343qtt.96.2023.08.29.14.42.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 14:42:43 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH 5/9] migration: Deliver return path file error to migrate
 state too
Date: Tue, 29 Aug 2023 17:42:31 -0400
Message-ID: <20230829214235.69309-6-peterx@redhat.com>
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
index def9d119b1..576e102319 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -2027,6 +2027,13 @@ out:
 
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


