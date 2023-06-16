Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAF8732C83
	for <lists+qemu-devel@lfdr.de>; Fri, 16 Jun 2023 11:54:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qA69O-0005Mv-KT; Fri, 16 Jun 2023 05:53:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qA69M-0005Mh-Ei
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:53:48 -0400
Received: from mga11.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qA69K-0007FX-36
 for qemu-devel@nongnu.org; Fri, 16 Jun 2023 05:53:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1686909226; x=1718445226;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=LFVYfrPd4s55atbdEB0bWySuSR/Tep2F1G/Jediedt8=;
 b=RQcJpTfClcRlpLbIND9zVMlbAPb55xnt8a9s+pqC12Ysq7HyBoh1G5Ep
 rTcPpnvmcJBXHvY9GesDeonV+Ki8tm4o2IPNTkvLZcf0jpwm4CFqR5iNQ
 RjqqFWWSZlDs0gfBFxVjUx9Aaf0wwWiikk/MCNr+rvn/kFPm0keehN2Br
 Xl1l1WOjz6kxOjd5OZQN3Pc3qZjyu8Xq7qU+UCgqXXJhj1T8TSbGgyahg
 psZhdpN7xHGoxqRq8lzfnuECmia6x5AuB6aqGTpgqA7FEwsKpIfV0xaQ8
 q6mCsiPOk+VSc+qyvVkZzfQcXpej5Ly1qRC8Wk8SosH4sPkK6rjE5sZUK A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="356663105"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; d="scan'208";a="356663105"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jun 2023 02:53:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10742"; a="887047253"
X-IronPort-AV: E=Sophos;i="6.00,247,1681196400"; d="scan'208";a="887047253"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
 by orsmga005.jf.intel.com with ESMTP; 16 Jun 2023 02:53:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 16 Jun 2023 02:53:42 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 16 Jun 2023 02:53:42 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 16 Jun 2023 02:53:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gtyOZYyNJSmM1qAUb4j2EwnJq4a5bHmeAnFwT1ct2rDZm/ffT2zy476G7Zj2KiLBRsMIEal4e+jkhUXeWCZd8/cHB8/pZ9UeYfLX28Q+Hc6sO8lDmJpMqTzdcpvpSsLZpubLXN96UvQOy9NMaWF2RYfXThgg654kCeMX2RME84/N1Wr+9ZSrLKEq3uutEqxrqpYTVs8TZ/csuGBoaDl94uYpbHranq/zZ0+9ZO5LcMSCG6nvnWarifVr9OT3wGcOUD/zjUHs+TVsEXRjmtKlyZvg8zEd/xrDhtPiqroqhzLeAFW66ApQxE3shM6JecK7tOIsO0FfkaksetfwEbBxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LFVYfrPd4s55atbdEB0bWySuSR/Tep2F1G/Jediedt8=;
 b=PBAA8tBE3cN2XFBdFmjD24SVEPhb406njFAlhLUB8jeN7GjdMStTdOmCcYJvmVkuC1JLvICVOYiMaHlVciS0nLlYujn20aWcY2v1D1e1C012a170yvlVG32+3zDB/MSz6owy83cnh3fr8QpvvrOPDIPUPZ7nqdpjafg8U4GbHYYWtJDty1Y6CAz9Ggxd1uE1G614zFh42IKxBqC8YO2stCGN5NSa5/6z4jytRKeHrNK/0qr3cS0qjH5kBLGflkgnzXA2NxsrEd572ahh53K6bstF0gYkwd3KjQEnMsWNhk9HmMXKyCrm1cBrTra7wRrVcZGncRWc3+h8/WZPtaPFlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by CH0PR11MB5460.namprd11.prod.outlook.com (2603:10b6:610:d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.29; Fri, 16 Jun
 2023 09:53:39 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::da0a:8aab:d75b:55f1%7]) with mapi id 15.20.6500.025; Fri, 16 Jun 2023
 09:53:39 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "Martins, Joao" <joao.m.martins@oracle.com>
CC: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, "Peng, Chao P" <chao.p.peng@intel.com>
Subject: RE: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Thread-Topic: [PATCH] vfio/migration: Fix return value of
 vfio_migration_realize()
Thread-Index: AQHZn2PPlNEvmdczhUGNGr4N1q3IM6+LjxGAgAAEy5CAABPwAIABDtMggABuCYCAAAPE8A==
Date: Fri, 16 Jun 2023 09:53:38 +0000
Message-ID: <SJ0PR11MB6744FA7630BA42F4DBFB30FA9258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20230615081851.326816-1-zhenzhong.duan@intel.com>
 <67af377f-a8b7-c879-516e-9544d6a4fab2@oracle.com>
 <SJ0PR11MB6744E8D7540A3B9E540A9F69925BA@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <186c9e07-c1e6-74ae-0a4f-7d6bc0c8ceb6@oracle.com>
 <SJ0PR11MB674488BE146A88E35D763C639258A@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <2f3ee2ab-e37b-c429-e604-b62440d37278@oracle.com>
In-Reply-To: <2f3ee2ab-e37b-c429-e604-b62440d37278@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|CH0PR11MB5460:EE_
x-ms-office365-filtering-correlation-id: 03484bfe-3275-44a4-14a9-08db6e4f8f47
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9V204NtVRVPDgRbbeTjOUV30jiBQFRShM+bcP2zRT2inTZiljrsX89HaNULHUXkRcmPshNNnM/JfUGPHJc4AleEqkBHQcxSqTdil6EPKmymbVAVEMdxX4LcBujLxa5f2mI455Wo5dprCl0pPCRwQOBL2Kptx9g9WcOwhKaMQDr+YBi8rBeOz6IAW5+3rhZoa8J1Kd9juTWvOK19VFd8MXHdtyKMdlpqkPDEv126g4HHl1tpeYzCSwgVjaVS5R0L+Tp598x14odj0kqNhys3Qzt0Jb3yerbELWudd4AIX2SfzV57+SEC0x1xLfRCjaSGPfpkkPLD8VN+qGKy7OYTCrpxyVligca6eEoY6wR5Bx9dJKjiCcAGAO7lochEJTMN/p3EJLY0IZlnQb1m09BTOELzQBTnMvQlAb/vbEEM+kkrNUHqwLJLX214C+4KmMVQGx59z8nghtcfybi8zpUn2ggFV8bs5nZXnTLvX8SxUWZiRHAyHIomsB+3S0KbOgtpQy6ep39UAcis9aJ53UMGUZ+GKA15ecSjPRa8wmoD958mGQY8hkbRyhnFPZJIl7aTGSf0+uifBUZE2I3xjeWD1SijER6EeYCEVTJFIMjvPqjr48dXFjU6Pg3Qaka2oBSv9
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199021)(55016003)(478600001)(54906003)(122000001)(7696005)(5660300002)(8936002)(52536014)(82960400001)(8676002)(41300700001)(2906002)(38070700005)(86362001)(33656002)(38100700002)(66446008)(66476007)(66556008)(64756008)(316002)(6916009)(66946007)(4326008)(76116006)(71200400001)(107886003)(26005)(9686003)(53546011)(6506007)(186003)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGtMWWhaN0xnZWV0b2JRaEkrOUNNTjk2bzBqeHZoMGJseXl0QzBhUHh3dzdi?=
 =?utf-8?B?RFUzUVNOditRVkFha09OQjh6dkplUWZLOFNSS1NIZjMwc09QN0loK25wbWJI?=
 =?utf-8?B?WEE4cEdad21Od1VNUytUNWhGUVdjanRTYWpFeG83bWlsMDVQZDR5OVVoWFhk?=
 =?utf-8?B?S3VRRDhHVWlVUmtFS3o5a0tkVGY1bURwTkNrdXYwelhkd01GNVdUc3lSdG5Z?=
 =?utf-8?B?M3ovWlVPOStSdFRXem8vQStrbHBESnZOem9NeXBoaEs0T2RaNmMyMHhqZ0tp?=
 =?utf-8?B?WkJrNWVoU1hzSnlJOHdvTTdQRDFHdWtvWTQvaFBwdERic1RLNU8vZ25SWmM2?=
 =?utf-8?B?dDRaUXYzSWs1eFJmN1lKZ2tFaDdvek43eWEyT28yZDJhVnFjclpRVnlzS2Mv?=
 =?utf-8?B?d1RGS0x2aExhVFE5alcveUlQRlQwZFVFTkpsemRmSlFFN00wRVFzK1N2b3Ny?=
 =?utf-8?B?aStlRktQQXhwRjQvMW5qakMwczFvRVVOamQzMTJkRWZ3d0x3MEpISHFkZnFi?=
 =?utf-8?B?eHZOYzBSakVQYjNiYzBiQWJ4d2hhY3RPaXR0a3h0TzRqMm1EalFMN1VBTlZK?=
 =?utf-8?B?cTM5c1BDVCt0TWxmSXNqL2gxTm5uNHZnaEgxY05FTit2QXEyaWViMm9QUElP?=
 =?utf-8?B?UjZKT1h0TXBUNCtXUXhRMW5YQ2xIODhCekY2dGpxQ2dMblZiUmpzZjcrZzhM?=
 =?utf-8?B?VHFPNVZJcG1Fdi94OFlXZTBTK1VKNGdmMGhvV3RJc0drdi9VREpmTWRzNGJX?=
 =?utf-8?B?V0ZuMHRmYW9ZTmZzWXZLM0lieGVsYUdlcXNXNC9aQUpGODkyOUdmaG9PRUg2?=
 =?utf-8?B?N2ZCSFVURklUYXdQT2VtSHFsMGRmdjF3K0FnWXNVaWJ6N0NqdWk3S3hvNmVG?=
 =?utf-8?B?bFhuZ2xoZzNNN3A2MnVzNk1acmMzVEd1ai9CNVErL0Q0Vk9ENnRzTkwxanhw?=
 =?utf-8?B?dGRUWWduM0hpOFNsZmRuNjVTRjd3TE1TMVNERnJKZnJxcTM3cU1MZW5yNnB0?=
 =?utf-8?B?Z2l4bmJicUEvdGtKQ2tYekpGR3kxd04xd0pFcGFUL0lnc2hiUFNGcjFHUlZt?=
 =?utf-8?B?Z053c29nbkwzL0VWR1BPeGNWZWhCWjNlRVJyb1kySmxaVittdU9rVUhTMkwy?=
 =?utf-8?B?ZXZkNEdOdy80M3M5cEZiS3F6b2lVVm1YSU56NXhLS3o1UEFVWUZ0R1ZoOFFD?=
 =?utf-8?B?d2hDOVhZdCsvYlNXUTlFK3dWbVJZOFk0a1oya1dGZU9PNGU4YTgvVmx5Ulh1?=
 =?utf-8?B?ZzRydFd3ZzlzSU84OG1kQWdjTytnbkM2YU5waEhGNGJOUEVkR1Z6N3BVQ01B?=
 =?utf-8?B?T1E4cVNRVGVnc1ZHK2JNUXpzSkxYOWhrSTVTVmxFS3JUczBPVUNVOHY5RTNS?=
 =?utf-8?B?RFEzd2xFVGY3d2RtODFId1RTL3JuQlFHeXoyZDc1TVN5WXljRW9lOGZWTFBk?=
 =?utf-8?B?TitQNjVIaGpmOHZBTFlDM2RJY3o1bHB6aW9kNzYwbjZCTUtxMUpxaFJicGdu?=
 =?utf-8?B?OXFaaUQwTHA1dFFpbEpiQzI4dzVOT3R1WVQxeU1xRnJHM3AxVXlCUmVCZ2RJ?=
 =?utf-8?B?ekdUMHlmYVgwdHVIMUV4djZrdU14ZVZzZlNLa1c1STZBQ3p2ZFJRSk9TT1Ju?=
 =?utf-8?B?bmpNU2FQeGpLVUxETDBITlV3N1FISXNCcXhCbUNnTzJUWTZkdkVaQzB5aXB2?=
 =?utf-8?B?eDBOOHRRamU5QW1TUzM3NWVMOG1sbzhYd3orYldBazZNZlNjZkpqTHBHNHZE?=
 =?utf-8?B?NVhXdk5PVVhkT0pDclY3TWl2TS9iSkh4RFBmVE5lb0drQVRNYjlKV3kwUy9K?=
 =?utf-8?B?V1hoQldVTngrUDRHM1ZTd1dYVkRLRmlUVlUrRE92MnNvVVdNQk1YZFJ1VnBO?=
 =?utf-8?B?a0FuRW91S2crTE1zTlhFbkF4MWpUdGtqdXlad3VPTXVOTFYybW1zcUhvWXNE?=
 =?utf-8?B?RjhWL3BQQXF0RlB2SWptTk1TRFFlMWM0d0VsZTY5MjFidW5XNVFONHpHWEwr?=
 =?utf-8?B?WG5sL2Nlb3FQUkhHckc2dGIwRDJ0TVNERklVYTlvZVBaNDVmRXM4cUdCbWVr?=
 =?utf-8?B?UVBBOFpaQVoxcXhSRFRTbXdJSEJvVnAxb0FleEJvRFYzbktCUzRGZDdkb0xj?=
 =?utf-8?Q?+K+hHKxTJVzHUHTSyAGBetM4S?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03484bfe-3275-44a4-14a9-08db6e4f8f47
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jun 2023 09:53:38.8250 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8uplbu9Rxx/1G02fUr+oRBFKSxXe63ApR2waO4jNQEnPmV+qj8QE8UdeR5IZic8vw7x5Xxqg3e0WjbS6N0wVXRWvFCbzpvpz5wtNH5hT18o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5460
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
 envelope-from=zhenzhong.duan@intel.com; helo=mga11.intel.com
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEpvYW8gTWFydGlucyA8am9h
by5tLm1hcnRpbnNAb3JhY2xlLmNvbT4NCj5TZW50OiBGcmlkYXksIEp1bmUgMTYsIDIwMjMgNTow
NiBQTQ0KPlRvOiBEdWFuLCBaaGVuemhvbmcgPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj5D
YzogYWxleC53aWxsaWFtc29uQHJlZGhhdC5jb207IGNsZ0ByZWRoYXQuY29tOyBxZW11LWRldmVs
QG5vbmdudS5vcmc7DQo+UGVuZywgQ2hhbyBQIDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+U3Vi
amVjdDogUmU6IFtQQVRDSF0gdmZpby9taWdyYXRpb246IEZpeCByZXR1cm4gdmFsdWUgb2YgdmZp
b19taWdyYXRpb25fcmVhbGl6ZSgpDQo+DQo+T24gMTYvMDYvMjAyMyAwMzo0MiwgRHVhbiwgWmhl
bnpob25nIHdyb3RlOg0KPj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4gRnJvbTog
Sm9hbyBNYXJ0aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4+IFNlbnQ6IFRodXJz
ZGF5LCBKdW5lIDE1LCAyMDIzIDY6MjMgUE0NCj4+PiBUbzogRHVhbiwgWmhlbnpob25nIDx6aGVu
emhvbmcuZHVhbkBpbnRlbC5jb20+DQo+Pj4gQ2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29t
OyBjbGdAcmVkaGF0LmNvbTsNCj4+PiBxZW11LWRldmVsQG5vbmdudS5vcmc7IFBlbmcsIENoYW8g
UCA8Y2hhby5wLnBlbmdAaW50ZWwuY29tPg0KPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIHZmaW8v
bWlncmF0aW9uOiBGaXggcmV0dXJuIHZhbHVlIG9mDQo+Pj4gdmZpb19taWdyYXRpb25fcmVhbGl6
ZSgpDQo+Pj4NCj4+PiBPbiAxNS8wNi8yMDIzIDEwOjE5LCBEdWFuLCBaaGVuemhvbmcgd3JvdGU6
DQo+Pj4+PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPj4+Pj4gRnJvbTogSm9hbyBNYXJ0
aW5zIDxqb2FvLm0ubWFydGluc0BvcmFjbGUuY29tPg0KPj4+Pj4gU2VudDogVGh1cnNkYXksIEp1
bmUgMTUsIDIwMjMgNDo1NCBQTQ0KPj4+Pj4gVG86IER1YW4sIFpoZW56aG9uZyA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPj4+Pj4gQ2M6IGFsZXgud2lsbGlhbXNvbkByZWRoYXQuY29tOyBj
bGdAcmVkaGF0LmNvbTsNCj4+Pj4+IHFlbXUtZGV2ZWxAbm9uZ251Lm9yZzsgUGVuZywgQ2hhbyBQ
IDxjaGFvLnAucGVuZ0BpbnRlbC5jb20+DQo+Pj4+PiBTdWJqZWN0OiBSZTogW1BBVENIXSB2Zmlv
L21pZ3JhdGlvbjogRml4IHJldHVybiB2YWx1ZSBvZg0KPj4+Pj4gdmZpb19taWdyYXRpb25fcmVh
bGl6ZSgpDQo+Pj4+Pg0KPj4+Pj4NCj4+Pj4+DQo+Pj4+PiBPbiAxNS8wNi8yMDIzIDA5OjE4LCBa
aGVuemhvbmcgRHVhbiB3cm90ZToNCj4+Pj4+PiBXZSBzaG91bGQgcHJpbnQgIk1pZ3JhdGlvbiBk
aXNhYmxlZCIgd2hlbiBtaWdyYXRpb24gaXMgYmxvY2tlZCBpbg0KPj4+Pj4+IHZmaW9fbWlncmF0
aW9uX3JlYWxpemUoKS4NCj4+Pj4+Pg0KPj4+Pj4+IEZpeCBpdCBieSByZXZlcnRpbmcgcmV0dXJu
IHZhbHVlIG9mIG1pZ3JhdGVfYWRkX2Jsb2NrZXIoKSwNCj4+Pj4+PiBtZWFud2hpbGUgZXJyb3Ig
b3V0IGRpcmVjdGx5IG9uY2UgbWlncmF0ZV9hZGRfYmxvY2tlcigpIGZhaWxlZC4NCj4+Pj4+Pg0K
Pj4+Pj4NCj4+Pj4+IEl0IHdhc24ndCBpbW1lZGlhdGVseSBvYnZpb3VzIGZyb20gY29tbWl0IG1l
c3NhZ2UgdGhhdCB0aGlzIGlzDQo+Pj4+PiBtYWlubHkgYWJvdXQganVzdCBwcmludGluZyBhbiBl
cnJvciBtZXNzYWdlIHdoZW4gYmxvY2tlcnMgZ2V0IGFkZGVkDQo+Pj4+PiBhbmQgdGhhdCB3ZWxs
DQo+Pj4+PiBtaWdyYXRlX2FkZF9ibG9ja2VyKCkgcmV0dXJucyAwIG9uIHN1Y2Nlc3MgYW5kIGNh
bGxlciBvZg0KPj4+Pj4gdmZpb19taWdyYXRpb25fcmVhbGl6ZSBleHBlY3RzIHRoZSBvcHBvc2l0
ZSB3aGVuIGJsb2NrZXJzIGFyZSBhZGRlZC4NCj4+Pj4+DQo+Pj4+PiBQZXJoYXBzIGJldHRlciB3
b3JkaW5nIHdvdWxkIGJlOg0KPj4+Pj4NCj4+Pj4+IG1pZ3JhdGVfYWRkX2Jsb2NrZXIoKSByZXR1
cm5zIDAgd2hlbiBzdWNjZXNzZnVsbHkgYWRkaW5nIHRoZQ0KPj4+Pj4gbWlncmF0aW9uIGJsb2Nr
ZXIuIEhvd2V2ZXIsIHRoZSBjYWxsZXIgb2YgdmZpb19taWdyYXRpb25fcmVhbGl6ZSgpDQo+Pj4+
PiBjb25zaWRlcnMgdGhhdCBtaWdyYXRpb24gd2FzIGJsb2NrZWQgd2hlbiB0aGUgbGF0dGVyIHJl
dHVybmVkIGFuDQo+Pj4+PiBlcnJvci4gRml4IGl0IGJ5IG5lZ2F0aW5nIHRoZSByZXR1cm4gdmFs
dWUgb2J0YWluZWQgYnkNCj4+Pj4+IG1pZ3JhdGVfYWRkX2Jsb2NrZXIoKS4gV2hhdCBtYXR0ZXJz
IGZvciBtaWdyYXRpb24gaXMgdGhhdCB0aGUNCj4+Pj4+IGJsb2NrZXIgaXMgYWRkZWQgaW4gY29y
ZSBtaWdyYXRpb24sIHNvIHRoaXMgY2xlYW5zIHVwIHVzYWJpbGl0eQ0KPj4+Pj4gc3VjaCB0aGF0
IHVzZXIgc2VlcyAiTWlncmF0ZSBkaXNhYmxlZCIgd2hlbiBhbnkgb2YgdGhlIHZmaW8NCj4+Pj4+
IG1pZ3JhdGlvbiBibG9ja2VycyBhcmUNCj4+PiBhY3RpdmUuDQo+Pj4+DQo+Pj4+IEdyZWF0LCBJ
J2xsIHVzZSB5b3VyIHdvcmRzLg0KPj4+Pg0KPj4+Pj4NCj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBa
aGVuemhvbmcgRHVhbiA8emhlbnpob25nLmR1YW5AaW50ZWwuY29tPg0KPj4+Pj4+IC0tLQ0KPj4+
Pj4+ICBody92ZmlvL2NvbW1vbi5jICAgIHwgNCArKy0tDQo+Pj4+Pj4gIGh3L3ZmaW8vbWlncmF0
aW9uLmMgfCA2ICsrKy0tLQ0KPj4+Pj4+ICAyIGZpbGVzIGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygr
KSwgNSBkZWxldGlvbnMoLSkNCj4+Pj4+Pg0KPj4+Pj4+IGRpZmYgLS1naXQgYS9ody92ZmlvL2Nv
bW1vbi5jIGIvaHcvdmZpby9jb21tb24uYyBpbmRleA0KPj4+Pj4+IGZhOGZkOTQ5YjFjZi4uODUw
NTM4NTc5OGYzIDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2h3L3ZmaW8vY29tbW9uLmMNCj4+Pj4+PiAr
KysgYi9ody92ZmlvL2NvbW1vbi5jDQo+Pj4+Pj4gQEAgLTM5OSw3ICszOTksNyBAQCBpbnQNCj4+
Pj4+PiB2ZmlvX2Jsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKEVycm9yDQo+Pj4+PiAq
KmVycnApDQo+Pj4+Pj4gICAgICAgICAgbXVsdGlwbGVfZGV2aWNlc19taWdyYXRpb25fYmxvY2tl
ciA9IE5VTEw7DQo+Pj4+Pj4gICAgICB9DQo+Pj4+Pj4NCj4+Pj4+PiAtICAgIHJldHVybiByZXQ7
DQo+Pj4+Pj4gKyAgICByZXR1cm4gIXJldDsNCj4+Pj4+PiAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gIHZv
aWQgdmZpb191bmJsb2NrX211bHRpcGxlX2RldmljZXNfbWlncmF0aW9uKHZvaWQpDQo+Pj4+Pj4g
QEAgLTQ0NCw3ICs0NDQsNyBAQCBpbnQgdmZpb19ibG9ja19naW9tbXVfbWlncmF0aW9uKEVycm9y
ICoqZXJycCkNCj4+Pj4+PiAgICAgICAgICBnaW9tbXVfbWlncmF0aW9uX2Jsb2NrZXIgPSBOVUxM
Ow0KPj4+Pj4+ICAgICAgfQ0KPj4+Pj4+DQo+Pj4+Pj4gLSAgICByZXR1cm4gcmV0Ow0KPj4+Pj4+
ICsgICAgcmV0dXJuICFyZXQ7DQo+Pj4+Pj4gIH0NCj4+Pj4+Pg0KPj4+Pj4+ICB2b2lkIHZmaW9f
bWlncmF0aW9uX2ZpbmFsaXplKHZvaWQpIGRpZmYgLS1naXQNCj4+Pj4+PiBhL2h3L3ZmaW8vbWln
cmF0aW9uLmMgYi9ody92ZmlvL21pZ3JhdGlvbi5jIGluZGV4DQo+Pj4+Pj4gNmI1OGRkZGI4ODU5
Li4wMTQ2NTIxZDEyOWEgMTAwNjQ0DQo+Pj4+Pj4gLS0tIGEvaHcvdmZpby9taWdyYXRpb24uYw0K
Pj4+Pj4+ICsrKyBiL2h3L3ZmaW8vbWlncmF0aW9uLmMNCj4+Pj4+PiBAQCAtNjQ2LDEyICs2NDYs
MTIgQEAgaW50IHZmaW9fbWlncmF0aW9uX3JlYWxpemUoVkZJT0RldmljZQ0KPj4+Pj4+ICp2YmFz
ZWRldiwNCj4+Pj4+IEVycm9yICoqZXJycCkNCj4+Pj4+PiAgICAgIH0NCj4+Pj4+Pg0KPj4+Pj4+
ICAgICAgcmV0ID0gdmZpb19ibG9ja19tdWx0aXBsZV9kZXZpY2VzX21pZ3JhdGlvbihlcnJwKTsN
Cj4+Pj4+PiAtICAgIGlmIChyZXQpIHsNCj4+Pj4+PiArICAgIGlmIChyZXQgfHwgKGVycnAgJiYg
KmVycnApKSB7DQo+Pj4+Pg0KPj4+Pj4gV2h5IGRvIHlvdSBuZWVkIHRoaXMgZXh0cmEgY2xhdXNl
Pw0KPj4+Pg0KPj4+PiBOb3cgdGhhdCBlcnJvciBoYXBwZW5zLCBubyBuZWVkIHRvIGFkZCBvdGhl
ciBibG9ja2VycyB3aGljaCB3aWxsDQo+Pj4+IGZhaWwgZm9yIHNhbWUgcmVhc29uLg0KPj4+Pg0K
Pj4+DQo+Pj4gQnV0IHlvdSBkb24ndCBuZWVkIHRoZSAoZXJycCAmJiAqZXJycCkgZm9yIHRoYXQg
YXMgdGhhdCdzIHRoZSB3aG9sZQ0KPj4+IHBvaW50IG9mIG5lZ2F0aW5nIHRoZSByZXN1bHQuDQo+
Pj4NCj4+PiBBbmQgaWYgdGhlcmUncyBhbiBlcnJvciBzZXQgaXQgbWVhbnMgbWlncmF0ZV9hZGRf
YmxvY2tlciBmYWlsZWQgdG8NCj4+PiBhZGQgdGhlIGJsb2NrZXIgKGUuZy4gc25hcHNob3R0aW5n
IElJVUMpLCBhbmQgeW91IHdvdWxkIGJlIGZhaWxpbmcgaGVyZQ0KPnVubmVjZXNzYXJpbHk/DQo+
Pg0KPj4gSWYgdGhlcmUgaXMgYW4gZXJyb3IgcWRldl9kZXZpY2VfYWRkKCkgd2lsbCBmYWlsLCBj
b250aW51ZSBleGVjdXRpb24gaXMNCj5tZWFuaW5nbGVzcyBoZXJlPw0KPj4gVGhlcmUgaXMgRVJS
UF9HVUFSRCBpbiB0aGlzIHBhdGgsIHNvIGl0IGxvb2tzICgqZXJycCkgaXMgZW5vdWdoLg0KPj4N
Cj4+IElmIEkgcmVtb3ZlZCAoZXJycCAmJiAqZXJycCkgdG8gY29udGludWUsIG5lZWQgYmVsb3cg
Y2hhbmdlIHRvIGJ5cGFzcw0KPj4gdHJhY2VfdmZpb19taWdyYXRpb25fcHJvYmUgRG8geW91IHBy
ZWZlciB0aGlzIHdheT8NCj4+DQo+PiAgICAgaWYgKCEqZXJycCkgew0KPj4gICAgICAgICB0cmFj
ZV92ZmlvX21pZ3JhdGlvbl9wcm9iZSh2YmFzZWRldi0+bmFtZSk7DQo+PiAgICAgfQ0KPj4NCj4N
Cj5JIGFtIG1haW5seSBxdWVzdGlvbmluZyB0aGF0IHRoZSBlcnJvciB0ZXN0aW5nIGlzIGNvcnJl
Y3QgdG8gdGVzdCBoZXJlLg0KPg0KPklJVUMsIHRoZSBvbmx5IG9uZSB0aGF0IGNhbiBwcm9wYWdh
dGUgYW55ICpuZXcqIGVycm9yIGluDQo+dmZpb19taWdyYXRpb25fcmVhbGl6ZSBpcyB0aGUgY2Fs
bHMgdG8gbWlncmF0ZV9hZGRfYmxvY2tlciBmYWlsaW5nIHdpdGhpbiB0aGUNCj52ZmlvX2Jsb2Nr
KiAobWlncmF0aW9uIGNvZGUgc3VnZ2VzdHMgdGhhdCB0aGlzIGhhcHBlbnMgb24gc25hcHNob3R0
aW5nKS4NCj5GYWlsaW5nIHRvIGFkZCBtaWdyYXRpb24gYmxvY2tlciBqdXN0IG1lYW5zIHdlIGhh
dmVuJ3QgaW5zdGFsbGVkIGFueSBibG9ja2Vycy4NCj5BbmQgdGhlIGN1cnJlbnQgY29kZSBwcmVz
ZW50cyB0aGF0IGFzIGEgIk1pZ3JhdGlvbiBkaXNhYmxlZCIgY2FzZS4gSWYgd2Ugd2FudA0KPnRv
IHByZXNlcnZlIHRoYXQgYmVoYXZpb3VyIG9uIG1pZ3JhdGlvbl9hZGRfYmxvY2tlcigpIGZhaWx1
cmVzICh3aGljaCBzZWVtcw0KPmxpa2UgdGhhdCdzIHdoYXQgeW91IGFyZSBkb2luZyBoZXJlKSB0
aGVuIGluc3RlYWQgb2YgdGhpczoNCg0KQ3VycmVudCBiZWhhdmlvcih3aXRob3V0IG15IHBhdGNo
KToNCiJNaWdyYXRpb24gZGlzYWJsZWQiIGlzbid0IHByaW50ZWQgaWYgbWlncmF0ZV9hZGRfYmxv
Y2tlciBzdWNjZWVkLg0KIk1pZ3JhdGlvbiBkaXNhYmxlZCIgaXMgcHJpbnRlZCBpZiBtaWdyYXRl
X2FkZF9ibG9ja2VyIGZhaWwuDQoNCkkgdGhpbmsgdGhpcyBiZWhhdmlvciBpc24ndCBjb3JyZWN0
LCBJIHdhbnQgdG8gcmV2ZXJ0IGl0IG5vdCBwcmVzZXJ2ZSBpdCwgc28gSSB1c2VkICFyZXQuDQpJ
bWFnaW5lIHdlIGhvdHBsdWcgYSB2ZmlvIGRldmljZSB3aGVuIHNuYXBzaG90dGluZywgbWlncmF0
ZV9hZGRfYmxvY2tlciBmYWlsdXJlDQp3aWxsIGxlYWQgdG8gaG90cGx1ZyBmYWlsLCB0aGVuIHRo
ZSBndWVzdCBpcyBzdGlsbCBtaWdyYXRhYmxlIGFzIG5vIHZmaW8gcGx1Z2dlZC4NCkJ1dCB3ZSBz
ZWUgIk1pZ3JhdGlvbiBkaXNhYmxlZCIgd2hpY2ggd2lsbCBjb25mdXNlIHVzLg0KDQo+DQo+CXJl
dHVybiAhcmV0Ow0KPg0KPnlvdSB3b3VsZCBkbyB0aGlzOg0KPg0KPglyZXQgPSBtaWdyYXRpb25f
YWRkX2Jsb2NrZXIoLi4uKTsNCj4JaWYgKHJldCA8IDApIHsNCj4JCWVycm9yX2ZyZWUoLi4uKTsN
Cj4JCWJsb2NrZXIgPSBOVUxMOw0KPisJCXJldHVybiByZXQ7DQo+CX0NCj4NCj4rCXJldHVybiAx
Ow0KPg0KPk9yIHNvbWV0aGluZyBsaWtlIHRoYXQuIEFuZCB0aGVuIGlmIHlvdSByZXR1cm4gZWFy
bHkgYXMgeW91IGludGVuZGVkPw0KDQpZZXMsIHRoaXMgY2hhbmdlIG1ha2Ugc2Vuc2UsIEkgYWxz
byB3YW50IHRvIGFkZCBiZWxvdzoNCg0KICAgICBpZiAoIXBkZXYtPmZhaWxvdmVyX3BhaXJfaWQp
IHsNCiAgICAgICAgIHJldCA9IHZmaW9fbWlncmF0aW9uX3JlYWxpemUodmJhc2VkZXYsIGVycnAp
Ow0KLSAgICAgICAgaWYgKHJldCkgew0KKyAgICAgICAgaWYgKHJldCA+IDApIHsNCiAgICAgICAg
ICAgICBlcnJvcl9yZXBvcnQoIiVzOiBNaWdyYXRpb24gZGlzYWJsZWQiLCB2YmFzZWRldi0+bmFt
ZSk7DQogICAgICAgICB9DQoNClRoYW5rcw0KWmhlbnpob25nDQo=

