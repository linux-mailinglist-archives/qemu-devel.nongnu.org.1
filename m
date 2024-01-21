Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8006B833737
	for <lists+qemu-devel@lfdr.de>; Sun, 21 Jan 2024 01:22:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRLaP-0002YT-6V; Sat, 20 Jan 2024 19:21:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaM-0002Xu-IV
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:15 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rRLaK-0007QS-Lc
 for qemu-devel@nongnu.org; Sat, 20 Jan 2024 19:21:14 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1d70c3c2212so13633335ad.1
 for <qemu-devel@nongnu.org>; Sat, 20 Jan 2024 16:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705796471; x=1706401271; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9Xu/nq6hQa8ZLXYCRSmO5dgODT19xrskc9XyMf3C3fg=;
 b=Lh/EN2ESLax+74ILHQBcm1S3B7ftNg9aSWElRluOvgCpPyL0jmSSkr0uZtSzc01GnM
 dh1aOdgFEZ2JFWjalR0ZmknGa2HdhByJe1L2kEoU2Nl4VW9a4VBAB+EhOmOd3Nlp0s+3
 5W37GqMe19udQ3/6v6nXCHms1pZMOAjTcXnb4F7tNxxWlkh7yLUvt9dT9YEHm5iXfz1k
 GA1yC8smVNHSRODsvjLzP85QSybcUbZCqpGbIFvAICkisymd96kXmiPknOi6jnoTELs0
 EbOPpLwM+QdxIhIJijpO+64BCfzswFbtw+czPPVqX7RAGwAf48d4wTND4sWhm5xxG9AH
 J0jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705796471; x=1706401271;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9Xu/nq6hQa8ZLXYCRSmO5dgODT19xrskc9XyMf3C3fg=;
 b=OsT2Xw0zaa4v8oelyYwH/eTL1GqYXvUUl/irgutLhSUCNFzmxzVgkmbjFZvlCQOwfG
 C3wFMXnN5HN8M6/sDF17b8aaUmkZJe+4nbnQODczqI/+pUJWpqz7XU0EaqIJWsGRcLtl
 MIqthVA/bPvoPpONFK+wSHyTRaKfcO3w/0/Bo0tDjYnBvAyY9BOqnH/fxn5yqa0t7GAG
 0lMazKZ7mMc/j4tps4jV6ewJKmc3zZFmnG01HSAFx/lidT+d+6eGaQ3mF9BC/wIyW8YM
 uBMSPGKjey4dTxNK2GUySZepRU/tsxYnaUvsARu+twTTAthO0A4I23MfKDKkcMAvK6t4
 cUtA==
X-Gm-Message-State: AOJu0Yw8Dzhqfb8kVoy8dF7r24+1UVtCArfOhsy3s62rWyJLVBRX/hip
 m7whCbhbIVVfw17lmMI7G78VYa1BXF0UnnjWETfhUQvSqnhjr+vzC4a29RU1txBDXWQoKbZTkf9
 FTzc=
X-Google-Smtp-Source: AGHT+IEem+jvjzC524AtxbbSrrGHAFmH3lzMPvQARvb/yn1qdjdHqZwk8dSZ/oEGiBjL+Xozilqi5g==
X-Received: by 2002:a17:903:2306:b0:1d3:f344:6b01 with SMTP id
 d6-20020a170903230600b001d3f3446b01mr2831284plh.3.1705796471153; 
 Sat, 20 Jan 2024 16:21:11 -0800 (PST)
Received: from stoup.net ([2001:8004:5170:1e39:1361:3840:4873:7990])
 by smtp.gmail.com with ESMTPSA id
 j4-20020a17090276c400b001d5af7fbda0sm5023546plt.122.2024.01.20.16.21.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Jan 2024 16:21:10 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Vineet Gupta <vineetg@rivosinc.com>
Subject: [PULL 6/8] linux-user/riscv: Adjust vdso signal frame cfa offsets
Date: Sun, 21 Jan 2024 11:20:45 +1100
Message-Id: <20240121002047.89234-7-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240121002047.89234-1-richard.henderson@linaro.org>
References: <20240121002047.89234-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

A typo in sizeof_reg put the registers at the wrong offset.

Simplify the expressions to use positive addresses from the
start of uc_mcontext instead of negative addresses from the
end of uc_mcontext.

Reported-by: Vineet Gupta <vineetg@rivosinc.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/riscv/vdso-32.so | Bin 2900 -> 2980 bytes
 linux-user/riscv/vdso-64.so | Bin 3856 -> 3944 bytes
 linux-user/riscv/vdso.S     |   8 ++++----
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/linux-user/riscv/vdso-32.so b/linux-user/riscv/vdso-32.so
index 1ad1e5cbbbb8b1fe36b0fe4bcb6c06fab8219ecd..c2ce2a4757900a16b891bb98f7a027ac30c47a5f 100755
GIT binary patch
delta 643
zcmYjPOH5Ni6ur|gwzc+9XhF0TMNp`GR6Zh~mKGzXLQ}<nX)IXKDriMfutkSuO^l&=
z8%#8QLeLmPh&6@~q8pbkjmE?!?quJE3vZFdn`GwPbMD;S+&S~jvFMz4i@%wQ7Lm>j
z)#}rFqIBkAs)(L%{#f{&3ii(}e_yh8Pgey7+LRKpj+~BYkcbM&LN$yL<+mtroa4HJ
zZMB#&#N4vYgN#$Ed?)jGwn>u^j$uL6%5;@6#JIs26v~>`CEXn6`%uX09<>tLIBejZ
zFY)AcUK{^`w8`*U60=@WX3@OR=)D9Xp?Lu9eduPPPr;Cc@g53huwxpgyD;B@WePiQ
z!+Hz5CSkh?Bv5z*_UkB`K=C*n*Cd=*Q4&Y#73{u@vN7x##oicPmry<e_b@6hVqXON
zFQ9S|2hOAF9IC@O7{Z}G)C5s`8lF=)d=hm5)OVx7i^fk9N7f~du1OqQm1z1X(fmQ8
z<-J7fip23{iMDqVC*Df5zmc$aEJ<`ON_4%FJY|0RKiMa`*FxkJpP`=5Nj~S5mxeB>
ze%vHqR9p0zd0b`2Q|4;3R+vXr`7g}X=20v*GSM6w@2yKv<qSmwLw&w8y?%;@!u|f9
zz(BYsnvEJuwVHOJBuy@TzIRS}W~$!$N`A#>wky9(Ht|*2WbKiW=;xN^G26tL(qVS~
E1D4W)y8r+H

delta 565
zcmZ1?eno780^^#Aisp<K6C<@*Em#>CEGBkVi#XS5FJ{d(y6ALK`0fjZ#F<&4uOCj9
zVB90Pf`x%0f`NfSh=GSe3rO=!e#$6sXaLm50TmSm(hNX850vi%q*ajQ?SOoV&8AHG
zjA8<eK<j|q3?Ll<q^AJsKMa$1G0W9o0CGY0Fa+=^r0_8?2mqM|Kn&8N0}=;<DG-W*
zxhg1_fw9JcQJRNo11qaTN@G$}LUUY8OlwqIM0;3ANM}%2K(}9yPp?;>N59(ymx)f3
z946aMv6*T$&0@OQ43n8gvkYeI&C!{wHBV!{+5(q_PELy)7TYbcS!%V+V!7E0la)rR
z3|8x{(OIjtPGh~=29=FUn-n(7ZIRh3wM}BX*bb4MLc0WZ^X=i;%e9YVKO5Mwb2h(Z
zS<c9~V)8^beIR)dNIFdZ$Yx)U92QkTA0UTlACNDB6n1lfeB`j*0Oa!^$sYmok;9rH
zIXR%X(kC%nFP}lBf+5}|($CS?)0rVYAjsd@)g?5@HGcDYc1dQ&H<K4~2~WPm#ls4+
se#PXsT<YM+cb+_vTX?b#w*X_!WLs`^RvUH(hMQoq8lafy<X&!Z0L@r})Bpeg

diff --git a/linux-user/riscv/vdso-64.so b/linux-user/riscv/vdso-64.so
index 83992bebe6d0182f24edfffc531015fd2f4e1cfb..ae49f5b043b5941b9d304a056c2b50c185f413b0 100755
GIT binary patch
delta 646
zcmZWmUr1A79KGMY?$6b`wWF>%t*xcjTq|2?Y1y{IoJiPMVG&Z%B2pwIB5I9(EFvNz
z?)pL^MhuHse{pSyL_`lkFFpi~An2jTdJL*3ANrQJmv!LB`8el0AAG-~d%k&ezwB?w
z2F6$=o7t~c%+g;}vY+2KKi``ijg36bKRDF->-VRR@qD&8Un;XH#&qseT&%$Rm2UT<
z5wR{OC8yv<Nt1Fsqqy8}YuvEmmP<wD5_3*7Ng5DRT5w!&LGU==ZEB~WIB7zu!XYLo
zrbB2|uHxr1NlGelKw{}AYt!U8*%Xz)E<;X3NullnOy^-f2g_Mlr=gxf{S+D|p`C{9
z6znIl;shMWfum>~N7E5BABJ-bD-Xhz0JX&79!2Xuw2ffZFjf!2GYIb<tck++hOqWE
zq5T!1V}Z~)Pgqwbtba-H&k?#_5CYE#8=eq?1;WNhgiQ|#-Lr(vc|zzuVM~s%^&X+;
zE}?gZu<Z_E`)xv>PUycy@b0)t*m;96aGkL08X<g@5V=C)*VSz-@lJE8^u?@+F0z>>
zzGUeUrG%_8_LX0>9{X?YDUqp`qVpeCm%D6~@^8O6!(HS))fFn#xbF-%SEEbG<V5e#
zU|*s%p~mXuVa5Zphkvj+RNc6#^Y69@tMD#+L~gP0Nqd+r@W=LunynXa3e51L=KTW|
Cbc<&I

delta 523
zcmaDMH$iTK2Ga$uiCSTd6%!l%IV;#0z@TE{&Eq0-y=7zemwaL`Tf>?2`}67j2EFQ>
zo3}9LFfy7<R%8}u^qFkQtS?yr)xrVM$sh`(g&24k940q1i%X`U$=X3>BQ|eju4WV!
zVPs&i0SYMq=>Q<@1Ed)yJF+U*UjQ<AfEWY>fLI5JPe5rP#V`Xz00DDVP%r~yjRT`J
z57PlQR)-eG#s<cwn&yg@lGcK@oc4^4l+J{%nC^(4kluhkpMH-CE)yLl*-W;WVlvfW
zn$C2M87easX35N!m?JV*U>?tWjs-3YofbJbEw)=?v(##t#d5P1CM%6r8LZY@qqA0P
zoyK~#4JsRzHYseD+aj}7YMaD%u^l2ig?0(-=G()wmunx#evpSj4qh<1k!|y419kyW
za5-|gGn!0n6rMbX!-TP6@<on##+1p1oZ^xu(C~qIwGXHh6nYVp6M?emVY>k;>oa*G
zP}TuWFGF&2M1Z-gk@Mz*obD`4Zx|+X@#%5GYydif&z`YjawDHTFrX$M;<IB+n9Rs;
L&uBT>kzXAEcnEna

diff --git a/linux-user/riscv/vdso.S b/linux-user/riscv/vdso.S
index a86d8fc488..c37275233a 100644
--- a/linux-user/riscv/vdso.S
+++ b/linux-user/riscv/vdso.S
@@ -101,12 +101,12 @@ endf __vdso_flush_icache
 	.cfi_startproc simple
 	.cfi_signal_frame
 
-#define sizeof_reg	(__riscv_xlen / 4)
+#define sizeof_reg	(__riscv_xlen / 8)
 #define sizeof_freg	8
-#define B_GR	(offsetof_uc_mcontext - sizeof_rt_sigframe)
-#define B_FR	(offsetof_uc_mcontext - sizeof_rt_sigframe + offsetof_freg0)
+#define B_GR	0
+#define B_FR	offsetof_freg0
 
-	.cfi_def_cfa	2, sizeof_rt_sigframe
+	.cfi_def_cfa	2, offsetof_uc_mcontext
 
 	/* Return address */
 	.cfi_return_column 64
-- 
2.34.1


