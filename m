Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6AF78D076
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7mm-0000ds-I5; Tue, 29 Aug 2023 19:06:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nT-0002R9-DE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:53 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6nN-0004A9-CT
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 18:02:50 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-68bedc0c268so4223677b3a.0
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 15:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346563; x=1693951363; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4P8uKuAKuluc1/WNH9Ak63d99XD9VhlZvaJdI6JNt38=;
 b=UC9731egNHoPB9f/Z9cgRMbC9H5MN/KjbDz6htetQqVfVpwfuSjhC1Zy46wjB6rFc1
 TM8abRvqXe5ngOWEVZ1plUjjR7QfU+sH0DLpD/8N37+VDdPh5mxOxPpH/uga1UMx9c6b
 uIoDK2kaiJnrwpZGtD4nY99iUqHn6rvw13XFSbkABozACUcLFc4PFZfRgrX6JWNUc7US
 R8g0WRVY0Da3GxEGFHvf6kIDDICQoQTSSv5hGbOh5/eNDDZ7AzJE/TOkAESBp5G6CfqX
 npC7bAn0oS5PCpnI4UG/y3y2ER9N2O8YJO5EJmp2ldh2Mfof8IRjpMadfjeelbkPtwEP
 wWqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346563; x=1693951363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4P8uKuAKuluc1/WNH9Ak63d99XD9VhlZvaJdI6JNt38=;
 b=da7i4uPPAw6kOwR1CJ6AC163UECHtp+vrOa4AkfFUs41ZP/sCLQL7evnX4fKvy2CM0
 SJrT/kmhCd30HYxdgIHKV0ZvlAQYkO7iSbMFKmf2QgnwtF3/XfP1PqwmpS9+dnpWWLRc
 kj/3cdh/tRukGVcHGnoB6pHbi8S7q4/SUxHHT2fJBkDzxTzbdlX6OUXLO7b2c+lEX9iO
 KwP5oZNaH66o18XqH2gXr89lWYm51eUh9qKUlgEPDrUp52WEUC1NTWQuW7axRzBE8sIJ
 XkXKV8VGStkNPhPI4CBPrLsKlqs4go082aPq65EuEhZwyBOUCTVAHs/vaxqZqZh2NKpI
 bgDw==
X-Gm-Message-State: AOJu0YwNzEugo2TvLeBoPoT2qyUoPkSmu2KWlj1VwLXx7WlZSQNCSPDU
 WBrsjECs6wrBgY4idqVFFelgeWfbcjuB73qXOT4=
X-Google-Smtp-Source: AGHT+IE5vIigCbLQDYLN5Zw9bVd+VQsWIvl+8i9AnUAoAJUCkerSV56ZhMoGmd5LkkZdtJ85RuKrgQ==
X-Received: by 2002:a05:6a20:8f22:b0:14c:7020:d613 with SMTP id
 b34-20020a056a208f2200b0014c7020d613mr713963pzk.37.1693346563363; 
 Tue, 29 Aug 2023 15:02:43 -0700 (PDT)
Received: from stoup.. ([71.212.131.115]) by smtp.gmail.com with ESMTPSA id
 b28-20020a63715c000000b0056606274e54sm9538196pgn.31.2023.08.29.15.02.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Aug 2023 15:02:42 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	laurent@vivier.eu
Subject: [PATCH v5 14/20] linux-user/arm: Add vdso
Date: Tue, 29 Aug 2023 15:02:22 -0700
Message-Id: <20230829220228.928506-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230829220228.928506-1-richard.henderson@linaro.org>
References: <20230829220228.928506-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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
 linux-user/arm/signal.c    |  28 +++---
 linux-user/elfload.c       |   3 +-
 linux-user/arm/meson.build |  35 ++++++++
 linux-user/arm/vdso-be.so  | Bin 0 -> 2680 bytes
 linux-user/arm/vdso-le.so  | Bin 0 -> 2680 bytes
 linux-user/arm/vdso.S      | 177 +++++++++++++++++++++++++++++++++++++
 linux-user/arm/vdso.ld     |  67 ++++++++++++++
 7 files changed, 293 insertions(+), 17 deletions(-)
 create mode 100755 linux-user/arm/vdso-be.so
 create mode 100755 linux-user/arm/vdso-le.so
 create mode 100644 linux-user/arm/vdso.S
 create mode 100644 linux-user/arm/vdso.ld

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index cf99fd7b8a..c328d31081 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -167,9 +167,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     abi_ulong handler = 0;
     abi_ulong handler_fdpic_GOT = 0;
     abi_ulong retcode;
-    int thumb, retcode_idx;
+    int thumb;
     int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
-    bool copy_retcode;
 
     if (is_fdpic) {
         /* In FDPIC mode, ka->_sa_handler points to a function
@@ -184,9 +183,7 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     } else {
         handler = ka->_sa_handler;
     }
-
     thumb = handler & 1;
-    retcode_idx = thumb + (ka->sa_flags & TARGET_SA_SIGINFO ? 2 : 0);
 
     uint32_t cpsr = cpsr_read(env);
 
@@ -202,24 +199,23 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
         cpsr &= ~CPSR_E;
     }
 
+    /* Our vdso default_sigreturn label is a table of entry points. */
+    int idx = is_fdpic * 2 + ((ka->sa_flags & TARGET_SA_SIGINFO) != 0);
+    retcode = default_sigreturn + idx * 16;
+
+    /*
+     * Put the sigreturn code on the stack no matter which return
+     * mechanism we use in order to remain ABI compliant.
+     */
+    memcpy(frame->retcode, g2h_untagged(retcode & ~1), 16);
+
     if (ka->sa_flags & TARGET_SA_RESTORER) {
         if (is_fdpic) {
+            /* Place the function descriptor in slot 3. */
             __put_user((abi_ulong)ka->sa_restorer, &frame->retcode[3]);
-            retcode = (sigreturn_fdpic_tramp +
-                       retcode_idx * RETCODE_BYTES + thumb);
-            copy_retcode = true;
         } else {
             retcode = ka->sa_restorer;
-            copy_retcode = false;
         }
-    } else {
-        retcode = default_sigreturn + retcode_idx * RETCODE_BYTES + thumb;
-        copy_retcode = true;
-    }
-
-    /* Copy the code to the stack slot for ABI compatibility. */
-    if (copy_retcode) {
-        memcpy(frame->retcode, g2h_untagged(retcode & ~1), RETCODE_BYTES);
     }
 
     env->regs[0] = usig;
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 8316868bd2..cd2ab4292c 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -768,6 +768,8 @@ static uint32_t get_elf_hwcap2(void)
 
 #undef GET_FEATURE_ID
 
+#endif /* not TARGET_AARCH64 */
+
 #if TARGET_BIG_ENDIAN
 # include "vdso-be.c.inc"
 #else
@@ -775,7 +777,6 @@ static uint32_t get_elf_hwcap2(void)
 #endif
 #define vdso_image_info()    &vdso_image_info
 
-#endif /* not TARGET_AARCH64 */
 #endif /* TARGET_ARM */
 
 #ifdef TARGET_SPARC
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 5a93c925cf..6a8ce075c3 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -5,3 +5,38 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+# TARGET_BIG_ENDIAN is defined to 'n' for little-endian; which means it
+# is always true as far as source_set.apply() is concerned.  Always build
+# both header files and include the right one via #if.
+
+vdso_cmd = [
+    build_vdso_cmd,
+    '-B', meson.project_build_root(),
+    '-C', meson.current_source_dir(),
+    '-T', 'arm-linux-user',
+    '-o', '@OUTPUT@',
+    '--',
+    '-nostdlib', '-shared',
+    '-Wl,-use-blx',
+    '-Wl,-h,linux-vdso.so.1',
+    '-Wl,--build-id=sha1',
+    '-Wl,--hash-style=both',
+    '-Wl,-T,@INPUT1@',
+    '@INPUT0@'
+]
+
+vdso_le_so = custom_target(output: 'vdso-le.so',
+                           input: files('vdso.S', 'vdso.ld'),
+                           command: vdso_cmd + ['-mlittle-endian'])
+
+vdso_be_so = custom_target(output: 'vdso-be.so',
+                           input: files('vdso.S', 'vdso.ld'),
+                           command: vdso_cmd + ['-mbig-endian'])
+
+gen = [
+  gen_vdso.process(vdso_be_so, extra_args: ['-s', 'sigreturn_codes']),
+  gen_vdso.process(vdso_le_so, extra_args: ['-s', 'sigreturn_codes'])
+]
+
+linux_user_ss.add(when: 'TARGET_ARM', if_true: gen)
diff --git a/linux-user/arm/vdso-be.so b/linux-user/arm/vdso-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..591db80fe47540707e5c627443ac566d7f2c7c60
GIT binary patch
literal 2680
zcmbtWO>9(E6h3eMTiWT=5TvP^8XGYPBf<nxiRrY{X)$fV(nbu4uhW^=&ct>GXI^Vd
zPzOb*g0LYZMoBQb)ieeZH^f;P!@{t@#DxYIb)&{;qQ-?de&2of)@kj=c&6Vw_dDm@
zpLg%M=k?|Op|s_*WL5m~0NTco5DDK1R(&D~>5?FP?Gl4O1i-h7D`*n|4bvZ#5~z8Q
zupSu$${!7=qD`p&IrqCmB0l&HBn2O#{950HHt0s1X!LIe_YaJW%cD~hJ$pKCTisvo
z|KV2P=tGz9zVtqPQDEHbW380xfBlB}_-;Yy6g1w^T7Yf_O28%{R;t(kgue!T8{7x|
zGt^bI|F0yme9jZOL!<?IC%6OMtoau3qYWH;9C)gMGge8v)PF&P`)kCH2G5L|!hNFP
zUDb*3Jd7}g=SKvC9RU-=KEdVA>yqDfVYKy=8-2yT_d4$XZ2MWU?fG1#WM^ke+2`zO
z$8`&{&W6UliGP{PPQ}=C&(c&bvnVr#;@rYcjvL3{!!mSWWc-M|JH8jIz=p5>EUXj1
z)}KCo7j~ZcT>#J3yqV?yaPD_7`Y39jtWN*qX!ihN1Rj9~tV!r&&@<3W(DTq&pkIQ<
zIa}`l5nvhE0b2|Z>-ebnPDHKFmR3^EvlZa}H%l@aIpaIey`+5?@cjn%LD;_Dz&-)n
z7eJ(8oCG-MJd8=(IO#++cCzi2=&P-#T3*|9y7^4gQsnjU8=<qobAdPg=Y1DAIfV1?
z2TlX`$UyX4ZSMmA95@GTmRL0S;;+F_DAp9FzAwPEkuKmz-~<r!VnRA5WMbeFseWAF
z7I{Q&Rj;viakbT?TO-@(tEJ8F1#r`*{$L%y_IAtlx6-iz6Z6eFp2VDYW}M7q0a+l@
z8cd8y$k(J_jVoFsH_4FT#?Lb%_ff;Vz$ZBG0L1!=PY``ytQF09Cm^a`(62TLJVh%w
za*E>B1#sky;x#_Oo2cP8^Rvc4{5&7}S!*DHLwtg_P#XbfqM3KV;?#Xdj290d<J-_v
z^+#KehZaP~qpWx}!t(le!gCU~9&85tKWNs6HrMxr*$*8*2AdLHZ=OZ}#`;wT=Up@P
z3wgJueq9Ftr+#I#&+o|{cN6iFbi2}>6Fc?HNOJf<pHvFdWyhT>7wv2*r>X^ty4^o$
zr$>{+{q|sLRP2GFgT2Wi`(QeKxPQzZOZE=++YKc{7pOG_W_{6WC`4-t*#<RB)i;S(
z7H8eeB(z)hbl$XzCD)O7Zn2n|Eo4;#vCtVeBk}3tTs)tt<UPAv_AK*Gxl$+<*AP1=
zaVKw2l{2%BozEfCFp0a)f-CXl=x{vay5+*;oQtjbPlEGSdCJ`9y&$>)BRc2hUKp6)
zNIR7;%-JfSa~$d9<@a`I<{8H0JyLgR0-SNoRmQPi?$#XR@qVd0)|lUnBX}2h&p6(S
z2iXD6bx=&)K74~&-x0_AsP1F}e0^N6wlOZ{L4DU@R$}hclNhfK3*)YOQ1`)%2RnW8
zwD}(ZwB|wf!Or)kpX;Mc0UVp-VeizP$NZ~e;#^pC9P0pKt=|`R;<t!#I1}D?b?1-K
zp@n-)IR&FxGiacO$5z0Id0#!JF$Z`i%V4M<vIXG!I3{aW!+4=3@Q(l^X1sP78sfr_
LfnPL1&?@e4ll^}8

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-le.so b/linux-user/arm/vdso-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..8077fa5608d3d2539ec19e8b097cf812fcc41ef8
GIT binary patch
literal 2680
zcmbtWU1%It6h6C?-DKPBW>Z94B2qP2sqIipsG?Q6`Prl;KQ%uX6*`&hPO^*1PT8Hr
zL~2a6w$ax1r7uzo6+xdWMHGA~?vvCaQlt-kQ1qd`h)M-5c~IByyE8XV(mV*B-EYtD
zJ@?L?d(PcgyLz*cNJKOl@~~*F4aRHr_=!raO}0u5zGg{F947iSE<h&g0_gEj6;<IN
zm`ad6ir?iB79kUQ{J|f+{4#<xI^iR<pZt0Vt&oYZ|1RhT(A_^GO}~8g{D%)Le{eqj
z%~Qq1!o@GI*qtf(MuIUnvEV=cuDNN<8H248oX<E1`v!0q*a)P7KWjC&3jbf=U~&um
z6AJ&6G8pgT0UE$JNu%rpcc62A>UV>`5YoBF&xCXbx~69Nt;YS;#C_oNkdrV>5ucTL
z!pmn2Z3O+Xx-Buv97A2Mwp<!Kv#Zc??X%>T_d7}_w}0`FSk`R5;##>WH}|47>3Cjo
z+F94Qr|k}N*{Nt-Fw&jK+w(G2EX~aAWL^{BN2Pav|H!Dd+uXxNL{~l$tdyVkKL0hz
zcYZIx_e%1gEh4vPJ~HSd>3xc{7*Fnl&NDfRz)|pV@WbF!;7j1M;1|Fbz;A)S3*G=+
z0(JmA52VP;gAzTGinKH)h4X9%xc_{2l1Vk3h@Otnz6<yXSZnWr?b~(iW3YV<@J#4D
zZInTna|n|*aniBH^wFl*Qm-eEHNLU&_=XdSrG_`_--@4%ovM4=I2}EMrK)x91wRhl
z2S|772ims+SAbK1+M{$T_R8<Ecs!k`Cx5Umu3~<M{|KO-S;fSIn7E38OVQ$|wQUWL
z$@hzwDV<%B5`omejlODDe_n#FW%7$_^vmZOufCH_ck7t%*65jgFs<#_<3))iA;#K<
zB_2)i(e9w@fyGcK!+%FK89@cG-hJJ#lp8C$Uoq?xzF$>>uwVE(tIO{jzV3HA-4_i1
z4N7$-KB3~--~4!WB4lq+poZ!;A_s#)HBkRyG9(#1fp4uty)#0`3*wuo>w*vR=^TvT
z1V#6V2=o@{M={?%@F>PVLVvJ6p4g|M>-}K-Fmz4qH;15v`&SuyxPS57h5Ofe=;8h)
zx!mmhfHQQ!bfwjk*1TAq&-G{e_IF67I9YbQnR3a>xp~zs(A2H29xFST>Fct3ItRt-
z?j2~)^jZVi>`>RRHJoYh?Xp5GBWO^o8qC_J6>3DQ8reEMOZ7J~EA!KyJr3@beO}N~
z$@LsD^YbNpx|mY}V!>_C7IU&RV;1a6!MA&5-!kizD@C`oO0n`{It6Q@Y)?B@A&*F{
ziRn3Wo|u`zKGXKRa&dgd!`A$F;`{cm_J8lv*3j_a=*j)C>AQpHg;)gq6Yk#&>`&VP
z-jO^qtRrF!GUHe_%*WobJJ5MFd7g;y>1G_kUd1Y7KGq$v1F}BSI_`1UZU=WU>ycoO
zTpQOO*qD#^JHdNh6VfX>fZtk>kM&D%eL5dhwWepm^?!gWj0D%B_mt}+O#sZzapC_n
zP!;Jo51Ni+A0Qg_qTthU3qc&;3G1CW3|W)v&rps5NU`FoB5tz|0@tbaoZ58*alGHy
mKlq;ms(NqiSb7g2$`TgvF@=D1zGmp*xF@h7XLS&`j{64#seq6G

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso.S b/linux-user/arm/vdso.S
new file mode 100644
index 0000000000..ea27cdd9b3
--- /dev/null
+++ b/linux-user/arm/vdso.S
@@ -0,0 +1,177 @@
+/*
+ * arm linux replacement vdso.
+ *
+ * Copyright 2023 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+/*
+ * All supported cpus have T16 instructions: at least arm4t.
+ *
+ * We support user-user with m-profile cpus as an extension, because it
+ * is useful for testing gcc, which requires we avoid A32 instructions.
+ */
+	.thumb
+	.arch	armv4t
+ 	.eabi_attribute Tag_FP_arch, 0
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
+ * few bytes as possible -- simply use 16 bytes per slot.
+ *
+ * Within each slot, use the exact same code sequence as the kernel,
+ * lest we trip up someone doing code inspection.
+ */
+
+/* offsetof(struct sigframe, retcode[3]) */
+#define SIGFRAME_RC3_OFFSET     756
+#define RT_SIGFRAME_RC3_OFFSET  884
+
+.macro	slot n
+	.balign	16
+	.org	sigreturn_codes + 16 * \n
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


