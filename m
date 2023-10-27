Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D487D9050
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:50:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHbu-0008F7-Rl; Fri, 27 Oct 2023 03:50:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwHbq-0007vM-UB
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:50:22 -0400
Received: from mgamail.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1qwHbn-0005G3-Kg
 for qemu-devel@nongnu.org; Fri, 27 Oct 2023 03:50:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1698393019; x=1729929019;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WRxaSyPT2JNOKkzNHBitV5y/6IYovoh23DPEKJXlpWI=;
 b=R0fm6Y1MFbzypJnCGQtTtD/jYtR/9JieMIp36Vcf5CRyzlRpvJwlzhTX
 BxhUdSbTlSsvgjULmemTPcZynKPKBVt2hh8KNT/fgMZcFjGyaMS85ezVY
 iuc4HsFltyyL/7jLtvAsCylMpF5uME29oN7a/Txo3YO7KWV43I0ZHBiMy
 2ZZKmfPb8i71x5th04D2oNN5npKOymGAgqekO3eWAo0UcTpgRTspSjEIN
 uGQ4+aSNO4b/cxB2NiOJoGbhJReoURD8dWNGrTMC/lJ+CHRYhlRZgSWb5
 r9vOLaYmzEY4zAbObdc5T/v9IYwuUhcZzCug4dwGoPWoE2vZKQYMbrNwm g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="372778660"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="372778660"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2023 00:50:13 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="825252058"
X-IronPort-AV: E=Sophos;i="6.03,255,1694761200"; d="scan'208";a="825252058"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
 by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 27 Oct 2023 00:50:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Fri, 27 Oct 2023 00:50:08 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Fri, 27 Oct 2023 00:50:08 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Fri, 27 Oct 2023 00:50:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTvdMqOpUwT1F7fEioZphxtVwk8MQFuxAp0Vez5TFU1gTClYJpJwBgDv6Gz/57Iu3spS54Q3IKJHs28MTJaYFOOZvGx1H9pdK6x1wUZYGBo+TQuaYOmsqseFuMzazRn6OPQ+OOQpMIpgdPruDmP7azHOhtXVY6BAYhNto2gjW7J6Voo3Oa1WNZMC1payW5zj7MXAv7YRgi7pS1Q6j34N9OSWt5KbPelBpyFMLIsltMwKIgFHM8H4k2hNPjK4uwcoQv3oAzkb2wxGU18uLU1Ih7rkCXnXKV15kJ47MFg6kv02APTop8dGW6MrtLHc03bYyRABrXkewWY3BIMwovaCcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WRxaSyPT2JNOKkzNHBitV5y/6IYovoh23DPEKJXlpWI=;
 b=ZTa3aRqVHXAL0jGCpcTrqMydzrt3wp36A4NS6S16dM1qbhwXaTGOouuPyYQrJBj6r3LDhHwrFWDTOkU4jpV61rzQK9uVk957yeOwbytkjWpf49E2aueVFW2xJyfS7YovLtt2fnoEm1YvbvfGtg54hI+5G1tEJWFL0JoAMNw78xu2dfsgzJW9Lg9tfQIRcuzktazH8J5R98ehwja9n1cmvGWTVgUHdBENw17DvDbJgm3yWvr/kgnxOv/qtdKrOCy3xYXkmLtZ4rxFRl7OiR7eo8nVDpfVw8110z9oxkU2tLFf1yJGjpWVBhShe3hL0A1mE35lxUg3BtkXVT/XxK5xbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by MN0PR11MB5962.namprd11.prod.outlook.com (2603:10b6:208:371::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 07:50:00 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::bb35:72a8:1513:c13f]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::bb35:72a8:1513:c13f%4]) with mapi id 15.20.6933.019; Fri, 27 Oct 2023
 07:50:00 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: Markus Armbruster <armbru@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "clg@redhat.com"
 <clg@redhat.com>, "jgg@nvidia.com" <jgg@nvidia.com>, "nicolinc@nvidia.com"
 <nicolinc@nvidia.com>, "Martins, Joao" <joao.m.martins@oracle.com>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>, "peterx@redhat.com"
 <peterx@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "Tian,
 Kevin" <kevin.tian@intel.com>, "Liu, Yi L" <yi.l.liu@intel.com>, "Sun, Yi Y"
 <yi.y.sun@intel.com>, "Peng, Chao P" <chao.p.peng@intel.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?utf-8?B?RGFuaWVsIFAuQmVycmFuZ8Op?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Eric Blake
 <eblake@redhat.com>
Subject: RE: [PATCH v3 24/37] backends/iommufd: Introduce the iommufd object
Thread-Topic: [PATCH v3 24/37] backends/iommufd: Introduce the iommufd object
Thread-Index: AQHaB/nlJZm1rfRcfUK2ik07RuZx6rBcENfJgAEtQpA=
Date: Fri, 27 Oct 2023 07:50:00 +0000
Message-ID: <SJ0PR11MB6744685EB6B526484F334AB692DCA@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20231026103104.1686921-1-zhenzhong.duan@intel.com>
 <20231026103104.1686921-25-zhenzhong.duan@intel.com>
 <87msw5a4z3.fsf@pond.sub.org>
In-Reply-To: <87msw5a4z3.fsf@pond.sub.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|MN0PR11MB5962:EE_
x-ms-office365-filtering-correlation-id: 9b286b8b-50b4-41f6-2648-08dbd6c15270
x-ld-processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Vq528wAILYw+SnHFZ2eZxODDqJ7vXbsQ/mF3TxK5Ex6gsDkTjSNlPPIv1Tew860RqJ7/cRNl2c5DdHRy8dlAZ2bEwaTXAqG45l+qm/2QFjFuuyYqiczARQ8mWCziYMT0N5ZuJKFiSXMJNRIQtOcdVOd3+NeyMRzKYAlsTRVGaQfYcz1OflrYmVdEma0CDKomGeAq3Mz4goaYg8SKKw/TwbA/HLJSjWZ+1KjeANvJlTJyeVsiYC+n7a3iap04QQD0lq/zXwExBdFHWWkoOOSbgJLIZVzeB5Ts54WNks9mre+I+CZL6hjklnWOigP2vFLPfhL4o9XKzYF3lEb4F37b7TFLG1Zehg1cxsiTFbU+7qqnIMNGquKsB34P7q2DbyP2y4lE5d1qd1edYSDOgxor01Ugqe9fJgrrmJyVvNQaaX4BdDIU3YmUcJ/NbmHcHbG6Inh8z9HZFIBuD+6o1aJHnTj/daTQY2TLYiEVLsZDQWwakH6vc0mYeYVEgr0LzK4gTd3c16nV16fTU6v5uNQ4DSykiVBS3RWREY7jAx9ZUD561E21CyVciSFHSEIov0f+q9xZVOEZKtNFOHt6rOLukAIMQ+uKZIEIYwC613ibZE9QWcaUNKFNxRWKPDmQJt1A
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(396003)(376002)(39860400002)(136003)(366004)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(26005)(38070700009)(6916009)(38100700002)(122000001)(2906002)(55016003)(33656002)(5660300002)(86362001)(7416002)(4326008)(52536014)(8676002)(8936002)(7696005)(54906003)(71200400001)(478600001)(66446008)(6506007)(66476007)(316002)(66556008)(64756008)(76116006)(66946007)(83380400001)(41300700001)(82960400001)(9686003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UFVWYnFYaFkzUFlqWlJOekR1TzE5d0FyZXVWRkhtSXZHMG8zN0JaeHAzaUti?=
 =?utf-8?B?WjZ0UFhyVmdqVU1PWStGMGROMzBIaUtMODQxcHJGN1JSYVlLWmdYV0N2SU1S?=
 =?utf-8?B?eFdydkJxNGxkWWgzWG5WeVVoODN0S1h4eVZBTDVMbGZSdlJYRXhLRDNOOVZU?=
 =?utf-8?B?QmVvbTBrNW1wcGtua1R1U0NVTktuVVZDUnVxM1k1SENZN2dIbkVlWEhibS9u?=
 =?utf-8?B?aUVXcWpIcFNBMW9Sa2VNa2VQN3NyYjFKaGtXei8wbGY2Y2RPZ3pjcjFZa0ZK?=
 =?utf-8?B?aUJNbml3enRHeVBHZ2RGNnlOY2NDakRqa2F6dUc2ZFlOV2xWN0RPVG4rbElt?=
 =?utf-8?B?c3h6Q09GSm1BTUdZaXpEK3NRMXp2MmFuRTgybjFwSXZEWGJiOFpyVzB5Q0I0?=
 =?utf-8?B?SjQwOUJRYTdKeVNIZUEwMEVpcTJ4U09leFNNU0YvNWcvTEptSi9KOVF3Y2FZ?=
 =?utf-8?B?ZDcxS3dJWm1TVTNSUmhkbUROL3hmNWd5ZUZxR3ZiMXJ6NzloZjZnY2lmUUJa?=
 =?utf-8?B?OXpVcDNrNGRXWlh5T1c5WnBiNEVQZzRGM0RvanNuSTJidmpjUDR3Y2RqaFVI?=
 =?utf-8?B?Y2dZR1JlNEYrSFJmNTFNNk5uYmt5eXZUMGtvWSswL00xREI4bmhWOXFDVVFr?=
 =?utf-8?B?OURFZWQwNWM1cDU1N0p0ajBtK0tnQkxMU2c2Mk5kZzBQTzJMelJmMUJKdmpt?=
 =?utf-8?B?OU9vdk1xWFI3TUhWMm9UWkZFWTFpcW03UDZCUk1Ec3BibG1pTlU4ZkdBeUhy?=
 =?utf-8?B?MDVCdU9xRTZCYzV1TVVFeGdCWVZpTEV5WkFUQmMrVVA0TlpFQlg5bW5uaGU2?=
 =?utf-8?B?V1cwQ0dadGw1QWwvWmpSNVBROTdoRXpNaFVycjVGUnRHYi9GVFFLVE9JWlFy?=
 =?utf-8?B?c2cyYjBGU01WM1cySmVUbDAyblpSOUJRRkdhQ29WQytnaUxqUldKWVhJTnUr?=
 =?utf-8?B?Wkw1UXpCakRMc2w4WklaVGRjSENtK29ralNoc1E4bUprQUVvbnMrZ3ZuZ2RY?=
 =?utf-8?B?Y1hMc2JkMUphL2ZHU09Ld1lUY29IL0R4SXJuSTlKQ3NoY1VDNitQWHk1aThM?=
 =?utf-8?B?ckMvcGFneUtEeSthZlNFc1RLOXkrTnlwdFY5V01YdEtwMkNFZVFUWFgzbUFE?=
 =?utf-8?B?Y1RaWHpBTlRaTmFodVI3Rm5nWVZ3UU1yNVRDSTJmTXNScUVQU0x1VFRJYk51?=
 =?utf-8?B?WUhTV2xVVTNWbkdhLzNERnRGcnZmNjhrdWZ3S2wyVUdwSVRFSTBQeXZ5cEI0?=
 =?utf-8?B?aTg2anRXZ0duaDA5NUdHekdBeDM4alNBODJpR00wR3JqdWNiTzc1ME84Skcr?=
 =?utf-8?B?RUxiNWNjMTBQUitLZURSMmtwWUlpbnhtNisxdmU1akU1azQydEVoTHVob0xj?=
 =?utf-8?B?aG1hRldzV3lMQ1VKTDNMZXpQT0Mxc29yclcvWVFRUkdZQUNtYzhEMjVHUk1Z?=
 =?utf-8?B?dUVMRTF3dWRtdzh1SzJqSjN4b1VJejJrSkFJbGF3elNaUHdKbEZLMUFzcmdL?=
 =?utf-8?B?QmlQZFB2RkpUeHQzM2VuY1NuMCttTDJJU0RDQUtCN1NoTzlmUTVJa3pGQlRF?=
 =?utf-8?B?d0VULzZJT0ppU005Z0Q2bEdwS0xLR0J3SFVPcFRRNnVaTU43aDEzRCtwTEFI?=
 =?utf-8?B?TERRb0hkNmwxWnNURHNuMFR2a2dlSWN0ZEp0K3pNa2tEVnVWQUhHRlBSUnRI?=
 =?utf-8?B?aWVwVHZSVDlrMnRBTEVHYlJmVTh2UjFmUXNqclZ2dGp4ZUNMRHNUallZb2h2?=
 =?utf-8?B?Zk9FSDJRRSs4blpZUVJEM0ZkR1ZITUgzazRuR0pOcTlJelU3aVpyQUgrUDM0?=
 =?utf-8?B?bDRYd09zTEZCU0M5eWM3S0E1dUduWVlTamNMZXowamFIbWRRSHZ0V0FDdG1s?=
 =?utf-8?B?WEUzaUdIUCs3WjFsTTgrSnFjWUhmM2MxVEpJOFZhR0J4dElWUTZmSmFQZ1ZQ?=
 =?utf-8?B?a1h4T2ZwVm50MUwvTTFpVEhQek1WZWUvRDRTa0lKTWphUnZPZWQvb0NIQ09s?=
 =?utf-8?B?aWRMRGlGcWh0T2hMOFBrZ2hOeXBWMUpmQWpKTWRaR09jcTd2MFdJVDM4eWQ2?=
 =?utf-8?B?OXAxbnl3VkF1ZkRPdGFHQzdoaWNoa3N2dGF6OFJ5eGpqcDNnbWQ2SG5VSzNu?=
 =?utf-8?Q?iOAqwTV/zQSrSFiR03oYJA+Zo?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b286b8b-50b4-41f6-2648-08dbd6c15270
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2023 07:50:00.2668 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z0bLXg0DMhK302oOxv2TlemXQobSIGAwpraiNUurc7jU0MWnTVn/vJqJU7DIokLBg06MwgeognpV6901e/Kg6MaaDTYG41iqMv3q9NHEkQE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB5962
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IE1hcmt1cyBBcm1icnVzdGVy
IDxhcm1icnVAcmVkaGF0LmNvbT4NCj5TZW50OiBUaHVyc2RheSwgT2N0b2JlciAyNiwgMjAyMyA5
OjI4IFBNDQo+U3ViamVjdDogUmU6IFtQQVRDSCB2MyAyNC8zN10gYmFja2VuZHMvaW9tbXVmZDog
SW50cm9kdWNlIHRoZSBpb21tdWZkIG9iamVjdA0KPg0KPlpoZW56aG9uZyBEdWFuIDx6aGVuemhv
bmcuZHVhbkBpbnRlbC5jb20+IHdyaXRlczoNCj4NCj4+IEZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj4+DQo+PiBJbnRyb2R1Y2UgYW4gaW9tbXVmZCBvYmplY3Qgd2hp
Y2ggYWxsb3dzIHRoZSBpbnRlcmFjdGlvbg0KPj4gd2l0aCB0aGUgaG9zdCAvZGV2L2lvbW11IGRl
dmljZS4NCj4+DQo+PiBUaGUgL2Rldi9pb21tdSBjYW4gaGF2ZSBiZWVuIGFscmVhZHkgcHJlLW9w
ZW5lZCBvdXRzaWRlIG9mIHFlbXUsDQo+PiBpbiB3aGljaCBjYXNlIHRoZSBmZCBjYW4gYmUgcGFz
c2VkIGRpcmVjdGx5IGFsb25nIHdpdGggdGhlDQo+PiBpb21tdWZkIG9iamVjdDoNCj4+DQo+PiBU
aGlzIGFsbG93cyB0aGUgaW9tbXVmZCBvYmplY3QgdG8gYmUgc2hhcmVkIGFjY3Jvc3Mgc2V2ZXJh
bA0KPj4gc3Vic3lzdGVtcyAoVkZJTywgVkRQQSwgLi4uKS4gRm9yIGV4YW1wbGUsIGxpYnZpcnQg
d291bGQgb3Blbg0KPj4gdGhlIC9kZXYvaW9tbXUgb25jZS4NCj4+DQo+PiBJZiBubyBmZCBpcyBw
YXNzZWQgYWxvbmcgd2l0aCB0aGUgaW9tbXVmZCBvYmplY3QsIHRoZSAvZGV2L2lvbW11DQo+PiBp
cyBvcGVuZWQgYnkgdGhlIHFlbXUgY29kZS4NCj4+DQo+PiBUaGUgQ09ORklHX0lPTU1VRkQgb3B0
aW9uIG11c3QgYmUgc2V0IHRvIGNvbXBpbGUgdGhpcyBuZXcgb2JqZWN0Lg0KPj4NCj4+IFN1Z2dl
c3RlZC1ieTogQWxleCBXaWxsaWFtc29uIDxhbGV4LndpbGxpYW1zb25AcmVkaGF0LmNvbT4NCj4+
IFNpZ25lZC1vZmYtYnk6IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+IFNp
Z25lZC1vZmYtYnk6IFlpIExpdSA8eWkubC5saXVAaW50ZWwuY29tPg0KPj4gU2lnbmVkLW9mZi1i
eTogWmhlbnpob25nIER1YW4gPHpoZW56aG9uZy5kdWFuQGludGVsLmNvbT4NCj4+IFNpZ25lZC1v
ZmYtYnk6IEPDqWRyaWMgTGUgR29hdGVyIDxjbGdAcmVkaGF0LmNvbT4NCj4+IC0tLQ0KPj4gIE1B
SU5UQUlORVJTICAgICAgICAgICAgICB8ICAgNyArDQo+PiAgcWFwaS9xb20uanNvbiAgICAgICAg
ICAgIHwgIDIwICsrKw0KPj4gIGluY2x1ZGUvc3lzZW11L2lvbW11ZmQuaCB8ICA0NiArKysrKysr
DQo+PiAgYmFja2VuZHMvaW9tbXVmZC1zdHViLmMgIHwgIDU5ICsrKysrKysrKw0KPj4gIGJhY2tl
bmRzL2lvbW11ZmQuYyAgICAgICB8IDI2OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysNCj4+ICBiYWNrZW5kcy9LY29uZmlnICAgICAgICAgfCAgIDQgKw0KPj4gIGJhY2tl
bmRzL21lc29uLmJ1aWxkICAgICB8ICAgNSArDQo+PiAgYmFja2VuZHMvdHJhY2UtZXZlbnRzICAg
IHwgIDEyICsrDQo+PiAgcWVtdS1vcHRpb25zLmh4ICAgICAgICAgIHwgIDEzICsrDQo+PiAgOSBm
aWxlcyBjaGFuZ2VkLCA0MzQgaW5zZXJ0aW9ucygrKQ0KPj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBp
bmNsdWRlL3N5c2VtdS9pb21tdWZkLmgNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYmFja2VuZHMv
aW9tbXVmZC1zdHViLmMNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQgYmFja2VuZHMvaW9tbXVmZC5j
DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL01BSU5UQUlORVJTIGIvTUFJTlRBSU5FUlMNCj4+IGluZGV4
IDdmOTkxMmJhYTAuLjdhYTU3YWIxNmYgMTAwNjQ0DQo+PiAtLS0gYS9NQUlOVEFJTkVSUw0KPj4g
KysrIGIvTUFJTlRBSU5FUlMNCj4+IEBAIC0yMTA5LDYgKzIxMDksMTMgQEAgRjogaHcvdmZpby9h
cC5jDQo+PiAgRjogZG9jcy9zeXN0ZW0vczM5MHgvdmZpby1hcC5yc3QNCj4+ICBMOiBxZW11LXMz
OTB4QG5vbmdudS5vcmcNCj4+DQo+PiAraW9tbXVmZA0KPj4gK006IFlpIExpdSA8eWkubC5saXVA
aW50ZWwuY29tPg0KPj4gK006IEVyaWMgQXVnZXIgPGVyaWMuYXVnZXJAcmVkaGF0LmNvbT4NCj4+
ICtTOiBTdXBwb3J0ZWQNCj4+ICtGOiBiYWNrZW5kcy9pb21tdWZkLmMNCj4+ICtGOiBpbmNsdWRl
L3N5c2VtdS9pb21tdWZkLmgNCj4+ICsNCj4+ICB2aG9zdA0KPj4gIE06IE1pY2hhZWwgUy4gVHNp
cmtpbiA8bXN0QHJlZGhhdC5jb20+DQo+PiAgUzogU3VwcG9ydGVkDQo+PiBkaWZmIC0tZ2l0IGEv
cWFwaS9xb20uanNvbiBiL3FhcGkvcW9tLmpzb24NCj4+IGluZGV4IGM1M2VmOTc4ZmYuLmVmMGI1
MGYxMDcgMTAwNjQ0DQo+PiAtLS0gYS9xYXBpL3FvbS5qc29uDQo+PiArKysgYi9xYXBpL3FvbS5q
c29uDQo+PiBAQCAtNzk0LDYgKzc5NCwyMiBAQA0KPj4gIHsgJ3N0cnVjdCc6ICdWZmlvVXNlclNl
cnZlclByb3BlcnRpZXMnLA0KPj4gICAgJ2RhdGEnOiB7ICdzb2NrZXQnOiAnU29ja2V0QWRkcmVz
cycsICdkZXZpY2UnOiAnc3RyJyB9IH0NCj4+DQo+PiArIyMNCj4+ICsjIEBJT01NVUZEUHJvcGVy
dGllczoNCj4+ICsjDQo+PiArIyBQcm9wZXJ0aWVzIGZvciBpb21tdWZkIG9iamVjdHMuDQo+PiAr
Iw0KPj4gKyMgQGZkOiBmaWxlIGRlc2NyaXB0b3IgbmFtZSBwcmV2aW91c2x5IHBhc3NlZCB2aWEg
J2dldGZkJyBjb21tYW5kLA0KPj4gKyMgICAgIHdoaWNoIHJlcHJlc2VudHMgYSBwcmUtb3BlbmVk
IC9kZXYvaW9tbXUuIFRoaXMgYWxsb3dzIHRoZQ0KPg0KPlR3byBzcGFjZXMgYmV0d2VlbiBzZW50
ZW5jZXMgZm9yIGNvbnNpc3RlbmN5LCBwbGVhc2UuDQoNClByZXN1bWUgeW91IG1lYW4gIiAgJ2Rh
dGEnOiB7ICcqZmQnOiAnc3RyJyB9IH0iIGxpbmUsIG5vdCBhYm92ZSBsaW5lLg0KDQo+DQo+PiAr
IyAgICAgaW9tbXVmZCBvYmplY3QgdG8gYmUgc2hhcmVkIGFjY3Jvc3Mgc2V2ZXJhbCBzdWJzeXN0
ZW1zDQo+PiArIyAgICAgKFZGSU8sIFZEUEEsIC4uLikgYW5kIGZpbGUgZGVzY3JpcHRvciB0byBi
ZSBzaGFyZWQgd2l0aA0KPg0KPkNvbW1hIGJlZm9yZSAiYW5kIGZpbGUiLg0KPg0KPkVpdGhlciAi
dGhlIGZpbGUgZGVzY3JpcHRvciIsIG9yICJmaWxlIGRlc2NyaXB0b3JzIi4NCj4NCj4+ICsjICAg
ICBvdGhlciBwcm9jZXNzLCBlLmc6IERQREsuDQo+DQo+ZS5nLg0KPg0KPkFsdGVybmF0aXZlbHkg
InN1Y2ggYXMgRFBESy4iDQoNCldpbGwgZml4Lg0KDQo+DQo+PiArIw0KPj4gKyMgU2luY2U6IDgu
Mg0KPj4gKyMjDQo+PiAreyAnc3RydWN0JzogJ0lPTU1VRkRQcm9wZXJ0aWVzJywNCj4+ICsgICAg
ICAgICdkYXRhJzogeyAnKmZkJzogJ3N0cicgfSB9DQo+DQo+QGZkIGlzIG9wdGlvbmFsLiAgSG93
IGRvZXMgdGhlIGlvbW11ZmQgb2JqZWN0IGJlaGF2ZSB3aGVuIEBmZCBpcyBhYnNlbnQ/DQoNCklm
IG5vIGZkIGlzIHBhc3NlZCBhbG9uZyB3aXRoIHRoZSBpb21tdWZkIG9iamVjdCwgdGhlIC9kZXYv
aW9tbXUNCmlzIG9wZW5lZCBieSB0aGUgcWVtdSBjb2RlLiBMZXQgbWUga25vdyBpZiB0aGlzIGFs
c28gbmVlZHMgdG8gYmUgZG9jdW1lbnRlZC4NCg0KPg0KPj4gKw0KPj4gICMjDQo+PiAgIyBAUm5n
UHJvcGVydGllczoNCj4+ICAjDQo+PiBAQCAtOTM0LDYgKzk1MCw4IEBADQo+ICAgIyMNCj4gICAj
IEBPYmplY3RUeXBlOg0KPg0KPk5vbmUgb2YgdGhlIGVudW0gbWVtYmVycyBhcmUgZG9jdW1lbnRl
ZC4gIEknbSBub3QgYXNraW5nIHlvdSB0byBmaXggdGhhdA0KPm5vdy4NCj4NCj4gICAjDQo+ICAg
IyBGZWF0dXJlczoNCj4gICAjDQo+ICAgIyBAdW5zdGFibGU6IE1lbWJlciBAeC1yZW1vdGUtb2Jq
ZWN0IGlzIGV4cGVyaW1lbnRhbC4NCj4gICAjDQo+ICAgIyBTaW5jZTogNi4wDQo+ICAgIyMNCj4g
ICB7ICdlbnVtJzogJ09iamVjdFR5cGUnLA0KPiAgICAgJ2RhdGEnOiBbDQo+ICAgICAgIFsuLi5d
DQo+PiAgICAgICdpbnB1dC1iYXJyaWVyJywNCj4+ICAgICAgeyAnbmFtZSc6ICdpbnB1dC1saW51
eCcsDQo+PiAgICAgICAgJ2lmJzogJ0NPTkZJR19MSU5VWCcgfSwNCj4+ICsgICAgeyAnbmFtZSc6
ICdpb21tdWZkJywNCj4+ICsgICAgICAnaWYnOiAnQ09ORklHX0lPTU1VRkQnIH0sDQo+DQo+U2hv
dWxkIHN0cnVjdCBJT01NVUZEUHJvcGVydGllcyBhbHNvIGhhdmUgJ2lmJzogJ0NPTkZJR19JT01N
VUZEJz8NCg0KWWVzLCB0aGFua3MgZm9yIHBvaW50IG91dCwgd2lsbCBmaXguDQoNCkJScy4NClpo
ZW56aG9uZw0K

