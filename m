Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1047275B03D
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 15:40:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMTsp-0007CP-Ii; Thu, 20 Jul 2023 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTsB-0006jN-BA
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1qMTs6-0007ZS-Hh
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 09:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689860349;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S1uk3xXFqYmKgl9hBSUZi3iwI7Rqj2Px1isqU8EHGjU=;
 b=NuIMswD1VE/U1y6LHgxdrkQMmFhniBlllmsZmEMggyc8Uwm9QwG2u13796eBLSIDyJn02G
 cSWMiIG178dCRPB3KOuFaOwIa6KmWDqI+skfReCEpIf/Ckr+tY1nJFyRvikotxcbq4XZbs
 +MBZhFhYjH18NvgDTg7s+yqKxV1ZDBk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-WtGNg9iOM_6cMx5VMCGLIQ-1; Thu, 20 Jul 2023 09:39:07 -0400
X-MC-Unique: WtGNg9iOM_6cMx5VMCGLIQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C5F01381D1E5
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 13:39:06 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq2.redhat.com
 (dell-r430-03.lab.eng.brq2.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2329D4CD0E3;
 Thu, 20 Jul 2023 13:39:06 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: mst@redhat.com,
	anisinha@redhat.com
Subject: [PATCH for-8.1 6/6] tests: acpi: update expected blobs
Date: Thu, 20 Jul 2023 15:38:58 +0200
Message-Id: <20230720133858.1974024-7-imammedo@redhat.com>
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

Expected change is that _ADR object is removed from
hostbridge descriptor in DSDT for PC and Q35 machines.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 tests/qtest/bios-tables-test-allowed-diff.h   |  37 ------------------
 tests/data/acpi/pc/DSDT                       | Bin 6836 -> 6830 bytes
 tests/data/acpi/pc/DSDT.acpierst              | Bin 6747 -> 6741 bytes
 tests/data/acpi/pc/DSDT.acpihmat              | Bin 8161 -> 8155 bytes
 tests/data/acpi/pc/DSDT.bridge                | Bin 13707 -> 13701 bytes
 tests/data/acpi/pc/DSDT.cphp                  | Bin 7300 -> 7294 bytes
 tests/data/acpi/pc/DSDT.dimmpxm               | Bin 8490 -> 8484 bytes
 tests/data/acpi/pc/DSDT.hpbridge              | Bin 6787 -> 6781 bytes
 tests/data/acpi/pc/DSDT.hpbrroot              | Bin 3343 -> 3337 bytes
 tests/data/acpi/pc/DSDT.ipmikcs               | Bin 6908 -> 6902 bytes
 tests/data/acpi/pc/DSDT.memhp                 | Bin 8195 -> 8189 bytes
 tests/data/acpi/pc/DSDT.nohpet                | Bin 6694 -> 6688 bytes
 tests/data/acpi/pc/DSDT.numamem               | Bin 6842 -> 6836 bytes
 tests/data/acpi/pc/DSDT.roothp                | Bin 10629 -> 10623 bytes
 tests/data/acpi/q35/DSDT                      | Bin 8361 -> 8355 bytes
 tests/data/acpi/q35/DSDT.acpierst             | Bin 8378 -> 8372 bytes
 tests/data/acpi/q35/DSDT.acpihmat             | Bin 9686 -> 9680 bytes
 tests/data/acpi/q35/DSDT.acpihmat-noinitiator | Bin 8640 -> 8634 bytes
 tests/data/acpi/q35/DSDT.applesmc             | Bin 8407 -> 8401 bytes
 tests/data/acpi/q35/DSDT.bridge               | Bin 11974 -> 11968 bytes
 tests/data/acpi/q35/DSDT.core-count2          | Bin 32501 -> 32495 bytes
 tests/data/acpi/q35/DSDT.cphp                 | Bin 8825 -> 8819 bytes
 tests/data/acpi/q35/DSDT.cxl                  | Bin 9673 -> 9655 bytes
 tests/data/acpi/q35/DSDT.dimmpxm              | Bin 10015 -> 10009 bytes
 tests/data/acpi/q35/DSDT.ipmibt               | Bin 8436 -> 8430 bytes
 tests/data/acpi/q35/DSDT.ipmismbus            | Bin 8449 -> 8443 bytes
 tests/data/acpi/q35/DSDT.ivrs                 | Bin 8378 -> 8372 bytes
 tests/data/acpi/q35/DSDT.memhp                | Bin 9720 -> 9714 bytes
 tests/data/acpi/q35/DSDT.mmio64               | Bin 9491 -> 9485 bytes
 tests/data/acpi/q35/DSDT.multi-bridge         | Bin 13214 -> 13208 bytes
 tests/data/acpi/q35/DSDT.noacpihp             | Bin 8241 -> 8235 bytes
 tests/data/acpi/q35/DSDT.nohpet               | Bin 8219 -> 8213 bytes
 tests/data/acpi/q35/DSDT.numamem              | Bin 8367 -> 8361 bytes
 tests/data/acpi/q35/DSDT.pvpanic-isa          | Bin 8462 -> 8456 bytes
 tests/data/acpi/q35/DSDT.tis.tpm12            | Bin 8967 -> 8961 bytes
 tests/data/acpi/q35/DSDT.tis.tpm2             | Bin 8993 -> 8987 bytes
 tests/data/acpi/q35/DSDT.viot                 | Bin 9470 -> 9464 bytes
 tests/data/acpi/q35/DSDT.xapic                | Bin 35724 -> 35718 bytes
 38 files changed, 37 deletions(-)

diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
index 8911b10650..dfb8523c8b 100644
--- a/tests/qtest/bios-tables-test-allowed-diff.h
+++ b/tests/qtest/bios-tables-test-allowed-diff.h
@@ -1,38 +1 @@
 /* List of comma-separated changed AML files to ignore */
-"tests/data/acpi/pc/DSDT",
-"tests/data/acpi/pc/DSDT.acpierst",
-"tests/data/acpi/pc/DSDT.acpihmat",
-"tests/data/acpi/pc/DSDT.bridge",
-"tests/data/acpi/pc/DSDT.cphp",
-"tests/data/acpi/pc/DSDT.dimmpxm",
-"tests/data/acpi/pc/DSDT.hpbridge",
-"tests/data/acpi/pc/DSDT.hpbrroot",
-"tests/data/acpi/pc/DSDT.ipmikcs",
-"tests/data/acpi/pc/DSDT.memhp",
-"tests/data/acpi/pc/DSDT.nohpet",
-"tests/data/acpi/pc/DSDT.numamem",
-"tests/data/acpi/pc/DSDT.roothp",
-"tests/data/acpi/q35/DSDT",
-"tests/data/acpi/q35/DSDT.acpierst",
-"tests/data/acpi/q35/DSDT.acpihmat",
-"tests/data/acpi/q35/DSDT.acpihmat-noinitiator",
-"tests/data/acpi/q35/DSDT.applesmc",
-"tests/data/acpi/q35/DSDT.bridge",
-"tests/data/acpi/q35/DSDT.core-count2",
-"tests/data/acpi/q35/DSDT.cphp",
-"tests/data/acpi/q35/DSDT.cxl",
-"tests/data/acpi/q35/DSDT.dimmpxm",
-"tests/data/acpi/q35/DSDT.ipmibt",
-"tests/data/acpi/q35/DSDT.ipmismbus",
-"tests/data/acpi/q35/DSDT.ivrs",
-"tests/data/acpi/q35/DSDT.memhp",
-"tests/data/acpi/q35/DSDT.mmio64",
-"tests/data/acpi/q35/DSDT.multi-bridge",
-"tests/data/acpi/q35/DSDT.noacpihp",
-"tests/data/acpi/q35/DSDT.nohpet",
-"tests/data/acpi/q35/DSDT.numamem",
-"tests/data/acpi/q35/DSDT.pvpanic-isa",
-"tests/data/acpi/q35/DSDT.tis.tpm12",
-"tests/data/acpi/q35/DSDT.tis.tpm2",
-"tests/data/acpi/q35/DSDT.viot",
-"tests/data/acpi/q35/DSDT.xapic",
diff --git a/tests/data/acpi/pc/DSDT b/tests/data/acpi/pc/DSDT
index 3f104cc65c4fcc55616540867ec1ec50a7b9c7fd..c93ad6b7f83a168a1833d7dba1112dd2ab8a431f 100644
GIT binary patch
delta 47
zcmdmDy3Ul#CD<ioofHEDBlkqER0%Kk_+Y2_=q4xj0B27Fj(87G7aqq8T+ADL)ujM4
Cu?(#M

delta 53
zcmZ2yy2X^sCD<ioixdL`<Ee>Usd5e+@xe~<(M=xg0nVNV9Pu8WE<BDGxR^QO9bJML
JHnyuv0RWzQ4y^zH

diff --git a/tests/data/acpi/pc/DSDT.acpierst b/tests/data/acpi/pc/DSDT.acpierst
index d33cffc67a5dc49694a6c6a57b3f26da1f759bbe..f643fa2d034053fa07f74f095565b64f021d4290 100644
GIT binary patch
delta 47
zcmca@a@B;(CD<h-REmLtF?b?Zs)QGNe6Uk|bdwW%fU~CoN4$rp3y<RkF6NEB=Oh6>
Cx($v1

delta 53
zcmca=a@&N<CD<h-T8e>zQD`Dps+<Eye6Uk|bdv{rfU~CoN4$rp3y<RkE@qB+N0%Um
IjqT?o0fXfZjsO4v

diff --git a/tests/data/acpi/pc/DSDT.acpihmat b/tests/data/acpi/pc/DSDT.acpihmat
index 726741a0f0934fa6504ab451d6374a739f704301..9d3695ff289036856886a093733926667a32a058 100644
GIT binary patch
delta 47
zcmaE8f7_nRCD<k8wmbs^<B5q}sS;l7@xe~<(M?Y50nVNV9Pu8WE<BDGxR^KghR6c|
DXM_$s

delta 53
zcmca@|InVxCD<k8p*#ZvWBWv|R5=HZ_+Y2_=q3;L0B27Fj(87G7aqq8T+AHtjxIqA
I8{0$V0keA#JOBUy

diff --git a/tests/data/acpi/pc/DSDT.bridge b/tests/data/acpi/pc/DSDT.bridge
index 89b5ee17e156d08168fcc93ab635dfb83d63b335..840b45f354ac14c858d0af8fbd31e97949a65d4b 100644
GIT binary patch
delta 47
zcmeCqZq4R$33dr-HDzF6l$^+wD&fT*AM6w#-Q>g`;OuF@5%1yY!sB>>i+N-3KNA2s
CSPi%U

delta 53
zcmZq8?#||N33dtTHf3O7yfKk0RnCDUKG-Qfy2*n*z}eG)Bi_T)g~#y%7c)n^qe~FO
I#`b?E0HnPSxBvhE

diff --git a/tests/data/acpi/pc/DSDT.cphp b/tests/data/acpi/pc/DSDT.cphp
index cb9fc3c524f238f90d9d84d795061fe78a21a6dd..dbc0141b2bbc77a6d806ff046dc137992c59a899 100644
GIT binary patch
delta 47
zcmZp%{Aa=C66_LEC&R$Nm_Ly#Rl<usKG-Qfy2*(>z}eG)Bi_T)g~#y%7xTv6@6rH4
C+zs0R

delta 53
zcmexo(PGKv66_MvBE!JIs5g--RnCDUKG-Qfy2*n*z}eG)Bi_T)g~#y%7c)n^qe~FO
I#`f>h0Ep2J+W-In

diff --git a/tests/data/acpi/pc/DSDT.dimmpxm b/tests/data/acpi/pc/DSDT.dimmpxm
index 3fcb0a22a3d074ce3e6e6d12eed95d174876ff99..1294f655d418dbdccc095e0d47ab220869a61a07 100644
GIT binary patch
delta 47
zcmZ4Gw8V+aCD<iIMUjDl(P|=Bs)QGNe6Uk|bdwW%fU~CoN4$rp3y<RkF6NEBa}@w6
CGYs1R

delta 53
zcmZ4Dw91LgCD<iIOOb(r@#jRYR5=HZ_+Y2_=q3;L0B27Fj(87G7aqq8T+AHtjxIqA
J8{6k9005CF4%+|#

diff --git a/tests/data/acpi/pc/DSDT.hpbridge b/tests/data/acpi/pc/DSDT.hpbridge
index 2cb4310af36c483e62671c9a9eaefef9363e59c7..8012b5eb3155377dc7995b73059ecb267d19232c 100644
GIT binary patch
delta 47
zcmZoR{cFPI66_LEE5*RTXg`rFRl<usKG-Qfy2*(>z}eG)Bi_T)g~#y%7xTv6Z;}8x
CbPbyT

delta 53
zcmexs(rn7*66_MvEXBaU_-`Uts+<Eye6Uk|bdv{rfU~CoN4$rp3y<RkE@qB+N0%Um
IjqTqg0j2v7n*aa+

diff --git a/tests/data/acpi/pc/DSDT.hpbrroot b/tests/data/acpi/pc/DSDT.hpbrroot
index a4073f36d686201296455e142e3bcbb2f368bbd2..4fa0c6fe720f7859f0541b82f828c0329a3c0548 100644
GIT binary patch
delta 47
zcmeB|>XhPg33dtL<Yi!B)SJkaD&fT*AM6w#-Q>g`;OuF@5%1yY!sB>>i+N*j6Au6f
CvkU70

delta 53
zcmeB_>X+hj33dtL=Vf4Ed^?dVRnCDUKG-Qfy2*n*z}eG)Bi_T)g~#y%7c)n^qe~FO
I#`Y#20Bj-+>i_@%

diff --git a/tests/data/acpi/pc/DSDT.ipmikcs b/tests/data/acpi/pc/DSDT.ipmikcs
index b0e0922f5e38f01b9eed33d6b7c7d60f81850a20..0a891baf458abee4a772ffba7a31914ec22418ec 100644
GIT binary patch
delta 47
zcmexk`puNfCD<k8n-l{BWBWv|R0%Kk_+Y2_=q4xj0B27Fj(87G7aqq8T+ADL^Q8c2
C%??Qb

delta 53
zcmexn`p1;ZCD<k8j}!v~quWHTR5=HZ_+Y2_=q3;L0B27Fj(87G7aqq8T+AHtjxIqA
I8{6}x0JM$|NdN!<

diff --git a/tests/data/acpi/pc/DSDT.memhp b/tests/data/acpi/pc/DSDT.memhp
index 61b66fcf9a9ca62436f933c40e116a16686445c7..9b442a64cf711b33d80691fe84f1d3a6256f943b 100644
GIT binary patch
delta 47
zcmZp6_-oJQ66_N4SDt}^@$W>gR0%Kk_+Y2_=q4xj0B27Fj(87G7aqq8T+ADL%j5xQ
Cj}CeO

delta 53
zcmexs-|WEU66_MftiZs)xO*a3s+<Eye6Uk|bdv{rfU~CoN4$rp3y<RkE@qB+N0%Um
IjqPRf0E#dUdH?_b

diff --git a/tests/data/acpi/pc/DSDT.nohpet b/tests/data/acpi/pc/DSDT.nohpet
index 57ccde1618ae08a8f7ad65553387ddcfe26b178b..1754c6878839fc657230e1e714cd7c5142e0a77e 100644
GIT binary patch
delta 47
zcmZ2xvcQDPCD<iIL5hKa@ybN5R0%Kk_+Y2_=q4xj0B27Fj(87G7aqq8T+ADLXG#J9
DGzSek

delta 53
zcmZ2rvdo0bCD<iIO^Shmaq>j2R5=HZ_+Y2_=q3;L0B27Fj(87G7aqq8T+AHtjxIqA
J8{20}0swe^4m$t<

diff --git a/tests/data/acpi/pc/DSDT.numamem b/tests/data/acpi/pc/DSDT.numamem
index 36bf83259ed7d3cb51e426d83663421ede24d998..9fc731d3d2bcde5e2612a8ccd81e12098134afe9 100644
GIT binary patch
delta 47
zcmdmGy2X^sCD<ioixdL`<JO5>sS;l7@xe~<(M?Y50nVNV9Pu8WE<BDGxR^Kg>Pi6s
DOtTGd

delta 53
zcmdmDy33TyCD<iomlOj7W64CWR5=HZ_+Y2_=q3;L0B27Fj(87G7aqq8T+AHtjxIqA
I8{2iI0F>koZvX%Q

diff --git a/tests/data/acpi/pc/DSDT.roothp b/tests/data/acpi/pc/DSDT.roothp
index ca44cca6a3e46777e1e3433512dfd101c1c7bb8b..e654c83ebe40c413b204c711adcefe3f04655e8c 100644
GIT binary patch
delta 47
zcmZn-{vX8U66_LEugSo`IDH~ls)QGNe6Uk|bdwW%fU~CoN4$rp3y<RkF6NEBKQsVR
CnhsR}

delta 53
zcmew#)Edm?66_Mvs>#5>7&ehBRnCDUKG-Qfy2*n*z}eG)Bi_T)g~#y%7c)n^qe~FO
I#`Yf?0Gt;ORR910

diff --git a/tests/data/acpi/q35/DSDT b/tests/data/acpi/q35/DSDT
index 720e8cbbbb10d86a458027b5cb47884bf8c5ee78..fb89ae0ac6d4346e33156e9e4d3718698a0a1a8e 100644
GIT binary patch
delta 57
zcmZ4KxY&`)CD<iou>u1FqxnRxR3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_2)|0LDuXT>t<8

delta 63
zcmZ4NxYCi!CD<ior2+#3<F|=isTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-g%kiuF%ew=

diff --git a/tests/data/acpi/q35/DSDT.acpierst b/tests/data/acpi/q35/DSDT.acpierst
index f26b1f2a19529c508d53ed3f434be0083c18dbab..46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b 100644
GIT binary patch
delta 57
zcmdnxxW$pnCD<ioivj}!<MoMLsY>3$@xe~<(M_KG0nVNV9Pu8WE<BDGxHvfCogpmd
IjnkDC0PF1#K>z>%

delta 63
zcmdnuxXY2tCD<iomjVL=<FtufsTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-l@$O&#SuXO

diff --git a/tests/data/acpi/q35/DSDT.acpihmat b/tests/data/acpi/q35/DSDT.acpihmat
index 86771f17466a85e3c938e86d1a5c6cee7c0ec4b6..61c5bd52a42242e85090934e8e45bf01642609d6 100644
GIT binary patch
delta 57
zcmccSeZiZ{CD<k8f+_<8<ClqCsY>3$@xe~<(M_KG0nVNV9Pu8WE<BDGxHvfCogpmd
IjnnN_0SC_z>;M1&

delta 63
zcmccMea)N8CD<k8nkoYW<K~H6sTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-?NtF`)Di3e

diff --git a/tests/data/acpi/q35/DSDT.acpihmat-noinitiator b/tests/data/acpi/q35/DSDT.acpihmat-noinitiator
index a894a2d16c81fff8ade2c5ddb20858a03169fd47..3aaa2bbdf54a0d0cade14421e84c6ec5a42f96fa 100644
GIT binary patch
delta 57
zcmX@$yvv!(CD<iomm&iL<KBr}sY>3$@xe~<(M_KG0nVNV9Pu8WE<BDGxHvfCogpmd
Ijng$10qkcGMF0Q*

delta 63
zcmdnxe88E@CD<k8fFc6}W6eaaR1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
ON4%p;5W~ianu-8JEfGZk

diff --git a/tests/data/acpi/q35/DSDT.applesmc b/tests/data/acpi/q35/DSDT.applesmc
index 276ae1df511346ccd286216c6de03cd56db410fd..944209adeaa5bbb722431161c404cb51b8209993 100644
GIT binary patch
delta 57
zcmccac+ru|CD<k8q5=a0qxwXyR3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_0|U0N}R}1poj5

delta 63
zcmccUc-@i9CD<k8x&i|O<FkoesTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-9TWg&c@hNx

diff --git a/tests/data/acpi/q35/DSDT.bridge b/tests/data/acpi/q35/DSDT.bridge
index a6765cebb6b95b9f192a04a79ac86c7386e35052..d9938dba8fa5d405f7696c0dbdc24f3ae42ec934 100644
GIT binary patch
delta 57
zcmX>Wdmxs}CD<k8fF1(_WAH?-R3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_9Tc0PFz}K>z>%

delta 63
zcmX>Qdn}gACD<k8m>vTIqtHaIR1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
ON4%p;5W~ia`g#CDJrO|w

diff --git a/tests/data/acpi/q35/DSDT.core-count2 b/tests/data/acpi/q35/DSDT.core-count2
index 2ec11fe3c36d635080af05afa32852fcc1bf10be..b47891ec10be131a59bf404242241c054ac902f8 100644
GIT binary patch
delta 59
zcmezRm+}2yMlP3Nmyq{$3=E7x6S-2AyoKX~o#LaLJoy8hJq<YGJv?1_94~NjaKt-9
LSj-!z$JGG<W26$^

delta 65
zcmaF=m+|XgMlP3NmyoY@3=E8d6S-0~97W=To#LaL{P_c%Jq<YGJv?1_94~NjaKt-9
RSj-&pjxIqA8z;uq0RYB-6W#y-

diff --git a/tests/data/acpi/q35/DSDT.cphp b/tests/data/acpi/q35/DSDT.cphp
index 612c85b1b4c8e4cc642734b1d52f5d5e1e2ec4eb..20955d0aa30120553da35d5a6640055d26255cf9 100644
GIT binary patch
delta 57
zcmezA^4W#UCD<jTSc!pwarQ*6R3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_5j~0rX%I3IG5A

delta 63
zcmezD^3#ROCD<jTQi*|qF=`@Ls)nOTe6Uk|bdx`SfU~CoN4$rp3y<RkE)I@(X9$a#
OBi_*^h+*TzM~VPTZW0Or

diff --git a/tests/data/acpi/q35/DSDT.cxl b/tests/data/acpi/q35/DSDT.cxl
index f049f414f0e789324e82916cfd0aa955211408c4..ee16a861c2de7b7caaf11d91c50fcdf308815233 100644
GIT binary patch
delta 101
zcmX@<z1^G3CD<ioyD9?%qu)fXR3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
l#_2sWTz<+i5OuDTb!AOAua#fTI9XUe6j{7T9waWq1_0uY9y9;|

delta 120
zcmdn)ebSrDCD<k8q$&dgWA{X^R1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
vN4%p;5W~iaJu+M_Dlrh%-jmg3O<BPbo1<kJnUH1D<PkD!7&p5q7P0^U3l<^E

diff --git a/tests/data/acpi/q35/DSDT.dimmpxm b/tests/data/acpi/q35/DSDT.dimmpxm
index 23dabeacb06b3ad4360c1ca142c06a173f82ff51..228374b55bd544116e359f659e546fc66cf8a895 100644
GIT binary patch
delta 57
zcmbR5H`9;HCD<iIQk{W;F>NAOs*<;Ge6Uk|bdx84fU~CoN4$rp3y<RkE)I@(X9$aV
I<Ma+S0Jp&pivR!s

delta 63
zcmbQ~H{XxTCD<iIUY&t~QFS6$s)nOTe6Uk|bdx`SfU~CoN4$rp3y<RkE)I@(X9$a#
OBi_*^h+*Tz4mAJ=(-4aQ

diff --git a/tests/data/acpi/q35/DSDT.ipmibt b/tests/data/acpi/q35/DSDT.ipmibt
index 541bb70522e72dd477f72cba2f71a336f6978de4..45f911ada5645f158f3d6c0c430ec1d52cadc5d8 100644
GIT binary patch
delta 57
zcmez3_|B2bCD<k8odN>`WA;R@R3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_6#N0RDXty#N3J

delta 63
zcmaFo_{EXSCD<k8ivj}!qt-;OR1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
ON4%p;5W~iau?hfI;Ss$6

diff --git a/tests/data/acpi/q35/DSDT.ipmismbus b/tests/data/acpi/q35/DSDT.ipmismbus
index e2d57a331873ada2fcbcdc1f0f7a244f235d7447..e5d6811bee1233d74236453c49060390d74d4416 100644
GIT binary patch
delta 57
zcmZp4`t8W&66_N4TY-Ur@y<l9R3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_3rK0R3tZ;{X5v

delta 63
zcmezE*yzON66_MfsK~&;IBOzTs)nOTe6Uk|bdx`SfU~CoN4$rp3y<RkE)I@(X9$a#
OBi_*^h+*TzECm1|W)R~5

diff --git a/tests/data/acpi/q35/DSDT.ivrs b/tests/data/acpi/q35/DSDT.ivrs
index f26b1f2a19529c508d53ed3f434be0083c18dbab..46fd25400b7c00ee9149ddb64cb5d5bd73f6a82b 100644
GIT binary patch
delta 57
zcmdnxxW$pnCD<ioivj}!<MoMLsY>3$@xe~<(M_KG0nVNV9Pu8WE<BDGxHvfCogpmd
IjnkDC0PF1#K>z>%

delta 63
zcmdnuxXY2tCD<iomjVL=<FtufsTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-l@$O&#SuXO

diff --git a/tests/data/acpi/q35/DSDT.memhp b/tests/data/acpi/q35/DSDT.memhp
index 809d7e2f0fc15351abc99031a118b4012822deea..5ce081187a578ba7145a9ba20d30be36c13b7663 100644
GIT binary patch
delta 57
zcmez2{mGllCD<k8lPUuPqvk}eR3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_5Tw0Q)NtsQ>@~

delta 63
zcmez5{llBfCD<k8hbjXD<BN%0sTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-6IB6&;S#9;

diff --git a/tests/data/acpi/q35/DSDT.mmio64 b/tests/data/acpi/q35/DSDT.mmio64
index ab3fe3c1b56a35d1312779412978cc1d51f05d33..8459b82c958b842cd7b92c2145977634fb9c6e5d 100644
GIT binary patch
delta 57
zcmbR2)$7IO66_MftIEK@_+%nis*<;Ge6Uk|bdx84fU~CoN4$rp3y<RkE)I@(X9$aV
I<MbL80K+>E%>V!Z

delta 63
zcmeD6n(W2p66_KptjfT^xOgI0s)nOTe6Uk|bdx`SfU~CoN4$rp3y<RkE)I@(X9$a#
OBi_*^h+*Tz8WjK)EfCEB

diff --git a/tests/data/acpi/q35/DSDT.multi-bridge b/tests/data/acpi/q35/DSDT.multi-bridge
index 15eef675913d2f10173f96ff6fc42b230d0a6618..1db43a69e4c2affd8bd678bbef4d3c228380288e 100644
GIT binary patch
delta 57
zcmbQ2J|msWCD<iohA{&Jqt8UHR3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_8<F0M@_{xBvhE

delta 63
zcmbP{J};fiCD<ioo-qRhBlkqER1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
ON4%p;5W~ia?8X2pm=L%C

diff --git a/tests/data/acpi/q35/DSDT.noacpihp b/tests/data/acpi/q35/DSDT.noacpihp
index 8cab2f8eb9ae94e0165f3f17857ec7d080fb0e13..8bc16887e1c963c61aaecf71712a09c0554f6d67 100644
GIT binary patch
delta 57
zcmdn!u-bvkCD<iITY-Ur@zg}FR3&fW_+Y2_=q6A80B27Fj(87G7aqq8TpS$n&JY&!
I#_6-<0nD8c4FCWD

delta 63
zcmZ4Ou+f3bCD<jzP=SGgv2!9<s)nOTe6Uk|bdx`SfU~CoN4$rp3y<RkE)I@(X9$a#
OBi_*^h+*TzS@HlMc@Yf&

diff --git a/tests/data/acpi/q35/DSDT.nohpet b/tests/data/acpi/q35/DSDT.nohpet
index becb5f7cad68361463b30be80095ab10966d7c88..c13e45e3612646cc2e30f00b3b7e53335da816ea 100644
GIT binary patch
delta 57
zcmbR3Fx7#}CD<iIRDpqkkzpcNs*<;Ge6Uk|bdx84fU~CoN4$rp3y<RkE)I@(X9$aV
I<MbAJ0Gz`P>i_@%

delta 63
zcmbR0Fx!F4CD<iIT7iLqasNcFR1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
ON4%p;5W~iaE%E>wR}kv}

diff --git a/tests/data/acpi/q35/DSDT.numamem b/tests/data/acpi/q35/DSDT.numamem
index 0cdec0b4c53b2b0e38cd019caab552f66f7728e7..ba6669437e65952f24516ded954b33fe54bdedfb 100644
GIT binary patch
delta 57
zcmZ4QxYCi!CD<ior2+#3<HLzusY>3$@xe~<(M_KG0nVNV9Pu8WE<BDGxHvfCogpmd
IjngF*0Oq9-9{>OV

delta 63
zcmZ4KxZaV=CD<ioy#fOR<ARA?sTz(V@xe~<(M|sR0nVNV9Pu8WE<BDGxHvfCogpk{
Oj(A6xAcl<-B@_TW^AR5a

diff --git a/tests/data/acpi/q35/DSDT.pvpanic-isa b/tests/data/acpi/q35/DSDT.pvpanic-isa
index 6a9904ec947e373520e0135a89c559cb4f57fa7d..6ad42873e91c80cef5a42224cb4d31936dad59b4 100644
GIT binary patch
delta 57
zcmeBk>Tu$633dtLP-I|Wd^wRTRmod8KG-Qfy2+D2z}eG)Bi_T)g~#y%7Y9eYGla#w
IaeBD|0KB*lrT_o{

delta 63
zcmeBh>T}|933dtLQ)FOZTrrU=Rl`vvKG-Qfy2+nEz}eG)Bi_T)g~#y%7Y9eYGla#=
O5%1^{#ISK<xdH$U_7J83

diff --git a/tests/data/acpi/q35/DSDT.tis.tpm12 b/tests/data/acpi/q35/DSDT.tis.tpm12
index 628bf628f6891f906bf872f8916692ba0ccb6877..e381ce4cbf2b11f56a2d0537db4d21acc97450c9 100644
GIT binary patch
delta 57
zcmZp7Yjops33dr#RAyjcOrOY=s^l#kAM6w#-Q>w1;OuF@5%1yY!sB>>i-RNH8Ny=T
IIK4m#0Hll$6aWAK

delta 63
zcmZp4Yj@*v33dr#S7u;fRGY|^s^KUSAM6w#-Q>?7;OuF@5%1yY!sB>>i-RNH8Ny=b
Oh<9`eV%RvbKnVcyZ4eXy

diff --git a/tests/data/acpi/q35/DSDT.tis.tpm2 b/tests/data/acpi/q35/DSDT.tis.tpm2
index 35c6b08068d4d2fb0353802dc2460cc2912c129c..a09253042ce4a715922027245de8a2ab7449c5b7 100644
GIT binary patch
delta 57
zcmZ4JHrtKMCD<iITA6`?QE?(ys*<;Ge6Uk|bdx84fU~CoN4$rp3y<RkE)I@(X9$aV
I<Mb{i0I5C?HUIzs

delta 63
zcmbR3w$P2sCD<iIQJH~(@xer{R1HUw_+Y2_=q7*u0B27Fj(87G7aqq8TpS$n&JY$e
ON4%p;5W~iaT}l8bUJ*6`

diff --git a/tests/data/acpi/q35/DSDT.viot b/tests/data/acpi/q35/DSDT.viot
index 3ad4d26b7f5c183fd3e146b67ebb23662b5108eb..64e81f571120e3eb2b8c6c9545293a78c75b7bbd 100644
GIT binary patch
delta 51
zcmez8`NNaTCD<k8hYAA&<CBS8sl498@xe~<(M_KG0nVP2?PW#TIO0P+T^J^>mvh{B
HPeBC$z1a|1

delta 48
zcmez2`OlNfCD<k8p9%v5<Kl^2seFzi@xe~<(M|sR0nVNVlRwCduyMpYx&$$7oS3cx
E0F6TrOaK4?

diff --git a/tests/data/acpi/q35/DSDT.xapic b/tests/data/acpi/q35/DSDT.xapic
index d4a34e23512c295f73abbe5ef1370fac7a1a06cd..d4acd851c62c956436a436f9fa6d08fc5f370fa7 100644
GIT binary patch
delta 59
zcmeB~&eS%YiOVI}C8VvJfr0VuM6OgNZ{hf0r}*e5PyPUBPXms44^I~!#|vB>9P!Q&
K7W2mGU%LPi*b*cF

delta 65
zcmZph&eSuViOVI}C8VdDfq`+&M6Of~N0Inor}*e5fBpbxPXms44^I~!#|vB>9P!Q&
Q7Bfe@qe~FO#))6M0BnU5Bme*a

-- 
2.39.3


