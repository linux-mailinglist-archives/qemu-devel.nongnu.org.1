Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEAC81B049
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 09:28:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGEOu-0008Sr-1F; Thu, 21 Dec 2023 03:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1rGEOq-0008Qt-LF
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:27:24 -0500
Received: from mgamail.intel.com ([198.175.65.10])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xin3.li@intel.com>) id 1rGEOo-0002WA-F9
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 03:27:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703147242; x=1734683242;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=amJ3pGjqQctpEaqo2O7VyXbp8+5E/FRealyMvQPL7Z8=;
 b=dk8WhS0Ugod6fFWCNHF4LNR4xKZELAVwf4SunEmdyoAnIV1hILEP1S0O
 4YW4SNbVaP5ZGGyox6WpmzxqZ35QuHUDWcLtDvjdWIHz/hwUQRXgWXNMP
 ArL3thP9vMzm4mDN+Z3JoUtrCDAx8M5wug0PmLQdht5Ys9TjCL/knUINW
 5tIyPJf5k1u70AD7URzNtg4vuil9l1P0fl6n2AHt/+0N1yrTK75KDfnTN
 eZIMO5MPVUd/5QTFxupF3SrCoKRkF+D7234ckK4yimD/ej5HPQKf/pYJE
 7KoGlRcS5Xe0YWWL8NgjSgk+hn+kKiLBAXv3N5zmc1a6OVGdwRReq/qeU w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="9322910"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="9322910"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 00:27:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="900013683"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="900013683"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Dec 2023 00:27:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 00:27:18 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 00:27:17 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 00:27:17 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 00:27:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g4FaHLvJc+ulLUxewlJULUUISpnN77YXP1Q7q2645wqMrHSqTpUrhAVOyge37ntZ5otR0tlmC/OuV29TXVUqQhgJNYqMjXHYZ0ayK6fYEcqLV4SuJa3cwJhudIlW+H8EWl4YZdO17JAadK2184dX6JvLVOTceknfxR7vYKG3sU27JWRdhH/is4R6jVXubbsoXC3FyxfRqcyNi/5hcTjPP2RV0fPxRCIyJxgnY0oiP+WKEtgjvyvvezPQZWgtmJ5O1RBkkQ655abvfr7cl6nCMox2SOsWRYrkLYtw+n9I9eRYGnPc+xA+rtCCOUHA8c7U3gOoz2QbytL30BTFg9nKBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amJ3pGjqQctpEaqo2O7VyXbp8+5E/FRealyMvQPL7Z8=;
 b=P5Kxl/w4tFHRgD1wHiS2Ge/Sz02f1i0QKhtfvai+1RVEccdZVZpNAxFVAAGFWz3jdwHDERNy8cswCBizYcCJNuqsqNotJ+O108oQen8OKg3lM/pIPCI+aJGfY+0KWe9QganvmYq0UWpEPS7fZzIcnVYo9938Vx+ahj+9blYaaIxrjPevNwza5AVJy5vOKXbraeeoZGy5Q3ObNQALQ5hOZFZmC9tAq4x9nd0miCbxjuZJ00h9geBExkF0naVuj1aV2i9vpTETQpG2DzF5ErSyFpJO4yehQaueidAbrWI+u5tKanq93KB7C8a+q/N/g0iZkJxRCu9AhELy+KVPEtl0DQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from MW4PR11MB6737.namprd11.prod.outlook.com (2603:10b6:303:20d::15)
 by SA0PR11MB4686.namprd11.prod.outlook.com (2603:10b6:806:97::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 08:27:14 +0000
Received: from MW4PR11MB6737.namprd11.prod.outlook.com
 ([fe80::2252:14d:8e00:3b34]) by MW4PR11MB6737.namprd11.prod.outlook.com
 ([fe80::2252:14d:8e00:3b34%3]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 08:27:14 +0000
From: "Li, Xin3" <xin3.li@intel.com>
To: "Wu, Dan1" <dan1.wu@intel.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>, "seanjc@google.com" <seanjc@google.com>, "Gao, Chao"
 <chao.gao@intel.com>, "hpa@zytor.com" <hpa@zytor.com>, "Li, Xiaoyao"
 <xiaoyao.li@intel.com>, "Yang, Weijiang" <weijiang.yang@intel.com>
Subject: RE: [PATCH v3 1/6] target/i386: add support for FRED in CPUID
 enumeration
Thread-Topic: [PATCH v3 1/6] target/i386: add support for FRED in CPUID
 enumeration
Thread-Index: AQHaEuF9PgUxmhk7ZkW3gGDhXdLhR7CopZUAgAsCidA=
Date: Thu, 21 Dec 2023 08:27:13 +0000
Message-ID: <MW4PR11MB6737DC0CCD50B5D3D00521A7A895A@MW4PR11MB6737.namprd11.prod.outlook.com>
References: <20231109072012.8078-1-xin3.li@intel.com>
 <20231109072012.8078-2-xin3.li@intel.com>
 <bfdebf3f-9467-41fe-a09f-ebc4e02465b4@intel.com>
In-Reply-To: <bfdebf3f-9467-41fe-a09f-ebc4e02465b4@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MW4PR11MB6737:EE_|SA0PR11MB4686:EE_
x-ms-office365-filtering-correlation-id: b68a1f11-aca1-49d1-a1e8-08dc01fea290
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p9WNVc6NoqdTtaSCI9ssvt/615P+JetTkSOdg0XpG9YFDOmMqY06f52IBrEgaSsUA2DbTrBkeoQBnUe+WAEjPT5AZf2+9Q6Gh5d5p7ALkXSRKs+8IJMQT6IuU/zNqF9FW9ytNne1O/aWHMmxMV0v/PVyYJKWvB+gK1BQ857mNDpbRGkaymO4TjNruVFlR8AlkLCJTKcAcarUa1LRgb0M8UU1iGxTCaXwQkkkrUNDqCuIS42qKKl2PV3EaJnSqlHHBhmYN9EAUwYjIUT9WnS/ME6ngu17ntTNZa9zXweVkqfZhv6EV+kepZAjn8OyM6iIVgtBRPFxkz+nnpwkiQHUAqebFh0vARVyHY2kMMrXPt366NmemwVKHZVS0ECz9jfJz1F3fKcJMppnhbatXbEC8o1f3GVh60SMdASPYF8/vJv4ciU9lSKNQ1DDe1dUWxnnvf7MzjDJcIGwA3zyN9pLJg95xavcx4wjoN8g38yq9K2c0ZazUAvJYC+xmcwZho3e1Lp0nxuzHIVUG7WMkyHyz6hP1Qz+VjxVCJSxD+GOnsVAWeEXfNuHNser0SDOod3rAPC4yqBCC0E1jCL1Xq2HRhtpwKlJztFJitMrydB36Tif+v6gbeyrlH7Vc5iNJ7C4
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR11MB6737.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(396003)(366004)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(4744005)(2906002)(86362001)(122000001)(82960400001)(38100700002)(41300700001)(110136005)(66946007)(33656002)(76116006)(66556008)(64756008)(66446008)(66476007)(107886003)(54906003)(26005)(316002)(71200400001)(9686003)(6506007)(7696005)(55016003)(478600001)(52536014)(38070700009)(8936002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RlFSdFJ4N2E1VnlYLzJkRm44VGZxZGRHTkpyczNiQ2lHWElXS2IxWmh4bm4w?=
 =?utf-8?B?NU1NTkJjL2M0eGRET05xalp2L1JhRWkrMTNTM2JGbmlmcFVZamM2LzZ6NlhH?=
 =?utf-8?B?b0dKOGIyYlhCWWxyRWN2dm5uVDFoZVlaMzdQTGhyTzNOajlZa2hRc3lPbUdU?=
 =?utf-8?B?TmFabUsrZ08wdHVWZzVOeW9zVUVKWER2bjRhQlJOWXk5TldhYmkvMmlDbkdH?=
 =?utf-8?B?K21PYjlMU3NMTEFsSzdGUk52dnlUUFVsOXBiSDR5ZHBIQW1WZ1hrS2dEOTg2?=
 =?utf-8?B?dE9NRUlsZFJKdm9oM1FOYjhrRndXUXRJbEo3YlNacjdmU3RIdklvbUMvZXFp?=
 =?utf-8?B?WWFsVEhqSTRCY25RTTcwUUJKSXlYRXN0ZE0yOU0vQlpITWZQVFAvRnU1VVVE?=
 =?utf-8?B?N3Rsalc3bEhJRFZCSlVoL0dEbU5qS1FzcWlFbEJyZjhud3lRUXdNdEpkWVZH?=
 =?utf-8?B?ZHhDUVBodjg2NFdVTk1Hdjl1ZVcxS3h5ZEdDd2lkQ2pFL3kzbVMvR0QvQzgz?=
 =?utf-8?B?RlNIc3cxbXdCbFA1WGg4SVpIVElqaUw2amdlYWFhREt1RnpmQ1lwK1ZzWDZH?=
 =?utf-8?B?Rjc5OGNoZjJLU3hzR201K2w3SGVPaUN6YzR5U3RMME9yb0lvOVdJNFBWQzA0?=
 =?utf-8?B?U3dQK1N3c3JONkJPMjNZQWtzSzFOVWI2TlgzWXBvMzB5VHVjVVhOUUEvWFNL?=
 =?utf-8?B?cjlZaHcwQTlPS2JuVVhjUjhNUndvb1g5T0tScWFpdnlhMmovWjF1bHkwNTNz?=
 =?utf-8?B?ak5SVitjK3IxVEdRZGI2Z3ZXN2xDTkNyeDF5cXlzbStnbDZQY0gwMDN1YmNh?=
 =?utf-8?B?dC9BeGtMQnJHVXZwWSszeUtBUnVoQ2IxWHFpNzBGQyt6ejV0M3FDM3p2OTlo?=
 =?utf-8?B?bG8yK0ozQTFTZHNUY2pqVDFrSWFMU3FYd3ZsT29oMG8rSUpOVDN1bUJRMTk5?=
 =?utf-8?B?N2YvSTVRR2pYKzltUzlTU203UHF4ejVsTTVNdTM0ODdzQmJpSzhoNEQ5MUJT?=
 =?utf-8?B?VVg4U29NdWlpWkwyekpIajZXa3l4ZCtvc2xyMWNYKzloaVhWWjNKMTE5ZUJn?=
 =?utf-8?B?S3A5MHU1QkhQSkVqK2MxZnh3cjhpQWUyV3dIQXBLSkFUNDFnaXVyMmNpclNG?=
 =?utf-8?B?eFBCdG1ZSGxoSjdhM0JNeUF3d0FqMDZITFZtT1QxMVZzRzVuTmxFL0FwVUJm?=
 =?utf-8?B?MkMxVWhXZTNvNkpyMVVRRUF2YjR1Tm13T2tleVJBdEhkV2VrMmxiU3NrSEpS?=
 =?utf-8?B?cDhKd2JaQlVBVzcwSUpaMm5ackd4UU1xTVZONzdDSnhQNnc5Ym5xaXFORGVL?=
 =?utf-8?B?d3dPeW9zQnRFYlh4QWJxQ2EyOXp4LzV2MW5mNnIyMkNYMzdYd2c1VkZseCtW?=
 =?utf-8?B?ZWxFa1JmMWhjb2M4Y2s2eGsxdEZEMDhoMVRGSEozYVY3S1ozTG9VSElzRkRk?=
 =?utf-8?B?ZHEzRVJ2WWdGdWVlZUVUTXVIQnlRV254QmE2Mmlzc3kwSkVqRmFpQ2ZKdXFt?=
 =?utf-8?B?Uy9abW51cGdEeG1yK0VFUVprVHlBRk9RNlBYQjRoaG5HVXB6UmkwelY0MkNT?=
 =?utf-8?B?ME56UStyMnBSdVdzb1NvYmZoeWZtY24xNjZNNTNnakxPVkdtVzFPT1EzU29U?=
 =?utf-8?B?eng1aUNUSGRtOXZIakNGQW5XTXR4RTQwbEhNak1QbEN6dWVwazVuMExYS2Vn?=
 =?utf-8?B?alhpcmU2a3NVNkxaZUhaL0daQlQxNHA4S3V2cFd2UXlsb2FNajZXbXlpSndH?=
 =?utf-8?B?a0hrbG1aMThQamo4YzFKaG5EanpRMVlsU1JhaTl1dU80WmRuOWVEbHBmdEow?=
 =?utf-8?B?UlpLbDY0U0E5Q2RhdlNiczhrSUM5eXFadkNEbjJVNXNhY3NSamp6YVBNdmlx?=
 =?utf-8?B?K1J4VnZxOXgzaEgzVCtVdWhlRktTZmMzdnRVVHBjd3lwblVUU1oxQXh4dTRD?=
 =?utf-8?B?SXBXTE1nemZiYklLRnNWeEVLdGhXZTFwZ2llVC9jNGpDZEkxTFo4S0k0TzRS?=
 =?utf-8?B?TGs4cGVwNG5FWktCcEdyQUJEYWZHeUgrN3NFL044M0hoQUZjVE44djloWkZa?=
 =?utf-8?B?V0R6eGtGN3VtckI4U1UyUitsSmExdU4rVDRJV0pyRk9Da0I1OWdISDczSUdB?=
 =?utf-8?Q?8v/o=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW4PR11MB6737.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b68a1f11-aca1-49d1-a1e8-08dc01fea290
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 08:27:13.9999 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: w4SJh6pSaCnjoZ17ttm1RjwyyNarX0LEjpZY9NDpxSrzhtrX8tkNxsymJhWoyreteoMm1hgWG5cd60eDt3Sp9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4686
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.10; envelope-from=xin3.li@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

Pj4gQEAgLTE1NTIsNiArMTU1MiwxNCBAQCBzdGF0aWMgRmVhdHVyZURlcCBmZWF0dXJlX2RlcGVu
ZGVuY2llc1tdID0gew0KPj4gICAgICAgICAgIC5mcm9tID0geyBGRUFUX1ZNWF9TRUNPTkRBUllf
Q1RMUywgIFZNWF9TRUNPTkRBUllfRVhFQ19FTkFCTEVfVVNFUl9XQUlUX1BBVVNFIH0sDQo+PiAg
ICAgICAgICAgLnRvID0geyBGRUFUXzdfMF9FQ1gsICAgICAgICAgICAgICAgQ1BVSURfN18wX0VD
WF9XQUlUUEtHIH0sDQo+PiAgICAgICB9LA0KPj4gKyAgICB7DQo+PiArICAgICAgICAuZnJvbSA9
IHsgRkVBVF83XzFfRUFYLCAgICAgICAgICAgICBDUFVJRF83XzFfRUFYX0ZSRUQgfSwNCj4+ICsg
ICAgICAgIC50byA9IHsgRkVBVF83XzFfRUFYLCAgICAgICAgICAgICAgIENQVUlEXzdfMV9FQVhf
TEtHUyB9LA0KPj4gKyAgICB9LA0KPj4gKyAgICB7DQo+PiArICAgICAgICAuZnJvbSA9IHsgRkVB
VF83XzFfRUFYLCAgICAgICAgICAgICBDUFVJRF83XzFfRUFYX0ZSRUQgfSwNCj4+ICsgICAgICAg
IC50byA9IHsgRkVBVF83XzFfRUFYLCAgICAgICAgICAgICAgIENQVUlEXzdfMV9FQVhfV1JNU1JO
UyB9LA0KPj4gKyAgICB9LA0KPiANCj4gc2luY2UgRlJFRCByZWxpZXMgb24gTEtHUyBhbmQgV1JN
U1JOUywgaGVyZSBzaG91bGQgYmUgYXMgZm9sbG93Og0KPg0KDQpZb3UncmUgcmlnaHQsIEkgbWVz
c2VkIGl0IHVwIGluIHRoaXMgdmVyc2lvbi4NClRoYW5rIQ0KICAgIFhpbg0KDQo+ICsgICAgew0K
PiArICAgICAgICAuZnJvbSA9IHsgRkVBVF83XzFfRUFYLCAgICAgICAgICAgICBDUFVJRF83XzFf
RUFYX0xLR1MgfSwNCj4gKyAgICAgICAgLnRvID0geyBGRUFUXzdfMV9FQVgsICAgICAgICAgICAg
ICAgQ1BVSURfN18xX0VBWF9GUkVEIH0sDQo+ICsgICAgfSwNCj4gKyAgICB7DQo+ICsgICAgICAg
IC5mcm9tID0geyBGRUFUXzdfMV9FQVgsICAgICAgICAgICAgIENQVUlEXzdfMV9FQVhfV1JNU1JO
UyB9LA0KPiArICAgICAgICAudG8gPSB7IEZFQVRfN18xX0VBWCwgICAgICAgICAgICAgICBDUFVJ
RF83XzFfRUFYX0ZSRUQgfSwNCj4gKyAgICB9LA0K

