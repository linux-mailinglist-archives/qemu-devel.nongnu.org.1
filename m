Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA078324C0
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 07:47:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQie8-000106-KS; Fri, 19 Jan 2024 01:46:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQie4-0000zs-0c; Fri, 19 Jan 2024 01:46:28 -0500
Received: from mgamail.intel.com ([198.175.65.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zhenzhong.duan@intel.com>)
 id 1rQidy-0006P0-FP; Fri, 19 Jan 2024 01:46:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1705646782; x=1737182782;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=DxKb7KqApw2RZZAiwViuZQFkFooNmeVlIhjR/XznbDQ=;
 b=YSppQ8ZFF/zCdY48NXj4Zqkl8c5PGO6DkFOe0fX9VmU0zcKx1Kqv7JZP
 bcVgC0t9ApA0ztEPNkw67Q0fUYXst1Ip2kX31zelcf6F7cvRdlyYgK5SY
 J2FfFJ0AKKJ+YXSrPCX4PlMU/jjwjMtqTchcLREe17uZ5nsjSOkWLXIoA
 g9NaPVjHsbY9WwmM9r0DuZ00Mg77obe1tBvie3B3McPAOgYp4yFLdLMm5
 gSp99nEyYJyFxK2creMQZbsc0c+Ymsqi6H90EvbWzl5oSbzf0Ebf7CooH
 g79TPvl2EekJkH71D+yFcIQKih5zWesHJ+KD5iCl/kv8uGsNPj+aDY5AY A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="8052832"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; 
   d="scan'208";a="8052832"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jan 2024 22:46:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10956"; a="1116178823"
X-IronPort-AV: E=Sophos;i="6.05,204,1701158400"; d="scan'208";a="1116178823"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384;
 18 Jan 2024 22:46:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 22:46:16 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 18 Jan 2024 22:46:15 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 18 Jan 2024 22:46:15 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 18 Jan 2024 22:46:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UQqNQzrddo7uAO4qCJkuT2TP3IuAIrwbegpyF6QVMXdpQJ+KFBCuJXKPWA/bttmEqrrrLmFT7of3UFR7+vFg+QQ+W6X5D3H4EZnmyoxwiIB/bqGowyRjdyGPHKzNQFMDYUhSYhTDS9GfglFtTjOnynP1r0b03/rbusLKTqbNAghkYuCRBbNTft4Iu7f8mCQTvhQoXvoNDWtvNV0WVohEAJAijNXeqtTlBr+56gjUrskL0LU0Pp2ScAB4fkQqnAqz3kWusoLnMhq/H9RRxL/7HqrkjCRBheJEI2ZlBeGb4LHgqkEhKb6nZDEx2KOCtjoBvd/J2d5KZwzN0ggkJXN0nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DxKb7KqApw2RZZAiwViuZQFkFooNmeVlIhjR/XznbDQ=;
 b=V951Jokh1fq8Ve09DVOauZGPoQ4I14Ej4LOspC8wzG16BdYVyHPFVH4MRCyQFONoTpB2riyzyBuD7M6xJxUslR9OJBrFPCpY596mHr2y6H3R1hB6NsjG4GuDvNXlEDrZrjl+8CULWhog5IDSQiMDpCfdj5Nr1FOpLzdRiH8hIWbXIw6y7nAeQ3fgvk6RZIHft73aTGhj7otRJgdmGEpU3XIF0iuddisp9UceI8I+CFb+aXMfFDHiF+es60WnVHMfWvREuSrF+rkk/eU74xNAYokEFcQPm8RmX75ZTIjvVapooZt5zBUZWH8O6KFbT7NAz4xkeJNYftLJ/KpKuCcszQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com (2603:10b6:a03:47d::10)
 by PH7PR11MB5818.namprd11.prod.outlook.com (2603:10b6:510:132::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Fri, 19 Jan
 2024 06:46:01 +0000
Received: from SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace]) by SJ0PR11MB6744.namprd11.prod.outlook.com
 ([fe80::88e9:5716:274c:5ace%5]) with mapi id 15.20.7202.024; Fri, 19 Jan 2024
 06:46:01 +0000
From: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>
To: "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>, "jean-philippe@linaro.org" <jean-philippe@linaro.org>, 
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>, "peterx@redhat.com"
 <peterx@redhat.com>, "yanghliu@redhat.com" <yanghliu@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "mst@redhat.com" <mst@redhat.com>, "clg@redhat.com" <clg@redhat.com>
Subject: RE: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling for
 hotplugged devices
Thread-Topic: [RFC 0/7] VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
 for hotplugged devices
Thread-Index: AQHaSRvYYeFgLORM0EqKETYNluqp/7DfAs3wgABQr4CAAV77UA==
Date: Fri, 19 Jan 2024 06:46:01 +0000
Message-ID: <SJ0PR11MB67444B320AFCF516B0DB5F7D92702@SJ0PR11MB6744.namprd11.prod.outlook.com>
References: <20240117080414.316890-1-eric.auger@redhat.com>
 <SJ0PR11MB6744C50921CC63221A93C75492712@SJ0PR11MB6744.namprd11.prod.outlook.com>
 <7bc955a1-f58d-43b1-8e95-c452bb11f208@redhat.com>
In-Reply-To: <7bc955a1-f58d-43b1-8e95-c452bb11f208@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR11MB6744:EE_|PH7PR11MB5818:EE_
x-ms-office365-filtering-correlation-id: 0884f35e-d724-4bed-0cdb-08dc18ba4d01
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v3U1olZ22RBqDSinZ3FU+RWkgRumT81ZiYZXUmvIYzjjNGJnfaX09jo9xFxk39eKzYtgOKFugRTPHL4bhHB1W0OR/xVRlJGFfJwSkhOCPN1Pbnq7wWbTNdI9Lb8lfaoUJreTulbbNldbw3nv2QPzIKUdfcklWI1aqNf8XVbWKZHdcO9llHgy4z4FzD6eKkoUQlaJ3llAgpnYJ6wUDPrw/3sgs1kuXBcz/A0Ot469MnYUFSmJ4ls0bza1/zf52Jx+b6/Nb4SPhM1FOJ4igAxRa08CaVG3wcXdHQW3rx4gLH46IGyUe6pckp3VN3c6QXRfzdo791kjLCzjgRUQMjXRZrtZPTvEUVlfg6rrHI7Hvbt5LJjBHFsoHSTTTYT3zFHtDykftCE6HzrorNhCEouHwwbiSweEfAA9Y2419dS3un45Z3HPguDNsUSpebzjCCb5T01qgtTSPiBdfv0wwMqreaZ/FVmKHKHVgNIaJcGameIIM9n/GbQXC4fjxA3IdhyRH1lWInECK0ejp1cv6iNU7CKM299FAo51AocBi4r2VVY88Nb5EnFghxoBHOhARrQODMQX8LtQLzOck5yUxPizU1n2Z1xJt+CQoPsn2v3KaV7u270nReWi+r00SWsRtLPIFZGlCw1aUkswsAoaLOtBCFpEwwOf3cdg2seC8LKzMUo=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR11MB6744.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(366004)(376002)(396003)(39860400002)(136003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(966005)(478600001)(71200400001)(4326008)(83380400001)(33656002)(86362001)(41300700001)(38070700009)(66446008)(8676002)(66556008)(52536014)(82960400001)(76116006)(54906003)(8936002)(110136005)(5660300002)(64756008)(2906002)(7416002)(316002)(122000001)(66476007)(66946007)(38100700002)(26005)(921011)(55016003)(9686003)(7696005)(6506007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Z090eVpnRlVqL2xLaFMvVmJxbjB0UElGaDZCOUpVcjRYaGlrc1hRdFF4Yld6?=
 =?utf-8?B?cklsUHF0WlpxREcwTXFRem1TcEdhUHA3M0pqZkZTazV6d1JrZ1Zpb29rUU1S?=
 =?utf-8?B?RVJYcGlsM0k5TmFLY2pUY0QvaTQ4R01EQWliZFVMcXU5aDF1OVphSi84SElw?=
 =?utf-8?B?UkpWREdsZ0svS2k5QTFMcGVrNWdWazQxclpvSCtUL0VtVVdWV2ZZRktwMFgv?=
 =?utf-8?B?VFB2Y2ZqZ213dkQwKzB5ck9tcTI0K3VQWWt5V2Y0UHE4dkdPTm5WczhaOGtJ?=
 =?utf-8?B?Qnl1S25aelBCNGQzajdla0doZDJyZG8wb0doVVZNVTNESVMrOUVnUVNpT0w1?=
 =?utf-8?B?VnZDMy9nWXkwMHlidHd0U3J2bStGamRzb0pzS2ZscVFpaGp0L3pVV1A2RmEx?=
 =?utf-8?B?Q3VzSG9NQkVIWVE0c2NTZDkvK0RhRmZnSEQ5TG5EVzlKZWowa0dQQTB3dFlL?=
 =?utf-8?B?SHpyM1lzcy9URWNiV0h4alNRZ3djbXZYSTIzNE43N0x2UUhqaHRqQ25nUll5?=
 =?utf-8?B?emN2ZFIyc2FoRi9HNSs5dmZHSDA4Vk9peDhNTG9CbXJJZFZURVBrL0puTFdL?=
 =?utf-8?B?RmU5RUI3WlRkVHE2NXNjUHJ0QkdJZ2ltN3lRd0Z4UGxPY1hmT0RGZld0VWVR?=
 =?utf-8?B?RjVrRGJhQkRIdTVkZTdWdUlCeVlxTmw3TGdBanhiSDNpOVRuYVV2NXhVZ0t3?=
 =?utf-8?B?SVVOejkxRnUrbllvVTZpRHBRNVVQaEFLRGZpTU1HWXRtaGhTeE83TUk3MXg1?=
 =?utf-8?B?QmNqUzhRYktVSVNrT2kzUG51ZWJxakl0REUwSjhaRXR4K1U2aWxhMEJGRGw3?=
 =?utf-8?B?RkRmUG1UQVZtb1FxdkZ2TEovbjJobHVBZkY0c0kxNmhLVG9YZ0dHUXFyZVVm?=
 =?utf-8?B?bjZHV2Q3Z3hPZ04vUFBCbGZVeTdTeTNNZVZFMERMOGhzUzdqazZra2o1ZFVO?=
 =?utf-8?B?RWhKZHlaVDRMWlJZZFBDSHFtQlgxKy9lUENLTWNSY1B5dzVoc0pBN1g0aFNM?=
 =?utf-8?B?eGdjejRLRS9EK1J0S2lzSEpvWHNJQ2crTEFIbWwwd24xQXBFd2o3dDd5TERx?=
 =?utf-8?B?SU5IQzF6eVhPQzRsWjlGWGVKVDFkYXoyNDZScDZSTDdjUG5CYmg1M1U5SnFE?=
 =?utf-8?B?ZHhabU52dmUzWjU2U1YwZ3Z5VGRtZUNrdTVmNDByNW9ybHVqVDlIcDYrR0po?=
 =?utf-8?B?QkRnbXFiZm5zeDE1UDIxbWdvVTJBMERpbTVtMHN5b0QySlNubjVmbjl3ZnVQ?=
 =?utf-8?B?L0FQQ2tkek5aMzJwU1M3ZGcxMm1YeExQOTh2ZGNkMFBKekFOZ05OVDhLV1py?=
 =?utf-8?B?ZU13WWk1TVAvS3NObUNsZUNBUnNjUU0vM1BYVUJJTTFlQ2RWVkdmTFpzUlhq?=
 =?utf-8?B?YUNoUmpmR2dwOTd4bEh1SHducHUvU0VpOHFjR0dDVXgxU1dqbGpGMi9VcVFo?=
 =?utf-8?B?V1JRSWszT3AxVlJrN2NHOU54S2VkNE0zeGJVeHVVNjFRMWh1enQ2TnMzOUtv?=
 =?utf-8?B?SzBkeUJZVTh1SVRKbTYySm1WZnhpemlKN3kvd3Jsd3NEWFI1L0xTcXhSTWxi?=
 =?utf-8?B?bnhDaU9JdjJhdk94eGszQ1o5c3dtdWhUdzRiRmdyQS9INi9RMXp4d3BOYmsy?=
 =?utf-8?B?Y3ZaRERESitMdC8vTVRvbXhWNGNqT1lVYTk3UUI3b0NJdkI0QUlKZGVXQVFJ?=
 =?utf-8?B?eFA5eU1EbGJBZEM0dmR1T1h3Y2tWbUxsZGx6TzZWYkx4YTJoL3YydjFTdE1X?=
 =?utf-8?B?aHNNVkI1UVp5WmVpUUErM2M0Yk81bHpGN0pvNlFQK0dsdmQzSFZkV3pSNHh3?=
 =?utf-8?B?QW40ZkNmMXVFNU4xUm1RVFNoYlhJN1kyVVl5R0lZM2trTzNvME9aUHdZbDhi?=
 =?utf-8?B?MStZT2cwazUxdHl2Nmd4UDlRdlBrZzZSY2hwb0JjRG53V0taRm9NaXNLRndH?=
 =?utf-8?B?MGk4UUdza3grRkVkN0huNEp2ZWZSUWhTQUYxN28vMExnam1FQWlBWkt6TUVM?=
 =?utf-8?B?bWVJd0NCMWY1MklNYmEyMVRmWk4xODZnYm8zL2dBaUpHOHQvcWJRaFJ6QTZP?=
 =?utf-8?B?V1lwQmpiVkUyZlBlMFo1Q3FVNGNFMG9EbmJkaWloUFBBcm9pQVdVSUI3NEZV?=
 =?utf-8?Q?+EFDS91Q6ZWTWktjKCctIK+Zh?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB6744.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0884f35e-d724-4bed-0cdb-08dc18ba4d01
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2024 06:46:01.4645 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: F5jcqGVb35CtUfhWkbj5qD+AFrkixFevAk9vCRvXvIp2QM8bP18WlBeJneoerG0iS89noX08HDU8Y4tYDXFrPbSpm+k9OvFs0M9L3qYR8Y4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5818
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=198.175.65.12;
 envelope-from=zhenzhong.duan@intel.com; helo=mgamail.intel.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

DQoNCj4tLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPkZyb206IEVyaWMgQXVnZXIgPGVyaWMu
YXVnZXJAcmVkaGF0LmNvbT4NCj5TdWJqZWN0OiBSZTogW1JGQyAwLzddIFZJUlRJTy1JT01NVS9W
RklPOiBGaXggaG9zdCBpb21tdSBnZW9tZXRyeQ0KPmhhbmRsaW5nIGZvciBob3RwbHVnZ2VkIGRl
dmljZXMNCj4NCj5IaSBaaGVuemhvbmcsDQo+T24gMS8xOC8yNCAwODoxMCwgRHVhbiwgWmhlbnpo
b25nIHdyb3RlOg0KPj4gSGkgRXJpYywNCj4+DQo+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0t
LS0NCj4+PiBGcm9tOiBFcmljIEF1Z2VyIDxlcmljLmF1Z2VyQHJlZGhhdC5jb20+DQo+Pj4gQ2M6
IG1zdEByZWRoYXQuY29tOyBjbGdAcmVkaGF0LmNvbQ0KPj4+IFN1YmplY3Q6IFtSRkMgMC83XSBW
SVJUSU8tSU9NTVUvVkZJTzogRml4IGhvc3QgaW9tbXUgZ2VvbWV0cnkNCj5oYW5kbGluZw0KPj4+
IGZvciBob3RwbHVnZ2VkIGRldmljZXMNCj4+Pg0KPj4+IEluIFsxXSB3ZSBhdHRlbXB0ZWQgdG8g
Zml4IGEgY2FzZSB3aGVyZSBhIFZGSU8tUENJIGRldmljZSBwcm90ZWN0ZWQNCj4+PiB3aXRoIGEg
dmlydGlvLWlvbW11IHdhcyBhc3NpZ25lZCB0byBhbiB4ODYgZ3Vlc3QuIE9uIHg4NiB0aGUgcGh5
c2ljYWwNCj4+PiBJT01NVSBtYXkgaGF2ZSBhbiBhZGRyZXNzIHdpZHRoIChnYXcpIG9mIDM5IG9y
IDQ4IGJpdHMgd2hlcmVhcyB0aGUNCj4+PiB2aXJ0aW8taW9tbXUgdXNlZCB0byBleHBvc2UgYSA2
NGIgYWRkcmVzcyBzcGFjZSBieSBkZWZhdWx0Lg0KPj4+IEhlbmNlIHRoZSBndWVzdCB3YXMgdHJ5
aW5nIHRvIHVzZSB0aGUgZnVsbCA2NGIgc3BhY2UgYW5kIHdlIGhpdA0KPj4+IERNQSBNQVAgZmFp
bHVyZXMuIFRvIHdvcmsgYXJvdW5kIHRoaXMgaXNzdWUgd2UgbWFuYWdlZCB0byBwYXNzDQo+Pj4g
dXNhYmxlIElPVkEgcmVnaW9ucyAoZXhjbHVkaW5nIHRoZSBvdXQgb2YgcmFuZ2Ugc3BhY2UpIGZy
b20gVkZJTw0KPj4+IHRvIHRoZSB2aXJ0aW8taW9tbXUgZGV2aWNlLiBUaGlzIHdhcyBtYWRlIGZl
YXNpYmxlIGJ5IGludHJvZHVjaW5nDQo+Pj4gYSBuZXcgSU9NTVUgTWVtb3J5IFJlZ2lvbiBjYWxs
YmFjayBkdWJiZWQNCj5pb21tdV9zZXRfaW92YV9yZWdpb25zKCkuDQo+Pj4gVGhpcyBsYXR0ZXIg
Z2V0cyBjYWxsZWQgd2hlbiB0aGUgSU9NTVUgTVIgaXMgZW5hYmxlZCB3aGljaA0KPj4+IGNhdXNl
cyB0aGUgdmZpb19saXN0ZW5lcl9yZWdpb25fYWRkKCkgdG8gYmUgY2FsbGVkLg0KPj4+DQo+Pj4g
SG93ZXZlciB3aXRoIFZGSU8tUENJIGhvdHBsdWcsIHRoaXMgdGVjaG5pcXVlIGZhaWxzIGR1ZSB0
byB0aGUNCj4+PiByYWNlIGJldHdlZW4gdGhlIGNhbGwgdG8gdGhlIGNhbGxiYWNrIGluIHRoZSBh
ZGQgbWVtb3J5IGxpc3RlbmVyDQo+Pj4gYW5kIHRoZSB2aXJ0aW8taW9tbXUgcHJvYmUgcmVxdWVz
dC4gSW5kZWVkIHRoZSBwcm9iZSByZXF1ZXN0IGdldHMNCj4+PiBjYWxsZWQgYmVmb3JlIHRoZSBh
dHRhY2ggdG8gdGhlIGRvbWFpbi4gU28gaW4gdGhhdCBjYXNlIHRoZSB1c2FibGUNCj4+PiByZWdp
b25zIGFyZSBjb21tdW5pY2F0ZWQgYWZ0ZXIgdGhlIHByb2JlIHJlcXVlc3QgYW5kIGZhaWwgdG8g
YmUNCj4+PiBjb252ZXllZCB0byB0aGUgZ3Vlc3QuIFRvIGJlIGhvbmVzdCB0aGUgcHJvYmxlbSB3
YXMgaGludGVkIGJ5DQo+Pj4gSmVhbi1QaGlsaXBwZSBpbiBbMV0gYW5kIEkgc2hvdWxkIGhhdmUg
YmVlbiBtb3JlIGNhcmVmdWwgYXQNCj4+PiBsaXN0ZW5pbmcgdG8gaGltIGFuZCB0ZXN0aW5nIHdp
dGggaG90cGx1ZyA6LSgNCj4+IEl0IGxvb2tzIHRoZSBnbG9iYWwgdmlydGlvX2lvbW11X2NvbmZp
Zy5ieXBhc3MgaXMgbmV2ZXIgY2xlYXJlZCBpbiBndWVzdC4NCj4+IFdoZW4gZ3Vlc3QgdmlydGlv
X2lvbW11IGRyaXZlciBlbmFibGUgSU9NTVUsIHNob3VsZCBpdCBjbGVhciB0aGlzDQo+PiBieXBh
c3MgYXR0cmlidXRlPw0KPj4gSWYgaXQgY291bGQgYmUgY2xlYXJlZCBpbiB2aW9tbXVfcHJvYmUo
KSwgdGhlbiBxZW11IHdpbGwgY2FsbA0KPj4gdmlydGlvX2lvbW11X3NldF9jb25maWcoKSB0aGVu
IHZpcnRpb19pb21tdV9zd2l0Y2hfYWRkcmVzc19zcGFjZV9hbGwoKQ0KPj4gdG8gZW5hYmxlIElP
TU1VIE1SLiBUaGVuIGJvdGggY29sZHBsdWdnZWQgYW5kIGhvdHBsdWdnZWQgZGV2aWNlcyB3aWxs
DQo+d29yay4NCj4NCj50aGlzIGZpZWxkIGlzIGlvbW11IHdpZGUgd2hpbGUgdGhlIHByb2JlIGFw
cGxpZXMgb24gYSBvbmUgZGV2aWNlLkluDQo+Z2VuZXJhbCBJIHdvdWxkIHByZWZlciBub3QgdG8g
YmUgZGVwZW5kZW50IG9uIHRoZSBNUiBlbmFibGVtZW50LiBXZSBrbm93DQo+dGhhdCB0aGUgZGV2
aWNlIGlzIGxpa2VseSB0byBiZSBwcm90ZWN0ZWQgYW5kIHdlIGNhbiBjb2xsZWN0IGl0cw0KPnJl
cXVpcmVtZW50cyBiZWZvcmVoYW5kLgkNCg0KQWdyZWUgdGhhdCB5b3VyIG5ldyBwYXRjaCBpcyBj
bGVhbmVyLg0KDQo+Pg0KPj4gSW50ZWwgaW9tbXUgaGFzIGEgc2ltaWxhciBiaXQgaW4gcmVnaXN0
ZXIgR0NNRF9SRUcuVEUsIHdoZW4gZ3Vlc3QNCj4+IGludGVsX2lvbW11IGRyaXZlciBwcm9iZSBz
ZXQgaXQsIG9uIHFlbXUgc2lkZSwNCj52dGRfYWRkcmVzc19zcGFjZV9yZWZyZXNoX2FsbCgpDQo+
PiBpcyBjYWxsZWQgdG8gZW5hYmxlIElPTU1VIE1Scy4NCj5pbnRlcmVzdGluZy4NCj4NCj5Xb3Vs
ZCBiZSBjdXJpb3VzIHRvIGdldCBKZWFuIFBoaWxpcHBlJ3MgcG92Lg0KPj4NCj4+PiBGb3IgY29s
ZHBsdWdnZWQgZGV2aWNlIHRoZSB0ZWNobmlxdWUgd29ya3MgYmVjYXVzZSB3ZSBtYWtlIHN1cmUg
YWxsDQo+Pj4gdGhlIElPTU1VIE1SIGFyZSBlbmFibGVkIG9uY2Ugb24gdGhlIG1hY2hpbmUgaW5p
dCBkb25lOiA5NGRmNWIyMTgwDQo+Pj4gKCJ2aXJ0aW8taW9tbXU6IEZpeCA2NGtCIGhvc3QgcGFn
ZSBzaXplIFZGSU8gZGV2aWNlIGFzc2lnbm1lbnQiKQ0KPj4+IGZvciBncmFudWxlIGZyZWV6ZS4g
QnV0IEkgd291bGQgYmUga2VlbiB0byBnZXQgcmlkIG9mIHRoaXMgdHJpY2suDQo+Pj4NCj4+PiBV
c2luZyBhbiBJT01NVSBNUiBPcHMgaXMgdW5wcmFjdGljYWwgYmVjYXVzZSB0aGlzIHJlbGllcyBv
biB0aGUNCj5JT01NVQ0KPj4+IE1SIHRvIGhhdmUgYmVlbiBlbmFibGVkIGFuZCB0aGUgY29ycmVz
cG9uZGluZw0KPnZmaW9fbGlzdGVuZXJfcmVnaW9uX2FkZCgpDQo+Pj4gdG8gYmUgZXhlY3V0ZWQu
IEluc3RlYWQgdGhpcyBzZXJpZXMgcHJvcG9zZXMgdG8gcmVwbGFjZSB0aGUgdXNhZ2Ugb2YgdGhp
cw0KPj4+IEFQSSBieSB0aGUgcmVjZW50bHkgaW50cm9kdWNlZCBQQ0lJT01NVU9wczogYmE3ZDEy
ZWI4YyAgKCJody9wY2k6DQo+Pj4gbW9kaWZ5DQo+Pj4gcGNpX3NldHVwX2lvbW11KCkgdG8gc2V0
IFBDSUlPTU1VT3BzIikuIFRoYXQgd2F5LCB0aGUgY2FsbGJhY2sgY2FuIGJlDQo+Pj4gY2FsbGVk
IGVhcmxpZXIsIG9uY2UgdGhlIHVzYWJsZSBJT1ZBIHJlZ2lvbnMgaGF2ZSBiZWVuIGNvbGxlY3Rl
ZCBieQ0KPj4+IFZGSU8sIHdpdGhvdXQgdGhlIG5lZWQgZm9yIHRoZSBJT01NVSBNUiB0byBiZSBl
bmFibGVkLg0KPj4+DQo+Pj4gVGhpcyBsb29rcyBjbGVhbmVyLiBJbiB0aGUgc2hvcnQgdGVybSB0
aGlzIG1heSBhbHNvIGJlIHVzZWQgZm9yDQo+Pj4gcGFzc2luZyB0aGUgcGFnZSBzaXplIG1hc2ss
IHdoaWNoIHdvdWxkIGFsbG93IHRvIGdldCByaWQgb2YgdGhlDQo+Pj4gaGFja3kgdHJhbnNpZW50
IElPTU1VIE1SIGVuYWJsZW1lbnQgbWVudGlvbm5lZCBhYm92ZS4NCj4+Pg0KPj4+IFsxXSBbUEFU
Q0ggdjQgMDAvMTJdIFZJUlRJTy1JT01NVS9WRklPOiBEb24ndCBhc3N1bWUgNjRiIElPVkENCj5z
cGFjZQ0KPj4+ICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMTAxOTEzNDY1MS44
NDIxNzUtMS0NCj4+PiBlcmljLmF1Z2VyQHJlZGhhdC5jb20vDQo+Pj4NCj4+PiBbMl0gaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwOTI5MTYxNTQ3LkdCMjk1NzI5N0BteXJpY2EvDQo+
Pj4NCj4+PiBFeHRyYSBOb3RlczoNCj4+PiBXaXRoIHRoYXQgc2VyaWVzLCB0aGUgcmVzZXJ2ZWQg
bWVtb3J5IHJlZ2lvbnMgYXJlIGNvbW11bmljYXRlZCBvbg0KPnRpbWUNCj4+PiBzbyB0aGF0IHRo
ZSB2aXJ0aW8taW9tbXUgcHJvYmUgcmVxdWVzdCBncmFicyB0aGVtLiBIb3dldmVyIHRoaXMgaXMg
bm90DQo+Pj4gc3VmZmljaWVudC4gSW4gc29tZSBjYXNlcyAobXkgY2FzZSksIEkgc3RpbGwgc2Vl
IHNvbWUgRE1BIE1BUCBmYWlsdXJlcw0KPj4+IGFuZCB0aGUgZ3Vlc3Qga2VlcHMgb24gdXNpbmcg
SU9WQSByYW5nZXMgb3V0c2lkZSB0aGUgZ2VvbWV0cnkgb2YgdGhlDQo+Pj4gcGh5c2ljYWwgSU9N
TVUuIFRoaXMgaXMgZHVlIHRvIHRoZSBmYWN0IHRoZSBWRklPLVBDSSBkZXZpY2UgaXMgaW4gdGhl
DQo+Pj4gc2FtZSBpb21tdSBncm91cCBhcyB0aGUgcGNpZSByb290IHBvcnQuIE5vcm1hbGx5IHRo
ZSBrZXJuZWwNCj4+PiBpb3ZhX3Jlc2VydmVfaW9tbXVfcmVnaW9ucyAoZG1hLWlvbW11LmMpIGlz
IHN1cHBvc2VkIHRvIGNhbGwNCj4+PiByZXNlcnZlX2lvdmEoKQ0KPj4+IGZvciBlYWNoIHJlc2Vy
dmVkIElPVkEsIHdoaWNoIGNhcnZlcyB0aGVtIG91dCBvZiB0aGUgYWxsb2NhdG9yLiBXaGVuDQo+
Pj4gaW9tbXVfZG1hX2luaXRfZG9tYWluKCkgZ2V0cyBjYWxsZWQgZm9yIHRoZSBob3RwbHVnZ2Vk
IHZmaW8tcGNpIGRldmljZQ0KPj4+IHRoZSBpb3ZhIGRvbWFpbiBpcyBhbHJlYWR5IGFsbG9jYXRl
ZCBhbmQgc2V0IGFuZCB3ZSBkb24ndCBjYWxsDQo+Pj4gaW92YV9yZXNlcnZlX2lvbW11X3JlZ2lv
bnMoKSBhZ2FpbiBmb3IgdGhlIHZmaW8tcGNpIGRldmljZS4gU28gaXRzDQo+Pj4gY29ycmVzcG9u
ZGluZyByZXNlcnZlZCByZWdpb25zIGFyZSBub3QgcHJvcGVybHkgdGFrZW4gaW50byBhY2NvdW50
Lg0KPj4gSSBzdXNwZWN0IHRoZXJlIGlzIHNhbWUgaXNzdWUgd2l0aCBjb2xkcGx1Z2dlZCBkZXZp
Y2VzLiBJZiB0aG9zZSBkZXZpY2VzDQo+PiBhcmUgaW4gc2FtZSBncm91cCwgZ2V0IGlvdmFfcmVz
ZXJ2ZV9pb21tdV9yZWdpb25zKCkgaXMgb25seSBjYWxsZWQNCj4+IGZvciBmaXJzdCBkZXZpY2Uu
IEJ1dCBvdGhlciBkZXZpY2VzJ3MgcmVzZXJ2ZWQgcmVnaW9ucyBhcmUgbWlzc2VkLg0KPg0KPkNv
cnJlY3QNCj4+DQo+PiBDdXJpb3VzIGhvdyB5b3UgbWFrZSBwYXNzdGhyb3VnaCBkZXZpY2UgYW5k
IHBjaWUgcm9vdCBwb3J0IHVuZGVyIHNhbWUNCj4+IGdyb3VwLg0KPj4gV2hlbiBJIHN0YXJ0IGEg
eDg2IGd1ZXN0IHdpdGggcGFzc3Rocm91Z2ggZGV2aWNlLCBJIHNlZSBwYXNzdGhyb3VnaA0KPj4g
ZGV2aWNlIGFuZCBwY2llIHJvb3QgcG9ydCBhcmUgaW4gZGlmZmVyZW50IGdyb3VwLg0KPj4NCj4+
IC1bMDAwMDowMF0tKy0wMC4wDQo+PiAgICAgICAgICAgICstMDEuMA0KPj4gICAgICAgICAgICAr
LTAyLjANCj4+ICAgICAgICAgICAgKy0wMy4wLVswMV0tLS0tMDAuMA0KPj4NCj4+IC9zeXMva2Vy
bmVsL2lvbW11X2dyb3Vwcy8zL2RldmljZXM6DQo+PiAwMDAwOjAwOjAzLjANCj4+IC9zeXMva2Vy
bmVsL2lvbW11X2dyb3Vwcy83L2RldmljZXM6DQo+PiAwMDAwOjAxOjAwLjANCj4+DQo+PiBNeSBx
ZW11IGNtZGxpbmU6DQo+PiAtZGV2aWNlIHBjaWUtcm9vdC1wb3J0LGlkPXJvb3QwLHNsb3Q9MA0K
Pj4gLWRldmljZSB2ZmlvLXBjaSxob3N0PTZmOjAxLjAsaWQ9dmZpbzAsYnVzPXJvb3QwDQo+DQo+
SSBqdXN0IHJlcGxheWVkIHRoZSBzY2VuYXJpbzoNCj4tIGlmIHlvdSBoYXZlIGEgY29sZHBsdWdn
ZWQgdmZpby1wY2kgZGV2aWNlLCB0aGUgcGNpIHJvb3QgcG9ydCBhbmQgdGhlDQo+cGFzc3Rocm91
Z2hlZCBkZXZpY2UgZW5kIHVwIGluIGRpZmZlcmVudCBpb21tdSBncm91cHMuIE9uIG15IGVuZCBJ
IHVzZQ0KPmlvaDM0MjAgYnV0IHlvdSBjb25maXJtZWQgdGhhdCdzIHRoZSBzYW1lIGZvciB0aGUg
Z2VuZXJpYyBwY2llLXJvb3QtcG9ydA0KPi0gaG93ZXZlciBpZiB5b3UgaG90cGx1ZyB0aGUgdmZp
by1wY2kgZGV2aWNlIHRoYXQncyBhIGRpZmZlcmVudCBzdG9yeToNCj50aGV5IGVuZCB1cCBpbiB0
aGUgc2FtZSBncm91cC4gRG9uJ3QgYXNrIG1lIHdoeS4gSSB0cmllZCB3aXRoDQo+Ym90aCB2aXJ0
aW8taW9tbXUgYW5kIGludGVsIGlvbW11IGFuZCBJIGVuZCB1cCB3aXRoIHRoZSBzYW1lIHRvcG9s
b2d5Lg0KPlRoYXQgbG9va3MgcmVhbGx5IHdlaXJkIHRvIG1lLg0KDQpUaGF0J3Mgc3RyYW5nZS4g
SSB0ZXN0ZWQgdHdvIHZmaW8gZGV2aWNlcyB3aXRoIGlvaDM0MjAsIG9uZSBjb2xkcGx1ZywgdGhl
IG90aGVyIGhvdHBsdWcuDQppb2gzNDIwIGFuZCB2ZmlvIGRldmljZXMgYXJlIGluIHNhbWUgZ3Jv
dXAuDQoNCi1bMDAwMDowMF0tKy0wMC4wDQogICAgICAgICAgICstMDEuMA0KICAgICAgICAgICAr
LTAyLjANCiAgICAgICAgICAgKy0wMy4wLVswMV0tLS0tMDAuMA0KICAgICAgICAgICArLTA0LjAt
WzAyXS0tLS0wMC4wDQoNCi9zeXMva2VybmVsL2lvbW11X2dyb3Vwcy8zL2RldmljZXM6DQowMDAw
OjAwOjAzLjAgIDAwMDA6MDE6MDAuMA0KDQovc3lzL2tlcm5lbC9pb21tdV9ncm91cHMvNC9kZXZp
Y2VzOg0KMDAwMDowMDowNC4wICAwMDAwOjAyOjAwLjANCg0KVGhhbmtzDQpaaGVuemhvbmcNCg0K
Pg0KPkkgaW5pdGlhbGx5IHRob3VnaHQgdGhpcyB3YXMgYW4gQUNTIGlzc3VlIGJ1dCBJIGFtIG5v
dyBwdXp6bGVkLg0KPg0KPlRoYW5rcyENCj4NCj5FcmljDQo+Pg0KPj4gVGhhbmtzDQo+PiBaaGVu
emhvbmcNCj4+DQo+Pj4gVGhpcyBpcyBub3QgdHJpdmlhbCB0byBmaXggYmVjYXVzZSB0aGVvcmV0
aWNhbGx5IHRoZSAxc3QgYXR0YWNoZWQNCj4+PiBkZXZpY2VzIGNvdWxkIGFscmVhZHkgaGF2ZSBh
bGxvY2F0ZWQgSU9WQXMgd2l0aGluIHRoZSByZXNlcnZlZCByZWdpb25zDQo+Pj4gb2YgdGhlIHNl
Y29uZCBkZXZpY2UuIEFsc28gd2UgYXJlIHNvbWVob3cgaGlqYWNraW5nIHRoZSByZXNlcnZlZA0K
Pj4+IG1lbW9yeSByZWdpb25zIHRvIG1vZGVsIHRoZSBnZW9tZXRyeSBvZiB0aGUgcGh5c2ljYWwg
SU9NTVUgc28gbm90DQo+c3VyZQ0KPj4+IGFueSBhdHRlbXB0IHRvIGZpeCB0aGF0IHVwc3RyZWFt
IHdpbGwgYmUgYWNjZXB0ZWQuIEF0IHRoZSBtb21lbnQgb25lDQo+Pj4gc29sdXRpb24gaXMgdG8g
bWFrZSBzdXJlIGFzc2lnbmVkIGRldmljZXMgZW5kIHVwIGluIHNpbmdsZXRvbiBncm91cC4NCj4+
PiBBbm90aGVyIHNvbHV0aW9uIGlzIHRvIHdvcmsgb24gYSBkaWZmZXJlbnQgYXBwcm9hY2ggd2hl
cmUgdGhlIGdhdw0KPj4+IGNhbiBiZSBwYXNzZWQgYXMgYW4gb3B0aW9uIHRvIHRoZSB2aXJ0aW8t
aW9tbXUgZGV2aWNlLCBzaW1pbGFybHkgYXQNCj4+PiB3aGF0IGlzIGRvbmUgd2l0aCBpbnRlbCBp
b21tdS4NCj4+Pg0KPj4+IFRoaXMgc2VyaWVzIGNhbiBiZSBmb3VuZCBhdDoNCj4+PiBodHRwczov
L2dpdGh1Yi5jb20vZWF1Z2VyL3FlbXUvdHJlZS9ob3RwbHVnLXJlc3YtcmZjDQo+Pj4NCj4+Pg0K
Pj4+IEVyaWMgQXVnZXIgKDcpOg0KPj4+ICBody9wY2k6IEludHJvZHVjZSBQQ0lJT01NVU9wczo6
c2V0X2hvc3RfaW92YV9yZWdpb25zDQo+Pj4gIGh3L3BjaTogSW50cm9kdWNlIHBjaV9kZXZpY2Vf
aW9tbXVfYnVzDQo+Pj4gIHZmaW8vcGNpOiBQYXNzIHRoZSB1c2FibGUgSU9WQSByYW5nZXMgdGhy
b3VnaCBQQ0lJT01NVU9wcw0KPj4+ICB2aXJ0aW8taW9tbXU6IEltcGxlbWVudCBQQ0lJT01NVU9w
cyBzZXRfaG9zdF9yZXN2X3JlZ2lvbnMNCj4+PiAgdmlydGlvLWlvbW11OiBSZW1vdmUgdGhlIGlt
cGxlbWVudGF0aW9uIG9mIGlvbW11X3NldF9pb3ZhX3Jhbmdlcw0KPj4+ICBody92ZmlvOiBSZW1v
dmUgbWVtb3J5X3JlZ2lvbl9pb21tdV9zZXRfaW92YV9yYW5nZXMoKSBjYWxsDQo+Pj4gIG1lbW9y
eTogUmVtb3ZlIElPTU1VIE1SIGlvbW11X3NldF9pb3ZhX3JhbmdlIEFQSQ0KPj4+DQo+Pj4gaW5j
bHVkZS9leGVjL21lbW9yeS5oICAgIHwgIDMyIC0tLS0tLS0NCj4+PiBpbmNsdWRlL2h3L3BjaS9w
Y2kuaCAgICAgfCAgMTYgKysrKw0KPj4+IGh3L3BjaS9wY2kuYyAgICAgICAgICAgICB8ICAxNiAr
KysrDQo+Pj4gaHcvdmZpby9jb21tb24uYyAgICAgICAgIHwgIDEwIC0tDQo+Pj4gaHcvdmZpby9w
Y2kuYyAgICAgICAgICAgIHwgIDI3ICsrKysrKw0KPj4+IGh3L3ZpcnRpby92aXJ0aW8taW9tbXUu
YyB8IDIwMSArKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4+PiBzeXN0
ZW0vbWVtb3J5LmMgICAgICAgICAgfCAgMTMgLS0tDQo+Pj4gNyBmaWxlcyBjaGFuZ2VkLCAxNjAg
aW5zZXJ0aW9ucygrKSwgMTU1IGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gLS0NCj4+PiAyLjQxLjAN
Cg0K

