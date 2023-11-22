Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C7B357F4520
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 12:51:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5lja-0007Nz-Bf; Wed, 22 Nov 2023 06:49:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5ljY-0007NY-5n
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:49:32 -0500
Received: from mgamail.intel.com ([192.55.52.120])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5ljV-0000q4-Kk
 for qemu-devel@nongnu.org; Wed, 22 Nov 2023 06:49:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700653769; x=1732189769;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=ZVPxMpYyFny1n09I1IvlOlYgwpjGdp/QlRUCWAR4lBs=;
 b=LA6tKdPId9Cp02DAnF5O8wpKjJ8ezU8fbVX0iLn/nWfy53MuZl1xrqth
 19itpYKcyAtAeYOntyGERuwo5fr39yfL7uhhi6x7h+T3qWBacl3ORRszu
 88aJc+69nAEaaFz0M+gY5nGOOfVXdFW1Bx51STA5kOHE3UfKD8wyW6ZtB
 mjyCwHmS3Nx2/XPMQeCrLayJa5TaBat30wzI+cvE6SY1SnFRdHrnGgAFr
 U5G4BkFFrPk/+Qkk5d+828IAOrCHei5oQcWNBLXWmRzJQ+pbpniiG+ng9
 dHAYY8o2OOQiW7BIna9EDa9bsKEjv0yyM4FmuEWxQbnrM97QMLXVDDzwH A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="390897595"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; d="scan'208";a="390897595"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2023 03:49:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014208216"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; d="scan'208";a="1014208216"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Nov 2023 03:49:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 03:49:25 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 03:49:24 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 03:49:24 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 03:49:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=In8nasVf2z88vmzi9rBW+R/U9pYpqAXPdWKutpUSrubA18IBLjOlZA6V6uB3md7t+JZ+D3NHOfH5YOjD70LsqpQQe4FZzdS7srz3kbD+1mw5Ocdh1dwUob9XXtnnc/VJmZXHa6gPkmXwROt32anCTTybrkn6MlBmoJgizwu+D3JAG+ATMxHxtgFTFwWFPLxEpvi/dRsZwQZzccLms5IDj8WsvGuSRFwHXL+frYjnOtwJGBzmHqRZaFNwL4DmimJA1usg431GmR00ysbAuGRkgoTvnt9nv3DlNpf9ocAv7RDjq/eoB7pZXz9nW5toUyYK1v8YaBMbNj+730o7Uw2yQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZVPxMpYyFny1n09I1IvlOlYgwpjGdp/QlRUCWAR4lBs=;
 b=NWvIjI95yd06N5FiL+0pxVcLOphyBf079vCdn510XaO7JtK+0ZQjrFhPykPmpiIjI9BM7qJVf+jr4KPnkdLpdrJOlbaXKCd76KygDL0E9MxobDLH763RVnK6+Vc5V98H8PU3fdImuMYBUb0aSja1C1GWo4WwIWzFUPIk1oN/UhaWsb5KH50BYq7zDPXsu2YR4GbjOEMoEM/H1My7zlSm1lV8sklonV7WtBTxDYpvGdQJgtm6Y6LW17/CdxCgkGCkKIPyOlRAO7mk7TGziItVdQlB/FJnNjGXcpF8yQP31uMzAxUu5uNRk+hbxEe40yDNhCfsVHO0Z5Qa3B/4vayBRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ2PR11MB8565.namprd11.prod.outlook.com (2603:10b6:a03:56b::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 11:49:18 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 11:49:17 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "joao.m.martins@oracle.com"
 <joao.m.martins@oracle.com>, "eric.auger@redhat.com" <eric.auger@redhat.com>, 
 "peterx@redhat.com" <peterx@redhat.com>, "jasowang@redhat.com"
 <jasowang@redhat.com>, "Tian, Kevin" <kevin.tian@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Sun, Yi Y" <yi.y.sun@intel.com>, "Peng, Chao P"
 <chao.p.peng@intel.com>, Thomas Huth <thuth@redhat.com>
Subject: RE: [PATCH v7 00/27] vfio: Adopt iommufd
Thread-Topic: [PATCH v7 00/27] vfio: Adopt iommufd
Thread-Index: AQHaHFc0W4LZl8jDnE6rBmZPePSx2LCFBg6AgACTyyCAAGMbAIAAOYOw
Date: Wed, 22 Nov 2023 11:49:17 +0000
Message-ID: <SJ0PR11MB6744F04EA29CA2697AD0B55892BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
 <182862f2-d339-4cba-aacf-bab06868272c@redhat.com>
 <SJ0PR11MB67449AA8E37A7CCCEF0B54CC92BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <365127fc-b161-4947-845d-cead7fa2e399@redhat.com>
In-Reply-To: <365127fc-b161-4947-845d-cead7fa2e399@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ2PR11MB8565:EE_
x-ms-office365-filtering-correlation-id: cb75a2ed-9944-4ccb-fc92-08dbeb510e7f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: W/jYn8snjHnn2FfSejc+JE2CXkPs0ArPQxbAWqofMD9ilhKLsi1N7w3ddUP2lrHRpwTDh++HqK6clVVtWQbrnVHe3tLoJMY6dYTD0WDbUPBDFfJnNPKfYjRfx2GPPftpVOMxOZux9gUSL+Rc/olfvBH2O7Iq+XRa7jMvcLkGDSaimwItHehbcWVK9T7a2Fp/QXmYa9NYfY85W/3UzqErtF2hkP/APz67xMlJpcP7W/hoZx3j/mFJMERfYgWNroiz2RkU2dEQPfnX25OT9UwmJwf+n6xvSk5lIc133Po0Mu3IwuPMrf8ELdP/GJ6uSqWl9+24gUf67UJSjaJXiPjQenb24NjZmuWvq76W2Zey9pwug9BG/kgEI1NA85LJLkZNyxEJAWrO50wsd6DoyQgcKiQwoTZzDKwL1SDvjw9XjGf4KCfrcb9K7dzuc3392ZoWZsznlgjbn56rlRIuOu6bOG3JAveXE4qNUVeYW1GjlF2F7VKW4wLv7qumgG/nb5EzgmMsNOKW3Dn7zZoGQtBixOuJYjrKxm0iFPXPYNG0CNUamonogB0o4KqJFOUbEmwUuJ3KjpdBtR0+dFv6y14QTBkRDJS6CqdEqPeJPKEvGNU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(396003)(346002)(376002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(966005)(7416002)(8676002)(5660300002)(55016003)(52536014)(4326008)(41300700001)(8936002)(2906002)(66446008)(66899024)(64756008)(316002)(54906003)(110136005)(66556008)(76116006)(66476007)(66946007)(86362001)(26005)(71200400001)(478600001)(38070700009)(9686003)(6506007)(66574015)(83380400001)(33656002)(122000001)(38100700002)(82960400001)(7696005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TThXYU5FMnZ4a09TSmFaaHFrSzE2dmQrMm1TajRJR1I2UmdoRnY1b3dkQThR?=
 =?utf-8?B?R2c2L1M4bkJweERqQU5VSEplMG5uN3NIQjZCbHgrVy9JeE1sNEZScFZKVStu?=
 =?utf-8?B?QjdSUFR2aTlVZkkwbkxjY3ZXT3BMZkEwZU1zalY4SlJnMFp6QmM1V2F4TGxI?=
 =?utf-8?B?R0Y5bzh2OEt6b1F4WVpLVFl5cVhBbE91TkNubkFKY25jamhWN3ptOG9sVmlq?=
 =?utf-8?B?cnZ2aW5Xek5FZGhFaXUyYit6L1FqM3hlR29peFhsOWppeWJLRjBuUjBhNkND?=
 =?utf-8?B?N20zV3U0dXNkZXNOcFJ4Njh6NEdzZW5ibWZTQVJZU2hrTE43aUFpRkxERi9a?=
 =?utf-8?B?c2dZQWVCQ1JPa1EzbTRRMDlJOFZFYVpiQUs1U1JpL3Zmb2tuMGs2VStHR3Fy?=
 =?utf-8?B?UWVydks1N01xQUZQVmZ5SGY1a3FrclFSMnZKRXlpVEVLR1pvZHNweGovNCto?=
 =?utf-8?B?SEhEMWMzNk5wSHdVZHZBeldob0RFZGovM25jczFLRWg5UlFOdW1qeUM3bTIz?=
 =?utf-8?B?Qzk2WkJHWUw5OUw4TkhCYVh2anZpZ1M0YWcyNXhsbWNkVUhJd1RMS3RCbk5H?=
 =?utf-8?B?TXdRZ2RvU0hTeHJHNkxOTDMwajJEa1RMZEx3cjhqT0RWQ0xyMnYrZlFUNTdo?=
 =?utf-8?B?MUVDSytBVlpsSFVucDZ1eVBzSTlJRUVNVU9lOW5HNTdVUGhLYmhWMkNQSHVt?=
 =?utf-8?B?M2o4dXBucEkxcjBpT2lCcUxXcUFvU3FTbW9EQnk3Ri9jakl2ZFlEYi9RTW1Z?=
 =?utf-8?B?TDEvc283N2hIcy9BaHREOEdlR3VFNlFzS0krQWZweXFDYXNSdm5oUGpHU3pv?=
 =?utf-8?B?dTdJT2x4Sk5KUXV3eFhPYnFtRytnK1BabVd6SmZKSmZaS0JHc0lwZ3liVlRh?=
 =?utf-8?B?MTJ0NWhCV29Oc1ZKMW1yZWsxaTVOd3J3VitrejF4RkxVSWtITDAxS0dYcFlN?=
 =?utf-8?B?bWZqU01QSVEzbUNTS1JRL3lmcWVCTHZwK21GbUFrUTlPektVSUNlTjFvRHdX?=
 =?utf-8?B?aXRnSnBnSzg2TFBqVkFHNEtqVkdaellTTlhOdS8xTnBvN04wcUMvRHNkc1Ra?=
 =?utf-8?B?bVpVNFBIaGdJalR3UGMvL3pqb0s0NVZQSnY3SWtrTGFkZTU2NHUyeVlKWU8y?=
 =?utf-8?B?a1hGTWV3UkFpOTNiZjZicGFJdllJcURWY2dnV3lxN2RJVld2VllWNVIwVkpN?=
 =?utf-8?B?VVVXcjQ3NlByajNIRUxJa012aTdxVUFqbjd5WXI5eTI1MWU0Vk9NN2xFenor?=
 =?utf-8?B?Nnl5bTlmb1FwQnJTMW9lTS9NbVFWQnMwa0R1cUVSS2diVU44RVRFY0NyNW1Z?=
 =?utf-8?B?aWo2YlIrbmpSSlE4bkFLT3pqMzV5a3B5MW1lWTF3cU5FdDRGK3RSWC9DUzNo?=
 =?utf-8?B?SFpYa01ZZm5kZ2d1bEZGbTB2ZDk3SUZydlh1Q1lMZytiTmR2UzdzaTl5Wk1B?=
 =?utf-8?B?WHpGSzdnaURUSW5hQVpMai9pWDBZSlBRa05OVTZJbXJnL1crS01rR0lOcGNR?=
 =?utf-8?B?SXpKbjhjYVViSnlsN0pvNVdZQlc0dDY3QS9remczc2lCQ2NzYWJCTlVmNFNQ?=
 =?utf-8?B?VnlkYWtoelFqZW9oSTVhbXJrY1hLSm9kK2tkVXRybWdVZENjMEZsb3J2TzlW?=
 =?utf-8?B?QW1ZMXU0aXIrQUJPMThGOVplSForUDFFNVF1WGI1dFNTSGVKemUzc0s4RFNU?=
 =?utf-8?B?eHd3QnFSQXJPcUNJN3RZUjBDVkc2OVB6ekFFVHlIVFBNVytDMm9QOWJzVnJw?=
 =?utf-8?B?bU9MakovT255UWNBMGVuU3RwWTlHejF3MzBHMDVabWNvbGxtKy9PTW9jOFRJ?=
 =?utf-8?B?Y0tQbmMvQTlOWFBCOHlpMlJQMWpoek82d25lZWFzaU5CdmJtY2dUMDZuTkYv?=
 =?utf-8?B?R0k5dHpHaVVBS3BrZzFwYlF3WjljRDRFRE56MzVDV05EeUNrTnZGOVhyZExO?=
 =?utf-8?B?V2grSUdXcW5WUlNHcm9IbHhCOTY5bnQ5Ym1pcTd6MUNOUm02UWxRbE5DYVdi?=
 =?utf-8?B?V09ZR1dWbko5ZUUva0oyWklLWGZ5aXBxS2lWUGVZMFYzSlhtSnlpQ1phM056?=
 =?utf-8?B?d1hEZkVWcENYSzRPQVFPcjFPT1JZREdRTk1hWXY4cUN6cnlDSGJ4cHJaUm4z?=
 =?utf-8?Q?n2ljXDz9QHLFdoMHkOKStM8W/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb75a2ed-9944-4ccb-fc92-08dbeb510e7f
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 11:49:17.0870 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eH5Gj63SRCdPAlDaKCsjJY7AN/eJprUmkai0kb04OcWcmWeEMVdMkBDHZY8ZzzL+uziVEK04fAYJG5eKtxFQN8++yPwglwDNmD6Ba84jeU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8565
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.120;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.058,
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIyLCAyMDIzIDQ6
MDcgUE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDAwLzI3XSB2ZmlvOiBBZG9wdCBpb21tdWZk
DQo+DQo+DQo+Pj4gVGhlIHNlcmllcyBpcyBwdXNoZWQgb24gdG9wIG9mIHZmaW8tbmV4dCBpbiB0
aGUgdmZpby04LjIgdHJlZSA6DQo+Pj4NCj4+PiAgICBodHRwczovL2dpdGh1Yi5jb20vbGVnb2F0
ZXIvcWVtdS9jb21taXRzL3ZmaW8tOC4yDQo+Pj4NCj4+PiB3aXRoIGEgbGl0dGxlIGV4dHJhIHRv
IGRlYWwgd2l0aCBhIFBQQyBidWlsZCBmYWlsdXJlLg0KPj4NCj4+IFRoYW5rcyBDw6lkcmljLiBU
aGF0J3Mgc3RyYW5nZSBJIGRpZG4ndCBzZWUgdGhpcyBmYWlsdXJlIG9uIG15IGVudg0KPj4gd2hp
Y2ggaGFzIENPTkZJR19WRklPX1BDSSBlbmFibGVkIGJ5IGRlZmF1bHQgZm9yIFBQQy4NCj4NCj4N
Cj5UaGUgY29tcGlsZSBpc3N1ZSBzaG93cyB3aXRoIC0td2l0aG91dC1kZWZhdWx0LWRldmljZXMu
DQo+DQo+VkZJTyBpcyBhbHdheXMgc2VsZWN0ZWQgKHNlZSBwcGMvS2NvbmZpZykgYnV0IFZGSU9f
UENJIGlzIG5vdCB3aGVuDQo+LS13aXRob3V0LWRlZmF1bHQtZGV2aWNlcyBpcyB1c2VkLiBIZW5j
ZSB0aGUgY29tcGlsZSBmYWlsdXJlIGJlY2F1c2UNCj5vZiB0aGUgY29tbW9uIHZmaW8tcGNpIHJv
dXRpbmVzIGV4cG9ydGVkIGluIHBjaS5jLg0KDQpDbGVhciwgdGhhbmtzDQoNCj4NCj5JZGVhbGx5
LCB3ZSBzaG91bGQgdXNlIGFuICdpbXBseSBWRklPJyBpbiBwcGMvS2NvbmZpZyBiZWNhdXNlIFZG
SU8NCj5pcyBub3QgYSByZXF1aXJlZCBzdWJzeXN0ZW0gZm9yIHRoZSBwc2VyaWVzIG1hY2hpbmUu
IElmIHRoYXQgd2FzDQo+dGhlIGNhc2UsIHdlIHdvdWxkbid0IGNvbXBpbGUgdGhlIFZGSU8gRUVI
IGhvb2tzIGRlZmluZWQgaW4NCj5ody9wcGMvc3BhcHJfcGNpX3ZmaW8uYyA6DQo+DQo+ICAgYm9v
bCBzcGFwcl9waGJfZWVoX2F2YWlsYWJsZShTcGFwclBoYlN0YXRlICpzcGhiKTsNCj4gICBpbnQg
c3BhcHJfcGhiX3ZmaW9fZWVoX3NldF9vcHRpb24oU3BhcHJQaGJTdGF0ZSAqc3BoYiwNCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFkZHIsIGludCBv
cHRpb24pOw0KPiAgIGludCBzcGFwcl9waGJfdmZpb19lZWhfZ2V0X3N0YXRlKFNwYXByUGhiU3Rh
dGUgKnNwaGIsIGludCAqc3RhdGUpOw0KPiAgIGludCBzcGFwcl9waGJfdmZpb19lZWhfcmVzZXQo
U3BhcHJQaGJTdGF0ZSAqc3BoYiwgaW50IG9wdGlvbik7DQo+ICAgaW50IHNwYXByX3BoYl92Zmlv
X2VlaF9jb25maWd1cmUoU3BhcHJQaGJTdGF0ZSAqc3BoYik7DQo+ICAgdm9pZCBzcGFwcl9waGJf
dmZpb19yZXNldChEZXZpY2VTdGF0ZSAqcWRldik7DQoNCkluZGVlZCwgSSByZXByb2R1Y2VkIHNh
bWUgYWZ0ZXIgc29tZSB0cnkgb3V0Lg0KTWF5YmUgbmVlZCBhIHN0dWIgZmlsZSBmb3IgdGhvc2Ug
ZnVuY3Rpb25zLg0KDQo+DQo+SXQgaXMgbm90IHRoYXQgc2ltcGxlIHRvIGZpeC4gVGhlIHNpbXBs
ZXIgYXBwcm9hY2ggaXMgdG8gZm9yY2UgY29tcGlsZQ0KPm9mIFZGSU8gUENJIGluIHBwYy9LY29u
ZmlnIHdpdGggYSAnc2VsZWN0IFZGSU9fUENJJy4gd2Ugc2hvdWxkIGltcHJvdmUNCj50aGF0Lg0K
DQpZZXMsIG5vdCBhIGJsb2NraW5nIGlzc3VlIGFmdGVyIHlvdXIgZml4LiBJIGNhbiBoYXZlIGEg
dHJ5IHdoZW4gSSdtIGlkbGUuDQoNClRoYW5rcw0KWmhlbnpob25nDQo=

