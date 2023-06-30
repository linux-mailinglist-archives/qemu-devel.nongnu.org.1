Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B78743236
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 03:24:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF2rP-0001sG-Rx; Thu, 29 Jun 2023 21:23:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF2rO-0001s8-0v
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:23:42 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF2rM-0007R8-06
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:23:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688088219; x=1719624219;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5JtgUqMYGHcWF4/0/xS1T2k1zIR+kU/eqEYDFIEfeuA=;
 b=iyUUE7KOkVbCTlx0w8BNswl7eYOC0S3ljizJTj3rk9U/obEjbFuNk2MP
 6dKlT8J7rwcyScyxfjSByS0AwygM2eutKG/dLfAx9uFOZ5ZMi6bcHaAKH
 rBs62RbE5UHUpLGJa3WF9aFDFI2hz/UfZMYP0ObZPynmInvR87XFIK6y7
 iQ3aD3i21iKBgv3jwLipfRrA6ZWhLzrNf3RhVKl1/l6RxYkY5lFtNClJD
 Fh4zReYFwnd3W4X8tQSZDYP2TfQGccBEU4n+lelY4SfWSQpJL5sXFVfp2
 wN7ii0XkijCTLZOV2ezjjspiWT5bVK3/auT22NeBSR81v8sAu6KDJEEGX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="342616925"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="342616925"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 18:23:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="807568236"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="807568236"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by FMSMGA003.fm.intel.com with ESMTP; 29 Jun 2023 18:23:35 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:23:35 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:23:35 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 18:23:35 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.47) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 18:23:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uk1dUOxG/vVwySDy1iNFPLypESKGfGXebxIJQYqCyO/rrMj0F/GIQuP+fOaH076Od/XHGg9ZvzrbPH8zfc+5k8KchV3/YmOZN4K+Xkb8RObI1U4MKYihBJmeE0QFu4It1QktL6x6vWQJv52mDn/jfewEUZGUSrkpcsadRV0KfdLIujmJ6jaBGpDLi5ZsDc18RTPfWNPeFt2wQ5+Aoc0Jh0aUQ24s3fJNngA9WHDhH+mzD3qTKYUkWY4vv6lSjDWMtopbeKeUWXhhuSYIq9uD0bqZSeMJoMxDE29uHFXvDQ/uS8/nvwP2XpRLCgVmNAMSXaTFlzZbe7ICtosN5317UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JtgUqMYGHcWF4/0/xS1T2k1zIR+kU/eqEYDFIEfeuA=;
 b=e0W3+gt6juESNtX1w17EUJR8/yydtjL1IQn1glhJymhzFbuKlY/l6nyTp7PC0+bQCSgs0eT3OBrLW79vm9crSFsOEZAPYQHM4TpzZWWJo8UI9ZRNJQ+LdTye3ojvbB6bY7rp+PWN/8On0GqDx9/J4ol8i9s6Dnx+nSH0F5VTapOXRgKqS6DJan+Aa62gu6GqH3qy/BssrdMg+efOtiUcD5/sgu+rGY6dD9OLuctU8qt+lPkywcfmvPTDcZmDxcQGLVX8mgnicanPMgnIniCth8cXl3xenKoBd73JenZplwudAu4XoyUcTs4s2VFOPp41YnoKoAP7nUp77JV+enU5AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by IA1PR11MB7272.namprd11.prod.outlook.com (2603:10b6:208:428::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Fri, 30 Jun
 2023 01:23:31 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 01:23:31 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "avihaih@nvidia.com" <avihaih@nvidia.com>, 
 "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 4/5] vfio/pci: Free resources when
 vfio_migration_realize fails
Thread-Topic: [PATCH v4 4/5] vfio/pci: Free resources when
 vfio_migration_realize fails
Thread-Index: AQHZqmdAYsqUcAoeWkaVOJED080MgK+hqbsAgADkOcA=
Date: Fri, 30 Jun 2023 01:23:31 +0000
Message-ID: <SJ0PR11MB67447D737D638B7952C476E1922AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-5-zhenzhong.duan@intel.com>
 <346b1c73-0efb-e339-dbbf-c4ae41e85861@oracle.com>
In-Reply-To: <346b1c73-0efb-e339-dbbf-c4ae41e85861@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|IA1PR11MB7272:EE_
x-ms-office365-filtering-correlation-id: 0cf05911-f97c-410b-a8ee-08db79089d80
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XYK7LoPjer71lSo3prw+E87nCU/ikv/ji8P/Sfn31SWZG+qiKWP6OobS44YbsleGmDeW0fSHchaesl+4QzAwNh0wrj3xNUI9/27az2LEXbypCpY8oZ3AyVgtT5Vej+/K/zHChMWlK9ZV1z8QbTVDy0ohaNfi/s9pdnPxIenI1qdxbAh/D5sma2ZTMj5Wtnr4dm+gTRh2HVEVrwWmKrKx3KlZfUbvMr7pU5RWlAcO20h4m5CMQBAHIhdd68pN96+ZS3qvTEcf6QtoPN+0zGP3E8bLyA8fx6G9Fjp7eZkIXiV6eRStIi8OyyJqU37k0keIZbowZh6i4BvfigoZyO9Ep0jIphDn+4MN9/1AYnZpOKfdiKI50g3y12M8cqY68g2NThm/UPTq/OU8aR+mKL1W6QOjyZzeFIiTDHFpTMJu+ZH8RI7elK66tEx2V9+JqAI232jOtuq8omfQjNZ0Vcb0DbqSdbKkYImqObJRJYeBe+8d1WDz1tk8g6BMBU9qFhUFOaWmQgjDCBsKEdcNrWMeIhjyaBiWtiaTHQd7sFJjN7GT4sCB8Qn9dNGa2PS4bv+0itKojnD+r4Wu7NtJQGocQxbGjrHEzG30pn2BJd72Kb8BrSKfx2o98bDBt4kW9E4G
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(136003)(366004)(346002)(396003)(39860400002)(451199021)(2906002)(186003)(55016003)(7696005)(71200400001)(122000001)(86362001)(107886003)(9686003)(38100700002)(83380400001)(82960400001)(26005)(6506007)(110136005)(41300700001)(54906003)(38070700005)(478600001)(316002)(76116006)(66556008)(66446008)(4326008)(66946007)(33656002)(64756008)(66476007)(5660300002)(52536014)(8676002)(8936002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGU5eTJseEtXeVg4M3EvVmJTTGJkWWo3bWFoM2JHT2FuWThDUEc2ZzZxeG9H?=
 =?utf-8?B?RWlDWUZwWVJBaTRiQUVwRWFqMnZKNVRzRWUrQ3d6U2Q5QXVEMElscEI3d0dB?=
 =?utf-8?B?ODdkVmdMUEwrUURFTkNKdzBOaHd1TWUzSVBRNjloWHZNRy92T3NzY042TnFo?=
 =?utf-8?B?ZG1DWXNEUXZ1SzZkNzN4QkxPMElGSHhOMXhKbjBnMEw2VmRTdzN3N01aYWcx?=
 =?utf-8?B?Ukk5cytNUjJTTzYzY3NoWEZxK09XUzNIN2lpeU94M3JtOUZ4WW16ZUtqeXZR?=
 =?utf-8?B?anF6SDE1SHlEdXFtSzQ4ZlRLWTBadUxRV01uQldMZ1JrWlhLT0Y2NldtR25y?=
 =?utf-8?B?a3lFQ2NieXA1ckZpZHZWUThsellGNGVSc0N4eHh3K212a09Ja0E1SU1pdHdx?=
 =?utf-8?B?YWZQY0N1Wm1ZVkJYV0MvdUpySnI0UXVZR1g0bnMxZGYxcjZuWlZlQlFSQUhL?=
 =?utf-8?B?ZzJJbTRPaGVabVZ1UnlLTVpkS25SNlpJbFVJNzhZdFlyOGVlaEhDMVpMN3k0?=
 =?utf-8?B?YWpTTHYvR2RuS0h1dUs0MU1LNThvSnp2Z1Blbk10Q2cvZDJUUHYwSithdzZI?=
 =?utf-8?B?UHFyQjd5ZU1FWkgrZThSRDBXdWp4cUsvWkl3OW9CTHQ0NnczWm9sQlFZQlp5?=
 =?utf-8?B?T0tSdnQxQTNjcy9FTy82ZTVsTHViQ3ZmSHQ0c3BoRVhTRGYvbDhqcDZxUFV1?=
 =?utf-8?B?bVo4STB1U3ljUGlFOGFoM1BYbzEzN3VtcEwvRkRwQ2RtWVRyV05lNytJc0tG?=
 =?utf-8?B?eGFoUm80ZUU2S25mTWkrMVV3bVJFQWF1dHh4ZnJYZ29pcm5JWnk0VURaeWU3?=
 =?utf-8?B?NDlmbXVwVFJLNC9ZYnZQa1BFSE05ZGNLS2IwN0JzZVBkWjVLREk5anlTRHNu?=
 =?utf-8?B?WUQzVmVyRFQ5WTNKWlFvMWJpZFJEVHVhaEVSNEhBbHQ2ZXBBSFRqRDA3dUFh?=
 =?utf-8?B?cGhrYnR3NlNuWWtvbFN0R01scytrN3pydjVRNE1ZdTRodnlsRmpZVm94TEt6?=
 =?utf-8?B?QVF1aDhBYVRXRG1TZHI2WGQyRzhZa3k2VkphWFgzaGhCWTc1enkxL3lKWjQ0?=
 =?utf-8?B?Qnc0MHJxNkd1WFZWVTl5YmhEYkdtWDFWakVKTVdFaDUrRC8rUXRHWUJaZU5l?=
 =?utf-8?B?c2ZvWmZyNVpaMEJlUkdLWmRvb2t5Q0pocDN2MTRnQWN5N2s1a2g0anUvd29s?=
 =?utf-8?B?ZmpJRVJURVZBNDlxbytxV09LWFpxL0lRdzFwTG1qWVZYaXQ3ZllENGtWV2dU?=
 =?utf-8?B?M3daUDhrQjlReEVDdjg5TjI5U0lxRzdIY0l3UWJBMEE3SFVHblBQV05mSmtj?=
 =?utf-8?B?dDZqbFpRd2lMaitVdllWNzgyQmRpWm5pS1BRdnQvVlhDUjkzem9iZC8zWXpH?=
 =?utf-8?B?SkJUb1VZN1pIT09Gd2tRemlUV3hpc1FlbXdjZG9uS2hmdG9IbmxWR2Q2NzRS?=
 =?utf-8?B?NTBOMExLTkFJYTVTTm9ZYTlpZW5TY2p3czJKcnFrZXVJeTlxNjlNVVhaQTNP?=
 =?utf-8?B?UnYzTXIySG9scHFKNHV0MnhEK1JyVFI5Q2ZZQXJKWWdTRnVXUHgvWS9nQ0Nj?=
 =?utf-8?B?LytKcVlXTTIxNG5yQ1J4a1ZFOUp0eUZOSHhnTEhqRk1qYjZ4YVJaRmw3RTdt?=
 =?utf-8?B?VDUvc1hxdjVOdFJnT3VpMm5qS3YwVmw1aWRNdENvTTYxSzY5VDJKTmk3MmJX?=
 =?utf-8?B?dnNzeXpHaUhFM2xDQWdxWjlTTmNPM3JVY0cyZENRVW9oRDJ1SzhLektROHpW?=
 =?utf-8?B?SFk3NVB1TjBaNEFYYURQdjRvSWtQRTNpSm9aK2ZZUUUwR043MWlNaDlwNDhT?=
 =?utf-8?B?REdFSGFmWEVYNEk2bTBKQ1ZoKzNCczVyWlF0dzJiU1Y1VkhPN0ladlhIbGVF?=
 =?utf-8?B?RlNUVUN6K0VQQWhDZktTekJ0STJiU3pieFhPYVU3OXl6bXBMMDF6ZHJtNHJW?=
 =?utf-8?B?bUZZY2k4alMrUExaZEpGak1scjU1QzNXcXkvVWpEY1RtRHBVckVaQWN2RUk3?=
 =?utf-8?B?MHIwenNIRnNrTG9Yblh1NTg2YVB6M3lteDFDQXdMZkFJT0I5cUVvenhtY290?=
 =?utf-8?B?c00xeTRWaUFNT2dmdmw2Zi91UUtJZkJ6Tk1adlJjYkJWM2xEN1QrZkd0QVBn?=
 =?utf-8?Q?omopNocjxkBW+CYsAB9l8i7Am?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0cf05911-f97c-410b-a8ee-08db79089d80
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:23:31.1598 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zACZyFEC+4h7pTM/rkMr1kqHwBvVztdx50YDxiZHEIrMk/VM1oG1sv/lehV9cvx3gFXEiN5UAWyiWYXREtdUoJhWAS1unKnnmfK4Sse8lxY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7272
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDQvNV0gdmZp
by9wY2k6IEZyZWUgcmVzb3VyY2VzIHdoZW4NCj52ZmlvX21pZ3JhdGlvbl9yZWFsaXplIGZhaWxz
DQo+DQo+T24gMjkvMDYvMjAyMyAwOTo0MCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBXaGVu
IHZmaW9fcmVhbGl6ZSgpIHN1Y2NlZWRzLCBob3QgdW5wbHVnIHdpbGwgY2FsbCB2ZmlvX2V4aXRm
bigpIHRvDQo+PiBmcmVlIHJlc291cmNlcyBhbGxvY2F0ZWQgaW4gdmZpb19yZWFsaXplKCk7IHdo
ZW4gdmZpb19yZWFsaXplKCkgZmFpbHMsDQo+PiB2ZmlvX2V4aXRmbigpIGlzIG5ldmVyIGNhbGxl
ZCBhbmQgd2UgbmVlZCB0byBmcmVlIHJlc291cmNlcyBpbg0KPj4gdmZpb19yZWFsaXplKCkuDQo+
Pg0KPj4gSW4gdGhlIGNhc2UgdGhhdCB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkgZmFpbHMsDQo+
PiBlLmc6IHdpdGggLW9ubHktbWlncmF0YWJsZSAmIGVuYWJsZS1taWdyYXRpb249b2ZmLCB3ZSBz
ZWUgYmVsb3c6DQo+Pg0KPj4gKHFlbXUpIGRldmljZV9hZGQNCj4+IHZmaW8tcGNpLGhvc3Q9ODE6
MTEuMSxpZD12ZmlvMSxidXM9cm9vdDEsZW5hYmxlLW1pZ3JhdGlvbj1vZmYNCj4+IDAwMDA6ODE6
MTEuMTogTWlncmF0aW9uIGRpc2FibGVkDQo+PiBFcnJvcjogZGlzYWxsb3dpbmcgbWlncmF0aW9u
IGJsb2NrZXIgKC0tb25seS1taWdyYXRhYmxlKSBmb3I6DQo+PiAwMDAwOjgxOjExLjE6IE1pZ3Jh
dGlvbiBpcyBkaXNhYmxlZCBmb3IgVkZJTyBkZXZpY2UNCj4+DQo+PiBJZiB3ZSBob3RwbHVnIGFn
YWluIHdlIHNob3VsZCBzZWUgc2FtZSBsb2cgYXMgYWJvdmUsIGJ1dCB3ZSBzZWU6DQo+PiAocWVt
dSkgZGV2aWNlX2FkZA0KPj4gdmZpby1wY2ksaG9zdD04MToxMS4xLGlkPXZmaW8xLGJ1cz1yb290
MSxlbmFibGUtbWlncmF0aW9uPW9mZg0KPj4gRXJyb3I6IHZmaW8gMDAwMDo4MToxMS4xOiBkZXZp
Y2UgaXMgYWxyZWFkeSBhdHRhY2hlZA0KPj4NCj4+IFRoYXQncyBiZWNhdXNlIHNvbWUgcmVmZXJl
bmNlcyB0byBWRklPIGRldmljZSBpc24ndCByZWxlYXNlZCwgd2UNCj4+IHNob3VsZCBjaGVjayBy
ZXR1cm4gdmFsdWUgb2YgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIGFuZCByZWxlYXNlIHRoZQ0K
Pj4gcmVmZXJlbmNlcywgdGhlbiBWRklPIGRldmljZSB3aWxsIGJlIHRydWVseSByZWxlYXNlZCB3
aGVuIGhvdHBsdWcNCj4+IGZhaWxzLg0KPj4NCj4+IEZpeGVzOiBhMjI2NTEwNTNiNTkgKCJ2Zmlv
OiBNYWtlIHZmaW8tcGNpIGRldmljZSBtaWdyYXRpb24gY2FwYWJsZSIpDQo+PiBTaWduZWQtb2Zm
LWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+
PiAgaHcvdmZpby9wY2kuYyB8IDMgKysrDQo+PiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9u
cygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcvdmZpby9wY2kuYyBp
bmRleA0KPj4gNTRhODE3OWQxYzY0Li5kYzY5ZDMwMzFiMjQgMTAwNjQ0DQo+PiAtLS0gYS9ody92
ZmlvL3BjaS5jDQo+PiArKysgYi9ody92ZmlvL3BjaS5jDQo+PiBAQCAtMzIxMCw2ICszMjEwLDcg
QEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBDSURldmljZSAqcGRldiwgRXJyb3INCj4qKmVy
cnApDQo+PiAgICAgICAgICByZXQgPSB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKHZiYXNlZGV2LCBl
cnJwKTsNCj4+ICAgICAgICAgIGlmIChyZXQpIHsNCj4+ICAgICAgICAgICAgICBlcnJvcl9yZXBv
cnQoIiVzOiBNaWdyYXRpb24gZGlzYWJsZWQiLCB2YmFzZWRldi0+bmFtZSk7DQo+PiArICAgICAg
ICAgICAgZ290byBvdXRfdmZpb19taWdyYXRpb247DQo+PiAgICAgICAgICB9DQo+PiAgICAgIH0N
Cj4+DQo+PiBAQCAtMzIxOSw2ICszMjIwLDggQEAgc3RhdGljIHZvaWQgdmZpb19yZWFsaXplKFBD
SURldmljZSAqcGRldiwgRXJyb3INCj4+ICoqZXJycCkNCj4+DQo+PiAgICAgIHJldHVybjsNCj4+
DQo+PiArb3V0X3ZmaW9fbWlncmF0aW9uOg0KPj4gKyAgICB2ZmlvX21pZ3JhdGlvbl9leGl0KHZi
YXNlZGV2KTsNCj4+ICBvdXRfZGVyZWdpc3RlcjoNCj4+ICAgICAgdmZpb19kaXNhYmxlX2ludGVy
cnVwdHModmRldik7DQo+PiAgb3V0X2ludHhfZGlzYWJsZToNCj4NCj5JIGFncmVlIHdpdGggdGhl
IGdlbmVyYWwgc2VudGltZW50IGJlaGluZCB0aGUgY2hhbmdlLg0KPkNsZWFybHkgdmZpbzo6bWln
cmF0aW9uIGFuZCB2ZmlvOjptaWdyYXRpb25fYmxvY2tlciBhcmUgbGVha2luZyBmcm9tIGluc2lk
ZSB0aGUNCj5taWdyYXRpb25fcmVhbGl6ZSgpIGZ1bmN0aW9uLg0KPg0KPkJ1dCBpdCBpcyBraW5k
YSBhd2t3YXJkIHNlbWFudGljIHRoYXQgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIChvciBhbnkg
cmVhbGl6ZSkNCj5mYWlsdXJlcyBuZWVkIHRvIGJlIGFjY29tcGFuaWVkIHdpdGggYSB2ZmlvX21p
Z3JhdGlvbl9leGl0KCkgdGhhdCB0ZWFycyBkb3duDQo+c3RhdGUgKmxlYWtlZCogYnkgaXRzIHJl
YWxpemUoKSBmYWlsdXJlLg0KPg0KPkl0IHNvdW5kcyB0byBtZSB0aGF0IHRoaXMgc2hvdWxkIGJl
IGluc2lkZSB0aGUgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpIG5vdCBvbg0KPnRoZSBjYWxsZXI/
IFVubGVzcyBRRU1VIDo6cmVhbGl6ZSgpIGlzIGV4cGVjdGVkIHRvIGRvIHRoaXMuDQpHb29kIHN1
Z2dlc3Rpb24sIHdpbGwgZml4Lg0KDQpUaGFua3MNClpoZW56aG9uZw0K

