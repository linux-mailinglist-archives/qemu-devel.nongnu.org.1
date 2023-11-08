Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD9587E5024
	for <lists+qemu-devel@lfdr.de>; Wed,  8 Nov 2023 06:47:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0bOh-0002ez-93; Wed, 08 Nov 2023 00:46:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0bOf-0002eq-Ak
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:46:37 -0500
Received: from mgamail.intel.com ([192.55.52.136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r0bOd-0005yJ-HJ
 for qemu-devel@nongnu.org; Wed, 08 Nov 2023 00:46:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1699422395; x=1730958395;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=oFEio4/lBq/2k3dyRwYg/0Z8bYRktvpBg23JXIQ+rDY=;
 b=Ts3/m5POxGJqOK/wBPzgEuCXRdfTvrmjsUuaZ3MZGqqmEof8vtUAszhs
 i2afbVBWP+S+jCRsO9QQKb0QcK5kJwzo1iAO7K1vGHUw83zksC8xAUvTJ
 3s9ZxKfv+Wjcw62zWz//U2BGBqARQUhW5qaqWm9iGPa/wgq4q5607sc+i
 RTPitMSPP7QK8mP5jNFpqLOPHHQuP/lrRR5gcDlbOXBJyjbtm3x5TkY+C
 LKMktxqdUHrbSP+Fe5l3TAhbwuS6g4ulUmEufbuxB7185vBC5YobuG/SV
 cw1pLdbsbNkMl1L114fz76x23Y7wFxjgzbuLsnWgKwiLs0dgsbk0Y3Clw g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="369030501"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="369030501"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Nov 2023 21:46:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10887"; a="762950223"
X-IronPort-AV: E=Sophos;i="6.03,285,1694761200"; d="scan'208";a="762950223"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 07 Nov 2023 21:46:33 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 21:46:32 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 7 Nov 2023 21:46:31 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 7 Nov 2023 21:46:31 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 7 Nov 2023 21:46:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P+3aZKfsyR2fzM0F+8Twxu/1PkT3DCu+Om8SJIt9e89blexI33zMkbF9TlN2gRbKgPZ+2G4agQ+XqotfcThZmuyDkKQwLfGtTkiTwu3BVZLCxiI41nod7XZf/7aCZDXVGUJIjLxFzriILMX3LoTMrqOd9RXqZGEoRJkEVizMZzu3JfiIrnKkAw6k0yr3PbPz9PQLrR6is9++6gRADBN9QeupdJZtIR545I4cRts+cPdhQXZNN2eEjzckRykeNlTjPoROj2yI264mzYUv45CQW0jYXGlWUXCt1TdOf8mAvbFggAnklDiJe2OODQj0dQ+rM1pcq0HUiSHuA6vTIipOJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oFEio4/lBq/2k3dyRwYg/0Z8bYRktvpBg23JXIQ+rDY=;
 b=fy4C4cVrwEq3xWJaZzgSltCWHSuxhUY4Nhg3sZypfmMjzDXop9dgjv8wpcMGJdcX8M3q7nHu8qij/wDA4AfOx4ijnomW7hfy3kJcXR0gl2Ya/GsQCl3s5OyquanTG9CDJ5AWHkAPrUzfOVzHalLAhM54UjfT7vVy8Cq0e+l11MYf75i6E1ms0gfToLzkhvpxYkELnVv7f4dbYCn9pwryglZILR0KrEThLrehz8goMYu9HWiUrFQVVRuWLVb4XbukpeI3ctZ9b7p4JJvUJ5s+/rykSFEyDIU8M7yR4PHpYb4xyQRYWhTiK6vn/nTfJx5s0AVvufEeZEBIvIX3OHozLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.28; Wed, 8 Nov
 2023 05:46:27 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.6954.028; Wed, 8 Nov 2023
 05:46:27 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH v4 32/41] vfio/pci: Introduce a vfio pci hot reset
 interface
Thread-Topic: [PATCH v4 32/41] vfio/pci: Introduce a vfio pci hot reset
 interface
Thread-Index: AQHaDV6Bk4FadWRRjU2/7TEeGBIRTrBu6JYAgAEKQxA=
Date: Wed, 8 Nov 2023 05:46:27 +0000
Message-ID: <SJ0PR11MB674432D05AA6A3B4EA2FB6EE92A8A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231102071302.1818071-1-zhenzhong.duan@intel.com>
 <20231102071302.1818071-33-zhenzhong.duan@intel.com>
 <7cb2087f-dbd8-48fb-b0e2-9f59ce597084@redhat.com>
In-Reply-To: <7cb2087f-dbd8-48fb-b0e2-9f59ce597084@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|SJ0PR11MB6576:EE_
x-ms-office365-filtering-correlation-id: bf371a82-9777-4203-365b-08dbe01e0d1c
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HgSNQJeQdu+v2NK4iqv7fPMrYgm0oOkdADej/F/tv3aUw38UImLg5yeqrjR/Wf0NxQ598RNYqqJE2IYYe1EQTJN07dI+RrBQI0mZgS8Er/c8lEvad1w2YKZ+IOizd5TfHGw4QgOrJTFDeox8DjpPB0iHgxCWIQ8BbdtVHxH96sCu4a/B4cUeUBbvaKzSXBzrf3RP0ZSlE7xxmta69GSKD2CPW1WBlUB7rujAMeZYaXdnC8ZynBYzDjOQvcfOx8y0cihOMloWzOCdU7d/fP59WVbIT9Cq6zOUpuwOm9t/EvliHqijfZKCldG3zCUjkqDG6YRVl7WgEYk8IewYaG0s7Yen6aL/MJnNOoYxPD9ETZfPcb7koyTRARoPH764BF30lZ+3jIhh+P6DyeO5JxoAHXAoNWUNhYIQpe4o+7L33E3ryLwyrmsuLU0V1f8ITt/Dy2lqTWsHEe11ul2T5bEOZBuiGEcuGSzaizMa7lffOLu2Iq0EOh996U/s8JezXDYJ2afYJXJDy1kDAWZflqOu8kJmLgz5gIXvJe4Dow3hovEHwkN3GFGgdE7KHo25ZpxKa4Dn/HQ23ozxsFiNdsGyA7OSbSExoT5btqYM1sqJGrp/p9Cdc0YLpufgfjX53/cf
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(136003)(346002)(376002)(366004)(39860400002)(396003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(76116006)(66946007)(110136005)(26005)(9686003)(107886003)(83380400001)(478600001)(66574015)(7696005)(6506007)(71200400001)(52536014)(4326008)(8936002)(55016003)(8676002)(64756008)(316002)(66446008)(66556008)(54906003)(66476007)(5660300002)(41300700001)(38100700002)(86362001)(122000001)(82960400001)(2906002)(38070700009)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?N2MwL3ltYjk4VGxab0JHL2k1YUt5cytzdDBaK1h3dzd5N2o3S0ZoTVBnTXNN?=
 =?utf-8?B?Tm5PNWRIbEZMQU9Ddk5UR0t5TFZvWXlGOHpxUmtRWjA4elFkUE54QlRkM3J6?=
 =?utf-8?B?Y1V4a2JZZzdJTGEySlBxU0p2am02dGhRU3p2RU80c2xFL1l3bk50d0dSTEhH?=
 =?utf-8?B?T1FZTWc4ZFFvRzFQWjFhMTFvUEV0eDlyVkVLSUcxNnlQYXlIOVJuYVBWTytk?=
 =?utf-8?B?dlJxbDluQ2RDWTdIYTB4emRhaFI2dE9WNEF6RS9FZlJzVFRDVmVxcEFRL202?=
 =?utf-8?B?a0RVbTVCaGxqbkg3Z1p3L05UMGJUU09JekpRYVhnM3FIZy91UVJpSDlCakJV?=
 =?utf-8?B?M0J5aW1OR3plbk15MXhKN0xCRmhRVEFBMVRydE1zZTRzcmNBTUlYWVE1ekNi?=
 =?utf-8?B?NnFIVHN6YWlEbGc0QUdTOHZFTWNzSTVOSUozMWtybkdqNWVuMVNsWFlPY3Jt?=
 =?utf-8?B?RXJIMEZFZVdEWGNLamVPUytsUjA5c25DcE5lOEgvZWQrTFdPczhtLzZyZHRn?=
 =?utf-8?B?WjNVbDJPZi9rZXZ5SE5QVkZ6dmxaTXR0a3h1RFhTR3FhRnRsSnpyYVZVd0JJ?=
 =?utf-8?B?TXJOeXRuU01DV3U2eHhtL2ZQQVVJUEl4OE5CUjF0V1p4SXU1S2FkU2l3c01T?=
 =?utf-8?B?bFgwQ2xkYk5DN00wMVRMRHNuclRETnpjUWhEWXNWTkR0cldUbzg4WEkxUm0x?=
 =?utf-8?B?RnZVMEZKalR1MHJsWWd1K0RQSStud0hrbmU3U2VEeHhCUnFabEJBRnZSMEV4?=
 =?utf-8?B?ZE04NVBOci9qcUJaVDZLZDVaN3JLT3BBWDg4TnRSWXhTN1BRYUhHRWdJc0Fu?=
 =?utf-8?B?U2x6aFlwenRrQ2FYUkYwbitBVkt5Z1lCcDl3YkVxUWpvZitYMWtENk4zZmN4?=
 =?utf-8?B?S09IdkRkTkJXZm82dUFQYWt6bUVjR2FIM1lYeCsvT1kxdkdoOWpkNlg5YVZR?=
 =?utf-8?B?M0pKdytOVnRSNUdEUkhmZnRMemVYdDNPUUI5VkNldHpZTEdnalM0ZkVyRW5i?=
 =?utf-8?B?bWNOMzVqWEJQQW12QktQZGY5bGgvNnJKWGlSelpOeXoxL0hTd2JKZFk2UmYz?=
 =?utf-8?B?ZHZFekxHbWUwSFFCVWhueWZuK2ZUM216NjNTU1hKNEQrY3Voc3YyVFNTUkR4?=
 =?utf-8?B?aEEybXJmRTVBVEFDMVA3a29ZSVQ5TlRqNlZUTDE2Lzl0dm14SlBPcnUvOTlT?=
 =?utf-8?B?WXdkWWN6Y2NJU3ltM2JvZFIwRlVlU3RMc1UxU2RRTlpIcWhEZE9yaERuMVY4?=
 =?utf-8?B?NWVCZUZndHNPT3UyKzFGWG9WeGxjR3BFRHF2bzNuYUJBdE5zbG5qNEd1aEl3?=
 =?utf-8?B?VHUwL01ackZ4Q2NpWE5XUndySkk5RUhsSVV5QzNveUFSdzlyVzhrTXp0a0xH?=
 =?utf-8?B?RExSa1pnZkRHclpiWmVoTkpBcHpQVjFOK1NvaUFTSFBWdGk2RDlQalZ1Vytq?=
 =?utf-8?B?citUQzhVVWZXS2NremNvWXRvbXZTdmxtc3I2NHd4ZkZOdjh3Q05TbFdMOG9W?=
 =?utf-8?B?VU4zdkoxeU1VT21sUzd3cnl0SFdnYUlqd3g3amVOdkdDVFpYdi9UeGNtTnBm?=
 =?utf-8?B?VUd4QVpCOEprVDJFWU1uUER3UTZrWGRTamd6SGJKdHJUNjBvOG1DMHRlWEFv?=
 =?utf-8?B?MTg1T2R3ZncwaEpCZjl0ME4xeStFU0xWOERDdW5uaWFvZVZnekdrckFabWpl?=
 =?utf-8?B?TnNZbk5XT0NEZnZxSzB3RVZmWDZES1hkdVJQUVJiaHRSQmg0M3RRa0l4S0M2?=
 =?utf-8?B?VjFZY0FtaGZ3RDErSENPTHVXbm5hTHRPK2lKcGhxdG5FVE80Y3E4Y1lyTkx6?=
 =?utf-8?B?bFNDNDBxcnE4L1R1L2FrM1p2R3ZnNjZsanlQWFFTYXZSY0V4RVFzODB2cnNq?=
 =?utf-8?B?MzltSWErZDJMZVJnK2VrdGxBVnpSUEZOQm5GN21FbUVOaU84SWJlOVd6QnhC?=
 =?utf-8?B?UzFSUG11bVhxSmZ0RkVrUWxvTURqWC9vMko0QkN4b3Vkd1NEZFlCZUJhZ1Bl?=
 =?utf-8?B?d2cvUWdPQ3VVTS9xbGRjMFQ5SnRqYkJwRmVrd2pLeGxUV3pnZWVTS3lFaGpi?=
 =?utf-8?B?MENTMUtyNW5lMjljTVQ0SHRzME5lVTZwNTJrRVNzWnJKQklTamtoa3ZXMmcw?=
 =?utf-8?Q?6oDpjaCssLvbze+w68n+EOziv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bf371a82-9777-4203-365b-08dbe01e0d1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Nov 2023 05:46:27.6597 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: exxBaEhOxk68iX+mrPgMbVDMurumdDEtwFnTVIfINWwWWYSXhEfO+w5EdJkschJe7FOUML66KK9pM+nN888OBpyQE6zq2In4MEYxJPAyOno=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.136;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUdWVzZGF5LCBOb3ZlbWJlciA3LCAyMDIzIDk6NTMg
UE0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY0IDMyLzQxXSB2ZmlvL3BjaTogSW50cm9kdWNlIGEg
dmZpbyBwY2kgaG90IHJlc2V0IGludGVyZmFjZQ0KPg0KPk9uIDExLzIvMjMgMDg6MTIsIFpoZW56
aG9uZyBEdWFuIHdyb3RlOg0KPj4gTGVnYWN5IHZmaW8gcGNpIGFuZCBpb21tdWZkIGNkZXYgaGF2
ZSBkaWZmZXJlbnQgcHJvY2VzcyB0byBob3QgcmVzZXQNCj4+IHZmaW8gZGV2aWNlLCBleHBhbmQg
Y3VycmVudCBjb2RlIHRvIGFic3RyYWN0IG91dCBwY2lfaG90X3Jlc2V0IGNhbGxiYWNrDQo+PiBm
b3IgbGVnYWN5IHZmaW8sIHRoaXMgc2FtZSBpbnRlcmZhY2Ugd2lsbCBhbHNvIGJlIHVzZWQgYnkg
aW9tbXVmZA0KPj4gY2RldiB2ZmlvIGRldmljZS4NCj4+DQo+PiBTdWdnZXN0ZWQtYnk6IEPDqWRy
aWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFpoZW56aG9u
ZyBEdWFuIDx6aGVuemhvbmcuZHVhbkBpbnRlbC5jb20+DQo+PiAtLS0NCj4+ICAgaHcvdmZpby9w
Y2kuaCAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxICsNCj4+ICAgaW5jbHVkZS9ody92Zmlv
L3ZmaW8tY29udGFpbmVyLWJhc2UuaCB8ICAzICsrKw0KPj4gICBody92ZmlvL2NvbnRhaW5lci5j
ICAgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4+ICAgaHcvdmZpby9wY2kuYyAgICAgICAgICAg
ICAgICAgICAgICAgICB8IDExICsrKysrKysrKystDQo+PiAgIDQgZmlsZXMgY2hhbmdlZCwgMTYg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9ody92Zmlv
L3BjaS5oIGIvaHcvdmZpby9wY2kuaA0KPj4gaW5kZXggMTAwNjA2MWFmYi4uMTJjYzc2NTgyMSAx
MDA2NDQNCj4+IC0tLSBhL2h3L3ZmaW8vcGNpLmgNCj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmgNCj4+
IEBAIC0yMjAsNiArMjIwLDcgQEAgZXh0ZXJuIGNvbnN0IFByb3BlcnR5SW5mbw0KPnFkZXZfcHJv
cF9udl9ncHVkaXJlY3RfY2xpcXVlOw0KPj4NCj4+ICAgaW50IHZmaW9fcGNpX2dldF9wY2lfaG90
X3Jlc2V0X2luZm8oVkZJT1BDSURldmljZSAqdmRldiwNCj4+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgc3RydWN0IHZmaW9fcGNpX2hvdF9yZXNldF9pbmZvICoqaW5mb19w
KTsNCj4+ICtpbnQgdmZpb19sZWdhY3lfcGNpX2hvdF9yZXNldChWRklPRGV2aWNlICp2YmFzZWRl
diwgYm9vbCBzaW5nbGUpOw0KPj4NCj4+ICAgaW50IHZmaW9fcG9wdWxhdGVfdmdhKFZGSU9QQ0lE
ZXZpY2UgKnZkZXYsIEVycm9yICoqZXJycCk7DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
aHcvdmZpby92ZmlvLWNvbnRhaW5lci1iYXNlLmggYi9pbmNsdWRlL2h3L3ZmaW8vdmZpby0NCj5j
b250YWluZXItYmFzZS5oDQo+PiBpbmRleCA0YjZmMDE3YzZmLi40NWJiMTljNzY3IDEwMDY0NA0K
Pj4gLS0tIGEvaW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4gKysrIGIv
aW5jbHVkZS9ody92ZmlvL3ZmaW8tY29udGFpbmVyLWJhc2UuaA0KPj4gQEAgLTEwNiw2ICsxMDYs
OSBAQCBzdHJ1Y3QgVkZJT0lPTU1VT3BzIHsNCj4+ICAgICAgIGludCAoKnNldF9kaXJ0eV9wYWdl
X3RyYWNraW5nKShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwgYm9vbCBzdGFydCk7DQo+
PiAgICAgICBpbnQgKCpxdWVyeV9kaXJ0eV9iaXRtYXApKFZGSU9Db250YWluZXJCYXNlICpiY29u
dGFpbmVyLCBWRklPQml0bWFwDQo+KnZibWFwLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBod2FkZHIgaW92YSwgaHdhZGRyIHNpemUpOw0KPj4gKyAgICAvKiBQQ0kgc3BlY2lm
aWMgKi8NCj4+ICsgICAgaW50ICgqcGNpX2hvdF9yZXNldCkoVkZJT0RldmljZSAqdmJhc2VkZXYs
IGJvb2wgc2luZ2xlKTsNCj4+ICsNCj4+ICAgICAgIC8qIFNQQVBSIHNwZWNpZmljICovDQo+PiAg
ICAgICBpbnQgKCphZGRfd2luZG93KShWRklPQ29udGFpbmVyQmFzZSAqYmNvbnRhaW5lciwNCj4+
ICAgICAgICAgICAgICAgICAgICAgICAgIE1lbW9yeVJlZ2lvblNlY3Rpb24gKnNlY3Rpb24sDQo+
PiBkaWZmIC0tZ2l0IGEvaHcvdmZpby9jb250YWluZXIuYyBiL2h3L3ZmaW8vY29udGFpbmVyLmMN
Cj4+IGluZGV4IGVkMmQ3MjFiMmIuLmYyN2NjMTVkMDkgMTAwNjQ0DQo+PiAtLS0gYS9ody92Zmlv
L2NvbnRhaW5lci5jDQo+PiArKysgYi9ody92ZmlvL2NvbnRhaW5lci5jDQo+PiBAQCAtMzMsNiAr
MzMsNyBAQA0KPj4gICAjaW5jbHVkZSAidHJhY2UuaCINCj4+ICAgI2luY2x1ZGUgInFhcGkvZXJy
b3IuaCINCj4+ICAgI2luY2x1ZGUgIm1pZ3JhdGlvbi9taWdyYXRpb24uaCINCj4+ICsjaW5jbHVk
ZSAicGNpLmgiDQo+Pg0KPj4gICBWRklPR3JvdXBMaXN0IHZmaW9fZ3JvdXBfbGlzdCA9DQo+PiAg
ICAgICBRTElTVF9IRUFEX0lOSVRJQUxJWkVSKHZmaW9fZ3JvdXBfbGlzdCk7DQo+PiBAQCAtOTI5
LDQgKzkzMCw1IEBAIGNvbnN0IFZGSU9JT01NVU9wcyB2ZmlvX2xlZ2FjeV9vcHMgPSB7DQo+PiAg
ICAgICAuZGV0YWNoX2RldmljZSA9IHZmaW9fbGVnYWN5X2RldGFjaF9kZXZpY2UsDQo+PiAgICAg
ICAuc2V0X2RpcnR5X3BhZ2VfdHJhY2tpbmcgPSB2ZmlvX2xlZ2FjeV9zZXRfZGlydHlfcGFnZV90
cmFja2luZywNCj4+ICAgICAgIC5xdWVyeV9kaXJ0eV9iaXRtYXAgPSB2ZmlvX2xlZ2FjeV9xdWVy
eV9kaXJ0eV9iaXRtYXAsDQo+PiArICAgIC5wY2lfaG90X3Jlc2V0ID0gdmZpb19sZWdhY3lfcGNp
X2hvdF9yZXNldCwNCj4+ICAgfTsNCj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL3BjaS5jIGIvaHcv
dmZpby9wY2kuYw0KPj4gaW5kZXggZWI1NWU4YWU4OC4uYTYxOTRiN2JmZSAxMDA2NDQNCj4+IC0t
LSBhL2h3L3ZmaW8vcGNpLmMNCj4+ICsrKyBiL2h3L3ZmaW8vcGNpLmMNCj4+IEBAIC0yNDgzLDgg
KzI0ODMsOSBAQCBpbnQgdmZpb19wY2lfZ2V0X3BjaV9ob3RfcmVzZXRfaW5mbyhWRklPUENJRGV2
aWNlDQo+KnZkZXYsDQo+PiAgICAgICByZXR1cm4gMDsNCj4+ICAgfQ0KPj4NCj4+IC1zdGF0aWMg
aW50IHZmaW9fcGNpX2hvdF9yZXNldChWRklPUENJRGV2aWNlICp2ZGV2LCBib29sIHNpbmdsZSkN
Cj4+ICtpbnQgdmZpb19sZWdhY3lfcGNpX2hvdF9yZXNldChWRklPRGV2aWNlICp2YmFzZWRldiwg
Ym9vbCBzaW5nbGUpDQo+DQo+Q291bGQgd2UgbW92ZSB0aGlzIHJvdXRpbmUgdG8gY29udGFpbmVy
IC5jID8NCg0KR29vZCBpZGVhLCB3aWxsIGRvLg0KDQpUaGFua3MNClpoZW56aG9uZw0K

