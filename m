Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A13F7972A0
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 15:10:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeEef-0006Wl-Ux; Thu, 07 Sep 2023 09:02:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdo-0004FC-At
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qeEdm-0007TP-5u
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 09:01:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694091705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=G5NZradxD71uQje+nwhEcOPdnjx/zNavwCfId1yJRzE=;
 b=Dvvdk9stfeB/nrq6u5SnTwZv66DjMHMj4xwQhFpM3aRA9nuvVNIDzAp4I+72lgtNOhFykY
 o5sqdH6WC8NERUBELtHgXZDSrtOItL0kzex6g0tnMBj3L/tVtHqf90HNobUPNVoiXV7DfT
 6996xpEExok57736ABtRyRC5j4UomRY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-iNSwMGc-PRGsrYmxcQjCrA-1; Thu, 07 Sep 2023 09:01:42 -0400
X-MC-Unique: iNSwMGc-PRGsrYmxcQjCrA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-401d9abf21cso7522695e9.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 06:01:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694091701; x=1694696501;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=G5NZradxD71uQje+nwhEcOPdnjx/zNavwCfId1yJRzE=;
 b=NjbXIIG1tv96fzNCHMqTmIOK4/xuNNcyAlHePj1H7hpVMGGF5h6Fe3n7YRpXZKRMKq
 AZnVMpuXAFgK+LIJG/S4LDVJvuNV3kK6tl4b94iXSB/R2DbO8bpariDgHnnho5qOQBiD
 ClTNnMebPzveQAp9A3tM1d03Lldd81ru2tMs4FuRyGYEBvZ1Nl0YCwxsah65iG/d8BOG
 Jzus4Kbp3BoBiq81IJgQZkxId0xOReuuNjA9H20bw5tZV2oy4+Ie4q+2NsjfjsF3QAcg
 rVN9jpcam6e7FL/LQA0KTVpxDLAu/H+9SzvKX5mVRP7PkJ87RkDwofCPExDzDTIHnO0v
 I1tQ==
X-Gm-Message-State: AOJu0YxM4FlZDRP40uXBrRlvrDk3VyA8L9qzD/Du+srk/VvzvGmJR+O8
 3HUUwQ6mEZyzz3aTmWPSBwnpBos/yjnhWG/uA7+9WNcsacH5IpzKq1Lyxno27S+zicSoFSLWtzG
 0H6LxDKLDPZVyOcDN4sNgoyrV0kk7+Fvj8CSIMJiY+jY5LuCdbmx2LOmfvLAsuvNRxhkRGWhHH6
 Q=
X-Received: by 2002:a1c:4c02:0:b0:3fe:111b:7fc4 with SMTP id
 z2-20020a1c4c02000000b003fe111b7fc4mr5061295wmf.21.1694091700806; 
 Thu, 07 Sep 2023 06:01:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGFF32+z0XiunSB4yga9QXq9C5tMvfo7DgQzbzac1MCik/UYregnVbblbzbmx45hl651fQrXA==
X-Received: by 2002:a1c:4c02:0:b0:3fe:111b:7fc4 with SMTP id
 z2-20020a1c4c02000000b003fe111b7fc4mr5061275wmf.21.1694091700492; 
 Thu, 07 Sep 2023 06:01:40 -0700 (PDT)
Received: from [192.168.1.174] ([151.48.237.81])
 by smtp.gmail.com with ESMTPSA id
 fa9-20020a05600c518900b003ff013a4fd9sm2509978wmb.7.2023.09.07.06.01.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 Sep 2023 06:01:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 41/51] target/i386/cpu-sysemu: Inline kvm_apic_in_kernel()
Date: Thu,  7 Sep 2023 14:59:50 +0200
Message-ID: <20230907130004.500601-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230907130004.500601-1-pbonzini@redhat.com>
References: <20230907130004.500601-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

In order to have cpu-sysemu.c become accelerator-agnostic,
inline kvm_apic_in_kernel() -- which is a simple wrapper
to kvm_irqchip_in_kernel() -- and use the generic "sysemu/kvm.h"
header.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Message-ID: <20230904124325.79040-6-philmd@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu-sysemu.c   | 4 ++--
 target/i386/kvm/kvm_i386.h | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/target/i386/cpu-sysemu.c b/target/i386/cpu-sysemu.c
index 28115edf44f..2375e48178f 100644
--- a/target/i386/cpu-sysemu.c
+++ b/target/i386/cpu-sysemu.c
@@ -19,9 +19,9 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
+#include "sysemu/kvm.h"
 #include "sysemu/xen.h"
 #include "sysemu/whpx.h"
-#include "kvm/kvm_i386.h"
 #include "qapi/error.h"
 #include "qapi/qapi-visit-run-state.h"
 #include "qapi/qmp/qdict.h"
@@ -253,7 +253,7 @@ APICCommonClass *apic_get_class(Error **errp)
 
     /* TODO: in-kernel irqchip for hvf */
     if (kvm_enabled()) {
-        if (!kvm_apic_in_kernel()) {
+        if (!kvm_irqchip_in_kernel()) {
             error_setg(errp, "KVM does not support userspace APIC");
             return NULL;
         }
diff --git a/target/i386/kvm/kvm_i386.h b/target/i386/kvm/kvm_i386.h
index e24753abfe6..470627b7504 100644
--- a/target/i386/kvm/kvm_i386.h
+++ b/target/i386/kvm/kvm_i386.h
@@ -13,8 +13,6 @@
 
 #include "sysemu/kvm.h"
 
-#define kvm_apic_in_kernel() (kvm_irqchip_in_kernel())
-
 #ifdef CONFIG_KVM
 
 #define kvm_pit_in_kernel() \
-- 
2.41.0


