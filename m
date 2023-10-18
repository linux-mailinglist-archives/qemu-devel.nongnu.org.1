Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7547A7CD90E
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3fr-00055Q-L1; Wed, 18 Oct 2023 06:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3fo-00054S-T6
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:21:08 -0400
Received: from mail-dm6nam10on20606.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::606]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3fn-0001JV-4a
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:21:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jMevosKfpzgkGmPPQdQVsqz3mPWGYCTGFYW18WMpAP3rZrydvIxFl3vOqjVtXcfrs918QDrJ+zM//7oIwCsehMTJlJjRX83/zHegUxFMvoO5E+WtccsaPzxdEpofx0M7pzRj4daArl0K5cRc/lM+OLUdzqxS914TeWaidrqrr1A+IFg/93OnXVyEc0FEaRtAH/erT4LORx1u5fbVTYO/gsi3I92FuzEAl/L+sgxYEY79OJ1dzt6dz3XzPDwlqek8uK4cG0MOxk9JVNmR+2DgaGK84v8VJhidkRVHr2pSYuTEYFO9QFxf5IIw+cE5gKPihV/j1/4USB7irqEaLnj8PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RraA6Axn6Z9WlJv+FaHL2C455nh+YrruPPXsuvRjz0s=;
 b=NLGmIRH+57os7ZZ7kRMWCZYc5DCUW6Arkggo5nRM4pnWuTN1s3fB/+xE4yrtH0u9PCW7fYOVjm23Z4zV1I+I86oayrYWpptLP6obDwXi1efR5MKGt/BJc9ADn2SFVa7pLc303y8Lcd1rOVWSUH78IegZuG+pXRQFcIwJWI8q9Hobpj6jkA9QyS+NVCrwQzks5TXUx3Rk+Ss7kG+OEXuXOuL2ECWn0aizPGO4hM16apaDPOYLL0KOkmxjLKjtLM/P9e1YmPlzF09sHokkjyiD6jm3uY68zcpwhJNedWNY04l/rO2r/wWN7qOUXMhMEvivTO4V+TebCzUCL3tASVzUnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RraA6Axn6Z9WlJv+FaHL2C455nh+YrruPPXsuvRjz0s=;
 b=aYuyCPaAX8rCN2dvJjmheSQe9hv0yRT//2Sl5PnQGe3xU3dCRjwbkDAtcWwfR9artwI03O0DnG4epDXHLd7QMvtboP+onPHdayWgcvBC46ZlBsORLUFsfpFDvKZeRqtLlVCsZhlyaivgiQ/2yaTX303y7i5JAJ36bV2YElX1cuk=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.47; Wed, 18 Oct 2023 10:20:58 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:20:58 +0000
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
Subject: RE: [PATCH 05/11] hw/net/cadence_gem: use FIELD to describe DMACFG
 register fields
Thread-Topic: [PATCH 05/11] hw/net/cadence_gem: use FIELD to describe DMACFG
 register fields
Thread-Index: AQHaATJnY6tszmvZC0qyaucku7Cr6LBPVssw
Date: Wed, 18 Oct 2023 10:20:57 +0000
Message-ID: <DS7PR12MB5741CF5A89A3998C7D14D716B6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-6-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-6-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: ef97a486-1dd5-460d-dc77-08dbcfc3eb89
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sOKOH3GpttXgVS6zHn75pNaWDwAqDNY1nGgBgMeSi/T6YId/Iu7kCbiy+eWpRIxUz7Xvylru0IlpYKAUhxH8Fqtm7hJs8SSSafPxAAr/op1QbU3w9yFpk8Kkc2TCENwc+PnFgcGm4nMJjftSoYLBlA0tv46Vw6hiN4niyv62o5PIyO/3wPYaN/1P/diA+M0BAqZS8IKBbZgQKtzDXPFI2QwoRhLRPkJ5MYA7csEa19TLHwI3VDngGboSfBJLL8Xt3ZmeQ61KzE6O14yy193Iaa+HExqFXb/WxP7+mZblnupgEMPqm/pKd88FNwV9jLdzfV0Z2+eNnVFgUtplpXn+diTWbksRXcan8dSYYeUmQ7XWneJwanFVgz2tEThhfdDoL7vzPV7oWBm+LJsH6En6jawsAXTyr0C6onnLNhkCy99BPjejpG3Ag/jAJv8ZZl5ycqbwbslhxpzFNa4cKMcbBq5ZhEdvXwcvLqOxnpwaOfgifRatBBGvDcuEjzxnOH36SN8urityzB2pnPpnGUmYo63ABU2bhljeNc8qSHCei29J12/+wOW5J/qnrHlDD9LULN1iZwtmuy/S7gexFFs7DIREw9UZxVFNoibSzsBxUd7x/yotV6FTXss/0c38AXukCRLqKMSEeMJdtqZQWMRPmnc3jmKqApFOR/qCdjGDNQg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(26005)(7696005)(9686003)(6506007)(83380400001)(66476007)(71200400001)(52536014)(8936002)(4326008)(316002)(5660300002)(478600001)(2906002)(8676002)(54906003)(64756008)(66556008)(66946007)(76116006)(110136005)(38070700005)(122000001)(86362001)(66446008)(38100700002)(41300700001)(33656002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?134qp97/FjXMF688WkhbkcvEBols+SEvxXY88OW9OP+bgL7H6sTMiSzLor?=
 =?iso-8859-1?Q?IacOmJgmf2Cgb8pZynda6zh22sADMHVAWS2ZGG/RxNVmpi7AzQ1OFP7nQE?=
 =?iso-8859-1?Q?OwrGR5EvGOjcHlPsHnfDVbeu4KsZIQGeeBndZMJ7mUUROkAPDB5EHp7akC?=
 =?iso-8859-1?Q?T5Eu9waI01TDhwgp9qQVeC6mOtUMVvO737t8SvtHXGIZtrvJSh/BGnkgoD?=
 =?iso-8859-1?Q?hA+JaSacgLhEjWCP+A04G1/+DolBfOLQO+0WiQNe8G/xow0yYrCe7QddE4?=
 =?iso-8859-1?Q?v28oK1AasT5p8P9YUaDu6ogLuy1uKMy6riea4vqWa2t7+W2dvcUGyaot8m?=
 =?iso-8859-1?Q?DYs+2JB4BqLXaqMB+KR9RJOEqxme/RoUaRE/vBeE4k7ltlnIpzROf3VIPi?=
 =?iso-8859-1?Q?SUe2dvusYXau751JO4QD1xjTp7pPrQrIi1syFiJLeZ3ylibHMrJwo6iCdS?=
 =?iso-8859-1?Q?nlHm031iDiL29qGEFJmNrpt2NwkAhS2dFEgKQrGp5GaG424LysHZPZ8m4K?=
 =?iso-8859-1?Q?H2yRyOrcU4UnvekxAqL1Pci44JId1sg3/Wq9yyQp7MG8QUQORXp9Dx9aIK?=
 =?iso-8859-1?Q?kny38bjpT4aLsyGxICMuy+MMTzHBvrF/gnP3yDJNf46Qgqye7wfqepYJbC?=
 =?iso-8859-1?Q?ILY9Vye77601a9LuT+aspCZ6wdRMCrnHk/IWF/QnKcwLonzQS8q6Grkj7t?=
 =?iso-8859-1?Q?rCHUVTM48hnAgaoam0ZmQg4ENsXzWHnxcR82ik4MGjDL0OwJ7p6/eX10Fw?=
 =?iso-8859-1?Q?jw/b6evVb20TiE4QNv7H1Uzve7E0puLJI8Go6C+yvp9dn0DKSW22pQf6x1?=
 =?iso-8859-1?Q?o4JAjjBABa4rRjUeihQBCKDSZ9QEjRCDLxCo2TdDzP2KuxAz5uTnprC1mZ?=
 =?iso-8859-1?Q?v7aYJLOIdE39o8clr3sDZ44ZbHy+1XBAiRhRj0qm1fCA4iFRKvQCzaRSzD?=
 =?iso-8859-1?Q?ZMZBeIIagUHVjLQLVqPljEfuUgWsFZHkrgparQKkVIMsb7kMSY1DIcMzyH?=
 =?iso-8859-1?Q?jFjqmdX/ZQ7RfBJBT7ZOpCACHQCUwZsOnjmI9Jt/OltIa0RwDQr4CFPpW6?=
 =?iso-8859-1?Q?xb0yPGrRepEsP2+/aMiwc11Cayw42EyuUVXKQuv3m+RgYHpRLVtF0Fw2bk?=
 =?iso-8859-1?Q?uYeMaLFSXMv2zxppcmMqkNXO7T9e+nu1Ple0YQdds8IwD6f2weMcsWmKvy?=
 =?iso-8859-1?Q?5IKKDD9VOk+ky9RHhjtGsGjcY1PEu6fFVRXQEwY06OaRtqE0zb9BV3Ukxa?=
 =?iso-8859-1?Q?6IztN/ycESEM0aAjaJS+MYyQhbyt9m9rf9x01zK79gt6AoJIMY0KJg0cQ5?=
 =?iso-8859-1?Q?orEg7n8Sb+7eq+uQ7vflQaZMkYCkFpFBS26BG0Nlk6qsOU5mmiygbj/b6X?=
 =?iso-8859-1?Q?Yl3HLdRYvfpxbyiwx6E98iwXxVezPNId8I4OOsjeG9VFbIjRYAHneoxsic?=
 =?iso-8859-1?Q?N16H8Ycr/grmn/4e3D9pYdgn/6DF4S9VatoortZ+jpCLB6Ab3tIFuD63bL?=
 =?iso-8859-1?Q?oG4fEXRgzbF9S0JPRKXoBoNvKYG+sZnn42fWYIIdrHPZjO0QTI0WkcyL2M?=
 =?iso-8859-1?Q?Po0VyvogjvtStAwIIaSrC4BXJIRGymPfRFX2DlOWSf01XqpElpUYT+Op8U?=
 =?iso-8859-1?Q?IkftukA1Tb7k0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ef97a486-1dd5-460d-dc77-08dbcfc3eb89
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:20:58.0050 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J3e9Kc9DrWNAj74sARwxAIsBT9SQmYEFuaXq+8O4WYIlk7tB10a/dg++XI5ETqIZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Received-SPF: softfail client-ip=2a01:111:f400:7e88::606;
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
>Subject: [PATCH 05/11] hw/net/cadence_gem: use FIELD to describe DMACFG
>register fields
>
>Use de FIELD macro to describe the DMACFG register fields.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com

>---
> hw/net/cadence_gem.c | 48 ++++++++++++++++++++++++++++---------------
>-
> 1 file changed, 31 insertions(+), 17 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>09f570b6fb..5c386adff2 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -108,11 +108,31 @@ REG32(NWCFG, 0x4) /* Network Config reg */
>     FIELD(NWCFG, IGNORE_IPG_RX_ER, 30, 1)
>     FIELD(NWCFG, UNI_DIRECTION_ENABLE, 31, 1)
>
> REG32(NWSTATUS, 0x8) /* Network Status reg */  REG32(USERIO, 0xc) /*
>User IO reg */
>+
> REG32(DMACFG, 0x10) /* DMA Control reg */
>+    FIELD(DMACFG, SEND_BCAST_TO_ALL_QS, 31, 1)
>+    FIELD(DMACFG, DMA_ADDR_BUS_WIDTH, 30, 1)
>+    FIELD(DMACFG, TX_BD_EXT_MODE_EN , 29, 1)
>+    FIELD(DMACFG, RX_BD_EXT_MODE_EN , 28, 1)
>+    FIELD(DMACFG, FORCE_MAX_AMBA_BURST_TX, 26, 1)
>+    FIELD(DMACFG, FORCE_MAX_AMBA_BURST_RX, 25, 1)
>+    FIELD(DMACFG, FORCE_DISCARD_ON_ERR, 24, 1)
>+    FIELD(DMACFG, RX_BUF_SIZE, 16, 8)
>+    FIELD(DMACFG, CRC_ERROR_REPORT, 13, 1)
>+    FIELD(DMACFG, INF_LAST_DBUF_SIZE_EN, 12, 1)
>+    FIELD(DMACFG, TX_PBUF_CSUM_OFFLOAD, 11, 1)
>+    FIELD(DMACFG, TX_PBUF_SIZE, 10, 1)
>+    FIELD(DMACFG, RX_PBUF_SIZE, 8, 2)
>+    FIELD(DMACFG, ENDIAN_SWAP_PACKET, 7, 1)
>+    FIELD(DMACFG, ENDIAN_SWAP_MGNT, 6, 1)
>+    FIELD(DMACFG, HDR_DATA_SPLIT_EN, 5, 1)
>+    FIELD(DMACFG, AMBA_BURST_LEN , 0, 5)
>+#define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplie=
r
>*/
>+
> REG32(TXSTATUS, 0x14) /* TX Status reg */  REG32(RXQBASE, 0x18) /* RX Q
>Base address reg */  REG32(TXQBASE, 0x1c) /* TX Q Base address reg */
>REG32(RXSTATUS, 0x20) /* RX Status reg */  REG32(ISR, 0x24) /* Interrupt
>Status reg */ @@ -263,17 +283,10 @@ REG32(TYPE2_COMPARE_0_WORD_1,
>0x704)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
>     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
>
> /*****************************************/
>-#define GEM_DMACFG_ADDR_64B    (1U << 30)
>-#define GEM_DMACFG_TX_BD_EXT   (1U << 29)
>-#define GEM_DMACFG_RX_BD_EXT   (1U << 28)
>-#define GEM_DMACFG_RBUFSZ_M    0x00FF0000 /* DMA RX Buffer Size mask
>*/
>-#define GEM_DMACFG_RBUFSZ_S    16         /* DMA RX Buffer Size shift */
>-#define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplie=
r
>*/
>-#define GEM_DMACFG_TXCSUM_OFFL 0x00000800 /* Transmit checksum
>offload */
>
> #define GEM_TXSTATUS_TXCMPL    0x00000020 /* Transmit Complete */
> #define GEM_TXSTATUS_USED      0x00000001 /* sw owned descriptor
>encountered */
>
> #define GEM_RXSTATUS_FRMRCVD   0x00000002 /* Frame received */
>@@ -367,11 +380,11 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>
> static inline uint64_t tx_desc_get_buffer(CadenceGEMState *s, uint32_t *d=
esc)
>{
>     uint64_t ret =3D desc[0];
>
>-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
>+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
>         ret |=3D (uint64_t)desc[2] << 32;
>     }
>     return ret;
> }
>
>@@ -412,25 +425,25 @@ static inline void print_gem_tx_desc(uint32_t *desc,
>uint8_t queue)
>
> static inline uint64_t rx_desc_get_buffer(CadenceGEMState *s, uint32_t *d=
esc)
>{
>     uint64_t ret =3D desc[0] & ~0x3UL;
>
>-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
>+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
>         ret |=3D (uint64_t)desc[2] << 32;
>     }
>     return ret;
> }
>
> static inline int gem_get_desc_len(CadenceGEMState *s, bool rx_n_tx)  {
>     int ret =3D 2;
>
>-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
>+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
>         ret +=3D 2;
>     }
>-    if (s->regs[R_DMACFG] & (rx_n_tx ? GEM_DMACFG_RX_BD_EXT
>-                                       : GEM_DMACFG_TX_BD_EXT)) {
>+    if (s->regs[R_DMACFG] & (rx_n_tx ?
>R_DMACFG_RX_BD_EXT_MODE_EN_MASK
>+                                     :
>+ R_DMACFG_TX_BD_EXT_MODE_EN_MASK)) {
>         ret +=3D 2;
>     }
>
>     assert(ret <=3D DESC_MAX_NUM_WORDS);
>     return ret;
>@@ -940,11 +953,11 @@ static inline uint32_t
>gem_get_rx_queue_base_addr(CadenceGEMState *s, int q)
>
> static hwaddr gem_get_desc_addr(CadenceGEMState *s, bool tx, int q)  {
>     hwaddr desc_addr =3D 0;
>
>-    if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
>+    if (FIELD_EX32(s->regs[R_DMACFG], DMACFG, DMA_ADDR_BUS_WIDTH)) {
>         desc_addr =3D s->regs[tx ? R_TBQPH : R_RBQPH];
>     }
>     desc_addr <<=3D 32;
>     desc_addr |=3D tx ? s->tx_desc_addr[q] : s->rx_desc_addr[q];
>     return desc_addr;
>@@ -1022,12 +1035,13 @@ static ssize_t gem_receive(NetClientState *nc,
>const uint8_t *buf, size_t size)
>     rxbuf_offset =3D FIELD_EX32(s->regs[R_NWCFG], NWCFG,
>RECV_BUF_OFFSET);
>
>     /* The configure size of each receive buffer.  Determines how many
>      * buffers needed to hold this packet.
>      */
>-    rxbufsize =3D ((s->regs[R_DMACFG] & GEM_DMACFG_RBUFSZ_M) >>
>-                 GEM_DMACFG_RBUFSZ_S) * GEM_DMACFG_RBUFSZ_MUL;
>+    rxbufsize =3D FIELD_EX32(s->regs[R_DMACFG], DMACFG, RX_BUF_SIZE);
>+    rxbufsize *=3D GEM_DMACFG_RBUFSZ_MUL;
>+
>     bytes_to_copy =3D size;
>
>     /* Hardware allows a zero value here but warns against it. To avoid Q=
EMU
>      * indefinite loops we enforce a minimum value here
>      */
>@@ -1306,11 +1320,11 @@ static void gem_transmit(CadenceGEMState *s)
>
>                 /* Handle interrupt consequences */
>                 gem_update_int_status(s);
>
>                 /* Is checksum offload enabled? */
>-                if (s->regs[R_DMACFG] & GEM_DMACFG_TXCSUM_OFFL) {
>+                if (FIELD_EX32(s->regs[R_DMACFG], DMACFG,
>+ TX_PBUF_CSUM_OFFLOAD)) {
>                     net_checksum_calculate(s->tx_packet, total_bytes, CSU=
M_ALL);
>                 }
>
>                 /* Update MAC statistics */
>                 gem_transmit_updatestats(s, s->tx_packet, total_bytes); @=
@ -
>1330,11 +1344,11 @@ static void gem_transmit(CadenceGEMState *s)
>                 total_bytes =3D 0;
>             }
>
>             /* read next descriptor */
>             if (tx_desc_get_wrap(desc)) {
>-                if (s->regs[R_DMACFG] & GEM_DMACFG_ADDR_64B) {
>+                if (FIELD_EX32(s->regs[R_DMACFG], DMACFG,
>+ DMA_ADDR_BUS_WIDTH)) {
>                     packet_desc_addr =3D s->regs[R_TBQPH];
>                     packet_desc_addr <<=3D 32;
>                 } else {
>                     packet_desc_addr =3D 0;
>                 }
>--
>2.39.2


