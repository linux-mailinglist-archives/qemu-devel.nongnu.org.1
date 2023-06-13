Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DC6472D76A
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 04:39:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q8tuf-0005pv-5l; Mon, 12 Jun 2023 22:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q8tud-0005pR-5I
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 22:37:39 -0400
Received: from mga17.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q8tub-0002Ha-8s
 for qemu-devel@nongnu.org; Mon, 12 Jun 2023 22:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686623857; x=1718159857;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DWjhRAA6UX7gVGk5/+UlWtuuM4hILnuEdjHVf1DyrDc=;
 b=YjUlX8NKhcC8lMnakDQIf6bXpSJzxfyjCS4HsU0WiDgBezhSE3LdSkTf
 vU8aVszwp+9nrV5skb+kMTt1LWoSxJmYxw4BBEs6BsbDjkN+/jTMxxNQR
 WILHT1NekQke+k5Pwr04+ImsEOWpY5cWycbDzRT6Roz6xAcj8ZnLOuSyN
 b94zvUPHnSM22RjdYYj7rTZ1cnr39RWVyfIewSUmoKohGM6YQ9keToEXs
 kFPilpLbjtQ7ofCJ2B5rBtDZBLatT8xIwgss1ZQXU13wgj+Be2Issv8at
 yl5Afif4APL+YdACbxFpf00UE0UNzQpHWRImSCNth8Vzu9pUjTwStBS3t w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="338570320"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; d="scan'208";a="338570320"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Jun 2023 19:37:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10739"; a="776626145"
X-IronPort-AV: E=Sophos;i="6.00,238,1681196400"; d="scan'208";a="776626145"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga008.fm.intel.com with ESMTP; 12 Jun 2023 19:37:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 12 Jun 2023 19:37:32 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 12 Jun 2023 19:37:32 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 12 Jun 2023 19:37:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAE1QkbM1DBmADHu7p2m2kZHNAbhGFGdYvcCgyHDxHJg40MQFSAEWl6+RAsY1wcIzbh4GdKCyto74Nu+RAjizRvqDJmVVueWP33l+jGCc1gE8md5+xYm7SzyopzyR8lHiWqEdrwlJH09pHLLT7mszfIqE14PQ0VOIVdt2LmDebLv62ocxM+eLezxXgUWApuF5DTMxz05rRMQjR9MQ9/MaPkZrRWt+bBY17o6zPvMm0KvukBszQ7e5PuP4zreSKLobA5QfDRKgd20CfyoXROIx6RHL3+bgVGHf3oWF7kV9xkbebQM7P0ma5a5pqkuQ/4KOiMJ4sab0/zLtGb9Kqd5FA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DWjhRAA6UX7gVGk5/+UlWtuuM4hILnuEdjHVf1DyrDc=;
 b=HqfbhEYo+XZ+hsOS+zZ4iv/hnxE3azr58lFfDn7z1w5ybpwx3Cag+shiUT+Hzv2jg6Cpet65iG2sQxGDrjrAfng4rbd1tT87kiiK9ZLUsX7cjm4nz3m5SyknBimD48EwNgfHrD8RrM6JZE2878IIHwq1hefps6dqc1K8leFAkpWuIvCgrkm9nxZ9ar5bINM6JDERWhxz+3JVdacL7iyLtRS+9GJMRFkwrYIiiVPAT47SR5bT3UUYtSIfkiRhvxOeTk92aIsXRwZgsu5V+9pHnGTKgtEa+XHms5LlC+DkDJ/vvwD7P9Ddlq3F4z8LbGFhuoBasBlSETVGBROGxheckw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA0PR11MB4542.namprd11.prod.outlook.com (2603:10b6:806:9f::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.29; Tue, 13 Jun
 2023 02:37:22 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.043; Tue, 13 Jun 2023
 02:37:22 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "Liu, Yi L" <yi.l.liu@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com"
 <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "david@redhat.com" <david@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "kwankhede@nvidia.com" <kwankhede@nvidia.com>,
 "cjia@nvidia.com" <cjia@nvidia.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Topic: [PATCH v3 5/5] intel_iommu: Optimize out some unnecessary UNMAP
 calls
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+A8JUAgAABtYCAABkOgIAADRsAgAA5boCAAKIgUIABChmAgAUM/2A=
Date: Tue, 13 Jun 2023 02:37:22 +0000
Message-ID: <SJ0PR11MB6744F464B09B90E2A4E22A1B9255A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZIHgFFSaBJWFUNd7@x1n>
 <ZIHhgyUv7YmWsG3H@nvidia.com> <ZIH2h7GAV6qirAgw@x1n>
 <ZIIBhmoT7H2/q0lb@nvidia.com> <ZIIxs9kXQyULglIJ@x1n>
 <SJ0PR11MB6744E9DE31D0424F4104FC469251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZIOY6w5n9hLEPUCC@x1n>
In-Reply-To: <ZIOY6w5n9hLEPUCC@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA0PR11MB4542:EE_
x-ms-office365-filtering-correlation-id: d853cda7-71ad-4cdf-2b05-08db6bb71d99
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zm9oFX0CKcli1G/YOmNEBAkQm2go6q+2NLnApS2dk8LDPb0wzrQsWi+D7bFnkGOfIBGC8PyEljYr0LwyUjENIkdVb6NqjeXYbTmd19za6o4yp/GcZJ1vdhJlLJCn80kT9e5qaYX0g9vFnz6+4voIYWoF/fo9K5BFoCsPScmKQjKF9jCVjB3v/IK4Y1GYLueaipsJqwD1cl+R69ZcRCslPjpziK8J28uJLTwTYC5pPgdfRQlKTWV//AtbvVgWhyPgVLsXxvbVGjfblNlCGWvCIhIeCAc6dnNajcJ7DIcb/uKMjNf17U2oXZBwzUZ5aEMSgZHEVH7sPAjzpcRo95JkxkwSd3DCAN9HM4Gp9ofGL1Y+I8He/NPI78NJHIBmzAlDlfPdzbzkcuDQETG6CuWrFWk1mhUV3fZx98g+oYsXFBTYxmrqazLX0Sw0XoF+CIO9OcFDAVOmZLPhBf90w4+ye2qyn+MqiF2fbUGSUEtaKWQr4J5D3Tm0HSKxSuK36lXJr9xhZjIvsT7yTxIWKe1phjC09a7vlmUjr5NqCjK4jUHKrX7btT/bUf+435666exhBomMZcVZ58XLuvElV/82V0HDT56KE06O2BvdPWBDf46xSFhz+CuwGs7uearfHvyp
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(366004)(396003)(376002)(346002)(136003)(39860400002)(451199021)(55016003)(83380400001)(66556008)(6916009)(478600001)(76116006)(71200400001)(7696005)(6506007)(107886003)(26005)(9686003)(54906003)(186003)(7416002)(2906002)(4744005)(8936002)(8676002)(52536014)(86362001)(5660300002)(4326008)(122000001)(41300700001)(38070700005)(38100700002)(33656002)(316002)(82960400001)(66946007)(66446008)(64756008)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Mkh6TWZYOXZPZEwwWEs2bzdXNzRWRFMvZ1g1MThHVWpLVGRESkRHSGFMVnE4?=
 =?utf-8?B?MWl4NVhERE5DSFFsbDlpQnRQd01kR0lndE5BWWdaMXRIaHZCMmE1ZnJieGtF?=
 =?utf-8?B?STVZOFhLMlp1M3puUDQyTFo0a3JRZy92ZmVyQXI0blFUTmdXeWtzUFA2TEpa?=
 =?utf-8?B?blp5SHRCZERsOWpERFFOaEUwWS9Ebnd6cXptRkNOaTFmM2VQUktMcHFidm42?=
 =?utf-8?B?Qi95NThsSTVjTDR6cmwzQ2tieHBFNmZ5YWlQVllOSmwwUFRnc0JyZVpSNHV0?=
 =?utf-8?B?a01taVF2d0JLNHYyNnJaNHBTRzR1eEt0OGlSK09hT3QvVkZtbTBDV3lVdHlM?=
 =?utf-8?B?R2VpL1ArRU9jZW9PbFpxa2NRa0E2dkpCUzhxbWlXVkJnRWJEYlpuS2taNlBS?=
 =?utf-8?B?KzFIbkRFUkJxV2txTm5MYXBCVlFFR2U3aVFwbDJvWUx4M2hpUmZXbVB6MVEz?=
 =?utf-8?B?aVR5VXBDQmo2TWZIODhaM0lKUUxadlE5RUdZTFBieDBKYnRyK1VLTXpnd3lP?=
 =?utf-8?B?RTdZOHU0V3hid29lNCtaZThPQVJEWEJmY1hKVDh1azlYcmMvc3g2dkZlcVNl?=
 =?utf-8?B?K2UxNHErRm1lSnhiZnhGZmFURlIrQjZFZjRGQm80NXpTcjRvRlVZS0xwOVN0?=
 =?utf-8?B?RUVvYVdnaFR4aVFYTDZ3K0d5UWplYkV3b1JOUGtLT3B5RTV1VVB0MStCTzls?=
 =?utf-8?B?UFJFTERTcVQyWTVTSE5YamRWRWdIajl0dUhPNEJtbXkyU3pLMjhSWC9PMGFh?=
 =?utf-8?B?U0VjdCtyWlA0NjZMdVpZZnE3VWlpS1NybFBaR1hmM1loc1AzVFhGQkJFNGM1?=
 =?utf-8?B?UVVQT2tXQmZHNGpqbUsrQ2ZUL3hCTVBoNUVKZWEvQU5NTVd5UTZMbmtFRzF2?=
 =?utf-8?B?NkxHTEVhS1V4S2pRc2lWak5YcDQrdHg0andMZUt2VVJEZTRNOWxxSVAvb1pt?=
 =?utf-8?B?V1VjaGxNWHNVUkR6Q3RCejdRSHNuWmwyZmpHOEM0Q0J6K0RKK09hV256bGZk?=
 =?utf-8?B?UmZxaVhRcEJGaW4yVFZyR1BmWDV1VWxkcHFUMHpLV1BzNUdhdUsyYXl6ZDNu?=
 =?utf-8?B?V1FEM1BsWGtBN3VsUHV6bTVEdEpxRi9DVVIvejcxbkRrUzZSbTlSbFA5TEt3?=
 =?utf-8?B?VFlZdENnVHQ2OFUxcnpuMlpOQlVvZVNaWmUvdlFnL1BUQVRBenMxN1hQbnV2?=
 =?utf-8?B?S1lxZlA1MmIreDIvTGZCSitZNTk2V2drSkpmc1RnL3MwUzZOTm0rWVU0NTk4?=
 =?utf-8?B?T2hwMEdlQU5GUFFaa1Fxa1c0YnduN2tncFJaOTFzUUhrc0Z0QjhjWjJCSWFK?=
 =?utf-8?B?N2k4TzFmK0FpZENmOVozeXIzL3RUTHgxVW9zbnU1TVNkRm9RaFVydkduSVFa?=
 =?utf-8?B?cXFOMG5yU1RTU3B3UlZXNGNsMGVkMi9BVUNZSC9uRkJweFlIRG9sTmN2bGc4?=
 =?utf-8?B?cERlQnlKMnJ4TXB5bkdCU203SGV0K2Z3NGVZUkQzSHgvdG9NelBUQWk1aFJU?=
 =?utf-8?B?VUVzbWVxbmxQOU5ZdWlCY2I2UnpSQk9JejhKZGtqd3ZZbUZFcng4MlVtZXdz?=
 =?utf-8?B?V2xaSmd1L0tWYkxUeFFEK083STFoZ0g0U2RGdW9qNXdJUjh5ZHVHbk5LZXQv?=
 =?utf-8?B?am1jWjAzajhQRU1FaUR5WW5GNG4xL0RIZlRNbmJNK0ZlQzdOQ1U2aW5SbGxJ?=
 =?utf-8?B?RVg0Zys1T0d4TVUzdlV6RHhmUnllL0d4d1RNY2NwK09Pc0xCY3ZWVS9FMUpI?=
 =?utf-8?B?ZCtvK3B3bi9vYU1nQ21yNUlKSjVxbDBMNy9mZ0k1dDJzWTg4UW56NDROZkt5?=
 =?utf-8?B?M1phM2E2dk40SHJiNW9TSHgzbTQ1Q3RXMmh5MzA4eVBKcUxZMHYzN2MyOGxH?=
 =?utf-8?B?eURkVmExS2dUQkQ5OWo1WkVNaHFRWkk3M0RGWVhLVjh0MnQ1ZVZhaXdzTXow?=
 =?utf-8?B?NlBZaXdiMC9ZdHNRZThBKzJuUERrQnNwQzVQMVA3VVZrVFVJM29NWmNGSzJL?=
 =?utf-8?B?Qm9ubFF5UkYyQTJSMHNrZm9oMlZoSjZMWDd5bmJUN21mVkdRVkR6M2JtMzBP?=
 =?utf-8?B?WUNxQW45aFNwVUswdTBaTHIwbkIwbWtaMlpDNEpKY1N6UGxFeGExZmQ2Mml2?=
 =?utf-8?Q?T/ijTzazfJ31qlTil5gwPko59?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d853cda7-71ad-4cdf-2b05-08db6bb71d99
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2023 02:37:22.2375 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QwNi0Guvbc5kJcXfLv+E9k11o0v3PZ7MF871o8Cjm+ccixP5wQrgTCLDAqg+onlb3UuEIlibuIt0v4EjuKxdFw5K6P/kTDnDRANZ73UdWMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4542
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IFBldGVyIFh1IDxwZXRlcnhA
cmVkaGF0LmNvbT4NCj5TZW50OiBTYXR1cmRheSwgSnVuZSAxMCwgMjAyMyA1OjI2IEFNDQo+U3Vi
amVjdDogUmU6IFtQQVRDSCB2MyA1LzVdIGludGVsX2lvbW11OiBPcHRpbWl6ZSBvdXQgc29tZSB1
bm5lY2Vzc2FyeQ0KPlVOTUFQIGNhbGxzDQo+DQo+T24gRnJpLCBKdW4gMDksIDIwMjMgYXQgMDU6
NDk6MDZBTSArMDAwMCwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4gU2VlbXMgdnRkX3BhZ2Vf
d2Fsa19vbmUoKSBhbHJlYWR5IHdvcmtzIGluIGFib3ZlIHdheSwgY2hlY2tpbmcgbWFwcGluZw0K
Pj4gY2hhbmdlcyBhbmQgY2FsbGluZyBrZXJuZWwgZm9yIGNoYW5nZWQgZW50cmllcz8NCj4NCj5B
Z3JlZWQgaW4gbW9zdCBjYXNlcywgYnV0IHRoZSBwYXRoIHRoaXMgcGF0Y2ggbW9kaWZpZWQgaXMg
bm90PyAgRS5nLiBpdCBoYXBwZW5zDQo+aW4gcmFyZSBjYXNlcyB3aGVyZSB3ZSBzaW1wbHkgd2Fu
dCB0byB1bm1hcCBldmVyeXRoaW5nIChlLmcuIG9uIGEgc3lzdGVtDQo+cmVzZXQsIG9yIGludmFs
aWQgY29udGV4dCBlbnRyeSk/DQpDbGVhci4NCg0KPg0KPlRoYXQncyBhbHNvIHdoeSBJJ20gY3Vy
aW91cyB3aGV0aGVyIHBlcmYgb2YgdGhpcyBwYXRoIG1hdHRlcnMgYXQgYWxsIChhbmQNCj5hc3N1
bWluZyBub3cgd2UgYWxsIGFncmVlIHRoYXQncyB0aGUgb25seSBnb2FsIG5vdy4uKSwgYmVjYXVz
ZSBhZmFpdSBpdCBkaWRuJ3QNCj5yZWFsbHkgdHJpZ2dlciBpbiBjb21tb24gcGF0aHMuDQpJJ2xs
IGNvbGxlY3QgcGVyZm9ybWFuY2UgZGF0YSBhbmQgcmVwbHkgYmFjay4NCg0KVGhhbmtzDQpaaGVu
emhvbmcNCg==

