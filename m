Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 95A9472355B
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 04:37:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6MY9-0002ou-Sz; Mon, 05 Jun 2023 22:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q6MY8-0002oY-De
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 22:35:56 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q6MY5-0004Hj-Mi
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 22:35:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686018953; x=1717554953;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=n1Hhg+XUWKQ/3BISBL0vFpVGiVSoOqtf2/RfDdNgBYw=;
 b=ZKg3zw9GuAIXsDZHBPTkKNtRtjfm0ihk3CtCZo8uk4044Y77/EHIjnpV
 pBW+sbjyYwCKEWJtfG/yhgfmOMfo1nXQQPjfK/pZjEygnPdhUfnNusAHh
 jvt9frdnvEp5agfCQASqZw12nBG4aV7pnt2FwmzKcLqk8NzycE/fRxfO9
 e9CfOECQJi3pwyd2FEkAHoqpO+VRVUUXMwWxT5fzDMU7UexQ37Zi0/ZYf
 Ftrq8iMExQJzFyR7WamKOBqKBNK9R1aV+cOuZNEC/yBMvxoLg3Q1HjSVN
 9YhisAdSMJVvx1ehiCjLZ1b8o5teGbyk1M0aq+ld3t6QnAPJpnWclFOGw w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="336164766"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; d="scan'208";a="336164766"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Jun 2023 19:35:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10732"; a="686342712"
X-IronPort-AV: E=Sophos;i="6.00,219,1681196400"; d="scan'208";a="686342712"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga006.jf.intel.com with ESMTP; 05 Jun 2023 19:35:45 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 5 Jun 2023 19:35:45 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 5 Jun 2023 19:35:45 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.46) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 5 Jun 2023 19:35:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h+fG1YOao9LBqUQxMPYIO8pAmJYj/+LjjaqYnE4IZGQ+GCZAtsjZwXSwkWFCcNp9dGSHqNbcg+QXuUxV5RPKmpTIpb9+NuFo7FyuYpBk+az00qJ6wNXkhYarQ6IqAYkvjtysOQW/o/kHsdP1pKxzRzq+1wU1DEpZMdHwxBukIyoArZPGUUA2gabiAjEV6FaUfH5k+42hHlCYcAGrrFpvmBTEdUySDmpwka3mil2FlEAmg1SLiy7QN8Inj2n08Y9QUuF3aoclfn98sIZoIWju/DZ/u0MBvFQvu0ylh4Z1r3zw69GtNGar6nw6f2p/j5lyCSslasditm173ppj2GNsRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n1Hhg+XUWKQ/3BISBL0vFpVGiVSoOqtf2/RfDdNgBYw=;
 b=HwTIH0WMcqEpbMLvh5Xx54PbrSc88OdZ4B5T48Qku8bOVAvha42otR976wFdZst+e205crbNU4JcgbK7YkHbezAV+TfJbSMHZ3N06eclFiQGlJAXHa2BItPisidOzruD3s90kK8nwKMEOefZqOmh06zSd7iafgsH1A67XjYJbHtccDs+39F7aw4D2mdnlRw/0gMzqeO8rI0YKEpc88Axcr672GmTQVMA2v3hx3aWk1hhfZER2SMT/r6xRedqd7OGHC6dH2HgGmWI6Hp5Xg7IZpXTePZNSQJuDIbsW1m6yh+geVY8zcIEQJ6Htn+adbyrd6sVrXjO+dVpyBYiV0Pu8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB6184.namprd11.prod.outlook.com (2603:10b6:208:3c4::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.32; Tue, 6 Jun
 2023 02:35:42 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Tue, 6 Jun 2023
 02:35:42 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Peng, 
 Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Thread-Topic: [PATCH v2 2/4] intel_iommu: Fix a potential issue in VFIO dirty
 page sync
Thread-Index: AQHZlFTN28S+6rYgn0KeXmgiZMA5mq98kW8AgAB2ESA=
Date: Tue, 6 Jun 2023 02:35:41 +0000
Message-ID: <SJ0PR11MB674438D23927056A81F447DC9252A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230601063320.139308-1-zhenzhong.duan@intel.com>
 <20230601063320.139308-3-zhenzhong.duan@intel.com> <ZH4r3FCIU8uOiV8h@x1n>
In-Reply-To: <ZH4r3FCIU8uOiV8h@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB6184:EE_
x-ms-office365-filtering-correlation-id: 7fdbb855-57a8-46d6-1f48-08db6636b8d4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a3Li8XJ/CIiDP2dirwDGoFRhmS14STonnZg8Ce1OsU4Pd5YR4VPLKG0iI2E1Jo2/+xDaIkaatxbBna6VOywRAd3s8gmg6DftsRsX3VhaKlh6YbaTeWVz54cKXNPpNpjnQrMQzJ3E9+sUposHIJHmORTAwm+jzQLRGAvd4/KCSz2wD4Pnw20h5VvQh/rdTkyqUr++Qt5PfqYs8sJc2lD8kBPbRMjqypvQjmN43htDwjYdtR68p4S9BIJN3VTUIN4hE5WcpuXvW+dTrUD4UH+3LilDeGMZdft9ruEL52Z75ejdGsYmQRBWjhgQZtWUM4NseSuIcNwIPUCG2nxzn0rwmNUP/cCxaED9atO4YYN6jxgkwMY06WT+z9N63ymahh3f14eqLgG1tCCSSCuch1oZg5l0jovoY4ZQyoVl1S/seMahqj2dtUN0rwUYBHC6iSnDsd7Ot2nBJ28Hp+nTITpw3h76XUDew4W5oKEIHnBrABXp+lcUvyHgP/8MwIH6WVgnPxRTUUF9SVeglOJF4zzyugg9sFibltxVIyjC3uMshPq9BEsNDfBVFckROJ7sQ3j/Ylkfp886FeXAbk5lg8KZwnlfK0yenRWSr/ko6uJZzok0L0d93EGbE0zU6301KWFUd/KjJlgUZmpyThiFr0D5ig==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(376002)(136003)(396003)(366004)(346002)(451199021)(6506007)(26005)(9686003)(107886003)(7416002)(83380400001)(122000001)(186003)(2906002)(86362001)(33656002)(55016003)(52536014)(5660300002)(316002)(8676002)(8936002)(41300700001)(38070700005)(66476007)(66446008)(6916009)(66556008)(64756008)(76116006)(66946007)(54906003)(82960400001)(4326008)(38100700002)(478600001)(71200400001)(7696005)(14143004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUlHTVkxU2ZkKzN3ZUI4OXFpVUs0dEhJaEJhTzRLSE1scUthVFhEZUt1dnB2?=
 =?utf-8?B?TklqL0txbG5mbWNXSVFGY3p6M0xwRkl3SVVlS1NJdXdob0VmQVB1ekttRE5n?=
 =?utf-8?B?cWpIS0RTVXpTTzB0WkpJKyt5Tk8zQU1KY1hTcitkYkcwMm1hU244YkNyWFpt?=
 =?utf-8?B?WHFaY2JRSHVpUVl2UklML0lUQmV6S05VRDlzWHoxQlpnNHZKVkd3aFVWSDha?=
 =?utf-8?B?ZlhTcWxZcVV0RWtjY2d0eFJZODF1SzluT0dMR1BLSlI5QzAvRVc3eGp1cll1?=
 =?utf-8?B?TWszMmc1ZTU4bk01ZTI2cG5XQjNiQmdSeXZyM3p0ZGFTT0I4QktDMk4zemQv?=
 =?utf-8?B?ejRRTDNTektyNjhoNHVnOGQ5UTg0dzlpVTBOWllpQ0lycWVubzA1NTgzZkE0?=
 =?utf-8?B?ZlRRZkR0WjY1dTRyLytGdHRqV1V6TndDRHVheXJ0UlVKRlI0ZkMxL1plWTha?=
 =?utf-8?B?eDZvb2cyR29EVHUxRU5RY2ZpdkQ2dFZWbzNiWE5zNkZKb0hLUnphbGdKV01q?=
 =?utf-8?B?dzI0YUMyVHdHQmhuOG9rSXl2a1kzek1vOW5ZSmFaaklXYmZEbUNNeFhWWGVQ?=
 =?utf-8?B?T3hXTW5HZW5lbHBuUlYraG05OUFlZlcvSnZVeXJKOVZTdWNRRFZidVlYSWp6?=
 =?utf-8?B?dVhhNFBRUUxDdlYwenJFeGs0UGdRVkVlZHJReUlVWG0xL3ZzcVllWFlEVUJK?=
 =?utf-8?B?aGF4QzN0MVdLMW04MTlXM1FRNDFCR0xGVmJwbTAxbUVOandNOCt1VjVjM0kz?=
 =?utf-8?B?R25LZStwUUY1ZUlHeDllZEtzQnVrSEVQRWJDQWIvZnJTQUFqZzZZUzRSc1lt?=
 =?utf-8?B?WEtQNTZzYnRYMVpYS1B0Mlo5ZXB1SjRtY3B0NFMyRGkzM1RUL1VueWNMK3FZ?=
 =?utf-8?B?aXNCVEFzeWNkdnBnQ0lmSGZJVDdkMnl2WjdNalJDcWtOaUV4djc4TUtRdTcw?=
 =?utf-8?B?NFgwVjZHT2QvbGZxZkNVeDFEM01udlM0UllYWWY1QWRteFpWaERtZGxycHN5?=
 =?utf-8?B?anZYcmN1UTVaSDJGWHB2bUFhUWFZbUZwVElVYzhuZElXZFI2eG9QTGZ3ZFNC?=
 =?utf-8?B?d3R5cTlzek5RUDkzU1gvaTUzalZMRUpGVTJpSzdvMjErMVk5RElmSjhFbmVT?=
 =?utf-8?B?anRpVDFqTko5S2xWTzc5NHpQYzVaZC9JT3pyaDFGM1NlbmFjc2VyUHJ5dGYx?=
 =?utf-8?B?QkJsVFdXZFc2SSt2aE5jdzJTRm0zTmZrVk5qOTQrdWsxOG5MeFVHa09kb0xX?=
 =?utf-8?B?T0lxSVZoUytqWHdGdXZVUVhja0NRK3NSSUtWOXYvSFJrdlFvcmVWeTVZUDVO?=
 =?utf-8?B?cEZMbytqazB5M00zUzBPdGRIQk9VcmM4aG9xSGhvL1hBL2hLcE1zek1BV3JL?=
 =?utf-8?B?OTdFQjlKSWlzWmlMRk5yaUxjc2VLZFplSWJScGdJSVNyYXNkaVJPVTlhM2ow?=
 =?utf-8?B?YXRDQ3IrWlZVRk5mclVPOTFyRnlOWm9oZmNyVzdjZGlhamtBQzZLeDBuZWpx?=
 =?utf-8?B?M0tvNFdpSVc2NEI1V1Y1cThTYlQ0bEFaMWhwK0NIRlFvV2h0YnRMdndST0ZQ?=
 =?utf-8?B?SzRScEc3S2dwa1VUbktLNXkyWEI3Zy9yUWphNE5URVlXOU5jRnZsSFNaaDdU?=
 =?utf-8?B?cGNIUFZYSHFtU3dLRGNKNUFDYXNvZnlSQjBlSEl5aDBNUHl1b095a3FMa1dK?=
 =?utf-8?B?MjkwU2dEMVF2Sm5JbFJHNEoxUC9pWGJsd0JoVkdIdDZSclZiV0dmU3NvSUJn?=
 =?utf-8?B?SFhBRXNONDJ2RTRJSVI3NzRLZkZFY3UzYkJCOXlZeFhCcVZPdXVhUG9QZ01M?=
 =?utf-8?B?RjU4ZUpkTmxVa3ZtbkNIRnJYUGovTHJOd0xOUlMzdzRFTGljUzUvYjRRSktu?=
 =?utf-8?B?TThuSjNPbzM1Z1VOVGFZV3Q0NlRYQUd0d3Z0NnZ0T0pESmduN1NXQjRlM0I0?=
 =?utf-8?B?L3h4bEtsbkRWSUxsSTRSVkExOTF0bTJhendUdW1WSi9Dbk45MHlrWHRnRk50?=
 =?utf-8?B?SUJlWHJaR0s4Ti9iL3ZoN0lpVTgyaHdZV1M1Q0ZFc2xhL3ZqTUd0Q1dxc3U5?=
 =?utf-8?B?OSs3akNXVHNLZWRyRzloSUZHVng1NTlYRkk0QXI2ckREbmR3MUlvak1YM1B1?=
 =?utf-8?Q?52AHUpCpyqhZ1HByJLarhpl9b?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7fdbb855-57a8-46d6-1f48-08db6636b8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Jun 2023 02:35:41.7704 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uiTR3ma1yfMvaEfTWiSbolcEbNcIrn8EHLdsrQLpbvXm9DEFfnmFqb8brKLosMsv2MBhT6ltRgpy7ybxT48+eOnko779wZWttqHGBw6m5AM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6184
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPg0KPlNlbnQ6IFR1ZXNkYXksIEp1bmUgNiwgMjAyMyAyOjM5IEFNDQo+VG86IER1YW4s
IFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNjOiBxZW11LWRldmVsQG5v
bmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPnBib256aW5p
QHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IGVkdWFyZG9AaGFia29z
dC5uZXQ7DQo+bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb207IGFsZXgud2lsbGlhbXNvbkByZWRo
YXQuY29tOw0KPmNsZ0ByZWRoYXQuY29tOyBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGluYXJv
Lm9yZzsNCj5rd2Fua2hlZGVAbnZpZGlhLmNvbTsgY2ppYUBudmlkaWEuY29tOyBMaXUsIFlpIEwg
PHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsDQo+Q2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRlbC5j
b20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAyLzRdIGludGVsX2lvbW11OiBGaXggYSBwb3Rl
bnRpYWwgaXNzdWUgaW4gVkZJTyBkaXJ0eQ0KPnBhZ2Ugc3luYw0KPg0KPk9uIFRodSwgSnVuIDAx
LCAyMDIzIGF0IDAyOjMzOjE4UE0gKzA4MDAsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gUGV0
ZXIgWHUgZm91bmQgYSBwb3RlbnRpYWwgaXNzdWU6DQo+Pg0KPj4gIlRoZSBvdGhlciB0aGluZyBp
cyB3aGVuIEkgYW0gbG9va2luZyBhdCB0aGUgbmV3IGNvZGUgSSBmb3VuZCB0aGF0IHdlDQo+PiBh
Y3R1YWxseSBleHRlbmRlZCB0aGUgcmVwbGF5KCkgdG8gYmUgdXNlZCBhbHNvIGluIGRpcnR5IHRy
YWNraW5nIG9mIHZmaW8sDQo+PiBpbiB2ZmlvX3N5bmNfZGlydHlfYml0bWFwKCkuICBGb3IgdGhh
dCBtYXliZSBpdCdzIGFscmVhZHkgYnJva2VuIGlmDQo+PiB1bm1hcF9hbGwoKSBiZWNhdXNlIGFm
YWl1IGxvZ19zeW5jKCkgY2FuIGJlIGNhbGxlZCBpbiBtaWdyYXRpb24gdGhyZWFkDQo+PiBhbnl0
aW1lIGR1cmluZyBETUEgc28gSSB0aGluayBpdCBtZWFucyB0aGUgZGV2aWNlIGlzIHByb25lIHRv
IERNQSB3aXRoIHRoZQ0KPj4gSU9NTVUgcGd0YWJsZSBxdWlja2x5IGVyYXNlZCBhbmQgcmVidWls
dCBoZXJlLCB3aGljaCBtZWFucyB0aGUgRE1BDQo+Y291bGQNCj4+IGZhaWwgdW5leHBlY3RlZGx5
LiAgQ29weSBBbGV4LCBLaXJ0aSBhbmQgTmVvLiINCj4+DQo+PiBUbyBlbGltaW5hdGUgdGhpcyBz
bWFsbCB3aW5kb3cgd2l0aCBlbXB0eSBtYXBwaW5nLCB3ZSBzaG91bGQgcmVtb3ZlIHRoZQ0KPj4g
Y2FsbCB0byB1bm1hcF9hbGwoKS4gQmVzaWRlcyB0aGF0LCBpbnRyb2R1Y2UgYSBuZXcgbm90aWZp
ZXIgdHlwZSBjYWxsZWQNCj4+IElPTU1VX05PVElGSUVSX0ZVTExfTUFQIHRvIGdldCBmdWxsIG1h
cHBpbmdzIGFzIGludGVsX2lvbW11IG9ubHkNCj5ub3RpZmllcw0KPj4gY2hhbmdlZCBtYXBwaW5n
cyB3aGlsZSBWRklPIGRpcnR5IHBhZ2Ugc3luYyBuZWVkcyBmdWxsIG1hcHBpbmdzLiBUaGFua3MN
Cj4+IHRvIGN1cnJlbnQgaW1wbGVtZW50YXRpb24gb2YgaW92YSB0cmVlLCB3ZSBjb3VsZCBwaWNr
IG1hcHBpbmdzIGZyb20gaW92YQ0KPj4gdHJlZXMgZGlyZWN0bHkgaW5zdGVhZCBvZiB3YWxraW5n
IHRocm91Z2ggZ3Vlc3QgSU9NTVUgcGFnZSB0YWJsZS4NCj4+DQo+PiBJT01NVV9OT1RJRklFUl9N
QVAgaXMgc3RpbGwgdXNlZCB0byBnZXQgY2hhbmdlZCBtYXBwaW5ncyBmb3INCj5vcHRpbWl6YXRp
b24NCj4+IHB1cnBvc2UuIEFzIGxvbmcgYXMgbm90aWZpY2F0aW9uIGZvciBJT01NVV9OT1RJRklF
Ul9NQVAgY291bGQgZW5zdXJlDQo+c2hhZG93DQo+PiBwYWdlIHRhYmxlIGluIHN5bmMsIHRoZW4g
aXQncyBPSy4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvaTM4Ni9pbnRlbF9pb21tdS5jIHwgNDkg
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0NCj4tLQ0KPj4gIGh3L3Zm
aW8vY29tbW9uLmMgICAgICB8ICAyICstDQo+PiAgaW5jbHVkZS9leGVjL21lbW9yeS5oIHwgMTMg
KysrKysrKysrKysrDQo+PiAgc29mdG1tdS9tZW1vcnkuYyAgICAgIHwgIDQgKysrKw0KPj4gIDQg
ZmlsZXMgY2hhbmdlZCwgNTggaW5zZXJ0aW9ucygrKSwgMTAgZGVsZXRpb25zKC0pDQo+Pg0KPj4g
ZGlmZiAtLWdpdCBhL2h3L2kzODYvaW50ZWxfaW9tbXUuYyBiL2h3L2kzODYvaW50ZWxfaW9tbXUu
Yw0KPj4gaW5kZXggOTRkNTJmNDIwNWQyLi4wNjFmY2RlZDBkZmIgMTAwNjQ0DQo+PiAtLS0gYS9o
dy9pMzg2L2ludGVsX2lvbW11LmMNCj4+ICsrKyBiL2h3L2kzODYvaW50ZWxfaW9tbXUuYw0KPj4g
QEAgLTM4MTksNiArMzgxOSw0MSBAQCBzdGF0aWMgaW50IHZ0ZF9yZXBsYXlfaG9vayhJT01NVVRM
QkV2ZW50DQo+KmV2ZW50LCB2b2lkICpwcml2YXRlKQ0KPj4gICAgICByZXR1cm4gMDsNCj4+ICB9
DQo+Pg0KPj4gK3N0YXRpYyBnYm9vbGVhbiB2dGRfcmVwbGF5X2Z1bGxfbWFwKERNQU1hcCAqbWFw
LCBncG9pbnRlciAqcHJpdmF0ZSkNCj4+ICt7DQo+PiArICAgIElPTU1VVExCRXZlbnQgZXZlbnQ7
DQo+PiArDQo+PiArICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9NQVA7DQo+PiArICAg
IGV2ZW50LmVudHJ5LmlvdmEgPSBtYXAtPmlvdmE7DQo+PiArICAgIGV2ZW50LmVudHJ5LmFkZHJf
bWFzayA9IG1hcC0+c2l6ZTsNCj4+ICsgICAgZXZlbnQuZW50cnkudGFyZ2V0X2FzID0gJmFkZHJl
c3Nfc3BhY2VfbWVtb3J5Ow0KPj4gKyAgICBldmVudC5lbnRyeS5wZXJtID0gbWFwLT5wZXJtOw0K
Pj4gKyAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSBtYXAtPnRyYW5zbGF0ZWRfYWRk
cjsNCj4+ICsNCj4+ICsgICAgcmV0dXJuIHZ0ZF9yZXBsYXlfaG9vaygmZXZlbnQsIHByaXZhdGUp
Ow0KPj4gK30NCj4+ICsNCj4+ICsvKg0KPj4gKyAqIFRoaXMgaXMgYSBmYXN0IHBhdGggdG8gbm90
aWZ5IHRoZSBmdWxsIG1hcHBpbmdzIGZhbGxpbmcgaW4gdGhlIHNjb3BlDQo+PiArICogb2YgSU9N
TVUgbm90aWZpZXIuIFRoZSBjYWxsIHNpdGUgc2hvdWxkIGVuc3VyZSBubyBpb3ZhIHRyZWUgdXBk
YXRlIGJ5DQo+PiArICogdGFraW5nIG5lY2Vzc2FyeSBsb2NrcyhlLnguIEJRTCkuDQo+DQo+V2Ug
c2hvdWxkIGJlIGFjY3VyYXRlIG9uIHRoZSBsb2NraW5nIC0gSSB0aGluayBpdCdzIHRoZSBCUUwg
c28gZmFyLg0KDQpXaWxsIHVwZGF0ZSBjb21tZW50cy4NCg0KPg0KPj4gKyAqLw0KPj4gK3N0YXRp
YyBpbnQgdnRkX3BhZ2Vfd2Fsa19mdWxsX21hcF9mYXN0X3BhdGgoSU9WQVRyZWUgKmlvdmFfdHJl
ZSwNCj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIElPTU1V
Tm90aWZpZXIgKm4pDQo+PiArew0KPj4gKyAgICBETUFNYXAgbWFwOw0KPj4gKw0KPj4gKyAgICBt
YXAuaW92YSA9IG4tPnN0YXJ0Ow0KPj4gKyAgICBtYXAuc2l6ZSA9IG4tPmVuZCAtIG4tPnN0YXJ0
Ow0KPj4gKyAgICBpZiAoIWlvdmFfdHJlZV9maW5kKGlvdmFfdHJlZSwgJm1hcCkpIHsNCj4+ICsg
ICAgICAgIHJldHVybiAwOw0KPj4gKyAgICB9DQo+PiArDQo+PiArICAgIGlvdmFfdHJlZV9mb3Jl
YWNoX3JhbmdlX2RhdGEoaW92YV90cmVlLCAmbWFwLCB2dGRfcmVwbGF5X2Z1bGxfbWFwLA0KPj4g
KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChncG9pbnRlciAqKW4pOw0KPj4gKyAg
ICByZXR1cm4gMDsNCj4+ICt9DQo+PiArDQo+PiAgc3RhdGljIHZvaWQgdnRkX2lvbW11X3JlcGxh
eShJT01NVU1lbW9yeVJlZ2lvbiAqaW9tbXVfbXIsDQo+SU9NTVVOb3RpZmllciAqbikNCj4+ICB7
DQo+PiAgICAgIFZUREFkZHJlc3NTcGFjZSAqdnRkX2FzID0gY29udGFpbmVyX29mKGlvbW11X21y
LCBWVERBZGRyZXNzU3BhY2UsDQo+aW9tbXUpOw0KPj4gQEAgLTM4MjYsMTMgKzM4NjEsNiBAQCBz
dGF0aWMgdm9pZA0KPnZ0ZF9pb21tdV9yZXBsYXkoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21y
LCBJT01NVU5vdGlmaWVyICpuKQ0KPj4gICAgICB1aW50OF90IGJ1c19uID0gcGNpX2J1c19udW0o
dnRkX2FzLT5idXMpOw0KPj4gICAgICBWVERDb250ZXh0RW50cnkgY2U7DQo+Pg0KPj4gLSAgICAv
Kg0KPj4gLSAgICAgKiBUaGUgcmVwbGF5IGNhbiBiZSB0cmlnZ2VyZWQgYnkgZWl0aGVyIGEgaW52
YWxpZGF0aW9uIG9yIGEgbmV3bHkNCj4+IC0gICAgICogY3JlYXRlZCBlbnRyeS4gTm8gbWF0dGVy
IHdoYXQsIHdlIHJlbGVhc2UgZXhpc3RpbmcgbWFwcGluZ3MNCj4+IC0gICAgICogKGl0IG1lYW5z
IGZsdXNoaW5nIGNhY2hlcyBmb3IgVU5NQVAtb25seSByZWdpc3RlcnMpLg0KPj4gLSAgICAgKi8N
Cj4+IC0gICAgdnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAodnRkX2FzLCBuKTsNCj4+IC0NCj4+ICAg
ICAgaWYgKHZ0ZF9kZXZfdG9fY29udGV4dF9lbnRyeShzLCBidXNfbiwgdnRkX2FzLT5kZXZmbiwg
JmNlKSA9PSAwKSB7DQo+PiAgICAgICAgICB0cmFjZV92dGRfcmVwbGF5X2NlX3ZhbGlkKHMtPnJv
b3Rfc2NhbGFibGUgPyAic2NhbGFibGUgbW9kZSIgOg0KPj4gICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAibGVnYWN5IG1vZGUiLA0KPj4gQEAgLTM4NTAsOCArMzg3OCwxMSBAQCBz
dGF0aWMgdm9pZA0KPnZ0ZF9pb21tdV9yZXBsYXkoSU9NTVVNZW1vcnlSZWdpb24gKmlvbW11X21y
LCBJT01NVU5vdGlmaWVyICpuKQ0KPj4gICAgICAgICAgICAgICAgICAuYXMgPSB2dGRfYXMsDQo+
PiAgICAgICAgICAgICAgICAgIC5kb21haW5faWQgPSB2dGRfZ2V0X2RvbWFpbl9pZChzLCAmY2Us
IHZ0ZF9hcy0+cGFzaWQpLA0KPj4gICAgICAgICAgICAgIH07DQo+PiAtDQo+PiAtICAgICAgICAg
ICAgdnRkX3BhZ2Vfd2FsayhzLCAmY2UsIDAsIH4wVUxMLCAmaW5mbywgdnRkX2FzLT5wYXNpZCk7
DQo+PiArICAgICAgICAgICAgaWYgKG4tPm5vdGlmaWVyX2ZsYWdzICYgSU9NTVVfTk9USUZJRVJf
RlVMTF9NQVApIHsNCj4+ICsgICAgICAgICAgICAgICAgdnRkX3BhZ2Vfd2Fsa19mdWxsX21hcF9m
YXN0X3BhdGgodnRkX2FzLT5pb3ZhX3RyZWUsIG4pOw0KPj4gKyAgICAgICAgICAgIH0gZWxzZSB7
DQo+PiArICAgICAgICAgICAgICAgIHZ0ZF9wYWdlX3dhbGsocywgJmNlLCAwLCB+MFVMTCwgJmlu
Zm8sIHZ0ZF9hcy0+cGFzaWQpOw0KPj4gKyAgICAgICAgICAgIH0NCj4+ICAgICAgICAgIH0NCj4+
ICAgICAgfSBlbHNlIHsNCj4+ICAgICAgICAgIHRyYWNlX3Z0ZF9yZXBsYXlfY2VfaW52YWxpZChi
dXNfbiwgUENJX1NMT1QodnRkX2FzLT5kZXZmbiksDQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9j
b21tb24uYyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4+IGluZGV4IDc4MzU4ZWRlMjc2NC4uNWRhZTQ1
MDJiOTA4IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9jb21tb24uYw0KPj4gKysrIGIvaHcvdmZp
by9jb21tb24uYw0KPj4gQEAgLTE4OTAsNyArMTg5MCw3IEBAIHN0YXRpYyBpbnQgdmZpb19zeW5j
X2RpcnR5X2JpdG1hcChWRklPQ29udGFpbmVyDQo+KmNvbnRhaW5lciwNCj4+DQo+PiAgICAgICAg
ICAgICAgICAgIGlvbW11X25vdGlmaWVyX2luaXQoJmdkbi5uLA0KPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHZmaW9faW9tbXVfbWFwX2RpcnR5X25vdGlmeSwNCj4+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBJT01NVV9OT1RJRklFUl9NQVAsDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVfTk9USUZJRVJfRlVM
TF9NQVAsDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2VjdGlvbi0+
b2Zmc2V0X3dpdGhpbl9yZWdpb24sDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgaW50MTI4X2dldDY0KGxsZW5kKSwNCj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBpZHgpOw0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvZXhlYy9tZW1vcnkuaCBi
L2luY2x1ZGUvZXhlYy9tZW1vcnkuaA0KPj4gaW5kZXggYzM2NjFiMjI3NmM3Li5lZWNjM2VlYzY3
MDIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2V4ZWMvbWVtb3J5LmgNCj4+ICsrKyBiL2luY2x1
ZGUvZXhlYy9tZW1vcnkuaA0KPj4gQEAgLTE0Miw2ICsxNDIsMTAgQEAgc3RydWN0IElPTU1VVExC
RW50cnkgew0KPj4gICAqICAgICAgIGV2ZW50cyAoZS5nLiBWRklPKS4gQm90aCBub3RpZmljYXRp
b25zIG11c3QgYmUgYWNjdXJhdGUgc28gdGhhdA0KPj4gICAqICAgICAgIHRoZSBzaGFkb3cgcGFn
ZSB0YWJsZSBpcyBmdWxseSBpbiBzeW5jIHdpdGggdGhlIGd1ZXN0IHZpZXcuDQo+PiAgICoNCj4+
ICsgKiAgICAgICBCZXNpZGVzIE1BUCwgdGhlcmUgaXMgYSBzcGVjaWFsIHVzZSBjYXNlIGNhbGxl
ZCBGVUxMX01BUCB3aGljaA0KPj4gKyAqICAgICAgIHJlcXVlc3RzIG5vdGlmaWNhdGlvbiBmb3Ig
YWxsIHRoZSBleGlzdGVudCBtYXBwaW5ncyAoZS5nLiBWRklPDQo+PiArICogICAgICAgZGlydHkg
cGFnZSBzeW5jKS4NCj4NCj5XaHkgZG8gd2UgbmVlZCBGVUxMX01BUD8gIENhbiB3ZSBzaW1wbHkg
cmVpbXBsIE1BUD8NCg0KU29ycnksIEkganVzdCByZWFsaXplZCBJT01NVV9OT1RJRklFUl9GVUxM
X01BUCBpcyBjb25mdXNpbmcuDQpNYXliZSBJT01NVV9OT1RJRklFUl9NQVBfRkFTVF9QQVRIIGNv
dWxkIGJlIGEgYml0IG1vcmUgYWNjdXJhdGUuDQoNCklJVUMsIGN1cnJlbnRseSByZXBsYXkoKSBp
cyBjYWxsZWQgZnJvbSB0d28gcGF0aHMsIG9uZSBpcyBWRklPIGRldmljZSBhZGRyZXNzDQpzcGFj
ZSBzd2l0Y2ggd2hpY2ggd2Fsa3Mgb3ZlciB0aGUgSU9NTVUgcGFnZSB0YWJsZSB0byBzZXR1cCBp
bml0aWFsDQptYXBwaW5nIGFuZCBjYWNoZSBpdCBpbiBJT1ZBIHRyZWUuIFRoZSBvdGhlciBpcyBW
RklPIGRpcnR5IHN5bmMgd2hpY2gNCndhbGtzIG92ZXIgdGhlIElPTU1VIHBhZ2UgdGFibGUgdG8g
bm90aWZ5IHRoZSBtYXBwaW5nLCBiZWNhdXNlIHdlDQphbHJlYWR5IGNhY2hlIHRoZSBtYXBwaW5n
IGluIElPVkEgdHJlZSBhbmQgVkZJTyBkaXJ0eSBzeW5jIGlzIHByb3RlY3RlZA0KYnkgQlFMLCBz
byBJIHRoaW5rIGl0J3MgZmluZSB0byBwaWNrIG1hcHBpbmcgZnJvbSBJT1ZBIHRyZWUgZGlyZWN0
bHkgaW5zdGVhZA0Kb2Ygd2Fsa2luZyBvdmVyIElPTU1VIHBhZ2UgdGFibGUuIFRoYXQncyB0aGUg
cmVhc29uIG9mIEZVTExfTUFQDQooSU9NTVVfTk9USUZJRVJfTUFQX0ZBU1RfUEFUSCBiZXR0ZXIp
Lg0KDQpBYm91dCAicmVpbXBsIE1BUCIsIGRvIHlvdSBtZWFuIHRvIHdhbGsgb3ZlciBJT01NVSBw
YWdlIHRhYmxlIHRvDQpub3RpZnkgYWxsIGV4aXN0aW5nIE1BUCBldmVudHMgd2l0aG91dCBjaGVj
a2luZyB3aXRoIHRoZSBJT1ZBIHRyZWUgZm9yDQpkaWZmZXJlbmNlPyBJZiB5b3UgcHJlZmVyLCBJ
J2xsIHJld3JpdGUgYW4gaW1wbGVtZW50YXRpb24gdGhpcyB3YXkuDQoNClRoYW5rcw0KWmhlbnpo
b25nDQo=

