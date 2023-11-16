Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD9D7ED92A
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 03:16:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3RuG-00064B-HX; Wed, 15 Nov 2023 21:15:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1r3Ru7-00063v-Ew
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:14:52 -0500
Received: from mgamail.intel.com ([134.134.136.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1r3Ru4-000127-3J
 for qemu-devel@nongnu.org; Wed, 15 Nov 2023 21:14:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700100888; x=1731636888;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=InVNeoLIvKQMwJb2BsHPuRpiDWwF6LpmDKiizS5qATA=;
 b=dYknykoGVp3BkX28DdypA/h3gHRJyTGXZOJm26AVmdk+7YCq5mJ19xBm
 pWSNLr73RG4mUyo5jIlwHAGKUwkPdt1hCjN2AHYZVwJTmE8xbjqbVob83
 QmRIF9h9Oisgb06VRv2ofeGhRlbZDiLxcNr0WiiyVHihnLLQmUnAPvRr2
 j6ryWXn25oL0RTHi7Zbekkeu9QUDPAhcx8+B+KzzCHCpUh/XnLSGqb684
 7k79bsE4Zuqi4tfjFxmn4s8pHjYIAP3Mbi7ST7lt/c3Cpm5COI/+PKiIz
 qjGpTAmTqHQjSr0vgx9wEPFaZnRnenhQJu/os2W3wpNTArFHP7PFkZ4fx Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393847589"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="393847589"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Nov 2023 18:14:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938681123"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; d="scan'208";a="938681123"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 15 Nov 2023 18:14:43 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 18:14:42 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 18:14:42 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 18:14:42 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 18:14:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0eXZ/92a6k6xt1xWE5loC/jIIYlmgSCkEWLiGCR9tztbP+nkvZrVXj+fRfKlSYI3ohuohy3AfCfhGAfbLhuLNatqjfQd9H/uRIcz7Q4uLUo5+n8oPYrUZ22vrEbnFos5wAERhBW1mc9ZXbgSbDkR3/Wmvi87S5ckyDO+aOro/pilB5P3cOB2xfDwAMWc8fdz3JgfBfIItq6GktFVxHq/9ML67liyncEuS91US6nctlO+jpXZRA+q8fMNYkeHkFi0+519AY4KPj68DtbcJBzOgTXJmOy3dUz7Jh4pNrV/qnVgUPk6khbBAjhzXQ7ilo5yWOJvgNCvkqZpEuMVoJC8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=il5P2VyccJQohT1LgmLN5gZxt/eqNd6ddHE1NrzN8l4=;
 b=jlWKLCeu/7sMfj6TgXUnzUhKbq2wXbtWwZCfsCAMRoP81T0yYwSIXtKd0ofNYUsAImHGS2+unJ2AQCHPas1A5ts08J5N4Wz20N380AyXhIIyoFoOCultvS6hunJ3F5TVT1oUg113B9Fxm46IuegZh2r8IO0hBwDItvCsF7M395nhipKWjBQye7/0SC2b4XONNM1U1lXy/Rf0foF4WOk44PIwwegj9m/Jt4sJO347mKm/RYFhuOnb/K4/od5SpxMz8gLQ8aBZKQWWdj+nMuTQ0e89Djo/pvMyyu+1MBcGCAOAkv36TNyUcdBsdVBk0EHK0kU/3Ox3mUEQH78iiYg4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from CYYPR11MB8432.namprd11.prod.outlook.com (2603:10b6:930:be::8)
 by SJ2PR11MB7599.namprd11.prod.outlook.com (2603:10b6:a03:4c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.18; Thu, 16 Nov
 2023 02:14:40 +0000
Received: from CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::3a72:6cef:3265:65ca]) by CYYPR11MB8432.namprd11.prod.outlook.com
 ([fe80::3a72:6cef:3265:65ca%5]) with mapi id 15.20.7002.015; Thu, 16 Nov 2023
 02:14:40 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: zhujun2 <zhujun2@cmss.chinamobile.com>, "thuth@redhat.com"
 <thuth@redhat.com>
CC: "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] tests/qtest: remove unused variables
Thread-Topic: [PATCH] tests/qtest: remove unused variables
Thread-Index: AQHaF5nD8UaN9YqxQ0iCZH2QY095ELB8NCGQ
Date: Thu, 16 Nov 2023 02:14:40 +0000
Message-ID: <CYYPR11MB8432C52A61F5A47F4025BDEB9BB0A@CYYPR11MB8432.namprd11.prod.outlook.com>
References: <20231115080014.12273-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231115080014.12273-1-zhujun2@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CYYPR11MB8432:EE_|SJ2PR11MB7599:EE_
x-ms-office365-filtering-correlation-id: 5c2a8246-bd7f-4bdd-0a12-08dbe649ca26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1esEJNFoAklJXx9LbCNRYnGmYedjY2rn2DBmpoulMAsoOC5yF5WZfIQKfN+XCgXfrRv+hlkgSwiHJIgHHd0YFey6nNUUHLCDbsIaLuqWVmcqdvESY0LC2bdPtdGjxB2bleuOh7tGPzn9hH0mXT3AnY+GLD6OhnAT+za77VPygYFt6DvDy2Z4vhima2qjNAzWCwrkoihHHQRDrQcZbcdkFEUljDE1Qb2XEaPp8a5+LVuf6ztfTcdgi92e9RKXH99XAeRTDsAL1SMROBMYlb7Pf32lN/ENIPSetCp9rEbkf5KNhJIPlSRJ/t/DGBlE2R2Xhi05gCZvfEUo6ZbwjH09BGWXHVzWLHJr9p5feAAdeOumP/I5ej1Dc9YylLFGTcyKoklOeo37UGQuIVXBmhEp5EjlBi9vJpgJN8+HtqSsVJ9hHX3dhEnzrPMBmpXgAFq+fZC/t3XetmnjKH5P9arenKA/M2q28WhqxAP1/qEbadfarPRlo+WGQVutTm+OxNHWdArU9SMonZ/+/fZ/XFJf2Baq8pZSS8mnjJPVe7gxTBVcdKQWtWEqpgN8J08NbZixvbTXcXZE57Gvd0cfEXKYi9sUR89lGHvwhPs549xhejK12ykl2uPpMyvrCMJOuTan
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8432.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(396003)(366004)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(122000001)(82960400001)(83380400001)(26005)(110136005)(38070700009)(6506007)(2906002)(52536014)(4326008)(5660300002)(316002)(8676002)(64756008)(478600001)(76116006)(66946007)(8936002)(66446008)(9686003)(53546011)(7696005)(41300700001)(86362001)(54906003)(71200400001)(33656002)(66476007)(66556008)(38100700002)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9rDmoEuAK1AcuiohsZHQ5YQ3My46Zbw1B+V26CMSsTDzfA2zfpuNGJOJj8TX?=
 =?us-ascii?Q?F5wGT3Fq+jgItGHTypyaXs7s0bsWSPy+glBi7Fhi2ye6TA5Ln3/mCGSKZaDs?=
 =?us-ascii?Q?itxhxMzo7N8gqYtC0sXb5ljBnZ9HnsEn9M4+BCugWljLJWwv6AjXTQNTGiax?=
 =?us-ascii?Q?VzEwJ1oG6tKcpwOQalzEuDzco20RHeFxYGB+pLluO33sxeOt7LvNFcz8Hgup?=
 =?us-ascii?Q?sswELgZWsX/fTnSnoHGjtlcwnVvIMW7GZjnOuhyLE3aXLmWs81ATMvr2+zLa?=
 =?us-ascii?Q?Y0ttK9z084GII3BE7Wt4XIB/Y2ALs37JPG9xFvnW17TLmYaWgNKd9Hz643NP?=
 =?us-ascii?Q?urJADY2HU03uzf7iEDUer0nr/ENemp6gQDoEPdvaJftFfrlHoVTEuBfuft3t?=
 =?us-ascii?Q?HW+wEAY41v5hWPqI5I4ESptEwCFeKTUZy1iHsKT7g7066hCCIwej+qYOz045?=
 =?us-ascii?Q?wy+JXaYk9+gEOdzSpRBiPpyJ570QtnoRs3KvtEVuyRgDiOFX+l+NIFnDxu5K?=
 =?us-ascii?Q?kHQaGVW3HYkLywaC10JAVVUVEtrbK6AVIuzi7Rr/zzyylX2UpemvMKeShsLW?=
 =?us-ascii?Q?1eEIJYbrKO9e81yNWWu46jen1fFJ+QzaqEgxEFJU1p5u6Eo04KXt/kfS2M1Z?=
 =?us-ascii?Q?U1Wc5H/49UtXpj31bu2XR3FwLjD0gXvjZP5Wz7/O6/u6hmK1Elqf58ctH+Jv?=
 =?us-ascii?Q?JxS53ipbkWuLUTHo38QfcWiHwpbrZI6Xlwa5BsOnlRDbOF9nx1STSmyb96/4?=
 =?us-ascii?Q?x4E50Esuhmhlq2cqq+zRroWOTEwu05lhGzlnvSO2j5wN2g01eG6ji7ACZ81d?=
 =?us-ascii?Q?N5IKBN5LGsu7z7QrlVsjd8Zlj99pIIlilGZ62PXrma3iRCDAhaXf34TfaV59?=
 =?us-ascii?Q?IyqwiSxkgmqXLIFdzqAmpo7A0qFnvpJWJRwAoj4jPqM6e89LOI2O180V0tAb?=
 =?us-ascii?Q?Q44vM7p2jou/2uwXwu04o6H3Khqd0Pf9ddNtUCUMijz5jeGDn9EUclVPZzbM?=
 =?us-ascii?Q?4mV/iPGtdSGTfx+MWh1FUflECOjFfyEKDYSwg6FSgbalCg7ckflwMB/yKwXf?=
 =?us-ascii?Q?1JF5UgQmdwDPpME9RR923DrIwHQxsi8Fqk+PR3hCaU2hZ3dv4QoGDFLCclrM?=
 =?us-ascii?Q?EcI3FcAqcBh7Ymj1yolDb+Y6rlyYICo6ZI0U+3wZE3SVh2ZJ220NzXSiVOel?=
 =?us-ascii?Q?EbnSzWGThEt3OrYidNtdEdGOJsegjnEsdglt7S2akiuNfdRLqIrxSE4GMcxg?=
 =?us-ascii?Q?kq13GRKNttQPuMb+eb5HhQrTOG7Mh0cP+fr0e6DWWPh5eIBtzo7tsWQCIKO5?=
 =?us-ascii?Q?E0h8H01I6eAbA1e30PIRFK16uXWnrKSf7hdUUe18NcpjPxcEAj5j7nm27l5O?=
 =?us-ascii?Q?4QMEk1k9TDltV3eU3oPeAMhlpANojf/lbEN6Digeg6K4Qem8gnghrse5Sykf?=
 =?us-ascii?Q?JroPH8TeDKzVswKWiEGxRDLX34ydKMMEFWsv8B91LoTp2x8kIXzQ2WEA0XcM?=
 =?us-ascii?Q?H9ojBgSrsiNfB7qobpLq9lpzYjMe4yMFNOIpvr3+JD0bwO0YwYV4p2fXc6sI?=
 =?us-ascii?Q?fNDEKe4YM8HXK65yXEDYw+cLlZOIDMSCI0tLJIga?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8432.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c2a8246-bd7f-4bdd-0a12-08dbe649ca26
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Nov 2023 02:14:40.0976 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k9h+j2+3SMqU5uO5fOy7UygiGuWwWgyzoPF0lTzUAqvkrDbs4+GhX7xuVL01O/VQSJnpBxERQqldNdIVE59lKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7599
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.24; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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



> -----Original Message-----
> From: qemu-devel-bounces+chen.zhang=3Dintel.com@nongnu.org <qemu-
> devel-bounces+chen.zhang=3Dintel.com@nongnu.org> On Behalf Of zhujun2
> Sent: Wednesday, November 15, 2023 4:00 PM
> To: thuth@redhat.com
> Cc: lvivier@redhat.com; pbonzini@redhat.com; qemu-devel@nongnu.org;
> zhujun2@cmss.chinamobile.com
> Subject: [PATCH] tests/qtest: remove unused variables
>=20
> These variables are never referenced in the code, just remove them
>=20
> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tests/qtest/test-filter-mirror.c     | 2 +-
>  tests/qtest/test-filter-redirector.c | 4 ++--
>  tests/qtest/virtio-net-test.c        | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-m=
irror.c
> index adeada3eb8..7aa81daa93 100644
> --- a/tests/qtest/test-filter-mirror.c
> +++ b/tests/qtest/test-filter-mirror.c
> @@ -60,7 +60,7 @@ static void test_mirror(void)
>=20
>      g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>      recv_buf =3D g_malloc(len);
> -    ret =3D recv(recv_sock[0], recv_buf, len, 0);
> +    recv(recv_sock[0], recv_buf, len, 0);
>      g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>=20
>      g_free(recv_buf);
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filt=
er-
> redirector.c
> index e72e3b7873..e4dfeff2e0 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -117,7 +117,7 @@ static void test_redirector_tx(void)
>=20
>      g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>      recv_buf =3D g_malloc(len);
> -    ret =3D recv(recv_sock, recv_buf, len, 0);
> +    recv(recv_sock, recv_buf, len, 0);
>      g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>=20
>      g_free(recv_buf);
> @@ -184,7 +184,7 @@ static void test_redirector_rx(void)
>=20
>      g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>      recv_buf =3D g_malloc(len);
> -    ret =3D recv(backend_sock[0], recv_buf, len, 0);
> +    recv(backend_sock[0], recv_buf, len, 0);

It looks like add more check for the "ret" is better.
For example:
g_assert_cmpint(ret, =3D=3D, len);

Thanks
Chen

>      g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>=20
>      close(send_sock);
> diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.=
c index
> fab5dd8b05..26df5bbabe 100644
> --- a/tests/qtest/virtio-net-test.c
> +++ b/tests/qtest/virtio-net-test.c
> @@ -90,7 +90,7 @@ static void tx_test(QVirtioDevice *dev,
>      g_assert_cmpint(ret, =3D=3D, sizeof(len));
>      len =3D ntohl(len);
>=20
> -    ret =3D recv(socket, buffer, len, 0);
> +    recv(socket, buffer, len, 0);
>      g_assert_cmpstr(buffer, =3D=3D, "TEST");  }
>=20
> --
> 2.17.1
>=20
>=20
>=20


