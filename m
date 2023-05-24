Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D96270FBE2
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 18:44:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1rZz-0004r7-4l; Wed, 24 May 2023 12:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1rZw-0004qc-Pk
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:43:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tsimpson@quicinc.com>)
 id 1q1rZp-0004R5-VG
 for qemu-devel@nongnu.org; Wed, 24 May 2023 12:43:12 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 34OGXgnX024619; Wed, 24 May 2023 16:43:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com;
 h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=qcppdkim1;
 bh=lUFqDSABd8Hp4dd0eJZbqgcD8OgFd5pAFI8LZYxChFc=;
 b=S1g1Bj1ydFletiPcNxxY3t/w7brGu7UUA4Lu+xttF/MXi7CH50Hg/c5na2nZrvneALCL
 aMhgKPN9W1xrlsw8KJn4AwB2WZ+k1ENF6bhvsXRmDCJAsBhRfR0baWsy7s13thvvJLHC
 4uqAzmkpW8IiZwsf/rgccqDVQ1/TuDd5lx/zJIvUEYVodEfvW7GOuRJr+w/xN0VOksM2
 cg46coW+Y9kwr0/eO59kQ44tS4g83RUwQnR8reS/gfWe4cJbQhcnUNnC1rtfSaN8Pwse
 rVuhAaVimjzE21kdd6n9cygx2c5tFOHd5dlUVBAba8u6Gx+PW970PmIuchJSnS/eU5SL kw== 
Received: from nam12-mw2-obe.outbound.protection.outlook.com
 (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3qsdhh1aps-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 May 2023 16:43:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=beDXm83DXdZvSQIiKt12O+L3rpDxNaa6zy8LhzR4vuz5w4yuWJH/aSLUitW9pCPNBTSjbuR9fWRNWEJi7mI+8yR0Py6sE/7B9vLnQo4rGNOEHi3Gdk+Pt/gQFc0u9eLdQT1yCMAOWnT0Pgzizs5A0CIJkJjNZFOnxB/LkdZhfstlMCYVH4jb3A4qlw2zeGS4T3tlt04oi60yg6YPH5d6zNiz5QgnF/hDc/GbsSTKk3o+2Dwrb+b7fYalxe9i9cp5ck/Ou5tEzNhagZZp3QsdJ7SWK+CogSJW0TMuZHll4Csp9EI7EDVsddC3HJZnu3usenRUMA4g1ms/0TzCzmU5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lUFqDSABd8Hp4dd0eJZbqgcD8OgFd5pAFI8LZYxChFc=;
 b=JC6U1BUCmbQN1Qs3LosVVGwpzZgoZn8An4t3kTBwKhl1uFQSRxbJIpLmAX7JkxCIQehbxwraZaQin+NXB2P8/m+mFlkTNaVIOUOFzfTSzLkZnHtE02zg5jnYxss4M3vPFyb7zYTrqnJ37JAVqwIxhKD7D25GcCfmrsEUbJgdEZfUQz5Zdkt+DWirzYoEVSkM3BYL0Ui/MRfYrhzUbhEDyWs9ysniWmtOoOmZ5zaukfNetMrhFKcG1lu/zm00q50XigxZKpOOTWeoo7iJfX1RrKwnZLwQsTq9gVWIoA6PWyT0E/T7VJ+RxcxfcV1/NId8Lk/6ItPNoiAvqpteJFJ8PA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 (2603:10b6:806:203::12) by CH3PR02MB9068.namprd02.prod.outlook.com
 (2603:10b6:610:148::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Wed, 24 May
 2023 16:42:58 +0000
Received: from SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5]) by SN4PR0201MB8808.namprd02.prod.outlook.com
 ([fe80::eb63:d1c0:28de:72f5%6]) with mapi id 15.20.6411.027; Wed, 24 May 2023
 16:42:58 +0000
From: Taylor Simpson <tsimpson@quicinc.com>
To: "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Brian Cain <bcain@quicinc.com>, "Marco Liebel (QUIC)"
 <quic_mliebel@quicinc.com>, Alessandro Di Federico <ale@rev.ng>, Anton
 Johansson <anjo@rev.ng>
Subject: RE: [PATCH v2 1/2] target/hexagon/*.py: clean up used 'toss' and
 'numregs' vars
Thread-Topic: [PATCH v2 1/2] target/hexagon/*.py: clean up used 'toss' and
 'numregs' vars
Thread-Index: AQHZjk3ibgZZa44q6EGIj+Uxsj1LRK9pgOig
Date: Wed, 24 May 2023 16:42:58 +0000
Message-ID: <SN4PR0201MB88082A79E523A81F8BE17937DE419@SN4PR0201MB8808.namprd02.prod.outlook.com>
References: <cover.1684939078.git.quic_mathbern@quicinc.com>
 <3ffd4ccb972879f57f499705c624e8eaba7f8b52.1684939078.git.quic_mathbern@quicinc.com>
In-Reply-To: <3ffd4ccb972879f57f499705c624e8eaba7f8b52.1684939078.git.quic_mathbern@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN4PR0201MB8808:EE_|CH3PR02MB9068:EE_
x-ms-office365-filtering-correlation-id: 8ee1dab4-331c-47ce-5739-08db5c75ee44
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zsvEHwp5kfDmMkREc8LrRSfei49NRf2ux8JHc0xtVm9Md8pHTkqWE1NiJu4wpZ4GA7kPflVc5D1wyZM/iScsvPri0iItskICa9Fq41tStb3vBxQsjfCnDaRROQKcZfULHg+J5pH6zKW6l9Li4X1uEOs812zXOUe7esVoh2LUzPJ6UA6ZNApraE7CJ8bFFE9tXCTTXnzfZN2fB3ctQ+oYlqqz1NZiVMbMYpZfE+NStmjvrQgvmdQprr8taNsLmkD8SqH/Doy8Sve584o7mYL4/1WaKc+EXj1d/VbPhSazcfvpOLfHajmvB0Wen8vl77vfkbZs4Np9vZOwG8TZdU2CVfaxGEPi6n6B3DBrJLTYw3plNtYZcXygwV3hTaIodVH8PUCsfeqtvp/WlMoJKcR1iMbhHEc6uXdN4EaeUMqojZDgcvmitO3OvL6AGbuIYejmz/cOZl+ArQkO9dGFlJuMAl9p3RRLJSmb7AlEJaUW1vXCqbyjtL2tcNyuNvDiD5gdkfbioS+lxoRtwCsLad0kAI8Vbbd2o5s0I2TH9XpDYyFr5aP/tZDYUV6NKEqUd3rniNmgeippt/qaK3KOQmZadHuj1NYObzD+j5nJ9JtansM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN4PR0201MB8808.namprd02.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(39860400002)(136003)(346002)(396003)(376002)(366004)(451199021)(71200400001)(66556008)(64756008)(54906003)(110136005)(66476007)(66946007)(66446008)(55016003)(6506007)(26005)(76116006)(316002)(4326008)(7696005)(41300700001)(478600001)(8676002)(52536014)(5660300002)(8936002)(9686003)(86362001)(83380400001)(2906002)(38070700005)(122000001)(38100700002)(186003)(33656002)(53546011);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?WwUMY3HSIRxkz1XediUe9avS4eCmgvNJTLB7JSe956qAwQCr95pi1/H1Qakk?=
 =?us-ascii?Q?IsksG20ayMooaZZjNulXLuUvkxHEf/JVUD9ee+e9U2pKO1mA51SIP5ABAHQZ?=
 =?us-ascii?Q?19Y8muThQvem1BvVrbSuKcP8CPlb3IirmqHCumgDBTNMK5FM5IaXZRkSW3Rf?=
 =?us-ascii?Q?nw0xte9jnP+we6D+yuzm7gC5YLRVoIb+uzoVTKOhKfgnXWo1l0ro2p4OpejA?=
 =?us-ascii?Q?D3uYPsRqrrDcS0CCzmHSwLZR84TGv0xPMD/cPIQ6KLcm4+PxXE6fGR8EyJjH?=
 =?us-ascii?Q?W8Ert//8EHQYC4Rld5KbJ8x3E40KOFOvSCJL3ClfVPxX9Sh+MpgAehB2ZQb8?=
 =?us-ascii?Q?T/rclcMu/y4i5VZna+Au94pP2Stx5hFfTt2ZqeZmW1UnPJlMfEX52urUXHRn?=
 =?us-ascii?Q?K6F3ByWgNgUwOygdy14OsRLUgeydtO5eyUai4GPK+ZOjJ3jAykUuM/fbgcLV?=
 =?us-ascii?Q?RGnthB60b3e4n0gwNlDAZ9YDf8eN4CCylF4nn+1PmFXj3feHVJYHC7OkN+Jq?=
 =?us-ascii?Q?bbv66AGlJoFP/fet14Ygqh0gm4MiySYV+xUyS3Kk8xwfLks/vpT4wk5q0IQt?=
 =?us-ascii?Q?vSXCGducmMEAYuR86dPdugjkGdVE0Gl/sqLmagZgA4R/bB+uYSUkH6GnEkfN?=
 =?us-ascii?Q?dPKxGowOxXUC33X8oymp5LaJoGc3Taa/cPgeKukUK0YzEqPe+QWN8gw7jDDR?=
 =?us-ascii?Q?aqhTFySD7uqkYrmyZtWzgT66/n+ct92j7cQjN8w++F5NgxD9Fsr9YZuxy/cB?=
 =?us-ascii?Q?CujS36fIOqMsW5FaCvvTfRdtFHHnraY/Ie9nYboMMnGPi48Ooyz1+NwoxscD?=
 =?us-ascii?Q?GFMemMnRsLvUfOG/C1sQuXuP2NTd4hfjSRBZXgm5t1mwpoO/xL0W/0Q07/im?=
 =?us-ascii?Q?imdXNS7KKgSOVcUe+tbuQGynVLOBae4NiKO2BD9OjHUaBwAy9UG/LV+PEBYi?=
 =?us-ascii?Q?5kAQecN/WefBp0l1kKvhq0D7CDqFFJ2DRMORVyK7XXrAyq9kEi+Lh4boL6s3?=
 =?us-ascii?Q?TyxjdIfiVbSzpSxnCEuKsRp1iXe+MBySH/4kKpxRERQyVw625hTFtPmQMmI6?=
 =?us-ascii?Q?Qu8qeTr8aXyAE2rpMiC3we20HUwoN6Zoe34FFdGF3SLjsLJq23FszIx6YEcw?=
 =?us-ascii?Q?zIEf4HW+dsZVYw1es1RgzosjDLhyiEH67f/zJbX07ux6E3IbHov9vZl1yjl2?=
 =?us-ascii?Q?ypWSqjixCJPZN3A88Xp3BvavBha5e6xoVdP/UeruiJ+vZNLPGVxJDjyvfXOf?=
 =?us-ascii?Q?nkZVAuCJfNPU8c05iShG18Je33oQ1xtEaqL3Lf2WfKrPlYVpB5F5lvcUHIjI?=
 =?us-ascii?Q?E0/+yu9CfPkZ0U0b6GcCNdX39nbLN2c0MQQzWtYpvo0GxPn8jrPh0DJ8iDVo?=
 =?us-ascii?Q?wb7PjDUvxTmGY9KOa91vMkZAdPdCB9l0x4q1njKX2q7DlbgilAipSXPL5XO5?=
 =?us-ascii?Q?+tu4Ko39vKzEto31sip5dfvdPbrEVBNSMu+QPpyT8lPoTfP2hpYHyotU02Ya?=
 =?us-ascii?Q?k39oLoIe0sKUn8X5XR17jf9uazzgxP3ZWGsEbHJW6alQfiNZ+e+eVqiV2ZGB?=
 =?us-ascii?Q?CO4TgDyQvccmR4YpqD5Mvw2uH42LprCMBfuC6cE5?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XzjQZLnh8f5g4NAi4O1eWQ8atpw8G6pSwWbGJBTFvOcJsxSbymWCdytmlA0BwiXTDNs/U3LSvks+75+CIf+Dkl5wTSC0Xs8mN2s4nXNfRfN50tYbL6eZTFFP5cJoovT7ZpxYyUH7PLnsR3Eiea8HbepaEsWIqTamMglrmjlhO5H1yj12BV5fVHhaWZPFurfEhbd1+T3fT4mwjE91/we/oNvprHG+Khi6f8UILh9SvrkBOWzU2yIvhPMnpIIaDKyQb7/BuvSA75GcLp+sHahwis8y4IyiVvLvlMTHDnrr2UyP9q1EPun95lV0a55U34VpYmkfCzne/z3brbzG1uS2GK5U2gz52v3dGK45YiZAFi73Y1L2suWkbBDYF+Ru4w3SxP7pYyzc29WgOzJTNHPdSuY1iT9wUpOVvtGOj1mnj0zGB9wjJ9/ePNt7b6KcSaDOzSLn9EKFw2Bqrk3GGEBohyL6Vh8zCC+SLEqGPfNwEJS5TeiDwneDcgf7/tzH8bNeRlXqIzdiHB+oIkKdhQzkx/uKeQIcrBGJqImYpQdxVqwXLjco7iCmx6uI4pYdkfxt1RBE/VLZfcHIVKl0i1wQV20OUOhnZWtzvpv7OLvjDOf59tPHdUOcZ4tbC55XKM50mkP+K6TcKAYZ6xEJzZ4P9QAqVS7ptLvAwZusDfivdojLAprUjUnmPmcWxxWvnkGAJe58367xZaGU1Aw77sCnvO/CwsXg72Dfj80cC/TneQpdg9WsVNBpKnaDvRSWL3sDmOZwP8R77Bjfyf8WMFQZhgzeOwrW49L1bQ1f9USssio=
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0201MB8808.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ee1dab4-331c-47ce-5739-08db5c75ee44
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 May 2023 16:42:58.1371 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DS2XSq+m+40lxhOrczYHqSW4YF6CDyexZFyGW41HEWLh7VU8UA+zQ2JR2CPVb5LUMuv4a/yFY+DpuF6+k4V2Dw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR02MB9068
X-Proofpoint-GUID: EZTdDj7Kb5qyMIQXcqDqYnsDZF4MY5_C
X-Proofpoint-ORIG-GUID: EZTdDj7Kb5qyMIQXcqDqYnsDZF4MY5_C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-24_11,2023-05-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 bulkscore=0 spamscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 phishscore=0 impostorscore=0
 mlxlogscore=550 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2304280000 definitions=main-2305240138
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=tsimpson@quicinc.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> Sent: Wednesday, May 24, 2023 9:42 AM
> To: qemu-devel@nongnu.org
> Cc: Taylor Simpson <tsimpson@quicinc.com>; Brian Cain
> <bcain@quicinc.com>; Marco Liebel (QUIC) <quic_mliebel@quicinc.com>;
> Alessandro Di Federico <ale@rev.ng>; Anton Johansson <anjo@rev.ng>
> Subject: [PATCH v2 1/2] target/hexagon/*.py: clean up used 'toss' and
> 'numregs' vars
>=20
> Many Hexagon python scripts call hex_common.get_tagregs(), but only one
> call site use the full reg structure given by this function. To make the =
code
> cleaner, let's make get_tagregs() filter out the unused fields (i.e. 'tos=
s' and
> 'numregs'), properly removed the unused variables at the call sites. The
> hex_common.bad_register() function is also adjusted to work exclusively w=
ith
> 'regtype' and 'regid' args. For the single call site that does use toss/n=
umregs,
> we provide an optional parameter to
> get_tagregs() which will restore the old full behavior.
>=20
> Suggested-by: Taylor Simpson <tsimpson@quicinc.com>
> Signed-off-by: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>
> ---
>  target/hexagon/gen_analyze_funcs.py     | 10 +++---
>  target/hexagon/gen_helper_funcs.py      | 30 ++++++++--------
>  target/hexagon/gen_helper_protos.py     | 22 ++++++------
>  target/hexagon/gen_idef_parser_funcs.py |  4 +--
>  target/hexagon/gen_op_regs.py           |  4 +--
>  target/hexagon/gen_tcg_funcs.py         | 46 ++++++++++++-------------
>  target/hexagon/hex_common.py            | 24 ++++++-------
>  7 files changed, 70 insertions(+), 70 deletions(-)

Reviewed-by: Taylor Simpson <tsimpson@quicinc.com>
Tested-by: Taylor Simpson <tsimpson@quicinc.com>

Queued to hex.next



