Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 31C3D7CD0FE
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 01:46:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qstjy-0002Ly-UI; Tue, 17 Oct 2023 19:44:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qstjx-0002Lo-1M
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 19:44:45 -0400
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1qstju-0001py-3v
 for qemu-devel@nongnu.org; Tue, 17 Oct 2023 19:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1697586282; x=1729122282;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZbqVe/UY8dWMFCPjH1r5KLDknWDAF/IyWkZHRKu+kv4=;
 b=KYoo/jxhjJY7nGP4m8hT82fhRoZ+iCfAnCSxCL6oEdT8F0lu/THhsZ9n
 ONfOqa80Wa9KnBT6xN2IAhG412Umhgr41rm+vDQwD6XbpWpQ6uDH4qxlS
 6P9ECsTBBNyCHYNe5WLxQlcr6Dc/E4/OElTII+evA9aeApAi/ZLmAVcNR
 4ASaxDsalOhiwUfpG2iLm5bLXekYmfhrfq0XQXu7fVCYGwiCVd+wsBcHu
 0ooVqDnXVEBDXIjG/RQfFl0VspiXIrKp+3gAjT8cdCjaU9oZymSoP7IkB
 cy2s/ANlQRr2QdhTnTQtDiGjV7aeoQapwmAuVGwMnB/EZPOXzjp2R7Yv0 g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="365251791"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; d="scan'208";a="365251791"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Oct 2023 16:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="706213342"
X-IronPort-AV: E=Sophos;i="6.03,233,1694761200"; d="scan'208";a="706213342"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 17 Oct 2023 16:44:37 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 17 Oct 2023 16:44:37 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 17 Oct 2023 16:44:37 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 17 Oct 2023 16:44:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j0p14JeCbu9FoQDrOpzjtY9npvBJK7Gcu3pj34Jw34GQxrKkqFMoRDx609phpFlnEkDfTH4g0bgWlkdF8iJyoLIibPl3kgMQVTB1RY2MwBwJTM65ZE2QDy62ShVbRbWQ8jSDePUSTqhqYrUIdFhjsR8m3y7vGqofJZs3uuET+OcGV73kLm/PyUvKNC4SwMZHPjPPjrF9nw+ArN4/5TsUrX/lqP4MT+h8PoFz+nP+T89Jz4A57pNukEmrdubQFTmVQ3LCVHwPZdbHXfUFiL0kkStw85LEGXvel/shtqD3zx+sohZ+wacULh0oyIablVeKW97xSFjAIEbzlaThz8sT0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZbqVe/UY8dWMFCPjH1r5KLDknWDAF/IyWkZHRKu+kv4=;
 b=CaQfUcA7PWVQXlQpizvVQzgBRZnNLulrcQV7iTwXAAfB0clTiR9juDqvHErhgW2zZop3owzgDAC6uGuOeYQbHPeorWxyTaUsCH/8ml/fsl6hS2Bt34/+f3CCKXB0Fn+A/5PnuSmLO/30fzXPUYAFA7aCrBuMdDhT68hEJ1QfFcD7axtCC9Vm+Qaugcqo9IwpTXZaPjadDyBei7rZ8cxCGu5xGYDEJuFVLLYVBrqqkOl3PqGWgQirABNkWodEwskCRoyYarbreFZ8O+t1pXbOHpi+YuhJfzt9Nl7QZk4nx4i9T4eZlWxQ91f75iPB6xZrlfJkXXpY5GCPCC7914URxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by DM4PR11MB6406.namprd11.prod.outlook.com (2603:10b6:8:8b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6886.36; Tue, 17 Oct
 2023 23:44:29 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b75a:da38:e6e1:89c]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::b75a:da38:e6e1:89c%5]) with mapi id 15.20.6886.034; Tue, 17 Oct 2023
 23:44:29 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH] ui/gtk: full-screening all detached windows
Thread-Topic: [PATCH] ui/gtk: full-screening all detached windows
Thread-Index: AQHZ/V6cyAhOPkzbb0WtKP3BOpX247BMX1qAgAJKpYA=
Date: Tue, 17 Oct 2023 23:44:28 +0000
Message-ID: <PH8PR11MB6879025B167EF9219023D91EFAD6A@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20231012222438.13853-1-dongwon.kim@intel.com>
 <CAMxuvawxX8+o-dm3rNFHo-OtA-aMJfLFoaub299Zs-khzDLgxA@mail.gmail.com>
In-Reply-To: <CAMxuvawxX8+o-dm3rNFHo-OtA-aMJfLFoaub299Zs-khzDLgxA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|DM4PR11MB6406:EE_
x-ms-office365-filtering-correlation-id: 3f04a9e3-7858-4f95-692a-08dbcf6b00d2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mguI/9UEB9jjwC07Fdb3svK4Kl/vcul0AxabQNwX0suio1oTbv1Ziu/WcCPh4lh0Wmjpjqh/TXlNd5ywRCjGogL/M7+JK/9WZ4CkJ7Zspeiwit5df1Jql40Br8R3J7RiPkd5OxGNxiJNM80HUdICkfhD18+xI0YpyWYv2Jt7IARxSbqo0SR/e2PkrZNH0haeUz+uVtEJq2oHJD8dARvm10awqPIfy9QxTf8uMvpSVOeZsOkdY1hiqqy9gE0z9RI49t6TBMP+woyt9SzTnkjNoG0gWfgUOrFyO/q1kk5hb4e5TnYOXHD/lc9Fnn3JTHkcz52uGY928/y5Rei+I/IAnEjQV7ruvcYjVdkXjTE8gRzvr1CHZBNx74Xg1nYGsAsudLr78WOPo6jAFmtAh/xi03guhp/j6DgkvJfcdnosvp26e3T2YdkfSVRcbbL5cmouv/U/IkzEgf28aLvdxOqvvxLTdF4bBeR5ySHtOPAzX1pMTgMmkLWqq9rlFetJz1qL+6LMPO8Oeofwmf+jDJWntRqENtc6ndY3YBLPPg+erN9AXIh/RTbj6qwpdxugu9zwxVPmltNZKhS5YSdf8skZfXjJxHBi8HBVGk9RYfn9GgCNweJ3CYBjvUaPnKcXRvbv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(136003)(346002)(39860400002)(366004)(396003)(230922051799003)(451199024)(186009)(1800799009)(64100799003)(55016003)(26005)(6506007)(7696005)(71200400001)(8936002)(76116006)(53546011)(83380400001)(41300700001)(52536014)(5660300002)(4326008)(2906002)(8676002)(478600001)(316002)(66476007)(66446008)(66556008)(6916009)(64756008)(66946007)(122000001)(38070700005)(82960400001)(86362001)(38100700002)(33656002)(9686003)(66899024);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnJuWWVXTDU3UzVYUDFFWFg0UStYaUZObjdTZlo2NFhSdEpYdjhUdXEwT0ho?=
 =?utf-8?B?aGxRRHpjdW9qWE1jeE1PV3p4d3kwUFNSYzRTU0pacUhnenVydVhjbDdYWDhO?=
 =?utf-8?B?d2RKeEswSmRNZE1tQU9GMVExWlRnelRuemFwZlhoRU1JVExCanZkaVdtRzBr?=
 =?utf-8?B?WlJHUFUwSnBXSlZQNnNQbml0NmJocjlsbjR6SENUMHBvWTlEKzFpZ2ozS0tV?=
 =?utf-8?B?YndDMmx3d1lBeEcwWkJBNVJHcCtJREpsMVEyV2RydHV5V1JsY3FaWnBJT3JU?=
 =?utf-8?B?WkZwK21HL21PbSt2YkMxMXd2eWFSamN6ZE1vay9zVU1PYzBnZ2o0TVZURXhJ?=
 =?utf-8?B?ekJRRU04RzdPT0VXUDJKU0dTQWFZYXdHcFQvU3BveDhLVHVJSnFnUjRlMVJI?=
 =?utf-8?B?SWVVanI1V2JYQ3dqcVhwNkp6MGJMVW5kTnFRVDVOYnE2dkV2M1Era2RYeHlP?=
 =?utf-8?B?MGFsVXRkUmNONC9KaDFJVVZodnFQY1lDNk01YlhQUWhJalN6bG5EbWJQZFcy?=
 =?utf-8?B?bVlLbzJTblE0K3E4YWhiMUQvVTh0SmFuZnpzMG8rdGN6bWNyaStaeXduYmFI?=
 =?utf-8?B?ckNtcHpqVWJRMndwNFc4S09LS256SWFlWlc2WUJHTVNYSEx1ZS9rNlNlNHhp?=
 =?utf-8?B?MzhSaVVpY3RhUE56d1gwbDl1aERwVmMraE9xaE1lc1VDMnhuNy9oaW1pcUtU?=
 =?utf-8?B?ZzNrU21iRFFSMmJHcFFZclVRWnBIMHF6SFgwZVVEM0Q1aWMwSFVYbjU2UjE3?=
 =?utf-8?B?dTRhbE1hWFlhWGhlVWw3VmFucCtGVThDZG1ZcTc1VzlUWEdYRENCeHloQ3FH?=
 =?utf-8?B?VHpUK1RmQlVxcUowWU02MXQwdWRReDJrZEFQbHpUNzRrby91SzR5SHZiaSth?=
 =?utf-8?B?cVIyQy94K0IrYW1EK2M4UkFQMWUvNmdpRDJSc0J4Wkp2SUVIUzBuNkh6dVZH?=
 =?utf-8?B?UVBsVUgwTFZKZjUzQndpNk01SjlwbXRxN0xlRkFBRmtuNlpEdWs1K3QrWFhy?=
 =?utf-8?B?akZmMEorNjhmaS9CSjBuekdneEFaU0NnUjRPVjRRZFpIVmVJRmNsTW1zcjhK?=
 =?utf-8?B?cXRZdVoyOEZlWWdTQlVaaHJQNkhOdVZyaVZCVTNiMHBRVThZL29ZRjlWSW1l?=
 =?utf-8?B?R04zR2NFbUQ4Q3FHa2dUeUtrMTBySzFJZ05xUVlyWmRkL0R2U0R0UTR4SnJk?=
 =?utf-8?B?MUxSZy8xMGlHV3Z4aVBDWXdJM1lCdlBRbkNBODcvNitXZWNzN21oNFBiTThQ?=
 =?utf-8?B?YVR6Um54clBtU2c3VVBOZTNhYXovWG43OXkramhiaTVxUFF0aUlnRVlhQTQ1?=
 =?utf-8?B?aXc2Mmd3a2g4ZWJvS09KaHNBWTRZUVFSOXZhcDR5SUZaUFh2Nnl4NGdPa3NM?=
 =?utf-8?B?UnRib0x6Rk1jVkpPbzZkTEhhMDM3aC9lSXNac3pjM09iUWVueGtuN0Vlejcr?=
 =?utf-8?B?ZEZwN1ExZE1YMk5uQVViRnJoMlJBVlFkaUtJcUNrZFVOQXVrQklDYXVuN3Jh?=
 =?utf-8?B?eHIxOGxKbWhsUnU2YlhQeC9OS3FXbHUwWU1JMjVwTW1YZVllQ0RkWmpiN242?=
 =?utf-8?B?NCtlYm8vZUFMZGg3K2ZiY0JWWW93REllaUN1T0preHAwVm95ajlkeHl2TjZ3?=
 =?utf-8?B?UVdKWENlREVRSHYzSEZiY3E4dW1aTVU0VHBHY1MyQWdHL0Zwdy8vbGRkb2hC?=
 =?utf-8?B?TFArVnJhQmQ1WnRHa1FtYmpVUjJ3TUFGY1I1MXhWM2NseS9MU1FJK2hLK1d6?=
 =?utf-8?B?SXRWMlRMeWFNZU5Rak9xZDd6Y3dGcUp0dmtwWVg1am5WTU5ZZ0RJUG1oS0JE?=
 =?utf-8?B?eXAvd0JxNlpyMDJ4VUFPcEk2aGZWZUVjZXk5Q2FuazMwL3dUUlE1eU1Ma293?=
 =?utf-8?B?ZUtGcXNqd0NYcG9sVVdENUNGWlhtcGw2K2Q3eHZDNkpPL3lCSURDSHUxWlNz?=
 =?utf-8?B?ektORUo0ZldyczVtekxKSlk0V01id2JZNUMyOGV1RFVIZWY4TTNOdmtHSDJH?=
 =?utf-8?B?MzBXOVp5NXBJL1NuT0VDRENsaE1HVml4VVlzMmVKQmJxRmxJMmduQUQxMkVD?=
 =?utf-8?B?T1FvUEo1Uk0yeG5rRDljNTVxWHNpRFVaZ013ZUVQQlFHNk9VOXlWbW9wWHht?=
 =?utf-8?Q?pAxMjQiYNZkWlrnQqZHfzZQ0j?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f04a9e3-7858-4f95-692a-08dbcf6b00d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2023 23:44:28.5100 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NwsZX/iQ+dkOujWCcTPnJ3P+2vyLSfihiq9sZEnHAZdhWXEEC96M70hN0eivIDUhtbwk7Hp4UvskdVzkDcNfrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6406
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136; envelope-from=dongwon.kim@intel.com;
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

SGkgTWFyYy1BbmRyw6ksDQoNCj4gSGkNCj4gDQo+IE9uIEZyaSwgT2N0IDEzLCAyMDIzIGF0IDI6
NTHigK9BTSBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiB3cm90ZToNCj4g
Pg0KPiA+IFdoZW4gdHVybmluZyBvbiBvciBvZmYgZnVsbC1zY3JlZW4gbWVudSwgYWxsIGRldGFj
aGVkIHdpbmRvd3Mgc2hvdWxkDQo+ID4gYmUgZnVsbC1zY3JlZW5lZCBvciB1bi1mdWxsLXNjcmVl
bmVkIGFsdG9nZXRoZXIuDQo+IA0KPiBJIGFtIG5vdCBjb252aW5jZWQgdGhpcyBpcyBkZXNpcmFi
bGUuIE5vdCBvbmx5IGhhdmluZyBtdWx0aXBsZSBmdWxsc2NyZWVuIHdpbmRvd3MNCj4gb24gdGhl
IHNhbWUgc2NyZWVuIGlzIHVzdWFsbHkgYSBiaXQgaGFyZGVyIHRvIGRlYWwgd2l0aC4gWW91IHR5
cGljYWxseSB3YW50IG9uZQ0KPiBpbWhvLg0KPiANCj4gQnV0IHRoZSBtb3N0IGFubm95aW5nIHRo
aW5nIGlzIHByb2JhYmx5IHRoYXQgZGV0YWNoZWQgd2luZG93cy9jb25zb2xlcyBkbyBub3QNCj4g
aGF2ZSB0aGUgc2FtZSBzaG9ydGN1dHMgYXMgdGhlIG1haW4gd2luZG93LCBhbmQgeW91IGNhbid0
IHVuZnVsbHNjcmVlbiB0aGVtDQo+IHRoZW4uLi4NCj4gDQo+IFdvdWxkbid0IHlvdSBwcmVmZXIg
dG8gaGF2ZSBhIHdvcmtpbmcgZnVsbHNjcmVlbiBrZXlib2FyZCBzaG9ydGN1dCBmb3INCj4gZGV0
YWNoZWQgdGFicyBpbnN0ZWFkPyBUaGlzIHdheSwgZWFjaCB3aW5kb3cgY2FuIGJlIHRvZ2dsZWQg
ZnVsbC91bmZ1bGwNCj4gaW5kaXZpZHVhbGx5Lg0KDQpbRFddIFRoYXQgaXMgcmlnaHQuIFR3byBk
ZXRhY2hlZCB3aW5kb3dzIG9uIHRoZSBzYW1lIGRpc3BsYXkgd291bGQgYmUgb3ZlcmxhcHBlZCwg
d2hpY2ggd2lsbCBiZSB1Z2x5LiBJIGFsc28gdGhvdWdodCBhYm91dCB0aGF0IGFzIHdlbGwgYXMg
b3RoZXIgdW5kZXNpcmFibGUgc2l0dWF0aW9ucyBidXQgbXkgaW5pdGlhbCB0aG91Z2h0IHdhcyB0
aGUgZnVsbC1zY3JlZW4NCm1lbnUgaXMgZ2xvYmFsIGFuZCBhbGwgUUVNVSB3aW5kb3dzIHNob3Vs
ZCBiZSBjb250cm9sbGVkIGJ5IGl0LiBBbnlob3csIEkgbGlrZSB5b3VyIGlkZWEgYWJvdXQgaW5k
aXZpZHVhbCBjb250cm9sLi4gc28gd2Ugd291bGQgcHJvYmFibHkgbmVlZCB0byBhZGQgbW9yZSBm
dWxsLXNjcmVlbiBtZW51cywgbGlrZSAnZnVsbHNjcmVlbjEsIGZ1bGxzY3JlZW4yLCBmdWxsc2Ny
ZWVuMy4uLiINCnRvIHRoZSBtZW51IHRoZW4gYWxzbyBhc3NpZ24gYSBob3RrZXkgdG8gZWFjaCBv
bmUgb2YgdGhlbT8gDQoNCj4gDQo+IHRoYW5rcw0KPiANCj4gPg0KPiA+IENjOiBNYXJjLUFuZHLD
qSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVkaGF0LmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5
OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICB1aS9n
dGsuYyB8IDQ0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCAzNCBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS91aS9ndGsuYyBiL3VpL2d0ay5jDQo+ID4gaW5kZXggOTM1ZGUx
MjA5Yi4uM2EzODBmOGQ1OSAxMDA2NDQNCj4gPiAtLS0gYS91aS9ndGsuYw0KPiA+ICsrKyBiL3Vp
L2d0ay5jDQo+ID4gQEAgLTE0NTIsMjkgKzE0NTIsNTMgQEAgc3RhdGljIHZvaWQgZ2RfYWNjZWxf
c2hvd19tZW51YmFyKHZvaWQNCj4gPiAqb3BhcXVlKSAgc3RhdGljIHZvaWQgZ2RfbWVudV9mdWxs
X3NjcmVlbihHdGtNZW51SXRlbSAqaXRlbSwgdm9pZA0KPiA+ICpvcGFxdWUpICB7DQo+ID4gICAg
ICBHdGtEaXNwbGF5U3RhdGUgKnMgPSBvcGFxdWU7DQo+ID4gLSAgICBWaXJ0dWFsQ29uc29sZSAq
dmMgPSBnZF92Y19maW5kX2N1cnJlbnQocyk7DQo+ID4gKyAgICBWaXJ0dWFsQ29uc29sZSAqdmM7
DQo+ID4gKyAgICBpbnQgaTsNCj4gPg0KPiA+ICAgICAgaWYgKCFzLT5mdWxsX3NjcmVlbikgew0K
PiA+ICAgICAgICAgIGd0a19ub3RlYm9va19zZXRfc2hvd190YWJzKEdUS19OT1RFQk9PSyhzLT5u
b3RlYm9vayksIEZBTFNFKTsNCj4gPiAgICAgICAgICBndGtfd2lkZ2V0X2hpZGUocy0+bWVudV9i
YXIpOw0KPiA+IC0gICAgICAgIGlmICh2Yy0+dHlwZSA9PSBHRF9WQ19HRlgpIHsNCj4gPiAtICAg
ICAgICAgICAgZ3RrX3dpZGdldF9zZXRfc2l6ZV9yZXF1ZXN0KHZjLT5nZnguZHJhd2luZ19hcmVh
LCAtMSwgLTEpOw0KPiA+IC0gICAgICAgIH0NCj4gPiAtICAgICAgICBndGtfd2luZG93X2Z1bGxz
Y3JlZW4oR1RLX1dJTkRPVyhzLT53aW5kb3cpKTsNCj4gPiAgICAgICAgICBzLT5mdWxsX3NjcmVl
biA9IFRSVUU7DQo+ID4gKyAgICAgICAgZ3RrX3dpbmRvd19mdWxsc2NyZWVuKEdUS19XSU5ET1co
cy0+d2luZG93KSk7DQo+ID4gKw0KPiA+ICsgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzLT5uYl92
Y3M7IGkrKykgew0KPiA+ICsgICAgICAgICAgICB2YyA9ICZzLT52Y1tpXTsNCj4gPiArICAgICAg
ICAgICAgaWYgKCF2Yy0+d2luZG93KSB7DQo+ID4gKyAgICAgICAgICAgICAgICBjb250aW51ZTsN
Cj4gPiArICAgICAgICAgICAgfQ0KPiA+ICsgICAgICAgICAgICBpZiAodmMtPnR5cGUgPT0gR0Rf
VkNfR0ZYKSB7DQo+ID4gKyAgICAgICAgICAgICAgICBndGtfd2lkZ2V0X3NldF9zaXplX3JlcXVl
c3QodmMtPmdmeC5kcmF3aW5nX2FyZWEsIC0xLCAtMSk7DQo+ID4gKyAgICAgICAgICAgIH0NCj4g
PiArICAgICAgICAgICAgZ3RrX3dpbmRvd19mdWxsc2NyZWVuKEdUS19XSU5ET1codmMtPndpbmRv
dykpOw0KPiA+ICsgICAgICAgIH0NCj4gPiAgICAgIH0gZWxzZSB7DQo+ID4gICAgICAgICAgZ3Rr
X3dpbmRvd191bmZ1bGxzY3JlZW4oR1RLX1dJTkRPVyhzLT53aW5kb3cpKTsNCj4gPiArDQo+ID4g
KyAgICAgICAgZm9yIChpID0gMDsgaSA8IHMtPm5iX3ZjczsgaSsrKSB7DQo+ID4gKyAgICAgICAg
ICAgIHZjID0gJnMtPnZjW2ldOw0KPiA+ICsgICAgICAgICAgICBpZiAoIXZjLT53aW5kb3cpIHsN
Cj4gPiArICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4g
KyAgICAgICAgICAgIGd0a193aW5kb3dfdW5mdWxsc2NyZWVuKEdUS19XSU5ET1codmMtPndpbmRv
dykpOw0KPiA+ICsNCj4gPiArICAgICAgICAgICAgaWYgKHZjLT50eXBlID09IEdEX1ZDX0dGWCkg
ew0KPiA+ICsgICAgICAgICAgICAgICAgdmMtPmdmeC5zY2FsZV94ID0gMS4wOw0KPiA+ICsgICAg
ICAgICAgICAgICAgdmMtPmdmeC5zY2FsZV95ID0gMS4wOw0KPiA+ICsgICAgICAgICAgICAgICAg
Z2RfdXBkYXRlX3dpbmRvd3NpemUodmMpOw0KPiA+ICsgICAgICAgICAgICB9DQo+ID4gKyAgICAg
ICAgfQ0KPiA+ICsNCj4gPiAgICAgICAgICBnZF9tZW51X3Nob3dfdGFicyhHVEtfTUVOVV9JVEVN
KHMtPnNob3dfdGFic19pdGVtKSwgcyk7DQo+ID4gICAgICAgICAgaWYgKGd0a19jaGVja19tZW51
X2l0ZW1fZ2V0X2FjdGl2ZSgNCj4gPiAgICAgICAgICAgICAgICAgICAgICBHVEtfQ0hFQ0tfTUVO
VV9JVEVNKHMtPnNob3dfbWVudWJhcl9pdGVtKSkpIHsNCj4gPiAgICAgICAgICAgICAgZ3RrX3dp
ZGdldF9zaG93KHMtPm1lbnVfYmFyKTsNCj4gPiAgICAgICAgICB9DQo+ID4gICAgICAgICAgcy0+
ZnVsbF9zY3JlZW4gPSBGQUxTRTsNCj4gPiAtICAgICAgICBpZiAodmMtPnR5cGUgPT0gR0RfVkNf
R0ZYKSB7DQo+ID4gLSAgICAgICAgICAgIHZjLT5nZnguc2NhbGVfeCA9IDEuMDsNCj4gPiAtICAg
ICAgICAgICAgdmMtPmdmeC5zY2FsZV95ID0gMS4wOw0KPiA+IC0gICAgICAgICAgICBnZF91cGRh
dGVfd2luZG93c2l6ZSh2Yyk7DQo+ID4gLSAgICAgICAgfQ0KPiA+ICsgICAgfQ0KPiA+ICsNCj4g
PiArICAgIHZjID0gZ2RfdmNfZmluZF9jdXJyZW50KHMpOw0KPiA+ICsgICAgaWYgKCF2Yykgew0K
PiA+ICsgICAgICAgIHJldHVybjsNCj4gPiAgICAgIH0NCj4gPg0KPiA+ICAgICAgZ2RfdXBkYXRl
X2N1cnNvcih2Yyk7DQo+ID4gLS0NCj4gPiAyLjIwLjENCj4gPg0KDQo=

