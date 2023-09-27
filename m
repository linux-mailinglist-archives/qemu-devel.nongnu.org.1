Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 774987B0193
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:14:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRY9-0000Bd-Sq; Wed, 27 Sep 2023 06:13:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlRY5-0008TH-OE
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:13:41 -0400
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qlRY2-0006Kw-7H
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:13:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1695809618; x=1727345618;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mZ7Dwek/9dje63Lv6/w1tiN//Usls5Yo8Urbm1VQ+qs=;
 b=JGcGhY7QoA7pj4T3IZQVtO1JPeGVuktgfH8nB3R/digBdDL03Xhh4OOn
 SM9aiDDETgP1eZS7792Nmgrg++7uykhwDriSiWDo9X4Wtk8knGEmrE87B
 i2xx9itV49AzZ7ntjx12HZW+c4oFANaEn1bMQhivo2n3fpngXkAHmHbBr
 hSOj2AhzwNr6jZs5m6zBiWufPcVMmTx76/j0VFHKnYWow4S92AptLzbl1
 CfrChGRZImK3SeSWuKSG36exGkMixeTitFpfDMxlHwSoqSIY5eZcd+i70
 Px9zLZzJ0CioT+Y3oMfATA/RcpR/9HDnuDuv6gms+64LrJTSH0L6/PA8k A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="380660371"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="380660371"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Sep 2023 03:12:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="784267835"
X-IronPort-AV: E=Sophos;i="6.03,179,1694761200"; d="scan'208";a="784267835"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Sep 2023 03:12:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:12:01 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 27 Sep 2023 03:12:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 27 Sep 2023 03:12:00 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.47) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 27 Sep 2023 03:12:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SF0kC+2U5g7Kudrz8Dspo7cLlCY9KCRPRE462WE3XG8bsKfpeYL16xyYgXZ10Ua2Ly3XkPvMI1bZhaTmGbw3Fa1bWzA9JSjC3bmOQs7BO1+T7PAtPGmUGhHC2ioZijEXMi8YFB03cj583Ul9Y7JbHdbUkQfIdYruOqhPpCSM+spFzJ2yU6v/fOOBx+gouz4Bb17nbrQDjxgXNdvknrBDMuHI5MdSP6UdBT0akjFo0cOfYwGItO4yKwDcfmLrY5R5x6Sf+5iK3ZelFOMaublcfslOhwO8PhtcnAvkJRikBv71B0FB/JqmzHLVHXPnqWgvDOrhXWSTzwNGL1T2vgq81w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mZ7Dwek/9dje63Lv6/w1tiN//Usls5Yo8Urbm1VQ+qs=;
 b=dkK0R5zgkEbxguFjMpYclGPrZK3CBYAkbfVosh2x0sP3QmUuiqAjdZN9Ffdu8zTb2mqOzP1l9JI1vKCPYXHfNwN6ehVsW9FxW7BnzTCgB0tm+FNa7tEg5qU6q8RdUGCkxZAHNA+lf1gWgyatXCRSo5M6qOeFVEYB80/Q1MYWhGFDYCl8mL6vrqqLV7E1imsYmjArAJGwIVQ34R6wdLwsvO2l5fVZycltRwd7CN+7EnzCl0z+Ox10xDLvhBiLUW5nEPNpLftjicCcjNgD3s8LScERN4EOgYYyGMbTiuzMQlEgyxWhke8q8hA56MzvLTX62PuslX7g1FbY0WxQwUiNKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by SJ2PR11MB7518.namprd11.prod.outlook.com (2603:10b6:a03:4c5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Wed, 27 Sep
 2023 10:11:51 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::cfa6:8eda:9312:1c24%3]) with mapi id 15.20.6813.017; Wed, 27 Sep 2023
 10:11:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>,
 "nicolinc@nvidia.com" <nicolinc@nvidia.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2 07/12] vfio/platform: Use vfio_[attach/detach]_device
Thread-Topic: [PATCH v2 07/12] vfio/platform: Use vfio_[attach/detach]_device
Thread-Index: AQHZ8G9N660mr+UxTUOcfIAPMNcyEbAuZBuAgAAP30A=
Date: Wed, 27 Sep 2023 10:11:51 +0000
Message-ID: <PH7PR11MB67226E0468AC92DC20348EE592C2A@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20230926113255.1177834-1-zhenzhong.duan@intel.com>
 <20230926113255.1177834-8-zhenzhong.duan@intel.com>
 <228e1e52-03e2-892b-2b18-8640ec65130f@redhat.com>
In-Reply-To: <228e1e52-03e2-892b-2b18-8640ec65130f@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|SJ2PR11MB7518:EE_
x-ms-office365-filtering-correlation-id: f58efbd9-8ff5-4c63-5cd5-08dbbf422b31
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IFiiX3qnfFsN9lVY4RurVrc/wWSnxM/gPkAOg9YW7TJ78lLAq4uq2a640uUBo72qqcDS8lR2A+q+FN84hnetqLggNGfVt3vpywmehX/smRnUxKjZk6Y0tHZbBbnHW6PwicNTrDKn21Za8H3ySve6vEOHLFr4Hc1ghKiSrP6bIBSE3z5e56ChSiwCViDdp1HRWglA07JOg3EQRUQprZU+vjyIkJAByCNTHAzG4YpGLlC/osE1FCXLct4PYb2kOzMKqSsIPmd1xT4QifmZ7FvebgNW44vor30iEOUhzeMjZefQqdZNuAjm2L8Ueu7E9PLAXYkGCBBXdDcSsTLQTjZOJdG22X5hoQOIZF+3utVS3D8GlaWaF7nqNu71R2Ot/7gLhIfIP6qaj4Tg+sJSdZ9X8/vk4MSZp1JZZlJsmaiOd0KXJ8Xyi37XBQxW/yVCqpzfdl3yxDrsisO+XgT+fGWe1LojMRTcC9XJJR4rHcIXn6/JUpfW238FFR9JH2l//XSQ2aMoouzJxdHpHFD4yS8iFTeOEgf7GKw9HMMdK1Unf4/OsBsa8p9nZyTyhHO4s8/II+QSusqUUOAhpkbFvldCXSwxwTsy9Kk9Hpmwielil/xfgboW72BEkqxyYeP6XTXw
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(376002)(136003)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(41300700001)(4326008)(316002)(54906003)(76116006)(66476007)(66946007)(66556008)(110136005)(64756008)(66446008)(9686003)(8936002)(8676002)(2906002)(52536014)(478600001)(26005)(71200400001)(38070700005)(33656002)(6506007)(7696005)(38100700002)(5660300002)(83380400001)(55016003)(86362001)(66899024)(107886003)(122000001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YTZvZzYwdElkdktjVTdxUzBKQ1MvZC9aeDRJNTF6WUNxM2RLN253YldmaFVG?=
 =?utf-8?B?UzlqWVF3NmhjNzgwU1MzZVVoc25KUGNVZTdFaFhYbHhXZmJ0ekNyYzdLLzlY?=
 =?utf-8?B?a2Z5S3NsMUs4SVJOUGFUNzdrcXB4ekdZQ2t3Ukp5K2E2UGNvUFhrMzNFVTUv?=
 =?utf-8?B?VzVtcU5jTXJha2NYR1NHem5FT2lPajJCYU5JVkt0UlRYMm5GdEdVRTZBaktH?=
 =?utf-8?B?R3pEMGxyNmtQRnNsVUxORFhCeVpyTjZxaWJFemlIbis0Y0x2MmpzNGpvL1ln?=
 =?utf-8?B?YnVkb3dSRHd2NTljWVF2ZGs0SWFJVUFRUFltQXgzNE9CSktQTVlXYXZZcEpr?=
 =?utf-8?B?eGRkbThNbjlFSXdkUGk1MWVwbm9nZDBoZm9FbVE2UmVyeS8rQWYybHV1dnky?=
 =?utf-8?B?ZUphRjE3MzVGNGNoYmZNc05QbWpWTlcweGhWMm5VUHgyYUNlNDJDS1JYQTc4?=
 =?utf-8?B?MmZwTW5zcnV0QUNCbHRXZWxDaTE2aHgxVGI2TmI5VEY2ako3NC9vR3M2NlZC?=
 =?utf-8?B?cFlveVVSUGNNOGhDaHNXWlQ0L3JqM202TzNQdFNxMTR5N2k3ZWlPTmJkL3pO?=
 =?utf-8?B?bjFNaWRmT00wS0Uva0prTU8wN3lUMlg1bmZCUDJERjc0V1NOWlBvSzNDbGVw?=
 =?utf-8?B?UWVLd0RSYjdVazN3dmwrNmRibmRGQVJ1bXQ5a0VzTFJwa2lrcnRJUTFvSXZl?=
 =?utf-8?B?NDNMOXVPYW5jYXBjOXJmcGFFYVVxSDRpLy9RYm9Vdkh2NzN3QmNFN0ZCdEtk?=
 =?utf-8?B?NThUcG16ZjRQVTVQSkloZWJHWW02TU9aeVltR00wc01vUTdEdXo4NlAzUVR3?=
 =?utf-8?B?QzJ5U3Eya05vSkR6Ynovd0psa0UycXNBWGlLVkhVWUlqSTk2cFJlOHR5NW1u?=
 =?utf-8?B?ODROUXdQYTFPRzdCMERHOERGeWxaazlYMXhXdGp5aFJBb3M0djJoTGNYekVO?=
 =?utf-8?B?YTNPOG1YdFpMR3hoZ0hmb1U5MklSdklwSFVmMG9Zc1JvSjBvMHFUdEpqc2E1?=
 =?utf-8?B?L1BpVEd2V1dDc3VpbGNsenVFOUVVUXF6YTZSRmlYaDlxNlYveWFKejRWV0Nz?=
 =?utf-8?B?SjA3QTkrOHM2Z0t0ekp3RmlnRmFKMDUyQ0hWRkZnT2wrSE83TFZoVlU5cnhE?=
 =?utf-8?B?REFFWFVuRGNJRkFXeTRTUS96S0tSRytpbmNOU3laZTRrY2s5QjIzQjdCVGYz?=
 =?utf-8?B?Zm5uZHREblJObXJhNWttOG1Rd0hvSVNVNjBULzFsblB4Q28zNHRrL01EYVdn?=
 =?utf-8?B?WDRiTWdhYzhldnh1Y1pybC9zR09rUWdtU1BTVml4YS8xYzhGWmFsQjhuZE5X?=
 =?utf-8?B?K25TTmhOY3RqWHBwSG1JUnYveEptRm15a0d1eFZsdHJvdXEvZ3h0aTYzWnF4?=
 =?utf-8?B?UzdSWWFvOFpCMUs1TkZDS3ZHWTRyZGtuOUJrNnlZQTlkRWtuZFl2aFVEa3gv?=
 =?utf-8?B?TVZZa0VONmhVeTJqNnNBQnF6aks4V3RFQnphc0lOZjVjTEEyQlhaMjlFTUYx?=
 =?utf-8?B?NU5Qc1ZaNHNXcTJBdW5RbjdLQjNKZnVRcTNwbmsrUnBQYUVTQWhGM3lad0sx?=
 =?utf-8?B?TFdjZGVMK2h5ZUZCMTA4TUxjWjhXdUpjb0RITHRTU29zZ2FNdCt2MGRTbmhK?=
 =?utf-8?B?VzVZTnhmcEFIckNNYUE1TWxQYU9JQitQTVBWK2VkWE5aMkQySzJHRjBicnl4?=
 =?utf-8?B?UWlSU1BoVnhHakxqV0tmV0tvRml1QUxxRlo2SWlZQ3NibFNvaEQwR3UyMkxa?=
 =?utf-8?B?Y1NEcUlKMSt4VHd5Y3B5N3pxRFg5bUVjb3FOWXBMVk05enRvNFNadHhwcFM2?=
 =?utf-8?B?bFZJQ3NHV3dUbW1ncnE2bWMwUnhWTGJYRDZnZGY3RDlDY3NSRFlkemlqaG8z?=
 =?utf-8?B?TWxKL2RhMWU5djdvU0FvRnBzajE2S3dZeWlMZjlkSGZsbW1YSlZOQktXc3oz?=
 =?utf-8?B?bXh5OXNYZFdwWUJQa1psME43b3VNdTFrMlRLeFROY0NHclVIWmdkbmZqcGd3?=
 =?utf-8?B?RVQ4cUh3Vkt1c1hOREE0VXlYaDRaU2lJUExoajRycDRRQStYK1dNTWZoOEd1?=
 =?utf-8?B?aWtWTDIxeHFsTnFIL0JlM1o1WWNkbnJSNFlidWI5ajNPZktPRnhjaS90ZUF5?=
 =?utf-8?Q?Ck1ayYhTUFm19ayUwZt8qjEQV?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58efbd9-8ff5-4c63-5cd5-08dbbf422b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Sep 2023 10:11:51.6346 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AiE7U6FzCmOREQiNGFwHIIFRmdgUqlqv3joZTI7Z3OFWBE62d/57X4OgR5rEBc1cZYVM8iSU7eMQAC/AGz/Jir8Crj21SNU2I1cuO45jcFw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7518
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNywgMjAyMyA1
OjExIFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MiAwNy8xMl0gdmZpby9wbGF0Zm9ybTogVXNl
IHZmaW9fW2F0dGFjaC9kZXRhY2hdX2RldmljZQ0KPg0KPkhpLA0KPg0KPk9uIDkvMjYvMjMgMTM6
MzIsIFpoZW56aG9uZyBEdWFuIHdyb3RlOg0KPj4gRnJvbTogRXJpYyBBdWdlciA8ZXJpYy5hdWdl
ckByZWRoYXQuY29tPg0KPj4NCj4+IExldCB0aGUgdmZpby1wbGF0Zm9ybSBkZXZpY2UgdXNlIHZm
aW9fYXR0YWNoX2RldmljZSgpIGFuZA0KPj4gdmZpb19kZXRhY2hfZGV2aWNlKCksIGhlbmNlIGhp
ZGluZyB0aGUgZGV0YWlscyBvZiB0aGUgdXNlZA0KPj4gSU9NTVUgYmFja2VuZC4NCj4+DQo+PiBE
cm9wIHRoZSB0cmFjZSBldmVudCBmb3IgdmZpby1wbGF0Zm9ybSBhcyB3ZSBoYXZlIHNpbWlsYXIN
Cj4+IG9uZSBpbiB2ZmlvX2F0dGFjaF9kZXZpY2UuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogRXJp
YyBBdWdlciA8ZXJpYy5hdWdlckByZWRoYXQuY29tPg0KPj4gU2lnbmVkLW9mZi1ieTogWWkgTGl1
IDx5aS5sLmxpdUBpbnRlbC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgaHcvdmZpby9wbGF0Zm9ybS5j
ICAgfCA0MyArKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+PiAg
aHcvdmZpby90cmFjZS1ldmVudHMgfCAgMSAtDQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCAzIGluc2Vy
dGlvbnMoKyksIDQxIGRlbGV0aW9ucygtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3Bs
YXRmb3JtLmMgYi9ody92ZmlvL3BsYXRmb3JtLmMNCj4+IGluZGV4IDVhZjczZjkyODcuLjhlM2Q0
YWM0NTggMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL3BsYXRmb3JtLmMNCj4+ICsrKyBiL2h3L3Zm
aW8vcGxhdGZvcm0uYw0KPj4gQEAgLTUyOSwxMiArNTI5LDcgQEAgc3RhdGljIFZGSU9EZXZpY2VP
cHMgdmZpb19wbGF0Zm9ybV9vcHMgPSB7DQo+PiAgICovDQo+PiAgc3RhdGljIGludCB2ZmlvX2Jh
c2VfZGV2aWNlX2luaXQoVkZJT0RldmljZSAqdmJhc2VkZXYsIEVycm9yICoqZXJycCkNCj4+ICB7
DQo+PiAtICAgIFZGSU9Hcm91cCAqZ3JvdXA7DQo+PiAtICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2
X2l0ZXI7DQo+PiAtICAgIGNoYXIgKnRtcCwgZ3JvdXBfcGF0aFtQQVRIX01BWF0sICpncm91cF9u
YW1lOw0KPj4gLSAgICBzc2l6ZV90IGxlbjsNCj4+ICAgICAgc3RydWN0IHN0YXQgc3Q7DQo+PiAt
ICAgIGludCBncm91cGlkOw0KPj4gICAgICBpbnQgcmV0Ow0KPj4NCj4+ICAgICAgLyogQHN5c2Zz
ZGV2IHRha2VzIHByZWNlZGVuY2Ugb3ZlciBAaG9zdCAqLw0KPj4gQEAgLTU1Nyw0NyArNTUyLDE1
IEBAIHN0YXRpYyBpbnQgdmZpb19iYXNlX2RldmljZV9pbml0KFZGSU9EZXZpY2UNCj4qdmJhc2Vk
ZXYsIEVycm9yICoqZXJycCkNCj4+ICAgICAgICAgIHJldHVybiAtZXJybm87DQo+PiAgICAgIH0N
Cj4+DQo+PiAtICAgIHRtcCA9IGdfc3RyZHVwX3ByaW50ZigiJXMvaW9tbXVfZ3JvdXAiLCB2YmFz
ZWRldi0+c3lzZnNkZXYpOw0KPj4gLSAgICBsZW4gPSByZWFkbGluayh0bXAsIGdyb3VwX3BhdGgs
IHNpemVvZihncm91cF9wYXRoKSk7DQo+PiAtICAgIGdfZnJlZSh0bXApOw0KPj4gLQ0KPj4gLSAg
ICBpZiAobGVuIDwgMCB8fCBsZW4gPj0gc2l6ZW9mKGdyb3VwX3BhdGgpKSB7DQo+PiAtICAgICAg
ICByZXQgPSBsZW4gPCAwID8gLWVycm5vIDogLUVOQU1FVE9PTE9ORzsNCj4+IC0gICAgICAgIGVy
cm9yX3NldGdfZXJybm8oZXJycCwgLXJldCwgIm5vIGlvbW11X2dyb3VwIGZvdW5kIik7DQo+PiAt
ICAgICAgICByZXR1cm4gcmV0Ow0KPj4gLSAgICB9DQo+PiAtDQo+PiAtICAgIGdyb3VwX3BhdGhb
bGVuXSA9IDA7DQo+PiAtDQo+PiAtICAgIGdyb3VwX25hbWUgPSBiYXNlbmFtZShncm91cF9wYXRo
KTsNCj4+IC0gICAgaWYgKHNzY2FuZihncm91cF9uYW1lLCAiJWQiLCAmZ3JvdXBpZCkgIT0gMSkg
ew0KPj4gLSAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCBlcnJubywgImZhaWxlZCB0byBy
ZWFkICVzIiwgZ3JvdXBfcGF0aCk7DQo+PiAtICAgICAgICByZXR1cm4gLWVycm5vOw0KPj4gLSAg
ICB9DQo+PiAtDQo+SGVyZSBhbHNvIG9uIGVycm9yIHBhdGggd2UgYXJlIGxlYWtpbmcgYm90aCB2
YmFzZWRldi0+bmFtZSBhbmQNCj52YmFzZWRldi0+c3lzZnNkZXYuIFRoaXMgaXMgaW5kZXBlbmRl
bnQgb24gdGhpcyBwYXRjaA0KPmNhcmUgbXVzdCBiZSB0YWtlbiBiZWNhdXNlIHZkZXYtPnZiYXNl
ZGV2Lm5hbWUgaXMgdXNlZCBpbiB0aGUgY2FsbGVyDQo+KHZmaW9fcGxhdGZvcm1fcmVhbGl6ZSkg
dG8gb3V0cHV0IHRoZSBlcnJvciBtc2cNCj5kZWFsbG9jYXRpb24gY291bGQgaGFwcGVuIHRoZXJl
Pw0KDQpCb3RoIGFyZSBkZXZpY2UgcHJvcGVydHksIEkgdGhpbmsgdGhleSBhcmUgZnJlZWQgYnkg
UU9NIHN1YnN5c3RlbS4NClBsZWFzZSBmaXggbWUgaWYgSSdtIHdyb25nLg0KDQpzdGF0aWMgUHJv
cGVydHkgdmZpb19wbGF0Zm9ybV9kZXZfcHJvcGVydGllc1tdID0gew0KICAgIERFRklORV9QUk9Q
X1NUUklORygiaG9zdCIsIFZGSU9QbGF0Zm9ybURldmljZSwgdmJhc2VkZXYubmFtZSksDQogICAg
REVGSU5FX1BST1BfU1RSSU5HKCJzeXNmc2RldiIsIFZGSU9QbGF0Zm9ybURldmljZSwgdmJhc2Vk
ZXYuc3lzZnNkZXYpLA0KDQpUaGFua3MNClpoZW56aG9uZw0K

