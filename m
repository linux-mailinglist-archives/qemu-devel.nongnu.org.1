Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 561D27CD8F1
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 12:16:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt3af-0001br-FP; Wed, 18 Oct 2023 06:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3aV-0001ZA-AJ
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:15:40 -0400
Received: from mail-bn8nam12on20623.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::623]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sai.pavan.boddu@amd.com>)
 id 1qt3aT-0000Ql-9N
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 06:15:39 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=loESp3P0nwjUiqJWCpnx90848Cicfs/yK0yEm0RyfkAwHM6auL9IDsk1Blq4haeUMrOL8XSxz8i1Xnh+FLC2vNePnfXeHNYF5/YI/v/+kN3Cy7kkbbX8xGKdm1RNXm6LqrmNiFQhkCE0iMrBY/1F72me40L08GiCdjopRUl80hPwJaOZBxYq6noW4BFPNyWtyGtU1Tkj5rX6cewtvEFXy3kA/j4hNmUuEN1HI06HurPWXrvEBLH7olwer08yMvIitxcMrRACN+Ib9dBjtx0W33aMPeMoZ/tvCdV55JDJ4XEAQycWl+RuMa+xy+UIy1DV2GrM5RubfXZngGCjQdXt2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cpI03bOIfBc/vtY3DgTOzEts7Howtc+e+NqhIlrJOZw=;
 b=aCpDglfeZucL5DVVgGWeFZirBZOhiXhNmGLx7Y/zcQHlXqgIDOfsqoOsKX/MWd+eLxEFOwEc7YTFnzFM8lDRXeohyZuNbFQ+SqvnkiUEbBEcF50CJ0pI917Rt4YPGC0jVbmRaWBfXGfbaaWfztS7n6V8A2QZNxN+bd/nu2N+D8nemu0h4A0pmS0wVZWeVZIZUixZx/WE5iycPMJG6+smJkHKrxjSHKIgzAtn7/0YuoECXZVkIABfBk9+7y6q0YJewn7mBd9eMVgF23YTsLj8EVyTC89ytVht0zSDrRZ5VZLcqrkcCTN0YLpdXi4wm035mnLOX963zeccuhsbVd+dCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cpI03bOIfBc/vtY3DgTOzEts7Howtc+e+NqhIlrJOZw=;
 b=0cc3feTb1SjBUA+tmqKA/0do19gmDEpbH+Mk+pSLHtDZWuvBn4IsFXyWbz6tcwJgs39Ve8oQsYmQLS7H0wO+4f4LkqOBolvc36mzgbKSmPSH+i9DksRLGkkkLvCdJOmwlZg/c6l9q7Ss2RMA882dmTvzIaL6KYrHUuAxG7HkSxU=
Received: from DS7PR12MB5741.namprd12.prod.outlook.com (2603:10b6:8:70::7) by
 PH7PR12MB6882.namprd12.prod.outlook.com (2603:10b6:510:1b8::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.35; Wed, 18 Oct
 2023 10:15:28 +0000
Received: from DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5]) by DS7PR12MB5741.namprd12.prod.outlook.com
 ([fe80::8f6b:fb45:d9a1:d4f5%3]) with mapi id 15.20.6907.021; Wed, 18 Oct 2023
 10:15:28 +0000
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
Subject: RE: [PATCH 03/11] hw/net/cadence_gem: use FIELD to describe NWCTRL
 register fields
Thread-Topic: [PATCH 03/11] hw/net/cadence_gem: use FIELD to describe NWCTRL
 register fields
Thread-Index: AQHaATJitjnMFPXYYka5/4pLh5rsc7BPVYDQ
Date: Wed, 18 Oct 2023 10:15:28 +0000
Message-ID: <DS7PR12MB5741BD830E5AC82BFDAE159AB6D5A@DS7PR12MB5741.namprd12.prod.outlook.com>
References: <20231017194422.4124691-1-luc.michel@amd.com>
 <20231017194422.4124691-4-luc.michel@amd.com>
In-Reply-To: <20231017194422.4124691-4-luc.michel@amd.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS7PR12MB5741:EE_|PH7PR12MB6882:EE_
x-ms-office365-filtering-correlation-id: 3b45aa60-d633-4741-cbb1-08dbcfc32742
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Gwpi7IRosabiLJQ9NlImBjlLXA1SPMjUCdcsip5G1+an0cayYXVrs+sS1PWNHyu5a3eJWTMNeirO3+TT7xoSyHCEcSjdEPU6KFCAfRRjXFHSmkHUFhI2/SQ4vEYeZU+DtjeaXy87oWQaVryeyhDja4TyGR97bedKYfUhNR52vBao3EzfsZI/7lzAk+awpv9bexsU2RQYxOUvcxngBdthx6l5la+LgEewmVj3jw+gNNhwEtUM/GeFPUkfWmgTGtzAuAGd1rjImnGX0e4RzxjDzbZKUWSAxYBijEpEohQU5zPyNmCIrZsv350tB67SOaGsr9dRB4a8DEdQuiBas7W2c+36hfdgU95IYBT+6Qt8GEskigcAV+o6obIm2vmB4EekFbeVB6dL/lswKNvaHMNqEuYHIUivIXr+ger83acw0vQsspeW5ov57a1QtrjtJq7hd3agy7njcHJdgMa0lz5YyTwCRsqGvibfgm01IciRvbNKx8qZCtxoGcf1mQGRQlBeQphtSLXJsWYaxdAoH69fmHIMDPWrVVp+koF8uh93P79/UMsH+mjbmyq0zv1Z8i0KUjh6eIJLVccbnwqew2pCD7Mq5FFfOlRqnsp9fh4r775sUL4V9qyC/K2SjzR7ogEm
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR12MB5741.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(136003)(366004)(376002)(39860400002)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(6506007)(7696005)(52536014)(33656002)(71200400001)(5660300002)(2906002)(122000001)(83380400001)(26005)(38100700002)(38070700005)(86362001)(9686003)(54906003)(316002)(66556008)(41300700001)(110136005)(64756008)(66946007)(66446008)(66476007)(76116006)(478600001)(8936002)(4326008)(8676002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?K5Etfm3oYPdrP6O/S6FaugaQe0/v3AP1lUWQsSrV9S46UywQVXyxXWhW/e?=
 =?iso-8859-1?Q?PSaawvQZMQ4MSAZ3R3gt3WsqicLNkIwgMuYcc/UZ66cRZhVU153AkMkLTt?=
 =?iso-8859-1?Q?BavRWko5rZXxUvL1l824zLhIpJDuwaykWzfW3LLZiktCu1dKaPps99SuNF?=
 =?iso-8859-1?Q?+uJehYsbcJyYSQDC0xU5eGjIf7vsKhZZit7+SLabr1Zf5h9L8+FidIAfN7?=
 =?iso-8859-1?Q?ZioR34fFfevMBXNWE6qpryivmFeBZBtxZDrJHsTUGndESDvdjR3ZZhSWy/?=
 =?iso-8859-1?Q?6z0jqO1nYV7loIQr1L+FuDVw7BB5ONVXBuZV4SefjwaZb7ubesT4HstPP4?=
 =?iso-8859-1?Q?E1zYTL1I+rtUyb0TvrFkviIJzJZgt1VrNZiBpxKG7UH3I/OpnqniJwlsX0?=
 =?iso-8859-1?Q?sRHo9B6ARY6FWApsf456pA+yQXJmdbyoU7sLfBHxkv297ZG3J0rBCsC6uV?=
 =?iso-8859-1?Q?aaA9dDdpaJ/7BYfjfqZPsKalEGcIm2TQOTxxiXol9oAvGPg15zl5dC/WKM?=
 =?iso-8859-1?Q?pihmYuMOU48sIU5C2cgbIN1PTG7isDvlkb0y9MoDUZo0UsVlqsimG1WqFf?=
 =?iso-8859-1?Q?tBRPFS1j5jHPvS1ARRbsW2zkieThE7DbUI1XRNsTlSPqKds5fgYWwuzsTV?=
 =?iso-8859-1?Q?WI+RuJQJbQ/COfLL1+8p8XWlpaWBfKu8sqZZW4DYZIqHJoFUqQrE9jGpcj?=
 =?iso-8859-1?Q?wIEkk5a8Fk4OuBTR7H5SQEzG7zekvJJzwzyOu54VSaL3H4tQbrC2MIKR/l?=
 =?iso-8859-1?Q?JHlTkK5Kqxt3IkqsCo0+NX9tUefU6OJ8YoOB1zTt7fmNuJ/GRWmj83oo4w?=
 =?iso-8859-1?Q?guE3Ehc8sCyOGqF/TtQe9WRwSJ5Vsedvbi9X3HBpk5T9efLhbTc/C27Fc1?=
 =?iso-8859-1?Q?H0pn4jnI0CwV7j6uAgmPfjKuMb/6dsbx/WTN4zUge+veQEDDi360883bKW?=
 =?iso-8859-1?Q?ydlS9Gub2yZFZmf9yj0N6XW3zpL4pNi84fw/fPLI6dqrpNwBcFDMr7I0ug?=
 =?iso-8859-1?Q?sUYMgsH/ZBPNja2YhdkXUBiAjkUqE/QkSMGvXSDqhbsFvZaErEM1Ckk+Zl?=
 =?iso-8859-1?Q?Qtj8jikeQpwUvDWgphhKzv4ooibMOumXU08FG/IG9d93FZ8GblsfVke+mq?=
 =?iso-8859-1?Q?btvWjy3nu9eUBYRcUmcvt5rqfGts5+x1gn00VCSwsGH0nvfppRuTEVQ5HX?=
 =?iso-8859-1?Q?QB0xMVIuYTXER+9ZZWsyVqxtaGuNSA6icp6S7HBRfg3h5v78M9E1yX1Ja5?=
 =?iso-8859-1?Q?ly2L4Z5keyqKTBURHAieFjbsR4gxMRlc7ylsWSpKCOgoTlwR1LNqAVh+cj?=
 =?iso-8859-1?Q?oOVCADp/+U+Tvr+q+x1bVru/VCsezOlL7BHuiFOH3pXShBbRISYKo5QEw3?=
 =?iso-8859-1?Q?0UyKVMgKrzycm61ljxgQKOf7Is1M3svMEVSUOJSJGT3iAXCqG3wtlZEy/a?=
 =?iso-8859-1?Q?3fG4P+F+IWnPhc7GLAM2HyJzI+nzS8gS6RHTPahG87zaNJOvZXora6yNM/?=
 =?iso-8859-1?Q?uAZrKWKlC0+5bhowffwl+VObywSqfs3fWCBgNZ53xHAwO/4/QYcA50MdmR?=
 =?iso-8859-1?Q?qwDAZPrXpHnJUVZwIrvv9SEWhFYA4MANeLTOzJwKp/zRnjZJVqZk63qt1f?=
 =?iso-8859-1?Q?UmAabq9LJVdYA=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5741.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b45aa60-d633-4741-cbb1-08dbcfc32742
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Oct 2023 10:15:28.6971 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: y9lcCOSvnXSAcsO1VIvyQk5sV1xPS7JTNlbRQPCFvBwXdqVTQX0IH2Qf4FnlV2hw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6882
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::623;
 envelope-from=sai.pavan.boddu@amd.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
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
>Subject: [PATCH 03/11] hw/net/cadence_gem: use FIELD to describe NWCTRL
>register fields
>
>Use the FIELD macro to describe the NWCTRL register fields.
>
>Signed-off-by: Luc Michel <luc.michel@amd.com>

Reviewed-by: sai.pavan.boddu@amd.com

Regards,
Sai Pavan

>---
> hw/net/cadence_gem.c | 53 +++++++++++++++++++++++++++++++++-------
>----
> 1 file changed, 40 insertions(+), 13 deletions(-)
>
>diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c index
>f01c81de97..2864f0940e 100644
>--- a/hw/net/cadence_gem.c
>+++ b/hw/net/cadence_gem.c
>@@ -44,10 +44,42 @@
>         qemu_log(__VA_ARGS__); \
>     } \
> } while (0)
>
> REG32(NWCTRL, 0x0) /* Network Control reg */
>+    FIELD(NWCTRL, LOOPBACK , 0, 1)
>+    FIELD(NWCTRL, LOOPBACK_LOCAL , 1, 1)
>+    FIELD(NWCTRL, ENABLE_RECEIVE, 2, 1)
>+    FIELD(NWCTRL, ENABLE_TRANSMIT, 3, 1)
>+    FIELD(NWCTRL, MAN_PORT_EN , 4, 1)
>+    FIELD(NWCTRL, CLEAR_ALL_STATS_REGS , 5, 1)
>+    FIELD(NWCTRL, INC_ALL_STATS_REGS, 6, 1)
>+    FIELD(NWCTRL, STATS_WRITE_EN, 7, 1)
>+    FIELD(NWCTRL, BACK_PRESSURE, 8, 1)
>+    FIELD(NWCTRL, TRANSMIT_START , 9, 1)
>+    FIELD(NWCTRL, TRANSMIT_HALT, 10, 1)
>+    FIELD(NWCTRL, TX_PAUSE_FRAME_RE, 11, 1)
>+    FIELD(NWCTRL, TX_PAUSE_FRAME_ZE, 12, 1)
>+    FIELD(NWCTRL, STATS_TAKE_SNAP, 13, 1)
>+    FIELD(NWCTRL, STATS_READ_SNAP, 14, 1)
>+    FIELD(NWCTRL, STORE_RX_TS, 15, 1)
>+    FIELD(NWCTRL, PFC_ENABLE, 16, 1)
>+    FIELD(NWCTRL, PFC_PRIO_BASED, 17, 1)
>+    FIELD(NWCTRL, FLUSH_RX_PKT_PCLK , 18, 1)
>+    FIELD(NWCTRL, TX_LPI_EN, 19, 1)
>+    FIELD(NWCTRL, PTP_UNICAST_ENA, 20, 1)
>+    FIELD(NWCTRL, ALT_SGMII_MODE, 21, 1)
>+    FIELD(NWCTRL, STORE_UDP_OFFSET, 22, 1)
>+    FIELD(NWCTRL, EXT_TSU_PORT_EN, 23, 1)
>+    FIELD(NWCTRL, ONE_STEP_SYNC_MO, 24, 1)
>+    FIELD(NWCTRL, PFC_CTRL , 25, 1)
>+    FIELD(NWCTRL, EXT_RXQ_SEL_EN , 26, 1)
>+    FIELD(NWCTRL, OSS_CORRECTION_FIELD, 27, 1)
>+    FIELD(NWCTRL, SEL_MII_ON_RGMII, 28, 1)
>+    FIELD(NWCTRL, TWO_PT_FIVE_GIG, 29, 1)
>+    FIELD(NWCTRL, IFG_EATS_QAV_CREDIT, 30, 1)
>+
> REG32(NWCFG, 0x4) /* Network Config reg */  REG32(NWSTATUS, 0x8) /*
>Network Status reg */  REG32(USERIO, 0xc) /* User IO reg */  REG32(DMACFG,
>0x10) /* DMA Control reg */  REG32(TXSTATUS, 0x14) /* TX Status reg */ @@ =
-
>202,15 +234,10 @@ REG32(TYPE2_COMPARE_0_WORD_1, 0x704)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_OFFSET, 7, 2)
>     FIELD(TYPE2_COMPARE_0_WORD_1, DISABLE_MASK, 9, 1)
>     FIELD(TYPE2_COMPARE_0_WORD_1, COMPARE_VLAN_ID, 10, 1)
>
> /*****************************************/
>-#define GEM_NWCTRL_TXSTART     0x00000200 /* Transmit Enable */
>-#define GEM_NWCTRL_TXENA       0x00000008 /* Transmit Enable */
>-#define GEM_NWCTRL_RXENA       0x00000004 /* Receive Enable */
>-#define GEM_NWCTRL_LOCALLOOP   0x00000002 /* Local Loopback */
>-
> #define GEM_NWCFG_STRIP_FCS    0x00020000 /* Strip FCS field */
> #define GEM_NWCFG_LERR_DISC    0x00010000 /* Discard RX frames with len
>err */
> #define GEM_NWCFG_BUFF_OFST_M  0x0000C000 /* Receive buffer offset
>mask */
> #define GEM_NWCFG_BUFF_OFST_S  14         /* Receive buffer offset shift =
*/
> #define GEM_NWCFG_RCV_1538     0x00000100 /* Receive 1538 bytes frame
>*/
>@@ -558,11 +585,11 @@ static bool gem_can_receive(NetClientState *nc)
>     int i;
>
>     s =3D qemu_get_nic_opaque(nc);
>
>     /* Do nothing if receive is not enabled. */
>-    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_RXENA)) {
>+    if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_RECEIVE)) {
>         if (s->can_rx_state !=3D 1) {
>             s->can_rx_state =3D 1;
>             DB_PRINT("can't receive - no enable\n");
>         }
>         return false;
>@@ -1171,11 +1198,11 @@ static void gem_transmit(CadenceGEMState *s)
>     uint8_t     *p;
>     unsigned    total_bytes;
>     int q =3D 0;
>
>     /* Do nothing if transmit is not enabled. */
>-    if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
>+    if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL, ENABLE_TRANSMIT)) {
>         return;
>     }
>
>     DB_PRINT("\n");
>
>@@ -1196,11 +1223,11 @@ static void gem_transmit(CadenceGEMState *s)
>                            sizeof(uint32_t) * gem_get_desc_len(s, false))=
;
>         /* Handle all descriptors owned by hardware */
>         while (tx_desc_get_used(desc) =3D=3D 0) {
>
>             /* Do nothing if transmit is not enabled. */
>-            if (!(s->regs[R_NWCTRL] & GEM_NWCTRL_TXENA)) {
>+            if (!FIELD_EX32(s->regs[R_NWCTRL], NWCTRL,
>+ ENABLE_TRANSMIT)) {
>                 return;
>             }
>             print_gem_tx_desc(desc, q);
>
>             /* The real hardware would eat this (and possibly crash).
>@@ -1269,12 +1296,12 @@ static void gem_transmit(CadenceGEMState *s)
>
>                 /* Update MAC statistics */
>                 gem_transmit_updatestats(s, s->tx_packet, total_bytes);
>
>                 /* Send the packet somewhere */
>-                if (s->phy_loop || (s->regs[R_NWCTRL] &
>-                                    GEM_NWCTRL_LOCALLOOP)) {
>+                if (s->phy_loop || FIELD_EX32(s->regs[R_NWCTRL], NWCTRL,
>+                                              LOOPBACK_LOCAL)) {
>                     qemu_receive_packet(qemu_get_queue(s->nic), s->tx_pac=
ket,
>                                         total_bytes);
>                 } else {
>                     qemu_send_packet(qemu_get_queue(s->nic), s->tx_packet=
,
>                                      total_bytes); @@ -1491,19 +1518,19 @=
@ static void
>gem_write(void *opaque, hwaddr offset, uint64_t val,
>     s->regs[offset] &=3D ~(s->regs_w1c[offset] & val);
>
>     /* Handle register write side effects */
>     switch (offset) {
>     case R_NWCTRL:
>-        if (val & GEM_NWCTRL_RXENA) {
>+        if (FIELD_EX32(val, NWCTRL, ENABLE_RECEIVE)) {
>             for (i =3D 0; i < s->num_priority_queues; ++i) {
>                 gem_get_rx_desc(s, i);
>             }
>         }
>-        if (val & GEM_NWCTRL_TXSTART) {
>+        if (FIELD_EX32(val, NWCTRL, TRANSMIT_START)) {
>             gem_transmit(s);
>         }
>-        if (!(val & GEM_NWCTRL_TXENA)) {
>+        if (!(FIELD_EX32(val, NWCTRL, ENABLE_TRANSMIT))) {
>             /* Reset to start of Q when transmit disabled. */
>             for (i =3D 0; i < s->num_priority_queues; i++) {
>                 s->tx_desc_addr[i] =3D gem_get_tx_queue_base_addr(s, i);
>             }
>         }
>--
>2.39.2


