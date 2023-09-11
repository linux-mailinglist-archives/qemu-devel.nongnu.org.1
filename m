Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1BA79A66F
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 10:58:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfck2-0004Nf-LA; Mon, 11 Sep 2023 04:57:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfcjq-0004H3-36
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 04:57:48 -0400
Received: from mgamail.intel.com ([134.134.136.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qfcjl-0004CM-EN
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 04:57:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1694422661; x=1725958661;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=4TZrdDCtCWZzdFVulYvUh0xRahcTYlFYkc6+zDCBzKg=;
 b=cSuWIJkRUxTwzYg0SvVLEOM+C11gpvmuyNvyVRc2tr/Ng7PWx9ubpwMy
 cXlv39xU+PvMc/qrDlQgr3ir2PMJNe9gm6dRRKhEddm+SQstckploNYox
 FcFfzK3Wd1E3fI1v2+wQ7fcLeP7/q2LvMtvBBeg2yM0+F4jAozevFZWol
 O4Bz2KAovizbCDbG8mL7CooAUl9weiOnyVU3YQ4ivqavhQYyfwbudhOam
 Y3nlsozmRw4hG5I1bST5JslVYkbs/20Xk4LSkQNbYJNt6PDUThBRjaN0c
 kwuXrmvde1EBZtcwbDLfvHa/rruAICsN4xjUVqh35YldJUwgxhQnfcy+v g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="368271769"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="368271769"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Sep 2023 01:57:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="813289065"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; d="scan'208";a="813289065"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
 by fmsmga004.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 11 Sep 2023 01:57:34 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 11 Sep 2023 01:57:33 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 11 Sep 2023 01:57:33 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 11 Sep 2023 01:57:32 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YtxSM1EQjcKyutlHyivjDhQYm3P+vLXkIuJDC0Bkdi9udgLa0+2DK36o6Y9usLT9kAmoDHEoj6E+KUD7ZeGSrazQoQy15axPEcVETAoOvbeXD7WXbEa0sFb3wD8puB/gqEeoYTSrDRONTDFpVb8ZzASKSMFO3iAPgUwqCytGDTNRGpViFeDM5VvwXrF71eqVZ8nyYH9zcDJjjaqUkblhyjjyPz/zR6f7p2dfojYSNfJg+IYutKOOQhHFsk5NVYYkCHKTK5KMe25aaB6CGcn5sbWa4jg6aXPw0IntniNDJhSHBmLRJNEYe/3c/mXyo0UDUndcv+j2UDUs/wDiU36XRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4TZrdDCtCWZzdFVulYvUh0xRahcTYlFYkc6+zDCBzKg=;
 b=FMmx4v8VMOiaUzh1ZfQrGfIB8jsnXj2T2Ka9p4lvx/goMV8dmwaJwbOP90r2/RXUQ41/NEGqPrTk9PeSmaNI6KBrm07vKn/D9mnkFeiPZcbLp7uGNyXHNT9w4v4Z7ZuOjwCwU4EMqDgLyzXvj4dmTmwTgGOYtHk1G2bYv9DH0vuAVQfCc30fCyTBHZPgwaGmrLbGFaRsF7w2P+E2Kskaue7N2RORwnva6+xy/Q+/R7+rDQDtwUMZMuZi/+WT5vNfL1iOxzATAD3u9xYPHZ2hVTSa20Mt4y69Ev1FIF26p4ZrtCL1bdnPqmgi0Z9hAeztM7231o8PDYWp3YMnhvVEfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6768.30; Mon, 11 Sep 2023 08:57:28 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::cac7:3146:4b74:8adb%6]) with mapi id 15.20.6745.035; Mon, 11 Sep 2023
 08:57:28 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: Alex Williamson <alex.williamson@redhat.com>, Cedric Le Goater
 <clg@redhat.com>, Avihai Horon <avihaih@nvidia.com>, Gerd Hoffmann
 <kraxel@redhat.com>, "Martins, Joao" <joao.m.martins@oracle.com>
Subject: RE: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Topic: [PATCH v1] vfio/common: Separate vfio-pci ranges
Thread-Index: AQHZ4tZ5L57QHMgEL06JAtdqYWcKlbAVVWmw
Date: Mon, 11 Sep 2023 08:57:28 +0000
Message-ID: <SJ0PR11MB67441FE6EAE5A0AB8992FEF792F2A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230908092944.47589-1-joao.m.martins@oracle.com>
In-Reply-To: <20230908092944.47589-1-joao.m.martins@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|DM3PR11MB8670:EE_
x-ms-office365-filtering-correlation-id: d30d7f48-723b-4415-c876-08dbb2a52082
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fq745mBbuW3T7ESatyA2uBKK8NM7zxHysOW1nyjU5tHptdmHqc7KA4pQClxZvAFOwar60cVmHthuFYQq2iL3DIWbuWsK/u7tYp6Kf9iGXL/Cp+hEbzRIg2td25dEjuLnDVyJ4e8sYud+p17VVbEKPOQlNd284CxbjuIYlxzW9YNeHLod38myB7ftdrW4koSE7tgrNCEJsL/mv+P2LGM+c17H9hfcQdQ0Tdivgum+SujkXTcKQpNN1D/gJkHslaoOuCjHQHDJY3Fuw81JWpYssaBcqCVNX6Hmk+l7eIFVElxcBIJTIw/K+kMgwInaMP+Q3GMkr3b4LZAfFLtCHKzsxCY7yC9EuOI5c842r8Zp/RwCMQjNESRke34h5ktvnbSMpQPZ7BNpjPKxPlKWG/lEodlYUM+WcwWVWPtQVFndv9YUDAG8olRcha81OsyYEMIN1Trfj2Bhrk2EosJSjiNYlEKnDqSj8aAWtoBN2hJH7/Ci23ryp/Wbu8cdgO3RV8TuBuMaDzrtOdgeHAuSLxDzNlD9zjNpfU1cBdmU3MgV4JjW6zCBBFf6sKwCq+re138k9dD46JuZIJGhf2KWZoVv3A9kSadmab9tC4OgWHgNanSzOcThCtZAgJyVxvQkUrXE
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(366004)(346002)(376002)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(52536014)(71200400001)(6506007)(7696005)(83380400001)(41300700001)(66574015)(76116006)(478600001)(26005)(9686003)(2906002)(66446008)(66476007)(54906003)(66556008)(64756008)(316002)(4326008)(5660300002)(110136005)(8676002)(8936002)(66946007)(86362001)(33656002)(38070700005)(55016003)(38100700002)(122000001)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzVsZXdwcG9WbGgyS3g5eWRJNHRUZnFrQW45V2o0d3ZrSTJMZTFMaTdtR0hF?=
 =?utf-8?B?SUUvSXhQSGhIVkJaWFJEbXNoU1FqRFZ4clZTcndhaVFuUFRJRDA3MnVmemtB?=
 =?utf-8?B?SFlWL1BoSWQ5QW9mVXc5RU1JR1dadldKdzYvSnJKK1JwdGlrQ1E3UE1UdVZm?=
 =?utf-8?B?aGYvNW9XRUdHR2VFeWZoZGE1a1ZEa0dIVm8vR0lHekR0T3hWbFVwZGFkWitL?=
 =?utf-8?B?ZmZUZ21aMjczM1JpTDBYTngySW5EVGtwOU5tUWN4dm9LeG50NjF2aXdJanh1?=
 =?utf-8?B?bC9ZL2Mxcmd1SStJVko4ajFsUkJ6Z1dISnpheUNaL1pPdkw3cTVWV2tXT3Fj?=
 =?utf-8?B?Z3ZhdlkvNExab0JienI4dlBzdkg5RXQ4VERkNDdqRVdEQm54VlFVcEVsZzhn?=
 =?utf-8?B?dzBhd1ZwSWF0WVVPT3NONGtSSkpUWjBoa0p6MFByTFR2NEZDcEVDQkZpY0lr?=
 =?utf-8?B?L0JsNGVjVHBOMHVkK29tZWlObDdScEZ3d3dCaGJBWjFsbjIydG1NWkRVVHFr?=
 =?utf-8?B?aGhzR3Z3Ukdvc25jUnhEQ3BONSs5RVphNUlUcDhhNmloZks2VUphVDl1MnZm?=
 =?utf-8?B?YjUzeGRLcVB0T0ZCR2VYaXR0ZG9uYXpnTjBwVnlXM1N4dDZVcjdpTExuNzEw?=
 =?utf-8?B?UnUxTWxFdWtPQmI4aUJNTldZRjdyV21VRC9ySDNVOG54Y0ZKYVc2ci9PUEZr?=
 =?utf-8?B?emM3RFpmWmJ3NFpzWG0wL2VXQnh1MkU0WmNCNlIyQk44QnF3QkVhQXVlZGNH?=
 =?utf-8?B?Q1puaURpc2R4T1JlM2xJdUN0ei9hWDAyY1REdlBUUFBqWHcyTTRIOG1ITTM0?=
 =?utf-8?B?Sy80U002YTdmcUozUmEwRTlFV01Bei9hNWN5QldlbjRMb2lIRldJME94dkV1?=
 =?utf-8?B?ZVlyY2pXQTUzSmNpeG9QOTBqOXRUbjlrMlI5Wjh3L003S1hBUVJ3c2dOZDVq?=
 =?utf-8?B?TU13MHUrR3pQY0hjR2FNd2xGL1hNL3ZiZksxL0NkRE5EOENEcDhwdUpHaytO?=
 =?utf-8?B?Nm8vNFRuOWxIN0hwc29Pd0pQZndVUFlhRGhGS1ZuYkNBTFJWMmZoa1hwMVY2?=
 =?utf-8?B?ODFVdXhNTUZpaGhGbEZWdHRYaVlmZjJzRXJpdWZyYzNoZDVISWhFaWE5VURk?=
 =?utf-8?B?Z20yKzVxVDJ1MUNJNVl1ZEhLMk9LamhqN1FQK2REWUM4N1dBbDUrYWVPSGhi?=
 =?utf-8?B?TzJnMG9rRSs0ZkhEdlJEQXFUNHgyUzdIWENielMvM2dFQ3M2VGFqek1sa0hY?=
 =?utf-8?B?V3lkSWtJeXpqZCttVHJNbXhxVHNLUGVqVXpwRlU5YStPdXhHbXpKOWcyWUtz?=
 =?utf-8?B?cFJJME9ib2RVZm1HRkwvMEY1UWJYcTBGWkJzNzZhbXozbkZvRzNMeDNpL1Vr?=
 =?utf-8?B?VU53eW9TUGZHN0lPb1Q3TVZMdklhQXNqcXlsbGd2dURiZFNKYmdmNmdXNVBa?=
 =?utf-8?B?bTNFelNKdzhjNng1YVplYWdLZ3ZRcGduQ2RNMHV3RHVWRTc0WStiVEZrcEFO?=
 =?utf-8?B?Q1N4L3AxSmNBekZSaUR3N3cwdVU4Sit4eG8rc3FVRWMzbDVaanNrWDJ0STRE?=
 =?utf-8?B?RkZiZmdVUmxPTjQ3L1U2b3hSNVd6UUl6T1h3MC9McTJmb2dnMlpLczJZUE5t?=
 =?utf-8?B?Wjc5SXNiRVJjd0VUR0c3U2gzVHBlcFhkK2lqUFA4MkZqVmpPZDBkaXhwZGhz?=
 =?utf-8?B?RnRsQ3ZsNUc3Wnl6T004SE5qa3BsUUs3N2pFK3JpMUtxSWpyS1ZzUkovVU02?=
 =?utf-8?B?ZUdLU0R3WWo1V28zOTN4aWJYT3gxeFdKdDJKMlZQaXFmTWVjSVZpRDdqaFo4?=
 =?utf-8?B?cmxROExxL1AxeHl2d0g0dzR4aW83a0R1Y1UrTUUrRjdtY0lvYmdnMFhUWnpW?=
 =?utf-8?B?OTBrNkFXaTk5Rmg5V05MQjdUZ1BiYk0vV3JHMmRhQ3FuY0FWSDQ0OE9WMWR3?=
 =?utf-8?B?N2ZRZW9YVUoxa3lJdVRFQ3hYaXpBbkxBRktmTHJMcS82eGY0Q0pUVUM1bmRV?=
 =?utf-8?B?ZS9nOFRkM3RtSmxuN3VlTEpxa3VLRTExdml2TEpLeksrWmZ6enBHaEtzdXND?=
 =?utf-8?B?N25FWnUyWUlKL3VEMjNoQm4vQVZqR0tmNGhUcm5EdmtNaEF6U0NPVlduUlVJ?=
 =?utf-8?Q?4CyruziUDZl/f3ua8/rhbK5pf?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d30d7f48-723b-4415-c876-08dbb2a52082
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 08:57:28.7642 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8g810NmAKZVfh46IQhBKCyaTR3TPgA78gxJaOpX60YeHUj6OJaPZLlumiVmPa6d99n/7QfBIZaJiuO+S5CqXMe1sV+pdlo7nHQK/4B5KUhc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.20;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IHFlbXUtZGV2ZWwtYm91bmNl
cyt6aGVuemhvbmcuZHVhbj1pbnRlbC5jb21Abm9uZ251Lm9yZyA8cWVtdS0NCj5kZXZlbC1ib3Vu
Y2VzK3poZW56aG9uZy5kdWFuPWludGVsLmNvbUBub25nbnUub3JnPiBPbiBCZWhhbGYgT2YgSm9h
bw0KPk1hcnRpbnMNCj5TZW50OiBGcmlkYXksIFNlcHRlbWJlciA4LCAyMDIzIDU6MzAgUE0NCj5T
dWJqZWN0OiBbUEFUQ0ggdjFdIHZmaW8vY29tbW9uOiBTZXBhcmF0ZSB2ZmlvLXBjaSByYW5nZXMN
Cj4NCj5RRU1VIGNvbXB1dGVzIHRoZSBETUEgbG9nZ2luZyByYW5nZXMgZm9yIHR3byBwcmVkZWZp
bmVkIHJhbmdlczogMzItYml0DQo+YW5kIDY0LWJpdC4gSW4gdGhlIE9WTUYgY2FzZSwgd2hlbiB0
aGUgZHluYW1pYyBNTUlPIHdpbmRvdyBpcyBlbmFibGVkLA0KPlFFTVUgaW5jbHVkZXMgaW4gdGhl
IDY0LWJpdCByYW5nZSB0aGUgUkFNIHJlZ2lvbnMgYXQgdGhlIGxvd2VyIHBhcnQNCj5hbmQgdmZp
by1wY2kgZGV2aWNlIFJBTSByZWdpb25zIHdoaWNoIGFyZSBhdCB0aGUgdG9wIG9mIHRoZSBhZGRy
ZXNzDQo+c3BhY2UuIFRoaXMgcmFuZ2UgY29udGFpbnMgYSBsYXJnZSBnYXAgYW5kIHRoZSBzaXpl
IGNhbiBiZSBiaWdnZXIgdGhhbg0KPnRoZSBkaXJ0eSB0cmFja2luZyBIVyBsaW1pdHMgb2Ygc29t
ZSBkZXZpY2VzIChNTFg1IGhhcyBhIDJeNDIgbGltaXQpLg0KPg0KPlRvIGF2b2lkIHN1Y2ggbGFy
Z2UgcmFuZ2VzLCBpbnRyb2R1Y2UgYSBuZXcgUENJIHJhbmdlIGNvdmVyaW5nIHRoZQ0KPnZmaW8t
cGNpIGRldmljZSBSQU0gcmVnaW9ucywgdGhpcyBvbmx5IGlmIHRoZSBhZGRyZXNzZXMgYXJlIGFi
b3ZlIDRHQg0KPnRvIGF2b2lkIGJyZWFraW5nIHBvdGVudGlhbCBTZWFCSU9TIGd1ZXN0cy4NCj4N
Cj5TaWduZWQtb2ZmLWJ5OiBKb2FvIE1hcnRpbnMgPGpvYW8ubS5tYXJ0aW5zQG9yYWNsZS5jb20+
DQo+WyBjbGc6IC0gd3JvdGUgY29tbWl0IGxvZw0KPiAgICAgICAtIGZpeGVkIG92ZXJsYXBwaW5n
IDMyLWJpdCBhbmQgUENJIHJhbmdlcyB3aGVuIHVzaW5nIFNlYUJJT1MgXQ0KPlNpZ25lZC1vZmYt
Ynk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4tLS0NCj52MjoNCj4qIHMv
bWlucGNpL21pbnBjaTY0Lw0KPiogcy9tYXhwY2kvbWF4cGNpNjQvDQo+KiBFeHBhbmQgY29tbWVu
dCB0byBjb3ZlciB0aGUgcGNpLWhvbGU2NCBhbmQgd2h5IHdlIGRvbid0IGRvIHNwZWNpYWwNCj4g
IGhhbmRsaW5nIG9mIHBjaS1ob2xlMzIuDQo+LS0tDQo+IGh3L3ZmaW8vY29tbW9uLmMgICAgIHwg
NzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0NCj4gaHcvdmZp
by90cmFjZS1ldmVudHMgfCAgMiArLQ0KPiAyIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMo
KyksIDEyIGRlbGV0aW9ucygtKQ0KPg0KPmRpZmYgLS1naXQgYS9ody92ZmlvL2NvbW1vbi5jIGIv
aHcvdmZpby9jb21tb24uYw0KPmluZGV4IDIzNzEwMWQwMzg0NC4uMTM0NjQ5MjI2ZDQzIDEwMDY0
NA0KPi0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4rKysgYi9ody92ZmlvL2NvbW1vbi5jDQo+QEAg
LTI3LDYgKzI3LDcgQEANCj4NCj4gI2luY2x1ZGUgImh3L3ZmaW8vdmZpby1jb21tb24uaCINCj4g
I2luY2x1ZGUgImh3L3ZmaW8vdmZpby5oIg0KPisjaW5jbHVkZSAiaHcvdmZpby9wY2kuaCINCj4g
I2luY2x1ZGUgImV4ZWMvYWRkcmVzcy1zcGFjZXMuaCINCj4gI2luY2x1ZGUgImV4ZWMvbWVtb3J5
LmgiDQo+ICNpbmNsdWRlICJleGVjL3JhbV9hZGRyLmgiDQo+QEAgLTE0MDAsNiArMTQwMSw4IEBA
IHR5cGVkZWYgc3RydWN0IFZGSU9EaXJ0eVJhbmdlcyB7DQo+ICAgICBod2FkZHIgbWF4MzI7DQo+
ICAgICBod2FkZHIgbWluNjQ7DQo+ICAgICBod2FkZHIgbWF4NjQ7DQo+KyAgICBod2FkZHIgbWlu
cGNpNjQ7DQo+KyAgICBod2FkZHIgbWF4cGNpNjQ7DQo+IH0gVkZJT0RpcnR5UmFuZ2VzOw0KPg0K
PiB0eXBlZGVmIHN0cnVjdCBWRklPRGlydHlSYW5nZXNMaXN0ZW5lciB7DQo+QEAgLTE0MDgsNiAr
MTQxMSwzMSBAQCB0eXBlZGVmIHN0cnVjdCBWRklPRGlydHlSYW5nZXNMaXN0ZW5lciB7DQo+ICAg
ICBNZW1vcnlMaXN0ZW5lciBsaXN0ZW5lcjsNCj4gfSBWRklPRGlydHlSYW5nZXNMaXN0ZW5lcjsN
Cj4NCj4rc3RhdGljIGJvb2wgdmZpb19zZWN0aW9uX2lzX3ZmaW9fcGNpKE1lbW9yeVJlZ2lvblNl
Y3Rpb24gKnNlY3Rpb24sDQo+KyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBW
RklPQ29udGFpbmVyICpjb250YWluZXIpDQo+K3sNCj4rICAgIFZGSU9QQ0lEZXZpY2UgKnBjaWRl
djsNCj4rICAgIFZGSU9EZXZpY2UgKnZiYXNlZGV2Ow0KPisgICAgVkZJT0dyb3VwICpncm91cDsN
Cj4rICAgIE9iamVjdCAqb3duZXI7DQo+Kw0KPisgICAgb3duZXIgPSBtZW1vcnlfcmVnaW9uX293
bmVyKHNlY3Rpb24tPm1yKTsNCj4rDQo+KyAgICBRTElTVF9GT1JFQUNIKGdyb3VwLCAmY29udGFp
bmVyLT5ncm91cF9saXN0LCBjb250YWluZXJfbmV4dCkgew0KPisgICAgICAgIFFMSVNUX0ZPUkVB
Q0godmJhc2VkZXYsICZncm91cC0+ZGV2aWNlX2xpc3QsIG5leHQpIHsNCj4rICAgICAgICAgICAg
aWYgKHZiYXNlZGV2LT50eXBlICE9IFZGSU9fREVWSUNFX1RZUEVfUENJKSB7DQo+KyAgICAgICAg
ICAgICAgICBjb250aW51ZTsNCj4rICAgICAgICAgICAgfQ0KPisgICAgICAgICAgICBwY2lkZXYg
PSBjb250YWluZXJfb2YodmJhc2VkZXYsIFZGSU9QQ0lEZXZpY2UsIHZiYXNlZGV2KTsNCj4rICAg
ICAgICAgICAgaWYgKE9CSkVDVChwY2lkZXYpID09IG93bmVyKSB7DQo+KyAgICAgICAgICAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4rICAgICAgICAgICAgfQ0KPisgICAgICAgIH0NCj4rICAgIH0NCj4r
DQo+KyAgICByZXR1cm4gZmFsc2U7DQo+K30NCg0KV2hhdCBhYm91dCBzaW1wbGlmeSBpdCB3aXRo
IG1lbW9yeV9yZWdpb25faXNfcmFtX2RldmljZSgpPw0KVGhpcyB3YXkgdmRwYSBkZXZpY2UgY291
bGQgYWxzbyBiZSBpbmNsdWRlZC4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K

