Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D30582923C
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 02:50:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNNiv-0000re-RT; Tue, 09 Jan 2024 20:49:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rNNit-0000r0-0Q; Tue, 09 Jan 2024 20:49:39 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chen.zhang@intel.com>)
 id 1rNNir-00007X-2f; Tue, 09 Jan 2024 20:49:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1704851377; x=1736387377;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=6gQdZXZ/IDqFkokWJV26jhnHAzCWYtbZ9rhfULU2sLQ=;
 b=VIxk7LbbZoiXYZDeSVkJvZbmriWuKOWe6hn63b8FGXF7lkqKPjGTQ4g7
 PVOYZXm65Z/I/fA41CI7xGe5cHq3I9iTP+KEJpARuiy1iDvabmwTMnmrH
 fGj48oCAM96dG8qUJ/M5zjxTVq+XZaXVtS6ytAkXH8rWH0JT+B4hQLoui
 tP9RXqAb432YokI/Zsj22ry6ih3aDRzYwLskZpMILIIGtI7D/c50AACMk
 w7QVGevQrA1LDRrut6RLTOXHV5RfwN8B4xdM2ZgDuTy8DEMmkjrjEC2JD
 fRcDZ/DLdAVRAxIxZLW34gGEZRpUQOj9GFQRoW2hDYLzB80Av2BnKLoP3 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="5737983"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; 
   d="scan'208";a="5737983"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jan 2024 17:49:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10947"; a="731690300"
X-IronPort-AV: E=Sophos;i="6.04,184,1695711600"; d="scan'208";a="731690300"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
 by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 09 Jan 2024 17:49:31 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:49:30 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 9 Jan 2024 17:49:30 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 9 Jan 2024 17:49:30 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Jan 2024 17:49:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMSEcGD71+XtXVJi2okn7mopP2o4BZ7Yxbh75mFTqSa7piJKnWfw5BkcFUm+y5qtCn7ASQlgy+hY7C2eTFJIGv/PWgtgn9xRCjvstuDUumue6LtvDD8cXQDDPuKL4p0+yFR6nMYkc61wPnZvQarhan7rviRj8bbMf0hafY9+r4BXZXlwjbEk6EwVSW+JiCplEWCgfGwEVgdYGYBjskb23Cx7lWsufNDWnPtfnMOmA9O4BGt2CxNNK/xLUjVcjQuF5lvb8A+daVxlrKjoqzEEihUAVh98CTs0h7x949bIGtY4+spACAA/SmGd9JtriNBLBPUISWMPdJhowmpoou3c8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6gQdZXZ/IDqFkokWJV26jhnHAzCWYtbZ9rhfULU2sLQ=;
 b=EV6AzfILzQdlTLK7UeLXDis1K4n6qKiUdiAiE2RzNcK9hGFLh8lGA0d2hSt6dzjnBnigZMqsdmB0JnMz644nbhs4oWExi10gxGJrRCHm+530kaQjLkX2EHMetR7TjG8KXn3COQAbN7bAA6g87xqm78adPBaMlpXv69PcR5d4ZP9q1bFtP3kZ+DlfzJCDJ4kdoxJaHzsROFmnzkE62mm1pEYZPvGAOE7Etx5XAHlBK2IW3O5URWevB8YsOMa3zYsZ4mDayka/j1k5w81S6MKtV9NI+lLFeIaTwVle9NjlKslFH+1btcNxPYmwuW4uxnpteLvbB7fYTGrQpNBbjRpKnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SA1PR11MB8428.namprd11.prod.outlook.com (2603:10b6:806:38b::20)
 by SN7PR11MB6876.namprd11.prod.outlook.com (2603:10b6:806:2a7::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.17; Wed, 10 Jan
 2024 01:49:28 +0000
Received: from SA1PR11MB8428.namprd11.prod.outlook.com
 ([fe80::bcbc:1378:dc73:42ca]) by SA1PR11MB8428.namprd11.prod.outlook.com
 ([fe80::bcbc:1378:dc73:42ca%3]) with mapi id 15.20.7159.020; Wed, 10 Jan 2024
 01:49:27 +0000
From: "Zhang, Chen" <chen.zhang@intel.com>
To: Michael Tokarev <mjt@tls.msk.ru>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-trivial@nongnu.org" <qemu-trivial@nongnu.org>, Li Zhijian
 <lizhijian@fujitsu.com>
Subject: RE: [PATCH trivial] colo: examples: remove mentions of script= and
 (wrong) downscript=
Thread-Topic: [PATCH trivial] colo: examples: remove mentions of script= and
 (wrong) downscript=
Thread-Index: AQHaQVxb77ChPaUaZUGuO+6+/tz/B7DQuvNggABAGYCAAUXhkA==
Date: Wed, 10 Jan 2024 01:49:27 +0000
Message-ID: <SA1PR11MB8428C34BF4358087F75B5A199B692@SA1PR11MB8428.namprd11.prod.outlook.com>
References: <20240107112459.335594-1-mjt@tls.msk.ru>
 <CYYPR11MB843238AD2090FC1B9B309DBA9B6A2@CYYPR11MB8432.namprd11.prod.outlook.com>
 <6c043607-d5ba-41d3-94df-5618fc05c15f@tls.msk.ru>
In-Reply-To: <6c043607-d5ba-41d3-94df-5618fc05c15f@tls.msk.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB8428:EE_|SN7PR11MB6876:EE_
x-ms-office365-filtering-correlation-id: cd40e7b7-4bb4-4091-5d04-08dc117e6180
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pSa+UTynuaFCcq0zPhbPUg8YA33HLo98P88WBz11bz7CRfQPs7dl1LmxtzerkHAk3ISfrWUnOOrFHmHJjiM9fg6iTv8ySwWdbyNJS06/bG8uFa2u6zrh4kNWpin0LGLEDaDuzmJRHnNpsC6PYRHjjn9FMRgiq0YDyv1qTv+6CBXj1yWPYTzVMJETd7b8klSCVgXhnN7+CyKPzcCXgI+NFhztXQZeMrOEQX/QK/2uFBCwMCd+vbZUdhYRyq7sxCtnjxybklB7GN5ZaCPVgzWR6Tp3hzad/Wsp9Z6QmHoA8JDzcwrWYqJLSAM2AIR+0A+SnXtlrkzKlaKgKG0l1l2hJBsj03EoMXPOP2J/e54nqN6s9ACIOMjfsHsbpKNbNSUTdcrbWdkxVoiLbi0vAKxZFJ2/l8I72BB+xvC1q6hb3F5w20kNYfZ9RbWbnfTmBWpDRhWmps9rewt6YNJanwvOO4FfsR6naIQ8mQ/4GL5aYyO5OIb5zf4yHVCXivz5zDy9Oxwn070HbFbgHwd7v5Ld6YO5+J8kGEDwXOCvSUdr6Xi20n95p8B3FKw54Nj0+5cplwn5TRHLJIHSJ/L5Qs+nlO3sNclq4jo2w/VzoTLMgV76itVwkNEIqXhFbRVOe69T
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR11MB8428.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(186009)(64100799003)(1800799012)(38100700002)(122000001)(38070700009)(86362001)(33656002)(41300700001)(82960400001)(26005)(4326008)(52536014)(7696005)(6506007)(53546011)(478600001)(76116006)(71200400001)(66446008)(66476007)(66946007)(64756008)(66556008)(316002)(110136005)(54906003)(55016003)(9686003)(8936002)(8676002)(2906002)(83380400001)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bWhzelJqaFNWS0gzNWgzZUh2VDVGak9vbE1sQjJDanVaODY0dzVxakN4R0Mz?=
 =?utf-8?B?d2F2N0Y5RXRpMkpOb28weHRZeWNoOUNKdVNWTnNQbGcvTGx3SGZOUTE4S3VL?=
 =?utf-8?B?NEkrdmZ2OTVOWVhCaEo4R1RhMWpHaTlMdWFmYjZqckZhaUpocUkzRXpudGh1?=
 =?utf-8?B?b2hBVzFQNVk0R2ZCdUtxS0gwT0gvbUVxbktZaEFQMmsra3JDcVk1WkJkSVpB?=
 =?utf-8?B?aDJobExpUEczK0hsUGpJSmxta1I0ek1QQjkyRHBDQlhQNTcxZ3BQenBWK3hO?=
 =?utf-8?B?YVJaR2ZkOSs5MHFkd1g3U0ZpTlM1dHU1YjFjV3ZqMWJIeDhJbGJqWEloNlRO?=
 =?utf-8?B?NEQ1cjkvN0lTYWhGZWpHa3dLeVlwRU9TcFJRTWlzcUdzYWRJeDFFOXdYaGtl?=
 =?utf-8?B?LzI4UkxZbkU4ekNoSlhiK3ZycW5uSXhZcE1jTThQUkg3U25GSVB0WXU5NE1M?=
 =?utf-8?B?dlZUbWc2QmE5V1hTM3Bhek1mVUFZNUZrUzNwR0RIVWNUV1FIWkVXbEdkSldt?=
 =?utf-8?B?OHZIc05RODZIUXVJbW9wamZxaU16ZVhZOVJhbHNMWUxHMVBPdzk1WC9aeklZ?=
 =?utf-8?B?cmI5QzV5OVFTTXNQT1pLZ2JpM3FFWnRlSng4c2Z3VE1EeFBXRHB0dGg5eGZq?=
 =?utf-8?B?aFM1MXJNTHFvd0t3WDlUNitCdFNSTkcvU25VZ3B2RTJQTE51ejhVeHI3cFNo?=
 =?utf-8?B?QTR6Uys4VmxLV0NEUGQySGlyZFM5cENJY2tzbyt5K2NCb3Vuc3h0dVpiemlH?=
 =?utf-8?B?dTNubktBcjBhVUtTRXpVMkxmZ213SFVmWXg0MmRZbmFSVE42TE1CRE5PNlZ5?=
 =?utf-8?B?QnRhNmpqaGYwOUlLRDVqbE1lWlEyYkMwZlhkUlVJeVdjWTBZQUJLL1RhWnJR?=
 =?utf-8?B?OVk0RmpYYWpWVzZDbEN1Q2NqVXU5aGIyZW9POVl2UEc4aXpEVU1ERXMwUTZQ?=
 =?utf-8?B?L2RYVysyMVJiV0dSdXlxMFo5M1NHaUhNeEhwVzVjZkV3WXFOalF4WHBlMVBI?=
 =?utf-8?B?MS9nUlVacmQ3Sy9iWWIvWWhWOUxNUUR2Ny9lK2xJeDZFRG5vY2FPLy9QR2hS?=
 =?utf-8?B?aE90bU9MK3dWNDd4N20wK29YUWk1T3NvRWpGYnNSemxqdWVnYlUyZUEvdU5h?=
 =?utf-8?B?aXZLek9QUTVCMUNMNWhYSCtWTkJVeUl2N2N5WTIxWjVIeSt3YkN3Q0RLam1y?=
 =?utf-8?B?Q1ZoUFpnbTB2SjdlMmlWdDQ5SW1LRkY0Ri9PekxTam9KMGx1OUFVRUxvQitt?=
 =?utf-8?B?VmZ2TWd5bWhwaHJxVUF1cFJpT055NmZxWTFRTldFandVUDRBZVJPdkhHSmVC?=
 =?utf-8?B?YkNVd3M2WVdUQ1U3L0xIWFhGd0hmWUtmYmJwQWhZdjRJRVVkeVVmQ0dFdnJZ?=
 =?utf-8?B?TEZqSkowMklwWFBaQkUvRVhPdjhSOEh5aUhiTnRsNnBQSU9kYUs2YmxSNTJk?=
 =?utf-8?B?TGt5aWd1cWhlRk1vZk1uZkVVY1daUy9pSHQ1TGZlWEpBRE9TQ3RocVQ0cmxv?=
 =?utf-8?B?YmV2emtBSzRRODJHWnE2UTRGc1g4ekxlU2lPbVJodVFNaXFCRVF2TTd5clV4?=
 =?utf-8?B?V3AyTHorYzBUayt4S2d0WlhzaUwrV2lLQ1RYYXdVU2J1OVZ4SWJubmx4b2Zr?=
 =?utf-8?B?eTZMbWkzQ1FqcTl4VkZOaU03ZnJLMkg5UDFOTmFaUnR1OGFNanpSdXNTYXQr?=
 =?utf-8?B?M2F4N0gzMm1zVFd3VWRiS2k4ZHFXTkhLcnZRNldhaGJkRXVOQXh6eTJNTTZT?=
 =?utf-8?B?aEJjK3dSR1JsMVdWd0E4ejhBRTdPVXlTMkQwMUx4WnJTc3JFb1FkNFQxWSt5?=
 =?utf-8?B?bU9HZG8yYm85TzczREpHcUdCSHhNK3pQdzExUUlBRFVkWFc5SnI3R0VOZFln?=
 =?utf-8?B?WW9tb0ljR1RtNW1KRU1XWWVZZ3E0L0NublR1WFp3N1dDakl5c3N6UkFLMUR5?=
 =?utf-8?B?eGFQbVpwc052dUFmZzRGaEtSQzhBc1dBS1NNenRGdDF3NEQxTE5oRWRiRWVa?=
 =?utf-8?B?NDdUeUsyc011M2lQd0liU291OHU4aGd5THFZMjY0WTd1djU1b1ExSGI5RzZK?=
 =?utf-8?B?UkNScFhIMlVpQTRVVG9VYzlIWmh5ZW9BSE9EdmV3WjdWS0JrQnFGRjRiTFRG?=
 =?utf-8?Q?coA7QJq3hTsUaEZpnfmtIY14w?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB8428.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cd40e7b7-4bb4-4091-5d04-08dc117e6180
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jan 2024 01:49:27.9079 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HWa3haicp7u1wX015YhebpZwNVLm1wnXh3PIFofrYtSlcfGIUY97me8hbh68eCH5RAoa4Zz/Ee85o1AR5HyUSQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6876
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12; envelope-from=chen.zhang@intel.com;
 helo=mgamail.intel.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTWljaGFlbCBUb2thcmV2
IDxtanRAdGxzLm1zay5ydT4NCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSA5LCAyMDI0IDE6NDQg
UE0NCj4gVG86IFpoYW5nLCBDaGVuIDxjaGVuLnpoYW5nQGludGVsLmNvbT47IHFlbXUtZGV2ZWxA
bm9uZ251Lm9yZw0KPiBDYzogcWVtdS10cml2aWFsQG5vbmdudS5vcmc7IExpIFpoaWppYW4gPGxp
emhpamlhbkBmdWppdHN1LmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSCB0cml2aWFsXSBjb2xv
OiBleGFtcGxlczogcmVtb3ZlIG1lbnRpb25zIG9mIHNjcmlwdD0gYW5kDQo+ICh3cm9uZykgZG93
bnNjcmlwdD0NCj4gDQo+IDA5LjAxLjIwMjQgMDU6MDgsIFpoYW5nLCBDaGVuIDoNCj4gPg0KPiA+
DQo+ID4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4+IEZyb206IE1pY2hhZWwgVG9r
YXJldiA8bWp0QHRscy5tc2sucnU+DQo+ID4+IFNlbnQ6IFN1bmRheSwgSmFudWFyeSA3LCAyMDI0
IDc6MjUgUE0NCj4gPj4gVG86IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZw0KPiA+PiBDYzogTWljaGFl
bCBUb2thcmV2IDxtanRAdGxzLm1zay5ydT47IHFlbXUtdHJpdmlhbEBub25nbnUub3JnOyBaaGFu
ZywNCj4gPj4gQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+OyBMaSBaaGlqaWFuIDxsaXpoaWpp
YW5AZnVqaXRzdS5jb20+DQo+ID4+IFN1YmplY3Q6IFtQQVRDSCB0cml2aWFsXSBjb2xvOiBleGFt
cGxlczogcmVtb3ZlIG1lbnRpb25zIG9mIHNjcmlwdD0NCj4gPj4gYW5kDQo+ID4+ICh3cm9uZykg
ZG93bnNjcmlwdD0NCj4gPj4NCj4gPj4gVGhlcmUncyBubyBuZWVkIHRvIHJlcGVhdCBzY3JpcHQ9
L2V0Yy9xZW11LWlmdXAgaW4gZXhhbXBsZXMsIGFzIGl0IGlzDQo+ID4+IGFscmVhZHkgaW4gdGhl
cmUuICBNb3JlLCBhbGwgZXhhbXBsZXMgdXNlcyBpbmNvcnJlY3QgImRvd24gc2NyaXB0PSINCj4g
Pj4gKHdoaWNoIHNob3VsZCBiZSAiZG93bnNjcmlwdD0iKS4NCj4gPg0KPiA+IFllcywgZ29vZCBj
YXRjaC4NCj4gPiBSZXZpZXdlZC1ieTogWmhhbmcgQ2hlbiA8Y2hlbi56aGFuZ0BpbnRlbC5jb20+
DQo+ID4NCj4gPj4gLS0tDQo+ID4+IEknbSBub3Qgc3VyZSB3ZSBuZWVkIHNvIG1hbnkgaWRlbnRp
Y2FsIGV4YW1wbGVzLCBhbmQgd2h5IGl0IHVzZXMNCj4gPj4gdm5ldD1vZmYsIC0gaXQgbG9va3Mg
bGlrZSB2bmV0PSBzaG91bGQgYWxzbyBiZSBkcm9wcGVkLg0KPiA+DQo+ID4gRG8geW91IG1lYW5z
IHRoZSAidm5ldF9oZHJfc3VwcG9ydCIgaW4gZG9jcz8NCj4gDQo+IE5vcGUsIGl0IHdhcyBhIHRo
aW5rbyBvbiBteSBwYXJ0LCBJIG1lYW4gdmhvc3Q9b2ZmIHBhcmFtZXRlciAtIHdoaWNoIGlzIHJp
Z2h0DQo+IG5leHQgdG8gc2NyaXB0PS4NCj4gV2h5IHZob3N0IGlzIGV4cGxpY2l0bHkgZGlzYWJs
ZWQgaGVyZSwgd2hpbGUgaXQgaXNuJ3QgZXZlbiBlbmFibGVkIGJ5IGRlZmF1bHQ/DQo+IA0KDQpC
ZWNhdXNlIFFlbXUgbmV0IGZpbHRlciBjYW4ndCBzdXBwb3J0IHZob3N0Lg0KVmhvc3QgcHV0cyB2
aXJ0aW8gZW11bGF0aW9uIGNvZGUgaW50byB0aGUga2VybmVsLCB0YWtpbmcgUUVNVSB1c2Vyc3Bh
Y2Ugb3V0IG9mIHRoZSBwaWN0dXJlLg0KU28sIHRoZSBmaWx0ZXIgY2FuJ3Qgd29ya3MgdG8gZ2V0
IG5ldHdvcmsgZGF0YS4NCg0KPiBBbmQgZG8gd2UgcmVhbGx5IG5lZWQgdGhhdCBtYW55IGV4YW1w
bGVzIGxpa2UgdGhpcywgbWF5YmUgaXQncyBhIGdvb2QgaWRlYSB0bw0KPiByZW1vdmUgaGFsZiBv
ZiB0aGVtIGFuZCByZWZlciB0byB0aGUgb3RoZXIgcGxhY2UgaW5zdGVhZD8NCg0KWWVzLCBuaWNl
IHRvIHNlZSBvcHRpbWl6ZWQgZG9jdW1lbnRhdGlvbi4NCg0KVGhhbmtzDQpDaGVuDQoNCj4gDQo+
IC9tanQNCg==

