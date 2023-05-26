Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCC9171228A
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 10:45:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2T40-00030I-94; Fri, 26 May 2023 04:44:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1q2T3x-0002zt-RZ
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:44:42 -0400
Received: from mga14.intel.com ([192.55.52.115])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yi.l.liu@intel.com>)
 id 1q2T3v-0003qb-Jf
 for qemu-devel@nongnu.org; Fri, 26 May 2023 04:44:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685090679; x=1716626679;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=vlI5apEInwE5NhTTYumwUzpCEsOWKyFgBAXrZ0lf/s8=;
 b=iaCJCOlPRC4KTnK4oFUMpH/tauXh0lE0DKUHnv0hgWV8cPOam3SHqHRt
 gsVJxKIxgBrWmbH/dkeJvcCJDz3L1NMqkwMx4tNxN4uoU+3acGqnFSnRV
 NZL+M/33KiGyeMUPnzrmM1sr/uvSdaGAPpj8OYkgH8vWIz+8PP4GVDawr
 Rl9wDx9j1CH81MFRx7g2YN/qz5To2dWAv7W8E+I4ODSqzw9g4zvs6pN1v
 u9m+bguo4AmcdVZFnuHzr+9yuabH4Kx1Ms4aN98poP7Kye3/UyVcWC5Kl
 kmZfF4Ffp0UZgtIpmekRxG1huFxA0UtKtG+xAZJAcTVFhniaOUb6wdzvb Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="354170301"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="354170301"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2023 01:44:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10721"; a="879481271"
X-IronPort-AV: E=Sophos;i="6.00,193,1681196400"; d="scan'208";a="879481271"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga005.jf.intel.com with ESMTP; 26 May 2023 01:44:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 26 May 2023 01:44:30 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 26 May 2023 01:44:30 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 26 May 2023 01:44:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bQe6Fh2ZCfSwSqXBvEOYtCybwwSzHmTWTGYPp4NZspwku8A+fds+UfvpMqyjyZnFPZWfJStf8L3xO61JQ1PyBu8ggpAoX0sv9lduX3tA6mghPblaUoumYA1j5mGWRhmtI77Q+n0fib13g0fq+gnLLSSMRYcT243rqJkEt5/k9AkzdKTBSWebfEIJjqPxi9oNN4kXs+l7MWkOoWZSRTCzL0rai0z/X53QezI8BatHzy262g0YWi/QHYuC7vNR4yiQtGYz7PMkYLNYEwC2nukQIEe4OQxmkTnGS/qx63OBJv1BGZSk+YzD7rnyk7qqry0tHql19nVU0JX3UPpZ7gAJeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlI5apEInwE5NhTTYumwUzpCEsOWKyFgBAXrZ0lf/s8=;
 b=kZs/Vb9cqOixTkFLrc40n74ZU5MaSxKlSiaEuPIF02YVUsDX7/+7LTgrsv5qMRNfE6KGjo1SYIAvmQGuUAUqZBOCA1Qq0QEYXz5U8bL0w+6SuvIt3vTmsPBEvxyMdMORZkx7h+3GCbd6OXt6Y8/QtvDbFYD1dn5g0xUNxbC8An7BsmIZ514zeJ3b0NUz1bMuZuop3fPuYaXerudEkarzsHYWOgg9TYanoIz2I5OxCYUy0osk/ImlU94QRojk/Ox4TuqPobLS/3XKPRJ6jtQcn6sqsPfmTVeGzsqJUtgorHgUx7HqrLgtXQSd1oDGXKOt98Vsijlt5X2N7FUOhEFSLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB7529.namprd11.prod.outlook.com (2603:10b6:8:141::20)
 by LV8PR11MB8511.namprd11.prod.outlook.com (2603:10b6:408:1ed::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Fri, 26 May
 2023 08:44:29 +0000
Received: from DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5]) by DS0PR11MB7529.namprd11.prod.outlook.com
 ([fe80::5b44:8f52:dbeb:18e5%3]) with mapi id 15.20.6411.028; Fri, 26 May 2023
 08:44:29 +0000
From: "Liu, Yi L" <yi.l.liu@intel.com>
To: Jason Wang <jasowang@redhat.com>, "Duan, Zhenzhong"
 <zhenzhong.duan@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Peter Xu <peterx@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "richard.henderson@linaro.org"
 <richard.henderson@linaro.org>, "eduardo@habkost.net" <eduardo@habkost.net>,
 "Peng, Chao P" <chao.p.peng@intel.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, Neo Jia <cjia@nvidia.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Thread-Topic: [PATCH] intel_iommu: Optimize out some unnecessary UNMAP calls
Thread-Index: AQHZjU9UI3KKLKxqMUqRp6MVxpCLPa9pp1qAgAE2YwCAAChSgIABFCuAgAABmwCAACSwUA==
Date: Fri, 26 May 2023 08:44:29 +0000
Message-ID: <DS0PR11MB75294EE1B95AE1953825B845C3479@DS0PR11MB7529.namprd11.prod.outlook.com>
References: <20230523080702.179363-1-zhenzhong.duan@intel.com>
 <ZG5CPws85lIvpT07@x1n>
 <SJ0PR11MB67447A3D47F6226F58DB813492469@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ZG9ocSY+vJAd1Hjs@x1n>
 <SJ0PR11MB67449B49619CCF94ECA7447392479@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <CACGkMEueaUvopf0zv4dxe=D5PLHkQkeV8-QshH8gmObVY6J9cg@mail.gmail.com>
In-Reply-To: <CACGkMEueaUvopf0zv4dxe=D5PLHkQkeV8-QshH8gmObVY6J9cg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB7529:EE_|LV8PR11MB8511:EE_
x-ms-office365-filtering-correlation-id: be5eb8ea-eace-45e8-4496-08db5dc56b31
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iF/1GABVC87D5S9c3aisDRyq2Y35U1NWFUUbMuVVun9A5nABuklbXF451swBBu03ct7/e16C7NuzToruIIevaeJW1m2PKZSjNRqWu1zlzqvCZl6AN6k87JZKiTncZavIZm30vMpLONUV1BfFCmF+welmi+wA8TPKiTTnqE2Wz0uWf5O1+kgEZhvG4F24P6iXfXEhb9pa95AgJn8PVorm6WrVE4ukEZ16xZk4KLM18p0hLKVn8j00R2cQ0ILylvs9QOQ8hpB+xaGHvOCCemvOHPjF1IEAqNm1VqlrHGo0+pAaGM/e2HOf3fHzHZlWvFgHjnDNPkBeukXmNsSSSmr53XfT8Cc0ipteP+waUDbEw+H29o3XZ7p0CDYRajUCAkHl9aP/rFl2gsXsrb8Niv2BX+Asg4RQ19ABh1aQkV5cRdDyNeBX8FokQLu25sGH75V3ajIzPKztbl3qWczrzPFZsELxxvN3egXB06mfrt2iVp2O3JUJYgQem+cc3M7duo5GRRalOHWV4+H6OiRWUtPJWmoypz/6S9fmdoAjxGg3LKamoEjHYZOFFcweR2x5kZ7M/hhPEG+MH9RexkIQVBHemL/cDl/2p0jXxV5b0l81nDysPa0gOF/jubsDdjZCzvTE+df0a/MDyhz1cmX7NgsWaA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7529.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(396003)(376002)(346002)(136003)(451199021)(6506007)(478600001)(7696005)(71200400001)(54906003)(110136005)(53546011)(26005)(9686003)(66476007)(66946007)(186003)(64756008)(76116006)(66556008)(66446008)(4326008)(33656002)(5660300002)(52536014)(82960400001)(41300700001)(55016003)(38070700005)(86362001)(83380400001)(8676002)(2906002)(38100700002)(8936002)(7416002)(316002)(122000001)(21314003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WFFiZHVqQXNoRmtVTCt3QVkyRGFqbGY4dEhFYjJpdGRlSHJFY0tMQTdwS1M3?=
 =?utf-8?B?RWw2Q2dhbW5pVkU5Zkp2cUZ1ckxnR2trQy8yTDB6Ry9rbzhuYzlmNDF3bE54?=
 =?utf-8?B?bDJSdXpFcWNBUk8rZGcvWENGZTdBeHhHVFZvREVhN0JIV2hVUTBsaU5pZm11?=
 =?utf-8?B?RFNqa1N5cFdjOVp4RWNWTVg3UkJUQ2lhdjVmN3RYY0NSVHgrVjBtZ2lYbU9s?=
 =?utf-8?B?RnVkOXF6djJrZlNwNm05Z3RENXBoUW5YSmpPVGJKNkRjelZ0enZnQjMvTjdv?=
 =?utf-8?B?U2NuUTk3WjE2VVVQMll3Y25XSVJ6dlBMR3lpYndvQ1BxeTJGbWQyQVMrbWFp?=
 =?utf-8?B?ZXdmOUVPN1JXUXdzZDNNTDVWdVR6MjlSYWoxWlJ0U1cyUUJvQi93Mm1vNzlm?=
 =?utf-8?B?c0RtRUFGSTN6aE5DbFNzQ0xZNFhWMDBSaHBHVXNXT2xSTWd5S3NBeGZ1NGsz?=
 =?utf-8?B?NDZYell2bEVYbVIwVktTMlc0SHA5Wjc5ajQveFVVZU9acm5RNHV5aUpqbU9O?=
 =?utf-8?B?c1U0NHBmMmFOb1JvRVA2TnlmTThGNDBkNGw1ak5lM1NkWEVaN2daRUxYeEQ0?=
 =?utf-8?B?T0hid3FNaFkxeUFJdElWcEVSNHBJYWdsMW93aE81ODB0YmxteFJJVFRUQURv?=
 =?utf-8?B?MHhPWUFLTElkTm8wZVB0Y0pNWU9HVjU0NkgxbmxCL3ZyamxsWnpFeEx2dy8r?=
 =?utf-8?B?QVdaaW41NTkrVE5QV0JzKzVSTlNxQ0pBK2szZWFrbnBZOTFlc0swMlU0aW5j?=
 =?utf-8?B?Z0FZSkVjc3ErUFZFKzU4bjFDRjdUOGQ0YXR3WDFnVWttekFFNDJNU2t1OXBz?=
 =?utf-8?B?NS9aVXpCVUF3bS9ZeTl4VkNDTU1WNFJHNzRubzJOTzk1Y29jSlM5bnJKbWVU?=
 =?utf-8?B?Yjlaem1NUnhDaU5wR2wybEN2cG1BYVBzOTU2MjFLWWZrUW9qM1lFNGw1d0o3?=
 =?utf-8?B?VGpOWjRIbWk5NGIzd2xYaEdTZVBPdFN1c2o1d1pCWHlqbUdSSTNrY2FSTTdh?=
 =?utf-8?B?SVB2QkpYbzQ2alV1WmZSeFUwQ3h5eXFCaFpIUGNQUmN3eUt4SGQ3cmxEbjFM?=
 =?utf-8?B?T3V2MitSRXJZSGpaelIyQ0JYOVRrYmVQdGovV3JZVHEwSXJ2SkNSemwxWWVR?=
 =?utf-8?B?Z1o4aWZsc0w2a08vMktaRG50R1N5TnZZYW1aZkgyNnM5NDdySmRaMXZ0bnAx?=
 =?utf-8?B?VFdYR01SM3d2Y3cxWWdYUEVnbTVaR1ZpUjJ3OUhjL05zanpGdHppVlUxdHg1?=
 =?utf-8?B?QmVRSTFxSzMwbkdFWE5vakE3a2dKWTlpOHNSWnp0S21wbU5HR3dtKzNFQ3Vx?=
 =?utf-8?B?SFhSR09IR0RnSHBTa3lNRXZXN2hFeDJaV09qc21JaExZc1RXeFVIRmQ2Y2Zj?=
 =?utf-8?B?c3oxQmZOdlM1ZFhHQWtqMi9vdzlzS3dtWFJzeFMrWEZmRExhTVNDMVZ6VUNy?=
 =?utf-8?B?bGJJNTJZc25CTFdKSExGa0FHQ0NOU0RtakNkUzR4ekdqRG5rVW9PNENyaEJ0?=
 =?utf-8?B?WXFqRmQvU1owTitBdWcxMDFqb2RpclQyNEozVUVIcFlKd3NiMmJVTUl5ZEVS?=
 =?utf-8?B?d0NoWVVvUk5qWDlhaEtUcG5KSkkyNTVxOVFySGp4VTdOM1czblJZcUdRZy9x?=
 =?utf-8?B?SWZHYzBnajN0aDFxbVVESGZIVTVoQ0VpbXFrV2hRLythYUlna2VlVUw2UmFo?=
 =?utf-8?B?UTRTQm1oaWlRc29BYzNIbWtvMVd0TCtpdDJrVUpZelFmZGwzME9QWWNjQmVE?=
 =?utf-8?B?VTJLUFRvRDZ6ektLWGh1bzBWSnRESFFTNjdTMm5yUVgwdWl4M2lxZ3JsdEdU?=
 =?utf-8?B?M2xYOUNWWDhCWmV4S3RSTmEwNUc5L0VIdG5CWXlSRjRWOHZhSW5kaXNBd0xO?=
 =?utf-8?B?UnkyZ3UrSkI5MXFUalRXN1UraXkyVE40b0RNNHpyTHIwRDlaUUFuUVlJYm91?=
 =?utf-8?B?cFd6QUNhWTZxbEY3bmhkS3VJbEM2RlA4YmkyQndxdVF0bEMzNjRtdW14MkNk?=
 =?utf-8?B?U3pTWXY4TmtkdmlUMUpaK3JVSytNQ1hlNW92YThRM0diU0plamZIR0RtbmZm?=
 =?utf-8?B?cllXd1dZbWRkTTdKSHAyRWRpSE9Ma01aTGdEQTFyeEFHcnRhVVFXZE9EVFRL?=
 =?utf-8?Q?rQeBo3LtcB6uL3xI6jiyxFHg/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7529.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be5eb8ea-eace-45e8-4496-08db5dc56b31
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 08:44:29.1237 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1I+FvwyMIngR3HlNUQC2cbMQ4sOGZmhqIziMT4oEaA6AZYvnrUAeHDR0VI1rqmwvN0SNr3YilHMjPdum5a6MVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8511
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.115; envelope-from=yi.l.liu@intel.com;
 helo=mga14.intel.com
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

PiBGcm9tOiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPg0KPiBTZW50OiBGcmlkYXks
IE1heSAyNiwgMjAyMyAyOjI4IFBNDQo+IA0KPiBPbiBGcmksIE1heSAyNiwgMjAyMyBhdCAyOjIy
4oCvUE0gRHVhbiwgWmhlbnpob25nDQo+IDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+DQo+ID4NCj4gPiA+LS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+RnJvbTog
UGV0ZXIgWHUgPHBldGVyeEByZWRoYXQuY29tPg0KPiA+ID5TZW50OiBUaHVyc2RheSwgTWF5IDI1
LCAyMDIzIDk6NTQgUE0NCj4gPiA+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IE9w
dGltaXplIG91dCBzb21lIHVubmVjZXNzYXJ5IFVOTUFQDQo+ID4gPmNhbGxzDQo+ID4gPg0KPiA+
ID5PbiBUaHUsIE1heSAyNSwgMjAyMyBhdCAxMToyOTozNEFNICswMDAwLCBEdWFuLCBaaGVuemhv
bmcgd3JvdGU6DQo+ID4gPj4gSGkgUGV0ZXIsDQo+ID4gPj4NCj4gPiA+PiBTZWUgaW5saW5lLg0K
PiA+ID4+ID4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4+ID5Gcm9tOiBQZXRlciBY
dSA8cGV0ZXJ4QHJlZGhhdC5jb20+DQo+ID4gPj4gPlNlbnQ6IFRodXJzZGF5LCBNYXkgMjUsIDIw
MjMgMTI6NTkgQU0NCj4gPiA+PiA+U3ViamVjdDogUmU6IFtQQVRDSF0gaW50ZWxfaW9tbXU6IE9w
dGltaXplIG91dCBzb21lIHVubmVjZXNzYXJ5IFVOTUFQDQo+ID4gPj4gPmNhbGxzDQo+ID4gPj4g
Pg0KPiA+ID4+ID5IaSwgWmhlbnpob25nLA0KPiA+ID4+ID4NCj4gPiA+PiA+T24gVHVlLCBNYXkg
MjMsIDIwMjMgYXQgMDQ6MDc6MDJQTSArMDgwMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+ID4g
Pj4gPj4gQ29tbWl0IDYzYjg4OTY4ZjEgKCJpbnRlbC1pb21tdTogcmV3b3JrIHRoZSBwYWdlIHdh
bGsgbG9naWMiKSBhZGRzDQo+ID4gPj4gPj4gbG9naWMgdG8gcmVjb3JkIG1hcHBlZCBJT1ZBIHJh
bmdlcyBzbyB3ZSBvbmx5IG5lZWQgdG8gc2VuZCBNQVAgb3INCj4gPiA+PiA+PiBVTk1BUCB3aGVu
IG5lY2Vzc2FyeS4gQnV0IHRoZXJlIGFyZSBzdGlsbCBhIGZldyBjb3JuZXIgY2FzZXMgb2YNCj4g
PiA+PiA+dW5uZWNlc3NhcnkgVU5NQVAuDQo+ID4gPj4gPj4NCj4gPiA+PiA+PiBPbmUgaXMgYWRk
cmVzcyBzcGFjZSBzd2l0Y2guIER1cmluZyBzd2l0Y2hpbmcgdG8gaW9tbXUgYWRkcmVzcw0KPiA+
ID4+ID4+IHNwYWNlLCBhbGwgdGhlIG9yaWdpbmFsIG1hcHBpbmdzIGhhdmUgYmVlbiBkcm9wcGVk
IGJ5IFZGSU8gbWVtb3J5DQo+ID4gPj4gPj4gbGlzdGVuZXIsIHdlIGRvbid0IG5lZWQgdG8gdW5t
YXAgYWdhaW4gaW4gcmVwbGF5LiBUaGUgb3RoZXIgaXMNCj4gPiA+PiA+PiBpbnZhbGlkYXRpb24s
IHdlIG9ubHkgbmVlZCB0byB1bm1hcCB3aGVuIHRoZXJlIGFyZSByZWNvcmRlZCBtYXBwZWQNCj4g
PiA+PiA+PiBJT1ZBIHJhbmdlcywgcHJlc3VtaW5nIG1vc3Qgb2YgT1NlcyBhbGxvY2F0aW5nIElP
VkEgcmFuZ2UNCj4gPiA+PiA+PiBjb250aW51b3VzbHksIGV4LiBvbiB4ODYsIGxpbnV4IHNldHMg
dXAgbWFwcGluZyBmcm9tIDB4ZmZmZmZmZmYNCj4gPiA+ZG93bndhcmRzLg0KPiA+ID4+ID4+DQo+
ID4gPj4gPj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGlu
dGVsLmNvbT4NCj4gPiA+PiA+PiAtLS0NCj4gPiA+PiA+PiBUZXN0ZWQgb24geDg2IHdpdGggYSBu
ZXQgY2FyZCBwYXNzZWQgb3IgaG90cGx1Z2VkIHRvIGt2bSBndWVzdCwNCj4gPiA+PiA+PiBwaW5n
L3NzaCBwYXNzLg0KPiA+ID4+ID4NCj4gPiA+PiA+U2luY2UgdGhpcyBpcyBhIHBlcmZvcm1hbmNl
IHJlbGF0ZWQgcGF0Y2gsIGRvIHlvdSBoYXZlIGFueSBudW1iZXIgdG8NCj4gPiA+PiA+c2hvdyB0
aGUgZWZmZWN0Pw0KPiA+ID4+DQo+ID4gPj4gSSBzdHJhY2VkIHRoZSB0aW1lIG9mIFVOTUFQIGlv
Y3RsLCBpdHMgdGltZSBpcyAwLjAwMDAxNHVzIGFuZCB3ZSBoYXZlDQo+ID4gPj4gMjggaW9jdGwo
KSBkdWUgdG8gdGhlIHR3byBub3RpZmllcnMgaW4geDg2IGFyZSBzcGxpdCBpbnRvIHBvd2VyIG9m
IDIgcGllY2VzLg0KPiA+ID4+DQo+ID4gPj4gaW9jdGwoNDgsIFZGSU9fREVWSUNFX1FVRVJZX0dG
WF9QTEFORSBvciBWRklPX0lPTU1VX1VOTUFQX0RNQSwNCj4gPiA+PiAweDdmZmZmZDVjNDJmMCkg
PSAwIDwwLjAwMDAxND4NCj4gPiA+DQo+ID4gPkNvdWxkIHlvdSBhZGQgc29tZSBpbmZvcm1hdGlv
biBsaWtlIHRoaXMgaW50byB0aGUgY29tbWl0IG1lc3NhZ2Ugd2hlbg0KPiA+ID5yZXBvc3Q/ICBF
LmcuIFVOTUFQIHdhcyB4eHggc2VjIGJlZm9yZSwgYW5kIHRoaXMgcGF0Y2ggcmVkdWNlcyBpdCB0
byB5eXkuDQo+ID4gU3VyZSwgd2lsbCBkby4NCj4gPg0KPiA+ID4NCj4gPiA+Pg0KPiA+ID4+ID4N
Cj4gPiA+PiA+Pg0KPiA+ID4+ID4+ICBody9pMzg2L2ludGVsX2lvbW11LmMgfCAzMSArKysrKysr
KysrKysrKy0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gPj4gPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBp
bnNlcnRpb25zKCspLCAxNyBkZWxldGlvbnMoLSkNCj4gPiA+PiA+Pg0KPiA+ID4+ID4+IGRpZmYg
LS1naXQgYS9ody9pMzg2L2ludGVsX2lvbW11LmMgYi9ody9pMzg2L2ludGVsX2lvbW11LmMgaW5k
ZXgNCj4gPiA+PiA+PiA5NGQ1MmY0MjA1ZDIuLjZhZmQ2NDI4YWFhYSAxMDA2NDQNCj4gPiA+PiA+
PiAtLS0gYS9ody9pMzg2L2ludGVsX2lvbW11LmMNCj4gPiA+PiA+PiArKysgYi9ody9pMzg2L2lu
dGVsX2lvbW11LmMNCj4gPiA+PiA+PiBAQCAtMzc0Myw2ICszNzQzLDcgQEAgc3RhdGljIHZvaWQN
Cj4gPiA+PiA+dnRkX2FkZHJlc3Nfc3BhY2VfdW5tYXAoVlREQWRkcmVzc1NwYWNlICphcywgSU9N
TVVOb3RpZmllciAqbikNCj4gPiA+PiA+PiAgICAgIGh3YWRkciBzdGFydCA9IG4tPnN0YXJ0Ow0K
PiA+ID4+ID4+ICAgICAgaHdhZGRyIGVuZCA9IG4tPmVuZDsNCj4gPiA+PiA+PiAgICAgIEludGVs
SU9NTVVTdGF0ZSAqcyA9IGFzLT5pb21tdV9zdGF0ZTsNCj4gPiA+PiA+PiArICAgIElPTU1VVExC
RXZlbnQgZXZlbnQ7DQo+ID4gPj4gPj4gICAgICBETUFNYXAgbWFwOw0KPiA+ID4+ID4+DQo+ID4g
Pj4gPj4gICAgICAvKg0KPiA+ID4+ID4+IEBAIC0zNzYyLDIyICszNzYzLDI1IEBAIHN0YXRpYyB2
b2lkDQo+ID4gPj4gPnZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKFZUREFkZHJlc3NTcGFjZSAqYXMs
IElPTU1VTm90aWZpZXIgKm4pDQo+ID4gPj4gPj4gICAgICBhc3NlcnQoc3RhcnQgPD0gZW5kKTsN
Cj4gPiA+PiA+PiAgICAgIHNpemUgPSByZW1haW4gPSBlbmQgLSBzdGFydCArIDE7DQo+ID4gPj4g
Pj4NCj4gPiA+PiA+PiArICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9VTk1BUDsNCj4g
PiA+PiA+PiArICAgIGV2ZW50LmVudHJ5LnRhcmdldF9hcyA9ICZhZGRyZXNzX3NwYWNlX21lbW9y
eTsNCj4gPiA+PiA+PiArICAgIGV2ZW50LmVudHJ5LnBlcm0gPSBJT01NVV9OT05FOw0KPiA+ID4+
ID4+ICsgICAgLyogVGhpcyBmaWVsZCBpcyBtZWFuaW5nbGVzcyBmb3IgdW5tYXAgKi8NCj4gPiA+
PiA+PiArICAgIGV2ZW50LmVudHJ5LnRyYW5zbGF0ZWRfYWRkciA9IDA7DQo+ID4gPj4gPj4gKw0K
PiA+ID4+ID4+ICAgICAgd2hpbGUgKHJlbWFpbiA+PSBWVERfUEFHRV9TSVpFKSB7DQo+ID4gPj4g
Pj4gLSAgICAgICAgSU9NTVVUTEJFdmVudCBldmVudDsNCj4gPiA+PiA+PiAgICAgICAgICB1aW50
NjRfdCBtYXNrID0gZG1hX2FsaWduZWRfcG93Ml9tYXNrKHN0YXJ0LCBlbmQsIHMtPmF3X2JpdHMp
Ow0KPiA+ID4+ID4+ICAgICAgICAgIHVpbnQ2NF90IHNpemUgPSBtYXNrICsgMTsNCj4gPiA+PiA+
Pg0KPiA+ID4+ID4+ICAgICAgICAgIGFzc2VydChzaXplKTsNCj4gPiA+PiA+Pg0KPiA+ID4+ID4+
IC0gICAgICAgIGV2ZW50LnR5cGUgPSBJT01NVV9OT1RJRklFUl9VTk1BUDsNCj4gPiA+PiA+PiAt
ICAgICAgICBldmVudC5lbnRyeS5pb3ZhID0gc3RhcnQ7DQo+ID4gPj4gPj4gLSAgICAgICAgZXZl
bnQuZW50cnkuYWRkcl9tYXNrID0gbWFzazsNCj4gPiA+PiA+PiAtICAgICAgICBldmVudC5lbnRy
eS50YXJnZXRfYXMgPSAmYWRkcmVzc19zcGFjZV9tZW1vcnk7DQo+ID4gPj4gPj4gLSAgICAgICAg
ZXZlbnQuZW50cnkucGVybSA9IElPTU1VX05PTkU7DQo+ID4gPj4gPj4gLSAgICAgICAgLyogVGhp
cyBmaWVsZCBpcyBtZWFuaW5nbGVzcyBmb3IgdW5tYXAgKi8NCj4gPiA+PiA+PiAtICAgICAgICBl
dmVudC5lbnRyeS50cmFuc2xhdGVkX2FkZHIgPSAwOw0KPiA+ID4+ID4+IC0NCj4gPiA+PiA+PiAt
ICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21tdV9vbmUobiwgJmV2ZW50KTsNCj4gPiA+
PiA+PiArICAgICAgICBtYXAuaW92YSA9IHN0YXJ0Ow0KPiA+ID4+ID4+ICsgICAgICAgIG1hcC5z
aXplID0gc2l6ZTsNCj4gPiA+PiA+PiArICAgICAgICBpZiAoaW92YV90cmVlX2ZpbmQoYXMtPmlv
dmFfdHJlZSwgJm1hcCkpIHsNCj4gPiA+PiA+PiArICAgICAgICAgICAgZXZlbnQuZW50cnkuaW92
YSA9IHN0YXJ0Ow0KPiA+ID4+ID4+ICsgICAgICAgICAgICBldmVudC5lbnRyeS5hZGRyX21hc2sg
PSBtYXNrOw0KPiA+ID4+ID4+ICsgICAgICAgICAgICBtZW1vcnlfcmVnaW9uX25vdGlmeV9pb21t
dV9vbmUobiwgJmV2ZW50KTsNCj4gPiA+PiA+PiArICAgICAgICB9DQo+ID4gPj4gPg0KPiA+ID4+
ID5UaGlzIG9uZSBsb29rcyBmaW5lIHRvIG1lLCBidXQgSSdtIG5vdCBzdXJlIGhvdyBtdWNoIGJl
bmVmaXQgd2UnbGwNCj4gPiA+PiA+Z2V0IGhlcmUgZWl0aGVyIGFzIHRoaXMgcGF0aCBzaG91bGQg
YmUgcmFyZSBhZmFpdS4NCj4gPiA+Pg0KPiA+ID4+IFllcywgSSBvbmx5IHNlZSBzdWNoIFVOTUFQ
IGNhbGwgYXQgY29sZCBib290dXAvc2h1dGRvd24sIGhvdCBwbHVnIGFuZA0KPiA+ID51bnBsdWcu
DQo+ID4gPj4NCj4gPiA+PiBJbiBmYWN0LCB0aGUgb3RoZXIgcHVycG9zZSBvZiB0aGlzIHBhdGNo
IGlzIHRvIGVsaW1pbmF0ZSBub2lzeSBlcnJvcg0KPiA+ID4+IGxvZyB3aGVuIHdlIHdvcmsgd2l0
aCBJT01NVUZELiBJdCBsb29rcyB0aGUgZHVwbGljYXRlIFVOTUFQIGNhbGwgd2lsbA0KPiA+ID4+
IGZhaWwgd2l0aCBJT01NVUZEIHdoaWxlIGFsd2F5cyBzdWNjZWVkIHdpdGggbGVnYWN5IGNvbnRh
aW5lci4gVGhpcw0KPiA+ID4+IGJlaGF2aW9yIGRpZmZlcmVuY2UgbGVhZCB0byBiZWxvdyBlcnJv
ciBsb2cgZm9yIElPTU1VRkQ6DQo+IA0KPiBBIGR1bWIgcXVlc3Rpb24sIHNob3VsZCBJT01NVUZE
IHN0aWNrIHRoZSBzYW1lIGJlaGF2aW91ciB3aXRoIGxlZ2FjeSBjb250YWluZXI/DQoNCk1heSBu
ZWVkIHRvIGhlYXIgZnJvbSBKYXNvbkcuIPCfmIogU2hvdWxkIElPTU1VX0lPQVNfVU5NQVAgcmV0
dXJuIGVycm9yIG9yDQpzdWNjZXNzIGlmIHRoZSBpb3ZhIGlzIG5vdCBmb3VuZD8NCg0KUmVnYXJk
cywNCllpIExpdQ0KDQo+IFRoYW5rcw0KPiANCj4gPiA+Pg0KPiA+ID4+IElPTU1VX0lPQVNfVU5N
QVAgZmFpbGVkOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5DQo+ID4gPj4gdmZpb19jb250YWlu
ZXJfZG1hX3VubWFwKDB4NTYyMDEyZDZiNmQwLCAweDAsIDB4ODAwMDAwMDApID0gLTIgKE5vDQo+
ID4gPj4gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkgSU9NTVVfSU9BU19VTk1BUCBmYWlsZWQ6IE5v
IHN1Y2ggZmlsZSBvcg0KPiA+ID4+IGRpcmVjdG9yeSB2ZmlvX2NvbnRhaW5lcl9kbWFfdW5tYXAo
MHg1NjIwMTJkNmI2ZDAsIDB4ODAwMDAwMDAsDQo+ID4gPj4gMHg0MDAwMDAwMCkgPSAtMiAoTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeSkNCj4gPiA+DQo+ID4gPkkgc2VlLiAgUGxlYXNlIGFsc28g
bWVudGlvbiB0aGlzIGluIHRoZSBjb21taXQgbG9nLCB0aGF0J2xsIGhlbHAgcmV2aWV3ZXJzDQo+
ID4gPnVuZGVyc3RhbmQgdGhlIGdvYWwgb2YgdGhlIHBhdGNoLCB0aGFua3MhDQo+ID4gV2lsbCBk
by4NCj4gPg0KPiA+ID4NCj4gPiA+Pg0KPiA+ID4+ID4NCj4gPiA+PiA+Pg0KPiA+ID4+ID4+ICAg
ICAgICAgIHN0YXJ0ICs9IHNpemU7DQo+ID4gPj4gPj4gICAgICAgICAgcmVtYWluIC09IHNpemU7
DQo+ID4gPj4gPj4gQEAgLTM4MjYsMTMgKzM4MzAsNiBAQCBzdGF0aWMgdm9pZA0KPiA+ID4+ID52
dGRfaW9tbXVfcmVwbGF5KElPTU1VTWVtb3J5UmVnaW9uICppb21tdV9tciwgSU9NTVVOb3RpZmll
cg0KPiA+ID4qbikNCj4gPiA+PiA+PiAgICAgIHVpbnQ4X3QgYnVzX24gPSBwY2lfYnVzX251bSh2
dGRfYXMtPmJ1cyk7DQo+ID4gPj4gPj4gICAgICBWVERDb250ZXh0RW50cnkgY2U7DQo+ID4gPj4g
Pj4NCj4gPiA+PiA+PiAtICAgIC8qDQo+ID4gPj4gPj4gLSAgICAgKiBUaGUgcmVwbGF5IGNhbiBi
ZSB0cmlnZ2VyZWQgYnkgZWl0aGVyIGEgaW52YWxpZGF0aW9uIG9yIGEgbmV3bHkNCj4gPiA+PiA+
PiAtICAgICAqIGNyZWF0ZWQgZW50cnkuIE5vIG1hdHRlciB3aGF0LCB3ZSByZWxlYXNlIGV4aXN0
aW5nIG1hcHBpbmdzDQo+ID4gPj4gPj4gLSAgICAgKiAoaXQgbWVhbnMgZmx1c2hpbmcgY2FjaGVz
IGZvciBVTk1BUC1vbmx5IHJlZ2lzdGVycykuDQo+ID4gPj4gPj4gLSAgICAgKi8NCj4gPiA+PiA+
PiAtICAgIHZ0ZF9hZGRyZXNzX3NwYWNlX3VubWFwKHZ0ZF9hcywgbik7DQo+ID4gPj4gPg0KPiA+
ID4+ID5JSVVDIHRoaXMgaXMgbmVlZGVkIHRvIHNhdGlzZnkgY3VycmVudCByZXBsYXkoKSBzZW1h
bnRpY3M6DQo+ID4gPj4gPg0KPiA+ID4+ID4gICAgLyoqDQo+ID4gPj4gPiAgICAgKiBAcmVwbGF5
Og0KPiA+ID4+ID4gICAgICoNCj4gPiA+PiA+ICAgICAqIENhbGxlZCB0byBoYW5kbGUgbWVtb3J5
X3JlZ2lvbl9pb21tdV9yZXBsYXkoKS4NCj4gPiA+PiA+ICAgICAqDQo+ID4gPj4gPiAgICAgKiBU
aGUgZGVmYXVsdCBpbXBsZW1lbnRhdGlvbiBvZiBtZW1vcnlfcmVnaW9uX2lvbW11X3JlcGxheSgp
IGlzIHRvDQo+ID4gPj4gPiAgICAgKiBjYWxsIHRoZSBJT01NVSB0cmFuc2xhdGUgbWV0aG9kIGZv
ciBldmVyeSBwYWdlIGluIHRoZSBhZGRyZXNzIHNwYWNlDQo+ID4gPj4gPiAgICAgKiB3aXRoIGZs
YWcgPT0gSU9NTVVfTk9ORSBhbmQgdGhlbiBjYWxsIHRoZSBub3RpZmllciBpZiB0cmFuc2xhdGUN
Cj4gPiA+PiA+ICAgICAqIHJldHVybnMgYSB2YWxpZCBtYXBwaW5nLiBJZiB0aGlzIG1ldGhvZCBp
cyBpbXBsZW1lbnRlZCB0aGVuIGl0DQo+ID4gPj4gPiAgICAgKiBvdmVycmlkZXMgdGhlIGRlZmF1
bHQgYmVoYXZpb3VyLCBhbmQgbXVzdCBwcm92aWRlIHRoZSBmdWxsIHNlbWFudGljcw0KPiA+ID4+
ID4gICAgICogb2YgbWVtb3J5X3JlZ2lvbl9pb21tdV9yZXBsYXkoKSwgYnkgY2FsbGluZyBAbm90
aWZpZXIgZm9yIGV2ZXJ5DQo+ID4gPj4gPiAgICAgKiB0cmFuc2xhdGlvbiBwcmVzZW50IGluIHRo
ZSBJT01NVS4NCj4gPiA+PiBBYm92ZSBzZW1hbnRpY3MgY2xhaW1zIGNhbGxpbmcgQG5vdGlmaWVy
IGZvciBldmVyeSB0cmFuc2xhdGlvbiBwcmVzZW50DQo+ID4gPj4gaW4gdGhlIElPTU1VIEJ1dCBp
dCBkb2Vzbid0IGNsYWltIGlmIGNhbGxpbmcgQG5vdGlmaWVyIGZvciBub24tcHJlc2VudA0KPiA+
ID50cmFuc2xhdGlvbi4NCj4gPiA+PiBJIGNoZWNrZWQgb3RoZXIgY3VzdG9tIHJlcGxheSgpIGNh
bGxiYWNrLCBleC4gdmlydGlvX2lvbW11X3JlcGxheSgpLA0KPiA+ID4+IHNwYXByX3RjZV9yZXBs
YXkoKSBpdCBsb29rcyBvbmx5IGludGVsX2lvbW11IGlzIHNwZWNpYWwgYnkgY2FsbGluZyB1bm1h
cF9hbGwoKQ0KPiA+ID5iZWZvcmUgcmVidWlsZCBtYXBwaW5nLg0KPiA+ID4NCj4gPiA+WWVzLCBh
bmQgSSdsbCByZXBseSBiZWxvdyBmb3IgdGhpcy4uDQo+ID4gPg0KPiA+ID4+DQo+ID4gPj4gPg0K
PiA+ID4+ID5UaGUgcHJvYmxlbSBpcyB2dGRfcGFnZV93YWxrKCkgY3VycmVudGx5IGJ5IGRlZmF1
bHQgb25seSBub3RpZmllcyBvbg0KPiA+ID4+ID5wYWdlIGNoYW5nZXMsIHNvIHdlJ2xsIG5vdGlm
eSBhbGwgTUFQIG9ubHkgaWYgd2UgdW5tYXAgYWxsIG9mIHRoZW0gZmlyc3QuDQo+ID4gPj4gSG1t
LCBJIGRpZG4ndCBnZXQgdGhpcyBwb2ludC4gQ2hlY2tlZCB2dGRfcGFnZV93YWxrX29uZSgpLCBp
dCB3aWxsDQo+ID4gPj4gcmVidWlsZCB0aGUgbWFwcGluZyBleGNlcHQgdGhlIERNQU1hcCBpcyBl
eGFjdGx5IHNhbWUgd2hpY2ggaXQgd2lsbCBza2lwLg0KPiA+ID5TZWUgYmVsb3c6DQo+ID4gPj4N
Cj4gPiA+PiAgICAgLyogVXBkYXRlIGxvY2FsIElPVkEgbWFwcGVkIHJhbmdlcyAqLw0KPiA+ID4+
ICAgICBpZiAoZXZlbnQtPnR5cGUgPT0gSU9NTVVfTk9USUZJRVJfTUFQKSB7DQo+ID4gPj4gICAg
ICAgICBpZiAobWFwcGVkKSB7DQo+ID4gPj4gICAgICAgICAgICAgLyogSWYgaXQncyBleGFjdGx5
IHRoZSBzYW1lIHRyYW5zbGF0aW9uLCBza2lwICovDQo+ID4gPj4gICAgICAgICAgICAgaWYgKCFt
ZW1jbXAobWFwcGVkLCAmdGFyZ2V0LCBzaXplb2YodGFyZ2V0KSkpIHsNCj4gPiA+PiAgICAgICAg
ICAgICAgICAgdHJhY2VfdnRkX3BhZ2Vfd2Fsa19vbmVfc2tpcF9tYXAoZW50cnktPmlvdmEsIGVu
dHJ5LQ0KPiA+ID4+YWRkcl9tYXNrLA0KPiA+ID4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICBlbnRyeS0+dHJhbnNsYXRlZF9hZGRyKTsNCj4gPiA+PiAg
ICAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gPj4gICAgICAgICAgICAgfSBlbHNlIHsNCj4g
PiA+PiAgICAgICAgICAgICAgICAgLyoNCj4gPiA+PiAgICAgICAgICAgICAgICAgICogVHJhbnNs
YXRpb24gY2hhbmdlZC4gIE5vcm1hbGx5IHRoaXMgc2hvdWxkIG5vdA0KPiA+ID4+ICAgICAgICAg
ICAgICAgICAgKiBoYXBwZW4sIGJ1dCBpdCBjYW4gaGFwcGVuIHdoZW4gd2l0aCBidWdneSBndWVz
dA0KPiA+ID4NCj4gPiA+U28gSSBoYXZlbid0IHRvdWNoZWQgdGhlIHZJT01NVSBjb2RlIGZvciBh
IGZldyB5ZWFycywgYnV0IElJUkMgaWYgd2UNCj4gPiA+cmVwbGF5KCkgb24gYW4gYWRkcmVzcyBz
cGFjZSB0aGF0IGhhcyBtYXBwaW5nIGFscmVhZHksIHRoZW4gaWYgd2l0aG91dCB0aGUNCj4gPiA+
dW5tYXBfYWxsKCkgYXQgdGhlIHN0YXJ0IHdlJ2xsIGp1c3Qgbm90aWZ5IG5vdGhpbmcsIGJlY2F1
c2UgIm1hcHBlZCIgd2lsbCBiZQ0KPiA+ID50cnVlIGZvciBhbGwgdGhlIGV4aXN0aW5nIG1hcHBp
bmdzLCBhbmQgbWVtY21wKCkgc2hvdWxkIHJldHVybiAwIHRvbyBpZg0KPiA+ID5ub3RoaW5nIGNo
YW5nZWQ/DQo+ID4gVW5kZXJzdG9vZCwgeW91IGFyZSByaWdodC4gVkZJTyBtaWdyYXRpb24gZGly
dHkgc3luYyBuZWVkcyB0byBiZSBub3RpZmllZA0KPiA+IGV2ZW4gaWYgbWFwcGluZyBpcyB1bmNo
YW5nZWQuDQo+ID4NCj4gPiA+DQo+ID4gPkkgdGhpbmsgKGFuZCBhZ3JlZSkgaXQgY291bGQgYmUg
YSAiYnVnIiBmb3IgdnRkIG9ubHksIG1vc3RseSBub3QgYWZmZWN0aW5nDQo+ID4gPmFueXRoaW5n
IGF0IGxlYXN0IGJlZm9yZSB2ZmlvIG1pZ3JhdGlvbi4NCj4gPiA+DQo+ID4gPkRvIHlvdSBhZ3Jl
ZSwgYW5kIHBlcmhhcHMgd2FudCB0byBmaXggaXQgYWx0b2dldGhlcj8gIElmIHNvIEkgc3VwcG9z
ZSBpdCdsbCBhbHNvDQo+ID4gPmZpeCB0aGUgaXNzdWUgYmVsb3cgb24gdmZpbyBkaXJ0eSBzeW5j
Lg0KPiA+IFllcywgSSdsbCB3cml0ZSBhbiBpbXBsZW1lbnRhdGlvbi4NCj4gPg0KPiA+IFRoYW5r
cw0KPiA+IFpoZW56aG9uZw0KDQo=

