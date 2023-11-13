Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EC77E9566
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 04:19:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2NSm-0002qb-GC; Sun, 12 Nov 2023 22:18:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2NSj-0002qK-LN
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 22:18:09 -0500
Received: from mgamail.intel.com ([198.175.65.9])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r2NSg-0001mp-PD
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 22:18:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699845486; x=1731381486;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=s67Rx3ARmL6daxq50g2Kw9u+JLUaUrr6ED7hf8I7iMw=;
 b=YPM0c70u3+RD3Nl2VKjNtwItbtEdYPSZUevvcgsHcyAI/4KxgUnWhkpp
 cO+lHtdmJqJsltgWjF2gY5qSyGuDGH4hn13ZDyKAk1aj9S/wK/n0FKG9p
 ZuR2SECXueALTA5qLEcgcM9rtTc6qDE+aVyVNPAKCSjhcJMCImS0wxA08
 vrntqKnVXKwEOGz1imzJlPRAi3uk6fceJx4DP4BBJM7ZyQFD9/Y55c4hy
 eTIMZg4YTmtI2zUD/b0U0sJH4bCPiLt3n9U/YvLoW1tunQeGAl5LS7cQ3
 iwoU66i+bFsDq8HF9/tM75dYpuR8DJs5F58MrQjxg/qdt9ciNt3aDcUDu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9015922"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="9015922"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Nov 2023 19:18:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="830122793"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; d="scan'208";a="830122793"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 12 Nov 2023 19:18:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:18:02 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Sun, 12 Nov 2023 19:18:02 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Sun, 12 Nov 2023 19:18:02 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Sun, 12 Nov 2023 19:18:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fTvsn1pUtpBs2Mx3/FA4uVXnQFjevU5Km+w50SbGvdAZRYaLYVJsMEOyAQ9i0Uy0q6wg01yX2PdSJ5XLZ1CEV/BANiYjCln0ixMvfs/YANFq8bJZbOftevykzAZEEUYU+BxoCecfZ/L6tLY3Y8Ab/e+Sx5a+rcGJxWKNViTIMiZ4IxARMsvaX41WBhpr2a2W9lH60sjAexFZqwilPdFWXhh8siSHL8j2zI/N1ifGn/khn4FaNfLCcrlsHAwe0EkjXJ1VJp6RPxlOUFnCo3jegoHHHFQ3z5KErwDXeWHgWB1Ybvj/lUQRjNIGCN0ZLaC1xgxmECI4AtlZJr2Yco0QkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s67Rx3ARmL6daxq50g2Kw9u+JLUaUrr6ED7hf8I7iMw=;
 b=DNcVRmV//+zHle+cQs/oUol22NZvO2WtOP1rEP/J6hNLV9QdTNUaRXeK/HVV7gvHGyuV20c14iWaJRns0dsgXaawmtV17o6UxVJRfFlec2Choux7a1Tn5/vvyQiB++yqVBl0d2t2+ceLi/DJil4qTruNSTZ1im+/JR0VgX48VXI0/sV9YJEYg3wRNRoiBBTEN+6tqRJ9MFEPN+RdxrVGjWSpxCJjI3W2OEeiI6ilX7+tPWp7OcwbSHyBOcRNIBQWlGKzvLk4X9smkr8hpWst2GX6ZEwAiKuFMfe19AWygf56d0ITw2kdOu7z78lpPhTv3VE7csnu81WuLoc100vWsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BN9PR11MB5403.namprd11.prod.outlook.com (2603:10b6:408:11c::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.29; Mon, 13 Nov
 2023 03:17:59 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6977.028; Mon, 13 Nov 2023
 03:17:59 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Joao Martins <joao.m.martins@oracle.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Matthew Rosato <mjrosato@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "clg@redhat.com" <clg@redhat.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "eric.auger@redhat.com"
 <eric.auger@redhat.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Thomas Huth
 <thuth@redhat.com>, Eric Farman <farman@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, Tony Krowiak
 <akrowiak@linux.ibm.com>
Subject: RE: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Topic: [PATCH v4 28/41] vfio/iommufd: Implement the iommufd backend
Thread-Index: AQHaDV58rXzWcAbguEiSUs8ukZNa17BvxJKAgABFgECAAF7hgIABicGAgAALAwCAAACygIAAAP4AgAABxICAAAOHgIAAFEgAgADT6yCAAKaTgIAEDP/A
Date: Mon, 13 Nov 2023 03:17:59 +0000
Message-ID: <SJ0PR11MB67445BF38A1BA78F535DE2F992B3A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-29-zhenzhong.duan@intel.com>
 <76538479-77ec-1a7d-cee1-906f6f758cff@linux.ibm.com>
 <SJ0PR11MB6744D87FD3CBB3380647E68792A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <20231108124817.GS4488@nvidia.com>
 <b6f22a3a-84cc-44ab-947b-b7e12656fe87@oracle.com>
 <20231109125700.GZ4488@nvidia.com>
 <592a04c2-0b4e-4bb2-80e4-f4c2dfacf00c@oracle.com>
 <d7475721-2388-4b9c-a47f-1891e82a635e@oracle.com>
 <20231109130921.GC4488@nvidia.com>
 <c761227b-360e-47d5-868d-2cfb71080a46@oracle.com>
 <20231109143434.GI4488@nvidia.com>
 <SJ0PR11MB6744A33106EC2DFA66D397B692AEA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <3b2faf27-493e-4b8b-92c5-1542399267c6@oracle.com>
In-Reply-To: <3b2faf27-493e-4b8b-92c5-1542399267c6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BN9PR11MB5403:EE_
x-ms-office365-filtering-correlation-id: 37bc838d-a840-4553-7875-08dbe3f7235a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yPvUGesTO89cyRdSdxPmGqslD3JJ8lVOjEBejw8xFM6eAwxAqTlXm8XVHz4dnIRGTmqkmR8mSokAyIhayQj3zqRpwOfE1GjgQ+upVkY4ffsMlqwjF74UpF4/WcEakq8I15O7HWZTzu4uXj45crWcpKOa0qlzrXkvp8VAuTfv2bmXPD3sVLIEJQMN+gndm7ydx8GSPQzeGQpOgbAe5oQKAYR2gp+gWoemVBQ4b5XC4Moyhx4gJStzImlRAFA9v4CHtU4X7D/C7VXK92CDWFCOw7jj3usAxzZ18ntI+Qy9yqsJTYkkNBlFdRgL8YEszyyEJ85lMY0cRFBAByWDlgpNwWRQ+f4qwuFlQ2iojR7/URcxxklKKfG4HYxCEJQeQ/Rp78Jai51OmaPoDbJXDLBbgsGZx63HnczwZl4TvrleRr7QCH+kkYl4jsCU0bxZmMTT+xEm5MPkuTPWl/LXzZoUwy3+iDt/ubWK/IAkK2EgvEOYL8ybq8ivlNjLjR9YnhIN/M4PWpmS1+25qPeDwEzYVDQOi1ouVLj7OZMZVXdx29Dc5waTStP4Df3MyShqfPcq6/dOX2LDEgsTRpw4joUokBw+DutcfZMEVKFPNxQWPFVuF6TRaQxt+M5gLwOWJ3WG
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(376002)(396003)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(4326008)(8936002)(8676002)(82960400001)(122000001)(52536014)(38100700002)(66946007)(71200400001)(76116006)(6506007)(7696005)(66556008)(66476007)(66446008)(64756008)(54906003)(110136005)(53546011)(478600001)(966005)(26005)(83380400001)(9686003)(316002)(33656002)(41300700001)(5660300002)(86362001)(2906002)(7416002)(38070700009)(55016003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWkvNHFjQWVpNVMxUWZURlFBZi9Ednk2VXltL0VPWTEzK0lLU1NkTGRENlE1?=
 =?utf-8?B?TXlUTDE0RFJXOG84R0ZhUXFGcEszcUpBdmlGU0RKU1hUY0owNGNaRWNCcita?=
 =?utf-8?B?VlJrRFdWMi92bXJvTFdHTDdRMURBSWpqUEs3aHZLQTJoekdXNHp5Z3pmaW9F?=
 =?utf-8?B?SU84S2ZpekhmTEJEWEtLQ1NNK2N3bmJ5bmhkNlhLTFdvKzJ3RXp4TndSZGx0?=
 =?utf-8?B?emRLWXBXQ3JWMXBRbDZhcktkcFVWa2RXZDVUeUdVKy9qWFlMMndTNTRndGtI?=
 =?utf-8?B?bVNMV1JKU3RIc2J5c0w5RDZsb0dxeitHbDA1RUFFMlo1TVVDSkNKOHVaWmhK?=
 =?utf-8?B?T1Y0aGtoWlZlTS9RY0Ewa29Vay8wU3BEN3VQbS9EN0lvRyt2aTlmYnpRb1g2?=
 =?utf-8?B?c1BaOS9TRUlnNUF0TTFGcUVhZ2doQmVwTFA5akFnanhQZ1k0dThZclFkYW1U?=
 =?utf-8?B?TkxhTmEwdzRBRVJmZUlZM0JNaHBBdFRYTGpyc3VZaGo2NHljWWsrVThEMnpw?=
 =?utf-8?B?aEVMMjJzaTBrUDBqWW5saHQvYXJ3d3VVRFppbU1sNHRZWUZBV0tMN3ZQUmF3?=
 =?utf-8?B?dWZPR3RCam9LKys3YTZrdmpGWFY4MmdwNWE2amJHaXAvZmR2NHM2cmxyRGtL?=
 =?utf-8?B?TTAvRUhjQ01waittS0s3SWdOQ0RaZHFRSVlRYnVxSWpYeHFMZ0llZ3l4YWpL?=
 =?utf-8?B?K0FueTE0c292c0hZMjhwQnpNaXRhakwzU0FzSjZWcndjQU8vUER1ZTlYKzc0?=
 =?utf-8?B?aWRIOEFiT0xFeEtzcFZtcVUwNW5TM3VhNGxuL2JOZFZoKzFobGJJVWNGUC9N?=
 =?utf-8?B?K2xNci95d21IUy9aY2FzVHgvdkd6YStGZzg3RlFUZUJIV0VJaThuZGkybENY?=
 =?utf-8?B?NW1LcTFpODUyZjFGNHRsZmZseHEwVjlKSk5nZmxxQXJJZjNra0krODRNS1V4?=
 =?utf-8?B?T2pRbnBwaTY0dTF6WG5YRjRaZ3dkb0tsNS9HZStVaHB5c0swVHlvRFhzY2dO?=
 =?utf-8?B?MUc2cUJMZHFSZXJtUGZqY2Jrb2VOR0IvSHAxd1ZkR1pWY0VqeTVOWnEybndC?=
 =?utf-8?B?VGJkc0w4YVFpUzQyUUpKc0F6QU9MU2hrdVhScXgzZlFUNmI4YWcrL2pmdHZU?=
 =?utf-8?B?bDBoOEpNa3BmcTRJY0tBRVZ6bk5pdUdaTHY2ODB3d2Z5SGtIeWFFSFVieVBC?=
 =?utf-8?B?ME52YVdmeUptbmdsOEdmNEFrZStuODlvVXhVMU1tNHdMa05KczRFcUJndCtL?=
 =?utf-8?B?UDJldGQ1T2QxNzdPSWdML0JNa20wU1RZMUVPenJCUnB4WUQwdTFoOGp3WWJP?=
 =?utf-8?B?YWNQeTg5NVJITkxQRWYrQXFJWXkzQ1Voc3dMRWhZWmdXUHZxTWFwcGw3MzhM?=
 =?utf-8?B?TXAycXZUVGNMYXJGRWg3aUFIR25LTGFkL2xOSTZyd0pyWEJGMGlQUU90RTFW?=
 =?utf-8?B?REFxWVNTMlAzN0VvUjNBUXM2Vkd1WFFwZmVUeGkwc3RFSUJqZ1N3ZlFEY2Uz?=
 =?utf-8?B?di9DRjJTbXlVSDFrWmVWZWplSG80ZDJ6M2JaWnRzMTBMZWV1dVFjVkFFREZR?=
 =?utf-8?B?cUljTTNxQ0c4QVdJVWVCNU9uTmJaVTZXMXlqMmYyaVl2WmNleTl6aHRIeUJU?=
 =?utf-8?B?WVJIWlNlV0xHQ1dpeUs0cmwxMTRUckZYMUZTR0thSkF3NGpJQlJLUHllTzZ3?=
 =?utf-8?B?dFZZUWxYcE1ub3RzWDVSS0dEK0ZLUHoyelVOZWUwM05rSnZvUXBNUzVHZ0x1?=
 =?utf-8?B?OTh6NjYzWGpNcHZlVmErVmFzQVE0enFHT3Z1TEJXVmtGUWw5SDd2eFVCdml6?=
 =?utf-8?B?MVhxeUc1RmlPQXhpem81ZmRqbzYwUEl2RmVibXNVRDg4TTg5VWhybTYvNjBQ?=
 =?utf-8?B?M2g3OXhldkxqZmtNbEN3bzVkelVQVUYxNTZjZHR4V2F2UUxRL1RaRGprTTZO?=
 =?utf-8?B?UHlmTXlmaUxpMkZWeFZWL29wbHY1N3ptNVgwWTY5cERQTlVLeWNqWWVvYkhx?=
 =?utf-8?B?S25DV1NIMDZtMlFNeFF1SDFUb3NsM2phVmtpSjRXQjhHV1RJa0xWNTBBR0My?=
 =?utf-8?B?cjNncGRyYUlKcEtUbldnZWZjTlJxQWdTY0pEWlRnTGdNOTh4V085N2dzTWs0?=
 =?utf-8?Q?tWjHlBsNrSZPM9PM6jES+9eXm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37bc838d-a840-4553-7875-08dbe3f7235a
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2023 03:17:59.2540 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U1Bw+MUhniJNE2U2FYG7tDLgb9OX0JiFFHQ55R4wexMTH+Z07zxOl5ROdYjDzyKApIOr21Buld+4dWoICN2jC7rxM/lcPGDzb66qmreUm6c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5403
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBGcmlkYXksIE5vdmVtYmVyIDEwLCAyMDIz
IDk6MDkgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDI4LzQxXSB2ZmlvL2lvbW11ZmQ6IElt
cGxlbWVudCB0aGUgaW9tbXVmZCBiYWNrZW5kDQo+DQo+T24gMTAvMTEvMjAyMyAwMzoxNSwgRHVh
biwgWmhlbnpob25nIHdyb3RlOg0KPj4gSGkgSmFzb24sIEpvYW8sDQo+Pg0KPj4+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogSmFzb24gR3VudGhvcnBlIDxqZ2dAbnZpZGlh
LmNvbT4NCj4+PiBTZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgOSwgMjAyMyAxMDozNSBQTQ0KPj4+
IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMjgvNDFdIHZmaW8vaW9tbXVmZDogSW1wbGVtZW50IHRo
ZSBpb21tdWZkDQo+YmFja2VuZA0KPj4+DQo+Pj4gT24gVGh1LCBOb3YgMDksIDIwMjMgYXQgMDE6
MjE6NTlQTSArMDAwMCwgSm9hbyBNYXJ0aW5zIHdyb3RlOg0KPj4+PiBPbiAwOS8xMS8yMDIzIDEz
OjA5LCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+Pj4+PiBPbiBUaHUsIE5vdiAwOSwgMjAyMyBh
dCAwMTowMzowMlBNICswMDAwLCBKb2FvIE1hcnRpbnMgd3JvdGU6DQo+Pj4+Pg0KPj4+Pj4+PiBJ
IGFtIG5vdCB0YWxraW5nIGFib3V0IG1kZXZzOyBidXQgcmF0aGVyIHRoZSByZWd1bGFyIChub24g
bWRldikgY2FzZSBub3QNCj4+PiBiZWluZw0KPj4+Pj4+PiBhYmxlIHRvIHVzZSBkaXJ0eSB0cmFj
a2luZyB3aXRoIGF1dG9kb21haW5zIGh3cHQgYWxsb2NhdGlvbi4NCj4+Pj4+Pg0KPj4+Pj4+IC4u
LiB3aXRob3V0IGFueSB2SU9NTVUuDQo+Pj4+Pg0KPj4+Pj4gQWgsIHdlbGwsIHRoYXQgaXMgdHJv
dWJsZXNvbWUgaXNuJ3QgaXQuLg0KPj4+Pj4NCj4+Pj4+IFNvIGRvIHdlIHRlYWNoIGF1dG9kb21h
aW5zIHRvIGJlIG1vcmUgZmVhdHVyZWQgaW4gdGhlIGtlcm5lbCBvciBkbyB3ZQ0KPj4+Pj4gdGVh
Y2ggdGhlIGdlbmVyaWMgcWVtdSBjb2RlIHRvIGVmZmVjdGl2ZWx5IGltcGxlbWVudCBhdXRvZG9t
YWlucyBpbg0KPj4+Pj4gdXNlcnNwYWNlPw0KPj4+Pg0KPj4+PiBUaGUgbGF0dGVyIGlzIGFjdHVh
bGx5IHdoYXQgd2UgaGF2ZSBiZWVuIGRvaW5nLiBXZWxsIEkgd291bGRuJ3QgY2FsbA0KPj4+IGF1
dG9kb21haW5zDQo+Pj4+IGluIHFlbXUsIGJ1dCByYXRoZXIganVzdCBhbGxvY2F0ZSBhIGh3cHQs
IGluc3RlYWQgb2YgYXR0YWNoaW5nIHRoZSBJT0FTDQo+Pj4+IGRpcmVjdGx5LiBCdXQgd2VsbCBt
ZGV2cyBkb24ndCBoYXZlIGRvbWFpbnMgYW5kIHdlIG92ZXJsb29rZWQgdGhhdC4gSSB3b3VsZA0K
Pj4+IHR1cm4NCj4+Pj4gdGhlIGV4Y2VwdGlvbiBpbnRvIGFuIGV4Y2VwdGlvbiByYXRoZXIgdGhh
biBtYWtpbmcgdGhlIG5vcm0sIGRvZXNuJ3QgbG9vayB0bw0KPj4+IGJlDQo+Pj4+IG11Y2ggY29t
cGxleGl0eSBhZGRlZD8NCj4+Pg0KPj4+IEF1dG9kb21haW5zIGFyZSBjb21wbGV4IGJlY2F1c2Ug
b2YgdGhpbmdzIGxpa2UgbWRldiBhbmQgaW9tbXUNCj4+PiBub24tdW5pZm9ybWl0eSdzLiBRZW11
IGNhbid0IGp1c3QgYWxsb2NhdGUgYSBzaW5nbGUgSFdQVCwgaXQgbmVlZHMgdG8NCj4+PiBiZSBh
bm5veWluZ2x5IG1hbmFnZWQuDQo+Pj4NCj4+Pj4gV2hhdCBJIGxhc3QgcmUtY29sbGVjdCBpcyB0
aGF0IGF1dG9kb21haW5zIHJlcHJlc2VudHMgdGhlICdzaW1wbGUgdXNlcnMnIHRoYXQNCj4+Pj4g
ZG9uJ3QgY2FyZSBtdWNoIGJleW9uZCB0aGUgYmFzaWNzIG9mIElPTU1VIGZlYXR1cmVzIChJIHJl
Y2FsbCB0aGUgZXhhbXBsZQ0KPj4+IHdhcw0KPj4+PiBEUERLIGFwcHMgYW5kIHRoZSBsaWtlKS4g
WW91IGNvdWxkIHNheSB0aGF0IGZvciBjdXJyZW50IG5lZWRzIElPTU1VDQo+Pj4gYXV0b2RvbWFp
bnMNCj4+Pj4gc3VmZmljZXMgZm9yIHFlbXUuDQo+Pj4NCj4+PiBZZXMsIHRoYXQgd2FzIG15IGlu
dGVudGlvbi4gQXNpZGUgZnJvbSB0aGF0IGl0IHByaW1hcmlseSBleGlzdHMgdG8NCj4+PiBzdXBw
b3J0IHZmaW8gY29tcGF0aWJpbGl0eQ0KPj4+DQo+Pj4+IENvbm5lY3RpbmcgYXV0b2RvbWFpbnMg
dG8gdGhpcyBlbmZvcmNpbmcgb24gdGhlIGh3cHQgaXMgcmVsYXRpdmVseSBzaW1wbGUNCj5idHcs
DQo+Pj4+IGl0IGp1c3QgbmVlZHMgdG8gY29ubmVjdCB0aGUgZGlydHkgdHJhY2tpbmcgZmxhZyB3
aXRoIHNhbWUgc2VtYW50aWMgb2YNCj4+Pj4gaHdwdC1hbGxvYyBlcXVpdmFsZW50IGFuZCBwYXNz
IHRoZSBod3B0IGZsYWdzIGludG8gdGhlIGRvbWFpbiBhbGxvY2F0aW9uLg0KPj4+DQo+Pj4gWWVz
DQo+Pj4NCj4+Pj4gSXQncyBtb3JlIG9mIHdoYXQgb2YgYSBxdWVzdGlvbiBzaG91bGQgYmUgdGhl
IGV4cGVjdGF0aW9ucyB0byB0aGUgdXNlciB3aGVuDQo+Pj4+IHVzaW5nIEFUVEFDSF9IV1BUIHdp
dGggYW4gSU9BU19JRCB2ZXJzdXMgZGlyZWN0IG1hbmlwdWxhdGlvbiBvZiBIV1BULiBJDQo+YW0N
Cj4+Pj4gd29uZGVyaW5nIGlmIGRpcnR5IHRyYWNraW5nIGlzIGFsb25lIGhlcmUgb3Igd2hldGhl
ciB0aGVyZSdzIG1vcmUgZmVhdHVyZXMNCj50aGF0DQo+Pj4+IHN0YXJ0IHRvIG11ZCB0aGUgc2lt
cGxpY2l0eSBvZiBhdXRvZG9tYWlucyB0aGF0IHdvdWxkIGFwcHJveGltYXRlIG9mIGh3cHQtDQo+
Pj4gYWxsb2MuDQo+Pj4NCj4+PiBUaGlzIGlzIHdoeSBJIGhhZCBiZWVuIHRoaW5raW5nIG9mIGEg
cHVyZSBIV1BUIGJhc2VkIHNjaGVtZQ0KPj4+DQo+Pj4gU28gaXQgc2VlbXMgd2UgY2Fubm90IGhh
dmUgYSBzaW1wbGUgbW9kZWwgd2hlcmUgdGhlIGdlbmVyaWMgcW1ldSBsYXllcg0KPj4+IGp1c3Qg
d29ya3MgaW4gSU9BUyA6KCBJdCBtaWdodCBhcyB3ZWxsIGFsd2F5cyB3b3JrIGluIEhXUFQgYW5k
DQo+Pj4gdW5kZXJzdGFuZCBhbGwgdGhlIGF1dG8gZG9tYWlucyBjb21wbGV4aXR5IGl0c2VsZi4N
Cj4+DQo+PiBMZXQgbWUga25vdyBpZiB0aGVyZSBpcyBhbnl0aGluZyBJIGNhbiBkbyBpbiB0aGlz
IHNlcmllcyB0byBmYWNpbGl0YXRlDQo+PiBmdXR1cmUgcWVtdSBkaXJ0eSB0cmFja2luZyBzdXBw
b3J0IG9mIGlvbW11ZmQuIE5vdCBjbGVhciBpZiBJIHNob3VsZA0KPj4gcmVzdG9yZSB0byB0aGUg
bWFudWFsIEhXUFRfQUxMT0MgbWV0aG9kIGluIHY0Lg0KPg0KPklmIHdlIHdhbnQgdG8gaGF2ZSB0
aGUgY2xvc2VzdCBzdXBwb3J0IGFzIHR5cGUxLWlvbW11LCBmcm9tIHdoYXQgd2UgaGF2ZSBiZWVu
DQo+ZGlzY3Vzc2luZy4uLiBpdCBzb3VuZHMgbGlrZSBJT0FTIGlzIHRoZSBlYXNpZXN0IGZpcnN0
IHN0ZXAgdG8gZ2V0IGJhcmVib25lcw0KPmlvbW11ZmQgc3VwcG9ydC4gV2hpY2ggc29ydCBvZiBt
YWtlcyBzZW5zZSBzaW5jZSB0aGlzIGlzIHRoZSBpbnRyb2R1Y3Rpb24gb2YNCj5pb21tdWZkIGFu
ZCBpdCBhbHJlYWR5IHJlcXVpcmVzIGEgbG90IG9mIGNodXJuICYgcmVmYWN0b3JpbmcgdG8gZ2V0
IHRoZXJlLg0KQWdyZWUuDQoNCj4NCj5Gb3IgdGhlIG5ldyBpb21tdWZkLW9ubHkgZmVhdHVyZXMg
KG5lc3RpbmcvZGlydHktdHJhY2tpbmcpIHdlIHdpbGwgbmVlZCB0aGUgYXV0bw0KPmRvbWFpbnMg
ZG9uZSBieSBRZW11IElJVUMgLS0gdW5sZXNzIG5lc3RpbmcgaXMgbWVhbnQgdG8gY29leGlzdCB3
aXRoDQo+YXV0b2RvbWFpbnMNCj53aXRoIGl0cyBvd24gaHdwdHMgc29tZWhvdyAoPykNCg0KV2Ug
aGF2ZSBhIGRyYWZ0IG5lc3RpbmcgaW1wbGVtZW50YXRpb24gd2hpY2ggaGFzIGl0cyBvd24gaHdw
dHMgYW5kIGNvZXhpc3QNCndpdGggYXV0b2RvbWFpbnMuDQpTZWUgaHR0cHM6Ly9naXRodWIuY29t
L3lpbGl1MTc2NS9xZW11L3RyZWUvemhlbnpob25nL2lvbW11ZmRfY2Rldl92NV9uZXN0aW5nDQpp
ZiB5b3UgYXJlIGludGVyZXN0ZWQuDQoNCj4NCj5SaWdodCBub3cgSSBkb24ndCBoYXZlIHRoZSBh
dXRvZG9tYWlucyBRRU1VIGVxdWl2YWxlbnQgc3RydWN0dXJlIGluIG1pbmQgdG8NCj5zdWdnZXN0
IGEgcGF0aCBpbiBhbHRlcm5hdGl2ZSB0byB2NTsgTG9va2luZyBhdCB0aGUga2VybmVsIGF1dG9k
b21haW5zIHBhdGgsDQo+YXNpZGUgZnJvbSBtZGV2IEkgYW0gbm90IHN1cmUgeWV0IHdoYXQgYW5u
b3lhbmNlcyB0aGUgYXV0b2RvbWFpbnMgcGF0aCBpbg0KPnFlbXUNCj5pcyBnb2luZyB0byBnZW5l
cmF0ZTogbW9yZSB3b3JyaW5nbHkgd2hldGhlciB3ZSBoYXZlIGVub3VnaCBpbmZvcm1hdGlvbiB0
bw0KPnRhY2tsZSB0aGUgbm9uLXVuaWZvcm1pdHkgZS5nLiBpZiB3ZSBhcmUgdGFsa2luZyBhYm91
dCBmZWF0dXJlcyBvciB3aGV0aGVyDQo+ZGlmZmVyZW50IGRldmljZXMgYXJlIGJlaGluZCBkaWZm
ZXJlbnQgSU9NTVVzLg0KDQpPSywgbG9va3MgbW9yZSB0aGlua2luZyBhbmQgZGlzY3VzcyBuZWVk
ZWQgZXhjZXB0IG1kZXYuDQpJJ2QgbGlrZSB0byBrZWVwIHRoaXMgc2VyaWVzIGFzIGEgYmFzaWMg
aW9tbXVmZCBzdXBwb3J0IHdpdGggSU9BUyBhdHRhY2hpbmcuDQpRRU1VIGF1dG9kb21haW4gbWF5
IGJlIGFub3RoZXIgc2VyaWVzIGFkZHJlc3NpbmcgbmV3IGlvbW11ZmQtb25seSBmZWF0dXJlcy4N
Cg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

