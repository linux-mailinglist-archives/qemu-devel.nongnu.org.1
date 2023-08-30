Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E2678D392
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 09:23:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbFWd-0007Tj-Br; Wed, 30 Aug 2023 03:22:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qbFWW-0007Tb-3o
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:21:56 -0400
Received: from mgamail.intel.com ([134.134.136.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qbFWR-0007pd-6J
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 03:21:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1693380111; x=1724916111;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c9MP8ZdEg+KPuDj2aFtiotvACj8vK6by6ueyIS6fmTw=;
 b=J4yOebjYodzjMveSZXdMdU8FdvPHBEWOu3aaMdUisQUajIzm6YnFp1Tc
 hO9/CTw6fHEqDeVpxt4U7gtFHIQZVVc7k9Kz6w2P1eAPGs7dJsouFpeYX
 xkN7FHZ00kV8zC0bJZspqLJ0j07LvB1ILnn1/kCcnxQG4MTldTU7JHmNY
 nW28/3YOf0sho8gy/lBPx1dpaJubZ17RFJ0KTiWy9Oi8Ncu7f97N+6A2M
 TKa/EWo3zkGmO/ntKPXGNscr1QkWKxp/Atsa+ZA3SyJWbKvw/AqNDnH8v
 Hjr3Xbu2HyIWwkEFKZdcd4udOwpnpFMuNc4UzqoBs+ndUk+1oxBB53yb6 w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="379324485"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="379324485"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Aug 2023 00:21:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="912688086"
X-IronPort-AV: E=Sophos;i="6.02,212,1688454000"; d="scan'208";a="912688086"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga005.jf.intel.com with ESMTP; 30 Aug 2023 00:21:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:21:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 00:21:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 00:21:44 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 00:21:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BE3Ki18UT1D1U0EvXWlcGE34JRG6s79GASDy9U7BsAVSkYlV6ilifWSBrbjLhODT2DKy8+nOO7+keqgdyaD9fTYY3hhRly2APHWtThGT8BlX/CTYgNB/3UJRtxuqCtab0NaTXPloQLhEj+wXnIxCGgw5d+EbcBOz6jcrhLBMqcKGcg76+Py+p6+ZSxqgCvdndzAaE5CClPC/VkVQlx5azi+liw6AK+ey45B96rR8Lv3M8fVinE/zzeSjyalNQwIASZRwufnREdcr+qgDPpYo0lp+vjF+150e/+pjE/OShTE/CrlDkCTD4NaFpMHkjP6AJGD4aMEsfuyutRBl1UaUmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9MP8ZdEg+KPuDj2aFtiotvACj8vK6by6ueyIS6fmTw=;
 b=iZtKVvCUgdKamxupYcBGDEBMCKWrjbpEpjl5RtpPJTWQn8hdJG/4r5iTHHBe2gJ0K64n8+daohyHjmgKXKOU/IlUF8k13+ekhCJr1JmmOx8gJrhop11ZzqzFTRpyJixd8RXzQs+hl7EuggK3ZWfvDqYAMaR8Nhzys4PBsReXqVmpN2Ct4OeOLcucon/ZKLg5ot9p+JAZw0cpX5DUlm1xFyxn9xhV2vh6ngTw678t0EvgbDwHWXEFbdOwzlsj9xq9/J5ntis0epywFj/8GickZrUCmhcsK8WrN0zXEy8nn6kaQuaopQWOnNoYR0xCsnW/abFE2Dhq+2/UWLiyiAGarA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 DS0PR11MB7904.namprd11.prod.outlook.com (2603:10b6:8:f8::8) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Wed, 30 Aug 2023 07:21:37 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6678.023; Wed, 30 Aug 2023
 07:21:37 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>,
 "jing2.liu@linux.intel.com" <jing2.liu@linux.intel.com>
Subject: RE: [PATCH v1 1/4] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Topic: [PATCH v1 1/4] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Index: AQHZ1Mpspit9NKRZ70Sssl+q9+wOxLABUUoAgAEkfDA=
Date: Wed, 30 Aug 2023 07:21:36 +0000
Message-ID: <DS0PR11MB811449835EA006213327B1F5A9E6A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230822072927.224803-1-jing2.liu@intel.com>
 <20230822072927.224803-2-jing2.liu@intel.com>
 <76d4ad43-72ba-a3cb-1c6a-85575c2e0e29@redhat.com>
In-Reply-To: <76d4ad43-72ba-a3cb-1c6a-85575c2e0e29@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|DS0PR11MB7904:EE_
x-ms-office365-filtering-correlation-id: 770d4bd8-5340-407d-1cb8-08dba929bf37
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: o8H+nDEg1E3aj4QhwZXPbdmZ7LPmj+8SSbN9DR7jjWjAMlfeJ23I0tu9KXRVEBGpZ4tuJiL3oNjOIyPM4pzvj/yMgmcoEq+yZOEKdl5ABtOUsUQMHTboMs8+Qq2azvy2N8ss0p4Yr4JLyRwHCHxsW5/Rh98x/e3tTZnnmSzNh8bDg6zolCrCr531gpzY5xx+ZjLKFoNPyW3DyMmgftycS90/455Q4HC5p/fNwhOxHGhxu2jknuXY5C3hRy2iBRI3CodhFayEOfT1o105UKLCcJvDCjlVpil3QQu5ivRSNnqMvFzxFEmL+USsGFkmcFLQ00Z6DCJe/OuG/U37yO10oKRb+/zJOFSUW28oVzOqBR5ymSqfmI1/xCVuc9qTHfLaYqB2Kgd+0ovEzgKaorMnz7nMZCLddyxFrRusFLBLnd0BVEnu1AjRwOLxVFZnO84gkHfiBovuAxKV8Nu9/X0Yw/6BiMywSWxQbFaUbaJg3xHQlXx4TdqfzRqvrSXKf3PEbhIbgRSBb+DH/PwOwnb8M1PLxnwdIbpL2J0GiAgLijf4o3njxCKUUlokD7IGpVcaSfjw+7UCUKE45akZQKrYVMgKWWc7do+6+q9TWdc+SXB0giMK1M/2tT08/4Gxql8p
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(136003)(39860400002)(346002)(366004)(1800799009)(451199024)(186009)(83380400001)(478600001)(122000001)(26005)(66574015)(9686003)(55016003)(6506007)(7696005)(53546011)(71200400001)(5660300002)(66946007)(2906002)(33656002)(52536014)(38070700005)(316002)(54906003)(82960400001)(66556008)(8936002)(76116006)(8676002)(66476007)(38100700002)(64756008)(41300700001)(66446008)(4326008)(110136005)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RFF5Y2x6RFZMRkwybVh2RHZpWGVnYThGSTEvQXd4czZxa1NnNjhLY21XeGRY?=
 =?utf-8?B?NTBHQlZoZFI1TWxLWmorRCtBRnBUaXZIc3dBZ0c0cUY4a005eHN2Y0NzZERh?=
 =?utf-8?B?M3Rvc010TGJvaTZlbEFTOWJmemdXOVE5QTVUSHhqM0VwNmRocUtML29zVnlx?=
 =?utf-8?B?K1k5dUR2SGJFZXY2S0R0S1R1czlDN2hmMjFoVE9KU1NXamN0S3BId3Z1cExH?=
 =?utf-8?B?dkNDMXpVRGZtVS9ZRDFIdk5vbWF0Z0RWMkFRakV3ZmNodFhOQWZvVHN1d2JT?=
 =?utf-8?B?djk5RG9iUFpPaHVmSFgzUXI3SGhoSm9ZWHBIK1JkQW9wUDN2YlNIckowcURM?=
 =?utf-8?B?QzdlWHhtR0Z6UE5jTkVkU1RMbjUxNHVRN3VmYlFDbFBlRlAwaG9HbFZVOWVi?=
 =?utf-8?B?M2pOTEswVm9VTWVBMm5weVd0Q255dy9OVTZjeHFXbFBqdEdZV2dBQlF2cUZI?=
 =?utf-8?B?OU9aVVlPdkhCRTNEVnJSUmlVUjhMWUhSOUtOV0VjN3V0eTBLRXpOUTRNYnhy?=
 =?utf-8?B?NHhzeHcrd1VvSVJoZWFGSGhGTkJNWUV3VXRlYWVJNjR5ekd1TmhOZWV0YVgv?=
 =?utf-8?B?a2ZMV3V1ZDZ2dWZKQlcwN1AyRFIyMmljaXdNaTMyS3BZM3BFNUNWQlkzb1N6?=
 =?utf-8?B?U1VxUjJBZWhlaU9QTFN0QTIxNVB6NVFuN2Q5RGh6Rk00ZTBFbTV4ZElROEdX?=
 =?utf-8?B?SzFFWVRRTXBqYTFuUzJ5WlJIYjN1TXBEakdRTnhReCtoeUdBd2JocGhUaS8v?=
 =?utf-8?B?WEluZHo1OWF1TU5BUGpNUEdjY1REUVNmNHhONlppOWV5M3RoQ1JqUDVINkNR?=
 =?utf-8?B?bUxNM0tkSEdLVFJMUkhEeVd4aytnWG55cjlUREF2QUx2OENYd0tYUG81Rzl5?=
 =?utf-8?B?NTQwZzFmVXA3OWQwTTA5QldyZU5hZVJ2TE1uU0IzbCtxeDRrOStEMGFaVzh5?=
 =?utf-8?B?VzcvaDlWcFFRNm5PK2JPQ0NWajBRVGVWaGdxR3JmbTNrbWllWDd0SnBIUkJG?=
 =?utf-8?B?aWkzbUNCTDVTM2FNQzBtK21hRytZbm00MnpJREV4ZjhjRitSZDJKZVZIYUJU?=
 =?utf-8?B?OGxBcHVQcno5ODBwNWlmRWVMMVBlbUFNVkk2ZkRiRWNrcm4rYWtsNGRwZE1S?=
 =?utf-8?B?NkxYVlhTSzFxdDJzeWZ4a1hOdmk3azNGcWZ1S3dtcEhvK2pLaFRjdTJSZHlC?=
 =?utf-8?B?UktiRG9wUm01VU5MeVN6MlhORFNyMllkS3hodUd1V0dGelpjRnNnbFZMMy9U?=
 =?utf-8?B?aXUvOVZQV1hiUm1aWjJXKzZ4UnJhT0xnQm5lWlQ4UUZTSXhZUzFkc2pDY1o2?=
 =?utf-8?B?NGVsdmhEYS91VVZQRmJZeGludUsweEZFdkN5RllTeGlmTE5EREE0OS92T0J3?=
 =?utf-8?B?TWlKcUVERjB5dU9mang5QW1TRGVJd1h2QWNGSlhtbFhCNmNpeG0zMWxaNWNI?=
 =?utf-8?B?TkxTSzJDOExqdzE1MHVNRzVsc1hzdVBrTGpRSmZwL2EzbngrUFpoajlPQ3Ri?=
 =?utf-8?B?aGZWOHFOSUNiRU1aZmFwbFFkak1PVWxseVNkZ3NZUU5STXNtUVZyRXpGendW?=
 =?utf-8?B?OHIwNE5PRTBSM1BuKzB6OUlZdURTSG81eG90OGZNUFh6dGk1d0lXT1ZFNmRo?=
 =?utf-8?B?Q1VKSVMwQk0zN0ZhVUxsZ0kyZmsrK2MwcmUvdmk1bU5KTE5EdXkycjBsMkVT?=
 =?utf-8?B?T2lLZDZ4RHNQWk12VnhIMGVjdDk1QnJqaUJXNitDQTVIOXBsTFltV3Y1c084?=
 =?utf-8?B?N3lqcFlBTlhSUnRZSGVTeXRyRy9xMFZ1Z0xCa2lMOS8xcFlvSVJjYnUvdXNw?=
 =?utf-8?B?R2p0Z3pTNCs1U05NRUR0eVhZUTlhLzBvQlJYSDR3elpibW5RTzVhWHo1T3JV?=
 =?utf-8?B?WDN6NHRpbkhmbjh0ejlLd0t3WHNKRVh4Ulowa044OFdkQ1dTYmxsZlFnaEUr?=
 =?utf-8?B?MlFMRk9SOE0zRGFnYXZRVHpnQmYzWE5MekZCOC9pYklheGQzRHlQK2gyNU51?=
 =?utf-8?B?dWNDYjZVUzR1YXBiRVlkMHZaVG01ZTlNei93RGp0eE82R0dmOEw4OWlPejJr?=
 =?utf-8?B?YnhpczNlTmhaVUc2NU4waGZic2RoMGl0OThSclhMdWE2WW5OdUwvVDl4QzRx?=
 =?utf-8?Q?T7Neq96HSQnd7rY/3T91Uato8?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 770d4bd8-5340-407d-1cb8-08dba929bf37
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Aug 2023 07:21:36.9351 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JVqKwVqQxNYcCvHjTIRMVqMV43VplDOxqPsD6DcvChlZQTTT9XYZ+hNZOynRKUG3YTy2/ozjrarwcrHi9h68vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7904
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.65; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
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

SGkgQ8OpZHJpYywNCg0KVGhhbmsgeW91IGZvciB5b3VyIHJldmlld2luZy4NCg0KT24gOC8yOS8y
MDIzIDk6MzMgUE0sIEPDqWRyaWMgTGUgR29hdGVyIHdyb3RlOg0KPiBIZWxsbyBKaW5nLA0KPiAN
Cj4gT24gOC8yMi8yMyAwOToyOSwgSmluZyBMaXUgd3JvdGU6DQo+ID4gS2VybmVsIHByb3ZpZGVz
IHRoZSBndWlkYW5jZSBvZiBkeW5hbWljIE1TSS1YIGFsbG9jYXRpb24gc3VwcG9ydCBvZg0KPiA+
IHBhc3N0aHJvdWdoIGRldmljZSwgYnkgY2xlYXJpbmcgdGhlIFZGSU9fSVJRX0lORk9fTk9SRVNJ
WkUgZmxhZyB0bw0KPiA+IGd1aWRlIHVzZXIgc3BhY2UuDQo+ID4NCj4gPiBGZXRjaCB0aGUgZmxh
Z3MgZnJvbSBob3N0IHRvIGRldGVybWluZSBpZiBkeW5hbWljIE1TSS1YIGFsbG9jYXRpb24gaXMN
Cj4gPiBzdXBwb3J0ZWQuDQo+ID4NCj4gPiBPcmlnaW5hbGx5LWJ5OiBSZWluZXR0ZSBDaGF0cmUg
PHJlaW5ldHRlLmNoYXRyZUBpbnRlbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1ieTogSmluZyBMaXUg
PGppbmcyLmxpdUBpbnRlbC5jb20+DQo+ID4gLS0tDQo+ID4gQ2hhbmdlcyBzaW5jZSBSRkMgdjE6
DQo+ID4gLSBGaWx0ZXIgdGhlIGR5bmFtaWMgTVNJLVggYWxsb2NhdGlvbiBmbGFnIGFuZCBzdG9y
ZSBhcyBhIGJvb2wgdHlwZS4NCj4gPiAgICAoQWxleCkNCj4gPiAtIE1vdmUgdGhlIGRldGVjdGlv
biB0byB2ZmlvX21zaXhfZWFybHlfc2V0dXAoKS4gKEFsZXgpDQo+ID4gLSBSZXBvcnQgZXJyb3Ig
b2YgZ2V0dGluZyBpcnEgaW5mbyBhbmQgcmVtb3ZlIHRoZSB0cmFjZSBvZiBmYWlsdXJlDQo+ID4g
ICAgY2FzZS4gKEFsZXgsIEPDqWRyaWMpDQo+ID4gLS0tDQo+ID4gICBody92ZmlvL3BjaS5jICAg
ICAgICB8IDE1ICsrKysrKysrKysrKystLQ0KPiA+ICAgaHcvdmZpby9wY2kuaCAgICAgICAgfCAg
MSArDQo+ID4gICBody92ZmlvL3RyYWNlLWV2ZW50cyB8ICAyICstDQo+ID4gICAzIGZpbGVzIGNo
YW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0t
Z2l0IGEvaHcvdmZpby9wY2kuYyBiL2h3L3ZmaW8vcGNpLmMgaW5kZXgNCj4gPiBhMjA1YzZiMTEz
MGYuLjhhM2IzNGYzYzE5NiAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3BjaS5jDQo+ID4gKysr
IGIvaHcvdmZpby9wY2kuYw0KPiA+IEBAIC0xNDkzLDcgKzE0OTMsOSBAQCBzdGF0aWMgdm9pZCB2
ZmlvX21zaXhfZWFybHlfc2V0dXAoVkZJT1BDSURldmljZQ0KPiAqdmRldiwgRXJyb3IgKiplcnJw
KQ0KPiA+ICAgICAgIHVpbnQ4X3QgcG9zOw0KPiA+ICAgICAgIHVpbnQxNl90IGN0cmw7DQo+ID4g
ICAgICAgdWludDMyX3QgdGFibGUsIHBiYTsNCj4gPiAtICAgIGludCBmZCA9IHZkZXYtPnZiYXNl
ZGV2LmZkOw0KPiA+ICsgICAgaW50IHJldCwgZmQgPSB2ZGV2LT52YmFzZWRldi5mZDsNCj4gPiAr
ICAgIHN0cnVjdCB2ZmlvX2lycV9pbmZvIGlycV9pbmZvID0geyAuYXJnc3ogPSBzaXplb2YoaXJx
X2luZm8pLA0KPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIC5pbmRl
eCA9DQo+ID4gKyBWRklPX1BDSV9NU0lYX0lSUV9JTkRFWCB9Ow0KPiA+ICAgICAgIFZGSU9NU0lY
SW5mbyAqbXNpeDsNCj4gPg0KPiA+ICAgICAgIHBvcyA9IHBjaV9maW5kX2NhcGFiaWxpdHkoJnZk
ZXYtPnBkZXYsIFBDSV9DQVBfSURfTVNJWCk7IEBADQo+ID4gLTE1MzAsNiArMTUzMiwxNCBAQCBz
dGF0aWMgdm9pZCB2ZmlvX21zaXhfZWFybHlfc2V0dXAoVkZJT1BDSURldmljZSAqdmRldiwNCj4g
RXJyb3IgKiplcnJwKQ0KPiA+ICAgICAgIG1zaXgtPnBiYV9vZmZzZXQgPSBwYmEgJiB+UENJX01T
SVhfRkxBR1NfQklSTUFTSzsNCj4gPiAgICAgICBtc2l4LT5lbnRyaWVzID0gKGN0cmwgJiBQQ0lf
TVNJWF9GTEFHU19RU0laRSkgKyAxOw0KPiA+DQo+ID4gKyAgICByZXQgPSBpb2N0bCh2ZGV2LT52
YmFzZWRldi5mZCwgVkZJT19ERVZJQ0VfR0VUX0lSUV9JTkZPLCAmaXJxX2luZm8pOw0KPiA+ICsg
ICAgaWYgKHJldCA8IDApIHsNCj4gPiArICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAsIC1y
ZXQsICJmYWlsZWQgdG8gZ2V0IE1TSS1YIGlycSBpbmZvIik7DQo+IA0KPiBNaXNzaW5nIDoNCj4g
ICAgICAgICAgICAgIGdfZnJlZShtc2l4KTsNCj4gDQpPaCwgeWVzLiANCg0KPiANCj4gV2l0aCB0
aGlzIGZpeGVkLA0KPiANCj4gUmV2aWV3ZWQtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVk
aGF0LmNvbT4NCj4gDQpUaGFuayB5b3UuIEknbGwgYXBwbHkgaXQgaW4gbmV4dCB2ZXJzaW9uIHdp
dGggdGhlIGZpeC4gDQoNCkppbmcNCg0KPiBUaGFua3MsDQo+IA0KPiBDLg0KPiANCj4gDQo+IA0K
PiA+ICsgICAgICAgIHJldHVybjsNCj4gPiArICAgIH0NCj4gPiArDQo+ID4gKyAgICBtc2l4LT5u
b3Jlc2l6ZSA9ICEhKGlycV9pbmZvLmZsYWdzICYgVkZJT19JUlFfSU5GT19OT1JFU0laRSk7DQo+
ID4gKw0KPiA+ICAgICAgIC8qDQo+ID4gICAgICAgICogVGVzdCB0aGUgc2l6ZSBvZiB0aGUgcGJh
X29mZnNldCB2YXJpYWJsZSBhbmQgY2F0Y2ggaWYgaXQgZXh0ZW5kcyBvdXRzaWRlDQo+ID4gICAg
ICAgICogb2YgdGhlIHNwZWNpZmllZCBCQVIuIElmIGl0IGlzIHRoZSBjYXNlLCB3ZSBuZWVkIHRv
IGFwcGx5IGENCj4gPiBoYXJkd2FyZSBAQCAtMTU2Miw3ICsxNTcyLDggQEAgc3RhdGljIHZvaWQN
Cj4gdmZpb19tc2l4X2Vhcmx5X3NldHVwKFZGSU9QQ0lEZXZpY2UgKnZkZXYsIEVycm9yICoqZXJy
cCkNCj4gPiAgICAgICB9DQo+ID4NCj4gPiAgICAgICB0cmFjZV92ZmlvX21zaXhfZWFybHlfc2V0
dXAodmRldi0+dmJhc2VkZXYubmFtZSwgcG9zLCBtc2l4LT50YWJsZV9iYXIsDQo+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNpeC0+dGFibGVfb2Zmc2V0LCBtc2l4LT5lbnRy
aWVzKTsNCj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtc2l4LT50YWJsZV9v
ZmZzZXQsIG1zaXgtPmVudHJpZXMsDQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgbXNpeC0+bm9yZXNpemUpOw0KPiA+ICAgICAgIHZkZXYtPm1zaXggPSBtc2l4Ow0KPiA+DQo+
ID4gICAgICAgdmZpb19wY2lfZml4dXBfbXNpeF9yZWdpb24odmRldik7IGRpZmYgLS1naXQgYS9o
dy92ZmlvL3BjaS5oDQo+ID4gYi9ody92ZmlvL3BjaS5oIGluZGV4IGEyNzcxYjlmZjNjYy4uMDcx
NzU3NGQ3OWU5IDEwMDY0NA0KPiA+IC0tLSBhL2h3L3ZmaW8vcGNpLmgNCj4gPiArKysgYi9ody92
ZmlvL3BjaS5oDQo+ID4gQEAgLTExMyw2ICsxMTMsNyBAQCB0eXBlZGVmIHN0cnVjdCBWRklPTVNJ
WEluZm8gew0KPiA+ICAgICAgIHVpbnQzMl90IHRhYmxlX29mZnNldDsNCj4gPiAgICAgICB1aW50
MzJfdCBwYmFfb2Zmc2V0Ow0KPiA+ICAgICAgIHVuc2lnbmVkIGxvbmcgKnBlbmRpbmc7DQo+ID4g
KyAgICBib29sIG5vcmVzaXplOw0KPiA+ICAgfSBWRklPTVNJWEluZm87DQo+ID4NCj4gPiAgICNk
ZWZpbmUgVFlQRV9WRklPX1BDSSAidmZpby1wY2kiDQo+ID4gZGlmZiAtLWdpdCBhL2h3L3ZmaW8v
dHJhY2UtZXZlbnRzIGIvaHcvdmZpby90cmFjZS1ldmVudHMgaW5kZXgNCj4gPiBlZTc1MDllNjhl
NGYuLjZkZTVkOWJhOGU0NiAxMDA2NDQNCj4gPiAtLS0gYS9ody92ZmlvL3RyYWNlLWV2ZW50cw0K
PiA+ICsrKyBiL2h3L3ZmaW8vdHJhY2UtZXZlbnRzDQo+ID4gQEAgLTI3LDcgKzI3LDcgQEAgdmZp
b192Z2FfcmVhZCh1aW50NjRfdCBhZGRyLCBpbnQgc2l6ZSwgdWludDY0X3QgZGF0YSkgIg0KPiAo
MHglIlBSSXg2NCIsICVkKSA9IDB4JSINCj4gPiAgIHZmaW9fcGNpX3JlYWRfY29uZmlnKGNvbnN0
IGNoYXIgKm5hbWUsIGludCBhZGRyLCBpbnQgbGVuLCBpbnQgdmFsKSAiICglcywNCj4gQDB4JXgs
IGxlbj0weCV4KSAweCV4Ig0KPiA+ICAgdmZpb19wY2lfd3JpdGVfY29uZmlnKGNvbnN0IGNoYXIg
Km5hbWUsIGludCBhZGRyLCBpbnQgdmFsLCBpbnQgbGVuKSAiICglcywNCj4gQDB4JXgsIDB4JXgs
IGxlbj0weCV4KSINCj4gPiAgIHZmaW9fbXNpX3NldHVwKGNvbnN0IGNoYXIgKm5hbWUsIGludCBw
b3MpICIlcyBQQ0kgTVNJIENBUCBAMHgleCINCj4gPiAtdmZpb19tc2l4X2Vhcmx5X3NldHVwKGNv
bnN0IGNoYXIgKm5hbWUsIGludCBwb3MsIGludCB0YWJsZV9iYXIsIGludCBvZmZzZXQsIGludA0K
PiBlbnRyaWVzKSAiJXMgUENJIE1TSS1YIENBUCBAMHgleCwgQkFSICVkLCBvZmZzZXQgMHgleCwg
ZW50cmllcyAlZCINCj4gPiArdmZpb19tc2l4X2Vhcmx5X3NldHVwKGNvbnN0IGNoYXIgKm5hbWUs
IGludCBwb3MsIGludCB0YWJsZV9iYXIsIGludCBvZmZzZXQsIGludA0KPiBlbnRyaWVzLCBib29s
IG5vcmVzaXplKSAiJXMgUENJIE1TSS1YIENBUCBAMHgleCwgQkFSICVkLCBvZmZzZXQgMHgleCwN
Cj4gZW50cmllcyAlZCwgbm9yZXNpemUgJWQiDQo+ID4gICB2ZmlvX2NoZWNrX3BjaWVfZmxyKGNv
bnN0IGNoYXIgKm5hbWUpICIlcyBTdXBwb3J0cyBGTFIgdmlhIFBDSWUgY2FwIg0KPiA+ICAgdmZp
b19jaGVja19wbV9yZXNldChjb25zdCBjaGFyICpuYW1lKSAiJXMgU3VwcG9ydHMgUE0gcmVzZXQi
DQo+ID4gICB2ZmlvX2NoZWNrX2FmX2Zscihjb25zdCBjaGFyICpuYW1lKSAiJXMgU3VwcG9ydHMg
RkxSIHZpYSBBRiBjYXAiDQoNCg==

