Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA9E75B038
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTsQ-0006sh-3v; Thu, 20 Jul 2023 09:39:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs8-0006in-5s
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs3-0007XF-MZ
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689860346;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FLlBJjEFiEo+1mQqJQHi3gyipgDK82HCDCJTFSG8xSo=;
 b=gnAmNPDw8wpmMM6rBMsxGIUcnEZ1JfwsQhRum/ZuzKyOYC2P9MVorYJ8y8PK3P3TV/VxTV
 Q3ARUuTGrjh3xqYnA3cyVqrczokYNaWm3OtUe5fuK0JQz8EmsW8MbtjSBK3n/EsjvEbkHU
 4e4FaX9QWL0B8bsHfsBgjYBbcNNUu94=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-336-5aFTZ6A3OfK9GsVY3YPNfQ-1; Thu, 20 Jul 2023 09:39:04 -0400
X-MC-Unique: 5aFTZ6A3OfK9GsVY3YPNfQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 62CBF936D52
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:39:04 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B30704CD0E8;
 Thu, 20 Jul 2023 13:39:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH for-8.1 3/6] tests: acpi: x86: update expected blobs
Date: Thu, 20 Jul 2023 15:38:55 +0200
Message-Id: <20230720133858.1974024-4-imammedo@redhat.com>
In-Reply-To: <20230720133858.1974024-1-imammedo@redhat.com>
References: <20230720133858.1974024-1-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Following change is expected on each PCI slot with enabled
ACPI PCI hotplug

-                            BSEL,
-                            ASUN
+                            Zero,
+                            Zero
                         }
+                    Local0 [Zero] = BSEL /* \_SB_.PCI0.BSEL */
+                    Local0 [One] = ASUN /* \_SB_.PCI0.S18_.ASUN */

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h |  14 --------------
 tests/data/acpi/pc/DSDT                     | Bin 6488 -> 6836 bytes
 tests/data/acpi/pc/DSDT.acpierst            | Bin 6411 -> 6747 bytes
 tests/data/acpi/pc/DSDT.acpihmat            | Bin 7813 -> 8161 bytes
 tests/data/acpi/pc/DSDT.bridge              | Bin 12615 -> 13707 bytes
 tests/data/acpi/pc/DSDT.cphp                | Bin 6952 -> 7300 bytes
 tests/data/acpi/pc/DSDT.dimmpxm             | Bin 8142 -> 8490 bytes
 tests/data/acpi/pc/DSDT.hpbridge            | Bin 6451 -> 6787 bytes
 tests/data/acpi/pc/DSDT.ipmikcs             | Bin 6560 -> 6908 bytes
 tests/data/acpi/pc/DSDT.memhp               | Bin 7847 -> 8195 bytes
 tests/data/acpi/pc/DSDT.nohpet              | Bin 6346 -> 6694 bytes
 tests/data/acpi/pc/DSDT.numamem             | Bin 6494 -> 6842 bytes
 tests/data/acpi/pc/DSDT.roothp              | Bin 9873 -> 10629 bytes
 tests/data/acpi/q35/DSDT.bridge             | Bin 11590 -> 11974 bytes
 tests/data/acpi/q35/DSDT.multi-bridge       | Bin 12770 -> 13214 bytes
 15 files changed, 14 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 1983fa596b..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,15 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpierst",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.hpbridge",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.nohpet",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.roothp",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.multi-bridge",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index 32d255cfc0a207c89bf8459edaca11fad12979e9..3f104cc65c4fcc55616540867ec1ec50a7b9c7fd 100644
GIT binary patch
delta 1639
zcma*ly-vbV6u|LIp@g)BmeSTJAKggU6vBsNv6v8)sMSp^vk3{CiL;5!;%<Baje*U?
z+2~Bd3rON-d;tyjo_NO7ne*d+&q){6SzYl1|9G~+SnT~-nX5{7c^U@o(D0ViFV&Tr
zJvrEFg{jc<k2J>OEae3!eI;&HLO<BoMrJ}{Y%ppEoxSmZvC-<+@gT+~wM=<stDFBe
z0X9L}Yp~dr!OEna3tPi(5^R#RWxXu*<Vjz5Txz{bF?t_i^i7O@M;Ki<_yatHe!zvn
z?_0+ksj#O??)f5Y18<~()kv#ldAEVxG}tt0&xCDaHv=|9+DEY1)xqkd{S~%_T?4E^
z+5?mC+rn-ZY?ibS!fs>N1Z$G^2P}4TU~{D1$?-RP*tNh~q`d=+T^p=T+D~EI*mb}<
zq-|LI(?7T9Pya@YK1CQ^@X=eF{?m%h`-c%muWWu^A5WBrHS^?}AHsI<L<O(~(iR-v
g?O?YEwn*Bcu)EkTfi02t6)bjLur6h%`dU}|0|BpdeE<Le

delta 1309
zcmZ|KzfQt%5Ww+TN>YA>w)77a2vipwT$G65pav`?CIX2C<6u&EHSq~t^bOe5cQA-A
zp%aUVqmGVF>SnlJyyaYfzfZn*_gH_ei69JyM+He*xSxm@P4s5RQP_^m&TRUj`SQv@
z3D=sD8nuFhv?L`YwH1!~BH@&yAnc_tEFrhU&i?%IWW1wS=f1Z3=N0q{>+jH0KZ!oc
z`X9Y250vqek+Zq+hX#CK{_{OGV7qnNPQ_^|JIyp>Pur!?r&xa;`#SXndcpc<^wihT
zYph?+!g+%%fBkh9*4?0726GuU_a6HOt*fKgS-)*Tzd?Niy}|n1*f*(fqBmLpZNYhq
zHh<p8hVh$}voL3|xd-&Lu8rPiz2QK=MSTao!}>Gy)OXRltbcOgyibQeuj;~g-{rrr
zT-a`xw)1eB$4+}gPumsH7g)cQgML8$BKjihZ_rb}gucZ3uN<7`=lS!7c^KcJTp4p^
dHaCfVm)5PIudrVCpx>pwkKX6}^wisve*rUoCENf2

diff --git a/tests/data/acpi/pc/DSDT.acpierst b/tests/data/acpi/pc/DSDT.acpierst
index 33e872b2fae3d974a3dc4ec0401b1f1734db313b..d33cffc67a5dc49694a6c6a57b3f26da1f759bbe 100644
GIT binary patch
delta 1579
zcma*my-LGS6bJCz*p%9&`A!D=wG|YEQa>8Sr6E<J>R{@mkoW>MyWkw?SOj0dUF`$t
z0|;({=%9<x7jPEuJ$S~GIsYI3a}GC??)!QrjKb0B5@QAHzVfOpex1cp5F7iSv$@id
zdP6ztcH(l}506#Gimcp^PL3)?XE_d|Lp8OE5@SgkM1zAYVJ!Xonk5A`4YfA6{=b#M
z%A~y(b`5(=U`wR^*4olgo@%<+qDJiLJR0YSW+Hl*Bl;$y1%n=7#o#yEz#A#Br$X*|
zDeNZRNCm5s_8BbpR>4+D+c5deJ?z!MYNQ>5#a<n(PTEIdee5;B8l*KWKC_R#CRmfS
z=fZAbuLag3?E_fswZYn?U9kDgee89>I;0(e#a<VzOWIpu1MKy{dZhia`481}=%>Hu
z@aRR3=#7Xz<%rHj)O6_qwq1VT5N}k2J!|Bi6JZB<qdM3+X+OYXZv$+Dw5uMUc^7+|
UV4I}90*k#Zur12YUc4RY7pxX!J^%m!

delta 1277
zcmZ|Ky)pw~6vpwjv-#L}ce1<LFZqzrq|vM-Bn3rcV-zID(wW&bXx#ueV1^=G1qzcp
zKu4{RD^PL;#(B>;&C%}u=Knrt*1l|tIEfF8lA_FQJc@Tie>+N(erj*OPCt!ET^?yk
zGfMMmFWxs5MN{&<<Zvi7Zy}A7UGuCc)P6G9`TaPa>=hc|yMI1|KEwJ4>08v#qR+Bk
zSkP}#KZicY`ctc+j<m_O6}a5o7ny5QPRE?i=9X-DewF45^n&#l=&5g@H&{QDevSGj
zdXx2C2hJNi{CT$y%<WLFfVl#j`$kW5E%X-aM@8s&sc)mVS$~h7`VM-B^|}k^t+@Po
zC-V2zKfj+{Sl6R<9=_(WuPu7g(>fo$&-!!e`_vE62dw`<PyG;m$oh^C*QY*z{f!TE
zHz`-bT#3znNgvbPGWs&>hXM3s>Q~TLSbrz|fcjPRRo3T2I4=tM^NvG!ev5K7%+=W3
R6MC9kM_=dsv_8MC{s8n097O;C

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index cd84abc1b1d026e6055057f4c6170146e1921ea6..726741a0f0934fa6504ab451d6374a739f704301 100644
GIT binary patch
delta 1640
zcma*mJxjw-6b9hiv}w~&+9XZVFKL_#f`ebs78FSu3#IB{)JaIhUE&YWO)Rb*1ZTmy
z)Lr}o`U9N06v0_=l-_&rj3;y6C+|7;Cbv7YUDXf#<C())>TaS+x;mJjg@G4p?tE(N
zj?^B?!FnfDLf1bkFqUSD8=M@fX>%p?gM&hBWF*F-*bDadM-gN3;^`<#v2j#xE$qhH
zzs-QnkahwVdu6aPX(f~QZenj1Y?ibESnSP#&5`y=*e&c;z$&Eu0gJtPuzAw<t(G*D
z$CsAvP*?IGqOS>}Um~j6^jo_&AK*Me^xo!o)5bF@!k$HP&rh&;MkTN%(ymr`ZwGrd
zuo`Kv!D6otRwwPduwCpmz#61=s(j`y_LjkxNgE66Vy_9-B<&km?6tsJq%~@MW)FL9
zur_Hgz+!I&Y=yKh!uGJY3bsmGxz1<qVQ&p=jkKqA{^{S;>A&PzL_ZQle?@e;LBDm-
i-~(JGh(0#>o_#!{ChXZH_xuKnXXJo&C_CL=8c2T^#Byc;

delta 1309
zcmZwCO-{m45Ww+TnoybomX?+l+HRDM8$VDnN(@j)Oav02?o8@hS$G9CoPdpb3JE80
zrS3R^A16>Zx;0EE&Stjn{qmogkNr_Yi$ruh3M6S^IMHN7>&;GM(TW#4v#D)_^2$IF
zYxP)-o6(UjNhwKfij%&Uvivv_J^iwv$t}@2oIjq8hh}x|*H{0&f?i?$i&>Qi%J|!~
zO)gip;Ja_}-!~Ra+o0{zI4#Xidry3gwo}ootZx*dU!#5oeTMb-iQlBYhF)X+ZxPN5
zZT`Gt8^&)@PRE?i<|gQA-7NYn>vInDx2c~)pJV+6dg|xV=UM;kz<FN|f8KHl#@8ul
zV9sE3*NNYubqnYVtbapKeG|RO`aKu+X;R-pZ?XQ)h4UU={=A>$JMj2#;lZ>PZRg-L
zhn@D2_%>}<LSJHiwha9?^<DHX>(3J(QQt%FvHqzH*MFAz^Oh<wzC*bR<|=IN3O%js
fqxV_=n)ojD1M~swcYWBWOZ^ai$oc85e<1$>8O|oD

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 69a73ea2a691de387b82bf85a7ba1a2279c01a0c..89b5ee17e156d08168fcc93ab635dfb83d63b335 100644
GIT binary patch
literal 13707
zcmeHO&2QV-5uc|In|hLLN@n6D&WDgq+U^Gu$<8MVw2?^JR&2?NC}+1|P*IW>Rnh=U
zWH-PjMo`6DWW6Z@G*wgd(1SMc-iqW;Xn~%3%W;p}LoYpU(M?Y4&OB10EsH=2<j?>T
zV45@Y_?wS6ocBhgG+nFy<}3jFI=7-O>Z#lZWi^E#1^{$U|K&pH8W?RYw@_ozK!_Rl
zqv9M7IZ1g>%dIZ3Keo(2nC2&+o2+g@<Ei|lQMW$ZG#fyJZZ|B>=|sLH)%0A=*jOAd
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

literal 12615
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

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index 20379056b399bf1ad8b8316453eac344f604d3b6..cb9fc3c524f238f90d9d84d795061fe78a21a6dd 100644
GIT binary patch
delta 1640
zcma*mJ4?e*6bJCzv?(P`+Ps<;`iL%qgT)8-AvmO@O07DWii?mA?$$4$ONWBs(nWAC
zbd}=ZCVm0^0D@aVa2DL8_Z~ds$(;X>|2c=7X>Hh4{J`%GON_;;kIF<-I`i`|Xob2r
zpFL}?RPV~cMk7pxo`0e;7H26hI6YS4_G;({N9w>#NR0Idt)P84>N7T2d>!>;Y#i5D
z7It&}-zLB&NZSL8y)sytv=d>sur~=dN!lNMMe54qis87_diw^CUPg%Ci|9*)=$D8Z
zCOyE8$?v<3H%h~vX>!k7VQY9J6|73y53ty)fz?R6X7QQp*qZ^HA?-C-?9GDBlJ-s5
z2KMS;b<!@`eC7uB8ek35UJ2X8UK6ZI+E=jHYk{>$YvuUN9`@Q`ZPH$V#oip)9BH3~
zZDFqi)*)@u;XhQ>p`ZSlh~7kqPDS)RLiATem-F-h2YG&9A8%BIJ&WX?55l(bMkTN%
k(td-*-ZI!SX?F{J<~{7KfUS`B4lMS%U|q`2J_{Y`58!ojQvd(}

delta 1309
zcmZwCy-vbV6u|LXN>VNqN?S^SKo=z@E^3sIs6(-sm<S|Z+)T=>4!(jPZ@{FxiKB$c
z(MjES0`(2lMOVY=iDx<My}$g=IoIv`h6rUiT&^g}f;|y;hUm?XBiV_}?ri#K`0C0)
zlWVO=kAm<pqbLbQ59Co_B%Ep#%3kK&5^6_w59W`fan7vI{rc*^*U)RMKSNLbB>E)l
zU(LEY(8k}UYjfl4dHC+<`R}VdY_~z%={QYir+uKO?NaDdtlzPqze#<8Ua<ZaJ@wP*
z)2#os;5^^v&l}n>zCk$ya|WB6#J)-EX3=L^pLL+$q<#*4j`gRpZ&BYwZ?gWyf%Co`
z{=B6EjBiuU!koqCF45DvHhP=&@39Z4@1S>BzwN?40rd;$3#`9!;k+l8Kkq00t`+%j
zS%hi3w4I03Ja*axdfKjpzQlUNgMLW;GWs&>Pta4pg1*A~XAiFb^!W1@OEA7mxhm$W
bZ0;iVd$ev1eU0^R=&A3c_c=e^D(|a*dzU5N

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 435496e836939eeb767f1a524dc1471740ad917e..3fcb0a22a3d074ce3e6e6d12eed95d174876ff99 100644
GIT binary patch
delta 1674
zcma*mJ4?e*6u|M@U}~DC4@#Ox+cXGL(8))&oh(VyLaBBzIw_>1V;6T3gl>vm1!u)Y
zI{5`01@Q|gLN~=#L6F{i@QkPX`Q?A^<>skz>#IQ+>@6=a7W=+eyE(NpIgCO-%6gM=
zlyfDiE00ce!(EDka7P>D<|M}Y13zqS5BrP_yl}ra?8n&XMz2gqpJy2T(JQsC9In+P
zCGvt@jWL-i(+{b#PG!1zZr4}-Z5(Wzv{zuUI}diAv>(D&v8#YpNV{e5ovYYQfK8D0
zT-Xils$f;pzJkSW5^R#Rt0v!h6T2E%jkKp=v6}*$BJGQ?HSDIrrb)YK@ttef&4A62
z_E^|DcC%o!q<ysb)Bm*Szr?ipXv3yQkHqN345JTX^lgSwwZQMl!#m2uIrHQ>4}|sc
zjtsB{Y45;d*92>l_E*>@b}g_LX?sO}-X?Z!ur_J0g$=M<09zpK7g+2T!4^sDmH5sr
o?3TcmNP7tuyAD`~wC}>Uv0DaPCT-Q>JGZgxf^{i7K65(KA8fySnE(I)

delta 1292
zcmZ|KOG?8~6vpuw(g(LGO=6PPJaJMLC!(lzR2x!3v__4Oi4Zs7V+HC!-9V?h0SAIq
zH=$Cx15sC@Bk8>d&*XG`fBf(H9-@Ae#c90P4<%{r<B4q;tTQ;u(kRo~gI;EYvYaU0
zE7KnLvpDUj=LVCbw7uC%_qUF_FJ^r<QPTOjteCapT~(44sW^OMib;9H629^8bKrBN
zKNEfd`+4wr(!YbpegS-e^fPvSIB&<M=iQ3u#}UupHea)d*D?5wk-x20g~#hk;7g>x
z7k&x*DtMLjzu>W7245!qVU4f9tkLVAYy8}0%vB&)A#?f!_YFK(1Fw<(6g>8I@H*+=
zgkQnF0p1|}w8Q6ZJM_F8ho9TRoC!IT%zc5!b1m=|>6<R^N7%Q)+oZn(kNqn6D(Qb*
zK5x>a=N)+b`C`O#&*Rs{c%1{kIplAeFFao7f_F)OB77VB9(a%Rui&xogZD{474UgU
WK(D_J__=GC3n3R$x!z~6F8={LI3!;H

diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/pc/DSDT.hpbridge
index b6eafab250d508e1358ea09f81eb1b2a6d96ce32..2cb4310af36c483e62671c9a9eaefef9363e59c7 100644
GIT binary patch
delta 1620
zcma*my-vbV6u|Kdp-|dVX({C!Hxgq^42WRjU~B7wI#Ah6+Ay2Q1Gur^OyUceI7>Qf
zd;uLDTp5hJiJKAcJ;@mlbI-5;b8p(XJ?$!9;9X3sj3s^-%Db9fUWS1i=8u-~mpV@F
zI8xBw4P_@7ohvD8EA)ahZDOX9j71YS@K0wEW0U`<vnavlS9+^ASc!fphmJSY7?YT=
z5^0}=?W}5G(_qu2)i-#zgWU|+3~57Q_pmF2l}Y;u7Q0!nS<)u*eCIB96|f3vhhVX*
zf>lX-FYG>cHLx0KzrkWR2R27q-{9x%VOIyMllIPNB?r>{*|0aMPw-QWZkY6F-{fzN
z))>7Nql-00KTLkk1H7XGoU=flbGyK;gLh<swMcsd7Q02TMbf?s>tfdiYm>HV@ts}l
zmcW)sdoAoScFSPPq<sO4-3r(WX^kS^*~4xXY?ZWQu-L7Et&uhs*2iugY@M_zoA2yn
fw*j_6+L5p)*lmJslJ>#of61Fo{!sCceVF_Mj7@Di

delta 1250
zcmZ|KxlY4C5P)H0tQ?Nx#0Nf54$(wHG$8>JBnoUC4he|FLKn#qPY@cQrv{4jKm$E;
z3$NgY;~h920@xif&7|G^^v}%2a?(;G79F;INt&8}RNo8vbP%&JF0ZG_N8wnW>nW_&
zjB^1y+E*338b@qT8=0ycvfl3B<8XYgH{`xDzSA9x`hL?J3w?#Pe<N`a9cYr2kwh*-
z=2|7;yZ=55K1=#*;g_(V1D_-PH+byl!RJZ8Q|9NLl<D&x#CJO3d)naFtl)MUOw-6|
zL-4p=5qy#K&%$@GuY=b~KWp-RI@m9PFOmMt<k#Pt^!2YI*TtLxIfKkCT73K}u4{rf
zNq+?%`xbbM^k2dU*tfykq~Esrc_W)X@80I?hM038=a4yhMtEG;1@DqR7JdW!9(a%R
zPvEidgZD}AJN&%Bq0c)N-!~J!UmSi-54Wqpv<f+`=?ahARl!$De<}PX_G{p4r2hnu
O{W|zM<&!OMP5uEil^M7I

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index 06aa7bfdeca40e10ee8411eeda08486599b90e39..b0e0922f5e38f01b9eed33d6b7c7d60f81850a20 100644
GIT binary patch
delta 1691
zcma*mzfZzI6u|MLP$+Fdprz%vP9zQ*6%chR6bwNfEXKv8n3%XJ&L++zjx3HY{sBsy
zHO?kZZvF%4?!;iYd-08rx$l$jyUX>yGOeku=k}&K#scj}^;1)wpA+9}_=(Q<c%q$4
z^{(u#Z~2PvxQ9ApL8ds~(SaH?mwngU*9WPP#8`jO@LGGrK4XK~*I_@vM%VH3%x<jx
z+Ys0gY2U$OR|YGSwz$B%73_w=hDmz?7P}F!5z@X0Tg9#dRv~R7!FR4=HwrdN+EZa`
z*j2%*q<sR5T@9>8+F+9Jyop^MtWMe<SnS5Y#z^}hY#qCCuyNA<Cd*P+9+gtoBK3TC
zQ+)Jtj?p_Y`Z~wxM2sd4dVw8--|sfwkpbs4$aCHb>);)kU`^6~fyHhbY?`zyCf~V%
zT??#5+8eOgwZYn?{SdZ^-3-_aX_wM`=O%WuV6&vX64u3T4s4FJZ(y;T2b(9YVey??
n*e!r9koF8Lc8g$(q<t2)jolL15^2LW|DjfG^68I{?T+*ZT)=vq

delta 1292
zcmZ|K%QC}I9LMoUZ<&*{l9M!vUKTbTrW;gEtw^N{GpdN&!c6S!@C4Z40lLNX2^dqJ
zf~CFyHXgxcVS3Jg{5OBwoX>po|NYc^H5NwUW^YVUMymI0ptIIsFOHhA*?#GN=m%=G
zlZ>Vtu@(p6hM_14MGK;>RhDqdaTv9YW6soO)LI#S-0xoIDrzU$z00{a_57Zz40AJ>
zOF=G0=7Le-Yg2!}PlHdB{suhuGvG6%|CW9h`x<zS^t+~*cV^P_9!+s>9ditFjLdOM
zdOTMLuao{r`Z??y;0@A0gU5are3tZ+T+CbN^t=oCeEZMy8y9ODc%2D<Gs(X#+S227
z7I=&F*V4~ppM&S5{{oMF8@x^W9Y?G`b?EgEjyN~KTpn_HGH2z5Z{oQwc$f5t;IZ$4
z_elRF{Sx+l@IL7$TrqFWrRSZy;@l8(1;`c1+$(rIw+OyS`UOw)Ti7pwFOmKVJod}r
Y%cTGG#Jq8zp119b=M(z5-}jf*UpvSo^Z)<=

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 10a0e44d610976cd5f08d53ec32c7d5eda064e1c..61b66fcf9a9ca62436f933c40e116a16686445c7 100644
GIT binary patch
delta 1640
zcma*mJxjw-6b9hiw6P_mA8GSpYuY%Jikn~9b`VWT3#D4Y=%kpAf=d^{SrIyl{Q<hU
zxJW0_S#TEIMd&E{0~G1K2hVsi=Y4qZc_FuJ=NpRWd%MwD#v+gRN?B9d<AcC&1Q~Zc
zs%ef??a2OOEl32ex1%x^WeL~c>nc%wKJff4wV#bijP?2rzqvW+G1i}a9rPk>c$TY7
z?9#%&je(7k_7yDl%3x*EmUZ5{jJ;D}r$~DO7JK7h<D`AoD^f=ue(I(}O=B56x^B?X
zBN4p}5q%KR_YhIV<QuKxMk?H?l6UTd#f_3+lcc>9wu-$euqo31fW_W4*feRo7QeTK
zy&13>(q4nbUJa~9+Am@2*qa5LC9ONn-(1Ju9M~LbuY`56R|l(;_5&>T8ek35uH^Zf
z8`x`tHA#B`7JDtQ7HQw|{D=C@(?8T)fk(Fsbo5k2Z$d<0MD#mEv@pXrYT`yV+-Z|{
k9)rb=ieQVReG;~Xy(O?E(k5;G<`(ukU>(Yi4(+z|2NqUy#sB~S

delta 1308
zcmZ|Ky-vbV6u|LPN+=EAEu}3K7Q^Boe&b+5p`a!riPa6QPoOON0<P*HyNOZ5Y}nL?
zAo>*QOBl{Q@hpe+-e3Oboa^RzTk`||Xk3w`$m6TFkkfk8K^U~cY-c)Y<f`&wUkR2Q
zp&EMrVN#N!lIjJ=2U^r{LqF&xhj~qI1)crb<Jss=ug&~Q{ogC-71sZvr+y55jP<)l
zP3|kBp<(LW_!k4luTn0Kxj37X3*gsiT@}5``Vc+!6X+AH{}6ti`WkwT^|lG;c_x3}
zmH2*`^ZjMQH5;^D3a6#mY4sxbP1-JvKF#`D^wiIw&#?YS_y+Z}=(DWfvEcd(i@*Na
zf_1kjm&aV5%|&eCX<Z$?&iYf~J?b0i4c5P-r+xu_f%TRH=QSPvyh{hxZBed>xgwkU
z6uwRCTIem-FO{I*roN5dX8n!uKJ^{+4(q>5a9*y=pVuwJ_xYUfr!s8Uq3v9p=5o{S
aUEp0>u7bS6@zDu-%2&}>IX`)G_vAl!D<m=i

diff --git a/tests/data/acpi/pc/DSDT.nohpet b/tests/data/acpi/pc/DSDT.nohpet
index 6905312d827502e8bb5852418cf58290eda8d86b..57ccde1618ae08a8f7ad65553387ddcfe26b178b 100644
GIT binary patch
delta 1640
zcma*mJxfAi6bJCftA^h9w*=p75gG~&OA8vVT@|w$x<y05b!gANK+z@yEiOTG(Hhbo
zjV<*7f;J&&4%))!IdsP3eE&cG=Nz8<TDh;ve&FwyGK@urk8)d)JLBUpXoRLW9vvw~
zsn(4Lm3o*6J%3MSEXopIaIh;!-G$H(cGSKdlNjsu8$ok>&||DW`8w!D*zis(P3&^{
z-^RekNc*Feq;7mz&{IXKrmgen=@ii$5q+K_`X!>4K@YHQ@I9+|qa^H^B=@`$b_H)F
zgOy490Tz1|unK7xO+ND~_Nri2(w>9GUJa~9+Bacq*sFupNjqopnQPc<fHg>aCTtyh
zO|T|uU%+Co1=b?1WAmBUu-67_llBBG_Bvo4(mo06VXq6;CGCvEf2bvge)@+ZdND=x
zK}6rDi2jP`yh{(T<?{P(;*HX<XPVseR#+czlmVL|?KfEL&4SI6c4L;$+{E4-*c@rE
j!D4S7Y@W2A!nUxt0JcEda*EH~!rmg-B4tOHsgCpqlh$$f

delta 1309
zcmZ|Ky-or_5Ww;CILNUF$9-{pMJQAn8&QZDZGb~#B9gFLNpiMoV{50rfuYeCuvNkf
zXrqRT7f|0oZL~J*PMl_JcYpcM%x!gCVF3^J##u#~IUBMqgLNkTkT*lCJsBMsC3Uf@
z@k%|^!$#0cC`v@p8+?D4MZDQC;GM*&!_+2k?@S*L2g77}>X(=Pyarw)y=h91{V4b-
z=})9z!F~*UjPx&NS?y|rFVlCabr(`%d=+y#<a9E32_DytgO8K`UHTgK8F)te4NL4(
z!@dFDApMOc&U>`z^M2%a(Wbw-EvBvFb|y?S$!YiCak~`w6zP+W=-07tfwxG13?BP7
zc$@Ukj=28Qq0gIl#rQSMxsY?o+=cWFT-O8dk^T)l_S4|gq+j>MK27ZV;C<3xd*ZwY
zk3R2P=31D`LM}_@dTBAfh3n?P=SY7ieSrNu_&n(ozUT+oFMuzQ{>T^SUHSBRPxAZY
fpYOShn6`=A6=7PDoOTW#w=01!QGWEA*;ao60qQ3j

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 59e31338eeb3a84c39ed3ae63105226ce2ad1125..36bf83259ed7d3cb51e426d83663421ede24d998 100644
GIT binary patch
delta 1674
zcma*mJxjw-6oBE|VrrVCX-u2+yAg+iASkW<5L^;dp;R4=Iti)x2P(QMjzw_l<{xmD
zI&~AA73V_7E)K4a(t8h{@pM1Web2ol)9Sdc_<?^i&NCLdc~K^+(wUuyffpL?Z1kf#
z(P&p18oKSQhkkIV_06RyW4*o?v=0V7#`<n>dNk-o*l<U$%ttR47=6$y&8`$wTcI4f
z{;|fG#N_!wij<}@6Jcvx|276TM%s-e@7A!p40f5cx592?R|YGS_5&<-<6z^Ybqv09
z9lHuxg|vOJ*j2%*q<s^%fn5!(Mp|=)@7%y{0&Ie`m%=u&tAo`^`wAAjNw7)MN+#dA
zg<S)zLE1BufBJVO{g*t8(a!}&f5qr(iaxcI;tO0YF#43@_jK`%EV!pd-t${n58ucJ
zYm;_2&AT3UGhj2MeH3;NyIHVV(oVr*HwQLH+D(h^>|-|%Hc#4nu-GktEs*w0*fw^H
nV2h+(v-!?#?3TcmNP8{pK6cAs%cOk=i(Ln-L)np)=|ukk4#0Sa

delta 1292
zcmZwC$x6du5Ww*m(uFT+vnRC+z4fAkv{dUwXiNmbS}=N0i}4X$o<gsE0rd?^4=yiZ
z?t;rjk3NA5oea)p&hz6xGmqVuwg}^J?|5F4<_;#}SrvnHl*B<|MCtTPZOZac85?EK
zZX{tm&`vEO2XVCBkN0;@#!<PoFjV69a#BqC;jSi0id3A9gyL}i7JcvE=g{X^|C{*^
z_4DZStRLxcPlx&i^aa*G=&jj%?>hgUXTW&f;KvsRZ0pi>0=EfvTZ*2pQ_-ueUoxS;
zLVXRr#`-Jt)GwhgvHsJ9_jHSYFSKC&D&=&{>1^&M^F2D(KyR@A2R-#o^d{?%Y`ABQ
z`WAYN_4hWs_h$3&xeny|lyflWu(@;ebgqluW&Km;1L}L|J=QO}a8E#eAHC1|OBddo
zxcqw`*|_ZS;|&kCg>+pNw^i9~*XZfG8u}XRzcU|EzmC4n`a>V?iKyQ|-(dZn58uD~
V{CiFXa+{QEVy?;Mre~Ec`48DGBwPRh

diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
index 448d596cf413d7e487af114e5c80bc73311d17f9..ca44cca6a3e46777e1e3433512dfd101c1c7bb8b 100644
GIT binary patch
literal 10629
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
MLBr`){ecnx0Z2bYmjD0&

delta 2603
zcmeH}y-wRu6vrLMpy0U9hn)~d!ASsnXqSNaYM~zq2C1kaw3kjrGHWX}>I0yDAP^Hn
zlmR+ad4mAT13;&$55NeBwL{7ykeqwz5z?V6OIH7X_jmtCvW~sYYGu`9-fGR2q`=aV
zdKwPzHUeutEBVo_M(a;FEz3I_^?p73^n?{={E%Pt-e?_G3YFNxtH8U>mkKKs_;V>#
zWN()xbIA8tS^E@M<u22GwqCF5&ckvCy`|_z0TTbMJ90&-U+GDMvc1T-k17fqLtBtv
zt_Dfn56+K^qMZR0!7C(x5dr@=`uhamNAhz~w_Eqi5MB2>kAFt#IA+6XJ4VM<8_G;z
znE_E|fGl$u1AY>RRRyn-{DU}Lzmlb|{}2b=6zVjg(@5PfuKOFOb<cC4n?{{3bULZ~
zW^f*-j|e_O^5+Ijlh4!F&zcZ_z9Zh}@rg;Fjt)ba$5_S?Wel>+N6r^<SX1yO$sZ)Z
zUqpXG@ClOFk}yqWgs%IZ$F(FKUyi`(_8sxFQ7AKyWh_y~BFlUo1m448(}GWv{MjH}
zpL6JTPg0;;KwU=YGNf)V1-j!Dt&6yzTST2LbT+AbZE+r_&k8<E@vWw%%DH*I4F9_Z
mdwcEXlhE613Y*6FtGCzw{VnwN8vZ%m?_R4nEvMCX_vCBofK}4~

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index 9f8a208aaadc167135e59839eefcd5b594c2f28a..a6765cebb6b95b9f192a04a79ac86c7386e35052 100644
GIT binary patch
delta 1812
zcma*myGufG6u|MHdavm9k?+CRO-)S*Q6V2gp>_?*Ea(=26xShWb#RY1ry3lC=AbDe
zXpfwut)=<{f@p9E8nWN-z!{IT=i~SM4m$3Rj}%SU_QrX}Ouk#?EpDG28hX?4tW8GW
z@w(}CR8o^mJCa@~7`BGKzs&+UL(@CXzE3hU*6TO**4D7cSpWaSVb8=y12tXVko7{<
zuo(?)*E#)W#;J*<k7~Nomi6Ma1=K94VkWJBKEo|$EnqFAJr=fvT?wp2+Iz6rmBGrS
zwI(v=wmixwLMnCD12K9!!|1gbeV$?TM~o(t^a7hne&1!hkpk~j$ah|X#Tz-mI!OB|
zY#F;wuujshr1;Kd?7G0ZNP8}91-ovrZqmMk#qJ!~Inovu_|8@Adcb-}dj=M}Ua(%$
zz6e{xt`Dq_w5c@TxrSXoSU+h8!ZxrQ02?6f6Ikp9!3Iei%JBc*YKH#lpNP?m8Acz(
z=*JAB_AFnZn57r!X8C<Jyipk587AL(0~T)-0UIIhudprbM!`l&+gap0x3C)n8zb$N
Yu<O{3gN>8+3oLe3uqtKm>N%_Q2VM%DrvLx|

delta 1427
zcmZ|MxlRIM5WsOD%e8F6AxAi5kz;{1Dxw^A0t*#L;%Z~mHBlQYdo6qh)|XH#;|qud
zy`9G3D=2Ru%uX`R*zWhse`d0ilgW{&>DobW&1SP-J&WII@ATNv+eV->HD~Ev``E0?
z*-S^!D;2}j(hv7+;blY92hw#&bhPzufAQ_iyps#+V2+xG$7pH$(!6E^ZfE(ITv#0n
z`sTce++lIi!TLr<aSR31$V8X8>Gv6Bk*iWpz?{J5X6R{KCweFA_g0|4MST}~7wezU
zQ{Ro=&3aE3&Z}hk^DeV6ew%V$%z4?|o8@b?u83Y_y_|!7jru<HKGxq_zD|7!y~O&@
z9Gqv*^XJv`@O=8uvzdqO8nm4sr}^1wzm{*(b^-JO)(;BMZ&E*qKFIn<%kNM>gg(T2
zw*u#FDE##o3XE@2E{wS_n;WC2btC8_tWOuA-==;PeU$Y#=&2t=A7lMTadF<L#9vn{
z!SoK*;#iBbwUOmD+BShc!TKNc)K8*Mvc6x2eY(_7p--{?p$tFoz09BIQsH@B<)6=0
SnAW51WSk~*(_UUxm+%J~MMH}K

diff --git a/tests/data/acpi/q35/DSDT.multi-bridge b/tests/data/acpi/q35/DSDT.multi-bridge
index 9ae8ee0b41738bd8951b9449abcfc67c293fdce1..15eef675913d2f10173f96ff6fc42b230d0a6618 100644
GIT binary patch
delta 2209
zcmbW(&r2Io5C`zLn{2yoqQ)q#Ka*_MP1L9)8cjr~P28kNG=;tv3Mp*BLp{cWe}M5K
zy|i?%qUTaC;;Bb3y-QD}2(|YX@hB9!d2e9oY1Ctq`RsRQc;xM`&BM2b!=0Ch^NcB>
z6XPNl+M8D1xV-E}-etV&*i-eH?&agw^z$IkW?j9+U)9;br0ejFa4Q;A8Edx6yt2OE
zWUSTsalffBZ#z-!xRZOj*~C5as=D_%k-T%Co^39h7d*G*>Tbz-5ms1$HQMDLV%p9(
z{-^49Z`aJ;?a}9^y|||FY!RO8@0W?~DdhGNNxM+fc+Ow9Xo)dZQbQ$eE141&V*_9V
zq&<^%4s(NGgQSgGB6kjRHLx0KH!XXnr15z;Ud97be6mt%P4mvJM{(*X-pI!CIFt^J
z>10f8Tnv@Rp}N3!k@i5^1<W<T8l?RV7IQ;jL!^CTi=G!THw-pR+V@~Fw;OCXX@5#v
zz}z0NJ*3U0M9&4x?FHLQ+P1Vs%#DDJkoFr`%<Ti)N80hU=y?fqqhO<?-2sca{b2h^
z`!y|&{+~2`^dC=%(v=CibW4_gxJBs~S$cVkQe#r=Xcc!f2y+gSb2h-@j)uSvk@i?x
z2XlwP4wLpTSj-&(J3`v}l$f`Ixual5NqYnqbH~7rk@ia3D(1$(#z<Srh@PvM8wVSw
r?CHnMs`|RF^Z)+j8twImczNobmjnL_t@u|Vv?m`=zC@gwvuA;S!q@uP

delta 1740
zcma)-K~EDw7=~xt#ocUMyHr{TP}<$HYiUbpMX=oHcH2Y&iH=^Z$(ne8qr%+-7nOq^
z_DYEU0~-!<;Xu%<`~X8VB<kI}#&+h@FD9R{$DMid%=^w{XZAPF9~wUQ@0`~dQ}(*X
z*;MSQsoW2^7nm=S;rFTK#EQmi)j$s#{_QvmZ{;(#W;Rt`?Tt0~-J5JA8~A)J{wQTc
zJl<OEk39&pRz0$!g-5wUeo(fZACSGFg{OIY5bw72p4XNjyTYQZv*VqJ<o!0iul8}+
zwW|MDC2Xg(*6UpVy$?)bqP;@4-?W{`x*EQ;Gnc5%d1t%jb(Po97L_(5O6shF;II5S
z1*QV8lKd0k(LV(I5XpZmI95yL^KhcZ1(KSb7AfY@s)1D_`CZ9h#nd|RI>~>VcKe%_
zbm&d<9kKiZ>I~2sr0zBF7&iudjO2exei8j~;Nv9UaYdd*^e2E%ko=)5>V0<Udg;qT
zcMWw(&?QOTmgMUg*96`q`BUK0KMedZ$ybUZ&l37mz^6$5c~R8s7U_Cl<@CiFdb&9y
zR%>9oG^~~;S9>LS57T9U&yf5N;L$${{3yxaD~UW!^p62QM)Ge<qWz~5U2mi;bUy0F
zK{rn79s`eYCxD+I`45tBp??ziNs=#DM4lG<v%qIb{#ixTdsCt7eUZ90>T;mVQMv<f
nwi#LVbpF@B+}T;y@M_lkPf72BzAhgcab5rWxj8tSJC6PW$(@kK

-- 
2.39.3


