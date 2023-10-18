Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A45597CD95C
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:36:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3uI-0000Mo-Bf; Wed, 18 Oct 2023 06:36:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3uE-0000I6-7g
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:36:02 -0400
Received: from mail-dm6nam10on20618.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::618]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3uC-0004WT-IJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:36:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EQMfGjMUCCGBjtCk+vFN7huhsUZB+FBknNVV8W2AmbGIEybnQcv/MyAE+kmh6l7xCc5rVZ2psXGZVuKw9j9Hv/8Ew/VMokf4AwIloX8YSD4KJ22tGplDOTNg4vnHuZqOOd9TmglRNPrChaYXtEz3DCbhbUz7MPraoo3NcfX3UX+IqTUMojYWpgbaCusVfwb4P6wVAKCFBarwpviuLV6iTFRJNKLuZGY5dow0RHPhxTdDnSv5M7aPfiYR1Sq/e4l+LlrtNRj0rVJ8KVVWO6QAfTvopGCxujM5DFV+kxlfE7fVndBJPKHLw701GKOEin4dEce9wy6GiH1fjdHmX+Uvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oIr9NtOKK462CpJFIsXWFidxb8e1WT/BW9/aMLf1hJw=;
 b=H2kT5ZHaslIOCCIH54XKnzGSKxoQ0ZPZhaQoEikEDb4j9jN+26T66JvmZNZU8TqHsTdE18y/B2dQILlqelvnGb7djRRNNLKFbBYDR8D5HlRBA1FDakRwWriH73ZrjZXduk9wfSnfFEkvzgV6oUi/+3OuczolOxk22tGSJKZJwqEKeaVpVu5Un1PCXuBMnzKfmal6kAVdF9NK5mkeFnzWd47D8ykTpIPfJI3tCQwdJgsyxyl0AmguK8Fmr3BF/QL+KP4XlAyhd8vJvE/tFGPtNeziG1ZP+v11FXjtiqy8yZI8NFYNwVTwxxHA5LKoRqinxnKIoI+ipAoHFrvRoV/lrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oIr9NtOKK462CpJFIsXWFidxb8e1WT/BW9/aMLf1hJw=;
 b=x6SRJsQ5XiPyj8l/PWxnxRzH5JXxvWtKw6RTYpeHTQfGYvzh4RMWMFBAoGC0GPq+QCyH2OEnjoEGwKTHtvAd2Yai9rYukBoanU//LQh2r1RWQrTRDnWWcz+0vxfyEkGfhE0LET93EYKKG2aX8gaq9UB2ok6c/saptq6neSkJpb4=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 SA1PR12MB7126.namprd12.prod.outlook.com (2603:10b6:806:2b0::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Wed, 18 Oct
 2023 10:35:50 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:35:49 +0000
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
Subject: RE: [PATCH 10/11] hw/net/cadence_gem: perform PHY access on write only
Thread-Topic: [PATCH 10/11] hw/net/cadence_gem: perform PHY access on write
 only
Thread-Index: AQHaATJtbMx39yZw1kGKeo2IjEWVurBPWznw
Date: Wed, 18 Oct 2023 10:35:49 +0000
Message-ID: <DS7PR12MB574160C5DF0DE3E636D00380B6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-11-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-11-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|SA1PR12MB7126:EE_
x-ms-office365-filtering-correlation-id: b4ab0820-0f65-4f6f-dd1a-08dbcfc5ff28
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ajE37FlX44DQ9PzTA3dSYdhCSqpdykL1pmLmNzRXf/mGAAquXU1pN5xF4ryMRIe07XTIMuY6L1QPkqW9QFxFjGTs2pzDnpqOZqHWVssuNd6JooBQJVLSI9CL3iUYJimpaartJvC/SQzpl6ls+hMw9WzSDgL7I+e8/4M1ry9gXlb7/MjKZyZAhDxZWMNJBXpOASdkUdm7/trt92Ga8QuUI0RYBiTMOmi1IUf2qGfyGbEB33p+5sa57vg38EV9V7j9ZVz7CHakS/nFdrZ3HpAIpSFnvoobnR/jdSwQAUZxzeR+kDCRM3unyDhMEJWPj/cfTvYtNuAxf7sq/HKqT6fTgUsw/PQGhw2gegih+DhBR34e8ThLEwpiOxO+S8zHNHXGlphV9erkR0+QNvHatypPe7VfA9k+SFLNcmu3IV7VL1nLN6ifLSilbgxeGVNqtYHc12nptdFzPOj1nGJuu3cCe9cawMpQLXAwzwZxIX9c8J5cZEQA49QKCvTitnhlNir0NaTVjN5pqhvL0g97BGm+AMUX7KnzklFusFFxMPBw4ACSXdZKvY4cz4vrafnzo3PcA4vDDD/g0AqMHAkKGm2iQ0vTetAJaE0+uwWwvr0DJZqESs03CntiqbWO0+5O9R0m
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(39860400002)(366004)(396003)(376002)(346002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(38100700002)(55016003)(33656002)(26005)(122000001)(83380400001)(8936002)(8676002)(4326008)(5660300002)(478600001)(52536014)(110136005)(76116006)(66946007)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(6506007)(7696005)(38070700005)(9686003)(41300700001)(71200400001)(86362001)(2906002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?1Ko51oC0RojhI/UYoxeNd2OoTEC1hi+JAmEdj8eqmQ5NwknV5Pr7m0UAR4?=
 =?iso-8859-1?Q?TH4ya7fEEEOfzPwKAP7CH9isInzomUA6+xewn7VzAalaEn0+GmrKnbcFbn?=
 =?iso-8859-1?Q?y6CI0meTtTjQgxk/8ZhE0jOEJKnrcTG8z6Jf+UbVXI0zOZnQwKTib3JV0n?=
 =?iso-8859-1?Q?7WOJxuWuVY9gReq2sn7y8uR542cb42S1SYKH1nijtEvLz1DrcyGd28PjTQ?=
 =?iso-8859-1?Q?DaxhhxofyQ0hapZqgmkALfP5niQSlIwbIeoixlGKXcpqTT9F4EIZrmAfna?=
 =?iso-8859-1?Q?MfbTQ1MjLHdfOXOrzQwjlm+3+0451H+PK4DMEnn6cicWtfGCkNGStZxQ3Y?=
 =?iso-8859-1?Q?Uuhxi521REbGd3yhXYZFj6y8J0ImGyfX3D91NNTC+NlhViKcvMwUgSqu/V?=
 =?iso-8859-1?Q?B3WwNbbeYoQ8DRNSB+A70/ZVD2zqF5lZkIXReqnz9HsuZ+optLGFnrEjmn?=
 =?iso-8859-1?Q?LTcg1Ne98yiMWSH2EjkD7i3MfkgpSMO6bVnxyu/Hyj/5n8fXy+DOfNcS5b?=
 =?iso-8859-1?Q?71GaRAIc/xVfpC7VmBlJhqLQ/D3vrwOdMxrtLKTPlNdfACIoe1t4OM7kDq?=
 =?iso-8859-1?Q?go+xJ01cW7M/1pIOOZWeUo7FOApzGzHiNb2Gx9Qnx3yTX1gOceWUdywmQ2?=
 =?iso-8859-1?Q?SjZA3OYU5g3GxCMVo+ldAjT95I12LhWUTPcPFv+bucv4ufZ/fV6pTPFqLm?=
 =?iso-8859-1?Q?igZl4eJF2p3RxPjpNfpD5bdLIhaoPm6crvc+Ls8vP12Avlmo2wjUMZ3exh?=
 =?iso-8859-1?Q?YBdM+Y90YrVSGqlz2dmXWO7Yvm0QUOeUZ28dntz5jo0ExxDkXTIpoqUdgL?=
 =?iso-8859-1?Q?MHYW8DLOC9Sd7IiSLxVqA6JHBqlIrTbSGU9iV3vKL0nmlJO3PI42OwAhL8?=
 =?iso-8859-1?Q?xDcyTsVi1jD4NF4iRpFM1MtPg+A4qHBz7yb6lRbKTBujKBbITFSJSlBmLV?=
 =?iso-8859-1?Q?VGmYP7TDgBVUkH4jxZh8JQpTjXsg9pMLt8AkNPGpdGYkg/2JvQ5cdf03VE?=
 =?iso-8859-1?Q?WG3l/+mHEFykbywUupNFML6OW42Jqu14OzP2Oy53CW+6irVr+mfvDMIycN?=
 =?iso-8859-1?Q?iZgYqRH43jwjGksVQz12NJCTGf9PkNIz/F27iimh6enpF2iNqycjxrdQ7V?=
 =?iso-8859-1?Q?Dkp63amqiITsSLlFjW6SdmLa8ZuFA0ZqVw0Ih/u/dK/cXCWrMJpMob9Q6/?=
 =?iso-8859-1?Q?t8m1Mu8G13gXql3Vu7BiYlH7V0pskSnS1rTRnHaw+lSDptVfp6FJ4V5TU9?=
 =?iso-8859-1?Q?9FjvEQLKLNHpnx5f3ZlIY90dAROBustYbVtwk3QFrmC+bQO87zgEfkBiWi?=
 =?iso-8859-1?Q?LiO9q45pLp3txSEmBxma8RbGb9/L501CuiL8qcAHEx58ZnfMKQ2BYCG9Lj?=
 =?iso-8859-1?Q?7GzD3yawzVoHql6PRH0rdL7I/IqPM5hTCzVis2FAXYvfciC8kg1cYM4e2p?=
 =?iso-8859-1?Q?zI9TX5A20dSskqPnshsmPVyqPPbk6KGOIePjSNn6hEkCf+Xjqz3QZsl41+?=
 =?iso-8859-1?Q?dWsGtOEyTTzOtNDnC0VntJiSStU9vjAgAU/Hzv7Nn+4yFMhl9nQP/0xoCa?=
 =?iso-8859-1?Q?cOVFTuiCCnBMR4WP/2ml6yrsHB7bt+7l5n0QUS45XTfDmHbT5S4G7Mkbwv?=
 =?iso-8859-1?Q?65DD/OfAO87/8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ab0820-0f65-4f6f-dd1a-08dbcfc5ff28
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:35:49.9250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q41ARO3M2/Dpjd0yDconLfCbDu8qtyOyURm8Q33AvMKKiHenzdJKXSb+S2TQjafN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7126
Received-SPF: softfail client-ip=2a01:111:f400:7e88::618;
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
>Subject: [PATCH 10/11] hw/net/cadence_gem: perform PHY access on write
>only
>
>The MDIO access is done only on a write to the PHYMNTNC register. A
>subsequent read is used to retrieve the result but does not trigger an MDI=
O
>access by itself.
>
>Refactor the PHY access logic to perform all accesses (MDIO reads and
>writes) at PHYMNTNC write time.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com



>---
> hw/net/cadence_gem.c | 56 ++++++++++++++++++++++++++------------------
> 1 file changed, 33 insertions(+), 23 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>4c5fe10316..21146f4242 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -1519,10 +1519,42 @@ static void gem_phy_write(CadenceGEMState *s,
>unsigned reg_num, uint16_t val)
>         break;
>     }
>     s->phy_regs[reg_num] =3D val;
> }
>
>+static void gem_handle_phy_access(CadenceGEMState *s) {
>+    uint32_t val =3D s->regs[R_PHYMNTNC];
>+    uint32_t phy_addr, reg_num;
>+
>+    phy_addr =3D FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
>+
>+    if (phy_addr !=3D s->phy_addr) {
>+        /* no phy at this address */
>+        if (FIELD_EX32(val, PHYMNTNC, OP) =3D=3D MDIO_OP_READ) {
>+            s->regs[R_PHYMNTNC] =3D FIELD_DP32(val, PHYMNTNC, DATA, 0xfff=
f);
>+        }
>+        return;
>+    }
>+
>+    reg_num =3D FIELD_EX32(val, PHYMNTNC, REG_ADDR);
>+
>+    switch (FIELD_EX32(val, PHYMNTNC, OP)) {
>+    case MDIO_OP_READ:
>+        s->regs[R_PHYMNTNC] =3D FIELD_DP32(val, PHYMNTNC, DATA,
>+                                         gem_phy_read(s, reg_num));
>+        break;
>+
>+    case MDIO_OP_WRITE:
>+        gem_phy_write(s, reg_num, val);
>+        break;
>+
>+    default:
>+        break; /* only clause 22 operations are supported */
>+    }
>+}
>+
> /*
>  * gem_read32:
>  * Read a GEM register.
>  */
> static uint64_t gem_read(void *opaque, hwaddr offset, unsigned size) @@ -
>1539,24 +1571,10 @@ static uint64_t gem_read(void *opaque, hwaddr
>offset, unsigned size)
>     switch (offset) {
>     case R_ISR:
>         DB_PRINT("lowering irqs on ISR read\n");
>         /* The interrupts get updated at the end of the function. */
>         break;
>-    case R_PHYMNTNC:
>-        if (FIELD_EX32(retval, PHYMNTNC, OP) =3D=3D MDIO_OP_READ) {
>-            uint32_t phy_addr, reg_num;
>-
>-            phy_addr =3D FIELD_EX32(retval, PHYMNTNC, PHY_ADDR);
>-            if (phy_addr =3D=3D s->phy_addr) {
>-                reg_num =3D FIELD_EX32(retval, PHYMNTNC, REG_ADDR);
>-                retval &=3D 0xFFFF0000;
>-                retval |=3D gem_phy_read(s, reg_num);
>-            } else {
>-                retval |=3D 0xFFFF; /* No device at this address */
>-            }
>-        }
>-        break;
>     }
>
>     /* Squash read to clear bits */
>     s->regs[offset] &=3D ~(s->regs_rtc[offset]);
>
>@@ -1663,19 +1681,11 @@ static void gem_write(void *opaque, hwaddr
>offset, uint64_t val,
>     case R_SPADDR3HI:
>     case R_SPADDR4HI:
>         s->sar_active[(offset - R_SPADDR1HI) / 2] =3D true;
>         break;
>     case R_PHYMNTNC:
>-        if (FIELD_EX32(val, PHYMNTNC, OP) =3D=3D MDIO_OP_WRITE) {
>-            uint32_t phy_addr, reg_num;
>-
>-            phy_addr =3D FIELD_EX32(val, PHYMNTNC, PHY_ADDR);
>-            if (phy_addr =3D=3D s->phy_addr) {
>-                reg_num =3D FIELD_EX32(val, PHYMNTNC, REG_ADDR);
>-                gem_phy_write(s, reg_num, val);
>-            }
>-        }
>+        gem_handle_phy_access(s);
>         break;
>     }
>
>     DB_PRINT("newval: 0x%08x\n", s->regs[offset]);  }
>--
>2.39.2


