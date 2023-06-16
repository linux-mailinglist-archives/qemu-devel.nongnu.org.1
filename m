Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 43AA2733343
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 16:15:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qAADE-0004bh-U1; Fri, 16 Jun 2023 10:14:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1qAADD-0004bZ-6q
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:14:03 -0400
Received: from mail-bn7nam10on2131.outbound.protection.outlook.com
 ([40.107.92.131] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kinsey.moore@oarcorp.com>)
 id 1qAADB-0000Po-Bs
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 10:14:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JR+1UmmJUQvneEYVbjLxDJy9x6b4WWyeepw/YSt+Y8hGeHbkn0kx+fC8VWoRaRek7uKmF6b3q2+OtT/abezVCeF0labo6lEy1rki7Ovv8E9Fvl9eaTPqvSb0sVO73OEVKl+yHgQz5X7UgX8e+R0Q4oM0CgBsrjxde25UYM68g643nWISCXRICu4+4XI/NWMmhWyJgLhF7AcAVoaYbU/DyarVOfwH//BEpz4ZrL+dwEOlvVW7giuYQ2IMWG4jjUS1s8zyX6cI4kmiB+8TZuJNQGGtujZsbj0JLASHMaslqq027ugHZw7AOjKtE30uP6xPda6qUpx5REVK2uNfx9f5bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mwpczsmCOMvzGZL7vx/wIE+GUl020LsBg9aRt2Qiip8=;
 b=YM9J0ZqTJ/11mmQwJIzpleGeXBUd71vWMdEvnDulCn7q2RXkZH/xqg8uZiNZzmBeDYkkj43/DZN6W8CmwDV6t6Lz6iVpLkblmAjTHtNtArfBNQ+7lBNOLbIaQ3GN1vnGtypB/bNho/shPNA2SyPGnmT2qhR/1hYTYzFn1XJz2lRvp70pUcX/pfYYYicB/EtYlJhhjFseZemuaUChVtvVBiWoEo8sUpNzmG2ZbIpgyL4pmpAuNhdbXy6zuLaZIoD9jlE9s9KEhCGnSR45NIo0UYthzXRQ+SbbMAXs+OSJuev1OKdqvHsO8wsRFXqfxDEgddOmGHBP86bMqBNTias81Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oarcorp.com; dmarc=pass action=none header.from=oarcorp.com;
 dkim=pass header.d=oarcorp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oarcorp.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mwpczsmCOMvzGZL7vx/wIE+GUl020LsBg9aRt2Qiip8=;
 b=NFGfA2YKRrCzmnMLz49k3oYdUZGc+oeoUmbEJsYXvx7dcHfhzX01CQDu6GleZLN4PqIiU+Szg6dmF7z46XAdcLMd4ll3WsWwCtWnxGQED8oYNtrGjyy11uiDZ8UpcscULlSwStRiSPaHUPiDg3QXirqdIApp1/sClltw/seHqD8=
Received: from BN6PR19MB3314.namprd19.prod.outlook.com (2603:10b6:405:76::12)
 by CY5PR19MB6339.namprd19.prod.outlook.com (2603:10b6:930:21::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.11; Fri, 16 Jun
 2023 14:08:51 +0000
Received: from BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e]) by BN6PR19MB3314.namprd19.prod.outlook.com
 ([fe80::f6b3:3419:418b:709e%4]) with mapi id 15.20.6521.013; Fri, 16 Jun 2023
 14:08:51 +0000
From: Kinsey Moore <kinsey.moore@oarcorp.com>
To: Francisco Iglesias <frasse.iglesias@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] hw/arm/xlnx: Connect secondary CGEM IRQs
Thread-Topic: [PATCH] hw/arm/xlnx: Connect secondary CGEM IRQs
Thread-Index: AQHZn5AkgRYqgfy+dkKp1006qUJrl6+NGawAgABfQAA=
Date: Fri, 16 Jun 2023 14:08:51 +0000
Message-ID: <BN6PR19MB3314A4121113E865281BB9F69058A@BN6PR19MB3314.namprd19.prod.outlook.com>
References: <20230615134847.4157666-1-kinsey.moore@oarcorp.com>
 <20230615134847.4157666-2-kinsey.moore@oarcorp.com>
 <20230616082734.GH6984@fralle-msi>
In-Reply-To: <20230616082734.GH6984@fralle-msi>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oarcorp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN6PR19MB3314:EE_|CY5PR19MB6339:EE_
x-ms-office365-filtering-correlation-id: c2708e5c-e149-4644-846b-08db6e733644
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyul4FCWF6zZuEIwrX4W7Ojf663Un6ZhvVR/P9J0rn2QXWhmuO7Uv6ex5HSgeMTGZj78/GzjhxsEzPNdlQxiTjSZKFv53yJI4tF6zqZz6z+9SK+Oxdw+4mxfMwQ8LHe36gJRkbNmvXYoNl9hijq80at5O7Ak7dOG2+Xg/0SZWMh61ZZM6Zs5yrXLj4Zi5i4TNP1uztDqU+nTtjzgP0eFuEDlox6std8p247TJ3xTgvHrjjYLPEPM1LERWUT5nxx8W2uIcFoL1Fxvb+JdcCi0tGaqweimR0sdXpC9Hhp6absqV15WT+kI1llbTPqFsTPeLPmktXWLQU5uyUQtP8Xaejg97csQ+Ddd05HKdzowo2zAtADGz+lB+Ov9H0RP3LRzayFYr8ZzQhdYENqxv+b9gKv0gGE8IAJkcX5Eo8GM72ahf52xCz4UePmMEfTUAJKbaF3P8z+AGzVXxsiBjT65F6l0XFjCW0gh9eV7Pag0Q6Ac3PlGpHhMQFnEhrjXnYdtLS7qdut5IL2q5AGMwngvgAtHV7UekaFpu9bIvZyKsa0K4qpYp4p8662Fhm3yZvdRd4Quz6Z5Y/yqbGw8mMyCQL1nzFr+fJYfiVJkXOfn+1DpUlGrI+EgnoFWrmJf4558
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN6PR19MB3314.namprd19.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(42606007)(366004)(39830400003)(346002)(136003)(376002)(451199021)(41300700001)(8676002)(86362001)(7696005)(64756008)(66946007)(66476007)(66556008)(66446008)(6916009)(8936002)(316002)(33656002)(71200400001)(4326008)(76116006)(38070700005)(478600001)(44832011)(9686003)(55016003)(5660300002)(52536014)(83380400001)(6506007)(53546011)(2906002)(186003)(38100700002)(122000001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?umDqec2TwN7SEPsTVAoAguEf6OY1f0juCXPsiRR5w+d91jq7aGiOeSxJ1vPN?=
 =?us-ascii?Q?Uh9sDyh4elQp+XLttyTJtvNnRYNZh1xmbMAL7eU+gTKsrOJ6qYwpWYFAJhmz?=
 =?us-ascii?Q?iT/MCOmOms4FLau4Z3V1veYIe39RHF0lH8yY9xEq/OgFJZrhxyGEKX/TJafC?=
 =?us-ascii?Q?a8u0zhr+1os2MxEfnmAQk2I/Hdd9e8gZaB9DRbhCGboxPQVDi6K0Pb6KoZKX?=
 =?us-ascii?Q?Q7OTY5V7XBr3wBf142eV0Kyz6GjGbbziYM5HrUINDmtQ/zfkXJHmOX4+HKih?=
 =?us-ascii?Q?ITpZsWOef7olGfEjG9sI8nUIrP4djDHE+cOLxzUXnipPcWtpj9jN2/uIk1YZ?=
 =?us-ascii?Q?ykAtjls3s6zXu3FjY53a4ROur7uBkJbe8sswqizsshGdkDUsByEDf39LXy8T?=
 =?us-ascii?Q?qVLVTYLkpAmehd+w/vmvTVgjEVzlUCTO/ckY+9tjqRn9+71YkneHMokvCOPf?=
 =?us-ascii?Q?eWagCCkFT4F4QDJvXXcqwMtUOYDCkxrKkFX1xB0nxhgyvPTM6TLhk1mXPamV?=
 =?us-ascii?Q?5NabmoY1RQIPczmrIakol9/OtvOZ2J5axVksy145bgSfoi5+l2L0R+3OwOR3?=
 =?us-ascii?Q?57Q3vhSkX8ZDVMWBSZ9x/LXYsTBzt2XE4lb9ZfQ5m23j67rvpcLhzm9VXap8?=
 =?us-ascii?Q?MBBIgSUlXwr6oWOyhn5nXAQL8Y7HWbLr/zRLUhBdBi+FIuC/1jbwqWNlWjaV?=
 =?us-ascii?Q?1reS1W+0igjFt2WE1MhtWdKpPgAzNCWFQoqYCB9kOK1xQb8VQQkDZ4CQVk47?=
 =?us-ascii?Q?pSA664CCJqzu33FXxhHWMULzGtY4Ux095t7XGyo5VaCNc1CERzSEreI1Odqw?=
 =?us-ascii?Q?efeoYQrpRoGPbL3okNLKTSf4Rd2CzX8BYRqgUeipFltWy0lDJlwW+rTNSYa8?=
 =?us-ascii?Q?PBExlS7amIIqxGzAR5kV4KRRKxClj0U43tzGCXp/XSHp8ve/9/a6Vu8F/QRQ?=
 =?us-ascii?Q?FO1p/n9LS5p1z8Oqc6LyLlRbavCEKbwPZvTrb8Rx/ngYdjabHI/YZ9iCR7L1?=
 =?us-ascii?Q?yT7eJ4ol0hnCEox1S2fanwksREZyfraQ6Ax02cwgR/xYn4mpuNQvQsmOmrcl?=
 =?us-ascii?Q?eUlDbfxFxwm2H7ZQbcUouu4dLo0nrIgkCmPzjlw0tlt3LTyOJTm9pDAXUM2m?=
 =?us-ascii?Q?Jp/Qm67KrvnzSlTmHRBTYRen2KMSWePVXI0fqNMBa1tS/Wp4WMYsuRhfiVuI?=
 =?us-ascii?Q?S1YYEshgBh3aXozpf0xK9B0vvLCDx5ptcWgiZ/cIvEgrEZRRj1So+DNc68gW?=
 =?us-ascii?Q?uhs5aPZM4PNYX0zBe2rnVLVEVKb/BID1l3QrFXK0KucT6E3Bey4arKpopG1C?=
 =?us-ascii?Q?3nMwadvvp1lBmKanrSC/urm8kSpbU/Og/x6T0Lj8KQNxVh5S90WEGhJLBvMq?=
 =?us-ascii?Q?BcV0g9np/kTHAO49KL/ANfDTCNN1WGzOveLqqFaeh40qMZ9AfvPJMv6s/m8r?=
 =?us-ascii?Q?jz48H0mbr073H1pCkYTEtCj1xSi2oJcdKG/OxWYa+JX7f8oUGy0ZRKwfTJaC?=
 =?us-ascii?Q?uJmXD6BRl/RFixDmK4QqsfLn1hyWxsrffyXiKS1CDWyZw6kZol6Yqeup8XHy?=
 =?us-ascii?Q?f6G8k3Evdgk+nBI/gp2XGNCPctJWAe7WlYRsKfhgftjX0WY0mOTUJaiIKYik?=
 =?us-ascii?Q?STNZL7bNLcCn6DxbN0L0tnk=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oarcorp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN6PR19MB3314.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2708e5c-e149-4644-846b-08db6e733644
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 14:08:51.3385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 7bdf32a6-03de-4c70-a71b-8665ba1294e3
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NX6lj30OfEczh+sC26o7FYUGp+z7vP7UQxZ9WGGcWJVXGXcBerGXAMo7chXArfXcQ6Vip3OSq6dLQfkMi9RfXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR19MB6339
Received-SPF: pass client-ip=40.107.92.131;
 envelope-from=kinsey.moore@oarcorp.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
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

Thanks for the review. I'll get this updated and sent back out as soon as I=
've tested it.

Kinsey

-----Original Message-----
From: Francisco Iglesias <frasse.iglesias@gmail.com>=20
Sent: Friday, June 16, 2023 3:28 AM
To: Kinsey Moore <kinsey.moore@oarcorp.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm/xlnx: Connect secondary CGEM IRQs

Hi Kinsey,

On [2023 Jun 15] Thu 08:48:47, Kinsey Moore wrote:
> The Cadence GEM peripherals as configured for Zynq MPSoC and Versal
> platforms have two priority queues with separate interrupt sources for
> each. If the interrupt source for the second priority queue is not
> connected, they work in polling mode only. This change connects the
> second interrupt source for platforms where it is available. This patch
> has been tested using the lwIP stack with a Xilinx-supplied driver from
> their embeddedsw repository.
>=20
> Signed-off-by: Kinsey Moore <kinsey.moore@oarcorp.com>
> ---
>  hw/arm/xlnx-versal.c | 1 +
>  hw/arm/xlnx-zynqmp.c | 2 ++
>  2 files changed, 3 insertions(+)
>=20
> diff --git a/hw/arm/xlnx-versal.c b/hw/arm/xlnx-versal.c
> index 60bf5fe657..a9e06b7fd1 100644
> --- a/hw/arm/xlnx-versal.c
> +++ b/hw/arm/xlnx-versal.c
> @@ -272,6 +272,7 @@ static void versal_create_gems(Versal *s, qemu_irq *p=
ic)
>          memory_region_add_subregion(&s->mr_ps, addrs[i], mr);
> =20
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic[irqs[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(dev), 1, pic[irqs[i]]);

This is correct (thanks!) but the lines need to be connected through a
qemu_or_irq (in both places), you can look into this commit: c74ccb5dd6 for=
 an
example (and reason).

Best regards,
Francisco

>          g_free(name);
>      }
>  }
> diff --git a/hw/arm/xlnx-zynqmp.c b/hw/arm/xlnx-zynqmp.c
> index 5905a33015..b919b38e91 100644
> --- a/hw/arm/xlnx-zynqmp.c
> +++ b/hw/arm/xlnx-zynqmp.c
> @@ -635,6 +635,8 @@ static void xlnx_zynqmp_realize(DeviceState *dev, Err=
or **errp)
>          sysbus_mmio_map(SYS_BUS_DEVICE(&s->gem[i]), 0, gem_addr[i]);
>          sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 0,
>                             gic_spi[gem_intr[i]]);
> +        sysbus_connect_irq(SYS_BUS_DEVICE(&s->gem[i]), 1,
> +                           gic_spi[gem_intr[i]]);
>      }
> =20
>      for (i =3D 0; i < XLNX_ZYNQMP_NUM_UARTS; i++) {
> --=20
> 2.30.2
>=20
>=20

