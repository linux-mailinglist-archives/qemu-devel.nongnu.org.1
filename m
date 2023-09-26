Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7C47AF17D
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 19:01:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlBPj-0002Bc-EA; Tue, 26 Sep 2023 12:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPZ-00025T-4e
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qlBPX-0006gZ-P6
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 12:59:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695747587;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B3MRqjJKPkyF3tHIV008r3NmHojHwaW5VLmbwgYG1UQ=;
 b=Gmyvvy2EglhCY5XbYJj4dC5M2FCn0JMmjRXd6BJ/LScc+vqSziC8tVAvY9bLt58ZUu0FaN
 2BBjac1lg8LZjgAwqICBt0lOKZ0rDG7BjGz79ANw8II9Soou9j6FnQsI6Q3em28HVnJwa6
 CZk7VO87xlyFRQED5st6YRBRs87j2Dg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-76-ySlsIK62PE2qKLwBkT-BbQ-1; Tue, 26 Sep 2023 12:59:45 -0400
X-MC-Unique: ySlsIK62PE2qKLwBkT-BbQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32001e60fb3so5324797f8f.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 09:59:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695747583; x=1696352383;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=B3MRqjJKPkyF3tHIV008r3NmHojHwaW5VLmbwgYG1UQ=;
 b=lx7Rh91IiqvflIIDmXa0RZ215xI+ZxdBtcH1uLpb07Yk2vQ1fB0C0LOLJfjNjzIe+g
 x8lMZEeR0FpcJNw5nk4PUQoGbUnjR3gmcRdayd9UJPmdhdLyOU4bvak4BxpDEr6yuF6R
 AGxFdzg81v/c33Q/HbJE0GiPIpjX6wvLAq2MkFrLrYx8iuTOguLnelP3zj3BJ2iQvt+P
 Q8gUrcMMaDyMbdnqcFLUhjs7vvuKxT+MDOtrrqkKV1pmz/igPdwXythV/Vk7rE6imk4U
 ONYEeX1uOq0h4LNB2lN4xksCAE/Lkbs07wF/h9YC+6khu0nDLYt8kZoLSXFB5Xv1m5ap
 xe6Q==
X-Gm-Message-State: AOJu0YxR9Yd+iLTSIA08qc8MvpRZdWoVN5qnyh0qsC4yHzFLbTosPpiy
 19UtbMJXzXp593gbzCZOVcalP+VtMTFP10ris3qi20XqO5oEDIicRveBwLLwR8ed8IN4lV3UswY
 MHU9wfJAX2pLYf6gRXK2GSzOPyTsWDbPF7fdUoLR6kpIBzSv0RJg/8RXq1vAg/cw7moX5ZWcieC
 0=
X-Received: by 2002:a5d:6b8b:0:b0:323:2c2b:baf0 with SMTP id
 n11-20020a5d6b8b000000b003232c2bbaf0mr2421546wrx.15.1695747583605; 
 Tue, 26 Sep 2023 09:59:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExTzcIxrtAoyTPXkYXVLLJKw4maoVppUO7b4sgRi2lRoL4D24wmuyN9i8iYARdV3fGhBEdEg==
X-Received: by 2002:a5d:6b8b:0:b0:323:2c2b:baf0 with SMTP id
 n11-20020a5d6b8b000000b003232c2bbaf0mr2421533wrx.15.1695747583252; 
 Tue, 26 Sep 2023 09:59:43 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 r8-20020a5d4e48000000b00315af025098sm14999066wrt.46.2023.09.26.09.59.42
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Sep 2023 09:59:42 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 14/19] target/i386/seg_helper: introduce tss_set_busy
Date: Tue, 26 Sep 2023 18:59:10 +0200
Message-ID: <20230926165915.738719-15-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230926165915.738719-1-pbonzini@redhat.com>
References: <20230926165915.738719-1-pbonzini@redhat.com>
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


