Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CB673F0E8
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 04:39:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDybl-0000MY-3x; Mon, 26 Jun 2023 22:39:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDybh-0000ME-Oz
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:39:05 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qDybf-0007C2-D7
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 22:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687833543; x=1719369543;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=7T67qRmR26HpNoHrzYN7WmCdM0OpsRklCxuLog4edL0=;
 b=iwAZ83DMsta+FmSH35JIE+5UmH+CVOQBMJ1R+0MyiRpYEh/9BvP7Kh7J
 Kk+pCFvSm4qTgJ7TB51LxK6RG5fQaSx6vWcZ+39qfKgPd6gx1jD688Y2N
 EumIKdWlTrZucOMfRrpQSdHymu+VzHfcUvhzb2zjcAzDWlVt19jST5c1C
 KtKG0VL4b3zogSVe2XN2961V+Si52PYL362eRgU8naMrFMoaCg85V0gJS
 bHf8RP7WewI1ln8uiH8Qh4i/rQ+zDFID0CxBcyN8sd0jh7r3A7rv2OJ5P
 1fkpQY9zt0Vbu+rC22mLP2lpdbLnSreI6HZffd7L0PBTl4cy8M7MZgx4A A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="341792727"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="341792727"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Jun 2023 19:39:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10753"; a="719606550"
X-IronPort-AV: E=Sophos;i="6.01,161,1684825200"; d="scan'208";a="719606550"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga007.fm.intel.com with ESMTP; 26 Jun 2023 19:39:00 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 26 Jun 2023 19:38:59 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 26 Jun 2023 19:38:59 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 26 Jun 2023 19:38:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GfCqARDxk/dJhhbHzWraR5aDHDwf+C1pImgWoJfrLj1XlIvUJl6DUSHa5tKWRCBoRRwX1X3jeR24qdYfr5v2R/JTTCozRYIKLXOA3ic5EoZXuOJcCHSzfLNw9Z+xiQ/DW9uRYwgVEBhi1Q7kgIVZQtZx2XNrnTxIeoKrFgtuUWboh8vjDx2YKRhMErSpLTJWHHcicVSQlCnmhHS7QuudQ4f64PnGXPzzDquLTbm5zavIEieL3gYb9Q+TfyXC1LUa5dqF5KvVJlT6+5+YAolIEvhXAfBK1ZUnkFFAXHvFpu3vUvVlV3KqpGkBtq3oaOblS4YhZloj54pmL+P7GoWHxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T67qRmR26HpNoHrzYN7WmCdM0OpsRklCxuLog4edL0=;
 b=E8pEWdrwfOvh+z6QLhm0+NQnU/YHyepiWfM7bQ6MbH4nook/N+xJ5lPO2dZWPsseXwFP0sEr+GlswPiGL2wX8Hss1cz60lVGrcEa3Y14YypggY6Vw7rchFUaId1fIViG0VUpXfRQjTNnsqaB9LWB7mmebRldndVDZ1CbetaBI5VBsKRD1eqrXQch1xbsPTBtzHOQ/NjammSCUWilgWPMoxciP/T/AV+h2GCgwW3NaVUJFsvvrNeJ76HZ85wfoiufrwWNIPIthTNzhZt8UBFWaWkzYAVeSorH7lJX3IIQdFapFKZiyDnci+Ke//dJdPqbX6YbsmnLe+vmaPoIYJlO+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MW4PR11MB6957.namprd11.prod.outlook.com (2603:10b6:303:22a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Tue, 27 Jun
 2023 02:38:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6521.024; Tue, 27 Jun 2023
 02:38:57 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "avihaih@nvidia.com" <avihaih@nvidia.com>, "Peng,
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Topic: [PATCH v3 1/3] vfio/pci: Fix resource leak in vfio_realize
Thread-Index: AQHZpBh99h+ohEs6RE+cMJ5+wAFWM6+VGTEAgAXtPLCAAaJjAIAAOw4AgAACDMA=
Date: Tue, 27 Jun 2023 02:38:56 +0000
Message-ID: <SJ0PR11MB6744DB25CF81FF634B82FF7A9227A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230621080204.420723-1-zhenzhong.duan@intel.com>
 <20230621080204.420723-2-zhenzhong.duan@intel.com>
 <88aa1fc0-edf4-a98e-0cbb-fcf312b3b19e@oracle.com>
 <SJ0PR11MB67441D1922E854785F2FED3D9221A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <SJ0PR11MB6744837FBCEAB1F9060BBAFD9226A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7e1567f1-aa79-cbeb-3c1a-20594f1942cd@oracle.com>
In-Reply-To: <7e1567f1-aa79-cbeb-3c1a-20594f1942cd@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MW4PR11MB6957:EE_
x-ms-office365-filtering-correlation-id: 6c54d562-0b46-4470-85a5-08db76b7a7c7
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0uAGcrdFD7GePbt7cTx6cayvTqgjoLa+jZQ+RBc9G74bhJ2lM5nbQ5RvyAAJXW3KkRBN70/cI2TDXMAvSZheM/rXN/OzTS4841ExMbMI10bDsshxb2ejbhRbm3fHm0zw7TvWKDz6eqfJ0y9vZAcuU6iVEfJHms46KNRcBQ2+CxpnTDU13uJXiPZnY0mHj8MVTRWIxDC6Xrr8pckJ1MWSOqyIYAdDH3kvrCydyNl/TZjRzb80Y9dkZoI7AmOmcs3NkLDovxxqOU9ZUAAhY/PBjIGLRAnKVJgy+OtJOGZpg9YSvEaWK3eRYEjYKEXeOEVJ9T4FD0WrlAUUhfz9Jt+yDHPjwcNC2o/BCxcV2zWUbE0ep4Ngdj3nnqJriOiu0Ue9HKSTZQgupIYyjXpFf6HxnK+B4ND2WWcTdct8lQ66+wSjBs43o4ScKprL9fcx7TnE0shFn++hHGPyVlFOd21GV9eG0RU6inY/k9WGQtR0VIUQcPXxVGG+vYNVxzoei+TSCSkae/vtUByTXUDWBhpMyc2Te51pfME28Jnu74X7fqjLz9b20xxMdRNgxfEo71bNAWwAJuCKgtgFPZHaTP2NLreZoXP4Fo3BkKHUh/sFtfEA18JxvwtgLWc1l3yJD2+1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(396003)(136003)(376002)(366004)(346002)(451199021)(5660300002)(52536014)(66556008)(4326008)(66446008)(64756008)(66946007)(33656002)(66476007)(6916009)(478600001)(316002)(76116006)(8676002)(8936002)(2906002)(55016003)(54906003)(6506007)(38070700005)(86362001)(41300700001)(7696005)(9686003)(186003)(53546011)(26005)(38100700002)(71200400001)(122000001)(107886003)(83380400001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dnZUenRMMk1UZFcwM0NJbW1walJ0ck5xeWN0Yld3QnZZMk03NnVSRGYwQ3Iy?=
 =?utf-8?B?L2Qwb2lFTWV0QzJxSUhQT2F3RUFnSVUrcmdsd2tHTTZrVkR2cEtPeUJNNzdB?=
 =?utf-8?B?SW4wRWxQVi9KQXFNVTB0L2FlcGVVUllkUE5reHBFbk5hUVBOOXVNUVRISm54?=
 =?utf-8?B?eEFRWXpvekF5a2ZGVlFEcTA3NG9WZUFTNXVhQmZQNWx2RTJ0dW5OWUtiQnpw?=
 =?utf-8?B?ajNodmRjcDdlTEJwam9kNXFFM3Fpait2UCtUUXBVNGhvdzBnNFd1TklKaUhp?=
 =?utf-8?B?bXQwTCtjb1BMTTduNmRjMGh1R0JZYlJNckw2dHhLZTZkMW5pTTVwQ2dod3VV?=
 =?utf-8?B?VkpqSWtGMDlod3RZcTZWajk5ZWpwQW5WaUNQRXVMVVlVWHd4S3dxZ1hxRFR0?=
 =?utf-8?B?NG5DY09EenVQbEpYR0ZXMm40OGFPeUtzZ2c2U0ozdFkvYTJOM3RwNW1henpT?=
 =?utf-8?B?N2pvdFQwdC95bGtqTUg4YXlmUlRaVEdHUFpwQ3oxSy9sTDQxMWZsRVZ3WGNL?=
 =?utf-8?B?cHZqeEt3azE1RGJaZTUxTDUvemNXOG1pV282MC9seGZSVXVhdkxpSThwYmsr?=
 =?utf-8?B?aDZ1QkI1M3lYUUc0aEZ4WTVhekdUWnkrbEVnb1FMY29VRy9Ncy9iSjJnTGt5?=
 =?utf-8?B?b2N6WWlSTC9oSDRMQm4yMERrdVRhU3REa0MxU2d0OFFyMDBGaU91Mmp3Nno3?=
 =?utf-8?B?VThQTjJhWVlpdWJGcUJSTXBlUjR1dHdWSEJCWHpYbGp5SVlvQ2Myem1sOXVm?=
 =?utf-8?B?b1AyeFA3WXBTaFZENERuaHVySEM4bUkwM2RmUGUzUnhsVXRZL3pnRldRczJ2?=
 =?utf-8?B?ZnNsK0FQd3YxcVVwMnB1WkVqU2xGTXQwSWJoYlZUOGJJSnYvWG9hczJ0Njhm?=
 =?utf-8?B?UzZQWVJRQWpOcjQxK0ExSENHeHVCUlkzRWJyWTVVektadXptV0tzenNUYjBh?=
 =?utf-8?B?S3FWREN1V1hEMDJ4b1l2dTZ6b2hXYzk3SU1QamNaMXR4bXlIV05qYklNeDBC?=
 =?utf-8?B?Q1JneXdUWCtzZHBkcDBBN29XWEEzd1Y4eU42bnVrUzhtWjVHMFhyN05tc0RE?=
 =?utf-8?B?cld3MWt0RHgzQzFnVHZVSEt5dHh5VmpxTk5jSnMyNjBGc0tiSUdaazNkU2JL?=
 =?utf-8?B?Zm5Ua2xCWmlSNVRidm5ySUpYMFBLRWxsRkY4V08zWUJRdWo3S1Vuc2pWbGFL?=
 =?utf-8?B?bTlJK1AyM1l4SjVtcGVqWGhlQzhQblA0QklSS2Rnem1Zc3l2TmE2Z3RFNGdq?=
 =?utf-8?B?TVNSMWs3YzBZTmN6VFduNXNiRlRvUGEyek80YksveWd3Z1htZDgyZ2tkcHdI?=
 =?utf-8?B?K1dWSERjWVBvRjArais2YlNZVTlIcER0SWdkeTFaUkZXMzVDcEpHQXRJaldR?=
 =?utf-8?B?bFE2TXY0Um93dW1aTEt6L3RtZmhiMTRmdjZmaVkyd0l0VldSU1JqTFAvK3kw?=
 =?utf-8?B?UktKSld3bWpyQksvU0xYUlBRYjM0emdDS2xCaVBBUjRZVW9rUHFzd2lBQzRT?=
 =?utf-8?B?RHRybEh0ckYveXEzUGJXdHJrNFFsbjJqSHBNUW1JcXFhR2VDLzEyMk04TTBF?=
 =?utf-8?B?UDFyWDd5V1ZHMGV0ZU9jdXMzZ1RUVzNMV3NEQ0JIa2VHZ0VIdE5KczNSTDk4?=
 =?utf-8?B?eXA5L2pyZGMvNXJrQm1nS2dGUnZMdWI4N3hkMVF6ZUp5WXFTV0d1aFJFRDA2?=
 =?utf-8?B?aFEyQy9wRFJjUFFZNHhaR1dGUUR2L1BFOFpJZ3ZHODNFSGNLWW1vMmhzd1Jh?=
 =?utf-8?B?TVNUblRCZUlKSy9CbnFUNnBuL3pSN28zREtPSDl6enVGZU56NGg4SDFBeE9l?=
 =?utf-8?B?SktJWWpNbHJ3Z1BWb3hzL1NwVXB1WmFnWFh3bUNON2hRREZyOGg0VXFLd0t1?=
 =?utf-8?B?b2c5UExheTVjKzJWdFdGd0RxMFRKOEh4L0R3c1FNZHBsNnNDc0tZMXowanhE?=
 =?utf-8?B?NC9ScFY1Kys2QXdWMStWaUY1VER5Y1ZtcjViN1RKODg5TjdZTnR1V1VNb1ZV?=
 =?utf-8?B?SE5TekYvWjNDL28rRjdMSkQzRXkzNGxmcU5SV3pidG5TSG5UdlFQWm9Sa010?=
 =?utf-8?B?UVpKL3ZGS2gyNHJudTdCMkJwU1FNWmJBQlFVRFdLOW1LNWx3dkhXeTlSa3hs?=
 =?utf-8?Q?YWop1fidCo/XuKWkFj0cdBAqS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c54d562-0b46-4470-85a5-08db76b7a7c7
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2023 02:38:56.8843 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fRefIdkmTfstZFr1gqBNHCij5FO77oBuamuenmnyxJmu7/4HIF1xO+x+3B1mF+wc6CMdr335FHw5Q2pPGpxexwQxvGiaBGf+mBKwp+m6//M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6957
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
 envelope-from=zhenzhong.duan@intel.com; helo=mga17.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IE1vbmRheSwgSnVuZSAyNiwgMjAyMyA2OjA4IFBN
DQo+VG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNjOiBh
bGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207IHFlbXUtZGV2ZWxAbm9u
Z251Lm9yZzsNCj5hdmloYWloQG52aWRpYS5jb207IFBlbmcsIENoYW8gUCA8Y2hhby5wLnBlbmdA
aW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgMS8zXSB2ZmlvL3BjaTogRml4IHJl
c291cmNlIGxlYWsgaW4gdmZpb19yZWFsaXplDQo+DQo+T24gMjYvMDYvMjAyMyAwODowMiwgRHVh
biwgWmhlbnpob25nIHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4g
RnJvbTogRHVhbiwgWmhlbnpob25nDQo+Pj4gU2VudDogU3VuZGF5LCBKdW5lIDI1LCAyMDIzIDI6
MDEgUE0NCj4+PiBUbzogSm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0K
Pj4+IENjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsgY2xnQHJlZGhhdC5jb207DQo+Pj4g
cWVtdS1kZXZlbEBub25nbnUub3JnOyBhdmloYWloQG52aWRpYS5jb207IFBlbmcsIENoYW8gUA0K
Pj4+IDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+Pj4gU3ViamVjdDogUkU6IFtQQVRDSCB2MyAx
LzNdIHZmaW8vcGNpOiBGaXggcmVzb3VyY2UgbGVhayBpbg0KPj4+IHZmaW9fcmVhbGl6ZQ0KPj4+
DQo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZyb206IEpvYW8gTWFydGlu
cyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+Pj4gU2VudDogV2VkbmVzZGF5LCBKdW5l
IDIxLCAyMDIzIDc6MDggUE0NCj4+Pj4gVG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1
YW5AaW50ZWwuY29tPg0KPj4+PiBDYzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNsZ0By
ZWRoYXQuY29tOyBxZW11LQ0KPj4+IGRldmVsQG5vbmdudS5vcmc7DQo+Pj4+IGF2aWhhaWhAbnZp
ZGlhLmNvbTsgUGVuZywgQ2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+Pj4+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggdjMgMS8zXSB2ZmlvL3BjaTogRml4IHJlc291cmNlIGxlYWsgaW4NCj4+
Pj4gdmZpb19yZWFsaXplDQo+Pj4+DQo+Pj4+DQo+Pj4+DQo+Pj4+IE9uIDIxLzA2LzIwMjMgMDk6
MDIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4+Pj4gV2hlbiBhZGRpbmcgbWlncmF0aW9uIGJs
b2NrZXIgZmFpbGVkIGluIHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSwNCj4+Pj4+IGhvdHBsdWcg
d2lsbCBmYWlsIGFuZCB3ZSBzZWUgYmVsb3c6DQo+Pj4+Pg0KPj4+Pj4gKHFlbXUpIGRldmljZV9h
ZGQNCj4+Pj4+IHZmaW8tcGNpLGhvc3Q9ODE6MTEuMSxpZD12ZmlvMSxidXM9cm9vdDEseC1lbmFi
bGUtbWlncmF0aW9uPXRydWUNCj4+Pj4+IDAwMDA6ODE6MTEuMTogVkZJTyBtaWdyYXRpb24gaXMg
bm90IHN1cHBvcnRlZCBpbiBrZXJuZWwNCj4+Pj4+IEVycm9yOiBkaXNhbGxvd2luZyBtaWdyYXRp
b24gYmxvY2tlciAoLS1vbmx5LW1pZ3JhdGFibGUpIGZvcjogVkZJTw0KPj4+Pj4gZGV2aWNlIGRv
ZXNuJ3Qgc3VwcG9ydCBtaWdyYXRpb24NCj4+Pj4+DQo+Pj4+PiBJZiB3ZSBob3RwbHVnIGFnYWlu
IHdlIHNob3VsZCBzZWUgc2FtZSBsb2cgYXMgYWJvdmUsIGJ1dCB3ZSBzZWU6DQo+Pj4+PiAocWVt
dSkgZGV2aWNlX2FkZA0KPj4+Pj4gdmZpby1wY2ksaG9zdD04MToxMS4wLGlkPXZmaW8wLGJ1cz1y
b290MCx4LWVuYWJsZS1taWdyYXRpb249dHJ1ZQ0KPj4+Pj4gRXJyb3I6IHZmaW8gMDAwMDo4MTox
MS4wOiBkZXZpY2UgaXMgYWxyZWFkeSBhdHRhY2hlZA0KPj4+Pj4NCj4+Pj4+IFRoYXQncyBiZWNh
dXNlIHNvbWUgcmVmZXJlbmNlcyB0byBWRklPIGRldmljZSBpc24ndCByZWxlYXNlZCwgd2UNCj4+
Pj4+IHNob3VsZCBjaGVjayByZXR1cm4gdmFsdWUgb2YgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgp
IGFuZCByZWxlYXNlDQo+Pj4+PiB0aGUgcmVmZXJlbmNlcywgdGhlbiBWRklPIGRldmljZSB3aWxs
IGJlIHRydWVseSByZWxlYXNlZCB3aGVuDQo+Pj4+PiBob3RwbHVnIGZhaWxlZC4NCj4+Pj4+DQo+
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwu
Y29tPg0KPj4+Pj4gLS0tDQo+Pj4+PiAgaHcvdmZpby9wY2kuYyB8IDEgKw0KPj4+Pj4gIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQ0KPj4+Pj4NCj4+Pj4+IGRpZmYgLS1naXQgYS9ody92
ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYyBpbmRleA0KPj4+Pj4gNzM4NzRhOTRkZTEyLi5jNzFi
MDk1NWQ4MWMgMTAwNjQ0DQo+Pj4+PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+Pj4+PiArKysgYi9o
dy92ZmlvL3BjaS5jDQo+Pj4+PiBAQCAtMzIxMCw2ICszMjEwLDcgQEAgc3RhdGljIHZvaWQgdmZp
b19yZWFsaXplKFBDSURldmljZSAqcGRldiwNCj4+Pj4+IEVycm9yDQo+Pj4+ICoqZXJycCkNCj4+
Pj4+ICAgICAgICAgIHJldCA9IHZmaW9fbWlncmF0aW9uX3JlYWxpemUodmJhc2VkZXYsIGVycnAp
Ow0KPj4+Pj4gICAgICAgICAgaWYgKHJldCkgew0KPj4+Pj4gICAgICAgICAgICAgIGVycm9yX3Jl
cG9ydCgiJXM6IE1pZ3JhdGlvbiBkaXNhYmxlZCIsDQo+Pj4+PiB2YmFzZWRldi0+bmFtZSk7DQo+
Pj4+PiArICAgICAgICAgICAgZ290byBvdXRfZGVyZWdpc3RlcjsNCj4+Pj4+ICAgICAgICAgIH0N
Cj4+Pj4+ICAgICAgfQ0KPj4+Pj4NCj4+Pj4gVGhpcyBkb2Vzbid0IGxvb2sgcmlnaHQuIFRoaXMg
bWVhbnMgdGhhdCBmYWlsdXJlIHRvIHN1cHBvcnQNCj4+Pj4gbWlncmF0aW9uIHdpbGwgZGVyZWdp
c3RlciB0aGUgZGV2aWNlLg0KPj4+DQo+Pj4gSW4gbXkgdW5kZXJzdGFuZGluZywgZmFpbHVyZSB0
byBzdXBwb3J0IG1pZ3JhdGlvbiBidXQgc3VjY2VzcyB0byBhZGQNCj4+PiBtaWdyYXRpb24gYmxv
Y2tlciB3aWxsIG5vdCBkZXJlZ2lzdGVyIGRldmljZS4NCj4+PiB2ZmlvX21pZ3JhdGlvbl9yZWFs
aXplKCkgaXMgc3VjY2Vzc2Z1bCBpbiB0aGlzIGNhc2UuDQo+Pj4gQnV0IGZhaWx1cmUgdG8gYWRk
IG1pZ3JhdGlvbiBibG9ja2VyIHNob3VsZCBkZXJlZ2lzdGVyIGRldmljZSwNCj4+PiBiZWNhdXNl
DQo+Pj4gdmZpb19leGl0Zm4oKSBpcyBuZXZlciBjYWxsZWQgaW4gdGhpcyBjYXNlKGVycnAgc2V0
KSwganVtcGluZyB0bw0KPj4+IG91dF9kZXJlZ2lzdGVyIGlzIHRoZSBiZXN0IGNob2ljZS4gVGhl
biB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkNCj4+PiBzaG91bGQgcmV0dXJuIGZhaWx1cmUgaW4g
dGhpcyBjYXNlLg0KPj4NCj4NCj5JIHdhcyBjaGVja2luZyBvdGhlciBkZXZpY2VzIGluIHRoZSB0
cmVlLCBhbmQgSSB0aGluayB5b3UgYXJlIHJpZ2h0LiBGYWlsdXJlIHRvDQo+YWRkIHRoZSBtaWdy
YXRpb24gYmxvY2tlciByZXN1bHRzIGluIGEgZmFpbHVyZSBvZiBkZXZpY2UgcmVhbGl6ZS4gV2hp
Y2ggSUlVQyBvbmx5DQo+aGFwcGVucyBpbiAnb25seS1taWdyYXRhYmxlJyBzZXR1cHMgYW5kIGR1
cmluZyBzbmFwc2hvdHMuDQpZZXMuDQoNCj4NCj5NYXliZSBhbHNvIGluY2x1ZGluZyBhIHNlbnRl
bmNlIGV4cGxhaW5lciBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgaXMgdXNlZnVsDQo+dG9vLg0KU3Vy
ZSwgd2lsbCBkby4NCg0KPg0KPj4gSSBqdXN0IHJlYWxpemVkIHRoZSBlcnJvciBwYXRoIGluIHZm
aW9fcmVhbGl6ZSgpIGlzbid0IGFkZXF1YXRlLiBXZSBuZWVkIHRvIGFkZA0KPm1vcmUgZGVyZWdp
c3RlciBjb2RlIGp1c3QgYXMgdmZpb19leGl0Zm4oKSwgc2VlIGJlbG93LiBJJ2xsIHJlLXBvc3Qg
YWZ0ZXIgd2UgYXJlDQo+Y29uc2Vuc3VzIG9uIHRoaXMgYW5kIGdldCBzb21lIGNvbW1lbnRzIG9m
IFBBVENIMy4NCj4+DQo+PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+PiArKysgYi9ody92ZmlvL3Bj
aS5jDQo+PiBAQCAtMzIxMCw3ICszMjEwLDcgQEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBD
SURldmljZSAqcGRldiwgRXJyb3INCj4qKmVycnApDQo+PiAgICAgICAgICByZXQgPSB2ZmlvX21p
Z3JhdGlvbl9yZWFsaXplKHZiYXNlZGV2LCBlcnJwKTsNCj4+ICAgICAgICAgIGlmIChyZXQpIHsN
Cj4+ICAgICAgICAgICAgICBlcnJvcl9yZXBvcnQoIiVzOiBNaWdyYXRpb24gZGlzYWJsZWQiLCB2
YmFzZWRldi0+bmFtZSk7DQo+PiAtICAgICAgICAgICAgZ290byBvdXRfZGVyZWdpc3RlcjsNCj4+
ICsgICAgICAgICAgICBnb3RvIG91dF92ZmlvX21pZ3JhdGlvbjsNCj4+ICAgICAgICAgIH0NCj4+
ICAgICAgfQ0KPj4NCj4+IEBAIC0zMjIwLDExICszMjIwLDE3IEBAIHN0YXRpYyB2b2lkIHZmaW9f
cmVhbGl6ZShQQ0lEZXZpY2UgKnBkZXYsDQo+PiBFcnJvciAqKmVycnApDQo+Pg0KPj4gICAgICBy
ZXR1cm47DQo+Pg0KPj4gK291dF92ZmlvX21pZ3JhdGlvbjoNCj4+ICsgICAgdmZpb19taWdyYXRp
b25fZXhpdCh2YmFzZWRldik7DQo+DQo+VGhpcyBiZWxvbmdzIGluIHRoaXMgcGF0Y2ggZnJvbSB0
aGUgbG9va3MNClllcywgSSBwbGFuIHRvIG1lcmdlIGFib3ZlIGNoYW5nZSB0byB0aGlzIHBhdGNo
Lg0KDQo+DQo+PiAgb3V0X2RlcmVnaXN0ZXI6DQo+PiAgICAgIHBjaV9kZXZpY2Vfc2V0X2ludHhf
cm91dGluZ19ub3RpZmllcigmdmRldi0+cGRldiwgTlVMTCk7DQo+PiAgICAgIGlmICh2ZGV2LT5p
cnFjaGlwX2NoYW5nZV9ub3RpZmllci5ub3RpZnkpIHsNCj4+ICAgICAgICAgIGt2bV9pcnFjaGlw
X3JlbW92ZV9jaGFuZ2Vfbm90aWZpZXIoJnZkZXYtPmlycWNoaXBfY2hhbmdlX25vdGlmaWVyKTsN
Cj4+ICAgICAgfQ0KPj4gKyAgICB2ZmlvX2Rpc2FibGVfaW50ZXJydXB0cyh2ZGV2KTsNCj4+ICsg
ICAgaWYgKHZkZXYtPmludHgubW1hcF90aW1lcikgew0KPj4gKyAgICAgICAgdGltZXJfZnJlZSh2
ZGV2LT5pbnR4Lm1tYXBfdGltZXIpOw0KPj4gKyAgICB9DQo+DQo+QnV0IHRoaXMgb25lIHN1Z2dl
c3RzIGFub3RoZXIgb25lIGFzIGl0IGxvb2tzIGEgcHJlLWV4aXN0aW5nIGlzc3VlPw0KWWVzLCBp
dCdzIGFub3RoZXIgcmVzb3VyY2UgbGVhayBJIGp1c3QgZm91bmQuDQpOb3Qgc3VyZSBpZiBpdCdz
IGJldHRlciB0byBhbHNvIG1lcmdlIGFib3ZlIGNoYW5nZSB0byB0aGlzIHBhdGNoIHdoaWNoIGlz
IHRhcmdldGluZyByZXNvdXJjZSBsZWFrIGlzc3VlcywNCm9yIHRvIFBBVENIMiB3aGljaCBpcyB0
YXJnZXRpbmcgb3V0X2RlcmVnaXN0ZXIgcGF0aCwgb3IgdG8gY3JlYXRlIGEgbmV3IG9uZS4NCkFu
eSBzdWdnZXN0aW9uPw0KDQpUaGFua3MNClpoZW56aG9uZw0K

