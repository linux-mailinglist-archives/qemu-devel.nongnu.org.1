Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F054D7F0FDD
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 11:07:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r51BX-0004JA-Ae; Mon, 20 Nov 2023 05:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r51BV-0004HG-1F
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:07:17 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r51BR-0000eH-4k
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 05:07:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700474833; x=1732010833;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZWMkLrmjGvTn5ceXFAxdWe1wKaB6ri9ottcdcacjFh8=;
 b=Hgxyq2ClGtnuMJ2T7DGAYpjS/YSom5G5Xb9JdJsSot8CTOjR8M6inprz
 Vg9HkTdHfHdUcDeybfOS+1S5/xXRM8ZLZ70uFsOwmqREwOqrxYiaphV1X
 RF7sc7gWrsSFSXYmlrQjC0ZLSmYUkCtfJ4UGPClxPfk3Rx3YA8LFUwQhd
 nUIMmmISjpnFSKv+tZGHoI1M6MAvGwjmGIs4l51YfOl/f5gebmUnbneld
 Ad+TTG88Y6Ayt5OyiZpfx6Rk0qMge7bpH8vSJSSd6uMF9Os+uUt6RlR9C
 ZzcxM7VKmI9ec8LO5LgO0cYSAKula41fs8fNzmiYkV2q747rOaBMonpv7 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="455916385"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="455916385"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Nov 2023 02:07:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="795428776"
X-IronPort-AV: E=Sophos;i="6.04,213,1695711600"; d="scan'208";a="795428776"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 20 Nov 2023 02:07:08 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:07:07 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 20 Nov 2023 02:07:07 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 20 Nov 2023 02:07:07 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 20 Nov 2023 02:07:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gedbi4ZZFNZoMhV+Vcd8HFZaG0epu9sXpTOymSaCh3Zdfmw/1lpPD/KXO04ccYXQh24ySGfei9Fb4jI6llSZ0Ev8AWNmsQNWi5alMiUxGknA63Due5VMmQXFW/pMA0pZkBhUH+tSoMfdE5q8g1guB3+zfmR+8kTw8TsLpUB1/y4sQBaWtGR+WWOnfEdO4h1t9L9zkpmL0X/pl5HFoz1SNoKWCs1pIv327df1cNQDpAgoTFgVhPh86wxhdF0rMPrQxR9NWQ1S4Rq/1IFlPIKXEGlA6fq2kVNlxjjxnM0dvNvL8spmcbodoQ5Ifjyh/ibistq1uFi1SE9W0uNZvP5MFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZWMkLrmjGvTn5ceXFAxdWe1wKaB6ri9ottcdcacjFh8=;
 b=UKpmnUnmAzW18RkLvfokIvCVDH6J84e/PXqRfcH1w1R4Rx46V7rmDlN8NdwwKiCPPRfwMG89UnceQNIT0xH3T6d1CecZGBedva7IWFi3C6VoKMKNHH62n2mid+YP9oyTmLmBE7PTXv9qCyOmDNQu4EOf3rIzBwz+pY+m1mZM73xpK2f5+5WThpmX5fxOy4YaI1WJbtD2flwmRfIKXrxWWONWy48JQNpj2Gm3KyDgV0JdyfG24fCuSp0oeC+6CYe9aFH6Q3BMjdoAt2QegAdY83OS6d1D186XGgEuXouOfMdpjpKLnlwE8lXcP1svSnyWoAaIlS9lOm3mlqsJDaUgdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB8183.namprd11.prod.outlook.com (2603:10b6:8:161::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.27; Mon, 20 Nov
 2023 10:07:05 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.025; Mon, 20 Nov 2023
 10:07:05 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "peterx@redhat.com" <peterx@redhat.com>,
 "jasowang@redhat.com" <jasowang@redhat.com>, "Tian, Kevin"
 <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Gerd Hoffmann
 <kraxel@redhat.com>, "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 "lersek@redhat.com" <lersek@redhat.com>
Subject: RE: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v6 01/21] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaFuTq+kqpFvBx/0+jXWJho7L/CbB+X2AAgAAFFfCAACIGAIAAB2wAgAQAf1CAAFnbgIAAFZjw
Date: Mon, 20 Nov 2023 10:07:04 +0000
Message-ID: <SJ0PR11MB674445FEAD689AF8B5A8A42B92B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231114100955.1961974-1-zhenzhong.duan@intel.com>
 <20231114100955.1961974-2-zhenzhong.duan@intel.com>
 <c964fdf3-d6ef-40cd-b4c0-32f1fb8501ae@redhat.com>
 <SJ0PR11MB6744B1B91C890A9A1B81E89792B7A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <248389a7-3f89-42ae-98e7-34d6612cf186@redhat.com>
 <c0c265d6-aaea-4071-b280-b93df459165e@redhat.com>
 <SJ0PR11MB67444672699A62007207FB3492B4A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
In-Reply-To: <ebc65641-4597-4679-8214-0f4555f9bd21@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB8183:EE_
x-ms-office365-filtering-correlation-id: 74ba2da3-c18c-4609-ae51-08dbe9b07251
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CfzhABLQG2KaFz/tEvX+wKCl1jBzGWZaEIJmFv1thDfuOb9vo18KK495sH+rA52msur85YgDtXEstr24951p937m/AEL9ztJdgzxirYKavZZ+JITaNvpGoQLOSKfCWhF7Ooj1vfrZNgISbkssaj/sA8TFoSq1ZqIfGfyvdJr+4yfuWrbQZ0mUIe7lgWSBNh5zkt/PMKDNQXdZD3RNxbQBB/OcG+B+Tjq4OaXWL3Mp1Sbyn4M8669qfxSsJpgSRvQz7BJMd2sYN1BsFwjbT2d3ejChmSEC+bcuS6BS9LNvSdclnlqFyWFM+piEyQGvYSIgyDMU3eUgye6BDMq7GRYJ35beMjVAd0thrgaN4JHr9kJx7vEfWwIpCwX0Ny4nZQDLS22RTq/yfkFm2kvhB56D1XOyTxEC+AF+1+vfKxXXMr4OQyLpeKds8BV8lAbDWqTA2n+jVhKEwLuPaTG0tQmtWE0wNZg+cjfFqKkQPDI98gzDpIUdcqFDtgIHMK/qzqzSDK29ShdBDsF1bhkJC50kCsOMzTHqNTWC2iTeKRlhWKdY1R3dzefiqDWSWxxtgH8JaWYI9YI6WOy99ABbji4jAx/pAFkJ0QC20EJxH8sr8mZFYl9YhMeLOhnjqhukOY1sr4RS+RrXxNUC3OCGbvOcQ==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(376002)(346002)(136003)(396003)(39860400002)(230173577357003)(230273577357003)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(41300700001)(86362001)(7416002)(52536014)(5660300002)(33656002)(2906002)(38070700009)(66574015)(9686003)(6506007)(478600001)(82960400001)(7696005)(71200400001)(83380400001)(966005)(55016003)(26005)(38100700002)(76116006)(66946007)(110136005)(316002)(66556008)(66476007)(66446008)(64756008)(54906003)(122000001)(8936002)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UE96elNjNUMzNXVzR1Yzb1l3SXhoNFB2THNqVFg0V0VUWXd2blNJV2pIcDNP?=
 =?utf-8?B?b3h4aVFKQytmVFF2dGthbkRvNm9OVENDRGxTbkdMWlFIcUc1c3o2WWVtSk1E?=
 =?utf-8?B?aDEvQ091UE5jOTNlVk5JaGovZFl4L2xIVmE1alFINGlCT015VmxzbHdRUTBP?=
 =?utf-8?B?eDJRWEZYTE1ZcnlJSjd3OGhKWXB1eC9XMEdoZEJMQlNnT3BvQzF5TElPWFVy?=
 =?utf-8?B?MkMxU2xZTGNaZDFsbWg1RG4ydFNsTkRnSXU0ejhSam54SlRCYTlmWU1VNkRr?=
 =?utf-8?B?d0daM0R3Y1JyaHpUZmpxZUEzMGNSMTFqLzJlV2EwUU5wc1EwVUh1aUI2UXNo?=
 =?utf-8?B?TG5WUzBrV095alRQakF2bkdEbnJneGdpcHhyR0FqSFVWZjFKako0ZXoyMTJV?=
 =?utf-8?B?M1V3b0EzcHZsN082Q245ZkFzc2hPS3Q1NnQ2NXJhcGFnVk40S0F0aFdIYkhi?=
 =?utf-8?B?QVFqZTd5UjU1aGthQnJPaVpVejBjOVFTeFB0UmVaSll1MVJVVTZVYzVJYXFS?=
 =?utf-8?B?cXd1ZG9xa0MyeWduRkt0aU1ncXFiMERMVUFDWTFuclZ1OWJFZjllT1luWDl1?=
 =?utf-8?B?cjJvSDBSRXAvMmZQNXRydjhhbnJRdzhmR3JjVy9udUVMZlJ1RGIwTXkvbmlm?=
 =?utf-8?B?ZnkzZUsyNjJTM3I1WWZIQmc0b1VldU8yZkh4VGJ6S0xzTzNDWWlrVlBIbDJK?=
 =?utf-8?B?Q0I5TW5GUm05VGZ2WFU2Sy9wNFBiQk43dEJpYzliYk82MTJXVnU4S29SaVAw?=
 =?utf-8?B?YW9rK1c2c3NjL2FWcC95V2NvaS92OU1RWkY0M1VTdGpmRXdTcUtWV3JVWExn?=
 =?utf-8?B?WCtQMm1oZzlSSytjMXpFeTA5cVZVdWdLNVRvN0ZvNld1eVpWMm42cWVBeHNE?=
 =?utf-8?B?QTVvSFJIUktSdDFEZEpXZUZ1TC9aMlNBOFNQbDRNMFBYTHNmVTJDMVFuSndJ?=
 =?utf-8?B?a0lzM3NoNW9MTmZ3dVozT0M1ckliZ3FsclErQnIrRzhnVndaeEswWFZXRGlF?=
 =?utf-8?B?dXQwVW12ekNFMWlVcjgzUjlMdHNCWkRrUm4rNFM2MWRrSDJpU0IyWC95OXd2?=
 =?utf-8?B?RkJma1pkVC8zSEVnTTY2QkJYdElUSjM3cm93Q1hoOWR1SXYzM2h6clZZb0Ur?=
 =?utf-8?B?SVhFWHZrc3RNbXAwcldMVkxrZVl5ZGVsN0NacWRjQ2loRjZQNVNDV2M3ZXhn?=
 =?utf-8?B?Wm5idlFkWm9YbER0ZzFiZGRPS2pDMWhhL0JOVStmUnhjWXc4MVU5dU1FUDJa?=
 =?utf-8?B?dER0U3F6ck40bVU2SmYzd1N3aFBmZmpBbVFEVWg1VlgyTm5GV1dsR2dXOVRN?=
 =?utf-8?B?YXY2ZmsrUGYwMkdGZks4TUhuSzJsaFVoeUNUdlExTy84WHVFdC9iaDdBK2Vr?=
 =?utf-8?B?OVhCNUc2czArK1V5N1NvZGlqeEgrUVJpTEhsVGRRZjFwazFJdGdRa2RqaVNJ?=
 =?utf-8?B?K0ROMUxZSnJraFBNOWR5WHBsNVplT1grUzhRYmRwTWpldkNkVlBST1U3M2JR?=
 =?utf-8?B?c0hyaG9wd01UZXFYcWdRYmduOUpvYVFERkh2MllHSmp2c0pYaWp2RFl2YWdR?=
 =?utf-8?B?Mm4vLzNva3FlOWV5MWlhTnRKMGgrc1NVMHA2UzRxNG9WQzM2WnpFRlVwUjk4?=
 =?utf-8?B?dzM2enBPNXh0WjVCQ3lXenZacndHNzBWb1BTeG1Udmt5S1hkSjNRUGRHdUhB?=
 =?utf-8?B?bXNGbk02bG9ROEFFWFFWbUNtZDIrcm83c2ZrRU9qT2xQcndoSXNDYllBUzV5?=
 =?utf-8?B?UFBGeUlRcmpVVGRSa1AxRWoyR2c0bU04bGt4NWZSWFdCNFhNeFFRTzZhUUZp?=
 =?utf-8?B?Vm16QjduSjFoTWxLemVSWE4wVGhYQmZmN1FqdzNhSWpNWTFwQ0liTy9pZm9E?=
 =?utf-8?B?R01jektuVjJJNzRuSXJkZ05wS3NEVTUyK3hEUWNWNUdiejMvcmRlMENLTzNn?=
 =?utf-8?B?QU1WaTBoRk84N0tGdmQ5ZC9PRGZBb0U1SnhEYTROMTliUHhkN3M1K3IzTWxL?=
 =?utf-8?B?WDVrTEc2eE51M25zdkNKRVV6SXJabk91TXZKWFV3bDJ5T0dBdHBXdzBqS2d2?=
 =?utf-8?B?NFBFQ3VWZXhPVzNUZHhtSVhyMWNsYTNzYWZ1Nlh2bFVtbWVIYVlqbFEyczd4?=
 =?utf-8?Q?dzvePJPXHP8P5ZKuRFhj2bN6E?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74ba2da3-c18c-4609-ae51-08dbe9b07251
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2023 10:07:04.4299 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1uxaHskHokmHeYsQD4Y/Gq4cUUJ9eF+JO+LTUi8tifZDExC5iPqchwHvgzyIKt6a1SZemAMLXv7PXfDLMxzspuKK1b6KpY1p3eZsD3SdIsk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8183
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.31;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

SGkgQ8OpZHJpYywNCg0KPi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogQ8OpZHJp
YyBMZSBHb2F0ZXIgPGNsZ0ByZWRoYXQuY29tPg0KPlNlbnQ6IE1vbmRheSwgTm92ZW1iZXIgMjAs
IDIwMjMgNDoyNSBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0ggdjYgMDEvMjFdIGJhY2tlbmRzL2lv
bW11ZmQ6IEludHJvZHVjZSB0aGUgaW9tbXVmZCBvYmplY3QNCj4NCj4+Pj4+IEEgc2ltaWxhciBp
c3N1ZSB3aXRoIGEgZml4IHN1Ym1pdHRlZCBiZWxvdywgY2NpbmcgcmVsYXRlZCBwZW9wbGUuDQo+
Pj4+PiBodHRwczovL2xpc3RzLmdudS5vcmcvYXJjaGl2ZS9odG1sL3FlbXUtZGV2ZWwvMjAyMy0x
MS9tc2cwMjkzNy5odG1sDQo+Pj4+PiBJdCBsb29rcyB0aGUgZml4IHdpbGwgbm90IHdvcmsgZm9y
IGhvdHBsdWcuDQo+Pj4+Pg0KPj4+Pj4gT3IgYmVsb3cgcWVtdSBjbWRsaW5lIG1heSBoZWxwOg0K
Pj4+Pj4gIi1jcHUgaG9zdCxob3N0LXBoeXMtYml0cy1saW1pdD0zOSINCj4+Pj4NCj4+Pj4gZG9u
J3QgeW91IGhhdmUgdGhlIHNhbWUgaXNzdWUgd2l0aCBsZWdhY3kgVkZJTyBjb2RlLCB5b3Ugc2hv
dWxkPw0KPj4+DQo+Pj4gSSB0ZW5kIHRvIGJlIGxhenkgYW5kIHVzZSBzZWFiaW9zIGZvciBndWVz
dHMgb24gdGhlIGNvbW1hbmQgbGluZS4NCj4+PiBJIGRvIHNlZSB0aGUgZXJyb3Igd2l0aCBsZWdh
Y3kgVkZJTyBhbmQgdWVmaS4NCj4+Pg0KPj4+IEhvd2V2ZXIsIHdpdGggdGhlIGFkZHJlc3Mgc3Bh
Y2Ugc2l6ZSB3b3JrLWFyb3VuZCBhbmQgaW9tbXVmZCwgdGhlDQo+Pj4gZXJyb3IgaXMgZGlmZmVy
ZW50LCBhbiBFRkFVTFQgbm93LiBTb21lIHBhZ2UgcGlubmluZyBpc3N1ZSBpdCBzZWVtcy4NCj4+
DQo+PiBZZXMsIHRoaXMgcmVtaW5kcyBtZSBvZiBpb21tdWZkIG5vdCBzdXBwb3J0aW5nIHAycCBt
YXBwaW5nIHlldC4NCj4NCj5PSy4gU2hvdWxkIHdlIHRyYW5zZm9ybSB0aGlzIGVycm9yIGluIGEg
d2FybmluZyA/IFRoZSBjb2RlIG5lZWRzDQo+YXQgbGVhc3QgYSBjb21tZW50Lg0KDQpNYWtlIHNl
bnNlLCB0aG91Z2ggSSdtIG5vdCBjbGVhciBpZiB0aGVyZSBpcyBvdGhlciBjb3JuZXIgY2FzZSBy
ZXR1cm4gRUZBVUxULg0KSSBwbGFuIGJlbG93IGNoYW5nZSBpbiB2NzoNCg0KZGlmZiAtLWdpdCBh
L2JhY2tlbmRzL2lvbW11ZmQuYyBiL2JhY2tlbmRzL2lvbW11ZmQuYw0KaW5kZXggNTNmZGFjNGNj
MC4uYmE1OGEwZWIwZCAxMDA2NDQNCi0tLSBhL2JhY2tlbmRzL2lvbW11ZmQuYw0KKysrIGIvYmFj
a2VuZHMvaW9tbXVmZC5jDQpAQCAtMTc4LDcgKzE3OCwxMyBAQCBpbnQgaW9tbXVmZF9iYWNrZW5k
X21hcF9kbWEoSU9NTVVGREJhY2tlbmQgKmJlLCB1aW50MzJfdCBpb2FzX2lkLCBod2FkZHIgaW92
YSwNCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmFkZHIsIHJlYWRvbmx5LCBy
ZXQpOw0KICAgICBpZiAocmV0KSB7DQogICAgICAgICByZXQgPSAtZXJybm87DQotICAgICAgICBl
cnJvcl9yZXBvcnQoIklPTU1VX0lPQVNfTUFQIGZhaWxlZDogJW0iKTsNCisNCisgICAgICAgIC8q
IFRPRE86IE5vdCBzdXBwb3J0IG1hcHBpbmcgaGFyZHdhcmUgUENJIEJBUiByZWdpb24gZm9yIG5v
dy4gKi8NCisgICAgICAgIGlmIChlcnJubyA9PSBFRkFVTFQpIHsNCisgICAgICAgICAgICB3YXJu
X3JlcG9ydCgiSU9NTVVfSU9BU19NQVAgZmFpbGVkOiAlbSwgUENJIEJBUj8iKTsNCisgICAgICAg
IH0gZWxzZSB7DQorICAgICAgICAgICAgZXJyb3JfcmVwb3J0KCJJT01NVV9JT0FTX01BUCBmYWls
ZWQ6ICVtIik7DQorICAgICAgICB9DQogICAgIH0NCiAgICAgcmV0dXJuIHJldDsNCiB9DQoNCkkg
ZmFpbGVkIHRvIGNoYW5nZSB2ZmlvX2NvbnRhaW5lcl9kbWFfbWFwIHByaW50IGFzIHdhcm5pbmcg
YmVjYXVzZSBmb3IgbGVnYWN5IGNvbnRhaW5lciwgaXQncyByZWFsIGVycnJvLg0KU28gcHJpbnQg
YWZ0ZXIgZml4Og0KDQpxZW11LXN5c3RlbS14ODZfNjQ6IHdhcm5pbmc6IElPTU1VX0lPQVNfTUFQ
IGZhaWxlZDogQmFkIGFkZHJlc3MsIFBDSSBCQVI/DQpxZW11LXN5c3RlbS14ODZfNjQ6IHZmaW9f
Y29udGFpbmVyX2RtYV9tYXAoMHg1NjBjYjZjYjE2MjAsIDB4ZTAwMDAwMDAyMTAwMCwgMHgzMDAw
LCAweDdmMzJlZDU1YzAwMCkgPSAtMTQgKEJhZCBhZGRyZXNzKQ0KDQo+DQo+PiBTbyBFRkFVTFQg
aXMgZXhwZWN0ZWQuIE1heWJlIEkgc2hvdWxkIGFkZCBhIGNvbW1lbnQgaW4gZG9jcy9kZXZlbC92
ZmlvLQ0KPmlvbW11ZmQucnN0DQo+DQo+WWVzLiBJdCB3b3VsZCBiZSBnb29kIHRvIGhhdmUgYSBs
aXN0IG9mIGdhcHMgYW5kIGVmZmVjdHMgaW4gdGhlDQo+ZG9jdW1lbnRhdGlvbi4gU2VlIEphc29u
J3MgcHJlc2VudGF0aW9uIGF0IExQQy4NCj4NCj4NCj5odHRwczovL2xwYy5ldmVudHMvZXZlbnQv
MTcvY29udHJpYnV0aW9ucy8xNDE4L2F0dGFjaG1lbnRzLzEyOTcvMjYwNy9MUEMyMDINCj4zX2lv
bW11ZmQucGRmDQoNCkkgc2VlLCBQQ0kgUGVlciB0byBQZWVyIGFuZCBQT1dFUi9TUEFQUiBhcmUg
cmVsYXRlZCB0byBxZW11IGlvbW11ZmQgaW1wbGVtZW50YXRpb24uDQpGb3IgUE9XRVIvU1BBUFIs
IHdlIGhhdmUgIlN1cHBvcnRlZCBwbGF0Zm9ybSIgc2VjdGlvbi4NCkJlbG93IGFyZSBvdGhlciBn
YXBzIEkgY2FuIHRoaW5rIG9mIGZvciBub3c6DQoNCkdhcHM6DQoxLiBkaXJ0eSBwYWdlIHN5bmMs
IFdJUCAoSm9hbykNCjIuIHAycCBkbWEgbm90IHN1cHBvcnRlZCB5ZXQuDQozLiBmZCBwYXNzaW5n
IHdpdGggbWRldiBub3Qgc3VwcG9ydCByYW0gZGlzY2FyZCh2ZmlvLXBjaSkgYXMgbm8gd2F5IHRv
IGtub3cgaXQncyBhIG1kZXYgZnJvbSBhIGZkLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

