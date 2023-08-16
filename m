Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F03D677E82F
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 20:05:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWKsH-0002SY-MR; Wed, 16 Aug 2023 14:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs8-0002RE-9E
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:57 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWKs4-0001Lx-Qo
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 14:03:56 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bda9207132so54671755ad.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692209031; x=1692813831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=lCcTKUpC7hqPLYYs0l8EiDrLdHKrRfn/8NeQPSauaTU=;
 b=zkY4+ic8O5KNGT/FamAMvZHXxbax1VYKX/4Z2oX60DVLbcrlPk8KlpeG7WHSDHT4Vq
 twZG9Q9FCe9Qa3AZlZh2YBpEgsW5kk6dfEk6kfd8Z6bsRLhpuyMZHJ7aIyJRB9j614A0
 UivBM9s1jSpShMH/qbQKwdqi44wpfL9dK+N7QQD1n+GVGhBoMoVuw4Br9WkJOqXyuqtf
 u7F/D0wnHevaM2WayVrfhGx8lpW4n8zE/nI2xVGGPJ3CPP8J3VQ6qDOS8kKabZ6wIJ8N
 PB+w3DWTiCCgzGVxz+7CNiXAX0bB146sIEutrRowL+KkafqjIjth5Ufe1Ieq2Bf2/O5W
 RcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692209031; x=1692813831;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lCcTKUpC7hqPLYYs0l8EiDrLdHKrRfn/8NeQPSauaTU=;
 b=V6YXXkdBDsLyiGh9az2VyN3gZ/BKn923oRU+LXt4ep2oDzgewsXsAuCotYQA9z22dw
 NR5tPopHI2PPM7iE6lIJEOv9BfFyAWTtrFloaNiVyOxj4LTKH+oIitHmPo2+2eUi6Vzu
 yc1sq/v/7xqfpcnUaMIqtuoFelUdEfGRzpjmBhWdzyF0DLYVRGyEYj53bOBaYCQMZY5w
 0bSUuawcCP6yJOxUnHxiQ13V+xT2YjkHXbYHQduEzD+7lxigNo72YLadxN+Ng6RW1xP7
 r2Vklteu32mdnGjvfKsZGDiM5xVea8JSi4HDVdYKvckqWD7xzyUze5mWOLbwZbGHpPB8
 XZdw==
X-Gm-Message-State: AOJu0YzWnA996ZrZme4S5U/DzU/CgHNor0ZHE9lXCY18gU24+TTNyB1d
 KLd6re4CLIjb4yfd/vE8ONtjpF6aZ5EG/wQLCwo=
X-Google-Smtp-Source: AGHT+IG0kPZTkZ71HGYGT9yxru/RJCpDAiR4gm0kbgRc77aSFGksATOY/gcpK7epx+tD8zBRQvTLaA==
X-Received: by 2002:a17:902:cecd:b0:1bc:39c9:c883 with SMTP id
 d13-20020a170902cecd00b001bc39c9c883mr3367384plg.65.1692209031220; 
 Wed, 16 Aug 2023 11:03:51 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 g14-20020a170902868e00b001bc2831e1a9sm13446584plo.90.2023.08.16.11.03.50
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 11:03:50 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PATCH v4 14/18] linux-user/riscv: Add vdso
Date: Wed, 16 Aug 2023 11:03:34 -0700
Message-Id: <20230816180338.572576-15-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230816180338.572576-1-richard.henderson@linaro.org>
References: <20230816180338.572576-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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
 linux-user/riscv/vdso-asmoffset.h |   9 ++
 linux-user/elfload.c              |   4 +
 linux-user/riscv/signal.c         |   8 ++
 linux-user/meson.build            |   1 +
 linux-user/riscv/Makefile.vdso    |  11 ++
 linux-user/riscv/meson.build      |   9 ++
 linux-user/riscv/vdso-32.so       | Bin 0 -> 2652 bytes
 linux-user/riscv/vdso-64.so       | Bin 0 -> 3528 bytes
 linux-user/riscv/vdso.S           | 186 ++++++++++++++++++++++++++++++
 linux-user/riscv/vdso.ld          |  74 ++++++++++++
 10 files changed, 302 insertions(+)
 create mode 100644 linux-user/riscv/vdso-asmoffset.h
 create mode 100644 linux-user/riscv/Makefile.vdso
 create mode 100644 linux-user/riscv/meson.build
 create mode 100755 linux-user/riscv/vdso-32.so
 create mode 100755 linux-user/riscv/vdso-64.so
 create mode 100644 linux-user/riscv/vdso.S
 create mode 100644 linux-user/riscv/vdso.ld

diff --git a/linux-user/riscv/vdso-asmoffset.h b/linux-user/riscv/vdso-asmoffset.h
new file mode 100644
index 0000000000..123902ef61
--- /dev/null
+++ b/linux-user/riscv/vdso-asmoffset.h
@@ -0,0 +1,9 @@
+#ifdef TARGET_ABI32
+# define sizeof_rt_sigframe     0x2b0
+# define offsetof_uc_mcontext   0x120
+# define offsetof_freg0         0x80
+#else
+# define sizeof_rt_sigframe     0x340
+# define offsetof_uc_mcontext   0x130
+# define offsetof_freg0         0x100
+#endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index b15d247746..c9cba730de 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -1752,8 +1752,10 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs,
 
 #ifdef TARGET_RISCV32
 #define ELF_CLASS ELFCLASS32
+#include "vdso-32.c.inc"
 #else
 #define ELF_CLASS ELFCLASS64
+#include "vdso-64.c.inc"
 #endif
 
 #define ELF_HWCAP get_elf_hwcap()
@@ -1770,6 +1772,8 @@ static uint32_t get_elf_hwcap(void)
 #undef MISA_BIT
 }
 
+#define vdso_image_info()    &vdso_image_info
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
diff --git a/linux-user/riscv/signal.c b/linux-user/riscv/signal.c
index eaa168199a..5449c7618a 100644
--- a/linux-user/riscv/signal.c
+++ b/linux-user/riscv/signal.c
@@ -21,6 +21,7 @@
 #include "user-internals.h"
 #include "signal-common.h"
 #include "linux-user/trace.h"
+#include "vdso-asmoffset.h"
 
 /* Signal handler invocation must be transparent for the code being
    interrupted. Complete CPU (hart) state is saved on entry and restored
@@ -37,6 +38,8 @@ struct target_sigcontext {
     uint32_t fcsr;
 }; /* cf. riscv-linux:arch/riscv/include/uapi/asm/ptrace.h */
 
+QEMU_BUILD_BUG_ON(offsetof(struct target_sigcontext, fpr) != offsetof_freg0);
+
 struct target_ucontext {
     unsigned long uc_flags;
     struct target_ucontext *uc_link;
@@ -51,6 +54,11 @@ struct target_rt_sigframe {
     struct target_ucontext uc;
 };
 
+QEMU_BUILD_BUG_ON(sizeof(struct target_rt_sigframe)
+                  != sizeof_rt_sigframe);
+QEMU_BUILD_BUG_ON(offsetof(struct target_rt_sigframe, uc.uc_mcontext)
+                  != offsetof_uc_mcontext);
+
 static abi_ulong get_sigframe(struct target_sigaction *ka,
                               CPURISCVState *regs, size_t framesize)
 {
diff --git a/linux-user/meson.build b/linux-user/meson.build
index dd24389052..3ff3bc5bbc 100644
--- a/linux-user/meson.build
+++ b/linux-user/meson.build
@@ -45,6 +45,7 @@ subdir('microblaze')
 subdir('mips64')
 subdir('mips')
 subdir('ppc')
+subdir('riscv')
 subdir('s390x')
 subdir('sh4')
 subdir('sparc')
diff --git a/linux-user/riscv/Makefile.vdso b/linux-user/riscv/Makefile.vdso
new file mode 100644
index 0000000000..5ea6166191
--- /dev/null
+++ b/linux-user/riscv/Makefile.vdso
@@ -0,0 +1,11 @@
+CROSS_CC ?= riscv64-linux-gnu-gcc
+LDFLAGS := -nostdlib -shared -Wl,-T,vdso.ld \
+	   -Wl,-h,linux-vdso.so.1 -Wl,--hash-style=both -Wl,--build-id=sha1
+
+all: vdso-64.so vdso-32.so
+
+vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mabi=lp64d -march=rv64g -fpic -o $@ vdso.S
+
+vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h Makefile.vdso
+	$(CROSS_CC) $(LDFLAGS) -mabi=ilp32d -march=rv32g -fpic -o $@ vdso.S
diff --git a/linux-user/riscv/meson.build b/linux-user/riscv/meson.build
new file mode 100644
index 0000000000..475b816da1
--- /dev/null
+++ b/linux-user/riscv/meson.build
@@ -0,0 +1,9 @@
+gen32 = [
+  gen_vdso.process('vdso-32.so', extra_args: ['-r', '__vdso_rt_sigreturn']),
+]
+gen64 = [
+  gen_vdso.process('vdso-64.so', extra_args: ['-r', '__vdso_rt_sigreturn'])
+]
+
+linux_user_ss.add(when: 'TARGET_RISCV32', if_true: gen32)
+linux_user_ss.add(when: 'TARGET_RISCV64', if_true: gen64)
diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
new file mode 100755
index 0000000000000000000000000000000000000000..d6067c0dc8a1d5ccedb113bbe5ea5c3f6839bc64
GIT binary patch
literal 2652
zcmb_eU2GIp6h5=V;!;apS}<T6Q)sPCgPVmEY_Mr|OSk;Ev`wM57~-((Zo3WbuGyU>
z#TY5JA}9h{M66XyQN;gB6~#Xud@#|(pU9&Rz8HNl24gfNBK7-b=GLk9!3WRox96U7
z&pmVR+;hLX`y$b1P18h)F24$`gY!gcp})OO1WmNd#Vgg~mm6fhW!wFX8F#=q;_qxQ
zAcbBVNF_)h9;hoWoJ5;Y<J-PB69c-4LM8eL)lYrNg}M3{qaP_`LraGQN59-2>zu0k
zV$Ip9O=j@WiF3QZE<&FPFjple^xL)R%noQwRmPyX#$#AW0rXMedH_=wYYosofU*E6
z1g=g`XF_=3pU_<2W$2Zh!2clSObF32TeUY`u#55J8t5Of2+oK0Ftn0I^2_v281t|w
z)xQMxcdqy->?<z20rq8=&3)oBxK3)WpYO&kd}kCs14Aw0lo?M=aE!KS!K$$M{j?cp
zz01!^C$}CArpk^Vo<4J-fBCZ0>(lj1J{`Sva#vCeV^1QNF?y1w+1sDYbSGkal`r0x
ziSJfD|8i!NIpxFP_`P{$b@%0SDWf+Yi>GGNXH6s5+mlV2`D|MHdeixV+xXZ3zN;j<
zsimXKs12-Ig9$@Cvp%eK`*Z5z&kI>|WdQ4n!oBj~H^1+P0`^gcZ6#W%en&ald`Er+
z)<LJB+n^6ZU!@<Q==ZgYcE6^TF7ycVECs#-SOd~lRGvUFGd2h?S2;B0xUD#TD-wjX
z(n8Oq*BeUg-}T_mp?ijRJaqSgu7~eBxb0B;BW;hi9F9J=`N+nj&BvM^Z+s#&(r~=~
z$#o~{o?3gd_UYB5!Dj+vE1#`-uKM|^@upLa6QR=$FVw%d?o8cFYtPocy!w^ktAW>6
zzFzZ2^_x|bm2a&$S3Y&~+hy<Ebbjf(H@>&{Lh<|l4~jl4{HWk#-^KaXT*ojsz6+im
zO8kIVD#n2cuas!owTkLfQsUKQ#1~waL;uhUP4tSe3{~uxp<6T!F`l^J>nZWJ{ShzI
z5i3$sG}tip%_n-rcn9+2rDsrP#*g@RT6so%g9XgTc=nf|J>r}6(KnY|a-6!gn>KIJ
zrCU{PbA)YkC-LrC+z_5s3b}=%Tg)Otj<Id~6p?Fe+h!KU8M?zTAv-O`^90(QXvdS8
zz*RH-WGI`rsdc<rl!C>xv^8)6NBEt?O1ly^Io6f}xg8BPfA()tUC`tb)|;Cv`e5^(
zpr70`2<_&MBe31vGXdMpRp(*5xk!wr?JeOgo7Rib*50~4($vu&F>nCy3~z`S+ro{}
zh=FqqMmHiGjpp|7mWZ*jsa=c>(bmRr)M#yP-Wu7a0$m5!p^>@H{#?{Dn=xjwgOh27
zd|W&;<0Dmx1af=(&DbtzGi&RVYNaz~QUZy+=~#bn+-e{eI%dWs(38#wQn6gh_M2JT
zvnQF&^=8tu3?m_dWXkBy#`=>+DuGC4Nx)1Fn0UGWQA!cV>SHOg-U-%*5^S+0%kj&q
zWyxG|a1z?CT$|H*2k=f}H8LOXPzz|QXD}c6YBj(bWj@v&p`Hbo)uvq!uxy!+=ZUC8
zTa_+j2>O0^?q8lWA_U(*;~E_wx~;pOXOMTi63&UT8JKqR@mvzc@Tq(pPjmw6-VdRZ
z;9T76g(=+tb90RQzYR=F)Y`dqDvsxy_{oW(QgIJBaoiK0Lt>Z#j;J`5OZoYKY!FWV
k2U-L$j{BkRcr-0JjKrTS1Dbg#9D^y%NGBHRey)o93j*MVIsgCw

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
new file mode 100755
index 0000000000000000000000000000000000000000..6e4558da0f449f8c948b79da178eb49a27497b19
GIT binary patch
literal 3528
zcmc&$No-qH6n)>$VA8a8(iFKQAQweYRl%fHfT%>3GdKe{gEEL9A^p0x6I&#9Wq(&m
zRZ#;03X~?0LPME4K$yW4D3qz}h+xwlEV^NVV1W=7Dr^eoUjKU>``1z>Hr(X>^WJ&)
zzU%*n^Zo&!zuTs13T9V-C~jRYHyN*VtXyMO$_TuwRh84zsn)9sYMY$d?=^vXO>@c6
zK!@;5S4zDUwD7=WKuVS~8$CH+TE?|vv+zLV8~VuzaojKbD1nV8t$^Z|%f<C^8P|&N
z2NuTFQJkGh&%l_v_4}jKKbBqJynNxW9qaqfx17GP?-Hk6#}6{Ygj_zZE^r{(rGK(<
z#uaJHvM7fnl4(*Io*1$!6V$xm8bOz!b<QzA(ye5f75pz}&HNe3_qVhqo%&tcOL%b%
z^gp1TX78ZP6Vmgt)vD_Jey)~|t-?EH0x=JB#Mh{cS#it5E~@c3O&0%+!aFRyUwF5L
z-zmJy!ebxv&*wE@<h2qvs+pEwe`;dNc`ewVk>8hNH0P!oucn%rW53+Ge_Nj!nQx9X
z966L-K0Cd6)2Yr_+s1E>-JIDSR=U17l#J_>VZ(?{hvO5Wz%01nR6KY;dafW7;UqW;
z4(>^zH8GV+M)YVf5RBx9PZ)YKI++L?sYFaoMPsR%TR5$U{<kTA-@w?o-s0JI8~tE1
zThX7%Y4nEtcjDY{Yx#UNP{G;Zcehbr>cG!c+{ec2$)?rY?`$OGd8#AFHbOVy5TTa?
zxsZv>DEq!)rR~?W`n9$k$LHZZ73?4OYofA3#Z856$pnrap<u68Uv2xkqTD;DJ($)W
z+W+v(obkw>N2eZ(91K0a>xuiG96vPr)X-u7eD6Zn)81#=7F&<BJlp(S)6p$UjnBJ}
zHN4<@vF;`3%hj(qj(45tIO#pL^VPQ3b}YBPe)}6OZ*G69`EAcTP48}fZ_E2PWg0)Y
z@wEHH8$N3I__{N$Pp<v6?riO6&d=9<QT=7rSB`VMANcnkr_xFV@381ts7g|MGOg62
z!&%AoMTc83o$K2`8;<)o<oYrW_PLtbX)>Xcg}!!LowUqzF>lZ7S22I(dFFmQ-9FIA
zV*iS~P8Rc(dA%&=9jcUW+35sA?~47a^7ltEzeYK6Fbg{D1-b*;+-euI)_Gvv)<}1}
zmIKdwmQ@}1R<22pJE*X~Rqy(VFQs4O#It@`^=L|X-1pcUY2mFpby#?-4xSX=s;6g!
zx9X$PyY3xm@9*nW`q1!Tr>|>l*r$^K+}+;e(?{Do{63v@gl<mV*Q<9AxA*(>-mYP#
z_xJ}p+Wq=qclU^I6pjVLAu?7<drC=Lv0@delZ=!XzXF}hb1aogd6Ki!MqoFgkuWiW
zS}bmal_xYC3rt6YxeECb28@96OvX~4NFW(8c_U#md&7xjG#)Ez=pp3^NA!tAU^=Wv
zLga~-@)+S62q4Y%f3<oF<U4}z3pSizpt%ptK7N+1R&%w@^yIC}`pSm=4aE0Y?jE9k
z+_%tMzK{7^1^Mwk1N?#d*zg+>?=oq%osiEK^5a|p;V<s_{NVXM;3JIu&=(-<CL6{_
z9Oi-h|D<mr#IJ}W(96MO)_9Xuszdq^kMBDmzUSa?mC?JXBU_Lkx(2M3K;%ar;62pO
z-*#w2|A2UZ>-^*QOi+b?6XKy)z^m;a-ol0P&{N>ANF<2)2mOG=Lq4HrK>U9AW8Kg$
z%ngpQRR;9Ri}Ck*4He{fu@f1-+054Jb4DD$TcvU}>-zDSSeruEPWd38D<r9IjsF*Y
CRdHPa

literal 0
HcmV?d00001

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
new file mode 100644
index 0000000000..70a4f710db
--- /dev/null
+++ b/linux-user/riscv/vdso.S
@@ -0,0 +1,186 @@
+/*
+ * RISC-V linux replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+#include <asm/unistd.h>
+#include <asm/errno.h>
+
+#if __riscv_xlen == 32
+# define TARGET_ABI32
+#endif
+#include "vdso-asmoffset.h"
+
+	.text
+
+.macro endf name
+	.globl	\name
+	.type	\name, @function
+	.size	\name, . - \name
+.endm
+
+.macro raw_syscall nr
+	li	a7, \nr
+	ecall
+.endm
+
+.macro vdso_syscall name, nr
+\name:
+	raw_syscall \nr
+endf	\name
+.endm
+
+__vdso_gettimeofday:
+	.cfi_startproc
+#ifdef __NR_gettimeofday
+	raw_syscall __NR_gettimeofday
+	ret
+#else
+	/* No gettimeofday, fall back to clock_gettime64. */
+	beq	a1, zero, 1f
+	sw	zero, 0(a1)	/* tz->tz_minuteswest = 0 */
+	sw	zero, 4(a1)	/* tz->tz_dsttime = 0 */
+1:	addi	sp, sp, -32
+	.cfi_adjust_cfa_offset 32
+	sw	a0, 16(sp)	/* save tv */
+	mv	a0, sp
+	raw_syscall __NR_clock_gettime64
+	lw	t0, 0(sp)	/* timespec.tv_sec.low */
+	lw	t1, 4(sp)	/* timespec.tv_sec.high */
+	lw	t2, 8(sp)	/* timespec.tv_nsec.low */
+	lw	a1, 16(sp)	/* restore tv */
+	addi	sp, sp, 32
+	.cfi_adjust_cfa_offset -32
+	bne	a0, zero, 9f	/* syscall error? */
+	li	a0, -EOVERFLOW
+	bne	t1, zero, 9f	/* y2038? */
+	li	a0, 0
+	li	t3, 1000
+	divu	t2, t2, t3	/* nsec -> usec */
+	sw	t0, 0(a1)	/* tz->tv_sec */
+	sw	t2, 4(a1)	/* tz->tv_usec */
+9:	ret
+#endif
+	.cfi_endproc
+endf __vdso_gettimeofday
+
+	.cfi_startproc
+
+#ifdef __NR_clock_gettime
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime
+#else
+vdso_syscall __vdso_clock_gettime, __NR_clock_gettime64
+#endif
+
+#ifdef __NR_clock_getres
+vdso_syscall __vdso_clock_getres, __NR_clock_getres
+#else
+vdso_syscall __vdso_clock_getres, __NR_clock_getres_time64
+#endif
+
+vdso_syscall __vdso_getcpu, __NR_getcpu
+
+__vdso_flush_icache:
+	/* qemu does not need to flush the icache */
+	li	a0, 0
+	ret
+endf __vdso_flush_icache
+
+	.cfi_endproc
+
+/*
+ * Start the unwind info at least one instruction before the signal
+ * trampoline, because the unwinder will assume we are returning
+ * after a call site.
+ */
+
+	.cfi_startproc simple
+	.cfi_signal_frame
+
+#define sizeof_reg	(__riscv_xlen / 4)
+#define sizeof_freg	8
+#define B_GR	(offsetof_uc_mcontext - sizeof_rt_sigframe)
+#define B_FR	(offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_freg0)
+
+	.cfi_def_cfa	2, sizeof_rt_sigframe
+
+	/* Return address */
+	.cfi_return_column 64
+	.cfi_offset	64, B_GR + 0			/* pc */
+
+	/* Integer registers */
+	.cfi_offset	1, B_GR + 1 * sizeof_reg	/* r1 (ra) */
+	.cfi_offset	2, B_GR + 2 * sizeof_reg	/* r2 (sp) */
+	.cfi_offset	3, B_GR + 3 * sizeof_reg
+	.cfi_offset	4, B_GR + 4 * sizeof_reg
+	.cfi_offset	5, B_GR + 5 * sizeof_reg
+	.cfi_offset	6, B_GR + 6 * sizeof_reg
+	.cfi_offset	7, B_GR + 7 * sizeof_reg
+	.cfi_offset	8, B_GR + 8 * sizeof_reg
+	.cfi_offset	9, B_GR + 9 * sizeof_reg
+	.cfi_offset	10, B_GR + 10 * sizeof_reg
+	.cfi_offset	11, B_GR + 11 * sizeof_reg
+	.cfi_offset	12, B_GR + 12 * sizeof_reg
+	.cfi_offset	13, B_GR + 13 * sizeof_reg
+	.cfi_offset	14, B_GR + 14 * sizeof_reg
+	.cfi_offset	15, B_GR + 15 * sizeof_reg
+	.cfi_offset	16, B_GR + 16 * sizeof_reg
+	.cfi_offset	17, B_GR + 17 * sizeof_reg
+	.cfi_offset	18, B_GR + 18 * sizeof_reg
+	.cfi_offset	19, B_GR + 19 * sizeof_reg
+	.cfi_offset	20, B_GR + 20 * sizeof_reg
+	.cfi_offset	21, B_GR + 21 * sizeof_reg
+	.cfi_offset	22, B_GR + 22 * sizeof_reg
+	.cfi_offset	23, B_GR + 23 * sizeof_reg
+	.cfi_offset	24, B_GR + 24 * sizeof_reg
+	.cfi_offset	25, B_GR + 25 * sizeof_reg
+	.cfi_offset	26, B_GR + 26 * sizeof_reg
+	.cfi_offset	27, B_GR + 27 * sizeof_reg
+	.cfi_offset	28, B_GR + 28 * sizeof_reg
+	.cfi_offset	29, B_GR + 29 * sizeof_reg
+	.cfi_offset	30, B_GR + 30 * sizeof_reg
+	.cfi_offset	31, B_GR + 31 * sizeof_reg	/* r31 */
+
+	.cfi_offset	32, B_FR + 0			/* f0 */
+	.cfi_offset	33, B_FR + 1 * sizeof_freg	/* f1 */
+	.cfi_offset	34, B_FR + 2 * sizeof_freg
+	.cfi_offset	35, B_FR + 3 * sizeof_freg
+	.cfi_offset	36, B_FR + 4 * sizeof_freg
+	.cfi_offset	37, B_FR + 5 * sizeof_freg
+	.cfi_offset	38, B_FR + 6 * sizeof_freg
+	.cfi_offset	39, B_FR + 7 * sizeof_freg
+	.cfi_offset	40, B_FR + 8 * sizeof_freg
+	.cfi_offset	41, B_FR + 9 * sizeof_freg
+	.cfi_offset	42, B_FR + 10 * sizeof_freg
+	.cfi_offset	43, B_FR + 11 * sizeof_freg
+	.cfi_offset	44, B_FR + 12 * sizeof_freg
+	.cfi_offset	45, B_FR + 13 * sizeof_freg
+	.cfi_offset	46, B_FR + 14 * sizeof_freg
+	.cfi_offset	47, B_FR + 15 * sizeof_freg
+	.cfi_offset	48, B_FR + 16 * sizeof_freg
+	.cfi_offset	49, B_FR + 17 * sizeof_freg
+	.cfi_offset	50, B_FR + 18 * sizeof_freg
+	.cfi_offset	51, B_FR + 19 * sizeof_freg
+	.cfi_offset	52, B_FR + 20 * sizeof_freg
+	.cfi_offset	53, B_FR + 21 * sizeof_freg
+	.cfi_offset	54, B_FR + 22 * sizeof_freg
+	.cfi_offset	55, B_FR + 23 * sizeof_freg
+	.cfi_offset	56, B_FR + 24 * sizeof_freg
+	.cfi_offset	57, B_FR + 25 * sizeof_freg
+	.cfi_offset	58, B_FR + 26 * sizeof_freg
+	.cfi_offset	59, B_FR + 27 * sizeof_freg
+	.cfi_offset	60, B_FR + 28 * sizeof_freg
+	.cfi_offset	61, B_FR + 29 * sizeof_freg
+	.cfi_offset	62, B_FR + 30 * sizeof_freg
+	.cfi_offset	63, B_FR + 31 * sizeof_freg	/* f31 */
+
+	nop
+
+__vdso_rt_sigreturn:
+	raw_syscall __NR_rt_sigreturn
+endf __vdso_rt_sigreturn
+
+	.cfi_endproc
diff --git a/linux-user/riscv/vdso.ld b/linux-user/riscv/vdso.ld
new file mode 100644
index 0000000000..aabe2b0ab3
--- /dev/null
+++ b/linux-user/riscv/vdso.ld
@@ -0,0 +1,74 @@
+/*
+ * Linker script for linux riscv replacement vdso.
+ *
+ * Copyright 2021 Linaro, Ltd.
+ *
+ * SPDX-License-Identifier: GPL-2.0-or-later
+ */
+
+VERSION {
+        LINUX_4.15 {
+        global:
+                __vdso_rt_sigreturn;
+                __vdso_gettimeofday;
+                __vdso_clock_gettime;
+                __vdso_clock_getres;
+                __vdso_getcpu;
+                __vdso_flush_icache;
+
+        local: *;
+        };
+}
+
+
+PHDRS {
+        phdr            PT_PHDR         FLAGS(4) PHDRS;
+        load            PT_LOAD         FLAGS(7) FILEHDR PHDRS;
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
+        .text           : { *(.text*) }         :load   =0xd503201f
+}
-- 
2.34.1


