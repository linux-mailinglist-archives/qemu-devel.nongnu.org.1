Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 141D278AC88
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 12:41:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qaZeo-0003R2-3a; Mon, 28 Aug 2023 06:39:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeZ-0003Ob-6w
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qaZeU-00057z-H2
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 06:39:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693219160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=r/VuExAkyshILkccp3KkTMigWjyaHk5E1NqYkd/KLzo=;
 b=EeTyuSrHnP5VdvrsBVuGlirv2jruzuyxKJXF3kXJURfvxl67l6DOnAMVdhM/+qUt25EvwM
 RkJgwE32E42CfLUitW5UrAoT02Nhn3GU8DqcABaZckLSKzXZL2nonBP/W0Qot3eWEa2CwG
 tclLyZeOb8a+oBQH56yBLYpgVthaN+8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-6vzAKRC5PryrCRce9Exs7Q-1; Mon, 28 Aug 2023 06:39:19 -0400
X-MC-Unique: 6vzAKRC5PryrCRce9Exs7Q-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-401b0ff0f39so18627715e9.1
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 03:39:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693219158; x=1693823958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=r/VuExAkyshILkccp3KkTMigWjyaHk5E1NqYkd/KLzo=;
 b=H5Dxzis8enE184yNBHzASz19kacX33iKNSZv0Zo59Xzjtmqcqsfldujr8tLGgTWNnW
 Etx3ck3apUXnJD/SmttX+7XHzTpXXHKDCFcbjEPE8sphFKuX4G1Dm21JsxldHpRexeY+
 IzYF+nfrP/et1BUp+LLslP5wIWh7EceLbLuK1+P7CgZP/xVc9o+iOsHdZw2ewe9XXU7a
 +FzTaNXUXgP7qRxeATpqiw7ruYK5bxEHg2tNl8gxXVwaslFRoT4dL3Fi7z//m0iBdp5B
 s4MQt2BZPoFqYe4IewS3vnfEszZB0Fr9bdwr6Ys1qyls85MoP2ql3j4deoDM0GRd64bS
 IJnQ==
X-Gm-Message-State: AOJu0YyvtRlx10UsuDIOBQ0qgjkOQ7agiP8cgg72/5BX6F1H10uMPmWT
 Ja34KtwGNIyflP1n3VDLIFfFc3CwLIkf9CkXmxlfUsosn/3At7eULbSoO+jf9rZTF5plzYsoi3i
 wzBYJjN5vltBQKr5WZVyTnd88TyMQ3Q5IogcnHkyTgnwofdPWxlhfJdb71iMtZOAgB7nmtGYakx
 c=
X-Received: by 2002:a5d:5272:0:b0:313:e391:e492 with SMTP id
 l18-20020a5d5272000000b00313e391e492mr22702256wrc.17.1693219157999; 
 Mon, 28 Aug 2023 03:39:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFQEcg1IH1Qpwbb7cI0qFfVH0owlPA6lqlOnqVRlfpPERq/1/lJ9JHBtErqZov+AlZd5MR7Ow==
X-Received: by 2002:a5d:5272:0:b0:313:e391:e492 with SMTP id
 l18-20020a5d5272000000b00313e391e492mr22702245wrc.17.1693219157705; 
 Mon, 28 Aug 2023 03:39:17 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 y11-20020adffa4b000000b0031c7682607asm10123935wrr.111.2023.08.28.03.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Aug 2023 03:39:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ake Koomsin <ake@igel.co.jp>
Subject: [PULL 12/14] target/i386: add support for
 VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE
Date: Mon, 28 Aug 2023 12:38:51 +0200
Message-ID: <20230828103856.46031-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230828103856.46031-1-pbonzini@redhat.com>
References: <20230828103856.46031-1-pbonzini@redhat.com>
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

From: Ake Koomsin <ake@igel.co.jp>

Current QEMU can expose waitpkg to guests when it is available. However,
VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE is still not recognized and
masked by QEMU. This can lead to an unexpected situation when a L1
hypervisor wants to expose waitpkg to a L2 guest. The L1 hypervisor can
assume that VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE exists as waitpkg is
available. The L1 hypervisor then can accidentally expose waitpkg to the
L2 guest. This will cause invalid opcode exception in the L2 guest when
it executes waitpkg related instructions.

This patch adds VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE support, and
sets up dependency between the bit and CPUID_7_0_ECX_WAITPKG. QEMU should
not expose waitpkg feature if VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE is
not available to avoid unexpected invalid opcode exception in L2 guests.

Signed-off-by: Ake Koomsin <ake@igel.co.jp>
Message-ID: <20230807093339.32091-2-ake@igel.co.jp>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 6 +++++-
 target/i386/cpu.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 97ad229d8ba..00f913b6382 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1228,7 +1228,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
             "vmx-invpcid-exit", "vmx-vmfunc", "vmx-shadow-vmcs", "vmx-encls-exit",
             "vmx-rdseed-exit", "vmx-pml", NULL, NULL,
             "vmx-xsaves", NULL, NULL, NULL,
-            NULL, "vmx-tsc-scaling", NULL, NULL,
+            NULL, "vmx-tsc-scaling", "vmx-enable-user-wait-pause", NULL,
             NULL, NULL, NULL, NULL,
         },
         .msr = {
@@ -1545,6 +1545,10 @@ static FeatureDep feature_dependencies[] = {
         .from = { FEAT_8000_0001_ECX,       CPUID_EXT3_SVM },
         .to = { FEAT_SVM,                   ~0ull },
     },
+    {
+        .from = { FEAT_VMX_SECONDARY_CTLS,  VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE },
+        .to = { FEAT_7_0_ECX,               CPUID_7_0_ECX_WAITPKG },
+    },
 };
 
 typedef struct X86RegisterInfo32 {
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index e0771a10433..a6000e93bd8 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1111,6 +1111,7 @@ uint64_t x86_cpu_get_supported_feature_word(FeatureWord w,
 #define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
 #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
+#define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
 
 #define VMX_PIN_BASED_EXT_INTR_MASK                 0x00000001
 #define VMX_PIN_BASED_NMI_EXITING                   0x00000008
-- 
2.41.0


