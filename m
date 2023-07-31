Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30608768A81
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 05:58:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQK2F-0004uN-Bz; Sun, 30 Jul 2023 23:57:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQK2D-0004u7-DJ
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 23:57:29 -0400
Received: from [192.55.52.151] (helo=mgamail.intel.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jing2.liu@intel.com>)
 id 1qQK2B-0002tQ-Lw
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 23:57:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1690775847; x=1722311847;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/5nwOMOlIAq90ScRcieInmp3nqeCTvUR1+/hR/wpFcU=;
 b=BpGHKbpQYqxs6XVw7PZSf9CNj86ZY9G4hLkWp+3SzQJWt9pmcuik6pvz
 v4wipdDdg7pR1PzkjPoshkJvMG3L0fMAvTJ3lRVwIT4mdk3AmiYRteVxk
 32UWjvYqi/vwpGw9eN6PXShlzteJjTKIzkCWGmfoqUwxtaNusX3mniT0D
 mLp4JMcpQ35DjOpEpBAmjjc6BPch7hyC5amUgEtJiiU+xJGhQAOZXNUyN
 /4baGxgwAWR6DNVpJS3GdrtClFY1rCcSmuT9lsfHaK+xQM27bHh/boLad
 Hpvigw0QKOj7ZjGkdR2E50ht/24fUgnL7PnBXlUzOhRwKm1q75mpiaIBb w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10787"; a="349215783"
X-IronPort-AV: E=Sophos;i="6.01,243,1684825200"; d="scan'208";a="349215783"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2023 20:57:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; d="scan'208";a="871481622"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmsmga001.fm.intel.com with ESMTP; 30 Jul 2023 20:57:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Sun, 30 Jul 2023 20:57:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Sun, 30 Jul 2023 20:57:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Sun, 30 Jul 2023 20:57:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fdLMSjclAPIFwe7WuRZ8ugsdC3AeY/J6PyixK3MhAYCUOaPA1uSlnin9UNuAZVVIYUAbZDxAcwh7XVDIdEWOzXjCHTGQnqK7iyKVGDQNYo3ktQwZbmhyYiETqmybsS0vItNZFz5EdjaogWP2Hz6VLqaC8B2PFb1xkTcsW+oDybZVEGiodV3BhbjINBNV4IG3zxaXxhSl9rN26w3PaoSdU2fvkwi/JtYNNdqjRvo0wBaRdz91j+nqujwaaei2vlIQjgsmDsWvBHbiJtf7Ol0ftDzEVvVJjd5Ln/i4b3fbQee3X+QnnqYC7Sd6DVGeZbnfpQg7YAW58TI/dBgWC0CEmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/5nwOMOlIAq90ScRcieInmp3nqeCTvUR1+/hR/wpFcU=;
 b=fF991utBzTtKRAnYOQLEVzgTlCm3/2dCfFQV4MzV0ygQyuVNsExIFbGHQcEZH8xENTrNWMCk50pgBTOmanuPjEhXK3aP7dxTAvyvP/bozVejP5+PVsa13G3A4ixv5wxqkF88pB4EcJBCtyABB1VbSPOFiZHZGPeqWRCpFLlQAGE/eo24eizdij929/xHOCqgbWeZqloNwfQ4rOWm7Mt5un78/+laDDUa4XLErzdlcYNqmsiJQ6qyGBODGMTJYCIjePwduu/6e/hUqtRqE8TGW22g1OZljomkZq+Aijhfp+3ALoNClTRB3Z0tbQqFKOCCd8nUynOgRJsK7u59Fjp66w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8114.namprd11.prod.outlook.com (2603:10b6:8:129::6) by
 BL1PR11MB6051.namprd11.prod.outlook.com (2603:10b6:208:393::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.43; Mon, 31 Jul
 2023 03:57:23 +0000
Received: from DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd]) by DS0PR11MB8114.namprd11.prod.outlook.com
 ([fe80::5de4:80fa:4a96:5dbd%7]) with mapi id 15.20.6631.026; Mon, 31 Jul 2023
 03:57:22 +0000
From: "Liu, Jing2" <jing2.liu@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Chatre, Reinette" <reinette.chatre@intel.com>, "Liu, 
 Jing2" <jing2.liu@intel.com>
Subject: RE: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Topic: [PATCH RFC v1 1/3] vfio/pci: detect the support of dynamic MSI-X
 allocation
Thread-Index: AQHZwFtnD/lhplXI/0is72NhiwHcDa/N1lcAgAD+laCAAAmiAIAEZZ/w
Date: Mon, 31 Jul 2023 03:57:22 +0000
Message-ID: <DS0PR11MB8114EDC8682BC265FFFA34C8A905A@DS0PR11MB8114.namprd11.prod.outlook.com>
References: <20230727072410.135743-1-jing2.liu@intel.com>
 <20230727072410.135743-2-jing2.liu@intel.com>
 <841b1ff1-0a50-e9c9-d405-256a16ffdf8c@redhat.com>
 <DS0PR11MB8114B633ED8814B272673415A906A@DS0PR11MB8114.namprd11.prod.outlook.com>
 <8e44b87f-c22c-9071-1ffe-7d16cff58869@redhat.com>
In-Reply-To: <8e44b87f-c22c-9071-1ffe-7d16cff58869@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB8114:EE_|BL1PR11MB6051:EE_
x-ms-office365-filtering-correlation-id: 5d685a9e-3dbb-4195-e866-08db917a3ebb
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 81euOElLmSnarC3Ahf+09op5BEovcYGcLrkBAPl4ToDgOF/7TB8DdkmJ11CCWUBfryYWeA/UHWbEBVQGX2SLNLmtOLdF8NmWGu2lmWQE0+Q14k2rH7qDaqdgwu+xw2Un+4Hi40EEBoQTN3aES4k2WBwFX53WpHTzV3EuKmpJMQxIr5J+K4f8m6aQtNXyz96s5MFXwUvXcdbkHsBby+R3RVOY7u1Q6Wc85YHvCUKpuOplfKQHOV5n2Q8vxQW4cJWJ5U9IIaaE7M38d1Ne0rdgdZkjr9A4RPg0tpe125EqDVJFr6AXVQzz7FYVB5U1vu/h/P+dVsoHTP2TK+yCcoTAm1Iguf/pYnUpqLBR1VQOSfV7ecXGGq6swXCOUrsEgSLyI9fEGdJVb2uKHALxCWD02oowViHTVsBzdc4ljmDBd05tiR+KZBRnY2vjYYWQ0dJXwniNU4Sd+Ow6hq4G0Hfg/N3tlODuvug4LxLLU+GGvB8TRzhwNm6LfiIKKtCdJePq66D0lMgdtOa9pEioF64bPJKg/qCqvmgUU6tH0hbp6EQ+nY0B4xNKvWysyMKTIV+qrqlivncdvR+q3RFJMYFyM3/2iuy/iZUTyx01tx5I9/tJEGPCacXf6hApL7jO3QQQ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8114.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(39860400002)(366004)(346002)(376002)(396003)(136003)(451199021)(9686003)(7696005)(55016003)(6506007)(26005)(83380400001)(107886003)(186003)(66574015)(33656002)(76116006)(66946007)(66556008)(52536014)(38070700005)(122000001)(54906003)(82960400001)(110136005)(41300700001)(86362001)(66476007)(316002)(64756008)(66446008)(4326008)(5660300002)(8936002)(8676002)(38100700002)(2906002)(71200400001)(478600001)(4744005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Q1NtS2FCSXJ3K3BleGxFRVQ3VWxJU0VoZE9TK3Q3cnpKOC85Um94Q0dNSFFi?=
 =?utf-8?B?OEpJYUtoZnZlZ3h6SUNhMUd1NWdzL1ZRQ1pYcmU4WGJxOGdWaENNT1MvQVNu?=
 =?utf-8?B?NGhYcW1iNWQrVU4xNTVzZHlJS3A5eDJZeUdwN0l6NEhBQlZhKzRkcW1DUTRj?=
 =?utf-8?B?K2dkWjRRYTRKcGh4WVRDTlA2eVlCb1dsYm1IR2FjTVhrRklGZThuYjQ0VnNF?=
 =?utf-8?B?MndvZXJEcFI5OEUxOXRrbWVVVnoxaGRTUU90RDkvOVBYYXZIK1dZKzhrMTk4?=
 =?utf-8?B?OXFYUVBINElKYWRVMFFtVjZIY0hlbEQxUTZRUFhsd1ZQQitJd2JMQ3praE80?=
 =?utf-8?B?VEFQZDI0OUh1ZERnUGNMa3BKTjFIaGZaK0xKU1NheEMvL2Q3VVFnYXpHN3Fr?=
 =?utf-8?B?UEl3QW53QUkrY2wwZWVSTFFtTjhQWGZWV2w5TFRSbVNnaytVaHlvK0JzRjYw?=
 =?utf-8?B?MEw3S2ZNMnFhbTBzRVlSUXoxQTcrRkZQSHlpMkVhNjJjbmhLQWZJQVBIL2hz?=
 =?utf-8?B?WVY2WTl0YVhsUEU1dDViTmNZTHF1OU1WajNkM0ZPRlZQOVd1ekFuaWJnMjJJ?=
 =?utf-8?B?TzBqM2Y2UTduOUpYRktWNEE4VVdPN3YwNFBpNEI2d3NZWFMxanFkZ2VwM3RP?=
 =?utf-8?B?NVN5MmRCSnI5T00xNUJ4VXZMZHlVS1VLQmlJL1JjcVJ1aGxEV0RTbktQaUNo?=
 =?utf-8?B?MUtkdnU2SkxleG9BM1J1cEFmVHZtRXlSNks4ZmtrMHBUNWpGdUxiOGRXSWZa?=
 =?utf-8?B?bUJUdVkrVXEzRXB6azZVVVR6Wm45WG1QZVpGMXJFSEYzckFwTjRsMjhTZFZm?=
 =?utf-8?B?SFZLOFhCLytvS2xiK1RsMkZFbGU5SFFUTFcvVUVDVjY3b2syUEZFS1RuY0Jp?=
 =?utf-8?B?NVM4UFhDMkdyMGxFYWVaUVlNRkNqaVFkQjNoTzRvTXlveWJ5UFZ3ZitsQXpL?=
 =?utf-8?B?dmRSdDJvZDRGTTZpN1NaZzNHeVAvaFdLSTRzRmpxdm1SVXFkVnNDYzVmUjBs?=
 =?utf-8?B?c0ltT0NUZUJKSGxyQjdQRHNmTURrbEovMmNQMElpbEc5QXZqMmUzdXFRNTBn?=
 =?utf-8?B?dTFjNmswMnVNeWhLeTcxNFZqOFB4WkxxS29GUlBRYkFWZ0VIYXdKRWZnRXhJ?=
 =?utf-8?B?aGc5M1g5ZGVYcHdsS0RXUVRYNlR5aVlRZCtGSmpRRnhnWnNvNzlUUGJRWGdB?=
 =?utf-8?B?TjQvUitwMnhvRGk3V2tmREFEaU1aWlc5K0JlVFpuZUVoNlRtR21iOVdBNXBj?=
 =?utf-8?B?Y0lFUzQwZ3hzUUlldXAwelpOT0lhVXBXVUc0VGNBa1J3SXR5UXZMdTk1eG96?=
 =?utf-8?B?QVNYMGJ6MWsyaUZmc0hlZDMrYlVHSG9oN2VFaVBYOTlOUTIwd0VEMGw1eGND?=
 =?utf-8?B?WnQ3b1kvWHFlZEFjNXprak1GdGVPSEhjQjJXci81UG5UYmNwUnFTSkJRU2d2?=
 =?utf-8?B?bW1mdDVvNEl6VFlvL0FHeFI5czNLWkw3dW9XOFVqTi9Rb3lPc29kTE83QnRu?=
 =?utf-8?B?NWh6eEpLOUNKSnE1WE03TGV6NXYxakl2d1dwcGlSUmRPZncrY0JSR1dJZzNG?=
 =?utf-8?B?amRaWmtJTDJyUzhSeGp2ZjU3blFtR0NPZGFPUFFoKzlSek5sZWF1RlRFV3Y0?=
 =?utf-8?B?NXhHblVocGxBRGlkMWNNNUVvb3JtZ1VJWWNsOWpxd1lTYzZVWFFDbEZOUWJ5?=
 =?utf-8?B?emcxWEwrdFU4YWZpMURVRzlNbU1DOXlkbFNzTi9zajhtK0lUUE1LcHVuaVVC?=
 =?utf-8?B?NmpqT2lRT25yTWJSNVVKWUQzeGxWMEtENk8zaTloc3lleFJFdTBLK2lTY0hk?=
 =?utf-8?B?V2U5cVROa08wYjNzeW4vU01aZ1dlLzJBdjZyZkwyT3dJVHV5L1RuOG1BZ0hQ?=
 =?utf-8?B?TDArcWpGRGpjZFZnaFRTYkVqU2JENUtJWWJ0SFdzZTVWdXRVc1ZhN0l5RUhP?=
 =?utf-8?B?L0owMUkxK1JYMXhxQlNnVjRNZ2hoWDM0ZGxpb1J3VHNZMjNJcmE1dzN6RVBM?=
 =?utf-8?B?c2U4c1BnMkMrRUFoQ3VDSGNMWlBIMTRsdEdEKzBsMW5lVXU4T0s4aFJpSnhr?=
 =?utf-8?B?L1FTckdCdndaQzRpL0xzQ0RDNGpsd2M2REo0clg2L1lOWUphak5GS1hIeDVE?=
 =?utf-8?Q?enIWllms1RkcKex6Rhhek7thb?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8114.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d685a9e-3dbb-4195-e866-08db917a3ebb
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2023 03:57:22.7489 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 63vrKTtv2VaOG5roykVO0lvK1ihuggBsI3YNL9rUXQHgjXjVrI4vyk2QKNf9JWO0agX6HPa+LhuQM8P8NFJIhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB6051
X-OriginatorOrg: intel.com
X-Host-Lookup-Failed: Reverse DNS lookup failed for 192.55.52.151 (failed)
Received-SPF: pass client-ip=192.55.52.151; envelope-from=jing2.liu@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RDNS_NONE=0.793, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

SGkgQy4NCg0KPiBPbiBKdWx5IDI4LCAyMDIzIDQ6NDQgUE0sIEPDqWRyaWMgTGUgR29hdGVyIDxj
bGdAcmVkaGF0LmNvbT4gd3JvdGU6DQo+IA0KPiBbIC4uLiBdDQo+IA0KPiA+IFNvcnJ5IEkgZGlk
bid0IHF1aXRlIHVuZGVyc3RhbmQgImluZm8uZmxhZ3MgYmUgdGVzdGVkIGFnYWluc3QNCj4gVkZJ
T19JUlFfSU5GT19OT1JFU0laRSIuDQo+ID4gSSBzYXcga2VybmVsIDwgNi40IHNpbXBseSBhZGRl
ZCBOT1JFU0laRSB0byBpbmZvLmZsYWdzIGFuZCBsYXRlc3Qga2VybmVsIGFkZHMNCj4gaWYgaGFz
X2R5bl9tc2l4Lg0KPiA+IFdvdWxkIHlvdSBwbGVhc2Uga2luZGx5IGRlc2NyaWJlIG1vcmUgb24g
eW91ciBwb2ludD8NCj4gDQo+IEkgd2FzIHRyeWluZyB0byBmaW5kIHRoZSBjb25kaXRpb25zIHRv
IGRldGVjdCBzYWZlbHkgdGhhdCB0aGUga2VybmVsIGRpZG4ndCBoYXZlDQo+IGR5bmFtaWMgTVNJ
LVggc3VwcG9ydC4gVGVzdGluZyBWRklPX0lSUV9JTkZPX05PUkVTSVpFIHNlZW1zIGVub3VnaC4N
Cj4gDQpPaCwgSSBzZWUuDQoNCj4gPj4gSW4gdGhhdCBjYXNlLCBRRU1VIHNob3VsZCByZXBvcnQg
YW4gZXJyb3IgYW5kIHRoZSB0cmFjZSBldmVudCBpcyBub3QNCj4gbmVlZGVkLg0KPiA+DQo+ID4g
SSByZXBsaWVkIGFuIGVtYWlsIHdpdGggbmV3IGVycm9yIGhhbmRsaW5nIGRyYWZ0IGNvZGUgYmFz
ZWQgb24gbXkNCj4gPiB1bmRlcnN0YW5kaW5nLCB3aGljaCByZXBvcnRzIHRoZSBlcnJvciBhbmQg
bmVlZCBubyB0cmFjZS4gQ291bGQgeW91IHBsZWFzZQ0KPiBoZWxwIHJldmlldyBpZiB0aGF0IGlz
IHdoYXQgd2Ugd2FudD8NCj4gDQo+IHllcy4gSXQgbG9va2VkIGdvb2QuIFBsZWFzZSBzZW5kIGEg
djEgIQ0KDQpUaGFua3MgZm9yIHJldmlld2luZyB0aGF0LiBJIGd1ZXNzIHlvdSBtZWFuIHYyIGZv
ciBuZXh0IHZlcnNpb24g8J+Yig0KDQpKaW5nDQo+IA0KPiBUaGFua3MsDQo+IA0KPiBDw6lkcmlj
Lg0KDQo=

