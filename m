Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D28D728EC6
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 06:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7TLQ-0004Nb-NW; Fri, 09 Jun 2023 00:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7TLO-0004KU-2W
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 00:03:22 -0400
Received: from mga01.intel.com ([192.55.52.88])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7TLJ-0001IS-Du
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 00:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686283397; x=1717819397;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=dIsMvSKLBhxccTqMK/H7DO9qn5lcWtoqvC+LbthO9Vw=;
 b=NiqK5Rv4e5Fjbt3YEpV/w2zVRoq3st4/GI/pDzB1yMZRfDUcrkIkTo11
 ldTYDQoJ7LQ0wU/nhzxgWDHXWyeETKWAhB36xHWhIrSE5xx4plzrd6qlL
 dOQhfk9g+NW5Mva7evsi3TkHKYAEjDUjmyxRVDRpRr/Go1+KiO89eQFU0
 +/NIzEuLi2bwq3yLf6C+yd9RkWBy03Dtf79fxqX++CuhgC5fLoXL98yX8
 WuKwHojqf3y11QJPhW2uhfr42tq+7vfeMq+EpX5OKTr7QELPFaGManc+y
 wR1w4ddE1I+RJR4w0pamDMmfCCHNg1xI/NdbPLKyBNvCiGZhuUPcq7d3r w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="385861571"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="385861571"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 21:03:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="956993382"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="956993382"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga006.fm.intel.com with ESMTP; 08 Jun 2023 21:03:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 21:03:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 21:03:13 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 21:03:13 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 21:03:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGighLiBjvX9xvqQzC34cREZntye6M+16Y3m4xDj4XvuKEStYLBn//DLKEsP/WSw+qVb2iqXVnYulD060n87lqgcNtW/59TbJXOlSWIdZ1Vicrs+768YaOa8UGlQOzcg5v5fW4WBwTgckW/ntzu7e5ZaxjVbUG6FSqomM5CKVW5FdM8+2/6FBQYQtOODtH+ifLWov/euyAxb7AzTHNiPR8P6HHeS5DUOylAGcA8kHTBb3yfEzEULT/TTsydg8WwPZHDfwXNqV9dvlnfw7gPNraL9bpMoN+UJrY+VrNCsZyr2owXKlgijDf3enlq0lDWoif7GGUG1tEUJUMTkd1UXgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dIsMvSKLBhxccTqMK/H7DO9qn5lcWtoqvC+LbthO9Vw=;
 b=Ml4jGcYpqsU8fbbpFNHS/iKrSc+xLW3zMY88jlkTPiR7wj7OPs4aGw9UsRJD4zcXVY33Wb3wXRu9kOhpw0ZwZL86fO9fWaAGyrhkOgciM5kIb6dvv4eLQNIEV66WnEqKB1JoXEr++PMeNy+vPE7J3AGovw7QXXc2t/G6l1TkUfd3jeYDyJsDdIu9c7ILLE3fC04XA9tRYYPImJXEA/Diz5EJ91EyTB7ogIF4RtDwL1qe4yUYl5wqth6DxhGt+7GdLSXrdwXsmXbzd3dM5QYb887IdeC3bph7/Z+sEH7rYbcsC9ZTTQTD/ttreWf5ZTLwAhY+D4z+AUGQOqObRPup9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM6PR11MB4755.namprd11.prod.outlook.com (2603:10b6:5:2ae::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.38; Fri, 9 Jun
 2023 04:03:12 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 04:03:12 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi
 L" <yi.l.liu@intel.com>
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
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+A8JUAgAABtYCAABkOgIAAzyng
Date: Fri, 9 Jun 2023 04:03:11 +0000
Message-ID: <SJ0PR11MB6744A1D3419436BE1C0E930B9251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZIHgFFSaBJWFUNd7@x1n>
 <ZIHhgyUv7YmWsG3H@nvidia.com> <ZIH2h7GAV6qirAgw@x1n>
In-Reply-To: <ZIH2h7GAV6qirAgw@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM6PR11MB4755:EE_
x-ms-office365-filtering-correlation-id: 1684a350-e2fd-4d77-5170-08db689e7169
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9juSba9EfDVNwG0j/3tDxwDJELQt1bQHccUyr/rVos0cKkMM6MPqdLeY/a8Xya2dzpPxFU4777jlEmhpfjS4qRxx7erRxbt7gzT3a2GIWu9VpUgG5E3vKKv+VCP3BoKF/U8r2P0sE9ZOKcMH8ureUb3F1a5aJf7Tn5WFRkhzmWvth+Fe12My3QbDF1kwuzye5qLeyynQ/aC/RLIMJrEd17kyjwGMYr0ZEK4hDtF++4NiCODy+GzobAeSFcvXsuh9J7QzoxR3++IC5tvWF00NYKbmqg5Tx1u63EUY/nZFgnRwkVBFcnXQbxTZ3ldtmhct2ZEvr7u6YcKlRhgKhsvwQT8YnvVU2sl4++4o0YC4XFuMWvIq/30wAJDwyVRmQlbh5T5QN6My5EMiFrYIMZ+X0kBjVOvjBsmeyvHwzo1XDDuGXTGXYqAICD6QrYe0Jm6OzjqHF0hC2RypFRx+7vns9Z7eOZMjoTRWhK/GBaYgo9ZN83B+9wiJExz9KOvLG0goqKT8hj4c+H5Gcux6BCmxtxHRhDFDt2kSnxga4/Fry8kjqsNKrEppLQ2MXCTIJlz352kbDkVuuESAJOqA9KLcrG94g4kTIqB477Z4b9tveLDW0S+FosgZDbSyeVJIPN7
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(396003)(366004)(136003)(376002)(346002)(39860400002)(451199021)(55016003)(110136005)(54906003)(122000001)(478600001)(82960400001)(8676002)(8936002)(4326008)(6636002)(66946007)(316002)(66556008)(66476007)(76116006)(66446008)(64756008)(41300700001)(38100700002)(107886003)(186003)(83380400001)(71200400001)(7696005)(6506007)(26005)(5660300002)(9686003)(33656002)(7416002)(52536014)(86362001)(38070700005)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?L3JVYXRFN3hxcjNTWHcvRzFpZGZXTFN5VDZxVWlKNHJ6QWtsbTVHc1lkUTVl?=
 =?utf-8?B?cnJXd2I1ZkdiM2Y5TklIc2ViNS9KdEhpQjVkZm1LNG1vVTlQK0hBL3JuS1pv?=
 =?utf-8?B?L1RKVzhuenhMUTZpcXMzSDRYTHZ0S0hXUExRNUhucmpZd2xBdVVaTEluMUNV?=
 =?utf-8?B?UTZseUp2dGlJeW00bXRIZU9qNCtyeE1nSHVrNmlOOW9VYjFETTdzcS8yQmQv?=
 =?utf-8?B?blZKKzNhOWVUVEVJZ1QycFpqM0hzZ0x2NGwrckhENDVkR1lHTllZYjhqajA5?=
 =?utf-8?B?NUczdzljRTVIcDk3UlVrRmU0Ly9qZHBDY0VIcWtjZFpoUXNpYmxjb0lPWm1x?=
 =?utf-8?B?R1pqVlBpcmZkVzFJaC9Xb20yMW9Fald2bzlSSXphZXVrUnBDVC9NbFVPMytO?=
 =?utf-8?B?Ny9WTHlCRURZMjEzOHpIQnZ4VHZNc3RpZGlPWmx0d0YzZXJ3K0t1K0szZHo3?=
 =?utf-8?B?ZHkxS2JmYjJYLzU1dmlZZmxkQnVRa1Npa016ZU1ZbjJoaFBRaER6SjY0TFdx?=
 =?utf-8?B?enJOVmRzQkRFdzc4cy9nYzdacmVpaWNjMUFXRmpsUUVGbmF0VW5wWkRnNlhC?=
 =?utf-8?B?WXk1MHRxNTFkblQ2U1FGQ1VWVXB5ZHdjQ0JYL3ZkVWZkZmJCb1dyRTYzcFlT?=
 =?utf-8?B?YWZWUndkOFlKY2E2Y1NOYjVWUlZTWmNEUER6MTU3Y1ExY2puRWhhektTQUFa?=
 =?utf-8?B?S0l4RmdrZkJ1SmFtSmdaMUNZVkViZGVIeDF5d1ArYzVTMG9xY1BpYVpQZmVj?=
 =?utf-8?B?RGNUWXFZa2tOMGh0M24rTnEzTnJSTTJkeUNqQ3YyejZwaTFKYWRNUlFmU1Zl?=
 =?utf-8?B?bWdya3J5VUhPNDJKR1NEbVlLaU05ZGVaeDJXWk1nVkhrMWM1WjZJdExGQllD?=
 =?utf-8?B?aS9KVTZBUW91NFZwcDJMVFZ6L2ZQMEQwaFAzZUcyZ3VDWlRFS2hOS3QxMDdr?=
 =?utf-8?B?VmpmdjVCYnNDS3FFenNTVlQ2SHdmR2drbXJZcldEVkFrd2VvVjJ4UVM5Sjc1?=
 =?utf-8?B?VzQwZGdYUldhSzNBUSsvaTcxK0JVMmttdUNFdmkzTW1Fd3FGdHg0TksyekJU?=
 =?utf-8?B?bVl6Zk1FTHU0dEF5SDMvOVdJbllSVjROc1JYamhPNEJreDdWekViZFFVdERR?=
 =?utf-8?B?ck5UWml3ZHRndkNQVVlIKzFUOERBTmFFeUh4UDFFRDFTSkJlQ3FhSU0vTEh4?=
 =?utf-8?B?Q2lBSmlWc1pJM3Z6OXlPM0ZBSGN1d1lrQjJERks5QXNTTm52VTQxeXJwKzBF?=
 =?utf-8?B?Q0g1SGRUajlwVlhPNExMcmJRaUN2WFhnRmY3dVhDbHl3VEVTWVp4SGNhQ3Jr?=
 =?utf-8?B?bG1jRmlQYnNEZzR2N1NPOFJ5OUdJV0tETUNvbml6eWpwdGh1STh3U0ZqSUda?=
 =?utf-8?B?L05HNjZJeEVHSzdmUDFkelk4UFVqZ1VDVU9NZURMOVJpU3lnRHpiRXJ5STFQ?=
 =?utf-8?B?bnhZWWFoSllFdnM1NUQzT0xZdVpiMkhLVW1sU08rTDVKSURtVHI4R1o3L0xy?=
 =?utf-8?B?QUxjMnNuSUwwMVlaVnVZWkk2NnltaFdkUWtVWHh6ZkZpb2hpR291cm1xbjFN?=
 =?utf-8?B?d25SWTh4OEJEQVpUNzdoVVl2blhHRmhzVlBVVTZOdVB1R0EzL0VabFVxNldY?=
 =?utf-8?B?RnVmRWxiaUlaOFJFbHhQS1FUVW9HaFk1YUNuWkJjb0E3ckxXYnpCQWg0Umhi?=
 =?utf-8?B?Q0VkM09jRWd4STl5UzYySWZJOFZEVzUwanM4YVRZV0xCaEt4anRVb0RxclJ0?=
 =?utf-8?B?cEZyU2NuY0hRYTRqRU1NZUdOMnprOWhUVHFWWFUzN0xKWEFHb1V5dndwTG9J?=
 =?utf-8?B?MkNkSTFDNDkrSFVPa2wxUGZkczBnTVl5d0dSOXkvWWVwSE1zbEZ4UTJNcUd4?=
 =?utf-8?B?SUFteGltSTA4Mjd2QmpQOStJejZicWI2aFZxTC9iQ2lhaVplOVR2UEp6am9W?=
 =?utf-8?B?Z0J6bnllL0ZYS0d5UCtpZk9HbklTWDZTZEZnUUxodytScHcxeHBXMkp4a2VE?=
 =?utf-8?B?MWdIcDVONWYvbFN5RkdpTUFpQ0djSmwrVzdHY002MWNDTHRjd0RBdldpUjh1?=
 =?utf-8?B?Y1BUZ1p3SzZ3ZEMyNmo5dDcwY24xWVhqMStBT08zaDJocXIrYUhiYTMzL0FZ?=
 =?utf-8?Q?am5Cesu4n1VqazEMkZmlF9BWq?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1684a350-e2fd-4d77-5170-08db689e7169
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 04:03:11.9487 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aiQ/q3CLiv33tjdfV8KaKHMWBISoMDJ6pupDT2Iw04SPFqd4kArWARsbc34er7PuBAaZQ1ByBZ+e7AQ0Rz3n69awQ/TSQRNB9vDQF6sdia0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4755
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.88;
 envelope-from=zhenzhong.duan@intel.com; helo=mga01.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
cmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgSnVuZSA4LCAyMDIzIDExOjQxIFBNDQo+VG86
IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+OyBMaXUsIFlpIEwgPHlpLmwubGl1QGlu
dGVsLmNvbT47IER1YW4sDQo+Wmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+
Q2M6IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPjsgcWVtdS0NCj5k
ZXZlbEBub25nbnUub3JnOyBtc3RAcmVkaGF0LmNvbTsgamFzb3dhbmdAcmVkaGF0LmNvbTsNCj5w
Ym9uemluaUByZWRoYXQuY29tOyByaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnOyBlZHVhcmRv
QGhhYmtvc3QubmV0Ow0KPm1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tOyBhbGV4LndpbGxpYW1z
b25AcmVkaGF0LmNvbTsNCj5jbGdAcmVkaGF0LmNvbTsgZGF2aWRAcmVkaGF0LmNvbTsgcGhpbG1k
QGxpbmFyby5vcmc7DQo+a3dhbmtoZWRlQG52aWRpYS5jb207IGNqaWFAbnZpZGlhLmNvbTsgTGl1
LCBZaSBMIDx5aS5sLmxpdUBpbnRlbC5jb20+OyBQZW5nLA0KPkNoYW8gUCA8Y2hhby5wLnBlbmdA
aW50ZWwuY29tPg0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjMgNS81XSBpbnRlbF9pb21tdTogT3B0
aW1pemUgb3V0IHNvbWUgdW5uZWNlc3NhcnkNCj5VTk1BUCBjYWxscw0KPg0KPk9uIFRodSwgSnVu
IDA4LCAyMDIzIGF0IDExOjExOjE1QU0gLTAzMDAsIEphc29uIEd1bnRob3JwZSB3cm90ZToNCj4+
IE9uIFRodSwgSnVuIDA4LCAyMDIzIGF0IDEwOjA1OjA4QU0gLTA0MDAsIFBldGVyIFh1IHdyb3Rl
Og0KPj4NCj4+ID4gSUlVQyB3aGF0IFZGSU8gZG9lcyBoZXJlIGlzIGl0IHJldHVybnMgc3VjY2Vl
ZCBpZiB1bm1hcCBvdmVyIG5vdGhpbmcNCj5yYXRoZXINCj4+ID4gdGhhbiBmYWlsaW5nIGxpa2Ug
aW9tbXVmZC4gIEN1cmlvdXMgKGxpa2UgSmFzb25XKSBvbiB3aHkgdGhhdCByZXR2YWw/ICBJJ2QN
Cj4+ID4gYXNzdW1lIGZvciByZXR1cm5pbmcgImhvdyBtdWNoIHVubWFwcGVkIiB3ZSBjYW4gYXQg
bGVhc3Qgc3RpbGwgcmV0dXJuIDANCj5mb3INCj4+ID4gbm90aGluZy4NCj4+DQo+PiBJbiBpb21t
dWZkIG1hcHMgYXJlIG9iamVjdHMsIHlvdSBjYW4gb25seSBtYXAgb3IgdW5tYXAgZW50aXJlDQo+
PiBvYmplY3RzLiBUaGUgYWJpbGl0eSB0byBiYXRjaCB1bm1hcCBvYmplY3RzIGJ5IHNwZWNpZnlp
bmcgYW4gcmFuZ2UNCj4+IHRoYXQgc3BhbnMgbWFueSBpcyBzb21ldGhpbmcgdGhhdCB3YXMgZWFz
eSB0byBkbyBhbmQgdGhhdCBWRklPIGhhZCwNCj4+IGJ1dCBJJ20gbm90IHN1cmUgaXQgaXMgYWN0
dWFsbHkgdXNlZnVsbC4uDQo+Pg0KPj4gU28gYXNraW5nIHRvIHVubWFwIGFuIG9iamVjdCB0aGF0
IGlzIGFscmVhZHkga25vd24gbm90IHRvIGJlIG1hcHBlZCBpcw0KPj4gYWN0dWFsbHkgcG9zc2li
bHkgcmFjeSwgZXNwZWNpYWxseSBpZiB5b3UgY29uc2lkZXIgaW9tbXVmZCdzIHN1cHBvcnQNCj4+
IGZvciBrZXJuZWwtc2lkZSBJT1ZBIGFsbG9jYXRpb24uIEl0IHNob3VsZCBub3QgYmUgZG9uZSwg
b3IgaWYgaXQgaXMNCj4+IGRvbmUsIHdpdGggdXNlciBzcGFjZSBsb2NraW5nIHRvIHByb3RlY3Qg
aXQuDQo+Pg0KPj4gRm9yIFZGSU8sIGxvbmcgbG9uZyBhZ28sIFZGSU8gY291bGQgdW5tYXAgSU9W
QSBwYWdlIGF0IGEgdGltZSAtIGllIGl0DQo+PiB3YXNuJ3Qgb2JqZWN0cy4gSW4gdGhpcyB3b3Js
ZCBpdCBtYWRlIHNvbWUgc2Vuc2UgdGhhdCB0aGUgdW5tYXAgd291bGQNCj4+ICdzdWNjZWVkJyBh
cyB0aGUgZW5kIHJlc3VsdCB3YXMgdW5tYXBwZWQuDQo+Pg0KPj4gPiBBcmUgeW91IHByb2JhYmx5
IHN1Z2dlc3RpbmcgdGhhdCB3ZSBjYW4gcHJvYmFibHkgaGFuZGxlIHRoYXQgaW4gUUVNVQ0KPnNp
ZGUNCj4+ID4gb24gLUVOT0VOVCBoZXJlIGZvciBpb21tdWZkIG9ubHkgKGEgcXVlc3Rpb24gdG8g
WWk/KS4NCj4+DQo+PiBZZXMsIHRoaXMgY2FuIGJlIGRvbmUsIEVOT0VOVCBpcyByZWxpYWJseSBy
ZXR1cm5lZCBhbmQgcWVtdSBkb2Vzbid0DQo+PiB1c2UgdGhlIGtlcm5lbC1zaWRlIElPVkEgYWxs
b2NhdG9yLg0KPj4NCj4+IEJ1dCBpZiB0aGVyZSBpcyB0aGUgcHJvcGVyIGxvY2tzIHRvIHByZXZl
bnQgYSBtYXAvdW5tYXAgcmFjZSwgdGhlbg0KPj4gdGhlcmUgc2hvdWxkIGFsc28gYmUgdGhlIHBy
b3BlciBsb2NrcyB0byBjaGVjayB0aGF0IHRoZXJlIGlzIG5vIG1hcCBpbg0KPj4gdGhlIGZpcnN0
IHBsYWNlIGFuZCBhdm9pZCB0aGUga2VybmVsIGNhbGwuLg0KPg0KPlRoZSBwcm9ibGVtIGlzIElJ
UkMgZ3Vlc3QgaW9tbXUgZHJpdmVyIGNhbiBkbyBzbWFydCB0aGluZ3MgbGlrZSBiYXRjaGluZw0K
PmludmFsaWRhdGlvbnMsIGl0IG1lYW5zIHdoZW4gUUVNVSBnZXRzIGl0IGZyb20gdGhlIGd1ZXN0
IE9TIGl0IG1heSBhbHJlYWR5DQo+bm90IG1hdGNoaW5nIG9uZSBtYXBwZWQgb2JqZWN0cy4NCj4N
Cj5XZSBjYW4gZGVmaW5pdGVseSBsb29rdXAgZXZlcnkgc2luZ2xlIG9iamVjdCBhbmQgZXhwbGlj
aXRseSB1bm1hcCwgYnV0IGl0DQo+bG9zZXMgcGFydGlhbCBvZiB0aGUgcG9pbnQgb2YgYmF0Y2hp
bmcgdGhhdCBndWVzdCBPUyBkb2VzLiAgTG9naWNhbGx5IFFFTVUNCj5jYW4gcmVkaXJlY3QgdGhh
dCBiYXRjaGVkIGludmFsaWRhdGlvbiBpbnRvIG9uZSBpb2N0bCgpIHRvIHRoZSBob3N0LCByYXRo
ZXINCj50aGFuIGEgbG90IG9mIHNtYWxsZXIgb25lcy4NCj4NCj5XaGlsZSBmb3IgdGhpcyBzcGVj
aWZpYyBwYXRjaCAtIFpoZW56aG9uZy9ZaSwgZG8geW91IGFncmVlIHRoYXQgd2Ugc2hvdWxkDQo+
anVzdCBoYW5kbGUgLUVOT0VOVCBpbiB0aGUgaW9tbXVmZCBzZXJpZXMgKEkgYXNzdW1lIGl0J3Mg
c3RpbGwgdW5kZXIgd29yayksDQo+dGhlbiBmb3IgdGhpcyBzcGVjaWZpYyBwYXRjaCBpdCdzIG9u
bHkgYWJvdXQgcGVyZm9ybWFuY2UgZGlmZmVyZW5jZT8NCg0KWWVzLCB0aGF0IG1ha2Ugc2Vuc2Uu
DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

