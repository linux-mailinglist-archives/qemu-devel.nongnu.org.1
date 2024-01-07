Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA3E826542
	for <lists+qemu-devel@lfdr.de>; Sun,  7 Jan 2024 18:06:51 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMWbW-0001Cz-IA; Sun, 07 Jan 2024 12:06:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWbQ-0001Bw-IG; Sun, 07 Jan 2024 12:06:25 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rMWbO-0008Q0-Lq; Sun, 07 Jan 2024 12:06:24 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1d3ef33e68dso6871335ad.1; 
 Sun, 07 Jan 2024 09:06:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1704647181; x=1705251981; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ktsLKK29f+/IeeDEKz0GGjKbLwJBswLySVd2HaxcMCQ=;
 b=dGXk19ikIB4WeaA9AUP86cvgXYTSL004LxAUcMaswjckXzPwkBQNbhrA0SKWICEflO
 RxmGRasWLwjiPg2yBfdIbIfIqdTGwwptJD2df1xNdqxFpewSZGKhlYp8Vq4wkWX2azkl
 TfHMgoWnZ5bENmFgm7VsYoJrsimcWJHrgEogfPqFP8UmBSEPCJ4O5El4w4/iW238VGW/
 Kh2vQ6B5DCjEQnxcNs3YxW3O8PnD6FwzYjuQOnynZsyz2ciddEudedNMMHfZQc6ZBI7k
 o8Rayq0Vd2IN4l+s7G3g6LaeybDknHD71LetKLoJmXEra9HFftu12neUWn0l+kYlNA37
 b7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704647181; x=1705251981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ktsLKK29f+/IeeDEKz0GGjKbLwJBswLySVd2HaxcMCQ=;
 b=Il5slQrzuJEnkSNXtogeuHON/mtfXdXAdTaNzL+UJoZu/QzfwIKcu9x2kG4q08Pm+w
 uzCAqugHv8ARAoKgSPdwo0MdZq5zPYpMUMgw6EAuzP5CgJepTgQwTKo5nY0qJ7lO8Hqr
 YDQwCPSbAGf1XZWz0wsq/2J1ppWi2mE434U1UQHEQxu53+yE5OjrY8v+WNnQ3pPFotU8
 LFARyTquW3/8pjFEFjCSeGgLjMxvZAK4WUis9Y/zM474rUYBH1D8/ssYBdOC8pNK2tLF
 I73px42ugUIyAimDVRciqQgS5DVqzqtvmMNtljsysry4eEXkTrp6aA8Jo/Y2piHm05hM
 wcnQ==
X-Gm-Message-State: AOJu0Yz2Qdv2XKSigfEFs1YNf4sx+I+V1rXWQtyuoIcePpwQ3VYS+8tR
 G5U+5GikqPTwC4WxoubnnvZI3jKHmgM=
X-Google-Smtp-Source: AGHT+IG5/Kxk51jBHHP6WfkkidzQ/WagyNMX8fAVZ+ilE3bIMUA8RcXKOVuX9dFc2GIwG6xeGQN6kw==
X-Received: by 2002:a17:903:11c5:b0:1d4:bd18:7c47 with SMTP id
 q5-20020a17090311c500b001d4bd187c47mr3334548plh.57.1704647180692; 
 Sun, 07 Jan 2024 09:06:20 -0800 (PST)
Received: from wheely.local0.net ([203.87.79.144])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a170902834100b001cff026df52sm4633203pln.221.2024.01.07.09.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jan 2024 09:06:15 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Subject: [PATCH] target/ppc: Fix crash on machine check caused by ifetch
Date: Mon,  8 Jan 2024 03:05:59 +1000
Message-ID: <20240107170559.82383-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

is_prefix_insn_excp() loads the first word of the instruction address
which caused an exception, to determine whether or not it was prefixed
so the prefix bit can be set in [H]SRR1.

In case it was the instruction fetch itself that caused the exception,
the [H]SRR1 prefix bit is not required to be set, because it is not the
instruction itself that causes the interrupt. If the load is attempted,
t could cause a recursive exception.

Instruction storage interrupts, HDSIs caused by ifetch are excluded from
the prefix check. Machine checks caused by ifetch are not, and these
can cause bugs. For example fetching from an unmapped physical address
can result in:

  ERROR:../system/cpus.c:504:qemu_mutex_lock_iothread_impl:
      assertion failed: (!qemu_mutex_iothread_locked())
  #0  __pthread_kill_implementation
      (threadid=<optimized out>, signo=signo@entry=6, no_tid=no_tid@entry=0)
      at ./nptl/pthread_kill.c:44
  #1  0x00007ffff705a15f in __pthread_kill_internal
      (signo=6, threadid=<optimized out>) at ./nptl/pthread_kill.c:78
  #2  0x00007ffff700c472 in __GI_raise (sig=sig@entry=6)
      at ../sysdeps/posix/raise.c:26
  #3  0x00007ffff6ff64b2 in __GI_abort () at ./stdlib/abort.c:79
  #4  0x00007ffff73def08 in  () at /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #5  0x00007ffff7445e4e in g_assertion_message_expr ()
      at /lib/x86_64-linux-gnu/libglib-2.0.so.0
  #6  0x0000555555a833f1 in qemu_mutex_lock_iothread_impl
      (file=0x555555efda6e "../accel/tcg/cputlb.c", line=2033)
      at ../system/cpus.c:504
  #7  qemu_mutex_lock_iothread_impl
      (file=file@entry=0x555555efda6e "../accel/tcg/cputlb.c", line=line@entry=2033) at ../system/cpus.c:500
  #8  0x0000555555cbf786 in do_ld_mmio_beN
      (cpu=cpu@entry=0x555556b72010, full=0x7fff5408e010, ret_be=ret_be@entry=0, addr=2310065133864353792, size=size@entry=4, mmu_idx=7, type=MMU_INST_FETCH, ra=0) at ../accel/tcg/cputlb.c:2033
  #9  0x0000555555cc2ec6 in do_ld_4
      (ra=0, memop=MO_BEUL, type=MMU_INST_FETCH, mmu_idx=<optimized out>, p=0x7fff67dfc660, cpu=0x555556b72010) at ../accel/tcg/cputlb.c:2336
  #10 do_ld4_mmu
      (cpu=cpu@entry=0x555556b72010, addr=<optimized out>, oi=<optimized out>, ra=ra@entry=0, access_type=access_type@entry=MMU_INST_FETCH)
      at ../accel/tcg/cputlb.c:2418
  #11 0x0000555555ccbaf6 in cpu_ldl_code
      (env=env@entry=0x555556b747d0, addr=<optimized out>)
      at ../accel/tcg/cputlb.c:2975
  #12 0x0000555555b7a47c in ppc_ldl_code
      (addr=<optimized out>, env=0x555556b747d0)
      at ../target/ppc/excp_helper.c:147
  #13 is_prefix_insn_excp (excp=1, cpu=0x555556b72010)
      at ../target/ppc/excp_helper.c:1350
  #14 powerpc_excp_books (excp=1, cpu=0x555556b72010)
      at ../target/ppc/excp_helper.c:1415
  #15 powerpc_excp (cpu=0x555556b72010, excp=<optimized out>)
      at ../target/ppc/excp_helper.c:1733
  #16 0x0000555555cb1c74 in cpu_handle_exception
      (ret=<synthetic pointer>, cpu=<optimized out>)

Fix this by excluding machine checks caused by ifetch from the prefix
check.

Fixes: 55a7fa34f89 ("target/ppc: Machine check on invalid real address access on POWER9/10")
Fixes: 5a5d3b23cb2 ("target/ppc: Add SRR1 prefix indication to interrupt handlers")
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 target/ppc/excp_helper.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
index a42743a3e0..34c307b572 100644
--- a/target/ppc/excp_helper.c
+++ b/target/ppc/excp_helper.c
@@ -1322,6 +1322,15 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     }
 
     switch (excp) {
+    case POWERPC_EXCP_MCHECK:
+        if (!(env->error_code & PPC_BIT(42))) {
+            /*
+             * Fetch attempt caused a machine check, so attempting to fetch
+             * again would cause a recursive machine check.
+             */
+            return false;
+        }
+        break;
     case POWERPC_EXCP_HDSI:
         /* HDSI PRTABLE_FAULT has the originating access type in error_code */
         if ((env->spr[SPR_HDSISR] & DSISR_PRTABLE_FAULT) &&
@@ -1332,10 +1341,10 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
              * instruction at NIP would cause recursive faults with the same
              * translation).
              */
-            break;
+            return false;
         }
-        /* fall through */
-    case POWERPC_EXCP_MCHECK:
+        break;
+
     case POWERPC_EXCP_DSI:
     case POWERPC_EXCP_DSEG:
     case POWERPC_EXCP_ALIGN:
@@ -1346,17 +1355,14 @@ static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
     case POWERPC_EXCP_VPU:
     case POWERPC_EXCP_VSXU:
     case POWERPC_EXCP_FU:
-    case POWERPC_EXCP_HV_FU: {
-        uint32_t insn = ppc_ldl_code(env, env->nip);
-        if (is_prefix_insn(env, insn)) {
-            return true;
-        }
+    case POWERPC_EXCP_HV_FU:
         break;
-    }
     default:
-        break;
+        return false;
     }
-    return false;
+
+
+    return is_prefix_insn(env, ppc_ldl_code(env, env->nip));
 }
 #else
 static bool is_prefix_insn_excp(PowerPCCPU *cpu, int excp)
@@ -3245,6 +3251,10 @@ void ppc_cpu_do_transaction_failed(CPUState *cs, hwaddr physaddr,
             env->error_code |= PPC_BIT(42);
 
         } else { /* Fetch */
+            /*
+             * is_prefix_insn_excp() tests !PPC_BIT(42) to avoid fetching
+             * the instruction, so that must always be clear for fetches.
+             */
             env->error_code = PPC_BIT(36) | PPC_BIT(44) | PPC_BIT(45);
         }
         break;
-- 
2.42.0


