Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CDF7AAC1B
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 10:12:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjbG1-0000jt-Ew; Fri, 22 Sep 2023 04:11:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qjbFz-0000jA-5R; Fri, 22 Sep 2023 04:11:23 -0400
Received: from mail-dm6nam04on20625.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::625]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ankita@nvidia.com>)
 id 1qjbFw-00045S-8U; Fri, 22 Sep 2023 04:11:22 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vi9qWED7l3nWdC4I33tnYFJqs6yNQiQAiuZKhMHeM8tnxEc1gQSi5Hu6AzOnwa/ddz3GzO5nXH1kVZuQ7NDzTtgSfHvcrkN92o0EehZCOPHxOhvGKQ2MZ6dtry0tfUjF/7pEAUtNXuM0CXJ0dp/5Lr/HYGDjt6MfAg3wvFn/EPwk1529h6K066Y3cjPYlXVmkGuQ6kApVOx4PsGSyp2JP5Z0gB1TsRt5cKOsHIKU0f+umKUoy5FdHPez7T2D5DdArGcwlYyK65md8INq2NduTMarQG6RgWLDnT49/SxLaJ3gwMGjg79PKnTDCdn1R+VpnZNTPblS5/ebq+cG8SOj2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ypUzZNRhNe/8s5OX7J0bGUlf9JEJ+s+KTMCKlG0xWD8=;
 b=D+1S8WsMSmUdA5ELwiGdgI2otmTYzQ+nov5zZ23wlVDApLGLwyIbevXzylDO4VcRh0wvPsNC6UmjI6qfaZUUgxSJjYi6n4Pk29MVYPwQZGI/kLMFIBjCphEm7Y+FOMRyF6mUeAQTAffzAMaURh99gif6DCBjIZUm83Na8zzkS+1Gbi58Rz/IsbJGuuHN9Yuwzd+7HT6DpAIH+Gtx6qkYVVtzbyuF8p+y/q2hEC1WluOg8LF/PvE/4K4mBr1cQosZgADKtulBszTvn8tKxDH+No9CKH0jmX5/+3bhN2XUXVVku10qLYd/uo7LiDCEX8uMsZ0mBMn2xqxhRMYZZ/jMzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ypUzZNRhNe/8s5OX7J0bGUlf9JEJ+s+KTMCKlG0xWD8=;
 b=mGJEAHZOjexzANkVP8Qdd1z0zLiDV4bFgPxTRN5TEsKLXsT+Lhq/8w3ncK6b3wFnJwHY5RvQk0X4thru4nh276ZEg/WtA0DT717wgd6jeK+ZV+RwzeOFnYZuwiFFR6SnESm6z4cf+WoCOvpWNvmGCDaq34navx73RviEEGLkG17Dqd7XxF42oG5zAP8XxqVrsP8Wiulx3jjpw6xq7xVojfTpDCcWRIy+HtH4OIC637EKWAh+x3q/YN0EEJx27AEsE24leVkvYL4xLyfLn5D1soa10xexMp/bcDJCRs8h9P1wKDIrGPrDtVBSNdyIbhiwiyBt62wh0t/Jf2e159robw==
Received: from BY5PR12MB3763.namprd12.prod.outlook.com (2603:10b6:a03:1a8::24)
 by LV2PR12MB5821.namprd12.prod.outlook.com (2603:10b6:408:17a::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Fri, 22 Sep
 2023 08:11:16 +0000
Received: from BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060]) by BY5PR12MB3763.namprd12.prod.outlook.com
 ([fe80::9e7a:4853:fa35:a060%2]) with mapi id 15.20.6813.017; Fri, 22 Sep 2023
 08:11:15 +0000
From: Ankit Agrawal <ankita@nvidia.com>
To: David Hildenbrand <david@redhat.com>, Alex Williamson
 <alex.williamson@redhat.com>, =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?=
 <clg@redhat.com>
CC: Jason Gunthorpe <jgg@nvidia.com>, "shannon.zhaosl@gmail.com"
 <shannon.zhaosl@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "ani@anisinha.ca" <ani@anisinha.ca>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Vikram
 Sethi <vsethi@nvidia.com>, Andy Currid <ACurrid@nvidia.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: RE: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Topic: [PATCH v1 0/4] vfio: report NUMA nodes for device memory
Thread-Index: AQHZ537JxLWb7mRoJ0CHc31F6ORMKbAb8EmAgAAH8ACAAD9dgIAKT71w
Date: Fri, 22 Sep 2023 08:11:14 +0000
Message-ID: <BY5PR12MB3763FA9922B9059DC14CA80DB0FFA@BY5PR12MB3763.namprd12.prod.outlook.com>
References: <20230915024559.6565-1-ankita@nvidia.com>
 <d09b3df6-74f8-c93b-b26e-59de5b2dd114@redhat.com>
 <20230915084754.4b49d5c0.alex.williamson@redhat.com>
 <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
In-Reply-To: <f129b30b-bd0c-4e30-6be9-384b2b79a26b@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BY5PR12MB3763:EE_|LV2PR12MB5821:EE_
x-ms-office365-filtering-correlation-id: 8bb2e72c-de69-4a93-57aa-08dbbb437da1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lgvpxHvLYAVmW/rKmEgxqhvN8ksuJCIJlW7AmMA2blw+9yLySLa0qaT37ckahV0QWnlOgUhjqpA2JEYz8u6iCZK7vEQnfIOs7M+6pLZru6EVeZN/4LnXrAMlncpstJJzQGPlU8LTG2r7CoqwrYF1QAl5agAlSuSxLJpQd9iDwFszQWWVmBSpt2z/5KaCuZ64tW9xtMSltJjoNXAvEBBCYqq7dbEozacnB/xSeEv/CEb7sPm0VVhrLSjJuNgEo5KPKVjSucMs43OERVYHidofEZeekNlSLMRTS/WM/oSrhTutfBcus9K/yPXn6xtWTcVvE9DflWNHmleG6LjDp1C3kSO07FBGx1xMUswMvB4xFJsPiGyCIlv+CzF+cmoCI0T1TzQT77lkAGRFzAAD4rlUJcGzV3RGL2Ov7QS2Mj25QI6hVpBQ5OyedyuOqWn/ZxUBCbmWP/dSG0COUFC4zsfcBwDYFuuyLv4Vj2NLWeLoBOkt5aDiNXV2h6AhDSxe/lxNZZ1QXwz4OEjpfYZrl/eMtDbdu9ww30MoZCpSjU3llSrpdIyuUwCC53AruAdsr7o1BpG0E6kUrI7OOg8rIdc5+7zjcraOq3ZXHScfQoB84Qg=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BY5PR12MB3763.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(186009)(451199024)(1800799009)(86362001)(33656002)(55016003)(71200400001)(8676002)(4326008)(7696005)(6506007)(122000001)(2906002)(38070700005)(38100700002)(83380400001)(8936002)(26005)(5660300002)(9686003)(41300700001)(316002)(966005)(52536014)(110136005)(66946007)(66556008)(66446008)(54906003)(76116006)(64756008)(66476007)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RURKTEV4bStwUSsycGpaMEZCMldNQ0M3U1BRcjdOcXFOZnUzMVFjckhKbHJx?=
 =?utf-8?B?TXl0QzNHbGNQT2FKYmZyeEVwRWkrd1hxSlZFU2hUM3FpMjBITVpmZk0rTHlD?=
 =?utf-8?B?aDVaQkdEb0h0eGtZUEFNYzZtZnk3RVN2UlNydG1rZENYTmQrUGd6ODBrOXZr?=
 =?utf-8?B?M1U0b3dORVJzQ2FJdkJsMVJ1UjFOYmpvLzhKM0xTelkwMUhsR0FMTHlaOTB1?=
 =?utf-8?B?TWV6elhKV1QxUmpDM2xOZXFXSGY3Qk5ERUlHNHZuN0VXbVJYK21EZ1dwcWNI?=
 =?utf-8?B?ZWxra1I3a0J0MVdIUmswZnNBK1ZJRnJUZkZ1d1QzNjhqSFQraTcyNVAzbG1p?=
 =?utf-8?B?amxLOHRTRmJ0ZmdqenNuUW92RnZ5cmVjK29BbVFHZG9ycndsaG5NTHBXWE52?=
 =?utf-8?B?TllORVhQN3V5WUY5ZGdwQzJORVRxbVhlZ1crNlZ1dVV6UjgyUHhNTTd2NzZR?=
 =?utf-8?B?K004N2dYdTNHL05WU0V3Q251RlIreTFReHZRTyt1Sk9FTDNRVmc0ZWpoTHls?=
 =?utf-8?B?RkRhZldCdmRaOHRBbDVuMzFGcFBwcE1NK0dYT0tGZnJXK1Avc3c2RWlReDJm?=
 =?utf-8?B?TDNzK2ZDT0hDWjRPUVlJZlcyN1hEaTZQNFdjZXRyQTVHNnBwblA3VHdRSTVz?=
 =?utf-8?B?RVlWNzloaExZeE5qYk03UFZhYlZGVnFJWmtjU0MzN0psQkpMa01uMXhPWXRk?=
 =?utf-8?B?Q1pPTFowU29Qb1pibDlxbERodnlOdm15TC9GNUxpM3lRM3NZYkRJT21DOE0y?=
 =?utf-8?B?eWVwTkZPdy9iajd4SGFrb1pwUjUrZUNnTmhBTFp6OUU1UzZ0UTJFMG05OGh0?=
 =?utf-8?B?bi9YWW1BTmUvUW5BMXRNWG1oT2puUzl0bFRVckM5dml6VEc1Y0JVRHZKSlpn?=
 =?utf-8?B?TlJwWCt0MVF6QjNxOGUydFZaUmgyK1NyNThhVlljN1Z6cFpnUXFSekdENDd2?=
 =?utf-8?B?azJRemkvTk81ZlVNS1lGMnZoQzZLdjdERDNpdSt6QmluZElGczNFSGlMRStY?=
 =?utf-8?B?NU4vVHN1WThIR2FDSVgwUjR6ejNiREt3cXFldmV3STNua0E1NEp3ZEJGVDFx?=
 =?utf-8?B?QVMrVkcveTFvMWZWdllZVnlOTzRxOVd1ZzlhNTBSZnovdFBOcFdvWVBRYnpK?=
 =?utf-8?B?YWkxYXNBSnRNMEZwNlAyODBMaXdpbjdNKy9DbG03UWM2djNOVElQVWhnYnVx?=
 =?utf-8?B?NlVUNVVRamEvUzJuSG9nM0p2TktONHE3NUxuL21yOTc4enloekVKc3ArZkxt?=
 =?utf-8?B?b0RYK28xV0Y0YlpiRkF1aG5lMDg2UWRNV1ZKSzVoYnJUTVJVemRZcGUybGw2?=
 =?utf-8?B?SHU2c1IrQytNZHp3c0k0TlBqeVZFcDdHcHVXenRNemFFWUdDRzEvWldQQnN2?=
 =?utf-8?B?ZllSc1E0VkRlL2loamk5SHdSNWMzTU9ST1lRVTlMWTdtTnorbzFGazFDSDlj?=
 =?utf-8?B?dnY2ZVB6Z0xUTXpFUjhuYlRWNjNFVS83VWE2V2RXR3c2S0lBbG0rODdOY09x?=
 =?utf-8?B?V1pnUVVCVU10d0tBclF4WUcwTUltek9qWkNPZEdRVFE5OURQWVlVbi96RUhv?=
 =?utf-8?B?MGZhSjk0UzBXenVkUmpNUnZjWVkxY1FpMmkrU2xoOWQ1SHZwejFqUXJqWFg3?=
 =?utf-8?B?SCtrb05zR2JaSDc3bTJZL3orZTFET3RpZUxqY1VveTFzL0NwVVo2bVkvS0NI?=
 =?utf-8?B?QzdOK2s3ZytSSS8vVmpYZ3FNNForSnRpT3c4TnRPc3JxR1VPN09Ed3FWSFVt?=
 =?utf-8?B?NTBPRG1UTktRc0x6MmMxd3BXRFEyQy92UTk3NjZSUDJsZEY3VWxCT2pOMnlV?=
 =?utf-8?B?UnozM3lYb281aEN0ejVtdnUxUGR0VzBZd0hoUW5pYm5sRFJiczVrMmhXbElS?=
 =?utf-8?B?Y0tHTi8rbFQ0eldpYkVnenRZR3BOQjEzOW5HWTlEaWNHK3VxdGt2V3UxYmoy?=
 =?utf-8?B?dE14ZjlQL2VVMVliZXVMMW5aSjJLbnFZRXFoUzRFKzliYTRTcEwxYzhoeFFC?=
 =?utf-8?B?UUd0UERwMDQ0VjFpK3pJaEo1dU9OOTRVT3RLcm55dVA3d0ZiUE9OUDlaazQw?=
 =?utf-8?B?cytFenV5M1lZZFJVQXpEaHZYU1RreGxJaTJEZTU3MUU1WThrTEh4WWg3UzBz?=
 =?utf-8?Q?WfeMPe+Tr4tYRSjQqhYC5G5Gg?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3763.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bb2e72c-de69-4a93-57aa-08dbbb437da1
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Sep 2023 08:11:14.7616 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 85UVWUBKByfy/Xu24imZgTJEbuOw32BabctB7WJPYCY0udOhfYtsmarhvL/j2dtBFjQLX5uLJ2ylzyeGnUdlLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5821
Received-SPF: softfail client-ip=2a01:111:f400:7e8b::625;
 envelope-from=ankita@nvidia.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
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

PiA+Pg0KPiA+PiBUeXBpY2FsbHksIGEgY29tbWFuZCBsaW5lIGZvciBhIHZpcnQgbWFjaGluZSB3
aXRoIE5VTUEgbm9kZXMgd291bGQNCj4gPj4gbG9vayBsaWtlIDoNCj4gPj4NCj4gPj4gICAgIC1v
YmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtLGlkPXJhbS1ub2RlMCxzaXplPTFHIFwNCj4gPj4gICAg
IC1udW1hIG5vZGUsbm9kZWlkPTAsbWVtZGV2PXJhbS1ub2RlMCBcDQo+ID4+ICAgICAtb2JqZWN0
IG1lbW9yeS1iYWNrZW5kLXJhbSxpZD1yYW0tbm9kZTEsc2l6ZT0xRyBcDQo+ID4+ICAgICAtbnVt
YSBub2RlLG5vZGVpZD0xLGNwdXM9MC0zLG1lbWRldj1yYW0tbm9kZTENCj4gPj4NCj4gPj4gd2hp
Y2ggZGVmaW5lcyAyIG5vZGVzLCBvbmUgd2l0aCBtZW1vcnkgYW5kIGFsbCBDUFVzIGFuZCBhIHNl
Y29uZCB3aXRoDQo+ID4+IG9ubHkgbWVtb3J5Lg0KPiA+Pg0KPiA+PiAgICAgIyBudW1hY3RsIC1I
DQo+ID4+ICAgICBhdmFpbGFibGU6IDIgbm9kZXMgKDAtMSkNCj4gPj4gICAgIG5vZGUgMCBjcHVz
OiAwIDEgMiAzDQo+ID4+ICAgICBub2RlIDAgc2l6ZTogMTAwMyBNQg0KPiA+PiAgICAgbm9kZSAw
IGZyZWU6IDczNCBNQg0KPiA+PiAgICAgbm9kZSAxIGNwdXM6DQo+ID4+ICAgICBub2RlIDEgc2l6
ZTogOTc1IE1CDQo+ID4+ICAgICBub2RlIDEgZnJlZTogOTY4IE1CDQo+ID4+ICAgICBub2RlIGRp
c3RhbmNlczoNCj4gPj4gICAgIG5vZGUgICAwICAgMQ0KPiA+PiAgICAgICAwOiAgMTAgIDIwDQo+
ID4+ICAgICAgIDE6ICAyMCAgMTANCj4gPj4NCj4gPj4NCj4gPj4gQ291bGQgaXQgYmUgYSBuZXcg
dHlwZSBvZiBob3N0IG1lbW9yeSBiYWNrZW5kID8gIEhhdmUgeW91IGNvbnNpZGVyZWQNCj4gPj4g
dGhpcyBhcHByb2FjaCA/DQo+ID4NCj4gPiBHb29kIGlkZWEuICBGdW5kYW1lbnRhbGx5IHRoZSBk
ZXZpY2Ugc2hvdWxkIG5vdCBiZSBjcmVhdGluZyBOVU1BDQo+ID4gbm9kZXMsIHRoZSBWTSBzaG91
bGQgYmUgY29uZmlndXJlZCB3aXRoIE5VTUEgbm9kZXMgYW5kIHRoZSBkZXZpY2UNCj4gPiBtZW1v
cnkgYXNzb2NpYXRlZCB3aXRoIHRob3NlIG5vZGVzLg0KPiANCj4gKzEuIFRoYXQgd291bGQgYWxz
byBtYWtlIGl0IGZseSB3aXRoIERJTU1zIGFuZCB2aXJ0aW8tbWVtLCB3aGVyZSB5b3UNCj4gd291
bGQgd2FudCBOVU1BLWxlc3Mgbm9kZXMgYXNzIHdlbGwgKGltYWdpbmUgcGFzc2luZyBDWEwgbWVt
b3J5IHRvIGEgVk0NCj4gdXNpbmcgdmlydGlvLW1lbSkuDQo+IA0KDQpXZSBhY3R1YWxseSBkbyBu
b3QgYWRkIHRoZSBkZXZpY2UgbWVtb3J5IG9uIHRoZSBob3N0LCBpbnN0ZWFkDQptYXAgaXQgaW50
byB0aGUgUWVtdSBWTUEgdXNpbmcgcmVtYXBfcGZuX3JhbmdlKCkuIFBsZWFzZSBjaGVja291dCB0
aGUNCm1tYXAgZnVuY3Rpb24gaW4gdmZpby1wY2kgdmFyaWFudCBkcml2ZXIgY29kZSBtYW5hZ2lu
ZyB0aGUgZGV2aWNlLg0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjMwOTE1MDI1NDE1
LjY3NjItMS1hbmtpdGFAbnZpZGlhLmNvbS8NCkFuZCBJIHRoaW5rIGhvc3QgbWVtb3J5IGJhY2tl
bmQgd291bGQgbmVlZCBtZW1vcnkgdGhhdCBpcyBhZGRlZCBvbiB0aGUNCmhvc3QuDQoNCk1vcmVv
dmVyIHNpbmNlIHdlIHdhbnQgdG8gcGFzc3Rocm91Z2ggdGhlIGVudGlyZSBkZXZpY2UgbWVtb3J5
LCB0aGUNCi1vYmplY3QgbWVtb3J5LWJhY2tlbmQtcmFtIHdvdWxkIGhhdmUgdG8gYmUgcGFzc2Vk
IGEgc2l6ZSB0aGF0IGlzIGVxdWFsDQp0byB0aGUgZGV2aWNlIG1lbW9yeS4gSSB3b25kZXIgaWYg
dGhhdCB3b3VsZCBiZSB0b28gbXVjaCBvZiBhIHRyb3VibGUNCmZvciBhbiBhZG1pbiAob3IgbGli
dmlydCkgdHJpZ2dlcmluZyB0aGUgUWVtdSBwcm9jZXNzLg0KDQpCb3RoIHRoZXNlIGl0ZW1zIGFy
ZSBhdm9pZGVkIGJ5IGV4cG9zaW5nIHRoZSBkZXZpY2UgbWVtb3J5IGFzIEJBUiBhcyBpbiB0aGUN
CmN1cnJlbnQgIGltcGxlbWVudGF0aW9uIChyZWZlcmVuY2VkIGFib3ZlKSBzaW5jZSBpdCBsZXRz
IFFlbXUgdG8gbmF0dXJhbGx5DQpkaXNjb3ZlciB0aGUgZGV2aWNlIG1lbW9yeSByZWdpb24gYW5k
IGRvIG1tYXAuDQoNCg==

