Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D429A820132
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 20:24:28 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJIRh-0005AI-F4; Fri, 29 Dec 2023 14:23:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rJIRc-00059q-T2
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 14:22:57 -0500
Received: from mgamail.intel.com ([134.134.136.100])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dongwon.kim@intel.com>)
 id 1rJIRa-0001BY-79
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 14:22:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703877774; x=1735413774;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=a6SQmRepVER/90r8GL74iwjjuIDSm2cCrIB1Thn94qw=;
 b=WtbUstNd04YOjxUp+18nxgI2JHjeK7D7DziykjeuOYwJWgyQSS3nhwHJ
 yFX2P3vKDN3xvxZcjaLHJ+nStPKr52NSpf3x9gEOYzX+MhTZQo5PhqkxN
 iaBF0vqdU3uXyShBfms+e6GOf6f6jqNqG7fHFOe5xqn/sEn8i1Kt/zShy
 YGxFdggJMOOnYI0875q7iEAJqZsPq1Vk9UJrGvxSGnZJyqUEUW1hmDXfB
 lC4v79IU6V4agnHifEn5ubcHYufpdwaG6d5zpXOKl+T1ZumumV/cUwv3u
 GERx61A0wJntPVhlbQQUHh6j3Qcv9kzs6CzUti3NDV7cvkxE08dpYr4UC w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10938"; a="463082731"
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; d="scan'208";a="463082731"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Dec 2023 11:22:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,315,1695711600"; d="scan'208";a="27220950"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 29 Dec 2023 11:22:35 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 29 Dec 2023 11:22:34 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 29 Dec 2023 11:22:34 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 29 Dec 2023 11:22:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HNPjHwBpHzSDCa7iqFC0U5Mbyu1T5AEkRwYsEGOr+VeuUNtF17Th64ilDGxK+fxfqxG02teNTzEbd4NRXvakUqtU6YYmuhdEavqnqsKPmJEx+CzD5yDAFuiB562wZGIx93BmUnntgRG9RUH52JZ23neuPz6V6wR0Tta9tXEX1mE1YztNesd8TtRFbRXyFLtOw5LaqRoKhTKORs6Ao1LRi4uTOBUPGHAyRHIlRrRXPjHdQNWeCRVYqAJAws4AS70jbjPybc1baf91Pjlso2+m4lQltTRKmHIWOmw2yJdVlrjVWlSahOct7agTSKPbLWwKtR4R4/PzLtMwMJJqDOjEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6SQmRepVER/90r8GL74iwjjuIDSm2cCrIB1Thn94qw=;
 b=hnK3OoJNONtZJ4F1IfZWXTqqyfySy8PS24zo37a8yYYATEmiFDZoUNls12zYk9KwSeuf4Wx4PHFecMP4Gx1zHzpEasyyE5fwd8f2izc4MrUppGBLjpkCdsG1d3wj7bpLmDUblvsVtzSAtszmgeoRzb9ukihP7iLsdsDE2BPsZy7tRTvGrhQpBdqaUkCBhCxBO4bYQA3I8nOqA9GadviZ6crVXk1bCDRrrT3YboHYtaV8P7nfhC/XU4c6Etq34d2MNnTW+MgDxjK7fw3mnKlDiXclBFFsOP8YvLGJkL3xhv+YqoNqt2heTjtq/2P9wmYjdrs0i6uTdfcZaHohXE6DQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from PH8PR11MB6879.namprd11.prod.outlook.com (2603:10b6:510:229::22)
 by CY8PR11MB6841.namprd11.prod.outlook.com (2603:10b6:930:62::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7135.20; Fri, 29 Dec
 2023 19:22:32 +0000
Received: from PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d]) by PH8PR11MB6879.namprd11.prod.outlook.com
 ([fe80::1332:70db:38b7:437d%7]) with mapi id 15.20.7135.019; Fri, 29 Dec 2023
 19:22:32 +0000
From: "Kim, Dongwon" <dongwon.kim@intel.com>
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH 1/3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Topic: [PATCH 1/3] ui/gtk: flush display pipeline before saving vmstate
 when blob=true
Thread-Index: AQHaLkWB0YzUR1vdqkulBpJjBWhQX7CqBjmAgBXulACAAMURIA==
Date: Fri, 29 Dec 2023 19:22:31 +0000
Message-ID: <PH8PR11MB68795103944450A3179260ABFA9DA@PH8PR11MB6879.namprd11.prod.outlook.com>
References: <20231204184051.16873-1-dongwon.kim@intel.com>
 <20231213202419.15459-1-dongwon.kim@intel.com>
 <CAJ+F1C+-v7ZG5fFxrbcSEVOSrFEYx6dYYV02FraCOvfcG9sC+w@mail.gmail.com>
 <IA0PR11MB71853BBB32D75EFF40F51B70F89DA@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB71853BBB32D75EFF40F51B70F89DA@IA0PR11MB7185.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB6879:EE_|CY8PR11MB6841:EE_
x-ms-office365-filtering-correlation-id: 8343e2f9-6142-42f6-ef79-08dc08a38133
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WgWUx53KndbxC8T8OFuCoG5bJHguSasqndNDL1m4+juYNhdGCA3XviuEEoaBSbEpQBRabWils49qk8lMjf1CWv52p034ytBohoBNwbP3uHLCIgFaczbbdGPgRb5nStC9NfKiorE2zCekDAn/WB8q0OfeyDzZ2HJGB2kAYtAEG7RcAqqDsbAVGjJa8ak88IO6o41fhS4aLOAfkMlLCJhciVSiqAPbZEZlcKgvt2Ie8Rqs0cR5FIqpmyqWypMeSL7gAIB2QZldqElOj4kh7wDLU2lDX4W4wAplR9RnvK4b67a15yaKRG0U6xoGAZjmnts81jrfNZ1EFIBV2YCeCXb3Rkt/A9SOyri7j1k5QmeCFYNAsZnyFdOd+D+oezc1QTnK7blFjPIKDaPHQ0nZLvqpv+B0lq2n6P+SWmQ9fxArKbGSlRSopHaH+IfLfm5o1PU/Yn2szm4xN0y+81HAd9kLztNO+FENa19JrucHj7R1Ts4UqduFYAeCrVnr8AsTppzhuU4uROQ/SlficlrH+5ob0X+NxN72iyFlbRXxkILNI6yHc8gtRMNJ7lxA2VaWzocd6bxnFYHPBAUGAsR972bwZFMIHssh9hOlT1haykNGHcB8vLYL4WSgM8F+IYo9m1PE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB6879.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(39860400002)(396003)(376002)(136003)(346002)(230922051799003)(186009)(451199024)(1800799012)(64100799003)(38070700009)(478600001)(5660300002)(83380400001)(26005)(8676002)(8936002)(38100700002)(122000001)(53546011)(86362001)(66446008)(64756008)(66556008)(76116006)(4326008)(52536014)(66946007)(66476007)(7696005)(9686003)(41300700001)(316002)(2906002)(110136005)(6506007)(55016003)(71200400001)(82960400001)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UGcrampTWDY3c0x6Z3pDZlpDckdQMGVFdDBSdU13UXFES1RrOHpyeEpLU2Zl?=
 =?utf-8?B?MkZVYWZSdzZzeDdNRlZ0aUZuVnFrT2cxcnBoWjRKb0h0T3Z2U2ZWdVpoRnFv?=
 =?utf-8?B?WjJuTE0rbSt0WC80a3liU29HZ25lM3JJc3RFSFhrY3RPeEtzTThOQlY4bkRR?=
 =?utf-8?B?dHQrRlI1dFZXUXFuS25pWHM3aHArTlVTc29ZTDBESmlBbXBhY1dXZ3FrQ2o1?=
 =?utf-8?B?eHhzK3RXRnBJOWJmeE5XMitZMnNLTzlGVmJsRGk4NFp2a2M0TGFRNnlYdHRa?=
 =?utf-8?B?c3dRR2wyQjlJd2IvSlV0U3JRVnpYTmdKVXluOUZTWmVIRzhqUDVEa0tFejRG?=
 =?utf-8?B?UE9WN0ZZYVY4M0pNdTk1VmE2ZXZmY0FrU3Eyc3BDYktpR2NCY2x0L3JrUjVP?=
 =?utf-8?B?UGVvNlFJQURrdDJuNU1VTng1eUt5R1hsN1hvS3ozTXpCOVkyUVgxTHVLYXI3?=
 =?utf-8?B?NEhERWVCbGFzSGZnVFdvZytpcWlhNzVRVnA4Tkd1MVc5aWFWTVRra1VYRW9h?=
 =?utf-8?B?TjM2c3h1MVNJYVNleFBhT2VDbDY3OGNXZXpZb2MxVmNSNkRuMEpVL1Y5eGdy?=
 =?utf-8?B?ZTFQc1pHQy9KRnVWMlJ0Uzg4VG1yNmNGNXFlbG1BUjdjNE5yVkFFRDFoSTZT?=
 =?utf-8?B?T2N5MnY4OEVweUdrU0NuMkx3VHJ4cHcyNVFnN0lGdWZpNGcvUHVtQzllNVpk?=
 =?utf-8?B?c3FkMlhrQzNQbGhGa3UzZzhURG4xNDZJZ3R3Z0tZL3FXYm1sbU11bnRHZW1x?=
 =?utf-8?B?Lzc3dHNkZGVhU3BxbzNtZHZ5QWFIclNGTDE3UnBWME5UQzFkdjZGMHF2aFFm?=
 =?utf-8?B?aDV6UEdzWDdxN20raXFjbzdOcmpPbitCQ216V0Rab2lYRGlHQlU5b2hTMnp0?=
 =?utf-8?B?ckVxbWhtd2JsV1BmU2phNHhET2lQUExhUHViVUZ5WHN4SEczSHpQdFhvOE1a?=
 =?utf-8?B?N2Frd1gxT2dNTi9IVk9seWpYWHpwRnB1UUphNWxQYXVYc1o2L1JDY3ZOV1BN?=
 =?utf-8?B?TGlIa1RFS1FEay9GUlR5L2YvQjJHcmYzajMxOHZtSWRWOEpvaThFTU16dHZz?=
 =?utf-8?B?dnJwZ2l1NmJjVjdiNVQ3cHZTbDArT0JNemlYTWh1cEQ5VHV2Mk0vdDNlcFBE?=
 =?utf-8?B?RDI1NUh4YzlWbCt2OWZTNnliYlcyQmNrUlJTSTdZNG41N0lFWExOaXdTWldX?=
 =?utf-8?B?RHJXYzlIUzBjVUJETlVXYTYwT0xGRjZ1RXQ1a2RhdTRza0JlN2dZWjVscTh4?=
 =?utf-8?B?eUYxYytKL2FoYkx0bnJXYWc1UG5HbGRBYUtVTTh6dXpCc1BNRWg0R25qY0Qz?=
 =?utf-8?B?UzkrMUNIU2p4eXFybVNQTitRWFNwTFZ6SEFHdWRNRTJpSm5NK2dRdFE1eWZ6?=
 =?utf-8?B?alVPd1RiRXBrUDIwNTh1ZjVYb0llRG9BSm96K1drRktZS1JTQmZyMkRqWmZl?=
 =?utf-8?B?VHJJWTJyZkZORkQ3STJhQkxBZGc3NGpKSlBVZTdJd3Radm9nQjh2blBrbHdG?=
 =?utf-8?B?Q2VBaHY1aDZ6UUtCZ2JnY2t2aU1TR1BkbmRsQnA5VkhyMzFaLzZDd0VncHBt?=
 =?utf-8?B?Vkt4NElUamZOUG9CcFhtL0h3ZEdIMXBJR3YyUmJqT25OOTNKRXBnTWpOZTVE?=
 =?utf-8?B?cXJMemhaeE45R0YxYzZmZUs1UXNZd1Z6UzNLd29SR2xmZnpwVkREb3Q4eTJY?=
 =?utf-8?B?SFBLZHM2UlZMUSs3Y0FQTEhiSGxhV3dEbUpGaThGT0ltbjdwYmtNVmVwRWpF?=
 =?utf-8?B?N0tTYTBMOFJsZElOTnN0SnhqOUlvdzY0Ni9KMmpuaEFZMWpCTFFkVitQYU5m?=
 =?utf-8?B?VHFveGZhOGp0SS9kSjBtNnFUbGEzM3gxWjV3RXorajZxVEtlSkxnTmEyM0Zm?=
 =?utf-8?B?REtKaURnWHVtclhKcXAzV0l4WnhGSGpiTEFMKy92TzI1RjZZUFZLL2N1OURT?=
 =?utf-8?B?bStzYWxiYnNVU3JFMU1HdjFQSEV2T3FoM1Nuak5nNjErN1p5TWw2SWdsblRI?=
 =?utf-8?B?Sk9Ja1YvcGNVUTBsYkNEUThSbXJIRERsUkQvMGR0aUN5WFUydGkrcG1GRTdl?=
 =?utf-8?B?Vml4OVZuVTNJM0ZVdzYvWHI5VDNhTlg5K2JUTlFYVkxBQU5lMGJXQk82UUJw?=
 =?utf-8?Q?a0qz4qc3E7ADafHmFFBrJJaXm?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB6879.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8343e2f9-6142-42f6-ef79-08dc08a38133
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Dec 2023 19:22:31.9953 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vZnfFmv9tWwE6sSsN5cU7UKDizv7E5ZDnk6uTs9lvvEazo4lmyqqM8WCvK4jTl3oW6vvPH1x4BrpybU4g2OiFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6841
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.100;
 envelope-from=dongwon.kim@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.553,
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

SGksDQoNCj4gU3ViamVjdDogUkU6IFtQQVRDSCAxLzNdIHVpL2d0azogZmx1c2ggZGlzcGxheSBw
aXBlbGluZSBiZWZvcmUgc2F2aW5nIHZtc3RhdGUNCj4gd2hlbiBibG9iPXRydWUNCj4gDQo+IEhp
LA0KPiANCj4gPg0KPiA+IE9uIFRodSwgRGVjIDE0LCAyMDIzIGF0IDg6MjbigK9BTSBEb25nd29u
IEtpbSA8ZG9uZ3dvbi5raW1AaW50ZWwuY29tPg0KPiA+IHdyb3RlOg0KPiA+ID4NCj4gPiA+IElm
IHRoZSBndWVzdCBzdGF0ZSBpcyBwYXVzZWQgYmVmb3JlIGl0IGdldHMgYSByZXNwb25zZSBmb3Ig
dGhlDQo+ID4gPiBjdXJyZW50IHNjYW5vdXQgZnJhbWUgc3VibWlzc2lvbiAocmVzb3VyY2UtZmx1
c2gpLCBpdCB3b24ndCBmbHVzaA0KPiA+ID4gbmV3IGZyYW1lcyBhZnRlciBiZWluZyByZXN0b3Jl
ZCBhcyBpdCBzdGlsbCB3YWl0cyBmb3IgdGhlIG9sZA0KPiA+ID4gcmVzcG9uc2UsIHdoaWNoIGlz
IGFjY2VwdGVkIGFzIGEgc2Nhbm91dCByZW5kZXIgZG9uZSBzaWduYWwuIFNvIGl0J3MNCj4gPiA+
IG5lZWRlZCB0byB1bmJsb2NrIHRoZSBjdXJyZW50IHNjYW5vdXQgcmVuZGVyIHBpcGVsaW5lIGJl
Zm9yZSB0aGUgcnVuDQo+ID4gPiBzdGF0ZSBpcyBjaGFuZ2VkIHRvIG1ha2Ugc3VyZSB0aGUgZ3Vl
c3QgcmVjZWl2ZXMgdGhlIHJlc3BvbnNlIGZvcg0KPiA+ID4gdGhlIGN1cnJlbnQgZnJhbWUgc3Vi
bWlzc2lvbi4NCj4gPiA+DQo+ID4gPiB2MjogR2l2aW5nIHNvbWUgdGltZSBmb3IgdGhlIGZlbmNl
IHRvIGJlIHNpZ25hbGVkIGJlZm9yZSBmbHVzaGluZw0KPiA+ID4gICAgIHRoZSBwaXBlbGluZQ0K
PiA+ID4NCj4gPiA+IENjOiBNYXJjLUFuZHLDqSBMdXJlYXUgPG1hcmNhbmRyZS5sdXJlYXVAcmVk
aGF0LmNvbT4NCj4gPiA+IENjOiBWaXZlayBLYXNpcmVkZHkgPHZpdmVrLmthc2lyZWRkeUBpbnRl
bC5jb20+DQo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBEb25nd29uIEtpbSA8ZG9uZ3dvbi5raW1AaW50
ZWwuY29tPg0KPiA+ID4gLS0tDQo+ID4gPiAgdWkvZ3RrLmMgfCAxOSArKysrKysrKysrKysrKysr
KysrDQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKykNCj4gPiA+DQo+ID4g
PiBkaWZmIC0tZ2l0IGEvdWkvZ3RrLmMgYi91aS9ndGsuYw0KPiA+ID4gaW5kZXggODEwZDdmYzc5
Ni4uZWE4ZDA3ODMzZSAxMDA2NDQNCj4gPiA+IC0tLSBhL3VpL2d0ay5jDQo+ID4gPiArKysgYi91
aS9ndGsuYw0KPiA+ID4gQEAgLTY3OCw2ICs2NzgsMjUgQEAgc3RhdGljIGNvbnN0IERpc3BsYXlH
TEN0eE9wcyBlZ2xfY3R4X29wcyA9IHsNCj4gPiA+IHN0YXRpYyB2b2lkIGdkX2NoYW5nZV9ydW5z
dGF0ZSh2b2lkICpvcGFxdWUsIGJvb2wgcnVubmluZywgUnVuU3RhdGUNCj4gPiBzdGF0ZSkNCj4g
PiA+ICB7DQo+ID4gPiAgICAgIEd0a0Rpc3BsYXlTdGF0ZSAqcyA9IG9wYXF1ZTsNCj4gPiA+ICsg
ICAgaW50IGk7DQo+ID4gPiArDQo+ID4gPiArICAgIGlmIChzdGF0ZSA9PSBSVU5fU1RBVEVfU0FW
RV9WTSkgew0KPiA+ID4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8IHMtPm5iX3ZjczsgaSsrKSB7
DQo+ID4gPiArICAgICAgICAgICAgVmlydHVhbENvbnNvbGUgKnZjID0gJnMtPnZjW2ldOw0KPiA+
ID4gKw0KPiA+ID4gKyAgICAgICAgICAgIGlmICh2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1ZiAmJg0K
PiA+ID4gKyAgICAgICAgICAgICAgICB2Yy0+Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+ZmVuY2VfZmQg
Pj0gMCkgew0KPiA+ID4gKyAgICAgICAgICAgICAgICBlZ2xDbGllbnRXYWl0U3luYyhxZW11X2Vn
bF9kaXNwbGF5LA0KPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2Yy0+
Z2Z4Lmd1ZXN0X2ZiLmRtYWJ1Zi0+c3luYywNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgRUdMX1NZTkNfRkxVU0hfQ09NTUFORFNfQklUX0tIUiwNCj4gPiA+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTAwMDAwMDAwKTsNCj4gPg0KPiA+IFRoaXMg
d29uJ3Qgd29yay4gZG1hYnVmLT5zeW5jIGlzIE5VTEwgYWZ0ZXIgZWdsX2RtYWJ1Zl9jcmVhdGVf
c3luYy4NCj4gUmlnaHQsIHdlIGRlc3Ryb3kgdGhlIHN5bmMgb2JqZWN0IGFmdGVyIHdlIGNyZWF0
ZSB0aGUgZmVuY2UgZnJvbSBpdC4gSWYgeW91IHdhbnQNCj4gdG8gdXNlIGVnbENsaWVudFdhaXRT
eW5jKCkgaGVyZSwgeW91IGVpdGhlciBuZWVkIHRvIHJlY3JlYXRlIHRoZSBzeW5jIG9iamVjdA0K
PiB1c2luZyBmZW5jZV9mZCBvciBkb24ndCBkZXN0cm95IGl0IGluIGVnbF9kbWFidWZfY3JlYXRl
X2ZlbmNlKCkuDQo+IEVpdGhlciB3YXkgc2hvdWxkIGJlIG9rIGJ1dCBtYWtlIHN1cmUgeW91IGRl
c3Ryb3kgaXQgd2hlbiB0aGUgZmVuY2VfZmQgaXMNCj4gY2xvc2VkLg0KDQpJIGd1ZXNzIGl0IG1h
a2VzIHNlbnNlIHRvIGRlc3Ryb3kgc3luYyBvYmplY3QgaW5zaWRlIGdkX2h3X2dsX2ZsdXNoZWQg
aWYgdGhhdCBpcyB0aGUgY2FzZS4NCkFub3RoZXIgdGhpbmcgaXMgSSBtZW50aW9uZWQgdGhhdCAi
ZG1hYnVmID09IE5VTEwgb3IgZmVuY2VfZmQgPCAwIiBkb2Vzbid0IHNlZW0gdG8gYmUgY2hlY2tl
ZA0KaW4gZ2RfaHdfZmx1c2hlZCBpbiBteSBwcmV2aW91cyByZXBseSBidXQgbm93IEkgYW0gdGhp
bmtpbmcgaXQgaXMgbmVlZGVkIGJlY2F1c2UgZ2RfaHdfZ2xfZmx1c2hlZA0KY2FuIGJlIGNhbGxl
ZCB0d2ljZSB3aXRoIGdpdmVuIGNvZGUgY2hhbmdlIC0gb25jZSB3aGVuIHJlbmRlcmluZyBpcyBk
b25lIGFuZCB0aGUgZmVuY2UgaXMgc2lnbmFsZWQgZHVyaW5nDQplZ2xDbGllbnRXYWl0U3luYyBh
bmQgc2Vjb25kIGFmdGVyIGVnbENsaWVudFdhaXRTeW5jLiBJIHdpbGwgY29tZSB1cCB3aXRoIGEg
bmV3IHZlcnNpb24gb2YgcGF0Y2hlcy4NCiANCj4gDQo+IFRoYW5rcywNCj4gVml2ZWsNCj4gDQo+
ID4NCj4gPiBJIHdpbGwgbGV0IFZpdmVrLCB3aG8gd3JvdGUgdGhlIHN5bmMgY29kZSwgY29tbWVu
dC4NCj4gPg0KPiA+IHRoYW5rcw0KPiA+DQo+ID4NCj4gPg0KPiA+IC0tDQo+ID4gTWFyYy1BbmRy
w6kgTHVyZWF1DQo=

