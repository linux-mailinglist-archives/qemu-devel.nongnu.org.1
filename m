Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03CFC7A90CA
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Sep 2023 04:12:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qj9A5-0005Ik-AS; Wed, 20 Sep 2023 22:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9A3-0005IY-31
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:11:23 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qj9A0-0002y5-RX
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 22:11:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695262280; x=1726798280;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=EBAA9OLSBRSRnVtiIP8DlTQ7T2hXv//0PyzrpmYBCa0=;
 b=l3iAXjL3K53NrJeV1z9W2HLXBl55Zg6FEjyg5d7KmDPf6/fhVhlGZPRJ
 rERpuOeNT+igwpsQLbdoDjMFRaam0dHkwUZU5LMWsTKYQ1L28aC1AEePI
 8sPfoggDQ8LGOpKdXLPCUOeNoTLYowRko7WXRxvX3UAhOHl/aPuVOoKNK
 XbD4SshPNtqVLlOA51hVSrcbHMv5ebyAeaMIaI3Kncx4XGHLyn6dUKrFE
 jqICS0jf9JOnHdZ9hWKjmPehdLCDRW/Eux7TebKUJuaOn734nHZwsmX5j
 3YbBLe7fs/P5LnLhUEz5dEzyHvv1mKEJlcKlDSWCVDXUxkCMEopuxX7eG A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384236406"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="384236406"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Sep 2023 19:11:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="1077713202"
X-IronPort-AV: E=Sophos;i="6.03,164,1694761200"; d="scan'208";a="1077713202"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Sep 2023 19:11:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:11:13 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 19:11:12 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 19:11:12 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.170)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 19:11:11 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Njs6CY511jUnV+3e9XtRj0CRvGC00N8iM5ZhQag5bxE+mnkG2rceSDsuGC7Q4RX1ee2OhrPPJ2M1RazAIvtvlYtZ1w4cMfBp5eXQLadRA2O3fOil76vV4/E6Ku6Ro3ccqddHDcLikPQZV9cCCXlm5MqmnXh05WA7yegPzzihZ91Ht5AH/XWFxJKNUfCdwdLXCfEKLwSBPZ2zEDZSBUzofjM3+BhUSRng5xt2mNG8qbfm4IrO4zl0eI9xqnFFqwR6kOz4h7ipIrQboPIGprhmdJ0CME6Z/pQDWYwwQpS+oEgpAPC3yfiIftgexrhKJJ37J87UmC0F8j37pzO9iwro5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EBAA9OLSBRSRnVtiIP8DlTQ7T2hXv//0PyzrpmYBCa0=;
 b=BLvXYIWHjF2w6bRHCbORv8By7Up086K4WnNUi8+M54wNlDFwJl8EXMl+9NqFlxZ2F8xLj9Cr6Rf4sekDcp0QjGvEP+swUJoTtfXlo3BxCZnlij4mUKSRMCwOrWHD+mg0JevJ25LTSGHGQvlsDEwRYxzuN/7TGX+7S1bhutGYjicMXm0QtoyqxgFIIMo7UNITQnAVeLpDIrSlbWKb9geXSWwjgesIWVtT0kmv08UcJG0Yn1B3WtUzGkrH/CK880UAqDvrboIxbGlJu3YfXmdU9aw8VzeQB6pprach2IoQ4lseEgoH/TsGsKOc51gUtotvScjlN8CAoCgDrsReZqHOSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SA3PR11MB7554.namprd11.prod.outlook.com (2603:10b6:806:315::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 02:11:10 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::30d5:1067:980d:b8aa%6]) with mapi id 15.20.6792.026; Thu, 21 Sep 2023
 02:11:09 +0000
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
Subject: RE: [PATCH v1 15/22] Add iommufd configure option
Thread-Topic: [PATCH v1 15/22] Add iommufd configure option
Thread-Index: AQHZ2zBBz9BBn8bZBkKAV/2bA/8zjLAigTGAgACtoLCAAJRFAIAA2Glw
Date: Thu, 21 Sep 2023 02:11:09 +0000
Message-ID: <SJ0PR11MB67443619422E3101C1DD3B1A92F8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230830103754.36461-1-zhenzhong.duan@intel.com>
 <20230830103754.36461-16-zhenzhong.duan@intel.com>
 <75c9c56e-f2da-f2a3-32b6-c9228678b05a@redhat.com>
 <SJ0PR11MB6744E56158500CC3A0A34BDC92F9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
In-Reply-To: <664d3338-c280-6d16-b03e-bb235931ce99@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SA3PR11MB7554:EE_
x-ms-office365-filtering-correlation-id: 1274ebb5-e1b9-48b9-f964-08dbba48058b
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ref0WQ37ykEGoAOSXcUGzjis2pY7B1iJULLhk6SSQdINe4c0Ow2bhIS/0gMIOqG9W62UGu6/9bRhv8/0in+jUWW10DspYMZZHBWDbmRk96wht6YCB7qL7xqsjzzbu5+PRDrtKtaJdNOCr8J/csNqvHp/2xjE5oqsKNrH1jpr5aQ9j+YuoXQ84OrPlbcz7kQZx8lFNMRIrsaeg5fIQh07uv5J1nr100G5VcfuZWqz9SdyY4Hker6Mudu+ExdZSRB0WbG1wIWoMLjnqhF7raqhp2ipQF8WcvwRHgknWMbD48F6d8vv2tnU1hU5vg/eqnRG1RGmZhyrm9F2ocyed5Cxsq/lwBq6vbczl7jplm5JmAryKMXapZRG5dquAeBWOyqB2jN5WVmsI62VAlgtNK/UWzuY3audxwOEbyWNSYdIVW2uXcqiqoCKecxRA2jjc9dRHC1UKyYNxjO0IS+CCtdKgQXTNmSluG1u3QW5dp+bJDuXaLKye8QpAtzyFA8EjYeVvq35bt+QvidApUEkRD3qeU4oM9AV+ixGfujPGyQZanu4XSCgSp3uVamdppOSUP4NaaE8B1NU8uANU7NaBYkVSccXYn5MmCpkVY1twTXBxQctCxbK1MTl3tmegbjUw1OZ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(366004)(136003)(376002)(346002)(451199024)(186009)(1800799009)(66899024)(82960400001)(38100700002)(122000001)(38070700005)(55016003)(33656002)(86362001)(478600001)(66446008)(54906003)(110136005)(64756008)(66556008)(66476007)(71200400001)(66946007)(2906002)(316002)(76116006)(9686003)(6506007)(53546011)(7696005)(8676002)(8936002)(5660300002)(4326008)(52536014)(41300700001)(7416002)(26005)(66574015)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NXVWd0FvODdIVlZRVHlBK0J4SDgvWjhIcXUzZDA4ejRhRXFiTGZiaFUyUzVo?=
 =?utf-8?B?VS93RjFOY01YZlU5NGpBaE5GNm1jMVN4Qy8rYzhQTFY2WG9IL0E0L2lIaWpR?=
 =?utf-8?B?UmNvd3RKcXN1cFZLSVEybnc4aVZUc1lCMWE3bVpxaGZKaUVzbm1HakxJcGNU?=
 =?utf-8?B?cG5HUWQ2QlF0bWw3T01VN0w2MmE5RENoZXJTZmk0OVdidXhqWllBbzFia2tq?=
 =?utf-8?B?VDQ2ckVEbllPUjl5R3VLdzV6NlgxbkZFbjRGMlZOaUwxU2tvN1BHOEcrc0NV?=
 =?utf-8?B?S3dnM24rWmo1VStaME5kWVhkZE93NE96NXRIWGQ0d0N2di9qZlpWbUxCZEd0?=
 =?utf-8?B?aDlQRkZ1NFRRQ0dnVlZCdDNhUUY5TVVjcTBHL1EwcjI5aFZhUEZBdnk4c1Jw?=
 =?utf-8?B?SHNlUmxoU0ExSkVSZmU0T0dnOXZMSy8yeG1vY003bGRjdG8rVC81cFZuTVY0?=
 =?utf-8?B?ZFpETHZ5WCsvYVpORjRmdHlFRm8rMHQ4YXdWMzhQRkxnYmI1a3ZjSi9iZ1lO?=
 =?utf-8?B?RW9aZEgvS0dmeUkyQ3k2VXFtRVVIL3NORjFOaUIxRUZGZUNHbWp0U1RyYjRt?=
 =?utf-8?B?YW9CVGhQVlpPZnBLVlU4akZ5djhFckM3dlgxblVoOWl6SWU2QmM0MWsxNjU2?=
 =?utf-8?B?SzR3dmwrc0VFbFo4NWtBM2lpQ0V4NlJGTndZdEhOUitSQTVld0JFdmZ1NTJZ?=
 =?utf-8?B?WmhJOG15UUVoYm1wVVlkSXZCQlJLZERVcHpYb1ZydXhvMytOSzRJNGZBb3B4?=
 =?utf-8?B?NlFTek92WUE1eENPRVJndEJ4dUJVS0lFM3RKR2VVWnFNZ2RoazRubXNBRnJQ?=
 =?utf-8?B?YS9xQmxyTFRNM3BkbG9udkVaUThTSmNPVkRodllZU2NwMElGSHdlaDhwQm5F?=
 =?utf-8?B?VDFEVUJkQjl1dVNudVpkRk1GNFlCVkczTlZFaHFGS2pKK1pZdGNrZisveFR0?=
 =?utf-8?B?WG5DSllTTjh6N1Nja0tuZmROZ1U0S2h1Z0tObkJ0VjdKdVp0dmhpMkwremw5?=
 =?utf-8?B?ZFhlODh5eUJJU1hxeWRuV2dRcHRpUVdUZDVCZDJ3bE1iUXZMUzRGeDZadDFS?=
 =?utf-8?B?SWhGMWNKUnRYTFVmVVZzMW84NndLbXFIQ0pDRkpHQm9FOXBVV2RFNUJJYjB1?=
 =?utf-8?B?UUdlZUUvemRKK1RablVlK3BEYjZ3WFhUWE1LblhSRUVLL3lwNHhZb0VRWXRO?=
 =?utf-8?B?b01XUXlaN0RHNE1XRGNSb2tEM1diU2tqeDk3bk5UN2RRdDg5U2c3SEtuODIr?=
 =?utf-8?B?Y3BTdXlDWERDY1ZXSWN5NEw0K0g3Tnl5bGl4R1cwZElodjVjTmlQaXdaVWd0?=
 =?utf-8?B?cnE0MHVLZjlndW82RCtLMmsrR25uUXpTY3hZVFA1U21iNytFWDl2OTBTMk10?=
 =?utf-8?B?WlBoR1BlYjA0SkNkR0ZWQUN5dzNGZitTZk1PaGFtZXI4NVd1VlU4NWQwdlBD?=
 =?utf-8?B?dVlnNCtuYVllL2huNTNEdXVyRVlkY3UvN1ZneUwvcUtUNmZvZFA5by9wM3BL?=
 =?utf-8?B?cCtCcldkNnlBOGoycndxcjJienh4bGZIV3U2a2NtMC9odUc5S0FraFBNWm1V?=
 =?utf-8?B?T09ZcHZ5cHJOQlBpRnZJYnN4QlRhTTdLcmVSZVA0NGxRanRpZGh6ejVqZGYz?=
 =?utf-8?B?azNpV0tpMjZnak81cDJMcGFjSkZnM2g5Y1BSKzlhWjNyL01wb2hxYVllTzFT?=
 =?utf-8?B?Q21IZ2N5aEtsSDRFdWlFSmJRdFpiZWlIelI4RmZ6cG4xM1pxS0F0WExIdDI0?=
 =?utf-8?B?Zm8yTVJFQ1VPVlBMa0IxYzdiWE81M1lOWmd2Uk12aU1KYXRlR01PQUxwQVlj?=
 =?utf-8?B?NzlHK0RRYzZsM0Q0L0lObmk4WXF0YUx1QjFNTUZWbVJUMWJvdURKeFljdURC?=
 =?utf-8?B?Z0VFYVIwVmdVUlJFdzZ0UUFsSGpHNzQzS1pxeklIMHJOTlNkRlBGQUltT3g5?=
 =?utf-8?B?YmV4YVVKTnVzaVVSeXlsTHNGazB5TFNSd1A5OGpxWTQvU0JxM2lsZkFNWklo?=
 =?utf-8?B?dm5WaG5hKzUvd082UmtMN0lMaUFxdWpVTmc3NGhXOVdCaU9aU0ZHc2tsVmdw?=
 =?utf-8?B?K3hNNHAvN21pT2xJUTB2S3k5OXl1dndHQzk0RUlPSTRvNkFyajQ2WmFKZ2o3?=
 =?utf-8?Q?pFLOlZUfWlW1KSodtvMdP2OY4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1274ebb5-e1b9-48b9-f964-08dbba48058b
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Sep 2023 02:11:09.6145 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 90ZofKXBoAofHxqTzuuJi5jJNXtBVl9l8CN+aJMGzAKu+hsYzLFakFU7UYCyX76l4dzOp0jW5gDU3SrqB5Iv7auexeLI/jQdTZgCKP8wAwQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7554
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyMCwgMjAyMyA4
OjIwIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MSAxNS8yMl0gQWRkIGlvbW11ZmQgY29uZmln
dXJlIG9wdGlvbg0KPg0KPk9uIDkvMjAvMjMgMDU6NDIsIER1YW4sIFpoZW56aG9uZyB3cm90ZToN
Cj4+DQo+Pg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPj4+IFNlbnQ6IFdlZG5lc2RheSwgU2VwdGVt
YmVyIDIwLCAyMDIzIDE6MDggQU0NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIIHYxIDE1LzIyXSBB
ZGQgaW9tbXVmZCBjb25maWd1cmUgb3B0aW9uDQo+Pj4NCj4+PiBPbiA4LzMwLzIzIDEyOjM3LCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4gVGhpcyBhZGRzICItLWVuYWJsZS1pb21tdWZkLy0t
ZGlzYWJsZS1pb21tdWZkIiB0byBlbmFibGUgb3IgZGlzYWJsZQ0KPj4+PiBpb21tdWZkIHN1cHBv
cnQsIGVuYWJsZWQgYnkgZGVmYXVsdC4NCj4+Pg0KPj4+IFdoeSB3b3VsZCBzb21lb25lIHdhbnQg
dG8gZGlzYWJsZSBzdXBwb3J0IGF0IGNvbXBpbGUgdGltZSA/IEl0IG1pZ2h0DQo+Pg0KPj4gRm9y
IHRob3NlIHVzZXJzIHdobyBvbmx5IHdhbnQgdG8gc3VwcG9ydCBsZWdhY3kgY29udGFpbmVyIGZl
YXR1cmU/DQo+PiBMZXQgbWUga25vdyBpZiB5b3Ugc3RpbGwgcHJlZmVyIHRvIGRyb3AgdGhpcyBw
YXRjaCwgSSdtIGZpbmUgd2l0aCB0aGF0Lg0KPg0KPkkgdGhpbmsgaXQgaXMgdG9vIGVhcmx5Lg0K
Pg0KPj4+IGhhdmUgYmVlbiB1c2VmdWwgZm9yIGRldiBidXQgbm93IFFFTVUgc2hvdWxkIHNlbGYt
YWRqdXN0IGF0IHJ1bnRpbWUNCj4+PiBkZXBlbmRpbmcgb25seSBvbiB0aGUgaG9zdCBjYXBhYmls
aXRpZXMgQUZBSVVJLiBBbSBJIG1pc3Npbmcgc29tZXRoaW5nID8NCj4+DQo+PiBJT01NVUZEIGRv
ZXNuJ3Qgc3VwcG9ydCBhbGwgZmVhdHVyZXMgb2YgbGVnYWN5IGNvbnRhaW5lciwgc28gUUVNVQ0K
Pj4gZG9lc24ndCBzZWxmLWFkanVzdCBhdCBydW50aW1lIGJ5IGNoZWNraW5nIGlmIGhvc3Qgc3Vw
cG9ydHMgSU9NTVVGRC4NCj4+IFdlIG5lZWQgdG8gc3BlY2lmeSBpdCBleHBsaWNpdGx5IHRvIHVz
ZSBJT01NVUZEIGFzIGJlbG93Og0KPj4NCj4+ICAgICAgLW9iamVjdCBpb21tdWZkLGlkPWlvbW11
ZmQwDQo+PiAgICAgIC1kZXZpY2UgdmZpby1wY2ksaG9zdD0wMDAwOjAyOjAwLjAsaW9tbXVmZD1p
b21tdWZkMA0KPg0KPk9LLiBJIGFtIG5vdCBzdXJlIHRoaXMgaXMgdGhlIGNvcnJlY3QgaW50ZXJm
YWNlIHlldC4gQXQgZmlyc3QgZ2xhbmNlLA0KPkkgd291bGRuJ3QgaW50cm9kdWNlIGEgbmV3IG9i
amVjdCBmb3IgYSBzaW1wbGUgYmFja2VuZCBkZXBlbmRpbmcgb24gYQ0KPmtlcm5lbCBpbnRlcmZh
Y2UuIEkgd291bGQgdGVuZCB0byBwcmVmZXIgYSAiaW9tbXUtc29tZXRoaW5nIiBwcm9wZXJ0eQ0K
Pm9mIHRoZSB2ZmlvLXBjaSBkZXZpY2Ugd2l0aCBzdHJpbmcgdmFsdWVzOiAibGVnYWN5IiwgImlv
bW11ZmQiLCAiZGVmYXVsdCINCj5hbmQgZGVmaW5lIHRoZSB2YXJpb3VzIGludGVyZmFjZXMgKHRo
ZSBvcHMgeW91IHByb3Bvc2VkKSBmb3IgZWFjaA0KPmRlcGVuZGluZyBvbiB0aGUgdXNlciBwcmVm
ZXJlbmNlIGFuZCB0aGUgY2FwYWJpbGl0aWVzIG9mIHRoZSBob3N0IGFuZA0KPnBvc3NpYmx5IHRo
ZSBkZXZpY2UuDQo+DQo+SSBtaWdodCBiZSB3cm9uZyBhbmQgdGhpcyBtaWdodCBoYXZlIGJlZW4g
ZGlzY3Vzc2VkIGJlZm9yZS4gSWYgc28sIGl0DQo+c2hvdWxkIGdvIGluIHRoZSBjb3ZlciBsZXR0
ZXIgd2l0aCBvdGhlciB0aGluZ3MgOiB3aGF0IGlzIHRoaXMgcGF0Y2hzZXQNCj5wcm92aWRpbmcg
dG8gVkZJTyAobXVsdGlwbGUgaW9tbXUgYmFja2VuZHMpLCBob3cgaXQgaXMgcmVhY2hpbmcgdGhh
dA0KPmdvYWwsIGhvdyBpcyBpdCBvcmdhbml6ZWQsIGhvdyBkbyB3ZSBkZWFsIHdpdGggdGhlIHNw
ZWNpYWwgY2FzZSAoc3BhcHIpLA0KPndoYXQncyB0aGUgdXNlciBpbnRlcmZhY2UsIGV0Yy4NCg0K
R290IGl0LCBJJ2xsIGFkZCAiIGhvdyBpcyBpdCBvcmdhbml6ZWQsIGhvdyBkbyB3ZSBkZWFsIHdp
dGggdGhlIHNwZWNpYWwgY2FzZSAoc3BhcHIpIg0KcGFydCwgb3RoZXIgcGFydHMgc2VlbXMgYWxy
ZWFkeSBpbiBjb3ZlciBsZXR0ZXIsIHRoZXJlIGlzIGEgZGlhZ3JhbSBzaG93aW5nDQp0aGUgYXJj
aGl0ZWN0dXJlIG9mIFZGSU8vbGVnYWN5IEJFL0lPTU1VRkQgQkUsIGV0Yy4NCg0KVGhhbmtzDQpa
aGVuemhvbmcNCg==

