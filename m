Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF206728EC7
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 06:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7TKN-0003eN-Pq; Fri, 09 Jun 2023 00:02:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7TKK-0003dl-Tm
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 00:02:17 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7TK7-0000oz-E5
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 00:02:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686283323; x=1717819323;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EoCNjSvnTn0iPffayPIimjRROxo7mttIfHop7mVaMqA=;
 b=nLs9Bps3LhNF1SUAA/W/Nb7o47fIKdQ5a2GPtm/eey8SkmwuZJcaG9qv
 JU+VNu7vLES8XrVw2K2iGwuYUu2xPbFiD1n9UrmepWN/Ovt835vYp/Gqr
 SBC0lYb2RqPGrR2qav1j4svtLRiETDSh4T2PuahdSpycuPvbsi4CUeiHW
 LSqKK99jCISQaCUyw97uN0MGOUU03BCuJykt2JzLfYp8gXC9jZNi+Z5LX
 fpXXqxjPRge4MIDvCQ/m4c/vCdP2TSAQLDkqWmnsT98QpOJORm3KmFqFd
 cloiwMNsALOgNwHfnoE/+2FMRHD8sokm50YjUxbqOIkCiA03Bw4W4Z7w0 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="342181668"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="342181668"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 21:01:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="740021631"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="740021631"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga008.jf.intel.com with ESMTP; 08 Jun 2023 21:01:34 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 21:01:33 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 21:01:33 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 21:01:33 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 21:01:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tjm0pZ+0kRT1MA86e12bALlapN7EZMdcValLLsyXsIUT80wy5vuRUR9dWfOQ9anvQmursZ2Q86jymoB1vuti/A3VGv7bd0s5fbJWIgIlMIQtfmQ7nXbLEvPwiuU5edL3iuGSDGo3CNnAo0+Ss38QzGVJ+9blmOxMPRB+RGA7V+5Gi9k+fjlkUbrujcTiJWbCR0om5Jowrdrws/XRzWUUVdQ5APvmc4BI7fY9NmdZ5vmIqiSnSnQDYogQPrGP76fI/w7f/yy5hbeQm3M1RzWATG/LmuF0a0+MTGNXUFFgWtXTgmNNXrlVyKC8b5c8ckB/VHvWAWPjWkiVIvNRgVZFlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EoCNjSvnTn0iPffayPIimjRROxo7mttIfHop7mVaMqA=;
 b=R936X5c84tKNWbqZfph1nb8Jvp1LKy1ZKxq1DwHqcl0LoNl1YgBMSFNqpb1LyN+kWFwjlnbgi50hpoMWLpDYye+kEhIg+qU2OhtXuLwvpQA7ooB5brly0xclkcs6xxfIhtk9NA+hjB8W13kP2ar/Ed/LscQ+7rPX4WyJaJC0UPHtpFaisN6iY2Keq9NUeU43R0YlKyLE4hG+6j9beVYlzEzIu+XVEmUu7FyzHrH5Y4ijLZlj//70pRXerLXg2Dc8t33BuL0LGpK8F1NKPXg2JwsemVD4xAi3G/7h+Gf0OjFMOjhhfZUDFJtNQecTtY96HlCXoIcfeYhnevVFIKpy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BL1PR11MB5956.namprd11.prod.outlook.com (2603:10b6:208:387::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 04:01:32 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 04:01:32 +0000
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
Subject: RE: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Topic: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+BXVuAgAB4mHA=
Date: Fri, 9 Jun 2023 04:01:32 +0000
Message-ID: <SJ0PR11MB6744CBC59B0BE971EE24D3799251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZII7UyaKrArIM5Qg@x1n>
In-Reply-To: <ZII7UyaKrArIM5Qg@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BL1PR11MB5956:EE_
x-ms-office365-filtering-correlation-id: c1eee8e6-c64a-4eb1-8834-08db689e361d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rcw00+q6yAzq1XL5+oUwijHWgPu3AdkzJiJM04gnBUjp8HfcCW5qXPJygcoY+twt2C7nL8xhA9mA7JWhiNW8W/dRtx9LUDf1auy+3mgIfJtFlJguOoa34GxK5jdXFqATdDhPo/cL84Wi5Lyxnf1qUY1R5vnBPaXr88vq9befgIWalV+zBJqWJ/0aopTjir9gRvbeqsW6lTDWCOo5REGdez0OVxKPRWjVHDMtLZQoW7QUbe9DteCppVQyo5wiEiG6KLFYN+VNrBGmwTeHPSBxo1GZuIYcu3y4W5Vj+OLj5hplH0C4mUl8nQl0wpIpt0Om3Ba7ARv8aBtTwnHDJ18RHLFN4nZGxg35t1vNR7wpSd8xIMXuMHTs1PEDpqyX4o0pSO8FrtV1pGj1o6H0rLRaj+PTycMq3lHvKfvHL2hQV3vPpru3PRQlK+HqaQSGYsNPIfLMFmHWlv8OvJBczuJvqC1QQimZ9FMB/o5cOwMV8BQ4bv36XYSz6A9CnnO3YSSmHEOLgUSE/rWbB68lhOi1JhFQC5RFjicB6+pfAYpsfk4CQAUWMYSm4tedutvVJEAI2/Lu9wlPzaRXAwIKkoCtyOoQKLVT9AjGjwGuMNSjTJkqDivaiAsxEdhe7pSsi8RL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(107886003)(9686003)(26005)(6506007)(186003)(38100700002)(83380400001)(122000001)(82960400001)(33656002)(86362001)(38070700005)(55016003)(8676002)(41300700001)(54906003)(66446008)(478600001)(66946007)(6916009)(4326008)(66476007)(76116006)(2906002)(64756008)(8936002)(316002)(52536014)(5660300002)(7416002)(7696005)(71200400001)(66556008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVdnUkIweXhBei9KYmdNcUFMR3RQRTVlVzA1blFzYjI5cUs0MGdmMVFGWWE4?=
 =?utf-8?B?QzNSMStic3VrRHRjK1laS1FvODUrWjVxWHJ2L2NkMnY3eVhiYVBmdXFiVkh4?=
 =?utf-8?B?M3NoaDJTRE9MWUxNVm5odjhSbSs2dFphV1dCaVpnT0JLNkI3UHZpR1VjbGEv?=
 =?utf-8?B?TUxrZGRQZ3pWOUFTL3BCeXhTTE5WVDI2SWZLZ3lVb2dHQ1dkVjlzcTZOdHVZ?=
 =?utf-8?B?UFNMazJXT0VDLzlRbWlhNjdDRWVSTTBlWjlaZ1RQSTM1VktUcHJra3Vkb0sr?=
 =?utf-8?B?MVUrcjV1dzNkNUIwaXdmUWlwNFZlUWltak80akxKSGdwU0Nqd0xrTWNMRE94?=
 =?utf-8?B?S1VyUUtINkRuUkxzazc4dU42ZlpIY1NyRElIY0kwdkNMMTJiYmNrOEkvY21H?=
 =?utf-8?B?YmIzaklQTHhsRXdacGY1Y09VZW9YL1lMT0RqOFBFSHNDbk9vTU14UTdtc2lL?=
 =?utf-8?B?bjMyQ3BVR0RKQjA2WllGM01raFdzNnBaL2VlaTM1dXVWSHVvRUpndnU3c2hL?=
 =?utf-8?B?U2FJUjBuL1BSbnVEQXcrQ3JZanFTSFBkdjRmL1lqMGNuQ3I2cjV4ODMyU3Rw?=
 =?utf-8?B?aHRKWHN3OEpwS2hZUUZIMmlnU0Z2eW5NWWgrVlFyeGo1dk13MEtOcjJDSmNU?=
 =?utf-8?B?aklPdUt5aHJWZnZVV0c2b2h2Q24zQWJNMURyV3ZhbVJBL2xTek1vUlNmYW5K?=
 =?utf-8?B?L2dJeC9UdjZNT0J0YnBrZXBWYmxoY2lYNUxEai9NLytDYWtRaW1lZTVSellS?=
 =?utf-8?B?bWpTTFF3SWozNVJYd0VESUx4blhHcFQzY1hIVEsrUGlEcE9wU2VwajBwOE5J?=
 =?utf-8?B?UEx2bXdFc1hzSVJJMzlpQnF0eUp4LzBJaHE5MVM1UWl6TVBIYTkvMmZma0t6?=
 =?utf-8?B?ZS95Qk53d2F3a1hhdzk2dW5TaTkrYUl5R21OS0ZQeUw5SWR1U2JEWDBidTVZ?=
 =?utf-8?B?eWF1TXZWcEg1bGdhRm1iK28zaXBxeTRSTW5qODN2NDYyZ1JoZWNlcWJaS2dB?=
 =?utf-8?B?ZnJ1ek1YeVpZREVsWE5hbWI5djI3RlJiMGpKWFlTZlZrWnV1TDY4UTEwYW5Q?=
 =?utf-8?B?VFhYQXEyZkRyTERpcFNOUzdKZHFhOUs1cTYweW5PSnFIT1IvSVJNU3o3L2tZ?=
 =?utf-8?B?TDRxaVNGNlFqNjlMR0JmcU5LZzhvdlJSWUJ5SHExdHdGMzB0bFdaQXlIN3N6?=
 =?utf-8?B?MkNIbEUvYkhJMFI5blk3VXQ0V0Q3RHNscy90aThJRzZyOFVjSlhWZytQdnFy?=
 =?utf-8?B?WS9hNCtxWE40emY0OWdQL1hObTZ3MlpaZkdYbWJvUHUvVVBVL1hEaENmRlRn?=
 =?utf-8?B?VEJrdEtianNIRENNdG1FVS9mdVhzUS94dTJDK0pJL1k5Tzl5UDNyM1VyRzRJ?=
 =?utf-8?B?cEE3dHcvdHlGamdudFUzZXdmUTl6MjJlVVVNaUJ2REI0TVNIRDRuZDNCcTNl?=
 =?utf-8?B?K3dTUE5mbzlyTkxLSGt1MEp0Y3JjSnJXVjA2cEdtbWU2Tnp1a1pHbFdJUFU1?=
 =?utf-8?B?YmhaMG1EWHc3SDdpekFnaUIvenNOeVlHS0ppOFdLSlNsWExDYStuWjNxZVhB?=
 =?utf-8?B?Z2RwSzZ1Ni8vR0RGSlM3Y0Z6Z3cyVVBoNm1ISXR5YWZSa01zUTROWHQ5c3gx?=
 =?utf-8?B?TmlxRnplMGNQWlJ5Z1MvUFhZU1FRbENoQnQ2RC92K202aHRaMm55UUhRbTh6?=
 =?utf-8?B?SXJzY2RoeFhtdGJ0T28wTlJSQXFId0V5TFprakdTNUFlNlJUeE9paXFnb1ND?=
 =?utf-8?B?bUo5TXdjcGVmOFRlamY2VlhjNmhGcEEzYXZ2bnZ1YmFrdUFFSHVLVjY1bmtq?=
 =?utf-8?B?UU5YdUpQa2k5UGZzb3AxaExZaCtDb3hMcmNOWjlkMTFqTFZMczQwck5CeFhq?=
 =?utf-8?B?amlSMXhZREloS2ZiWXAvVFNxUGV0bm9VUWhmNk85eml4blFITnpSS2lZOUM1?=
 =?utf-8?B?N0dDQ01qdFVZZ3ZobjZvQTNMeTZmZUtqckdta3NOTWZuYU8zR1RiUkNlcFkw?=
 =?utf-8?B?NGVGTldBd0ZqSFRxYnBUZGhCRXpvZkhRVXFWejhaUGpZWjUva1JGYnRRWHVz?=
 =?utf-8?B?TVRGOUV1MHRQRXRHeWlRZHJlTWNwaEgxcy9pTkVxb3pmb3JjaHNmdWV6ck5O?=
 =?utf-8?Q?sNMuhDagTzMkPakH1z/F5NYjJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1eee8e6-c64a-4eb1-8834-08db689e361d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 04:01:32.4891 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uj/mYP3uuJPTmdPUKtsncaAav7T24fireB0jfodqM/V5Jmc+sCrlFGr7zxUB7n2QXO281FeFc1+Df9N17+1SzmiG0aXQKWoKCcel5OqNWYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5956
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mga18.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIEp1bmUgOSwgMjAyMyA0OjM0IEFNDQo+VG86IER1
YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPkNjOiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IG1zdEByZWRoYXQuY29tOyBqYXNvd2FuZ0ByZWRoYXQuY29tOw0KPnBib256
aW5pQHJlZGhhdC5jb207IHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5vcmc7IGVkdWFyZG9AaGFi
a29zdC5uZXQ7DQo+bWFyY2VsLmFwZmVsYmF1bUBnbWFpbC5jb207IGFsZXgud2lsbGlhbXNvbkBy
ZWRoYXQuY29tOw0KPmNsZ0ByZWRoYXQuY29tOyBkYXZpZEByZWRoYXQuY29tOyBwaGlsbWRAbGlu
YXJvLm9yZzsNCj5rd2Fua2hlZGVAbnZpZGlhLmNvbTsgY2ppYUBudmlkaWEuY29tOyBMaXUsIFlp
IEwgPHlpLmwubGl1QGludGVsLmNvbT47IFBlbmcsDQo+Q2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRl
bC5jb20+DQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyA1LzVdIGludGVsX2lvbW11OiBPcHRpbWl6
ZSBvdXQgc29tZSB1bm5lY2Vzc2FyeQ0KPlVOTUFQIGNhbGxzDQo+DQo+T24gVGh1LCBKdW4gMDgs
IDIwMjMgYXQgMDU6NTI6MzFQTSArMDgwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiAgICAg
IHdoaWxlIChyZW1haW4gPj0gVlREX1BBR0VfU0laRSkgew0KPj4gLSAgICAgICAgSU9NTVVUTEJF
dmVudCBldmVudDsNCj4+ICAgICAgICAgIHVpbnQ2NF90IG1hc2sgPSBkbWFfYWxpZ25lZF9wb3cy
X21hc2soc3RhcnQsIGVuZCwgcy0+YXdfYml0cyk7DQo+PiAgICAgICAgICB1aW50NjRfdCBzaXpl
ID0gbWFzayArIDE7DQo+Pg0KPj4gICAgICAgICAgYXNzZXJ0KHNpemUpOw0KPj4NCj4+IC0gICAg
ICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9VTk1BUDsNCj4+IC0gICAgICAgIGV2ZW50
LmVudHJ5LmlvdmEgPSBzdGFydDsNCj4+IC0gICAgICAgIGV2ZW50LmVudHJ5LmFkZHJfbWFzayA9
IG1hc2s7DQo+PiAtICAgICAgICBldmVudC5lbnRyeS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFj
ZV9tZW1vcnk7DQo+PiAtICAgICAgICBldmVudC5lbnRyeS5wZXJtID0gSU9NTVVfTk9ORTsNCj4+
IC0gICAgICAgIC8qIFRoaXMgZmllbGQgaXMgbWVhbmluZ2xlc3MgZm9yIHVubWFwICovDQo+PiAt
ICAgICAgICBldmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPj4gLQ0KPj4gLSAgICAg
ICAgbWVtb3J5X3JlZ2lvbl9ub3RpZnlfaW9tbXVfb25lKG4sICZldmVudCk7DQo+PiArICAgICAg
ICBtYXAuaW92YSA9IHN0YXJ0Ow0KPj4gKyAgICAgICAgbWFwLnNpemUgPSBtYXNrOw0KPj4gKyAg
ICAgICAgaWYgKGlvdmFfdHJlZV9maW5kKGFzLT5pb3ZhX3RyZWUsICZtYXApKSB7DQo+PiArICAg
ICAgICAgICAgZXZlbnQuZW50cnkuaW92YSA9IHN0YXJ0Ow0KPj4gKyAgICAgICAgICAgIGV2ZW50
LmVudHJ5LmFkZHJfbWFzayA9IG1hc2s7DQo+PiArICAgICAgICAgICAgbWVtb3J5X3JlZ2lvbl9u
b3RpZnlfaW9tbXVfb25lKG4sICZldmVudCk7DQo+PiArICAgICAgICB9DQo+DQo+QWggb25lIG1v
cmUgdGhpbmc6IEkgdGhpbmsgdGhpcyBwYXRoIGNhbiBhbHNvIGJlIHRyaWdnZXJlZCBieSBub3Rp
ZmllcnMgd2l0aG91dA0KPk1BUCBldmVudCByZWdpc3RlcmVkLCB3aG9zZSBpb3ZhIHRyZWUgd2ls
bCBhbHdheXMgYmUgZW1wdHkuICBTbyB3ZSBtYXkgb25seQ0KPmRvIHRoaXMgZm9yIE1BUCwgdGhl
biBJJ20gbm90IHN1cmUgd2hldGhlciBpdCdsbCBiZSB3b3J0aHdoaWxlLi4NCg0KSG1tLCB5ZXMs
IG15IGNoYW5nZSB3aWxsIGxlYWQgdG8gdmhvc3QgbWlzc2VkIHRvIHJlY2VpdmUgc29tZSBpbnZh
bGlkYXRpb24gcmVxdWVzdCBpbiBkZXZpY2UtdGxiIGRpc2FibGVkIGNhc2UgYXMgaW92YSB0cmVl
IGlzIGVtcHR5LiBUaGFua3MgZm9yIHBvaW50IG91dC4NCg0KTGV0IG1lIGNvbGxlY3QgdGltZSBk
aWZmIHNwZW50IGluIHVubWFwIEFTIGZvciB5b3UgdG8gZGVjaWRlIGlmIGl0IHN0aWxsIHdvcnRo
IG9yIG5vdC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCiANCg==

