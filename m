Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A06C7CD902
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:19:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3dd-0003bb-3e; Wed, 18 Oct 2023 06:18:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3db-0003ay-4p
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:18:51 -0400
Received: from mail-bn7nam10on2060e.outbound.protection.outlook.com
 ([2a01:111:f400:7e8a::60e]
 helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3dZ-0000oe-8G
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:18:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ii/dlEKHPQkeoid3oV09OpmcpXMsZjK4m/ihmg6R+RjxZSV1kGoJD/G2hSsSpZzpNNV5lJBM9C1hNig0ZZUm97m501KH1gKfgAoaYe56SP0jTjSSB+W72x7y9xy0YGk3+vsZzIymwjb/31cL3dFXEgGG19NgU6aQvxXSACs1+UFTolqScySCZAEkKWnwbP3QfeXbsYng7+WKEmO3Cm1TFXjmnJiEkU+BXwr/XgVKRzf7J8hw48MBthB6hGeJ1G5RWZeprbW4BbZ3puqn9sX8mbcdzCzdPm5q+zHOKm361gAUb+gDt7U05pnPsv+GJ/hJSSepjIZMlotaBUdMdJWAUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NMkvgSJ195B6GfRVZxcP270rM1uogzOyLbEFE1HGPkg=;
 b=JSYXTgbCCzGCPT6x31Uc9HMTV/L0Qbe2BmIkn1bxFyM5V8nPtQCdEy5VnKv0xLJLyPADD+f8Iyajd3zRsorDPZi6CK0+YizNt+STs44sr1E1JyBMWqqOBQy6WeeifCMsDgpbZ1fs+AqKYBgDi5uS9RPX5f5ZGBr/1hG2wUQmBRvP+B2o3RUgAZH9X+8oSh16Us82AVk5n6b3jQITVkey35WkNjXZE6iy66xWu9HuRfGfVdO2jK1n0Z3KqOF7XzpPWl4RCAZoIlIaGfYAhVUARovWrjB9uzfMEOKGdqbk8nXBrOE0KL9fscbUKZ16YOzJISwFajMLVArQxxg8bXiS6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NMkvgSJ195B6GfRVZxcP270rM1uogzOyLbEFE1HGPkg=;
 b=pz3Cx8u23hp0SbEhK4f7BQ+q6Zk1gdWb3YIafKffCmk3MRmnQtfTCpW5tVBld9D0H5mRjIrJZ+gn/kZC/qwPBAmIHDVTVbeIx9y3wey0qgxPL+5SlocN+LAxY3UOphGCGszRykYmJjZ+fdA0Xs6ZNe8VDUa2yJpthqK8LJTPlkE=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.47; Wed, 18 Oct 2023 10:18:40 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:18:40 +0000
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
Subject: RE: [PATCH 04/11] hw/net/cadence_gem: use FIELD to describe NWCFG
 register fields
Thread-Topic: [PATCH 04/11] hw/net/cadence_gem: use FIELD to describe NWCFG
 register fields
Thread-Index: AQHaATJoEMzg/11QnUK0VG5gSKjBOrBPVmWQ
Date: Wed, 18 Oct 2023 10:18:40 +0000
Message-ID: <DS7PR12MB574161D6A4005388DB0715C3B6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-5-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-5-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: 57d408b8-0671-49da-9353-08dbcfc39986
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UsPBiNpbkOXte0CgveBsowdvCwKpUYUdQPmcnMnicjDnGqA5kzWgQ3pltJCWD7rqTlYsQMgP3vWLmUY0vZDT+GmahHkWDFriP+8UOoj+VLeOOzV5HsHOoduQOh7Qu7rrIkDPSDUu3WlzqkyaIQMOzcyv8vvuiD7NVSl0fgbGvBQfU43wKX/7wmmxmH6cEvibS90h6+mvi/P4qvWwUG5+iJxZlWvSYf2C+iGHr6NiKcvux2KLu6+CwY/8Zxq1kr7cWxT6OmlbGyQOl2WU7sPIlqMMuv8qq2H3gdrH9Q0QvwaqXsdO0pRiUkLF1tYprul1vTwP75qySCkrEswibN0CXcW15CXd7RAqubZAjOnTwoYk8yRRoFUxtjuLRT0QHQmbKEhCuyv2ESubMAH46v2OkFLbhHUD+5Ng4+pPZKQOl8ggy2GFbpar4ALfjxofWpsFOISkEBgMQoQHkaKj6KR3rOQppNbUyrefJ9CLeOuG2Dd6pS7WqkntXE+sudazDhZcpKzZ/oDZ+4qbDotVIVubyJTdaagBR6Z2NBZZYOj9ffX3xd0XD78lBRfWwNAHxsOHv473nAyS4E7vw7JdfHvM+XmFZ8cq1YEyD1y/+9niPd3yt2wdYJAKLG3tK5LSYBpKQ01LbToebLgbv5eYKbCg9wqD2XD+De6KB028DkRq1xo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(26005)(7696005)(9686003)(6506007)(83380400001)(66476007)(71200400001)(52536014)(8936002)(4326008)(316002)(5660300002)(478600001)(2906002)(8676002)(54906003)(64756008)(66556008)(66946007)(76116006)(110136005)(38070700005)(122000001)(86362001)(66446008)(38100700002)(41300700001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sy5iTava/jB7IpLXxYt5Y7whuqSzE0i1r61xaTsFdjfO8SWWAmbfITl9c4?=
 =?iso-8859-1?Q?h4Esgz8B9Fg2KyLw/bt487FDemZwkdo6zsgi9M2/+AJio1mD3xq6o+TCjP?=
 =?iso-8859-1?Q?Ul577uaTi/enhM0PV/LdmXXwJlaZBHn1PzToYDlTDc6tzUr6XL6xX7i348?=
 =?iso-8859-1?Q?Aehp+Y94OX1I6wavVwkocoAY1Cs5YqQV7xlQFQV3krfDRo0M06Qu3fZY6R?=
 =?iso-8859-1?Q?BK5JA5lxHZeiQ5fZRYAebATkIdbVFlJxNrNA1bMv949cRlWPlty6Lswk2D?=
 =?iso-8859-1?Q?wf94bZVpY3KKGg2c8t8vVEGjn07dJVItGIrbgXBcqeeNFXYdJvgY6znH95?=
 =?iso-8859-1?Q?rkVa5moSn37O7h4Z7mQFCAAVbRTLyXyEBaFQtiOsFOBbllzBWBtrwkKFoq?=
 =?iso-8859-1?Q?WAwpAMxfoymWvh7WBR1ZFnMus7LSCHbkBf4Ryr4W1SnQ800UMhtj72+nQM?=
 =?iso-8859-1?Q?ON318+316PGCn6jzk/AHPbMA1fbaNkWmyWmvFN4ZdrDveqXsFStdXC3nLd?=
 =?iso-8859-1?Q?KaXrbSjR9VwqdivHvEIHSdPln69nYl8lg7yPNb0zMhXelHg1ojiJvJWYmN?=
 =?iso-8859-1?Q?hYhgNZkHfEp1rRYIYjYsYM54DxpTr0Ew7wxahFTCQNrnVaWHD7YOU8QNov?=
 =?iso-8859-1?Q?FTIOxv480b9rOG7if4HnP8NpyFuqBRmbt3Ck+jZcPlf5uhg43BXXwL4CiV?=
 =?iso-8859-1?Q?CiAek3aI+g0gh2WtKehz+rSWb8HUKIAwNCZVLVZndPjunnhtIQMVEwrfls?=
 =?iso-8859-1?Q?sl5cbOOXaF42G31xca0BbZsO7tXitiNzlSnxi2kLVvK1GmtVwB4UrPDlay?=
 =?iso-8859-1?Q?Ar1ORpbPaLkMtnOFa39H5TPLpeHM7DDLF951OZ4qCLfToq6uR6fOjrBA6w?=
 =?iso-8859-1?Q?L2zJpx8DFh7gjNzCidPhUW8qgyLfT/zm70apxRF4I7PK+7fPwOcinRcpD/?=
 =?iso-8859-1?Q?XjBLsDtNKNFd0p+XAQruSXwk3Mj1dle58aThR28u12fxaB1LM1CfYYXj4f?=
 =?iso-8859-1?Q?uybgXGUph7js5dwBtUQnIVt0F20+JI2kwRYQANDwhlMfoS5jFVRBuiGx+N?=
 =?iso-8859-1?Q?TNZsL1Ex++Y3ayixVa/2D/diRd0oJid4npfQ77gZJtAhLRNZUdr/BVdeHC?=
 =?iso-8859-1?Q?Cp/+r8Y7rcuUXf77nuT1TngvihzFX0VDBm2QMZR6tupmDtZzpbuWiUBB5f?=
 =?iso-8859-1?Q?4Vvc5Rk/DTZDqWpz/QHP4Hu9aJBNqrsRIbD3gt0Wa2fQrPSZ4LmJSfsYNp?=
 =?iso-8859-1?Q?cqHoYQqMOcN2u8kyIu0Z6wlMPf6Vi656ZspAswjdDYoYeZU6fMQd051G8j?=
 =?iso-8859-1?Q?ox/ra6BhNm6XZGHjFTXJsYhR/6Qc4jDYD5NRz6wcUWgiHdXnZRVJFluUpP?=
 =?iso-8859-1?Q?1cZysSUY01coQAAmNNqOACRUPqRUdF1grpv2vsrmSKJn9F9SSlvmnfQsnJ?=
 =?iso-8859-1?Q?+C8QnWpPs7vHqPtCRmkcBFXZDmYpCjle7kAw7d9I+ADrQrxXWxKqCgZn6v?=
 =?iso-8859-1?Q?ZbRRrSlb9dbApIzWZfrsG3XOCjrx1FyBCdwf2Erg8nyYUBk+cJNhP0ejMw?=
 =?iso-8859-1?Q?39jA4O1Hb61GTVhDTmDto/5ZSgNB0bvXK/DpJQvbRnGTY418y+wbm6nEnr?=
 =?iso-8859-1?Q?OquNdAMtZVTcc=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d408b8-0671-49da-9353-08dbcfc39986
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:18:40.3995 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +FJU/0/pUnCXQ9bXyot206+qA883pYx9yBh/AZQg7MjMfQxspdNYQIskhMTtkD0i
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Received-SPF: softfail client-ip=2a01:111:f400:7e8a::60e;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
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
>Subject: [PATCH 04/11] hw/net/cadence_gem: use FIELD to describe NWCFG
>register fields
>
>Use de FIELD macro to describe the NWCFG register fields.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com

Regards,
Sai Pavan
>---
> hw/net/cadence_gem.c | 60 ++++++++++++++++++++++++++++---------------
>-
> 1 file changed, 39 insertions(+), 21 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>2864f0940e..09f570b6fb 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -77,10 +77,39 @@ REG32(NWCTRL, 0x0) /* Network Control reg */
>     FIELD(NWCTRL, SEL_MII_ON_RGMII, 28, 1)
>     FIELD(NWCTRL, TWO_PT_FIVE_GIG, 29, 1)
>     FIELD(NWCTRL, IFG_EATS_QAV_CREDIT, 30, 1)
>
> REG32(NWCFG, 0x4) /* Network Config reg */
>+    FIELD(NWCFG, SPEED, 0, 1)
>+    FIELD(NWCFG, FULL_DUPLEX, 1, 1)
>+    FIELD(NWCFG, DISCARD_NON_VLAN_FRAMES, 2, 1)
>+    FIELD(NWCFG, JUMBO_FRAMES, 3, 1)
>+    FIELD(NWCFG, PROMISC, 4, 1)
>+    FIELD(NWCFG, NO_BROADCAST, 5, 1)
>+    FIELD(NWCFG, MULTICAST_HASH_EN, 6, 1)
>+    FIELD(NWCFG, UNICAST_HASH_EN, 7, 1)
>+    FIELD(NWCFG, RECV_1536_BYTE_FRAMES, 8, 1)
>+    FIELD(NWCFG, EXTERNAL_ADDR_MATCH_EN, 9, 1)
>+    FIELD(NWCFG, GIGABIT_MODE_ENABLE, 10, 1)
>+    FIELD(NWCFG, PCS_SELECT, 11, 1)
>+    FIELD(NWCFG, RETRY_TEST, 12, 1)
>+    FIELD(NWCFG, PAUSE_ENABLE, 13, 1)
>+    FIELD(NWCFG, RECV_BUF_OFFSET, 14, 2)
>+    FIELD(NWCFG, LEN_ERR_DISCARD, 16, 1)
>+    FIELD(NWCFG, FCS_REMOVE, 17, 1)
>+    FIELD(NWCFG, MDC_CLOCK_DIV, 18, 3)
>+    FIELD(NWCFG, DATA_BUS_WIDTH, 21, 2)
>+    FIELD(NWCFG, DISABLE_COPY_PAUSE_FRAMES, 23, 1)
>+    FIELD(NWCFG, RECV_CSUM_OFFLOAD_EN, 24, 1)
>+    FIELD(NWCFG, EN_HALF_DUPLEX_RX, 25, 1)
>+    FIELD(NWCFG, IGNORE_RX_FCS, 26, 1)
>+    FIELD(NWCFG, SGMII_MODE_ENABLE, 27, 1)
>+    FIELD(NWCFG, IPG_STRETCH_ENABLE, 28, 1)
>+    FIELD(NWCFG, NSP_ACCEPT, 29, 1)
>+    FIELD(NWCFG, IGNORE_IPG_RX_ER, 30, 1)
>+    FIELD(NWCFG, UNI_DIRECTION_ENABLE, 31, 1)
>+
> REG32(NWSTATUS, 0x8) /* Network Status reg */  REG32(USERIO, 0xc) /*
>User IO reg */  REG32(DMACFG, 0x10) /* DMA Control reg */
>REG32(TXSTATUS, 0x14) /* TX Status reg */  REG32(RXQBASE, 0x18) /* RX Q
>Base address reg */ @@ -234,21 +263,10 @@
>REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
>     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
>
> /*****************************************/
>-#define GEM_NWCFG_STRIP_FCS    0x00020000 /* Strip FCS field */
>-#define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len
>err */
>-#define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset
>mask */
>-#define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift =
*/
>-#define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame
>*/
>-#define GEM_NWCFG_UCAST_HASH   0x00000080 /* accept unicast if hash
>match */
>-#define GEM_NWCFG_MCAST_HASH   0x00000040 /* accept multicast if hash
>match */
>-#define GEM_NWCFG_BCAST_REJ    0x00000020 /* Reject broadcast packets
>*/
>-#define GEM_NWCFG_PROMISC      0x00000010 /* Accept all packets */
>-#define GEM_NWCFG_JUMBO_FRAME  0x00000008 /* Jumbo Frames enable
>*/
>-
> #define GEM_DMACFG_ADDR_64B    (1U << 30)
> #define GEM_DMACFG_TX_BD_EXT   (1U << 29)
> #define GEM_DMACFG_RX_BD_EXT   (1U << 28)
> #define GEM_DMACFG_RBUFSZ_M    0x00FF0000 /* DMA RX Buffer Size mask
>*/
> #define GEM_DMACFG_RBUFSZ_S    16         /* DMA RX Buffer Size shift */
>@@ -480,21 +498,22 @@ static inline void rx_desc_set_sar(uint32_t *desc, i=
nt
>sar_idx)  static const uint8_t broadcast_addr[] =3D { 0xFF, 0xFF, 0xFF, 0x=
FF, 0xFF,
>0xFF };
>
> static uint32_t gem_get_max_buf_len(CadenceGEMState *s, bool tx)  {
>     uint32_t size;
>-    if (s->regs[R_NWCFG] & GEM_NWCFG_JUMBO_FRAME) {
>+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, JUMBO_FRAMES)) {
>         size =3D s->regs[R_JUMBO_MAX_LEN];
>         if (size > s->jumbo_max_len) {
>             size =3D s->jumbo_max_len;
>             qemu_log_mask(LOG_GUEST_ERROR, "GEM_JUMBO_MAX_LEN reg
>cannot be"
>                 " greater than 0x%" PRIx32 "\n", s->jumbo_max_len);
>         }
>     } else if (tx) {
>         size =3D 1518;
>     } else {
>-        size =3D s->regs[R_NWCFG] & GEM_NWCFG_RCV_1538 ? 1538 : 1518;
>+        size =3D FIELD_EX32(s->regs[R_NWCFG],
>+                          NWCFG, RECV_1536_BYTE_FRAMES) ? 1538 : 1518;
>     }
>     return size;
> }
>
> static void gem_set_isr(CadenceGEMState *s, int q, uint32_t flag) @@ -730=
,26
>+749,26 @@ static int gem_mac_address_filter(CadenceGEMState *s, const
>uint8_t *packet)  {
>     uint8_t *gem_spaddr;
>     int i, is_mc;
>
>     /* Promiscuous mode? */
>-    if (s->regs[R_NWCFG] & GEM_NWCFG_PROMISC) {
>+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, PROMISC)) {
>         return GEM_RX_PROMISCUOUS_ACCEPT;
>     }
>
>     if (!memcmp(packet, broadcast_addr, 6)) {
>         /* Reject broadcast packets? */
>-        if (s->regs[R_NWCFG] & GEM_NWCFG_BCAST_REJ) {
>+        if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, NO_BROADCAST)) {
>             return GEM_RX_REJECT;
>         }
>         return GEM_RX_BROADCAST_ACCEPT;
>     }
>
>     /* Accept packets -w- hash match? */
>     is_mc =3D is_multicast_ether_addr(packet);
>-    if ((is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_MCAST_HASH)) ||
>-        (!is_mc && (s->regs[R_NWCFG] & GEM_NWCFG_UCAST_HASH))) {
>+    if ((is_mc && (FIELD_EX32(s->regs[R_NWCFG], NWCFG,
>MULTICAST_HASH_EN))) ||
>+        (!is_mc && FIELD_EX32(s->regs[R_NWCFG], NWCFG,
>+ UNICAST_HASH_EN))) {
>         uint64_t buckets;
>         unsigned hash_index;
>
>         hash_index =3D calc_mac_hash(packet);
>         buckets =3D ((uint64_t)s->regs[R_HASHHI] << 32) | s->regs[R_HASHL=
O]; @@
>-981,11 +1000,11 @@ static ssize_t gem_receive(NetClientState *nc, const
>uint8_t *buf, size_t size)
>     if (maf =3D=3D GEM_RX_REJECT) {
>         return size;  /* no, drop silently b/c it's not an error */
>     }
>
>     /* Discard packets with receive length error enabled ? */
>-    if (s->regs[R_NWCFG] & GEM_NWCFG_LERR_DISC) {
>+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, LEN_ERR_DISCARD)) {
>         unsigned type_len;
>
>         /* Fish the ethertype / length field out of the RX packet */
>         type_len =3D buf[12] << 8 | buf[13];
>         /* It is a length field, not an ethertype */ @@ -998,12 +1017,11 =
@@ static
>ssize_t gem_receive(NetClientState *nc, const uint8_t *buf, size_t size)
>     }
>
>     /*
>      * Determine configured receive buffer offset (probably 0)
>      */
>-    rxbuf_offset =3D (s->regs[R_NWCFG] & GEM_NWCFG_BUFF_OFST_M) >>
>-                   GEM_NWCFG_BUFF_OFST_S;
>+    rxbuf_offset =3D FIELD_EX32(s->regs[R_NWCFG], NWCFG,
>+ RECV_BUF_OFFSET);
>
>     /* The configure size of each receive buffer.  Determines how many
>      * buffers needed to hold this packet.
>      */
>     rxbufsize =3D ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >> @@ -
>1024,11 +1042,11 @@ static ssize_t gem_receive(NetClientState *nc, const
>uint8_t *buf, size_t size)
>     if (size < 60) {
>         size =3D 60;
>     }
>
>     /* Strip of FCS field ? (usually yes) */
>-    if (s->regs[R_NWCFG] & GEM_NWCFG_STRIP_FCS) {
>+    if (FIELD_EX32(s->regs[R_NWCFG], NWCFG, FCS_REMOVE)) {
>         rxbuf_ptr =3D (void *)buf;
>     } else {
>         unsigned crc_val;
>
>         if (size > MAX_FRAME_SIZE - sizeof(crc_val)) {
>--
>2.39.2


