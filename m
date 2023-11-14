Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D69F07EAA94
	for <lists+qemu-devel@lfdr.de>; Tue, 14 Nov 2023 07:40:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2n4Q-0005y5-DV; Tue, 14 Nov 2023 01:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1r2n45-0005uz-VU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 01:38:27 -0500
Received: from mgamail.intel.com ([192.198.163.7])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vivek.kasireddy@intel.com>)
 id 1r2n41-00027X-OE
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 01:38:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699943902; x=1731479902;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6A9hcKHKAIGDz9QtpdL5+S/Kp2IPuFxlNr36YOmwIrk=;
 b=HeQaVnVACuiUQn+mayhsMW1tsFmgyRCAj3YtIJlEwIN6Vk2dKavL13Zx
 hRPjURDPs8IRK4C1gMqA3vBGjfT1VNdJs15loPjFOn7yiYdPaV+eGA5DH
 f0+RPlLmBeIp2JLYmnxdQfakkfiycBp/xceuKg8JLZDZiYLmAlaxlh1Sg
 57LB3qCx5DLhaRjL1sHVKzqhkK1Wp01KzmKW3+8He4/A7Nc7O2ViGWkvb
 1tJf6xlPiN4YKL9yQ0PcR7yAt0S/yjSRqtNVN0gUoT89fHRtWBmb6CPgs
 1Ecj1jenXJ6lAWZwTDfyMVko/K3w7Xg49OmKfXbkUljsOeYNE76nqlA9T w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="12141798"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="12141798"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2023 22:38:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10893"; a="799417134"
X-IronPort-AV: E=Sophos;i="6.03,301,1694761200"; d="scan'208";a="799417134"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 13 Nov 2023 22:38:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 22:38:17 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 13 Nov 2023 22:38:16 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 13 Nov 2023 22:38:16 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 13 Nov 2023 22:38:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cgn//MXgfhAsCClfvlLM+AjLdiiHxKiv1djklWXSLQVSJWJkJvcg6zDOYIKKRo8ivtT24ApEotm1uwJYBRNnTTOiBaVOuydtW2tJORARFi5YpPVnx+fj3nb1wKzIDqGFZKg/Eq9bp+7kneagaKfB3vujDl73Omy1KYInaalY8v5Pim5MoDRXX3ojx8rl0ZL+KQCVdrMACywV67cX0NP8bhLJ6tmQvsXgCZLJYKXTbt4YGWkqXM5I3ylz6CuwU+iFVVq2/NWKh0boadgo4eebs5s5cebHUOdJQDIWltkS7uu2Go+f6yrbm1de3lMhAtWzyb8MFBP2y3Nu9cHt5kDDDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A9hcKHKAIGDz9QtpdL5+S/Kp2IPuFxlNr36YOmwIrk=;
 b=erKddQL3EC/+HBzFI8uk7A9A3TUZJVemE7ykw18jCoL1oN+JLe8RpoqvsnGAm6rqkerIaasyEhAvNornM1jTYwqpIi2lNgBGD5/UGcEzecYJXJtE7T5LIxrXUBkYRZ17HvSHI9qGxACgC6aT9Kiw8Pr5vYSkF+gdxeR5FJ1Ns/hcjYqtyhX90OXGzQ/uJ0q/Kb43lJvNHPmL/5Ndq5vvsvNXfYG/zdIdCGnIZOIJ6mMYy2tUzOdO0SUWzT85CLy94Jhn5BQNhBtxCXu0CKukbt/FxAvWk744Sn2P7TUshar6XawscMbCx/NxCpeRxR/cxj2OTieZOZTwfBxyewqrRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20)
 by PH7PR11MB8275.namprd11.prod.outlook.com (2603:10b6:510:1ae::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Tue, 14 Nov
 2023 06:38:13 +0000
Received: from IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::b6a:cf27:4d2d:1df4]) by IA0PR11MB7185.namprd11.prod.outlook.com
 ([fe80::b6a:cf27:4d2d:1df4%4]) with mapi id 15.20.6977.029; Tue, 14 Nov 2023
 06:38:13 +0000
From: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
To: Laszlo Ersek <lersek@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Gerd Hoffmann <kraxel@redhat.com>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Alex
 Williamson" <alex.williamson@redhat.com>, "Kim, Dongwon"
 <dongwon.kim@intel.com>
Subject: RE: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
Thread-Topic: [PATCH v1] target/i386/host-cpu: Use IOMMU addr width for
 passthrough devices on Intel platforms
Thread-Index: AQHaFgbgRf8zjaPTskm3AyElkCgqfLB3+8SAgAFBYgA=
Date: Tue, 14 Nov 2023 06:38:12 +0000
Message-ID: <IA0PR11MB7185A5D525E42BEF95F6FEE8F8B2A@IA0PR11MB7185.namprd11.prod.outlook.com>
References: <20231113073239.270591-1-vivek.kasireddy@intel.com>
 <794ccd1e-a308-382f-dab7-438e2f62b8b4@redhat.com>
In-Reply-To: <794ccd1e-a308-382f-dab7-438e2f62b8b4@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR11MB7185:EE_|PH7PR11MB8275:EE_
x-ms-office365-filtering-correlation-id: dd5601ce-e28b-4936-5da7-08dbe4dc464c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: soLEf6T4EnGqK8EMqbBjYYYEDLXapM3em/5fHqpBJiq2aZq3dCFylOoUCXbEl8B4CgX5ONfed5xG+z+YkIvlqZzXCRHYOEakD6qvFeXf+6wwjpDqD5cS6I/46QumcJqvdx0hp18zfd2PwfvPeszAlkz4ct6l6hXsKGcLYuFDXsmC5vRHshYm0Erxa1kjAJYTGetYmON+lVCkNU1lFgoXWc2jfHquB2lSIMRX7Slda29/Yb+pYIpx9DfI2l5H6bQ5kczxaTw/SFRDN3j4YiR55LS5YafIMHmjvXQj6WnpdsmPXYxFimeWsq22hSXbgUlMcGZ+Z8cRjEuPpGxLmBK5EGEulWz3Sh7FjFqkGfBG4+edHyxupj93lGNZKMUHy/TdL5+e5fQQRgGiCc9BcsO5cvdd06r/j3zObZu/5wnYKsOEuZEQMG0LpReAd9dW4MfNwLfs+pN4nP+fygU/j+4Ggo8SBOXqgdvxUGUrfT+4aj3S0is5jAIgrcf9wyXJ6yxjPHy+mfoanOTAlUJZtPL+FUkO0CV2Vdww0yTfm77EM9uijNxJR4VlXXEUsI9xfLakvWf3LL+EkEiKTULtV9dqxak51Iy86sOeMCoLSEKrFFC+whd2NPH8G7sDKLO3wjJBQqYlTFJkPsY3AG4erQo6pw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(376002)(136003)(39860400002)(366004)(230922051799003)(230273577357003)(230173577357003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(41300700001)(33656002)(966005)(86362001)(76116006)(110136005)(66946007)(316002)(54906003)(64756008)(66446008)(66476007)(66556008)(82960400001)(122000001)(478600001)(107886003)(5660300002)(52536014)(2906002)(26005)(9686003)(7696005)(6506007)(53546011)(71200400001)(8936002)(4326008)(8676002)(83380400001)(38070700009)(55016003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UERKNU82RXdKNHRPUnlPbCswYm1CU2ovdVBoQSt6SWNHVWs1ZnYrUmdLb3l6?=
 =?utf-8?B?eElVam9UcWJsR1FxSUcxOVJlSTdlN0NBK0JaT3NpQzNyZ0x5NEZQT0d2eGZC?=
 =?utf-8?B?bmxzUWpGR0NIZCsxeElmZEhTYm1aeTZOdmJuSDFXUFpvakNzZktUb1p2K0ls?=
 =?utf-8?B?ZDI5ZEtydldkdWszMFBxQkVqMlU2am1YMWxIa1dQaFZkQWlNRHlwYS9rYlU2?=
 =?utf-8?B?Z3RWVldpZ1hUMXhPV3c1Zk92U2dIV3ZmVUg1bVdZeWJoOUFQVjMzUklPYTc0?=
 =?utf-8?B?TlUyZ1BYRmxvOVd1ZFJLKzB6M09HRkg0QVpqK2RFaVJoNFhERDBjV2tJN3NY?=
 =?utf-8?B?WmpyNi96c1FXc3Z6OGdWZEcvOVNjNlJmS0EyR0JTNFVyS3Frdmh4cUJsenE4?=
 =?utf-8?B?MjBHcHlCTEtpM2hqUXM1cm1FSkt0SDVOMjVTZDdJTUwxRTE5NVRoWXYwWWov?=
 =?utf-8?B?NGdDaGFrMlo2RHhpSzlMRTZTdjVxRHZJUEJZaElaQWZXOWhSZEVvL01DS21m?=
 =?utf-8?B?TE51VE5oMGlsa2NTZlplV1pZdGVMbEVJa2R4V2NqOHdwcDZ5NUhsVkRZMUhq?=
 =?utf-8?B?SEJlb3VLTnZOOXR2SUlCbCtNSk1ZQXo0T3RLVytFSldZcUx2bmtJbjhtYm12?=
 =?utf-8?B?Z29RSnpDaGhCMEU4Rng0ZHQveVU2ZDVyL2dCa0VBWGF1b05UTHVGMkZ6Wlh4?=
 =?utf-8?B?bFVQVFpVczdwMVVhVUVhQTRZSUxqL083cXNvVko4RHRta3JxY2lyQjgzRVkz?=
 =?utf-8?B?MVd5Y1BZbnlqR3JSSjFnbEp5U1QxMi9KMFd4QTNJcFlwdlJIdlk0NHh2NCtx?=
 =?utf-8?B?dHZ0WDNRaEtSMWdlZklYdnhsNTlEK083aEFFbExtOHY5Zm8wMXQ1aFpQRko4?=
 =?utf-8?B?NG9BVFhBYkc5dkNxZnJMdVZOdHhpcmJaa2NCMnNVMUdiYWNXVVR3Q2s1TTd3?=
 =?utf-8?B?eXp6VmJVYkVoVlMvc1YzUFBUa2pMR01MN2FpU2pjYS8wVmFhZStNS1pQZWtC?=
 =?utf-8?B?V24wUjgvY2ZMVUVuLzVTa0U3WWhubHptZml2alZxb2h1emhXakVjK0tNazA0?=
 =?utf-8?B?K1Y4Z0FkUFFZdmFqY1ZLM05mbVMvZVYwdERjNlZtL0J3UVhWOVJZU2V2SStz?=
 =?utf-8?B?TStVa1ZyTGcwS0tBWlVZRkw5eEtlbm9qeWFvRDh0cVhHNXhpUXZXUE5OYmRy?=
 =?utf-8?B?NCtDYWkwMFpqb2NJTWhrQ1pRaHh5ZXE2K0FTcHNqd3h0Y0pIS2VMU1kxUU0z?=
 =?utf-8?B?VFNxem1iZGpuUFhkYU50NWxCK2R6cjdnSHdyME5jSlIwK1YrV2Q1U2srdGZi?=
 =?utf-8?B?QkJuWEZHMnZxK1lKS1prVVdZK1VjZ29xeDBFVFAvSUhYdndsV0FGRnZtZnpL?=
 =?utf-8?B?MVB4V3o2WGlQY1ArMmVHSDBkdWZZSEIyd0w1UEJRSEhaaG9HaStVSHh2VTJW?=
 =?utf-8?B?aXBtOG1xaGdnd1BPYlUyOE5rTG1wNnRxRlpqRjdqMDRzUTkvdlkraDRmUWNI?=
 =?utf-8?B?Ump6clQwVHZhUU5seDFyQlR5WWZ0WjZ3RGZSN3k3cjVlaGMvdFVmZXd0Y1Rh?=
 =?utf-8?B?OC95SEJqRW1jU1BDRU4xOHlpWXZiQ3JrR1RXZFhUTWdiOUlOUlhzVW5aUDYy?=
 =?utf-8?B?N1FndzhKSWxaeVM0UVBSRWxzWTJ1eVZtbkNuUm05dDFHaCtMekNXTzB6b3cr?=
 =?utf-8?B?MGpxZ09GYkx2aU9DMEgvZHAvUDZqcjRDbkZQbnEzbGtEcnZTSzFiZlRibXlr?=
 =?utf-8?B?U3pqS25Pd1Vsc2VTdHpXclprbWNMOXNicjRiMzd1MkJoR1V6UDlUYlM5b3pK?=
 =?utf-8?B?R2REOC94Rk5keGNuYkhhbUd1WTVob3ZxSENiUldxN3hHbHB2ZURSdGVtZnpk?=
 =?utf-8?B?V0pUM3hvbzk4bUZjTjJuQXExVE5SYXhINFhWTCtIUFFyLzJpSmFySVgzOEZt?=
 =?utf-8?B?WDlpSi9Td0h4azFFU0lFS3lmV241ZUpsTXg4MHBPd1QvT2VWdGNzd21KMHIr?=
 =?utf-8?B?QzFGdFE2VjBxUUVmRTdvZkcxandaOWZHbm5lTlZINXVoa3lYWXEvdjlBVjZR?=
 =?utf-8?B?WlZ5TDl3c1pXdjJBbjBpUFdLRzNaYmc3M2VMRWwrM2E1WTVDaDRpL1JNQmRm?=
 =?utf-8?Q?+rka5zGQR/ccK0BvddUL+2uC6?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5601ce-e28b-4936-5da7-08dbe4dc464c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2023 06:38:12.5824 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gnQ3nGKWnJNvNS8H6CZfuRPFgreKflXsb+6df6LqezaYCjvAiwfLYRO2TocxCxzSvRwPna+U95GczvDuNHchFxyA7Ic69zKZWLAO7pnQrLI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8275
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.198.163.7;
 envelope-from=vivek.kasireddy@intel.com; helo=mgamail.intel.com
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

SGkgTGFzemxvLA0KDQo+IA0KPiBPbiAxMS8xMy8yMyAwODozMiwgVml2ZWsgS2FzaXJlZGR5IHdy
b3RlOg0KPiA+IEEgcmVjZW50IE9WTUYgdXBkYXRlIGhhcyByZXN1bHRlZCBpbiBNTUlPIHJlZ2lv
bnMgYmVpbmcgcGxhY2VkIGF0DQo+ID4gdGhlIHVwcGVyIGVuZCBvZiB0aGUgcGh5c2ljYWwgYWRk
cmVzcyBzcGFjZS4gQXMgYSByZXN1bHQsIHdoZW4gYQ0KPiA+IEhvc3QgZGV2aWNlIGlzIHBhc3N0
aHJvdWdoJ2QgdG8gdGhlIEd1ZXN0IHZpYSBWRklPLCB0aGUgZm9sbG93aW5nDQo+ID4gbWFwcGlu
ZyBmYWlsdXJlcyBvY2N1ciB3aGVuIFZGSU8gdHJpZXMgdG8gbWFwIHRoZSBNTUlPIHJlZ2lvbnMg
b2YNCj4gPiB0aGUgZGV2aWNlOg0KPiA+IFZGSU9fTUFQX0RNQSBmYWlsZWQ6IEludmFsaWQgYXJn
dW1lbnQNCj4gPiB2ZmlvX2RtYV9tYXAoMHg1NTdiMmYyNzM2ZDAsIDB4MzgwMDAwMDAwMDAwLCAw
eDEwMDAwMDAsDQo+IDB4N2Y5OGFjNDAwMDAwKSA9IC0yMiAoSW52YWxpZCBhcmd1bWVudCkNCj4g
Pg0KPiA+IFRoZSBhYm92ZSBmYWlsdXJlcyBhcmUgbWFpbmx5IHNlZW4gb24gc29tZSBJbnRlbCBw
bGF0Zm9ybXMgd2hlcmUNCj4gPiB0aGUgcGh5c2ljYWwgYWRkcmVzcyB3aWR0aCBpcyBsYXJnZXIg
dGhhbiB0aGUgSG9zdCdzIElPTU1VDQo+ID4gYWRkcmVzcyB3aWR0aC4gSW4gdGhlc2UgY2FzZXMs
IFZGSU8gZmFpbHMgdG8gbWFwIHRoZSBNTUlPIHJlZ2lvbnMNCj4gPiBiZWNhdXNlIHRoZSBJT1ZB
cyB3b3VsZCBiZSBsYXJnZXIgdGhhbiB0aGUgSU9NTVUgYXBlcnR1cmUgcmVnaW9ucy4NCj4gPg0K
PiA+IFRoZXJlZm9yZSwgb25lIHdheSB0byBzb2x2ZSB0aGlzIHByb2JsZW0gd291bGQgYmUgdG8g
ZW5zdXJlIHRoYXQNCj4gPiBjcHUtPnBoeXNfYml0cyA9IDxJT01NVSBwaHlzX2JpdHM+DQo+ID4g
VGhpcyBjYW4gYmUgZG9uZSBieSBwYXJzaW5nIHRoZSBJT01NVSBjYXBzIHZhbHVlIGZyb20gc3lz
ZnMgYW5kDQo+ID4gZXh0cmFjdGluZyB0aGUgYWRkcmVzcyB3aWR0aCBhbmQgdXNpbmcgaXQgdG8g
b3ZlcnJpZGUgdGhlDQo+ID4gcGh5c19iaXRzIHZhbHVlIGFzIHNob3duIGluIHRoaXMgcGF0Y2gu
DQo+ID4NCj4gPiBQcmV2aW91cyBhdHRlbXB0IGF0IHNvbHZpbmcgdGhpcyBpc3N1ZSBpbiBPVk1G
Og0KPiA+IGh0dHBzOi8vZWRrMi5ncm91cHMuaW8vZy9kZXZlbC90b3BpYy8xMDIzNTkxMjQNCj4g
Pg0KPiA+IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4NCj4gPiBDYzogUGhp
bGlwcGUgTWF0aGlldS1EYXVkw6kgPHBoaWxtZEBsaW5hcm8ub3JnPg0KPiA+IENjOiBBbGV4IFdp
bGxpYW1zb24gPGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tPg0KPiA+IENjOiBMYXN6bG8gRXJz
ZWsgPGxlcnNla0ByZWRoYXQuY29tPg0KPiA+IENjOiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1A
aW50ZWwuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFZpdmVrIEthc2lyZWRkeSA8dml2ZWsua2Fz
aXJlZGR5QGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAgdGFyZ2V0L2kzODYvaG9zdC1jcHUuYyB8
IDYxDQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNjAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4g
ZGlmZiAtLWdpdCBhL3RhcmdldC9pMzg2L2hvc3QtY3B1LmMgYi90YXJnZXQvaTM4Ni9ob3N0LWNw
dS5jDQo+ID4gaW5kZXggOTJlY2I3MjU0Yi4uODMyNmVjOTViYyAxMDA2NDQNCj4gPiAtLS0gYS90
YXJnZXQvaTM4Ni9ob3N0LWNwdS5jDQo+ID4gKysrIGIvdGFyZ2V0L2kzODYvaG9zdC1jcHUuYw0K
PiA+IEBAIC0xMiw2ICsxMiw4IEBADQo+ID4gICNpbmNsdWRlICJob3N0LWNwdS5oIg0KPiA+ICAj
aW5jbHVkZSAicWFwaS9lcnJvci5oIg0KPiA+ICAjaW5jbHVkZSAicWVtdS9lcnJvci1yZXBvcnQu
aCINCj4gPiArI2luY2x1ZGUgInFlbXUvY29uZmlnLWZpbGUuaCINCj4gPiArI2luY2x1ZGUgInFl
bXUvb3B0aW9uLmgiDQo+ID4gICNpbmNsdWRlICJzeXNlbXUvc3lzZW11LmgiDQo+ID4NCj4gPiAg
LyogTm90ZTogT25seSBzYWZlIGZvciB1c2Ugb24geDg2KC02NCkgaG9zdHMgKi8NCj4gPiBAQCAt
NTEsMTEgKzUzLDU4IEBAIHN0YXRpYyB2b2lkIGhvc3RfY3B1X2VuYWJsZV9jcHVfcG0oWDg2Q1BV
DQo+ICpjcHUpDQo+ID4gICAgICBlbnYtPmZlYXR1cmVzW0ZFQVRfMV9FQ1hdIHw9IENQVUlEX0VY
VF9NT05JVE9SOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIGludCBpbnRlbF9pb21tdV9jaGVj
ayh2b2lkICpvcGFxdWUsIFFlbXVPcHRzICpvcHRzLCBFcnJvcg0KPiAqKmVycnApDQo+ID4gK3sN
Cj4gPiArICAgIGdfYXV0b2ZyZWUgY2hhciAqZGV2X3BhdGggPSBOVUxMLCAqaW9tbXVfcGF0aCA9
IE5VTEwsICpjYXBzID0gTlVMTDsNCj4gPiArICAgIGNvbnN0IGNoYXIgKmRyaXZlciA9IHFlbXVf
b3B0X2dldChvcHRzLCAiZHJpdmVyIik7DQo+ID4gKyAgICBjb25zdCBjaGFyICpkZXZpY2UgPSBx
ZW11X29wdF9nZXQob3B0cywgImhvc3QiKTsNCj4gPiArICAgIHVpbnQzMl90ICppb21tdV9waHlz
X2JpdHMgPSBvcGFxdWU7DQo+ID4gKyAgICBzdHJ1Y3Qgc3RhdCBzdDsNCj4gPiArICAgIHVpbnQ2
NF90IGlvbW11X2NhcHM7DQo+ID4gKw0KPiA+ICsgICAgLyoNCj4gPiArICAgICAqIENoZWNrIGlm
IHRoZSB1c2VyIGlzIHBhc3N0aHJvdWdoaW5nIGFueSBkZXZpY2VzIHZpYSBWRklPLiBXZSBkb24n
dA0KPiA+ICsgICAgICogaGF2ZSB0byBsaW1pdCBwaHlzX2JpdHMgaWYgdGhlcmUgYXJlIG5vIHZh
bGlkIHBhc3N0aHJvdWdoIGRldmljZXMuDQo+ID4gKyAgICAgKi8NCj4gPiArICAgIGlmIChnX3N0
cmNtcDAoZHJpdmVyLCAidmZpby1wY2kiKSB8fCAhZGV2aWNlKSB7DQo+ID4gKyAgICAgICAgcmV0
dXJuIDA7DQo+ID4gKyAgICB9DQo+ID4gKw0KPiA+ICsgICAgZGV2X3BhdGggPSBnX3N0cmR1cF9w
cmludGYoIi9zeXMvYnVzL3BjaS9kZXZpY2VzLyVzIiwgZGV2aWNlKTsNCj4gPiArICAgIGlmIChz
dGF0KGRldl9wYXRoLCAmc3QpIDwgMCkgew0KPiA+ICsgICAgICAgIHJldHVybiAwOw0KPiA+ICsg
ICAgfQ0KPiA+ICsNCj4gPiArICAgIGlvbW11X3BhdGggPSBnX3N0cmR1cF9wcmludGYoIiVzL2lv
bW11L2ludGVsLWlvbW11L2NhcCIsDQo+IGRldl9wYXRoKTsNCj4gPiArICAgIGlmIChzdGF0KGlv
bW11X3BhdGgsICZzdCkgPCAwKSB7DQo+ID4gKyAgICAgICAgcmV0dXJuIDA7DQo+ID4gKyAgICB9
DQo+ID4gKw0KPiA+ICsgICAgaWYgKGdfZmlsZV9nZXRfY29udGVudHMoaW9tbXVfcGF0aCwgJmNh
cHMsIE5VTEwsIE5VTEwpKSB7DQo+ID4gKyAgICAgICAgaWYgKHNzY2FuZihjYXBzLCAiJWx4Iiwg
JmlvbW11X2NhcHMpICE9IDEpIHsNCj4gPiArICAgICAgICAgICAgcmV0dXJuIDA7DQo+ID4gKyAg
ICAgICAgfQ0KPiA+ICsgICAgICAgICppb21tdV9waHlzX2JpdHMgPSAoKGlvbW11X2NhcHMgPj4g
MTYpICYgMHgzZikgKyAxOw0KPiA+ICsgICAgfQ0KPiA+ICsNCj4gPiArICAgIHJldHVybiAwOw0K
PiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgdWludDMyX3QgaG9zdF9pb21tdV9waHlzX2JpdHMo
dm9pZCkNCj4gPiArew0KPiA+ICsgICAgdWludDMyX3QgaW9tbXVfcGh5c19iaXRzID0gMDsNCj4g
PiArDQo+ID4gKyAgICBxZW11X29wdHNfZm9yZWFjaChxZW11X2ZpbmRfb3B0cygiZGV2aWNlIiks
DQo+ID4gKyAgICAgICAgICAgICAgICAgICAgICBpbnRlbF9pb21tdV9jaGVjaywgJmlvbW11X3Bo
eXNfYml0cywgTlVMTCk7DQo+ID4gKyAgICByZXR1cm4gaW9tbXVfcGh5c19iaXRzOw0KPiA+ICt9
DQo+ID4gKw0KPiA+ICBzdGF0aWMgdWludDMyX3QgaG9zdF9jcHVfYWRqdXN0X3BoeXNfYml0cyhY
ODZDUFUgKmNwdSkNCj4gPiAgew0KPiA+ICAgICAgdWludDMyX3QgaG9zdF9waHlzX2JpdHMgPSBo
b3N0X2NwdV9waHlzX2JpdHMoKTsNCj4gPiArICAgIHVpbnQzMl90IGlvbW11X3BoeXNfYml0cyA9
IGhvc3RfaW9tbXVfcGh5c19iaXRzKCk7DQo+ID4gICAgICB1aW50MzJfdCBwaHlzX2JpdHMgPSBj
cHUtPnBoeXNfYml0czsNCj4gPiAtICAgIHN0YXRpYyBib29sIHdhcm5lZDsNCj4gPiArICAgIHN0
YXRpYyBib29sIHdhcm5lZCwgd2FybmVkMjsNCj4gPg0KPiA+ICAgICAgLyoNCj4gPiAgICAgICAq
IFByaW50IGEgd2FybmluZyBpZiB0aGUgdXNlciBzZXQgaXQgdG8gYSB2YWx1ZSB0aGF0J3Mgbm90
IHRoZQ0KPiA+IEBAIC03OCw2ICsxMjcsMTYgQEAgc3RhdGljIHVpbnQzMl90IGhvc3RfY3B1X2Fk
anVzdF9waHlzX2JpdHMoWDg2Q1BVDQo+ICpjcHUpDQo+ID4gICAgICAgICAgfQ0KPiA+ICAgICAg
fQ0KPiA+DQo+ID4gKyAgICBpZiAoaW9tbXVfcGh5c19iaXRzICYmIHBoeXNfYml0cyA+IGlvbW11
X3BoeXNfYml0cykgew0KPiA+ICsgICAgICAgIHBoeXNfYml0cyA9IGlvbW11X3BoeXNfYml0czsN
Cj4gPiArICAgICAgICBpZiAoIXdhcm5lZDIpIHsNCj4gPiArICAgICAgICAgICAgd2Fybl9yZXBv
cnQoIlVzaW5nIHBoeXNpY2FsIGJpdHMgKCV1KSINCj4gPiArICAgICAgICAgICAgICAgICAgICAg
ICAgIiB0byBwcmV2ZW50IFZGSU8gbWFwcGluZyBmYWlsdXJlcyIsDQo+ID4gKyAgICAgICAgICAg
ICAgICAgICAgICAgIGlvbW11X3BoeXNfYml0cyk7DQo+ID4gKyAgICAgICAgICAgIHdhcm5lZDIg
PSB0cnVlOw0KPiA+ICsgICAgICAgIH0NCj4gPiArICAgIH0NCj4gPiArDQo+ID4gICAgICByZXR1
cm4gcGh5c19iaXRzOw0KPiA+ICB9DQo+ID4NCj4gDQo+IEkgb25seSBoYXZlIHZlcnkgc3VwZXJm
aWNpYWwgY29tbWVudHMgaGVyZSAoc29ycnkgYWJvdXQgdGhhdCAtLSBJIGZpbmQNCj4gaXQgdG9v
IGJhZCB0aGF0IHRoaXMgUUVNVSBzb3VyY2UgZmlsZSBzZWVtcyB0byBoYXZlIG5vIGRlc2lnbmF0
ZWQNCj4gcmV2aWV3ZXIgb3IgbWFpbnRhaW5lciBpbiBRRU1VLCBzbyBJIGRvbid0IHdhbnQgdG8g
aWdub3JlIGl0KS4NCj4gDQo+IC0gVGVybWlub2xvZ3k6IEkgdGhpbmsgd2UgbGlrZSB0byBjYWxs
IHRoZXNlIGRldmljZXMgImFzc2lnbmVkIiwgYW5kIG5vdA0KPiAicGFzc2VkIHRocm91Z2giLiBB
bHNvLCBpbiBub3VuIGZvcm0sICJkZXZpY2UgYXNzaWdubWVudCIgYW5kIG5vdA0KPiAiZGV2aWNl
IHBhc3N0aHJvdWdoIi4gU29ycnkgYWJvdXQgYmVpbmcgcGVkYW50aWMuDQpObyBwcm9ibGVtOyBJ
J2xsIHRyeSB0byBzdGFydCB1c2luZyB0aGUgcmlnaHQgdGVybWlub2xvZ3kuDQoNCj4gDQo+IC0g
QXMgSSAobWF5IGhhdmUpIG1lbnRpb25lZCBpbiBteSBPVk1GIGNvbW1lbnRzLCBJJ20gdW5zdXJl
IGlmIG5hcnJvd2luZw0KPiB0aGUgVkNQVSAicGh5cyBhZGRyZXNzIGJpdHMiIHByb3BlcnR5IGR1
ZSB0byBob3N0IElPTU1VIGxpbWl0YXRpb25zIGlzIGENCj4gZ29vZCBkZXNpZ24uIFRvIG1lIGl0
IGZlZWxzIGxpa2UgaGFja2luZyBvbmUgcGllY2Ugb2YgaW5mb3JtYXRpb24gaW50bw0KPiBhbm90
aGVyICh1bnJlbGF0ZWQpIHBpZWNlIG9mIGluZm9ybWF0aW9uLiBJdCB2YWd1ZWx5IG1ha2VzIG1l
IHRoaW5rDQo+IHdlJ3JlIGdvaW5nIHRvIHJlZ3JldCB0aGlzIGxhdGVyLiBCdXQgSSBkb24ndCBo
YXZlIGFueSBzcGVjaWZpYywgY3VycmVudA0KPiBjb3VudGVyLWFyZ3VtZW50LCBhZG1pdHRlZGx5
Lg0KVGhlIHBoeXNpY2FsIGFkZHJlc3Mgc3BhY2UgcmVzdHJpY3Rpb24gaXMgb25seSBhcHBsaWVk
IGlmIHRoZSB1c2VyIHJlcXVlc3RzIGEgVkZJTw0KYXNzaWduZWQgZGV2aWNlIGJ1dCBub3QgaW4g
b3RoZXIgZ2VuZXJhbCBjYXNlczsgd2hpY2ggSSB0aGluayBpcyBzb21ld2hhdA0KcmVhc29uYWJs
ZS4gSG93ZXZlciwgSSBkbyBhZ3JlZSB3aXRoIHlvdSB0aGF0IHRoaXMgc29sdXRpb24gZmVlbHMg
YSBiaXQgbGFja2x1c3Rlci4NCg0KQUZBSUNTLCBzaW5jZSB0aGUgbWFpbiBpc3N1ZSBoZXJlIGlz
IHRoZSBwbGFjZW1lbnQgb2YgdGhlIE1NSU8gd2luZG93LCBJDQphbSB3b25kZXJpbmcgaWYgd2Ug
Y2FuIGFkZHJlc3MgdGhpcyBzcGVjaWZpYyBpc3N1ZS4gSUlSQywgcHJpb3IgdG8gR2VyZCdzIHBh
dGNoLA0KdGhlIE1NSU8gYmFzZSBhbmQgc2l6ZSB3ZXJlIGJvdGggMzIgR0IgYW5kIHRoaXMgc2Vl
bWVkIHRvIGhhdmUgd29ya2VkDQpmaW5lIHdpdGggVkZJTy1hc3NpZ25lZCBkZXZpY2VzLiBTbywg
SSBhbSB3b25kZXJpbmcgd2hhdCBhcmUgdGhlIHByb3MgYW5kDQpjb25zIG9mIGtlZXBpbmcgdGhp
cyBiZWhhdmlvciB2cyB0aGUgbmV3IG9uZS4NCg0KVGhhbmtzLA0KVml2ZWsNCg0KPiANCj4gTGFz
emxvDQoNCg==

