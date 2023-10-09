Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 68CE27BD3D9
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:55:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpk9v-0002HS-Ho; Mon, 09 Oct 2023 02:54:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpk9s-0002Gy-UR; Mon, 09 Oct 2023 02:54:29 -0400
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qpk9q-0007tt-Vm; Mon, 09 Oct 2023 02:54:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1696834466; x=1728370466;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i706udD3LuOwRsHEC2rTACFX1LI44N9U4GH59T8/GKw=;
 b=iWQ5loVh2pQqHvvevOq3httjidE+bXua+sQT1tdC2JKfbpuWFnBxpHGE
 qiQ2kfFRSKjnVZpb/3l71HTSpUwV+XfktkIUtXV+6mijLgQJLFkxtdfeo
 21q+LtQA8O7x2NMKxmdzst3QKq05d1uEbAaNcnK/hQKUE/ZNgW8j8+j+x
 wVtUU/Z4gUec1TnBIjXw0++1KuiIVQ3twwz1LsIP7MqlwwajV8pVbA9WG
 t/UKX/TqiVXeVbfolaUfOaf94lPzn2JWeqFoy3c5Dvrq/tpxj4iM3HE/x
 kwluN5DIRs2KKKlApTjH6jCzkjRr9xyrvKhZXI6j2cYQraKfs1r465Ro7 A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="450579299"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="450579299"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2023 23:54:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10857"; a="818739429"
X-IronPort-AV: E=Sophos;i="6.03,209,1694761200"; d="scan'208";a="818739429"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 08 Oct 2023 23:54:21 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 23:54:21 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sun, 8 Oct 2023 23:54:20 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Sun, 8 Oct 2023 23:54:20 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Sun, 8 Oct 2023 23:54:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WJsKhaNUddn/2LNjfkFgUgOZYOYo7ok3W82N3KMKl2DbzN/Be1FmtlqJrD1LH4LdmQFhq+6kCoqD0pyU5pSMElnur4ub7tHV2ONTAHvNFdSDmvUXl2GSTF4wsatkoopt9vFQtsbJxEryCR8vlWToRhGoF8jsENaMBfL7EOndFRTgfOcZu9eMM6LScrEaTdyR3x8EmiVHCvy0vPDgZ4eLwbEoCMcGZutxAY1wFj3qUtjwgOwx6hkTJoi5kwaA/2l/tK5P/PWuxJpfa6BtlJBG7rjiivFaaQppw6zB5K/4kY8gwafKlJwhdTmGvrvE8JDCFJnkqCkN3SnsJAtthvbUtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i706udD3LuOwRsHEC2rTACFX1LI44N9U4GH59T8/GKw=;
 b=RWzajrLW7lr3W5UsEgB9ghdghgZ+LqhywQ2aADs8kNfuvGh8Y36RqFQAdYyVAER6J0hUr1hXOPHGmIIA+3jDHuds5UJcyOMtGiP2/eayHvtZMZCBmGrgbEBQbQAVAieCBhz1yQSWATpdTT4V18cblH5wg76zktGXwGEAOw+IFA8LnKJDHEshiasOFVoMZNIUS3Heu3Tz8wsjeY+5rHC0ueCQORb60G1c65hF4WSkM75tNPQkfd7c5f+FJNg4LLz8tVuXPzqzKLc00LHLlMKhDLqY4ms2hqF1czNasav62Xj2o8kG4Z17g2F4YW0gQm4tts8HZF9OFXNpyhK+26+GWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH7PR11MB6722.namprd11.prod.outlook.com (2603:10b6:510:1ae::15)
 by CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.39; Mon, 9 Oct
 2023 06:54:18 +0000
Received: from PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a]) by PH7PR11MB6722.namprd11.prod.outlook.com
 ([fe80::2cfd:ca55:d42a:e46a%3]) with mapi id 15.20.6863.032; Mon, 9 Oct 2023
 06:54:18 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "thuth@redhat.com" <thuth@redhat.com>, "akrowiak@linux.ibm.com"
 <akrowiak@linux.ibm.com>, "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
 "jjherne@linux.ibm.com" <jjherne@linux.ibm.com>, "farman@linux.ibm.com"
 <farman@linux.ibm.com>, "mjrosato@linux.ibm.com" <mjrosato@linux.ibm.com>,
 "borntraeger@linux.ibm.com" <borntraeger@linux.ibm.com>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>, "eric.auger@redhat.com" <eric.auger@redhat.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>,
 "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>
Subject: RE: [PATCH 0/3] vfio: memory leak fix and code cleanup
Thread-Topic: [PATCH 0/3] vfio: memory leak fix and code cleanup
Thread-Index: AQHZ+ld3s6MwE6DSrkup1DjwqB7gBLBA/9YAgAADrCA=
Date: Mon, 9 Oct 2023 06:54:18 +0000
Message-ID: <PH7PR11MB6722B05F6EE9455EE384997292CEA@PH7PR11MB6722.namprd11.prod.outlook.com>
References: <20231009022048.35475-1-zhenzhong.duan@intel.com>
 <afd76927-c523-e53a-4205-966c6082d3a2@redhat.com>
In-Reply-To: <afd76927-c523-e53a-4205-966c6082d3a2@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR11MB6722:EE_|CH0PR11MB8086:EE_
x-ms-office365-filtering-correlation-id: c6a2166d-20a8-4873-5632-08dbc8948efc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VCd3hrIJIbM7HElq52TTfgv99tZ2T6nEM4zOQJ9yFvPm8jBjiR2s5PgEYL0BXV9ffvYr00TXGhWqi68A8fGrzGj8S2njmpOsTD8Dp/aPd7xKU8JAVKmfsDSYyn/InPP9xDHIh96ZuzjnuY2KZvueglXtpCvPjBAS30NfdxuFyoTbYJqXU41Htw23JJAmvOmHRbmAxDA4xbg/0aKW4c1KRRty6jTSMJhCMp1nShaXiHxUCQGrcUYicPinAJ87C8zm7TmuVHoe/GHqh1z0FIa0s9VZTU1JcdQxS+iTjHPX7Gni+ivh8V6GhKuoZmXKmIr5iT8YMX8yvR6MQsLGptdlXQn74brnq8rFoIKs5ig0IJPgbFt6lCxN2BEnHTFNkbZzJQi3wAXCoPNvk4BWGr0LSEXRpsU6x6KTqpuM4SduQtWqFUtd1NFQdxVcANH0iUj3W1o2b1vGEjbwcnCgcOvU8KzOn7ZiW6MhwL7PZrwMd4tkXrezM9MFutxTuIrI63nub+DeeXR/xiQ5xiSQRozvRllH8M2WlA5TyNwsnf1FsYcjh9Z2Br3sTkcCLz1zNkt8vlOlPEaNpnmtBzxKY3BzB9MCVj2D8tXhfnwSR5fA5jhjSfFYNrCRnwR0HW+PWdWwNQi3RkwYWBJ9h5sK9LZ6BQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6722.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(376002)(366004)(39860400002)(396003)(346002)(230922051799003)(64100799003)(186009)(1800799009)(451199024)(71200400001)(9686003)(478600001)(7696005)(6506007)(7416002)(2906002)(4326008)(52536014)(66446008)(64756008)(8936002)(316002)(8676002)(66556008)(66476007)(66946007)(76116006)(54906003)(41300700001)(5660300002)(110136005)(38070700005)(26005)(38100700002)(33656002)(82960400001)(122000001)(86362001)(4744005)(83380400001)(55016003)(13296009);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Y2NJNUJQZEdrNXRpSWdLczdEamZKZC9DSCtNOTVVSmRVN0VMeFdaSFVnVjBE?=
 =?utf-8?B?QjUxdzBpbkRIdXVaWnRReDVDbEpBZkYzYm0wSFhNemJnRHpwTmNYSVpDMy8r?=
 =?utf-8?B?ZFlVbUVtS2VhcG5heTdib1lkUXFwN3ZJVHgyUi84N2pOZTNTcXhJb3VUM2Vr?=
 =?utf-8?B?dW5GQXBxcXpqa2twS2U0bVZRUHNtQ3U3V2QrOHJVYnhUWW0xYkZFL2N6akFZ?=
 =?utf-8?B?Y0d2c0JFV09kWC9XNHAzWW5jUGxBaE5ZSE1YbG9WR0thWW5OVmhYVm9RbU9T?=
 =?utf-8?B?Q3BRUDhxaVR2L08zUHFHM0FyS0RoUzV3T3NWTGV3eEFWUURBeDBoTWpTdzNS?=
 =?utf-8?B?dGVlQzU1anpWaFhCZjN6RmR4RWk1bmxKYWNNbE00b1h3Y054Nm5IZzRleXFp?=
 =?utf-8?B?TG9BOU5LSURzNmlRenRIYTEvdE1KZzlnbHR6Q0tsZkNwbUN6dFZKc3BZcEFj?=
 =?utf-8?B?U2d6RnRnKzI4T3FxMFp6ZWpVWmN4Y0dYNGVoTlV4Z3F1cG1idGVuUGxkYkdi?=
 =?utf-8?B?bXZnRFNPckxyWUorbDlCc3hUNDRZTkRjVVFuNzFwRkNaUVQ0c01qZGFKNjlu?=
 =?utf-8?B?WVJkNjRTaWhzTVNvYTgwK1FVN2pGalVDeFIxMkU2dzZXdm8rbE45RGtzUExF?=
 =?utf-8?B?Ri9EUW9RS2N4VUE5bmxHUUJSTkk2Z2dKWC9oclpDMzhWZ0UwdmF5b2FMMHI4?=
 =?utf-8?B?cjdYcERvUWJPSXNHd2p5QTZDMTZ5cjB0OGtRQ3FrL0NuSmZ2aGI3Vm1sOEpz?=
 =?utf-8?B?cVVBNk9qL1dhUjlxcmZNelRkM25EdFYxSm9lVmlERnlHVjZmWll4SkRDN2JU?=
 =?utf-8?B?dFlBcDNoSk9sUWFURmVWU056M1NCVXRpN0RxeVpxRnBwQStHcjI3cDB0Szhx?=
 =?utf-8?B?aGRTaVpVT0RJUlBxdUNrb3kzR0xWMUFueXEvRnhyT0xJVlE1dDRNelBmSzQ2?=
 =?utf-8?B?N1dlUWF3czNmN2lXRmlHQVdFanhFdmd0OW9mSmJ1N1JBN0tESmJTeDFUaG5s?=
 =?utf-8?B?Nk9nVEROeFZVeitsMmVuc0NYYmw4aEczOEhQZk84WTNhdURKK0kya1ZnWENi?=
 =?utf-8?B?d1hzTm9URnNDcGR5aEZKM3VnVjhDUWRQK1NUbVVKQjZ0WlE1a29DbXRyT0Jq?=
 =?utf-8?B?WWFGaXVXdU41aC9GTHpaSUZKMC9zNTBUKzdRbTVTamU0dlZBZWdlWWxrblRS?=
 =?utf-8?B?czJMTHRLRjBEVmVqT2NIOHgrY3g3UUhLOEZrLzdzeGtTTzdKWk1xYnkxdW1u?=
 =?utf-8?B?NDg3TkhoK1VyTDc5eVdITFd5UUJGNEhzclJFcXQwSkNPVE9VYjNoWURlSUtG?=
 =?utf-8?B?clpXTlArcmhkb3RYU1cxVmo0TEIrL3dldFozUXFHTGppZU1lL05vUGhMb21k?=
 =?utf-8?B?YnVHT0FFNzlDMUx4Z1o0Z29nVkNFMTJtWmg3MkdFUlBjeCtKdFRYUnFmYVFQ?=
 =?utf-8?B?TTVabW9hTzcyaHdLMU9XRHJHMXk1T2w5T0VueFl6eWEzRXlFMW1EdURWS3dz?=
 =?utf-8?B?azZaZXhyUjhPMTIvNlJUNUJtUnYrWE9yTFZsVi9YbEpQcGFLNll1RDEyMG1i?=
 =?utf-8?B?R0VUNDVndDNkVnF2SGl5OVZzbVdRaTE2dGZoK1NHY21KZ3d5M1d5ODl3MnhU?=
 =?utf-8?B?RlBxSG5rbkpLWmZ0VGwzOFJCUDVHK0JUQlFWUk9SNFFKUVNsanYzaTlaMll3?=
 =?utf-8?B?Wnh6T0F0eUJ6c3p4MjlOMVhJYmJkVmtvTkl5TVJaZGlaVmJHMjZ4aWpHeVNC?=
 =?utf-8?B?VnRhbGtqR1BSaytLTWdUdGNsSXhBYm5PaDllQ2lIeE5jeWwxSzlpaU5yekN5?=
 =?utf-8?B?UUxpV012cWZ4aitPeTNSNUVGZjA3dG5HYno1VVdCei9Edy9Fd3NJNWpYMEov?=
 =?utf-8?B?RVltTlJ1S0NmaExhN1NlNjhTRWhNM21TOVMyQW5aVnN0cm5hWGVnTDlzVllB?=
 =?utf-8?B?S3dZakUwUTZBbDY1SkhuQWxXZGRFUXRybnVaNWpweEYzcHJsUGhxVkwxWnZ4?=
 =?utf-8?B?blUvWFRvU0pVd3MvcFVudUV1eitRUEhjUzNmV2k3bnQ1cXhVWXZDS3Rjb2ZE?=
 =?utf-8?B?QUw5UCtIcmhlZVYvZExFRDBWSmFBN2NzVmhQMHBENzF1cll6a3h5Z3plTXdj?=
 =?utf-8?Q?bDiEsy/rmy+0S2oVqmx8ofhoK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6722.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a2166d-20a8-4873-5632-08dbc8948efc
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2023 06:54:18.2563 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m0owQ9dIp0CYhb4mPJp68rl0MalkImzJu5jl13tm3A4Ppzk4OYq2kDMo0BqPdFX/rV1KYOGJiSKH4xiBR8g6S197NYYRIQ2hxeYzHcks9H4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8086
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBNb25kYXksIE9jdG9iZXIgOSwgMjAyMyAyOjMyIFBN
DQo+U3ViamVjdDogUmU6IFtQQVRDSCAwLzNdIHZmaW86IG1lbW9yeSBsZWFrIGZpeCBhbmQgY29k
ZSBjbGVhbnVwDQo+DQo+T24gMTAvOS8yMyAwNDoyMCwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+
PiBIaSwNCj4+DQo+PiBUaGlzIHRyaXZpYWwgcGF0Y2hzZXQgZml4ZXMgYSBpbmNyZW1lbnRhbCBt
ZW1vcnkgbGVhayBpbiByYXJlIGNhc2UsDQo+PiBhbmQgc29tZSBjbGVhbnVwIG9uIGFwL2Njdy4N
Cj4+DQo+PiBUaGlzIHBhdGNoc2V0IGlzIGJhc2VkIG9uIHZmaW8tbmV4dC4NCj4NCj5XaWxsIHRo
aXMgYXBwbHkgb24gdGhlIGZ1dHVyZSB2NSBvZiBFcmljID8NCg0KSSB0aGluayBzbywgdGhvdWdo
IHRoaXMgcGF0Y2hzZXQgaXMgYXBwbGllZCBvbiB2NCBvZiBFcmljLiBMZXQgbWUga25vdyBpZg0K
eW91IHdhbnQgYSBuZXcgdmVyc2lvbiB3aXRob3V0IGJhc2luZyBvbiB0aGUgcHJlcmVxdWlzaXRl
IHBhdGNoc2V0LA0KaXTigJlzIGVhc3kgdG8gcmViYXNlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

