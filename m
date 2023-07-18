Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D83A97581C7
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 18:11:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLnGf-0001mp-2t; Tue, 18 Jul 2023 12:09:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1qLnGc-0001mc-Ol
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 12:09:39 -0400
Received: from [2a00:dcc0:1ea5:31f2::1] (helo=bonnix2.bonnix.it)
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1qLnGa-0004jS-C9
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 12:09:38 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 23E1DADCE8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1689696571;
 bh=S5lMKfDkeUunX1NK+z7qbTuhRXLAPbjB1oBkreCRN1o=;
 h=Date:Subject:From:To:References:Cc:In-Reply-To;
 b=sKB9CI7nNT023ATCbdCtpkad385YDYAFsg9+e+hn71pADZ2I6JE50dcR69OQt/TNr
 aK4O4o7UgNT4QDvY20+6QIhJVba08uJHq5gcTV43vEz7ay83w+OKecxgUmWNhpM4aN
 VbbqESzfp8xTKNmXwpxHX7bxBHhmPw73e6vDj1Ro=
Received: from [10.0.0.152] (unknown [82.84.102.14])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 23E1DADCE8;
 Tue, 18 Jul 2023 18:09:31 +0200 (CEST)
Message-ID: <b542dcc6-8e74-4790-d8a2-d6c6e60a3a57@bonslack.org>
Date: Tue, 18 Jul 2023 18:09:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] Missing CASA instruction handling for SPARC qemu-user
Content-Language: it, en-US
From: Luca Bonissi <qemu@bonslack.org>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
References: <4a785697-de37-3a3e-bf38-b20044cb56af@bonslack.org>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
In-Reply-To: <4a785697-de37-3a3e-bf38-b20044cb56af@bonslack.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Host-Lookup-Failed: Reverse DNS lookup failed for 2a00:dcc0:1ea5:31f2::1
 (failed)
Received-SPF: pass client-ip=2a00:dcc0:1ea5:31f2::1;
 envelope-from=qemu@bonslack.org; helo=bonnix2.bonnix.it
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.095,
 RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On qemu-sparc (user-space), the CASA instruction is not handled for 
SPARC32 even if the selected cpu (e.g. LEON3) supports it.

Following the patch that works.

The patch also include an incorrect cpu-type for 32bit and missing 
configurable CPU features TA0_SHUTDOWN, ASR17, CACHE_CTRL, POWERDOWN, 
and CASA.

Re-posting to add "signed-off-by" line. Removing also unused functions 
from qemu-sparc (32bit) building, and consequently removed helper patch 
(needed only by unused [removed] functions).


Signed-off-by: Luca Bonissi <qemu@bonslack.org>
---

diff -urp a/linux-user/syscall.c b/linux-user/syscall.c
--- a/linux-user/syscall.c	2023-03-27 15:41:42.000000000 +0200
+++ b/linux-user/syscall.c	2023-04-01 13:54:14.709136932 +0200
@@ -8286,7 +8286,11 @@ static int open_net_route(CPUArchState *
  #if defined(TARGET_SPARC)
  static int open_cpuinfo(CPUArchState *cpu_env, int fd)
  {
+#if defined(TARGET_SPARC64)
      dprintf(fd, "type\t\t: sun4u\n");
+#else
+    dprintf(fd, "type\t\t: sun4m\n");
+#endif
      return 0;
  }
  #endif
diff -urp a/target/sparc/cpu.c b/target/sparc/cpu.c
--- a/target/sparc/cpu.c	2023-03-27 15:41:42.000000000 +0200
+++ b/target/sparc/cpu.c	2023-03-31 21:32:54.927008782 +0200
@@ -560,6 +560,11 @@ static const char * const feature_name[]
      "hypv",
      "cmt",
      "gl",
+    "ta0shdn",
+    "asr17",
+    "cachectrl",
+    "powerdown",
+    "casa",
  };

  static void print_features(uint32_t features, const char *prefix)
@@ -852,6 +857,11 @@ static Property sparc_cpu_properties[] =
      DEFINE_PROP_BIT("hypv",     SPARCCPU, env.def.features, 11, false),
      DEFINE_PROP_BIT("cmt",      SPARCCPU, env.def.features, 12, false),
      DEFINE_PROP_BIT("gl",       SPARCCPU, env.def.features, 13, false),
+    DEFINE_PROP_BIT("ta0shdn",  SPARCCPU, env.def.features, 14, false),
+    DEFINE_PROP_BIT("asr17",    SPARCCPU, env.def.features, 15, false),
+    DEFINE_PROP_BIT("cachectrl",SPARCCPU, env.def.features, 16, false),
+    DEFINE_PROP_BIT("powerdown",SPARCCPU, env.def.features, 17, false),
+    DEFINE_PROP_BIT("casa",     SPARCCPU, env.def.features, 18, false),
      DEFINE_PROP_UNSIGNED("iu-version", SPARCCPU, env.def.iu_version, 0,
                           qdev_prop_uint64, target_ulong),
      DEFINE_PROP_UINT32("fpu-version", SPARCCPU, env.def.fpu_version, 0),
diff -urp a/target/sparc/translate.c b/target/sparc/translate.c
--- a/target/sparc/translate.c	2023-03-27 15:41:42.000000000 +0200
+++ b/target/sparc/translate.c	2023-07-18 17:27:30.681134549 +0200
@@ -1917,7 +1917,6 @@ static void gen_ldstub(DisasContext *dc,
  }

  /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
  typedef enum {
      GET_ASI_HELPER,
      GET_ASI_EXCP,
@@ -2149,6 +2148,7 @@ static DisasASI get_asi(DisasContext *dc
      return (DisasASI){ type, asi, mem_idx, memop };
  }

+#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
  static void gen_ld_asi(DisasContext *dc, TCGv dst, TCGv addr,
                         int insn, MemOp memop)
  {
@@ -2277,6 +2277,7 @@ static void gen_swap_asi(DisasContext *d
          break;
      }
  }
+#endif // !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)

  static void gen_cas_asi(DisasContext *dc, TCGv addr, TCGv cmpv,
                          int insn, int rd)
@@ -2300,6 +2301,7 @@ static void gen_cas_asi(DisasContext *dc
      }
  }

+#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
  static void gen_ldstub_asi(DisasContext *dc, TCGv dst, TCGv addr, int 
insn)
  {
      DisasASI da = get_asi(dc, insn, MO_UB);
@@ -5508,7 +5510,6 @@ static void disas_sparc_insn(DisasContex
                  case 0x37: /* stdc */
                      goto ncp_insn;
  #endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                  case 0x3c: /* V9 or LEON3 casa */
  #ifndef TARGET_SPARC64
                      CHECK_IU_FEATURE(dc, CASA);
@@ -5517,7 +5518,6 @@ static void disas_sparc_insn(DisasContex
                      cpu_src2 = gen_load_gpr(dc, rs2);
                      gen_cas_asi(dc, cpu_addr, cpu_src2, insn, rd);
                      break;
-#endif
                  default:
                      goto illegal_insn;
                  }

