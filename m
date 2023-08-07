Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDE2F771D5F
	for <lists+qemu-devel@lfdr.de>; Mon,  7 Aug 2023 11:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSwqi-0001cI-S8; Mon, 07 Aug 2023 05:48:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqb-0001OK-LT
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qSwqY-0003Na-QV
 for qemu-devel@nongnu.org; Mon, 07 Aug 2023 05:48:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691401697;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zkk2LjmI/HFHL6lFuM9lrbndUs9UU/AhpRhRIBVdFB0=;
 b=gRmY1fdE7z7dn3HEoQO7Ea7LuWpXoRc+xyi+IZ5y2Q8cALJk7sSGoHGDauiJuOZ40rp8g4
 aLGkBT1Cph5jl1uxGIswXZd5OnVK61KG7vQSzQQ93cPFPwTsLhxfEj9LSoczTT6uVAN1GU
 1orksPPlyihn2Jv/orjS41m6hps4cDY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-615-xGLUWQP9Nl6Xg-UmYczsiw-1; Mon, 07 Aug 2023 05:48:16 -0400
X-MC-Unique: xGLUWQP9Nl6Xg-UmYczsiw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-317a0d22311so2454869f8f.0
 for <qemu-devel@nongnu.org>; Mon, 07 Aug 2023 02:48:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691401694; x=1692006494;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Zkk2LjmI/HFHL6lFuM9lrbndUs9UU/AhpRhRIBVdFB0=;
 b=HOV0dzilSlpAVaHnd4I+2jMRhTX9wSgsOHp61d9jwPpZt4/GSaQ55XgwZ1/H3EyeOZ
 6yS2Gi1UkRm8RghnLocKsV3gbVvKnDgXIui+tkB9GOPCeSbdwahzIakASqr8gztS7AzQ
 OZtxFtLnLt2/rAUeLbLu3CzZ2J3Z/omTCRjD7XjRCcOQ2E5PsBprBw4zEt6+Q6roddJi
 VTGsnynUP4Es2/fSxdST4JjSwNEATB99IYOqdWY9KJ5gbxE0ZcJ1h2Btik+0YQLJLfSo
 wk/8kJ7wbLgn96zkONfRzv1BrarN9kCQ9CFZ7zsSZLsjX0ATIxPz6tCIG9sTocF/DN1w
 Nc5g==
X-Gm-Message-State: AOJu0Yx90VY7MFNKlQWGe2XyKHNjsXFIqy77mQHxOL4r5xH3eT+Gro/H
 i6dk8739kYHdnQJOWzoieWrzoRcRMzsVH91EjagI+ILxgq3vKKPN4FL741g3u9N0NMhVGsDaKrV
 PccuxkrhalyrUj2w6+GEC9zaW1P8iNRwzu0d+sQFxr/cDkVTlI9CdQidI44nSfWeAZtfCYXNPOg
 8=
X-Received: by 2002:a5d:56ca:0:b0:317:6cd2:b90c with SMTP id
 m10-20020a5d56ca000000b003176cd2b90cmr6449350wrw.13.1691401694377; 
 Mon, 07 Aug 2023 02:48:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/Gff1YpzKFWH7TqtP1f8HG1nLhHt/2m9Kykb4GZSWiB6L0Gk7xkLZeeXT2pWN4c8NVQjRMQ==
X-Received: by 2002:a5d:56ca:0:b0:317:6cd2:b90c with SMTP id
 m10-20020a5d56ca000000b003176cd2b90cmr6449336wrw.13.1691401694061; 
 Mon, 07 Aug 2023 02:48:14 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 k18-20020a5d66d2000000b0031417fd473csm10050398wrw.78.2023.08.07.02.48.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Aug 2023 02:48:13 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org,
	philmd@linaro.org
Subject: [PATCH 2/3] linux-user: cleanup unused linux-user/include/host
 directories
Date: Mon,  7 Aug 2023 11:48:06 +0200
Message-ID: <20230807094807.471646-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230807094807.471646-1-pbonzini@redhat.com>
References: <20230807094807.471646-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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
---
 linux-user/include/host/alpha/host-signal.h |  55 --------
 linux-user/include/host/s390/host-signal.h  | 138 --------------------
 2 files changed, 193 deletions(-)
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
-- 
2.41.0


