Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E937A73C4
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirMQ-0003up-F3; Wed, 20 Sep 2023 03:10:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parav@nvidia.com>) id 1qirMM-0003ue-Dx
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:10:54 -0400
Received: from mail-bn8nam12on20624.outbound.protection.outlook.com
 ([2a01:111:f400:fe5b::624]
 helo=NAM12-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parav@nvidia.com>) id 1qirMJ-0008Ud-ST
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:10:54 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jb/nkGTqA53ZeVdIGprkKzSyQESnMB6iv5JMT2BVD19p74bZXFYioDMQU/N6Y71XVGKgQoWt54CB9UyMaO7E9IjQ/zlnKWHZyGFJVMBf1N56sFuFIsJO1n3BAdvS6l8Kg4GieCX7wn4rO9A9/KRK1F0XzYOibTV6udmSNv5nx3QQKGwvnL/KiM0KcyeoqjZY1x1I+PjGLT34L9yGR5PdQ3m3lMJdA9mqj4XhpEMIHTuxXfEwXDFNt8Rq3H888IS/E+5jW3qQ2pLyTRIaqIaKrLs+v4Oap0FyfV6Bfy4KaTaBzHjUqoPWQB3onWyM+qJlxqUjuNOLoOI2gnEyqF+mnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ornt/eYdShkL7aYT8VpSeFe06MkvfyariL1UmBa/0w4=;
 b=l0/9spBDyS6uK60XlorXMDTez5uuW2eguESQPdU8W1kK36tRfkeZmlkX50RZS0AAHjck0D45ZgxIjLC8LkOPt67i3czih3i2g7MZqwIymxN0VbZGLFJ3WhXuAab0Q36BghPZGX3UFspPIPGHzqltgGO54CLK8nBme1oVHIdRaZVT0b68ISueey0CL3cRziuRm2GSWBAOuWCeP8X3ppdXrCufq4rJ+FqhbXOAVaJMJ1sdEHuL6Mcx1M++JZ+XZeixNu3Bavvls3q0hGyWFFpk7AY2MFV21vXntYS57yrurh6v0f/Zcw2lBlvdYKWVrCWV3CZDBM1OdQkZxB1P4i+CKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ornt/eYdShkL7aYT8VpSeFe06MkvfyariL1UmBa/0w4=;
 b=Pfac7sGq81qIQEVG5YZtEPqlo0AAV+JTo3WcO3w1/BAZtH9PwvWX/Cn0suwWz54i2jfNV+1gIQuHJHp0zodpO0okOQFL8T4O9VMa4Kmgq8p9toO9waHHwJntlmeEmNDo0MWF99qS6FCKTgjk1V6G33QzQfJ9VfPFbaOPlSVPaGNVHEGzZipH+x986zcxAmaaYfut6py39H4owSHuckcCwl6ks4qaMx8S5kr0SOKehd27cOvOOowuGNwVpwQIdYVISiKV1KZ63U8ndJStTiwZ+6fvWtI4ufdLBcMumVAPFrlwNCvGv7i5F2jE7k6IDctRNvKSm8Wjf1ZVcDyLFhU2aQ==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by BL1PR12MB5046.namprd12.prod.outlook.com (2603:10b6:208:313::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Wed, 20 Sep
 2023 07:10:47 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:10:46 +0000
From: Parav Pandit <parav@nvidia.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>, "Chen, Jiqian"
 <Jiqian.Chen@amd.com>, "Michael S. Tsirkin" <mst@redhat.com>
CC: Gerd Hoffmann <kraxel@redhat.com>, Jason Wang <jasowang@redhat.com>, Xuan
 Zhuo <xuanzhuo@linux.alibaba.com>, David Airlie <airlied@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu <olvaffe@gmail.com>, 
 =?utf-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>, Robert
 Beckett <bob.beckett@collabora.com>, Mikhail Golubev-Ciuchea
 <Mikhail.Golubev-Ciuchea@opensynergy.com>,
 "virtio-comment@lists.oasis-open.org" <virtio-comment@lists.oasis-open.org>,
 "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Stefano
 Stabellini <sstabellini@kernel.org>, =?utf-8?B?Um9nZXIgUGF1IE1vbm7DqQ==?=
 <roger.pau@citrix.com>, "Deucher, Alexander" <Alexander.Deucher@amd.com>,
 "Koenig, Christian" <Christian.Koenig@amd.com>, "Hildebrand, Stewart"
 <Stewart.Hildebrand@amd.com>, Xenia Ragiadakou <burzalodowa@gmail.com>,
 "Huang, Honglei1" <Honglei1.Huang@amd.com>, "Zhang, Julia"
 <Julia.Zhang@amd.com>, "Huang, Ray" <Ray.Huang@amd.com>
Subject: RE: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Topic: [virtio-dev] Re: [virtio-comment] Re: [VIRTIO PCI PATCH v5 1/1]
 transport-pci: Add freeze_mode to virtio_pci_common_cfg
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAABRIA==
Date: Wed, 20 Sep 2023 07:10:46 +0000
Message-ID: <PH0PR12MB5481891053E37A79920991F6DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
In-Reply-To: <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|BL1PR12MB5046:EE_
x-ms-office365-filtering-correlation-id: d6006d29-3737-469e-465a-08dbb9a8b667
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ma+R0hSl3G4uicB7zQ11Ecay0YlHeHigZYvUTjBk5jAajhMOUhTgVMDHrrXzOciHSICJwa/F+GEoHjXSxyQdlaSV7Jsr85tv6DHq9vNe7HozDGOOILc9V18122/xIGuqnhTX5kp513Mxz8+5Ck8BfJP3cvuXhTxa0Jo33NbP0e0nlj4vj88gMCPxWwg27+uZyJD4RZePzvIo8rk/9wUmp0W94SeroRxafdRNDAfcfu6mk3GwxYT/VyipGLZUzeyTxRn3eiRlFqpKZul6vyzcRvwPdP2NGVWxHOPrPLr3fxOhvRtEaVt5dzpZxa8VY6shetQ+OPF9/8Qtz1X8nZEgHPWw7ElJh9eouw+w2qmaBHWYwgpNqAOGjXXBM1qVln46yRynQXzd6BCR8SrToV5uzi+yNG8QruoaQzyxEmJhfc01neDG/okaDAzswUkXbIb+hh8Rgv9lWWnVn5z8cj2czHt+RdmqVg1WJH5vx5lIvraZl7g8RGeGfnYbmhOs0flmNtTQcKbxscreKG2dcrN2h+/AipTzMfMUpawdpJRdqNpGYZj8yxDLV8spz/frGyqh/4W6aBGowrKnygQR5MWpjIW/uBu0CG8WhWgoUHPKTl4X8L/tzRf5GbhqHkYv0X0/
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(346002)(396003)(366004)(39860400002)(136003)(376002)(186009)(1800799009)(451199024)(38070700005)(38100700002)(55016003)(7696005)(6506007)(33656002)(86362001)(122000001)(26005)(2906002)(9686003)(83380400001)(478600001)(71200400001)(5660300002)(8936002)(52536014)(8676002)(4326008)(110136005)(41300700001)(316002)(7416002)(66556008)(54906003)(64756008)(66476007)(66946007)(76116006)(66446008);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OWlPMEJ1VGpHQUxpNW90YVBFbForeHJHNHpVY25UTFFiNGVyWkhmandMSUN4?=
 =?utf-8?B?QllTYlgzbzJhS0hOeWlTaEozNGN6Njc5OWdlbGNIaGJzNnI5ZmpraTlQWG9X?=
 =?utf-8?B?VW5FYTlvWlpQN2VjQUEraXVvMkNLcVJTM1ErblNCclpRSXEzY0F6emJ5MkFW?=
 =?utf-8?B?dSt0ZFVodWVmLzRwWVdIRWdmbmw4MzF6dGFEdG4rUkRFSWgxOGJCOUxzeHls?=
 =?utf-8?B?REUxRTVYSFFBVHBZRUhMUm9kRVA3SUtSd3EyOVVZZnRTbkUxTm5XenlIbTJL?=
 =?utf-8?B?VzVUTUxHN2g2ZmczUEMwTDc0THBZTGJqWXJpaXN2ZDBXS01wSHR3UXdic29P?=
 =?utf-8?B?RnJGRks5OGNVSHNTaU9RZCtibjlZMUFiRzhualhJdzBLV0FSaHZrbkVLRFNW?=
 =?utf-8?B?R2ZQc2YwZWlXV1ZqSGZKQmlTT1ZoL1h5Q0tXNllCTzRlUG4rY1FGOSs0WW41?=
 =?utf-8?B?MTF4S3pwQVZjR3NMZURNQ3ptSFF6SnZwZWJnWGJ3K0w1S0hENTlyY0hnbytu?=
 =?utf-8?B?elhSdG85NVZiSGFQamNTeFI3bHFFcXFaaVdERTZVcUozUDJYSkc1c0xTb1Bl?=
 =?utf-8?B?Tk05aUc4ZVliV29VTS85QmhpQmdsYUIyODZ6YnlkdSs3L3JHQjBpdWRGVFdZ?=
 =?utf-8?B?VU85UVFZVG1MNVRRdStvbEpqUy92bVN2Z3duSGlpVEZQQzU1MGEwLzVzenVs?=
 =?utf-8?B?WVc4N2pySVk3MU90NTRyUWMwdFBMYWhvdDNSRVB6U2FzbStrb05lMDZtNGF5?=
 =?utf-8?B?NmZUKzVDdGRWTUgwZGt0czZoYWIzZEdNT09mUmlwTjlLQ0tpMUJYSXZpcHB5?=
 =?utf-8?B?WnZ4bVkyL1VVZFhaa3lOQldvbnJOb2Y3Tms3N1NwUUtDdFNFTk5mYVhTbWVP?=
 =?utf-8?B?TWcvZXVrSGdIdTNsa0UxdzdpUnVWUzV0NkFOaCsvdkVsYW1ZNkR1bXYyV2Mr?=
 =?utf-8?B?Z1A0MjRSUmNuV05Mai9tQmJacm5mNjhRTmJDNnc0Y3Z5U3IzSkloVTdtd3FW?=
 =?utf-8?B?bW9zd0lJcFVuNjlYMWJ2VjZzUmFQSDFtWWlYRVkxYlY4a1FzMXlqcEphdU1j?=
 =?utf-8?B?NkEyMGU4bTIyYkt2bDZ0UXdMVWNXR0ZER3JIbW9FM080dG1aQVZtdi9Dakww?=
 =?utf-8?B?NkNKTURlMTZuQ3c5WnB5UW9Lb1dnV2lFRTBNckRBZmx4VDQyekVjODV4TElM?=
 =?utf-8?B?enZYOTZFRElsalNLZHNnVi9Ia3MxdkkvZUZNNFRGVTlSdjIvenArdHRSMkg5?=
 =?utf-8?B?UDA4Nk1vdmZjZjlIelFLZHlXYkg2OElyazNhV2haNnlUbFRGWXhma2xSSzFq?=
 =?utf-8?B?d2FuNGFhWHFySTVFZThwTUtZalBzZUtpcFJYNERnQktsSm9zMTJucWFrZWEw?=
 =?utf-8?B?aW9hcHo3dldCSDNSUmpZTjJZemxmelk0UDJrdGZ2ekltc0Q2STlGeVRNcmJG?=
 =?utf-8?B?cHZ0aUNVVWhwVEhhRXovSXY4NmJlUjJPVjJheUZCRml1NkgybmtMMUVqMlNQ?=
 =?utf-8?B?K2tlR2dGaXY1M3NFZFhkVnZ0L2NRQm5lbUdQSzRCRFZCZkpaLzZzZEllK3JB?=
 =?utf-8?B?eGhPWG9VRzZMS0JuNnRxVGNabzlqRjVuNEJKcVdDVDNBelNFK3p5eWNycE5o?=
 =?utf-8?B?ck8zQlExR0daZjQvMmROU2pCQXI4NFprNlZrRUVMTWw3VlhKNkgyeERUVCtB?=
 =?utf-8?B?N2puemhlMnRtcWtDbFhPOFdLdjRMQmplQVhOekhpU1BjTmtHSU5iUGhrODEr?=
 =?utf-8?B?TDFBTUNrMS8rSy9nSlFhMjFueXlBSFhyQXp6SDAvTlo4eFgzRHE4T0NtZ1NX?=
 =?utf-8?B?RWlTNUdFQ0tWSlMwVnJZUk9BZ0NydlVoNkhJYTBISEhtZHE1Y2pNa1FMdTha?=
 =?utf-8?B?T25jYS9wWG1RQXYyTzlpWlF3Z1hMclpmSE9PUjY3aFlqamJ4UUdWcFpUa0gy?=
 =?utf-8?B?Z00vejFvVjJLSXpIMzRvZmJQa0pPMVJxVkllVW90K2lOSWttQWdlYWRrNDRx?=
 =?utf-8?B?NnV1UHd4ZzZOSEh4dnVNMEJVVzZjOE9hWUczZU16cko2QkFUekp3dWR1d0Jk?=
 =?utf-8?B?MWljcCt1a3N6M1lXYWdTSUtXTHVpR0NFdHhuRDdSZUJtSGZGcmp4OGZkY1V6?=
 =?utf-8?Q?oACY=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6006d29-3737-469e-465a-08dbb9a8b667
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:10:46.8728 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R83z/6zvkLpHYpv67CWkREOdaTnfthoHApq1KLzNqNLB4sp0OyVCt2ykp18X1Z7rXM9BTSq90SMdg8+HWAqxGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5046
Received-SPF: softfail client-ip=2a01:111:f400:fe5b::624;
 envelope-from=parav@nvidia.com;
 helo=NAM12-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

DQo+IEZyb206IFpodSwgTGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+DQo+IFNlbnQ6
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDEyOjM3IFBNDQoNCj4gPiBUaGUgcHJvYmxl
bSB0byBvdmVyY29tZSBpbiBbMV0gaXMsIHJlc3VtZSBvcGVyYXRpb24gbmVlZHMgdG8gYmUgc3lu
Y2hyb25vdXMNCj4gYXMgaXQgaW52b2x2ZXMgbGFyZ2UgcGFydCBvZiBjb250ZXh0IHRvIHJlc3Vt
ZSBiYWNrLCBhbmQgaGVuY2UganVzdA0KPiBhc3luY2hyb25vdXNseSBzZXR0aW5nIERSSVZFUl9P
SyBpcyBub3QgZW5vdWdoLg0KPiA+IFRoZSBzdyBtdXN0IHZlcmlmeSBiYWNrIHRoYXQgZGV2aWNl
IGhhcyByZXN1bWVkIHRoZSBvcGVyYXRpb24gYW5kIHJlYWR5IHRvDQo+IGFuc3dlciByZXF1ZXN0
cy4NCj4gdGhpcyBpcyBub3QgbGl2ZSBtaWdyYXRpb24sIGFsbCBkZXZpY2Ugc3RhdHVzIGFuZCBv
dGhlciBpbmZvcm1hdGlvbiBzdGlsbCBzdGF5IGluIHRoZQ0KPiBkZXZpY2UsIG5vIG5lZWQgdG8g
InJlc3VtZSIgY29udGV4dCwganVzdCByZXN1bWUgcnVubmluZy4NCj4gDQpJIGFtIGF3YXJlIHRo
YXQgaXQgaXMgbm90IGxpdmUgbWlncmF0aW9uLiA6KQ0KDQoiSnVzdCByZXN1bWluZyIgaW52b2x2
ZXMgbG90IG9mIGRldmljZSBzZXR1cCB0YXNrLiBUaGUgZGV2aWNlIGltcGxlbWVudGF0aW9uIGRv
ZXMgbm90IGtub3cgZm9yIGhvdyBsb25nIGEgZGV2aWNlIGlzIHN1c3BlbmRlZC4NClNvIGZvciBl
eGFtcGxlLCBhIFZNIGlzIHN1c3BlbmRlZCBmb3IgNiBob3VycywgaGVuY2UgdGhlIGRldmljZSBj
b250ZXh0IGNvdWxkIGJlIHNhdmVkIGluIGEgc2xvdyBkaXNrLg0KSGVuY2UsIHdoZW4gdGhlIHJl
c3VtZSBpcyBkb25lLCBpdCBuZWVkcyB0byBzZXR1cCB0aGluZ3MgYWdhaW4gYW5kIGRyaXZlciBn
b3QgdG8gdmVyaWZ5IGJlZm9yZSBhY2Nlc3NpbmcgbW9yZSBmcm9tIHRoZSBkZXZpY2UuDQogDQo+
IExpa2UgcmVzdW1lIGZyb20gYSBmYWlsZWQgTE0uDQo+ID4NCj4gPiBUaGlzIGlzIHNsaWdodGx5
IGRpZmZlcmVudCBmbG93IHRoYW4gc2V0dGluZyB0aGUgRFJJVkVSX09LIGZvciB0aGUgZmlyc3Qg
dGltZQ0KPiBkZXZpY2UgaW5pdGlhbGl6YXRpb24gc2VxdWVuY2UgYXMgaXQgZG9lcyBub3QgaW52
b2x2ZSBsYXJnZSByZXN0b3JhdGlvbi4NCj4gPg0KPiA+IFNvLCB0byBtZXJnZSB0d28gaWRlYXMs
IGluc3RlYWQgb2YgZG9pbmcgRFJJVkVSX09LIHRvIHJlc3VtZSwgdGhlIGRyaXZlcg0KPiBzaG91
bGQgY2xlYXIgdGhlIFNVU1BFTkQgYml0IGFuZCB2ZXJpZnkgdGhhdCBpdCBpcyBvdXQgb2YgU1VT
UEVORC4NCj4gPg0KPiA+IEJlY2F1c2UgZHJpdmVyIGlzIHN0aWxsIGluIF9PS18gZHJpdmluZyB0
aGUgZGV2aWNlIGZsaXBwaW5nIHRoZSBTVVNQRU5EIGJpdC4NCj4gUGxlYXNlIHJlYWQgdGhlIHNw
ZWMsIGl0IHNheXM6DQo+IFRoZSBkcml2ZXIgTVVTVCBOT1QgY2xlYXIgYSBkZXZpY2Ugc3RhdHVz
IGJpdA0KPiANClllcywgdGhpcyBpcyB3aHkgZWl0aGVyIERSSUVSX09LIHZhbGlkYXRpb24gYnkg
dGhlIGRyaXZlciBpcyBuZWVkZWQgb3IgSmlxaWFuJ3Mgc3luY2hyb25vdXMgbmV3IHJlZ2lzdGVy
Li4NCg0K

