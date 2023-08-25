Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4164788DB0
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 19:16:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZaPQ-0003xj-M6; Fri, 25 Aug 2023 13:15:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaPA-0003t7-7a
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:15:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qZaP7-0001jO-0q
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 13:15:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692983722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=b7Mzp01MjD+p2th1wyzmIyguJuc8ShGmF1Bq3+qHw/g=;
 b=RGhR2JzlqD8l7qWflR8LnUvnLCy9j8vlgAF7dk+D9ZWIQJcuI/V7YcJul9KkfXMnBr42j8
 Jf9mcY0Nr0kg4jJ+Ri6QqjAap2y+WU7XwYIi2wI1Ir2XpKfkCkOT/ZiVy+IHizS6YXuz9d
 B2TT82vrwUF9WoUDyecvaLl7587iLPY=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-NmkF8un-NDu15WdZKi0ZFQ-1; Fri, 25 Aug 2023 13:15:20 -0400
X-MC-Unique: NmkF8un-NDu15WdZKi0ZFQ-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-64726969c8bso3607946d6.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 10:15:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692983720; x=1693588520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b7Mzp01MjD+p2th1wyzmIyguJuc8ShGmF1Bq3+qHw/g=;
 b=KKW0Kz4u8ZzG/Tm51ijNSS3zSLOzGn8rUTcqhm8W+P0aSSajAsDd+Bw34APWxc0kpu
 b61T3jxvHS+8RhiySaH8+eMfMhVH4RCJuiRvuzr9nlwjT8ZLpgzYdvATHElxMn9sBB4E
 yFcsOBGsTDSdYPW9wsAJLalevMQa12VcKXDY8/Rwd/4xNLOb/rNHNNsC5wgNASfKgHPv
 CiSQErY48xEliRrY7+G0eRjPSxSLvhwWACSzAD0/9eO3FfbsblQ9mh47/Y0+D1yOz3Y4
 Z6llPq6PAQ5/OG/93YW8vE7pH11/3TkgpeIe3LNxN39J3SsIil/YM6mguXHGkaInb1o4
 PQng==
X-Gm-Message-State: AOJu0YyEHmbcn5feCyRpSG49WUhy1rClFWtlYYzmWT5kUihzC63EjLoa
 BBa5nRgyKEHV2zJDYRaaN8HIWxzm+Lp+0/all2Nokh00J+r2Kv+Bx52dvnQ4Ahu/+UOBOKV86zL
 YfyRxN+vDn5oEUG88IUbVGJE/iQaa3PFcN6g14oriWCABE3mFAIfF/C4OjhXJsHjDXbOjQMvF
X-Received: by 2002:a05:6214:e62:b0:641:8d4a:1a83 with SMTP id
 jz2-20020a0562140e6200b006418d4a1a83mr21666214qvb.3.1692983720129; 
 Fri, 25 Aug 2023 10:15:20 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHC+wMFMLfQBBolICLojV+GNR1xw+OGklNHU2ANN+UO076EgjaKUuHfYXblPzNSNccdCc+wzw==
X-Received: by 2002:a05:6214:e62:b0:641:8d4a:1a83 with SMTP id
 jz2-20020a0562140e6200b006418d4a1a83mr21666191qvb.3.1692983719820; 
 Fri, 25 Aug 2023 10:15:19 -0700 (PDT)
Received: from x1n.redhat.com
 (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com. [99.254.144.39])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a0cf184000000b0063cfb3fbb7esm679191qvl.16.2023.08.25.10.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Aug 2023 10:15:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Leonardo Bras Soares Passos <lsoaresp@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-stable@nongnu.org
Subject: [PATCH v2 1/4] migration/qmp: Fix crash on setting tls-authz with null
Date: Fri, 25 Aug 2023 13:15:14 -0400
Message-ID: <20230825171517.1215317-2-peterx@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230825171517.1215317-1-peterx@redhat.com>
References: <20230825171517.1215317-1-peterx@redhat.com>
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


