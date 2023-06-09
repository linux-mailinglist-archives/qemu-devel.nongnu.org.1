Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ACF42728F6B
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 07:50:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7V06-0001kf-5w; Fri, 09 Jun 2023 01:49:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7V03-0001kL-ED
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 01:49:27 -0400
Received: from mga07.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q7Uzs-0005cq-CI
 for qemu-devel@nongnu.org; Fri, 09 Jun 2023 01:49:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686289756; x=1717825756;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OdVAGCareLChLrRpwYji62VtgXZS3yIIabl/b9MQ+kM=;
 b=lmYoYtLSu+xLwWDttZVqSrsI5wkD+RsQf2KJtUGdgI/LNmHFnAY+VUSD
 /Jg4Dgj/k/jd5CPF0BmZzn3ANrtC38VZ02A47NHiNwx3bZ8fs1Up2XDGP
 oyEsvL/250GuqXy4gYhp8b7DVVHbwvW14KpGTObBT5lEMQ+v3NWMiZphm
 qQuFvOcFFosFG08nlVkxKkKJh34UNnVUFkD4GHUkBbetU1dTIEHf1LU/Q
 LEtCr0Y9FMKn5xrtO+nMkcbK3zP9g8u54QiRI+J8LXkaJ2jWp1RrOJ/Lt
 HG09kZc0Jz8IFGPFuJJX3sWevKtSt28yHSTDDcxWBzuBU+TCgMCTERanu Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="423401368"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="423401368"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Jun 2023 22:49:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="884470443"
X-IronPort-AV: E=Sophos;i="6.00,228,1681196400"; d="scan'208";a="884470443"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga005.jf.intel.com with ESMTP; 08 Jun 2023 22:49:07 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 22:49:07 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 8 Jun 2023 22:49:07 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 8 Jun 2023 22:49:07 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 8 Jun 2023 22:49:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AytJiIRyG2vldBWslKRthh81s2cw7dvzgIwrzWH8AW2gNSLKESTKXdp8g2zTXOcE8b1XVzNSl0IGtRbN/csVmEx+LoKpSC80nnfUc4c5J+5vaNuqJeb/8HKc5qxrsGypYqp9cJt78o/lRPYs3PVHiHXnE9RrfCnoj8ggBlMiWhTqhG+MoXEN1jY2+ig5pkXdzr8FMB+/QLZU4udJp/+/WbFDbqXqGBuf5d2zfNB8tzSuIYPD64K0+XDnoXVS9NUighASHhOFhnMchhd1l/vLGAH8Sh3U1MQstyjAV5zK034BnDqdD8KS8uEfH32FIrrbSg9SNfG8TsHI/u1NXSw6GQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OdVAGCareLChLrRpwYji62VtgXZS3yIIabl/b9MQ+kM=;
 b=Q0Eso6ER60staTMwlgAD6RBG7VEZdoR9Q8Hc2XQnNy75lcmTlxBXMnxLqFzwTIwCaeORf9yyEq8hMbtyPlU0lXHTgh1fknUt9RofGSRbXdLsXr54Iyh8GW+636fjY750wF6lCCytnehmLmyuC+G39W54HI7MHTSGsFRX8+MexyOBNINGl2/3CVLzRO77aN6t6VDgykO/3Pj3og4c4OKrN6M9yy5YJfWH2wrbp9ExPeabA+DH970fHiL004QdRkeBuSNMgN1ZLtFu2EVF+Y8PQpZEI/tfSkTUbf/ReI/u67yVqKfAtH1xCTdtggWMb+EiVIiO59FdOBm40aI/g5B7vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM8PR11MB5574.namprd11.prod.outlook.com (2603:10b6:8:39::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6455.33; Fri, 9 Jun
 2023 05:49:06 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6455.030; Fri, 9 Jun 2023
 05:49:06 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Peter Xu <peterx@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: "Liu, Yi L" <yi.l.liu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "richard.henderson@linaro.org"
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
Thread-Index: AQHZmfDNwmLmlvy/GkmXR1XRJDGDhq+A8JUAgAABtYCAABkOgIAADRsAgAA5boCAAKIgUA==
Date: Fri, 9 Jun 2023 05:49:06 +0000
Message-ID: <SJ0PR11MB6744E9DE31D0424F4104FC469251A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230608095231.225450-1-zhenzhong.duan@intel.com>
 <20230608095231.225450-6-zhenzhong.duan@intel.com> <ZIHgFFSaBJWFUNd7@x1n>
 <ZIHhgyUv7YmWsG3H@nvidia.com> <ZIH2h7GAV6qirAgw@x1n>
 <ZIIBhmoT7H2/q0lb@nvidia.com> <ZIIxs9kXQyULglIJ@x1n>
In-Reply-To: <ZIIxs9kXQyULglIJ@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM8PR11MB5574:EE_
x-ms-office365-filtering-correlation-id: d1d0b5a2-d121-4170-7962-08db68ad3cc8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DZdSDnXRC8w7il9prXGsuSZOoOK5LXcEbuU+9hnIX7Bbf0n60YYwxIKCDCAiZ8V7nEMdJf9A/AjmGdU4DQF57dEwEBjD133d56CoVjUInjfwg8GO0mHCpIBxSFVWiVcA4NPuh3Lf25zmzl0+tqPLCya/NPnaOsGL/kR5sRqmDYFI39wcJN8kH7q5IdHTi8RYJBqLRm74ODyaX9JbmbIREpRNF2j0GnkZVL0F2iATBVMKYDG+eYLY1fbXiBQdLw5/TIIjrAfLmMxP7GLZo9J6VbGPKUdSBl1ZSYFqDBR81bZO/xqpLRIl3j/kz4Cmvk5mCn5hAqzL5hxqAAlSspOyWUH6WU0HFh94E/JOZ/Ny5bHyRN8JdMgfyXjsabQUzjpSwqBGtCazvzojIzcbpdFtaRqPJkvnDo5RBnsIGUeIJOZSMpMzf6hKvlHaiCqk8t3JxrG+lLtOOP2mlcOhjyZAZ5rvW+38VDqNwirJs7kT+gV2G+Fxf4Q9zbL2fd+s+/L38wxNVcP6SzHMuR2agaU5e8TKlPeMSB9gICJJ7M/dvm+mNtLbaP2gYFcnYt9iBndCUl86ull0/f/QUfe+Nr3xGuHQepBA9M7KJCl2gEzp4eu5TYxK7DnRebmwcZHoVgRS
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(346002)(396003)(136003)(366004)(376002)(451199021)(41300700001)(8676002)(66446008)(4326008)(66556008)(66476007)(76116006)(8936002)(66946007)(64756008)(110136005)(5660300002)(7416002)(316002)(52536014)(54906003)(55016003)(2906002)(38100700002)(82960400001)(122000001)(26005)(9686003)(86362001)(186003)(6506007)(107886003)(71200400001)(478600001)(7696005)(33656002)(83380400001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WkJOWVZVYk9kbEdsUDhJRG5LRnJuSlZ5NGt5RFhWS1cxUDJ2L0lVVm1UN0Vq?=
 =?utf-8?B?aDhQemp4ZjBuQ2pGQmZjRkVuNnhydWU4VmJVdWxmRFBtOXV3RTRrandVWUJY?=
 =?utf-8?B?S0dQcE9COFg3SElXcXJqUDZiWXBiNWsxdmZLclZxdDZiVWFtY0tsOGZTVmRW?=
 =?utf-8?B?WmwveXRkU3JudHNHVzBhRGEwaDNXRkNDOTdCYVVFeTd1c2ZTQW42cWI2NWNi?=
 =?utf-8?B?UVJ2MDFIeUFCelcrQlR5bWdvUlI4cXJmd1MzamI3di9VU2hxZWx5dTN3Tm5N?=
 =?utf-8?B?ZUwrNHdqQ09xb1NxOEMzQmNleVQ0SU9venRscitNaVF4bGVkN0U2VHRDZy9O?=
 =?utf-8?B?WEU5U3RVbGlxR2xOT1MwMlVuMkd0MVVqb25USUtkVnNIOHVMaVpPdXVrV21I?=
 =?utf-8?B?M0Y5SzErUTdyVTJHZDRNcWVScWVleTRIek1iN042YTliUHMxZ3VaMk9ZMWtn?=
 =?utf-8?B?K3Q4ZmEzRHRQWG1GMXNRclNiWDYxL1MwVUNSL1d4d1FKUGpybjZJTXRnVWJS?=
 =?utf-8?B?RW40TDhKbzRVaVh3VEV5WFlFT3hha2FoYVBtNU05SEYwSlowQ0NqTVk0Z3JX?=
 =?utf-8?B?cnR5eVN4QWUrTEIyeW9jT1d1SkJkWjZuN2dnNUJQdi9WRlVxNlV2WDVTZEU4?=
 =?utf-8?B?ZGg0NUV1K3R0SmpQRU9xWG4yYTEwMW5zaE9pd1lvZlVsbjZJMjRkWElaZWpS?=
 =?utf-8?B?OTlQU2owWlJPTTQyeTJVZlljSzMvK2xzNktEaGZINVluRGpmcVlUQmh2R1No?=
 =?utf-8?B?MFVybVdZeWkzRTJrL3lXdXZnM2twYUlaQm5tUFlDSm5BVFIxQkNRRDViQ3RR?=
 =?utf-8?B?OE0vWmpRVW11R1dYNnV3SWhMUTA5VmR2YnJTOHJaMS95RXplaXNNc21mNXRp?=
 =?utf-8?B?OE94dFMxYUJRL2pvb3Rob2x2WktzNHdSMmNIeE5SVkg3cTZvMXpHR3N2R3po?=
 =?utf-8?B?SFhTUTdrRGg4Szh1akVLWTRYczFHRUpoVEV5Sk5KUktXSnJnbWQ5NThYNDdk?=
 =?utf-8?B?N1Nic0dIZEJaVjlRS1NvSFpFY1VIZGZ4L0d2ZVBObE4vQWdIc3dUTHZiaTk4?=
 =?utf-8?B?a25UcVFGWHFVK1pBN3BFblpWRzVZY3dIU3NraGtXWGtnbGR2MXh4S3RHdUtP?=
 =?utf-8?B?NkhSNk1pR2VJYWRvMjZCL3dBV011OEtxWlNLMENUaUNJN0xFTFQxaEZ5bUhu?=
 =?utf-8?B?RUJxRzNXb1p3UHg4QjdGb0hGWDNacUpmVWVqaGYyYW0vYVdVMEFjSERVMDNx?=
 =?utf-8?B?VEE5NTlMYzNVVjArY3ZvTTdFdjh3LzFTNnZkM29WdVpmOXFuRVo2NE45SkpM?=
 =?utf-8?B?UGIzbWphajlRcXlWS3QvVmZQWDMyalV1bXk0TlcvT3phQnFPMHZWMFMwK1FS?=
 =?utf-8?B?Q3pwVGlQVDEwVHM0NWwzRmNwTkNEUUJOSjRkV2Q2b0hodEtOWDJxT1lmNnA5?=
 =?utf-8?B?NEwrRFV1Z2E1ZWxoN0hrOHZ3ZkJnUWdxMERJVGNNZldPWmUzcVl5OUptZXkr?=
 =?utf-8?B?NE1WR0tWRzVhV3hpR1dvTFlPKzc1MkdOdWVHQUV1czV1NVcwRzRDeDluSkow?=
 =?utf-8?B?WlM1Ym1NWjhXSWRSUkNQTUVqWG9oanhqMnVPamZRR1hVejdnRnFHVGpKSDl3?=
 =?utf-8?B?MTZZajlXQTNQenI4T0l4bHlmOS9TTTN6MzREMU80cmM5WnVTckwrNlV5bTJL?=
 =?utf-8?B?c3RsU2d5RXBmUmdPYi9VdUtad2NMMkRYeUxrYzFwZkExdGZoUnB6ai92bFlJ?=
 =?utf-8?B?RlFWS0t0dmRYV2NUR1JON1BpMXlXZzVITjdQZVdpMHNUTVF2NWM0NVQwNkdn?=
 =?utf-8?B?cGJhSE50T21UalRqR2g0Sm9EK3hjNEtCaEVGMXlkeGg3bHd4VENPWEdGVzFy?=
 =?utf-8?B?YUVISVFJR2JKOXQ3dGR5THBHbUFzVnh0MkRvNUFXK0JKcVZ0UHJDVUtDS1hI?=
 =?utf-8?B?YUhISGN2d3h1ZndMM0JEejErYUJJa3pzdHhFQmwrY2UvZzdXY2M2eGtkRjBV?=
 =?utf-8?B?MWE1MzN2OGhGYkRRdmxXV3VqelNUNWd4NEdIMXYxcmo5M003UzhJai9FbVIv?=
 =?utf-8?B?M0ZxeGQyRjRrNm1LSEt1Sk1nSkgzb2hVTDFWR2dNbml3QlJia09nMWZxaHpE?=
 =?utf-8?Q?IQNlfdfiLCazxgAVPJ2R0zUEy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1d0b5a2-d121-4170-7962-08db68ad3cc8
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2023 05:49:06.1196 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uAPVyyVa5GrRgGrEfiWRNAuAxzmxkl5AUPt5P7hl+AcHn3Q5fjfrdN3iY9EcjiZqNd9/u0cq4F1+i9HyWph/QuLgsUBdC349gbar/jCdLgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR11MB5574
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=zhenzhong.duan@intel.com; helo=mga07.intel.com
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
cmVkaGF0LmNvbT4NCj5TZW50OiBGcmlkYXksIEp1bmUgOSwgMjAyMyAzOjUzIEFNDQo+VG86IEph
c29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+DQo+Q2M6IExpdSwgWWkgTCA8eWkubC5saXVA
aW50ZWwuY29tPjsgRHVhbiwgWmhlbnpob25nDQo+PHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT47
IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgbXN0QHJlZGhhdC5jb207DQo+amFzb3dhbmdAcmVkaGF0
LmNvbTsgcGJvbnppbmlAcmVkaGF0LmNvbTsNCj5yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3Jn
OyBlZHVhcmRvQGhhYmtvc3QubmV0Ow0KPm1hcmNlbC5hcGZlbGJhdW1AZ21haWwuY29tOyBhbGV4
LndpbGxpYW1zb25AcmVkaGF0LmNvbTsNCj5jbGdAcmVkaGF0LmNvbTsgZGF2aWRAcmVkaGF0LmNv
bTsgcGhpbG1kQGxpbmFyby5vcmc7DQo+a3dhbmtoZWRlQG52aWRpYS5jb207IGNqaWFAbnZpZGlh
LmNvbTsgUGVuZywgQ2hhbyBQDQo+PGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj5TdWJqZWN0OiBS
ZTogW1BBVENIIHYzIDUvNV0gaW50ZWxfaW9tbXU6IE9wdGltaXplIG91dCBzb21lIHVubmVjZXNz
YXJ5DQo+VU5NQVAgY2FsbHMNCj4NCj5PbiBUaHUsIEp1biAwOCwgMjAyMyBhdCAwMToyNzo1MFBN
IC0wMzAwLCBKYXNvbiBHdW50aG9ycGUgd3JvdGU6DQo+PiBPbiBUaHUsIEp1biAwOCwgMjAyMyBh
dCAxMTo0MDo1NUFNIC0wNDAwLCBQZXRlciBYdSB3cm90ZToNCj4+DQo+PiA+ID4gQnV0IGlmIHRo
ZXJlIGlzIHRoZSBwcm9wZXIgbG9ja3MgdG8gcHJldmVudCBhIG1hcC91bm1hcCByYWNlLCB0aGVu
DQo+PiA+ID4gdGhlcmUgc2hvdWxkIGFsc28gYmUgdGhlIHByb3BlciBsb2NrcyB0byBjaGVjayB0
aGF0IHRoZXJlIGlzIG5vIG1hcCBpbg0KPj4gPiA+IHRoZSBmaXJzdCBwbGFjZSBhbmQgYXZvaWQg
dGhlIGtlcm5lbCBjYWxsLi4NCj4+ID4NCj4+ID4gVGhlIHByb2JsZW0gaXMgSUlSQyBndWVzdCBp
b21tdSBkcml2ZXIgY2FuIGRvIHNtYXJ0IHRoaW5ncyBsaWtlIGJhdGNoaW5nDQo+PiA+IGludmFs
aWRhdGlvbnMsIGl0IG1lYW5zIHdoZW4gUUVNVSBnZXRzIGl0IGZyb20gdGhlIGd1ZXN0IE9TIGl0
IG1heQ0KPmFscmVhZHkNCj4+ID4gbm90IG1hdGNoaW5nIG9uZSBtYXBwZWQgb2JqZWN0cy4NCj4+
DQo+PiBxZW11IGhhcyB0byBmaXggaXQuIFRoZSBrZXJuZWwgQVBJIGlzIG9iamVjdCBiYXNlZCwg
bm90IHBhZ2VkDQo+PiBiYXNlZC4gWW91IGNhbm5vdCB1bm1hcCBwYXJ0aW9ucyBvZiBhIHByaW9y
IG1hcHBpbmcuDQo+Pg0KPj4gSSBhc3N1bWUgZm9yIHRoaXMga2luZCBvZiBlbXVsYXRpb24gaXQg
aXMgZG9pbmcgNGsgb2JqZWN0cyBiZWNhdXNlDQo+PiBpdCBoYXMgbm8gaWRlYSB3aGF0IHNpemUg
b2YgbWFwcGluZyB0aGUgY2xpZW50IHdpbGwgdXNlPw0KPg0KPk1BUCBpcyBmaW5lLCBiZWZvcmUg
bm90aWZ5KCkgdG8gVkZJTyBvciBhbnl0aGluZywgcWVtdSBzY2FucyB0aGUgcGd0YWJsZQ0KPmFu
ZCBoYW5kbGVzIGl0IGluIHBhZ2Ugc2l6ZSBvciBodWdlIHBhZ2Ugc2l6ZSwgc28gaXQgY2FuIGJl
ID40SyBidXQgYWx3YXlzDQo+Z3Vlc3QgaW9tbXUgcGdzaXplIGFsaWduZWQuDQo+DQo+SSB0aGlu
ayB3ZSByZWx5IG9uIGd1ZXN0IGJlaGF2aW5nIHJpZ2h0LCBzbyBpdCBzaG91bGQgYWxzbyBhbHdh
eXMgb3BlcmF0ZQ0KPm9uIHRoYXQgc2l6ZSBtaW5pbXVtIHdoZW4gbWFwcGVkIGh1Z2UuICBJdCBz
aG91bGRuJ3QgdmlvbGF0ZSB0aGUNCj4icGVyLW9iamVjdCIgcHJvdG9jb2wgb2YgaW9tbXVmZC4N
Cj4NCj5JSVVDIHRoZSBzYW1lIHRvIHZmaW8gdHlwZTF2MiBmcm9tIHRoYXQgYXNwZWN0Lg0KPg0K
Pkl0J3MgbW9yZSBhYm91dCBVTk1BUCBiYXRjaGluZywgYnV0IEkgYXNzdW1lIGlvbW11ZmQgaXMg
ZmluZSBpZiBpdCdzIGZpbmUNCj53aXRoIGhvbGVzIGluc2lkZSBmb3IgdGhhdCBjYXNlLiAgVGhl
IG9ubHkgZGlmZmVyZW5jZSBvZiAibm90IGV4aXN0IiBvZg0KPi1FTk9FTlQgc2VlbXMgdG8gYmUg
anVzdCBzYW1lIGFzIGJlZm9yZSBhcyBsb25nIGFzIFFFTVUgdHJlYXRzIGl0IGFzIDAgbGlrZQ0K
PmJlZm9yZS4NCj4NCj5UaG91Z2ggdGhhdCBkb2VzIGxvb2sgc2xpZ2h0bHkgc3BlY2lhbCwgYmVj
YXVzZSB0aGUgd2hvbGUgZW1wdHkgVU5NQVANCj5yZWdpb24gY2FuIGJlIHNlZW4gYXMgYSBob2xl
IHRvbzsgbm90IHN1cmUgd2hlbiB0aGF0IC1FTk9FTlQgd2lsbCBiZSB1c2VmdWwNCj5pZiBxZW11
IHNob3VsZCBhbHdheXMgYnlwYXNzIGl0IGFueXdheS4gIEluZGVlZCBub3QgYSBwcm9ibGVtIHRv
IHFlbXUuDQo+DQo+Pg0KPj4gPiBXZSBjYW4gZGVmaW5pdGVseSBsb29rdXAgZXZlcnkgc2luZ2xl
IG9iamVjdCBhbmQgZXhwbGljaXRseSB1bm1hcCwgYnV0IGl0DQo+PiA+IGxvc2VzIHBhcnRpYWwg
b2YgdGhlIHBvaW50IG9mIGJhdGNoaW5nIHRoYXQgZ3Vlc3QgT1MgZG9lcy4NCj4+DQo+PiBZb3Ug
ZG9uJ3QgbmVlZCBldmVyeSBzaW5nbGUgb2JqZWN0LCBidXQgaXQgd291bGQgYmUgZmFzdGVyIHRv
IGNoZWNrDQo+PiB3aGVyZSB0aGluZ3MgYXJlIG1hcHBlZCBhbmQgdGhlbiBjYWxsIHRoZSBrZXJu
ZWwgY29ycmVjdGx5IGluc3RlYWQgb2YNCj4+IHRyeWluZyB0byBpdGVyYXRlIHdpdGggdGhlIHVu
bWFwcGVkIHJldWx0cy4NCj4NCj5NYXliZSB5ZXMuICBJZiBzbywgSXQnbGwgYmUgZ3JlYXQgaWYg
Wmhlbnpob25nIGNvdWxkIGp1c3QgYXR0YWNoIHNvbWUgcHJvb2YNCj5vbiB0aGF0LCBtZWFud2hp
bGUgZHJvcCB0aGUgImlvbW11ZmQgVU5NQVAgd2FybmluZ3MiIHNlY3Rpb24gaW4gdGhlIGNvbW1p
dA0KPm1lc3NhZ2UuDQoNClNlZW1zIHZ0ZF9wYWdlX3dhbGtfb25lKCkgYWxyZWFkeSB3b3JrcyBp
biBhYm92ZSB3YXksIGNoZWNraW5nIG1hcHBpbmcNCmNoYW5nZXMgYW5kIGNhbGxpbmcga2VybmVs
IGZvciBjaGFuZ2VkIGVudHJpZXM/DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

