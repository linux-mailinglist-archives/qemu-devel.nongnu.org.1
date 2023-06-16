Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76F73255D
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 04:44:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9zQn-0003Sm-8J; Thu, 15 Jun 2023 22:43:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9zQj-0003SY-QI
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 22:43:17 -0400
Received: from mga04.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1q9zQf-0003g8-Ai
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 22:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686883393; x=1718419393;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=tDmQnnAW1omAGVRmubrYvb6VTCFhM4GPFOGffijHsxI=;
 b=Qs2uqRUNREM4MnB/74lQJyMrgDKyxBOnuLF8beEzxHh6ImyM8l9pY39V
 1GNr+yIelbFlMtYaLBL6BODTW6ldWF+vq4Oc+hs9UGOolCnByuGoISUGd
 qdspWiroQOQt3kyGrjeW8o+U3B6bg6XfdtTn4ZBGpltaZPNDg+Ghe/rGi
 g0sg0dpHErvxVLvGtzz5fw/awKNqd/5Dh5Nofads0rMNtN3eWQdrBk6uj
 rv5ufKgvPfz4BBrXrFfYlqqFj4Gj/7TJ2Y7mkEGQ196NcoWY0UO810kl+
 FdjStlBvwt/1gdm9c++58XqmtGfKJakZudJUiOJflXd+Td+CPS4lgiWVX g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="357973333"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="357973333"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Jun 2023 19:42:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="742477694"
X-IronPort-AV: E=Sophos;i="6.00,246,1681196400"; d="scan'208";a="742477694"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga008.jf.intel.com with ESMTP; 15 Jun 2023 19:42:55 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:42:54 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 15 Jun 2023 19:42:54 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 15 Jun 2023 19:42:54 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 15 Jun 2023 19:42:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SlR/UngepE9jtf0xD3c0hBwVEjY7V3heUCUgMd+sMVqRijjyaZIgXDGZHUmBAalpyEBCBhgvHeFuvJN04+VTUED5GM5+NYdMpX18fHmMGmQDujXK7lGL1bHEWjJ/aF3nfF5EYNUy7mTHnJIAJMRqaF8Plcs7FCqqBPdDeNFuue8+GGGUPfQ0VNiV58dcO1BefhiM/IEBbYG3Ah09b8u5jqUb86MlXJ33zPk2UvSoTnHJ6EvK/QfCFLD5GIelko7rbW7q2Ulwp/eh0TZLlz30iOXFtzrbYZuQs5UDF6bizXNs4jkLLjMoVIwmYcq7ZxeBsUZi2jWva0Ko8GhsZu9NsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDmQnnAW1omAGVRmubrYvb6VTCFhM4GPFOGffijHsxI=;
 b=oBDWq21ryarqMO838g4SXNT3fgBIxu/ys+FyNECB+8JL0q3aFXJhym2TWsP3puphFITN6G7jmyzZzdA9xwGLdsLZ4ZOu5OVQ8QNvGW6gozd/xfxbTp0qK0drqAt45Kzp43SD9b7VgYkvD1eQYnkw+RBgn64Buwu9jypLAZj29oM/LUoReVs9JGNZHcQ4Yol+WYzHNV99N1+n6LcAwheNZ+uFxeGOd5rOPDIoXLcR8qAzHA0sOAOqmLujyM/Ul4sPbOk+5aTaDy/vtddmzRzg837zZUhH55goCl6wie4rxYbBufI21vGXEJoryfRb//ld7m6rLsGfoMC1qcSO5q5ICw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ1PR11MB6251.namprd11.prod.outlook.com (2603:10b6:a03:458::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Fri, 16 Jun
 2023 02:42:51 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 02:42:51 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Thread-Topic: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Thread-Index: AQHZn2PPlNEvmdczhUGNGr4N1q3IM6+LjxGAgAAEy5CAABPwAIABDtMg
Date: Fri, 16 Jun 2023 02:42:50 +0000
Message-ID: <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
In-Reply-To: <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ1PR11MB6251:EE_
x-ms-office365-filtering-correlation-id: d8dee72f-13c3-4e38-33bc-08db6e1360a1
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Seg7QgEgJ3sGsmBazyTLzZtdY0vO5Y1cakUEJMdWueM2I87e7azRilU1srtsdDHWfl6sJ9dg3KXV9AFuKGpWABLEfiAuqzQZF6hJZ11Q+1dtYk/xo55i4bZrJKGFoaX3zb0ytQOUwDlKDE+MSAMovqn2cWgVzaZhdfjx+jumwlHUxSYnkEHO3+yhnMybAjChnHGGLDxzNOHTb3Xr9h9OPHcXbQb74fYscTz1wIw8Tk6ZrSOO+oi3Q9nJUs4UCGm0Fvt/U427VXV/s5OgpRUpILyzEAr1wFcXk5c2JXv4sqVQXQUQ4awRukcVWc3X1Rt4qVS6SHf+AlY9zYL4PBX8e2Cq+9Z7Kqa5v/B4mz2N8v73k36EAkTRB3RTGycngr2Z8R6xHsNjOjVsh4duWUkPnq+8XZ1MfOl6dBRoI5lu8sLSz+QKDl23pCBkmoXSe0U6ey8udylksB7Jbxqa5sk7M1rKgYkB9LeIZlQbcmmuoe7f0rFjcH352FYx3Wsevu2+4vui/KGuUsQFbw3j1FLhs7ulxBEb3aOf/7wStC0CaiRwVvOlhM+kp6L+KqIImECQTzaDEQUW4dCtdBFmYUA+/GpoW1HJGTNOUr6lAmngRJPK/d/iEqEesSiHfRCyFWfJ
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(136003)(396003)(376002)(39860400002)(366004)(346002)(451199021)(26005)(7696005)(8936002)(9686003)(8676002)(41300700001)(82960400001)(478600001)(71200400001)(66446008)(66556008)(4326008)(66946007)(66476007)(38100700002)(86362001)(76116006)(64756008)(6916009)(54906003)(38070700005)(316002)(33656002)(122000001)(53546011)(55016003)(6506007)(52536014)(83380400001)(5660300002)(186003)(107886003)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MTM2bFJZMnhCcTM4ckp1MEVGVWJacFFPdzBFUTB3eVYrNzZ4cmdpS1IyZnBu?=
 =?utf-8?B?eThCbThCTTFUcGRyNVBBRDh1UkxlOHh3dS9rUlJrb1ptd0NQb3FBMnRaVHQ0?=
 =?utf-8?B?SFg0VTVLNEYxdFBDUFNKWURnTTdsSlpGYnVvS010bkxoMWVBL0FNVU9RNFBG?=
 =?utf-8?B?dVdmSkZjcDFNTjZUS2grSGI5aStNVXEyc25GRjFRbWgydmpSR3JEWWVDOXl3?=
 =?utf-8?B?bDVwMU9IOE1Kdi9TUmNZRTF2VW1yUzkxOTRzcXEwMGhPS0YybU4xVm1FT05y?=
 =?utf-8?B?aUNXc1dhMHdzQ3NFQkNHRmZ2dnlndE50d01LYmZiQmNRSDgrVXRjd3QvRlQ5?=
 =?utf-8?B?WmRsZ09MOXRoSm1ySm8rNWF1SHg3QURZMDdiKzhqUVUrNzJEbHdnZXZLeWM3?=
 =?utf-8?B?Y3ZPVzNkUnhMa3lTb1h6T1haS0hXNUhEdjFmS0djZXFrUDZ3aXV1N1BCeXVp?=
 =?utf-8?B?K0plUFQwZ3BhOW5PL25zait0UGQxaHVHKzNkaXpxck9ZTUFUNUlPSGIvcks0?=
 =?utf-8?B?L29CZmpnUm11b2R4NFIyL2JsU3ZINmp4THVXdk1zc2RxUFkxU1RlQTZNZ1p3?=
 =?utf-8?B?N2R5SGphWVVrbXFUMFJ3SzlLSFJuZU9wQWxpTnUzRjZmQ0lFb1cxRml1cWw1?=
 =?utf-8?B?NmErSENIQ3NPMTF0RkN6cFZRVjdDbGNiL1FUS0hqRG8rc1c1aUNac1R5Z3pt?=
 =?utf-8?B?L3hBNnBXM3kyWmIyVnJCNzFoVXhLOE81TmljanJ3UFEwcUZmcGJRZHZRNzUv?=
 =?utf-8?B?OUZ4TmtEaVNHVVZwbzRMVE9ES2VFZFRmMEt6TkZZR3lxS3JJMDJ3b0hOd1cz?=
 =?utf-8?B?V1h5akZzMHZ0d1BETk9VVU5RdlczTmRyRnJyYjFHcTNLMExVQjBDem8vNG11?=
 =?utf-8?B?Z3BuSEtxZExhTjRRY1g5ZjVyZWoyZldjR0ZLZGFBMUsxNmIrMGdRMDY4OENN?=
 =?utf-8?B?SXZPNGtHSDZyUXdGQkVJYWhTOHFZNGpab3lLMzNwSEc3U2t2S2x3a2pYR0Y5?=
 =?utf-8?B?UlZ3blpNSE5tcXpJaStEZCtVUEdLOUJLWUN1QkxRT0tSdjhGUVNpMlFRVEtG?=
 =?utf-8?B?YjNkaE0zV1U5YVdXeGdVUVdkb3hDVG1Odlc4MkVnMUhlNm9OeGpjZmZnMXJD?=
 =?utf-8?B?dis1S3VWODlFeFpIOTZZNmR2cUdxUUN3UHA5SUJxbDNUTmZXelBiYjFidnRy?=
 =?utf-8?B?MWlTQ1pXM3hxTkRaOFM0N3ByQjJqNVlHZ1QxQllHTXkwQS9YSzI0dnNucGI1?=
 =?utf-8?B?blFrZ1htNnZLa29SOTFnekpWV2kyTkZBdGNWRk44dHZpUWl4SlpZQzQxV1hq?=
 =?utf-8?B?QjB4QUx2YjYwL1VhT3phdGswVVJqY0NwTUVtOVdteFFUWlBKSC9kNWR5QTJX?=
 =?utf-8?B?QUZWT1BscmNmbnAyUTZXaWVrck16OG5PQWZIMzRqdVpLQVhnYXQ2UVd5TTl4?=
 =?utf-8?B?ZnRQTHBYYW5nSWhkeFUvSjNvaHVwMmhTZ0VwR1ZIWTFWY3kyR0wrWWt4NmJ5?=
 =?utf-8?B?SEhOZEd2SGJoZnE5MWI1Rm1aT1NhZjhnOWhpNk5tYnQwc2RiTTZvVmhZTG0r?=
 =?utf-8?B?VnJLSDYyaTFjck5VajBEcTVrcUFYSXRSRExuN2grRkFKTHBrQ0x3Q0FsS1FQ?=
 =?utf-8?B?M1NqcE1CL3dyNzJjOWtzRklrQU1sRWpheGZyNzluOEY0cTBNaDB4cThKbk5w?=
 =?utf-8?B?cHNUN0NkdmlWWWlvU1RCTlZCT2ZoOFVXbmY2VThEWEN3bEtNL1NKRHFKYmZF?=
 =?utf-8?B?N2hsa2hQbkMvWlRoZE43VjJEM3JUSE1nVHUwdStOaWdvc0grNk5aTkZySWpE?=
 =?utf-8?B?bWpmR3l6RDhsNjRseTd0MXBSNFdxVXhBcmpoZGREVU9LN1FWd1hXckh0bDJE?=
 =?utf-8?B?eDRuUHZZeitKaXFGc2wyYzRmK2R0dWZpcEVZU1lMVnJIQXlXWm5JRml6QjRP?=
 =?utf-8?B?TTl0dTlwSjhjT2VwT1l6YXA5eG9RNng5N094Y3B4dWh4ekFwMnVKa3pQWjNa?=
 =?utf-8?B?b1pnc1h6aUtEZ1B0L0g2VnBhZnBDWEpnK0FYRVBBZng0dVdqWHdZN0ZSVEt3?=
 =?utf-8?B?cmdnWmtnYmxPd2VaTndJZW5sOFVkYlV4VFp3SnJJT0orN2dWYTdZNUZOc0w4?=
 =?utf-8?Q?Auhel/qfeB+B+9IN/WoVxVJE+?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d8dee72f-13c3-4e38-33bc-08db6e1360a1
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 02:42:50.7236 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iDCTvzBZaHFcC1MCi4IslcwVYnkdmY9CZXd0Lo0Ap78oB6Y/ubGBtXg/yw/sIzobWTYHEeghc0NIYnzazxBkGmtyaDkpQb7i9gj1JkcGeig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6251
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mga04.intel.com
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

Pi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+RnJvbTogSm9hbyBNYXJ0aW5zIDxqb2FvLm0u
bWFydGluc0BvcmFjbGUuY29tPg0KPlNlbnQ6IFRodXJzZGF5LCBKdW5lIDE1LCAyMDIzIDY6MjMg
UE0NCj5UbzogRHVhbiwgWmhlbnpob25nIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Q2M6
IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbTsgcWVtdS1kZXZlbEBu
b25nbnUub3JnOw0KPlBlbmcsIENoYW8gUCA8Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPlN1Ympl
Y3Q6IFJlOiBbUEFUQ0hdIHZmaW8vbWlncmF0aW9uOiBGaXggcmV0dXJuIHZhbHVlIG9mIHZmaW9f
bWlncmF0aW9uX3JlYWxpemUoKQ0KPg0KPk9uIDE1LzA2LzIwMjMgMTA6MTksIER1YW4sIFpoZW56
aG9uZyB3cm90ZToNCj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+IEZyb206IEpv
YW8gTWFydGlucyA8am9hby5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj4+PiBTZW50OiBUaHVyc2Rh
eSwgSnVuZSAxNSwgMjAyMyA0OjU0IFBNDQo+Pj4gVG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpo
b25nLmR1YW5AaW50ZWwuY29tPg0KPj4+IENjOiBhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbTsg
Y2xnQHJlZGhhdC5jb207DQo+Pj4gcWVtdS1kZXZlbEBub25nbnUub3JnOyBQZW5nLCBDaGFvIFAg
PGNoYW8ucC5wZW5nQGludGVsLmNvbT4NCj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSB2ZmlvL21p
Z3JhdGlvbjogRml4IHJldHVybiB2YWx1ZSBvZg0KPj4+IHZmaW9fbWlncmF0aW9uX3JlYWxpemUo
KQ0KPj4+DQo+Pj4NCj4+Pg0KPj4+IE9uIDE1LzA2LzIwMjMgMDk6MTgsIFpoZW56aG9uZyBEdWFu
IHdyb3RlOg0KPj4+PiBXZSBzaG91bGQgcHJpbnQgIk1pZ3JhdGlvbiBkaXNhYmxlZCIgd2hlbiBt
aWdyYXRpb24gaXMgYmxvY2tlZCBpbg0KPj4+PiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXplKCkuDQo+
Pj4+DQo+Pj4+IEZpeCBpdCBieSByZXZlcnRpbmcgcmV0dXJuIHZhbHVlIG9mIG1pZ3JhdGVfYWRk
X2Jsb2NrZXIoKSwgbWVhbndoaWxlDQo+Pj4+IGVycm9yIG91dCBkaXJlY3RseSBvbmNlIG1pZ3Jh
dGVfYWRkX2Jsb2NrZXIoKSBmYWlsZWQuDQo+Pj4+DQo+Pj4NCj4+PiBJdCB3YXNuJ3QgaW1tZWRp
YXRlbHkgb2J2aW91cyBmcm9tIGNvbW1pdCBtZXNzYWdlIHRoYXQgdGhpcyBpcyBtYWlubHkNCj4+
PiBhYm91dCBqdXN0IHByaW50aW5nIGFuIGVycm9yIG1lc3NhZ2Ugd2hlbiBibG9ja2VycyBnZXQg
YWRkZWQgYW5kIHRoYXQNCj4+PiB3ZWxsDQo+Pj4gbWlncmF0ZV9hZGRfYmxvY2tlcigpIHJldHVy
bnMgMCBvbiBzdWNjZXNzIGFuZCBjYWxsZXIgb2YNCj4+PiB2ZmlvX21pZ3JhdGlvbl9yZWFsaXpl
IGV4cGVjdHMgdGhlIG9wcG9zaXRlIHdoZW4gYmxvY2tlcnMgYXJlIGFkZGVkLg0KPj4+DQo+Pj4g
UGVyaGFwcyBiZXR0ZXIgd29yZGluZyB3b3VsZCBiZToNCj4+Pg0KPj4+IG1pZ3JhdGVfYWRkX2Js
b2NrZXIoKSByZXR1cm5zIDAgd2hlbiBzdWNjZXNzZnVsbHkgYWRkaW5nIHRoZQ0KPj4+IG1pZ3Jh
dGlvbiBibG9ja2VyLiBIb3dldmVyLCB0aGUgY2FsbGVyIG9mIHZmaW9fbWlncmF0aW9uX3JlYWxp
emUoKQ0KPj4+IGNvbnNpZGVycyB0aGF0IG1pZ3JhdGlvbiB3YXMgYmxvY2tlZCB3aGVuIHRoZSBs
YXR0ZXIgcmV0dXJuZWQgYW4NCj4+PiBlcnJvci4gRml4IGl0IGJ5IG5lZ2F0aW5nIHRoZSByZXR1
cm4gdmFsdWUgb2J0YWluZWQgYnkNCj4+PiBtaWdyYXRlX2FkZF9ibG9ja2VyKCkuIFdoYXQgbWF0
dGVycyBmb3IgbWlncmF0aW9uIGlzIHRoYXQgdGhlIGJsb2NrZXINCj4+PiBpcyBhZGRlZCBpbiBj
b3JlIG1pZ3JhdGlvbiwgc28gdGhpcyBjbGVhbnMgdXAgdXNhYmlsaXR5IHN1Y2ggdGhhdA0KPj4+
IHVzZXIgc2VlcyAiTWlncmF0ZSBkaXNhYmxlZCIgd2hlbiBhbnkgb2YgdGhlIHZmaW8gbWlncmF0
aW9uIGJsb2NrZXJzIGFyZQ0KPmFjdGl2ZS4NCj4+DQo+PiBHcmVhdCwgSSdsbCB1c2UgeW91ciB3
b3Jkcy4NCj4+DQo+Pj4NCj4+Pj4gU2lnbmVkLW9mZi1ieTogWmhlbnpob25nIER1YW4gPHpoZW56
aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+Pj4gLS0tDQo+Pj4+ICBody92ZmlvL2NvbW1vbi5jICAg
IHwgNCArKy0tDQo+Pj4+ICBody92ZmlvL21pZ3JhdGlvbi5jIHwgNiArKystLS0NCj4+Pj4gIDIg
ZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA1IGRlbGV0aW9ucygtKQ0KPj4+Pg0KPj4+
PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb21tb24uYyBiL2h3L3ZmaW8vY29tbW9uLmMgaW5kZXgN
Cj4+Pj4gZmE4ZmQ5NDliMWNmLi44NTA1Mzg1Nzk4ZjMgMTAwNjQ0DQo+Pj4+IC0tLSBhL2h3L3Zm
aW8vY29tbW9uLmMNCj4+Pj4gKysrIGIvaHcvdmZpby9jb21tb24uYw0KPj4+PiBAQCAtMzk5LDcg
KzM5OSw3IEBAIGludCB2ZmlvX2Jsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKEVycm9y
DQo+Pj4gKiplcnJwKQ0KPj4+PiAgICAgICAgICBtdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlvbl9i
bG9ja2VyID0gTlVMTDsNCj4+Pj4gICAgICB9DQo+Pj4+DQo+Pj4+IC0gICAgcmV0dXJuIHJldDsN
Cj4+Pj4gKyAgICByZXR1cm4gIXJldDsNCj4+Pj4gIH0NCj4+Pj4NCj4+Pj4gIHZvaWQgdmZpb191
bmJsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKHZvaWQpDQo+Pj4+IEBAIC00NDQsNyAr
NDQ0LDcgQEAgaW50IHZmaW9fYmxvY2tfZ2lvbW11X21pZ3JhdGlvbihFcnJvciAqKmVycnApDQo+
Pj4+ICAgICAgICAgIGdpb21tdV9taWdyYXRpb25fYmxvY2tlciA9IE5VTEw7DQo+Pj4+ICAgICAg
fQ0KPj4+Pg0KPj4+PiAtICAgIHJldHVybiByZXQ7DQo+Pj4+ICsgICAgcmV0dXJuICFyZXQ7DQo+
Pj4+ICB9DQo+Pj4+DQo+Pj4+ICB2b2lkIHZmaW9fbWlncmF0aW9uX2ZpbmFsaXplKHZvaWQpDQo+
Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL21pZ3JhdGlvbi5jIGIvaHcvdmZpby9taWdyYXRpb24u
YyBpbmRleA0KPj4+PiA2YjU4ZGRkYjg4NTkuLjAxNDY1MjFkMTI5YSAxMDA2NDQNCj4+Pj4gLS0t
IGEvaHcvdmZpby9taWdyYXRpb24uYw0KPj4+PiArKysgYi9ody92ZmlvL21pZ3JhdGlvbi5jDQo+
Pj4+IEBAIC02NDYsMTIgKzY0NiwxMiBAQCBpbnQgdmZpb19taWdyYXRpb25fcmVhbGl6ZShWRklP
RGV2aWNlDQo+Pj4+ICp2YmFzZWRldiwNCj4+PiBFcnJvciAqKmVycnApDQo+Pj4+ICAgICAgfQ0K
Pj4+Pg0KPj4+PiAgICAgIHJldCA9IHZmaW9fYmxvY2tfbXVsdGlwbGVfZGV2aWNlc19taWdyYXRp
b24oZXJycCk7DQo+Pj4+IC0gICAgaWYgKHJldCkgew0KPj4+PiArICAgIGlmIChyZXQgfHwgKGVy
cnAgJiYgKmVycnApKSB7DQo+Pj4NCj4+PiBXaHkgZG8geW91IG5lZWQgdGhpcyBleHRyYSBjbGF1
c2U/DQo+Pg0KPj4gTm93IHRoYXQgZXJyb3IgaGFwcGVucywgbm8gbmVlZCB0byBhZGQgb3RoZXIg
YmxvY2tlcnMgd2hpY2ggd2lsbCBmYWlsDQo+PiBmb3Igc2FtZSByZWFzb24uDQo+Pg0KPg0KPkJ1
dCB5b3UgZG9uJ3QgbmVlZCB0aGUgKGVycnAgJiYgKmVycnApIGZvciB0aGF0IGFzIHRoYXQncyB0
aGUgd2hvbGUgcG9pbnQgb2YNCj5uZWdhdGluZyB0aGUgcmVzdWx0Lg0KPg0KPkFuZCBpZiB0aGVy
ZSdzIGFuIGVycm9yIHNldCBpdCBtZWFucyBtaWdyYXRlX2FkZF9ibG9ja2VyIGZhaWxlZCB0byBh
ZGQgdGhlDQo+YmxvY2tlciAoZS5nLiBzbmFwc2hvdHRpbmcgSUlVQyksIGFuZCB5b3Ugd291bGQg
YmUgZmFpbGluZyBoZXJlIHVubmVjZXNzYXJpbHk/DQoNCklmIHRoZXJlIGlzIGFuIGVycm9yIHFk
ZXZfZGV2aWNlX2FkZCgpIHdpbGwgZmFpbCwgY29udGludWUgZXhlY3V0aW9uIGlzIG1lYW5pbmds
ZXNzIGhlcmU/DQpUaGVyZSBpcyBFUlJQX0dVQVJEIGluIHRoaXMgcGF0aCwgc28gaXQgbG9va3Mg
KCplcnJwKSBpcyBlbm91Z2guDQoNCklmIEkgcmVtb3ZlZCAoZXJycCAmJiAqZXJycCkgdG8gY29u
dGludWUsIG5lZWQgYmVsb3cgY2hhbmdlIHRvIGJ5cGFzcyB0cmFjZV92ZmlvX21pZ3JhdGlvbl9w
cm9iZQ0KRG8geW91IHByZWZlciB0aGlzIHdheT8NCg0KICAgIGlmICghKmVycnApIHsNCiAgICAg
ICAgdHJhY2VfdmZpb19taWdyYXRpb25fcHJvYmUodmJhc2VkZXYtPm5hbWUpOw0KICAgIH0NCg0K
VGhhbmtzDQpaaGVuemhvbmcNCj4NCj5TdGlsbCBpdCBmZWVscyBzdHJhbmdlIHRvIHVzZSB0aGUg
ZXJyb3IgcG9pbnRlciB0byBjaGVjayBmb3IgdGhhdCwgaXQncyBiZXR0ZXIgdG8NCj5yZXR1cm4g
ZXJyb3IgYXBwcm9wcmlhdGVseS4NCj4NCj4+Pg0KPj4+PiAgICAgICAgICByZXR1cm4gcmV0Ow0K
Pj4+PiAgICAgIH0NCj4+Pj4NCj4+Pj4gICAgICByZXQgPSB2ZmlvX2Jsb2NrX2dpb21tdV9taWdy
YXRpb24oZXJycCk7DQo+Pj4+IC0gICAgaWYgKHJldCkgew0KPj4+PiArICAgIGlmIChyZXQgfHwg
KGVycnAgJiYgKmVycnApKSB7DQo+Pj4NCj4+PiBTYW1lIGhlcmU/DQo+Pg0KPj4gVG8gYXZvaWQg
Y2FsbGluZyBpbnRvIHRyYWNlX3ZmaW9fbWlncmF0aW9uX3Byb2JlKCkgd2hpY2ggaGludHMgdmZp
byBtaWdyYXRpb24NCj5yZWFsaXplIHN1Y2NlZWQuDQo+Pg0KPg0KPlRoYXQgd2FzIGNsZWFyLCBt
eSBxdWVzdGlvbiB3YXMgbW9yZSByZWxhdGVkIHRvIHNlY29uZCBjbGF1c2UgeW91IGFyZQ0KPmFk
ZGluZy4uDQo+DQo+PiBUaGFua3MNCj4+IFpoZW56aG9uZw0KPj4NCj4+Pg0KPj4+PiAgICAgICAg
ICByZXR1cm4gcmV0Ow0KPj4+PiAgICAgIH0NCj4+Pj4NCj4+Pj4gQEAgLTY2Nyw3ICs2NjcsNyBA
QCBhZGRfYmxvY2tlcjoNCj4+Pj4gICAgICAgICAgZXJyb3JfZnJlZSh2YmFzZWRldi0+bWlncmF0
aW9uX2Jsb2NrZXIpOw0KPj4+PiAgICAgICAgICB2YmFzZWRldi0+bWlncmF0aW9uX2Jsb2NrZXIg
PSBOVUxMOw0KPj4+PiAgICAgIH0NCj4+Pj4gLSAgICByZXR1cm4gcmV0Ow0KPj4+PiArICAgIHJl
dHVybiAhcmV0Ow0KPj4+PiAgfQ0KPj4+Pg0KPj4+PiAgdm9pZCB2ZmlvX21pZ3JhdGlvbl9leGl0
KFZGSU9EZXZpY2UgKnZiYXNlZGV2KQ0K

