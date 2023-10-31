Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB8E7DC51F
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 05:03:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxfwH-0001Sp-Jg; Tue, 31 Oct 2023 00:01:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfw2-0001PY-Jx
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:58 -0400
Received: from mail-pl1-f180.google.com ([209.85.214.180])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qxfvy-0005HT-NJ
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 00:00:57 -0400
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-1cc5fa0e4d5so8741225ad.0
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 21:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698724847; x=1699329647;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SGtq5I2edM6lbHRuueynMG7BqVX2PCnxVoATIyNBLD0=;
 b=h1mN6xMyA47XYen6NvM0vlCaWL+sDlvTibMBMLFlQU5Kd7YT9nglhM99DoP8LPDF48
 4LBjltuek8EDGXnsfKpc5vzQpxYnrEr3TGFlkeNPaf5/T8rV+Atij5WC22vMygltAgnR
 jTd5Z9qfhFpc+R4pj84B2BqBf6S/nmPql/ObvC+THDASMwDETCtVJ/YgyPLdyKmgEQFL
 mtuzEKR+FFd7Z2on7tjUUObqeQ4zgHTZNy+uFZY4sw/o7GkihArG/aj2TCWSiBmJLiMd
 c+v+oLRH6ohavi2iIa83ba9mAip4G0zP+qHOvNYBpaDWcnpoBq6JRult9VZlg8zKDSts
 CPlw==
X-Gm-Message-State: AOJu0YzuT93GhskXrWV7LBFyRrJYmcP07xXQlAl3DAIULsSkn2nYAX0l
 bxqB6YKO3Gp20T2M/nPG1//0t3aCPSy+gg==
X-Google-Smtp-Source: AGHT+IGg2nQ/f8K4yBpyajIM6LtKFfqc/VDh7TqtL7dE9oPkkl9AyCJf6K1+/Q4yo1lnBy0pQ2Hq5w==
X-Received: by 2002:a17:903:1104:b0:1ca:29f:4b06 with SMTP id
 n4-20020a170903110400b001ca029f4b06mr15208843plh.2.1698724847509; 
 Mon, 30 Oct 2023 21:00:47 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:7b37:49a8:6e6e:cee6:cee7])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a170902f54400b001bbfa86ca3bsm257975plf.78.2023.10.30.21.00.46
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 30 Oct 2023 21:00:47 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v4 13/14] tests: acpi: updated expected blobs for TPM CRB
Date: Mon, 30 Oct 2023 21:00:16 -0700
Message-ID: <20231031040021.65582-14-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231031040021.65582-1-j@getutm.app>
References: <20231031040021.65582-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.214.180; envelope-from=osy86dev@gmail.com;
 helo=mail-pl1-f180.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Signed-off-by: Joelle van Dyne <j@getutm.app>
---
 tests/qtest/bios-tables-test-allowed-diff.h |   4 ----
 tests/data/acpi/q35/DSDT.crb.tpm2           | Bin 0 -> 8355 bytes
 tests/data/acpi/q35/TPM2.crb.tpm2           | Bin 0 -> 76 bytes
 tests/data/acpi/virt/DSDT.crb-device.tpm2   | Bin 0 -> 5276 bytes
 tests/data/acpi/virt/TPM2.crb-device.tpm2   | Bin 0 -> 76 bytes
 5 files changed, 4 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index c2d1924c2f..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,5 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/q35/DSDT.crb.tpm2",
-"tests/data/acpi/q35/TPM2.crb.tpm2",
-"tests/data/acpi/virt/DSDT.crb.tpm2",
-"tests/data/acpi/virt/TPM2.crb.tpm2",
diff --git a/tests/data/acpi/q35/DSDT.crb.tpm2 b/tests/data/acpi/q35/DSDT.crb.tpm2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e 100644
GIT binary patch
literal 8355
zcmb7JOKcm*8J^`sS}m8-l3H7S#U`8>eWXYzJ1?|oP;!?qOOz=tWv8G4E+waxod8)R
zF%Ty(AS*!P_|$}T&?B8HKyU4-*Ba=hz4_JvJ@wE_u0;`_qJIC(jy<!afQkol|Jm>R
z|M_Nj=UdMBf#3Umi815V>Lsrkl&WuZyb?YJV~mdJ*J)+0vi^==Z48WDDr5BT<oGeZ
zs;2uBzq-*dezzTd8HVqF8XCihZGPq4-yB9C-wihzfo^U_mPH57%HklX4*I*Tg^t%M
zn}cS{w=0h<(;Rr>C~XclT0V1EX9t%8FLUoL=J{8a$7|Wqc45(S`t5&S`0mW9UwnDx
z{mR3i|KnHp-m)?PoX4+;-wP3ag&&31>2U0PF}iNtCOSX2JYM`_#7~Phht5PHwLGvz
z6Qx?-d&^zP*8HHIAHOoX!J<OiVBz@07or1?Uj6&OgO@*Sf4=l>`}kkI_Fg!iy?@<G
z?S+wb=WfUt8cvOFShG<vn__tuViewHY#0s2$^PzZez)Rr<@wH9r|gxN8Ps=!!Wrw-
zr%R04H01R8)BgVcU&JAEZZT)oeSrp#2Cl!;@q(U_duUr`|Bgd}hxUyUzWh>uC#YS-
zrTUv~WpJ%1@T%q7MVzRvwYx^{k)ToFRo6D!rB2I#qtrL5tKJH8&vm@o#Z>=UiuU)T
zZ9+u1jO&bY^nXCjd(3^l0?srP<%;MljIp6xo$K)N^k)t=pcpkO!Uqsv2HV7CxINlr
zqfHxQv(Ii1jp6O#EyJ39I>6&|+UO?|M4RF=n4OkaXRbZKuMuri<m_HHXnY;-TYhhL
zy1h<u<-MI^E|Wv8)wPux6UPRQ>#S%~yOl!FkU<(jlNIwB^beO&;Npl_0M3hZoCl~3
ziHZCio8nAh<A|6Nnqr&@C}$!hCVIoMY0i{ANHbzeXj(7<<xGUclvOgEDSMFNObN{h
zrtCaIRcBVyndM9g%?hUMJVI6HjHYvjGbMCJ*NIToIjiZM)pXA4IuWWmO--k%=`?kn
z2vwbPn$9^*=bWw+p{mo;bXuBDOV^1|)tS?D<}{r-T_-|Sr>*I<HJ!Gu6QQazuj$Nd
zI`g_tgsRSYP3OF(b6(epP}RAh>0HosF6cTDsyZD_r=#g~be#xQodr#2LDN~#bs|)C
z7B!tkO=nTpiBQ$KsOenPbS~;T5vn>}O{c5rbakBwRh>sPokujCM|7PCRh>sQokumD
zM|GVDRh_UgF=z2vX-U($r0Ybe>O7|DJf`V9rt3tg>O9Vwm3SsR&Y9JCvO6xA-qVnn
zevCb#F;8gB6FL*2$~>ttPioAQIuoJFJf$&DY0OhP6QRm{Mq@ssF`v<y2vz23&XjZf
zY0i{${At0I6E{L)N+&s^)jXrsJfqh{C~BH8(28Q9ji80n+)ND|qi}4X2vAl8X#}z;
z3{>FwO=K`)$^IEADxgmc6rq#`0~J_lpbC@>R6w5?C_?l`8mPd=5!FOi>6pZnBSr>_
z5Iy2p7^uL;QLK?O$v_2EhN?~&s7TA1Fi-_b28vL+A{i(`sS^e&u$&14RiI>`0?KQW
zfg+STVW0xbnJ`cVN(L&RoJj_XQ0jz%3M^;BKouw%sDN@N87M+|Jz<~%%b74x1xf}g
zpqxnticso=feI{V!ax-$8K{7ACK)I~sS^e&u$&14RiI>`0?L_Wpa`W-7^uK<CJa=8
zl7R{+XOe*;lsaLc0?U~&Pz6c`DxjQ628vMXgn<eyXTm@gC>f}LawZulLa7r5DzKah
z16818paRO7WS|J8P8g`bawZH^fs%m=C})y^B9uB|paRR8Fi-_b1}dPONd}5g>V$y`
zEN8+%6(|{~fN~}oC_<?d1}d<e2?JH2WS|1dnPi{{rA`>Az;Y%GRDqI#3Mglifg+ST
zVW0xbnJ`cVN(L&RoJj_XQ0jz%3M^;BKouw%sDN@N87M-j69y`<oCyO}pk$x|%9&)K
z2&GOKsK9b23{-)VfeI*Rl7S+WI$@xQ6az)18Yn{5KoKeisxV=o3X=>}VUmF=Oc<!b
zgn=qdGEjv{2C6V&pb8TPsxZkw6($*|!i0e;Oc<!bBm-5LWS|NY28u{tT^J}LTrobF
zWS|If8DvOIIkqrRL~?9lporwyl7S+WV@n2#5NjYO2Cz^zwnzNW>K^?eeK12m6?d_<
zj{pDTxsR-!ZMJ94?O8eZrPjLForCRm%Y}I>_t^}a<4Xy**ga~qviNRAA8lI;jE<0~
zTkh|!&cf#_awW!I5bG}{N(Y6b*5YULY%UFlVwi&&W>a>HxeJ4!S7Ce9g-&<9;uZ#e
zD`2<j*xKPO3$&m?2(QcIr9sdQjC<R0AE-RF$JMKe>c%0eSC#5jUcHL`snx6Q^y=0A
zZkx1=wHT~I#oDdZA<BD7d5@R(66L)E%6oBnKOx@23fTWW_P$cy=jHuGdH;a&eq6qm
zET1_<`I=I`#>>|d<!c9&uf^r-$@1All&>r0>%4qDQNDga`FdQwkt{!Ri1H1ke1n&7
zB+54qDBp<7H<RUO4^h6UlyCC#%|!X;0p*)0pP}g}S>6%l<>Y}^13d0xaZ+z{XZRzJ
zA9}9ibjioqD(LC(zA%wav`tMn@mv=5ba;uFNGIB+rki-q7WH&^vzSOH+NP$Pcy3%h
z9bPvk(uuaI=_a0oBYHZ#gG{6oZBx@t+}B6-ba*kDNGIB+rkl7=m-KXaTbW2F+Vpfz
z+Z4<HHM7~N_2lhmV9KLK|Nc(1(`z%lc|ZC-$FOwmP`r4#w&s^QU4Kw=U*XOZQA-$6
z)9}O4a>B9w`6y(g5bLpfY&`$@Xvls$wAsJ@o85ys!qRAYy<p9Mg1;b?oZ-(J7S!EA
zqa&_kzT$OS<#PEI=3IJRbg^k&eK9T9+dJJ_AbV?JjzDkoUT34!eCPe>?VG<Yz5C{S
z@7#QM>&^FA-|#xCEAc~<x2%Tojs1;n*teh#(>m7dzp*X5f9Ho3R9MOD)Yc5IwH6p&
zw|&{b%6pl<>IO@DUfaj&evy!AFQ~1S0QW1s5|*u7Yb`Tk)QE@g!d1R8fDVaH#%h+!
z)D5w%l64DSul~!_*cxrKPdrGy?lxzzZBUu(KYR7Xj4G4_(7J!J8O0*n2^l3%kc7xu
zz<U40nbnoO&~0Z)*5L{n$yCTNHNRUw>IL4Kd4LSlTdQ3uruHMY6&csQ@{6NuM#Qc~
zMi{Z-SF84KMxk+k3r%6Pl`P2xCmV55#!L5;t+*^(UytWTLu(&pzK*7yA3rxSa&+CJ
zt-I96A-g$5uO7TQet81M?+jeNEh`;O3=B?!cXNxj-D(-J??wqX*%n=LXxr*9PZu|l
z3;nsdIenPhbKa$(XCE-k)9;pv{209G`joMWtW>g<pf{3@80M+H>wo+j-P81RGuqX`
zeQoa1-Hj)pUFj8amdUViL9fH^JT?}4ITFLRuitP_;^DzGFsPN!v-pXp2Z`<}r+q{`
zS$sc;Pa+p{)}Qa@SqgI$KKt}#G>pggW7{y%ZrIp?VeC7cer!L9^VmLO>_2>SkDsTv
z>HU3ro2E~SY1@7#cDDW~&agjdXC7id@OyFQ;p_LF$5vsSO|+3Z+7^RQ?L#r9pIt8l
zonp_G?>ts8-HEA;+LbvBlXS0Q<;1kf=djXDX~w`FWPkT!rqk?n`COPtf<c-xA5P|a
zXg{=#W0-z_bQR@;3xncJ#z5b3{L-LkW~`Kj^*cl_(-~6Y{Osvv=<mKzzv2nI%&*tl
z8@TM}37zP%lXbE*>pHcQS7~x{+9&8L_IGnZxjZlj6~7BLKMu;Ti2zs3VDRu@*=N|@
z#KC!aaDfh>+zska!DnbbZ*|vGR%qFdm*GYFcYgX}n#vH8&KmSD2mi>{tMuj3mv1td
z*?NtR>-5#2ucq1GeQBlYqcdVlJPl7IO|f|$vyL>3kcG^^?RJe_!|&M?zpBr*FKs+w
zE#Rd_VVPF;ENvb4ch9eOddo6*2IB<>!{00g>sa}Q@j?27v}vB*;hE2Sm)cJ_S)iwL
z9;Y9tnR(XXoO9it_oO#D)FJ2PsUsFK!#v9j>drz?uf*e?Vi-zlsKyOxG&nXrlX!Wk
HVR!t0z{JvO

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/q35/TPM2.crb.tpm2 b/tests/data/acpi/q35/TPM2.crb.tpm2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..9d89c5becc0fc4558a0556daf46e152181f2eb51 100644
GIT binary patch
literal 76
zcmWFu@HO&bU|?Wja`Jcf2v%^42yj*a0!E-1hz+7az=7e)KM>6hB2WNG#ec9c0JCKY
A0RR91

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/DSDT.crb-device.tpm2 b/tests/data/acpi/virt/DSDT.crb-device.tpm2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..1b3a8ef4cb3ab093402f4bdb2a349b3d0d015ad5 100644
GIT binary patch
literal 5276
zcmZvg%WoT16o>D`lh__VVmr?JVHZlpGaB1Xla{u`9y^IkoEVSWAf=KkRYjC+Dp6G`
z6;jBeh3;r1RxE-P3H}TuR_xfZV9kbqfF0&{=guVOsAr^%=gi#m&Hcv5@$qf?&Hj%?
zrAB^f?0Q>%x$$Y&D`T^iQu<iG=3Z=CcL#oBuzxh?xvrZSY_*%2y4P(ZSXGI^?RHb`
zA6@fyJJGdXXUlafmGD|(;Pw3coHPAAsWdRDa!P$SrY!3MqNm7R+t~9q4EK{(=Qg-i
z<of-(lR~mrw+tfhWDQ~@ITL2q?K{0_O4~cVU8Js@-}Wr?{N|1t32*LFM8({lBlK-w
zLyV|%L?uKt^en0p!WoemHepmLqb4$95@U=oYLszVWY`iTK^T`QV?|_)N(_fERw(0&
z$QY9tX~MWd8LJ{AE-|u%u}T?hA|oL&a)hx)8COL{QeqSc<0@fP!Vd>8F~^Y@MZ&m7
z8Dg384@p$&Q-tv$Wyp1!mgX@-7}qI7uG5Ufm?MlElp)t?R$?p=#!bqQ>vUXVED^>>
zlp)t?PGXb^W1TYOI?YRrHwdFn8FHN#B*sO;Xi$b+rxOz65@C3RQI+eoC^6n9j3#Bs
zbvh|A-X)9{Wyp0pB{AM7j19_=>vURTEEC2iWyp0pBQadU*rE)%PG==Xl`z_rA=l}g
z#JEftw<trd(|L(;g)ly*47pAhB*q$HY*U6@r;8Hf8ewz@qbAqslEk=97(0|9*J(*&
z+$4<Mkg@Y~*K3FK=<amgy1Rzv!$W&yqMGhvTASE68arogiQn(#OU^=9d8(}*sIqeL
z*Tm5i^-$f%tJ095@#yyY6Wd=phlP}#8V=Q_-*%Nbws2fgg|t5Jj3B5+K@34n6*6{u
zIJA_`!MHHeSs0i#*Md9@jY6FXelQkYk{KIDIx`xI7D(R_LxW6&Iy1UUEXa&z5K}rc
z8X7a17#d_E)R~x3a2GqsjAmd5nbA<ROrd3viI94ZGSAT<Gx8iYnbG7CQqM8wiKZ0u
ziH4%ZqMit;XPkM)nP;4PBBY)P=9yrgXvwH2Lh6}ho@l4d(+eI+l6xYgo(}VLm?v5|
z>WPqgrkH1nd8W80Lh6}jo@wTZmXCTOq@Ee(nPHw8?un3kW|?P}d7?$6o(QSuIP)B5
zp5xpTA@#)18B^my73Y{IT1x7Pkb35sXP$ZHxhF#ESzw+8=7|=RdLpEr6U=jhc}{Ro
zgwzv16p3e%d7@>do(QSuB=ekPo|D`YA@!VMo>R;dEiUy$NIj>S=QQ)2=AH<tCw^QK
z&l%>4mY8}Xq@J_PbC!9|a!-WRbB=k=F;BG6)Dt1~oM)c%%yXW5BBY)R%yWTxqUENZ
z2&v~H^IT+}i`)|-^;}|}OUx53I`u?IJxk29#5_yf6QS|kKWf|htu#O1^p~>dZk&A)
zcd;yybyC4n#GAoaI=**bJ69YV_&whWQDMixP*^9RsEY#1oI69^(z6O1T!zx?1(fxc
zz%u7JD{OQ*3+o1ybxB~Eb0Mpk8+eVnI>rA`m0QQoJdUln^Z4708o|GFY(u@XUf|P}
zMt2cxx#93X{j&_)a2Z#uG<pEDp=rT3#8peZe2?S=mk;$dy#>+vPM?3O68`OOS0%iD
zZ(9{Nl7n5}vtJ%4uenz_*@_>3o}X}X`<=gP|CSckf7p9m|MkY7pS?VAYz(O4HG$XK
zBOPdtKB#HbGre<4dVi98b^Or!8doa8=*r2|tK(>#Ii1rNAL+sR{OQ3@S#w_Bq;h&t
z{9w@ZJNC&1Gn+qFfB)NG`Kt5%^go^1-@MLA^7spNnvYqQ-eIAuWA|D<t46)hrE9L{
zxUW5*;61?8DXpJB8hwQC8?$cKh~Hh-D|4Hz=D?J=S(dBl#uLkO8C(eYrp{y5J0|t8
z)k9y3cQlc7?EP<2I`mq8Yr9-r9JKEAlaF+8?<9Bp?4G0hz31J%Uc))uKbqAC^z-DI
zd%<qU?sq%kL^}RP->tZM4G{fq1{ccJWw+dX@Z{nB2POj_8@<G*f34#IoGtEQRuFuu
F{s$^RBs~BC

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/TPM2.crb-device.tpm2 b/tests/data/acpi/virt/TPM2.crb-device.tpm2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..b2d9268351fcfdc634131e326bfafdd306dc639c 100644
GIT binary patch
literal 76
zcmWFu@HO&bU|?W5<mB({5v<@85#X!<1dKp25F12;fCB>q4~S+55hwtp;-oW32mq=x
B2mt^9

literal 0
HcmV?d00001

-- 
2.41.0


