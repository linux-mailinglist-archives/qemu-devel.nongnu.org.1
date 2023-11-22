Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63C467F3C47
	for <lists+qemu-devel@lfdr.de>; Wed, 22 Nov 2023 04:23:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5doY-0007Fu-EC; Tue, 21 Nov 2023 22:22:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5doW-0007FW-KV
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 22:22:08 -0500
Received: from mgamail.intel.com ([192.55.52.151])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r5doU-00074F-0J
 for qemu-devel@nongnu.org; Tue, 21 Nov 2023 22:22:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700623326; x=1732159326;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=c9D1iVkiUOXYgqNwZWfQATipRiSMBMbZGNCB8iO6Gjg=;
 b=aU5DVmtkqwX1lQxhPOpOrMF7JGZou0rfa7/ZHCOA7Yy5oIOW+i4VYXzi
 G+3iwxpS8xr8qfZhIaE4r6XhvoLV4s7oiv3V3CfKeXt23ITNi/3/AXaMF
 HCkJpuA4Ao+YBZqDaCxPZXm5Ue4Ux62C/Nlau3gT/W3bWJopQu9UqcW40
 KiKXQt03LSsS62MzEcms2aEK37XR42zg0B3qe5fxVcAJluA6XpuhGYV/T
 VrP0xOIM2td4SfWb553067tvS9a9eNAU0IOiZj8R7wqvZW9W2dcFSoMp7
 NTIfWNo/l5B4WVfeTvcnd0tl68RopiYbKfgsGYO/x/Au0Zzm/RZmEaqtM w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372145984"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="372145984"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Nov 2023 19:22:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="940291624"
X-IronPort-AV: E=Sophos;i="6.04,217,1695711600"; d="scan'208";a="940291624"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 21 Nov 2023 19:22:01 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 21 Nov 2023 19:22:00 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 21 Nov 2023 19:22:00 -0800
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 21 Nov 2023 19:22:00 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QwkQMGZ1H9iGl4QCsDGqYPlpTjAuMOiZRu2KNT0hDDdd+ebJutukdIkl+Y5ubwQ/IdWk1diI+e9pKVGO8zBwN6cJm0OG/aag2gHaD4eSpgAJzO2GdhrZIfiv+9HUgVg9bhINInu5yMLcul515HMjD37msnzBZZ4H4dkNXeNK3mBTqcnvOsdTrCXU+JEcuO7YQqEwktDTrrMIvw8+B5ClvuXuFOqYBcqIz7Y4pPSJ2tWYNwA19nkd8uY3J3+60Ld9qyYmMpZeYc55QoQDKvrjkMeQwtw/yJB7HcZcB0LhUxObu0tvOsWP5jo+TzfGxviOfamc2M+fL+OALZrFRP5o2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9D1iVkiUOXYgqNwZWfQATipRiSMBMbZGNCB8iO6Gjg=;
 b=YSbKYFY6ZXsVFUsGIF2RS5sCBpJL20a+MEz5dbPURqr+t4aT5LMYxh6X2jMB5bFp3TquAODKHe3v3s8IVphhmEF2p1FqUMZPVkBA3MTvc9sO1WUZFc0gjSwGGoi2UUUa2W81do878l+ix+WaxqXZbF16lo0O3qoOyiQP9kofViUxZpZqOHgm4AmVdJgGdaJUfo7QqPfEaPEsjdZJNHNmh5uWAYNsk8fDUTuKXsn/d9N8RsKx6h49diriE7JadY3qziGn6fPR4cB4HmtqV/zXCtZ9PbeOEcTjV+qjkg44vwwsCvlahyXM/E1CqckWspK5rJoSKZXU9kcN5pn1ShJDWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB6554.namprd11.prod.outlook.com (2603:10b6:510:1a8::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Wed, 22 Nov
 2023 03:21:57 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 03:21:57 +0000
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
 <chao.p.peng@intel.com>
Subject: RE: [PATCH v7 00/27] vfio: Adopt iommufd
Thread-Topic: [PATCH v7 00/27] vfio: Adopt iommufd
Thread-Index: AQHaHFc0W4LZl8jDnE6rBmZPePSx2LCFBg6AgACTyyA=
Date: Wed, 22 Nov 2023 03:21:57 +0000
Message-ID: <SJ0PR11MB67449AA8E37A7CCCEF0B54CC92BAA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231121084426.1286987-1-zhenzhong.duan@intel.com>
 <182862f2-d339-4cba-aacf-bab06868272c@redhat.com>
In-Reply-To: <182862f2-d339-4cba-aacf-bab06868272c@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB6554:EE_
x-ms-office365-filtering-correlation-id: 7e8db374-1c01-43ff-088c-08dbeb0a2ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vka2r/CjzkUtFuCiz6VsWuuLZIeHVn8wo0MBY3RDslft84VhkMVB3MA6tPvY0UXJwhoQ4CZ+HHFNoyr3GDayq7jGmTdZbfm/f+nnScRgBSqWQkpI12YKyE10qUCDf2gNOG1eL7ABSO8F8WhMS2SminrfN/Qz4roadJLfbwdOWx2Kiq8U5y6eV2TzJzlmHsQH8MhpM2OQD6JMwSekeULeIBURENfDl2vDgFKsoRYSHlsXWYQ3sVec1gYdqyOVTofGFMab85cfCXSyS4Uf/RU0OyljUmHSqB/Rpj+CAzYtc3YEiCB5meeEMw9G4GwgdM7yLhI1AcQZXPyO62AY7AIp59Igf3cgD1irnXpuB8GZ4HRMDWW2YRSjxl0+lnH+2alj8GrJWTSGXqUsq9PBSB0JFhWAdBtsk+MWs5C48Al6PwYUXUyFTiZjFRIjiUn82T5RAhCFbeB/8hKWUJbRhGqDEeHssknq86AskAriwD16XIXpuTPIKMbJtwpPTTEI/nG1VhiAaShbv/0HugT5Y5bJamSkJtdxvgMXi5y88ApCbmVBqX9hcAGjprzA6wN9msCjET35/+rSLkbKwJf0wF3lWcmCOjNzj1l+ZqkSSpzc/+p8WqcgOZhGUrT7l1v4EFXPDULg16FVB949saQsfufCkg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(39860400002)(376002)(366004)(136003)(346002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(5660300002)(76116006)(2906002)(52536014)(8936002)(4326008)(66556008)(54906003)(66946007)(64756008)(66446008)(316002)(41300700001)(8676002)(66476007)(110136005)(55016003)(71200400001)(966005)(6506007)(478600001)(7696005)(26005)(9686003)(107886003)(83380400001)(38100700002)(66899024)(66574015)(33656002)(38070700009)(122000001)(82960400001)(86362001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVh0bnIzV3lmQXRkMmZYR1dWVzJFR1A4ZzBqdnFhWU1NVWQ5OEhaSGFTOWJD?=
 =?utf-8?B?dHJ2TExpUkFRdUl1bFlvL2g0ZklCZUREeHd5VkRIdHJsQjMrUW95ZlJUdzBB?=
 =?utf-8?B?K0p2d3lnQXp5REV6Q3RuZHcydGZQUEE2UHpHdk4zL2VpdTV4RVpOcFU2SENp?=
 =?utf-8?B?UjE4UmhlTmptVWYxNlY0V2RvUDFwa0JuMjgycWNIZzdWaDN2a09rODJaQnB3?=
 =?utf-8?B?VXZhem5FeXp4Z0Q3U2pUM1BEYldLY083ZVFjczl4NmgzTndtemZ0dFprUGlO?=
 =?utf-8?B?bFZKbFZKVWE4SmFnSmhWek9QMEE3ampmTzNRL0dwZENoQmRtYllVeWYvb0g5?=
 =?utf-8?B?MC83WmJFeGpjbkRqNEw5WFEyQnBVd0ZmMkJOWGVLeDVwYkJ2R2phUHEwRERo?=
 =?utf-8?B?M0pDZHBlMU5PRUIxS3dERm1paktBMFBWbzlnVE03YWZjWUg4eFFCNWY0VHV2?=
 =?utf-8?B?eWxkOUtZRGFMTXFobGJwcEZvd2VZY1QwR2hNWmtBbWdsWVVDQmdvVEt1R1FX?=
 =?utf-8?B?Y21PRGd4SnA3R2prRjUxN1dFdnVsWXBYaEZCcnNSRlJCVTBzaGRyYjY3VkNC?=
 =?utf-8?B?dzBiYnVzMHN5b3loSGh4VEd6enplZlQ1RTdpUEx6b3h6Z1JjeTFpUElZL0pZ?=
 =?utf-8?B?MndBRlhIMFA2MWZmVnVFZWtvNzFaei9ibWkyVVhpNkcwa3hWeFJZZDJiSG9O?=
 =?utf-8?B?dVF3Vm5oTDJTKzlhMDI2V0gvQXFGWksrU0pkTWdKakxKYkhJSHNkYzRabW1S?=
 =?utf-8?B?WnhMOFpJMkJMWXJ5czI2TnpUTFV3S1EyV1J1YlJ2RFdERlZnYjkvZVA2Wk1J?=
 =?utf-8?B?cWhIRmQzWDVrTktkd3hjU3dUUmdiWjQ5NUMxOU9GaFVWckxZSTQ5SThpM1Av?=
 =?utf-8?B?KzZRSGNjejVZQWFnTnRKbURpVjFJQVkzTUJWNW4rd2tCMStYWHFjZnNRd1gz?=
 =?utf-8?B?WlY2ZjdZOENzRU9FU2hXN0VscTBRUGs5VXozQjBGR2V4VXVtOWM5eEtyUURJ?=
 =?utf-8?B?Zzd5L1loOXFnK3k0aHV2QWNwdUJ2L1NpZmtmclpmelc1eXQ4cVl2Z1F2NXlX?=
 =?utf-8?B?blRESk9iWjlBdzUvSnhRNVBrQUxaOE9UVTJBSTNjZkFrNDFKUGtTZy9wK2xu?=
 =?utf-8?B?WWRyRmVFK1ZsQStkK3Q0bzJGVnZuNTkyd3BnN1g2a2VSRnN4Z05nUmZJTVd0?=
 =?utf-8?B?b2VweFdsRU0xd1ZHT3VNbW9tK0Uvei9ZRDR3ZGFaRW9TWGdLcEVsNk56NitX?=
 =?utf-8?B?MGo0cVFiNC9vMXV4SzRLb09URXVSQ2lrcXEzbEV4eXgzTEhDQzBTZk9JR2lX?=
 =?utf-8?B?TUMvSnQwbTcwa0FuSlZpQndwSUg4ZXRGdExtanRtTmRVT0ZpRytDeFFHbm9j?=
 =?utf-8?B?L2x3UG95UGU3SWVzQzVwaERYVkE0YWhXNEN2K28zRDVGMG1YQkM4Z0lIb1oy?=
 =?utf-8?B?TVlxSFhOY29Ob3RxTjd5eE1kSnBEejcyMVVsMlp5MmFIZlc4V2hXQ2lZRVNR?=
 =?utf-8?B?cTcyNm5kMGhZRjR2THpCcDQ3TmZGcHdTa2FydmkzMzhkTmloakdYcWZlRmVy?=
 =?utf-8?B?RmhpYmZzeWhtU0JyV1h6RkFocS96VVdRWEJpdndqVVZFc0xVTjZWaWpsWktm?=
 =?utf-8?B?MnZVV3VQb3lMNm8vaWdZbWM1SllnTE4wMVQ0M1NMVkJiT1NsejZzZGltZ0V0?=
 =?utf-8?B?b1Nod2lzZ25LVktzdHJ6UktrZ1ovODZ0SytDT3Mvekd3WWVsK01leDRIa0pi?=
 =?utf-8?B?Qng5WVljVFNpYVBJOVB1OHhoWjVQb1V1UU9FUnNLNTl2MXY3a0NndjcrT1lC?=
 =?utf-8?B?blMzVmpWd05IZE9WQmlNWkFHaGxvNDJIeVhwRHRUTGFjalYrMzdLenlaMS9V?=
 =?utf-8?B?WVl0SUo2T0xqZGx2cm5iaGZVVjJXYi9aVnZJM2pNdTQ0Vk9qT1l4a3ViZ25w?=
 =?utf-8?B?NUlWRU5sZWM3RmVaYzdkTE1ON3BVeUppb2UzR1E4VWFOYmQwcDkyUkVSNTJu?=
 =?utf-8?B?clRac3NJRDBjS0U4bzB4NkF0U2pyOFFpa2dsdjNTeUxreFliMEtnZjNPMG56?=
 =?utf-8?B?akJ0cys5QVhldUtIM1dWRFdsL01oM3N1N3FIcjg3NHlTTDJ2RDh6WENPcnNO?=
 =?utf-8?Q?9mjQwuQ4LKoI2WHBglVz53uEK?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e8db374-1c01-43ff-088c-08dbeb0a2ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2023 03:21:57.1673 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s0J8aDRK6t2kDTwFV2KjP5+TrJV+6sBFPszuEPP32Yc7VQjWQI1TTN/iS3kz6RUWKnSRFQLvobZq8BiZnsJmU5m4HQXxh2cja8jghNPeTnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6554
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.151;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBXZWRuZXNkYXksIE5vdmVtYmVyIDIyLCAyMDIzIDE6
MjMgQU0NCj5TdWJqZWN0OiBSZTogW1BBVENIIHY3IDAwLzI3XSB2ZmlvOiBBZG9wdCBpb21tdWZk
DQo+DQo+SGVsbG8gWmhlbnpob25nDQo+DQo+T24gMTEvMjEvMjMgMDk6NDMsIFpoZW56aG9uZyBE
dWFuIHdyb3RlOg0KPj4gSGksDQo+Pg0KPj4gVGhhbmtzIGFsbCBmb3IgZ2l2aW5nIGd1aWRlcyBh
bmQgY29tbWVudHMgb24gcHJldmlvdXMgc2VyaWVzLCB0aGlzIGlzDQo+PiB0aGUgcmVtYWluaW5n
IHBhcnQgb2YgdGhlIGlvbW11ZmQgc3VwcG9ydC4NCj4+DQo+PiBCZXNpZGVzIHN1Z2dlc3RlZCBj
aGFuZ2VzIGluIHY2LCBJJ2QgbGlrZSB0byBoaWdobGlnaHQgdHdvIGNoYW5nZXMNCj4+IGZvciBm
aW5hbCByZXZpZXc6DQo+PiAxLiBJbnN0YW50aWF0ZSBjYW5fYmVfZGVsZXRlZCBjYWxsYmFjayB0
byBmaXggcmFjZSB3aGVyZSBpb21tdWZkIG9iamVjdA0KPj4gICAgIGNhbiBiZSBkZWxldGVkIGJl
Zm9yZSB2ZmlvIGRldmljZQ0KPj4gMi4gQWZ0ZXIgY2FyZWZ1bCByZS10aGlua2luZywgSSdkIGxp
a2UgdG8gZm9sbG93IE5pY29saW4ncyBzdWdnZXN0aW9uIGluIHY1LA0KPj4gICAgIHJlbW92ZSBp
c19pb2FzIGNoZWNrIHdoaWNoIGluZGVlZCBsb29rcyBoZWF2eSBqdXN0IGZvciB0cmFjZXBvaW50
Lg0KPj4gICAgIEluIGZhY3Qgd2UgY2FuIGdldCBjb3JyZXNwb25kaW5nIGluZm8gYnkgbG9va2lu
ZyBvdmVyIHRyYWNlIGNvbnRleHQuDQo+Pg0KPj4gUEFUQ0ggMTogSW50cm9kdWNlIGlvbW11ZmQg
b2JqZWN0DQo+PiBQQVRDSCAyLTk6IGFkZCBJT01NVUZEIGNvbnRhaW5lciBhbmQgY2RldiBzdXBw
b3J0DQo+PiBQQVRDSCAxMC0xNzogZmQgcGFzc2luZyBmb3IgY2RldiBhbmQgbGlua2luZyB0byBJ
T01NVUZEDQo+PiBQQVRDSCAxODogbWFrZSBWRklPQ29udGFpbmVyQmFzZSBwYXJhbWV0ZXIgY29u
c3QNCj4+IFBBVENIIDE5LTIxOiBDb21waWxlIG91dCBmb3IgSU9NTVVGRCBmb3IgYXJtLCBzMzkw
eCBhbmQgeDg2DQo+PiBQQVRDSCAyMi0yNjogdmZpbyBkZXZpY2UgaW5pdCBjb2RlIGNsZWFudXAN
Cj4+IFBBVENIIDI3OiBhZGQgaW9tbXVmZCBkb2MNCj4+DQo+Pg0KPj4gV2UgaGF2ZSBkb25lIHdp
ZGUgdGVzdCB3aXRoIGRpZmZlcmVudCBjb21iaW5hdGlvbnMsIGUuZzoNCj4+IC0gUENJIGRldmlj
ZSB3ZXJlIHRlc3RlZA0KPj4gLSBGRCBwYXNzaW5nIGFuZCBob3QgcmVzZXQgd2l0aCBzb21lIHRy
aWNrLg0KPj4gLSBkZXZpY2UgaG90cGx1ZyB0ZXN0IHdpdGggbGVnYWN5IGFuZCBpb21tdWZkIGJh
Y2tlbmRzDQo+PiAtIHdpdGggb3Igd2l0aG91dCB2SU9NTVUgZm9yIGxlZ2FjeSBhbmQgaW9tbXVm
ZCBiYWNrZW5kcw0KPj4gLSBkaXZpY2VzIGxpbmtlZCB0byBkaWZmZXJlbnQgaW9tbXVmZHMNCj4+
IC0gVkZJTyBtaWdyYXRpb24gd2l0aCBhIEU4MDAgbmV0IGNhcmQobm8gZGlydHkgc3luYyBzdXBw
b3J0KSBwYXNzdGhyb3VnaA0KPj4gLSBwbGF0Zm9ybSwgY2N3IGFuZCBhcCB3ZXJlIG9ubHkgY29t
cGlsZS10ZXN0ZWQgZHVlIHRvIGVudmlyb25tZW50IGxpbWl0DQo+PiAtIHRlc3QgbWRldiBwYXNz
IHRocm91Z2ggd2l0aCBtdHR5IGFuZCBtaXggd2l0aCByZWFsIGRldmljZSBhbmQgZGlmZmVyZW50
IEJFDQo+PiAtIHRlc3QgaW9tbXVmZCBvYmplY3QgaG90cGx1Zy91bnBsdWcgYW5kIG1peCB3aXRo
IHZmaW8gZGV2aWNlIHBsdWcvdW5wbHVnDQo+Pg0KPj4gR2l2ZW4gc29tZSBpb21tdWZkIGtlcm5l
bCBsaW1pdGF0aW9ucywgdGhlIGlvbW11ZmQgYmFja2VuZCBpcw0KPj4gbm90IHlldCBmdWxseSBv
biBwYXIgd2l0aCB0aGUgbGVnYWN5IGJhY2tlbmQgdy5yLnQuIGZlYXR1cmVzIGxpa2U6DQo+PiAt
IHAycCBtYXBwaW5ncyAoeW91IHdpbGwgc2VlIHJlbGF0ZWQgZXJyb3IgdHJhY2VzKQ0KPj4gLSBk
aXJ0eSBwYWdlIHN5bmMNCj4+IC0gYW5kIGV0Yy4NCj4+DQo+Pg0KPj4gcWVtdSBjb2RlOg0KPmh0
dHBzOi8vZ2l0aHViLmNvbS95aWxpdTE3NjUvcWVtdS9jb21taXRzL3poZW56aG9uZy9pb21tdWZk
X2NkZXZfdjcNCj4+IEJhc2VkIG9uIHZmaW8tbmV4dCwgY29tbWl0IGlkOiBjNDg3ZmI4YTUwDQo+
DQo+VGhlIHNlcmllcyBpcyBwdXNoZWQgb24gdG9wIG9mIHZmaW8tbmV4dCBpbiB0aGUgdmZpby04
LjIgdHJlZSA6DQo+DQo+ICAgaHR0cHM6Ly9naXRodWIuY29tL2xlZ29hdGVyL3FlbXUvY29tbWl0
cy92ZmlvLTguMg0KPg0KPndpdGggYSBsaXR0bGUgZXh0cmEgdG8gZGVhbCB3aXRoIGEgUFBDIGJ1
aWxkIGZhaWx1cmUuDQoNClRoYW5rcyBDw6lkcmljLiBUaGF0J3Mgc3RyYW5nZSBJIGRpZG4ndCBz
ZWUgdGhpcyBmYWlsdXJlIG9uIG15IGVudg0Kd2hpY2ggaGFzIENPTkZJR19WRklPX1BDSSBlbmFi
bGVkIGJ5IGRlZmF1bHQgZm9yIFBQQy4NCg0KQlJzLg0KWmhlbnpob25nDQo=

