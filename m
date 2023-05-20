Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED55B70A466
	for <lists+qemu-devel@lfdr.de>; Sat, 20 May 2023 03:44:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0BcZ-0005gi-UE; Fri, 19 May 2023 21:42:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q0BcX-0005g9-7K
 for qemu-devel@nongnu.org; Fri, 19 May 2023 21:42:57 -0400
Received: from mga18.intel.com ([134.134.136.126])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wei.w.wang@intel.com>)
 id 1q0BcU-0002aX-VH
 for qemu-devel@nongnu.org; Fri, 19 May 2023 21:42:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1684546974; x=1716082974;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=gNWUkzSwumidIErCeTEx+jKMe36XJG+tZ2coGPFovIc=;
 b=oKCfkErwjP0X9fYw8k9kxKax7R9J49sTFRlyXt36EWGyfADQNkPpH+lN
 Odp3+YZ6LCtNjLVmU7k5JJzsW2jgq7YRgYR21kuMwgorcQ3YOKVNtdxoP
 S1TW+2YmxYBBHk1CkyXDiTjlQBVG9kih1icZ5PLytbgXdRjeUoLEYOdP+
 1OgKrQxz9MV89YICrgFaNkBZ2a2dCNCflB+oWP4PkfS0c4pgQW4VN+dKw
 VpbSuM8VTaKFOe8RXtM54SG165GgS6bY/zmX12/YeP/KHoW5za53Wzkod
 KFpglh4U2cxCJsZyZnbFLH2M//Om4Tm65WKpYyoZCFhsk9ZZXnyNv7QHA Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="337120777"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; d="scan'208";a="337120777"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
 by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2023 18:42:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10715"; a="792564112"
X-IronPort-AV: E=Sophos;i="6.00,178,1681196400"; d="scan'208";a="792564112"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
 by FMSMGA003.fm.intel.com with ESMTP; 19 May 2023 18:42:14 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 19 May 2023 18:42:14 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Fri, 19 May 2023 18:42:14 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.108)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 19 May 2023 18:42:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGmBWP7UWD9oiMm5/8MJ9kCfgqBXNzlOeTma8osRx/fqwKD+lLx9vWhdzd3Rb1v/RhhQEOIPMpOGNUVvh1N0so19tafn9Nab3g8H9BIKDedkuyX/HfWuKP56S3b8EaT3xHp9/ZTp3rGh3+a3+Y4qxLxWt3/BevQg3UsQbgmC8NF1kV7YK4uZBJX8c9rCXuxGdxC9m1xfdJPqvQMQvNXJN6/I+ZUN/Y4zIwXVgBHG9jE7iBITLylGXSBkMefKnLaicNS1APtlOx2d8Y9/qqjeSWiHLscLFe7r6aDCNlWRETjhcXMzGvbrJa7kJvCcb1HzEbdCJOQEqqsUan3bhjQkMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gNWUkzSwumidIErCeTEx+jKMe36XJG+tZ2coGPFovIc=;
 b=YC+sNLbkJO66PP5CChS6ef3RfHxelb0ZVUZfHOKFB5aoOMwfWzJbxhdiqihRq6kVZYXB4/w8QNnLZrQmTyQiDIL8j7KhRs1NzWkq9xFmTFSQjSM0kp9Pv4GC5RIZbcirj6W03nmYRNmBl7OWZJZ5AHMfbOsmMLauNJys1Gy7G94zfVOsB76GIuQtAHTWnYrxMqJcxR/+cIQ/80e6fi8XjN/XGGxWBCIGGmrIXcX8OijZ72Sfmlg+lR5khpxO43kfgI2oOcudza+j4lSkvpffFMQ1CTW/H54Vsnnuhbjli5Ty4rhLVPPwIgkDMgobJbeQMGkeRB5OJQYrvBb1hIYhbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB6373.namprd11.prod.outlook.com (2603:10b6:8:cb::20) by
 CY5PR11MB6439.namprd11.prod.outlook.com (2603:10b6:930:34::11) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6411.21; Sat, 20 May 2023 01:42:07 +0000
Received: from DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6]) by DS0PR11MB6373.namprd11.prod.outlook.com
 ([fe80::14c:205:c858:1ef6%7]) with mapi id 15.20.6411.021; Sat, 20 May 2023
 01:42:06 +0000
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Peter Xu <peterx@redhat.com>
CC: "quintela@redhat.com" <quintela@redhat.com>, "Wang, Lei4"
 <lei4.wang@intel.com>, "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Topic: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Thread-Index: AQHZiaHrpdDskbcmfUmdUetnWYWQW69gaDgAgABj4tCAAO5TgIAAAOyAgACb1xA=
Date: Sat, 20 May 2023 01:42:06 +0000
Message-ID: <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
In-Reply-To: <ZGeW3R5McptUueJF@x1n>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR11MB6373:EE_|CY5PR11MB6439:EE_
x-ms-office365-filtering-correlation-id: 84b36cd7-67f4-4bd3-5fe6-08db58d36b2f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nljxnZiJ/Sqo432k4t/th1QnS8rwAxlFvaLxc0U6G/DUw3kUBubEYrRCVX2Y015aZ6voe+fp2tKjh58SMuD4g01pOTDp3kCUrvd53omThHq2EdlTTmKzlclcGGYHzGkZwhO4qXXGhQbAZ68MSSqx0tGL7tbvOb4/26o3ShIiznChb6lGMA4dBTmgQM3JX5XtMkIGZLdBuvEVxC7pgesI0RWWWa/cV8SsrDoKLUzxHzvgwSmY9JnhiZRDD4vKYri1INCO1wOWdl6ZxlSlFXHAtnOnUO74LjAFslHj60d70RIER+A1z6UtWL4a2UflGNjo22cB+w7x+CUB4YaCZUZw0uYAbZYwmZ5Vo8NXeWuhaYCXhE8C8wGOMyoLCz09zmHRbGzNiKaA6Xf0uZM51u7Y4KaUgtssA6RdWEKQwL123mkHf0ggmxGdbaHdn294VvIMFV2rfWjnfDSFQ7TWx5GAHhZHScD9JHhp/9IrQn4aIjceCV76/P1DSLn44w9qUHHZII/kRW7J/3REB6Q4s29shuBOzlQ7mVv2a1QG9+j7aJ1/4eE8+zvzcXLyss87XO6NIOZIamOaYRq2PWnu1A/qNuoSMPNCAMQ19NQpC7ObGZ9nDRaAJCMIyZcM01jugpK3
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB6373.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(376002)(396003)(136003)(366004)(346002)(39860400002)(451199021)(83380400001)(7696005)(38100700002)(38070700005)(82960400001)(6506007)(71200400001)(186003)(55016003)(26005)(9686003)(53546011)(122000001)(33656002)(64756008)(76116006)(66946007)(86362001)(52536014)(5660300002)(41300700001)(316002)(6916009)(66556008)(66446008)(66476007)(2906002)(4326008)(4744005)(8936002)(8676002)(54906003)(478600001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Sk5yejYrK0dHQXd6YlFKMDlPWXpieHpLMHI2Q0dwNmJOYzJHelNBdGdBeDVR?=
 =?utf-8?B?b3RyMmUzSG1UOWlNeE9SVXhuRFBnYk1SRnd3Y2pyVFpCeFphMzNrVmN2RytI?=
 =?utf-8?B?Z2JvZHdVL3JpdWd1Y3VCVEQ4T3RtY1N6dFFidGZ3dFNSZEFsRnQycm1VbERZ?=
 =?utf-8?B?QUZJVDJ4UTJCd1FlY1FlTk4xeXYwNXl3SGRrbGhWd1QyWXcySEVVTWRTZm1I?=
 =?utf-8?B?UXZadW5VQnlSemxjOTM2OStWeklEMjVDTlFJb1BTc24wb3laWndNSXdqYmpt?=
 =?utf-8?B?YUZxdnQ3ZVlkc1ZxYmlwNXNIU2VGeVVPaXhsSzZzSlBKQXhNTkhvRjNOQlE2?=
 =?utf-8?B?MG16L2xRVDhtZkpvQzZJd0ZFdlgrNzlBVURXZmN2a0loMmlsVzNPdDdVOW5M?=
 =?utf-8?B?Ukh2a3EwaWx1SXNjUng0RzJkeTF2QVNzS09FemFIZHROTVZpcndNamh0WUJz?=
 =?utf-8?B?dklSTUM0bjJtWExTVkZ6QnpYWjFLY3dMNDA5M3JrU2ZNbTlaR05IcDdaMzkr?=
 =?utf-8?B?WjQrMVJ0K2txejh2U3lWUnFNaWI2RDduT28vUVYwL01DVE5qRjZmakNOM01w?=
 =?utf-8?B?M2d0UnVndlRXN3VKVEdraTgrK2xTdXpmZFNGa3RoMTltdVVKaWNBVm1WYzVW?=
 =?utf-8?B?b3RKTUVqS2F6azlmQ0w0MTlCSStEeG5JSjEySVhEVjErK2twSStSZ2plWXdQ?=
 =?utf-8?B?QUoxUVN5SjNSQjBzSXFya3ZjSWJBMXJTYkIxQmlyVXRzR2pVMUVKVFhvaE03?=
 =?utf-8?B?eDlxdm42RnBvMmRHcEhTNlQ2SkVWdWpiMFoyUGpMcm5MS3BteEdZTURUcDV5?=
 =?utf-8?B?WlIyNUlIeGNXR1dvN1R4T0NZV0IxczJrWWVxNmd1UnFmV0ROSi8xeGVleW9i?=
 =?utf-8?B?TURua1hTVmpxRU85WlAyYmtPc09vYVRBSU9vUWxtbCttc0pUTjFJbWM1ajJy?=
 =?utf-8?B?b2wxZ3JyZ21uRktHWEdDNXpUVFFTaDlSU0dzTXRLMi95TG1HY2srTHo1MXYx?=
 =?utf-8?B?Vm15cUdrY09iV0VRR0dlT0l0aVdpVng1Z0JJaHlxZjZZdS9PeWZCWVJHSzho?=
 =?utf-8?B?RmlSY2tTYWpsQ0IyTERBbFd2NDVQZ0I2ZkFCeTB0cW01U2owUGtrOUR1b3J3?=
 =?utf-8?B?TmpPUmVCU2ZQbDhoZCt4SlNVMzl1VmYxTi9keFIyREJVaDlFTFAxaUNsRHNl?=
 =?utf-8?B?T0ZxR05YeUtXTkxSbFRxMGZrQUxQRlNNMUpoa0gxUk94VzNkK0I0VW9FbEE2?=
 =?utf-8?B?SEF4cWU5eDFOMXduVHgzandNUnd3QlE3Znc2VHNnWGRHTDY5d2l0WFNTdllD?=
 =?utf-8?B?SGpVWFBNZ1lTUTdsWFMzbUZvTGpCS2lKRTNiM1F6RU52bU1HQXRFK0xYVUl1?=
 =?utf-8?B?Z0JubDkxajExOXZ2bjZQS0N3dFNRYmJtUUN2YklwZnN4ZlFWRlVOYU1PejdU?=
 =?utf-8?B?RWVNZ2s0K3FneC9rN2ROWnFrRWZHR2U5dXg2UncwMXNwQUF3QmtKaG51OHFj?=
 =?utf-8?B?RjJwb1NXeWxFVGYyeExPR2lUTHVTKzJwY25MT3AzNlZuL2t3Ti93SG1wQVhH?=
 =?utf-8?B?U3RJYWE4VGZYSlhncThaV3NSblRmY2dOVmZFamtVVXhjdStVSk56UWdDK2xj?=
 =?utf-8?B?Rjh5NHJlcC9SdnREeTAyNURHKzVQQVdpKytwOEZ5QnBlbzN5OEVaZmxWa1Ns?=
 =?utf-8?B?ZnFpZjA1eXFxV1VZbEszUlR1bU9Qb3kvTFZtbkowVTU3MXE5b2hZU3Nhc1ZI?=
 =?utf-8?B?dXVZMStnTERoWXp5QnFNUkpVN0NyNFpmTE56bmNqWGFNQUhRZmNzaU1PL1NP?=
 =?utf-8?B?bDlIQUFoVi8veEV6UUMweDNrN3ZDWlVSZWVEVmk2dGVVdWlvZGlwY1NOWWtZ?=
 =?utf-8?B?NGY1bWJKd1ZvZ3lpOTdSd1BUN3Y3Z2V3cVMvNk5Ia3VmRWQ4ZURxWkU4SDNn?=
 =?utf-8?B?Y3BpWGRMcVVncFhVSnord2tHb1kzL25FUk82bmlIRThtSkh0a0UzUkUvQkVr?=
 =?utf-8?B?SU0vSUU3WE96aS96Zm1VQWZMM2ovNW94d1hseXFTRUY5d1huaHNaVEpuaEdY?=
 =?utf-8?B?R1c1WTVZcGJJL0J5UlFtOUdHYnRCdTFhcU5OVjlvUGdjRnlsL1V4bTRDUW9x?=
 =?utf-8?Q?1JaA1Tv0IuWiddrinkyKjIwTv?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB6373.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84b36cd7-67f4-4bd3-5fe6-08db58d36b2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2023 01:42:06.2309 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlVkdQP3kHchTFKk0UW501EoTJGfu7PBy7+do8hH6vKwOwctQEJQitcF1k8x1tcZaOpm6ajJRDkcxk4NJpLlbw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6439
X-OriginatorOrg: intel.com
Received-SPF: pass client-ip=134.134.136.126;
 envelope-from=wei.w.wang@intel.com; helo=mga18.intel.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

T24gRnJpZGF5LCBNYXkgMTksIDIwMjMgMTE6MzQgUE0sIFBldGVyIFh1IHdyb3RlOg0KPiA+IEFo
IHllcyBpbmRlZWQgaXQga2VlcHMgd29ya2luZywgYmVjYXVzZSB3ZSBhcHBseSAtZ2xvYmFsIGJp
dHMgYmVmb3JlDQo+ID4gc2V0dXAgc29ja2V0cy4gVGhlbiBpdCdzIGZpbmUgYnkgbWUgc2luY2Ug
dGhhdCdzIHRoZSBvbmx5IHRoaW5nIEkNCj4gPiB3b3VsZCBzdGlsbCBsaWtlIHRvIGtlZXAgaXQg
d29ya2luZy4gOikNCj4gPg0KPiA+IElmIHNvLCBjYW4gd2UgcmV3b3JkIHRoZSBlcnJvciBtZXNz
YWdlIGEgYml0PyAgT2J2aW91c2x5IGFzIHlvdSBzYWlkDQo+ID4gd2UncmUgbm90IHJlYWxseSBj
aGVja2luZyBhZ2FpbnN0IC1kZWZlciwgYnV0IGVzdGFibGlzaGVkIGNoYW5uZWxzLg0KPiA+IFRo
ZSBwcm9ibGVtIGlzIGlmIHNvbWV0aGluZyBpcyBlc3RhYmxpc2hlZCB3aXRob3V0IGtub3dpbmcg
bXVsdGlmZA0KPiA+IGJlaW5nIHRoZXJlIGl0IG1heSBub3Qgd29yayBmb3IgbXVsdGlmZCBvciBw
cmVlbXB0LCBub3Qgc3RyaWN0bHkgYWJvdXQgZGVmZXIuDQo+ID4NCj4gPiBIb3cgYWJvdXQ6DQo+
ID4NCj4gPiAgICJNdWx0aWZkL1ByZWVtcHQtTW9kZSBjYW5ub3QgYmUgbW9kaWZpZWQgaWYgaW5j
b21pbmcgY2hhbm5lbCBoYXMNCj4gc2V0dXAiDQo+ID4NCj4gPiA/DQoNClllcywgSSdsbCByZXdv
cmQgaXQgYSBiaXQuDQoNCj4gDQo+IFdlIG1heSBhbHNvIHdhbnQgdG8gdHJhcCB0aGUgY2hhbm5l
bCBzZXR1cHMgb24gbnVtOg0KPiANCj4gbWlncmF0ZV9wYXJhbXNfdGVzdF9hcHBseSgpOg0KPiAN
Cj4gICAgIGlmIChwYXJhbXMtPmhhc19tdWx0aWZkX2NoYW5uZWxzKSB7DQo+ICAgICAgICAgZGVz
dC0+bXVsdGlmZF9jaGFubmVscyA9IHBhcmFtcy0+bXVsdGlmZF9jaGFubmVsczsNCj4gICAgIH0N
Cg0KRGlkbuKAmXQgZ2V0IHRoaXMgb25lLiBXaGF0IGRvIHlvdSB3YW50IHRvIGFkZCB0byBhYm92
ZT8NCg==

