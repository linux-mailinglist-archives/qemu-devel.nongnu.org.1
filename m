Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 769B57A74DC
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 09:51:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qirze-0007uQ-Oh; Wed, 20 Sep 2023 03:51:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parav@nvidia.com>) id 1qirzd-0007uA-7E
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:51:29 -0400
Received: from mail-dm6nam10on20626.outbound.protection.outlook.com
 ([2a01:111:f400:7e88::626]
 helo=NAM10-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <parav@nvidia.com>) id 1qirzX-0008Df-QG
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 03:51:28 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QhZMWRVPUBFki2nu4IFzzGAUJsOkZCzbzuKNQauz3njWNFnfB4G1o43w2KlZVl+DfRz6UKRNmdV5z7Jjzeqj+0jtVtFZBZUqnMzzoh+73U2JgAulvEDxSMKG2y6eQaVrTatR7sRgWkwqa6FWSlem8f0L54Myfdm08zaxjEc6tg1bsJ1Q+SNop8A21dGv88PSZnshmBesCmVjvtVtw93peLiOwXH+zJwmscNtVMwrIp3WlY5sH5JswlfMLq1u9ey8MB1lPM40a5P4mnYps7LbhLqAEAKcMAjkKIBvo5B9DnRMdJ0apISug6H3eMi/Icla7A3QF+g62dpH8YzpaJMz2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ccBWVdoPRdcx8EFgb+aDbYtpu0MBs8Bo5ScdIb2Sbu8=;
 b=L5lCDJ4pSNsUy94bqhO2vp25qRoonU2IeGHyh+Sp4GbX4Oj/PqC6+xQeOsd/zj7o3f56nlSbvlSsRtjNfC3riGpdugbimMVgJa1DCNelhZ0CaZcOepJMfK6VrA0s3RjnNvan5tjepaAu2oF+uJnEmR+0LhC+oTg3g71YIK9hQ3LTS/N+XTaEWooHdiVgZMsqWjLSpV4Bc4oEmrm9K88kDycF5sV3+pRQni/jAhT5UqtJ6UtJeKLqxWLafkFPd3/8diVVI6giOMhq9LYd6TF4IuKM0R45iv1RlJncioSWEar383bJYF1JagrD1oExwXBAszoGLp4u9cZXZgF58nc3kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ccBWVdoPRdcx8EFgb+aDbYtpu0MBs8Bo5ScdIb2Sbu8=;
 b=JthslmjydHA/cWSHKAu5cM8LmL+vHQVTAmUZQC124QJ5KLWpFF2V8Z+/V6sFpoUrKrLfnDJiT9yaZMk/9bi2wpq+7oDLnTHkV8BnB5SLgSLQoDzedc8MPwPnUnOhi0hkA6Y7y4vHrwU4RzUWzmOeGOt1ahROAzt8KrL/a92XSdgYR7/c/Cgofbf0sRlr9RFIqufY9aGv9eLXiYAwP4TQf13GS2K8ae24JvIvav5pPZjf5PK1fqriIvl0EyP30KPaA4o3dAMf9MNWqagwWU0C9pzQ3pd9Gy/phTklHHMO/yvsiDpqUNQSSHToJ+keWcBURscgg8TDaDuEn5vtHtmHTw==
Received: from PH0PR12MB5481.namprd12.prod.outlook.com (2603:10b6:510:d4::15)
 by IA1PR12MB7640.namprd12.prod.outlook.com (2603:10b6:208:424::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.32; Wed, 20 Sep
 2023 07:51:20 +0000
Received: from PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199]) by PH0PR12MB5481.namprd12.prod.outlook.com
 ([fe80::4002:4762:330c:a199%7]) with mapi id 15.20.6792.026; Wed, 20 Sep 2023
 07:51:20 +0000
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
Thread-Index: AQHZ6u55wdLgYEJT5UeWhzYWiXOCmrAiFHuAgAEk1ACAAAlvAIAABTWAgAAEKYCAAATtgIAAAbEAgAAAlkCAAAQ8gIAAAD9g
Date: Wed, 20 Sep 2023 07:51:20 +0000
Message-ID: <PH0PR12MB5481E16E2BC9C5B4B786FD91DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
References: <20230919114242.2283646-1-Jiqian.Chen@amd.com>
 <20230919114242.2283646-2-Jiqian.Chen@amd.com>
 <20230919082802-mutt-send-email-mst@kernel.org>
 <cd8d306b-6acc-34be-516c-b89c23ac108d@intel.com>
 <BL1PR12MB5849E32A76165F1307492185E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <PH0PR12MB5481D2CBCFBF7BCBF427EE1EDCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <701bb67c-c52d-4eb3-a6ed-f73bd5d0ff33@intel.com>
 <BL1PR12MB5849A542AA93F6ED9FEEAAF0E7F9A@BL1PR12MB5849.namprd12.prod.outlook.com>
 <a636b841-1bfc-925a-406e-6c4469e7e4c6@intel.com>
 <PH0PR12MB54817E116B756914B3FC1860DCF9A@PH0PR12MB5481.namprd12.prod.outlook.com>
 <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
In-Reply-To: <40765650-ba6e-357a-cf73-ff6a0288c0e8@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR12MB5481:EE_|IA1PR12MB7640:EE_
x-ms-office365-filtering-correlation-id: db94c5d7-86ab-4f6c-00a1-08dbb9ae60ad
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: xj2Lq9PBK8GLmvD59PlNIFZUBp0VMSUnsWq4qj/Y2qT/h5QK7NlLxcejff9mGjaZ8giiiBCKHkmZxQso6ZrFAjU07jqTvQQ67MhNUSOM5eG6hyYhVRLVBqfi2ub19hMIU0ihgjXNC+8+Q3h47GBugOxbFnj53eF6BP38qNDr01S9BSkRfxp2SUn1iQ5zp2ij0bkEn6GC/WEPc4z8XTYk3x/gRuil8LS8m9SKFaLDu4ZSlLcNySQNBfm+7TD1mrlQ7Nn6K0KDSAMjZkFKEwVP9Ds+8RaJzX2qvYymUVVbJ+dsmOeEP753MZkRUBkY7CR58BnriX/6FQYIrQ7VpVrG19Qg3n66wsVBS3Ny08CdyGqAJ/tRe2UW3oxttkhtwTh2eS6EGa/ccCPlmNx6KGNvPjMQXV3g3V44xOLktrKy3rzgidG0YZ6oPq7Qnf65XQ8uYNaZ4UDkS+VAbaDATL82edMHi18rdr4e9PRme5CQ7V9/oNwuBWgEpp5jh+I8WA+7CoEEsvfiVhpKsnvGOnfya6dZ9ptpNWzPx6phI3ZGSLnCQCNHhVebrZec/bxFIs8DHmHRvBJmAsm5275zM+6//BLnHdBfdRrhYNyu5TvVbrVN7ZMsh71ILERV7MH+3Bey
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR12MB5481.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(346002)(366004)(396003)(136003)(39860400002)(451199024)(186009)(1800799009)(86362001)(122000001)(55016003)(38070700005)(38100700002)(33656002)(110136005)(66476007)(2906002)(6506007)(478600001)(4744005)(76116006)(316002)(66556008)(7416002)(64756008)(66446008)(66946007)(9686003)(71200400001)(54906003)(5660300002)(8676002)(4326008)(8936002)(52536014)(41300700001)(7696005)(83380400001)(26005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OW1RcStaQW5KQzhJaGxxU3ZKL1FkYzEyeTZtRElnNzhvaFNZM3JQVnpicm9G?=
 =?utf-8?B?eWJxU3BzNmU2MVI2eTU4ODVieFNYLzRPMGJYMnVRZnQ5SS9aaWd3RFJXejZD?=
 =?utf-8?B?bjJYQXY0b3lkUFoxQmJuL3A0aENwd2Z0VlVKcGpJYjQvUzdUaEw3d0FXQ0k5?=
 =?utf-8?B?MklHYjRSRXZhZGM5M0JNQTlXbzFnQ3dZRXZLRVNLWStwWHBaZ2NUWC9aai9N?=
 =?utf-8?B?M1NOSm0yTGJ5bUMwWUtudHhEVXE0NnR5T2JBelh2SlpkOHNVR0U1R05OdHZM?=
 =?utf-8?B?VW5VbUcxc1VDV2pWb2J0dXh3aFVJaktUWGMvS1ZuNStJS2l5M25INUhoSnlG?=
 =?utf-8?B?TWJZaTZBQVNKalJORHJRSXk1YXozdG9XSjNoVTFZZWdoSWZMblNYc1BMeFkz?=
 =?utf-8?B?S2JJd0dOUk1pZ3Rqa09WOXZTK0RkRll3N1dEdGxwZnlEdVZ6cGlkVWhTVDJ5?=
 =?utf-8?B?ckN0QWFrMWZMQVNjSWptZ0U1SWlKUE1tLzl3cVQwalVldWpNOHpmV2d1WklW?=
 =?utf-8?B?eVNDTEUvRS8rbEFLaE9hZ3BQclBzdUhNbEJITUI2MUNWZGpwQWpIL0U0WmNH?=
 =?utf-8?B?a2wranY2TGNPbkthekI5ZG5NV1Rad0lwYUhkdGdoVFpSb1JPTGFhK0VqQ1Rw?=
 =?utf-8?B?WnBDY29oS3ZCVDluYTNNN0pEZ0tGLzlBb084TGlxWDZOZ2Z4dExkdXR0RnM1?=
 =?utf-8?B?bWxTK1FoRVVWK3JRdklKeU5ZZTFMZjVyYnFqWTFwNTNtTlhCRVFyUVdMWi9i?=
 =?utf-8?B?Zkk2d1pDdGlON1hGTlFpWW1sQjZNUE95S21BZ3hwSG8vVUhiMnBaS1hwUS8v?=
 =?utf-8?B?bFhJM1pBRXZsZm1Ua3ZOSkFvMStVbUx1Si9EWjRMY1U3aEdqL3VGQ0F3THdp?=
 =?utf-8?B?RmNGbTg4dkV3YmJCUjVVZFByTXBIRlFvTFlmYjRQdUJ6V2pVM0k3TmVScDZp?=
 =?utf-8?B?b3ZINS9mZVZEbVRpYStzV252V0dZbzFUY0I1RDZEU3htWHBKNDQxQVdlTC9L?=
 =?utf-8?B?eUpaajg3cEpaSnVUcENkS09XRlNiMi9sVmRxQzJab1RrUTJnS3BUU3BTYllO?=
 =?utf-8?B?QXJOSlN3TXBnNmRJamJrWnE5WjM2WTJtSnIwSjI2QXR4TWUwSFRGNDROSURP?=
 =?utf-8?B?MW1wSVFZYmpSOVNRUlA5K0ZrNlVHNWo0ZDBiRlRWdnBvNTkwMGV3QWFJMUdO?=
 =?utf-8?B?SXBDSzV0YnRiVTkxKzVuTldxSkFnbXV2bE94VUZXeGRoem1SREFrUmVQanlQ?=
 =?utf-8?B?UnlWb2ZGTis5REpYQUNELzJKaTJzdVprelFZZ3hoZm9WemhhVExPMGlSV0pS?=
 =?utf-8?B?anJHRHo5azZhUFZ5Q1FWeldySWJUM2E3eGZOWW9vMWUwS0JEWWtLcW0zR3hU?=
 =?utf-8?B?VDc4VVpvaG9TNDNFRkYwSTRNUE5UK3JxZ0J3ZEo1NE0rYXlaaGRyTVVIRmtn?=
 =?utf-8?B?SVNsaW9LYllqdlBxSUhhaEVhV2xvVENNMGdVYXFydDd1eTFoaFJvdFpUa014?=
 =?utf-8?B?alJGeHBXMzNKK2tzSE84OE5iN2RXaDBMRlpIbHRsOExHMjhucG1zak8xa2Rs?=
 =?utf-8?B?R3RNNThscU8rNktRT1I0WU04UjVBdDNxWGtBNG5Pd3h1UjdIdllValc4eSt1?=
 =?utf-8?B?WkdNYjM2KytCbDRMcm5ZT1pDOXgwdTRDVFZ6ekxiTkxBbXA3QzltekxsVzlT?=
 =?utf-8?B?UkQ5cFB6aG1GeG55L2plNzB0WnZKR2ljYlNjb0tiR3JBeUMvQ0VlY1FYUEFT?=
 =?utf-8?B?a0tvQWt5NEppV284N3oyY3FoMVFSWlBDclcyUDE1dmc2SEFNKzJhQ2dxcS9i?=
 =?utf-8?B?OWlocDZTbWh4N1VMYXVGcytZbjhudFJEQ25yY3FvSVlSMXduWmNjd1ZsSFJV?=
 =?utf-8?B?NUJBRnloeDhTSmNxVnpwanlqTjRBK004bEV5SnQzRm95VFhXb1c4WWMyakx1?=
 =?utf-8?B?NEN2ODhBaHBGU1NnSzZDNW9pOExnWlZMQ1FGbVh4Mnk4d0hsU2NWT25jZHow?=
 =?utf-8?B?OFFiNU53WlNQRjZmdzFSYWFncEdNZWcwa2JwbWhqZDFpZEcvK1g2K3FzM1Fy?=
 =?utf-8?B?azhxNGE2ZGViRE14Z3NDbG1Kd0tZajNoWGtMeGZpb1dnbThqK1hKcG0ySzRH?=
 =?utf-8?Q?M/q8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR12MB5481.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: db94c5d7-86ab-4f6c-00a1-08dbb9ae60ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2023 07:51:20.0202 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tb+Peas80AuXTplDuT05i36rmTvqeSktNirRcIhhQK0iikKECeEaaZDGwvOb+g47pCEWLtj0NEdUo6EsWQ/3/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7640
Received-SPF: softfail client-ip=2a01:111:f400:7e88::626;
 envelope-from=parav@nvidia.com;
 helo=NAM10-DM6-obe.outbound.protection.outlook.com
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
IFdlZG5lc2RheSwgU2VwdGVtYmVyIDIwLCAyMDIzIDE6MTcgUE0NCg0KPiA+IFRoaXMgaXMgbm90
IGxpdmUgb3IgZGV2aWNlIG1pZ3JhdGlvbi4gVGhpcyBpcyByZXN0b3JpbmcgdGhlIGRldmljZSBj
b250ZXh0DQo+IGluaXRpYXRlZCBieSB0aGUgZHJpdmVyIG93bmluZyB0aGUgZGV2aWNlLg0KPiBy
ZXN0b3JlIHRoZSBkZXZpY2UgY29udGV4dCBzaG91bGQgYmUgZG9uZSBieSB0aGUgaHlwZXJ2aXNv
ciBiZWZvcmUgc2V0dGluZw0KPiBEUklWRVJfT0sgYW5kIHdha2luZyB1cCB0aGUgZ3Vlc3QsIG5v
dCBhIGNvbmNlcm4gaGVyZSwgb3V0IG9mIHNwZWMNCg0KVGhlIGZyYW1ld29yayBpcyBnZW5lcmlj
IGZvciB0aGUgUENJIGRldmljZXMgaGVuY2UsIHRoZXJlIG1heSBub3QgYmUgYW55IGh5cGVydmlz
b3IgYXQgYWxsLiBIZW5jZSByZXN0b3JlIG9wZXJhdGlvbiB0byB0cmlnZ2VyIG9uIERSSVZFUl9P
SyBzZXR0aW5nLCB3aGVuIHByZXZpb3VzbHkgc3VzcGVuZGVkLg0KDQpTaW5jZSB3ZSBhbHJlYWR5
IGFncmVlIGluIHByZXZpb3VzIGVtYWlsIHRoYXQgcmUtcmVhZCB1bnRpbCBkZXZpY2Ugc2V0cyB0
aGUgRFJJVkVSX09LLCBpdHMgZmluZSB0byBtZS4gSXQgY292ZXJzIHRoZSBhYm92ZSByZXN0b3Jl
IGNvbmRpdGlvbi4NCg0KVGhhbmtzLg0KDQo=

