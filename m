Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 969A2719685
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:13:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eM5-0000wQ-GS; Thu, 01 Jun 2023 05:12:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q4eM2-0000pc-S0
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:12:23 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q4eM0-0003AK-GV
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:12:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1685610740; x=1717146740;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=U2sG6xLUROGjL1Zu/GkRk8k4ZTnkRTXCTF+DLm3mT7k=;
 b=CiXQcVkhypkX99OcGDxZRfNL9DF1oc+tDqQFkGhHjI+KQoaLlgK9T8qp
 RkxNIZDhW4z/PuXHFnHwvGDT8lAEIynLe82z6ksddthISz0db5VqiSwMk
 +Lf3/shL5+Bze5Ann56/HeRkNAutEd793eUQ+DcZ7gyMl38doVfUItoEB
 zw5aEtdjJ0H4kMgb1zemMwSrlePnRVyq2k7mUVJ4jwB34nHg620wasOfX
 kMKlRpQNCWGJQncgUfYKkmJhVJvvj/aOCGLZe+dFl6z+024ZOxCW7rlJd
 k/3NjFNdsdP6wf+cHWreh8l+HufjRjsYvlXsKjMuMFUU4756vVXHE9eYE g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="340105131"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="340105131"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Jun 2023 02:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10727"; a="772352360"
X-IronPort-AV: E=Sophos;i="6.00,209,1681196400"; d="scan'208";a="772352360"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga008.fm.intel.com with ESMTP; 01 Jun 2023 02:12:17 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 1 Jun 2023 02:12:16 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 1 Jun 2023 02:12:16 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 1 Jun 2023 02:12:16 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SS0WRXd1fSNprE2cJU7Irv3WAHFBfCOEjnNgAfS1vFRJFpagJSvwaDavDVeoIJHkmSsqRw7q0GKUQKBLFPLN0XBkR8h/GptGOaRE2ZO6HfCiy1sIYSL2x9s1+z3/R953BKulDtJ2z+jc9qL9AvGgdUydiNHZVRFO6kqCB+lEGyEzJ2s2eYN9L5F+Ue/5lAJE/BN1Y822KMlb3Zhe+9E51HgUQas5bALesAF7kpAVPTFmUZ+TkcG21sLLJ0L6qaUzoOPIX21X5zWXPyqKnH0ubtSn2xDcM7bp4BUhFXB0HMf9TZ2j7UXgsoWrWNgUgeSwQD+hnydudjS9MgH7BAbtGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U2sG6xLUROGjL1Zu/GkRk8k4ZTnkRTXCTF+DLm3mT7k=;
 b=j3mwwiLkL/lm+u1aXilDWbk1zWOJg+cGNlpiygYJhcFX4fGLkncgOHzNjprHt4AnzcMnAbAk5l6LwM5w4vF/YsARBZB2SZbC5JtJnFIEgTdH8+/M55MMEY39BQoppGRu8NwcWkvDnDwN9MxLFooFufQYu7OelBLoZ1O/LT9vOd84eKDqAx7vxzBlwtZRecgjuEAkFNFTMRfOMGWKyTwpyF/Axz/SQehcHktCAjD0W75Urvnwuqn9yMAtNHZk6kG/LXy+FnUB0e7v37++gap/SqClG6yRvMLVstQxnGFJ8Jpcp5wGEUC7o2oZ5S9HU1HtKxlHt/hEbKocQLWK96ixvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 DS0PR11MB7578.namprd11.prod.outlook.com (2603:10b6:8:141::16) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6455.23; Thu, 1 Jun 2023 09:12:14 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Thu, 1 Jun 2023
 09:12:14 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer" for
 postcopy tests
Thread-Topic: [PATCH v2 2/2] qtest/migration-tests.c: use "-incoming defer"
 for postcopy tests
Thread-Index: AQHZktWTIexX3rIWCUy8lvegBejjAa9y4+mAgAC7pwCAALnpgIABSg2w
Date: Thu, 1 Jun 2023 09:12:13 +0000
Message-ID: <DS0PR11MB63731922AFD16473CCDAEACADC499@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230530090259.189462-1-wei.w.wang@intel.com>
 <20230530090259.189462-3-wei.w.wang@intel.com> <ZHYLDSZiP+BQXv6K@x1n>
 <DS0PR11MB6373797A00F0A4E6B22EF639DC489@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZHdEa0jQJTAvg3RM@xz-m1.local>
In-Reply-To: <ZHdEa0jQJTAvg3RM@xz-m1.local>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|DS0PR11MB7578:EE_
x-ms-office365-filtering-correlation-id: 6da2acb7-e0eb-41f3-880f-08db628049e2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwHIRq/meTrydVL86rCm/VKN/qXnHW9NCjT4EEbtTR6tpI7qIMyWfRzZnt1WhTl64aIM/MZmTqNic38twSIVQDzwO9/esAGd5wvdKU6hpgbFjz72hCPm2ALydHwvD0S6u+xFc4Ssm6vadIGPwzuRDxbUMsPw7Vpwwndpdrhfq9fYSgk5j6+mZJbJVcm4Jgy3vfOs1CCZCMWNsZhETSbJWoICTjFccjioiZbZS/hDU1wvyT9P4Ee1U5LaYsMJKIL4yYPEh/+DC1QbtPcNGG4rMZzYExUy/uaHbi840a/7s6ZZhFTcpzyedH4YjLVcrQ8tXZd2GnqXC/cfO6X042CsGf7o6xY0Dm+SjAlC/cjQmUj8gKVdOQir3j7imY06FHFT3nMYdJOHFB+XEPcl+oMrsmYxwyaeXLfhRHvXYCSaJ1WJ2XMcAQ5MavXnHtSuoNzPkEUhfYCg7Z9WzHlvdCTM1EFbi/lNbH5F/TFpQr3YyNVu9nA9K0drCwKHQlu4ABALXIrPzAIFFnv+mDj4qcP3oxKH2bp238Jh5PhYMkFbPfqDVrFj9agKS9qoDkLZY8PBa+oXgveihz5iEyrnETd7tFQkMkHkbInmgi19WYaYQ2k+sMo8a+Vv8FGvZt7NhFAv
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199021)(2906002)(5660300002)(52536014)(41300700001)(8676002)(8936002)(76116006)(6916009)(66446008)(66556008)(64756008)(66946007)(66476007)(316002)(4326008)(54906003)(71200400001)(7696005)(478600001)(82960400001)(55016003)(6506007)(53546011)(26005)(186003)(83380400001)(9686003)(33656002)(122000001)(38100700002)(86362001)(38070700005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZHJGYXdMMGx3M01PM09yZFNkNTQ1Zkt0YmJGd216d2ZNYXlIUzhZREVnaFdo?=
 =?utf-8?B?cEZVNFBNdldXRDVSRnpjMDNDZjRiM0l6TEtTcWJqQlYwalJNS1UvMWwwOFdZ?=
 =?utf-8?B?Q0JRaDd1c253c0h5MTZWZWloU1lMTysyUHZnTXZ6ZVozVUxUVm8wRkN5QSsv?=
 =?utf-8?B?Yyt2S28vT2NMeUFSQTZMY2JMSFFFTHBQMTlaem1HRUtFbzc0dXMwbzhwWW4z?=
 =?utf-8?B?NFJXSE16bnJiUVVjLzN4NCtScHlTNXpiV1BHU0xUdWF4OGh1NlBVS3lqNVRk?=
 =?utf-8?B?M0hXeHJyWkpvUHd2Ly9jUVlmaWZQVDhUMUt3M1JrL0JBdFFLd1N4d2FhZWpU?=
 =?utf-8?B?QUxTalFwR0xVamFmQXNXT2xzOURVQmVYN21pTzJVRklIS1dFQkdseGJRTDBa?=
 =?utf-8?B?V2I0c0hnZUxqSjZSYWVaVHNyU0c3OS9UWVRORW1WZDFweWhSU0cwWmkwdW0z?=
 =?utf-8?B?aUF6MDZFSWZhVkJuekZOTkpXOFM1cHZxeHJ0VnEzS3NYM2dNd3B5Q1FxQWxV?=
 =?utf-8?B?TzdwMERtemljcXlubzBBQVNZQjdqSVA3cnpEazBBazlTRWNJc0tGRnFvZ2FQ?=
 =?utf-8?B?amVXUW1pOXZiZUdRU2lycy9vSWRUN0o2VVZiZFlpK3cvck1QOFk5ZWJhRHV0?=
 =?utf-8?B?Q1RlYiticUppNCtyaG9TSERtUks3WWNISnlWT29vNlp5SEVOVGEzL3V5NStS?=
 =?utf-8?B?NWtjS2VQcEVoSXkrR1FKODhESjJiUXQrRkpLamZLTUhKYzg2Qmx2QjRkc2Na?=
 =?utf-8?B?aVJ3eEM4Z2x6RWhtbUkzdUR1ZGpNSVRvZjNhZUNoTmxDSWdEMmtTSkd3aTdm?=
 =?utf-8?B?c2JtMHNwMUJob2g3TzlkcnpXRmdMNXY3TUo1U0xEdWpUVnM1bUw1VWZWRUxT?=
 =?utf-8?B?V2lPeXc3RXNiL0pnVzNlT0tTZGM1dFN3b1l3RkttbkFnSHcrWFE1cTVOVXZ6?=
 =?utf-8?B?aitpV2FKYlE2M0xmbWp3NE5MVERRVzNiNmo2NFFoTlpxb0RsMXVaTzlwSnJV?=
 =?utf-8?B?K2QvRGN3MmZnbTE0endkTnNoNFhxNk03UHdVVU0rYS94TEE5MzFwZ3M5ek0w?=
 =?utf-8?B?ZUZWU3VFNVdWQkVHUkNCcGZ1VmtiTzJrMXNtTTBKRXk4V28waHJOWGo2NEpl?=
 =?utf-8?B?QUNPelNXaVlWb1JqeGRhOEoyS3o0d21qQzFtcHM5cUpvMkxDMkFaR1ltVDZs?=
 =?utf-8?B?bkpXakd2RTN3bktCczNNcGpUZjBMc3dXam9YazVOVHBMRFFrU0hZNFBoQnhO?=
 =?utf-8?B?VW9DZWcxSm9yNldqMTFMQWhFcHJHakM4MUEycEZqTTBOdFUwRzdyRWJOaFUv?=
 =?utf-8?B?a0V5ZjJVYlhPZWhLTS9wZXdqczE1SlhsR0p5SVB4d0NpNzk0SDdqTCtGNkd6?=
 =?utf-8?B?c244Y2tTTmoyWjd6OXdKOGlwNUFGWEdob2lrVnVmUjRvY0owOTU5ZWtYanZl?=
 =?utf-8?B?RW5FM0Z3dnFUeXdaSHVKSTMrT3Fsc0wrYkFrR2RxZ1Z0U2Z0dzViakYwTkxa?=
 =?utf-8?B?NUZheTZmOGZ0eG9IUXZPazdUQWdVZGlQNkJxODZubmhIRk1GdTFNbVUrQkcr?=
 =?utf-8?B?bUlyUGNETG5rcXJQMm9qSjZtVkhNdlpVT1VzY21GakpyUFBmM093d0JPQzda?=
 =?utf-8?B?Y0ZOVnB6cDVnZmtzdWdXSGF6aU9NTks4cTVDcDBZd2J6Vyt1ck5MYWNhRkdF?=
 =?utf-8?B?TTZERkQ2RWVUT1g0bFRPeWVUSzZQUlEwTVFRREx0bHpXekRUQ2wyTFVxbEN5?=
 =?utf-8?B?Q3FteUJhUXhUUzZYaUc4cWFmck84OXdQVHdPalRndnZRZHRGRlZsZkdRRUUy?=
 =?utf-8?B?ODhYTml3cHBvNDV0bHVqaHh4RTVmSmtHZldqZ3o2M29SbUkrNk9FcHVHbkNX?=
 =?utf-8?B?ZlFWakZndDRMdGp2V2FsVURCTjVCZXFDcGkyWTVsbFoxNjA5aUNqcDVrQmxJ?=
 =?utf-8?B?U1pUS1N6THVLcXgzL0RXem9NUmdZVmUzb2ppSVhjRHRBWEVnSm0xWkc4c205?=
 =?utf-8?B?eDVkYWJCcDNBVWlNU1BlcjR4bDRuK2FsWEJvZDlFVk4vckV5SmFNenlIUXEx?=
 =?utf-8?B?WTNGeFZFSVM4MkJ5c0xmcU9yWDBvaU0xbVpZajUyVm01bVdjdVR6a3NQME13?=
 =?utf-8?Q?aTx3jWqZZyY0EqnZWYOofPnqi?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6da2acb7-e0eb-41f3-880f-08db628049e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jun 2023 09:12:13.7519 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: G3ULAVFN4WFnhY33lR2ePCAcEP+v/EupPpDmbzwGxkplLiOqcEXnl0Zy8Y7NEINAMhrfG6Ev7RjTFyy58eyC/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7578
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=wei.w.wang@intel.com; helo=mga18.intel.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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

T24gV2VkbmVzZGF5LCBNYXkgMzEsIDIwMjMgODo1OCBQTSwgUGV0ZXIgWHUgd3JvdGU6DQo+ID4g
PiBIbW0uLiBzbyB3ZSB1c2VkIHRvIGRvIHNvY2tldF9zdGFydF9pbmNvbWluZ19taWdyYXRpb25f
aW50ZXJuYWwoKQ0KPiA+ID4gYmVmb3JlIHNldHRpbmcgdGhlIHJpZ2h0IG51bSBmb3IgdGhlIHBy
ZWVtcHQgdGVzdCwgdGhlbiBJJ20gY3VyaW91cw0KPiA+ID4gd2h5IGl0IHdhc24ndCBmYWlsaW5n
IGJlZm9yZSB0aGlzIHBhdGNoIHdoZW4gdHJ5aW5nIHRvIGNvbm5lY3Qgd2l0aCB0aGUNCj4gcHJl
ZW1wdCBjaGFubmVsLi4NCj4gPiA+DQo+ID4gPiBXZWksIGRvIHlvdSBrbm93Pw0KPiA+DQo+ID4g
SSB0aGluayB0aGVyZSBhcmUgdHdvIHJlYXNvbnM6DQo+ID4gIzEgImJhY2tsb2ciIHNwZWNpZmll
cyB0aGUgbnVtYmVyIG9mIHBlbmRpbmcgY29ubmVjdGlvbnMuIEFzIGxvbmcgYXMNCj4gPiB0aGUg
c2VydmVyIGFjY2VwdHMgdGhlIGNvbm5lY3Rpb25zIGZhc3RlciB0aGFuIHRoZSBjbGllbnRzIHNp
ZGUNCj4gPiBjb25uZWN0aW5nLCBjb25uZWN0aW9uIHdpbGwgc3VjY2VlZC4gRm9yIHRoZSBwcmVl
bXB0IHRlc3QsIGl0IHVzZXMNCj4gPiBvbmx5IDIgY2hhbm5lbHMsIHNvIHZlcnkgbGlrZWx5IHRv
IG5vdCBoYXZlIHBlbmRpbmcgY29ubmVjdGlvbnMuIChUaGlzDQo+ID4gaXMgZWFzaWVyIHRvIHRy
aWdnZXIgZm9yIHRoZSBtdWx0aWZkIGNhc2UsIGUuZy4gdXNlIGEgbXVjaCBsYXJnZXIgbnVtYmVy
IGxpa2UNCj4gMTYpLg0KPiA+ICMyIHBlciBteSB0ZXN0cyAob24ga2VybmVsIDYuMiksIHRoZSBu
dW1iZXIgb2YgcGVuZGluZyBjb25uZWN0aW9ucw0KPiA+IGFsbG93ZWQgaXMgYWN0dWFsbHkgImJh
Y2tsb2cgKyAxIiwgd2hpY2ggaXMgMiBpbiB0aGlzIGNhc2UuIEFkZGluZw0KPiA+IG1vcmUgcGVu
ZGluZyBjb25uZWN0aW9ucyB3aWxsIHRoZW4gYmUgZHJvcHBlZC4gSSdtIG5vdCBzdXJlIGlmICIg
YmFja2xvZyArDQo+IDEiIGlzIHRydWUgZm9yIG9sZGVyIHZlcnNpb25zIG9mIGtlcm5lbCwgdGhv
dWdoLg0KPiANCj4gSW50ZXJlc3RpbmcgdG8ga25vdywgdGhhbmtzLg0KPiANCj4gSWYgdGhlcmUn
bGwgYmUgYSBuZXcgdmVyc2lvbiwgcGxlYXNlIGNvbnNpZGVyIGFkZGluZyBzb21lIG9mIHRob3Nl
IGludG8gdGhlDQo+IGNvbW1pdCBtZXNzYWdlLg0KDQpPSywgd2lsbCByZXNlbmQgd2l0aCBjb21t
aXQgdXBkYXRlLg0KUGxhbiB0byB3YWl0IGEgYml0IGluIGNhc2UgdGhlcmUgd291bGQgYmUgb3Ro
ZXIgZmVlZGJhY2tzLg0KDQo+IA0KPiBSZXZpZXdlZC1ieTogUGV0ZXIgWHUgPHBldGVyeEByZWRo
YXQuY29tPg0KPiANCj4gLS0NCj4gUGV0ZXIgWHUNCg0K

