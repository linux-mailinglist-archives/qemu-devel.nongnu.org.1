Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F0AC0748541
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 15:43:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qH2m5-0006ay-7O; Wed, 05 Jul 2023 09:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sajan.Karumanchi@amd.com>)
 id 1qH2KC-0004rY-Er
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:13:40 -0400
Received: from mail-bn7nam10on2075.outbound.protection.outlook.com
 ([40.107.92.75] helo=NAM10-BN7-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <Sajan.Karumanchi@amd.com>)
 id 1qH2K9-0005vr-RP
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 09:13:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kWU4w0raCMsvSvP1MkHapQ5RYV/xHsCPeT0npBVI4fGopqKRVmhE7h9BZds6xw2gl0s+IAjY/6mcZvtT+YtEHrAT/g9C/w+0zBcbQ5Ne39Uo6YoQZCg+MGbWqzgbK8prHhJsLvjOznuiw9+54dTyq2PNI3yvl/Nri+noGw7sA8l8snVjLgwoEJ8zgK5YcTDlP8DLv9TDJYMqumwlIINPfBQweSX7zlSQ7ZnEWKujkVTNs9F9oknBA1S+f1+CjKr0RHGkRVSZyGIUoMmjxcHKBobeP7cqIyHU5yZk2oRdugK0FnvbGheAkytO4DR6TCy5ym/8lWq7XQrGuXgl37leIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uh2GJSXEaQc0CCKs2CNo/Ld7+47BH8VMyjz9gtyM01c=;
 b=AVLLwlKyjj32IPMB+PPFzTcqddtTQRdnt3VhXywwj3B4P1WQS+Y2iBcbacGuDjtQHGssGMpKdlpPH6a26dIm2SJFIz9zvkjV8c5TZBFMq7LKMmXapTngi2lVq+NdwH7gyhfowy1owO4dpvTbEinL3fF9te6OjSKq951TrBUYD/HWk66GzsFyjUopV+7DlGvHf3Bao0pn34dMNQGfeJZgvV++AyqLb1/9jtuhqaaMVJV7VPsdlD/4UKstvvFfGkK0xPjK0SxKXQjod+tOvEfvLyU95sWP785cAI6mI1VBtaK9lKqqKN8kXQEE/LxwyEvqjb7v+zBX/WMXzaT88j/+ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uh2GJSXEaQc0CCKs2CNo/Ld7+47BH8VMyjz9gtyM01c=;
 b=pprK0bBqLuBsnefDITZPfuWDmn4eZw1lPfySYRdm7DivK/RpEoyuybS+uGZ1yhdyA/0Qn2tfafLJekvcKyegrij0lC1gisXMNGUA/KPmfzt3sL39/ByLm2dl5x3hUB46GyZ8WW2qnx+PZxEnDP60hvpnydQ7WjrhegvDE3yvLbo=
Received: from SJ0PR12MB5633.namprd12.prod.outlook.com (2603:10b6:a03:428::8)
 by BL1PR12MB5972.namprd12.prod.outlook.com (2603:10b6:208:39b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.17; Wed, 5 Jul
 2023 13:08:31 +0000
Received: from SJ0PR12MB5633.namprd12.prod.outlook.com
 ([fe80::d5ab:3a80:dd41:98d2]) by SJ0PR12MB5633.namprd12.prod.outlook.com
 ([fe80::d5ab:3a80:dd41:98d2%4]) with mapi id 15.20.6544.024; Wed, 5 Jul 2023
 13:08:31 +0000
From: "Karumanchi, Sajan" <Sajan.Karumanchi@amd.com>
To: Florian Weimer <fweimer@redhat.com>,
 =?iso-8859-1?Q?Daniel_P=2EBerrang=E9?= <berrange@redhat.com>
CC: Pierrick Bouvier <pierrick.bouvier@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>,
 "laurent@vivier.eu" <laurent@vivier.eu>, "Mallappa, Premachandra"
 <Premachandra.Mallappa@amd.com>
Subject: Re: GLibC AMD CPUID cache reporting regression (was Re: qemu-user
 self emulation broken with default CPU on x86/x64)
Thread-Topic: GLibC AMD CPUID cache reporting regression (was Re: qemu-user
 self emulation broken with default CPU on x86/x64)
Thread-Index: AQHZrfIt0hxEaafV30aQjsXtI1+dPq+p4KA4gAFG+rU=
Date: Wed, 5 Jul 2023 13:08:31 +0000
Message-ID: <SJ0PR12MB563371758C7F46DB37D23C7D892FA@SJ0PR12MB5633.namprd12.prod.outlook.com>
References: <c0a35ed3-7e4a-aea6-a3bd-9f0e4079f4e0@linaro.org>
 <ZKM4LV5UboN7PGni@redhat.com> <87v8ez4ly4.fsf@oldenburg.str.redhat.com>
In-Reply-To: <87v8ez4ly4.fsf@oldenburg.str.redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Enabled=True;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SiteId=3dd8961f-e488-4e60-8e11-a82d994e183d;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_SetDate=2023-07-05T13:08:30.133Z;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Name=General;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_ContentBits=0;
 MSIP_Label_4342314e-0df4-4b58-84bf-38bed6170a0f_Method=Standard; 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR12MB5633:EE_|BL1PR12MB5972:EE_
x-ms-office365-filtering-correlation-id: b7ca7241-d2e8-4e66-a340-08db7d58ee7a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mwZumtI/BGVpWBSwn7H4ApYsZtRYALFxqC9aQDbjD6OsyMrdHoC7JVnssQzB06cqSBIZoEbwgrIzvJV3NXVNg9VWIGKKs5IQQqtW5zPfyFyfZP8HcEWniPLawLfVMe7dXpwxlRsgCZJq06pqpYjV0qkiw7AXAxYj9mwCHvbFqwt1aXip4xzboSztdp6mDqB1G0RCY/FLLIm2MarWmOuvIHx6pqYPUQObt3byr6Zohq2Mf5vNdPlXrS3NpyNSCwj+jF7Tfq/grKPBqiQaKpSxtejgYscYukgQffnwoYVfzvGDIvTVOaU4IKw5yoZr6WTKOLQMTaodM74FU0MCc+lYczSwdQjxSW39HcaAoe3Lxh+BbP611uUhmtBfQ0871GIQUpQ8VvJhzZR00AtbgRrlmhPMfdyLO0r98cwhWdqOzEgv1Ky3l/vTYDoaQIWcC30DzNbBa3drLt3nhXmGrl+Mu9PDpFnZJyJoaNLNkFQD6+Spa2ta6IC/xjf3ft0WtszqLxnjFy0rEA85bcOpTBuyO1sUYAdT03pg7TbtVyQcB14LeP1KrSvqqmwXgsjWqnR1F1PDGi/VfMHx4XGhGoCJNBnPKEBA3HSKg3MqeRyoXCZ0UcYPtqcA/20MzqP7OAW/Zipt9QgX7uKp/4XHzCJlgA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB5633.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(366004)(376002)(39860400002)(136003)(346002)(396003)(451199021)(64756008)(66476007)(91956017)(4326008)(66446008)(66556008)(76116006)(66946007)(122000001)(38100700002)(38070700005)(86362001)(186003)(6506007)(9686003)(26005)(166002)(53546011)(83380400001)(478600001)(33656002)(7696005)(55016003)(54906003)(110136005)(41300700001)(52536014)(8936002)(19627405001)(8676002)(71200400001)(21615005)(5660300002)(2906002)(316002);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?02BPwPm3O2s4WH2KzyccVhTgpxT/dhHFDjdN35alXw2O3BUuayUc7WZnGF?=
 =?iso-8859-1?Q?SM1FxraRHbefnBjGo45/gWgrQ7nFCTEDElaLFQlEtFYamAC4PtarxeFknX?=
 =?iso-8859-1?Q?EvskeFS2ponRzU92bztHgQb9Jv8MgE6XKrBMdG5GouJCGgrE44OUiS+NGI?=
 =?iso-8859-1?Q?B+DPbryAvHzu+KPYOMAoDi0lApJK8yALcT3KNeJP9LQuxHyG8/lxAQLK0H?=
 =?iso-8859-1?Q?Er9JgPt4nRzqaXwleMX+XSOSSDCTcc017weCwk+gGKB7sQJLa5Vatasu8q?=
 =?iso-8859-1?Q?1F+zuTmvmNLcb+kphpx40/jEJoUjFvRDz09y9Y8qsgjKQQa7rQKXNVE3pi?=
 =?iso-8859-1?Q?8SHpFSc63f4ZYYyQtwamXIXk1Wiak1MetFuG6NnhevkUnc7/vMq8I4Xja0?=
 =?iso-8859-1?Q?n6ToMTk3JTz3ec0Pt4cAuy+e2wEPRxPQv9xEpjjYKsAtVsSVJhMisEvoHD?=
 =?iso-8859-1?Q?dkskNfO6+kL03da5SEgiHuTfN2J7L4CSdL4s+jt12Xaz6aM0wCP3Mjo0AA?=
 =?iso-8859-1?Q?McGE2eRi735lK0Ydkd6QlLkEEptruC5j+v5n+Ch3ACyS9UMkm4m2qBOgxe?=
 =?iso-8859-1?Q?y1M+RP/WFnZW7qFChJn8h3UMP/aL6iINB1hXPSe9zE7Z2BTdBQlJ7l9VSL?=
 =?iso-8859-1?Q?3nObFJlRHnBIancGPvocAaDMpZT7482mJjY7Q3Xc5YB4/i1TiYHhoMJj4Z?=
 =?iso-8859-1?Q?HFGBNgFe275kFnhkx+enKhmVknGvkDg6qT7ruT1Tjqw7lAeXbVd53Va2yg?=
 =?iso-8859-1?Q?u3ZeYffjHKvEFoYtivwNr9NQhgJVJxREWr7fquiNmuvAReSSR/A8U6onGM?=
 =?iso-8859-1?Q?5ftXBP0JkoAdwYHo00E7amgGV4R1L3VE5+PlekGXKfthSl2akDU4ztkcl8?=
 =?iso-8859-1?Q?p6v/fmm9M4xkPP5AjH3NCVzRAxIeKNxgRV/xp0hPDILdCwCvstl7JiZmTv?=
 =?iso-8859-1?Q?ISn5IdtOcZKfWRnMuhWLbqv5hLjS68VuIC3vGqK5JR5wFWtx9I8qxB5GEx?=
 =?iso-8859-1?Q?fmlXSNu8/2pfnwKZtLlMeLUVyJnQX5xa4NQ8+JpXBIMxIqyhI0vgu4azvp?=
 =?iso-8859-1?Q?yVSvOfJEcutFj3rx0tc2neXxjB9sy1+H18OMYf9mDJ3cRh2XjX74F0SGnh?=
 =?iso-8859-1?Q?maZRkYzHFpHKlv7j5vGK0M2sMzeCsja9sqsRWHP4AjLhSdunKDKvhPPgpR?=
 =?iso-8859-1?Q?ZPcMFXGwqO8H68d2mlrtU2AxskRPjzUi++G7ik2Y497chuF8zjn164dGiF?=
 =?iso-8859-1?Q?0Te4bNatMkuz0ceX2OLBHZVF9eCj0ceigOJ8OV+rU5+lhUx/YKhzsKKts9?=
 =?iso-8859-1?Q?cJ+n7HyMU1/I/eREAFXMzBzyPD2qjKg6pD4PVIBV0x7mq4E+vugi7bAT4N?=
 =?iso-8859-1?Q?pAB+nGO13EjTy7o3CbMvFMw5ou0jRK6y8C+Z/27kHDbl9YpLLkMIcfg3X/?=
 =?iso-8859-1?Q?c2izv34B8MAuxzcekq80d6CSx7/nsJG6KB27ywZvAJkBbwFn790raZmwXg?=
 =?iso-8859-1?Q?mPDbdHblx9vWvidbIpRf6jP8C4lARijgPe+yFe46R0Crf/6rHd+APtWC6E?=
 =?iso-8859-1?Q?HctlcFofop8J6/lXXs1pqgnmKJ/CiFxMdLYxDBFL6aFozhRfUhS5EwTFUa?=
 =?iso-8859-1?Q?OT+qh+GNyaO6Q=3D?=
Content-Type: multipart/alternative;
 boundary="_000_SJ0PR12MB563371758C7F46DB37D23C7D892FASJ0PR12MB5633namp_"
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB5633.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7ca7241-d2e8-4e66-a340-08db7d58ee7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jul 2023 13:08:31.4409 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GxUbDRiWBl6rIs5rrM4mz0tea6ZTQyciaXCFJY270fo1qHvejJVq9NtJw22ql3CTdVXNwNARHilRwDl+L31oWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5972
Received-SPF: softfail client-ip=40.107.92.75;
 envelope-from=Sajan.Karumanchi@amd.com;
 helo=NAM10-BN7-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 05 Jul 2023 09:42:27 -0400
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

--_000_SJ0PR12MB563371758C7F46DB37D23C7D892FASJ0PR12MB5633namp_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

[AMD Official Use Only - General]

++ Prem


Thanks & Regards,

Sajan K.



________________________________
From: Florian Weimer <fweimer@redhat.com>
Sent: Tuesday, July 4, 2023 11:07 PM
To: Daniel P.Berrang=E9 <berrange@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>; qemu-devel@nongnu.org <=
qemu-devel@nongnu.org>; Richard Henderson <richard.henderson@linaro.org>; l=
aurent@vivier.eu <laurent@vivier.eu>; Karumanchi, Sajan <Sajan.Karumanchi@a=
md.com>
Subject: Re: GLibC AMD CPUID cache reporting regression (was Re: qemu-user =
self emulation broken with default CPU on x86/x64)

Caution: This message originated from an External Source. Use proper cautio=
n when opening attachments, clicking links, or responding.


* Daniel P. Berrang=E9:

> On Mon, Jul 03, 2023 at 06:03:08PM +0200, Pierrick Bouvier wrote:
>> Hi everyone,
>>
>> Recently (in d135f781 [1], between v7.0.0 and v8.0.0), qemu-user default=
 cpu
>> was updated to "max" instead of qemu32/qemu64.
>>
>> This change "broke" qemu self emulation if this new default cpu is used.
>>
>> $ ./qemu-x86_64 ./qemu-x86_64 --version
>> qemu-x86_64: ../util/cacheflush.c:212: init_cache_info: Assertion `(isiz=
e &
>> (isize - 1)) =3D=3D 0' failed.
>> qemu: uncaught target signal 6 (Aborted) - core dumped
>> Aborted
>>
>> By setting cpu back to qemu64, it works again.
>> $ ./qemu-x86_64 -cpu qemu64 ./qemu-x86_64  --version
>> qemu-x86_64 version 8.0.50 (v8.0.0-2317-ge125b08ed6)
>> Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project developers
>>
>> Commenting assert does not work, as qemu aligned malloc fail shortly aft=
er.
>>
>> I'm willing to fix it, but I'm not sure what is the issue with "max" cpu
>> exactly. Is it missing CPU cache line, or something else?
>
> I've observed GLibC is issuing CPUID leaf 0x8000_001d
>
> QEMU 'max' CPU model doesn't defnie xlevel, so QEMU makes it default
> to the same as min_xlevel, which is calculated to be 0x8000_000a.
>
> cpu_x86_cpuid() in QEMU sees CPUID leaf 0x8000_001d is above 0x8000_000a,
> and so  considers it an invaild CPUID and thus forces it to report
> 0x0000_000d which is supposedly what an invalid CPUID leaf should do.
>
>
> Net result: glibc is asking for 0x8000_001d, but getting back data
> for 0x0000_000d.
>
> This doesn't end happily for obvious reasons, getting garbage for
> the dcache sizes.
>
>
> The 'qemu64' CPU model also gets CPUID leaf 0x8000_001d capped back
> to 0x0000_000d, but crucially qemu64 lacks the 'xsave' feature bit,
> so QEMU returns all-zeroes for CPUID leaf 0x0000_000d. Still not
> good, but this makes glibc report 0 for DCACHE_*, which in turn
> avoids tripping up the nested qemu which queries DCACHE sysconf.
>
> So the problem is thus more widespread than just 'max' CPU model.
>
> Any QEMU CPU model with vendor=3DAuthenticAMD and the xsave feature,
> and the xlevel unset, will cause glibc to report garbage for the
> L1D cache info
>
> Any QEMU CPU model with vendor=3DAuthenticAMD and without the xsave
> feature, and the xlevel unset, will cause glibc to report zeroes
> for L1D cache info
>
> Neither is good, but the latter at least doesn't trip up the
> nested QEMU when it queries L1D cache info.
>
> I'm unsure if QEMU's behaviour is correct with calculating the
> default 'xlevel' values for 'max', but I'm assuming the xlevel
> was correct for Opteron_G4/5 since those are explicitly set
> in the code for along time.

We are tracking this as:

  New AMD cache size computation logic does not work for some CPUs,
  hypervisors
  <https://sourceware.org/bugzilla/show_bug.cgi?id=3D30428>

I filed it after we resolved the earlier crashes because the data is
clearly not accurate.  I was also able to confirm that impacts more than
just hypervisors.

Sajan posted a first patch:

  [PATCH] x86: Fix for cache computation on AMD legacy cpus.
  <https://sourceware.org/pipermail/libc-alpha/2023-June/148763.html>

However, it changes the reported cache sizes on some older CPUs compared
to what we had before (although the values are no longer zero at least).

Thanks,
Florian


--_000_SJ0PR12MB563371758C7F46DB37D23C7D892FASJ0PR12MB5633namp_
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
<p style=3D"font-family:Arial;font-size:10pt;color:#0000FF;margin:5pt;font-=
style:normal;font-weight:normal;text-decoration:none;" align=3D"Left">
[AMD Official Use Only - General]<br>
</p>
<br>
<div>
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);" class=3D"elementToProof">
++ Prem</div>
<div class=3D"elementToProof">
<div style=3D"font-family: Calibri, Arial, Helvetica, sans-serif; font-size=
: 11pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div>
<div class=3D"WordSection1">
<p class=3D"MsoAutoSig"><i><span style=3D"font-size:10.0pt;mso-bidi-font-fa=
mily:Calibri;=0A=
mso-bidi-theme-font:minor-latin">Thanks &amp; Regards,<o:p></o:p></span></i=
></p>
<p class=3D"MsoAutoSig"><i><span style=3D"font-size:10.0pt;mso-bidi-font-fa=
mily:Calibri;=0A=
mso-bidi-theme-font:minor-latin">Sajan K.<o:p></o:p></span></i></p>
<p class=3D"MsoAutoSig"><i><span style=3D"font-size:10.0pt;mso-bidi-font-fa=
mily:Calibri;=0A=
mso-bidi-theme-font:minor-latin"><o:p>&nbsp;</o:p></span></i></p>
</div>
</div>
</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Florian Weimer &lt;fw=
eimer@redhat.com&gt;<br>
<b>Sent:</b> Tuesday, July 4, 2023 11:07 PM<br>
<b>To:</b> Daniel P.Berrang=E9 &lt;berrange@redhat.com&gt;<br>
<b>Cc:</b> Pierrick Bouvier &lt;pierrick.bouvier@linaro.org&gt;; qemu-devel=
@nongnu.org &lt;qemu-devel@nongnu.org&gt;; Richard Henderson &lt;richard.he=
nderson@linaro.org&gt;; laurent@vivier.eu &lt;laurent@vivier.eu&gt;; Karuma=
nchi, Sajan &lt;Sajan.Karumanchi@amd.com&gt;<br>
<b>Subject:</b> Re: GLibC AMD CPUID cache reporting regression (was Re: qem=
u-user self emulation broken with default CPU on x86/x64)</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">Caution: This message originated from an External =
Source. Use proper caution when opening attachments, clicking links, or res=
ponding.<br>
<br>
<br>
* Daniel P. Berrang=E9:<br>
<br>
&gt; On Mon, Jul 03, 2023 at 06:03:08PM +0200, Pierrick Bouvier wrote:<br>
&gt;&gt; Hi everyone,<br>
&gt;&gt;<br>
&gt;&gt; Recently (in d135f781 [1], between v7.0.0 and v8.0.0), qemu-user d=
efault cpu<br>
&gt;&gt; was updated to &quot;max&quot; instead of qemu32/qemu64.<br>
&gt;&gt;<br>
&gt;&gt; This change &quot;broke&quot; qemu self emulation if this new defa=
ult cpu is used.<br>
&gt;&gt;<br>
&gt;&gt; $ ./qemu-x86_64 ./qemu-x86_64 --version<br>
&gt;&gt; qemu-x86_64: ../util/cacheflush.c:212: init_cache_info: Assertion =
`(isize &amp;<br>
&gt;&gt; (isize - 1)) =3D=3D 0' failed.<br>
&gt;&gt; qemu: uncaught target signal 6 (Aborted) - core dumped<br>
&gt;&gt; Aborted<br>
&gt;&gt;<br>
&gt;&gt; By setting cpu back to qemu64, it works again.<br>
&gt;&gt; $ ./qemu-x86_64 -cpu qemu64 ./qemu-x86_64&nbsp; --version<br>
&gt;&gt; qemu-x86_64 version 8.0.50 (v8.0.0-2317-ge125b08ed6)<br>
&gt;&gt; Copyright (c) 2003-2023 Fabrice Bellard and the QEMU Project devel=
opers<br>
&gt;&gt;<br>
&gt;&gt; Commenting assert does not work, as qemu aligned malloc fail short=
ly after.<br>
&gt;&gt;<br>
&gt;&gt; I'm willing to fix it, but I'm not sure what is the issue with &qu=
ot;max&quot; cpu<br>
&gt;&gt; exactly. Is it missing CPU cache line, or something else?<br>
&gt;<br>
&gt; I've observed GLibC is issuing CPUID leaf 0x8000_001d<br>
&gt;<br>
&gt; QEMU 'max' CPU model doesn't defnie xlevel, so QEMU makes it default<b=
r>
&gt; to the same as min_xlevel, which is calculated to be 0x8000_000a.<br>
&gt;<br>
&gt; cpu_x86_cpuid() in QEMU sees CPUID leaf 0x8000_001d is above 0x8000_00=
0a,<br>
&gt; and so&nbsp; considers it an invaild CPUID and thus forces it to repor=
t<br>
&gt; 0x0000_000d which is supposedly what an invalid CPUID leaf should do.<=
br>
&gt;<br>
&gt;<br>
&gt; Net result: glibc is asking for 0x8000_001d, but getting back data<br>
&gt; for 0x0000_000d.<br>
&gt;<br>
&gt; This doesn't end happily for obvious reasons, getting garbage for<br>
&gt; the dcache sizes.<br>
&gt;<br>
&gt;<br>
&gt; The 'qemu64' CPU model also gets CPUID leaf 0x8000_001d capped back<br=
>
&gt; to 0x0000_000d, but crucially qemu64 lacks the 'xsave' feature bit,<br=
>
&gt; so QEMU returns all-zeroes for CPUID leaf 0x0000_000d. Still not<br>
&gt; good, but this makes glibc report 0 for DCACHE_*, which in turn<br>
&gt; avoids tripping up the nested qemu which queries DCACHE sysconf.<br>
&gt;<br>
&gt; So the problem is thus more widespread than just 'max' CPU model.<br>
&gt;<br>
&gt; Any QEMU CPU model with vendor=3DAuthenticAMD and the xsave feature,<b=
r>
&gt; and the xlevel unset, will cause glibc to report garbage for the<br>
&gt; L1D cache info<br>
&gt;<br>
&gt; Any QEMU CPU model with vendor=3DAuthenticAMD and without the xsave<br=
>
&gt; feature, and the xlevel unset, will cause glibc to report zeroes<br>
&gt; for L1D cache info<br>
&gt;<br>
&gt; Neither is good, but the latter at least doesn't trip up the<br>
&gt; nested QEMU when it queries L1D cache info.<br>
&gt;<br>
&gt; I'm unsure if QEMU's behaviour is correct with calculating the<br>
&gt; default 'xlevel' values for 'max', but I'm assuming the xlevel<br>
&gt; was correct for Opteron_G4/5 since those are explicitly set<br>
&gt; in the code for along time.<br>
<br>
We are tracking this as:<br>
<br>
&nbsp; New AMD cache size computation logic does not work for some CPUs,<br=
>
&nbsp; hypervisors<br>
&nbsp; &lt;<a href=3D"https://sourceware.org/bugzilla/show_bug.cgi?id=3D304=
28">https://sourceware.org/bugzilla/show_bug.cgi?id=3D30428</a>&gt;<br>
<br>
I filed it after we resolved the earlier crashes because the data is<br>
clearly not accurate.&nbsp; I was also able to confirm that impacts more th=
an<br>
just hypervisors.<br>
<br>
Sajan posted a first patch:<br>
<br>
&nbsp; [PATCH] x86: Fix for cache computation on AMD legacy cpus.<br>
&nbsp; &lt;<a href=3D"https://sourceware.org/pipermail/libc-alpha/2023-June=
/148763.html">https://sourceware.org/pipermail/libc-alpha/2023-June/148763.=
html</a>&gt;<br>
<br>
However, it changes the reported cache sizes on some older CPUs compared<br=
>
to what we had before (although the values are no longer zero at least).<br=
>
<br>
Thanks,<br>
Florian<br>
<br>
</div>
</span></font></div>
</div>
</body>
</html>

--_000_SJ0PR12MB563371758C7F46DB37D23C7D892FASJ0PR12MB5633namp_--

