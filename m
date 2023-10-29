Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 464B67DAB09
	for <lists+qemu-devel@lfdr.de>; Sun, 29 Oct 2023 07:06:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwyul-0002KB-Tu; Sun, 29 Oct 2023 02:04:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyud-0002Il-5m
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:39 -0400
Received: from mail-pf1-f175.google.com ([209.85.210.175])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <osy86dev@gmail.com>)
 id 1qwyub-0001t3-87
 for qemu-devel@nongnu.org; Sun, 29 Oct 2023 02:04:38 -0400
Received: by mail-pf1-f175.google.com with SMTP id
 d2e1a72fcca58-6be840283ceso3143284b3a.3
 for <qemu-devel@nongnu.org>; Sat, 28 Oct 2023 23:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698559474; x=1699164274;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KbcInts6uJjUbWdfAwLSHERZRGkdHynJLINGdCPwRNY=;
 b=R2sXiPotWGB4UnazcYLK+ImNUt0ea/HiZl2SGTDR6gsxyLzMVLKUiqhB4cqouO/XTJ
 yVmN1W0jOowiJE+bF56xdqdl9OeqfrbLi20DP60R6suBW3DxlbMaSK9LFvLgWTSeMu6i
 3dVjQubkl/8yIPAaM2o0vkG5Ow2lHWeReXgd17tteNWU4wZ9aSUS8TIKgFWHlG/FCp+D
 znlW9QrhlGFalYed55fB7pYptBJ7ZvY+lIYVa95bY2RdU6Gj3VHcXaAUab82XIjsSqfy
 SNIgTrtvn6aFb5FQklAKHEat40dkigi6LBUyD+DvKECLUSPKtQXzmmWoOiSJ0FqtHLJ8
 80Dg==
X-Gm-Message-State: AOJu0YxZbJVpWoGrFMarrYE5y24N0E9R/Bigu0bT+JW27t3NHe8LtEvH
 GEeOpgVhPnWuDl+rfBqc3O8aolEf2N8mXQ==
X-Google-Smtp-Source: AGHT+IEjfhQJtTq66yb//II3l2q7r1y/k4eflgTXbgibRYkx9TFLrYjS0FXo+PElYdXcUdkgEtGxqw==
X-Received: by 2002:a05:6a20:7486:b0:140:c838:2b2e with SMTP id
 p6-20020a056a20748600b00140c8382b2emr6019916pzd.22.1698559473745; 
 Sat, 28 Oct 2023 23:04:33 -0700 (PDT)
Received: from localhost.localdomain ([2601:642:4c02:6ead:344e:2b1:f5a5:58c6])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a17090341cc00b001b8943b37a5sm4019518ple.24.2023.10.28.23.04.32
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 28 Oct 2023 23:04:33 -0700 (PDT)
From: Joelle van Dyne <j@getutm.app>
To: qemu-devel@nongnu.org
Cc: Joelle van Dyne <j@getutm.app>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: [PATCH v3 13/14] tests: acpi: updated expected blobs for TPM CRB
Date: Sat, 28 Oct 2023 23:03:26 -0700
Message-ID: <20231029060404.71196-14-j@getutm.app>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231029060404.71196-1-j@getutm.app>
References: <20231029060404.71196-1-j@getutm.app>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.210.175; envelope-from=osy86dev@gmail.com;
 helo=mail-pf1-f175.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.249, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
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
 tests/data/acpi/q35/DSDT.crb.tpm2           | Bin 0 -> 8981 bytes
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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..0f04f48f0bb378f035773211b0e70ad50094f95f 100644
GIT binary patch
literal 8981
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

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
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..d5d6d0e004ce8cf7562b17e0cbd07b81d75f3297 100644
GIT binary patch
literal 5276
zcmZvg%WoT16o>D`lh__VVmr?JVHZlpGaB1Xla{u`9y^IkoEVSWAf=KkRYjC+Dp6IG
z3MpjKLU%M0D;7bD#J_>WiXA%^tl97nu*3ZB+?nJY^^BD9oSA#Rx!?FWKE6%A+5f4i
z)W}zjU2n@TH$LrpWo(vGN+0Xj+>1@??!a#h_K)T~*L4$vt#&h0_quHat12<L-EOM=
zqif!7C%V?_Y`Jcw5?)ITyq=$*bEcmsl?EnNPO0z5lx1B&^c1;k8++b{;eOKU+y=Lb
zT)$s;Qb_jdmO<p5tU-(<XTr?7eWw>qX?v%)i`13#+n!~f-`r6n;muu&sF=HRgud--
zh!J&;sDy}yo<&tcI3p6nCX6a&)I>&1VvG?+jWRBa3|nF(2;(wktcZ+JiQy2&3T0do
z8DkP7O&C`wV^w6tB}SGoRw-jmWF#a;jxg3J<EqF=N{j+wTqTT3_~GCs<~S0gNEp{B
zLo8GNA&E+TiZDK;47pCz(mZAe<2q%?b()bFbA)k&GUPhVN{j`<xJemuosLV4CBpcK
zGUPhVNsKaKtW$<ur+JC-24U1GL$1?;#JETp4a$(~bV6cWA`Fi(s&btcCC1x?(WDHy
zPA4VCyM)oA47pCHB*y!Mu|XMfolZ-PWy08`47pBcB!){ETa+Q!>8!-45=NUc<T{;`
z7?%m-7G=nFIxjJ<5XQ%pA=l}G#8@MYZOV}AbWvhlBa9AV)Z{u{k{H(sV}~;2IxR_z
zn}o3&GIoCHdhKu?-JPymch}H-cxaDIRMTBdYZLoMW9O_b@%z1e$yw+sPqozpRaP$k
znmBr*9;*9zRT>gB9^GDlV*5+yu#mD-!=c*r+paRl7LF^bkk;p&5d_sJh#{z{LdH%H
zhnCVg7#Bu53j?#}T9AjKQK&P)55}TPGGoI?XGTNO0_i(qXpo6eXGV941)0$dVoGO5
zLt`crLxW6&IukPr?qUa-(G2V$Ga8DPDYOhS5mL`l<~bT<MxLW4Gnza?>N&<d(Uf97
z(NMHl)Dt1~j5E(T^Ne#(gw!*^JQK_lEgAJhNIjFx6YaEldch+}a!-WR(_x+t^F#|r
zJrPpR6!T0m&lLAWNIlccGtE5F@=;HO)HB08Gt4u?JrPpREc47VPqc{C6Cw2+XP)EC
zbDVo3q@MUWV`@C8;vDltOG!NuQqMf|%rnnC_e4lN3(T{?Jkf$uPlVKSf_Y9b&k62{
zkb2^WBJnITPqeJm6Cw4SWS*1EbCP=^q@GjEbBcMQ#igDIspmBFoMxWW+!G=7#E(nj
zIm0~B5>rov)N_`3&N9zg?un3k&N0t9=7|=XdLpEr^UQOedCqfBgw%6^c`h(dwA|Da
zA@y8jo{P+Lk$WPfo=ePgiFu+$r=AF@XNh^1m}iN5A~c@+M{QfbmFDN0{!;ebjk7P}
zE|w*-PAXW6cr*A)$M^1Q=Za$kzvo*aD(n~-3hM+Ebx}Z>b7!bqdRAeB%TRi~fU@2a
zSmqpOg^ey}VcmeTE(t7iE@TyR1Fun6r}!VLa_iWc$FUW69)FinBlvfYZK!wF3w*lL
z=q`dSHyr+_f0khzF5`-oMh{>%G%eVMxN51F?~$C~@}a(_w;(#->GMxj!oS_^s)X0?
zZL8u&a<J=r_R9n1HTNnfTk+%1^Ak>Pzw=k^-_pYRk9&{nzux%svzG^sjR94>Ch%H&
zqyx>-2Q`g)rgu(B?@w~Cjvrdz;7TPJT{)S0bsUW|r*rz^BRyE3KRx(4YtHMNR89|y
z9}Jp)$3D4WX7k7D?|=I%Uw3|({--nho7Xu>9)F=u^D)cPJ1lf{>|V=f)u<P`bj{Tq
z_qFE}ya#wXrS<biqmS@?W7f?Y@w>}<Wp1<89GDU}%W@Uncw$*Dg9{<w)OpN$$D|&%
zdgx2>jwX_hz5i`WhhEEXZI_FSgVvpX@{tbio#c+6-E(xm_q@B;YdDAdN3;5Xex5vY
zFWBwa{cb0mNXOskyA@Zj0ixf{;6k~&?3SAko;<w&z+~WKqnG&fuXQ|tv&B8kYF+F7
E4^LzyJpcdz

literal 0
HcmV?d00001

diff --git a/tests/data/acpi/virt/TPM2.crb-device.tpm2 b/tests/data/acpi/virt/TPM2.crb-device.tpm2
index e69de29bb2d1d6434b8b29ae775ad8c2e48c5391..3e8727cd0ef170aea6dd59a2b468bed3d7cf3d51 100644
GIT binary patch
literal 76
zcmWFu@HO&bU|?X`<>c?|5v<@85#X!<1dKp25F12;fCB>q4~S+55hwtp;-WK12mq){
B2mt^9

literal 0
HcmV?d00001

-- 
2.41.0


