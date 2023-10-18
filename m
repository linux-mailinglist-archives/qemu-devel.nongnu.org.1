Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4397CE2F1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 18:38:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt9YK-0000vx-2t; Wed, 18 Oct 2023 12:37:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YG-0000ve-AX
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qt9YE-0007NW-Ux
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 12:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697647062;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L4DzlN4wlvBrrC7R/mPs5UhfL8TuwbZ//Pi97xqHTxw=;
 b=V4Qgqp4lVt5XGSISjUzGxQPGbMl2eyLVzjx+nLWvZYEHwo6PxW0VwqK5fcXqTNH92x6ohE
 gXS9qv/Fgg9L24N4JRcJRF07emJi/WrKMMD3l4y1xnRthTXCMXxOYEEFRq4x/vK7cNhK5l
 ZYGFMONZbYeHiOt4Isr5mQSdzwSy5vE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-_b5xdo-NOluDxhp90JsZ3A-1; Wed, 18 Oct 2023 12:37:39 -0400
X-MC-Unique: _b5xdo-NOluDxhp90JsZ3A-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9b65c46bca8so227867166b.1
 for <qemu-devel@nongnu.org>; Wed, 18 Oct 2023 09:37:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697647054; x=1698251854;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=L4DzlN4wlvBrrC7R/mPs5UhfL8TuwbZ//Pi97xqHTxw=;
 b=TgEPhpQtABmPQ1kplhFTsXZ7HuJhCnCyq+DQuVnFKdslRqbFGG/Eqw+RqklcpXY+IG
 uUByUv99mmJTBz9FmGwcFO138oPpO7zuTPm+mvoxM4E8Lj0LkJkgb1ZNVL1XL46gPYJP
 XBtKVZEd4T4y2M4/LDCwrMiRZaGcHfZy971+RAlguAQsP2AAI/NWCbyEvvegzZpI39Sv
 e7+lqUdliawRMCPdL2eI9Rv0btR5DMUQzU5in8uP+JBaYi2dEo7qYwTbbyfJ99QY8w/O
 63ze3smqtQ51gGb8Y0RE0tVwhd0I9uLq8iO0wk4xg09Kqnx7HlN1XChyTJNAk7oGl8xt
 Lp7A==
X-Gm-Message-State: AOJu0Yydr3GCGfDs4/JtiT1/x/jqHddje1PYDfaOZUdlnIifZAZm5QnT
 NV4Ib5cJL80JSxBwiOzMzqi+6DcAnONMZKmbLPbEmktheoZeItbNLKjyCuHLgYlY0qzyoT1nCjV
 v0f3DmcVNUp+eBvzKoDMcvDsF3LF0qIg8LRRALY0UIv8BDvoJexYLiSfLWSMlWu3sU2fB+LYhIO
 M=
X-Received: by 2002:a17:907:980c:b0:9bf:5df1:38c9 with SMTP id
 ji12-20020a170907980c00b009bf5df138c9mr4412959ejc.9.1697647054250; 
 Wed, 18 Oct 2023 09:37:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEpRGXSM0MNXP35NsmKwQR4Ob7XHolnv20FAjRwEqRwvndKyreYR0nngBzs1oh1EXwj7kt+Pw==
X-Received: by 2002:a17:907:980c:b0:9bf:5df1:38c9 with SMTP id
 ji12-20020a170907980c00b009bf5df138c9mr4412941ejc.9.1697647053737; 
 Wed, 18 Oct 2023 09:37:33 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 c12-20020a17090603cc00b009adce1c97ccsm1957335eja.53.2023.10.18.09.37.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Oct 2023 09:37:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 02/17] kvm: require KVM_CAP_INTERNAL_ERROR_DATA
Date: Wed, 18 Oct 2023 18:37:13 +0200
Message-ID: <20231018163728.363879-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231018163728.363879-1-pbonzini@redhat.com>
References: <20231018163728.363879-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This was introduced in KVM in Linux 2.6.33, we can require it unconditionally.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 accel/kvm/kvm-all.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index 3f7eafe08cb..8eee5042252 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -111,6 +111,7 @@ static const KVMCapabilityInfo kvm_required_capabilites[] = {
     KVM_CAP_INFO(USER_MEMORY),
     KVM_CAP_INFO(DESTROY_MEMORY_REGION_WORKS),
     KVM_CAP_INFO(JOIN_MEMORY_REGIONS_WORKS),
+    KVM_CAP_INFO(INTERNAL_ERROR_DATA),
     KVM_CAP_LAST_INFO
 };
 
@@ -2794,16 +2795,14 @@ static void kvm_handle_io(uint16_t port, MemTxAttrs attrs, void *data, int direc
 
 static int kvm_handle_internal_error(CPUState *cpu, struct kvm_run *run)
 {
+    int i;
+
     fprintf(stderr, "KVM internal error. Suberror: %d\n",
             run->internal.suberror);
 
-    if (kvm_check_extension(kvm_state, KVM_CAP_INTERNAL_ERROR_DATA)) {
-        int i;
-
-        for (i = 0; i < run->internal.ndata; ++i) {
-            fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
-                    i, (uint64_t)run->internal.data[i]);
-        }
+    for (i = 0; i < run->internal.ndata; ++i) {
+        fprintf(stderr, "extra data[%d]: 0x%016"PRIx64"\n",
+                i, (uint64_t)run->internal.data[i]);
     }
     if (run->internal.suberror == KVM_INTERNAL_ERROR_EMULATION) {
         fprintf(stderr, "emulation failure\n");
-- 
2.41.0


