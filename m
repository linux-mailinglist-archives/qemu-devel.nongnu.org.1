Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD9279DBD6
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 00:23:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgBlh-0007q5-8E; Tue, 12 Sep 2023 18:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBle-0007ou-87
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgBlb-0003Hv-SZ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 18:21:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694557315;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p6uAjHfWVV5l02g/VMaRfP8rGJHV6qapnjAjrMo0sFg=;
 b=HzJ0QsCbmelewvr8zsA/kaPtvhIO+1vOPl7cXi9V2XWErE87LzoAocpSc4/gt0iKmv+7pJ
 21cMi9hcLcAaeKMKqVm6rgEPDa86icmipbjk4gkSQKgVc72rNIo19r+E+Oj4h4H9+zXb0z
 FGI09vTurjxFiCBxEeAhuBUm0B6T5Nw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-hUCaLEaUMXaNN3OiOy5lzg-1; Tue, 12 Sep 2023 18:21:53 -0400
X-MC-Unique: hUCaLEaUMXaNN3OiOy5lzg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76f025ed860so93069485a.0
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 15:21:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694557312; x=1695162112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=p6uAjHfWVV5l02g/VMaRfP8rGJHV6qapnjAjrMo0sFg=;
 b=YHCQ7jewOn0KGUp7QldxnT0CeSxzBZHwe0fgtknKnQAg2GKIOZsOxn3/HAX4p7sh9w
 qj803nMR/uWREqD+69ebsHqp8DD8AEEK8ydMOpWf++kM75qI9USHMoLXvTY6o3k8a5hu
 XZP5IG4nRO4+Jf+yHI8HY1P7cGI8YeK/JJ1/95ScoDO5AbNeddtAYcX8AanD0h6VwsWi
 0/0ZSRa6wX5g8UuJLWdpqTWyrlBPiL1K1LJ1zobcD/TKYg0UP/rDhWy+FUXxR9e3iFxd
 IBDNajDMYs9ZMk8BMy3VQy/VegOoMyX668PoTiEtJUtQymhP/sEC6F8lCJQXzKSQKMGH
 jVbA==
X-Gm-Message-State: AOJu0YwTMkVXvo7J4CQmp7yk5FwlP78+cJvmCbZmJFthD7oEFJg05WzT
 dpWv5uPtFQQF38wwHzix8PA6yeVlFKXW8xCPuhxQr8WsPEw/oKBc3CxXIB3fmeoGxswnK4THZiA
 Ok0L3+/JX50eGy7qJZVvE9654nKtARwbQCVH+F9HicGCUhB+zJo/VN0Fdf/h+8Xly5YzwCitQ
X-Received: by 2002:a05:620a:3187:b0:76f:1118:9b62 with SMTP id
 bi7-20020a05620a318700b0076f11189b62mr779156qkb.3.1694557312610; 
 Tue, 12 Sep 2023 15:21:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3rw/aEa5EC4RbH9RAiLwbNKVg42cH/JQvU4hQQxFK9Zcb0X+QnVewbdnr7T0O/wN1yWogbA==
X-Received: by 2002:a05:620a:3187:b0:76f:1118:9b62 with SMTP id
 bi7-20020a05620a318700b0076f11189b62mr779142qkb.3.1694557312245; 
 Tue, 12 Sep 2023 15:21:52 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a05620a136500b0076f206cf16fsm3494272qkl.89.2023.09.12.15.21.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Sep 2023 15:21:51 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PATCH v2 06/11] qemufile: Always return a verbose error
Date: Tue, 12 Sep 2023 18:21:40 -0400
Message-ID: <20230912222145.731099-7-peterx@redhat.com>
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


