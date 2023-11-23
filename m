Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3C57F5998
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 08:50:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r64S6-000556-Hi; Thu, 23 Nov 2023 02:48:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r64Ry-000537-VO; Thu, 23 Nov 2023 02:48:39 -0500
Received: from mgamail.intel.com ([192.55.52.93])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1r64Rw-0005zE-Fq; Thu, 23 Nov 2023 02:48:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1700725716; x=1732261716;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=NPjqKWkU/E5cBUHVw8n1b+AZHfpJ12Wcz/Fs7+ZKrkI=;
 b=HaxkjgEjE//oTX2uKep8kD7k/i8iIM4//b5/Khh1zVQQuC9LQa1WVTFN
 mFV/ipow89m7DHPHoA+a0JuOvqvfJBWSVRneudTS5BsYbRa+Q3fvr54Kp
 wruubz60BmCTPGsVN8rX2iiskvjHIRkUZET/L4p95y9tjGBg3UJ/ERreX
 0NIQLHd5oO2SS3zj7To82UsmwmUSDp5dLu1EhYZhxB+luXldjz1k3iYI5
 GbrHcLG1t7F4bgynm+jjxwY01dwyXlckft648ueV13Fm9ugVlrHkoiWan
 1qEOJneoizzGBvxfjsPZcME0tYaikz6il3e4D0cPo8vw0Kw6+uaTRulIj g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="389368304"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; d="scan'208";a="389368304"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
 by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2023 23:48:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="911090002"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; d="scan'208";a="911090002"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 22 Nov 2023 23:48:19 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 23:48:19 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 23:48:19 -0800
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 23:48:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ce8b0HdSITLCPsz3SOYmH8wkvINK9cYu77bW+J3/Cdu/BB5VGhswSVDxHieotd6i+vG4id6I0D5lcDcCfebCJLWdobchLAc95S9rbNf5FhR4eBvE3TlJHCa0daRJ11TVMFx8+ATd/5o2mh1zKiT+YDawRH5UCeh5IO0E//ts19R8caRyRfz/qEVH1ybDJs7nPxP8CfgeV9vwDvEyckFz63Fd/WgyiO1jo/IL2hmsR1/WV/5Vm2dChp5c5erz2m2rNwvd48cAx/GVPVoz2vf3Tw1nwtxBqHLKHg5JhieWKbnpSW4k8DBQDJH5+ckgwsIGW2jx24LGjv3fqh9p6veUJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NPjqKWkU/E5cBUHVw8n1b+AZHfpJ12Wcz/Fs7+ZKrkI=;
 b=Vzo3sAY4itSpXHw4lxtPrFmnj5CPtn1KyTNcvUIXvSPZAHXIJ/Hn18aICLGLG1/S1u3P4qRBw26SO0mZ2nMNPKHmNRtpTQAFO1X0I4Gk8/9CEZrSSEpliEihi/3z6TSb4NdFlNTFBR5JnWFsW2ERFdn781SvdFtCCOnvLd8atZNtvxJRfeCnW8Dma63hS9u/T7mlq1AaGuHWFQIhsgVNwOPhtMiZXMsfr6iJHtNHp+ROTxkP24KEa1d6w72AtLKYvQ1DOj2oFVz9dtGu4RD76jod4L4pI5EMvCHBuQYYVvLrQo2tke/p87Zf8mqAtNQMTaORrWXscH+QNT7YBdwWcw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by BY1PR11MB8078.namprd11.prod.outlook.com (2603:10b6:a03:52a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Thu, 23 Nov
 2023 07:48:11 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::a4bb:8de0:9dde:2fea%4]) with mapi id 15.20.7025.020; Thu, 23 Nov 2023
 07:48:08 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, "Daniel Henrique
 Barboza" <danielhb413@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, "open list:PowerPC TCG CPUs"
 <qemu-ppc@nongnu.org>
Subject: RE: [PATCH] hw/ppc: Improve build for PPC VFIO
Thread-Topic: [PATCH] hw/ppc: Improve build for PPC VFIO
Thread-Index: AQHaHdK5y2MYznEAe0iiTj2wR1sQdrCHgwWAgAADKKA=
Date: Thu, 23 Nov 2023 07:48:08 +0000
Message-ID: <SJ0PR11MB6744463B724EB31A02AA771792B9A@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231123060109.131904-1-zhenzhong.duan@intel.com>
 <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
In-Reply-To: <dd2db398-908a-46a8-b02b-8418956462cb@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|BY1PR11MB8078:EE_
x-ms-office365-filtering-correlation-id: 4b1bc4cd-b1f1-49da-e852-08dbebf88927
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: S4aIAxxrSga+4+YELP64bAbaRrXj8mvmISAPR5Gs2IljU0OewjFqMd0RhYXNhdmx6kxnSoYVXgKZe7AUqGxFlHB1ZhSz3a34mzTpb+LoeG9s5dQK/NHRkzbewVYfJeNHZCVGrn54r82IyKXWVahZ6PzUe8BQjRkdI3j4G+/E71GWTpz8V4rkKydSFhBDuOW/ZoN7T3ZlOfpQJASZRycnJO32E7Z6SlSv9a3tw3TWBhEJh8a/dyTViWm6zTqX02morQMSAnqkzREqXzhWjuyRW6fGO2WfIsvonib+9sOpTGTWczPIisb6cTScIfJaPNObdbT31NpuSDeGdQBsX+7Y+iQsSQz2cGxI2OMRqFVa0r9o703OU6aBirVbQYy0vIrKYpppWrScFYWxwl2a8+tb2EFf42Tp4KwJUiAW4qtqAIQo1Q6hUY2MFFnRuSGlhPsl/MNiSJ9Os6qaJEpdmH3uRkCWW/Dj0paNijMIndaEkSz3IHaWFsbSF7dSRUbYFMswcSHk7J9wWNvXJrzNs2eES20XyWjQxs55Q9OryZtBUBqDRqUIgBldPUiFwS51hVoA3kpPvqhJ1Bbpt8hHkf6MqjnhDDc1R3u+uVFVH88nYfV7MrEREILLoBvewrLn54nW
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(39860400002)(136003)(396003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(7696005)(66446008)(66556008)(66476007)(76116006)(110136005)(66946007)(64756008)(316002)(54906003)(9686003)(6506007)(71200400001)(38100700002)(478600001)(26005)(66574015)(82960400001)(122000001)(83380400001)(33656002)(86362001)(38070700009)(55016003)(5660300002)(2906002)(52536014)(8936002)(41300700001)(8676002)(4326008);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NS9qanJSdnpqcGx5Z2c2SW5ZTHgxcUJvSS9YKzZyUENsOWNzai9qYkxGRW5i?=
 =?utf-8?B?S1l4TGNaejZldHRZTm5pUU5LS2hYaCtJL0psTzVFdkJqM2VRZ2NOcWd6NlNi?=
 =?utf-8?B?OEY1NnhkVHZkMmJhVWRYM0xrOVZjcW02OFZjeFhROTZkRlN1S2tBNHJPZ1hH?=
 =?utf-8?B?S3pWaWZQeXVyZ3NmcnFiMG80NUlBWGNDWmR6ZCswR0poVldkZW1kQ2dUREwr?=
 =?utf-8?B?N1JGUFVSTEZ4dTdOa1Jkb0JPZmJJZVhRV2Jua2pqNEVqSmdCNnhrME5KSk1x?=
 =?utf-8?B?alA4ZkhrZE5zUnFwQWtmQkNLZ1R4WHRjSmJQajJQM2xLOVZaZHlNOG1tbkhh?=
 =?utf-8?B?V3ZWVVdUTWNoL0NSc0lvTUc4QlFEblN0WG5oaHozbGVTek1lYUpJT2RxMUxY?=
 =?utf-8?B?ZVBIYjNiclZWKzFPSXZDaUs0MU9RU2phWWRzam1sZzRabmFxUUdVOStyMHc2?=
 =?utf-8?B?WFVsVCttamQ3aWRhRXhrTjhMaDlqdlY3NGxvL3FUbVpyOHNDV3V1Z1U3NlRE?=
 =?utf-8?B?TERPTUlhZnNCWGd1THBEN3cxRnBjVjhLUUY4TU1JbktEb2RlNnNHeGNQUzg0?=
 =?utf-8?B?QlJla25keHhDU0hMeDkyS2cyUnhRN2dDbzY0T3krc016VU5xZWozbng1Mjhw?=
 =?utf-8?B?M0ExaDBJMkZMeG13VHpaVEdMWHRaU0V4Vld1V2p1c01wZm5Qdk1GTzVHdHBS?=
 =?utf-8?B?cSt2MFErajYxc01abVA4YjY2MW11UlE1cE5QM1lsOW8wcFBzV0dIUEpVUXd3?=
 =?utf-8?B?ZS9BSzRpbVcrZFo2RDBXTE4xLy91ZXhUMVJoV0kwUnRoOHI1cGQvNU8raXZ1?=
 =?utf-8?B?THNqcG1XeTNLWDBVZDF0S1RCeE5VeFFzS2VqTWx4UnBPWDViQ21ENE83bmMr?=
 =?utf-8?B?blZLeWZJbzhaWExSSTZpMVkyM0pJSDJWVVVEbmU5bTNWZjhrcVNBMmtjM0ZF?=
 =?utf-8?B?SnJtRVBXVG04S1J5NXlkZTNtTlFSVGdoanp6ZE1kVzhzcmlyeEFQYis2UG5Z?=
 =?utf-8?B?ZFJUMGJ2TmRmVHFjVFJSK0xvMFNSM1p6V3RVZ290Zm8weXhTYkVOQjVPb3ds?=
 =?utf-8?B?WjhQSStpZURaVUNiYVRlenVXQ20xN3MzeEM4a3lpSTlGaXhtUXNUZGRJN3ls?=
 =?utf-8?B?eFphckdueDBQS21jaUUzZk1vbjhnUzlJQXJVWW1IZUdDZzgxUTF3dFBVVVZv?=
 =?utf-8?B?akk0YjYzaE84RlhYaEhBRUFqMzBBb2ZTUTJyYTgyOFNGVDdUaFFwZi84bnJJ?=
 =?utf-8?B?WDJITWhiZWhRUDQ1VWg2TXdXTmVwTStUMjRIT05nWDJmb2V4eE5BbWpBdHZl?=
 =?utf-8?B?OFEydlNKdi9NVXlMOHlONnMwOEpwczIyL0dHTzFIVHozN2xNR1AvYThTZjJH?=
 =?utf-8?B?emlHcEs3eFJTMWxmdGxjNTdVQzJXR0U1Q1pLNDBDcVd3Wk1CQjBxdlhiM1I1?=
 =?utf-8?B?NDhUWXk1SU1rNjd5MWF6VStuckJZVXBEbk13SmRUalF2SVZ1NVhodU1Od2I4?=
 =?utf-8?B?UmVTYWVIY0hRT21Lb0tyR3pKUGxwS0FtNC9KUVJTbW1QVHhIQ3V1dTlIZnQx?=
 =?utf-8?B?aVV5UWY4c3RVNEZHUUFzbWhuNzJTcDJIV1FWU2JuWHV1WFFKL2h0b3MybHla?=
 =?utf-8?B?UjMwaSs3enV5Zm5YTTZHd0Zxc3VUUmVFaFk5Mm1sTjZXZDQ1T1R2eFZ1WVNh?=
 =?utf-8?B?M1dIUTQ4bGNULzVLRmhnZ2QramZvVjZ3U1hyNis3ZkRCZ1dPVmxUZmNna3BH?=
 =?utf-8?B?ckFJbFZtMkRqNnZOU3JlcTJTRzFveEd1dUtYNCs3MlJvdUZURkh4RHpkUERZ?=
 =?utf-8?B?eE0vSXpPMlIrTFNETDZoTS9QbmpPMnNaQ2tCUUxiTkRVVjRZYUtKTCtwWk5l?=
 =?utf-8?B?NnJYQWZudkxIRnY2ZjQxSWM4N1N3blVseWJYdzRSU1NxL3B0dHVOV0d0ZnRX?=
 =?utf-8?B?aG15RzNxa2w1Y24vbmNTanlCb3JwNmNrWkk1MDI4UnQ5NVBDcFJoWENYSGtB?=
 =?utf-8?B?aVVaSTM1UkVxQkNwNUhxcVFyYVYyYWN2R0YrcnBIQjI2d29lZm85NUdHMERZ?=
 =?utf-8?B?SmpFNWR1eGFtWndIZkxXYXhUU2NSeWdYSUZWbERoUmNQUFpzZjhESlJNTjZ6?=
 =?utf-8?Q?DwuyEof6Fv5QW9akhYicljwsF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b1bc4cd-b1f1-49da-e852-08dbebf88927
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Nov 2023 07:48:08.7954 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WkiC5rTNpqpSjzzzJx/EDWAbPS/J5awKLrd9H/w+7vvOP52T+ja3wsmeMpjNl0J+QdJ5qXhZ2OLSGW69dE3jeD6+QaL+n0c+H8b0TNVonew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR11MB8078
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=192.55.52.93;
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
IDxjbGdAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgTm92ZW1iZXIgMjMsIDIwMjMgMzoz
MyBQTQ0KPlN1YmplY3Q6IFJlOiBbUEFUQ0hdIGh3L3BwYzogSW1wcm92ZSBidWlsZCBmb3IgUFBD
IFZGSU8NCj4NCj5PbiAxMS8yMy8yMyAwNzowMSwgWmhlbnpob25nIER1YW4gd3JvdGU6DQo+PiBW
RklPIGlzIG5vdCBhIHJlcXVpcmVkIHN1YnN5c3RlbSBmb3IgdGhlIHBzZXJpZXMgbWFjaGluZSBi
dXQgaXQncw0KPj4gZm9yY2UgZW5hYmxlZCBjdXJyZW50bHkuIFdoZW4gLS13aXRob3V0LWRlZmF1
bHQtZGV2aWNlcyBpcyB1c2VkDQo+PiB0byBkcm9wIHNvbWUgZGVmYXVsdCBkZXZpY2VzIGluY2x1
ZGluZyB2ZmlvLXBjaSwgdmZpbyBjb3JlIGNvZGUNCj4+IGlzIHN0aWxsIGtlcHQgd2hpY2ggaXMg
dW5uZWNlc3NhcnkuDQo+Pg0KPj4gSW50cm9kdWNlIGEgc3R1YiBmaWxlIHRvIGhvbGQgc3R1YiBm
dW5jdGlvbnMgb2YgVkZJTyBFRUggaG9va3MsDQo+PiB0aGVuIHZmaW8gY29yZSBjb3VsZCBiZSBj
b21waWxlZCBvdXQuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xn
QHJlZGhhdC5jb20+DQo+PiBTaWduZWQtb2ZmLWJ5OiBaaGVuemhvbmcgRHVhbiA8emhlbnpob25n
LmR1YW5AaW50ZWwuY29tPg0KPg0KPg0KPk5pY2ssDQo+DQo+SSB3aWxsIHRha2UgdGhpcyBwYXRj
aCB0aHJvdWdoIHRoZSB2ZmlvIHRyZWUgaWYgdGhhdCdzIE9LIGZvciB5b3UuDQoNClN1cmUuDQoN
Cj4NCj4+IC0tLQ0KPj4gQmFzZWQgb24gdmZpby1uZXh0L3ZmaW8tOC4yDQo+Pg0KPj4gICBody9w
cGMvc3BhcHJfcGNpX3ZmaW9fc3R1Yi5jIHwgMzMgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrDQo+PiAgIGh3L3BwYy9LY29uZmlnICAgICAgICAgICAgICAgfCAgMiArLQ0KPj4gICBo
dy9wcGMvbWVzb24uYnVpbGQgICAgICAgICAgIHwgIDYgKysrLS0tDQo+PiAgIDMgZmlsZXMgY2hh
bmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4+ICAgY3JlYXRlIG1vZGUg
MTAwNjQ0IGh3L3BwYy9zcGFwcl9wY2lfdmZpb19zdHViLmMNCj4+DQo+PiBkaWZmIC0tZ2l0IGEv
aHcvcHBjL3NwYXByX3BjaV92ZmlvX3N0dWIuYyBiL2h3L3BwYy9zcGFwcl9wY2lfdmZpb19zdHVi
LmMNCj4+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+PiBpbmRleCAwMDAwMDAwMDAwLi5hZGIzZmI1
ZTM1DQo+PiAtLS0gL2Rldi9udWxsDQo+PiArKysgYi9ody9wcGMvc3BhcHJfcGNpX3ZmaW9fc3R1
Yi5jDQo+PiBAQCAtMCwwICsxLDMzIEBADQo+PiArI2luY2x1ZGUgInFlbXUvb3NkZXAuaCINCj4+
ICsjaW5jbHVkZSAiaHcvcGNpLWhvc3Qvc3BhcHIuaCINCj4+ICsNCj4+ICtib29sIHNwYXByX3Bo
Yl9lZWhfYXZhaWxhYmxlKFNwYXByUGhiU3RhdGUgKnNwaGIpDQo+PiArew0KPj4gKyAgICByZXR1
cm4gZmFsc2U7DQo+PiArfQ0KPj4gKw0KPj4gK3ZvaWQgc3BhcHJfcGhiX3ZmaW9fcmVzZXQoRGV2
aWNlU3RhdGUgKnFkZXYpDQo+PiArew0KPj4gK30NCj4+ICsNCj4+ICtpbnQgc3BhcHJfcGhiX3Zm
aW9fZWVoX3NldF9vcHRpb24oU3BhcHJQaGJTdGF0ZSAqc3BoYiwNCj4+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGFkZHIsIGludCBvcHRpb24pDQo+PiAr
ew0KPj4gKyAgICByZXR1cm4gUlRBU19PVVRfTk9UX1NVUFBPUlRFRDsNCj4+ICt9DQo+PiArDQo+
PiAraW50IHNwYXByX3BoYl92ZmlvX2VlaF9nZXRfc3RhdGUoU3BhcHJQaGJTdGF0ZSAqc3BoYiwg
aW50ICpzdGF0ZSkNCj4+ICt7DQo+PiArICAgIHJldHVybiBSVEFTX09VVF9OT1RfU1VQUE9SVEVE
Ow0KPj4gK30NCj4+ICsNCj4+ICtpbnQgc3BhcHJfcGhiX3ZmaW9fZWVoX3Jlc2V0KFNwYXByUGhi
U3RhdGUgKnNwaGIsIGludCBvcHRpb24pDQo+PiArew0KPj4gKyAgICByZXR1cm4gUlRBU19PVVRf
Tk9UX1NVUFBPUlRFRDsNCj4+ICt9DQo+PiArDQo+PiAraW50IHNwYXByX3BoYl92ZmlvX2VlaF9j
b25maWd1cmUoU3BhcHJQaGJTdGF0ZSAqc3BoYikNCj4+ICt7DQo+PiArICAgIHJldHVybiBSVEFT
X09VVF9OT1RfU1VQUE9SVEVEOw0KPj4gK30NCj4+ICsNCj4+IGRpZmYgLS1naXQgYS9ody9wcGMv
S2NvbmZpZyBiL2h3L3BwYy9LY29uZmlnDQo+PiBpbmRleCBlZGM2ZDJkMTM5Li5iOGRhYmRiZmJl
IDEwMDY0NA0KPj4gLS0tIGEvaHcvcHBjL0tjb25maWcNCj4+ICsrKyBiL2h3L3BwYy9LY29uZmln
DQo+PiBAQCAtMywxMSArMywxMSBAQCBjb25maWcgUFNFUklFUw0KPj4gICAgICAgaW1wbHkgUENJ
X0RFVklDRVMNCj4+ICAgICAgIGltcGx5IFRFU1RfREVWSUNFUw0KPj4gICAgICAgaW1wbHkgVklS
VElPX1ZHQQ0KPj4gKyAgICBpbXBseSBWRklPIGlmIExJTlVYICAgIyBuZWVkZWQgYnkgc3BhcHJf
cGNpX3ZmaW8uYw0KPg0KPlpoZW56aG9uZywNCj4NCj5JIGNoYW5nZWQgVkZJTyB0byBWRklPX1BD
SSBiZWNhdXNlIFBQQyBvbmx5IHN1cHBvcnRzIHRoaXMgdHlwZQ0KPm9mIHBhc3N0aHJvdWdoIGRl
dmljZXMuDQoNCk9oLCBJIHNlZSwgdGhhbmtzDQoNCkJScy4NClpoZW56aG9uZw0KDQo+DQo+V2l0
aCB0aGF0LA0KPg0KPlJldmlld2VkLWJ5OiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5j
b20+DQo+DQo+VGhhbmtzLA0KPg0KPkMuDQo+DQo+DQo+DQo+PiAgICAgICBzZWxlY3QgTlZESU1N
DQo+PiAgICAgICBzZWxlY3QgRElNTQ0KPj4gICAgICAgc2VsZWN0IFBDSQ0KPj4gICAgICAgc2Vs
ZWN0IFNQQVBSX1ZTQ1NJDQo+PiAtICAgIHNlbGVjdCBWRklPX1BDSSBpZiBMSU5VWCAgICMgbmVl
ZGVkIGJ5IHNwYXByX3BjaV92ZmlvLmMNCj4+ICAgICAgIHNlbGVjdCBYSUNTDQo+PiAgICAgICBz
ZWxlY3QgWElWRQ0KPj4gICAgICAgc2VsZWN0IE1TSV9OT05CUk9LRU4NCj4+IGRpZmYgLS1naXQg
YS9ody9wcGMvbWVzb24uYnVpbGQgYi9ody9wcGMvbWVzb24uYnVpbGQNCj4+IGluZGV4IGVhNDQ4
NTZkNDMuLjJkZjVkYjJlZWYgMTAwNjQ0DQo+PiAtLS0gYS9ody9wcGMvbWVzb24uYnVpbGQNCj4+
ICsrKyBiL2h3L3BwYy9tZXNvbi5idWlsZA0KPj4gQEAgLTM0LDkgKzM0LDkgQEAgcHBjX3NzLmFk
ZCh3aGVuOiBbJ0NPTkZJR19QU0VSSUVTJywgJ0NPTkZJR19UQ0cnXSwNCj5pZl90cnVlOiBmaWxl
cygNCj4+ICAgICAnc3BhcHJfc29mdG1tdS5jJywNCj4+ICAgKSkNCj4+ICAgcHBjX3NzLmFkZCh3
aGVuOiAnQ09ORklHX1NQQVBSX1JORycsIGlmX3RydWU6IGZpbGVzKCdzcGFwcl9ybmcuYycpKQ0K
Pj4gLXBwY19zcy5hZGQod2hlbjogWydDT05GSUdfUFNFUklFUycsICdDT05GSUdfTElOVVgnXSwg
aWZfdHJ1ZTogZmlsZXMoDQo+PiAtICAnc3BhcHJfcGNpX3ZmaW8uYycsDQo+PiAtKSkNCj4+ICtw
cGNfc3MuYWRkKHdoZW46IFsgJ0NPTkZJR19WRklPX1BDSScsICdDT05GSUdfUFNFUklFUycsICdD
T05GSUdfTElOVVgnXSwNCj4+ICsgICAgICAgICAgIGlmX3RydWU6IGZpbGVzKCdzcGFwcl9wY2lf
dmZpby5jJyksDQo+PiArICAgICAgICAgICBpZl9mYWxzZTogZmlsZXMoJ3NwYXByX3BjaV92Zmlv
X3N0dWIuYycpKQ0KPj4NCj4+ICAgIyBJQk0gUG93ZXJOVg0KPj4gICBwcGNfc3MuYWRkKHdoZW46
ICdDT05GSUdfUE9XRVJOVicsIGlmX3RydWU6IGZpbGVzKA0KDQo=

