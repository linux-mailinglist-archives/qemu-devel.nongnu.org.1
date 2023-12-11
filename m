Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8C080C102
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 06:53:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCZCx-0002UQ-7A; Mon, 11 Dec 2023 00:51:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZCs-0002Tz-SX
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:51:55 -0500
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rCZCq-0004So-DQ
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 00:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1702273912; x=1733809912;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=I0B7DOfXHx/yvJ6fFZoFaTU4Qbb/ALZVKCXZJoWxwtA=;
 b=aRcwdLcKWde46WZicyvV+wWI7UOvEUR/Bn54hx5nIhfrpcnOrDq9jTqh
 c5QqFGwjJ/e9rl/arfFXNGPXjxD3IUPI1W66h0/RDAZgNcI1PjOdw2QQD
 SpJ24NjEAHetjvzheALhkugFiU6XjlaqWYk7ffE9XOUzr6o1h2BviMaiN
 JvkJRGndUuCKq67BvNi7fmxbwPDuXdKnCqgziP5lcD0vy0AepsS2TuqkD
 ANhS3PZRTVb5y8S+EYAZGND6bxNI1uo830zTrSwbJApbZU58LLjbPh1c3
 3klgmvH0ciUlaPvpD06glRzF/9bAueoWJh9Zqs8lxv1haAwCONE/ViSlj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="385007382"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="385007382"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Dec 2023 21:51:46 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10920"; a="838885888"
X-IronPort-AV: E=Sophos;i="6.04,267,1695711600"; d="scan'208";a="838885888"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 10 Dec 2023 21:51:46 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 21:51:45 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 10 Dec 2023 21:51:45 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sun, 10 Dec 2023 21:51:45 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sun, 10 Dec 2023 21:51:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gCVj+bZL5gRO8QnZV+0zyoKNV7Sy6Rcxsnd8R39bgp16i9JH59iL1J4P/rRtKLQHge7EHg4kLPO2UkzjT+jkBrM2bBRm/NZ5FhXdnHUSMsIvmDzIQ4GVbVi4kBnOvHQjP4BL7FJvM9ik7QNC6ENMfzc0GSeKmNSwoynGYxNdEbK0Qeoe9h0gbY3YOLX1QpAs4j4/S93Cl8cthSGt4kR6EPKwrUa2lgC5mGR2ia7IOk7JYGnMDCr/paFQhT244z8PlZKZ8CyO8vbZT8fPdgxmLwy6yIL8VM29McklCF4DQ0Ieecx+DHo/I7jeDUbU/i7QQU4S7GSt5STTr6HfJ6LS3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I0B7DOfXHx/yvJ6fFZoFaTU4Qbb/ALZVKCXZJoWxwtA=;
 b=QiYqFZOYMW8/IXGu/kWIRfZs3TQE8X5xW4YtXe2n70NOAIT0XzbBGuP9cIbV/NlDIzigi0CzGgPVAFbZ9If0vq5+0KzV3oKk6D7hnXME1pPb7MeEtTIzJwk+8RfDxOhPAep1lENsQ7N6bMSHxGtSDPgDNObb32GZjZ5kGf+o1/UGKDqdJm63I5b/QBdgYll7VsWo26BhzwpdheXaHGBw2zbwDobh/EfSbRKuljEwZ304Blo5rpHX1OSdngqjc3ZWyFEnN2UwrZ/6ULurC9ZoZjOvHkfHCsfBpeK0iDbqvC50zoBfWwwpA3Q7EXQxf4KIc+ScDVrDn5hP0NryWmm0mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CY8PR11MB7947.namprd11.prod.outlook.com (2603:10b6:930:7a::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.32; Mon, 11 Dec
 2023 05:51:43 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7068.031; Mon, 11 Dec 2023
 05:51:43 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Harsh
 Prateek Bora" <harshpb@linux.ibm.com>
Subject: RE: [PATCH for-9.0 01/10] vfio/spapr: Extend VFIOIOMMUOps with a
 release handler
Thread-Topic: [PATCH for-9.0 01/10] vfio/spapr: Extend VFIOIOMMUOps with a
 release handler
Thread-Index: AQHaKbMoR2DQJMeT1UaIXHgLwvgvHLCjmCag
Date: Mon, 11 Dec 2023 05:51:43 +0000
Message-ID: <SJ0PR11MB6744DF28201C18698B61724B928FA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231208084600.858964-1-clg@redhat.com>
 <20231208084600.858964-2-clg@redhat.com>
In-Reply-To: <20231208084600.858964-2-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CY8PR11MB7947:EE_
x-ms-office365-filtering-correlation-id: a49a0fd5-da40-41e4-340e-08dbfa0d410b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Bgjw2jZwDFDE/Dwbie8Hh3mT5YW4tXLYk7/eSd9yal0c8DdALLSEyVQ0wztWc/PfmgD/HNLeEleHkGO223RcBNhGRCu8O8B1BS6KXBcWGGCUqwl+05tLvBl5diK1YMvggTOKxkXWWK3qi4ChNXvZX/3BqUDjgRHuUd6qBBxygOswaAsTZZSIT5PRmKZGCcSvlYCVv9lIEdB+U051UoZ69FwJ8ShNAYzhpuXC/5zniGlllEAwAyHwMqCcGKOUYgecZVr0vJMbZtJ6UbhY/fLBE9FNVO1AjRJ3sdx09qVJ9rCGqnS8NIg5N0uGjfqZ32lsxI24JBlQI4LYSRkzXAGindq5uSGMnxdHJA1OBFpO3DI4Girk2mQbrz+teKnV0N1JLdu98VBsEYrFAXi2GCJUlXCpfqdt0O+1KBJAmtWET29I70qvYY5urC03vC5D8LkWHkIaEku04A/6D3tXiUMvjJRue5J0OJdUycTrCM0dSwsR8MnCcbqf2DobcksCEIAxl7f1icnpGap4NU5GIssU28eNFIYA8KVrQeonY5TLqrPbvtMP3p4OfQR8PB1uENkVUEhG7DnM/lgE3mXn4sDj/s3VQ2UTo5OmKG4mOdmJYI/fudf6SIhN2PJ7R3FXR2xL
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(136003)(376002)(346002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(9686003)(52536014)(6506007)(5660300002)(26005)(33656002)(55016003)(38070700009)(4744005)(76116006)(54906003)(66446008)(66476007)(66556008)(66946007)(64756008)(2906002)(83380400001)(82960400001)(41300700001)(478600001)(7696005)(86362001)(8676002)(8936002)(4326008)(122000001)(110136005)(316002)(38100700002)(71200400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NldLSFJhUU1IRnRJeFo3ZXZJcWRXOFNNcnc2V2xoeUUyOFNwNWY3WXM2Z2lx?=
 =?utf-8?B?RVhBZldUWEtyeDlobzhHcjZKaWZyQlR0RU03bDA5VlF4WVY2OENKSFVzclJW?=
 =?utf-8?B?OUg3U0h3eDhGRERtVCtNQTh6cWtVNC9Ca1R6cmZlTy9xM0hObFZqNkJvMW1W?=
 =?utf-8?B?RVV2d1RhV1p5VWZDc29ROEZnUENuVkRxL21jVklmcTZySE1hOHUvYmRMRllR?=
 =?utf-8?B?ZDFLeHdzSUlKcnVFR1dlRC9GVXBlYjUzQTRaZkxvRHVhM1A3U1hyRWtwWkF6?=
 =?utf-8?B?aFp3aW5iZ0dpdVhPVHJCZU9iaWJnZWNkSnZOd1NDTHNEZkZYbWp0WDNtaElp?=
 =?utf-8?B?YzJRMEVpNW9mQytuamNaRGxKdGdJaWZDeDd2SFV4TFdwa015WmpXN245RDZE?=
 =?utf-8?B?aURablh3TlY1WTlOYW5FRUliUXVOKzhvOUhEQ1c4MDgzN0JhMGtlc1hZb05J?=
 =?utf-8?B?WlJUZWxoa0FnZ1FtWnhkcko1RzZtQnp1WkZoaHZtYzJPbWs5WTNRd1F1cndl?=
 =?utf-8?B?NHJ5eE5NUnA5UUtrQ0NlMUZSYjNBeEE0bE9XMUtOcDFHUWM0eng0dzJzWSsw?=
 =?utf-8?B?THF3NTN1TFBlQ2t0a0JSNEc3QUU5QUc5UWtrUkc5R2FyQUlEVmdrV1UyZHNI?=
 =?utf-8?B?d0ZTejlzOTFCd1RCaTNmTkRBRHh3TThlR093cEpFekIyVllWVmR2amRJUS94?=
 =?utf-8?B?SmFIL3lJVExGQ3lNaE5kWkNOVGswckZWdzBsSnUyeW9rSDVrTCtHdWdvMEpl?=
 =?utf-8?B?K3g2SmR0TCtBMi9lSGJqK1ZMc3ZJK3JMNFhsQ2VZNG04RmN3M2VGSThtZkdY?=
 =?utf-8?B?alF5eHBIYW44SFNIODdCeFpsQm5VbXppMEYrdFN6cExTNkNVeXR6VkpjNEZi?=
 =?utf-8?B?OTFJU0dyMVBrL2MzRDZLb1pVdm5sQ3hVZmZWck1PYzdwcFJXRGdvK0tFbUF2?=
 =?utf-8?B?L0syQ2RCN3Z5VVl2T0R1QTJQTHVaakgwQmhTSmJ1V0I1Q3o0M09rNkJZTCt6?=
 =?utf-8?B?ZG0vaVl2ZmE3VzVQUld5c0o5UlkrS1NNUmIzcVdHdTh5RmJ4NTV2MklkdEk3?=
 =?utf-8?B?cUFsaFhsNk4xajl5Yk1Xdmk4SC9QcU9yWTlmRnRPK3RVcEYzWEdNTmp4ZHg2?=
 =?utf-8?B?aFFtUC9aa21oUG5GcTNFUWJuTkdzYStETHc3bUV3WHdHRVZEK1dUazhCTm9U?=
 =?utf-8?B?akhBQ0MvYUJiY2ZFREJmMlBvUm9LTVpNaFVmWDNmV2Z0Vmt6cGRSbVNIMFlO?=
 =?utf-8?B?bW5nSFFsUEdkVFBVZXp3bG9IZHpFVUlGUDA2U0dNQUJZMzNGYzJkUFZvWDFZ?=
 =?utf-8?B?WXV6L1dpRzZnYis4aUhXMmlvVkIyQjBqRWtiTGNDM2habXh6d1FSczN0NHNE?=
 =?utf-8?B?VUhxWjZHOTNYdG9HT01aQ2VhQVI4dkFQdi9nUmJjZGFUaDMyWXA5T1J1bS9H?=
 =?utf-8?B?cXNDOTloSFhjc1ZFKzRkbm1ZNjZqUFRuWG8vcFpxVTd5a2tMcVQyaXdKeGZR?=
 =?utf-8?B?bSt3QjJDOFNjenJYV1I0dXVVbXhrMG1VV0QzRjkvN0xHUWYreGF4MTRaOG53?=
 =?utf-8?B?Q3c3MDA0TjRzYmwzTnJHcE4rZ2VocURhb0JCZm1WdE5JL1lBTVZOc0U2OURs?=
 =?utf-8?B?RDJ4QzZWc2EvTUFnd2ZmWlNXV2lXTSsreUFIZ3N1anA1Wm5zaWVlT2ZBMFBH?=
 =?utf-8?B?TEhpWEJZY3lVY3dQSXZscEx3Tk56T21NdWdib3dKUFlpV3c1TlU1cWRTRThQ?=
 =?utf-8?B?TUhTaVg4ZlVoRTRmQVg0bGNSNU1LY0NNSFd5Tm5od1lwQW9GOWhGK3hpQkpk?=
 =?utf-8?B?WGR5SzFSU28wcEYvemhnUWwzZm93ODlOcW1zbkNSaFJxdHBOdGUvclYyZE5x?=
 =?utf-8?B?Kytoam85YStGV1hRb290YzdJbm43K0dvcldYRUM5Q3dLOEl1VyswajhkSEVO?=
 =?utf-8?B?L3Z4S1o4VnhvbnY3SElMOGFRU0drZk1CRE5VSUpiK0tVcmNJN2ZtMWhZanJR?=
 =?utf-8?B?WFRGRTNVMHlZbkltZ2tSaDRKOW1JcDhEYm51cnpmNGl5UDZNd01UaHNUUHBJ?=
 =?utf-8?B?SkprSlZhdkhMODVDSFhZUGFvWmVubVB3ZFdDVU5wdnRST1NMdzRMUzh6c1Fy?=
 =?utf-8?Q?6vUFcogwY8wGCoMedujmpl4Bm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a49a0fd5-da40-41e4-340e-08dbfa0d410b
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2023 05:51:43.5744 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: os+yx42ki7QxpO5Kt228KE1midj/K1LK8x+ob51GTYSbPxehd55iHua3RW01M5eLM7w0znCukjwwO/xKT9/jaQjDCJeXI0WUFAcANKHX6z0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7947
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IEZyaWRheSwgRGVjZW1iZXIgOCwg
MjAyMyA0OjQ2IFBNDQo+U3ViamVjdDogW1BBVENIIGZvci05LjAgMDEvMTBdIHZmaW8vc3BhcHI6
IEV4dGVuZCBWRklPSU9NTVVPcHMgd2l0aCBhDQo+cmVsZWFzZSBoYW5kbGVyDQo+DQo+VGhpcyBh
bGxvd3MgdG8gYWJzdHJhY3QgYSBiaXQgbW9yZSB0aGUgc1BBUFIgSU9NTVUgc3VwcG9ydCBpbiB0
aGUNCj5sZWdhY3kgSU9NTVUgYmFja2VuZC4NCj4NCj5TaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExl
IEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+DQoNClJldmlld2VkLWJ5OiBaaGVuemhvbmcgRHVhbiA8
emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KDQpUaGFua3MNClpoZW56aG9uZw0K

