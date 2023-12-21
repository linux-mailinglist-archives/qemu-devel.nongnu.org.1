Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8BB81B0D4
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:57:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEr1-0000gR-UF; Thu, 21 Dec 2023 03:56:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rGEqv-0000eT-9F
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:56:25 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rGEqs-0006VL-Ll
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:56:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703148982; x=1734684982;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DsKLwFkp7hlqdlHY6YitzGufX8vKqri91hEVOV9MROI=;
 b=h4et/tweNwJ/uO90HWpmaCJN+QyCwBMOPes7t6KJ29zJFlZffrxcwRYE
 UYwbBoBp7PVoiEhg8c15GJn3UY7IRoEyH5EgSmYc1qrkg3Uq3MW3TbUoX
 /Y5hViHH9Cty9Qk7omYQ/fdNklAyXbtDximGQw4Yfwj05p9IZd2gmH/nP
 ++g+Q4wQPJ88aE+8k9CSRTDbkulftG5QSyk//K/Yq1Exoo54mnVmdIiGV
 3xZAqftTWQoUuwJyA/u9ZmRlBSuPz2C0SUuf8kY8V60I685zQhY+/E0hi
 2er9LwTW9oVRINv9c+7XcsnrtvC8ET5egNQ8FxjMT3xzsB5kLONOAs7zJ A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="460282312"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="460282312"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 00:56:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="895030247"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="895030247"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Dec 2023 00:56:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 00:56:01 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 00:56:01 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 00:55:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SDoxUIpwHcIFh1A3PZWndyDq8enFrXgF+V5WA9RlGNBWPWmem9jS0Y5Hw3dRtE/E1srA4dIKkabTni6NM4QtL5bTTWsZvmwv4THxhjGOTqXrMZ7jAxkVHQzUoNsDjENkyMdSnZRPY6kHD/V1JXQ9hsgcKBRsx+pUzdFIPuH1bDbjVVlIw7ctAgDhAfdKEJzTM0S245mGxUr069KN0Mzq1FaJYgNuNCsWqSaIh9ur0dS4FcZZoG2rt6rZRJcLvm/kodVYG6ZibUr8ODXchwX6OWkcnG9BCEQmOUpY5w7wIEiY4J0ZZW27vVWOAMP6M3OoOxl2RR9T+GB2NNz2s50zcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DsKLwFkp7hlqdlHY6YitzGufX8vKqri91hEVOV9MROI=;
 b=QUg10nVPzUF/y5Kkp6ZNhzO4ePRcqqR0p1Pvaxeq/XjnWrjVhX+/5mZgcjCG/KrvuZ6KxkpCqIoNYyDrGIB9fXydbK5pyPLEWmK5b5F7Ck/mCHbfaHmy9pRv5BdY94UffggOoJvuRs3aJJfIzmVPYtt9uubOoMm2wyV/AFH4CMQjK6K2tClgKNCWf/wwYxrP6BdDx0zLKm+s0fmIsLlYqanoFQbfbPKEpCDe5wNAPdNmGrtir8lHrIAxTaEDx78EagC0AsyLfUfa0C/nB1wNoaHFfpR2p45XO6HOpFqlejClWtoh41vFOIpHZUg9Klfh30cXkv322u8sKSj4LiNs5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM6PR11MB4642.namprd11.prod.outlook.com (2603:10b6:5:2a2::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20; Thu, 21 Dec
 2023 08:55:53 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 08:55:53 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH] vfio/iommufd: Remove the use of stat() to check file
 existence
Thread-Topic: [PATCH] vfio/iommufd: Remove the use of stat() to check file
 existence
Thread-Index: AQHaM+UqeJknvgSwEUu7ME6CfwkGM7CzblOQ
Date: Thu, 21 Dec 2023 08:55:53 +0000
Message-ID: <SJ0PR11MB6744B077E851815942C260C69295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231221080957.1081077-1-clg@redhat.com>
In-Reply-To: <20231221080957.1081077-1-clg@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM6PR11MB4642:EE_
x-ms-office365-filtering-correlation-id: f596e291-9743-4b40-a07e-08dc0202a352
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wynPmHEkMUZ1N0ktBC8l+KP13eg9t3FgZA6FyoKh6V8Kg5yXkxiFhNRD+FyS/aHv7bfGUZtiqCCyGDTPcC5FSIylbbxIKE+t3FmIrGO8x/ttQb5+Z/Ykr5SMT+gYAmuWa0bY8/9KmLozdWu7FK53i+5rVonMeskiIUTVynjzTiBCsuoy1eHoSmpqOp95c0H7NhuwkjOHIt4sfdA9jAycBdfWZx3WeFJxcwVJU8qUmRXtqDnvYKxTTIXltLTvA1/hU3mr0HLtQdLWjEIWRTTgXOYDVnSIfbSR//W3CSQ1H4qTuJgyMpoYONzmGWQhVChKHd5VuAx8xIKNf4sqto4cdT4ahR49mYZA4haPCwGK12TqeQAdlQbtuAoDSxcCLbTj8tae+kHf+so/wsHifX4JcUyHn0xLXv5niq7gKz55XgwHrhJIq3bnLaJmUtFQquJ5vqSHn6Q8jRnpx5gAtTGrm4thVz7MhMIbQbZgsUn9m5NiSqkQOvAwXiXs9SRvb6gvxpPR89kusHSYVpTgu626gMnjVrmfXtRn18UX0vkMVDFGVMIZBUfzadl+wga0JumsfAjvKZ317vBLJ0rdoUSuvqbXUDPGhHWCK6FMYr5xpa502UkMRhxZsdep5+ek/PS5
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(39860400002)(396003)(346002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(55016003)(26005)(9686003)(7696005)(6506007)(71200400001)(66574015)(86362001)(33656002)(82960400001)(38070700009)(38100700002)(5660300002)(83380400001)(4326008)(8936002)(8676002)(41300700001)(52536014)(122000001)(66556008)(66446008)(64756008)(54906003)(66946007)(76116006)(110136005)(66476007)(2906002)(316002)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TFdkbXYzSWY3bVgrZUhBN3FMbjVoYUFuQnQrMnpzWEQ1Y2tsZVd6SnJRK1J1?=
 =?utf-8?B?TVNCU3NheHpBRy9kK3hMenhYK25MTUc5VUpzWEFDMitzUHlMczdGY25QWWhP?=
 =?utf-8?B?NHp0YUFCL2w3UXpSZ0FXR3VVeEN0K0lhbTRjWHZ4REM1b1VTYWU1UlVleits?=
 =?utf-8?B?MG9qT0tEVVE0d3p3Uld2YlVtSlFRamEwS0tsVVlPTS95WmtPVWM0c08yckJt?=
 =?utf-8?B?STRnQ29EcE1UbjhLUTZkZmhJTGZHNmRUK3dLSkZMN2xybXZUUmJ5RlE5VHdN?=
 =?utf-8?B?bDhoQzF6RG0wVXNaNzlxSmgrZFBEdmw3ZE1YYU5tMml6c0ZPdVFnZHBYTlEw?=
 =?utf-8?B?bEpWa1BoTi9xRkxIMlZvNFQvTmNqZm0rekJ4RHlGNTZEU0k2dGpkSDY3YnpC?=
 =?utf-8?B?MmtJbUNidUZ5OTdzVFkweHd6Y0VHUDNIeEdsbkFPanYwcHlSbmN2ZzlHbUhh?=
 =?utf-8?B?K0Zxcnovdnd5ZjNITnhhNVpWQldKcVB5bWpBSGlVYktYRHIza2hsRnVieGJt?=
 =?utf-8?B?cWZoNDBnWDZaZURzQXh2UFAxYmdFbm9QdWk5MkZFYlpyRWNjODRmR3gxZ2Fs?=
 =?utf-8?B?V2ZLWWtqeHZzWlJhNkFQekwrTG5oSm5VWGZ4R3M1WkxDdGpSSGU3R1NRbFYz?=
 =?utf-8?B?cTRTRTdSbG03N0VkT3lFeUQrYlRaNzZydkI4YzdYby9JYS83c09aN0ZmTk10?=
 =?utf-8?B?TzMzSEd3QjhSYzhYWjFrRFBlTm5GbDk2b3h6OTVNcExHTXN0VTQzUnJyRnFI?=
 =?utf-8?B?UFpEM3dpa1FEU29PVTUwakp6cVFuQ015UWxUVDlGaGFJZjg4VUw3YlFoUnRz?=
 =?utf-8?B?Y1VicWE5VUdTSU9rb29vUTRFQ1RLNXFrbGVJOUxKN05vV25tbDFUMmR6SmdZ?=
 =?utf-8?B?Z1pBMHdnbnA5T09wUVFObnJ4V01TdDlUV1lpUUNaOW9tTThOUTIzUnVLZTJl?=
 =?utf-8?B?Tjd4Um91NUIyODFsZmIyRHNZNEQ1aEtNVzQrelkzRmxTMTNpTnJxZ05XOEZt?=
 =?utf-8?B?S3U1ckQrL0RTZTRaNkQvdlJLbkRjRUh1YnZGWDhSUmt3bHNVbW5IcE9Raitj?=
 =?utf-8?B?NnVMNjFXNmhSMDg4b1UxMlpKUUxlNHB2MVlyaDZkdzNQdmlQemJsTE11MG5S?=
 =?utf-8?B?Tkpha2QvbFZuZXVRbFY3L1RpN1kreDdKMXBJOUl6NXRwWlhVbkZ0TVplVnZN?=
 =?utf-8?B?YzEzNDBFRDNQRTd3MkZ1QlVTbHBPTXZNS0RCZlAzY2R2NlNZbHUrVXBON2xm?=
 =?utf-8?B?dFQwaTBLS3FXbm53eVVqdlp1eVB6UXVOcjR3ZzNBRVpXb3VPTTYzTDRSanZw?=
 =?utf-8?B?MUpabU1DQmJwWGhuVEdka0dhaDFacGFHVWZPcS9qWDdhTC92dUdZR3BYNXF4?=
 =?utf-8?B?OFN5alQ3QnRwMG5PdTk5dnB6VUlpay9vNFdWRjlFUzZab3ptSXJxK1BGMU1p?=
 =?utf-8?B?b1RvUmE3WDNjNXhtcng4bjJ3T3pxdm1vZ2hwRmhCT1VHYW9zSmtyMU9jQzFq?=
 =?utf-8?B?UkMvbmt2enJGZWt3SlRQM1pZZnJXMWsxNUtBamtQa1pKcVpSY3E3LzNQODlj?=
 =?utf-8?B?VmJ3Qno2TVR6RExxbUVQa25nNTZ3RzBGMnVybzJiQkppMUtqZlZObHVYRGM5?=
 =?utf-8?B?QTF3QzV1ZGozejJJSDJ2cWJxL3FDNFhRWHI2S2JGM2wrcWthSnB1NW1VT29G?=
 =?utf-8?B?QjJMeWdoVWJHV3BPSkt2WWs4VE84OWtPdDZtY0Vzd3lSeUg2WTlMdEZId1Va?=
 =?utf-8?B?YUp6UWpGanBTZWxzZ016YUlTcWpUVTN0ZGFaVjQ5WHJ5d3ljMjJGZzA1bmYv?=
 =?utf-8?B?YjF0NjRFdFdJb3RrbFd6M3lkODJMdGs5YW9LSFZsL29qcDA0NlJWK1IzdTlS?=
 =?utf-8?B?SUkyVlI3bWcyWGR4Wm9PSmZwK3J3NVdrMjNFdFhNUThKNFUyRk02T0JpTlRq?=
 =?utf-8?B?N2s3Q1kza2I3dXhJc09kcWxYdnV6NFYwRjdBQnVoMmtKeEdBQTdXT0llQ1JO?=
 =?utf-8?B?cHBWdDl4aS9ZdW9BSVdKTEMyVzI2eXhzRHh5L0pSWGxvUXZHR1B4Z3JWL1h5?=
 =?utf-8?B?ME1lakVGZjRMNVE2bDVnYStxOFpWaEtlLzA0WVR5am94eUtnekw1WjVicHNL?=
 =?utf-8?Q?N4mvoanNGanyZJJAXnEBVXsU0?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f596e291-9743-4b40-a07e-08dc0202a352
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:55:53.2431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GAZH1UhaIKGxgsVScyuECkz6H3bDRtrgC6SLPqIDiU72qtWJaGyJhFWW5JPs04RzhR84ZN95qyuwZSw/uF/tlynalpERgNkkFlnrOQug+7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4642
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjEsIDIwMjMgNDox
MCBQTQ0KPlN1YmplY3Q6IFtQQVRDSF0gdmZpby9pb21tdWZkOiBSZW1vdmUgdGhlIHVzZSBvZiBz
dGF0KCkgdG8gY2hlY2sgZmlsZQ0KPmV4aXN0ZW5jZQ0KPg0KPlVzaW5nIHN0YXQoKSBiZWZvcmUg
b3BlbmluZyBhIGZpbGUgb3IgYSBkaXJlY3RvcnkgY2FuIGxlYWQgdG8gYQ0KPnRpbWUtb2YtY2hl
Y2sgdG8gdGltZS1vZi11c2UgKFRPQ1RPVSkgZmlsZXN5c3RlbSByYWNlLCB3aGljaCBpcw0KPnJl
cG9ydGVkIGJ5IGNvdmVyaXR5IGFzIGEgU2VjdXJpdHkgYmVzdCBwcmFjdGljZXMgdmlvbGF0aW9u
cy4gVGhlDQo+c2VxdWVuY2UgY291bGQgYmUgcmVwbGFjZWQgYnkgb3BlbiBhbmQgZmRvcGVuZGly
IGJ1dCBpdCBkb2Vzbid0IGFkZA0KPm11Y2ggaW4gdGhpcyBjYXNlLiBTaW1wbHkgdXNlIG9wZW5k
aXIgdG8gYXZvaWQgdGhlIHJhY2UuDQo+DQo+Rml4ZXM6IENJRCAxNTMxNTUxDQo+U2lnbmVkLW9m
Zi1ieTogQ8OpZHJpYyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KDQpUaGFua3MgZm9yIGZp
eGluZywgUmV2aWV3ZWQtYnk6IFpoZW56aG9uZyBEdWFuIDxaaGVuemhvbmcuZHVhbkBpbnRlbC5j
b20+DQoNCkJScy4NClpoZW56aG9uZw0KDQo+LS0tDQo+IGh3L3ZmaW8vaW9tbXVmZC5jIHwgNiAt
LS0tLS0NCj4gMSBmaWxlIGNoYW5nZWQsIDYgZGVsZXRpb25zKC0pDQo+DQo+ZGlmZiAtLWdpdCBh
L2h3L3ZmaW8vaW9tbXVmZC5jIGIvaHcvdmZpby9pb21tdWZkLmMNCj5pbmRleA0KPmQ0YzU4NmU4
NDJkZWY4ZjA0ZDNhOTE0ODQzZjVlZWNlMmM3NWVhMzAuLjliZmRkYzEzNjA4OTU0MTMxNzZhOWYN
Cj4xNzBlMjllODkwMjczODRhNjYgMTAwNjQ0DQo+LS0tIGEvaHcvdmZpby9pb21tdWZkLmMNCj4r
KysgYi9ody92ZmlvL2lvbW11ZmQuYw0KPkBAIC0xMjEsMTcgKzEyMSwxMSBAQCBzdGF0aWMgaW50
IGlvbW11ZmRfY2Rldl9nZXRmZChjb25zdCBjaGFyDQo+KnN5c2ZzX3BhdGgsIEVycm9yICoqZXJy
cCkNCj4gICAgIERJUiAqZGlyID0gTlVMTDsNCj4gICAgIHN0cnVjdCBkaXJlbnQgKmRlbnQ7DQo+
ICAgICBnY2hhciAqY29udGVudHM7DQo+LSAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4gICAgIGdzaXpl
IGxlbmd0aDsNCj4gICAgIGludCBtYWpvciwgbWlub3I7DQo+ICAgICBkZXZfdCB2ZmlvX2RldnQ7
DQo+DQo+ICAgICBwYXRoID0gZ19zdHJkdXBfcHJpbnRmKCIlcy92ZmlvLWRldiIsIHN5c2ZzX3Bh
dGgpOw0KPi0gICAgaWYgKHN0YXQocGF0aCwgJnN0KSA8IDApIHsNCj4tICAgICAgICBlcnJvcl9z
ZXRnX2Vycm5vKGVycnAsIGVycm5vLCAibm8gc3VjaCBob3N0IGRldmljZSIpOw0KPi0gICAgICAg
IGdvdG8gb3V0X2ZyZWVfcGF0aDsNCj4tICAgIH0NCj4tDQo+ICAgICBkaXIgPSBvcGVuZGlyKHBh
dGgpOw0KPiAgICAgaWYgKCFkaXIpIHsNCj4gICAgICAgICBlcnJvcl9zZXRnX2Vycm5vKGVycnAs
IGVycm5vLCAiY291bGRuJ3Qgb3BlbiBkaXJlY3RvcnkgJXMiLCBwYXRoKTsNCj4tLQ0KPjIuNDMu
MA0KDQo=

