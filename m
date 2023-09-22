Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8A7AB34A
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 16:11:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjgqx-0002yn-Rr; Fri, 22 Sep 2023 10:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqs-0002w0-He
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:52 -0400
Received: from mail-lj1-x22f.google.com ([2a00:1450:4864:20::22f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1qjgqq-0008Py-Ca
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 10:09:49 -0400
Received: by mail-lj1-x22f.google.com with SMTP id
 38308e7fff4ca-2bfea381255so37141771fa.3
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 07:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1695391786; x=1695996586;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WgvxkIY3+j2qIvKdDbYfJBN2du/aHpWbM4Y0iyDsskY=;
 b=EJtFwnG6zCCNE0iw3NW0ALzTsi+lkMRJEPTzXPI5k1kfg78KhBsGT4KKYH7OPOI8jK
 T+Fk7uynpXTC6epeZuGUx7XM5qBCcjGmKzcG7OIBJWEIfWB8JpBvPSs+50ug923lG+Cn
 Ic9UrbUyM11jAGkwFp+UsTfTp+xGou2NUqc5qWFfIzRhX61YUaRw1wacSwkmhZbzvLy4
 qVcnXoA2IFpggvSXecmox28gHM3uVVv2WswXIqWXOJBx3i74RNsj7FS8xBC/Hfda8nA1
 crO+QaLfPHDNBA6W+3fYCOusLaXxB4KGaOtnk0syR4F+Dy+X3UpmJvYX+BAPVFFUONXL
 VAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695391786; x=1695996586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=WgvxkIY3+j2qIvKdDbYfJBN2du/aHpWbM4Y0iyDsskY=;
 b=q4sZnB23ZFavlGUIvUKjATyreISolCE8GG2xp12XuxkY9xVMiMtlTk93ZyGCYHRv5B
 xVGLa/AjTBBNbiTfeXXrwwMwaqOG2nb7FJ99WuWVbfO2k2nY780p6DUsMQrl9DGeookS
 m+ex6LdeZ+bgwFntliKxLcNzbP/il9jUGaaX3BGQr7NAsrdDkjcNwWdm7HhuKK44iHAO
 RbU542fFKrScPEFvo17WsOoTfoBg4klTd9Qe5HA1gXN2K+BphZK/d1A9e6HSJDGm+NPG
 gw7Hs8dvAmG9ko2T+6B8wZBucQgFB0gKjbqulOaxaZDe/4dSsxyNaSNchetYkq/5EUro
 Nw/A==
X-Gm-Message-State: AOJu0YzDXUpYxmcl/SLKBeycfSZSZWTDZd42bWII5Vmmlq6OtX3fS/Zn
 gTFBNlSQ/OQVzeF40z1nzhQpAeMKRg7pifOF1wQ=
X-Google-Smtp-Source: AGHT+IGUqOhxUCB82o+yTrCJioaXz1V/a3rdke6PWrJaTZB/0NHLVQM35YmT3MUbasnmhSo3hqKiEg==
X-Received: by 2002:a2e:9c07:0:b0:2c0:2583:520e with SMTP id
 s7-20020a2e9c07000000b002c02583520emr7651387lji.41.1695391786598; 
 Fri, 22 Sep 2023 07:09:46 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 g27-20020a170906395b00b009ae587ce128sm2725823eje.216.2023.09.22.07.09.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 07:09:46 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>
Subject: [PATCH 3/3] i386: hvf: Updates API usage to use modern vCPU run
 function
Date: Fri, 22 Sep 2023 16:09:14 +0200
Message-Id: <20230922140914.13906-4-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20230922140914.13906-1-phil@philjordan.eu>
References: <20230922140914.13906-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::22f;
 envelope-from=phil@philjordan.eu; helo=mail-lj1-x22f.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

macOS 10.15 introduced the more efficient hv_vcpu_run_until() function
to supersede hv_vcpu_run(). According to the documentation, there is no
longer any reason to use the latter on modern host OS versions.

Observed behaviour of the newer function is that as documented, it exits
much less frequently - and most of the original function’s exits seem to
have been effectively pointless.

Another reason to use the new function is that it is a prerequisite for
using newer features such as in-kernel APIC support. (Not covered by
this patch.)

This change implements the upgrade by selecting one of three code paths
at compile time: two static code paths for the new and old functions
respectively, when building for targets where the new function is either
not available, or where the built executable won’t run on older
platforms lacking the new function anyway. The third code path selects
dynamically based on runtime detected availability of the weakly-linked
symbol.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
---
 target/i386/hvf/hvf.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index 55bd7d2af8..e4c785c686 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -410,6 +410,27 @@ static void hvf_cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     }
 }
 
+static hv_return_t hvf_vcpu_run(hv_vcpuid_t vcpu_id)
+{
+    /*
+     * hv_vcpu_run_until is available and recommended from macOS 10.15+.
+     * Test for availability at runtime and fall back to hv_vcpu_run() only
+     * where necessary.
+     */
+#ifndef MAC_OS_X_VERSION_10_15
+    return hv_vcpu_run(vcpu_id);
+#elif MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_X_VERSION_10_15
+    return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
+#else /* MAC_OS_X_VERSION_MIN_REQUIRED < MAC_OS_X_VERSION_10_15 */
+    /* 10.15 SDK or newer, but could be < 10.15 at runtime */
+    if (__builtin_available(macOS 10.15, *)) {
+        return hv_vcpu_run(vcpu_id);
+    } else {
+        return hv_vcpu_run_until(vcpu_id, HV_DEADLINE_FOREVER);
+    }
+#endif
+}
+
 int hvf_vcpu_exec(CPUState *cpu)
 {
     X86CPU *x86_cpu = X86_CPU(cpu);
@@ -438,7 +459,7 @@ int hvf_vcpu_exec(CPUState *cpu)
             return EXCP_HLT;
         }
 
-        hv_return_t r  = hv_vcpu_run(cpu->accel->fd);
+        hv_return_t r = hvf_vcpu_run(cpu->accel->fd);
         assert_hvf_ok(r);
 
         /* handle VMEXIT */
-- 
2.36.1


