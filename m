Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 636767E8522
	for <lists+qemu-devel@lfdr.de>; Fri, 10 Nov 2023 22:35:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Z91-0002SU-QK; Fri, 10 Nov 2023 16:34:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56783987ff=volodymyr_babchuk@epam.com>)
 id 1r1YKr-00015R-CQ; Fri, 10 Nov 2023 15:42:37 -0500
Received: from mx0b-0039f301.pphosted.com ([148.163.137.242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1)
 (envelope-from <prvs=56783987ff=volodymyr_babchuk@epam.com>)
 id 1r1YKp-0003I4-L1; Fri, 10 Nov 2023 15:42:37 -0500
Received: from pps.filterd (m0174683.ppops.net [127.0.0.1])
 by mx0b-0039f301.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 3AAKI1MR020361;
 Fri, 10 Nov 2023 20:42:33 GMT
Received: from eur01-he1-obe.outbound.protection.outlook.com
 (mail-he1eur01lp2050.outbound.protection.outlook.com [104.47.0.50])
 by mx0b-0039f301.pphosted.com (PPS) with ESMTPS id 3u9jbx27f5-2
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 10 Nov 2023 20:42:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOK36g/Pl2ODq37wiWTkrdMQbE0ICJRGgAJkbBIPbpqWkZ447Chj9frPNCX32xQRy5aqDjKpes9J2qhVeQGM1I3j8GpcR/C1S4IMtY+luQ+R88WpuQmK29cE39GqKiAT6UEyl0zubAVqtf1npa4z0SklEoUyuT0j7GrX61B4UeWk/n69UQzuk20rNUVcILjOSxZN3C/hznBeBDAiKjF5ld8bDgS1LAddIUXEk7nZ5NTZw5AXcDF8ILj+c/F3AUHXplzHK6ZZxhYd1cSbMxD3YZV1uIitr4qzbU9avSf+GAZM6htYVl9Z2RI1V8gVVpZ8KoUZcH4nU2xSqClhcjADIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MQhMXgI0DmtKlJZnPxUK5w6V43NeKKerokDdW5sHBw8=;
 b=Dl1h/EP9ius4cX/wtcYC/bBqVQUI/f93b4YupCKx+o4/oEKBtvrvBX8dTYWs68KhTZKim+ZQzUVVVqMiUD1kf0JOSv/npjmyiPOLqNZYzP8hvMqql3OzhxbmYw0MJKem4MWt2FKWZDlo4wrs2YbYtuTb87r3KO2a27oQRD4dUrGf38zGldJDv+CPvhvK8ZRlCefTp2vwAT2CzPXC3tJJQJi1E+9d7QYPjVGNsMCh6Nu/Jz/Y4+6KKBs1IMwhR4m/ATpOPhQBPqL5DDqPSOdxU6EyhOBRbGGAapi3VEGUGQsmCUxXuyF3lv+10fPQ6wajTkfVi6SEAtU2KTH3ED44QQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=epam.com; dmarc=pass action=none header.from=epam.com;
 dkim=pass header.d=epam.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=epam.com; s=selector2; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MQhMXgI0DmtKlJZnPxUK5w6V43NeKKerokDdW5sHBw8=;
 b=rDoEtW3/rDdGAlcLMWze7yFkMXvH0DZxH4MjVMIX7cj9EBhmzxbbcFIap2tyZPHrcrzNtkY1ujeLpNQNkl4wS2AiQ9VFsOxR0oHb6zlqvrTZRsBjxzMWcdOcOAQL6+fu+ouAIWQ5WbuoyXTiMk1qBWzPqnE1NMkSrVsnvvH3KCOfran0AvuT4elXuNGVMA9YmNd4pbeEpY9T3eUGxGeub/K8U9j4Q/bE2zeZsxPYgzvf1q8ju3RiwWNx/2xM6yJ5Z6ChgdE3pPPrOFTBq3FJ0SxTQzqrHvcZlQkjKoQn3urx5kQu7CLV8TA72bX/wROafRJCPNIOYf75jqUJs7g8Vw==
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com (2603:10a6:803:31::18)
 by DB3PR0302MB8991.eurprd03.prod.outlook.com (2603:10a6:10:437::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Fri, 10 Nov
 2023 20:42:24 +0000
Received: from VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822]) by VI1PR03MB3710.eurprd03.prod.outlook.com
 ([fe80::8e03:368:1fd7:1822%5]) with mapi id 15.20.6977.019; Fri, 10 Nov 2023
 20:42:24 +0000
From: Volodymyr Babchuk <Volodymyr_Babchuk@epam.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Oleksandr Tyshchenko <Oleksandr_Tyshchenko@epam.com>, Volodymyr Babchuk
 <Volodymyr_Babchuk@epam.com>, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Subject: [PATCH v1 6/7] xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in
 xen_arm_init()
Thread-Topic: [PATCH v1 6/7] xen_arm: Set mc->max_cpus to GUEST_MAX_VCPUS in
 xen_arm_init()
Thread-Index: AQHaFBZo7E1DnNqpy0eDQLoZ6N62MQ==
Date: Fri, 10 Nov 2023 20:42:23 +0000
Message-ID: <20231110204207.2927514-7-volodymyr_babchuk@epam.com>
References: <20231110204207.2927514-1-volodymyr_babchuk@epam.com>
In-Reply-To: <20231110204207.2927514-1-volodymyr_babchuk@epam.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.42.0
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: VI1PR03MB3710:EE_|DB3PR0302MB8991:EE_
x-ms-office365-filtering-correlation-id: 5b2aa615-8726-46d3-0eea-08dbe22d8b94
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pPMQlOKRU/1RzLzEprT9jsmzH0fENRAHQs6h3QmCJD6oC15qONzgUKuD4wGGYFGmDzj77aCUR+NdbgBglNE1rAS1Pn683L89BbluYLDEzOqVWbSz1R8IBQCx4Qv1QBoV6a845E2s5mseHo/L781ODsk7FmD9Q17E6N2UuC8Hm6fZgvC6MTzT3BIKYQV2EhRj54A+4gjndMhz2qx5AeQ/8BJYL3UnRYSumeyK842L6jL1vnEGEnWelIYrzXVtL/Dt/s/k9R5KnKVDAhGlOAn0LdS0B7C533+fmgkEWpzuCOxYhMxYdmNMiwnNAuFmpxQsqWl4yIRwl6GtP3trlj7z1wT01ONgITaggXN+gaSpBTOE72vFeFM3Lg8nQrwgH0caGup71JjQF13MVFqs0NhGcoB80X5IGA59rmM+UXB+A1KzhfUXdDLIiUvZtnA0aFfvS7tCnD4UvgJaoW/ZheM4PQEYVfxq/Y0YsvvSBEW+oE+KoUQhZrhZsfRqLLdVDoiCeBmFcXulUNyYZwxMxP3wrRQ/DkDYT5CZnHsWyOl9J3NgrrFdPhxpAf9NGdr/wS85nwrSKguC+t4JU13yT/FLzIYMmOnvrREjiz1Scl9wj0lziwOmIUVnYMvAY8RgdYsT
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:VI1PR03MB3710.eurprd03.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(41300700001)(2906002)(8936002)(4326008)(86362001)(5660300002)(38070700009)(8676002)(316002)(36756003)(83380400001)(38100700002)(478600001)(2616005)(1076003)(6512007)(6486002)(71200400001)(122000001)(6506007)(55236004)(91956017)(76116006)(66556008)(66446008)(26005)(6916009)(64756008)(66476007)(66946007)(54906003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?asAw3NgwFsmtYKl00ZdbDxpAG4E4dGtWv/b9m3Ga44sYDnSTRIYlnUBKQa?=
 =?iso-8859-1?Q?7+4vRArrW6i0e+M09DtS886Ak55OCwKr9eSjlof/9gjX40TWXpHiuY2Fod?=
 =?iso-8859-1?Q?TnnJpUVbceVFkP239mRO5ht/ie0gHSiGjakkoZuAl6DfFkMPZebkJ3Bety?=
 =?iso-8859-1?Q?85r47q04fRv4xuFU6DxQal9zsXeyiYYaCLjTKrfBA8lrylqqGoBbuWIUdE?=
 =?iso-8859-1?Q?A+gC6MCXmWTb6V98GopUyHyHHT9XTjrvNj+hjh7MpnHkoE7toQh4CimuGP?=
 =?iso-8859-1?Q?+0j4ALZZjH33I06qjCxotWHvGUHSyGfgn1coTmqxxFpw3wODEFWUcjzL0F?=
 =?iso-8859-1?Q?ahis0wbDLlQB6GIXG+yu0bUPH0BxX4w5U0KRwRqrY15gM6wJ6npJdU25/1?=
 =?iso-8859-1?Q?aWSugAdgT5L/hC/hml/CD/8dq26/zaH/uPSZRnq8llMeP/c25pklsBr/nc?=
 =?iso-8859-1?Q?xK0yuqN/kqvOdlPQuW/9/OQnRaxfuBkRod7Mqt83vi3SqTRbRSc9U2hrdS?=
 =?iso-8859-1?Q?SbCmkYjJO7Zv3TuyTwdvIy80Ke9g11GW2OZAOreLuI5ONHuO60YaSezFjF?=
 =?iso-8859-1?Q?1ym2I605+QxzDLeAhEqfrVbVzBNTKs9o4Yd1Abez5JwSjMFbmetx0psWrD?=
 =?iso-8859-1?Q?TD1o8G4QcPL6yJkLiXCsY/E6tdYI35creju/PPTwzGdQa0SoadfsoYD1r9?=
 =?iso-8859-1?Q?gVTbYKXULI1eL5lGuw/v5JefcYVrSEoVHxHqwztUJ28djOfM1tMSjMgUhq?=
 =?iso-8859-1?Q?OzZszi0tliTR505AB48xA1WBQd5UnesD+ZtGMwn2M2PpcMFDh1fH9+T2Ag?=
 =?iso-8859-1?Q?nrwummERDGCKnjCttgYx6oFvKR9uYeZfOQs3HM3XSfrwrPgsDuNbbfPlA3?=
 =?iso-8859-1?Q?8rUCjWzcvSPIM24tWh8ijnxI4HXbkMbYrzLEGf5N350cTtcjRnRapFFufo?=
 =?iso-8859-1?Q?Uq47MSB7CS1Itt0nlPBNTebkLr79oXg2ky+oFxEMSrwnv9CnDJw6QP5b0R?=
 =?iso-8859-1?Q?ZLvEaf8zloK4kH2n0n0xs5OwNdcRUB1Ks2vaxU9C8D3dbK3atop7QjFkIg?=
 =?iso-8859-1?Q?3y09KImLyGFRqbHrsbRhJX9cezPWVhLV+GRMzla8ZBatoskQPzI7WrBMIG?=
 =?iso-8859-1?Q?BaaLiG+esexqEifFxMd/t2jSEgelQ3kSU7zNfIMboXbXOGHq88COTBmTKO?=
 =?iso-8859-1?Q?7W96IFsnR49Epc7q1A9DbvFQgn4ojYKLBT9oVlsuVTwzYgPHM1bJA7P8Vo?=
 =?iso-8859-1?Q?oBNgJdhF5ZlAmp6Rq0Y3a14gMyqB6TYssV/t3w4euTOax7JlN9ZFgwKtjH?=
 =?iso-8859-1?Q?0HPFrb7zTW6F30yje00wGUiYdOVh+m63iHkYlXNHNOrNwTvaj96+G8vG+g?=
 =?iso-8859-1?Q?/tMiAsI/6EACbB8S20y6HoR9p5BO/rCv9kA8nZ6QQIj1SjXxjJKf+vc7Tf?=
 =?iso-8859-1?Q?2lwy3FRRbv/e+MyjTqADrVTr7+F68piZKWjh9x61ZNYxCKf4uianK65n2A?=
 =?iso-8859-1?Q?t4J4idpaTb5zAIrMWZJTf24oLVUr5aKpY7m2Zri3OEGn/1WxpUqYnQfb8a?=
 =?iso-8859-1?Q?t8YVn8uwrtHsKdb5pK7uu1Ya9/pMKJy+u6tF1RyBXzokgZjUlp2vcsGx26?=
 =?iso-8859-1?Q?VKUoPs/+vDGhHwExvk5QgdPXlfV/9gTz90fjfIP/0Mmg//UpE20ivRuA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: epam.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: VI1PR03MB3710.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2aa615-8726-46d3-0eea-08dbe22d8b94
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Nov 2023 20:42:23.9150 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b41b72d0-4e9f-4c26-8a69-f949f367c91d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0/ubqvU/d2GXaIFjsFkYPxjdN2sXXTDT27SD1aY3nVyuLkr0x1sNbmQFd5INbF4E1+kTbLaoXQ28GppU3xDF0fXNaO9P0lPPlhb5bxHTxgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB3PR0302MB8991
X-Proofpoint-ORIG-GUID: URn1e9JojTyjRIlC9e89918NbANoDH_l
X-Proofpoint-GUID: URn1e9JojTyjRIlC9e89918NbANoDH_l
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-10_18,2023-11-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0
 spamscore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 mlxscore=0 mlxlogscore=999 malwarescore=0 suspectscore=0 clxscore=1015
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100172
Received-SPF: pass client-ip=148.163.137.242;
 envelope-from=prvs=56783987ff=volodymyr_babchuk@epam.com;
 helo=mx0b-0039f301.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Fri, 10 Nov 2023 16:34:26 -0500
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
index f83b983ec5..a2b41dc2de 100644
--- a/hw/arm/xen_arm.c
+++ b/hw/arm/xen_arm.c
@@ -229,7 +229,7 @@ static void xen_arm_machine_class_init(ObjectClass *oc,=
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

