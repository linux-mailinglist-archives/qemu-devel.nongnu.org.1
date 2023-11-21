Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 518DD7F262C
	for <lists+qemu-devel@lfdr.de>; Tue, 21 Nov 2023 08:10:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5KtW-0003Oa-N1; Tue, 21 Nov 2023 02:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1r5KtU-0003MT-5j
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:10:00 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1r5KtR-0002GO-8W
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 02:09:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700550597; x=1732086597;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=14pOEZ6vGL/6Jsl9YCauaDqj1Pzifds5pU96zWKnMAk=;
 b=eKKbhsZL0e13xqnIkQqeCbkMy8SaJkbHM5xjhqTnI59iWUAFlSufUJ2l
 uNx+yvHQz/10Kw+z/ZGkZ2Jt8IkXntjI2vHGy0GXQKPsPcOQGLfuaytL8
 e7wc8rIhfoZDXQzjR6VY07sjVj0hbur0Yt66a+aYt2Bd8ITV+dPFCUFFR
 QFHzJJ76PvzIjqEY9OIiz328F9bhGAcn9n8nYJOZk+XaBhDqvR+rdOBRW
 O+NNggSd1HMAqnvjmAsV9OYMKZLlpSNfl48cToB6QwWeQ/oLs1RDxGHs1
 UN6keHrR4N4DizINgFhlIv/bQMtLWAs/6Cbf/e+gqOzm2MSOBJzTTX0lG Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="371952793"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="371952793"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 23:09:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10900"; a="940008085"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; d="scan'208";a="940008085"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Nov 2023 23:09:37 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 23:09:37 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 23:09:37 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 23:09:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4zIZ587vRsAenhkWkgtb3KpCEfznA0MH14lObch6PfmOuf3aO1q7ZukdHsp4WWweM4P38fIy4WtDHgRZdGhWChVGAH7lquIpAnTP6sGz1vjoFJriMd2MOQRkdPnnFGY1qLeKTQmfpz/bpZKsk0SEzwgydUyhCs4QzKYetsa6tkl/h5dhVSn2QJg+V0MDwyjGXybGNZD05ShcG7PJ2ZNEjOY1eFyDwmpbVEVOYhXdC0bd317c2fX9EswdTia7HWKWNHwfkSnzxUtKbOXhMqxK0U9OcrBJ/ClxumTeBFuGdluwzfRqFdFIF/F+eMlePd5n1xSXRQrX36LJdL5SSw8Bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pnr41UJ4Lp88RWfjLil6t7eaNpl0jmoo4egg6b2fL40=;
 b=B6gfy1h7uv3EXbaajAgujgCoZLbbRQPonH1gWiEfdUUiUcPdBahunyddqy6CAuwyDW9HxY7pwF4P+ovuXEsAXEByLye94ZSQlkNyETVkHDKXrWMi4jjWMcNdMa+c/cfLdyc4FMP2KevrjMlfvB+Y5yFmBqTFYbB2TqtmEaDnCz50HpvigdHwhZqTqnUVKLZXTLtAzR9luZwECpFD/mRAEDSLSQDV9NwTjCpTwvY1ys1uyDOP84Faf0hae0ZcBJzozbBkQwGQfIraeaIeEbV1SvmYamhfnpV1KnnnEqs7vdUobT8Q9RfZ9AKsM26xnMsibUin+zwKScqsDZoyY1GWHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20)
 by PH0PR11MB5626.namprd11.prod.outlook.com (2603:10b6:510:ee::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Tue, 21 Nov
 2023 07:09:35 +0000
Received: from SA1PR11MB8428.namprd11.prod.outlook.com
 ([fe80::68bb:9c39:9371:3077]) by SA1PR11MB8428.namprd11.prod.outlook.com
 ([fe80::68bb:9c39:9371:3077%4]) with mapi id 15.20.7002.028; Tue, 21 Nov 2023
 07:09:35 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: zhujun2 <zhujun2@cmss.chinamobile.com>
CC: "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "thuth@redhat.com" <thuth@redhat.com>
Subject: RE: [PATCH] tests/qtest: check the return value
Thread-Topic: [PATCH] tests/qtest: check the return value
Thread-Index: AQHaHEJOeV7OcaDBm0it0yEg0oQICrCEWGDg
Date: Tue, 21 Nov 2023 07:09:35 +0000
Message-ID: <SA1PR11MB8428A0D15E607BE3F6F863149BBBA@SA1PR11MB8428.namprd11.prod.outlook.com>
References: <CYYPR11MB8432C52A61F5A47F4025BDEB9BB0A@CYYPR11MB8432.namprd11.prod.outlook.com>
 <20231121061630.3350-1-zhujun2@cmss.chinamobile.com>
In-Reply-To: <20231121061630.3350-1-zhujun2@cmss.chinamobile.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8428:EE_|PH0PR11MB5626:EE_
x-ms-office365-filtering-correlation-id: 52c7138e-60b2-4e0f-e626-08dbea60d14c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: AQ9RrebS79mJNLo5cUZWlsgpgUneQW2j7jIbM+S4ReBuIdVr8pB17TEFmUpema5KGGXTkDZzAv99NCCQszrtDYiur68joLFAqQJBob6a8zFWs/IE3qis9d7d10rImjAevli2eCIiieqJP6Um1obgU83S2qOXfiDv6S5W589cnZKtGv80LHgG0MXzUzpOK6trbCYVHsj8bOFvAN9ZFNHG/FfiGUknLfNsABK9ShZxXA1LueOjXdrqnaBiaOdJh/yVOMnzZTKAJgKKOIAsVT01GorIRwH7c+w7F/BtpU04CXPZnLXrAdHGorOjwX3kBkjhAcQ+TJzGD/8q/TyD5lwtoG6WICM/KqlvFif1K0yF3i4Y/uxUbYl/pYR+tSbbQnOlIVHeIt9pd3FsKgoHgjQKZbU+mvU8ZiiiREhrurnwLUNd59HLo/pR6WtDnwXmNGhlKugAdyhNjRaFtgl4Q9c19H9Qh/wEsfvBTdFZ2emb75p/hwIv8jqI+Vi1Lixh0vy/g4DQr8hm1TAtP13phcfFACg7W4Xy02o0tFllUDvLO4g/HIaxzXEIQl0gzulzM8ZUWuXXSEivzIAInBxHxUzhCYXSV9iBG7LDoCekmWRDFbqWDy/qGdQNemEZU4HONY2o
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8428.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(39860400002)(376002)(366004)(396003)(136003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(76116006)(66556008)(66446008)(66476007)(66946007)(64756008)(6916009)(54906003)(316002)(71200400001)(6506007)(7696005)(53546011)(9686003)(38070700009)(26005)(478600001)(38100700002)(82960400001)(122000001)(83380400001)(33656002)(86362001)(55016003)(5660300002)(2906002)(41300700001)(52536014)(8676002)(4326008)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?cY11Acd6e1nUeBzij77kMSSZhSpbRzjNsdyeztrSKCUR28KMBaorQvyR0Q/1?=
 =?us-ascii?Q?2gbIJKAjhZWZfXMMhSKnp51jkSP3/tyKmIQIoJSYBU0rAhf3kXVmY0QWqICw?=
 =?us-ascii?Q?BT2ukqgVWsHHQ80Az7pBCetIsms2EQqevtlpBt5xZT4Mrnnq4XADLFrnAR+l?=
 =?us-ascii?Q?1D5Tt57pTQDL5j/rRD0raPGgVWwIZV0HoAECg1ew2kfnW6xWzBV2ltMh5jFp?=
 =?us-ascii?Q?BMgJKXYpT40/vfc9It3NQhb5YHo91fx4PdRludcEwOn91lQ1cLfa6F2hWrBO?=
 =?us-ascii?Q?KFjQNvVEM26u5gMCNxaS0kgW7NFvDIpuhwzi9eK1DdNx1+ATPzhYnJCHoNze?=
 =?us-ascii?Q?LLjUYjcE9s+XIFTRYw8zn6oujclQEoEDFb37cKkD42g/IA47pNs/7Gw1vcV4?=
 =?us-ascii?Q?7ya2qUGHLXBIJrwLZEsWgamIIii4Sso6SN5HEewd90r/kPS87b+fl/jBAJHr?=
 =?us-ascii?Q?pazi10OqBH9xmiZB4b7qrChDcoIYosW1i2Y0lULqRJg/wizv3s9MNQg15dn+?=
 =?us-ascii?Q?8Z+anaLYaj97vCEdmW9uRCC5ytJBk42ReGmpfQvlzDnXeQv2/AUqkHUqkCqm?=
 =?us-ascii?Q?LjFRKHu5nqUDCdozROiISePUoJ9IGaFRkWYFIhWxWSL28ydZvkuHNlUMjeYJ?=
 =?us-ascii?Q?OCFOBscjjZiXYnBQMrPwiE9cHvHA4niGT1rzHOPGwAYcnOY16d0zzq6pqD7f?=
 =?us-ascii?Q?xpujKewgSyTRah5OGSiRuAX858qrgukYQFO7Ke6WIXSkpzf8vRI2KIibhQys?=
 =?us-ascii?Q?qixUs7ryIvna07TKY6c8tdN6aZtJdNdb83VDIWZuWDZQHXP02DFmVDuw5RtU?=
 =?us-ascii?Q?qw4AloMQws7NgqkHvzEfze6p6eZdDssUAACxHD+frdF62RecoiMQubSCDbVr?=
 =?us-ascii?Q?z9TncwL4eu/lCCqJgjD39Q+qcIUp6JrMZgC0VKgIT6Uz9uFFmRdTO6yDC7SN?=
 =?us-ascii?Q?vNajddmHWmDEpVbn6tbvx1puEeBq2vUlpjLmkuY+0KemwNVdmPQy45lr5TBI?=
 =?us-ascii?Q?GoK+hZQF06FQNAUFXgOOTtJ4JJUSWMlEtM4D3HQozBZ5PvKvhbo8xuljedK9?=
 =?us-ascii?Q?T8XXaB+baoGSyjUai2SfNWZAK6XtHoGQg8J8VG6YUduqZAAomRg/kK4ttS9g?=
 =?us-ascii?Q?JIe4YoyL9hmb7Ta5E3CPyqh0jxD+A0jUAzjO0WhAiHkDpDwUQiy5qk6iwkze?=
 =?us-ascii?Q?VpYJsYeS8jNu/D1D7hIDR9dTnQjfqT8knM+GMuHgk1yE/cYdlc1qjeCyHnTB?=
 =?us-ascii?Q?yY8DrtC/W36Fpw1CZc8mNb1LmDt0hmK2w3G17Pe/jMbR3r2SgS10GrxuNGNf?=
 =?us-ascii?Q?VXn7oNh6HU4xxU3kTF9ifejj5OXGuHa6DJPuK98aXQzOCHcwXuCTckhbAPiP?=
 =?us-ascii?Q?RMbC+Xr1m2QPOQtTHTTvAgYAirrYjWWWBSpZczJ8ToUIEs4WwAjDPSVFqVZ6?=
 =?us-ascii?Q?YAEM4xJawB2fx7TcNRLeK79N4Asa/KzZRncfaJlg7W+SdfIyfzTfmKPJgaon?=
 =?us-ascii?Q?bofODk+qFstBs3t/F3btd4cA/qqrcU4tTT3z1Q/qXo1fLjA4A/NOsA0hkKS4?=
 =?us-ascii?Q?PPjEmAbLPp3+1hWn4kqxy/mlpodmlNcfnRS8BVzP?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8428.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52c7138e-60b2-4e0f-e626-08dbea60d14c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2023 07:09:35.2018 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdelgyZGdVnJTH2DBlaBKPs8ILr2uyOggEhOo31sI0fTkj5BwFam8jddIRWogNtUXkMsShRd+Qs7WgUk38iFlw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5626
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.035,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
> From: zhujun2 <zhujun2@cmss.chinamobile.com>
> Sent: Tuesday, November 21, 2023 2:17 PM
> To: Zhang, Chen <chen.zhang@intel.com>
> Cc: lvivier@redhat.com; pbonzini@redhat.com; qemu-devel@nongnu.org;
> thuth@redhat.com; zhujun2@cmss.chinamobile.com
> Subject: [PATCH] tests/qtest: check the return value
>=20
> These variables "ret" are never referenced in the code, that add check lo=
gic
> for the "ret"
>=20

Just tiny comments, please check the len before str, and add the V2 tag in =
mail title next time.
After fix my comments and Thomas comments:
Reviewed-by: Zhang Chen <chen.zhang@intel.com>

Thanks
Chen

> Signed-off-by: zhujun2 <zhujun2@cmss.chinamobile.com>
> ---
>  tests/qtest/test-filter-mirror.c     | 1 +
>  tests/qtest/test-filter-redirector.c | 2 ++
>  tests/qtest/virtio-net-test.c        | 1 +
>  3 files changed, 4 insertions(+)
>=20
> diff --git a/tests/qtest/test-filter-mirror.c b/tests/qtest/test-filter-m=
irror.c
> index adeada3eb8..f3865f7519 100644
> --- a/tests/qtest/test-filter-mirror.c
> +++ b/tests/qtest/test-filter-mirror.c
> @@ -61,6 +61,7 @@ static void test_mirror(void)
>      g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>      recv_buf =3D g_malloc(len);
>      ret =3D recv(recv_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
>      g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>=20
>      g_free(recv_buf);
> diff --git a/tests/qtest/test-filter-redirector.c b/tests/qtest/test-filt=
er-
> redirector.c
> index e72e3b7873..a77d5fd8ec 100644
> --- a/tests/qtest/test-filter-redirector.c
> +++ b/tests/qtest/test-filter-redirector.c
> @@ -118,6 +118,7 @@ static void test_redirector_tx(void)
>      g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>      recv_buf =3D g_malloc(len);
>      ret =3D recv(recv_sock, recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
>      g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>=20
>      g_free(recv_buf);
> @@ -185,6 +186,7 @@ static void test_redirector_rx(void)
>      g_assert_cmpint(len, =3D=3D, sizeof(send_buf));
>      recv_buf =3D g_malloc(len);
>      ret =3D recv(backend_sock[0], recv_buf, len, 0);
> +    g_assert_cmpint(ret, =3D=3D, len);
>      g_assert_cmpstr(recv_buf, =3D=3D, send_buf);
>=20
>      close(send_sock);
> diff --git a/tests/qtest/virtio-net-test.c b/tests/qtest/virtio-net-test.=
c index
> fab5dd8b05..b470d8c6e2 100644
> --- a/tests/qtest/virtio-net-test.c
> +++ b/tests/qtest/virtio-net-test.c
> @@ -92,6 +92,7 @@ static void tx_test(QVirtioDevice *dev,
>=20
>      ret =3D recv(socket, buffer, len, 0);
>      g_assert_cmpstr(buffer, =3D=3D, "TEST");
> +    g_assert_cmpint(ret, =3D=3D, len);

Move it before g_assert_cmpstr().

>  }
>=20
>  static void rx_stop_cont_test(QVirtioDevice *dev,
> --
> 2.17.1
>=20
>=20


