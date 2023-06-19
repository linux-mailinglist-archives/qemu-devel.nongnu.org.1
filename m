Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E77E47358E7
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 15:47:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBFDu-00030I-VK; Mon, 19 Jun 2023 09:47:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qBFDn-0002wt-Rg
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:47:09 -0400
Received: from qs51p00im-qukt01080501.me.com ([17.57.155.22])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1qBFDl-0006PM-CU
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 09:47:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 t=1687182423; bh=EcDTfFvPiDbu6xKRzq1KBQP9u7bfAG3ORDug4/njrBc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To;
 b=HOYRyX3YnwaAGY0t8g2X1MuWPmdySTYmN+ez62Q2qhKcaA9JTD8Io6w9idAk6x5mB
 SoDp2WObu409/2plc2SaQpvvvUZHLtKAyjkKlyAxU3w4ZMMrhS10luwWm/K58WTKqq
 3YfOpRSg5a/Rv9iphtBxhb2iR6WNbchYHOqRkobZGhJsvGEvgVaMDod03C2jlwtV46
 oDttjmRplBT/TqJx8v5BDggoAdBCO6iG5stysWYhaNeGuKZHnpwd3zKRZrzFyeHlS5
 5RiTmy4qSMbGfhqUYRaW2B6uWPgpPiPqFkq5dR+awASc56w7k1WKZoUDQ9Kd+ypMuH
 L9QXcrZWIny1A==
Received: from smtpclient.apple (qs51p00im-dlb-asmtp-mailmevip.me.com
 [17.57.155.28])
 by qs51p00im-qukt01080501.me.com (Postfix) with ESMTPSA id F3FDF19802C7;
 Mon, 19 Jun 2023 13:47:00 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.600.7\))
Subject: Re: [PATCH v2 12/12] target/arm: Allow users to set the number of VFP
 registers
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <c027687b-da81-3e3f-9305-43a6eadc17fe@kaod.org>
Date: Mon, 19 Jun 2023 15:46:49 +0200
Cc: "open list:ARM cores" <qemu-arm@nongnu.org>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Andrew Jeffery <andrew@aj.id.au>,
 =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <21DCF8D7-06DA-4F3E-B3E8-890B9D401978@ynddal.dk>
References: <20230607043943.1837186-1-clg@kaod.org>
 <20230607043943.1837186-13-clg@kaod.org>
 <955C217E-FE0F-41E2-8E97-9AFD8C4A0DBE@ynddal.dk>
 <c027687b-da81-3e3f-9305-43a6eadc17fe@kaod.org>
To: =?utf-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
X-Mailer: Apple Mail (2.3731.600.7)
X-Proofpoint-ORIG-GUID: QrN7nG6HdqmsH9aEXif00vEOAxBWskLb
X-Proofpoint-GUID: QrN7nG6HdqmsH9aEXif00vEOAxBWskLb
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.790,17.0.605.474.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-12=5F03:2022-01-11=5F01,2022-01-12=5F03,2020-01-23?=
 =?UTF-8?Q?=5F02_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 mlxscore=0 clxscore=1030
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=595
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2306190126
Received-SPF: pass client-ip=17.57.155.22; envelope-from=mads@ynddal.dk;
 helo=qs51p00im-qukt01080501.me.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


> ARM's "Vector Floating Point" unit has many implementation with =
different
> features: VFPv3-D16/D32, *FP16, VFPv4-D16/D32, Neon, etc. The test =
might
> be too strict and could possibly be removed.
>=20
> Could you send us the result of 'cat /proc/cpuinfo' on the host ?
>=20
> Thanks,
>=20
> C.

The host is macOS, so there's no '/proc/cpuinfo'. I can get this from =
sysctl:

$ sysctl -a | grep hw.optional
hw.optional.arm.FEAT_FlagM: 1
hw.optional.arm.FEAT_FlagM2: 1
hw.optional.arm.FEAT_FHM: 1
hw.optional.arm.FEAT_DotProd: 1
hw.optional.arm.FEAT_SHA3: 1
hw.optional.arm.FEAT_RDM: 1
hw.optional.arm.FEAT_LSE: 1
hw.optional.arm.FEAT_SHA256: 1
hw.optional.arm.FEAT_SHA512: 1
hw.optional.arm.FEAT_SHA1: 1
hw.optional.arm.FEAT_AES: 1
hw.optional.arm.FEAT_PMULL: 1
hw.optional.arm.FEAT_SPECRES: 0
hw.optional.arm.FEAT_SB: 1
hw.optional.arm.FEAT_FRINTTS: 1
hw.optional.arm.FEAT_LRCPC: 1
hw.optional.arm.FEAT_LRCPC2: 1
hw.optional.arm.FEAT_FCMA: 1
hw.optional.arm.FEAT_JSCVT: 1
hw.optional.arm.FEAT_PAuth: 1
hw.optional.arm.FEAT_PAuth2: 0
hw.optional.arm.FEAT_FPAC: 0
hw.optional.arm.FEAT_DPB: 1
hw.optional.arm.FEAT_DPB2: 1
hw.optional.arm.FEAT_BF16: 0
hw.optional.arm.FEAT_I8MM: 0
hw.optional.arm.FEAT_ECV: 1
hw.optional.arm.FEAT_LSE2: 1
hw.optional.arm.FEAT_CSV2: 1
hw.optional.arm.FEAT_CSV3: 1
hw.optional.arm.FEAT_DIT: 1
hw.optional.arm.FEAT_FP16: 1
hw.optional.arm.FEAT_SSBS: 1
hw.optional.arm.FEAT_BTI: 0
hw.optional.arm.FP_SyncExceptions: 1
hw.optional.floatingpoint: 1
hw.optional.neon: 1
hw.optional.neon_hpfp: 1
hw.optional.neon_fp16: 1
hw.optional.armv8_1_atomics: 1
hw.optional.armv8_2_fhm: 1
hw.optional.armv8_2_sha512: 1
hw.optional.armv8_2_sha3: 1
hw.optional.armv8_3_compnum: 1
hw.optional.watchpoint: 4
hw.optional.breakpoint: 6
hw.optional.armv8_crc32: 1
hw.optional.armv8_gpi: 1
hw.optional.AdvSIMD: 1
hw.optional.AdvSIMD_HPFPCvt: 1
hw.optional.ucnormal_mem: 1
hw.optional.arm64: 1


If it's any help, the Linux guest looks like this:

$ cat /proc/cpuinfo
processor : 0
BogoMIPS : 48.00
Features : fp asimd evtstrm aes pmull sha1 sha2 crc32 atomics fphp =
asimdhp cpuid asimdrdm jscvt fcma lrcpc dcpop sha3 asimddp sha512 =
asimdfhm dit uscat ilrcpc flagm sb paca pacg dcpodp flagm2 frint
CPU implementer : 0x00
CPU architecture: 8
CPU variant : 0x0
CPU part : 0x000
CPU revision : 0

=E2=80=94
Mads Ynddal


