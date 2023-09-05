Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 357797925C6
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 18:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdYq9-00056Q-CZ; Tue, 05 Sep 2023 12:23:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYq7-00055U-Ll
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qdYq5-00064x-1n
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 12:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693931020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=itPguxkiBWkiGfVju4cdVWS3JiDjTmliW6gC+4lTFqw=;
 b=aQnwchQte8livT8wmf8AfziYqLy/pFPS7AgR/XVXXIP8e6KoB7whCQ5BXApdGD4HY1cD+W
 Qh9kYfvIFzs2Km2Kr6iXCj4kSIIC66MM6LZbLcI1XSwZG7TQSpiT2U3f4DGf94LcvVolsX
 bze9aThN4LJFhw9RQpe8e2SEZmdUkIA=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-391-ZobFSsZLOPu0MWvKLB6lOA-1; Tue, 05 Sep 2023 12:23:38 -0400
X-MC-Unique: ZobFSsZLOPu0MWvKLB6lOA-1
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-7a4ff742b97so225506241.0
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 09:23:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693931018; x=1694535818;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=itPguxkiBWkiGfVju4cdVWS3JiDjTmliW6gC+4lTFqw=;
 b=Cz53tFiBSW9CeeP20KQcdN3Vk0ZYbdy4zwBTI99EdIsCvIrkZCg/2rB2+SPasy1qtZ
 C6nj0g+6hmQX6osQDdTE/CykaK04xp+vAJsjfrvHZRcxLvEwNkKqr86Tmq5ASlJZypMj
 CU00jl4mpATty1fHq0Huo3D382r23jHGGXmjmh8DRw4dT+h8yIb2/d5FU0GQE/oKthYS
 K+pfOOIa7KpnbS6r7kLAxCVOqLUjwSpowhnAfW8x7lKuvia/F3wxrpV/qzYApr8m46So
 3ITspwu38RhG7z8Dvy1MY3Cp4CCnqohNN7jGDDkN4JH/lyKaNUe+W458a9SGT3Xzhdtm
 /Yyg==
X-Gm-Message-State: AOJu0YzgAJnag7BYJuVfjayHMkn+OKKJ6+TbhGP24Gc7PHEl9wcWIpBu
 ST9+klYXEP2j4lDidfybwxFhO/2mJ3Ad+rTYj40ybYJ+yKG0yckzdduPGKF3NEjwZotiurYg0pX
 rcctJposkWgVbRANtt+xMyviJ8bfYvq5F9+jC9gOFd+3N1dd5Pr4yXU/KG6snBEFYx+Q7CMxI
X-Received: by 2002:a1f:2797:0:b0:48f:d0ca:b4a3 with SMTP id
 n145-20020a1f2797000000b0048fd0cab4a3mr9192567vkn.1.1693931018166; 
 Tue, 05 Sep 2023 09:23:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYZ7n7eWKUVCz/Sm83ZqVShL46tKGWkgJ6ujNd3FftjXcwMm0VCX1nHV6RzkhOtftvjaJ/bQ==
X-Received: by 2002:a1f:2797:0:b0:48f:d0ca:b4a3 with SMTP id
 n145-20020a1f2797000000b0048fd0cab4a3mr9192542vkn.1.1693931017818; 
 Tue, 05 Sep 2023 09:23:37 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 u16-20020a0cf1d0000000b0063d281e22f1sm4581675qvl.17.2023.09.05.09.23.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Sep 2023 09:23:37 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, peterx@redhat.com,
 Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v3 1/4] migration/qmp: Fix crash on setting tls-authz with null
Date: Tue,  5 Sep 2023 12:23:32 -0400
Message-ID: <20230905162335.235619-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230905162335.235619-1-peterx@redhat.com>
References: <20230905162335.235619-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Reviewed-by: Fabiano Rosas <farosas@suse.de>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
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


