Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E767049F8
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 12:03:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyrW3-0007xc-1c; Tue, 16 May 2023 06:02:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1pyrVz-0007wx-Jg
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:02:44 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1pyrVx-0003KT-5V
 for qemu-devel@nongnu.org; Tue, 16 May 2023 06:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684231361; x=1715767361;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fmOSIBfGzSkXgpaV8bGYirTLz93Vn0NteDx3TIUXaQs=;
 b=PLcE11D9HH9Lo6kjXOGFj6dJWKZWFm9XhXvELNT1Mqx1yIXevUu5Bg9D
 gH7S2qEnvDV9LK7qBZTcXpiSCqulztM3ocxQrxPQHtGrEQtt9mjpW8Wer
 HxvK9+iqT99b9G3qkjS2NDBR4Z5ZfBn2rVWwX6UdR92kyop2T8dM4RQjN
 WkjfSMn2L4+X5A3KqjsvC3X1K07e1kTk9LTLVRgXz8ybur2nuX0/UgXB7
 wti3ztaGQ1KDxgaOFOHiqf72LIVtt1+VCQCEWRNid7Taj8dyuXvxJuUXk
 KB7TZ5k3EjW1CTaQAWvVal6XgBpeB2Mlc2Z8fBpbZK5LS8guS7Ndc/CYg g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="351469078"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; d="scan'208";a="351469078"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 May 2023 03:02:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10711"; a="701284316"
X-IronPort-AV: E=Sophos;i="5.99,278,1677571200"; d="scan'208";a="701284316"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP; 16 May 2023 03:02:33 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Tue, 16 May 2023 03:02:32 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Tue, 16 May 2023 03:02:32 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.102)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Tue, 16 May 2023 03:02:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G8CHZMJ4ll290aDKo8WmuPcM8e/y6M7Jc4GxZs22pKq2VFzyWffJ/pJZ8eU6hjUn5leBsuo3LXsIA33tzlI98JHwMf5NYcAo5U4DHSOs23WZR5q0iqGeyPj1fHnHMxiKH4svW+AxS/6saGTdYfJuFxzB+Yr4ooym7R3PhMAahxw6/7z9CHd4YGJVs4KPdJeImEURRpTFk6iMV1vBR2rMH65d720zmZweZWF7qr4ufOEH4Na3zHw2hwag4nZ+LpJWu79vEBCHaBCuyNkDrBTBpVaHGSlxiNzntY7Vp5z8NqoNWxJxKMm2w9PHuNOaMugZRWvskmgP89KttiFoLAIpAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fmOSIBfGzSkXgpaV8bGYirTLz93Vn0NteDx3TIUXaQs=;
 b=H7gxPu/T7OpFuOPZqbwsrK13INLYzN68QojLzqib/SfnbKCsc+05aEoZrqbt77PbzS+mIOZnAglgbKvzwINLS7RIYVGR8fGtCGyCH2beCuqqPp7fOVVUyPgVE+EWQ5o9i3PoA2wgIXNvsg0IM6088yT6ZqH792cI66kSUZ7GNYYH6oy9G1mXImI08Hu6AOdrmPlFTJZMHjJbjmQQtUcEGcAFyD2mboq/NFOYDm3pPZcEUhu5u7FeXkgktWqDePLVqvUb695BOY2HRm5Z4Lm6aJDzA+EZvp8SllFBwizlzA0rWvX0WVsDDf3W5P/Wu7xn9/s+1K7NeLwkvXYsOj9lPA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7830.namprd11.prod.outlook.com (2603:10b6:8:f2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6387.33; Tue, 16 May
 2023 10:02:25 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6387.030; Tue, 16 May 2023
 10:02:25 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "minwoo.im@samsung.com" <minwoo.im@samsung.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio/pci: Fix a use-after-free issue
Thread-Topic: [PATCH] vfio/pci: Fix a use-after-free issue
Thread-Index: AQHZh6pcVyh2DoD9DkWzAE+6sXomca9cmZ6AgAAH/eA=
Date: Tue, 16 May 2023 10:02:24 +0000
Message-ID: <SJ0PR11MB6744418C6BCC9BF373898AEF92799@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230516034357.61276-1-zhenzhong.duan@intel.com>
 <a704c7bf-3e04-e919-03e2-149f82c04a2b@redhat.com>
In-Reply-To: <a704c7bf-3e04-e919-03e2-149f82c04a2b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7830:EE_
x-ms-office365-filtering-correlation-id: f2cd1f91-d1f2-4134-2c87-08db55f4a616
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6W5fTaubupBBRup6M4dxZNGCGFrd4xD3FW2bd5G6r4WkFPL8HGXzFpgIHHsKb3FcvU1mlorw86f9VqLjWHH1abUsx6IeZ53VDGT168v9n3k11CXY9UlBq6USXbiWpFahPGbx0HnTrAS/PmIhLGzgdwt5MHLnMXCUEBmkJNjLlaChxXeS7sgVJeewLc5CAKcCY9+frDFKc74Ai5YUlrMWTqap3h3ziAccPYA//6JMpJ4Y1OGBg78c26QJVIHDp1iBXnJlX2XT3Kfp0oSSMYWmb+vyMuSR2XOor7hRYFkDTlutL9ahk+J4QbYGCE0DDm9WkSdl9MjBim4TKtEryvJllkQoMqXQig5x+0hIBDp83XZuyEjHnjw4NODagwztRiqWyaLe0sSMj+K1nTnPzUpyBhiRVqVBUkjDO9OwKeFOCGI+CHSJq5ufYNut2igvS2IOyWTM5kqNFhyj6B3tlDr1sknohDyNzNMBljUlmVekfw6yJZ79GZd20GPSO+G/TuUMN7+BURTO6VrBxAtuGbYl4jvcXzIdDyFztt6YebURkfOVGWWWZn8nzz42milrV9qowJxCtFhR8zeS4US1SBuxBLUcxdRimgJLGoQdblHPI6B+UmabxoeVNDRlXrGpFJLl
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(39860400002)(136003)(346002)(376002)(396003)(451199021)(83380400001)(4326008)(38070700005)(2906002)(52536014)(5660300002)(8676002)(8936002)(86362001)(316002)(55016003)(64756008)(66446008)(66476007)(66556008)(66946007)(76116006)(38100700002)(41300700001)(122000001)(82960400001)(66574015)(107886003)(110136005)(186003)(9686003)(6506007)(26005)(33656002)(7696005)(71200400001)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Qldpd0JjNWx0cTZiQWljdWlnUUoxS3dRSS8vSDBWZkpYWm1aaERaUEpnTWNM?=
 =?utf-8?B?U21ueHVGMSs2MzNnRGtyM0ZsMGYrdVV4RGdDQTRWSUI5SWlWcGs4Z1dNNDFE?=
 =?utf-8?B?SjErYlVrWkYreHoxWnNSTnBvMENweGo3Ym85YUtmMlkzVW8rOVdXbHd3RXhV?=
 =?utf-8?B?ZEIvVE5PNFlwT3gwSkxJMTVHc2dyQ2VGZzNua2pBNUZOM0x2bUJCdWpOUHdx?=
 =?utf-8?B?M0FDemkyMk55VHpIOHYrRk9zb2tFdjZWcjBYMXFxN0toaTlxSHVvclBMVVBa?=
 =?utf-8?B?NXFLTU0zVFNsM2tIY2NIVXpjWnR1NDlCbkp0SWF6QVlPcGVQRVlqWGNENHhs?=
 =?utf-8?B?M0lkTnc5Lzc0RWRCL1U4WlJFbVJYa2QwZG5WWm9lUE1aRE1oT3lOa1MwcXdz?=
 =?utf-8?B?bkNBWUFUbmZiRnJyTmdRaGpjbFRRamtnMUpqdVJUY0VrMit5b0N5MDNOMjVG?=
 =?utf-8?B?QTRQTHVERk03N1FpbHZES2o0U2RVVllDNVhQaUI1bW1VVHR3STFkcnRHdTZD?=
 =?utf-8?B?ZTNzalNLTmN0Yk9DUGJhZlFvQ2tJUUxRaTMzNVRWY2MvRUlPSWlyeUxoczV4?=
 =?utf-8?B?QW5iSnlwaDVmTGNHbnl4ZHh1Y1Y0UWd1UnBhTlJHZDJvYlhxZWszbVBWdmNu?=
 =?utf-8?B?dVhxK1c3eTVsN1FteW90dGIzN3lDNGJwSGg1RGFmTURXblVHamVhRkRsM05u?=
 =?utf-8?B?SXRuanlza0FvZlBxOWU3Z0Zrdk04UitXTnFUNGNPd3JEUVo1UVptRXV2YzRR?=
 =?utf-8?B?YjJCZG12UFBPeUFjaWRQV2lxZ1phUTJUV1J6S3dlZWZlMkNYeE9xbnVrUTB3?=
 =?utf-8?B?Y0tlL3RlT3NYMVdNTnB5QktoUytJYjJjcHM5NDFMWDVJbXVMMEhudFJiNTBk?=
 =?utf-8?B?OEN3bVVUVW41N3MzbDdPZWJWdUQwVFN2bXZwMlhhT3hXOEtpckdnSXNjWHR5?=
 =?utf-8?B?VjR4OTFobStCZm0wU2thamtPWWFNMFpUb2hqVndTZFhQUllsdmhpeEVRa3Ey?=
 =?utf-8?B?ZFJaZEpLd3N1L2FmTG5RMTA4disrVDhJTmtDMldTVlJHbnZOcEs5VkRxRUM4?=
 =?utf-8?B?Ym85N0w2M29FSDhnZTJRZnF2eE9XR2dsZFlHQXdBbmhkOW9mRTJqdUxuZXJQ?=
 =?utf-8?B?c1hxdTBPdjlGckxWWUhaeEhlTTM3ZlJXc3JxN1JyNGY0QTJYVFFjR1dkK0R0?=
 =?utf-8?B?L1dWYmRzN0czRlV2SlNveXd1TnZOQ3llRnY4dGU0WGlmaThlV3NwZ1FsQWcy?=
 =?utf-8?B?TVBzMWlicEEyaUtaZmxDTUpJM1NuZ3JzVVN6TWdRcEdKL051LzZ5djJELzBn?=
 =?utf-8?B?Y3pQcHZURWZhYjR2NytWU29zUUxEUDV4QWxQd3lqNERLYnBEaHlVUWV1SUV1?=
 =?utf-8?B?Mm56OVVrUXpXRFFIek1BZnU5dVhRaUtYTjBiTHd6bTBpVmpYNERjQlBQRjdK?=
 =?utf-8?B?ZU1ZUllGU3JuVzRwMXdjYkt4dlF1dWVFN3NVU3pwZnRXRmI1cFd3cmU0RHMw?=
 =?utf-8?B?cWtONVBSc1BTd3F5bzVscTFvNXFiS1paVDJkcXNKY3U4VnZUZDBHSnFxOXBw?=
 =?utf-8?B?K0Fwc2JCbkVyZEsvckZYaGRZMUpaVmVJTmlhS3EycVkrK29PTTBKd1NlWWxJ?=
 =?utf-8?B?czRXMFBGUW1pMmtXZ2lxLzN0RjAyNUREb0pycVMzWGZiZ1VVcWIzOHUxTVg5?=
 =?utf-8?B?Mlg5Sk1XVHNLOU1sdVhCcnIvNnFGQ0VzZWVRQ1hsbCtnb1dRKzQ1bmdob29k?=
 =?utf-8?B?bjVyRVJpRXlLVVAwbG9NSmVlaXdMRG5hdHE5ZThGVnVGaE5kWkIrOW9zYVAv?=
 =?utf-8?B?dURUcWVtVmNockJRbjBsb0E2RGthaHpYNHUwSlMzWTJiMGx2ZjVhanlZUWp1?=
 =?utf-8?B?UVdQU2F3UVBsM1FncjV4c0ZhS1lFVm0wQnRPbEV5dm1GK2grSStoUUhxeFFC?=
 =?utf-8?B?Y3VpY1J0aHlwcWlqY1ZpRDZIbmNLNTZxZ0NOcFFqRWhoTFJ6clZPdGdmTXox?=
 =?utf-8?B?a3dNNkpKYUN5ajNoeFF2dmtNK3dNbkV4d1RJbVdReGxoNnFVTHozOGNheG9k?=
 =?utf-8?B?YnR5NlVzeFgzcGQ4QVlmczJhQTNiN2tHWnIrNWphNTAwbHpxbEFONHFxYUM2?=
 =?utf-8?Q?agyrFj+9sS35jM+N8GpBJkAe7?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2cd1f91-d1f2-4134-2c87-08db55f4a616
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 May 2023 10:02:24.9753 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FI83IHake/m1ofja5rc644EecpEbLs0j+bix3nN8DTD/tW7Dg8nZUcmNsNRuevET7mwVt1IlU+uyPWia3+rUF9BQhEaVXRawKTJpJUW7B10=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7830
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115;
 envelope-from=zhenzhong.duan@intel.com; helo=mga14.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBNYXkgMTYsIDIwMjMgNDo1OCBQTQ0K
PlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47IHFlbXUtDQo+
ZGV2ZWxAbm9uZ251Lm9yZw0KPkNjOiBtaW53b28uaW1Ac2Ftc3VuZy5jb207IGFsZXgud2lsbGlh
bXNvbkByZWRoYXQuY29tOyBQZW5nLCBDaGFvIFANCj48Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0K
PlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZmaW8vcGNpOiBGaXggYSB1c2UtYWZ0ZXItZnJlZSBpc3N1
ZQ0KPg0KPk9uIDUvMTYvMjMgMDU6NDMsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gV2Ugc2hv
dWxkIGZyZWUgdGhlIGR1cGxpY2F0ZWQgdmFyaWFudCBvZiB2YmFzZWRldi0+bmFtZSBwbHVzIHV1
aWQNCj4+IHJhdGhlciB0aGFuIHZiYXNlZGV2LT5uYW1lIGl0c2VsZi4NCj4+DQo+PiBGaXhlczog
MmRjYTFiMzdhNyAoInZmaW8vcGNpOiBhZGQgc3VwcG9ydCBmb3IgVkYgdG9rZSIpDQo+DQo+InRv
a2UiIC0+ICJ0b2tlbiINCldpbGwgZml4LCB0aGFua3MNCg0KPg0KPj4gU2lnbmVkLW9mZi1ieTog
Wmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IC0tLQ0KPj4gICBo
dy92ZmlvL3BjaS5jIHwgNCArKystDQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCAzIGluc2VydGlvbnMo
KyksIDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3
L3ZmaW8vcGNpLmMgaW5kZXgNCj4+IGJmMjdhMzk5MDU2NC4uZDI1OTM2ODFlMDAwIDEwMDY0NA0K
Pj4gLS0tIGEvaHcvdmZpby9wY2kuYw0KPj4gKysrIGIvaHcvdmZpby9wY2kuYw0KPj4gQEAgLTI5
OTgsNyArMjk5OCw5IEBAIHN0YXRpYyB2b2lkIHZmaW9fcmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYs
IEVycm9yDQo+KiplcnJwKQ0KPj4gICAgICAgfQ0KPj4NCj4+ICAgICAgIHJldCA9IHZmaW9fZ2V0
X2RldmljZShncm91cCwgbmFtZSwgdmJhc2VkZXYsIGVycnApOw0KPj4gLSAgICBnX2ZyZWUobmFt
ZSk7DQo+PiArICAgIGlmIChuYW1lICE9IHZiYXNlZGV2LT5uYW1lKSB7DQo+DQo+DQo+eWVzLiBJ
IHdvbmRlciBpZiB3ZSBzaG91bGRuJ3QgdXNlIHRoZSBzYW1lIHRlc3Qgd2l0aCB3aGljaCAnbmFt
ZScgd2FzDQo+YWxsb2NhdGVkIGluc3RlYWQgOg0KPg0KPiAgICAgaWYgKCFxZW11X3V1aWRfaXNf
bnVsbCgmdmRldi0+dmZfdG9rZW4pKSB7DQoNCkkgdGhpbmsgdGhleSBhcmUgc2FtZSBlZmZlY3Qg
YW5kICIgaWYgKG5hbWUgIT0gdmJhc2VkZXYtPm5hbWUpIHsiIGlzIGEgYml0DQptb3JlIG9wdGlt
YWwuIElmIHlvdSBwcmVmZXIgIiBpZiAoIXFlbXVfdXVpZF9pc19udWxsKCZ2ZGV2LT52Zl90b2tl
bikpIHsiLA0KbGV0IG1lIGtub3cgYW5kIEknbGwgdXBkYXRlIGluIHYyLg0KDQpUaGFua3MNClpo
ZW56aG9uZw0K

