Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 47F557CD8EE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:15:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3Zd-0000zE-GB; Wed, 18 Oct 2023 06:14:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3Zb-0000z6-4t
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:14:43 -0400
Received: from mail-bn8nam12on20605.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::605]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3ZZ-000092-6L
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:14:42 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TpePqw4nL19Ap911QYtbGdGzgWG7GTCBnu+Fy0wlswOUDL1ZR4aFLgozQWyFqL1ryD2tmCrIjvTYnMwi3nA4mInOm7tnEVGZeAGeQhw6FLf1mkjOqpxmisd7kmrdSEnrln936DgeBgGqS3scpm5D0WDRWp2eBSkfuamQuCwf5G6u4H8yFsVAXQ9jVs8Q1Jz4mQKviiHXkJ/T0tY7mtSimINZqrogBMzFsxOZ4elasqnsh5mXJVO9sgJ7BDgaft6AHCjWxm/ypE6Ji98ApA7mmFpxXuUFZZ8+WGWVsfdIwn9y5n+ctObBbVR+xLDRgY7ef5NIc7kPFK7xcfWTfG8KzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wa3o/UzmotaHV31GSrJrScnzFgviLQKFGcAPcegXmhI=;
 b=IgTTNfvQkI+b7pE6FNMpKMD5Otpc8N5dmiHJGdjvRf2eJQ/3fovOu/bKhF1p0jQ9QzX1q0GjEi+hJqNflik7/njglJVe+MJW1+ak+mpXEIWK2mZHEpWGk5kngapeajYDG16+m8byg+9Ie5Fni4n0o+sMhhmNvy5l2ZVnrKGhAm6o/l8F7xoHEGmhy/3urlhBPhh5EyPfNjpYvLxZ3hQ3RbQNFtj3cXe1WFOi0gJO+e5zDJJI0ehUDeWDkUq+PhTTM9Ox0Wjhz+H4c9/3p0Z1UIUtW2O2e2LKuOQqeBQToVX63tAiAhZV2n1pjMZSToTomz/HpPf9Ncpsc3mZ9vgkjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wa3o/UzmotaHV31GSrJrScnzFgviLQKFGcAPcegXmhI=;
 b=wsBMBra8LLCBXV1jJdGD4NttctzFT9CzWJTMgWxd3GkHQZii2btz33dQOfJgqlYANR/PbYAGDg0a7aHQQ5RRIuW0KO8bXMvaC2d5KNtJaeP65NMt97F5FY3j2nt2xeOW4sB/hvaWJsz+6//8P0C6nLbhZKK1fQYjbe+QFev8gjA=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 10:14:29 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:14:29 +0000
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
Subject: RE: [PATCH 02/11] hw/net/cadence_gem: use FIELD for screening
 registers
Thread-Topic: [PATCH 02/11] hw/net/cadence_gem: use FIELD for screening
 registers
Thread-Index: AQHaATJe0ywlEMnZbUaSBY8oGHvTC7BPVSjg
Date: Wed, 18 Oct 2023 10:14:29 +0000
Message-ID: <DS7PR12MB57412366EE672C8CAE7BF3A3B6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-3-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-3-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|PH7PR12MB6882:EE_
x-ms-office365-filtering-correlation-id: e3c6d6b7-6d1a-4c82-d080-08dbcfc3041c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MYUDCDWV+Tsl4LK7aTOYpRdbeDavto5yNK2WqENWXdcNxtwf3BKp41TTmp+d/KDnLVfxHiTk+ZUYUp819Vowc+EGQt2BVXJ6tY/ALr8h/35tMPpJeKewiN+gTpwnyWdVmm2CLDOwm1j4sFLGsTAKgjXUtm7xVWXFZx+mDdKVv9lQyjfSn9mVuxDvPDn8lhcyEDNCxAHcM4PF53IkbHayqzstZPu0LTz0zGn4lEk45luwqrzfms3idIxqYsRVn825N0wW4y3sp9wh7j6jShMgnYSxbdxLfSLJjSHGaOpmXTvUXk09Z21yjh4SBl4VrVqgRig7OAo4na8gaHEz+kgSqlS5SLAD1VGFhatr8bCblNG7u4UCxWL2sFpdKtvnJnFrqGYk2ZoXVqwo0EidtAzLN/GxzJQLHB1yKy5yGzApVgX1NkVgDRaEUo9lEgYaDP/rgdX3nTpzeMK0/ArJ2AdGk/CECgcK7gCdDbJDfKsT3f3egDlhHU/pnWE8C5MjQBI3t1G8u5r7D5xdNFktVIY9HOfdu3INCeS/OfqyWd6sXcV8GGRZ4iTeh3IGtstG6C58R0nf5vv1IJcRcG8dNcbHGqKC5OBsdLGUYfmR7YuLn991dxpRCbB5SbOEaGKCNk/i
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(6506007)(7696005)(52536014)(33656002)(71200400001)(5660300002)(2906002)(122000001)(83380400001)(26005)(38100700002)(38070700005)(86362001)(9686003)(54906003)(316002)(66556008)(41300700001)(110136005)(64756008)(66946007)(66446008)(66476007)(76116006)(478600001)(8936002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?10qLXL5Z/MxyMPIXDIl8Kir1Ws0a3wziixxBSCNIE/cxXJWuqxowBS35kg?=
 =?iso-8859-1?Q?2wUNG+PN6c/DO92IibXaZJshMQuWpBvr1EtMRPpBA2TsOYNdH9TsGedVlJ?=
 =?iso-8859-1?Q?V6LEFJxKaWldw/K+fCPvO82Lsb+MZC7OtalqhV6NpC/b5EnCEGu7LjlNnC?=
 =?iso-8859-1?Q?TShqLx770AnAd/hNEQCEpbYTww7iqDrdJUm89q79lt6a0MpeUyAVvbjYCG?=
 =?iso-8859-1?Q?WeeuQmbDG5rVlmkusaXqCLE8sTR3GTJTPLjY7FP75b7hMmBAulIkv9ONCp?=
 =?iso-8859-1?Q?L6HUTJNmiRbjAB4Eq6t6vWRrfjXPc76HU+ePVpkcYD84AqRh0Xufl09LKh?=
 =?iso-8859-1?Q?DKSYn9BQFI4lsmj55/Zc+Aud2c0wgkj3HWFS/Q5fNlv8EiFVOYIMkW3kbS?=
 =?iso-8859-1?Q?covx9ErLhgYlpDeQtNUyzAgHCoLDzmjSS9iuEcKOrcG3eG78LctCyDPIiz?=
 =?iso-8859-1?Q?Ll3gf1SIkivCccznuEj+kmNLpUt1okEQq2hJvJExt2EWQZY0r8jTHj9O5t?=
 =?iso-8859-1?Q?V15eJVr/QiErPgICH1vx+LtviNgoREe/3k/CY1Jh+RGAzaPGWFxjnvLP25?=
 =?iso-8859-1?Q?rnSZscrK9eMip8LhzDiha9rkgx5KtbL/orYY1T8aHhSYg9chmd34wj/9tk?=
 =?iso-8859-1?Q?ySaxYtFMJ/RBbvgikP9BnToXvjI5VsRshw6MmL3g8lJyIx/Ywiw4CCajK3?=
 =?iso-8859-1?Q?jU/8ZaQCqf1iuLMGtz4dTLVKfMbAtL4L4TXcNerC7iGZcgvMjNnr5+q6tL?=
 =?iso-8859-1?Q?+EgMYyCRm60YyCSHqYsq2D3vpAc5bBLFvbLxeTiVOxic7WMy4Exe4wApFW?=
 =?iso-8859-1?Q?xlk/MVROC21LscIdgWNz69/0ZEEdxsp+lO6h054vfsmWurpMvGi69q9cUU?=
 =?iso-8859-1?Q?uj49lbBZTx6vEsMmdLmzTlyHxxt5knx7jUblvWbbna74aIuiyyFtu0kDo1?=
 =?iso-8859-1?Q?TA+7vIvKMG14P1SUCUuThlwTodHXLWc2bOwUm33T9KTQLudH9A+22eyBUk?=
 =?iso-8859-1?Q?RahppG41mULsNvaVu4znA3HjYBLcnOkWSzmskBbbBUEWAUqSHMFIwngSWy?=
 =?iso-8859-1?Q?c64tui7sebVs9zUzmMfkAcv9w66z8QtcecFryTHNmlDyLgoNhyxA2DPQpc?=
 =?iso-8859-1?Q?n6W7sgp4qlKubYpQajzbGbJ8SkgAg8dvvG9wr1HCh38duMV9XD7HHAAo0b?=
 =?iso-8859-1?Q?mcXvTZ0mxwpKFVDbXJ3ZeH95oyozwU/vKGAB2LpRYNlk28Ff/T/TEO7Ris?=
 =?iso-8859-1?Q?rb7YNv9OLQich5L+TLAg7FU2ziTzx4dWqi4iUH37yXjUphxCWKoDT3Lqzb?=
 =?iso-8859-1?Q?du3cI148ddbvxAZpSn3W3yCxbQAPQZovqbY49iBTj7A/sjGN6bIJUxHx0t?=
 =?iso-8859-1?Q?Q5iQqakLJT+9PVdjFgt/NB2K64h4pD0MmciOPiqCmC+QCLb1n0RpSdgNXe?=
 =?iso-8859-1?Q?3yHSY3VeieBXzagj3Dmw/9UU4OOhuTad+/QYMos++LggglFVi+zxvWgmvG?=
 =?iso-8859-1?Q?RXkAQH0TUO0vEqef/xD5VrNbze5x8iszTd9sc2+Luqmf4maeEnTPUwOxYQ?=
 =?iso-8859-1?Q?QZMrOpLDJSSwJADxpGtz+cRAc6GGcVSu7vRHoI63t2bOjfEstD4yKZ/LO8?=
 =?iso-8859-1?Q?9Ov1ITsno43Z0=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3c6d6b7-6d1a-4c82-d080-08dbcfc3041c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:14:29.7259 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kdWTiZ+tWoSoKGOwzxN1bqeeGzlNTMbwq/MnYjeRUVcbm87M0N8mPyZ2+RpWrUY7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::605;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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
>Subject: [PATCH 02/11] hw/net/cadence_gem: use FIELD for screening registe=
rs
>
>Describe screening registers fields using the FIELD macros.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com

Regards,
Sai Pavan
>---
> hw/net/cadence_gem.c | 92 ++++++++++++++++++++++----------------------
> 1 file changed, 47 insertions(+), 45 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>0e5744ecd7..f01c81de97 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -168,39 +168,42 @@ REG32(INT_Q7_ENABLE, 0x618)
>
> REG32(INT_Q1_DISABLE, 0x620)
> REG32(INT_Q7_DISABLE, 0x638)
>
> REG32(SCREENING_TYPE1_REG0, 0x500)
>-
>-#define GEM_ST1R_UDP_PORT_MATCH_ENABLE  (1 << 29)
>-#define GEM_ST1R_DSTC_ENABLE            (1 << 28)
>-#define GEM_ST1R_UDP_PORT_MATCH_SHIFT   (12)
>-#define GEM_ST1R_UDP_PORT_MATCH_WIDTH   (27 -
>GEM_ST1R_UDP_PORT_MATCH_SHIFT + 1)
>-#define GEM_ST1R_DSTC_MATCH_SHIFT       (4)
>-#define GEM_ST1R_DSTC_MATCH_WIDTH       (11 -
>GEM_ST1R_DSTC_MATCH_SHIFT + 1)
>-#define GEM_ST1R_QUEUE_SHIFT            (0)
>-#define GEM_ST1R_QUEUE_WIDTH            (3 - GEM_ST1R_QUEUE_SHIFT + 1)
>+    FIELD(SCREENING_TYPE1_REG0, QUEUE_NUM, 0, 4)
>+    FIELD(SCREENING_TYPE1_REG0, DSTC_MATCH, 4, 8)
>+    FIELD(SCREENING_TYPE1_REG0, UDP_PORT_MATCH, 12, 16)
>+    FIELD(SCREENING_TYPE1_REG0, DSTC_ENABLE, 28, 1)
>+    FIELD(SCREENING_TYPE1_REG0, UDP_PORT_MATCH_EN, 29, 1)
>+    FIELD(SCREENING_TYPE1_REG0, DROP_ON_MATCH, 30, 1)
>
> REG32(SCREENING_TYPE2_REG0, 0x540)
>-
>-#define GEM_ST2R_COMPARE_A_ENABLE       (1 << 18)
>-#define GEM_ST2R_COMPARE_A_SHIFT        (13)
>-#define GEM_ST2R_COMPARE_WIDTH          (17 -
>GEM_ST2R_COMPARE_A_SHIFT + 1)
>-#define GEM_ST2R_ETHERTYPE_ENABLE       (1 << 12)
>-#define GEM_ST2R_ETHERTYPE_INDEX_SHIFT  (9) -#define
>GEM_ST2R_ETHERTYPE_INDEX_WIDTH  (11 -
>GEM_ST2R_ETHERTYPE_INDEX_SHIFT \
>-                                            + 1)
>-#define GEM_ST2R_QUEUE_SHIFT            (0)
>-#define GEM_ST2R_QUEUE_WIDTH            (3 - GEM_ST2R_QUEUE_SHIFT + 1)
>+    FIELD(SCREENING_TYPE2_REG0, QUEUE_NUM, 0, 4)
>+    FIELD(SCREENING_TYPE2_REG0, VLAN_PRIORITY, 4, 3)
>+    FIELD(SCREENING_TYPE2_REG0, VLAN_ENABLE, 8, 1)
>+    FIELD(SCREENING_TYPE2_REG0, ETHERTYPE_REG_INDEX, 9, 3)
>+    FIELD(SCREENING_TYPE2_REG0, ETHERTYPE_ENABLE, 12, 1)
>+    FIELD(SCREENING_TYPE2_REG0, COMPARE_A, 13, 5)
>+    FIELD(SCREENING_TYPE2_REG0, COMPARE_A_ENABLE, 18, 1)
>+    FIELD(SCREENING_TYPE2_REG0, COMPARE_B, 19, 5)
>+    FIELD(SCREENING_TYPE2_REG0, COMPARE_B_ENABLE, 24, 1)
>+    FIELD(SCREENING_TYPE2_REG0, COMPARE_C, 25, 5)
>+    FIELD(SCREENING_TYPE2_REG0, COMPARE_C_ENABLE, 30, 1)
>+    FIELD(SCREENING_TYPE2_REG0, DROP_ON_MATCH, 31, 1)
>
> REG32(SCREENING_TYPE2_ETHERTYPE_REG0, 0x6e0)
>+
> REG32(TYPE2_COMPARE_0_WORD_0, 0x700)
>+    FIELD(TYPE2_COMPARE_0_WORD_0, MASK_VALUE, 0, 16)
>+    FIELD(TYPE2_COMPARE_0_WORD_0, COMPARE_VALUE, 16, 16)
>
>-#define GEM_T2CW1_COMPARE_OFFSET_SHIFT  (7) -#define
>GEM_T2CW1_COMPARE_OFFSET_WIDTH  (8 -
>GEM_T2CW1_COMPARE_OFFSET_SHIFT + 1)
>-#define GEM_T2CW1_OFFSET_VALUE_SHIFT    (0)
>-#define GEM_T2CW1_OFFSET_VALUE_WIDTH    (6 -
>GEM_T2CW1_OFFSET_VALUE_SHIFT + 1)
>+REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>+    FIELD(TYPE2_COMPARE_0_WORD_1, OFFSET_VALUE, 0, 7)
>+    FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
>+    FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
>+    FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
>
> /*****************************************/
> #define GEM_NWCTRL_TXSTART     0x00000200 /* Transmit Enable */
> #define GEM_NWCTRL_TXENA       0x00000008 /* Transmit Enable */
> #define GEM_NWCTRL_RXENA       0x00000004 /* Receive Enable */
>@@ -753,45 +756,43 @@ static int
>get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>         reg =3D s->regs[R_SCREENING_TYPE1_REG0 + i];
>         matched =3D false;
>         mismatched =3D false;
>
>         /* Screening is based on UDP Port */
>-        if (reg & GEM_ST1R_UDP_PORT_MATCH_ENABLE) {
>+        if (FIELD_EX32(reg, SCREENING_TYPE1_REG0, UDP_PORT_MATCH_EN)) {
>             uint16_t udp_port =3D rxbuf_ptr[14 + 22] << 8 | rxbuf_ptr[14 =
+ 23];
>-            if (udp_port =3D=3D extract32(reg, GEM_ST1R_UDP_PORT_MATCH_SH=
IFT,
>-                                           GEM_ST1R_UDP_PORT_MATCH_WIDTH)=
) {
>+            if (udp_port =3D=3D FIELD_EX32(reg, SCREENING_TYPE1_REG0,
>+ UDP_PORT_MATCH)) {
>                 matched =3D true;
>             } else {
>                 mismatched =3D true;
>             }
>         }
>
>         /* Screening is based on DS/TC */
>-        if (reg & GEM_ST1R_DSTC_ENABLE) {
>+        if (FIELD_EX32(reg, SCREENING_TYPE1_REG0, DSTC_ENABLE)) {
>             uint8_t dscp =3D rxbuf_ptr[14 + 1];
>-            if (dscp =3D=3D extract32(reg, GEM_ST1R_DSTC_MATCH_SHIFT,
>-                                       GEM_ST1R_DSTC_MATCH_WIDTH)) {
>+            if (dscp =3D=3D FIELD_EX32(reg, SCREENING_TYPE1_REG0,
>+ DSTC_MATCH)) {
>                 matched =3D true;
>             } else {
>                 mismatched =3D true;
>             }
>         }
>
>         if (matched && !mismatched) {
>-            return extract32(reg, GEM_ST1R_QUEUE_SHIFT,
>GEM_ST1R_QUEUE_WIDTH);
>+            return FIELD_EX32(reg, SCREENING_TYPE1_REG0, QUEUE_NUM);
>         }
>     }
>
>     for (i =3D 0; i < s->num_type2_screeners; i++) {
>         reg =3D s->regs[R_SCREENING_TYPE2_REG0 + i];
>         matched =3D false;
>         mismatched =3D false;
>
>-        if (reg & GEM_ST2R_ETHERTYPE_ENABLE) {
>+        if (FIELD_EX32(reg, SCREENING_TYPE2_REG0, ETHERTYPE_ENABLE)) {
>             uint16_t type =3D rxbuf_ptr[12] << 8 | rxbuf_ptr[13];
>-            int et_idx =3D extract32(reg, GEM_ST2R_ETHERTYPE_INDEX_SHIFT,
>-                                        GEM_ST2R_ETHERTYPE_INDEX_WIDTH);
>+            int et_idx =3D FIELD_EX32(reg, SCREENING_TYPE2_REG0,
>+                                    ETHERTYPE_REG_INDEX);
>
>             if (et_idx > s->num_type2_screeners) {
>                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range ethertype "
>                               "register index: %d\n", et_idx);
>             }
>@@ -803,31 +804,31 @@ static int
>get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>             }
>         }
>
>         /* Compare A, B, C */
>         for (j =3D 0; j < 3; j++) {
>-            uint32_t cr0, cr1, mask;
>+            uint32_t cr0, cr1, mask, compare;
>             uint16_t rx_cmp;
>             int offset;
>-            int cr_idx =3D extract32(reg, GEM_ST2R_COMPARE_A_SHIFT + j * =
6,
>-                                        GEM_ST2R_COMPARE_WIDTH);
>+            int cr_idx =3D extract32(reg,
>R_SCREENING_TYPE2_REG0_COMPARE_A_SHIFT + j * 6,
>+
>+ R_SCREENING_TYPE2_REG0_COMPARE_A_LENGTH);
>
>-            if (!(reg & (GEM_ST2R_COMPARE_A_ENABLE << (j * 6)))) {
>+            if (!extract32(reg,
>R_SCREENING_TYPE2_REG0_COMPARE_A_ENABLE_SHIFT + j * 6,
>+
>+ R_SCREENING_TYPE2_REG0_COMPARE_A_ENABLE_LENGTH)) {
>                 continue;
>             }
>+
>             if (cr_idx > s->num_type2_screeners) {
>                 qemu_log_mask(LOG_GUEST_ERROR, "Out of range compare "
>                               "register index: %d\n", cr_idx);
>             }
>
>             cr0 =3D s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2];
>-            cr1 =3D s->regs[R_TYPE2_COMPARE_0_WORD_0 + cr_idx * 2 + 1];
>-            offset =3D extract32(cr1, GEM_T2CW1_OFFSET_VALUE_SHIFT,
>-                                    GEM_T2CW1_OFFSET_VALUE_WIDTH);
>+            cr1 =3D s->regs[R_TYPE2_COMPARE_0_WORD_1 + cr_idx * 2];
>+            offset =3D FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1,
>+ OFFSET_VALUE);
>
>-            switch (extract32(cr1, GEM_T2CW1_COMPARE_OFFSET_SHIFT,
>-                                   GEM_T2CW1_COMPARE_OFFSET_WIDTH)) {
>+            switch (FIELD_EX32(cr1, TYPE2_COMPARE_0_WORD_1,
>+ COMPARE_OFFSET)) {
>             case 3: /* Skip UDP header */
>                 qemu_log_mask(LOG_UNIMP, "TCP compare offsets"
>                               "unimplemented - assuming UDP\n");
>                 offset +=3D 8;
>                 /* Fallthrough */
>@@ -841,21 +842,22 @@ static int
>get_queue_from_screen(CadenceGEMState *s, uint8_t *rxbuf_ptr,
>                 /* Offset from start of frame */
>                 break;
>             }
>
>             rx_cmp =3D rxbuf_ptr[offset] << 8 | rxbuf_ptr[offset];
>-            mask =3D extract32(cr0, 0, 16);
>+            mask =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0, MASK_VALUE);
>+            compare =3D FIELD_EX32(cr0, TYPE2_COMPARE_0_WORD_0,
>+ COMPARE_VALUE);
>
>-            if ((rx_cmp & mask) =3D=3D (extract32(cr0, 16, 16) & mask)) {
>+            if ((rx_cmp & mask) =3D=3D (compare & mask)) {
>                 matched =3D true;
>             } else {
>                 mismatched =3D true;
>             }
>         }
>
>         if (matched && !mismatched) {
>-            return extract32(reg, GEM_ST2R_QUEUE_SHIFT,
>GEM_ST2R_QUEUE_WIDTH);
>+            return FIELD_EX32(reg, SCREENING_TYPE2_REG0, QUEUE_NUM);
>         }
>     }
>
>     /* We made it here, assume it's queue 0 */
>     return 0;
>--
>2.39.2


