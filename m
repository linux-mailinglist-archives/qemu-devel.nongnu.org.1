Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7DD7DC1AF
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 22:18:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxZeJ-00017A-Vp; Mon, 30 Oct 2023 17:18:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdx-000115-GU
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:53 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qxZdp-0006VM-H5
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 17:17:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1cc53d0030fso9722505ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 14:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698700660; x=1699305460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=o8UKlKVkoj09wOTSfnwVa8vuy3oPCOLj92gGCvrYZjE=;
 b=h7BBz2mj/SQgaMpiYWwsC+CIWR7lWViiFM/jJjlo7sjUCieu4rfJGr/kSMbVTpnMKo
 Y6NVdrguCejjXbpu96kYCrBKCDUuMa09/1oLbw7o8G1QjBwm/6c1vL5z+xAx1qSE0Pgl
 EljRmAJWaZNj2E/idibLQUlcCDtP3pRJVgqHS3XTLl7Pj9DRH9H09d9rVWFo5DMVTB4R
 Xlwt9RiHi216KsmIPVj+7Y+Y3y4A4T1lM7/aDCMeGNpCth7cGYhyDQSzi9cxs1Daiqd6
 YkCo7KhLK+sWCOPJRI+m5l/Ef7p+YRZaxAa9tqS7bP2a3NXgtjZ9XErUDMcadxssuLzm
 MmWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698700660; x=1699305460;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o8UKlKVkoj09wOTSfnwVa8vuy3oPCOLj92gGCvrYZjE=;
 b=t1ndPjq4VPS8UqaaFoKrbFopMh/rbx6qWrDoiWr5Fqt4FDi8jHeb5kZGi78Eoxw5V7
 EZn+kW+8WgZgsXSNrjmHJIS7ItfXYX1uYdeURGpRKfsiSsxj1Am606eLwBb1Hgp7hv6P
 9e5RMLSQBOw3H6wxhhpb9isAsENounyD7Bb9ehiOOIb6fOs6BAaTX6PBXT8Mz9s+Pdp+
 bXzo8aTp3jXYJsB+20eyO52j2toMcR1qrdcDmIg3V5qBLAw+DW39ERCzE6qip9sV9aEE
 +hZmZVLn9QuEm2kc/7a+NGKrhzDJog4i05KfO86V/miw2J1XHxweGSndJHbp0rneBAyl
 WAew==
X-Gm-Message-State: AOJu0YznUW1fj84q0dSUaBUSbB9dorz2YTMFxmh2Q/3e0cn69wSlZJ8l
 znojynxgD9flY4WDs5W6VKosNoyr5GjdgfgKgMk=
X-Google-Smtp-Source: AGHT+IF8sdonO/+uJUKdTvT8/QyLFdLGUySL7iGjz99Y7ZvSIP8PI8TFE3SrkqjntyrPlF9Mgv0c/g==
X-Received: by 2002:a17:903:2805:b0:1cc:30bf:d07c with SMTP id
 kp5-20020a170903280500b001cc30bfd07cmr744293plb.10.1698700660512; 
 Mon, 30 Oct 2023 14:17:40 -0700 (PDT)
Received: from stoup.. ([71.212.149.95]) by smtp.gmail.com with ESMTPSA id
 jf2-20020a170903268200b001cc32261bdfsm4670350plb.38.2023.10.30.14.17.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 30 Oct 2023 14:17:40 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/21] linux-user/arm: Add vdso
Date: Mon, 30 Oct 2023 14:17:19 -0700
Message-Id: <20231030211727.165090-14-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231030211727.165090-1-richard.henderson@linaro.org>
References: <20231030211727.165090-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/vdso-asmoffset.h |   3 +
 linux-user/arm/signal.c         |  55 ++++++----
 linux-user/elfload.c            |   3 +-
 linux-user/arm/Makefile.vdso    |  17 ++++
 linux-user/arm/meson.build      |  12 +++
 linux-user/arm/vdso-be.so       | Bin 0 -> 2648 bytes
 linux-user/arm/vdso-le.so       | Bin 0 -> 2648 bytes
 linux-user/arm/vdso.S           | 174 ++++++++++++++++++++++++++++++++
 linux-user/arm/vdso.ld          |  67 ++++++++++++
 9 files changed, 310 insertions(+), 21 deletions(-)
 create mode 100644 linux-user/arm/vdso-asmoffset.h
 create mode 100644 linux-user/arm/Makefile.vdso
 create mode 100755 linux-user/arm/vdso-be.so
 create mode 100755 linux-user/arm/vdso-le.so
 create mode 100644 linux-user/arm/vdso.S
 create mode 100644 linux-user/arm/vdso.ld

diff --git a/linux-user/arm/vdso-asmoffset.h b/linux-user/arm/vdso-asmoffset.h
new file mode 100644
index 0000000000..252a95c46e
--- /dev/null
+++ b/linux-user/arm/vdso-asmoffset.h
@@ -0,0 +1,3 @@
+/* offsetof(struct sigframe, retcode[3]) */
+#define SIGFRAME_RC3_OFFSET     756
+#define RT_SIGFRAME_RC3_OFFSET  884
diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index cf99fd7b8a..e19b514f17 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "vdso-asmoffset.h"
 
 struct target_sigcontext {
     abi_ulong trap_no;
@@ -102,6 +103,11 @@ struct rt_sigframe
     struct sigframe sig;
 };
 
+QEMU_BUILD_BUG_ON(offsetof(struct sigframe, retcode[3])
+                  != SIGFRAME_RC3_OFFSET);
+QEMU_BUILD_BUG_ON(offsetof(struct rt_sigframe, sig.retcode[3])
+                  != RT_SIGFRAME_RC3_OFFSET);
+
 static abi_ptr sigreturn_fdpic_tramp;
 
 /*
@@ -160,6 +166,9 @@ get_sigframe(struct target_sigaction *ka, CPUARMState *regs, int framesize)
     return (sp - framesize) & ~7;
 }
 
+static void write_arm_sigreturn(uint32_t *rc, int syscall);
+static void write_arm_fdpic_sigreturn(uint32_t *rc, int ofs);
+
 static int
 setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
              struct sigframe *frame, abi_ulong sp_addr)
@@ -167,9 +176,9 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     abi_ulong handler = 0;
     abi_ulong handler_fdpic_GOT = 0;
     abi_ulong retcode;
-    int thumb, retcode_idx;
-    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
-    bool copy_retcode;
+    bool is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
+    bool is_rt = ka->sa_flags & TARGET_SA_SIGINFO;
+    bool thumb;
 
     if (is_fdpic) {
         /* In FDPIC mode, ka->_sa_handler points to a function
@@ -184,9 +193,7 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     } else {
         handler = ka->_sa_handler;
     }
-
     thumb = handler & 1;
-    retcode_idx = thumb + (ka->sa_flags & TARGET_SA_SIGINFO ? 2 : 0);
 
     uint32_t cpsr = cpsr_read(env);
 
@@ -202,24 +209,32 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
         cpsr &= ~CPSR_E;
     }
 
-    if (ka->sa_flags & TARGET_SA_RESTORER) {
-        if (is_fdpic) {
-            __put_user((abi_ulong)ka->sa_restorer, &frame->retcode[3]);
-            retcode = (sigreturn_fdpic_tramp +
-                       retcode_idx * RETCODE_BYTES + thumb);
-            copy_retcode = true;
-        } else {
-            retcode = ka->sa_restorer;
-            copy_retcode = false;
-        }
+    /* Our vdso default_sigreturn label is a table of entry points. */
+    retcode = default_sigreturn + (is_fdpic * 2 + is_rt) * 8;
+
+    /*
+     * Put the sigreturn code on the stack no matter which return
+     * mechanism we use in order to remain ABI compliant.
+     * Because this is about ABI, always use the A32 instructions,
+     * despite the fact that our actual vdso trampoline is T16.
+     */
+    if (is_fdpic) {
+        write_arm_fdpic_sigreturn(frame->retcode,
+                                  is_rt ? RT_SIGFRAME_RC3_OFFSET
+                                        : SIGFRAME_RC3_OFFSET);
     } else {
-        retcode = default_sigreturn + retcode_idx * RETCODE_BYTES + thumb;
-        copy_retcode = true;
+        write_arm_sigreturn(frame->retcode,
+                            is_rt ? TARGET_NR_rt_sigreturn
+                                  : TARGET_NR_sigreturn);
     }
 
-    /* Copy the code to the stack slot for ABI compatibility. */
-    if (copy_retcode) {
-        memcpy(frame->retcode, g2h_untagged(retcode & ~1), RETCODE_BYTES);
+    if (ka->sa_flags & TARGET_SA_RESTORER) {
+        if (is_fdpic) {
+            /* Place the function descriptor in slot 3. */
+            __put_user((abi_ulong)ka->sa_restorer, &frame->retcode[3]);
+        } else {
+            retcode = ka->sa_restorer;
+        }
     }
 
     env->regs[0] = usig;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 0a3a57018b..7400ed0ca1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -944,13 +944,14 @@ const char *elf_hwcap2_str(uint32_t bit)
 
 #undef GET_FEATURE_ID
 
+#endif /* not TARGET_AARCH64 */
+
 #if TARGET_BIG_ENDIAN
 # define VDSO_HEADER  "vdso-be.c.inc"
 #else
 # define VDSO_HEADER  "vdso-le.c.inc"
 #endif
 
-#endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
 #ifdef TARGET_SPARC
diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
new file mode 100644
index 0000000000..2d098a5748
--- /dev/null
+++ b/linux-user/arm/Makefile.vdso
@@ -0,0 +1,17 @@
+include $(BUILD_DIR)/tests/tcg/arm-linux-user/config-target.mak
+
+SUBDIR = $(SRC_PATH)/linux-user/arm
+VPATH += $(SUBDIR)
+
+all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
+
+# Adding -use-blx disables unneeded interworking without actually using blx.
+LDFLAGS = -nostdlib -shared -Wl,-use-blx \
+	  -Wl,-h,linux-vdso.so.1 -Wl,--build-id=sha1 \
+	  -Wl,--hash-style=both -Wl,-T,$(SUBDIR)/vdso.ld
+
+$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
+
+$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
+	$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 5a93c925cf..c4bb9af5b8 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -5,3 +5,15 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
+# is always true as far as source_set.apply() is concerned.  Always build
+# both header files and include the right one via #if.
+
+vdso_be_inc = gen_vdso.process('vdso-be.so',
+                               extra_args: ['-s', 'sigreturn_codes'])
+
+vdso_le_inc = gen_vdso.process('vdso-le.so',
+                               extra_args: ['-s', 'sigreturn_codes'])
+
+linux_user_ss.add(when: 'TARGET_ARM', if_true: [vdso_be_inc, vdso_le_inc])
diff --git a/linux-user/arm/vdso-be.so b/linux-user/arm/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..69cafbb956e283e2975bac59a10491c0cbafca57
GIT binary patch
literal 2648
zcmbtVO>A355T57%q>ketR9ezQ5D`VCwMu1`A`rrf?W8D4OPYuR5-*PZ5?ds8WWR(2
z@#8{h3oY#>2P%XJf@`Y?wNft?xqwg)z@Y~Y{2jstAq3+00GRLFx0^a47sMproBd{H
zci-Ec8NZkr$XY&2*2OP(V{8mbk?=~e?h{E$mjvPKkU0Dy0KRoBV@w1z%zRKvVA+F&
z^~zXK{%ArSV?xa@xZfTX@xgB(Y4`}`*ZKyuK{v)kv;S6bf8WrkT>1HI=J#C}-v0DM
z`Ko86^ZqyN_qyPV0iyusSZkHW-@jr%ep?Va4UKQK=Am1G3a|}`R~n5!;a`RR3)~0&
zBh+P#|F5L*D%>Y>i%1lDAGibEs`+;CC!09VIPho_XRMMAY5ar%&)0|_1Kt@mh37=U
zx2hZAeHdX3?~e!ucLq!h=LA<euS;?N`Qf&!pY@h|-`#oFM|;kQZO;{I6+1sw$v<sR
zI<8xqcD6JgO#aJUb!x_@XI3T(xdoXjm1pPoaoq&|@0EeWL!-y-1Brup3mo|RpN03t
zU)v8KyaPM$d>6obHD6}=FU|f2Mju6;lhx^e0ON;&FanQ51J*e74D=NAY3MoVW#|{6
zanIHg5CLf03mfxAtY?SC_gu{CjJA<-pB(_tzg1GP$SL1Bo+a)3f$z4k_rvzZ7WOgN
zJ^><4>m<Rs=P_*B&P~Va@e}PY#a?b(jJ~q%Wb3Jx(~(!huZ7M8&jw!ipYxsP<`C}x
zAaD}cE`70Yw7m=bV_*@8N<0>P{+D1V6mJPr-x*-qNEh%uz;lUsF(DljGBI$8)UPyl
zNA8oa>(@A1S|7FO(a>)CR<q{s8E}p-YJKg^==BTPc;A;=r?BR2IVU$>!Yzxm1(PEZ
z^0nw!=Z+iX1{o6A_<0B9K5Cff`2=T<L#)sF1kv?it!d7jhp2u)zd8i)G_Bys8H!i;
z;K&KZSNQ~Qp@!e=&mIEt^Ze;&FM$M(@(CWLHUiE>GT(rgQ}v7(FCIR|w_~Q7kFj14
zBZ!Vi+wgjT<<0Me=LBqBI1J9e$GjiLe7}dxdFc2N*p%pg@)YJb_opg2YsvH{<kg1$
z^cMKd{*=!@G1Iq@Ehj3{?Min+?DXS9slmg&QY%eX9e1``w)2&O>IP`qcBbFX4yOh)
zc7J+U?7o2`J*ffvNH%*cGh&aVdImCfQ%ledXhQ?p+?1Lc&4xy`MNd-wOA@t(X*V|x
z?N&WqG^29GbtF+(DCee2c{M;Rbk5C5VzNA&DCTNK&+b+|%bZiKl`7>8#4bp}DcTd&
z+_YmC3y3sK60S4vN+LBpn8>+qwKP8K;%NSp;J#I!GWS^*L^ohW=e*nj1M?ecr}Bk4
zTL*NGBb~hb-UH1%!+NYERZC;wjAO1cj{Wd}=2(yQrE07>zZplc7FcIoZ_R`31?PKE
zOxz*-#<G7Sj`gT&G6}vpu1DJ#m-e83w_#Rd>gf@z*MNm_mp!O@FzdlipFC!M<3U$F
z$RXJIz4Y__C=&qJ=6X0gRrA<?T}+${i;iO-Ags;j!b$wCVI1y+^{#5()H(e;W6I*p
z%`*TEEaR~QFv2w`dQXoa?kY?xVCWzC9e@Ggn(SHT3@{88@pvCFV%F<`p(!qWJNS|b
If>v?=0AXBj6aWAK

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-le.so b/linux-user/arm/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..ad05a1251875ac0c76685e1f9190a7307a8444d1
GIT binary patch
literal 2648
zcmbtWU1%It6h5<)-6ZYqW>ciL#)n9wmD&!qgeWwKo1aZ8NgB5ajR>7=b|=}zWT)&-
zVj@~ojcv8s`j8h9Aw_&tf++N*n7)V<5g#h}py-1lh)4@s`cPfJ@6OyfN%J6hHs74{
zoqO(`JNMpmZeH#k$QXtpT1<IZG;4=*wH}X%MBAlRqG)TDl*Hg-o5l)kqAq~$52|DZ
z4Frc0j2^-Bb_k2G3EhAAXRmM@K^i@1BXm3U^$^-%6XEuIz)hfUXjI-lT>i52o2xxn
z_w4-TgA;d}AB-ETNwkdyeSX4(|NOh=rtr=vd_B<o#(DU+LA$_qAO+m1)!a3-{{;;t
zH=sYE@joSv{w_YC0eXkT<p8t;&i9k=gnl-}xyDb2xC5@GS#H+2zFN2r{2powx+&qe
za-8t=8ABhz_GsPiC~fv3muoGn*^38@-Cti$?0&zye16~O4~cEh6{@bCpLX-l*;9_^
zm1dkRogM9Wxhqap`+}bCWFfa8)1~t4`~i+@;qOryI5IRkW*@RTIEl#m&%jLiyY$)b
z3GVs*0QZ&Rf14q<W<N67M$zkJw3vsV1m~F?L*N+n1oTPhY3Os%bI>c$r=V{@FGDxb
z2kZxU9w^2OS&6)uG+N>b;d^!gTz~GJq>~M2BNq(%4+6geoBjRpeYb^w9KNpro(Vlp
zJ8cNwc?>UY;!DRDQ>U9=Nxqs`iodq~%(k<Q=NewGe<OB2`exl*=7q>bOjXUR6Z#Cm
zvm|}VAL(xez5tehI3THH^rb(du~@3Ho_bGROvU_$rfERUMa9H|n3#%TSIXk2wY?3G
z$q$QHXf3Z>je#|^mu+hq{d*pq_J@JK@^1XvJDF79_km8|i$QZvZlWYc0%o**L}HOf
zPW>*q9(YW(^Zp*tWd<jl`RsE)6TV&Nenzkk`0eVX3+sW;nLU18@VQ^fbl#i(s>s@U
ze4~nI{qp10j!S2dfTpS@BEvx<n*PfB!FZaI2)@8~)ghm`H#(j>)kLlnIvCH7X0G0>
z?Euj=zyNOnKaKabLPya55w-{O<B5C%T(1Y?N5HkPo}2&)*QW}2xIXb*h3nIM;Nkit
z`Mh_$BQrW|xzgrITS4reXNJ;)N4lk2nyNV7Y^7}H-GZtHDB5;!zn#gZ2Yc=Qo~+n?
z14p~k1NPBO=2-8DJ(BJk=(R&7At*o_3drW76e=_u3e^@hN!2g0stYq-ZUWk?_`0aA
zvg<iw6&A|5nNnUEh=tC1IkBe7vsN)zE&6`1;(O+tO10#cHxRoZmQ%DRE4dlRE*21}
znOL4P?}?Sp4q7?StCS{YJuJ<C7w)%zb^m);wuQO}M^7GrPu~qZFT^6?pK!nKGw1gK
zyaRb;m`B7oY{tP<_XF$Up@8#f@;ni$u7FecUV^oVS;q00cf@|!`bg`z$Kksb+_lU{
zf;Dh+Tvy=Zc)Y&}-rHI*yppHztOesSe+kY{j|ZyebR1gW@oR7roQqyl&W|z)aBTJq
z|GxsNM8|nxI*xUKi0etAO~;)I;<zWwcLms5^qsQ=2ZlJQ{VRywr3thiTE9~_T}Iq0
noU9+b2SC+5#)_ra0Hzc%fsbhfqQ`3n569hy1zFZX&^qoPLfUOq

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso.S b/linux-user/arm/vdso.S
new file mode 100644
index 0000000000..b3bb6491dc
--- /dev/null
+++ b/linux-user/arm/vdso.S
@@ -0,0 +1,174 @@
+/*
+ * arm linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include "vdso-asmoffset.h"
+
+/*
+ * All supported cpus have T16 instructions: at least arm4t.
+ *
+ * We support user-user with m-profile cpus as an extension, because it
+ * is useful for testing gcc, which requires we avoid A32 instructions.
+ */
+	.thumb
+	.arch	armv4t
+	.eabi_attribute Tag_FP_arch, 0
+	.eabi_attribute Tag_ARM_ISA_use, 0
+
+	.text
+
+.macro	raw_syscall n
+	.ifne \n < 0x100
+	mov	r7, #\n
+	.elseif \n < 0x1ff
+	mov	r7, #0xff
+	add	r7, #(\n - 0xff)
+	.else
+	.err
+	.endif
+	swi	#0
+.endm
+
+.macro	fdpic_thunk ofs
+	ldr	r3, [sp, #\ofs]
+	ldmia	r2, {r2, r3}
+	mov	r9, r3
+	bx	r2
+.endm
+
+.macro	endf name
+	.globl	\name
+	.type	\name, %function
+	.size	\name, . - \name
+.endm
+
+/*
+ * We must save/restore r7 for the EABI syscall number.
+ * While we're doing that, we might as well save LR to get a free return,
+ * and a branch that is interworking back to ARMv5.
+ */
+
+.macro SYSCALL name, nr
+\name:
+	.cfi_startproc
+	push	{r7, lr}
+	.cfi_adjust_cfa_offset 8
+	.cfi_offset r7, -8
+	.cfi_offset lr, -4
+	raw_syscall \nr
+	pop	{r7, pc}
+	.cfi_endproc
+endf \name
+.endm
+
+SYSCALL	__vdso_clock_gettime, __NR_clock_gettime
+SYSCALL __vdso_clock_gettime64, __NR_clock_gettime64
+SYSCALL __vdso_clock_getres, __NR_clock_getres
+SYSCALL __vdso_gettimeofday, __NR_gettimeofday
+
+
+/*
+ * We, like the real kernel, use a table of sigreturn trampolines.
+ * Unlike the real kernel, we do not attempt to pack this into as
+ * few bytes as possible -- simply use 8 bytes per slot.
+ *
+ * Within each slot, use the exact same code sequence as the kernel,
+ * lest we trip up someone doing code inspection.
+ */
+
+.macro	slot n
+	.balign	8
+	.org	sigreturn_codes + 8 * \n
+.endm
+
+.macro cfi_fdpic_r9 ofs
+	/*
+	 * fd = *(r13 + ofs)
+         * r9 = *(fd + 4)
+	 *
+	 * DW_CFA_expression r9, length (7),
+	 *   DW_OP_breg13, ofs, DW_OP_deref,
+	 *   DW_OP_plus_uconst, 4, DW_OP_deref
+         */
+	.cfi_escape 0x10, 9, 7, 0x7d, (\ofs & 0x7f) + 0x80, (\ofs >> 7), 0x06, 0x23, 4, 0x06
+.endm
+
+.macro cfi_fdpic_pc ofs
+	/*
+	 * fd = *(r13 + ofs)
+         * pc = *fd
+	 *
+	 * DW_CFA_expression lr (14), length (5),
+	 *   DW_OP_breg13, ofs, DW_OP_deref, DW_OP_deref
+         */
+	.cfi_escape 0x10, 14, 5, 0x7d, (\ofs & 0x7f) + 0x80, (\ofs >> 7), 0x06, 0x06
+.endm
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+	.cfi_startproc simple
+	.cfi_signal_frame
+	.cfi_return_column 15
+
+	.cfi_def_cfa	sp, 32 + 64
+	.cfi_offset	r0, -16 * 4
+	.cfi_offset	r1, -15 * 4
+	.cfi_offset	r2, -14 * 4
+	.cfi_offset	r3, -13 * 4
+	.cfi_offset	r4, -12 * 4
+	.cfi_offset	r5, -11 * 4
+	.cfi_offset	r6, -10 * 4
+	.cfi_offset	r7, -9 * 4
+	.cfi_offset	r8, -8 * 4
+	.cfi_offset	r9, -7 * 4
+	.cfi_offset	r10, -6 * 4
+	.cfi_offset	r11, -5 * 4
+	.cfi_offset	r12, -4 * 4
+	.cfi_offset	r13, -3 * 4
+	.cfi_offset	r14, -2 * 4
+	.cfi_offset	r15, -1 * 4
+
+	nop
+
+	.balign	16
+sigreturn_codes:
+	/* [EO]ABI sigreturn */
+	slot	0
+	raw_syscall __NR_sigreturn
+
+	.cfi_def_cfa_offset 160 + 64
+
+	/* [EO]ABI rt_sigreturn */
+	slot	1
+	raw_syscall __NR_rt_sigreturn
+
+	.cfi_endproc
+
+	/* FDPIC sigreturn */
+	.cfi_startproc
+	cfi_fdpic_pc SIGFRAME_RC3_OFFSET
+	cfi_fdpic_r9 SIGFRAME_RC3_OFFSET
+
+	slot	2
+	fdpic_thunk SIGFRAME_RC3_OFFSET
+	.cfi_endproc
+
+	/* FDPIC rt_sigreturn */
+	.cfi_startproc
+	cfi_fdpic_pc RT_SIGFRAME_RC3_OFFSET
+	cfi_fdpic_r9 RT_SIGFRAME_RC3_OFFSET
+
+	slot	3
+	fdpic_thunk RT_SIGFRAME_RC3_OFFSET
+	.cfi_endproc
+
+	.balign	16
+endf sigreturn_codes
diff --git a/linux-user/arm/vdso.ld b/linux-user/arm/vdso.ld
new file mode 100644
index 0000000000..3b00adf27a
--- /dev/null
+++ b/linux-user/arm/vdso.ld
@@ -0,0 +1,67 @@
+/*
+ * Linker script for linux arm replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_2.6 {
+        global:
+                __vdso_clock_gettime;
+                __vdso_gettimeofday;
+                __vdso_clock_getres;
+                __vdso_clock_gettime64;
+
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS; /* FLAGS=RWX */
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
+        . = SIZEOF_HEADERS;
+
+        /*
+         * The following, including the FILEHDRS and PHDRS, are modified
+         * when we relocate the binary.  We want them to be initially
+         * writable for the relocation; we'll force them read-only after.
+         */
+        .note           : { *(.note*) }         :load :note
+        .dynamic        : { *(.dynamic) }       :load :dynamic
+        .dynsym         : { *(.dynsym) }        :load
+        /*
+         * There ought not be any real read-write data.
+         * But since we manipulated the segment layout,
+         * we have to put these sections somewhere.
+         */
+        .data           : {
+                *(.data*)
+                *(.sdata*)
+                *(.got.plt) *(.got)
+                *(.gnu.linkonce.d.*)
+                *(.bss*)
+                *(.dynbss*)
+                *(.gnu.linkonce.b.*)
+        }
+
+        .rodata         : { *(.rodata*) }
+        .hash           : { *(.hash) }
+        .gnu.hash       : { *(.gnu.hash) }
+        .dynstr         : { *(.dynstr) }
+        .gnu.version    : { *(.gnu.version) }
+        .gnu.version_d  : { *(.gnu.version_d) }
+        .gnu.version_r  : { *(.gnu.version_r) }
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :load :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :load
+
+        .text           : { *(.text*) }         :load
+}
-- 
2.34.1


