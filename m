Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C5C97F3908
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 23:12:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5YxG-0005Wq-Sv; Tue, 21 Nov 2023 17:10:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5689374ac6=volodymyr_babchuk@epam.com>)
 id 1r5YxD-0005S9-Hl; Tue, 21 Nov 2023 17:10:47 -0500
Received: from mx0a-0039f301.pphosted.com ([148.163.133.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=5689374ac6=volodymyr_babchuk@epam.com>)
 id 1r5YxA-0001bK-9f; Tue, 21 Nov 2023 17:10:47 -0500
Received: from pps.filterd (m0174679.ppops.net [127.0.0.1])
 by mx0a-0039f301.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 3ALJcd1F031085; Tue, 21 Nov 2023 22:10:37 GMT
Received: from eur03-am7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233])
 by mx0a-0039f301.pphosted.com (PPS) with ESMTPS id 3uh0hhgrv3-6
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 Nov 2023 22:10:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKAcpyAEZXDE16zBn8ggH2w5dEMvrBkgdFvNLD2b4E+dxSPkPB7lpE+amKlUT+Y4ZB9fVgUWpTCkRENcRIOFGlo5n1Ed97r0GY45YcKDS2HsF1Gcll44smexJO7Sx3fT6J+g1X8bAa4tE0q9RJhlCC+ifskQD5qMQUrA4dQYvp4yOdO+0+gKPUmlk76aaAxPZ7+kr5dSm3obsngj7nHvsh9uWdfCO3eRDYNRvSjjaygG5GtRUqjwri3WtL6jneKrDP9M5AOm8UBXNlOps7f2zy8S5Y9mhn2hSov9FtETOSezWTh+SoPrbCOsBJY3IJ3IjyJyRAFN7/yZPrlzHS/KUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CaOBkFCMmuEScm/QQeDLhJOz4phbpzFdrHGi97vhBfA=;
 b=G/yWGX3OftUthpyj9GUQkcwShxm8YyJi68LqKIy3MPAPCxZcfV6I+pG0ZtCk7dtrsFWasE3rDh3hHDUPXIpvIjyBDaDukPJM45jMJR7Mhi6a9xBRbO3g/dC7Zvc+rBa20Z2D6oJNsDzhfa47gVPeX9CJXUmRlXXvhsAwvY/V1u1TNukCDFNRsSGWM722giyHYFQWJNw+lFOPKfIOsxImbFQTQfuSoMhi4d+/phF2+aZmVhYjNk/LYD9qePjf2/E/O55IfhR+iXzcRGTRD0JUztPX/WaUSQJp4vU+2mNHoSPAWWws2yj4moC2DD5lqYKbSdNXZO+b6PXEGOCkVGbyPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CaOBkFCMmuEScm/QQeDLhJOz4phbpzFdrHGi97vhBfA=;
 b=mXIHPiTzVzKXyqgAWbpkLKhh7Kdz3CMEtxv7QjpnCIvArbG6cSgZ+fKBYGNA8PhDHdBbTBx6HQRlMwYP0IfWn1EGKN+8oNnD4pOf9NQPhOAwG3l7BPfT9a4u6wYvzNREiOrdYhhyNu7lxFQJ00x3OL9wHUVs7BRpDlOWNOrTerfmJru4u3ulHJQs3x+eBMN4isOKp1JciU4k0bTC4TXlANUCSoq2RcS1xlGbVjUghq4TdJtOi1QO1zXHDmGUoQvCMwTXSrHbJWFK2KoBVyh3rpYAg6mTN0yY+hXEG/XuHSPYQaxNQrYUgUfoJhlysT2Z8s8cThRzz5htbQWlnIMF8Q==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DU0PR03MB8836.eurprd03.prod.outlook.com (2603:10a6:10:40c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Tue, 21 Nov
 2023 22:10:29 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%6]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 22:10:29 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: David Woodhouse <dwmw@amazon.co.uk>, Stefano Stabellini
 <sstabellini@kernel.org>, Julien Grall <julien@xen.org>,
 Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [PATCH v2 5/6] xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in
 xen_arm_init()
Thread-Topic: [PATCH v2 5/6] xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in
 xen_arm_init()
Thread-Index: AQHaHMeJPOinN/4s8Ua2FsufYnZh4A==
Date: Tue, 21 Nov 2023 22:10:28 +0000
Message-ID: <20231121221023.419901-6-volodymyr_babchuk@epam.com>
References: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20231121221023.419901-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|DU0PR03MB8836:EE_
x-ms-office365-filtering-correlation-id: cf6a73ab-b075-41e2-c84a-08dbeadeac0c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tZ0c6sTf1f0ONpg+Ms52egNa76AgDXSbLzbMYM4bqlh4ooToHYP1mb74EN5tw/gW1rP/pFCmGBj2xk6iT8tWTuT7BiotafC7qBDhZSAdUXERsGahPGujpm3p5HM8YHPz00frDYzCYNeORxWh2ZjHsh4wlmFg2YgWbyJobllkRWMMnQT8tWL8nPEBiIn100KANcWHsp+qTpQIHqlvt6jtRFl+6jJzML0PFSJ0cMg1mBZzuhp/xXROmohZG7kQWAKzHt9yJ7U1h9TlSsFfEsWZ37h2fTQC6LFJSzgco33+Ld+DR41irx1UWqFfnflnRxZ6weH8Dv9StyjMg0EKxL6l6I1AkMUZVIIBJfEwVwG1bVKE+9FCCDpqIsrlxgbIlteCsFAQNZU9pG1MINkiiFDPJPo5NBWPz0Io3rPTkp3ZZHuaRZFYI67axmJPp6PxXynU81qGcgAruu3gkjlw4Wwpyu/rNfUq9thbqqcADyV0tRnhHH93r3GGoW9fQFfwcyq5+o2U6Q9otxMrro90IIARRp8Wh5fMS6xSltmJa3iYyPzRBMPmzj+vc2rE2xmEvhQCSMM2LjhP0BG9M1OTm+3vJPxtCZuaFf/XdmdoIlMYBp/+PJi5K7UX0VJ+XEaPjBGi
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(396003)(136003)(39860400002)(376002)(346002)(230922051799003)(451199024)(186009)(1800799012)(64100799003)(41300700001)(86362001)(36756003)(5660300002)(2906002)(38070700009)(122000001)(6512007)(2616005)(6506007)(55236004)(6486002)(83380400001)(71200400001)(1076003)(478600001)(26005)(38100700002)(91956017)(66556008)(66446008)(316002)(66946007)(6916009)(64756008)(54906003)(4326008)(8676002)(66476007)(76116006)(8936002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?uXpwSJVWgS01gHJc7j1HShLyJTjJVcx3NBppdhsHKtP0nLNZ8OY0Wkh10c?=
 =?iso-8859-1?Q?Z2gThefyfXgwpV6dGf7Qs/LOGErZ5VcdM1h/Zwkxga0rsCob51al4942Eo?=
 =?iso-8859-1?Q?ihSpLuA9ClBp+VPodnNsflSt4jOd1yU+Ow2V7WtDO6Um60YofZ8Ksulo59?=
 =?iso-8859-1?Q?G2JRTftIT8a/HcsM0UodOhiouxcgE6UqGb0vR7PO5SlNA1A/9uoAU2IszF?=
 =?iso-8859-1?Q?wa6TAEfizAtyRNdiY1NCB06z4aTfmxSRKs6dtO/SlxlBbCFcCnj8KZSO/k?=
 =?iso-8859-1?Q?qsyvtvrDBb5SBDzpa6ptgma5WAUlepzgntlur1mIBKyPUl6bjS6gWl0Hwb?=
 =?iso-8859-1?Q?cE3hFuZsXPW3lg4jPqckDNF2y/QH5sNF4N1FlFNjapSmLuCrcP0v99MQ7Q?=
 =?iso-8859-1?Q?5ItMOB0Ih6VZNB6ZBZy6y4sXFx3i5jv6MZgWRVeAD1KnBs7hSyRGFUmo7s?=
 =?iso-8859-1?Q?HcwHZ77gUP1R7zVm0XR5bEx58EK20RjRXNOMsylIio0/TMG7rLbXue0aMG?=
 =?iso-8859-1?Q?oCFex+gGWJwFiH3eQBvpt6Mss1+s7CQS0OpwH3t7nQ+6mlih1UruKIFDiJ?=
 =?iso-8859-1?Q?jUYuc6W40GHVHppb7dpo6e0lARSjWeQXyRfUHDdelvICYUEmb0JK+wseEV?=
 =?iso-8859-1?Q?fEZ1LRLxg1bUUzY557iyfhBzdL5ZokyTwmVL8lQNGa0Zmc+uSG4ZsQbgBk?=
 =?iso-8859-1?Q?ozkMCpARdg5KvPPdTZaqJrzjMuGKyGPeFIURhsSTHuvw27n3uHy570JAb7?=
 =?iso-8859-1?Q?bIPEz41f6vgmJM+yq4ydh1c5rqqoYZLwjJpG4AO3o21tY6qbn+iy6PtTXi?=
 =?iso-8859-1?Q?bkJEz94e4M6SQ12veNWfpXw4zYdtgiJlJUbZJYEUW43VQ2N5RadUItloJ5?=
 =?iso-8859-1?Q?vB3i3Y7gJKMFnRstVl/1j7wKzs93oyunc/j3GqYtthX/C6mk8TTc+tOlGu?=
 =?iso-8859-1?Q?YXl9o0Yt7ZUNCiv/rHfojoO/B0Lfa4EVxfmbfk/M17KsNjaNxjRJF+yMwV?=
 =?iso-8859-1?Q?DY2a1CfV+TJJl6pzaJWoPw8PCz8++3eBs+pYXbmGvs849Fz6P9wT7MAHVm?=
 =?iso-8859-1?Q?jk+sRqz8R8rcuRjhbwQP6aZ/mHV+y/GQ4a3nZ3JD5KHniMRgFTnDvzhvid?=
 =?iso-8859-1?Q?myS/U0n3OBG4OjCfXHGwsfFRwYqw6HuRGj7b6Cftu/YReQVVGEQftFj+20?=
 =?iso-8859-1?Q?SCvkuoaKLYgO2LdA8R+88XYElGXkxycb3o5kzZv7vV+OqihcuY7A3B6987?=
 =?iso-8859-1?Q?DtAOenNaaAVUfN2GVEOrTuWA10goWdQMfbKh/CHT7JPYbK0WJ7DtmLJNhk?=
 =?iso-8859-1?Q?bqbkbpC6prrFKc+l89vLMMV3CYxMGHEmGorsr5y3y0Zs5DjabR1FFhI1kk?=
 =?iso-8859-1?Q?EP9FlSkTyovRjBF86I/0q0iGqGjg2T6E0gdDOxA6AePXVI0vEM0IqtePtN?=
 =?iso-8859-1?Q?la9WWwz0+7Rw8vyTc9txuxWziDy/zPT0sutRgIByzXbJ5WpFfQ2TyXRDv/?=
 =?iso-8859-1?Q?YPPM69pp06gprkHodwV6YbP3v97D4asbJJE+d5+1h+ZzSTUFN72QEB/cRu?=
 =?iso-8859-1?Q?Dxf2d9/lpTqD7bCH0zeXzLJbPTphldZ0HSU0fvcq1hP1Zwjg73kTraWSGh?=
 =?iso-8859-1?Q?Ld+cw0rBsNIdyNMzSSbpGvhnEWpHhX6ZaOQvOIZbIGlMOvr1Ir5OXV/Q?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf6a73ab-b075-41e2-c84a-08dbeadeac0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 22:10:28.4682 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ij2NdnIf/X4e0quBWY/QuS4bRPK0Dj04HZtqxU0pSZYYGMDo8ZaKuxM6fecacZPhVpx1c4CmXev+yxLKSSKzooi/a388Oo5gLcQPiFU48H0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR03MB8836
X-Proofpoint-GUID: jyXU3_qtO9KUIEeBKVo1c3iN_2BWT4-0
X-Proofpoint-ORIG-GUID: jyXU3_qtO9KUIEeBKVo1c3iN_2BWT4-0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-21_12,2023-11-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0
 phishscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 mlxlogscore=999 bulkscore=0 impostorscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311210173
Received-SPF: pass client-ip=148.163.133.242;
 envelope-from=prvs=5689374ac6=volodymyr_babchuk@epam.com;
 helo=mx0a-0039f301.pphosted.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

From: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>

The number of vCPUs used for the IOREQ configuration (machine->smp.cpus)
should really match the system value as for each vCPU we setup a dedicated
evtchn for the communication with Xen at the runtime. This is needed
for the IOREQ to be properly configured and work if the involved domain
has more than one vCPU assigned.

Set the number of current supported guest vCPUs here (128) which is
defined in public header arch-arm.h. And the toolstack should then
pass max_vcpus using "-smp" arg.

Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Signed-off-by: Volodymyr Babchuk <volodymyr_babchuk@epam.com>
---
 hw/arm/xen_arm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/arm/xen_arm.c b/hw/arm/xen_arm.c
index a5631529d0..b9c3ae14b6 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -231,7 +231,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc,=
 void *data)
     MachineClass *mc =3D MACHINE_CLASS(oc);
     mc->desc =3D "Xen Para-virtualized PC";
     mc->init =3D xen_arm_init;
-    mc->max_cpus =3D 1;
+    mc->max_cpus =3D GUEST_MAX_VCPUS;
     mc->default_machine_opts =3D "accel=3Dxen";
     /* Set explicitly here to make sure that real ram_size is passed */
     mc->default_ram_size =3D 0;
--=20
2.42.0

