Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC577361F6
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 05:06:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBRg9-0007jB-PF; Mon, 19 Jun 2023 23:05:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBRg8-0007j3-34
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 23:05:12 -0400
Received: from mga12.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qBRg0-0000or-G8
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 23:05:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1687230304; x=1718766304;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=/XoyIJr2nMvCb8inihEKNCEdHp98T9QwYXxYNZXJ9MA=;
 b=WJWz51BXACujqM/SZ6M+3/uvy2Krn/MWhnKPbV3N5Jj/pohdBRhLRp88
 LUbXqw4fQwy2jZMlz+YoiPLmnMvKpyvp2W0O+m8Td15CARe4QcTDwWM9Y
 Dd6ziLu52+GyTXfKPejaj7pzqauCPOxabRbq572rnpzuqMF0AXZTHDR0x
 ZHtpQNnqZs1OCCgh9YMVPtUmCYXBiCOgEzbgRbVYtgKBke1FykRRokBVN
 TmgtmPBEgDNq6QiRqq9xJ/wkdbJlfok+fa6nMapd+CPKzFRuqXBmgpwpV
 7sy1oNa2Tpu/9vd3RQSoqwCk+zEQOruRlCue7gDgCe2KUqYI9kJ3gq8sQ g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="339366357"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="339366357"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2023 20:04:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10746"; a="1044078067"
X-IronPort-AV: E=Sophos;i="6.00,256,1681196400"; d="scan'208";a="1044078067"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga005.fm.intel.com with ESMTP; 19 Jun 2023 20:04:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 20:04:59 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Mon, 19 Jun 2023 20:04:58 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Mon, 19 Jun 2023 20:04:58 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Mon, 19 Jun 2023 20:04:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FNASYIoh+G69wcU7JiqzvMQJkzhn6D0fyxU86nuZj8KWKf43hNqwDF6IHga7roL8rkngWQeWLOfEqU7Sa3UbuZn8k4s0CHhPUvwZtdwqrNInIaSPXIFznjUyCJr6MgVuMRcgapbdcvTzvl/zY119rdi/BbbT/UX9tPfCtrMNX7EZDPTxEEr4XOxHphWP2UR0xNbt6nPgwc53Y3dyEh1/XOP8AVGKfh6Z6mDAfH7FpgcH7pFEOU9fg9AJR56G/yGxXhrBLRCbWtcJkfKr1RXc6vP2llYiUO9OxH7ywiNwVE19OEHsNRWQXLMXSiy7vcGq+k4OxKqadFWFPCrVMJ2xuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/XoyIJr2nMvCb8inihEKNCEdHp98T9QwYXxYNZXJ9MA=;
 b=U3oR9DCPPr/e3B+YYKVVP2nyvpDEKTiI7zXEOIoxwSxeK+ecza02GoraMuDys19gKYTinwHETFGy3TFPnEFKVF7dtkx1iN8LJ15ba88080o5cCviL7P/WUP/6P/5qtstYfZYhKsbHUqF+xfb+GW0WKlmt/+s2jbe/UsqwMmJMY7G7Nc12m1suK5DnsMrujfySM1qALK17HG8Sku1ljmvdjZJJadbff/0phVHM4P2eMqw8AVpUWvpuR0n+mHDR7UqDkCmJ/4BUcXAGVikr6ZhH+42O6JvGtIFEf5EZf7AQxAENd9XxXwIW9dhZKIe0ZER676/n1P3h1KdZD2QV2DB5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CO6PR11MB5617.namprd11.prod.outlook.com (2603:10b6:5:35c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Tue, 20 Jun
 2023 03:04:54 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%5]) with mapi id 15.20.6500.036; Tue, 20 Jun 2023
 03:04:54 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Avihai Horon <avihaih@nvidia.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "Martins, Joao"
 <joao.m.martins@oracle.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Thread-Topic: [PATCH v2] vfio/migration: Refactor and fix print of "Migration
 disabled"
Thread-Index: AQHZoowecKaj4XAnBEKc7Un5J/J7Ha+R+RWAgAEJD5A=
Date: Tue, 20 Jun 2023 03:04:54 +0000
Message-ID: <SJ0PR11MB67443F8A4A7AF037379355C5925CA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230619084446.399059-1-zhenzhong.duan@intel.com>
 <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
In-Reply-To: <41469da8-dae3-df36-6de1-4b44bf6ba508@nvidia.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CO6PR11MB5617:EE_
x-ms-office365-filtering-correlation-id: 19011fc9-2221-4158-e5ac-08db713b1f7a
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lhYxU7v+YLBwH+SrISm9eSMzm9le9/Af1ol5tsejdQm9m5xB0FHTX+r/CGS9AxyZRE9Bi9g3u1ffn1t4AVDCtnR/XQqEkWhlb8bm8e1WtOuiTwN/Hi3tSQRpmMB6IoXTS1Dj0wQVtqi1NrnaBn6fhUDECisg6Xsr5Qmb7iR15bWDlFgSCSU1wZxvEA/5792xbOMKFR2PxmGRx10gUJttJ1jMkM+i5jLGX2q2UQXTEVdrOy1mZSEPcYbkUIZrXEiOOuIf6Ob8W5/iFA0n6CCWdoIJy4z2SMMIt8WV/GSanZNmVambczDBIU+90oPyRqFhc3TfXA0F0/nF7Qilv0c41BDSTmU0q51qn3g85C1+Amb6Gqjrysh5po3XrToQDmAxwGfmHwUFFXe8i8adXMshQUW0rE/ZiQwRiN47CM0rHt8k1LG/FewxjAcIJZ2Qxb1X/9/GVbXiND2gFn/O04m/HlnucFmOqO3WQsulhl2dRg6LA1VmLV4iS1RTF7LPWsquIEYeQ7SeEgO5wCqD2rC2wukFrFbk3eicFLWYZdOuEXzZw+Dj7VkwYiPs6ZH6MwuP43f8DQYsbVPeeuXEQrCdYxiiv3SX0WG96QBmjvNGXummPk9niRKn9OKs6nQUHzSn
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(136003)(366004)(396003)(39860400002)(451199021)(26005)(107886003)(33656002)(83380400001)(6506007)(9686003)(71200400001)(110136005)(54906003)(478600001)(7696005)(82960400001)(316002)(41300700001)(122000001)(38100700002)(86362001)(66446008)(76116006)(66946007)(4326008)(66476007)(66556008)(64756008)(2906002)(38070700005)(8936002)(8676002)(55016003)(186003)(52536014)(5660300002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3k0MmdIeGpEa0lHTmhGdnZsVVZadTU2d0V4OU5KOVlMY00zS3FzdTREV2Jt?=
 =?utf-8?B?UEx6Q2pkSUZmd2NkSVhMWEhacWFHcUxvekhXWEhkTlNiVHFlN3c4WjErRnF6?=
 =?utf-8?B?UGNhVFNOYkJsMDdGaStzTVMyd2h1UEdFWnluS0dmdytlVU9wRmRVSGxvM2Mw?=
 =?utf-8?B?cDA1cVVDTWZUV2tSZ1g1TmJoeVFOWmFYSFVmM21KbU42RjFIK3VGcVcvUTZ4?=
 =?utf-8?B?Vmw1bTNrUnN5WmhaRXJQTzBrcEgySnlJSTQxUi9tSDcyWmJvOU1Yd0RFRnBn?=
 =?utf-8?B?ZHdVR05CQllaQXpIdDJjOHhMN1QxRkxiMVNBMEdaTkR2WFIwd2hhNDB0MHpl?=
 =?utf-8?B?ZkgrMDFEdW9KZnZObmRuT01YQzh5Vi9wQ2FUNm9YTkF1Z092c1NJRksvU1dB?=
 =?utf-8?B?QnA4QkxXUTVVSXR3dlRqNStRZlRRaGV5Tk5rWE5sd1c5cm5ZQmcyOEU5ZG54?=
 =?utf-8?B?WXh3MFBYZTdqNkdUMmU2c2JIOVgyL2U4MzdHVnNIbW96aUNmODB0NEVydWFJ?=
 =?utf-8?B?YmlFcHl4WlpwTlJnY1lqd1pxTk9lYlNaUTRDRllMWjBseTR0bTFlTFQyV284?=
 =?utf-8?B?MldaT0Z1djhzRHFwek9xT2xiRzBkcU5zUXZPMjBIWDdHS3VNbkpyR00wdkpF?=
 =?utf-8?B?eUpJTlp6NTVkMTRaV3Q0aVYrR2ZpQUZ3d3hZazJaK1U4YzBQeVJEK05acm1p?=
 =?utf-8?B?cmVZUzBYZEV0WVRXQ0FDQnN6d2kyVUhlbUZFVXBJdmRZT2JYOGs5NWhMS3lJ?=
 =?utf-8?B?SVZxT09oRnlQUHEyMERzdXA2N0tPM0tqbGpTNi9lSXZtbU84NkxzOTd0WXIr?=
 =?utf-8?B?aDIzOVk3cXZBSDN1UmYrQjM3MUNaWXNBTFdkVS9WT2w0NDQwaDZEMmFRMlRD?=
 =?utf-8?B?QUp5UlFvclpvU0lOazhYVUlRNXVod1pBWHdRdUlQTUliL1RKYW5teEpPM2lZ?=
 =?utf-8?B?NFhJeldxUkxwTlZUMUtvU1RraE4zYUR2bXBLQVBPSmMyMDBnWEtEay9xV0xn?=
 =?utf-8?B?c21aMTRuUmJaekdqRjc2Q2hjRGJyc2xJQ3BnQTUxR1laSmFHd0dKVGZYNzdy?=
 =?utf-8?B?bGZTK2xCUFdCVDBNOVhzUlZ1b2NEYld3WEFxcmpuUExJanpVUDdwcnh3ZkU0?=
 =?utf-8?B?TzRPZE1zSWZ6MUZsWHpWRmt5NE1aWFdDbzJCN1pDbEp2b2hXMFBhUFloQ1By?=
 =?utf-8?B?WnRTdDY2UDFWaDJnYVdOUStkQ2M0ckdram8zSFFzUFpLc3FoR3cybm9VSTFv?=
 =?utf-8?B?cmV6aDZQMUhsc0s3RjM5aDh4WDY4R2dHWDRhZ0dTR0RMckdLV0RsZ2JibFB4?=
 =?utf-8?B?WDFqY3RZamVvVU0zM3FqVjJzMmRHUFJZaUhpcGc0QkFWWnVmUlE2d2lPb1JW?=
 =?utf-8?B?RWFwV1lmRS9OQ2swWmpqNy8yaDZIbWFZMEEzd3dMalpUYjhRckFjTVA4UEVt?=
 =?utf-8?B?OEp0b1ZCSThjdGFLa1g2UzhsK2VXT2JmZWhvYThGVzB4R052NVNaemtDdDRB?=
 =?utf-8?B?WmlZRy9ITDJsTm14VndHQUdWMEFXbXRXVDE2dkZRQ2pqcmppWXI0Ylc0QzVY?=
 =?utf-8?B?cCtLVjRucTF6aHI5VC9vN3dXMVdIcCtmNnZULzJGZVRUeUxnQU02M243ZHRv?=
 =?utf-8?B?Z3Y3NVIway9ORHFCcXhOOFZUTTJaWVVWNnhObmgveUMya3JIZXJMV0JHNWt2?=
 =?utf-8?B?WFlDa1p5U0JpSjdpZU40UUUwU2NJNm9ZajArak1EdkJNWVZIU0ZEa2ZlazdS?=
 =?utf-8?B?ZlNlWHZEWEJkTTBjVFQvdHNySzdWZmdmZ3Qwc1pwZEdtNk5DMTVrVlU1MThw?=
 =?utf-8?B?ak5PWDVhK3c1bHlkTnZORUdDZDY0aER0TDJCeDlvNHNLUmxkN2Yxc2t2K05l?=
 =?utf-8?B?cEpKVEhXMXlvVjg3cEplZHZ6bFJqSkpBbVNwS3BqQ29iWmExVWo0T2lGTFo0?=
 =?utf-8?B?bDMxSm9pcExvRDFnenErUDBBNS9zeWhidmovbnU0eUZaYWdIRDJkUGVSMlBy?=
 =?utf-8?B?M0ZFTy9hM1NGMk1Qa3NUMm1adlN0cXU3NWFkUlZGaGRKZ2FSWnhhWGQ5dTk5?=
 =?utf-8?B?ZGN6YXRISncyMXF0dEx2UXVDc2F4dkx5TWo1V0NPVjlsblBRQ08zTWI0WGo4?=
 =?utf-8?Q?7dXvO6Ky7BjsZpCuaqjyW4mQL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19011fc9-2221-4158-e5ac-08db713b1f7a
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2023 03:04:54.8028 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ltNP+bpovWuCD1DUbp6PMQ4PZ1l5FI13G7mvjlw3oXaneh3nPAfR3d/hlS6n1xNYQqPgCEITM7EuB6SUwrMHq37iqO8rEBr1SE8SUepQq0M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR11MB5617
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=zhenzhong.duan@intel.com; helo=mga12.intel.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEF2aWhhaSBIb3JvbiA8YXZp
aGFpaEBudmlkaWEuY29tPg0KPlNlbnQ6IE1vbmRheSwgSnVuZSAxOSwgMjAyMyA3OjE0IFBNDQou
Li4NCj4+IGEvaHcvdmZpby9taWdyYXRpb24uYyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMgaW5kZXgN
Cj4+IDZiNThkZGRiODg1OS4uYmM1MWFhNzY1Y2I4IDEwMDY0NA0KPj4gLS0tIGEvaHcvdmZpby9t
aWdyYXRpb24uYw0KPj4gKysrIGIvaHcvdmZpby9taWdyYXRpb24uYw0KPj4gQEAgLTYzMiw0MiAr
NjMyLDQxIEBAIGludDY0X3QgdmZpb19taWdfYnl0ZXNfdHJhbnNmZXJyZWQodm9pZCkNCj4+ICAg
ICAgIHJldHVybiBieXRlc190cmFuc2ZlcnJlZDsNCj4+ICAgfQ0KPj4NCj4+IC1pbnQgdmZpb19t
aWdyYXRpb25fcmVhbGl6ZShWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3IgKiplcnJwKQ0KPj4g
K2Jvb2wgdmZpb19taWdyYXRpb25fcmVhbGl6ZShWRklPRGV2aWNlICp2YmFzZWRldiwgRXJyb3Ig
KiplcnJwKQ0KPj4gICB7DQo+PiAtICAgIGludCByZXQgPSAtRU5PVFNVUDsNCj4+ICsgICAgaW50
IHJldDsNCj4+DQo+PiAtICAgIGlmICghdmJhc2VkZXYtPmVuYWJsZV9taWdyYXRpb24pIHsNCj4+
ICsgICAgaWYgKCF2YmFzZWRldi0+ZW5hYmxlX21pZ3JhdGlvbiB8fCB2ZmlvX21pZ3JhdGlvbl9p
bml0KHZiYXNlZGV2KSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZygmdmJhc2VkZXYtPm1pZ3Jh
dGlvbl9ibG9ja2VyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAiVkZJTyBkZXZpY2UgZG9lc24n
dCBzdXBwb3J0IG1pZ3JhdGlvbiIpOw0KPj4gICAgICAgICAgIGdvdG8gYWRkX2Jsb2NrZXI7DQo+
PiAgICAgICB9DQo+Pg0KPj4gLSAgICByZXQgPSB2ZmlvX21pZ3JhdGlvbl9pbml0KHZiYXNlZGV2
KTsNCj4+IC0gICAgaWYgKHJldCkgew0KPj4gKyAgICBpZiAodmZpb19ibG9ja19tdWx0aXBsZV9k
ZXZpY2VzX21pZ3JhdGlvbihlcnJwKSkgew0KPj4gKyAgICAgICAgZXJyb3Jfc2V0ZygmdmJhc2Vk
ZXYtPm1pZ3JhdGlvbl9ibG9ja2VyLA0KPj4gKyAgICAgICAgICAgICAgICAgICAiTWlncmF0aW9u
IGlzIGN1cnJlbnRseSBub3Qgc3VwcG9ydGVkIHdpdGggbXVsdGlwbGUgIg0KPj4gKyAgICAgICAg
ICAgICAgICAgICAiVkZJTyBkZXZpY2VzIik7DQo+PiAgICAgICAgICAgZ290byBhZGRfYmxvY2tl
cjsNCj4+ICAgICAgIH0NCj4NCj5IZXJlIHlvdSBhcmUgdHlpbmcgdGhlIG11bHRpcGxlIGRldmlj
ZXMgYmxvY2tlciB0byBhIHNwZWNpZmljIGRldmljZS4NCj5UaGlzIGNvdWxkIGJlIHByb2JsZW1h
dGljOg0KPklmIHlvdSBhZGQgdmZpbyBkZXZpY2UgIzEgYW5kIHRoZW4gZGV2aWNlICMyIHRoZW4g
dGhlIGJsb2NrZXIgd2lsbCBiZSBhZGRlZCB0bw0KPmRldmljZSAjMi4gSWYgeW91IHRoZW4gcmVt
b3ZlIGRldmljZSAjMSwgbWlncmF0aW9uIHdpbGwgc3RpbGwgYmUgYmxvY2tlZA0KPmFsdGhvdWdo
IGl0IHNob3VsZG4ndC4NCj4NCj5JIHRoaW5rIHdlIHNob3VsZCBrZWVwIGl0IGFzIGEgZ2xvYmFs
IGJsb2NrZXIgYW5kIG5vdCBhIHBlci1kZXZpY2UgYmxvY2tlci4NCg0KVGhhbmtzIGZvciBwb2lu
dCBvdXQsIHlvdSBhcmUgcmlnaHQsIHNlZW1zIEkgbmVlZCB0byByZXN0b3JlIHRoZSBtdWx0aXBs
ZSBkZXZpY2VzIHBhcnQgY29kZS4NCg0KUmVnYXJkcw0KWmhlbnpob25nDQo=

