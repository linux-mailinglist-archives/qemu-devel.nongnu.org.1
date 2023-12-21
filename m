Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C1081B227
	for <lists+qemu-devel@lfdr.de>; Thu, 21 Dec 2023 10:24:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGFH2-0006Ds-MG; Thu, 21 Dec 2023 04:23:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rGFH0-0006DV-LS
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:23:22 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rGFGy-0000SX-6p
 for qemu-devel@nongnu.org; Thu, 21 Dec 2023 04:23:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1703150601; x=1734686601;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=AAY9mAHzlxeEqT+MVgvY7c7b/I4lddkaeHmoq7ZsvMA=;
 b=K+H7OC22V1bhMoHjXJO7WS6ifVhf8h5wxs+G7rCui7AOYNgrr9PKWMPV
 vLihoWnNjeqRmbW0sy3FVAy1Vun9revxPb78UAWWdf10X3HE0cFMfInxi
 gi4Fv7QXG3ITvRhOdtJqXuI7R7rXBI9hoC5v3TALSny5iBObdkWU86e/A
 yDOcmxKOYFuSyawo48KNgLfKckOGtASlsaXSep3RayU8yYFl6Z3ymP+gM
 R77okX094MQpqbTCHvNVWt7adTKWnDDk9X2wah3uGEtoLhs5DR+ViHjOp
 GY30OxTgCqjOz5c2Ts49O+kYx0mPjKWV5OLtWxAkFcjwCsiKnHlrD7Ip4 Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="3187095"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; 
   d="scan'208";a="3187095"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Dec 2023 01:23:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10930"; a="810916333"
X-IronPort-AV: E=Sophos;i="6.04,293,1695711600"; d="scan'208";a="810916333"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
 by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Dec 2023 01:23:16 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 21 Dec 2023 01:23:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 21 Dec 2023 01:23:16 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 21 Dec 2023 01:23:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XyUoU450eF83bSbeeuD43pvdnSvUuAAozub9+MpCKDP9+kMj0L2/T7fCB1+xhkjzb0rykpbQifyW7syhdERqWz6D7mHosYfmKa6vCg1WP6Xd79C4sPZ/w2WCcV36Q1aQnQfwktAHjquOkaMh5FLnP6vvx2Ix1x3K1Z2G9HafzMkxc2QUYUVnHT6VHSs9+zdJFhcBMaj4987RV2KE93X1XYwyc6u77n7SZt45GalO4//lRTrJgU0lvSLhm3gz+tBZh3oaUlIKfRK7RfYNVOugoYP6ex013Ku5LoZTVh6B9pKG19kAvBqOqjlbR6eLFhsAC4+bLj4T15zCiR2AA2fKOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AAY9mAHzlxeEqT+MVgvY7c7b/I4lddkaeHmoq7ZsvMA=;
 b=IbWKoysyXNLITQle59qrv0DoUakCEdCGhI52brjY2CBEogM7vC41OjcPewwwsAKQtrqqcYcboh2P+fUjQQOGKpn8H84iUfMdPHUCktDWQBmgul2Yk7YtNJlJfRESynva9bJ9F+tJL1C6UH+Ns1jJ0uO8oa32rnv5sfKx8pQhyY73iJOsgwb8YLK61J+ayp+vEj+DePpeQWNg2BawpMF0XDvehsz5eHKOj5am7xz10/UZXteq12XiRUo3FhdcNmmwqRWZOEryz7PFaQVs+58+G3x9zejqPOqR0kMnmlTpUaTaaYDje6en/pgsb8K1CLHNC92+Y8SPGojPVmst1vYQVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH0PR11MB5950.namprd11.prod.outlook.com (2603:10b6:510:14f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 09:23:14 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7091.034; Thu, 21 Dec 2023
 09:23:13 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Eric Auger <eric.auger@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>
Subject: RE: [PATCH] vfio/iommufd: Remove the use of stat() to check file
 existence
Thread-Topic: [PATCH] vfio/iommufd: Remove the use of stat() to check file
 existence
Thread-Index: AQHaM+UqeJknvgSwEUu7ME6CfwkGM7CzblOQgAAGgYCAAAFbcA==
Date: Thu, 21 Dec 2023 09:23:13 +0000
Message-ID: <SJ0PR11MB674415332CEDD03287E861F49295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231221080957.1081077-1-clg@redhat.com>
 <SJ0PR11MB6744B077E851815942C260C69295A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <51941699-5f1e-4f61-adb8-dba79af7d55d@redhat.com>
In-Reply-To: <51941699-5f1e-4f61-adb8-dba79af7d55d@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH0PR11MB5950:EE_
x-ms-office365-filtering-correlation-id: e9cc2f1d-bc25-4ea4-350e-08dc02067536
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Iay2hqm88aQUuPcSg8HfvibD0/oMH6G/r3WMlTqMtTed1hGHXxHNeOHy1sGzLgW17vbWlTlhbatMSPAKsfcvvi4k4x/NbAnZwVlfVvDu2nOVKkOmVfit4fc3lYpRp9S14lWm/cZegh5zCTBGNaxjk3utl/O8T8r74OXmZbdup9Yxq759Ir7l4QlPVQIZPiE6JzHuVgTWzVqadZPt8TCRuNcyIPWV3Qi1LmrQHBqIfmV0F/MoHQFEkTYXgA/AD/9/RSpXuc3xwaTxm/Nwnf4KQCP0qIgEKfYYYWqB2HU0Xdc8kGonc2aWSMDfzfcnYuDalLiqiF36N0mqJFRB5Zca+kH1/1qnkFU3fBmqTi6Yh7S5MjV8FMj5jOqECb40UBDarcjEf5jQJbNOp79iIjCIuCmx7PziJOtqEFZPXdxs+u3HHDRDWnfeFq2SFl8eqQc0q2gQjNq6u6A3bA2u5kMI29RT82dEF36OVSi9AhEX8BrKTpbzBwOA30h8zPwvBtnwbbS3vXybsXGKOdge0/zk+WKgmBEivCG0uv10axBwQ2NEqjk2IbjZndcvZtA5GAKIUsYeSvA/kBLIR7zDHu81V6sBl2Bawi81j95baRpUB461WU7gFr39l1Bu2CIhvvi6
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(136003)(396003)(376002)(346002)(366004)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(38070700009)(55016003)(66446008)(71200400001)(7696005)(26005)(53546011)(478600001)(52536014)(4326008)(8676002)(8936002)(110136005)(76116006)(66556008)(66476007)(9686003)(64756008)(316002)(66946007)(2906002)(6506007)(54906003)(5660300002)(66574015)(122000001)(41300700001)(83380400001)(33656002)(86362001)(38100700002)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TU5EY0dYVGdUYWthY3JmWU0ySW1FSGJkZnNOYUU4Q1hBKy8zcFpQcG1pYVZH?=
 =?utf-8?B?SEpjK0FyUU1UM0lyeTZwN0hBTW5vSmNBVXJ5bzBrWHlSa2JzMEMwY0diUm1B?=
 =?utf-8?B?RXFURmdqcDJHTng3VHpWd0lzT0NYTmZDblpUOUFRTXJYeXhpMUhURW5KcVc1?=
 =?utf-8?B?MHVmZmswTlpzeXMrUktncUJ4eWFrSTRtZUdnTGZRY29wVWs0Wmtlci9DbHFp?=
 =?utf-8?B?UXFPVjEva3FRV3BqdUU2TnNON2h5L2laaFo0SXM0NGRONGsrMEdxRDRQTkJI?=
 =?utf-8?B?aForUXRSNFY5MUNlZ0lwMjFWeDRIM1JPUzVlQ05EaEhySkRsQmZabHFvUDht?=
 =?utf-8?B?VjJsbkhybGhYcTVSclR6RFQ3bjVkMkhiNDZSSjROTmtZY0pCbjRyMzlRMnBs?=
 =?utf-8?B?M1QrSE9TK1ZpalpETU9IQnlkUzE2b0J2d0d0cHhpVkhZUVlzejBMb3dLc1JD?=
 =?utf-8?B?MzBkc0cyVFRySTVkQzdRS29GbVpZZlBTSHRLMzhjQXd4TXNreUtPKzlXQTJn?=
 =?utf-8?B?Q2NKaW5scnRTU0ZMK3NtOFRuckxvU1lHUzFpc3lNVGNUZld1elN4Y0pmckdy?=
 =?utf-8?B?aXR0V0JIdm9iM0Q0QWRLYjlURFo4T3hPNk5NT2FjSG9mZTdjMzZOOUJUKzVI?=
 =?utf-8?B?NUtuLzBUWmx2VVdBRzlsZlNKSXNNb3I5T2xVaERJUG9hQ2FhWTRMTksveWg4?=
 =?utf-8?B?RTdNRWxuK1NmbFp0NW1Pa1pua0dQZEw2VHJNSi9LR1hnMWhDcmNVWXZCOHMv?=
 =?utf-8?B?SWJaZ01pNGMrU1F4MlBlekxtV1Zvd0FmVjRaNDN4c3NBUVhFUWIxQVE4Sm4z?=
 =?utf-8?B?Nnc2S1ZLSGs4MzN2Q2FCU0NIOFhaRFJ4eHBPRUVhQWRsY2p1TEs2dlhiWmQ0?=
 =?utf-8?B?dXdZSkZ4UXY1ZWUwQ2RObXAxMTkzTHZ3UGFabzI5dDZxUTVmcHN0Q2VmVU5s?=
 =?utf-8?B?bjgwZzJ6VDlsQy8vMmdPZHBQcDlUenZabGwrRDhTVGNaV2tjeDFHUDdZTnJ6?=
 =?utf-8?B?dFZpeVA1ZSswdkxoMTFzU21yZ0hzaGEzMVJyYkplUDVYcU41UldsL3VEbS96?=
 =?utf-8?B?TnUvWm9Yczl6Vjd2bDFYaGdlT2d0cVdTclFYaDdxNkVucjRiVXBsbzNCZlBW?=
 =?utf-8?B?Z0plRFRGb1ZodERMWWZ4R0d1YnhnSHJYUlZnUWhOczZLZ09rbHgreXRJYzNF?=
 =?utf-8?B?NzVlRkcyK3lNK0V5ZEM2S3dIeklwdjF4WHFzeitxNGFmd2NIQ25JVzJUQVV5?=
 =?utf-8?B?NitKUXFOcFpSYlZnN0pvSC9JY2J2U1JUdkVIM3Rwa3VMa2NwMDJiSDVkTU51?=
 =?utf-8?B?TDBIYjNDNGE0RG9XVURrSDhJbUl1M1huVzViZnR2U1RSallidzNtaUhKNVNH?=
 =?utf-8?B?WTlSdHdzeUZraFAvaExYWCtnWTBLdDExSmxDaDF3MmFoakUxSnRxeTNzaUlh?=
 =?utf-8?B?NWw2TXpTcGtxSlBwSTdIZWVTTzV1NlR2R3c2UFZKTzIwY2pPN2pCZEhqbUQw?=
 =?utf-8?B?VEE3U0dnQ203K0wweGwxQUpZT3FtSDl4OVR3RkZNd0FsdlY5MFYyOHFuN0tp?=
 =?utf-8?B?UkJHVlVqQjNKamxjZ0FJQUUwcTUzSEN4WnY4VnY3T3N3Zk51ZTRkUjE1Ui8r?=
 =?utf-8?B?UWFaRkhLc09GL2tsSkg1M2lLZ0NPb3FZc2tMZ0d5R3ExUHRkODBabTA0K1Fn?=
 =?utf-8?B?R1J5NE5CWGROcDdNdDdQVCs3bnkyYW11SnQ4d2ZYdG5iV0VUSHZ1ZDlXQU5J?=
 =?utf-8?B?b3VhY1BuUk9NbjlPMXRibEtFMXY1TWQ3Wm5hT3cxTkN2bDNaTEM5QjJBYXJs?=
 =?utf-8?B?d3BTTUxTQ3UzSzF6MTZXMUVROE1oQTZNYmNFRHphNGtvY3VUWG80emQycVRa?=
 =?utf-8?B?Zjlwc2hSaWE4ZUZVdldDZ2JodlRDdndEL3lldnAxcldKVld4Y014TTVvclBx?=
 =?utf-8?B?M2ovcTQyRldlcUc5Z0NGY0o0Nmd0N0hEMUtjY1FZbm4ybFRjSWw4R0Zic2VZ?=
 =?utf-8?B?cGdMTjN4TW4zZmJwRis0SXJlT2FCWTB3Y01BTkF4TGN5OE9qZTdRa2RiYzA4?=
 =?utf-8?B?RmlMa1lPRkRuRTlVZ3IyaWo1bVBsOU44TlFFVFcxSGw4cFk1aVIwbmZXUm1R?=
 =?utf-8?Q?A/yI8OEc5ro8vy2ZpzxMNQYKw?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e9cc2f1d-bc25-4ea4-350e-08dc02067536
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Dec 2023 09:23:13.8702 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KZCSYSbq5aQ/2r7tDjTBMge3l+DM0ISSWpVowlSY1fVeGm0TxZxhSa/2HQ2OwIQysWKy4QbeLBww22QdUlEk3vJnhnoFtRIHBVTJ8Y6U6SM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5950
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEPDqWRyaWMgTGUgR29hdGVy
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgRGVjZW1iZXIgMjEsIDIwMjMgNTox
NiBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZmaW8vaW9tbXVmZDogUmVtb3ZlIHRoZSB1c2Ug
b2Ygc3RhdCgpIHRvIGNoZWNrIGZpbGUNCj5leGlzdGVuY2UNCj4NCj5IZWxsbyBaaGVuemhvbmcN
Cj4NCj5PbiAxMi8yMS8yMyAwOTo1NSwgRHVhbiwgWmhlbnpob25nIHdyb3RlOg0KPj4NCj4+DQo+
Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+PiBGcm9tOiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+Pj4gU2VudDogVGh1cnNkYXksIERlY2VtYmVyIDIxLCAyMDIz
IDQ6MTAgUE0NCj4+PiBTdWJqZWN0OiBbUEFUQ0hdIHZmaW8vaW9tbXVmZDogUmVtb3ZlIHRoZSB1
c2Ugb2Ygc3RhdCgpIHRvIGNoZWNrIGZpbGUNCj4+PiBleGlzdGVuY2UNCj4+Pg0KPj4+IFVzaW5n
IHN0YXQoKSBiZWZvcmUgb3BlbmluZyBhIGZpbGUgb3IgYSBkaXJlY3RvcnkgY2FuIGxlYWQgdG8g
YQ0KPj4+IHRpbWUtb2YtY2hlY2sgdG8gdGltZS1vZi11c2UgKFRPQ1RPVSkgZmlsZXN5c3RlbSBy
YWNlLCB3aGljaCBpcw0KPj4+IHJlcG9ydGVkIGJ5IGNvdmVyaXR5IGFzIGEgU2VjdXJpdHkgYmVz
dCBwcmFjdGljZXMgdmlvbGF0aW9ucy4gVGhlDQo+Pj4gc2VxdWVuY2UgY291bGQgYmUgcmVwbGFj
ZWQgYnkgb3BlbiBhbmQgZmRvcGVuZGlyIGJ1dCBpdCBkb2Vzbid0IGFkZA0KPj4+IG11Y2ggaW4g
dGhpcyBjYXNlLiBTaW1wbHkgdXNlIG9wZW5kaXIgdG8gYXZvaWQgdGhlIHJhY2UuDQo+Pj4NCj4+
PiBGaXhlczogQ0lEIDE1MzE1NTENCj4+PiBTaWduZWQtb2ZmLWJ5OiBDw6lkcmljIExlIEdvYXRl
ciA8Y2xnQHJlZGhhdC5jb20+DQo+Pg0KPj4gVGhhbmtzIGZvciBmaXhpbmcsIFJldmlld2VkLWJ5
OiBaaGVuemhvbmcgRHVhbg0KPjxaaGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+DQo+SXQgc2Vl
bXMgdGhhdCB0b29scyBsaWtlIGI0IG5lZWQgdGhlIFItYiB0YWcsIGFuZCBwcm9iYWJseSBvdGhl
cg0KPnRhZ3MsIHRvIGJlIGF0IHRoZSBiZWdpbm5pbmcgb2YgYSBuZXcgbGluZS4gU28sIGp1c3Qg
cmVwZWF0aW5nIDoNCj4NCj5SZXZpZXdlZC1ieTogWmhlbnpob25nIER1YW4gPFpoZW56aG9uZy5k
dWFuQGludGVsLmNvbT4NCg0KR290IGl0LCB3aWxsIGZvbGxvdyB0aGF0IHJ1bGUgaW4gdGhlIGZ1
dHVyZS4NCg0KVGhhbmtzDQpaaGVuemhvbmcNCg==

