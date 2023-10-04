Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0055D7B970F
	for <lists+qemu-devel@lfdr.de>; Thu,  5 Oct 2023 00:04:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo9xQ-0004ZS-VS; Wed, 04 Oct 2023 18:03:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xN-0004Mn-5F
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qo9xL-0003wW-IG
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 18:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696456978;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jV8cOpRTPLd2f04WBSfLlfjLLJ1luyrwGf9W18xAndM=;
 b=eGNtRaaPIQU4W31cQhXgQGrxPei6OcZEzeouJJGKUYAddF8D/13kIkryQTPpqi9PYXrHdC
 nXHv+a5MftX5DoD2y77pcrwPvEiwZyowh7S7bjv/tFSs7IRANkYYg7OEz7kXVh8HygBs7h
 wHxyvRvGFkzEucasOts6FHvQCtbWRXg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-75-CIGeB-NAM8qYfwn_ytGK_A-1; Wed, 04 Oct 2023 18:02:47 -0400
X-MC-Unique: CIGeB-NAM8qYfwn_ytGK_A-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-637948b24bdso495936d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 15:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696456967; x=1697061767;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jV8cOpRTPLd2f04WBSfLlfjLLJ1luyrwGf9W18xAndM=;
 b=cvKLgnntrYg9I7+XDSGyrBeZCdOlLvv4dqqa+QOXNjwGazdimI0e4FeeI8AFgW2fdr
 T3L45AaeipJXdntkScxmKTMNFs2Tbi/tr78mo/w7Uw4Ql/4P+EwCANzq8RROUs66mN7v
 P9vPLDy+9xHdzfQrkz4aqGxVwnJt2ya8PHmQDVVVMyWHkSj/fl/f8B2xruWolICOaPzg
 v9pHiedUX3MWW0qQRvqb7B9DeizhdsCKcEZxynSCLneZZr2Bv9BTMiXi5iXA9UeXaPK8
 UYgnIlLUuTVKqE4hGqLEt4dKRBStugYWTNsQohoj06WztaWz41QT1h2X6q6PMFOj4DUp
 mriA==
X-Gm-Message-State: AOJu0YzL4YP80UWGEFDodNhb6lYSEWatPmiigmwo+V+6IkWb0d0Stswk
 QBgjGDBMi1JYeEmtDs+o6DBZtbpnB0miKVyydvsr8lLGb8ayXyVNmJPUL6uqvR5pzKDd9pkWZye
 0G8oUA4cSS4A+81dEnxOCM6OYFeKJDnjwYNSFw98oILmdeJp0CPg2AHG3xKaEyMM289Q3wAo4
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id
 gc3-20020a056214230300b00668e31b5576mr3691704qvb.1.1696456967134; 
 Wed, 04 Oct 2023 15:02:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3ordlFWGONG9+oZ5uQcWyu4LiOP3ozr+k0GBZvOeh4cqLLTnkzitp9brpVOEZCa52mkqECQ==
X-Received: by 2002:a05:6214:2303:b0:668:e31b:5576 with SMTP id
 gc3-20020a056214230300b00668e31b5576mr3691658qvb.1.1696456966347; 
 Wed, 04 Oct 2023 15:02:46 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 w17-20020a0cdf91000000b0063d162a8b8bsm10821qvl.19.2023.10.04.15.02.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 15:02:45 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: [PATCH v3 04/10] migration: Deliver return path file error to migrate
 state too
Date: Wed,  4 Oct 2023 18:02:34 -0400
Message-ID: <20231004220240.167175-5-peterx@redhat.com>
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

We've already did this for most of the return path thread errors, but not
yet for the IO errors happened on the return path qemufile.  Do that too.

Re-export qemu_file_get_error_obj().

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/qemu-file.h | 1 +
 migration/migration.c | 1 +
 migration/qemu-file.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/migration/qemu-file.h b/migration/qemu-file.h
index 03e718c264..75efe503c4 100644
--- a/migration/qemu-file.h
+++ b/migration/qemu-file.h
@@ -120,6 +120,7 @@ int coroutine_mixed_fn qemu_peek_byte(QEMUFile *f, int offset);
 void qemu_file_skip(QEMUFile *f, int size);
 int qemu_file_get_error_obj_any(QEMUFile *f1, QEMUFile *f2, Error **errp);
 void qemu_file_set_error_obj(QEMUFile *f, int ret, Error *err);
+int qemu_file_get_error_obj(QEMUFile *f, Error **errp);
 void qemu_file_set_error(QEMUFile *f, int ret);
 int qemu_file_shutdown(QEMUFile *f);
 QEMUFile *qemu_file_get_return_path(QEMUFile *f);
diff --git a/migration/migration.c b/migration/migration.c
index e821e80094..b28b504b4c 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1884,6 +1884,7 @@ static void *source_return_path_thread(void *opaque)
         header_len = qemu_get_be16(rp);
 
         if (qemu_file_get_error(rp)) {
+            qemu_file_get_error_obj(rp, &err);
             goto out;
         }
 
diff --git a/migration/qemu-file.c b/migration/qemu-file.c
index 5e8207dae4..ffa9c0a48a 100644
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


