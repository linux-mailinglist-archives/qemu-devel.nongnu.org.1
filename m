Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5587074324C
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 03:40:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF35z-0003yY-Lp; Thu, 29 Jun 2023 21:38:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF35y-0003yQ-D7
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:38:46 -0400
Received: from mga06b.intel.com ([134.134.136.31] helo=mga06.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qF35v-00053W-4P
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 21:38:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1688089123; x=1719625123;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=STSxEt9LIXxudgIRiHVN2JpxcTTmy8Iw2mFZVKnRRuc=;
 b=azWPNwxemJczy6e9xynMgqs01hv3ilPkkHjYGepZhHQ9Aq1DYig4bpCm
 2YAJuk7QQkpXZAcgzJ9AbZTzdZgCHYNBCl1DBmvwZtdUKBnBBwmu+jLrH
 K//2RL4fVXsYSElv9Ki3H20e0rqVRNMr96oQbug3NWdq2cPM6Pk2dWLq4
 dTtIXPWA6BrtEKLy/NN23sMzTpno6s0RaKjX/T9+3L4e50s+fuB3L0rnC
 uuk8eXNH0nHYrtEwqpB8fR4BBwB7QigEJLbyHX8MI2nAKJ+R+uJF1p4dp
 VHJGL2wztyCxYG3cxvBsbguJbquZCkxjmMujAy/nyJxCrErRsPOwQMGVh w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="425972645"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="425972645"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Jun 2023 18:38:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10756"; a="787546150"
X-IronPort-AV: E=Sophos;i="6.01,169,1684825200"; d="scan'208";a="787546150"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga004.fm.intel.com with ESMTP; 29 Jun 2023 18:38:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:38:39 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 29 Jun 2023 18:38:38 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 29 Jun 2023 18:38:38 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.177)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 29 Jun 2023 18:38:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TbEaG6GvgNRy90gXtRBufGLbDNiJIG8H8C9VHgn2J9pTAcwDUzJtLb6EnjUTePA2XKWdTQ+GY4KKz/GuIfxIgULwXrmsrf/n7LLT65qGAlx0X4Y6yhE8EidmbXCWjRAlaWCzAPJvruAlyn4qa0zXtXBRYqGO9Dty8dEFK057JjnPln8H3srqN1LwSR4kMTRb+KO6C28acqUhyQcU8ltkGl61YilNBtne3yAqYCBE8kW+JJnWwjLGnXBaXXLl2cVtTLluOB1sA5Q6wiU9w7HcqArFiCGh5mIMxyJ3T3rhk90wmuzO+jIghWgUU7E3ikTM3moZfDsROpmNV85SCIXp9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=STSxEt9LIXxudgIRiHVN2JpxcTTmy8Iw2mFZVKnRRuc=;
 b=VB8uRWxYosdh9FTV1g/zc2aoTki6MgnbkkmbvRJv61ugZbhaSvtDn30ReYL/nSltFkvsfdLHkv1znlGMsPCTJrPFbwZ7Z4V339x69yP/d5mZeWw9yO3eJjUx1XAw+Bn5rI2YMbvtnEtRfZbTJh6pHGd+xouIgYGq3fd/0tPcKMGhxnu4NYn9SW3Lko0mgTcSnU+BoDD8TEPOEvgwkR6CwqfHAM6SvCXfpbVt9Qzm3bIwtAzTqur4IOo2Me6TwPr1xkBQGJEw7J5saTJLYoOa8fskDKI+ySY/lH3u2mEGRsgKG8OaDYjhxho9e7s8tIi6zaaGf7NdbqNhF6NUCfZpCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA2PR11MB5131.namprd11.prod.outlook.com (2603:10b6:806:116::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Fri, 30 Jun
 2023 01:38:35 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%6]) with mapi id 15.20.6521.024; Fri, 30 Jun 2023
 01:38:35 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Alex Williamson <alex.williamson@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>
CC: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "clg@redhat.com" <clg@redhat.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Thread-Topic: [PATCH v4 5/5] vfio/migration: Refactor and fix print of
 "Migration disabled"
Thread-Index: AQHZqmc8HYoHMjMQv0uJrkNymTGr86+huhgAgAArdwCAAAY6gIAAbP8AgAA3g9A=
Date: Fri, 30 Jun 2023 01:38:34 +0000
Message-ID: <SJ0PR11MB674439F4C7EC1FB9D7637B99922AA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230629084042.86502-1-zhenzhong.duan@intel.com>
 <20230629084042.86502-6-zhenzhong.duan@intel.com>
 <9aa97ee7-ee54-a2d3-2cde-36b1a1d1241d@oracle.com>
 <8c9e8103-d194-5e8f-eaa2-1cc16bfb3c9a@nvidia.com>
 <8032e407-2aad-b39e-a6d2-bc2828360e73@oracle.com>
 <20230629161230.21fe40b5.alex.williamson@redhat.com>
In-Reply-To: <20230629161230.21fe40b5.alex.williamson@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA2PR11MB5131:EE_
x-ms-office365-filtering-correlation-id: eb13fcf7-d37e-4bad-c574-08db790ab82c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: koqMX3537RBDobLU10m9+4mwxmVsKMYEolfhR29B1c1QkRBfCbwxfaTKk2KacfppPC/DezZ2Bxe+C4yGKcY1NGPUwHEKfZ5aYibMdb+RdQpusnjvUEgZEnA55yIqoubGwNl1PYK4870AQQE3ZAojWKh/R4iWHVMpnhXLN2YLcdKEcfjMo6XGuS22IlS1rq8xoh2DXkE9u0tTe5FNOt0VwSbGqb3BoOhVlZ+n1Ae1vjQK5TtlsclQs7Apj+ilstRJc+SdiavtVYAevauU8B+tpl0E3evMxOt+1J32XU55m/Vzl2eX0aUUx7kvdrc0uhsCZMAWpQxmHy3fPZzXarfA9wvupRAuSfSLscmmF0qd5i2HDAU+e4M66agqm2QT/p6VBfLhkNjeMaX9nDhK1jg9nkMpv3qN2dqR3Dd7t7J5Em5Fg5geHNdHJwi5znQdXQYNhOV9Kv7G3Hdfx1dEWmNkHME5bI+h2nGzBSxuXmYOD0ZmO+VONvHKnhTkFqQmVtnzS20R7f9MRP0KoWJXFycoYx1vyOYYmcAtVe1TGz+4wPm1KkbwNuglkfkUeIf/W6sFCBLNBE5/kXVJnENnuIznLuPnu2nPrXR6kuzWvk4bbDfT95E7eZJwdnqjmlkt9ZQ1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(366004)(346002)(39860400002)(376002)(451199021)(66446008)(38070700005)(8936002)(9686003)(26005)(66556008)(4326008)(66476007)(66946007)(86362001)(122000001)(316002)(41300700001)(8676002)(52536014)(55016003)(76116006)(64756008)(82960400001)(5660300002)(38100700002)(33656002)(110136005)(6506007)(107886003)(186003)(2906002)(83380400001)(71200400001)(53546011)(7696005)(478600001)(54906003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VUNmZk9RdEdYQXhKajBKaHIyVzJFbDNOTlRiejl6cnhlZXVLcjA5ZGI1YjRE?=
 =?utf-8?B?b0JXTXVhU0h5NXZwT2NPTlZFZWNJaG1JRng0VUY4eE4vREhrdGFUSURWSTZh?=
 =?utf-8?B?R3cyNzE2bzVmajVmSnlqRUJYWjR2V0lUSEx3N096N3FCY3JldXZDRGdZaXN5?=
 =?utf-8?B?STBrL2d1YTFUN0ZCZUpTM0lRUFVYMHBnUmRlMzFwUytHYUNINU9RZ21NQkhH?=
 =?utf-8?B?NGQyaUdhU2Z3eXlvZkQxNFVXZ0dMZmN2WnpzNnc1R2d1OFdTYzdYY3BMd3JN?=
 =?utf-8?B?ZllzT25QZUtFeFE0U0ZEUHpPcmJRNURNVGlEUUhmZjRYQzlqUXR4dTcwZjdC?=
 =?utf-8?B?Z093Z1l5ckZWR0MzNG9OSW9XK3lsems1UzNaVUFwd09aTFZ3b0NHVlJUM1lx?=
 =?utf-8?B?VlRQb0NBd0tXTENyYzhNRVJ5dDJzNmpwQW1BcHJYbFRhV2hyOTU4VnRpWmlO?=
 =?utf-8?B?emlhSjdsZmNiUkMrYjhrY3U2VnJrSzJ6c1ZZUkZIUEI2SlZpTmliNE15Q1Bh?=
 =?utf-8?B?TTBsOHVwazZINEJxcU05T2JnZEFGdUlDRjVaaHplWHNnYmpFaENUL3Axby9C?=
 =?utf-8?B?MkNoZDZUeUFhU0creWNCUWg1VmExeFp0RTk1ZXQvUjRCeWcxME1OTU50N3c1?=
 =?utf-8?B?Z2VPKytDS2hCcjNvc2p6T0tYTXBZWG9RVVZDMUVONmJOdllDRU5zbThmWEYy?=
 =?utf-8?B?NlhZcHFqMGlQb3hXUkhmL3pFNjFpTWxtYzF0dnh4WTdPdUtaalpEYVNmWkJZ?=
 =?utf-8?B?ODUwN1VxOXk5Vzd3WVhmNkhEcEdDRnBDSHVIenJGU05kelVIQjhiMDdKNEtT?=
 =?utf-8?B?K1oxakNhRE0yU3JPWVhvMUJId0Nia0xONmh6V3pEZThRU04yUXhaUkRUVEdR?=
 =?utf-8?B?eU9CTkNGZ2s0TDJPN2VaR1R1aEN0L2tWOUVHRW1xMFRHenE3Mkt6MkU3TitR?=
 =?utf-8?B?WVo0ajNSVFRDNHA5cTdNeHBTdjRKbmMxT0U4a2R5UCs5YjBZa0FNMjBhSjN2?=
 =?utf-8?B?d1JNeGg2aWxoUE03S3psUk1neVBrdGg5Vjh0ODQvYTU1MmFyMzQxMU9tOTJi?=
 =?utf-8?B?b3A2QVM3ajA1YmZMK1ZaMnFhd2lNb3czd3lZU2xKekp3OTUxZ3FhS0JWWlpE?=
 =?utf-8?B?eVVxK1NLdEFYUndEQVdjaW8wK29lU0VzdTVaU2hFamM1Vy9SdVpJb2lVMlIr?=
 =?utf-8?B?R1E0SmJ3NVlSUUw0bUxqTjNoTWgrdXZyN2FKMnNLVVpuMGVNd0JrNCs2NlAr?=
 =?utf-8?B?UDE0QjZ0eGdDT3l0T0o1QjY3YllwTCtwSjFHcytHK0lQQkpiMEloNFFJb1Ba?=
 =?utf-8?B?UVMwUjJJSTZkYldaMFplbU11TFRINjE1eFlVU3FMcVFTZGNjdllCeVQzb2FB?=
 =?utf-8?B?ODhkWEhqTjRseGR5dmlkckt4cWtFUXZVOXAzSVJ3YWVIN3F0c05oQmlYdWg5?=
 =?utf-8?B?cjNaREQ4S0pzcjl6NWlwQlNCVmhMVFpnTmp2N0V5ay9hREViRW9RU3JFTVdE?=
 =?utf-8?B?RzFZUG5scVRCd1hyMTUra1VTRnpQcjhrZFFNYlBpS2paNWR1SFhVN2JRYzN4?=
 =?utf-8?B?czU1UVN1eC9tU1VsQjB1cStlZjRoM1U0bnBNdC9PS3VaZlhxdW1jM1hzQ0Rj?=
 =?utf-8?B?Z0hTQXZGUk5DWEZJRWgxL0pJb3Z5QUZIdU9SR2RVNXNKQk4yTm91ZEtvRDlD?=
 =?utf-8?B?ZCtMblI3bHovMHVta2phZGR6SHMvcnpVWmFqbWxSL21CNTFUOFN6MGNuMDda?=
 =?utf-8?B?L0tUN2J4SHRicFQzSCtvM01mMXJOa2NkbmJnaXU2N0Z6OG90a01iNlZ0NXMy?=
 =?utf-8?B?T1lIaGpFbkMwckE2THRGTHI0bG1RMUZ3Wk51VTR6V3FWMXhGa0JteE1idVps?=
 =?utf-8?B?SlBRRjFQZmxmL1dWVmttNVJMVWx4QVU4cm5sdEhHZ3RTRG1KRjRZMXVUaitM?=
 =?utf-8?B?Y2srbjRieXFPN0tDS09XcGNkVGc4eWY2WitHc2NKYmd5OTVZdVZCdFRJTzRR?=
 =?utf-8?B?a0F4Zm4zcVNTSE54cHZEbFFYSzNRajBjak92N0JRMUVGU3BWanJFNzhjZnpO?=
 =?utf-8?B?S1FTQkpwaStoRHNTOW10b1VkUjNES2ZlUHM0c1ZKclhxUm02aVdwTGN2Mll4?=
 =?utf-8?Q?cbVTYjAGLti5iwkgOkICYHMP5?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eb13fcf7-d37e-4bad-c574-08db790ab82c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2023 01:38:34.9035 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hVJ5Er/e7ZKaO1CpntWn0VZAhy4sRiAhMY/3NQCIb7g7D7KzD+vYFgk+LXrvRSby7/ej2eW+f2Nq6PLBY0EKUfNlYIU0/nqXt9nFgt9l6DY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5131
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mga06.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQWxleCBXaWxsaWFtc29uIDxhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDUvNV0gdmZp
by9taWdyYXRpb246IFJlZmFjdG9yIGFuZCBmaXggcHJpbnQgb2YgIk1pZ3JhdGlvbg0KPmRpc2Fi
bGVkIg0KPg0KPk9uIFRodSwgMjkgSnVuIDIwMjMgMTY6NDI6MjMgKzAxMDANCj5Kb2FvIE1hcnRp
bnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+IHdyb3RlOg0KPg0KPj4gT24gMjkvMDYvMjAy
MyAxNjoyMCwgQXZpaGFpIEhvcm9uIHdyb3RlOg0KPj4gPiBPbiAyOS8wNi8yMDIzIDE1OjQ0LCBK
b2FvIE1hcnRpbnMgd3JvdGU6DQo+PiA+PiBPbiAyOS8wNi8yMDIzIDA5OjQwLCBaaGVuemhvbmcg
RHVhbiB3cm90ZToNCi4uLg0KPj4gPj4+IEBAIC00MDMsOSArNDAyLDE1IEBAIGludA0KPj4gPj4+
IHZmaW9fYmxvY2tfbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb24oVkZJT0RldmljZQ0KPj4gPj4+
ICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4gPj4+IMKgwqDCoMKgwqAgaWYgKHJldCA8IDAp
IHsNCj4+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgZXJyb3JfZnJlZShtdWx0aXBsZV9kZXZpY2Vz
X21pZ3JhdGlvbl9ibG9ja2VyKTsNCj4+ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgbXVsdGlwbGVf
ZGV2aWNlc19taWdyYXRpb25fYmxvY2tlciA9IE5VTEw7DQo+PiA+Pj4gK8KgwqDCoCB9IGVsc2Ug
ew0KPj4gPj4+ICvCoMKgwqDCoMKgwqDCoCAvKg0KPj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgICog
T25seSBPTl9PRkZfQVVUT19BVVRPIGNhc2UsIE9OX09GRl9BVVRPX09GRiBpcyBjaGVja2VkDQo+
PiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKiBpbiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkuDQo+
PiA+Pj4gK8KgwqDCoMKgwqDCoMKgwqAgKi8NCj4+ID4+PiArwqDCoMKgwqDCoMKgwqAgd2Fybl9y
ZXBvcnQoIk1pZ3JhdGlvbiBkaXNhYmxlZCwgbm90IHN1cHBvcnQgbXVsdGlwbGUNCj4+ID4+PiAr
VkZJTyBkZXZpY2VzIik7DQo+PiA+Pj4gwqDCoMKgwqDCoCB9DQo+PiA+Pj4NCj4+ID4+IFBlcmhh
cHMgeW91IGNvdWxkIHN0YXNoIHRoZSBwcmV2aW91cyBlcnJvciBtZXNzYWdlIGFuZCB1c2UgaXQg
aW4NCj4+ID4+IHRoZSB3YXJuX3JlcG9ydF9lcnJvciB0byBjb25zb2xpZGF0ZSB0aGUgZXJyb3Ig
bWVzc2FnZXMgZS5nLg0KPj4gPj4NCj4+ID4+IGJvb2wgdmZpb19ibG9ja19tdWx0aXBsZV9kZXZp
Y2VzX21pZ3JhdGlvbihWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ID4+IEVycm9yICoqZXJycCkg
ew0KPj4gPj4gwqDCoMKgwqAgRXJyb3IgKmVyciA9IE5VTEw7DQo+PiA+Pg0KPj4gPj4gwqDCoMKg
wqAgaWYgKG11bHRpcGxlX2RldmljZXNfbWlncmF0aW9uX2Jsb2NrZXIgfHwNCj4+ID4+IMKgwqDC
oMKgwqDCoMKgwqAgdmZpb19taWdyYXRhYmxlX2RldmljZV9udW0oKSA8PSAxKSB7DQo+PiA+PiDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiB0cnVlOw0KPj4gPj4gwqDCoMKgwqAgfQ0KPj4gPj4NCj4+
ID4+IMKgwqDCoMKgIGVycm9yX3NldGcoJmVyciwgIiVzOiBNaWdyYXRpb24gaXMgY3VycmVudGx5
IG5vdCBzdXBwb3J0ZWQgd2l0aA0KPm11bHRpcGxlICINCj4+ID4+IMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAiVkZJTyBkZXZpY2VzIiwgdmJhc2VkZXYtPm5hbWUp
Ow0KPj4gPj4NCj4+ID4+IMKgwqDCoMKgIGlmICh2YmFzZWRldi0+ZW5hYmxlX21pZ3JhdGlvbiA9
PSBPTl9PRkZfQVVUT19PTikgew0KPj4gPj4gwqDCoMKgwqDCoMKgwqDCoCBlcnJvcl9wcm9wYWdh
dGUoZXJycCwgZXJyKTsNCj4+ID4+IMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5WQUw7DQo+
PiA+PiDCoMKgwqDCoCB9DQo+PiA+Pg0KPj4gPj4gwqDCoMKgwqAgLi4uDQo+PiA+PiDCoMKgwqDC
oCBpZiAocmV0IDwgMCkgew0KPj4gPj4gwqDCoMKgwqAgfSBlbHNlIHsNCj4+ID4+IMKgwqDCoMKg
wqDCoMKgwqAgLyogV2FybnMgb25seSBvbiBPTl9PRkZfQVVUT19BVVRPIGNhc2UgKi8NCj4+ID4+
IMKgwqDCoMKgwqDCoMKgwqAgd2Fybl9yZXBvcnRfZXJyKGVycik7DQo+PiA+DQo+PiA+IEknbSBu
b3Qgc3VyZSB0aGlzIHdhcm5pbmcgaXMgbmVlZGVkLg0KPj4gPiBJZiBJIHJlbWVtYmVyIGNvcnJl
Y3RseSwgSSB0aGluayBBbGV4IGRpZG4ndCB3YW50IG1pZ3JhdGlvbg0KPj4gPiBlcnJvci93YXJu
aW5nIG1lc3NhZ2VzIHRvIGJlIGxvZ2dlZCBpbiB0aGUgQVVUTyBjYXNlLg0KPg0KPkNvcnJlY3Qu
DQo+DQo+PiBIbW0sIG9rLCBJIG1pc3NlZCB0aGlzIGZyb20gdGhlIHByZXZpb3VzIGRpc2N1c3Np
b25zLg0KPj4NCj4+IFNvIHRvZGF5IHRoZXJlIGFyZSBtaWdyYXRpb24gd2FybmluZ3MgaW4gdGhl
IGN1cnJlbnQgY29kZS4gKGV2ZW4gaW4NCj4+IHRoZSBBVVRPIGNhc2UpLiBTbyBpZiB3ZSB3YW50
IHRoZW0gcmVtb3ZlZCwgdGhlbiB0aGlzIHBhdGNoIHdvdWxkIHRoZW4NCj4+IGp1c3QgcmVtb3Zl
IHRoZSAiTWlncmF0aW9uIGRpc2FibGVkIiBhbGwgdG9nZXRoZXIgKGluIHRoZSB0d28gcGxhY2Vz
IHdlDQo+Y29tbWVudGVkKS4NCj4+DQo+PiBUaGUgcmVzdCBvZiB0aGUgY2FzZXMgYWxyZWFkeSBw
cm9wYWdhdGUgdGhlIGVycm9yIEkgdGhpbmsuIEFuZCB0aGUNCj4+IEFVVE8gY2FzZSB3aWxsIGFs
d2F5cyBiZSBibG9ja2VkIG1pZ3JhdGlvbiBhbmQgc2VlIHRoZSBzYW1lIHByaW50ZWQNCj5tZXNz
YWdlcyBlbHNld2hlcmUuDQo+DQo+SSB0ZXN0ZWQgdGhpcyB3aXRoIEF2aWhhaSdzIHNlcmllcyBh
bmQgc2F3IHRoZSBjb3JyZWN0IGxvZ2dpbmcsIGF0IGxlYXN0IGZvciBhDQo+ZGV2aWNlIHRoYXQg
ZG9lcyBub3Qgc3VwcG9ydCBtaWdyYXRpb24uDQo+DQo+SW4gQVVUTyBtb2RlLCB3ZSBzaG91bGQg
b25seSBldmVyIHNlZSBlcnJvcnMgb3Igd2FybmluZ3MgaWYgdGhlIGRldmljZQ0KPnN1cHBvcnRz
IG1pZ3JhdGlvbiBhbmQgYW4gZXJyb3Igb3IgaW5jb21wYXRpYmlsaXR5IG9jY3VycyB3aGlsZSBm
dXJ0aGVyDQo+cHJvYmluZyBvciBjb25maWd1cmluZyBpdC4gIExhY2sgb2Ygc3VwcG9ydCBmb3Ig
bWlncmF0aW9uIHNob3VsZCBvbmx5IGV2ZXINCj5nZW5lcmF0ZSBhbiBlcnJvciBvciB3YXJuaW5n
IHdoZW4gdXNpbmcgZW5hYmxlX21pZ3JhdGlvbj1vbiBvciB0aGUgZ2xvYmFsIC0NCj5vbmx5LW1p
Z3JhdGFibGUgZmxhZy4NCldpbGwgcmVtb3ZlIHRoZSB0d28gcGxhY2VzIG9mICJNaWdyYXRpb24g
ZGlzYWJsZWQiIHByaW50Lg0KDQo+DQo+QXMgSSB1bmRlcnN0b29kIEF2aWhhaSdzIHBhdGNoLCB3
ZSdyZSBwb3B1bGF0aW5nIHRoZSBFcnJvciBwb2ludGVyLCBidXQgd2UNCj5vbmx5IGV2ZXIgcHJv
cGFnYXRlIHRoYXQgZXJyb3IgaW4gdGhlIGFib3ZlIGNhc2VzLiAgVGhhbmtzLA0KPg0KPkFsZXgN
Cj4NCi4uLg0KPj4gPj4+ICs4MTgsMTEgQEAgc3RhdGljIGludCB2ZmlvX2Jsb2NrX21pZ3JhdGlv
bihWRklPRGV2aWNlICp2YmFzZWRldiwNCj4+ID4+PiBFcnJvciAqZXJyLCBFcnJvciAqKmVycnAp
DQo+PiA+Pj4gwqDCoMKgwqDCoCBpZiAocmV0IDwgMCkgew0KPj4gPj4+IMKgwqDCoMKgwqDCoMKg
wqDCoCBlcnJvcl9mcmVlKHZiYXNlZGV2LT5taWdyYXRpb25fYmxvY2tlcik7DQo+PiA+Pj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHZiYXNlZGV2LT5taWdyYXRpb25fYmxvY2tlciA9IE5VTEw7DQo+PiA+
Pj4gK8KgwqDCoCB9IGVsc2UgaWYgKHZiYXNlZGV2LT5lbmFibGVfbWlncmF0aW9uICE9IE9OX09G
Rl9BVVRPX09GRikgew0KPj4gPj4+ICvCoMKgwqDCoMKgwqDCoCB3YXJuX3JlcG9ydCgiJXM6IE1p
Z3JhdGlvbiBkaXNhYmxlZCIsIHZiYXNlZGV2LT5uYW1lKTsNCj4+ID4+PiDCoMKgwqDCoMKgIH0N
Cj4+ID4+Pg0KPj4gPj4gUGVyaGFwcyB5b3UgY2FuIHVzZSB0aGUgdGhlIGxvY2FsIGVycm9yIHRv
IGV4cGFuZCBvbiB3aHkgbWlncmF0aW9uDQo+PiA+PiB3YXMgZGlzYWJsZWQgZS5nLg0KPj4gPj4N
Cj4+ID4+IMKgwqDCoMKgwqDCoMKgwqAgd2Fybl9yZXBvcnRfZXJyKGVycik7DQo+PiA+DQo+PiA+
IFNhbWUgaGVyZS4NCj4+ID4NCj4+ID4gVGhhbmtzLg0KPj4gPg0KPj4gPj4NCj4+ID4+PiAtwqDC
oMKgIHJldHVybiByZXQ7DQo+PiA+Pj4gK8KgwqDCoCByZXR1cm4gIXJldDsNCj4+ID4+PiDCoCB9
DQo+PiA+Pj4NCj4+ID4+PiDCoCAvKg0KPj4gPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPj4gPj4+IC0tLS0gKi8g
QEAgLTgzNSw3ICs4MzcsMTIgQEAgdm9pZA0KPj4gPj4+IHZmaW9fcmVzZXRfYnl0ZXNfdHJhbnNm
ZXJyZWQodm9pZCkNCj4+ID4+PiDCoMKgwqDCoMKgIGJ5dGVzX3RyYW5zZmVycmVkID0gMDsNCj4+
ID4+PiDCoCB9DQo+PiA+Pj4NCj4+ID4+PiAtaW50IHZmaW9fbWlncmF0aW9uX3JlYWxpemUoVkZJ
T0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+ID4+PiArLyoNCj4+ID4+PiArICog
UmV0dXJuIHRydWUgd2hlbiBlaXRoZXIgbWlncmF0aW9uIGluaXRpYWxpemVkIG9yIGJsb2NrZXIg
cmVnaXN0ZXJlZC4NCj4+ID4+PiArICogQ3VycmVudGx5IG9ubHkgcmV0dXJuIGZhbHNlIHdoZW4g
YWRkaW5nIGJsb2NrZXIgZmFpbHMgd2hpY2gNCj4+ID4+PiArd2lsbA0KPj4gPj4+ICsgKiBkZS1y
ZWdpc3RlciB2ZmlvIGRldmljZS4NCj4+ID4+PiArICovDQo+PiA+Pj4gK2Jvb2wgdmZpb19taWdy
YXRpb25fcmVhbGl6ZShWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4gPj4+
IMKgIHsNCj4+ID4+PiDCoMKgwqDCoMKgIEVycm9yICplcnIgPSBOVUxMOw0KPj4gPj4+IMKgwqDC
oMKgwqAgaW50IHJldDsNCj4+ID4+PiBAQCAtODczLDE4ICs4ODAsMTcgQEAgaW50IHZmaW9fbWln
cmF0aW9uX3JlYWxpemUoVkZJT0RldmljZQ0KPj4gPj4+ICp2YmFzZWRldiwgRXJyb3INCj4+ID4+
PiAqKmVycnApDQo+PiA+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIHZiYXNlZGV2LT5uYW1lKTsNCj4+ID4+PiDCoMKgwqDCoMKgIH0NCj4+ID4+Pg0KPj4gPj4+
IC3CoMKgwqAgcmV0ID0gdmZpb19ibG9ja19tdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlvbih2YmFz
ZWRldiwgZXJycCk7DQo+PiA+Pj4gLcKgwqDCoCBpZiAocmV0KSB7DQo+PiA+Pj4gLcKgwqDCoMKg
wqDCoMKgIHJldHVybiByZXQ7DQo+PiA+Pj4gK8KgwqDCoCBpZiAoIXZmaW9fYmxvY2tfbXVsdGlw
bGVfZGV2aWNlc19taWdyYXRpb24odmJhc2VkZXYsIGVycnApKSB7DQo+PiA+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybiBmYWxzZTsNCj4+ID4+PiDCoMKgwqDCoMKgIH0NCj4+ID4+Pg0KPj4gPj4+
IC3CoMKgwqAgcmV0ID0gdmZpb19ibG9ja19naW9tbXVfbWlncmF0aW9uKHZiYXNlZGV2LCBlcnJw
KTsNCj4+ID4+PiAtwqDCoMKgIGlmIChyZXQpIHsNCj4+ID4+PiAtwqDCoMKgwqDCoMKgwqAgcmV0
dXJuIHJldDsNCj4+ID4+PiArwqDCoMKgIGlmICh2ZmlvX3Zpb21tdV9wcmVzZXQodmJhc2VkZXYp
KSB7DQo+PiA+PiBUaGUgLyogQmxvY2sgbWlncmF0aW9uIHdpdGggYSB2SU9NTVUgKi8NCj4+ID4+
DQo+PiA+PiBXb3VsZCBnbyBhYm92ZSwgYnV0IEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBpdCBhbnlt
b3JlIC4uLg0KV2lsbCByZW1vdmUgaXQuDQoNCj4+ID4+DQo+PiA+Pj4gK8KgwqDCoMKgwqDCoMKg
IGVycm9yX3NldGcoJmVyciwgIiVzOiBNaWdyYXRpb24gaXMgY3VycmVudGx5IG5vdCBzdXBwb3J0
ZWQgIg0KPj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgIndpdGgg
dklPTU1VIGVuYWJsZWQiLCB2YmFzZWRldi0+bmFtZSk7DQo+PiA+Pj4gK8KgwqDCoMKgwqDCoMKg
IHJldHVybiB2ZmlvX2Jsb2NrX21pZ3JhdGlvbih2YmFzZWRldiwgZXJyLCBlcnJwKTsNCj4+ID4+
IC4uLiBhcyB0aGUgZXJyb3IgbWVzc2FnZSB3aGVuIHBsYWNlZCBoZXJlIG1ha2VzIGl0IG9idmlv
dXMuIFNvIHRoZQ0KPj4gPj4gY29tbWVudCBJIHN1Z2dlc3RlZCB3b24ndCBhZGQgbXVjaC4gVW5s
ZXNzIG90aGVycyBkaXNhZ3JlZS4NCj4+ID4+DQo+PiA+Pj4gwqDCoMKgwqDCoCB9DQo+PiA+Pj4N
Cj4+ID4+PiAtwqDCoMKgIHRyYWNlX3ZmaW9fbWlncmF0aW9uX3JlYWxpemUodmJhc2VkZXYtPm5h
bWUpOw0KPj4gPj4+IC3CoMKgwqAgcmV0dXJuIDA7DQo+PiA+Pj4gK8KgwqDCoCByZXR1cm4gdHJ1
ZTsNCj4+ID4+PiDCoCB9DQo+PiA+Pj4NCj4+ID4+IEkgdGhpbmsgc29tZXdoZXJlIGluIGZ1bmN0
aW9uIHdlIHNob3VsZCBoYXZlIHZmaW9fbWlncmF0aW9uX2V4aXQoKQ0KPj4gPj4gYmVpbmcgY2Fs
bGVkIGJlaGluZCBhIGxhYmVsIG9yIGVsc2V3aGVyZSBmcm9tDQo+PiA+PiB2ZmlvX21pZ3JhdGlv
bl9yZWFsaXplICguLi4pDQo+PiA+Pg0KPj4gPj4+IMKgIHZvaWQgdmZpb19taWdyYXRpb25fZXhp
dChWRklPRGV2aWNlICp2YmFzZWRldikgZGlmZiAtLWdpdA0KPj4gPj4+IGEvaHcvdmZpby9wY2ku
YyBiL2h3L3ZmaW8vcGNpLmMgaW5kZXggZGM2OWQzMDMxYjI0Li4xODRkMDg1NjgxNTQNCj4+ID4+
PiAxMDA2NDQNCj4+ID4+PiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+PiA+Pj4gKysrIGIvaHcvdmZp
by9wY2kuYw0KPj4gPj4+IEBAIC0zMjA5LDcgKzMyMDksOCBAQCBzdGF0aWMgdm9pZCB2ZmlvX3Jl
YWxpemUoUENJRGV2aWNlICpwZGV2LA0KPj4gPj4+IEVycm9yICoqZXJycCkNCj4+ID4+PiDCoMKg
wqDCoMKgIGlmICghcGRldi0+ZmFpbG92ZXJfcGFpcl9pZCkgew0KPj4gPj4+IMKgwqDCoMKgwqDC
oMKgwqDCoCByZXQgPSB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKHZiYXNlZGV2LCBlcnJwKTsNCj4+
ID4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKHJldCkgew0KPj4gPj4+IC3CoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGVycm9yX3JlcG9ydCgiJXM6IE1pZ3JhdGlvbiBkaXNhYmxlZCIsDQo+PiA+Pj4g
dmJhc2VkZXYtPm5hbWUpOw0KPj4gPj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHRyYWNlX3Zm
aW9fbWlncmF0aW9uX3JlYWxpemUodmJhc2VkZXYtPm5hbWUpOw0KPj4gPj4+ICvCoMKgwqDCoMKg
wqDCoCB9IGVsc2Ugew0KPj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gb3V0
X3ZmaW9fbWlncmF0aW9uOw0KPj4gPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+PiA+Pj4gwqDC
oMKgwqDCoCB9DQo+PiA+PiAoLi4uKSBXaGljaCB0aGVuIHZvaWQgdGhlIG5lZWQgZm9yIHRoaXMg
Y2hhbmdlLiBQZXJoYXBzIHlvdXINCj4+ID4+IHByZXZpb3VzIHBhdGNoDQo+PiA+PiAoNC81KSBj
b3VsZCBjb21lIGFmdGVyIHRoaXMgcmVmYWN0b3IgcGF0Y2ggaW5zdGVhZCAuLi4gd2hlcmUgeW91
DQo+PiA+PiB3b3VsZCBmaXggdGhlIHVud2luZGluZyBlcnJvciBwYXRoIGluc2lkZSB0aGUNCj4+
ID4+IHZmaW9fbWlncmF0aW9uX3JlYWxpemUoKSBhcyBvcHBvc2VkIHRvIHZmaW9fcmVhbGl6ZSgp
Lg0KU3VyZSwgd2lsbCBmaXguDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

