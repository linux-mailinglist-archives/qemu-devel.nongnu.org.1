Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7963C73DFEA
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 14:59:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDlnY-0002SF-U2; Mon, 26 Jun 2023 08:58:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qDlnV-0002Q0-Cf
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:58:25 -0400
Received: from mail-db3eur04on2040.outbound.protection.outlook.com
 ([40.107.6.40] helo=EUR04-DB3-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <john.hogberg@ericsson.com>)
 id 1qDlnT-0002DT-Gn
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 08:58:25 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=InMxqcxoEqRqAckdjN/kEGofDBDirnMPu8p8G9jbP7TVPX8lwgNRE72wgmcIfpZnlD6QH+OUuZgibU4MpibYpkby4OCUmFsG0uOPuqAF/pMyd9E7XayWdtioj15uC1sd4I5w+nP4+SOOnifukVK8tVEeFSxukBER8pq//qIpsE1NHA/wJrGYWGNE8Lory4T4EIkQk+swE4WYwbT1Iv067SWcNG+LzQqbvskvWwfeWQDsZKvmRzVog93HM0SKZRJivgDSLYYxKjJZdb7Tn5+h1mGJXxGYHe6dqYDJIcjYVAlKmmZ3rN0DpC8BwMLprC3Aw0CDVl+WPBV9IDNUUbBV4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P2+Jnz6264wWrlkk7AsRcWuJib4+yeM+QCtKmdnXTxc=;
 b=SPVHmiOo6FgP0FyotABvCwV0sLi/lTkFYhQp4+sS1GrwmzLFGuN3CG8PUEr2A2GuXRxkdrXX92BxCPsNNomP7Rk4/g3FZqHgfHNF2IsV/LWqKJCLysd7GLJh0LopfIlof69aDU6J/qUq20g1eMJsVJzXM1XOfELjDBL6Zlrgd0KIlCR6F3JVexfdocYaIeMEPMvFVK9HPZJoNL8yZ369gWZ82kNi6EtEi47H8hDi3JuwWohLBdcfUO1vT9kuAc019sqEe1d9Y+g0/0dp5Q2dmPelpUb/ebktbwG6XcflCInJQ3Cxjp4XQMMLYj5xCnNU3J6dxrq10+CcQDQxa5nR3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ericsson.com; dmarc=pass action=none header.from=ericsson.com;
 dkim=pass header.d=ericsson.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P2+Jnz6264wWrlkk7AsRcWuJib4+yeM+QCtKmdnXTxc=;
 b=RgSIP82w90z/KCkNrFDb5Lmri1jRl1+/Yyfft/TqU6mdsU7sd65Gwho0euazvXG5f3Viv7agprxoFrxUjImrND1ebCG/uls0lKdqzLDi95TkriwzKPvYpCDg1gk3VwPN5rpoNao7G4F2DkXiaY5L1kKUWbkfNQMskFEZNp9UooA=
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com (2603:10a6:10:310::5)
 by PA4PR07MB7534.eurprd07.prod.outlook.com (2603:10a6:102:ce::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.26; Mon, 26 Jun
 2023 12:53:18 +0000
Received: from DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b]) by DU0PR07MB8833.eurprd07.prod.outlook.com
 ([fe80::fe43:aa1:308c:b32b%4]) with mapi id 15.20.6521.026; Mon, 26 Jun 2023
 12:53:18 +0000
From: =?utf-8?B?Sm9obiBIw7ZnYmVyZw==?= <john.hogberg@ericsson.com>
To: "peter.maydell@linaro.org" <peter.maydell@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH qemu v3 1/2] target/arm: Handle IC IVAU to improve
 compatibility with JITs
Thread-Topic: [PATCH qemu v3 1/2] target/arm: Handle IC IVAU to improve
 compatibility with JITs
Thread-Index: AQHZoxNA72EloxcOpUWl6KTmHsvjtq+dEAEAgAAEMoA=
Date: Mon, 26 Jun 2023 12:53:18 +0000
Message-ID: <8fa0f3f64b6a79a6a7a6d5d789e157f7da4c7160.camel@ericsson.com>
References: <168722304495.6281.8113287217736957231-0@git.sr.ht>
 <168722304495.6281.8113287217736957231-1@git.sr.ht>
 <CAFEAcA8Ttt=6mt_1X3u6F2ngFoD_9hRw72r=87ybpbeeodrBLw@mail.gmail.com>
In-Reply-To: <CAFEAcA8Ttt=6mt_1X3u6F2ngFoD_9hRw72r=87ybpbeeodrBLw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ericsson.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DU0PR07MB8833:EE_|PA4PR07MB7534:EE_
x-ms-office365-filtering-correlation-id: 2e461167-d2c2-498e-28ac-08db76445074
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uCmaBGdrtoFfKUb399v0STWFqy0UMRC0MieOi3s4Dr0Zy0AROQH/90e3I/RCz9YS3L6oner2eML0dp/1LYSCbHtYgXQBsxVCUc0FtkyjJSnXNe4JWocp+4IF0f0dd21MGiQTeA17AsQs+IHatdRwhteeku6+cZgQvBWPrevemgmYJCS4yQTr8FTcA1G0RV1JDIHd1SAxe/t0x8pe95elGUg7J8ocTJXKsEVooy87Fqrcnnk1pEhbq/p9rGFRGAQkxK8DzRjc7tKS9NfWFP9rF6looWAEbAT1cWa+jbbCB//n6JL0LByePbbh781i/EmIPWkQJ/A/RCPC7/bsKkeW4A76a2rFxAwmdJNJoSyDAPFHeI3EIxq7IAO6BebycjRFYyRmtMLTE4ksH/JBTFBMqQiLVkOPRO1/Zs/uP1DS1tjbNh+pS3s4fyhKDXhvjs1n6xBmo2RLE94nhesugaNvLhtpjQ47koqPWDT2IdWmsGf2Dq1QqrM/Sy9Mm/E7PxVl33SsziFWJZuhXY49hdU0W/AwR7xYwA7mWtz3m7rNN97b7onVRLqNQCZjAcwJA5jew1Ex0mgXGGt3Zb5vZB4zM3FxshAmQerJL5mm9X2J9c3ItZ4HVmRzeH62D16s62smb0kWrIACmhpXP7Q490Pfd4cYCTYSNHiltFpZUs3b5XU=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DU0PR07MB8833.eurprd07.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230028)(4636009)(136003)(39860400002)(396003)(376002)(346002)(366004)(451199021)(6486002)(478600001)(85182001)(2906002)(6512007)(26005)(186003)(6506007)(66476007)(66446008)(64756008)(71200400001)(66556008)(66946007)(316002)(76116006)(8676002)(41300700001)(5660300002)(91956017)(8936002)(38100700002)(122000001)(36756003)(6916009)(4326008)(85202003)(86362001)(82960400001)(38070700005)(83380400001)(66574015)(2616005);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWNzcGFaVm9laEc2V1pSUUZoZGQwanNsZGNWM3NoMWdxWmJVRCtDMEVueDdn?=
 =?utf-8?B?VEY2ZjBQQlp3cVVnUi9zOHJFRTBXdEMrb0lFaDBxR1J3SUdEczhCbzlaK244?=
 =?utf-8?B?TEtxUys3WVpHN1VvSUdwMFBXNlh0V25tV1MraDBLZ0h5WHN2elYwODVCdzVH?=
 =?utf-8?B?SDRtZ3JDOHRsSG56TWdTejJxak1HYzdLckNoOTQ1Qk12cjVKVlExcmNSck4x?=
 =?utf-8?B?MTA1NGZWN2tUSTlkNDA5M2VmTHA4Qmc1YkNGUVdqOXRhcEcxUDFsTFV5TDQ5?=
 =?utf-8?B?YmFJWUNaanBIR3BKQkFJaXYxTngvajN3YnRrZGQvKzJkeDEyM2NIMlZkaEZM?=
 =?utf-8?B?TG0wa0lZT3FEcFJ2ZmF1R2VyRVYrakt6Tm1NSnRBZ1BZQWR2YTk0dDBoc0Qx?=
 =?utf-8?B?SlRNUUxnVjhyd2ZrbFNnMS9UOHpIQkZjMnVNbWJhT0U1TEQ3blhIS2t6UGV0?=
 =?utf-8?B?YTI0UUJPTzJpQnJmNkUxWTB0eWlhUkVzK2R3YTJOOTA5Mm9XVE1xSTlsNDkx?=
 =?utf-8?B?a0NIZnVxWkFZMW1hZzlPU29mV24zVFcyN2xJdnZId2NVMGtMR3NhV2hxYUM4?=
 =?utf-8?B?eGZxTmROWVhEdkROenQ5RlM2RjlLbVFJY0pTZDVzVy9NOXFxbTg2OUR6ZHVk?=
 =?utf-8?B?NHhLRTd1b25URlcwUEFwN2M1bTN4VVUxaFRQZ1RISlh3eGJ4bnZTNU1CemFL?=
 =?utf-8?B?YWpZTUxWd01NVUpGL1BKdHBEN3VEUW5RZU94bVpqWFJPRGc1SlJ0SGhvOHRk?=
 =?utf-8?B?OXRXdDFNQW1HbTBTdTFBMG9rR2Z3aTRETXgzZ2EzSEtQOVB3NFEwS2IrNy9z?=
 =?utf-8?B?OTE5OXBNSGg3VCtKUHFjTmViWjZ0Q2Nvbk9WOTM3K3YrTXIzRm9jMlJ1N3VW?=
 =?utf-8?B?S2xwSGdYM0ZkTzJ0aFBmdXdQZUFvT2doV1liaUNoR0laN0JHdG1tQjlHeVNX?=
 =?utf-8?B?bTE5SUpKdnREaW9ZaWpHWTlURGdSS3NpR0FpMEZuNkV1elRCaWJTTG5JUEVY?=
 =?utf-8?B?YUhRK0RZVTlneTZrV0h4RTlKODZ3SExqREFoc0Zna0J6N2ZoZ3JmcXlBcVRJ?=
 =?utf-8?B?ZXVaY0NyRFIyVG9FUXIydjVPS3JOZi9odjNZZ0ZXWFRGaHA0dGhsNHB5Mnor?=
 =?utf-8?B?RWJFdFVGQjdHSk5QUnZVZGpBN3A2eDQ3MUdkYUFxZGU0YUJ1cnNIREJnSXRI?=
 =?utf-8?B?akNnMTNobDRYVmE0Q3RuTmhudHhBRXdiMENPNnQxZ3ZlcEZNbUFXRVQ4OWVS?=
 =?utf-8?B?Rk11dHZRcUtQUlVlNGowQ0s2UkFwVUxzOGNhSFdmQjFndXdwQzZyaXdpb2pm?=
 =?utf-8?B?aGd1b2FBMDhYZHpEbHJSa2xXMWE2SXVGemlYcW5vWW1VRWNaZFFSbHZVVHlX?=
 =?utf-8?B?YkNRTjZtQ0YwOUFvT1p0eVM2ZXQ5SkdMOUtScVkwUUFzQ01vOEp4YWtQa2Ri?=
 =?utf-8?B?V3ROVk5XMmJqYTZ3bWpzSlNWV2poVFB2c0VNYVRZTDFKZEttM2FQVmozMUtI?=
 =?utf-8?B?TVdEQmFVK2dvQ2xxOUljcE5LRXFsR3d5cit4ZzhGM2cxWUxQaGRkbSs4MkQ5?=
 =?utf-8?B?bU05Wm9sUE4rbnZ6TkZzTWpKYmNTb1BHWEU0QzByZzhlM1RGNEJaKzFxMkNX?=
 =?utf-8?B?K21qaWZCbnRUaTVjQkFCMnY5UzhLZzMyTC9DcEl2Z3VaNlRQcnJVcEh6YjVr?=
 =?utf-8?B?L01wNU4vZU1DbmhWVUtSdjQ4ejY2V1o3bHk1aHJlL0JOTnFvNGNhVFRTT29V?=
 =?utf-8?B?M1c0WEJhQ2hxRzNKYXUxYkRsRTJzcXM4ODhLakdvcFQvWmJqRG52UHh2QitT?=
 =?utf-8?B?dUFzM1NKUlpCd1BXZGlLY1MrRHcyMnBKNzZzdkdKWG16QnUzK1F2MXBLNlVl?=
 =?utf-8?B?Wjdxa3hQUlZYNjNXUmRhYXYyeUdVUjRNQ0VyVmtMSDJaRk5ZZ2MySFA2QWtN?=
 =?utf-8?B?QS9tR29zNGk2UUhBZGFpejJTUTBvaGVhMzltSFdEYWovcDd3UDd0c2s1QWZT?=
 =?utf-8?B?alZNTkdkTFo2UVhBNktRc3dxdk1pdzRTMndxdzB3VnEwTHBYaU05ckgxVjBT?=
 =?utf-8?B?NjRTdHpETXBNYmlhMGxoU1lRV2ZjNEZLR3J2NG4rVHB6MVdoOWk2c1VRS25Z?=
 =?utf-8?B?Ylh2ZEtKNTByS1ovcnFycTBDSVVYQmc3dGhFNzdFRFE2SHoyUStOS3UwTjlX?=
 =?utf-8?B?WEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5BC6302B45FF1748A02A054E5ADBE719@eurprd07.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DU0PR07MB8833.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e461167-d2c2-498e-28ac-08db76445074
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2023 12:53:18.2596 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qRDyeNeoS63nrZFQSHHzwRJvXz3bS6p1AhYODDVXtRfMVMwHs2vZndoLmE9NNzxw6uBj8JnOOChTmPaJQo4gYDPMODqXvb1dUKoVXMIrNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR07MB7534
Received-SPF: pass client-ip=40.107.6.40;
 envelope-from=john.hogberg@ericsson.com;
 helo=EUR04-DB3-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

PiBUaGlzIGlzIGltcGxlbWVudGF0aW9uLWRlcGVuZGVudCA6IGlmIHRoZQ0KPiBpbXBsZW1lbnRh
dGlvbiByZXBvcnRzIENUUl9FTDAue0RJQyxJREN9ID09IHsxLDF9IHRoZW4NCj4gaXQgZG9lc24n
dCBuZWVkIGljYWNoZSBpbnZhbGlkYXRpb24gb3IgZGF0YSBjYWNoZSBjbGVhbg0KPiB0byBwcm92
aWRlIGRhdGEtdG8taW5zdHJ1Y3Rpb24gb3IgaW5zdHJ1Y3Rpb24tdG8tZGF0YQ0KPiBjb2hlcmVu
Y2UuIFRoaXMgaXMgY3VycmVudGx5IG5vdCB0cnVlIGZvciBhbnkgQ1BVIFFFTVUNCj4gbW9kZWxz
LCBidXQgdGhlIE5lb3ZlcnNlLVYxICh3aGljaCBJJ20gYWJvdXQgdG8gc2VuZCBhIHBhdGNoDQo+
IGZvcikgY2FuIGRvIHRoaXMuIChJdCdzIGFsc28gdGVtcHRpbmcgdG8gbWFrZSAnbWF4JyBzZXQN
Cj4gdGhlc2UgYml0cywgd2hpY2ggd291bGQgc2F2ZSB0aGUgZ3Vlc3Qgc29tZSBlZmZvcnQgaW4N
Cj4gZG9pbmcgY2FjaGUgb3BzIHdoaWNoIHdlIE5PUCBhbnl3YXkuKQ0KDQpTdXJlLCBJJ2xsIHVw
ZGF0ZSB0aGUgY29tbWl0IG1lc3NhZ2UgdG8gdGhpcyBlZmZlY3QuDQoNCj4gU28gbWF5YmUgd2Ug
c2hvdWxkIGFsc28gZm9yY2UgQ1RSX0VMMC5ESUMgdG8gMCBpbiB1c2VyLW1vZGUNCj4gc28gdGhh
dCB0aGUgZ3Vlc3Qgd29uJ3QgZGVjaWRlIGJhc2VkIG9uIHRoZSB2YWx1ZSBvZiB0aGF0IGJpdA0K
PiB0aGF0IGl0IGRvZXNuJ3QgbmVlZCB0byBpc3N1ZSB0aGUgSUMgSVZBVSA/DQo+IGFybV9jcHVf
cmVhbGl6ZWZuKCkgd291bGQgYmUgdGhlIHBsYWNlIHRvIGRvIHRoaXMsIEkgdGhpbmsuDQoNClNv
dW5kcyBnb29kLCBJJ2xsIGZpeCB0aGF0LiBUaGFua3MgOikNCg0KL0pvaG4NCg0KLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGlu
YXJvLm9yZz4NClRvOiB+amhvZ2JlcmcgPGpvaG4uaG9nYmVyZ0Blcmljc3Nvbi5jb20+DQpDYzog
cWVtdS1kZXZlbEBub25nbnUub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHFlbXUgdjMgMS8yXSB0
YXJnZXQvYXJtOiBIYW5kbGUgSUMgSVZBVSB0byBpbXByb3ZlDQpjb21wYXRpYmlsaXR5IHdpdGgg
SklUcw0KRGF0ZTogTW9uLCAyNiBKdW4gMjAyMyAxMzozODoxNiArMDEwMA0KDQpPbiBUdWUsIDIw
IEp1biAyMDIzIGF0IDAyOjA0LCB+amhvZ2JlcmcgPGpob2diZXJnQGdpdC5zci5odD4gd3JvdGU6
DQo+IA0KPiBGcm9tOiBKb2huIEjDtmdiZXJnIDxqb2huLmhvZ2JlcmdAZXJpY3Nzb24uY29tPg0K
PiANCj4gVW5saWtlIGFyY2hpdGVjdHVyZXMgd2l0aCBwcmVjaXNlIHNlbGYtbW9kaWZ5aW5nIGNv
ZGUgc2VtYW50aWNzDQo+IChlLmcuIHg4NikgQVJNIHByb2Nlc3NvcnMgZG8gbm90IG1haW50YWlu
IGNvaGVyZW5jeSBmb3IgaW5zdHJ1Y3Rpb24NCj4gZXhlY3V0aW9uIGFuZCBtZW1vcnksIGFuZCBy
ZXF1aXJlIHRoZSBleHBsaWNpdCB1c2Ugb2YgY2FjaGUNCj4gbWFuYWdlbWVudCBpbnN0cnVjdGlv
bnMgYXMgd2VsbCBhcyBhbiBpbnN0cnVjdGlvbiBiYXJyaWVyIHRvIG1ha2UNCj4gY29kZSB1cGRh
dGVzIHZpc2libGUgKHRoZSBsYXR0ZXIgb24gZXZlcnkgY29yZSB0aGF0IGlzIGdvaW5nIHRvDQo+
IGV4ZWN1dGUgc2FpZCBjb2RlKS4NCg0KVGhpcyBpcyBpbXBsZW1lbnRhdGlvbi1kZXBlbmRlbnQg
OiBpZiB0aGUNCmltcGxlbWVudGF0aW9uIHJlcG9ydHMgQ1RSX0VMMC57RElDLElEQ30gPT0gezEs
MX0gdGhlbg0KaXQgZG9lc24ndCBuZWVkIGljYWNoZSBpbnZhbGlkYXRpb24gb3IgZGF0YSBjYWNo
ZSBjbGVhbg0KdG8gcHJvdmlkZSBkYXRhLXRvLWluc3RydWN0aW9uIG9yIGluc3RydWN0aW9uLXRv
LWRhdGENCmNvaGVyZW5jZS4gVGhpcyBpcyBjdXJyZW50bHkgbm90IHRydWUgZm9yIGFueSBDUFUg
UUVNVQ0KbW9kZWxzLCBidXQgdGhlIE5lb3ZlcnNlLVYxICh3aGljaCBJJ20gYWJvdXQgdG8gc2Vu
ZCBhIHBhdGNoDQpmb3IpIGNhbiBkbyB0aGlzLiAoSXQncyBhbHNvIHRlbXB0aW5nIHRvIG1ha2Ug
J21heCcgc2V0DQp0aGVzZSBiaXRzLCB3aGljaCB3b3VsZCBzYXZlIHRoZSBndWVzdCBzb21lIGVm
Zm9ydCBpbg0KZG9pbmcgY2FjaGUgb3BzIHdoaWNoIHdlIE5PUCBhbnl3YXkuKQ0KDQpTbyBtYXli
ZSB3ZSBzaG91bGQgYWxzbyBmb3JjZSBDVFJfRUwwLkRJQyB0byAwIGluIHVzZXItbW9kZQ0Kc28g
dGhhdCB0aGUgZ3Vlc3Qgd29uJ3QgZGVjaWRlIGJhc2VkIG9uIHRoZSB2YWx1ZSBvZiB0aGF0IGJp
dA0KdGhhdCBpdCBkb2Vzbid0IG5lZWQgdG8gaXNzdWUgdGhlIElDIElWQVUgPw0KYXJtX2NwdV9y
ZWFsaXplZm4oKSB3b3VsZCBiZSB0aGUgcGxhY2UgdG8gZG8gdGhpcywgSSB0aGluay4NCg0KdGhh
bmtzDQotLSBQTU0NCg0K

