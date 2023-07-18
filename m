Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9990757D87
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 15:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLklB-0000ZW-NM; Tue, 18 Jul 2023 09:29:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu@bonslack.org>) id 1qLkl8-0000RE-R0
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:28:58 -0400
Received: from bonnix2.bonnix.it ([37.247.49.194])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu@bonslack.org>) id 1qLkkx-0001Ik-Av
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 09:28:50 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 bonnix2.bonnix.it 23A7FADC38
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bonslack.org;
 s=20220805; t=1689686924;
 bh=iZR9A+i1M2t7txDLSnFMRJ7j9utpkv3II0xxrA4hbU8=;
 h=Date:To:From:Subject;
 b=IyRM9gKMOwE1hDBm3ObfkvWaOoWkb4GIXXW0rxaRSTdClLdRnAtPirNTS671cL6Qv
 /rAKUzHIu3YfUX8xDr498OKO2ITIDodUhLp+5KfhC1Y9r3JbPgg5sLjgYQPi+0Cy5L
 0efmwXmIMJL6lQX7arcpsaVvZILPTHcwhZXgRMhY=
Received: from [10.0.0.152] (unknown [82.84.102.14])
 by bonnix2.bonnix.it (Postfix) with ESMTPSA id 23A7FADC38
 for <qemu-devel@nongnu.org>; Tue, 18 Jul 2023 15:28:44 +0200 (CEST)
Message-ID: <4a785697-de37-3a3e-bf38-b20044cb56af@bonslack.org>
Date: Tue, 18 Jul 2023 15:28:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: it
To: qemu-devel@nongnu.org
From: Luca Bonissi <qemu@bonslack.org>
Subject: Missing CASA instruction handling for SPARC qemu-user
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=37.247.49.194; envelope-from=qemu@bonslack.org;
 helo=bonnix2.bonnix.it
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Following the patch that works. I created "fake" ld/st_asi helpers: it 
seems all works fine, but I don't know if we should make real ld/st 
helpers like for SPARC64 user-space. Please check.

The patch also include an incorrect cpu-type for 32bit and missing 
configureable CPU features TA0_SHUTDOWN, ASR17, CACHE_CTRL, POWERDOWN, 
and CASA.


diff -urp qemu-20230327.orig/linux-user/syscall.c 
qemu-20230327/linux-user/syscall.c
--- qemu-20230327.orig/linux-user/syscall.c	2023-03-27 
15:41:42.000000000 +0200
+++ qemu-20230327/linux-user/syscall.c	2023-04-01 13:54:14.709136932 +0200
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
diff -urp qemu-20230327.orig/target/sparc/cpu.c 
qemu-20230327/target/sparc/cpu.c
--- qemu-20230327.orig/target/sparc/cpu.c	2023-03-27 15:41:42.000000000 
+0200
+++ qemu-20230327/target/sparc/cpu.c	2023-03-31 21:32:54.927008782 +0200
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
diff -urp qemu-20230327.orig/target/sparc/helper.h 
qemu-20230327/target/sparc/helper.h
--- qemu-20230327.orig/target/sparc/helper.h	2023-03-27 
15:41:42.000000000 +0200
+++ qemu-20230327/target/sparc/helper.h	2023-03-31 20:41:36.084224862 +0200
@@ -38,10 +38,10 @@ DEF_HELPER_3(tsubcctv, tl, env, tl, tl)
  DEF_HELPER_FLAGS_3(sdivx, TCG_CALL_NO_WG, s64, env, s64, s64)
  DEF_HELPER_FLAGS_3(udivx, TCG_CALL_NO_WG, i64, env, i64, i64)
  #endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+//#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
  DEF_HELPER_FLAGS_4(ld_asi, TCG_CALL_NO_WG, i64, env, tl, int, i32)
  DEF_HELPER_FLAGS_5(st_asi, TCG_CALL_NO_WG, void, env, tl, i64, int, i32)
-#endif
+//#endif
  DEF_HELPER_FLAGS_1(check_ieee_exceptions, TCG_CALL_NO_WG, tl, env)
  DEF_HELPER_FLAGS_3(ldfsr, TCG_CALL_NO_RWG, tl, env, tl, i32)
  DEF_HELPER_FLAGS_1(fabss, TCG_CALL_NO_RWG_SE, f32, f32)
diff -urp qemu-20230327.orig/target/sparc/ldst_helper.c 
qemu-20230327/target/sparc/ldst_helper.c
--- qemu-20230327.orig/target/sparc/ldst_helper.c	2023-03-27 
15:41:42.000000000 +0200
+++ qemu-20230327/target/sparc/ldst_helper.c	2023-03-31 
21:02:21.897968335 +0200
@@ -1167,7 +1168,19 @@ void helper_st_asi(CPUSPARCState *env, t
  #endif
  }

+#else /* CONFIG_USER_ONLY */
+uint64_t helper_ld_asi(CPUSPARCState *env, target_ulong addr,
+                       int asi, uint32_t memop)
+{
+	return(0);
+}
+void helper_st_asi(CPUSPARCState *env, target_ulong addr, uint64_t val,
+                   int asi, uint32_t memop)
+{
+}
+
  #endif /* CONFIG_USER_ONLY */
+
  #else /* TARGET_SPARC64 */

  #ifdef CONFIG_USER_ONLY
diff -urp qemu-20230327.orig/target/sparc/translate.c 
qemu-20230327/target/sparc/translate.c
--- qemu-20230327.orig/target/sparc/translate.c	2023-03-27 
15:41:42.000000000 +0200
+++ qemu-20230327/target/sparc/translate.c	2023-04-01 15:24:18.293176711 
+0200
@@ -1910,7 +1910,8 @@ static void gen_ldstub(DisasContext *dc,
  }

  /* asi moves */
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+//#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+#if 1
  typedef enum {
      GET_ASI_HELPER,
      GET_ASI_EXCP,
@@ -5521,7 +5522,7 @@ static void disas_sparc_insn(DisasContex
                  case 0x37: /* stdc */
                      goto ncp_insn;
  #endif
-#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
+//#if !defined(CONFIG_USER_ONLY) || defined(TARGET_SPARC64)
                  case 0x3c: /* V9 or LEON3 casa */
  #ifndef TARGET_SPARC64
                      CHECK_IU_FEATURE(dc, CASA);
@@ -5529,8 +5530,8 @@ static void disas_sparc_insn(DisasContex
                      rs2 = GET_FIELD(insn, 27, 31);
                      cpu_src2 = gen_load_gpr(dc, rs2);
                      gen_cas_asi(dc, cpu_addr, cpu_src2, insn, rd);
+//#endif
                      break;
-#endif
                  default:
                      goto illegal_insn;
                  }

