Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 711817745D4
	for <lists+qemu-devel@lfdr.de>; Tue,  8 Aug 2023 20:47:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTRif-0005Bq-NY; Tue, 08 Aug 2023 14:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTRiW-0005BA-V9
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:46:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qTRiT-00047g-Vp
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 14:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691520361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbxmfz/m6432xjJwoRgE+UYPOT+ApabJPxNLYbtQHqY=;
 b=FYv/hGodIuDXtAoAsVGF3YbFV0Q3jBrlWCYoYA662//jfVGZIoUnt38VDy60U+W2NZBoDc
 BG9EJXbiufFXfj/KNxjrgr0F42DGY2Qbm1Ob5v3rTh7O3skYeZcLNm7d16t75XBe5/C0zV
 Ae/AAbBrPCxFEoUk0BwuDPpx/1UILCk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-9fd6s5KuNXqGzeJlq7lhdw-1; Tue, 08 Aug 2023 14:45:58 -0400
X-MC-Unique: 9fd6s5KuNXqGzeJlq7lhdw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe182913c5so33139535e9.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 11:45:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691520357; x=1692125157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dbxmfz/m6432xjJwoRgE+UYPOT+ApabJPxNLYbtQHqY=;
 b=RYfW/pkJroLXjZBC06w/aznXezo07lQsQoafLKeyAD6xH3qNH2Lw34zo9xrHEBFyay
 Vw5e5klizlpkY6hRgvwukNkyXtd1u9RIDyaZTIPvKZNAKyaPMOtnvQS3FGnHxuffxq+b
 hJCuGVnloXuJXTp8XMPr5/xqM07E33dPyiNtjKh28bmJDuU0qG5TcI14r8XexrMbOIul
 A/PyH0DAMjbHL+QE9DtvxurSPKYsCAU06yX2XFNaUi367zbHgQfdhGDTI/J2arYMMhh1
 alEjRw/yInxmSjaySBcEuESkL9fpn/CedBtupf36ROOYEpURivGw70EIHgjLvhTKLMfv
 FDcA==
X-Gm-Message-State: AOJu0YyzvSb0luQF8CoU+4bs20Nu4A+uUoYuofsUGpmlcvgfOVPh2JtV
 FQGhmrD/4835a+gUVZXX3OWuSAQ/4Va+kntpvbwjBeaGtjP6tFV5kqSgtTLI20EEhGOX6z8cJIb
 fxRJBFZf5IVwShFG3gXtaui+TcbTeMuHUcjGSTVVYWlDEIVZr6A3miSH32tkNGXrtRPqX02Ta9L
 Q=
X-Received: by 2002:a1c:7710:0:b0:3fe:1d13:4663 with SMTP id
 t16-20020a1c7710000000b003fe1d134663mr546365wmi.1.1691520356646; 
 Tue, 08 Aug 2023 11:45:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs+7Lddw572Pd30Bn+f0Yo5SmN48hi9F9Yb8G0ujLMVRcEyHUWXGZnYmAQffoRqsUgjDttLw==
X-Received: by 2002:a1c:7710:0:b0:3fe:1d13:4663 with SMTP id
 t16-20020a1c7710000000b003fe1d134663mr546350wmi.1.1691520356305; 
 Tue, 08 Aug 2023 11:45:56 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 m21-20020a7bcb95000000b003fc02e8ea68sm19012304wmi.13.2023.08.08.11.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Aug 2023 11:45:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ilya Leoshkevich <iii@linux.ibm.com>,
	Michael Tokarev <mjt@tls.msk.ru>
Subject: [PULL 2/3] linux-user: cleanup unused linux-user/include/host
 directories
Date: Tue,  8 Aug 2023 20:45:50 +0200
Message-ID: <20230808184551.684522-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230808184551.684522-1-pbonzini@redhat.com>
References: <20230808184551.684522-1-pbonzini@redhat.com>
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

Alpha and 31-bit s390 lack the assembly fragment to handle signals
occurring at the same time as system calls, so they cannot run
linux-user emulation anymore.  Drop the host-signal.h files for
them.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>
Tested-by: Ilya Leoshkevich <iii@linux.ibm.com>
Tested-by: Michael Tokarev <mjt@tls.msk.ru>
Message-ID: <20230808120303.585509-3-pbonzini@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 linux-user/include/host/alpha/host-signal.h |  55 --------
 linux-user/include/host/s390/host-signal.h  | 138 -------------------
 linux-user/include/host/s390x/host-signal.h | 139 +++++++++++++++++++-
 3 files changed, 138 insertions(+), 194 deletions(-)
 delete mode 100644 linux-user/include/host/alpha/host-signal.h
 delete mode 100644 linux-user/include/host/s390/host-signal.h

diff --git a/linux-user/include/host/alpha/host-signal.h b/linux-user/include/host/alpha/host-signal.h
deleted file mode 100644
index 4f9e2abc4b0..00000000000
--- a/linux-user/include/host/alpha/host-signal.h
+++ /dev/null
@@ -1,55 +0,0 @@
-/*
- * host-signal.h: signal info dependent on the host architecture
- *
- * Copyright (c) 2003-2005 Fabrice Bellard
- * Copyright (c) 2021 Linaro Limited
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef ALPHA_HOST_SIGNAL_H
-#define ALPHA_HOST_SIGNAL_H
-
-/* The third argument to a SA_SIGINFO handler is ucontext_t. */
-typedef ucontext_t host_sigcontext;
-
-static inline uintptr_t host_signal_pc(host_sigcontext *uc)
-{
-    return uc->uc_mcontext.sc_pc;
-}
-
-static inline void host_signal_set_pc(host_sigcontext *uc, uintptr_t pc)
-{
-    uc->uc_mcontext.sc_pc = pc;
-}
-
-static inline void *host_signal_mask(host_sigcontext *uc)
-{
-    return &uc->uc_sigmask;
-}
-
-static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
-{
-    uint32_t *pc = (uint32_t *)host_signal_pc(uc);
-    uint32_t insn = *pc;
-
-    /* XXX: need kernel patch to get write flag faster */
-    switch (insn >> 26) {
-    case 0x0d: /* stw */
-    case 0x0e: /* stb */
-    case 0x0f: /* stq_u */
-    case 0x24: /* stf */
-    case 0x25: /* stg */
-    case 0x26: /* sts */
-    case 0x27: /* stt */
-    case 0x2c: /* stl */
-    case 0x2d: /* stq */
-    case 0x2e: /* stl_c */
-    case 0x2f: /* stq_c */
-        return true;
-    }
-    return false;
-}
-
-#endif
diff --git a/linux-user/include/host/s390/host-signal.h b/linux-user/include/host/s390/host-signal.h
deleted file mode 100644
index e6d3ec26dc7..00000000000
--- a/linux-user/include/host/s390/host-signal.h
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- * host-signal.h: signal info dependent on the host architecture
- *
- * Copyright (c) 2003-2005 Fabrice Bellard
- * Copyright (c) 2021 Linaro Limited
- *
- * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
- * See the COPYING file in the top-level directory.
- */
-
-#ifndef S390_HOST_SIGNAL_H
-#define S390_HOST_SIGNAL_H
-
-/* The third argument to a SA_SIGINFO handler is ucontext_t. */
-typedef ucontext_t host_sigcontext;
-
-static inline uintptr_t host_signal_pc(host_sigcontext *uc)
-{
-    return uc->uc_mcontext.psw.addr;
-}
-
-static inline void host_signal_set_pc(host_sigcontext *uc, uintptr_t pc)
-{
-    uc->uc_mcontext.psw.addr = pc;
-}
-
-static inline void *host_signal_mask(host_sigcontext *uc)
-{
-    return &uc->uc_sigmask;
-}
-
-static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
-{
-    uint16_t *pinsn = (uint16_t *)host_signal_pc(uc);
-
-    /*
-     * ??? On linux, the non-rt signal handler has 4 (!) arguments instead
-     * of the normal 2 arguments.  The 4th argument contains the "Translation-
-     * Exception Identification for DAT Exceptions" from the hardware (aka
-     * "int_parm_long"), which does in fact contain the is_write value.
-     * The rt signal handler, as far as I can tell, does not give this value
-     * at all.  Not that we could get to it from here even if it were.
-     * So fall back to parsing instructions.  Treat read-modify-write ones as
-     * writes, which is not fully correct, but for tracking self-modifying code
-     * this is better than treating them as reads.  Checking si_addr page flags
-     * might be a viable improvement, albeit a racy one.
-     */
-    /* ??? This is not even close to complete.  */
-    switch (pinsn[0] >> 8) {
-    case 0x50: /* ST */
-    case 0x42: /* STC */
-    case 0x40: /* STH */
-    case 0x44: /* EX */
-    case 0xba: /* CS */
-    case 0xbb: /* CDS */
-        return true;
-    case 0xc4: /* RIL format insns */
-        switch (pinsn[0] & 0xf) {
-        case 0xf: /* STRL */
-        case 0xb: /* STGRL */
-        case 0x7: /* STHRL */
-            return true;
-        }
-        break;
-    case 0xc6: /* RIL-b format insns */
-        switch (pinsn[0] & 0xf) {
-        case 0x0: /* EXRL */
-            return true;
-        }
-        break;
-    case 0xc8: /* SSF format insns */
-        switch (pinsn[0] & 0xf) {
-        case 0x2: /* CSST */
-            return true;
-        }
-        break;
-    case 0xe3: /* RXY format insns */
-        switch (pinsn[2] & 0xff) {
-        case 0x50: /* STY */
-        case 0x24: /* STG */
-        case 0x72: /* STCY */
-        case 0x70: /* STHY */
-        case 0x8e: /* STPQ */
-        case 0x3f: /* STRVH */
-        case 0x3e: /* STRV */
-        case 0x2f: /* STRVG */
-            return true;
-        }
-        break;
-    case 0xe6:
-        switch (pinsn[2] & 0xff) {
-        case 0x09: /* VSTEBRH */
-        case 0x0a: /* VSTEBRG */
-        case 0x0b: /* VSTEBRF */
-        case 0x0e: /* VSTBR */
-        case 0x0f: /* VSTER */
-        case 0x3f: /* VSTRLR */
-            return true;
-        }
-        break;
-    case 0xe7:
-        switch (pinsn[2] & 0xff) {
-        case 0x08: /* VSTEB */
-        case 0x09: /* VSTEH */
-        case 0x0a: /* VSTEG */
-        case 0x0b: /* VSTEF */
-        case 0x0e: /* VST */
-        case 0x1a: /* VSCEG */
-        case 0x1b: /* VSCEF */
-        case 0x3e: /* VSTM */
-        case 0x3f: /* VSTL */
-            return true;
-        }
-        break;
-    case 0xeb: /* RSY format insns */
-        switch (pinsn[2] & 0xff) {
-        case 0x14: /* CSY */
-        case 0x30: /* CSG */
-        case 0x31: /* CDSY */
-        case 0x3e: /* CDSG */
-        case 0xe4: /* LANG */
-        case 0xe6: /* LAOG */
-        case 0xe7: /* LAXG */
-        case 0xe8: /* LAAG */
-        case 0xea: /* LAALG */
-        case 0xf4: /* LAN */
-        case 0xf6: /* LAO */
-        case 0xf7: /* LAX */
-        case 0xfa: /* LAAL */
-        case 0xf8: /* LAA */
-            return true;
-        }
-        break;
-    }
-    return false;
-}
-
-#endif
diff --git a/linux-user/include/host/s390x/host-signal.h b/linux-user/include/host/s390x/host-signal.h
index 0e83f9358df..e6d3ec26dc7 100644
--- a/linux-user/include/host/s390x/host-signal.h
+++ b/linux-user/include/host/s390x/host-signal.h
@@ -1 +1,138 @@
-#include "../s390/host-signal.h"
+/*
+ * host-signal.h: signal info dependent on the host architecture
+ *
+ * Copyright (c) 2003-2005 Fabrice Bellard
+ * Copyright (c) 2021 Linaro Limited
+ *
+ * This work is licensed under the terms of the GNU LGPL, version 2.1 or later.
+ * See the COPYING file in the top-level directory.
+ */
+
+#ifndef S390_HOST_SIGNAL_H
+#define S390_HOST_SIGNAL_H
+
+/* The third argument to a SA_SIGINFO handler is ucontext_t. */
+typedef ucontext_t host_sigcontext;
+
+static inline uintptr_t host_signal_pc(host_sigcontext *uc)
+{
+    return uc->uc_mcontext.psw.addr;
+}
+
+static inline void host_signal_set_pc(host_sigcontext *uc, uintptr_t pc)
+{
+    uc->uc_mcontext.psw.addr = pc;
+}
+
+static inline void *host_signal_mask(host_sigcontext *uc)
+{
+    return &uc->uc_sigmask;
+}
+
+static inline bool host_signal_write(siginfo_t *info, host_sigcontext *uc)
+{
+    uint16_t *pinsn = (uint16_t *)host_signal_pc(uc);
+
+    /*
+     * ??? On linux, the non-rt signal handler has 4 (!) arguments instead
+     * of the normal 2 arguments.  The 4th argument contains the "Translation-
+     * Exception Identification for DAT Exceptions" from the hardware (aka
+     * "int_parm_long"), which does in fact contain the is_write value.
+     * The rt signal handler, as far as I can tell, does not give this value
+     * at all.  Not that we could get to it from here even if it were.
+     * So fall back to parsing instructions.  Treat read-modify-write ones as
+     * writes, which is not fully correct, but for tracking self-modifying code
+     * this is better than treating them as reads.  Checking si_addr page flags
+     * might be a viable improvement, albeit a racy one.
+     */
+    /* ??? This is not even close to complete.  */
+    switch (pinsn[0] >> 8) {
+    case 0x50: /* ST */
+    case 0x42: /* STC */
+    case 0x40: /* STH */
+    case 0x44: /* EX */
+    case 0xba: /* CS */
+    case 0xbb: /* CDS */
+        return true;
+    case 0xc4: /* RIL format insns */
+        switch (pinsn[0] & 0xf) {
+        case 0xf: /* STRL */
+        case 0xb: /* STGRL */
+        case 0x7: /* STHRL */
+            return true;
+        }
+        break;
+    case 0xc6: /* RIL-b format insns */
+        switch (pinsn[0] & 0xf) {
+        case 0x0: /* EXRL */
+            return true;
+        }
+        break;
+    case 0xc8: /* SSF format insns */
+        switch (pinsn[0] & 0xf) {
+        case 0x2: /* CSST */
+            return true;
+        }
+        break;
+    case 0xe3: /* RXY format insns */
+        switch (pinsn[2] & 0xff) {
+        case 0x50: /* STY */
+        case 0x24: /* STG */
+        case 0x72: /* STCY */
+        case 0x70: /* STHY */
+        case 0x8e: /* STPQ */
+        case 0x3f: /* STRVH */
+        case 0x3e: /* STRV */
+        case 0x2f: /* STRVG */
+            return true;
+        }
+        break;
+    case 0xe6:
+        switch (pinsn[2] & 0xff) {
+        case 0x09: /* VSTEBRH */
+        case 0x0a: /* VSTEBRG */
+        case 0x0b: /* VSTEBRF */
+        case 0x0e: /* VSTBR */
+        case 0x0f: /* VSTER */
+        case 0x3f: /* VSTRLR */
+            return true;
+        }
+        break;
+    case 0xe7:
+        switch (pinsn[2] & 0xff) {
+        case 0x08: /* VSTEB */
+        case 0x09: /* VSTEH */
+        case 0x0a: /* VSTEG */
+        case 0x0b: /* VSTEF */
+        case 0x0e: /* VST */
+        case 0x1a: /* VSCEG */
+        case 0x1b: /* VSCEF */
+        case 0x3e: /* VSTM */
+        case 0x3f: /* VSTL */
+            return true;
+        }
+        break;
+    case 0xeb: /* RSY format insns */
+        switch (pinsn[2] & 0xff) {
+        case 0x14: /* CSY */
+        case 0x30: /* CSG */
+        case 0x31: /* CDSY */
+        case 0x3e: /* CDSG */
+        case 0xe4: /* LANG */
+        case 0xe6: /* LAOG */
+        case 0xe7: /* LAXG */
+        case 0xe8: /* LAAG */
+        case 0xea: /* LAALG */
+        case 0xf4: /* LAN */
+        case 0xf6: /* LAO */
+        case 0xf7: /* LAX */
+        case 0xfa: /* LAAL */
+        case 0xf8: /* LAA */
+            return true;
+        }
+        break;
+    }
+    return false;
+}
+
+#endif
-- 
2.41.0


