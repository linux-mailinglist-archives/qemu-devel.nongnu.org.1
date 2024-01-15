Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E982E333
	for <lists+qemu-devel@lfdr.de>; Tue, 16 Jan 2024 00:16:55 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPWBn-0007D1-SV; Mon, 15 Jan 2024 18:16:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rPWBW-0006rO-KI
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:16:03 -0500
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <vineetg@rivosinc.com>)
 id 1rPWBU-0008UB-HC
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 18:16:02 -0500
Received: by mail-oi1-x232.google.com with SMTP id
 5614622812f47-3bd576ec101so3235540b6e.2
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 15:15:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1705360558; x=1705965358;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sPga7+ConxBZ+rteOtFzwEj9FWX4ZMxhZxqsSsRYM6U=;
 b=p5gGcPN9S8QczTLcSpPTGcOeNS7erD2NyjO5BFVINRDqx7n3HDrJw7H/aFuLqsb9Uh
 /cmIgI3Lp7b0WdS5bvo/9QlHFlwqYdiMDcpX4apcFpRZKJQtfUR1hBTXda7EZyDL7Lam
 9pt9a9WUN99Q9Um3zAgzJYn+w6AV/ctuNnARsOxOkd15aP1B228YtXiHKJIjjC8+QeNW
 vet7Ry5Sk88GI3qX9LNNVlxrhuSvvmfeS/7q2uzyCrtHam8DFg43HonV25x7Yd2lPRCe
 2sF6e+mfaYQ4clOfFvde7m/dX6Sfw5Nv67HU8FjyxK3AEYruyNhJNM3Esre6PaNIDOxw
 Z4pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705360558; x=1705965358;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=sPga7+ConxBZ+rteOtFzwEj9FWX4ZMxhZxqsSsRYM6U=;
 b=Mk663d2NBpMli5m3N2ImND0DOihnLj1x8uPGe52jKZ7Ri08iG6SyV+jm7RNEkzrvLu
 DJGTw12iVnmIjWWrv9lt7w5niqu+xCsSYw31JKlWZmIgNnoAR2LBKyt7AVUf8nxHhSO/
 TnEJX1jiZ70tXh3bja3k+Ccexabf59E3EIjZJT+w4S6/xP257jKMzId0hgckRR6p21Zu
 LrKeoR8BZD7ug7judQqRn3PahNdLxIqRQqnjUSLOeVKPJ56i4Vk+bc298X65AMncO55z
 pKwDh2JAISOyqLYSURbt1ZYa2TXS7f/Uq32VaTHmiuxi2Zs682ZT21dBKw1gA1ca9Orh
 213g==
X-Gm-Message-State: AOJu0YxuWDpvRWuIrlgQyy4GFW9NfgbnUvJLnm1b3+/04CGcsCYUE7Ji
 if2X1JQnmmktq6zSJT7xdUPtKls2DgS43uqNUQT7bNMvgq4=
X-Google-Smtp-Source: AGHT+IGmQGQt+tTdmcZMaJpEYRwvDToVIeFicq9CObyrD8ex8kbSE97w/Rm/C8dPNiraxMmFZwVbqw==
X-Received: by 2002:a05:6808:2202:b0:3bb:cdff:2c67 with SMTP id
 bd2-20020a056808220200b003bbcdff2c67mr10785547oib.35.1705360558415; 
 Mon, 15 Jan 2024 15:15:58 -0800 (PST)
Received: from vineet-framework.. (c-24-5-188-125.hsd1.ca.comcast.net.
 [24.5.188.125]) by smtp.gmail.com with ESMTPSA id
 oe7-20020a17090b394700b0028e6005f836sm1813182pjb.28.2024.01.15.15.15.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Jan 2024 15:15:58 -0800 (PST)
From: Vineet Gupta <vineetg@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>, Edwin Lu <ewlu@rivosinc.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 gnu-toolchain <gnu-toolchain@rivosinc.com>,
 Vineet Gupta <vineetg@rivosinc.com>
Subject: [PATCH 2/2] linux-user/riscv: rebuild vdso binaries after prev fix
Date: Mon, 15 Jan 2024 15:15:52 -0800
Message-Id: <20240115231552.3217789-2-vineetg@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240115231552.3217789-1-vineetg@rivosinc.com>
References: <20240115231552.3217789-1-vineetg@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=vineetg@rivosinc.com; helo=mail-oi1-x232.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
Splitting this from prev patch in case maintainers want to regenerate
the vdso at their end. Or if they choose to, this can be squashed with
prev change too.
---

Signed-off-by: Vineet Gupta <vineetg@rivosinc.com>
---
 linux-user/riscv/vdso-32.so | Bin 2900 -> 2836 bytes
 linux-user/riscv/vdso-64.so | Bin 3856 -> 3792 bytes
 2 files changed, 0 insertions(+), 0 deletions(-)

diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
index 1ad1e5cbbbb8b1fe36b0fe4bcb6c06fab8219ecd..ee158b8374d14973492a4d05f705bf12c6cf42b2 100755
GIT binary patch
delta 563
zcmca2HbrcL0%OiZMRVRQEDUhqGci@34J5FIWnx#Ah{>aRivX+7%f)pfCby{;th~y{
zaAdLs;~pUuppponE+GaU1}z}n!7}+7qnyzipfCqiSQJRt0Qo#nz7LRIfFy4R<WFJQ
zY{rzwDB1&LTLAGBAPxXx5k>}vipe{f<y}F#Ko&6s@F}G5F)#=KnFc@%(xC&yAOI2r
z0p_ZpU<Sq-Mn-8~CXko}5KjSOj>!vIX7G3eSw)$}$z=?Tj+0$kO*!MMa&t>_3=0e<
zH!_M&p1`_+QDw3tn?8^%WRtG<1Q`Hy1_&@ReEc5-qz?d{4+0>54v?O~4CVp}E{1v_
z>A(cxgXE{eq=2*_kiP&(BYS@fkdGXSCxHAZh~TnkxCRtJ4$oIWeg{GU!#^M&IeZzC
zla0z;OWoY{@)=YrCVR3PB7C^ni@l3+^CgaDjEotR1G$7J_i*vBf^1irJeNzI6%^q<
llO4H*C*R=`U}Tv5mP?)O02>2?Fymw?ZY8G6?33-d#Q-6rVafmi

delta 697
zcmbOtc13K00^^#Aisrl)tPF7AJTX<C4J2T}I<c!t#JNs;F>9{TMW>6xcV8$Z&ddsZ
z{cy4b;~t?EEDQ`0KwUx%JPcYunum4rGe$Wh1E5Y0sIVx=P#~WN%J%`%DoFBnK)wX)
zW;3QdMo|Gqpp8I&29OQ_(o=x+pUFF!<?Am1c_51z0{9eC_!t-jfJ_4*2I<fNi37nD
z2*to$6%@?CSmVGb&BL^TmDM4oF{vq`Ij$w9HL5M5J**?7GpH+|+pou`*Q?K?-)(}+
zM5jp(lkKM1OtqS3G2Lv2$xNeJ2DA0%=*-ocr!ik`fy+WCuSE`v?UvXqwOVGe+-!x(
zN~2W<tM%6Ctkqhlv0iP1%0{J43Y+D&$ZVC`Cb3;?hsaK$T>`uL_VDcG+Q+e<4eZ!C
zK*vo0VxGyeEHikVfUKg-;^Z<0MvKV@SxhH4GKx(WVco#EV)9W|{d!QaLI5b#5P*f@
z<9~i2R|4p35MTuIC4jU8Fg!s3#5V%cGnm0#Ai>4p3M3tvAbgN~G)xLe3j+CRKpHtd
zsu&oe8Ia?(52!!_DFQ)0L5|=JKt2zW{1G4@Il>u|lLLw?eG;?v@)=YrHgm9dF>ap1
zv4oNF&169?;mJN+Jggw=R!olNQfCFFIp@iY+`^ORa0xKhOkN8VvtegoxCs_}!zI8Z
K$}#yLmlyyeGL7y4

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
index 83992bebe6d0182f24edfffc531015fd2f4e1cfb..f2e250fc6ca1bfb79bd7f350ae914fa7b366a1f5 100755
GIT binary patch
delta 694
zcmbOrcR_Z72IGW@n&FHeCSPP1p1gpGh0$m7Mjr8r8x*)curh$b2iA$Vj)^$8=3hz_
z5MXOLa6sbt;}gq7+qw5{-olu}D76Nvjt8QgK?_I=G4L=PVV!KntmpLtD$N0v7KKXh
zK-1;}6~BX~-VQ2$fpzmH<|;<99w6Tah-UzC01%%5;tGbzPOM6f9zZ6{6#_uE4iGy)
zX&}V_5(5F|s-R#7#u`ROX<jCfm;?}m^m0trW%J?j2C|AWi<8S37#%0KvYB$mSLNoG
z<`@<jOrFT3xcLqn4<q9mU~q{}{>N?vW(iLg;Sllk1nOgC`1pSZBandvf`Dw0I4nG2
zQaNA-7lQ)S!!Yss$qPBe>!$*_f<Rp`Q5d}d$N+^ddN6H)ilfH{D0o2XFQ5hYHK;gx
z^t^(In**Z{$N~abfc^urK?b468$)ukXIh?dkcD18gG$BZPBueCfNjp>T*L@WRcxCD
zxEC-nrcB<*tIq{<;TqP-uXyb^VZq`v*^tki(P45XpFP(D4zSe>!i<wQ@tJXc=7eyk
I0h6XY01KLL+5i9m

delta 798
zcmca0J3(%O2IGZ^n&C_pY?CK4i7`4)F60rPxIuxdf{g(TD%d98IwmsLTQ+8Y$tU)*
zHJmxWKcC)j(5ue5c?)9>qm&6$9S=k~gBFk$V&Gx$VVi8ltmjn#mF9p-i$bLx(6sqL
z#Z%DK+d;)6*fwusu3{7uVPs&i0g5RA=>Q<@1Ed)kCp)n!)n5RzV6G4VvUPy?1e69+
z3^PCk5HME-1v4<#I50}{FdblHb!cI1Y+!7vX|8A~X)S2WY0v0L=}hQ~>5k|L=?&=f
z>Gzo6GSOj@&18!yCQ}Wj=}gy{p)ylpmdtF4IU;if=JCwuSm3hIX_151V!I_aORbh!
zEH_(WveIak!D_uVI%~DoX{=Y<pt4bElfq`XEizlBwn=Ok+aa=3XqUilzCAp9x%P4F
z2YDIf-~~YJ0>nI%m$LfsI00EjnZ?Ov42%|&|FW6_qep3T3>yz4lL_18EOs|RSjYp_
zLBQmR?BbsMKsF=8$NxJ(0fPi2fNYR>12lkPQbu3~7lQ&TOawx^PFCa)=Zpq&1cAC3
zCNuI1*Ms5}J%Xx$DnQ~e*T7<+4=Nsk7SVH{;^+xu1614xP5lw5I55FT1DS{@W=Kws
z2rzdwa@NadP^s9g!MTWW^98O2OpI?P7xL<J!Q2B3tW~^roUr8VJozK9IpcxJntb-0
a37lX98Eyj8y!_+|d=i|NTo93IAQ1pY&yJD+

-- 
2.34.1


