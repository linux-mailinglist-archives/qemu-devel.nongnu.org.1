Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DE0682FDD7
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 00:51:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPtCS-0004Ng-7H; Tue, 16 Jan 2024 18:50:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1rPtCN-0004NP-Pc
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 18:50:27 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sidneym@quicinc.com>)
 id 1rPtCM-0002gT-1O
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 18:50:27 -0500
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id
 40GMtGC0030944; Tue, 16 Jan 2024 23:50:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
 from:to:cc:subject:date:message-id:content-type:mime-version; s=
 qcppdkim1; bh=OMb6LvDioa7EITczeZpxuhcO3FtDUk8nd5FVLpsYFjU=; b=nq
 Na13i83ZZvyza5b+R68fr8TpDoRo+xMMYzekyVHfP8sk/LF8llzVAu7+dcVgmBiW
 i0PS0QP34DjJT21x3BRb4FrE+dql6HbpqvuLS3xumdISJpmxcMTX3vB16dibTK6n
 vo/i+XpwlRqLvYL8AlDSnhvTl44iN22Nf1VZUclLbLQTSD3hcjQ/UmTTyvXmvgge
 ROPGZh1WDoShXNHTa60e0PPuLIYEbKj0wuzMfgNbu3r0peO/wHATLnfSXZH1bvRp
 4xSut27asJnrf4Zi7ObAZrPutFQzhtr8hegep8hzmFlzklFfAg4Bu5Wtrq7JOXKt
 8cMWo3gq5f4uXweQIDXA==
Received: from nam12-dm6-obe.outbound.protection.outlook.com
 (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3vnmq0jafp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Jan 2024 23:50:22 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ncWg5effXXjnEG7UHEAFVNrctM72aDfxTijEoKe2EujsM7iIv4jIhVtJp0RkfTYnDG9ya6LqkcN4e+qbDSXZph7D2ClC7aDk7rlDS2G9Gr+HsG92Gf0lUR1YNDfogjb2Dy9CpvKXsXV2zJntmeP36BOnFoeDKa/m7bBrI1r0JJvRrjRUoLR+efG+W760hCOzL2PuiZM2KdmbTLWXyN1bCa6uP5exNvGT/3EzQJP1UDAT7Ugmy0U+fbsUidkifwCBQsRJAyyFB0PBzkHhFv3bmPkKx1/6Ls6kzNag4iW8fXMoHVpFEISCiD98lMIeqFBylM4Ih2mjZ4WX0AtvgTHrsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OMb6LvDioa7EITczeZpxuhcO3FtDUk8nd5FVLpsYFjU=;
 b=dpbd0gGFmxqgohlTUpTHHphhZtN2L5EZZlcH2XFgZ2U/Mc5oFldnuESNth9hVfqcSRLBYQFtVmLpxumKyzW0jlFcu1usAv9s9xoJtvauVEWzV+PQCYCOYaapXfrpMAjvfPPiOcvbonxTU97TljxeQWEJhP7NYq6pq3MCcPxPfPcjkmFXyg/r8UroEFFNp7MlK/bXzDlP5lwJDbLW5krN+WvpMvDIIFRvPGSa/R5djUujNP0wfST38/FVYQULghuav4IhUzHRy/3/CdwBuUtbNPldDAjhenQ5W//ni7I8A74bTCT7J+EnNYL6rrRLD2uZVzAmg4jGqrskURRuiaG4oQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from IA0PR02MB9486.namprd02.prod.outlook.com (2603:10b6:208:403::18)
 by DM6PR02MB6512.namprd02.prod.outlook.com (2603:10b6:5:1b5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.21; Tue, 16 Jan
 2024 23:50:18 +0000
Received: from IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::fba0:e11b:6b0c:73b7]) by IA0PR02MB9486.namprd02.prod.outlook.com
 ([fe80::fba0:e11b:6b0c:73b7%6]) with mapi id 15.20.7181.020; Tue, 16 Jan 2024
 23:50:18 +0000
From: Sid Manning <sidneym@quicinc.com>
To: "ltaylorsimpson@gmail.com" <ltaylorsimpson@gmail.com>, Brian Cain
 <bcain@quicinc.com>, Matheus Bernardino <mathbern@qti.qualcomm.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Issue with PC updates.
Thread-Topic: Issue with PC updates.
Thread-Index: AdpI1Nkb4JAKjm39TF2aS55qOpZPzw==
Date: Tue, 16 Jan 2024 23:50:18 +0000
Message-ID: <IA0PR02MB94868A441EB2706DDC7DC3DFBE732@IA0PR02MB9486.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR02MB9486:EE_|DM6PR02MB6512:EE_
x-ms-office365-filtering-correlation-id: de39a5f4-5d7a-4cfc-f730-08dc16ede4ec
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 61maCF0jVPv3W54i0UibEHiRtLwyBuiOlag0sRgYsR8uzU8iqg3d+qtw89UD4K+uix5iuyxPksrntBxK5ZXEGeOXKIw2JJ8mOw97oi4YHd21Vv5DvVXpssVIhYHqjXZPqTJ/OwBtqy5Nfot0U1gyY2VoFB4g+6JK3erxhZbfR+BsIWOs1nEKVio5NQI3BrG/aghSWpgoChkRHmm5/sZKRzVr5t0IJPciTpJOLx1LjJHCBusxR4BrYPYCDovyL5tB3f0LsfN81OixzRRVk+/+RyG8FC/UGdlORXUqT+tfDj6MUAhTZbd8nHwTnHDOHjGzk3MrP1RApF+QOy2eL1LCwr7+wK7WTQjbbVQv16qYwWFIBmh1XbFAzO+GZkPucKgFaoz+IXrpyoD5PsC5VecUJ3iFoDCUlio6mytmMwEJARU+4OSCZB1uwXn00iru4agNVxyBF668OZIYdgM1rlQhQM4xOcbdLNWQLeaXUt3jXYTxCN0inHM3jdTVbSrQO5UrDwJuK3vcgjiWxKMa/yUjDgyfnU2LXEtdty15QH7D56YSVzhYGA11Vm/1dXmkOu9A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR02MB9486.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(396003)(366004)(346002)(376002)(39860400002)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(7696005)(6506007)(26005)(71200400001)(9686003)(38070700009)(99936003)(83380400001)(38100700002)(86362001)(3480700007)(41300700001)(122000001)(478600001)(33656002)(52536014)(15650500001)(8676002)(4326008)(8936002)(5660300002)(66946007)(76116006)(66476007)(110136005)(66556008)(55016003)(66446008)(2906002)(316002)(64756008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LwfTRK3hJseUOKTX0P9BSRnXV0OJeP10IFGFRmNHOsDSFd+LdC0k0BFzXman?=
 =?us-ascii?Q?ucnJHYt4oCz4PKG7L3/9k2BshLDKToF0KFBjDCGS1Qa63bjR2lymGwBdYpD5?=
 =?us-ascii?Q?U05uaikmEFpOysnGBBD1DT1tA4+kng7fQJJaBr5dkLrBHGpxp/C4iyMXa4UZ?=
 =?us-ascii?Q?BAlAc0v0bM9SOtu6OfGZQOPKA04FUTQ5ex2+Rr6243B3MR8JEPT4rUr6CvDL?=
 =?us-ascii?Q?nQ4ud4aLUVOdeBYh8QfWo97H89Ya3QxPxUxIIikDPvd9hWUZJbw/ymAtwB78?=
 =?us-ascii?Q?ydSxakHsmykfE/7PVioXIkpdpULTABtSP7jL/w644Ah5fahz3WPKm1e2eBBn?=
 =?us-ascii?Q?hvIgkCxlq0KYuoQISGkHuOmgF2jrboXAffBwL2ht2vLJzeuWA0ZthoBXknd4?=
 =?us-ascii?Q?o9fm/Aagpnm+pruG37her+yQY9LFSfD5iSLbwNA8SVjsxueCdEKK4nb86+qt?=
 =?us-ascii?Q?85L+65QOD1EhCuvQceR+v4gDJ6iO0Ay5l2g40HNgyRRN//mEqVdndMlyIDR+?=
 =?us-ascii?Q?LC56fJW8KMw3iJJ4y9v4YJwkYVtuNnXH7wf8nwrr7NbOGE3gENTNIOQbWy4P?=
 =?us-ascii?Q?cSRfIryB1Xj2eEJzChaDiQf7oG7Wnfn85VaYxpxHdSZSTEpMjMofqlRpDiKE?=
 =?us-ascii?Q?MXe82Kaz9NV/NKaHsXxxn/Ir99wif5Pm/VCvWbEBvkfRTpNCm0GXDCbEYBdJ?=
 =?us-ascii?Q?2/lcPgc+8FU2QCUi2KECh7StyW+ttcHM+g7VfDip/k92q+ge/GSQfGGMmJea?=
 =?us-ascii?Q?aRYB+GejwJmQUCLBAsMCT7l3CdXMUWMrt4BOcvBSyll9kyP3injepAKVPJ3L?=
 =?us-ascii?Q?EMnMGKtGFFajDcQztqILhSx5+4cNid7wt5el6M5oa/5qhFvEzYXAC4adKR3s?=
 =?us-ascii?Q?3u+Go9/5UMyY/ebnmjclVm2zXrqniPFR6apT6YgpXeS93eRQDApwjRyKEJWA?=
 =?us-ascii?Q?jkemLxn35rPoDadpoZg1E4XrtYOnDrWLv4a6gNTYCaVLIVxGS5rG7A4R2Rm7?=
 =?us-ascii?Q?UwWjKrQnvkACaiqCHqziX8JHVDmg6ITiGvLZbJVAamUj+ffVMxJH/uupjCbg?=
 =?us-ascii?Q?A5HNOsQ+pWtSKfPgACMj9Ncg+8Bje5VhP8CgX/3Vb+yRmGaHUsyVTpgxrgz4?=
 =?us-ascii?Q?ge7LA0oh7DWGWDY1LpBZoivVhijSeiVmE6jD1T0NETPF+X3RPeyWqc3OnRBp?=
 =?us-ascii?Q?YWdz/pM2g+W4t301E6lDakuvSKcadHGnDD7c0XnaEkRUliBTsZpp5CJdHj5v?=
 =?us-ascii?Q?hTLXeIBmd5YytooXBaMz3pSxIFCSOY5casXIQVMaB9NjhfP5q/cYsvFYj8bt?=
 =?us-ascii?Q?zDulxl70TfPrepCrl1w73IIAcIZm81MckpS4ItO01mVptjgsTOXwLtcevM2V?=
 =?us-ascii?Q?3ID3dGnRuQbaoNn3GkSVQSZm4H3EGcvaI8E1nlD7DaU9jlMkUuum4Q7uj2mY?=
 =?us-ascii?Q?ZbKmCOBK8OSA+4vInfL9QQrPMcNfbklSqJQvsVxx3lUgPMjbXUBGSqRpnKF3?=
 =?us-ascii?Q?tWXXLBu3kVl1uF+ylLlfz1odVy1vdUj23G/oEiPIbxPdUe66Er1aQy1xTjnl?=
 =?us-ascii?Q?ZR0scSBuLW7d0DLi2WAIyLGcarfty9w1z2/P6yE8?=
Content-Type: multipart/mixed;
 boundary="_003_IA0PR02MB94868A441EB2706DDC7DC3DFBE732IA0PR02MB9486namp_"
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5zviV0rqny86VS7cVTUTT3gGd84iTmCsRp1uC6vRAxYhSVLfxcHXvE1z6EAOmAclpJNitiKN6MduoHFd5eeqprQjYS6HFbREFjSJlX0S7lKCK+umphzb4k2ofxKuHQIx43Kowsytr9/bOv0gNCAQ1TMQvjhhrdPlhoJSuaD4NH92lIuEPUg0WMpAiNFX7HGycxWdyEbXCxQXYSZwrlniqrnSOf+HwgghGwvKHPHABftEQs6IVLvTHW2Y+BRXoJn38s//S1se68JXQed0MRK00QPWCr8thhKhbygDNVVPNI1+Nr+GITO71N1a3Dfbs0/NcZQovKWmpzxvhv3wCk0N6LU1FjAwFWp4dP3cTS50PVN31ZCNO+6EYso9U4TDQgIlteJI08gMPoAcr1yH4uKDafCYaiPKsq7AU/pAL35G93hjlLLl9Uj+7doqFTzu1J48rNnJXAm/ijeNOc5BEVxZzWAbkppNhMFM4RkldL3zTtbcyVpgC/5O4H3HfOsVyptdlxMkbysnXfZq4BAgN5U8akDteKeA/HDkAvRy1M2sb4XbPTHwRfkDH8k+qViUBRs4h5EFGK/rFCoZZcCzcXlQV36O+8DoPBzN2qdwshV01NnP9rEBVhDkMRl1ti42QEDP
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR02MB9486.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de39a5f4-5d7a-4cfc-f730-08dc16ede4ec
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jan 2024 23:50:18.3222 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WsKFQLBtW74njldYiCX+VeN74s0GS2Dv0q4kJheQGvefbcDwABx2R/y7fm0IPG27FUN8yHO13dyuHMY21S2ySg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR02MB6512
X-Proofpoint-GUID: dRXynWQb6B_PF4LoVP3MD2SC5Ag3OHY8
X-Proofpoint-ORIG-GUID: dRXynWQb6B_PF4LoVP3MD2SC5Ag3OHY8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-16_14,2024-01-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 suspectscore=0 impostorscore=0 lowpriorityscore=0
 malwarescore=0 clxscore=1011 mlxlogscore=689 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2311290000
 definitions=main-2401160187
Received-SPF: pass client-ip=205.220.180.131; envelope-from=sidneym@quicinc.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

--_003_IA0PR02MB94868A441EB2706DDC7DC3DFBE732IA0PR02MB9486namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi Taylor,

I ran into an issue when a packet, not executed out of ram (get_page_addr_c=
ode_hostp returns -1, see translate-all.c) contains a fault.
This packet is an example:
{
    p0 =3D cmp.eq(r6,#0x6)
    if (p0.new) jump:t pass
    memw(##0xf2000000) =3D r6
}

The above packet should always jump to "pass" since r6 is set to #0x6, but =
if the store faults, the jump is discarded.  This happens because do_raise_=
exception's call to cpu_loop_exit_restore is not able to find a TB to resto=
re the PC to.  When an instruction is not associated with a physical RAM pa=
ge translate-all will create a "one-shot" TB so when cpu_restore_state look=
s for the TB by calling tcg_tb_loopup none is found.  That keeps the PC fro=
m being restored.

The change attached restores some of the code from commit 613653e500c0d4827=
84f09aaa71f1297565b6815 / Hexagon (target/hexagon) Remove next_PC from runt=
ime state.

There are two attachments, the qemu update also includes an update to trans=
late-all.c that forces this problem to occur.  The second is the testcase w=
hich is built using vanilla llvm toolchain configured for hexagon.

Thanks,

--_003_IA0PR02MB94868A441EB2706DDC7DC3DFBE732IA0PR02MB9486namp_
Content-Type: application/x-gzip; name="pc-testcase.tar.gz"
Content-Description: pc-testcase.tar.gz
Content-Disposition: attachment; filename="pc-testcase.tar.gz"; size=756;
	creation-date="Tue, 16 Jan 2024 23:32:23 GMT";
	modification-date="Tue, 16 Jan 2024 23:50:17 GMT"
Content-Transfer-Encoding: base64

H4sICJYQp2UAA3BjLXRlc3RjYXNlLnRhcgDtlc9v2jAUx7nOf8WTuIBEgg0k6Zg4VNO0U6VK67Zj
5SQOTXGc1DYFNO1/n+1QSLVuPaw/VM2fgxP7+cd735fnNFmgmdIZVWzceyawIYmiHp4QTCbE9acE
u+eeHplFEYmNPZn1zKQ4Ij2InsuhLmulqQToqTIXbFf9ZR6T6iUcelmaTv7P6IoVJWdPfYZNcDyb
/TH/U0z2+cdJbL8TMpuSqAf4qR15iP88/5TzOXoXhuM6vQ44v63GaSnGGadiCVYZHX6BoLqNIwjq
dgCCwmgR8HzBeQ6BqJXOeZlC8J2PggvNtnqEt+/TE5fadpQJLXed0cOBN6xaj20TqJ3SrAqu2JYu
awFBDnUzKsUlVZXplKrhdAeiFgwgWDEpGG+9Qa8t4BunW//7fD/5GY/Uv732j/d/jG39k8nU1/9L
EC55ndK7YnLtHIFBYlhAv89uU9c1T9OXuGNr35WSR8P1umqgr5heNwj1c/M3MQWreXpZipxtQRKC
jj27Pd7uP4IEobCWS8BbYu4HZI6bH3cM//m1b46tSuPrBiHk/Gu3/+FaFxPZO5Rh7O6powXvLUVC
pgkmreWna7vR0DwfHPoj6JPh3ZTNQJI5Hh2MQyMOfBI05QzOzr62mk4OgpxEFCdFq+5OZcXSCjyx
ay5MqUIr7zG0vi3gy6zOmZliJn2kAmrBd3BFRW5OsJdmQddcA9VG32LSKj7+drpYnJ+aJQdtrCZ3
inT1cEvQ72qwWauG1eJRJR7UwQ2vBa+zlXmX2oRgIjiXtZGmglPJKGqoUi5ZrULOD6XrZiDx8ANC
h+DbObGbs407u5zTbMXMb+seqI2zsdFkVROym4GMR3Zlm7WygEGDQ8E2QyfzXIN1xNkqVm0GToK9
lEOboBj9dM5/ZlqX5u95xSSDsmp4yZTRv+RrycJjHOR+HK99D3g8Ho/H4/F4PB6Px+PxeDwej8fj
8Xg8nrfPL/wrFX8AKAAA

--_003_IA0PR02MB94868A441EB2706DDC7DC3DFBE732IA0PR02MB9486namp_
Content-Type: application/octet-stream;
	name="0001-Incorrect-PC-update-for-many-miss-packets.patch"
Content-Description: 0001-Incorrect-PC-update-for-many-miss-packets.patch
Content-Disposition: attachment;
	filename="0001-Incorrect-PC-update-for-many-miss-packets.patch"; size=5500;
	creation-date="Tue, 16 Jan 2024 23:31:36 GMT";
	modification-date="Tue, 16 Jan 2024 23:50:18 GMT"
Content-Transfer-Encoding: base64

RnJvbSA2M2U2YWUyOTU2MzM0MzMwMTEwOTQ5ZGRiYTYxNTU0ZWVmNDI3NjgzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaWQgTWFubmluZyA8c2lkbmV5bUBxdWljaW5jLmNvbT4KRGF0
ZTogVHVlLCAxNiBKYW4gMjAyNCAxMjozMjo0NSAtMDgwMApTdWJqZWN0OiBbUEFUQ0hdIEluY29y
cmVjdCBQQyB1cGRhdGUgZm9yIG1hbnkgbWlzcyBwYWNrZXRzLgoKVGhlIGZvbGxvd2luZyBlcnJv
ciBleHBvc2VkIGEgaG9sZSBpbiBob3cgb3VyIHRyYW5zbGF0aW9uCmNvZGUgd2FzIG1hbmFnaW5n
IHBjL25leHRfcGMuCgpBIHBhY2tldCB3aXRoIGEgbG9hZC9zdG9yZSBhbmQgYSBjb25kaXRpb25h
bCBjaGFuZ2Ugb2YgZmxvdwpjYW4gZW5kIHVwIGF0IHRoZSB3cm9uZyBQQy4KClNpZ25lZC1vZmYt
Ynk6IFNpZCBNYW5uaW5nIDxzaWRuZXltQHF1aWNpbmMuY29tPgotLS0KIGFjY2VsL3RjZy90cmFu
c2xhdGUtYWxsLmMgIHwgIDEgKwogdGFyZ2V0L2hleGFnb24vY3B1LmggICAgICAgfCAgMSArCiB0
YXJnZXQvaGV4YWdvbi9nZW5wdHIuYyAgICB8ICA3ICsrKystLS0KIHRhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5jIHwgMTcgKysrKysrKysrKysrKystLS0KIHRhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5oIHwgIDIgKysKIDUgZmlsZXMgY2hhbmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9hY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5jIGIvYWNjZWwvdGNn
L3RyYW5zbGF0ZS1hbGwuYwppbmRleCA3OWE4OGY1ZmI3Li4wNGU0ZDFkMGNhIDEwMDY0NAotLS0g
YS9hY2NlbC90Y2cvdHJhbnNsYXRlLWFsbC5jCisrKyBiL2FjY2VsL3RjZy90cmFuc2xhdGUtYWxs
LmMKQEAgLTMwMSw2ICszMDEsNyBAQCBUcmFuc2xhdGlvbkJsb2NrICp0Yl9nZW5fY29kZShDUFVT
dGF0ZSAqY3B1LAogICAgIHFlbXVfdGhyZWFkX2ppdF93cml0ZSgpOwogCiAgICAgcGh5c19wYyA9
IGdldF9wYWdlX2FkZHJfY29kZV9ob3N0cChlbnYsIHBjLCAmaG9zdF9wYyk7CisgICAgcGh5c19w
YyA9IC0xOyAvLyBGb3JjZSBvbmUtc2hvdCBUQiB0byBkZW1vbnN0cmF0ZSBQQyBpc3N1ZQogCiAg
ICAgaWYgKHBoeXNfcGMgPT0gLTEpIHsKICAgICAgICAgLyogR2VuZXJhdGUgYSBvbmUtc2hvdCBU
QiB3aXRoIDEgaW5zbiBpbiBpdCAqLwpkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vY3B1Lmgg
Yi90YXJnZXQvaGV4YWdvbi9jcHUuaAppbmRleCAzMTM1MDg2MDg3Li40MGY0OTljNTExIDEwMDY0
NAotLS0gYS90YXJnZXQvaGV4YWdvbi9jcHUuaAorKysgYi90YXJnZXQvaGV4YWdvbi9jcHUuaApA
QCAtNDI3LDYgKzQyNyw3IEBAIHR5cGVkZWYgc3RydWN0IENQVUFyY2hTdGF0ZSB7CiAgICAgYm9v
bCBzc19wZW5kaW5nOwogICAgIFBNVVN0YXRlIHBtdTsKICNlbmRpZgorICAgIHRhcmdldF91bG9u
ZyBoZXhfbmV4dF9QQzsKIH0gQ1BVSGV4YWdvblN0YXRlOwogI2RlZmluZSBtbXZlY3hfdCBDUFVI
ZXhhZ29uU3RhdGUKIApkaWZmIC0tZ2l0IGEvdGFyZ2V0L2hleGFnb24vZ2VucHRyLmMgYi90YXJn
ZXQvaGV4YWdvbi9nZW5wdHIuYwppbmRleCBlZmFhOTc1N2FjLi4zNzE0MjY0MTZhIDEwMDY0NAot
LS0gYS90YXJnZXQvaGV4YWdvbi9nZW5wdHIuYworKysgYi90YXJnZXQvaGV4YWdvbi9nZW5wdHIu
YwpAQCAtNzA4LDE0ICs3MDgsMTUgQEAgc3RhdGljIHZvaWQgZ2VuX3dyaXRlX25ld19wY19hZGRy
KERpc2FzQ29udGV4dCAqY3R4LCBUQ0d2IGFkZHIsCiAgICAgICAgIHRjZ19nZW5fYnJjb25kaV90
bChjb25kLCBwcmVkLCAwLCBwcmVkX2ZhbHNlKTsKICAgICB9CiAKKyAgICBUQ0d2IFBDX3dyID0g
Y3R4LT5uZWVkX25leHRfcGMgPyBoZXhfbmV4dF9QQyA6IGhleF9ncHJbSEVYX1JFR19QQ107CiAg
ICAgaWYgKGN0eC0+cGt0LT5wa3RfaGFzX211bHRpX2NvZikgewogICAgICAgICAvKiBJZiB0aGVy
ZSBhcmUgbXVsdGlwbGUgYnJhbmNoZXMgaW4gYSBwYWNrZXQsIGlnbm9yZSB0aGUgc2Vjb25kIG9u
ZSAqLwotICAgICAgICB0Y2dfZ2VuX21vdmNvbmRfdGwoVENHX0NPTkRfTkUsIGhleF9ncHJbSEVY
X1JFR19QQ10sCisgICAgICAgIHRjZ19nZW5fbW92Y29uZF90bChUQ0dfQ09ORF9ORSwgUENfd3Is
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICBjdHgtPmJyYW5jaF90YWtlbiwgdGNnX2NvbnN0
YW50X3RsKDApLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgaGV4X2dwcltIRVhfUkVHX1BD
XSwgYWRkcik7CisgICAgICAgICAgICAgICAgICAgICAgICAgICBQQ193ciwgYWRkcik7CiAgICAg
ICAgIHRjZ19nZW5fbW92aV90bChjdHgtPmJyYW5jaF90YWtlbiwgMSk7CiAgICAgfSBlbHNlIHsK
LSAgICAgICAgdGNnX2dlbl9tb3ZfdGwoaGV4X2dwcltIRVhfUkVHX1BDXSwgYWRkcik7CisgICAg
ICAgIHRjZ19nZW5fbW92X3RsKFBDX3dyLCBhZGRyKTsKICAgICB9CiAKICAgICBpZiAoY29uZCAh
PSBUQ0dfQ09ORF9BTFdBWVMpIHsKZGlmZiAtLWdpdCBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0
ZS5jIGIvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKaW5kZXggODU4NWM3YjYxNi4uM2QyOGE1
ZmMyNyAxMDA2NDQKLS0tIGEvdGFyZ2V0L2hleGFnb24vdHJhbnNsYXRlLmMKKysrIGIvdGFyZ2V0
L2hleGFnb24vdHJhbnNsYXRlLmMKQEAgLTUyLDYgKzUyLDcgQEAgc3RhdGljIGNvbnN0IEFuYWx5
emVJbnNuIG9wY29kZV9hbmFseXplW1hYX0xBU1RfT1BDT0RFXSA9IHsKIFRDR3YgaGV4X2dwcltU
T1RBTF9QRVJfVEhSRUFEX1JFR1NdOwogVENHdiBoZXhfcHJlZFtOVU1fUFJFR1NdOwogVENHdiBo
ZXhfc2xvdF9jYW5jZWxsZWQ7CitUQ0d2IGhleF9uZXh0X1BDOwogVENHdiBoZXhfbmV3X3ZhbHVl
X3VzcjsKIFRDR3YgaGV4X3JlZ193cml0dGVuW1RPVEFMX1BFUl9USFJFQURfUkVHU107CiBUQ0d2
IGhleF9zdG9yZV9hZGRyW1NUT1JFU19NQVhdOwpAQCAtODQsNiArODUsOCBAQCBUQ0d2X2k2NCBo
ZXhfY3ljbGVfY291bnQ7CiBUQ0d2IGhleF92c3RvcmVfYWRkcltWU1RPUkVTX01BWF07CiBUQ0d2
IGhleF92c3RvcmVfc2l6ZVtWU1RPUkVTX01BWF07CiBUQ0d2IGhleF92c3RvcmVfcGVuZGluZ1tW
U1RPUkVTX01BWF07CitzdGF0aWMgYm9vbCBuZWVkX25leHRfUEMoRGlzYXNDb250ZXh0ICpjdHgp
OworCiAKIHN0YXRpYyBjb25zdCBjaGFyICogY29uc3QgaGV4YWdvbl9wcmVkbmFtZXNbXSA9IHsK
ICAgInAwIiwgInAxIiwgInAyIiwgInAzIgpAQCAtMjM4LDYgKzI0MSw5IEBAIHN0YXRpYyB2b2lk
IGdlbl9lbmRfdGIoRGlzYXNDb250ZXh0ICpjdHgpCiAKICAgICBnZW5fZXhlY19jb3VudGVycyhj
dHgpOwogCisgICAgaWYgKG5lZWRfbmV4dF9QQyhjdHgpKSB7CisgICAgICAgIHRjZ19nZW5fbW92
X3RsKGhleF9ncHJbSEVYX1JFR19QQ10sIGhleF9uZXh0X1BDKTsKKyAgICB9CiAgICAgaWYgKGN0
eC0+YnJhbmNoX2NvbmQgIT0gVENHX0NPTkRfTkVWRVIpIHsKICAgICAgICAgaWYgKGN0eC0+YnJh
bmNoX2NvbmQgIT0gVENHX0NPTkRfQUxXQVlTKSB7CiAgICAgICAgICAgICBUQ0dMYWJlbCAqc2tp
cCA9IGdlbl9uZXdfbGFiZWwoKTsKQEAgLTk2MCw4ICs5NjYsOSBAQCBzdGF0aWMgdm9pZCBnZW5f
c3RhcnRfcGFja2V0KENQVUhleGFnb25TdGF0ZSAqZW52LCBEaXNhc0NvbnRleHQgKmN0eCkKICAg
ICAgICAgdGNnX2dlbl9tb3ZpX3RsKGN0eC0+YnJhbmNoX3Rha2VuLCAwKTsKICAgICB9CiAgICAg
Y3R4LT5wa3RfZW5kc190YiA9IHBrdF9lbmRzX3RiKHBrdCk7Ci0gICAgaWYgKG5lZWRfbmV4dF9Q
QyhjdHgpKSB7Ci0gICAgICAgIHRjZ19nZW5fbW92aV90bChoZXhfZ3ByW0hFWF9SRUdfUENdLCBu
ZXh0X1BDKTsKKyAgICBjdHgtPm5lZWRfbmV4dF9wYyA9IG5lZWRfbmV4dF9QQyhjdHgpOworICAg
IGlmIChjdHgtPm5lZWRfbmV4dF9wYykgeworICAgICAgICB0Y2dfZ2VuX21vdmlfdGwoaGV4X25l
eHRfUEMsIG5leHRfUEMpOwogICAgIH0KICAgICBpZiAoSEVYX0RFQlVHKSB7CiAgICAgICAgIGN0
eC0+cHJlZF93cml0dGVuID0gdGNnX3RlbXBfbmV3KCk7CkBAIC0xNjc2LDYgKzE2ODMsNyBAQCBz
dGF0aWMgdm9pZCBoZXhhZ29uX3RyX2luaXRfZGlzYXNfY29udGV4dChEaXNhc0NvbnRleHRCYXNl
ICpkY2Jhc2UsCiAgICAgY3R4LT5wbXVfbnVtX3BhY2tldHMgPSAwOwogICAgIGN0eC0+cG11X2h2
eF9wYWNrZXRzID0gMDsKICNlbmRpZgorICAgIGN0eC0+bmVlZF9uZXh0X3BjID0gZmFsc2U7CiAK
ICAgICBjdHgtPm1lbV9pZHggPSBGSUVMRF9FWDMyKGhleF9mbGFncywgVEJfRkxBR1MsIE1NVV9J
TkRFWCk7CiAKQEAgLTE5MDIsOCArMTkxMCwxMSBAQCB2b2lkIGhleGFnb25fdHJhbnNsYXRlX2lu
aXQodm9pZCkKICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCB0aHJlYWRJZCksICJ0
aHJlYWRJZCIpOwogICAgIHNzX3BlbmRpbmcgPSB0Y2dfZ2xvYmFsX21lbV9uZXcodGNnX2VudiwK
ICAgICAgICAgb2Zmc2V0b2YoQ1BVSGV4YWdvblN0YXRlLCBzc19wZW5kaW5nKSwgInNzX3BlbmRp
bmciKTsKLQogI2VuZGlmCisKKyAgICBoZXhfbmV4dF9QQyA9IHRjZ19nbG9iYWxfbWVtX25ldyh0
Y2dfZW52LAorICAgICAgICBvZmZzZXRvZihDUFVIZXhhZ29uU3RhdGUsIGhleF9uZXh0X1BDKSwg
Im5leHRfUEMiKTsKKwogICAgIGZvciAoaSA9IDA7IGkgPCBTVE9SRVNfTUFYOyBpKyspIHsKICAg
ICAgICAgc25wcmludGYoc3RvcmVfYWRkcl9uYW1lc1tpXSwgTkFNRV9MRU4sICJzdG9yZV9hZGRy
XyVkIiwgaSk7CiAgICAgICAgIGhleF9zdG9yZV9hZGRyW2ldID0gdGNnX2dsb2JhbF9tZW1fbmV3
KHRjZ19lbnYsCmRpZmYgLS1naXQgYS90YXJnZXQvaGV4YWdvbi90cmFuc2xhdGUuaCBiL3Rhcmdl
dC9oZXhhZ29uL3RyYW5zbGF0ZS5oCmluZGV4IDBlMTNiN2M4MzEuLjI2YmViNTI4NWMgMTAwNjQ0
Ci0tLSBhL3RhcmdldC9oZXhhZ29uL3RyYW5zbGF0ZS5oCisrKyBiL3RhcmdldC9oZXhhZ29uL3Ry
YW5zbGF0ZS5oCkBAIC0xMTIsNiArMTEyLDcgQEAgdHlwZWRlZiBzdHJ1Y3QgRGlzYXNDb250ZXh0
IHsKICAgICBib29sIHNzX3BlbmRpbmc7CiAgICAgYm9vbCBzaG9ydF9jaXJjdWl0OwogICAgIGJv
b2wgaGFzX2h2eF9oZWxwZXI7CisgICAgYm9vbCBuZWVkX25leHRfcGM7CiAgICAgVENHdiBuZXdf
dmFsdWVbVE9UQUxfUEVSX1RIUkVBRF9SRUdTXTsKICAgICBUQ0d2IG5ld19wcmVkX3ZhbHVlW05V
TV9QUkVHU107CiAgICAgVENHdiBwcmVkX3dyaXR0ZW47CkBAIC0zMDIsNiArMzAzLDcgQEAgZXh0
ZXJuIFRDR3YgaGV4X3ZzdG9yZV9wZW5kaW5nW1ZTVE9SRVNfTUFYXTsKIGV4dGVybiBUQ0d2IGhl
eF9zbG90OwogZXh0ZXJuIFRDR3YgaGV4X2ltcHJlY2lzZV9leGNlcHRpb247CiAjZW5kaWYKK2V4
dGVybiBUQ0d2IGhleF9uZXh0X1BDOwogCiB2b2lkIGdlbl9leGNlcHRpb24oaW50IGV4Y3AsIHRh
cmdldF91bG9uZyBQQyk7CiB2b2lkIGdlbl9leGNlcHRpb25fZW5kX3RiKERpc2FzQ29udGV4dCAq
Y3R4LCBpbnQgZXhjcCk7Ci0tIAoyLjE3LjEKCg==

--_003_IA0PR02MB94868A441EB2706DDC7DC3DFBE732IA0PR02MB9486namp_--

