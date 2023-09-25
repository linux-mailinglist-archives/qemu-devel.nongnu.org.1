Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1207ADAC0
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:56:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmsn-0000do-Aj; Mon, 25 Sep 2023 10:48:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsR-0000ZY-2l
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmsP-00082z-CA
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653276;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=W99wLLFYhtnwHpHG7W/UEXV5+jth7FT6o0DfSkLFFJI=;
 b=jEv1uml47hMDYG+czy1kRjL7jrsyz/PkWcEZx1IqB8wTEP/HHu9Trh59qq9c4Enmch0hMk
 bQo9dXB6oR8SjaBi7vxJcCFikQZ8Zp8Do/6z0QvK92EVoH6TzB7yyj/lPiH+rTFsaN2Ny8
 Zl7mEpcPC8msDYiTfmarJtijStcjj9Q=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-SAtfV3h8MQKsCWrTxB7jXw-1; Mon, 25 Sep 2023 10:47:54 -0400
X-MC-Unique: SAtfV3h8MQKsCWrTxB7jXw-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so60679215e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:47:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653272; x=1696258072;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W99wLLFYhtnwHpHG7W/UEXV5+jth7FT6o0DfSkLFFJI=;
 b=kgjf0bxXRxhXoAIu7fQnGKm3ohZ99KYKoENARjNLLDui078NsD5KMyqdk2kO4GOl5w
 3YvmKXkh9meCG8QyuaKSEw4RFis5bgBWcFiIgWLBd6D1MUuRdCFNa/7RtgoTILKdA/gK
 NaWAXIxs7xGLMT5f5hx2fetNPEcc4vJVN3hDbcYjuI4xyp72/Pk3hfjpC96OIs4CnLQL
 4IUQVxdThwRDFOWstx+x8BlNgh6eMYbvilqfRCIWBSFhvszkq+RlkJsaQfPhQzk0hPZI
 wRDS1zXQJKN7wtCdbQdB98Z0WmWNQm/kU2o/zz4J6nZx+Rp5O4R11RlETMVgn6xR0x/f
 e4GQ==
X-Gm-Message-State: AOJu0Yywi/AbvCtL84njZNV9zQYCCGjXIrZ+8VaJ72Xudz6Ze2FWFy7O
 Ryv5bkheJX3xUm5IQI42KO1qgabNTLrTkdFwjY1So/vNfHNt7Wc9zIQABQMmNGq13a4IubSIa2H
 XR9baYsqpqJ71Aqt7DxdI/6H46f7FPEZWNEMWwP+xwV94dmqICBu2AUr+8+ahQcxW+GyXTP6tq8
 Q=
X-Received: by 2002:a1c:770c:0:b0:405:3d41:5641 with SMTP id
 t12-20020a1c770c000000b004053d415641mr6338407wmi.15.1695653272567; 
 Mon, 25 Sep 2023 07:47:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGaGXKnEo6gev1D35KKhspeXM4ALXqdEhXeN2/xaMzsFp3+tSoXrfQN2WXMa7eLbjJOBWBk9g==
X-Received: by 2002:a1c:770c:0:b0:405:3d41:5641 with SMTP id
 t12-20020a1c770c000000b004053d415641mr6338384wmi.15.1695653272127; 
 Mon, 25 Sep 2023 07:47:52 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j2-20020a5d4642000000b00317e77106dbsm12056524wrs.48.2023.09.25.07.47.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:47:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] vl: remove shadowed local variables
Date: Mon, 25 Sep 2023 16:47:41 +0200
Message-ID: <20230925144744.527958-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 TVD_SUBJ_WIPE_DEBT=1.004 autolearn=no autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 softmmu/vl.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/softmmu/vl.c b/softmmu/vl.c
index 0d23054ccd2..cafb1a98427 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -3210,7 +3210,6 @@ void qemu_init(int argc, char **argv)
                 }
                 break;
             case QEMU_OPTION_watchdog_action: {
-                QemuOpts *opts;
                 opts = qemu_opts_create(qemu_find_opts("action"), NULL, 0, &error_abort);
                 qemu_opt_set(opts, "watchdog", optarg, &error_abort);
                 break;
@@ -3521,16 +3520,16 @@ void qemu_init(int argc, char **argv)
                 break;
             case QEMU_OPTION_compat:
                 {
-                    CompatPolicy *opts;
+                    CompatPolicy *opts_policy;
                     Visitor *v;
 
                     v = qobject_input_visitor_new_str(optarg, NULL,
                                                       &error_fatal);
 
-                    visit_type_CompatPolicy(v, NULL, &opts, &error_fatal);
-                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opts);
+                    visit_type_CompatPolicy(v, NULL, &opts_policy, &error_fatal);
+                    QAPI_CLONE_MEMBERS(CompatPolicy, &compat_policy, opts_policy);
 
-                    qapi_free_CompatPolicy(opts);
+                    qapi_free_CompatPolicy(opts_policy);
                     visit_free(v);
                     break;
                 }
-- 
2.41.0


