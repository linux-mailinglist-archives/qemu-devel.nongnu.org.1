Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFF47ADAB9
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 16:56:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkmtI-0000hG-W2; Mon, 25 Sep 2023 10:48:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmtG-0000gn-8S
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkmtE-0008E1-P7
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695653328;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=B3MRqjJKPkyF3tHIV008r3NmHojHwaW5VLmbwgYG1UQ=;
 b=Z92cul/Yj1euuplDH1RFCGexRCFvSzRNTjBY02GPajCD/B9dhvW4kxe7z4LFjOqV0fZ/So
 xRSqaHXx01RopYli6UO6Hf4sKwZBn9Nf4Qwf91HtPgp++kmlMRNyFuO7clKPJc57JDE5oi
 HM3E7CwTD28I2ud6VlhUVdR/ZWEa7wY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-y1eLRAKkPESY6LgiYf5aVA-1; Mon, 25 Sep 2023 10:48:46 -0400
X-MC-Unique: y1eLRAKkPESY6LgiYf5aVA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-32323283257so1929371f8f.2
 for <qemu-devel@nongnu.org>; Mon, 25 Sep 2023 07:48:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695653324; x=1696258124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B3MRqjJKPkyF3tHIV008r3NmHojHwaW5VLmbwgYG1UQ=;
 b=ActUJD9AkcBocCKQcD0yahVnpmdS9Cp2zBBSOnpCOz9+R5UF/vk6g3wskmnzV0oqhY
 VvZaUoNxwFAJKpFIuVkUSO6SaRBysuCtwebM1e3QLD9tK8MDiF2OkW8zZWAMgv+YsGzT
 0Ympm4Tbpm2wY9I18DF0vrEDBteOP35Eur5Tw9jCVVZ4HlLtS6V6dZyLVeAW1cQITk/L
 OGo5vnD+PPgVvTK1BNvmhmXW77J7JjWWvWroQMd9csinZdLWxby2t46PSAmEv5uibW2m
 tN6bqu1j1P6f8uURPj8K9nHZzQD7l5Ly1nVvKlJ949KgMpTi0gvfZ3TPKQRNqmYTP6Ri
 WdhQ==
X-Gm-Message-State: AOJu0YwmAmQR7G0ouo2TkkGvvAFttCASvupQ8M51wm2Hdiv9OsC2lY3R
 8Xh3pEWnT5qi0QyHMNjia5jpHY4L8MjbaDm1pLdo/cKj3MpLlkYocb0DdLLF6behjdFtj1JZofN
 l/QjDQiXbihdX06cIjNeFgR3vUH+hfWq07pgFWkawdUraAvSkRx7x1GpFjhn2xw6g/tF5ptaiFf
 8=
X-Received: by 2002:a05:6000:1148:b0:319:6caa:ada2 with SMTP id
 d8-20020a056000114800b003196caaada2mr6241678wrx.47.1695653324217; 
 Mon, 25 Sep 2023 07:48:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvpVzOCYySjbURXdC9pwRx3NVrzCF2qWM3O5OsGyX63mHwdH0eRsUUp/YWq4WJjFM/rVmZQQ==
X-Received: by 2002:a05:6000:1148:b0:319:6caa:ada2 with SMTP id
 d8-20020a056000114800b003196caaada2mr6241662wrx.47.1695653323947; 
 Mon, 25 Sep 2023 07:48:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a5d424d000000b0031753073abcsm11994906wrr.36.2023.09.25.07.48.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:48:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH] target/i386/seg_helper: introduce tss_set_busy
Date: Mon, 25 Sep 2023 16:48:42 +0200
Message-ID: <20230925144842.529264-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
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

Eliminate a shadowed local variable in the process.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/seg_helper.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/target/i386/tcg/seg_helper.c b/target/i386/tcg/seg_helper.c
index e8d19c65fdc..b5198db82bc 100644
--- a/target/i386/tcg/seg_helper.c
+++ b/target/i386/tcg/seg_helper.c
@@ -226,6 +226,21 @@ static void tss_load_seg(CPUX86State *env, X86Seg seg_reg, int selector,
     }
 }
 
+static void tss_set_busy(CPUX86State *env, int tss_selector, bool value,
+                         uintptr_t retaddr)
+{
+    target_ulong ptr = env->gdt.base + (env->tr.selector & ~7);
+    uint32_t e2 = cpu_ldl_kernel_ra(env, ptr + 4, retaddr);
+
+    if (value) {
+        e2 |= DESC_TSS_BUSY_MASK;
+    } else {
+        e2 &= ~DESC_TSS_BUSY_MASK;
+    }
+
+    cpu_stl_kernel_ra(env, ptr + 4, e2, retaddr);
+}
+
 #define SWITCH_TSS_JMP  0
 #define SWITCH_TSS_IRET 1
 #define SWITCH_TSS_CALL 2
@@ -341,13 +356,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
 
     /* clear busy bit (it is restartable) */
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_IRET) {
-        target_ulong ptr;
-        uint32_t e2;
-
-        ptr = env->gdt.base + (env->tr.selector & ~7);
-        e2 = cpu_ldl_kernel_ra(env, ptr + 4, retaddr);
-        e2 &= ~DESC_TSS_BUSY_MASK;
-        cpu_stl_kernel_ra(env, ptr + 4, e2, retaddr);
+        tss_set_busy(env, env->tr.selector, 0, retaddr);
     }
     old_eflags = cpu_compute_eflags(env);
     if (source == SWITCH_TSS_IRET) {
@@ -399,13 +408,7 @@ static void switch_tss_ra(CPUX86State *env, int tss_selector,
 
     /* set busy bit */
     if (source == SWITCH_TSS_JMP || source == SWITCH_TSS_CALL) {
-        target_ulong ptr;
-        uint32_t e2;
-
-        ptr = env->gdt.base + (tss_selector & ~7);
-        e2 = cpu_ldl_kernel_ra(env, ptr + 4, retaddr);
-        e2 |= DESC_TSS_BUSY_MASK;
-        cpu_stl_kernel_ra(env, ptr + 4, e2, retaddr);
+        tss_set_busy(env, tss_selector, 1, retaddr);
     }
 
     /* set the new CPU state */
-- 
2.41.0


