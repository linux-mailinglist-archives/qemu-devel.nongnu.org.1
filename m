Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 107C97E33D9
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 04:13:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0CQi-0001ip-EJ; Mon, 06 Nov 2023 22:07:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0CQe-0001Vl-U0; Mon, 06 Nov 2023 22:07:00 -0500
Received: from mgamail.intel.com ([134.134.136.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0CQX-0001Fn-Ux; Mon, 06 Nov 2023 22:07:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699326413; x=1730862413;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=mCSUFkV60t4Xqvzn7KLiirItJKzy2zmmELo7sGVCMXs=;
 b=eBbFCCAu/MV3lspkvboQOA1tZL2qhcG9Iw2xIodHKfbrfGD7EFL51Dev
 qSD4c1qeYxgcwSA2PlV7cHDQUjZ6DxcalxV3Clqbo6xk+zAv91hFKg2jL
 1X/sJnFPHTiTm08ofv2rrq1N4dEl2mi+muRbhqWSs7NSqcsmt1SFnQ+5e
 hF2qTpe2RBijeeMIA6jkM9Umf2JdbwBS+F6++qMPJO0ND09vXU4HdZrId
 xcxRG+REytu7dVgWkkVtdRvX1IJKXymeflh+4yq7j7f95EZDyCIwgTVJc
 ha9wctutMm5t5GcWlvdlGWXPkGsU0voWNVjyb89jUB2cdSOXEdNV7nk/L w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10886"; a="453728703"
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; d="scan'208";a="453728703"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2023 19:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,282,1694761200"; d="scan'208";a="10664854"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 06 Nov 2023 19:06:44 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 6 Nov 2023 19:06:43 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 6 Nov 2023 19:06:43 -0800
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.41) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 6 Nov 2023 19:06:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V94u01FdXvzZXUi56bGmSE+SNJIaXtTlOSEpFUjQbdr+3HNz1KBL3krkZZ0u9pPEwCF9pJIhTrdI/9SnBguZ06JgwSzsG+TPKIueCDuZ+sOOyZSlrWud8NiLY6GUV5NG0hFA7rTgLeYFk26AEjfTTo59zG8lMFikDIhFWQA4FYJAMzG5/yVl82A0cA4FuHUzQi1Duq/FiFIR4pBSIdbAOlXo3BRaqZGWZq0MDslPsJLKfkaJmPAl8VO5XBfCUL6C9YTB+C4AGKLi8JCpFAPcHjN8ns8/fc9Yq5U+Q8sHMGYSitmBwVEXCquzUiy2k3D5ZboTjTnBOG36y9dKy9RwKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCSUFkV60t4Xqvzn7KLiirItJKzy2zmmELo7sGVCMXs=;
 b=ikFurOcVNXe5puC31ZC3Bv9aTbbPpXf+IEhyEPeMiBiLdpdx3wqeZ1diVQWtZPQGAGRr+sfKI3HZbBPVrtYb9w6NIMawh/YYZAoLb2wimgzR6HCygrhJKErfRQMhywTGKjk1kax+QW8ndRkr+vy+/M7hfpJV+fysCKVNiUdn3Afzlfpmf+8st+7mxzqPj0qon3rOS2bL9OjVjyJFTfBLLuVzTsonxmEpKIUuSlWXWuZUCa6VoRISm3rJcH9/6q1DR0wRRCZdphBgoDbTvD6HquJ06J6UhgcVGaAXwsQTg62LqLmNOWn+XpgovFAtV2dHfRW72z/HxD2PkzZB/Ox8yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DS0PR11MB7851.namprd11.prod.outlook.com (2603:10b6:8:fb::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Tue, 7 Nov
 2023 03:06:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Tue, 7 Nov 2023
 03:06:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Nicholas Piggin
 <npiggin@gmail.com>, Daniel Henrique Barboza <danielhb413@gmail.com>, "David
 Gibson" <david@gibson.dropbear.id.au>, Harsh Prateek Bora
 <harshpb@linux.ibm.com>, "open list:sPAPR (pseries)" <qemu-ppc@nongnu.org>
Subject: RE: [PATCH v4 22/41] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
Thread-Topic: [PATCH v4 22/41] vfio/spapr: switch to spapr IOMMU BE
 add/del_section_window
Thread-Index: AQHaDV5qKFOHF3TjUUK9jtksnODUp7Btk/SAgACdx8A=
Date: Tue, 7 Nov 2023 03:06:39 +0000
Message-ID: <SJ0PR11MB67440CDA57F75F3BAB9A60F792A9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-23-zhenzhong.duan@intel.com>
 <42508355-9891-4d20-96fe-c470bc7d9747@redhat.com>
In-Reply-To: <42508355-9891-4d20-96fe-c470bc7d9747@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DS0PR11MB7851:EE_
x-ms-office365-filtering-correlation-id: b1772c0e-45c7-413a-efc1-08dbdf3e8f86
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +W9+zsigO3x1oeDRFRCiOkqjv1B2M38sZxhl4BsLf2QL40u3l5qin512u+XauB26aR4OQ89r1CXk5VEeZWQOe+lDhTBNdKCmWmx06HJybV8jW9vXc6KjtoivoHyjtLjcjxtdZeT+3eNW9MTXpRmNWU++enoAwBKWq2M5gSJ7Vrc9/9o2JFeetJHbCg/XA1l1BL+OimuQuOuHK9ggEkz4gANnpEdl1kDc5aC2J9FARbx8X27LpzrGY9/iZrEEb8j2MU1sUOokIU+CAfK1JGou7ODPrpF2TSoSHlzsfaxxR7Min2nHfzvIPh879WukqCMUWY+YwOMNVUs9aPHryVLYDWUoHdYeZXjWTQkLkLWW5tcrXjcvF7Fb+WZ2UbRdR/uRycQAprr2PN5yoabmrQQ7zaQOeABiU2sBaBteMliuPPyfgmt4MeF9haqb3rS8Kw0mE14ATmL/hafM80y22ax/35JAPwfdMxxkH7k8sNV9jBeL1NDjM3rhc5YM0ufd98OZUGwpo9Y5iUFpsIvD4IOe8bQ+WbDbs8CxsUgTaHMp6g0fWu6FTGjRjp42COJ6HqWtMuHRhg91mu+SYTbGZuUbrtj0Zl03a2baMWCM46etuJt2/NWvYYrMTFL5tkryXqA1
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(39860400002)(136003)(366004)(346002)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(38100700002)(7416002)(5660300002)(41300700001)(2906002)(86362001)(38070700009)(33656002)(122000001)(82960400001)(478600001)(7696005)(83380400001)(9686003)(66946007)(76116006)(110136005)(26005)(316002)(66476007)(54906003)(64756008)(66446008)(66556008)(71200400001)(55016003)(6506007)(8936002)(8676002)(4326008)(52536014);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SU5ib2x1THZrdEhHdW5nVVZwSjRpTG9RSkNUS21mYzc1M2V2Q1JNRDhCZW43?=
 =?utf-8?B?WG1RMUF1UGVxZTVCUVRLcFBOQ20rbFVtR0ZqaE9TekhXUFlBaXJySTRhZ1lW?=
 =?utf-8?B?ckVoTFJCY2RZZUNGVXRrM1hrVjZJN3Y3OGJ1eXhpU0p1ZjZ5aENNcFZjN29P?=
 =?utf-8?B?a1FvZWd4dWcyVGJwYURDdkRlLytjNUZKanR1YWZNM0NoRkpFNFVLa1JUM3Jn?=
 =?utf-8?B?L3drUzN3S0RkRWxnS2VpYXdQRjRxbExnRXl6cW9KdzVuWjRsaTZIOXJMREps?=
 =?utf-8?B?L3hqY1crRnhRcXVKL0M0ckVkSllkeFVtbjByRitGNXR3dHpxRGxkeFBDbDNu?=
 =?utf-8?B?WkYxbFZwVXZrR1lFVjU4Q25MUnArVTJyNGNmeWw5RVViRDRBQVFFYWpIWUZS?=
 =?utf-8?B?R0tRYjU2T2FEU0tnLzFMWlQvMlpPSE82aWhBZEVrWUk0ZFRSR1Vvd1ZITDNa?=
 =?utf-8?B?MEJBWHZWM1RrbjV3cktLU2libTN4eHpCSUtDN3RUVjZzRngzQ04zbmNaWEx1?=
 =?utf-8?B?a1gzUlV4L0s1Sy9mSlY4S24zRHVZZDhOR0lEREpqZDFXb3pLUk1mTExpVlNG?=
 =?utf-8?B?SUl1dmVnQVVUaWVJNjl6RVdaa2IrdVB3NVUzMVloNkcrU1BpeUZ5aml6QXRh?=
 =?utf-8?B?MmJnaEVOVC9aVHBuS0RqWjAyUFdGV1ZMQWZBTWV6WHNxZ2ZhbFNMV3pHdlZs?=
 =?utf-8?B?am1nVDdvZHNJa3M2eEt0Tmo4NE0vN0dqRmQ5S21ValdFRHNWTzBKazFYMlla?=
 =?utf-8?B?OTBFUkEyKzIxTXEzRlRnQlZ5KzdaYU9TSXYvbllpVjE5T0NSOHdVV1F6aXpk?=
 =?utf-8?B?RENVVGxZZjhFRldrMWVLVVZrWmVwbG9WaEVYcFIvNG1Rbm5PSjFFd3ZWRXB6?=
 =?utf-8?B?ZmZCRktweUZFcDQ2K2Rxcjhuak55WEM5NlhETHVCSlBScklDTWNOdTFlN3NI?=
 =?utf-8?B?YThQUXVKbUNlSk5TWHlRTUNla1hBMVphcTlIWHJrSDVOOGQwRHE0dnpVZk93?=
 =?utf-8?B?bEY0OG00a2Ftb0d1OHloYWNVcE0vbVRvSENDSmxYZVpCSlhQRkZHR0hKNVM5?=
 =?utf-8?B?c3pGY2ZVYlNSSkNBK2FyTHpibTR5TVc3NmNHUDZZcVJ1K0NPVmdUbWRmbFo5?=
 =?utf-8?B?WVEzQyt1U1BiQlM2cDZ4c0NReTE2QkIxVW5BNjRac2lTVjZocmkvYkNoZ0Jh?=
 =?utf-8?B?QlJkMVppL0VoRXAxSVhxek9MWHFYR1Q4RFFwTmtneWs3S0dEaTZyNDdidkJY?=
 =?utf-8?B?bUJra01vY1pDVW5ibXZmMG8yK1kxSWxLeis0Q0VGU1lQVFFpM1VNNlRrL1Ba?=
 =?utf-8?B?L1lNeDZGYmQvT0Fha2JvNWIvaS85LzhIQTVYc1pUQnErOFU3QmtUTFQ2a0xX?=
 =?utf-8?B?OTdOaU9uK0pBS01iY0VHTXVtM1NRMm5VWVJzN0tyZjhjVlhqVWZOZFZtazlI?=
 =?utf-8?B?OXpzdFdVcDJ2UGpvSnRuNGxEL3hJeDdkS0U3eXFxdnd6VkZScDVjeFV0WWZy?=
 =?utf-8?B?RUxMR3hxUWsxQjJZUXMxSWxuQ3VKdkRUaDFUNDhFZktLbmU1clYydmkxUWts?=
 =?utf-8?B?a2pEa0l2YklUbjhnWHN4Z2dIQURJN2VNdUM4S3ZEYmpVTzRHQnUwbyt6T1di?=
 =?utf-8?B?dnhXZGJEQXhwUjRJbnE4bjd5RmhZaTM5Vlc0NEhEcW9sUFBVU01vQ2dwY2Jv?=
 =?utf-8?B?ekk4SGNXemszLzJmMFhuRzdkV25JbGZjUXBlNkJWeEo0c2dnWkROcHRybU5x?=
 =?utf-8?B?djJJWlh0R2Z0TDkwb2p3c29VcTNxTGJlNG0xR0tPdGJ0UmJJaWduYVg4SEhC?=
 =?utf-8?B?THdCK05mMEF1bW5NaTZIc3U4eWZmRTNpNVBHa0RtcEs5OUJLOCtnbzc0a29G?=
 =?utf-8?B?NTBlcXZOZmQ2dUJkOFM4ZEZZTWNpcHJ6RUN3MHhVb2hzL0pWV3pKSHR2cUJ4?=
 =?utf-8?B?aUJJSEhtMjhoSmJiMXZ3NldGUXpScXJwdUFNMGhjbmxBUCtWSFV1K1IvenNI?=
 =?utf-8?B?cnErTjM4bjUwTUV0T1R1ak8ybGFBUm5rV3BIbmZSMHdXcENRRUFJSmltcXZO?=
 =?utf-8?B?eEx4NTNSUldya2FoTUN5bGhjaXc3b2s4RWIydUM3b29mYkFyL2V4OXA4QklT?=
 =?utf-8?Q?JLvdzMyZYAiMDQPAXcEPBvNmJ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1772c0e-45c7-413a-efc1-08dbdf3e8f86
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 03:06:39.1903 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3j25Uyx1S74KgL0BfY8ekCkfvI2RNCrkPuSd2uzqAkyuhV/tlrHoSA2UmxKalqvZrP8+Lma2qoGZFxwHCu7D5oYyS7s3p62HUlUAPgprGX8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7851
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA3LCAyMDIzIDE6MzMg
QU0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDIyLzQxXSB2ZmlvL3NwYXByOiBzd2l0Y2ggdG8g
c3BhcHIgSU9NTVUgQkUNCj5hZGQvZGVsX3NlY3Rpb25fd2luZG93DQo+DQo+T24gMTEvMi8yMyAw
ODoxMiwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBObyBmdWNudGlvbmFsIGNoYW5nZSBpbnRl
bmRlZC4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1
YW5AaW50ZWwuY29tPg0KPj4gLS0tDQo+PiAgIGluY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5o
ICAgICAgICAgfCAgNSAtLS0tLQ0KPj4gICBpbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXIt
YmFzZS5oIHwgIDUgKysrKysNCj4+ICAgaHcvdmZpby9jb21tb24uYyAgICAgICAgICAgICAgICAg
ICAgICB8ICA4ICsrLS0tLS0tDQo+PiAgIGh3L3ZmaW8vY29udGFpbmVyLWJhc2UuYyAgICAgICAg
ICAgICAgfCAyMSArKysrKysrKysrKysrKysrKysrKysNCj4+ICAgaHcvdmZpby9zcGFwci5jICAg
ICAgICAgICAgICAgICAgICAgICB8IDE5ICsrKysrKysrKysrKysrLS0tLS0NCj4+ICAgNSBmaWxl
cyBjaGFuZ2VkLCA0MiBpbnNlcnRpb25zKCspLCAxNiBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29tbW9uLmggYi9pbmNsdWRlL2h3L3ZmaW8v
dmZpby1jb21tb24uaA0KPj4gaW5kZXggYjllNWEwZTY0Yi4uMDU1ZjY3OTM2MyAxMDA2NDQNCj4+
IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbW1vbi5oDQo+PiArKysgYi9pbmNsdWRlL2h3
L3ZmaW8vdmZpby1jb21tb24uaA0KPj4gQEAgLTE2OSwxMSArMTY5LDYgQEAgVkZJT0FkZHJlc3NT
cGFjZQ0KPip2ZmlvX2dldF9hZGRyZXNzX3NwYWNlKEFkZHJlc3NTcGFjZSAqYXMpOw0KPj4gICB2
b2lkIHZmaW9fcHV0X2FkZHJlc3Nfc3BhY2UoVkZJT0FkZHJlc3NTcGFjZSAqc3BhY2UpOw0KPj4N
Cj4+ICAgLyogU1BBUFIgc3BlY2lmaWMgKi8NCj4+IC1pbnQgdmZpb19jb250YWluZXJfYWRkX3Nl
Y3Rpb25fd2luZG93KFZGSU9Db250YWluZXIgKmNvbnRhaW5lciwNCj4+IC0gICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24sDQo+
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApOw0K
Pj4gLXZvaWQgdmZpb19jb250YWluZXJfZGVsX3NlY3Rpb25fd2luZG93KFZGSU9Db250YWluZXIg
KmNvbnRhaW5lciwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBN
ZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uKTsNCj4+ICAgaW50IHZmaW9fc3BhcHJfY29udGFp
bmVyX2luaXQoVkZJT0NvbnRhaW5lciAqY29udGFpbmVyLCBFcnJvciAqKmVycnApOw0KPj4gICB2
b2lkIHZmaW9fc3BhcHJfY29udGFpbmVyX2RlaW5pdChWRklPQ29udGFpbmVyICpjb250YWluZXIp
Ow0KPj4NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3ZmaW8vdmZpby1jb250YWluZXItYmFz
ZS5oIGIvaW5jbHVkZS9ody92ZmlvL3ZmaW8tDQo+Y29udGFpbmVyLWJhc2UuaA0KPj4gaW5kZXgg
ZjYyYTE0YWM3My4uNGI2ZjAxN2M2ZiAxMDA2NDQNCj4+IC0tLSBhL2luY2x1ZGUvaHcvdmZpby92
ZmlvLWNvbnRhaW5lci1iYXNlLmgNCj4+ICsrKyBiL2luY2x1ZGUvaHcvdmZpby92ZmlvLWNvbnRh
aW5lci1iYXNlLmgNCj4+IEBAIC03NSw2ICs3NSwxMSBAQCBpbnQgdmZpb19jb250YWluZXJfZG1h
X21hcChWRklPQ29udGFpbmVyQmFzZQ0KPipiY29udGFpbmVyLA0KPj4gICBpbnQgdmZpb19jb250
YWluZXJfZG1hX3VubWFwKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciBpb3ZhLCByYW1fYWRkcl90IHNpemUsDQo+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSU9NTVVUTEJFbnRyeSAqaW90bGIpOw0K
Pj4gK2ludCB2ZmlvX2NvbnRhaW5lcl9hZGRfc2VjdGlvbl93aW5kb3coVkZJT0NvbnRhaW5lckJh
c2UgKmJjb250YWluZXIsDQo+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBNZW1vcnlSZWdpb25TZWN0aW9uICpzZWN0aW9uLA0KPj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgRXJyb3IgKiplcnJwKTsNCj4+ICt2b2lkIHZmaW9fY29udGFpbmVy
X2RlbF9zZWN0aW9uX3dpbmRvdyhWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNZW1vcnlSZWdpb25TZWN0aW9u
ICpzZWN0aW9uKTsNCj4+ICAgaW50IHZmaW9fY29udGFpbmVyX3NldF9kaXJ0eV9wYWdlX3RyYWNr
aW5nKFZGSU9Db250YWluZXJCYXNlICpiY29udGFpbmVyLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgYm9vbCBzdGFydCk7DQo+PiAgIGludCB2ZmlvX2Nv
bnRhaW5lcl9xdWVyeV9kaXJ0eV9iaXRtYXAoVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIs
DQo+PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3ZmaW8vY29tbW9uLmMNCj4+
IGluZGV4IDQ4M2JhODIwODkuLjU3MmFlN2M5MzQgMTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2Nv
bW1vbi5jDQo+PiArKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+PiBAQCAtNTcxLDggKzU3MSw2IEBA
IHN0YXRpYyB2b2lkIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2FkZChNZW1vcnlMaXN0ZW5lcg0KPips
aXN0ZW5lciwNCj4+ICAgew0KPj4gICAgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIg
PSBjb250YWluZXJfb2YobGlzdGVuZXIsIFZGSU9Db250YWluZXJCYXNlLA0KPj4gICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdGVuZXIpOw0KPj4g
LSAgICBWRklPQ29udGFpbmVyICpjb250YWluZXIgPSBjb250YWluZXJfb2YoYmNvbnRhaW5lciwg
VkZJT0NvbnRhaW5lciwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGJjb250YWluZXIpOw0KPj4gICAgICAgaHdhZGRyIGlvdmEsIGVuZDsNCj4+ICAgICAg
IEludDEyOCBsbGVuZCwgbGxzaXplOw0KPj4gICAgICAgdm9pZCAqdmFkZHI7DQo+PiBAQCAtNTk1
LDcgKzU5Myw3IEBAIHN0YXRpYyB2b2lkIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2FkZChNZW1vcnlM
aXN0ZW5lcg0KPipsaXN0ZW5lciwNCj4+ICAgICAgICAgICByZXR1cm47DQo+PiAgICAgICB9DQo+
Pg0KPj4gLSAgICBpZiAodmZpb19jb250YWluZXJfYWRkX3NlY3Rpb25fd2luZG93KGNvbnRhaW5l
ciwgc2VjdGlvbiwgJmVycikpIHsNCj4+ICsgICAgaWYgKHZmaW9fY29udGFpbmVyX2FkZF9zZWN0
aW9uX3dpbmRvdyhiY29udGFpbmVyLCBzZWN0aW9uLCAmZXJyKSkgew0KPj4gICAgICAgICAgIGdv
dG8gZmFpbDsNCj4+ICAgICAgIH0NCj4+DQo+PiBAQCAtNzM4LDggKzczNiw2IEBAIHN0YXRpYyB2
b2lkIHZmaW9fbGlzdGVuZXJfcmVnaW9uX2RlbChNZW1vcnlMaXN0ZW5lcg0KPipsaXN0ZW5lciwN
Cj4+ICAgew0KPj4gICAgICAgVkZJT0NvbnRhaW5lckJhc2UgKmJjb250YWluZXIgPSBjb250YWlu
ZXJfb2YobGlzdGVuZXIsIFZGSU9Db250YWluZXJCYXNlLA0KPj4gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGlzdGVuZXIpOw0KPj4gLSAgICBWRklP
Q29udGFpbmVyICpjb250YWluZXIgPSBjb250YWluZXJfb2YoYmNvbnRhaW5lciwgVkZJT0NvbnRh
aW5lciwNCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGJj
b250YWluZXIpOw0KPj4gICAgICAgaHdhZGRyIGlvdmEsIGVuZDsNCj4+ICAgICAgIEludDEyOCBs
bGVuZCwgbGxzaXplOw0KPj4gICAgICAgaW50IHJldDsNCj4+IEBAIC04MTgsNyArODE0LDcgQEAg
c3RhdGljIHZvaWQgdmZpb19saXN0ZW5lcl9yZWdpb25fZGVsKE1lbW9yeUxpc3RlbmVyDQo+Kmxp
c3RlbmVyLA0KPj4NCj4+ICAgICAgIG1lbW9yeV9yZWdpb25fdW5yZWYoc2VjdGlvbi0+bXIpOw0K
Pj4NCj4+IC0gICAgdmZpb19jb250YWluZXJfZGVsX3NlY3Rpb25fd2luZG93KGNvbnRhaW5lciwg
c2VjdGlvbik7DQo+PiArICAgIHZmaW9fY29udGFpbmVyX2RlbF9zZWN0aW9uX3dpbmRvdyhiY29u
dGFpbmVyLCBzZWN0aW9uKTsNCj4+ICAgfQ0KPj4NCj4+ICAgdHlwZWRlZiBzdHJ1Y3QgVkZJT0Rp
cnR5UmFuZ2VzIHsNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMgYi9o
dy92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj4+IGluZGV4IDAxNzdmNDM3NDEuLjcxZjcyNzQ5NzMg
MTAwNjQ0DQo+PiAtLS0gYS9ody92ZmlvL2NvbnRhaW5lci1iYXNlLmMNCj4+ICsrKyBiL2h3L3Zm
aW8vY29udGFpbmVyLWJhc2UuYw0KPj4gQEAgLTMxLDYgKzMxLDI3IEBAIGludCB2ZmlvX2NvbnRh
aW5lcl9kbWFfdW5tYXAoVkZJT0NvbnRhaW5lckJhc2UNCj4qYmNvbnRhaW5lciwNCj4+ICAgICAg
IHJldHVybiBiY29udGFpbmVyLT5vcHMtPmRtYV91bm1hcChiY29udGFpbmVyLCBpb3ZhLCBzaXpl
LCBpb3RsYik7DQo+PiAgIH0NCj4+DQo+PiAraW50IHZmaW9fY29udGFpbmVyX2FkZF9zZWN0aW9u
X3dpbmRvdyhWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24sDQo+
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBFcnJvciAqKmVycnApDQo+
PiArew0KPj4gKyAgICBpZiAoIWJjb250YWluZXItPm9wcy0+YWRkX3dpbmRvdykgew0KPj4gKyAg
ICAgICAgcmV0dXJuIDA7DQo+PiArICAgIH0NCj4NCj5UaGVzZSBzaG91bGQgYW4gYXNzZXJ0IHJp
Z2h0ID8gYmVjYXVzZSBvbmx5IGNhbGxlZCBvbiB0aGUgcHNlcmllcw0KPnBsYXRmb3JtIHdoaWNo
IGRlZmluZXMgdGhlIGhhbmRsZXJzLg0KDQpCZWNhdXNlIHdlIHVzZSBhIHVuaWZpZWQgdmZpb19t
ZW1vcnlfbGlzdGVuZXIgZm9yIGxlZ2FjeSwgc3BhcHIgYW5kIGlvbW11ZmQNCmJhY2tlbmQsIHNv
IHdlIG5lZWQgdGhlIGNoZWNrIGZvciBsZWdhY3kgYW5kIGlvbW11ZmQgYmFja2VuZC4NCg0KQW5v
dGhlciBjaG9pY2UgaXMgdG8gaW50cm9kdWNlIHNlcGFyYXRlIHJlZ2lvbl9hZGQvZGVsIGNhbGxi
YWNrcyBmb3Igc3BhcHIsDQp0aGVuIHdlIGNhbiBhZGQgYXNzZXJ0LiBCdXQgdGhhdCB3YXkgd2Ug
d2lsbCBoYXZlIHJlZHVuZGFudCBjb2RlLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

