Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 188BF7DB334
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 07:27:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxLii-0008GB-C0; Mon, 30 Oct 2023 02:25:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxLie-0008FU-IA; Mon, 30 Oct 2023 02:25:48 -0400
Received: from mail-dm6nam12on20631.outbound.protection.outlook.com
 ([2a01:111:f400:fe59::631]
 helo=NAM12-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qxLiS-0007q5-E4; Mon, 30 Oct 2023 02:25:48 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e++pW7hB+JPU82b9Db6duPh4157adXtGG6Yx0KH01dPgUj5M17G9YODvK+M6r6ZAQ7gvFIk5HvGpnNmUkBFF98Ppr84Erk0OOv2OMUUZfB+oiNIdB9JQGaXG/G7RDRRiMb1pasqwUuw8Uf0kcOUYBkOyBKlCGcJEBqgILQPDRmuImprBuuWAaRKTBXkNqyYrH3KuyPK42b1YW5dUGwKHNw8/nobXN6cMR5SMh/kS/DmrXVCDLJ9UoUCjQQLHKmWoRBSmBklHIc4XeXZm454xaEVFD485Vib4Hy5GwGP8+pnkT06ctmA+XhX4FoOVq7FnWjYlP9AX0j2kp2qKOdUIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QKpRZNtXGZDTC1h4is3Eck6FyF7VvA3eQAf+wMEkrDk=;
 b=V8J3z0NyHq086s0ivVBHw6So9NC++9ryqCftAmPiEawJQFW2u2G0TlxkwxLtM+6BOxb4HUyKQ1OMzO4TGP5pdWy5UForkIthpJFTlptDuT1RxLP79yXj9k+58G4pslrunQl0xMNcFXY5dl8bf7ic8iTGe185kglN4A5O4V79gj7B2RQB/ziA7ZBUMXtqlYE4H9GLA8qXg5qLQIvCBO5OMnqrrsJ9q7XSJrbjHTnRiQDx9s9xrrHMXMFXPpeXjg+EG0Py6UrTmNXRyJjUEMcxoyhs5IdNXmiNYDzdZcB1pi77Aqs116CbNmDFepY8+hdkzbQ3DOHXfVrzx5oMyXrxVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QKpRZNtXGZDTC1h4is3Eck6FyF7VvA3eQAf+wMEkrDk=;
 b=0o/fHgxK4CTW9bObBEwJNPCrTU2tHRR8bP1v88CT7DBerZjL4RKsfwrKWukrImDr9VEwEN/OVyRO2PRfn5+dZ+45qrm5pAAU238GR8hd///b9gdj6Llww3WhcQunMkgBaVUHPCS8EhbMK6tzcT8wua+9zYA9JYHeHqccd2kaJTE=
Received: from BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 by IA1PR12MB8359.namprd12.prod.outlook.com (2603:10b6:208:3fc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 06:25:30 +0000
Received: from BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::6a67:b8a8:161b:e684]) by BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::6a67:b8a8:161b:e684%2]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 06:25:29 +0000
From: "Ho, Tong" <tong.ho@amd.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alistair@alistair23.me" <alistair@alistair23.me>,
 "edgar.iglesias@gmail.com" <edgar.iglesias@gmail.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "frasse.iglesias@gmail.com" <frasse.iglesias@gmail.com>
Subject: Re: [PATCH v4 3/3] tests/qtest: Introduce tests for AMD/Xilinx Versal
 TRNG device
Thread-Topic: [PATCH v4 3/3] tests/qtest: Introduce tests for AMD/Xilinx
 Versal TRNG device
Thread-Index: AQHaATCrrzNJcYMzpEigiTL96G3ywrBdqX0AgARBDS8=
Date: Mon, 30 Oct 2023 06:25:29 +0000
Message-ID: <BL0PR12MB48827D764A414B476C261C45E6A1A@BL0PR12MB4882.namprd12.prod.outlook.com>
References: <20231017193217.1512868-1-tong.ho@amd.com>
 <20231017193217.1512868-4-tong.ho@amd.com>
 <CAFEAcA_yCEtDkW6R43LGNjWGH323HuSWPFibgaRSZ=+DqfrZ_g@mail.gmail.com>
In-Reply-To: <CAFEAcA_yCEtDkW6R43LGNjWGH323HuSWPFibgaRSZ=+DqfrZ_g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4882:EE_|IA1PR12MB8359:EE_
x-ms-office365-filtering-correlation-id: 5d4f5820-51a7-46a0-fc73-08dbd9110376
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bEFvSLy2D1v2PALnNOAPw5oaq8hSuVScYZ0aS+kB4yOSLU5l2ggBtDyyBIsadHxO2fOjahgHOJ4WfWhLm0HR63ErOo811w/UoExr9TXXrmX1lktI+2zigmB0gbGvRY/Bji7pV3JqNtSWEHSFkOhlCz74u+evZYLWdHk3H2OwL273c5BGB9/SCoBuVpo8NRuFbi6gqghvA2p9twIAVXPmhCJ+lWxGRHJELu2bj1P+PPIPabJ7/jbrF9jLaHO0aCduq9H240mPK1VWQYIcREQq9onxgEce5YfBkZzoI5h4O65XukvDWW85Azz0Hn8N3gkKsRzbmgJ7hCoAcHc9zabgHxmoL7+4R1jd84gfTlgXFTLgic9CKug3xfXgTno5H9Eru3wdzvtepbV89NMdq+AnVcY5teDxFSBvTM0oUzcqJGlgDteehhr8PVhAaen96FSjrCjXNPc35BNzU2p9lhFU9XxBrcSm84M67BW4cmCqP0G67HWU6EJf0ehl2MeaWZrv6vg6503ev2R1VCdsF6DmpCHcMoGacf5t+4Q8eiN3m2VUTyyGWgt00tPUvcc2e8YC+/T1+4Xx94Z5yBz2NP7wnxo/wSukBXrdOz5SkXLLEm6XKGg8mvXCfQCyxmdi49ne
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(136003)(39860400002)(396003)(376002)(366004)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(55016003)(9686003)(26005)(53546011)(71200400001)(478600001)(6506007)(7696005)(2906002)(83380400001)(91956017)(66556008)(41300700001)(66946007)(5660300002)(76116006)(8936002)(66476007)(66446008)(4326008)(8676002)(52536014)(6916009)(54906003)(64756008)(316002)(38070700009)(38100700002)(122000001)(86362001)(33656002)(19627405001)(66899024);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?xH9s9s6rZqsEV1gw7J5k3IxVpobYsfTqPuhhUzHHBWMhWjCF9PO+GLnAUF?=
 =?iso-8859-1?Q?CHV7gI9Kxd4+O2ijm+4lC3E9x2YQF9JYUarmiIAIBQVcXx+Dr/NZo+My84?=
 =?iso-8859-1?Q?IARzFzyUmyab+E0IvoDqGHT7qT8pkjYzoRBqTf7kCWtuFuAKMOb4kKhjvY?=
 =?iso-8859-1?Q?M/v4hk1SKaVQuBe3UzJHTT4Qa++A/vmvX5oPTuM7K/q9qsd5CUGJWuQ5Jd?=
 =?iso-8859-1?Q?Za31NNLT6IMzZbn8MDa9PbyGa3QoHcZZrg0SBBIGF5FE9xm6DG1BHQNDIt?=
 =?iso-8859-1?Q?m8xZktwkUxgJzTGcGoZlWTPcUyyyVji3U/65hiZLPKHJShjkC1lA4Vtqk6?=
 =?iso-8859-1?Q?y1YHYbS72jADTSI0a9ezYV5wZ5u7LJ2vTYZDcl0SdbYR1IgTqp1Xn/ub2d?=
 =?iso-8859-1?Q?XpWXC2uXratje/Vo7J/UBsHdRrAI0Vs9aV4OHtxS/zCbMztvqotQYqbCcn?=
 =?iso-8859-1?Q?NkW/S0IuBtbinCect0ebFCmoEOcpyFBGyM75r7AqzgNOIt/tmelosR/qnR?=
 =?iso-8859-1?Q?lISsN4lV1AVJd/kzL6JRrdhG7qgbCzcgn2InWROH5yaNzDKlHLqU66lQCS?=
 =?iso-8859-1?Q?561+PmgNm8jcIrLddl7p5ovTtk7RcMx3rgNIAxUKoFX2jbEkDdamrTugAZ?=
 =?iso-8859-1?Q?o2KNTZkf4lvk+MpnzTUjYFHM1PlyNFPPBtpl9C1XEbX1uP8q4k/efhemmL?=
 =?iso-8859-1?Q?AdtlKx6rMqbt3pzFyOia7tOBHKPMJzwuZ6PZn/kb2ezkHAXV1x0zoVh6hG?=
 =?iso-8859-1?Q?OGN5Ufsrwg6hI5f5N9cmIuVGDfq1kvUDg1dMxtGymDnUFkLeNUQxbYMxVm?=
 =?iso-8859-1?Q?k0fEk1PS31VdGFJk01XZe65DeNFBT2WhJhPmEjFSlvMjvGvsOyztZRVa5Q?=
 =?iso-8859-1?Q?lk/48ip3IBUy5OWonFbQLxWmNjECfACDEZj4UQHzk2LbvbhseSdcLX8hTd?=
 =?iso-8859-1?Q?yjd5qNZ860qwLzGGahP8Hie764NjpL9hEjKFf2MEmiqffRmNY7q2ndAApm?=
 =?iso-8859-1?Q?ZlzY2hjO02U+VEK8lYoE3qWZQxnB2WffL3aVqkecHjxJ07gijfUrTfOwJ4?=
 =?iso-8859-1?Q?w7g5qaiiN7je0xxYhfWpuaAXKuEmyf//ExCRInAO6F5VtPKABfwA7Ua3mj?=
 =?iso-8859-1?Q?pR4w52KFM21H9u7c4QQ4Wz9P7XhB28oWYruBc3o/PoolH+yiIx120oBGSr?=
 =?iso-8859-1?Q?Du/0sC1eR0dGO5sGVd8ZOavbD8P/ceZkk3AZ1oXKMRIeF4EH4mnPDabnbq?=
 =?iso-8859-1?Q?gjhVBlcfvvPMUtwhibxlsdljuGX49QYFpVCqeZZiem9fxLZY1E5gvuBGf0?=
 =?iso-8859-1?Q?lgn9atBnoGu0/jQERpKM4ojxatNSbaf/Dx9gTCFrCJ9j8JyjSJxgLmOgyC?=
 =?iso-8859-1?Q?NQj8gts1K04+4oXMD3bV0rbXpXhbowwy2Cxc3tsh8WL/Ntks/8uGNpdvW2?=
 =?iso-8859-1?Q?dgKhcgua2/Dif6UD8onSdlCbyqujgpZwevYoddFFe8D5GQ+Z3kJryMvhZG?=
 =?iso-8859-1?Q?2NyQUJk0fPAL2Kb5H0jdDmiljKLE8Bi5Gczq4Ep1x/kj+NlnvjdwOSF+px?=
 =?iso-8859-1?Q?3wcP//xU12e/QlQ1sxTGYk6mXAy+m/sZ0YyptTEJ+9FNCDht7nllS0peFV?=
 =?iso-8859-1?Q?DAUYbGMHJ9y1s=3D?=
Content-Type: multipart/alternative;
 boundary="_000_BL0PR12MB48827D764A414B476C261C45E6A1ABL0PR12MB4882namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4882.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d4f5820-51a7-46a0-fc73-08dbd9110376
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Oct 2023 06:25:29.8466 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rmsLIYtNFoZIyacieuUrANEvItd9RuIvQnta+y4KapZdqTxNT5Z+ZsWl+IMAw3Qz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8359
Received-SPF: softfail client-ip=2a01:111:f400:fe59::631;
 envelope-from=tong.ho@amd.com;
 helo=NAM12-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HTML_MESSAGE=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--_000_BL0PR12MB48827D764A414B476C261C45E6A1ABL0PR12MB4882namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi Peter,

This is in regard to your comment on the use of g_usleep() in waiting for
an event-bit update from the device under test.

The TRNG device model presented in patch #1 does not have any asynchronous =
behavior.

So, do you mean that, although the qtest process and the qemu-system-* proc=
ess
are running as 2 separate processes, qtest infrastructure already has the n=
ecessary
mechanism to ensure that:

1. After qtest test sets a register that has the correct deterministic beha=
vior to update an event bit,

2. The same qtest test subsequently issuing a register read will be guarant=
eed to observe the updated bit?

If that is the case, then there would be no need for any timeout. Instead,
a qtest test can declare fail when the expected bit update is not observed =
by the test.

I would like to know.

Thanks,
Tong Ho

________________________________
From: Peter Maydell <peter.maydell@linaro.org>
Sent: Friday, October 27, 2023 6:03 AM
To: Ho, Tong <tong.ho@amd.com>
Cc: qemu-arm@nongnu.org <qemu-arm@nongnu.org>; qemu-devel@nongnu.org <qemu-=
devel@nongnu.org>; alistair@alistair23.me <alistair@alistair23.me>; edgar.i=
glesias@gmail.com <edgar.iglesias@gmail.com>; richard.henderson@linaro.org =
<richard.henderson@linaro.org>; frasse.iglesias@gmail.com <frasse.iglesias@=
gmail.com>
Subject: Re: [PATCH v4 3/3] tests/qtest: Introduce tests for AMD/Xilinx Ver=
sal TRNG device

On Tue, 17 Oct 2023 at 20:32, Tong Ho <tong.ho@amd.com> wrote:
>
> Signed-off-by: Tong Ho <tong.ho@amd.com>
> ---
>  tests/qtest/meson.build             |   2 +-
>  tests/qtest/xlnx-versal-trng-test.c | 486 ++++++++++++++++++++++++++++
>  2 files changed, 487 insertions(+), 1 deletion(-)
>  create mode 100644 tests/qtest/xlnx-versal-trng-test.c


> +static void trng_wait(uint32_t wait_mask, bool on, const char *act)
> +{
> +    time_t tmo =3D time(NULL) + 2; /* at most 2 seconds */

Don't put timeouts this short into tests, please; ideally,
avoid them entirely. Sometimes the CI machines are heavily
loaded and the test might not be able to complete in a
short time like this. If you must have a timeout, it should
be at least a minute. (And see below on whether we need one.)

> +    uint32_t event_mask =3D 0;
> +    uint32_t clear_mask =3D 0;
> +
> +    /*
> +     * Only selected bits are events in R_TRNG_STATUS, and
> +     * clear them needs to go through R_INT_CTRL.
> +     */
> +    if (wait_mask & TRNG_STATUS_CERTF_MASK) {
> +        event_mask |=3D TRNG_STATUS_CERTF_MASK;
> +        clear_mask |=3D TRNG_INT_CTRL_CERTF_RST_MASK;
> +    }
> +    if (wait_mask & TRNG_STATUS_DTF_MASK) {
> +        event_mask |=3D TRNG_STATUS_DTF_MASK;
> +        clear_mask |=3D TRNG_INT_CTRL_DTF_RST_MASK;
> +    }
> +    if (wait_mask & TRNG_STATUS_DONE_MASK) {
> +        event_mask |=3D TRNG_STATUS_DONE_MASK;
> +        clear_mask |=3D TRNG_INT_CTRL_DONE_RST_MASK;
> +    }
> +
> +    for (;;) {
> +        bool sta =3D !!(trng_status() & event_mask);
> +
> +        if ((on ^ sta) =3D=3D 0) {
> +            break;
> +        }
> +
> +        if (time(NULL) >=3D tmo) {
> +            FAILED("%s: Timed out waiting for event 0x%x to be %d%s",
> +                   act, event_mask, (int)on, trng_info());
> +        }
> +
> +        g_usleep(10000);

Why does this test need to use sleeps and timeouts?
A qtest test controls the guest 'clock' directly, so
usually they're completely deterministic. Is there some
behaviour in the TRNG device which is asynchronous (in
a way not driven from the QEMU guest clock) that I've missed ?

> +    }
> +
> +    /* Remove event */
> +    trng_bit_set(R_TRNG_INT_CTRL, clear_mask);
> +
> +    if (!!(trng_read(R_TRNG_STATUS) & event_mask)) {
> +        FAILED("%s: Event 0x%0x stuck at 1 after clear: %s",
> +               act, event_mask, trng_info());
> +    }
> +}

thanks
-- PMM

--_000_BL0PR12MB48827D764A414B476C261C45E6A1ABL0PR12MB4882namp_
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Diso-8859-=
1">
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Hi Peter,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
This is in regard to your comment on the use of g_usleep() in waiting for</=
div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
an event-bit update from the device under test.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
The TRNG device model presented in patch #1 does not have any asynchronous =
behavior.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
So, do you mean that, although the qtest process and the qemu-system-* proc=
ess</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
are running as 2 separate processes, qtest infrastructure already has the n=
ecessary</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
mechanism to ensure that:</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
1. After qtest test sets a register that has the correct deterministic beha=
vior to update an event bit,</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
2. The same qtest test subsequently issuing a register read will be guarant=
eed to observe the updated bit?</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
If that is the case, then there would be no need for any timeout. Instead,<=
/div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
a qtest test can declare fail when the expected bit update is not observed =
by the test.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
I would&nbsp;like to know.</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div class=3D"elementToProof"><span style=3D"font-family: Aptos, Aptos_Embe=
ddedFont, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 1=
1pt; color: rgb(0, 0, 0);">Tong Ho</span></div>
<div id=3D"appendonsend"></div>
<div class=3D"elementToProof" style=3D"font-family: Aptos, Aptos_EmbeddedFo=
nt, Aptos_MSFontService, Calibri, Helvetica, sans-serif; font-size: 11pt; c=
olor: rgb(0, 0, 0);">
<br>
</div>
<hr style=3D"display: inline-block; width: 98%;">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><span style=3D"font-family: Calibri, =
sans-serif; font-size: 11pt; color: rgb(0, 0, 0);"><b>From:</b>&nbsp;Peter =
Maydell &lt;peter.maydell@linaro.org&gt;<br>
<b>Sent:</b>&nbsp;Friday, October 27, 2023 6:03 AM<br>
<b>To:</b>&nbsp;Ho, Tong &lt;tong.ho@amd.com&gt;<br>
<b>Cc:</b>&nbsp;qemu-arm@nongnu.org &lt;qemu-arm@nongnu.org&gt;; qemu-devel=
@nongnu.org &lt;qemu-devel@nongnu.org&gt;; alistair@alistair23.me &lt;alist=
air@alistair23.me&gt;; edgar.iglesias@gmail.com &lt;edgar.iglesias@gmail.co=
m&gt;; richard.henderson@linaro.org &lt;richard.henderson@linaro.org&gt;;
 frasse.iglesias@gmail.com &lt;frasse.iglesias@gmail.com&gt;<br>
<b>Subject:</b>&nbsp;Re: [PATCH v4 3/3] tests/qtest: Introduce tests for AM=
D/Xilinx Versal TRNG device</span>
<div>&nbsp;</div>
</div>
<div><span style=3D"font-size: 11pt;">On Tue, 17 Oct 2023 at 20:32, Tong Ho=
 &lt;tong.ho@amd.com&gt; wrote:<br>
&gt;<br>
&gt; Signed-off-by: Tong Ho &lt;tong.ho@amd.com&gt;<br>
&gt; ---<br>
&gt;&nbsp; tests/qtest/meson.build&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; |&nbsp;&nbsp; 2 +-<br>
&gt;&nbsp; tests/qtest/xlnx-versal-trng-test.c | 486 ++++++++++++++++++++++=
++++++<br>
&gt;&nbsp; 2 files changed, 487 insertions(+), 1 deletion(-)<br>
&gt;&nbsp; create mode 100644 tests/qtest/xlnx-versal-trng-test.c<br>
<br>
<br>
&gt; +static void trng_wait(uint32_t wait_mask, bool on, const char *act)<b=
r>
&gt; +{<br>
&gt; +&nbsp;&nbsp;&nbsp; time_t tmo =3D time(NULL) + 2; /* at most 2 second=
s */<br>
<br>
Don't put timeouts this short into tests, please; ideally,<br>
avoid them entirely. Sometimes the CI machines are heavily<br>
loaded and the test might not be able to complete in a<br>
short time like this. If you must have a timeout, it should<br>
be at least a minute. (And see below on whether we need one.)<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp; uint32_t event_mask =3D 0;<br>
&gt; +&nbsp;&nbsp;&nbsp; uint32_t clear_mask =3D 0;<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; /*<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * Only selected bits are events in R_TRNG_ST=
ATUS, and<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; * clear them needs to go through R_INT_CTRL.=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp; */<br>
&gt; +&nbsp;&nbsp;&nbsp; if (wait_mask &amp; TRNG_STATUS_CERTF_MASK) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_mask |=3D TRNG_STATU=
S_CERTF_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_mask |=3D TRNG_INT_C=
TRL_CERTF_RST_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; if (wait_mask &amp; TRNG_STATUS_DTF_MASK) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_mask |=3D TRNG_STATU=
S_DTF_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_mask |=3D TRNG_INT_C=
TRL_DTF_RST_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +&nbsp;&nbsp;&nbsp; if (wait_mask &amp; TRNG_STATUS_DONE_MASK) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; event_mask |=3D TRNG_STATU=
S_DONE_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; clear_mask |=3D TRNG_INT_C=
TRL_DONE_RST_MASK;<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; for (;;) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; bool sta =3D !!(trng_statu=
s() &amp; event_mask);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if ((on ^ sta) =3D=3D 0) {=
<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; br=
eak;<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if (time(NULL) &gt;=3D tmo=
) {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FA=
ILED(&quot;%s: Timed out waiting for event 0x%x to be %d%s&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; act, event_mask, (int)on, trng_info=
());<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; g_usleep(10000);<br>
<br>
Why does this test need to use sleeps and timeouts?<br>
A qtest test controls the guest 'clock' directly, so<br>
usually they're completely deterministic. Is there some<br>
behaviour in the TRNG device which is asynchronous (in<br>
a way not driven from the QEMU guest clock) that I've missed ?<br>
<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; /* Remove event */<br>
&gt; +&nbsp;&nbsp;&nbsp; trng_bit_set(R_TRNG_INT_CTRL, clear_mask);<br>
&gt; +<br>
&gt; +&nbsp;&nbsp;&nbsp; if (!!(trng_read(R_TRNG_STATUS) &amp; event_mask))=
 {<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; FAILED(&quot;%s: Event 0x%=
0x stuck at 1 after clear: %s&quot;,<br>
&gt; +&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp; act, event_mask, trng_info());<br>
&gt; +&nbsp;&nbsp;&nbsp; }<br>
&gt; +}<br>
<br>
thanks<br>
-- PMM</span></div>
</body>
</html>

--_000_BL0PR12MB48827D764A414B476C261C45E6A1ABL0PR12MB4882namp_--

