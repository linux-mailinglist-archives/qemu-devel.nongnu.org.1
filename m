Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E626B748951
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 18:36:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH5TN-0001dN-MH; Wed, 05 Jul 2023 12:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TH-0001ZT-I2
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qH5TE-0003c5-Gl
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 12:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688574911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8nfLmUWQ8pB+Gq1IgpYYS03S4VtZKbHTf8LZ4fkY7mg=;
 b=VGiA8iTEmVyrpBEoTuMpCdo9qQYV6FON1hzmdxede6zrmQOfuI2B2ZjLByQUXbLuOEt7/3
 65Daf3OyxbcT2va0SRPEp0vd6LaFHQjARqeUgDPRlFRxzHtqUVn1hJC+hOzxQoBfpVf+OM
 7nK953kL/qdRnXJUW8EAYYJ6LWBdm68=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-fg8lGj27OkaSh8UCh3_l1Q-1; Wed, 05 Jul 2023 12:35:10 -0400
X-MC-Unique: fg8lGj27OkaSh8UCh3_l1Q-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-74faf5008bbso128205585a.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 09:35:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688574910; x=1691166910;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8nfLmUWQ8pB+Gq1IgpYYS03S4VtZKbHTf8LZ4fkY7mg=;
 b=eYEWfqAf8v10GdaEqlnzVerEIIMxwR/K9le/ugw5D83Cul54/w7UVr8DIgSqssJEU9
 JdZU1MbJPpldyPZd5NQZwzqMDukNa3SZOpozNxDXyzfIrK4+LFm97Nj9ohs3QuNiNtLY
 BgRyEyKlEGE76gz3Pv0vtXc1N0xfylq6JUtquiQJAUqXm+ySM+ENIE+wDUx/zFcrRwAX
 ChddTvusixL8ywksuQmpo+i4V4mIgyzRSwgOehaq5E71G84r7sPoL0LguEQcbgJ3MNJo
 5Yfqw3528++C4kjK7LvqAXAyz25+PTOTLOhBnsDx/XLuFzFNb6cyKppChS5n+RoYU0tP
 ROdg==
X-Gm-Message-State: AC+VfDyIdkJkNPTVguFbpi9XZ90WpjsnjmrFI9LRxBcBali3cyQv83m0
 aTqGzCaZJ7Sdxd9TkV2lYexRYwZkeLVn/tIr0lVPpE0isM8UNI7hPdPJn9FjbKuci59figZC1rz
 DWWbLWAp4mMpgWgjcmeSIZSLEiHEOmt+YJnR2yxExz2ks0P5AvlEv5vvAhnoqVpLSIIioqva7
X-Received: by 2002:a05:620a:2403:b0:763:a1d3:196d with SMTP id
 d3-20020a05620a240300b00763a1d3196dmr20496441qkn.0.1688574910075; 
 Wed, 05 Jul 2023 09:35:10 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4jSwk75xhPI6NrZQ9KR/ix+DudwIY9fnl90bo8rdPtUX/g9To91BEoWr0nFkajMc+YnL8JeA==
X-Received: by 2002:a05:620a:2403:b0:763:a1d3:196d with SMTP id
 d3-20020a05620a240300b00763a1d3196dmr20496405qkn.0.1688574909721; 
 Wed, 05 Jul 2023 09:35:09 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a05620a12b300b007620b03ee65sm6760094qki.37.2023.07.05.09.35.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jul 2023 09:35:09 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Laszlo Ersek <lersek@redhat.com>,
 peterx@redhat.com
Subject: [PATCH v2 6/7] qemufile: Always return a verbose error
Date: Wed,  5 Jul 2023 12:35:01 -0400
Message-ID: <20230705163502.331007-7-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230705163502.331007-1-peterx@redhat.com>
References: <20230705163502.331007-1-peterx@redhat.com>
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


