Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A1F78F7A3
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 06:18:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbvaZ-0000re-1U; Fri, 01 Sep 2023 00:16:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qbvaV-0000rC-0w; Fri, 01 Sep 2023 00:16:51 -0400
Received: from mail-dm6nam11on2061d.outbound.protection.outlook.com
 ([2a01:111:f400:7eaa::61d]
 helo=NAM11-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tong.ho@amd.com>)
 id 1qbvaR-0007gh-S7; Fri, 01 Sep 2023 00:16:50 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BJyJzztaaRChxx4ghqEW+o/w1h2BbuUrauBwV33T48hPtEeEsvJpg+SOI4d868xTaJ9CQ1LCUoTMQE87xA6mdZHq9Gh17mJJkQVVe331fSwubkxV1jQR3hDbqXdvc5EozGcpGo3exhAPkunQnEByTzj95M7y4MPLqC23ObrANqC30N+CAnk2qiCXmxTdsBDCUfshl0lMYR7ts4PpeFRIKHpVNfDKvspa9pvnY5apONwy5o+F0KTag4db5Da31wYD6xs6luGMXmjK3f2qLjZouyUtrmW30o69P5I3G3m0CGRAvSQPPZamP58/W4rHN9Np1CHMh0xfdbrMouDoeI296Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l/9VhZv3LM3tlm67SpX8Iel04/VHHYjWcSY3WEFuKbo=;
 b=QqsdJ59HYqcfZFcBd6HOp8CgcBV1C8S7756PdLqXIaMteySpAFhgjFuke4Il5pnnGus1nl2Q0vhfEq128bgoE5iZjg3HE1bXWEg7SO0QEjgK68OyArt+4eSp61dRnXdcstsgKwcPgRgAhOm6D3vTS4OQEqBJ6mcAAh07nPXO7ZbDS6veOTk7OkxgLT00Qcdvqcs9yBDSKaG09yhJTS2e0HDaB4RVgfyKePsiYSbBbYmNc7qPqn5AJPCi09MwLoVVz2mLVIUPGMSqwsRnQ1bNlNGKa+8T6PeycfCIAMtmHkaZUqbSXK01T4cDLjgj7++/x5xR0pq2yg1N++pyyslARg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l/9VhZv3LM3tlm67SpX8Iel04/VHHYjWcSY3WEFuKbo=;
 b=Yr/+oJMriGWv7XCE6QDJ2NySwiK2TkiS1KQhOzowiulj9zLBU+bHI1MP2MtuasJwdOz+83ZSLGGsH2pSyjFdiSOsfC1DIXg+sWku8Zq0NXKfoA42bvz6ysb5Fzax8D13ZDrnfoJGvZ4MGxxhIooHrnlpXePvYkp2q2zWu+6+2ys=
Received: from BL0PR12MB4882.namprd12.prod.outlook.com (2603:10b6:208:1c3::10)
 by DM4PR12MB7501.namprd12.prod.outlook.com (2603:10b6:8:113::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.20; Fri, 1 Sep
 2023 04:16:43 +0000
Received: from BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::c8b1:9fbd:b3d5:693c]) by BL0PR12MB4882.namprd12.prod.outlook.com
 ([fe80::c8b1:9fbd:b3d5:693c%4]) with mapi id 15.20.6745.020; Fri, 1 Sep 2023
 04:16:43 +0000
From: "Ho, Tong" <tong.ho@amd.com>
To: Richard Henderson <richard.henderson@linaro.org>, "qemu-arm@nongnu.org"
 <qemu-arm@nongnu.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "alistair@alistair23.me"
 <alistair@alistair23.me>, "edgar.iglesias@gmail.com"
 <edgar.iglesias@gmail.com>, "peter.maydell@linaro.org"
 <peter.maydell@linaro.org>, "Ho, Tong" <tong.ho@amd.com>
Subject: RE: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
Thread-Topic: [PATCH 1/3] hw/misc: Introduce AMD/Xilix Versal TRNG device
Thread-Index: AQHZ3C85IdR/2hbobUC8AAIMe7DmJrAFEeUAgABB0kA=
Date: Fri, 1 Sep 2023 04:16:43 +0000
Message-ID: <BL0PR12MB48829589D59FA02B93549E65E6E4A@BL0PR12MB4882.namprd12.prod.outlook.com>
References: <20230831171849.3297497-1-tong.ho@amd.com>
 <20230831171849.3297497-2-tong.ho@amd.com>
 <622751d4-8a89-b34e-171f-9e9f7ac99972@linaro.org>
In-Reply-To: <622751d4-8a89-b34e-171f-9e9f7ac99972@linaro.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BL0PR12MB4882:EE_|DM4PR12MB7501:EE_
x-ms-office365-filtering-correlation-id: f80fac6f-5fac-49d4-cd57-08dbaaa23fea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: DTIynzT3oiRyd+UX6ZP/3DmrhvEuIhrzozJGGRWFRZBUG/gNQGGxIzb96U9DOfmhs3xWD630IhDDpyzAmRAv1LrDRmHg6A8SFO5qt0KwgyhJUsAA7+fn0uUGQq7SxY13b0j2N8hEQRrhslfhSHgAPulMYA560UCrxIgpSaOj7B73oeSh/eQGcdyIqwtQ3gTJ00M2rMX90aBTqPgwdX/zEag+n6irhmW99Os7ZJvflfA9TaGq/2GK9qdc2e78e5xmE5KWaIqdW+n3K27GriS+RaMZh3D4O5YrI7bh8Pn31ChiCm9RK4EirlB48OALEs7euXEmttjWe8UIcBwdEYxd7iE5+t3qv/1Jg5rHSfh8yldi7joeEcOIW2n6XqX58wvCyifHpUT5JoGPOpsR/6FECVy5ykCgbhHCKl8Tc4DH1oTjRR4QuVmHDe/7IPebmNOfy0VREhV43cDBV3Yw6H4WR1BY/QZspCfIpAUDF8xfUFoTeTnGq2y/Gr7AaXYjdoGEjm+tUiouLbDYg8QLZnqJDeJZiCdi6QB7tTwUFupFa6LSXEVt42O6JqC1umUrHK9pP/V1+aFB0ywIfUR9BDBwPsp+AvXns5X8VGdPRUNFGGrbmPsXFKftXOHonOjogtDI
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL0PR12MB4882.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(39860400002)(366004)(346002)(136003)(376002)(396003)(186009)(1800799009)(451199024)(55016003)(54906003)(66446008)(66556008)(316002)(66476007)(64756008)(66946007)(110136005)(38100700002)(122000001)(76116006)(38070700005)(2906002)(41300700001)(8936002)(86362001)(5660300002)(7696005)(4326008)(52536014)(8676002)(83380400001)(9686003)(53546011)(26005)(6506007)(71200400001)(33656002)(478600001);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Uy9rZU9YTVVQMlNqck5zZjNzczdmbVA1dTZyT3Q0VW5GWXM2eGlsdFFiSEJ6?=
 =?utf-8?B?UTBvMXR0NnRuS2hKODBySGdIbENCSGpxNmFRVjFvaDJVTzVPb3BSU2dwVi9i?=
 =?utf-8?B?REU3RTR1Zmt2YUJ4ekpkZ0NCbXVjOGtscGVSejNIS0FlSEsxWXNGUFgwMktP?=
 =?utf-8?B?ZFNJbUxXV0VpUzVMVEVDS01JMkJEOS8xZVA0SlVoT3g4dnhOZ2p1cjlQK3pB?=
 =?utf-8?B?Z0g2azdJQjM5NC9LaVFiekljM2Rtc3dSb1RNT0hIQ0VhUTRESWtpWjgyQkZw?=
 =?utf-8?B?ZG0yZnFSZkVLa1lJcnVWUHlUN21SN1ZvZTVZN0M1WGhnaUVKejY3aWZITUNC?=
 =?utf-8?B?Ty8xc1ltb0NCTlNDWVlGSzIzU25jdU5DVlRXYjE3cisvWVQzM3ZrdE9wblF3?=
 =?utf-8?B?cmd4MDVXU0xTb01ib1ByL0VKY0NHZmE3RjEvRE1aYys5MW5tckd2ejBtMk9H?=
 =?utf-8?B?MlZvUWpNKy8wcm1hOG44MFozSzJWaDRqUlI2OXNZL25yVFNEamVIZlZwcHpV?=
 =?utf-8?B?UGZPdGUrQXpqblc5bGd0dml6bWZOQ09oa1dHVkRQbEJjdnNzN3NhK2VXS2N0?=
 =?utf-8?B?di9jdkRyUzcyZmx6cXhqcW1YV3dxSncvYmdIQ3ZtUEgxY3c3L2V4OEdXTUtt?=
 =?utf-8?B?eVF5Q3pyQ3FaYjYrOHpjYkJQUHlLNVNkcXVxRk1oakVJVUROM1Jxa0NFUWg3?=
 =?utf-8?B?U0E3bTREdVJ4d1ZiYjU5c0ZUeEpMUDJXdnN4MmhYVzBhVGRqclkwMloySnNh?=
 =?utf-8?B?L3ZRdzd2OUFYTWlsWUNKbTJsSm5yQWtpRUI2SWhjY05GM1E2bm00cU4yeVN0?=
 =?utf-8?B?OTFUODhJMzBLS2JIVEF5dElOYVVkRUNvZlJWL3BGaDBHd1JRTDRpcUlRQlRE?=
 =?utf-8?B?NTJYM3diN1ZwbmdOR1JkVlQ5aXJSV2NDTU1SM3N2UFpNVWt2VkRIbXA5QUs4?=
 =?utf-8?B?R2lsaWl0UVNXTkx4a0ZsNXV5YU1DalRmeDllSWpNSUZOWlQ3Sk43NmRPb0RD?=
 =?utf-8?B?TWZwUFdKZWp1V3BCUFBRVUsxV05OSS94YkllQ0xCSkNudFEzd0JEeG83dklo?=
 =?utf-8?B?cXZiVzNIUU5lRVU5UkNTVmhUTVZRVkkzbWlNRHV5THpQd0R4UHBqenRJU2gw?=
 =?utf-8?B?TmhoMTZJN0tsL3J2T2RZUEVDMnRHUElPUWRwbUNjQklSamc1Y0trdGlZL1JC?=
 =?utf-8?B?QktYRDFWdkJxNFZkcUVYOUhyeW1rSk1pZi8ya1JhdFo4TXZtQUwxSDg1UERm?=
 =?utf-8?B?RFZySEZtZ2dhd2lGc3hWQWNTU21LeURUOGVxaU50aGxLeXRaSWZnOCtXcVRz?=
 =?utf-8?B?NlNGNWs4NkxwMUF0eDhVTEZhNFdXTW15MUU5c0ZKNEdCWTAzVUcyYUF3alNO?=
 =?utf-8?B?M3AvaGJ2b3pYdDAxY0k0V1RlZWFDaFp3MDczODBYY2NnNFkyRjZWYytGS0tw?=
 =?utf-8?B?L1V6VTE5SXNKNE1GMVRaSmVPRzF4OHV5WXpRWGlJTWtzS0E3S3ZINmQzRUFK?=
 =?utf-8?B?TU95L3NDM0lkaTdXbTUzN3BFejRvYVVpcW10M3FmUnVKSENJc3pmUGlHNmw2?=
 =?utf-8?B?SkdBMFhWbEhPMzNiSVJySVlyTFV3Zi9KMFdkeU1BRTFlNEJvMTAxQ2lHVy95?=
 =?utf-8?B?MEFWQk10Vmo4ZExyVXR1c3BZc0FmekFSMU9Tc1d6aHVrZ3N4My8yWDRFUEhy?=
 =?utf-8?B?Q0pORXlYTWZMc3JVTU5qZmFJb3BscDhsVGxRSVhZaWk3M2wyUmNFMHB1ZEVr?=
 =?utf-8?B?QnNrdDRRKzFEZWFUTzNrNFlZRmM1UjZMY1ZxSnJNU3dNaFVqQzV2cTdVT3Nm?=
 =?utf-8?B?djZTSUlZT2RoNWpTTUxsZzdjRE4xdDRDRUkwbEordlp4NUd6MDVrWWFQMWxz?=
 =?utf-8?B?Y2hsYmVuYnFqVGlNV3hKeW03c1YwempubkdUWHpLRDVaSkU1WkdZUWRjbks1?=
 =?utf-8?B?WHp5NlRKKytnaGZuL2JuaklUc2ZiU3NoMVp2MjlkMCtMa1l3UzhzRnlaeWVu?=
 =?utf-8?B?eXF0ZzJMamxpRW1KKzJEMUdtMXpyUXFhcTZSR2lTTFpPT2RtZ09CSW1pY0RL?=
 =?utf-8?B?UUZkOWROUU5ldE1OcHB1R1lmdzN0ZkZCZnZ6ejlDZG5ZZ3FRSzBUQXZ4d2ov?=
 =?utf-8?Q?mvL0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB4882.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f80fac6f-5fac-49d4-cd57-08dbaaa23fea
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2023 04:16:43.6385 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Yyz6lhlO029pYG2gEA74hYselPpazBtXxmvLaMFmueO6ES25s2iagEyi3BX5nWAn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7501
Received-SPF: softfail client-ip=2a01:111:f400:7eaa::61d;
 envelope-from=tong.ho@amd.com;
 helo=NAM11-DM6-obe.outbound.protection.outlook.com
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

SGkgUmljaGFyZCwNCg0KVGhhbmtzIGZvciB5b3VyIGlucHV0Lg0KDQpJIGhhdmUgcXVlc3Rpb25z
IHJlZ2FyZGluZyB1c2luZyBxZW11L2d1ZXN0LXJhbmRvbS5oIGZvciBRRU1VIGRldmljZSBtb2Rl
bHMuDQoNClVzaW5nIHFlbXUvZ3Vlc3QtcmFuZG9tLmgsIGhvdyBjYW4gdGhpcyBUUk5HIG1vZGVs
IGVuc3VyZSBpdHMgaW5kZXBlbmRlbmNlIGZyb20NCm90aGVyIHVzZXMgb2YgdGhlIHNhbWUgcWVt
dV9ndWVzdF9nZXRyYW5kb20oKSBhbmQgcWVtdV9ndWVzdF9yYW5kb21fc2VlZF8qKCk/DQoNCkJ5
ICJvdGhlciB1c2VzIiwgSSBtZWFuIGNvbXBvbmVudHMgYW5kL29yIGRldmljZXMgdXNpbmcgcWVt
dS9ndWVzdC1yYW5kb20uaCBidXQgdW5yZWxhdGVkIHRvIHRoaXMgWGlsaW54IFZlcnNhbCBUUk5H
IGRldmljZS4NCg0KQnkgImluZGVwZW5kZW50IiwgSSBtZWFuIHRoZSBYaWxpbnggVmVyc2FsIFRS
TkcgZGV2aWNlIGlzOg0KDQoxLiBOb3QgaW1wYWN0ZWQgYnkgb3RoZXIgdXNlcyB0aGF0IG1heSBv
ciBtYXkgbm90IG5lZWQgdG8gc2V0IHRoZSAnLXNlZWQnIG9wdGlvbiwgYW5kDQoNCjIuIE5vdCBp
bXBhY3Rpbmcgb3RoZXIgdXNlcyBqdXN0IGJlY2F1c2UgYSBYaWxpbnggVmVyc2FsIG1hY2hpbmUg
dXNlciBkZWNpZGVzIHRvIHVzZSBkZXRlcm1pbmlzdGljIG1vZGUgKm9ubHkiIGZvciB0aGlzIFRS
TkcgZGV2aWNlLg0KDQpBbHNvLCBJIGFtIGF0IGEgbG9zcyBpbiBob3cgdW5yZWxhdGVkIFFFTVUg
ZGV2aWNlcyBjYW4gcmVtYWluIGluZGVwZW5kZW50IHdoZW46DQoNCjMuIHFlbXUvZ3Vlc3QtcmFu
ZG9tLmggdXNlcyAnX190aHJlYWQnIHZhcmlhYmxlIGZvciBHUmFuZCBjb250ZXh0LCBidXQNCg0K
NC4gUUVNVSBkZXZpY2VzIHJ1biBtb3N0bHkgYXMgY28tcm91dGluZXMgYW5kIG5vdCBhcyBzZXBh
cmF0ZSB0aHJlYWRzLg0KDQpJIHN1cHBvc2UgdGhlIFZlcnNhbCBUUk5HIGltcGxlbWVudGF0aW9u
IGNvdWxkIHVzZSBnX3JhbmRfKigpIGRpcmVjdGx5LA0KaGF2aW5nIGEgR1JhbmQgb2JqZWN0IGlu
IHRoZSBkZXZpY2Ugc3RhdGUgYW5kIHNlZWRpbmcgdGhyb3VnaCBnX3JhbmRfc2V0X3NlZWRfYXJy
YXkoKS4NCg0KQmVzdCByZWdhcmRzLA0KVG9uZyBIbw0KDQotLS0tLU9yaWdpbmFsIE1lc3NhZ2Ut
LS0tLQ0KRnJvbTogUmljaGFyZCBIZW5kZXJzb24gPHJpY2hhcmQuaGVuZGVyc29uQGxpbmFyby5v
cmc+IA0KU2VudDogVGh1cnNkYXksIEF1Z3VzdCAzMSwgMjAyMyA0OjQ1IFBNDQpUbzogSG8sIFRv
bmcgPHRvbmcuaG9AYW1kLmNvbT47IHFlbXUtYXJtQG5vbmdudS5vcmcNCkNjOiBxZW11LWRldmVs
QG5vbmdudS5vcmc7IGFsaXN0YWlyQGFsaXN0YWlyMjMubWU7IGVkZ2FyLmlnbGVzaWFzQGdtYWls
LmNvbTsgcGV0ZXIubWF5ZGVsbEBsaW5hcm8ub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIDEvM10g
aHcvbWlzYzogSW50cm9kdWNlIEFNRC9YaWxpeCBWZXJzYWwgVFJORyBkZXZpY2UNCg0KT24gOC8z
MS8yMyAxMDoxOCwgVG9uZyBIbyB3cm90ZToNCj4gVGhpcyBhZGRzIGEgbm9uLWNyeXB0b2dyYXBo
aWMgZ3JhZGUgaW1wbGVtZW50YXRpb24gb2YgdGhlIG1vZGVsIGZvciANCj4gdGhlIFRydWUgUmFu
ZG9tIE51bWJlciBHZW5lcmF0b3IgKFRSTkcpIGNvbXBvbmVudCBpbiBBTUQvWGlsaW54IFZlcnNh
bCANCj4gZGV2aWNlIGZhbWlseS4NCj4gDQo+IFRoaXMgbW9kZWwgaXMgb25seSBpbnRlbmRlZCBm
b3Igbm9uLXJlYWwgd29ybGQgdGVzdGluZyBvZiBndWVzdCANCj4gc29mdHdhcmUsIHdoZXJlIGNy
eXB0b2dyYXBoaWNhbGx5IHN0cm9uZyBUUk5HIGlzIG5vdCBuZWVkZWQuDQo+IA0KPiBUaGlzIG1v
ZGVsIHN1cHBvcnRzIHZlcnNpb25zIDEgJiAyIG9mIHRoZSBWZXJzYWwgVFJORywgd2l0aCBkZWZh
dWx0IHRvIA0KPiBiZSB2ZXJzaW9uIDI7IHRoZSAnaHctdmVyc2lvbicgdWludDMyIHByb3BlcnR5
IGNhbiBiZSBzZXQgdG8gMHgwMTAwIHRvIA0KPiBvdmVycmlkZSB0aGUgZGVmYXVsdC4NCj4gDQo+
IE90aGVyIGltcGxlbWVudGVkIHByb3BlcnRpZXM6DQo+IC0gJ2ZvcmNlZC1wcm5nJywgdWludDY0
DQo+ICAgIFdoZW4gc2V0IHRvIG5vbi16ZXJvLCAidHJ1ZSByYW5kb20gcmVzZWVkIiBpcyByZXBs
YWNlZCBieQ0KPiAgICBkZXRlcm1pbmlzdGljIHJlc2VlZCBiYXNlZCBvbiB0aGUgZ2l2ZW4gdmFs
dWUgYW5kIG90aGVyDQo+ICAgIGRldGVybWluaXN0aWMgcGFyYW1ldGVycywgZXZlbiB3aGVuIGd1
ZXN0IHNvZnR3YXJlIGhhcw0KPiAgICBjb25maWd1cmVkIHRoZSBUUk5HIGFzICJ0cnVlIHJhbmRv
bSByZXNlZWQiLiAgVGhpcyBvcHRpb24NCj4gICAgYWxsb3dzIGd1ZXN0IHNvZnR3YXJlIHRvIHJl
cHJvZHVjZSBkYXRhLWRlcGVuZGVudCBkZWZlY3RzLg0KPiANCj4gLSAnZmlwcy1mYXVsdC1ldmVu
dHMnLCB1aW50MzIsIGJpdC1tYXNrDQo+ICAgIGJpdCAzOiBUcmlnZ2VycyB0aGUgU1A4MDAtOTBC
IGVudHJvcHkgaGVhbHRoIHRlc3QgZmF1bHQgaXJxDQo+ICAgIGJpdCAxOiBUcmlnZ2VycyB0aGUg
RklQUyAxNDAtMiBjb250aW51b3VzIHRlc3QgZmF1bHQgaXJxDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBUb25nIEhvPHRvbmcuaG9AYW1kLmNvbT4NCj4gLS0tDQo+ICAgaHcvbWlzYy9LY29uZmlnICAg
ICAgICAgICAgICAgICAgICB8ICAgMyArDQo+ICAgaHcvbWlzYy9tZXNvbi5idWlsZCAgICAgICAg
ICAgICAgICB8ICAgMyArDQo+ICAgaHcvbWlzYy94bG54LXZlcnNhbC10cm5nLmMgICAgICAgICB8
IDcyNSArKysrKysrKysrKysrKysrKysrKysrKysrKysrKw0KPiAgIGluY2x1ZGUvaHcvbWlzYy94
bG54LXZlcnNhbC10cm5nLmggfCAgNTggKysrDQo+ICAgNCBmaWxlcyBjaGFuZ2VkLCA3ODkgaW5z
ZXJ0aW9ucygrKQ0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBody9taXNjL3hsbngtdmVyc2FsLXRy
bmcuYw0KPiAgIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL2h3L21pc2MveGxueC12ZXJzYWwt
dHJuZy5oDQoNCkkgZG9uJ3QgdGhpbmsgeW91IHNob3VsZCBiZSBpbnZlbnRpbmcgYW5vdGhlciBQ
Uk5HLCBvciByZWxhdGVkIHByb3BlcnRpZXMuDQoNCldlIGFscmVhZHkgaGF2ZSBxZW11L2d1ZXN0
LXJhbmRvbS5oLCBhbmQgdGhlIC1zZWVkIGNvbW1hbmQtbGluZSBwYXJhbWV0ZXIgdG8gZm9yY2Ug
dGhlIHVzZSBvZiBhIGRldGVybWluaXN0aWMgUFJORyB3aXRoIGEgZ2l2ZW4gc2VlZCB2YWx1ZS4N
Cg0KDQpyfg0K

