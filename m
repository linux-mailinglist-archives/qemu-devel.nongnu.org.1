Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4D6820A78
	for <lists+qemu-devel@lfdr.de>; Sun, 31 Dec 2023 09:46:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJrRs-0004Bj-SO; Sun, 31 Dec 2023 03:45:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRp-0004Al-Q1
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:29 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rJrRn-0000gh-Vk
 for qemu-devel@nongnu.org; Sun, 31 Dec 2023 03:45:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704012325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LQ32nVs2r70R47Ic6geyxZ1Up/qQ6fMthSaIzXPGiiM=;
 b=fUQAO+n+AGxRtSmjvEqVIfKyOTGnS+BqSg5wYrbISqYhxGcS1t6us5bSveL3TMAjxIPBZK
 XnWJkcttv+vrs2R1ovZSNVzZXxlX8lPAVXRVSyuoYqvHyQQBWi0yRjKMUu0Y9u/XWYc8lT
 sxWMmmWFeLh21BNaoc9YWp3lGmid9x8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-524-K-GONlf2OqiHJmUHVmgRIg-1; Sun, 31 Dec 2023 03:45:17 -0500
X-MC-Unique: K-GONlf2OqiHJmUHVmgRIg-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-554acc951faso3431862a12.2
 for <qemu-devel@nongnu.org>; Sun, 31 Dec 2023 00:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704012316; x=1704617116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LQ32nVs2r70R47Ic6geyxZ1Up/qQ6fMthSaIzXPGiiM=;
 b=f6pCYKnWexSfhBhteOpAjOu0ZOUwMzjjpf9u7nE2PZk2nuGqgmqqwK4Yrerk2FOG9h
 DbP5fNCQ1bk7H5brYXpzRVAXDnbPq6pp0IyXr6RdyqgrA0Wxx7IYhhOqsquacspPwVae
 8tPPWlc+8RLoyXmvi5MM2TiGbRpSt5qD8PZ8LMi1lMsqb4miHYTbmU+Y60dmAMjW6YaM
 owRhN+5H4Tpcs/l40zctG/0Lky77mOvE1bg1jGNaF4onvryy552S7fJzkWW578QqUUQh
 3zCt9/kNWaUuY/f/9W1zbb+8MPhL/dpwMBHsrqLrQ+HNYkEQ4tENDR6rgRppdbM+4+V9
 V9bQ==
X-Gm-Message-State: AOJu0Yy6AYak+7MUhXvQqZOJli+dUS8DpQ+PBgGh6dXL6Xey460khfXy
 PVcFgGvl54YL2w97p7bJeBDVUqkZq8nJkB447fbvFYaayLEPvxTMxzRZm51XV/f5r5mC7W3LJkD
 mLSkVMShLTqdHvEAhpnz7QvIQJQKLof46w3+AsMurkCN9LZa/LuZ5/oAjeR/4zLWc5ESNI0OL1z
 lvBukCE2g=
X-Received: by 2002:a17:906:117:b0:a27:45a2:e5f9 with SMTP id
 23-20020a170906011700b00a2745a2e5f9mr2977464eje.21.1704012316028; 
 Sun, 31 Dec 2023 00:45:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGdPMyA8PM+9BJ5fm9tYnFHgj5QSJIpqxMnaTdN6Gvxgj2P24XyFeBTSf22d9ggQFKDvZrcPA==
X-Received: by 2002:a17:906:117:b0:a27:45a2:e5f9 with SMTP id
 23-20020a170906011700b00a2745a2e5f9mr2977460eje.21.1704012315735; 
 Sun, 31 Dec 2023 00:45:15 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:1c09:f536:3de6:228c])
 by smtp.gmail.com with ESMTPSA id
 hg2-20020a170906f34200b00a26b361ec0esm8730683ejb.118.2023.12.31.00.45.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Dec 2023 00:45:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 04/46] target/i386: remove unnecessary arguments from
 raise_interrupt
Date: Sun, 31 Dec 2023 09:44:20 +0100
Message-ID: <20231231084502.235366-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231231084502.235366-1-pbonzini@redhat.com>
References: <20231231084502.235366-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.667,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

is_int is always 1, and error_code is always zero.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/excp_helper.c | 7 +++----
 target/i386/tcg/helper-tcg.h  | 3 +--
 target/i386/tcg/misc_helper.c | 2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/target/i386/tcg/excp_helper.c b/target/i386/tcg/excp_helper.c
index 7c3c8dc7fe8..65e37ae2a0c 100644
--- a/target/i386/tcg/excp_helper.c
+++ b/target/i386/tcg/excp_helper.c
@@ -28,7 +28,7 @@
 G_NORETURN void helper_raise_interrupt(CPUX86State *env, int intno,
                                           int next_eip_addend)
 {
-    raise_interrupt(env, intno, 1, 0, next_eip_addend);
+    raise_interrupt(env, intno, next_eip_addend);
 }
 
 G_NORETURN void helper_raise_exception(CPUX86State *env, int exception_index)
@@ -112,10 +112,9 @@ void raise_interrupt2(CPUX86State *env, int intno,
 
 /* shortcuts to generate exceptions */
 
-G_NORETURN void raise_interrupt(CPUX86State *env, int intno, int is_int,
-                                int error_code, int next_eip_addend)
+G_NORETURN void raise_interrupt(CPUX86State *env, int intno, int next_eip_addend)
 {
-    raise_interrupt2(env, intno, is_int, error_code, next_eip_addend, 0);
+    raise_interrupt2(env, intno, 1, 0, next_eip_addend, 0);
 }
 
 G_NORETURN void raise_exception_err(CPUX86State *env, int exception_index,
diff --git a/target/i386/tcg/helper-tcg.h b/target/i386/tcg/helper-tcg.h
index cd1723389ad..ce34b737bb0 100644
--- a/target/i386/tcg/helper-tcg.h
+++ b/target/i386/tcg/helper-tcg.h
@@ -65,8 +65,7 @@ G_NORETURN void raise_exception_err(CPUX86State *env, int exception_index,
                                     int error_code);
 G_NORETURN void raise_exception_err_ra(CPUX86State *env, int exception_index,
                                        int error_code, uintptr_t retaddr);
-G_NORETURN void raise_interrupt(CPUX86State *nenv, int intno, int is_int,
-                                int error_code, int next_eip_addend);
+G_NORETURN void raise_interrupt(CPUX86State *nenv, int intno, int next_eip_addend);
 G_NORETURN void handle_unaligned_access(CPUX86State *env, vaddr vaddr,
                                         MMUAccessType access_type,
                                         uintptr_t retaddr);
diff --git a/target/i386/tcg/misc_helper.c b/target/i386/tcg/misc_helper.c
index babff061864..66b332a83c1 100644
--- a/target/i386/tcg/misc_helper.c
+++ b/target/i386/tcg/misc_helper.c
@@ -43,7 +43,7 @@ void helper_into(CPUX86State *env, int next_eip_addend)
 
     eflags = cpu_cc_compute_all(env, CC_OP);
     if (eflags & CC_O) {
-        raise_interrupt(env, EXCP04_INTO, 1, 0, next_eip_addend);
+        raise_interrupt(env, EXCP04_INTO, next_eip_addend);
     }
 }
 
-- 
2.43.0


