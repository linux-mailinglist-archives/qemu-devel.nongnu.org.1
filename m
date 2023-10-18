Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F5D67CD920
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:24:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3iW-0001on-2L; Wed, 18 Oct 2023 06:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3iS-0001iF-9U
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:23:52 -0400
Received: from mail-dm6nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::60e]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3iQ-0002C2-KF
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:23:52 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Opgjmmwlbyi+JUxkFessHECb1d3xU2MJFhyik6pGhIsK5f1wxP4+cXwFD1684RtqVuLL5g3xmnBFxyRKU5KGkK43Wi/NErvwIhis6lD31kX0035RaLlFLyVPCyG1anPxylkhrZ3YHekWPMgcQxlIQlZGUOawxsyMm8mPCF0646y0pBnjBtu/W+6djAxO8fIoI4Y86VkZ+ajgTdYSzzIZZmcbLanFWWJqhr84xyaeamu1/ep+t20gr/smTlCTL5YriIQ00weVXXug92qGIMeO7OkgxB4TmR5+kTtkk7uXtl3Qr7VO1u4FS1KfyUjSbiobrw3X0bnaHmG7YPaIbVjhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0vBj1q5e1vZJsw+AIKEiTgyqGkWhP/G8AwM/ssHjejA=;
 b=dvkDvL/H7W2FZHk7Frvzp85+vEEmGk+epxYaiDqhgfjfGOD811lKlJytFd3y8Jlg7oRocNFuX8HK/0WZCxMyvRnbIW4+lgveesz1dVQummcStAKCJAP4DBS/H+k49QJk2zR63ee8qi2JbUCGpocskSE69v5HTaL2jFHhtUHEHFwiiPxJclBLpUBFSLDGlI4K71QmgBvCzhnQNhe8tRPjoeIAGnz+eSufwNhby8C57iMzgCUZUtkCc6trQvqKo/vmrnMUpYytfK8VSF7h3X17vEVqG32DfEdoEjsMO4/l/JY0Pb2UJ5OkDc7h8+oECijl9KDcdccmGDTZnnwbous5vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0vBj1q5e1vZJsw+AIKEiTgyqGkWhP/G8AwM/ssHjejA=;
 b=en+MnqUJjiUX2GxuMO2VYZ2SwM4FLFNkClzgkKNSzVT2XKW7fOb6W5GWohr1W3ngFYGkrfdF8hIcQ6mGn4+qT5E5AJvelTrTD1gLRFkmGZTR3ADoCfiBz0DA7JkaXcNkoPEjfKVUecsAuNjtK+1VRD4WOpXkeMkwiWqjyy3ud68=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 DS7PR12MB6285.namprd12.prod.outlook.com (2603:10b6:8:96::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6886.36; Wed, 18 Oct 2023 10:23:41 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:23:41 +0000
From: "Boddu, Sai Pavan" <sai.pavan.boddu@amd.com>
To: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "Michel, Luc" <Luc.Michel@amd.com>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, Peter Maydell
 <peter.maydell@linaro.org>, Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, "Iglesias,
 Francisco" <francisco.iglesias@amd.com>, "Konrad, Frederic"
 <Frederic.Konrad@amd.com>
Subject: RE: [PATCH 09/11] hw/net/cadence_gem: use FIELD to describe PHYMNTNC
 register fields
Thread-Topic: [PATCH 09/11] hw/net/cadence_gem: use FIELD to describe PHYMNTNC
 register fields
Thread-Index: AQHaATJspAmnzCpGxkuVTHaq20N8/rBPV9tA
Date: Wed, 18 Oct 2023 10:23:41 +0000
Message-ID: <DS7PR12MB5741CD55334E6EA6AE03AADCB6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-10-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-10-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|DS7PR12MB6285:EE_
x-ms-office365-filtering-correlation-id: 4b2ff9c7-2efe-4102-8868-08dbcfc44d00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fDc75y+5dMwLVXknQlZX3wY2d9WliTxpVwJr8s6gGStBKzQjgS4ToeHTorKzm5d5ttoliKjMBHp+LmUqMw5YX6VTyWbGGXgeGKPX4j+moh0we+XfbOyY4ivN/oiwH7223UZ0IfnMYQMO+oeevp8FgvTZqgRDn1n8vowm1Acv+dIMOx+1sUUqdEpBOxEqgi4dff7xCauTeF+aEHHG99mriKl8GudXc7hLgLtfe0TnVN1MRAhwDc+tZSiFwkGL5941m4OsON/vD+uwN35G7PjMwL/ywoeWi+Jtd5Zs6JgFCNl0RhubfPbSXB5xxPBo7I1N4lNCvjaULJbrY9tpC4JSGs+TNjQZEAXDWMioqYOzYX/WGf1DK1pDFqx5zaiw6sC+d+GQjUWfqqH2HAmvUAVKasayRJ9vw+5DT585rS6y9D3m3Gk4Av3VK/G9fQvl/vu/7UYfOYuUCHcyuRmOwnFYB34La4VWjWp6opPAd2UOknzEq3oyIQ1ROwcUGO3pPOQ1ttqTkOiTVdT2Vm00Hl2sI197ioRVg3ubpnCqDSdh/zIEDkWk9YT+ZsxuLlS+KS/yCVNSJrecmVl+YpPPtaiJm/3iuwqJV6jmhUdSBYxJZfyaOPulHwpGodHL3IslGBt6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(346002)(136003)(396003)(376002)(230922051799003)(451199024)(64100799003)(1800799009)(186009)(33656002)(86362001)(55016003)(478600001)(71200400001)(6506007)(2906002)(5660300002)(122000001)(38070700005)(38100700002)(41300700001)(7696005)(26005)(66476007)(8936002)(76116006)(316002)(66556008)(66446008)(54906003)(66946007)(8676002)(83380400001)(9686003)(4326008)(110136005)(64756008)(52536014);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?epM25Ae+ehv6GsKUKszh0M8RoXhm++qlKLk1hrLnwxg5RHwhjaqatGvWC2?=
 =?iso-8859-1?Q?TswT5ETy6TOcH/j3yxTXBsXvJSu6XQEP+wH/f4fcFYnSa+R6htg2gKFSWN?=
 =?iso-8859-1?Q?HrvaKWGoZNqDZfjzds09l1FVShEvmou1fQdyEIkCUnIJ0bEazO4uNb2f9p?=
 =?iso-8859-1?Q?UTJND/B60GFbymKym05XTbTDDjaklyned3KuEkkCv4K2bOuk0nXZob4u1n?=
 =?iso-8859-1?Q?Yg2hDGySa4eZsKuYVr+4pJ4iC9bAN3PQPUlZu7gWRdBs7dTNMgONVd/i+6?=
 =?iso-8859-1?Q?z4uhKSvtHLifqjIVrZYn+vpPZe64fKkW4TNHkYwJLRFf38F3Yg7nfnJmKC?=
 =?iso-8859-1?Q?twg9MEyS2jPJ7/QW41ubYHjgMSO8PkGjbWBZEYIfzY1c4rvmuvYWOxX/vr?=
 =?iso-8859-1?Q?UoU1Dwi8yEgGa+dKzNxZ6qDXeLdAnuq34lHe0Mjhe/GHa84srM3BexzwfS?=
 =?iso-8859-1?Q?uFkAzQroKnbgCdPAOFWQCP/S9qs9mZHt9fHkNL/aaeVM21jsu84a15ki5Y?=
 =?iso-8859-1?Q?ApYyB7T8Nq6E7844J2DkBj/0QRKV5uaTgSxrpaDlzzYo9TeWD6AkFgMN0R?=
 =?iso-8859-1?Q?JFuMY9+a/7jdBPIjhIX9LN1F94a8N125n2AsOIKFaY0jaAFLq1cbkD8EoA?=
 =?iso-8859-1?Q?oDjskjiFIgdaH0Ya1vdQB3Tmv6pnXDp2I7OCCbacgUp5k4GLW5IuqbMHm0?=
 =?iso-8859-1?Q?tx852UHwuoZgy3pIN2D7UFnN21f92Y908JgmYYfgn99p3HzbKUzJ4cSrUu?=
 =?iso-8859-1?Q?xpAqDd31WJW3G3IzuIAip84CjAuIyWOtlj35qAlS+2B4vQxEkuQsJd6CJQ?=
 =?iso-8859-1?Q?pB1vnEeYMG1tqzSn38DNOr02MLDHPTvhLsGDlQIFI9MUZPYAXFUC9A3gFb?=
 =?iso-8859-1?Q?ycPCPP7ODFbxwwrVGnUF5nJauI84V+k/ZCVQWJumkb9Ke5c4iVdRPwVOuV?=
 =?iso-8859-1?Q?smvClKEkiIk6cgDyq+o1aMO+Dgcg7lmaiPnSkeLs2/ocBPvFxxLDSB/VPE?=
 =?iso-8859-1?Q?NfLe/E2TvrKK+8I6A0rj6CTcyFWPa0mHEm1BcLZVUaiKE9QsDJeoTlN+tD?=
 =?iso-8859-1?Q?7JJ9pJHgVwv4iZFBiNE2xt/FKrAtNTD0/P3PTOcEfo9rhabifTBF2cMZG0?=
 =?iso-8859-1?Q?J3J9q+dZsTx0RoLC/7tsWRqSm5Rhbohn2+1fOvdzpgKcwpfVqbbs8GCRag?=
 =?iso-8859-1?Q?5nXU3+E1+TLmFvSRXN5sD5GL7jJ2z0a110fPv6LTCMzBKLWqZFe9PdZw4E?=
 =?iso-8859-1?Q?H8DFWMsX6qq9fC/6VEDndjR6ak09MMTams3iAzMycDeaVee871QZE8r86U?=
 =?iso-8859-1?Q?DGadi4yhUBSOMkopoRw07qvC/+Bbvixq9R4O5Ab9tyWEVo3CFMEprFs1wc?=
 =?iso-8859-1?Q?ELe8kbATBROgYc/cIVsJft7dTHNdOuSY3sSCMqjR5RT81vb6icIOAj2t34?=
 =?iso-8859-1?Q?eEn7moxFTVETowVlo0gOD8HcFLq9N2Ot1POOs3Fse4EC3BGHW07v0f3Ohc?=
 =?iso-8859-1?Q?av85l7xsCr2vlAt8R5BiAmUR2d+y6jdjsPPv9M0fdkHwQP3bA7GyURbe6i?=
 =?iso-8859-1?Q?90fAgBiJ59GCE02Yil1BLDwVKEWxhpR8pYAbQWC+q3w9uBRvNNyNFfWPe2?=
 =?iso-8859-1?Q?E03B1YLJky5mg=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b2ff9c7-2efe-4102-8868-08dbcfc44d00
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:23:41.5089 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PL3SJXdXZuv159b7BsNhhX68CeC9l/dl6Bto2jHIYfWEtJx7ZGE6F/RfXQuy4wp6
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6285
Received-SPF: softfail client-ip=2a01:111:f400:7e88::60e;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



>-----Original Message-----
>From: Luc Michel <luc.michel@amd.com>
>Sent: Wednesday, October 18, 2023 1:14 AM
>To: qemu-devel@nongnu.org
>Cc: Michel, Luc <Luc.Michel@amd.com>; qemu-arm@nongnu.org; Edgar E .
>Iglesias <edgar.iglesias@gmail.com>; Alistair Francis <alistair@alistair23=
.me>;
>Peter Maydell <peter.maydell@linaro.org>; Jason Wang
><jasowang@redhat.com>; Philippe Mathieu-Daud=E9 <philmd@linaro.org>;
>Iglesias, Francisco <francisco.iglesias@amd.com>; Konrad, Frederic
><Frederic.Konrad@amd.com>; Boddu, Sai Pavan
><sai.pavan.boddu@amd.com>
>Subject: [PATCH 09/11] hw/net/cadence_gem: use FIELD to describe
>PHYMNTNC register fields
>
>Use the FIELD macro to describe the PHYMNTNC register fields.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com

>---
> hw/net/cadence_gem.c | 27 ++++++++++++++-------------
> 1 file changed, 14 insertions(+), 13 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>955a8da134..4c5fe10316 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -192,10 +192,18 @@ REG32(ISR, 0x24) /* Interrupt Status reg */
>REG32(IER, 0x28) /* Interrupt Enable reg */  REG32(IDR, 0x2c) /* Interrupt
>Disable reg */  REG32(IMR, 0x30) /* Interrupt Mask reg */
>
> REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
>+    FIELD(PHYMNTNC, DATA, 0, 16)
>+    FIELD(PHYMNTNC, REG_ADDR, 18, 5)
>+    FIELD(PHYMNTNC, PHY_ADDR, 23, 5)
>+    FIELD(PHYMNTNC, OP, 28, 2)
>+    FIELD(PHYMNTNC, ST, 30, 2)
>+#define MDIO_OP_READ    0x3
>+#define MDIO_OP_WRITE   0x2
>+
> REG32(RXPAUSE, 0x38) /* RX Pause Time reg */  REG32(TXPAUSE, 0x3c) /* TX
>Pause Time reg */  REG32(TXPARTIALSF, 0x40) /* TX Partial Store and Forwar=
d
>*/  REG32(RXPARTIALSF, 0x44) /* RX Partial Store and Forward */
>REG32(JUMBO_MAX_LEN, 0x48) /* Max Jumbo Frame Size */ @@ -340,17
>+348,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>
> /*****************************************/
>
>
>
>-#define GEM_PHYMNTNC_OP_R      0x20000000 /* read operation */
>-#define GEM_PHYMNTNC_OP_W      0x10000000 /* write operation */
>-#define GEM_PHYMNTNC_ADDR      0x0F800000 /* Address bits */
>-#define GEM_PHYMNTNC_ADDR_SHFT 23
>-#define GEM_PHYMNTNC_REG       0x007C0000 /* register bits */
>-#define GEM_PHYMNTNC_REG_SHIFT 18
>-
> /* Marvell PHY definitions */
> #define BOARD_PHY_ADDRESS    0 /* PHY address we will emulate a device at
>*/
>
> #define PHY_REG_CONTROL      0
> #define PHY_REG_STATUS       1
>@@ -1539,16 +1540,16 @@ static uint64_t gem_read(void *opaque, hwaddr
>offset, unsigned size)
>     case R_ISR:
>         DB_PRINT("lowering irqs on ISR read\n");
>         /* The interrupts get updated at the end of the function. */
>         break;
>     case R_PHYMNTNC:
>-        if (retval & GEM_PHYMNTNC_OP_R) {
>+        if (FIELD_EX32(retval, PHYMNTNC, OP) =3D=3D MDIO_OP_READ) {
>             uint32_t phy_addr, reg_num;
>
>-            phy_addr =3D (retval & GEM_PHYMNTNC_ADDR) >>
>GEM_PHYMNTNC_ADDR_SHFT;
>+            phy_addr =3D FIELD_EX32(retval, PHYMNTNC, PHY_ADDR);
>             if (phy_addr =3D=3D s->phy_addr) {
>-                reg_num =3D (retval & GEM_PHYMNTNC_REG) >>
>GEM_PHYMNTNC_REG_SHIFT;
>+                reg_num =3D FIELD_EX32(retval, PHYMNTNC, REG_ADDR);
>                 retval &=3D 0xFFFF0000;
>                 retval |=3D gem_phy_read(s, reg_num);
>             } else {
>                 retval |=3D 0xFFFF; /* No device at this address */
>             }
>@@ -1662,16 +1663,16 @@ static void gem_write(void *opaque, hwaddr
>offset, uint64_t val,
>     case R_SPADDR3HI:
>     case R_SPADDR4HI:
>         s->sar_active[(offset - R_SPADDR1HI) / 2] =3D true;
>         break;
>     case R_PHYMNTNC:
>-        if (val & GEM_PHYMNTNC_OP_W) {
>+        if (FIELD_EX32(val, PHYMNTNC, OP) =3D=3D MDIO_OP_WRITE) {
>             uint32_t phy_addr, reg_num;
>
>-            phy_addr =3D (val & GEM_PHYMNTNC_ADDR) >>
>GEM_PHYMNTNC_ADDR_SHFT;
>+            phy_addr =3D FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
>             if (phy_addr =3D=3D s->phy_addr) {
>-                reg_num =3D (val & GEM_PHYMNTNC_REG) >>
>GEM_PHYMNTNC_REG_SHIFT;
>+                reg_num =3D FIELD_EX32(val, PHYMNTNC, REG_ADDR);
>                 gem_phy_write(s, reg_num, val);
>             }
>         }
>         break;
>     }
>--
>2.39.2


