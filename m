Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF3CA25127
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Feb 2025 02:49:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1telZI-00032Z-EV; Sun, 02 Feb 2025 20:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1telZD-000321-Lt
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 20:48:03 -0500
Received: from mail-eastasiaazon11020121.outbound.protection.outlook.com
 ([52.101.128.121] helo=HK2PR02CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1telZ9-00034o-L5
 for qemu-devel@nongnu.org; Sun, 02 Feb 2025 20:48:03 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=obf5Rzh1crWCMzMfk4NdjtPVaAIULFuN7FWExaWqh9v1Xe8AdKs1d5C1lMqslHiws7P/Wlo0GWnW1WvR6MEPdufgJhlxS8INsst0cHEDs0Bis56ekWeh+L/7Qf6UrSwL4PYKvmzTuQHCAlNogHTCeVNkSzpLkc5hM4KoIBsJv7hbH52kEtlsQSVCgJvupTlCj4rg2YCpNT47HQWxBQkkW6EAuGkVqJiCp6zaOXqzHYQ3/i76UgL9U+crWhBwBQ/YNXidHsGogV48E2LnYyUh8my6VdGZiBlVdk6eJLFM0M8sYmvRr8s/JOBdaDcNvxKxBYPMg6WWlBvSrqcD456fiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V8tQtTyHl0INgV3sg0YAIzbsFe00uzEsiRgn5R4Ul4g=;
 b=VpBMA6kcDc5k4VgXXLtuByeCHvH3lvmIt/AbHrSGtzgDvxYOPX93hfZ+EQiGs8vDnI+IayQpNU0TQ/5LgkZSxDLBkfJsGsyD8DGF3y7MkzB6vwOpvorRChYWUDJJjCGHrXuH/3Eah4JXtc6vyo2L85fAu291yfaAReGk9KEWaXcwemA5qZ8TkW55viHeK736uVFxRDs96Dta736Iq74G2P+2RlfuMkDAJ+1uQsXJ+qf4IIH2/g8gVhFTJsGzjfwl5h598fEpKZkhVR1wx7r7Tzi7sGdDnTfZTwNw5PuXGtABJjzFZJvh/jUuKPSIVf8FMh/1EMz+fOEXFYfI6RvSAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V8tQtTyHl0INgV3sg0YAIzbsFe00uzEsiRgn5R4Ul4g=;
 b=JSHhG+9iUJaIiCH9cF+oDKyPLZCOdIeO/v7Ggt7U7f98/bMhsd06jk/JB2B9zqBL+pUPoCIzSZ5etVImbI5UW1jY4q4uuwKehDUAs/HyLLwUNj550OOl2PNHybWPmcn9dcr1WsqI6CEWSqCsbcTJn3xiFgPJPzogXEIv5dwCwbapGkxJzr0FBighEyVNGrf9beA+RkVChJ5AZgUXqyVCQWpnNIoTE2+ZtHplYlZqsEJWLWdcn0qcgqJ2rjXRtY+p3OBhMdWoMG9dhgCMnNj9o2itaEPMQFCmP7mG8tPJanTfZloo5NXwm/QXN4CF0A7KBoj9VJs5OfyX9pbwSkAV5g==
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com (2603:1096:4:1a4::6) by
 JH0PR06MB7125.apcprd06.prod.outlook.com (2603:1096:990:8f::14) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8422.9; Mon, 3 Feb 2025 01:42:50 +0000
Received: from SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56]) by SI2PR06MB5041.apcprd06.prod.outlook.com
 ([fe80::705a:352a:7564:8e56%5]) with mapi id 15.20.8422.005; Mon, 3 Feb 2025
 01:42:50 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: Stefano Garzarella <sgarzare@redhat.com>, Rust-VMM Mailing List
 <rust-vmm@lists.opendev.org>
CC: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel <qemu-devel@nongnu.org>, 
 kvm <kvm@vger.kernel.org>, Richard Henderson <richard.henderson@linaro.org>,
 =?utf-8?B?UGhpbGlwcGUgTWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, Peter
 Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Alex Bennee
 <alex.bennee@linaro.org>, Akihiko Odaki <akihiko.odaki@gmail.com>, Zhao Liu
 <zhao1.liu@intel.com>, Bibo Mao <maobibo@loongson.cn>,
 =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>,
 =?utf-8?B?RXVnZW5pbyBQw6lyZXo=?= <eperezma@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Troy Lee <troy_lee@aspeedtech.com>
Subject: RE: Call for GSoC internship project ideas
Thread-Topic: Call for GSoC internship project ideas
Thread-Index: AQHbcaAQzhxF2ePEzkKY5nSGbWSvkbMuB5kAgAbO41A=
Date: Mon, 3 Feb 2025 01:42:49 +0000
Message-ID: <SI2PR06MB5041B0E2D49B298985EB0318FCF52@SI2PR06MB5041.apcprd06.prod.outlook.com>
References: <CAJSP0QVYE1Zcws=9hoO6+B+xB-hVWv38Dtu_LM8SysAmS4qRMw@mail.gmail.com>
 <CAGxU2F7oh+a7nZp9MLh67ghKtkwFvHRNqNvFqjgVhBhbe4HK2w@mail.gmail.com>
In-Reply-To: <CAGxU2F7oh+a7nZp9MLh67ghKtkwFvHRNqNvFqjgVhBhbe4HK2w@mail.gmail.com>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SI2PR06MB5041:EE_|JH0PR06MB7125:EE_
x-ms-office365-filtering-correlation-id: 8456762f-81ce-4dc5-64f3-08dd43f41173
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|38070700018; 
x-microsoft-antispam-message-info: =?utf-8?B?MWMyN0EwdGpYR0NsRzNFd1J4V1F2dnVrYlJYTGRRMlM4UHhieFJsNkVPblFo?=
 =?utf-8?B?eEFwWnBHSkswMDFDekdwZkt3TTBvd3RoQUNNZCs4dmdxZ0MxS0xRL2R2TWJG?=
 =?utf-8?B?VnZycTBaN2x4ZHZyZ3lMdmdWUFQvaW82YVUxL3gwUTFvZmNtOVRSK25nWC83?=
 =?utf-8?B?ZElueFkyQlQyTENxVUY2SXArZ3VWaENNdllaYUl5dko0NEFDbXFSaTVhbjJK?=
 =?utf-8?B?Y1FxU1JpS1pUNVdNWmY5d3UyUnBjNGI0VkVxNld6ZzhhZXQ3MnlnS0V2VDIw?=
 =?utf-8?B?UHJIdWliM2FTTmM2bFY2YWhHSXJLRVozOGZzek1KQlNqSERmcTBnU05Ld09q?=
 =?utf-8?B?MlJXRTVYd1kyc3VaSFZncE9PV21HRTlXM1daeVhja3cxQnVvNnIxczZBaTkw?=
 =?utf-8?B?TzBQZDZuTmJoTFJZcEorZTNvcUczd1poaUdGWlM2MU4veksyTGhzSkhNS3ho?=
 =?utf-8?B?aGw3MXJZT1FaV0pJclltZDNMek1MNnFybVBlSE9EakxPeHVKQkdpRTRpbXJs?=
 =?utf-8?B?Mzh4WUsyT2N5YUQzWGpLcStuMUpGWjZGREVzcDF4QUpxK0NKWnBPeGFyZkUz?=
 =?utf-8?B?UFdxZ040cEVGMk44L08zaDR2dW9wZnVBKzFQckRzQzEyOVNOY2VDaWszUXNQ?=
 =?utf-8?B?V0FUQ3BOOXhtQUhIeU5lMzl1V3o2ZW02RVJ3NWFlWnNyeFhPWVV0R1g0ODRw?=
 =?utf-8?B?bWhPempOd3orc3NaODlMSmRMcVo2RXIzSjRveGxIYmpZUXgybG96N2kwdlBi?=
 =?utf-8?B?a3RTWEluZW1HUUEyenRyaUc2ZC84bnJLUVl2Qm03c0N6MGpaQ0p6SGlZbUdo?=
 =?utf-8?B?MXZJSGxqczNtQ0UzVVFkcytTSUVoMDdma0dNUk1ydG1renZVOGZ0dzY4Wk9j?=
 =?utf-8?B?T3lhc1BVdE9ZMWI0ZEY3T0VGalRxSnorbU9WN2x0eW5DdGRoVjQ5WEQrTmVV?=
 =?utf-8?B?V2ZhSjBHSGIxbHpNdjBSWGVrYi9EMVdvejBYZlY3eCtsV3ZaZFJSbCtFc3F3?=
 =?utf-8?B?OUNkTzc0cTVUcVVtNHdCMHFyS1dqa3JQUGJSYWNCZmNtUTJKRzdEK2lCdUgz?=
 =?utf-8?B?YTJyVTJtTHkrclBXMWZCdzI1NENiVWhpYk9EZGF5dFZjMnZudEI1R1hHTE9Y?=
 =?utf-8?B?amVkMFVsdnZ6aGxDVnoyTVNQdjRwMC9GMEg5dUZpbnlGbmJqeG9PRmdkQ2FQ?=
 =?utf-8?B?eWZENXFQV3FSYlBtUmdiREFhSDRoZGJDejBHTWd2UHZnMVpSN3dMYXNqOG5S?=
 =?utf-8?B?TjJvV2ZsZ3p0RFMwS09lZ1B0d09RbUxxcFhkTGJwN3dmOU55NXcrRlhyZFBv?=
 =?utf-8?B?SG41aEdhUWRXTmp2UHd2VnFDeXg2Sk40b2c3c21VTTRTWVhpVnluTmlNVlMr?=
 =?utf-8?B?aUJneE9sc2QrZm1Idzg2VG9Ib3BlNmxPY2libDlxN3E0bzFBenhWYTBwbDdi?=
 =?utf-8?B?bUFxVk1CS1ZFNUI1OEJaUTVpVUxUdGtYYjl5VlpIN2xiay9hK05GYldDUllJ?=
 =?utf-8?B?Z2VHKzRndXo5NWlmTi9tM0JqbmFodTlrRXc4bi85ZTBlbCtZTXBVNFZEK2Fn?=
 =?utf-8?B?RzRra3FVNHE0NXlqQjgzejdPUUllb05QRjl2d095THBwQkhYUVFBOE5ybWQ4?=
 =?utf-8?B?bVErODV0anQ1dmh0T043eFVzbzhaQ2FOSWlFZDhMZDhYdlZBUG5ZMHJUcmNO?=
 =?utf-8?B?Zi9tNG5iU3JOZ1l5TDVodzJJeE9CZWpYYkl5MzNpREx1a0RMR21zekdlSThF?=
 =?utf-8?B?N0pDZFRHL1NwT0xrNnVmRDExbFFWSkhMajZ5azZRNUJPQk41bVdtQ0d6K1k1?=
 =?utf-8?B?RUJNTk54L09WRlRMMHhHWmpIbWFmMUthUmo0ZHkyRXJaMXlUN3F2R3VsWk1r?=
 =?utf-8?Q?DSVBfdb2tKX1M?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:zh-tw; SCL:1;
 SRV:; IPV:NLI; SFV:NSPM; H:SI2PR06MB5041.apcprd06.prod.outlook.com; PTR:;
 CAT:NONE; SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Ri9EWVBONmJNeFJXYjlRZVVIUHZlMEhrYS9PWmFXQlNXQ3BtSTNoM0pkM0lp?=
 =?utf-8?B?T05VYUJSSnNTSG1lVTVYYVFFbkdmL0pxVm5VRm91UjFFUkJOcXpLSVFISHdw?=
 =?utf-8?B?WnJlOFdtY0lGbTQ1YUVlYVdVVXJnbGROSWZzMVA0L0p1QVA0cHJhYkl5ZG03?=
 =?utf-8?B?dGoydUtlbHoxblJYeFREeHJzbnlWOThEV21jc0J5czk5SnBxSVZiQ0sxMElq?=
 =?utf-8?B?K3BtZmt0R1F3b0V1UEx4RStVL2RXQ1lNMmxFdWR4RzhxRkNlT1ZBVHFoRnBP?=
 =?utf-8?B?NFJtM1NUNXFjQWo1bnM5dVkzenYrVXo1TlRDcVdMUTBXRmZ3TmlEOUg2Nkcx?=
 =?utf-8?B?cFM5eXBSQTBTMm9TN3hmYUpkRFFVb285b2tRSHpQekVyUDcxdDVzTjJEYXpq?=
 =?utf-8?B?RGljck9vUUNFMHpSeUF0dXAxMEU0YXE1SXNZT3pHeHVwN0NrTE91WkRQdFZm?=
 =?utf-8?B?bGoxSHcvUDhvZnUrZGcweE43dnRWd2hZM2lNUTZTZC9tbHB4UlhNN1ZZc0xJ?=
 =?utf-8?B?SllTNlRZN3llc01OMUJ4ZmN4QTZ5MXMwTEpXYzhNZ1dua3pnanNYVFNkOURu?=
 =?utf-8?B?eWtqWDRPS0QvMU1nNkEraXRvYlpKMHU1eXl3VlI1MW16STBTRnZOb0UrZkgz?=
 =?utf-8?B?MWpjakY3a3ZqUUJGaTBCalk2ejIwUEVZM29PZkhFZ1dxanRjVWRIZTJ3bXF1?=
 =?utf-8?B?MGJVL2kyYkMvWVhsMkYrcmN1ZEwzalQ1alAyWlFmWllkMDVFSXcvekVoUWV6?=
 =?utf-8?B?a1UzYk9vZWtsQ1BOd2luWFl5N1RYT2JtZkJ2Y2ZWTFd1SXJBYXFRQVAySU95?=
 =?utf-8?B?Q2hSRjBzc1d4ZFJ5K2puKy9ZazlCandsYzBhWXJQVUJHWVNsZTdJc1poZUt4?=
 =?utf-8?B?V3hycFU3aWFpQUxIL0JIN3dtTjZnaDU1UllLeVJ5bFFydW1aeE9sWFJURStV?=
 =?utf-8?B?dnVmMmlMUG45VTUrYWs4MitxNjY1WW05eU54YVY0c3VWdGVka1pqY3pYakFR?=
 =?utf-8?B?aVJMTzdzelVHSVBvOUFxQWU3cUZtZzFjcFk2N1Z0NURsc21sd2RjZ09oSm9F?=
 =?utf-8?B?RUxZNTVmdmI0eUxqTEwwdmFmSkJmRXNCTlpESHdrZzZTWTY2N3FwY2VYRUZw?=
 =?utf-8?B?akZQVUxEQU9mYzJ5RzF6UTNNaTV6UEJTaXNOZ2VQMjhqWkRnTVZhRFNXajVW?=
 =?utf-8?B?T2hqNG1ISEVMMk9kdldqQkZMZXhEWnJsdEtwMVprejFIUURNQ0k5QzFWaGQ0?=
 =?utf-8?B?VEJKbzUvb3JGL3RHR1hUUE9iRlJyYzJMYzJQR3RsckoxSUVpc05VS3FxYS9U?=
 =?utf-8?B?M1dUMS82MFV2cGhOK2t4WnlPekY5bUkwcUNFQjk4QTd2RDR5ckdDdFRNWkFr?=
 =?utf-8?B?ZVo0OTRFbDNoOXpjWTZCdDV2aWZ4TFp0MERCcmQwb3kvQm15MTUyMTdFTWI1?=
 =?utf-8?B?MldvWnZYN0ViTmtmczVpbTNHV1RYYkFFU1paSmdGRjZVcHBxNisyRmpJR3pP?=
 =?utf-8?B?T2VQS0cwODNmUUtlZzUxQVI0OVh1TTdTUTVaUmpNTzg0a3hyelBnK2NMQ2Ro?=
 =?utf-8?B?dmRsL3FvZ050dE9kdDhubE0xdHhPSWdXTkN0M28xWXNsbHIwTStQb3ZTWXh6?=
 =?utf-8?B?K2FvUzJVOGF5SDF5WVFpRnNTYVovSFJtUFBkQ2tranU4aVVGK1Q5RGthZWxY?=
 =?utf-8?B?VDBCVjJucFJ6YVIraVpMYzdjTjZsU09BdDQ1YTZlK0FPb0F4THkzZWJxaGtV?=
 =?utf-8?B?WEdWRDIySUs3cGE0dmlTc3M5UE11bFJ4TmVURTg4T2JlSW5JaE5McXBrdWo3?=
 =?utf-8?B?NEtRbXRic2NBNlJUVmlyRUZ1SHVrNnV3eVRaNHhQOWhobDlHK3gwWkNrZVhw?=
 =?utf-8?B?bGcyQUVQVk1id212QS9GY2pkOHJJbVRsQk1wUnlRS2tvQVdSZGtyeklaSHY2?=
 =?utf-8?B?WC9iME1JUVNDYmtSWUVJMjJmYlg5SXpSUzVVR0Q1QXRFWU1wZTFhSWFkczYy?=
 =?utf-8?B?Sk9RRDFJSHE5U1JXdHpIQWR1SFpYS1ByaGFweEFjREdkcVdEdTlOdHVoWTdh?=
 =?utf-8?B?ZEVlVVBsVWtMNWVwZ3JQMHNmSlRISDNBeHRZV0E5bEV2RGFya2ovM2ZUbHVj?=
 =?utf-8?Q?r3h0sqOYL/MG6b2h+X8M/3stP?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5041.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8456762f-81ce-4dc5-64f3-08dd43f41173
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 01:42:49.9797 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4eNDpHAjhPFogBuFSqLbG32jD3B0n4kkgypB9BnwBasZaStPl4V2+/5Q3cQQUBnW0Kve8DFomTrBWM9YhpJQVCu6YNtFXJ/Xl670hmZP+w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: JH0PR06MB7125
Received-SPF: pass client-ip=52.101.128.121;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=HK2PR02CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

KyBUcm95DQoNCioqKioqKioqKioqKiogRW1haWwgQ29uZmlkZW50aWFsaXR5IE5vdGljZSAqKioq
KioqKioqKioqKioqKioqKg0K5YWN6LKs6IGy5piOOg0K5pys5L+h5Lu2KOaIluWFtumZhOS7tinl
j6/og73ljIXlkKvmqZ/lr4bos4foqIrvvIzkuKblj5fms5Xlvovkv53orbfjgILlpoIg5Y+w56uv
6Z2e5oyH5a6a5LmL5pS25Lu26ICF77yM6KuL5Lul6Zu75a2Q6YO15Lu26YCa55+l5pys6Zu75a2Q
6YO15Lu25LmL55m86YCB6ICFLCDkuKboq4vnq4vljbPliKrpmaTmnKzpm7vlrZDpg7Xku7blj4rl
hbbpmYTku7blkozpirfmr4DmiYDmnInopIfljbDku7bjgILorJ3orJ3mgqjnmoTlkIjkvZwhDQoN
CkRJU0NMQUlNRVI6DQpUaGlzIG1lc3NhZ2UgKGFuZCBhbnkgYXR0YWNobWVudHMpIG1heSBjb250
YWluIGxlZ2FsbHkgcHJpdmlsZWdlZCBhbmQvb3Igb3RoZXIgY29uZmlkZW50aWFsIGluZm9ybWF0
aW9uLiBJZiB5b3UgaGF2ZSByZWNlaXZlZCBpdCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUg
c2VuZGVyIGJ5IHJlcGx5IGUtbWFpbCBhbmQgaW1tZWRpYXRlbHkgZGVsZXRlIHRoZSBlLW1haWwg
YW5kIGFueSBhdHRhY2htZW50cyB3aXRob3V0IGNvcHlpbmcgb3IgZGlzY2xvc2luZyB0aGUgY29u
dGVudHMuIFRoYW5rIHlvdS4gDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJv
bTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPg0KPiBTZW50OiBUaHVy
c2RheSwgSmFudWFyeSAzMCwgMjAyNSAxOjQ0IEFNDQo+IFRvOiBSdXN0LVZNTSBNYWlsaW5nIExp
c3QgPHJ1c3Qtdm1tQGxpc3RzLm9wZW5kZXYub3JnPg0KPiBDYzogU3RlZmFuIEhham5vY3ppIDxz
dGVmYW5oYUBnbWFpbC5jb20+OyBxZW11LWRldmVsDQo+IDxxZW11LWRldmVsQG5vbmdudS5vcmc+
OyBrdm0gPGt2bUB2Z2VyLmtlcm5lbC5vcmc+OyBSaWNoYXJkIEhlbmRlcnNvbg0KPiA8cmljaGFy
ZC5oZW5kZXJzb25AbGluYXJvLm9yZz47IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpDQo+IDxwaGls
bWRAbGluYXJvLm9yZz47IFBldGVyIE1heWRlbGwgPHBldGVyLm1heWRlbGxAbGluYXJvLm9yZz47
IFBhb2xvDQo+IEJvbnppbmkgPHBib256aW5pQHJlZGhhdC5jb20+OyBUaG9tYXMgSHV0aCA8dGh1
dGhAcmVkaGF0LmNvbT47IERhbmllbCBQLg0KPiBCZXJyYW5nZSA8YmVycmFuZ2VAcmVkaGF0LmNv
bT47IFBpZXJyaWNrIEJvdXZpZXINCj4gPHBpZXJyaWNrLmJvdXZpZXJAbGluYXJvLm9yZz47IEFs
ZXggQmVubmVlIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPjsNCj4gQWtpaGlrbyBPZGFraSA8YWtp
aGlrby5vZGFraUBnbWFpbC5jb20+OyBaaGFvIExpdSA8emhhbzEubGl1QGludGVsLmNvbT47DQo+
IEJpYm8gTWFvIDxtYW9iaWJvQGxvb25nc29uLmNuPjsgSmFtaW4gTGluIDxqYW1pbl9saW5AYXNw
ZWVkdGVjaC5jb20+Ow0KPiBDw6lkcmljIExlIEdvYXRlciA8Y2xnQHJlZGhhdC5jb20+OyBGYWJp
YW5vIFJvc2FzIDxmYXJvc2FzQHN1c2UuZGU+Ow0KPiBQYWxtZXIgRGFiYmVsdCA8cGFsbWVyQGRh
YmJlbHQuY29tPjsgRXVnZW5pbyBQw6lyZXoNCj4gPGVwZXJlem1hQHJlZGhhdC5jb20+OyBIYW5u
YSBSZWl0eiA8aHJlaXR6QHJlZGhhdC5jb20+DQo+IFN1YmplY3Q6IFJlOiBDYWxsIGZvciBHU29D
IGludGVybnNoaXAgcHJvamVjdCBpZGVhcw0KPiANCj4gK0NjIHJ1c3Qtdm1tIE1MLCBzaW5jZSBp
biBwYXN0IHllYXJzIHdlIGhhdmUgdXNlZCBRRU1VIGFzIGFuIHVtYnJlbGxhDQo+IHByb2plY3Qg
Zm9yIHJ1c3Qtdm1tIGlkZWFzIGZvciBHU29DLg0KPiANCj4gVGhhbmtzLA0KPiBTdGVmYW5vDQo+
IA0KPiBPbiBUdWUsIDI4IEphbiAyMDI1IGF0IDE3OjE3LCBTdGVmYW4gSGFqbm9jemkgPHN0ZWZh
bmhhQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBEZWFyIFFFTVUgYW5kIEtWTSBjb21tdW5p
dGllcywNCj4gPiBRRU1VIHdpbGwgYXBwbHkgZm9yIHRoZSBHb29nbGUgU3VtbWVyIG9mIENvZGUg
aW50ZXJuc2hpcCBwcm9ncmFtIGFnYWluDQo+ID4gdGhpcyB5ZWFyLiBSZWd1bGFyIGNvbnRyaWJ1
dG9ycyBjYW4gc3VibWl0IHByb2plY3QgaWRlYXMgdGhhdCB0aGV5J2QNCj4gPiBsaWtlIHRvIG1l
bnRvciBieSByZXBseWluZyB0byB0aGlzIGVtYWlsIGJ5IEZlYnJ1YXJ5IDd0aC4NCj4gPg0KPiA+
IEFib3V0IEdvb2dsZSBTdW1tZXIgb2YgQ29kZQ0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gR1NvQyAoaHR0cHM6Ly9zdW1tZXJvZmNvZGUud2l0aGdv
b2dsZS5jb20vKSBvZmZlcnMgcGFpZCBvcGVuIHNvdXJjZQ0KPiA+IHJlbW90ZSB3b3JrIGludGVy
bnNoaXBzIHRvIGVsaWdpYmxlIHBlb3BsZSB3aXNoaW5nIHRvIHBhcnRpY2lwYXRlIGluDQo+ID4g
b3BlbiBzb3VyY2UgZGV2ZWxvcG1lbnQuIFFFTVUgaGFzIGJlZW4gZG9pbmcgaW50ZXJuc2hpcCBm
b3IgbWFueQ0KPiA+IHllYXJzLiBPdXIgbWVudG9ycyBoYXZlIGVuam95ZWQgaGVscGluZyB0YWxl
bnRlZCBpbnRlcm5zIG1ha2UgdGhlaXINCj4gPiBmaXJzdCBvcGVuIHNvdXJjZSBjb250cmlidXRp
b25zIGFuZCBzb21lIGZvcm1lciBpbnRlcm5zIGNvbnRpbnVlIHRvDQo+ID4gcGFydGljaXBhdGUg
dG9kYXkuDQo+ID4NCj4gPiBXaG8gY2FuIG1lbnRvcg0KPiA+IC0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0NCj4gPiBSZWd1bGFyIGNvbnRyaWJ1dG9ycyB0byBRRU1VIGFuZCBLVk0gY2FuIHBhcnRpY2lw
YXRlIGFzIG1lbnRvcnMuDQo+ID4gTWVudG9yc2hpcCBpbnZvbHZlcyBhYm91dCA1IGhvdXJzIG9m
IHRpbWUgY29tbWl0bWVudCBwZXIgd2VlayB0bw0KPiA+IGNvbW11bmljYXRlIHdpdGggdGhlIGlu
dGVybiwgcmV2aWV3IHRoZWlyIHBhdGNoZXMsIGV0Yy4gVGltZSBpcyBhbHNvDQo+ID4gcmVxdWly
ZWQgZHVyaW5nIHRoZSBpbnRlcm4gc2VsZWN0aW9uIHBoYXNlIHRvIGNvbW11bmljYXRlIHdpdGgN
Cj4gPiBhcHBsaWNhbnRzLiBCZWluZyBhIG1lbnRvciBpcyBhbiBvcHBvcnR1bml0eSB0byBoZWxw
IHNvbWVvbmUgZ2V0DQo+ID4gc3RhcnRlZCBpbiBvcGVuIHNvdXJjZSBkZXZlbG9wbWVudCwgd2ls
bCBnaXZlIHlvdSBleHBlcmllbmNlIHdpdGgNCj4gPiBtYW5hZ2luZyBhIHByb2plY3QgaW4gYSBs
b3ctc3Rha2VzIGVudmlyb25tZW50LCBhbmQgYSBjaGFuY2UgdG8NCj4gPiBleHBsb3JlIGludGVy
ZXN0aW5nIHRlY2huaWNhbCBpZGVhcyB0aGF0IHlvdSBtYXkgbm90IGhhdmUgdGltZSB0bw0KPiA+
IGRldmVsb3AgeW91cnNlbGYuDQo+ID4NCj4gPiBIb3cgdG8gcHJvcG9zZSB5b3VyIGlkZWENCj4g
PiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gPiBSZXBseSB0byB0aGlzIGVtYWls
IHdpdGggdGhlIGZvbGxvd2luZyBwcm9qZWN0IGlkZWEgdGVtcGxhdGUgZmlsbGVkIGluOg0KPiA+
DQo+ID4gPT09IFRJVExFID09PQ0KPiA+DQo+ID4gJycnU3VtbWFyeTonJycgU2hvcnQgZGVzY3Jp
cHRpb24gb2YgdGhlIHByb2plY3QNCj4gPg0KPiA+IERldGFpbGVkIGRlc2NyaXB0aW9uIG9mIHRo
ZSBwcm9qZWN0IHRoYXQgZXhwbGFpbnMgdGhlIGdlbmVyYWwgaWRlYSwNCj4gPiBpbmNsdWRpbmcg
YSBsaXN0IG9mIGhpZ2gtbGV2ZWwgdGFza3MgdGhhdCB3aWxsIGJlIGNvbXBsZXRlZCBieSB0aGUN
Cj4gPiBwcm9qZWN0LCBhbmQgcHJvdmlkZXMgZW5vdWdoIGJhY2tncm91bmQgZm9yIHNvbWVvbmUg
dW5mYW1pbGlhciB3aXRoDQo+ID4gdGhlIGNvZGUgYmFzZSB0byByZXNlYXJjaCB0aGUgaWRlYS4g
VHlwaWNhbGx5IDIgb3IgMyBwYXJhZ3JhcGhzLg0KPiA+DQo+ID4gJycnTGlua3M6JycnDQo+ID4g
KiBMaW5rcyB0byBtYWlsaW5nIGxpc3RzIHRocmVhZHMsIGdpdCByZXBvcywgb3Igd2ViIHNpdGVz
DQo+ID4NCj4gPiAnJydEZXRhaWxzOicnJw0KPiA+ICogU2tpbGwgbGV2ZWw6IGJlZ2lubmVyIG9y
IGludGVybWVkaWF0ZSBvciBhZHZhbmNlZA0KPiA+ICogTGFuZ3VhZ2U6IEMvUHl0aG9uL1J1c3Qv
ZXRjDQo+ID4NCj4gPiBNb3JlIGluZm9ybWF0aW9uDQo+ID4gLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+IFlvdSBjYW4gZmluZCBvdXQgYWJvdXQgdGhlIHByb2Nlc3Mgd2UgZm9sbG93IGhlcmU6
DQo+ID4gVmlkZW86IGh0dHBzOi8vd3d3LnlvdXR1YmUuY29tL3dhdGNoP3Y9eE5WQ1g3WU1VTDgN
Cj4gPiBTbGlkZXMgKFBERik6IGh0dHBzOi8vdm1zcGxpY2UubmV0L35zdGVmYW4vc3RlZmFuaGEt
a3ZtLWZvcnVtLTIwMTYucGRmDQo+ID4NCj4gPiBUaGUgUUVNVSB3aWtpIHBhZ2UgZm9yIEdTb0Mg
MjAyNCBpcyBub3cgYXZhaWxhYmxlOg0KPiA+IGh0dHBzOi8vd2lraS5xZW11Lm9yZy9Hb29nbGVf
U3VtbWVyX29mX0NvZGVfMjAyNQ0KPiA+DQo+ID4gV2hhdCBhYm91dCBPdXRyZWFjaHk/DQo+ID4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiA+IFdlIGhhdmUgc3RydWdnbGVkIHRv
IGZpbmQgc3BvbnNvcnMgZm9yIHRoZSBPdXRyZWFjaHkgaW50ZXJuc2hpcA0KPiA+IHByb2dyYW0g
KGh0dHBzOi8vd3d3Lm91dHJlYWNoeS5vcmcvKSBpbiByZWNlbnQgeWVhcnMuIElmIHlvdSBvciB5
b3VyDQo+ID4gb3JnYW5pemF0aW9uIHdvdWxkIGxpa2UgdG8gc3BvbnNvciBhbiBPdXRyZWFjaHkg
aW50ZXJuc2hpcCwgcGxlYXNlIGdldA0KPiA+IGluIHRvdWNoLg0KPiA+DQo+ID4gVGhhbmtzLA0K
PiA+IFN0ZWZhbg0KPiA+DQoNCg==

