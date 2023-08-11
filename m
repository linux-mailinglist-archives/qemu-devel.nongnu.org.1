Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB81F779544
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:52:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUVMW-00069t-9B; Fri, 11 Aug 2023 12:51:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVMH-0005xr-G9
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:30 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qUVME-0001SN-Dj
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:51:29 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-d650a22abd7so1521628276.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691772685; x=1692377485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fv/nprM4vucV0KWAOdV177LiiABh1cKOQpOoQHFwI70=;
 b=jqvulLz6Uy5x20h1V53/yrnxHfGw0Lrcg39MriQ9LseiJgMVuWmm/R9QSFvqcUl9sK
 xJVO4cwLnLfiSNdKKNiVQd3Wqa3khMxV08PmlgbqtfShf1URMqtV928uofHVkn/pfPlO
 +Hr/hCdAikqkT3Y2G6XMGUkiU/2pt/O0PHXkSVA8UhT+/kJ/qRYRZ8YAhwHxEgZr77ng
 i5cvCxFJVmkaiynD9bUyQ+5ntDYdHPlDjzBZoJTv3IDVF55elhEE2YBcNZrzGpbl7oro
 lHoBy5wclmeXFFpxYMe54zlQvMykZrrLweMVDH9/GF/nJgX7Yy2jI8+S0LPttalQYa0l
 wfGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691772685; x=1692377485;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fv/nprM4vucV0KWAOdV177LiiABh1cKOQpOoQHFwI70=;
 b=cTnkuHn+9SIkOvF+x+Hx78uQSeaM6webR/3XDjhNMU4J2OlPyr4DWyR5J++BWj3+3b
 mVASz+27oTAGoMieI2+pwHn++K2TRHrSLuMzA+ZCqNTOaSosocK6zMp+3nuWx3mBJtoP
 OJq+ZLwGT+AYDRcpYyq6Ha4CYakEcdkKpJ0yA49yB0Et9oE9JmyokOQP6EyDTk2Mps2P
 RtQnfF7xxJeRKVAtnT/iv/fT3kMzS6wxUY4J3u6d0L60f51CgQz1e2CG4LV1eNx3ktUf
 /+WF8OKbXt5TqRS0s9XKoQcTscpT+1M/eiLobu7IWldKTOqRcBo2wQaM4z4z82TFgJm3
 QTQw==
X-Gm-Message-State: AOJu0Yz+4dWjVAkCVMfpwMvUr8ZtzVcVPVsl9IOWLJFH7b3wC9Hs2yi9
 lygmirWNVuRHMDs2QXn0+qrGxuduwZk/12yX5EM=
X-Google-Smtp-Source: AGHT+IFToHFYKwmkK7W3xbH53FQU+Vf0DNwt1d4qoh2S/NOgk7nyWEViUjpf3G183kWs59uimH0ohw==
X-Received: by 2002:a17:90b:358d:b0:268:29cf:3231 with SMTP id
 mm13-20020a17090b358d00b0026829cf3231mr1881005pjb.3.1691772664111; 
 Fri, 11 Aug 2023 09:51:04 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:e773:351d:2db2:8a8a])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm3803713pjj.8.2023.08.11.09.51.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:51:03 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org,
	pbonzini@redhat.com,
	philmd@linaro.org
Subject: [PATCH v3 11/15] linux-user/arm: Add vdso and use it for rt_sigreturn
Date: Fri, 11 Aug 2023 09:50:48 -0700
Message-Id: <20230811165052.161080-12-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230811165052.161080-1-richard.henderson@linaro.org>
References: <20230811165052.161080-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=richard.henderson@linaro.org; helo=mail-yb1-xb36.google.com
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

Building of the vdsos are not actually wired up to anything, since
we require a cross-compiler.  Just check in the files for now.

The thumb vdso will only be used for m-profile, as all of our
a-profile cpus support arm mode.

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/arm/signal.c       |  30 +++--
 linux-user/elfload.c          |  24 ++++
 linux-user/arm/Makefile.vdso  |  17 +++
 linux-user/arm/meson.build    |  18 +++
 linux-user/arm/vdso-arm-be.so | Bin 0 -> 5648 bytes
 linux-user/arm/vdso-arm-le.so | Bin 0 -> 5648 bytes
 linux-user/arm/vdso-thm-be.so | Bin 0 -> 5620 bytes
 linux-user/arm/vdso-thm-le.so | Bin 0 -> 5620 bytes
 linux-user/arm/vdso.S         | 209 ++++++++++++++++++++++++++++++++++
 linux-user/arm/vdso.ld        |  74 ++++++++++++
 10 files changed, 355 insertions(+), 17 deletions(-)
 create mode 100644 linux-user/arm/Makefile.vdso
 create mode 100755 linux-user/arm/vdso-arm-be.so
 create mode 100755 linux-user/arm/vdso-arm-le.so
 create mode 100755 linux-user/arm/vdso-thm-be.so
 create mode 100755 linux-user/arm/vdso-thm-le.so
 create mode 100644 linux-user/arm/vdso.S
 create mode 100644 linux-user/arm/vdso.ld

diff --git a/linux-user/arm/signal.c b/linux-user/arm/signal.c
index cf99fd7b8a..bd160b113b 100644
--- a/linux-user/arm/signal.c
+++ b/linux-user/arm/signal.c
@@ -167,9 +167,8 @@ setup_return(CPUARMState *env, struct target_sigaction *ka, int usig,
     abi_ulong handler = 0;
     abi_ulong handler_fdpic_GOT = 0;
     abi_ulong retcode;
-    int thumb, retcode_idx;
-    int is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
-    bool copy_retcode;
+    bool thumb;
+    bool is_fdpic = info_is_fdpic(((TaskState *)thread_cpu->opaque)->info);
 
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
index aff58cabfd..8e03bb6d76 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -568,6 +568,30 @@ static const char *get_elf_platform(void)
 #undef END
 }
 
+#if TARGET_BIG_ENDIAN
+# include "vdso-arm-be.c.inc"
+# include "vdso-thm-be.c.inc"
+#else
+# include "vdso-arm-le.c.inc"
+# include "vdso-thm-le.c.inc"
+#endif
+
+static const VdsoImageInfo *vdso_image_info(void)
+{
+    ARMCPU *cpu = ARM_CPU(thread_cpu);
+
+    /*
+     * The only cpus we support that do *not* have arm mode are m-profile.
+     * It's not really possible to run Linux on these, but this config is
+     * useful for testing gcc.  In any case, choose the vdso image that
+     * will work for the target cpu.
+     */
+    return (cpu_isar_feature(aa32_a32, cpu)
+            ? &vdso_arm_image_info
+            : &vdso_thm_image_info);
+}
+#define vdso_image_info vdso_image_info
+
 #else
 /* 64 bit ARM definitions */
 #define ELF_START_MMAP 0x80000000
diff --git a/linux-user/arm/Makefile.vdso b/linux-user/arm/Makefile.vdso
new file mode 100644
index 0000000000..89da6f91ae
--- /dev/null
+++ b/linux-user/arm/Makefile.vdso
@@ -0,0 +1,17 @@
+CROSS_CC ?= arm-linux-gnueabihf-gcc
+LDFLAGS := -nostdlib -shared -Wl,-T,vdso.ld \
+	   -Wl,-h,linux-vdso.so.1 -Wl,--hash-style=sysv -Wl,--build-id=sha1
+
+all: vdso-arm-le.so vdso-arm-be.so vdso-thm-le.so vdso-thm-be.so
+
+vdso-arm-le.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mlittle-endian -marm vdso.S -o $@
+
+vdso-arm-be.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mbig-endian -marm vdso.S -o $@
+
+vdso-thm-le.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mlittle-endian -mthumb vdso.S -o $@
+
+vdso-thm-be.so: vdso.S vdso.ld Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mbig-endian -mthumb vdso.S -o $@
diff --git a/linux-user/arm/meson.build b/linux-user/arm/meson.build
index 5a93c925cf..66072411d6 100644
--- a/linux-user/arm/meson.build
+++ b/linux-user/arm/meson.build
@@ -5,3 +5,21 @@ syscall_nr_generators += {
                    arguments: [ meson.current_source_dir() / 'syscallhdr.sh', '@INPUT@', '@OUTPUT@', '@EXTRA_ARGS@' ],
                    output: '@BASENAME@_nr.h')
 }
+
+# ??? There does not seem to be a way to do
+#   when: ['TARGET_ARM', !'TARGET_WORDS_BIGENDIAN']
+# so we'd need to add TARGET_WORDS_LITTLEENDIAN.
+# In the meantime, build both files for arm and armeb.
+
+gen = [
+  gen_vdso.process('vdso-arm-be.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_arm']),
+  gen_vdso.process('vdso-arm-le.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_arm']),
+  gen_vdso.process('vdso-thm-be.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_thm']),
+  gen_vdso.process('vdso-thm-le.so',
+                   extra_args: ['-s', 'sigreturn_codes', '-p', 'vdso_thm']),
+]
+
+linux_user_ss.add(when: 'TARGET_ARM', if_true: gen)
diff --git a/linux-user/arm/vdso-arm-be.so b/linux-user/arm/vdso-arm-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..197a8cc1b5303c0b5844272f2279eb79f9ddb724
GIT binary patch
literal 5648
zcmeHL%}*Ow5T9LRV+a^0p-m+?xGD!!g{37ZiqtB?1PqZ3iTIF`(_(A~y9FEBOMr+d
z?k8!Irbrx`OC?fq=q0^2Qd=d59{NZ0kSdClR#iVF)Ke<@`@Mb7n3PM^QzZ`>&-=~H
z&g`3gFVf7l;bg+HEvZsKy0L~LN>#te(T!lm<|-y3*rL(~eaN@buJ|D&xj}PHKxm}l
zxX*abx9IrHq4I2CK@Ms=5?U|qv8=#GR`E05lk+0>4|^;_u#ruE%AFeS!kS!bZwC&H
zj8Ds_r)S*W+>M{_de@q}J0CpydS~P+Y!UFZ|BUqvGKhSv4fbyFU7Nv0@F8%txVsA<
zdmHjEU>ovxh&x#SSIU|Ihh_H<tm8=cCS>%8pSuT3zE``(F9LIK2J2cI%(_-7fEB+b
z>q5dFtHdvb?;!LMaox+Aa?wrC7t?RMb6L;JFJuo?p6vgJx|A&&oqn=-DU({2`Fvq%
zrH64H{Ci!JXUC^6xP8t^mC;6a|Ifmyz+daH5AMRky>){5ZPZDHmlgPO=}#cqNUCO5
zN8k;t2f&RYt^EEMAWuOqLM9=vL(V{MK|&|^X05jnGz<xyg>&m4Q0vNs*lQ81qooxp
zl?Qcf`A)3|BjI)XHtWUwuR;It0R1TR-yEQyf&M=9QQ3>r4=l(ziKJ~zI#Y?h)AnxU
zz1H_zJ~;GY^Lo?u@JEd|LN|lA8a@u(wm)HV5cA_~w5&jON+R+|>tn#*L%#;uF40Kv
z>P|2eiZ(S;zS6)WATjVS@R^5<`aU7;6EZ$9)u~>AdIjngs8^s~fqDh%6{uIBUV(ZA
z{;w6N4D|fexVZJ$T3dhIXl?vfseJpCx=pRytkH$FE?lD<hi+W_=g>y|xD31u%r*HQ
z@Vy$m)A!kvu)X>8=x(pFdnfkeI0|_zl}*j&(ea@P3-(V*$PROT5baQj236br-WHgB
zD@gU}wEI1*Sm^H*(EYCJ>uJ<|uj=oKRYPR@cVP67Bzv2`z~~Q2oIxnuM2S^Q{ra;3
zETe?<=Zv6Az%2mPJvI1!{bAz|8~xGC1ymo1HD?V~(*DN~0zD`LskuN5&z}bzz~=cp
z`cVJ<u;%-nfv4KP_P+?7B0X0~<9YOs)w#klmfgT+j&Kv0{iVU51M_(w_j(J9z3KGy
zTPF&mMW-lTDe20HJ9Ke8K6dtul=E|?thZDuxand>jRP=wafe6U#6)~-*c~035O*Yb
zZZMv7&m|I*!&B~5d@woe*31O-1Y+L=;rXdV&7@)9q~d^~gc@LoQ(j&0QnQd=$(K2^
zDipn}IGNQ#Y9XIi3;05&yp%Y(R5|DCyplL`g(c^5wp7j+3;TeZ5ht5-FO^aYSvQw~
zr$OR)*%eQm_{5l#^1M=hcF99o{tb1&ndg#co%evu8HXW##^q%wc%E_W%uG$q()1Zu
zvmc)4SHV0th{t=Q?#>J_{diUxj~~2GW5&aIQfG?i*%1B6r@*{djQ7lEIS!2H6dAwM
zS_ePgKXnH=S2JYpNdhyqT`1{y$7gkqOg!jSEhfzj4shFN^)B28eVCUt3ubJ_!#!4a
zWrzk%#%~c=`vqcneX#ZXe)-51F#V8+Wg@GYCM8KJAS(!H-kItR{HS{jNizG@IejJk
ozJO^9h;zvoz<fW(<lU}`cVra!E3hFG5C6aH^J6WU+mQ168?PsKc>n+a

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-arm-le.so b/linux-user/arm/vdso-arm-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..94c757a7e283fecc45847a7942c2943b989a1163
GIT binary patch
literal 5648
zcmeHL%}-oa6hChs3_}Y8{ZL78fsqAi;8Bq@O>7Lq$CR3ZHhdWB=JA-B!bF&v%sdJ-
z81a*8Yn_CcxKYtGjSFkyN*8VH!bSfGO*EuQO^jkBu4=~L@4k2G!?G}OW%ADOn{&^{
zJ?GxTdy|~=>QE|a7=~yvr9+g|EYb^Q<p{naQrjzS5{0c<n!r69?Zh1)HQ>a<Xb?c1
zP!ilntB#LgLR7$rT7dQlzFXj=u?(5e@z33JGvC8WV-Pk%+sStVXvdle+K)mufzzXt
zB412?khwA5GWFFDQy;&ub^DJ`?p}|>28-JB0B7OZI*^lhs6ajdUH}dPyvBoSwQwEw
zzrcC^ZSW7d_>Ytg>^~&GR}+v=At7@fM)of74hXyt<;TH~24oynIcqy>s)_gKeOMQg
zSATC!Hy)opifsF0rd+Vo^M&-w_H5R5a|>D7PkEyE5p^kB);fP@;X=k)k@;MHak-0e
zE&M$rsWYRKQ+AJaf*B*bA3ibseERLLjl9Q`0RJ~6@0^DGx%j0?8%fv9Xf>bfgIou+
zH;PPwp9C+0r@$|RPlIoQ7s0o|uY$)AbQ8Q29HmrbTpE+eYTRgTXjHXsf%dxwukO+x
zkF7_p8O(nixU-Lb82VfL=%=Co26~mpkJAes2|34+w24Wl*P35zdOiL|<C_g{9en%1
zdi~|tJ9Y0yuhd?xdC$BSd7pJ){!_p*;;}}OjQ>b|8*mp`)%ly_wXf{dMx)L3b>vUi
zM3v7k@R`?VQ9e=MC#rm44k@faSb?wtVFkhpgcS%Y5LO_pKv;qQaRt`;x_+)JZf+T?
z>sxh3<+ru9+xMy4@O2vjUCh_T0=iM?M#bBQuIZ;G$V-s9CT>E$8IX5+KDrl+Y}`Lm
z?N)a8*}Zb&2^7=GIx{&j(1Ky`Fd@+hJF-V<$5)xE3-sm%RGF%C_4;&A_PW?@KZ@yh
zyzJ{eyVv=$zxQNsQla~IQ+1Fc?C(8$OmWU1Jh@)+HosXm)pP(Vzj-v(lt8(tFH;))
z6MMQE^!10h)XgUR*~|6rHs72!JS6(FOuCmhAh$t2hy8uv5$rz>uFoe@F9VSE{po)m
zvL?<I(h!1kg(b+rxxy95!MVa`+>CrYC+7~*?Jg9%)9Ha1r;4SQtb(*V(w-4}@cd|E
z<jjDSbF-zayI9KG=|V=012B29hlcIsSYl+z9v&PM`*iATe<Ed{O(w^OChUnse`?4M
z%mn;l!=4GkKL-$jNyDB=#Xds`HNX(7yt3drGvIE?<8ykIFSuE;GAns!A(vJQ_<}pG
zBi5W#p7V5WNvzrYqIEG_D(4FMJ%XJPD?4XjC^-vRdoBY{Es5o3mtC<EV<VR1x~1IA
zqKmTpYiflj=Nfzj`5q9QacR;sou{DS)67RHI8XDQaBud*r}-GbSr+4QzC}!9O+UUS
zjK{~b$Cnw8&l7=>!7kB{I0^8rVm!WQL?_nVN78=JV@)0X`2G=`t7*bEMM->D{n;Ad
zOM-cIJcugBIJlm{@qHzD7T$wC%uAX97@NA_91)@-?N@}P{o0U>XwZj(P5WK){Zw69
zD4+tSi7L_>fDlElNfj74OVXr6>zrEuIs7)E<XrMGfO#2{zdX7ISjzBWk*~S%Nyp>w
POVF<hzlwGO*M5Hky@hy6

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-thm-be.so b/linux-user/arm/vdso-thm-be.so
new file mode 100755
index 0000000000000000000000000000000000000000..a83a7feb10d0e46b92531607d75d4564754f99dd
GIT binary patch
literal 5620
zcmeHL&2L*p5T9qqj+4fYTRw^iDn>*CA@cg6s1SiroF+~Rv4fmOY7x?lW5320jUCx9
zO;WYOK%s?}QmH~J<x)@%y#OcRfGT?6fcO(o5l9sh2ZZ>DI2DE8Z{Kd}gj^6Oq&Mk!
z_BT5_^LBQ((#*>v;~6Vt$vTDQQH-HTQq?bVmltV<I7&$rb4lrjKI+eLUhxe`a+~HB
zhtNpd<33}ZKcoFKhKe(f0Xd@Q5zxBt4$Bhe$jX1o`|){^(9Jt6!<ZwR_>`+H+>0@}
zb^dPP@MvyIzRgXQzqqvP+KcbT2KEf)7k|3-!YRxpz*GJj>o#Nr@t7Oz-MR?b39f;+
zfs?hhHQ0n!ApZgmLH-JH8RP#-u5qwk)_%h{jc^Y_#&-Cz`+)BO?$r2RV1ARq%r&#F
zG4r}kVT^c|%nJ#7Tqmx<IS6e;9OrncQFDsNYQ>kFS=aL_bMBVP{r&$?*WHHE>6Nvk
zrNXitt5g@3`smljzr8YkFgJDB*=O%p5krXX|5>;d_>2GY<p-GIxjg{p*{GWeD=Yl*
z!k<8#BdMHOJ>jP?9t5|G#CiUQA#F(9wfK{eXCa3muR=Zxi8G6r;WP$$5)${;zo6EM
zyo63Bte&noR4NYg*!300osv$(&V(*7UyQ#8`p>q|k3oNJ3;i_oSD=rz_~{20#GFLX
zZU&uhCSU1(HSt>fbl2<K-sn8jaW?j5`&-d-k@IbDhcATQVQ>)RKMj9*$Xzm;_(AJa
zz+Xd;{lg}ih@4uDM5D=$cFKp_cm*T{{uws-PV8CPM72%S*kCH4AOk@Lf(!&12r>|4
zAjm+Ffgl4x2L7)ZXns2Qd;3oLzImOaOL{c1dV0~<<sPBDk@@5gX_6O#&6x6|P5Aoz
zUEjQyNsbzu?>6By5_NyUEzDF<(V@<WJkghxXuLh!!BTTeTBR06s4ivv`W09&P_;Pc
z{W?`F)Nl&unpV~BoYb|gs^N)M(PL_KVAP1D&<cNnW0b%*`3u}ZiBU@ZvhGuqRKJ*K
z&Am>*T>$!<SzxQ$eY-9vX-9k1YhhLEVXXaeYTbS(T%gXRBegz-^?Lyav3agXt?7Rs
z#{9kmuvGik_D7&oq<aTNtZ(fdECRRo4$cA7ujw6p2+TeBc(*q<zq?qRn9mJ7H(=MK
z*OT6oIKxMB>FmJ+(x}YVU2maYb&9o;D*4e}aYn|ROg^0*amI%8;*5?@45i1NiA-j4
z<dAbHJv2VzwAB5&%dnwKu(|Wl(oNXVjo6~`pqdn7H<stT!VIKW_hs3Psx{9QyR=*_
z%vFkN09(j{R}i~gXq0`OR~LJ>x?mr7>y1jSx&b&PvE8zBv|gBVopK4528r#tOP<*2
zeAX^_UcEB2;2|ylhI(Mkd&#@bcR*$z!;rq?@(>if&$xD`Z>IWX`i`sq4)610V4g4h
z@!hDmGYw2To-_UNLhsX<{&1hvo#K5qL_0EjD12A+ciU%S&jjlf8M|k+4t9Kh>J74Y
zX2`sg4EknkP}1(Q&*~i+f6%L3OqxC$;EK=cTeuI}FfM5ZOyBf}cdXvZFefw_yLn)3
z7f$(a+}gZfE;*s?5Qk|ZtG*>ANhu(kaA>}nYCz#x8Z!IUF^xKT9-na)h`mR?OMV}H
d@@=>H+rb=v4mM=`;s2KncDH~p8Y4($_c!UoWV`?X

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso-thm-le.so b/linux-user/arm/vdso-thm-le.so
new file mode 100755
index 0000000000000000000000000000000000000000..241fc569a4752fbe5642971f8dff72c3625799d1
GIT binary patch
literal 5620
zcmeHL-%lJ>6h6DdE>M<bTdi%xC`OEpf$5KsTBB)L3JX;h43wmO8kXHDyRrKtyF-Dd
zji|M)w$>)T_@fWiXyS|dq&_wF!I;K>L5)p}i4ToIB|cU0`|h1f2js!TCzCnw&3Dha
z=bn4#%*-a|yf8GHi9{k|#FAa2w3J96jNU!CL?zZIT@uG!N;<%Lj`PF~A5CE5ZZs&6
z9vBI(<E)8~U_#VDL=5136xW?_GFX64nE22A<Q2YylffY72s2M!37{KeA~=69bPE_B
zo08i%A3gW;*H`~ad{|E$od5P#_DoMSiMc6%%^jSDXWNB6c@I~hZvj_<Hh{NrXLYsu
z0p|Y%^Zd);w>bEZ;s(}lm0wrW&>zBvE#Pg~y%)S4I?qG>K5$z=$5AB`(3w*syno&g
z^Fq=2*JHZz`1DcYI428@s*^ua%|GwVx}H}myRw;af8RgMb+=(`{>tj{LT*t`lqz!z
zy^L$)f3J)l9-BJq?6dcC$LQK0-x&VA_vJ6`d~Oc_d^Qw)&WQXm_ld<hipg1|(|W2O
zdNa`7E^-uXgKOXe;0xdZ@HOx=;AL<T+=8H|!98H4PD$j{ghWp#Bb|wM;XXTouM#@%
zl1{dqk6w<@z6bbx6Z;74A8lfvhW#Db`8-XWK8_*Sa}t|&aMS6f)QcT2C0}kon|P(|
z+?MmL7g}Czel316cB$!g>vHrB=7IY^4NM^3gJ2m>-lDw=xCtDEoj#IE#?Gw7;_*~#
zGx?FGxbnG;sS)_7dsaSi-zTnoxHOb717QZj41^g7GZ1DV%s`ldFau!*{=XSm`mF!A
z<{k3G(shpB^he_>XXmwT>@o6<%%{K05-|_mjL9Ew(67In_~z|QYS{REzd=vmk6h*4
z+)PQ8r4oChH!Jb>=4|Wc#qx@uT1!=Wx+g%BrK(e1i)&q1s>>{RAeLX%vUb<Hu5MYw
zYh8CEOpR`-Dp7<ryq;GTnd&iUy;a$}{DRn06*o+NfoQ2tfO1h6OA`KxwXF%Y`&JH3
zK?#4>Vts1`HY@nMLjN65O}!q0-UWRx*7t*>Sic9%9*CA!IfQ|^fBGLYQ(*QE^59_a
zU><s~cW@DUuy^o2^kDBmc6;U8?tFeYT`NENtX-9EPr3`@3?3UxXAd8eMrpS0dUN%P
zldl$3$&c=eGc@94Ceqm<XJl|foZ->&f%K>|p2<uO9dVAN2S$gSK;7>*6xMYKHZ~ao
z-Gp`Bh)o&~s!1VsW3lYzX24!ubJ2_{RnHZ>uvp2JOL;YbFF5Dr#4hF<MQ!uyV$W9Q
z?2~T2QL0wfDNaFbx9A+N=gO{AEWp!fVtej_Cw6)wYv(+#UYeQnkd}Wfo$zGuf{&Qr
z0l_|&5!1JM7zV!0e3gPdGyR6^{tn;f#{u@M7>_+HVj5%m@iSpOzMlJho$>fS5oimn
z3H^uz0KY26<99~%V9a$C<985a+UUpck6`c22$m_y;JWJf&-h&u+}Ff|s$xunO`nb5
zE5WnyKIp@JDKh|L(-!O%LRDh?YS4^d7d9gj=1`b3ey4mtl~*PT;94UzQI-INSevS0
zg3r>332pW?_Dk@)1|xfq+X3#&nEd52IlxeQwuyYffiET=e_w)rKf>>daRM8^zX6tP
BWsm>>

literal 0
HcmV?d00001

diff --git a/linux-user/arm/vdso.S b/linux-user/arm/vdso.S
new file mode 100644
index 0000000000..1831b29efc
--- /dev/null
+++ b/linux-user/arm/vdso.S
@@ -0,0 +1,209 @@
+/*
+ * arm linux replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+
+	.text
+	.eabi_attribute Tag_FP_arch, 0
+
+#ifdef __thumb__
+	.thumb
+	.arch	armv7-m
+	.eabi_attribute Tag_ARM_ISA_use, 0
+	.eabi_attribute Tag_CPU_arch, 13 /* TAG_CPU_ARCH_V7_M */
+
+.macro	raw_syscall n
+	.ifne \n < 0x100
+	mov	r7, #\n
+	.else
+	ldr	r7, =\n
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
+#else
+	.arm
+	.arch	armv4t
+	.eabi_attribute Tag_THUMB_ISA_use, 0
+
+.macro	raw_syscall n
+	.ifne \n < 0x100
+	mov	r7, #\n
+	.else
+	mov	r7, #(\n & 0xff)
+	orr	r7, r7, #(\n & 0xff00)
+	.endif
+	svc	#(\n | __NR_OABI_SYSCALL_BASE)
+.endm
+
+.macro	fdpic_thunk ofs
+	ldr	r3, [sp, #\ofs]
+	ldmia	r3, {r3, r9}
+	bx	r3
+.endm
+
+#endif
+
+.macro	FUNC name
+	.globl	\name
+	.type	\name, %function
+#ifdef __thumb__
+	.thumb_func
+#endif
+\name:
+.endm
+
+.macro	ENDF name
+	.size	\name, . - \name
+.endm
+
+/*
+ * We must save/restore r7 for the EABI syscall number.
+ * While we're doing that, we might as well save LR to get a free return,
+ * and a branch that is interworking back to ARMv5.
+ */
+
+.macro syscall n
+	.cfi_startproc
+	push	{r7, lr}
+	.cfi_adjust_cfa_offset 8
+	.cfi_offset r7, -8
+	.cfi_offset lr, -4
+	raw_syscall \n
+	pop	{r7, pc}
+	.cfi_endproc
+.endm
+
+FUNC __vdso_clock_gettime
+	syscall	__NR_clock_gettime
+ENDF __vdso_clock_gettime
+
+FUNC __vdso_clock_gettime64
+	syscall	__NR_clock_gettime64
+ENDF __vdso_clock_gettime64
+
+FUNC __vdso_clock_getres
+	syscall	__NR_clock_getres
+ENDF __vdso_clock_getres
+
+FUNC __vdso_gettimeofday
+	syscall	__NR_gettimeofday
+ENDF __vdso_gettimeofday
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
+FUNC sigreturn_codes
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
+	.macro cfi_fdpic_pc ofs
+	/*
+	 * fd = *(r13 + ofs)
+         * pc = *fd
+	 *
+	 * DW_CFA_expression lr (14), length (5),
+	 *   DW_OP_breg13, ofs, DW_OP_deref, DW_OP_deref
+         */
+	.cfi_escape 0x10, 14, 5, 0x7d, (\ofs & 0x7f) + 0x80, (\ofs >> 7), 0x06, 0x06
+	.endm
+
+	.macro cfi_fdpic_r9 ofs
+	/*
+	 * fd = *(r13 + ofs)
+         * r9 = *(fd + 4)
+	 *
+	 * DW_CFA_expression r9, length (7),
+	 *   DW_OP_breg13, ofs, DW_OP_deref,
+	 *   DW_OP_plus_uconst, 4, DW_OP_deref
+         */
+	.cfi_escape 0x10, 9, 7, 0x7d, (\ofs & 0x7f) + 0x80, (\ofs >> 7), 0x06, 0x23, 4, 0x06
+	.endm
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
+ENDF sigreturn_codes
diff --git a/linux-user/arm/vdso.ld b/linux-user/arm/vdso.ld
new file mode 100644
index 0000000000..3bddef97a5
--- /dev/null
+++ b/linux-user/arm/vdso.ld
@@ -0,0 +1,74 @@
+/*
+ * Linker script for linux arm replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
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
+        data            PT_LOAD         FLAGS(6) FILEHDR PHDRS;
+        text            PT_LOAD         FLAGS(5);
+        dynamic         PT_DYNAMIC      FLAGS(4);
+        eh_frame_hdr    PT_GNU_EH_FRAME;
+        note            PT_NOTE         FLAGS(4);
+}
+
+SECTIONS {
+        /*
+         * We can't prelink to any address without knowing something about
+         * the virtual memory space of the host, since that leaks over into
+         * the available memory space of the guest.
+         */
+        . = SIZEOF_HEADERS;
+
+        /*
+         * The following, including the FILEHDRS and PHDRS, are modified
+         * when we relocate the binary.  We want them to be initially
+         * writable for the relocation; we'll force them read-only after.
+         */
+        .note           : { *(.note*) }         :data :note
+        .dynamic        : { *(.dynamic) }       :data :dynamic
+        .dynsym         : { *(.dynsym) }        :data
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
+        .eh_frame_hdr   : { *(.eh_frame_hdr) }  :data :eh_frame_hdr
+        .eh_frame       : { *(.eh_frame) }      :data
+
+        . = ALIGN(4096);
+        .text           : { *(.text*) }         :text
+}
-- 
2.34.1


