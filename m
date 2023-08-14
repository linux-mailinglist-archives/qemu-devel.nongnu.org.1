Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 692EF77C35C
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 00:21:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVfuw-0003Co-Uk; Mon, 14 Aug 2023 18:20:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVful-0003BH-Jl
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qVfuk-0005k2-3t
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 18:19:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692051593;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qu5ivLazFUczHSfNwhNGz9an3pNXKi1yqEOz8vB4qLg=;
 b=fp6NzbJMDAChdiOpnzalpAleiw7dOyFptHBOlkJ0wyD5WyM5lDhwMaz+dGSKddIRITK+dv
 cwQhCARHhib5VnQp06imV23tPDL+vF2uYwfZUiiirteKL8wB5XhxnJzg6WjlM4V4eWYGJC
 o4Zeneqokz7DhqTM3SV7sxSxtRHTNfE=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-567-OE2vJyz3MEKyF1h3RZYcew-1; Mon, 14 Aug 2023 18:19:51 -0400
X-MC-Unique: OE2vJyz3MEKyF1h3RZYcew-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76cb292df12so172453485a.0
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 15:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692051591; x=1692656391;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qu5ivLazFUczHSfNwhNGz9an3pNXKi1yqEOz8vB4qLg=;
 b=I2saY6nK7+9URxe90Tq9i5o472L4vEDPCiYUxtuVDbqZIgBN30xAckrx2TbU7twgdk
 X0UuWAtxwl7/XKixYiRlzLpeHQe8W3k5i9kB1QmL8aTmqU9ZRld3oH/Cy0kfs/9Vw6b6
 cOLqzPl1x1prWcnK+nO1zqPDydwIfoIp0a0yoSgFG/6NpJBVR+4c9sy6LXPUfEQr9tm/
 AGH5ZZhkkf3Lr4cCBNhYQt8Bp1uYGbDL0ujPcqqqajasFOGgfS+x3x7otIgD1aCCTRhM
 eWkzQoNpoWT+E5FmWu2JbvwFofs4LDBkSi5UPSUiPMEFU79e+B5fNlKSPHDJPkUXtgiV
 ttLA==
X-Gm-Message-State: AOJu0Yx65haCteBp3cndgTK7GJOqZJDB4Lf4qlK/jRc7F53HUrPu4xiz
 aBR1SCKSn3Ip1HK6iCHn307fNZjdVZML9fDhhwGlb2W9PlOFnbpUOq37OEEeblmqrdgbc2uls50
 87A/McwNeaSffpAmf1WPSjQEIEjlgWmnXpxo8rRRvVz2z4sYwYa4oSZZv8kLfeNv/1uu5jyrI
X-Received: by 2002:a05:620a:45a5:b0:76c:a9eb:90bf with SMTP id
 bp37-20020a05620a45a500b0076ca9eb90bfmr14784502qkb.3.1692051590916; 
 Mon, 14 Aug 2023 15:19:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEQoEGJcwdLnun/r4m4RVHgk6wafTVEo5mvU9H/B3jJ1Kl9KBd8IyfN7OqBSn9cO+dfAYJfkA==
X-Received: by 2002:a05:620a:45a5:b0:76c:a9eb:90bf with SMTP id
 bp37-20020a05620a45a500b0076ca9eb90bfmr14784476qkb.3.1692051590523; 
 Mon, 14 Aug 2023 15:19:50 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 s22-20020a05620a16b600b0076ca401d8c7sm3324978qkj.111.2023.08.14.15.19.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Aug 2023 15:19:50 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Juan Quintela <quintela@redhat.com>, qemu-stable@nongnu.org
Subject: [PATCH for-8.2 1/4] migration/qmp: Fix crash on setting tls-authz
 with null
Date: Mon, 14 Aug 2023 18:19:44 -0400
Message-ID: <20230814221947.353093-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230814221947.353093-1-peterx@redhat.com>
References: <20230814221947.353093-1-peterx@redhat.com>
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

QEMU will crash if anyone tries to set tls-authz (which is a type
StrOrNull) with 'null' value.  Fix it in the easy way by converting it to
qstring just like the other two tls parameters.

Cc: qemu-stable@nongnu.org # v4.0+
Fixes: d2f1d29b95 ("migration: add support for a "tls-authz" migration parameter")
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/options.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/migration/options.c b/migration/options.c
index 1d1e1321b0..6bbfd4853d 100644
--- a/migration/options.c
+++ b/migration/options.c
@@ -1408,20 +1408,25 @@ void qmp_migrate_set_parameters(MigrateSetParameters *params, Error **errp)
 {
     MigrationParameters tmp;
 
-    /* TODO Rewrite "" to null instead */
+    /* TODO Rewrite "" to null instead for all three tls_* parameters */
     if (params->tls_creds
         && params->tls_creds->type == QTYPE_QNULL) {
         qobject_unref(params->tls_creds->u.n);
         params->tls_creds->type = QTYPE_QSTRING;
         params->tls_creds->u.s = strdup("");
     }
-    /* TODO Rewrite "" to null instead */
     if (params->tls_hostname
         && params->tls_hostname->type == QTYPE_QNULL) {
         qobject_unref(params->tls_hostname->u.n);
         params->tls_hostname->type = QTYPE_QSTRING;
         params->tls_hostname->u.s = strdup("");
     }
+    if (params->tls_authz
+        && params->tls_authz->type == QTYPE_QNULL) {
+        qobject_unref(params->tls_authz->u.n);
+        params->tls_authz->type = QTYPE_QSTRING;
+        params->tls_authz->u.s = strdup("");
+    }
 
     migrate_params_test_apply(params, &tmp);
 
-- 
2.41.0


