Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CA27E503C
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 07:10:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0bk0-0001t0-B4; Wed, 08 Nov 2023 01:08:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0bjx-0001sa-MZ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 01:08:38 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0bjv-0001JY-B7
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 01:08:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699423716; x=1730959716;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=J61D/1/uj3XYOuI46ddL9uOfRwHbdaKbcTuMJoc6KJQ=;
 b=FLNuE1FP/YQLZn2PrcF/FI74WZ9EPXwqbhs5KaURsNxUQh6SE2pAqXoY
 PyYGTHggGKPm4y3/aE5VsJijca4ohU/myXPS8wMgjgmB5+8uf8ZhtxKaX
 RkX4bEx8dr2taizz+Q+FT8Cu6YbdmIu2D9pPrD8je7eB3GxHV/a2gZEIX
 F6wClmlLRLcmqMlxcDqkhP1+tSm8vRWYctvIFNXLN2yCAxtm5F+39C3fm
 5yIX1MaogoWfipaeU5GQKCzrow6zHqOJFns3ClkADxmjxmM09czS/pkVX
 5m+wpbszUQBawLuKaMqBGz30xuXIBo4XHpU6k3xkaYefSHP1o4OLuDexO A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="8350573"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; 
   d="scan'208";a="8350573"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 22:08:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="828863797"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="828863797"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2023 22:08:31 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 22:08:30 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 22:08:30 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 22:08:30 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 22:08:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bzMcTOi8yjrqy5dlu9gbuSphC5HJTEXeakOsaAGQ9xJDQipiEJ6VN4OYo8dUwBnXM1KVfcAikoOMbfcMLxNZkbWMYjaQgeMf4Sp8zp6TECm9wvvjeBGI6Uf83h297nTS6Wa3ktxM21V5t4VFRc2cNLLq+XV48R4g8ZlhxGUFlu9c0prMSDUSTGLI0+T7audpHf+V/4Ixzq0WA8/2vxR6bQolRGoLkrH3ouOb+1rHSTs7IZWCkZPQu8fkq1FPlvOo3x7W8wd02LkynY2NPbX+jx/QGX8hqGR/252/TIsJ6vNhM+yTJqxNnMANL8a89BxQJuEOHk4FE8olKO1cmEwN+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J61D/1/uj3XYOuI46ddL9uOfRwHbdaKbcTuMJoc6KJQ=;
 b=Q97PACkgg+xUB0MAnb+tr3jAbqAez2vxedzqrWJpJZOuXqVDqHW6kzaluP2TQEEjhr0fzvrmvkKjLgx98VQ7opLWNsmkSMNLdLDmqobbJS69R2tHjEi87Koaju46NOC0xZ03cEFLx6VsYzUhDgmU4BYM58dKCczaTH9S4PcDQtRk2zmgkFuy/HC8mtXb5XvqKE+IPDCHyzLxKRl80bzBsLTvNDmoS4a5+aRM05LVWZGc5dbSH2Zz7bmUW4UIc9oAtfAkGG6b+8NxJ9/RdV7cf2t5R8OTc2rxgDNwWezrckzVko4SAe96ZuNB0yKwPd2w2GwqfzBqqApDhDack7JFMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB7658.namprd11.prod.outlook.com (2603:10b6:510:28d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.24; Wed, 8 Nov
 2023 06:08:26 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 06:08:26 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?=
 <marcandre.lureau@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: RE: [PATCH v4 25/41] Add iommufd configure option
Thread-Topic: [PATCH v4 25/41] Add iommufd configure option
Thread-Index: AQHaDV525I9F5hjtm0Ggr9IoJcJrUrBu3hGAgAAXC4CAAQIYMA==
Date: Wed, 8 Nov 2023 06:08:26 +0000
Message-ID: <SJ0PR11MB6744FF2F22AD7FAB3C7FE9A992A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-26-zhenzhong.duan@intel.com>
 <b20a0864-6592-4544-9b73-4ba029f707da@redhat.com>
 <95315815-4baa-42c2-9ec2-943955f110b3@redhat.com>
In-Reply-To: <95315815-4baa-42c2-9ec2-943955f110b3@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB7658:EE_
x-ms-office365-filtering-correlation-id: 9c67cac7-9f6c-49d6-2500-08dbe0211f18
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pWR/0CWsovV7mt9sxYPegpCe3oFzsqy1TyygnvmEO+16XZ7xlLUTqfnZEvdPbupwwJL6h1U6HoqT85SvLFdcseojd0+O55AW7hz2VHzZH8yPFH+/JAB3cx8sc94C3Px7Apk+9Kad/auVLfje3qlNksuvy8IzZeVa2Yq1KYa3RGad6d58BEQXJav2YV3rVw+VFqNDxfvcJwr9XRJeBFYpSsOgMc9n5CE/sq7XsDpVu9lm4WHvRLgHZWsi8sNG57XMlD8Z92rQwdHTB9M4kpGHv2ZJ8K9V64k0CRzNpRFY8um3rQIEHDOhDc12VWyRXdCrsLysuzn90+Ivz1YIiVzPLZ/gGPd8sMUIhDM5i6lymP5QmOvaBzpn+VPXXgnTkcQZsCNR9+gvqfLh+p5s2wZ+siiEQ31O53aSrFLd9alojulK6HBf/x0J0dh6+eGNhW4KcXfa2rhe7l5/n8tv4A7tB+DWmm5nCuRkvRXXQGAWtbCxjemhQhZIfOObeiZJBcQurmduUEfKhZTqnY+PKY7CVZlU3d2ULgToQHJNzvnOACnBMiZfoXvezup63+oJvcSXTezhqXAJovCD/NoGn6Iv6xSmafTrSirnNOzwYg8pG8Y=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(396003)(346002)(366004)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(66556008)(41300700001)(66446008)(110136005)(66476007)(2906002)(76116006)(316002)(66946007)(64756008)(54906003)(966005)(478600001)(71200400001)(86362001)(7416002)(5660300002)(52536014)(8936002)(4326008)(38070700009)(8676002)(55016003)(122000001)(82960400001)(83380400001)(66574015)(26005)(7696005)(6506007)(53546011)(33656002)(38100700002)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cjduakFsUWEvV0dVTWRyUWdLU1h5S3hTYkN2aTdXR0NDTFpDOHh2dmZRQzNw?=
 =?utf-8?B?SFRzRHg0T3pzSUZIYzU4dEhEL1hFRGN1bzBQZlFBNHFzZThwb0g3dzVQaHNh?=
 =?utf-8?B?WDA2NjQ1R1M0T0ZDcFdvLzlKNGRkNkhwVFhEeEtiNWY1TlhCYzlTU21sRWM0?=
 =?utf-8?B?T2M0Vk9BL0c2dVd2QkJKZXZDMWNyTWtKbmxHeVNnTWxGangvaDRPY2J1ZmdW?=
 =?utf-8?B?OVBNTDQrZGFaWGhnZGV3TUNoVlF6NGpvVGJ5WHdGdEVBMDNHY1NzVnY0VGEw?=
 =?utf-8?B?UXlmYno5c244SG14Tk1tcFc5eGRMMWQxN1pYUHZyYzU5QW5qRFUvSjNPT3Z6?=
 =?utf-8?B?K2NyZDlWdmlNUjhjRHd4RmVIZ2hyKzJxa2hiN25ERHNxSU4yVWZlZWFDcklE?=
 =?utf-8?B?bWJiUWxIdDVYZnhGTE8wZlBpa29KMys1bVBtWVpjdytSQXdxSVhTcFpva203?=
 =?utf-8?B?ZWttYnA1RnVqWDgxSFBCbC84QmxPY0ttUnlJOGlzTGRFSUpvSTZGaThxYWpS?=
 =?utf-8?B?VVREck5MeTBOTDlLeVdUZktsT01jR2NzNXJ0QnFyWlpWbVUyWGZ3aWMzbGNt?=
 =?utf-8?B?cVR0Z1J0b3BUVUdRTEJsbjJqTUxtZnd0REdSVUY5cXg3WU9VbzkxMjZ1bVNG?=
 =?utf-8?B?RWNMZC9LN2FPNEFJTWV6Vk9QVC9aTDQrSnZydVZUZmlNLy9Mdk5wczJic2Ry?=
 =?utf-8?B?UVdYTmQxSUhrNHFCaDA4UGk5S3JQYU5XSm5oNzNzenBLMk9sMllsR2VtR3pX?=
 =?utf-8?B?QWp6OGFJaHlKM3EvM2g5MnErMGg1b3hWQjhhd25uU2ZmS01EVGhBUEJtUDA2?=
 =?utf-8?B?NW9vWWJ3Z3Zvc0tsWUJIZTRRc2w1SUs2U1hNVFFWQk9pYnAxVHhIRGV6WlZa?=
 =?utf-8?B?WS9GSENJNEhhVmwrdHRZYlJnZmRoWlBpL3F0Vzlaay9KS3kyaHZTd0hJM2U5?=
 =?utf-8?B?WkkzTlYvQm5Oc2tzRXhjM0Rqc3hGS0hjKzNKYTQzRWl1Wnh6V25DaEFPemRi?=
 =?utf-8?B?MUQxYko0L2FwMGlJUU1QTmtnL0hYUlF3VFNGWllqelhrdGQ1SzZRK2RQZkRH?=
 =?utf-8?B?TXoyREtRYjUrY1FoaThNc29kWDgvVkNCeDNWeTZOMnIvZmlnZkxCdUFmRkJv?=
 =?utf-8?B?ZVY0Z0Z1bTRaNW9DeUlzeFZFMVdCWFU3Tkw5MzFkR3loTzRuUnNsNUZNbE9l?=
 =?utf-8?B?b2RqTXd4RzU2aTBuMjZSaklvRlI3YWhiK3BpZnppMnhUNjNZU0VXY1l3Zi81?=
 =?utf-8?B?anVrQmR1RVVaTHVmNEJTYlE2SG5WOERQanhCVVk1Z2cySXNoL0hSWWF2ZzJF?=
 =?utf-8?B?MWQrTUF4MkR1MU5XUzN0Q281d3hoKzdKNGFGL2h2V25JRnNSY2piNDdHZDgr?=
 =?utf-8?B?MVZVeG1jVXJCc3E1MXNlZlRGQjdJNElQVnpjVWVkVWFNOWd2RTlQOGQrcjV4?=
 =?utf-8?B?TkF5ejVMZ0tFYVpDaEVPNEs5Zk5VRmVYYTQ3NkZBMllzRDliNTBGSSs0ZjBO?=
 =?utf-8?B?NVZKOVN0OXVJMUNJeVpOR0RBa0VhdmVMdUhGZXZ0clI3Z0xmVVY0T1N5WjlK?=
 =?utf-8?B?L2RsRGtYNjY2dEU2cUpBMHROM2xPU3g0K0Z2WUVSakNKZkgwZGd5R0lYRENP?=
 =?utf-8?B?Y05ROHoyTForUDh0Qk9EYm8xMmR2RG9oWFQ5aitSTG1oVkRGRmx3S2JGS3Jk?=
 =?utf-8?B?Zmh3VU8rSUVhTWRuS0FUTnRqYU9FMXFZbXJVZEE1LzlGQTlJZ2hjdGlyUlcw?=
 =?utf-8?B?MkV2QTM4YzBzT2lHdlVIMHlVRzlTRDY0YllicnFySUx0eEhJVUx0TkszZjNo?=
 =?utf-8?B?OFRMY2hsOEhxZ0FjREpCbEpzVHVVbjFYaThsS2U5QU5OQS9wSEZveUl6bWZX?=
 =?utf-8?B?a0JQUUp6YkVmSTRudDJUVFo3ODR3b3ZMTU4rV0IraDgzNkJpN0xXWWFYZFp0?=
 =?utf-8?B?ZzZxSHI4aVNKWnczVnMzdEZ1anJ5UFhUQ0crQWc2YjVtTktMclpvUkV3aTBt?=
 =?utf-8?B?cWZOL2tSdXVkSUVzM3pYUlFxVmFkblR0cTc4NjNmbGZPOVR2Z0dsclBFVkpV?=
 =?utf-8?B?c29hNDl4K25lQUV2YmJaOTJQZ2FLa2hiSmVaQ1M2Ti9nbHl3QzN4YjFtZENU?=
 =?utf-8?Q?YH+0Mza54gAb/rb6l5O5JNCfU?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c67cac7-9f6c-49d6-2500-08dbe0211f18
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 06:08:26.3181 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BcFikFCVO7rt+JeRzjqVE248+Z3OlVul5OjImvoBkGsZnkw+7Bn6qlIaBdTfDHlKLROtHKrRBFcKZMgCVS5EDBwPN0hMUhg5WS8kJE3fLcI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7658
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.9;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA3LCAyMDIzIDEwOjM3
IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2NCAyNS80MV0gQWRkIGlvbW11ZmQgY29uZmlndXJl
IG9wdGlvbg0KPg0KPk9uIDExLzcvMjMgMTQ6MTQsIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0K
Pj4gT24gMTEvMi8yMyAwODoxMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+Pj4gVGhpcyBhZGRz
ICItLWVuYWJsZS1pb21tdWZkLy0tZGlzYWJsZS1pb21tdWZkIiB0byBlbmFibGUgb3IgZGlzYWJs
ZQ0KPj4+IGlvbW11ZmQgc3VwcG9ydCwgZW5hYmxlZCBieSBkZWZhdWx0Lg0KPj4NCj4+IEkgZG9u
J3QgdGhpbmsgYSBjb25maWd1cmUgb3B0aW9uIGlzIHRoZSByaWdodCBhcHByb2FjaC4gSSB3aWxs
DQo+PiBjb21tZW50IG90aGVyIHBhdGNoZXMgdG8gcHJvcG9zZSBhbm90aGVyIHNvbHV0aW9uIHJl
bHlpbmcgb24NCj4+IEtjb25maWcgYW5kIGFjdGl2YXRpbmcgSU9NTVVGRCBmb3IgYWFyY2g2NCwg
czM5MHgsIHg4Nl82NCBvbmx5Lg0KPg0KPkhlcmUgaXMgYW4gZXhhbXBsZSBvbiB5b3VyIHNlcmll
cyA6DQo+DQo+ICAgaHR0cHM6Ly9naXRodWIuY29tL2xlZ29hdGVyL3FlbXUvY29tbWl0cy92Zmlv
LTguMg0KPg0KPlRoZSBiYWNrZW5kIGlzIGFsd2F5cyBjb21waWxlZCAoc2luY2UgaXQgaXMgY29t
bW9uKSBidXQgdGhlIFZGSU8gZnJvbnRlbmQNCj5hbmQgdGhlICdpb21tdWZkJyBvYmplY3QgYXJl
IG9ubHkgYXZhaWxhYmxlIG9uIHg4Nl82NCwgYXJtLCBzMzkweC4NCg0KSXQgbG9va3MgbGlrZSBp
b21tdWZkIGJhY2tlbmQgaXMgY29tcGlsZWQgb25seSBmb3IgeDg2XzY0LCBhcm0gb3IgczM5MHgs
DQp0aGlzIG1ha2VzIHNlbnNlIGZvciBtZSwgYXMgSSB0aGluayBvbiBvdGhlciBwbGF0Zm9ybSB3
aGljaCBkb2Vzbid0DQpzdXBwb3J0IGlvbW11ZmQsIG5vIG5lZWQgdG8gY29tcGlsZSB1c2VsZXNz
IGlvbW11ZmQgYmFja2VuZCBpbi4NCg0KPg0KPkxvb2tzIGxpa2UgYSBnb29kIGNvbXByb21pc2Uu
IFBsZWFzZSB0ZWxsIG1lIHdoYXQgeW91IHRoaW5rIGFib3V0IGl0Lg0KDQpZZXMsIHRoaXMgbG9v
a3MgYmV0dGVyIGZvciBtZSwgSSdsbCBpbmNsdWRlIHlvdXIgY2hhbmdlIGluIHY1Lg0KDQpUaGFu
a3MNClpoZW56aG9uZw0K

