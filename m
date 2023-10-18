Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 921757CD914
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:22:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3gt-0005gc-Hf; Wed, 18 Oct 2023 06:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3gi-0005aR-US
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:22:10 -0400
Received: from mail-dm6nam10on20622.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::622]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3gc-0001og-Kl
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:22:01 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YmI2CmcHwMY0j6pMqHd7L49FQMDDsMMs0RQDFVMjdygEpJ6XMLyxIpcRR7InfhuP8YoYBqkkF1fBE5nbJUFyoc76oJFht88cM8ypH3Dku0RGa3xhmCg7T507oEeSlJCJTsqdz1tBL2yogYMWPcbH6G6GXxyFcikSmcGDWiW2Kg1tPveIup3VoHze+hrb3ZEG5FROC2e8ysEAziZuZh9uOCnwtqTbji/ktaF/nabQYQKcSC6YralqFNpMfL9vV/ADsDpn6i5Pj3fV4ht2nk3MXlxFarPxvXjWSA3tw8IU38s/MhuZyMhZqvaMOFV4Uf4Pw2h/RfkHqEfndp15eMgfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p1BXYdxgKAHxDzbJYaPfSiJFuzVHnlyI2wdEenDMfoo=;
 b=NoHtugWo2GD0VPEDoCaPAoSb5axmf8xt4OxibwReoa+Db1BOJhwaln5zyHjt7G3a3Mxn7XQJhfXqIF8ZYf2wjgU6TF0vtQujnX3edXtrZRH3yrhNv978hvWXgIcMPXNmUX6WzntHcKevAIlboaiQlku/6V5MnF1lrxvPBocQWqz/lcmdm/vGoi0blDEDoK3J0xpCXGyHnovp7evjNbVYE88A+LadslCqWO49gBfzwWryr+tmSMM3g4TA6r6CkMFiLU/7QQKQ5+qBb5eDdYvb3J9O1zKMHjA+5AGwutZyRWWq2jx2Reu6mfeKZjU7dDoX1NgPgRFnAFjtn4e06zmMUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p1BXYdxgKAHxDzbJYaPfSiJFuzVHnlyI2wdEenDMfoo=;
 b=06VVVHvI2vOSdkm+3bvSHHY7L3fwYdJ+34ICQmbQ8/PWW7DLM907WB3He8mVcWUJAHVex+hwFr14YNrsiwJewonr7SUgbOXeXygQPV6fAWr7jWpzBl8h0kDiicvAdJDC8bllYe1asvq+iFg399Y6QK5Zp3ki7/B5dS/QFBp9etc=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 IA0PR12MB7652.namprd12.prod.outlook.com (2603:10b6:208:434::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6863.47; Wed, 18 Oct 2023 10:21:46 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:21:46 +0000
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
Subject: RE: [PATCH 06/11] hw/net/cadence_gem: use FIELD to describe
 [TX|RX]STATUS register fields
Thread-Topic: [PATCH 06/11] hw/net/cadence_gem: use FIELD to describe
 [TX|RX]STATUS register fields
Thread-Index: AQHaATJp09jFNvHCTk+6o8DV3dIQgrBPV1Rg
Date: Wed, 18 Oct 2023 10:21:46 +0000
Message-ID: <DS7PR12MB57410ADA288A1EB0BB6AAC60B6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-7-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-7-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|IA0PR12MB7652:EE_
x-ms-office365-filtering-correlation-id: 490c0230-9130-48d0-6fbd-08dbcfc40872
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: q/QN2+OC1XIRvDk1hir/sghFZt1dqtm5aXPVWPU7uopOnb6EwLAoT20Viq+Rl1ilo2sEi07ovHtNE7P773ev7BnOTcWJ3HtpU5LvsRWJNrCrCoeAvVCn1mNGHfoxbdcSN7xSfv6gBZ2sGuPSj/jVGqCYF6jnZ8Pz3LLsE+qQ5YiXOU8Av5YuvCl3i8+dArdI5yDOaOT/x0gTW/+u5ddWz/FLrrWh0UGxvIQmHD0FvAqaaVrFyiH+qRlQB7MqnVbVw0pmQ+jGHDQGklZRozYg6Bl0109owDDvLG2quvNl/9QpqEX96ThcTDP+5JTlkD8Eek6VwIPee1ViiIC2ZpIEj5Xvi+EqHrcvkGX9a6cxGujtrlAzD9mjEtDmeiKEYJ620YvjAtnMYfsvTY3jW3ft+9blm7Q+G2ZK5N6CaYvr63dgxu4QZJJi73XmwDCp6VBU9ieAUZjsvYKBz/hlp3QiTYL3i8VPfy/pJm5AJeBM1/5RiKyr2iL1t/mealG/7eVeRJCmwgJyRN126gPcojllc2SJfBh5EmNCPcP0Rz6qpoNtrbrAgtCqvxBLFCjHnDQ6aHVyUshhnmXtBZYWYqr3n3bi6Vb0iC2ZFAYgMYSEoUzkepK2bpJAeEtEi3ZF19/pOhqDmBqOTTzm4ipxVZqgcXyplF2AbBL0lzys2kDzo6eBPXlVgm9mOKOnWcQwBIuI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(39860400002)(366004)(376002)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(26005)(7696005)(9686003)(6506007)(83380400001)(66476007)(71200400001)(52536014)(8936002)(4326008)(316002)(5660300002)(478600001)(2906002)(8676002)(54906003)(64756008)(66556008)(66946007)(76116006)(110136005)(38070700005)(122000001)(86362001)(66446008)(38100700002)(41300700001)(33656002)(83133001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?UvmpMe0cIGoiCuGc5CkPOYtfHsUhQrLZ9qX9JU20lAG6vr97aWsrBLLtkn?=
 =?iso-8859-1?Q?9yZlJcjlrtfaowXqoxdpWdBqKs/ApvnBplFkmqCDEra0ufy8ZZ04uWI1yF?=
 =?iso-8859-1?Q?hGtBjaSjW/rGTmnmxKv0nAys78MjTGxuRgZVhF40qJ7sGVU5/pNKD5rqQC?=
 =?iso-8859-1?Q?IxioNdra0DnCGenaG2gn3mIGL4EmJenaH/bkg6GP1T+jYwwFHBqpkWUZFS?=
 =?iso-8859-1?Q?4y1myX+zq1uJrnNd52YWBAKXo55ZKe6dF0VD2FRpkNUZvT27dUQL5gWut+?=
 =?iso-8859-1?Q?NIi+tdyUO2KHn1W26smKJ5OV5sySI5Fuyv00D8lpZYr1dDUaN8ybRaQ+Ah?=
 =?iso-8859-1?Q?DUBqcRbYX5HAtfxaEu0uJ7ZKSH93599M6ZQ1OtU1lrAFTqLkDc2RpVGzuh?=
 =?iso-8859-1?Q?QZR3DtX4MixSY4Uau2g6kjjSofFjV4X6SsnZ2O+HwPjeV8D3Ub1dVuhN0H?=
 =?iso-8859-1?Q?H7SmmPQoX8QkI7UoOG9paVNrdBiNQh53jmzSLaxi9DEm409D2a1pRtr6P0?=
 =?iso-8859-1?Q?zKtgJhi3XcjPttuvhBQP/OnhKfXXq7nR88cE2Ew5+ySsI9idQcZ7RiGJl9?=
 =?iso-8859-1?Q?QQpYHRT8LorUqfMqTczRRw8auHBqRPBpZX5ePJ8etSy8T7mw/494nxuIRY?=
 =?iso-8859-1?Q?aA5R6c7LL1kuexln0EZqY48HDPlBvxAP1VuknMavWr/fkXnaO1Z7M9kZ0M?=
 =?iso-8859-1?Q?hzGLQ5f1JCM7rj/jOe6deNIVm9VXp/Zj703maik7mYq1NyqlSd5PNuolH6?=
 =?iso-8859-1?Q?pXFDy54wSZTE8H9y4dOdfF7dEfpWR957eek3dmEk7EOhyhcK7jCR5XruPl?=
 =?iso-8859-1?Q?BvJSO8ZaaFuNj9ABRYNiWVlFNAqtOUufEojyIbNQqQ2tV18BLACgc3BlbV?=
 =?iso-8859-1?Q?SVrJI23Py/7vcD8oIP3x33tkppH5xKBlwUIjqewTiGofnHTUGZjgUGElf+?=
 =?iso-8859-1?Q?EVBxlF45DHy6IWKvb4X4uvvgL69VOtHW2Oj3li9rAKSstqGnWrgg6b2D98?=
 =?iso-8859-1?Q?+Sn+XKrSK+y0SQX3VArI5zLoHLKzsUIDVTtigbNTMYwn3vgD9MFu7Kc4C7?=
 =?iso-8859-1?Q?TkBE6LQSrHeax/c4YEDz8jI8ATzDN7Qtylc6n043V6yCf4tUOcfKlLLZMy?=
 =?iso-8859-1?Q?ZxUoL/OVxC/EQkDFNG/oTH8ccNbeGDFjAR9SxcsKi0jDmZmABPm3cHbrzG?=
 =?iso-8859-1?Q?6OEtUxym6xoPklGebbykynhswLxJM4VWtBAVj8fU+VDEVHeK7AR8TMMSfV?=
 =?iso-8859-1?Q?pWxS8JGHhfMI6lMW/wEP3dT3CgnkaKvkpuz8Xr8XSwpz/gGZyj4DA++zOV?=
 =?iso-8859-1?Q?qAhT6tpUbckOhSbrQR8DhPrgKsgH+Ck82P1fAeeQCw34lF7TwBy7LnyYVL?=
 =?iso-8859-1?Q?70K3Tad/n/OpF4G3td78dhc/Rf1MHCOEOR2mWYrh8VI7j6dwPm/vZAz/i+?=
 =?iso-8859-1?Q?sciysTqWRjMyceCx1NfE8VmO3p5lEZ0YS39ntBQssYzw3v/w65sOgBwYYw?=
 =?iso-8859-1?Q?s3MmgTphzDu1QQjQf/gdxFq0LWGhCVEWxurpWHn8P9qctjeUJb2U7IpDHQ?=
 =?iso-8859-1?Q?N8IptGRa7M1/dad3eqmA+G3IREFeuA46+uIGQoHHm/lIN4kH6LXzAZiPhb?=
 =?iso-8859-1?Q?uExi+XWFJN4+c=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 490c0230-9130-48d0-6fbd-08dbcfc40872
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:21:46.4976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LFpOWpw2bMyxtkWQP4BUn7ik/zjqUmYQY4sGS7UhMWORb2/ea80Ldg2n/KhbU4Pq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7652
Received-SPF: softfail client-ip=2a01:111:f400:7e88::622;
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
>Subject: [PATCH 06/11] hw/net/cadence_gem: use FIELD to describe
>[TX|RX]STATUS register fields
>
>Use de FIELD macro to describe the TXSTATUS and RXSTATUS register fields.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com


>---
> hw/net/cadence_gem.c | 34 +++++++++++++++++++++++++---------
> 1 file changed, 25 insertions(+), 9 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>5c386adff2..0acee1d544 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -130,13 +130,34 @@ REG32(DMACFG, 0x10) /* DMA Control reg */
>     FIELD(DMACFG, HDR_DATA_SPLIT_EN, 5, 1)
>     FIELD(DMACFG, AMBA_BURST_LEN , 0, 5)
> #define GEM_DMACFG_RBUFSZ_MUL  64         /* DMA RX Buffer Size multiplie=
r
>*/
>
> REG32(TXSTATUS, 0x14) /* TX Status reg */
>+    FIELD(TXSTATUS, TX_USED_BIT_READ_MIDFRAME, 12, 1)
>+    FIELD(TXSTATUS, TX_FRAME_TOO_LARGE, 11, 1)
>+    FIELD(TXSTATUS, TX_DMA_LOCKUP, 10, 1)
>+    FIELD(TXSTATUS, TX_MAC_LOCKUP, 9, 1)
>+    FIELD(TXSTATUS, RESP_NOT_OK, 8, 1)
>+    FIELD(TXSTATUS, LATE_COLLISION, 7, 1)
>+    FIELD(TXSTATUS, TRANSMIT_UNDER_RUN, 6, 1)
>+    FIELD(TXSTATUS, TRANSMIT_COMPLETE, 5, 1)
>+    FIELD(TXSTATUS, AMBA_ERROR, 4, 1)
>+    FIELD(TXSTATUS, TRANSMIT_GO, 3, 1)
>+    FIELD(TXSTATUS, RETRY_LIMIT, 2, 1)
>+    FIELD(TXSTATUS, COLLISION, 1, 1)
>+    FIELD(TXSTATUS, USED_BIT_READ, 0, 1)
>+
> REG32(RXQBASE, 0x18) /* RX Q Base address reg */  REG32(TXQBASE, 0x1c) /*
>TX Q Base address reg */  REG32(RXSTATUS, 0x20) /* RX Status reg */
>+    FIELD(RXSTATUS, RX_DMA_LOCKUP, 5, 1)
>+    FIELD(RXSTATUS, RX_MAC_LOCKUP, 4, 1)
>+    FIELD(RXSTATUS, RESP_NOT_OK, 3, 1)
>+    FIELD(RXSTATUS, RECEIVE_OVERRUN, 2, 1)
>+    FIELD(RXSTATUS, FRAME_RECEIVED, 1, 1)
>+    FIELD(RXSTATUS, BUF_NOT_AVAILABLE, 0, 1)
>+
> REG32(ISR, 0x24) /* Interrupt Status reg */  REG32(IER, 0x28) /* Interrup=
t
>Enable reg */  REG32(IDR, 0x2c) /* Interrupt Disable reg */  REG32(IMR, 0x=
30)
>/* Interrupt Mask reg */  REG32(PHYMNTNC, 0x34) /* Phy Maintenance reg */
>@@ -284,15 +305,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
>
> /*****************************************/
>
>-#define GEM_TXSTATUS_TXCMPL    0x00000020 /* Transmit Complete */
>-#define GEM_TXSTATUS_USED      0x00000001 /* sw owned descriptor
>encountered */
>-
>-#define GEM_RXSTATUS_FRMRCVD   0x00000002 /* Frame received */
>-#define GEM_RXSTATUS_NOBUF     0x00000001 /* Buffer unavailable */
>
> /* GEM_ISR GEM_IER GEM_IDR GEM_IMR */
> #define GEM_INT_TXCMPL        0x00000080 /* Transmit Complete */
> #define GEM_INT_AMBA_ERR      0x00000040
> #define GEM_INT_TXUSED         0x00000008
>@@ -985,11 +1001,11 @@ static void gem_get_rx_desc(CadenceGEMState *s,
>int q)
>                        sizeof(uint32_t) * gem_get_desc_len(s, true));
>
>     /* Descriptor owned by software ? */
>     if (rx_desc_get_ownership(s->rx_desc[q]) =3D=3D 1) {
>         DB_PRINT("descriptor 0x%" HWADDR_PRIx " owned by sw.\n",
>desc_addr);
>-        s->regs[R_RXSTATUS] |=3D GEM_RXSTATUS_NOBUF;
>+        s->regs[R_RXSTATUS] |=3D R_RXSTATUS_BUF_NOT_AVAILABLE_MASK;
>         gem_set_isr(s, q, GEM_INT_RXUSED);
>         /* Handle interrupt consequences */
>         gem_update_int_status(s);
>     }
> }
>@@ -1162,11 +1178,11 @@ static ssize_t gem_receive(NetClientState *nc,
>const uint8_t *buf, size_t size)
>     }
>
>     /* Count it */
>     gem_receive_updatestats(s, buf, size);
>
>-    s->regs[R_RXSTATUS] |=3D GEM_RXSTATUS_FRMRCVD;
>+    s->regs[R_RXSTATUS] |=3D R_RXSTATUS_FRAME_RECEIVED_MASK;
>     gem_set_isr(s, q, GEM_INT_RXCMPL);
>
>     /* Handle interrupt consequences */
>     gem_update_int_status(s);
>
>@@ -1313,11 +1329,11 @@ static void gem_transmit(CadenceGEMState *s)
>                     s->tx_desc_addr[q] =3D packet_desc_addr +
>                                          4 * gem_get_desc_len(s, false);
>                 }
>                 DB_PRINT("TX descriptor next: 0x%08x\n", s->tx_desc_addr[=
q]);
>
>-                s->regs[R_TXSTATUS] |=3D GEM_TXSTATUS_TXCMPL;
>+                s->regs[R_TXSTATUS] |=3D
>+ R_TXSTATUS_TRANSMIT_COMPLETE_MASK;
>                 gem_set_isr(s, q, GEM_INT_TXCMPL);
>
>                 /* Handle interrupt consequences */
>                 gem_update_int_status(s);
>
>@@ -1361,11 +1377,11 @@ static void gem_transmit(CadenceGEMState *s)
>                                MEMTXATTRS_UNSPECIFIED, desc,
>                                sizeof(uint32_t) * gem_get_desc_len(s, fal=
se));
>         }
>
>         if (tx_desc_get_used(desc)) {
>-            s->regs[R_TXSTATUS] |=3D GEM_TXSTATUS_USED;
>+            s->regs[R_TXSTATUS] |=3D R_TXSTATUS_USED_BIT_READ_MASK;
>             /* IRQ TXUSED is defined only for queue 0 */
>             if (q =3D=3D 0) {
>                 gem_set_isr(s, 0, GEM_INT_TXUSED);
>             }
>             gem_update_int_status(s);
>--
>2.39.2


