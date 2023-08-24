Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3257865AE
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 05:04:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZ0cp-0002s9-7a; Wed, 23 Aug 2023 23:03:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZ0cn-0002s1-MB
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 23:03:09 -0400
Received: from mail-dm6nam04olkn20801.outbound.protection.outlook.com
 ([2a01:111:f400:7e8b::801]
 helo=NAM04-DM6-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alloc.young@outlook.com>)
 id 1qZ0ck-0005Iv-US
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 23:03:09 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dIjZ+AYXIrHJZtYG5hwSYCY0iucnKG1ynZi3AglhYJWIloMrkzcJjVfMHg6ica2Mnl/Jgih9wHAvxi0K2t2EVPmnayAZIGgCAO8qHDtpFDW3IoQaiY0OJ6VZpOJHdqcY80h2vAHh2ZmraHzi0S6rAWOt6XjlAuH3Xa8sHWfFpEkWcC2FYRT0jaeGzxGHKV6ERKsQyUJgJ5c2unCKaZRnNmN/j2508GvRDsw22CCBZ1SoKAPveRhC88qpXLBM/JOP8RbaKYe+V+gwaHUaVMtHLkVmsYScjiMWAOkOqPe2si2njR6knqSiY12pY9skqVr9shJLEqSaeJOY2YrOwxBAQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PFOUqukZvxLdb6XYjaya2cgQnJ3JaxU51P/0kDvPROw=;
 b=g56VLJLUgJfpw1AFa5fzVoL0w3eIJ3p1b4GtjW35KWoDkwPsYtbjY7tE7NbhfaZfqShqy71/qAkB7HuBUafZGXYH4FFf6Hec0zlKqe42lqVhzDm22LbjJIz9Q/KDKC0YQJZKPUeNSU1KiEV48rR1vbpZstD3A+bCh5oTDvTrk+CjZKS+3codQlzehNQtE8ddW8OPma8iLeiiarmVq6ln/w/TEdW6NkLXcSUuhg7I55oVXgoU5EyLNs+FIA9PQcOv4a+HwyNtKzNozuOLnuj9Wf5Xt3EDMrRauRTZa7ePkV0AOn+U8G3ys1hg+QPhowvvjTfXF32zuUb8PyDxoP5hBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=outlook.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PFOUqukZvxLdb6XYjaya2cgQnJ3JaxU51P/0kDvPROw=;
 b=FEpViZc0GTsSUg2j8rx0eIdGnG7coMnn3x0DlGP2frGQ1+htObqLN3PovW6dhwR2d0XUllIEliSVM5KGXx7kLn85Bt8855eT7O9oGHugEXCkOc791jbrXpiRld1w6/rj194+74Hq8Kk+5KZ6L0cUt3VOLMv82LBYz466tyPMejptSBaxSW7E8ssEU6oQzxb+1Qawq4pLm4KPC4+D4GG6Y9Bs6rrj5n5vfCG6x6eawR9o4/vYsgsAYNWGwi7G/UiICs+2KFGoeCIyGn3u7wnkjqYvutBGThfnUv2A5tjDvQBACcbITxJMl9kZjZNS9GYHy+tyPLdtTa+HEQ96I5JEjg==
Received: from SA1PR11MB6760.namprd11.prod.outlook.com (2603:10b6:806:25f::14)
 by PH8PR11MB7990.namprd11.prod.outlook.com (2603:10b6:510:259::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Thu, 24 Aug
 2023 03:03:01 +0000
Received: from SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf]) by SA1PR11MB6760.namprd11.prod.outlook.com
 ([fe80::df85:2db:d56b:38bf%5]) with mapi id 15.20.6699.020; Thu, 24 Aug 2023
 03:03:01 +0000
From: =?utf-8?B?6ZizIOaYpeWFiQ==?= <alloc.young@outlook.com>
To: Yong Huang <yong.huang@smartx.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: =?utf-8?B?5Zue5aSNOiBbUEFUQ0hdIHNvZnRtbXU6IEZpeCBkaXJ0eWxpbWl0IG1lbW9y?=
 =?utf-8?Q?y_leak?=
Thread-Topic: [PATCH] softmmu: Fix dirtylimit memory leak
Thread-Index: AQHZ1ZYqxLXBulDR0Em6IsmTVnEoZq/4mW+AgAAqODE=
Date: Thu, 24 Aug 2023 03:03:01 +0000
Message-ID: <SA1PR11MB67609D4BB7D191BF5499DFAEF51DA@SA1PR11MB6760.namprd11.prod.outlook.com>
References: <SA1PR11MB67606FB284BF14ED9F11D436F51CA@SA1PR11MB6760.namprd11.prod.outlook.com>
 <CAK9dgmaXp1yE+VdMDpfKE2TVam1sx2UD9w49tVN16nYcF_ajFw@mail.gmail.com>
In-Reply-To: <CAK9dgmaXp1yE+VdMDpfKE2TVam1sx2UD9w49tVN16nYcF_ajFw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-tmn: [7WhzkQGOpT6OqvdzRSka5sOrYv8RWZks/LmBFriqhAw=]
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SA1PR11MB6760:EE_|PH8PR11MB7990:EE_
x-ms-office365-filtering-correlation-id: a47bd6c7-a0cc-4255-1aee-08dba44ea0b8
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A0cxYvnCLbrI0xQKhBH0nB7HQ/1Rvxe5xg2lQN6/9kK1lyo23kbXTKIzf1r99VcVobAGjbku8wwCEPokuMwiqG6RiUckLkVQWPaAaFuDT/r5IIoyMcUudzlwwerOLqxdZC0A0DRLchGj/zkSdvImvYgKgALNRPfvDq77NRw4ba3mOQevI2a5Q1uHxGfv3Y3kf4+rOSSoI6mZ6ObU1dYFHWwJEA/WILXz+6XXXvuLsTK0qrxJC+hLbqg5sCkMIROIbBNf+ISkRTaEnw6xgGQaAguxv1E5uG562GKeX4AQvHgiY24k5Gw9gEfrNmj0d+NIuvu+tfSa56rvwGMCKYI0FNCY03022XO0F+gR5U/DMW742V2GDUexZtP0p7kB0k99gusWYiB0upqTzllOfirDqEZP/FZGHBGan1sq6zmQur3JfsBtNERMKblxE/0ox2TmNZ7IoAv/DGoEzkMp8RiFsB45qV82/sdhroQB9C2ues76uCujRY1cL/Wezwp0yTaU0GgrkkfxYOEWrlMW5ozxM5cT6cWDoaA+9HQd1t6Gu9EjqA+i1CQvDkz4KUYYCklR
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?azAwZFI4RTRmaXhORy81SUpSMG93S3FmSSt0cFZjOW1DOGZRWTBjUjJMNHF2?=
 =?utf-8?B?bzM1cHFxWmJIMjNTVW42eWFrSW5MSDhKS0lDc3BnL0g3aDl5MERoQ0I1TWRJ?=
 =?utf-8?B?UWdGcE56WkRKSXdCYnZPS1ZhQTdacis3RjlJREc2SW52TFVrVldmQitsaGlJ?=
 =?utf-8?B?SWtXTTJETTB4R0I0WmVvVWVNQWxHaG9mRUFuS29UVjNWbzlHUG9kVmN5cmQ3?=
 =?utf-8?B?UDMyNWQ3VVltUHkvei96WStKbGJuUXNTWjlPSEIvR3QwUy9NOWhNTkd3ZWhi?=
 =?utf-8?B?WC84dVFrZTFUSk1iTjNqd2luK09mNkMrNXZ2NFpQdW1pTXBnYnQxS2VCalJY?=
 =?utf-8?B?QVhkZUdGU1JrVXUzTFIvRFZ1NVFrQ3h5TXpZeTN5QU5ueVkzUFMzTi82SWJh?=
 =?utf-8?B?cmVuamU4bStHOUxPaEV2Rm85dmYwbUtSblc4MlFXRGRNSkdhRGE1WTAwc2po?=
 =?utf-8?B?S001aHVVWVAzZEtLejNnZFBXU2t3WTBTNkF1MzFNSnB1bktDVkNQYXRjbzRr?=
 =?utf-8?B?cUdiM3lBdEd5UnphNDBuOGpWd1FtYVNqVEIzTHhJZmRxOC94MCtObXJhejQ5?=
 =?utf-8?B?NEhKZTlqZzc0YWFXK1g5UzBrWDJWWEdQM2Q4R3I2d3h5R0NPL24wZjFLdHNz?=
 =?utf-8?B?RGRabXNuRjM1OVVwQlR1N2c1bjh5Y3VIaDZaTEt4ZnRtVGw0U3dlaTIzc2JX?=
 =?utf-8?B?MnIyVUl3U3NTQVo4ZThFRW5BNGhXVjVCRE8vU2FRblZzcWZEWlJ2aTZabElW?=
 =?utf-8?B?aUNybFhXQTUzSk41b2dmL2dwanNZYUduWTRzVWVrM2dIREtMQ2lDN2t3T0lJ?=
 =?utf-8?B?ZVZqb3BrWFZIeXQ4N3U1Q3gzWVA4RDRNcXZCRmJGRzhsQU1KK0FyVjUrMTdH?=
 =?utf-8?B?NDQyanZtT1E0MGJjckFmKzh4RGl0TFVwWnJRVGk4bnhaOHhEZGJEVCtpeEV2?=
 =?utf-8?B?SVdKbHBvZjc3VkFIdHZzc0NKMlFNTDI1MHgxcWtTY0ZEdmZaMzhnS0dUdWtN?=
 =?utf-8?B?NlAvTFpiVk05NkxTekM3UjRoRElqbStmNkszbk53ZHFQUmhRUTRDSWZMdndi?=
 =?utf-8?B?a091T3VuZzR1N3NIaTRzWUwrT0lTc1habVFEOVYyZm56Y3NWZ0Q3dW1WbTBH?=
 =?utf-8?B?aGpNaHA2OEhvdCtIMGhDWlVXNnhCN2tZVEhDQ3g1SUg2amY2cjVIQXdzVjFP?=
 =?utf-8?B?SG5JeVlkODNWaWM3Qi9nVXFIMVU1ejBzMVVSTVZOa1F4a0FDSW5jK3BZZHZ2?=
 =?utf-8?B?aXFxZ09vNjdDWko1ZFRFRHhLT2Y0K2RkYmNTN2ZuKzVmamJ4VVNpaUVTVGI2?=
 =?utf-8?B?K042QkNkV3VHMk44emYzbXA3NW1vb2lxRFNGVUplY3duUTUrQm9xeEJWWHJG?=
 =?utf-8?B?d3lXeU1ucTVCRW1iRzhVZ2NmRHZFWmtpQnFsaFlJN1lIc0ZpaVBIampSMDRN?=
 =?utf-8?B?UmdWOWRUbkR4N0o3WU1lMFc3azEyMVBkQ3NWQzJ2Sk5KQ0Nac0xiMlNhSVZK?=
 =?utf-8?B?M2N2L1dtVm5idEZMQVJxTlgvcU5yL0dkWk0rWUl2Q1ZTV3dzeG1FTE9jWnpw?=
 =?utf-8?B?RWpOUUdrbDZsNEMzbGo0QThpR1RVVzFGRUwwcGpNbWU1bEZvbTFMTGprajBv?=
 =?utf-8?B?OXNkaC9HcHdXUndhemVBV2tMYnMwQkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6760.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: a47bd6c7-a0cc-4255-1aee-08dba44ea0b8
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Aug 2023 03:03:01.3802 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7990
Received-SPF: pass client-ip=2a01:111:f400:7e8b::801;
 envelope-from=alloc.young@outlook.com;
 helo=NAM04-DM6-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCuWPkeS7tuS6ujogWW9u
ZyBIdWFuZyA8eW9uZy5odWFuZ0BzbWFydHguY29tPgrlj5HpgIHml7bpl7Q6IDIwMjPlubQ45pyI
MjTml6UgODozMQrmlLbku7bkuro6IGFsbG9jLnlvdW5nQG91dGxvb2suY29tCuaKhOmAgTogcWVt
dS1kZXZlbEBub25nbnUub3JnCuS4u+mimDogUmU6IFtQQVRDSF0gc29mdG1tdTogRml4IGRpcnR5
bGltaXQgbWVtb3J5IGxlYWsKCgoKT24gV2VkLCBBdWcgMjMsIDIwMjMgYXQgMzo0OOKAr1BNIDxh
bGxvYy55b3VuZ0BvdXRsb29rLmNvbTxtYWlsdG86YWxsb2MueW91bmdAb3V0bG9vay5jb20+PiB3
cm90ZToKRnJvbTogImFsbG9jLnlvdW5nIiA8YWxsb2MueW91bmdAb3V0bG9vay5jb208bWFpbHRv
OmFsbG9jLnlvdW5nQG91dGxvb2suY29tPj4KCkZpeCBtZW1vcnkgbGVhayBpbiBobXBfaW5mb192
Y3B1X2RpcnR5X2xpbWl0LHVzZSBnX2F1dG9wdHIKaGFuZGxlIG1lbW9yeSBkZWFsbG9jYXRpb24s
IGFsc2UgdXNlIGdfZnJlZSB0byBtYXRjaCBnX21hbGxvYwomJiBnX25ldyBmdW5jdGlvbnMuCgpT
aWduZWQtb2ZmLWJ5OiBhbGxvYy55b3VuZyA8YWxsb2MueW91bmdAb3V0bG9vay5jb208bWFpbHRv
OmFsbG9jLnlvdW5nQG91dGxvb2suY29tPj4KLS0tCiBzb2Z0bW11L2RpcnR5bGltaXQuYyB8IDI2
ICsrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTIgaW5zZXJ0aW9u
cygrKSwgMTQgZGVsZXRpb25zKC0pCgpbLi4uXQpkaWZmIC0tZ2l0IGEvc29mdG1tdS9kaXJ0eWxp
bWl0LmMgYi9zb2Z0bW11L2RpcnR5bGltaXQuYwppbmRleCAzYzI3NWVlNTViLi5mYTk1OWQ3NzQz
IDEwMDY0NAotLS0gYS9zb2Z0bW11L2RpcnR5bGltaXQuYworKysgYi9zb2Z0bW11L2RpcnR5bGlt
aXQuYwpAQCAtMTAwLDcgKzEwMCw3IEBAIHN0YXRpYyB2b2lkIHZjcHVfZGlydHlfcmF0ZV9zdGF0
X2NvbGxlY3Qodm9pZCkKICAgICAgICAgICAgIHN0YXQucmF0ZXNbaV0uZGlydHlfcmF0ZTsKICAg
ICB9CgotICAgIGZyZWUoc3RhdC5yYXRlcyk7CisgICAgZ19mcmVlKHN0YXQucmF0ZXMpOwogfQoK
Q29kZSBvcHRpbWl6YXRpb24uCiBzdGF0aWMgdm9pZCAqdmNwdV9kaXJ0eV9yYXRlX3N0YXRfdGhy
ZWFkKHZvaWQgKm9wYXF1ZSkKQEAgLTE3MSwxMCArMTcxLDEwIEBAIHZvaWQgdmNwdV9kaXJ0eV9y
YXRlX3N0YXRfaW5pdGlhbGl6ZSh2b2lkKQoKIHZvaWQgdmNwdV9kaXJ0eV9yYXRlX3N0YXRfZmlu
YWxpemUodm9pZCkKIHsKLSAgICBmcmVlKHZjcHVfZGlydHlfcmF0ZV9zdGF0LT5zdGF0LnJhdGVz
KTsKKyAgICBnX2ZyZWUodmNwdV9kaXJ0eV9yYXRlX3N0YXQtPnN0YXQucmF0ZXMpOwogICAgIHZj
cHVfZGlydHlfcmF0ZV9zdGF0LT5zdGF0LnJhdGVzID0gTlVMTDsKCi0gICAgZnJlZSh2Y3B1X2Rp
cnR5X3JhdGVfc3RhdCk7CisgICAgZ19mcmVlKHZjcHVfZGlydHlfcmF0ZV9zdGF0KTsKICAgICB2
Y3B1X2RpcnR5X3JhdGVfc3RhdCA9IE5VTEw7CiB9CgpMaWtld2lzZS4uLgpAQCAtMjIwLDEwICsy
MjAsMTAgQEAgdm9pZCBkaXJ0eWxpbWl0X3N0YXRlX2luaXRpYWxpemUodm9pZCkKCiB2b2lkIGRp
cnR5bGltaXRfc3RhdGVfZmluYWxpemUodm9pZCkKIHsKLSAgICBmcmVlKGRpcnR5bGltaXRfc3Rh
dGUtPnN0YXRlcyk7CisgICAgZ19mcmVlKGRpcnR5bGltaXRfc3RhdGUtPnN0YXRlcyk7CiAgICAg
ZGlydHlsaW1pdF9zdGF0ZS0+c3RhdGVzID0gTlVMTDsKCi0gICAgZnJlZShkaXJ0eWxpbWl0X3N0
YXRlKTsKKyAgICBnX2ZyZWUoZGlydHlsaW1pdF9zdGF0ZSk7CiAgICAgZGlydHlsaW1pdF9zdGF0
ZSA9IE5VTEw7CgpMaWtld2lzZS4uLgogICAgIHRyYWNlX2RpcnR5bGltaXRfc3RhdGVfZmluYWxp
emUoKTsKQEAgLTY1Myw3ICs2NTMsOCBAQCBzdHJ1Y3QgRGlydHlMaW1pdEluZm9MaXN0ICpxbXBf
cXVlcnlfdmNwdV9kaXJ0eV9saW1pdChFcnJvciAqKmVycnApCgogdm9pZCBobXBfaW5mb192Y3B1
X2RpcnR5X2xpbWl0KE1vbml0b3IgKm1vbiwgY29uc3QgUURpY3QgKnFkaWN0KQogewotICAgIERp
cnR5TGltaXRJbmZvTGlzdCAqbGltaXQsICpoZWFkLCAqaW5mbyA9IE5VTEw7CisgICAgRGlydHlM
aW1pdEluZm9MaXN0ICppbmZvOworICAgIGdfYXV0b3B0cihEaXJ0eUxpbWl0SW5mb0xpc3QpIGhl
YWQgPSBOVUxMOwogICAgIEVycm9yICplcnIgPSBOVUxMOwoKICAgICBpZiAoIWRpcnR5bGltaXRf
aW5fc2VydmljZSgpKSB7CkBAIC02NjEsMjAgKzY2MiwxNyBAQCB2b2lkIGhtcF9pbmZvX3ZjcHVf
ZGlydHlfbGltaXQoTW9uaXRvciAqbW9uLCBjb25zdCBRRGljdCAqcWRpY3QpCiAgICAgICAgIHJl
dHVybjsKICAgICB9CgotICAgIGluZm8gPSBxbXBfcXVlcnlfdmNwdV9kaXJ0eV9saW1pdCgmZXJy
KTsKKyAgICBoZWFkID0gcW1wX3F1ZXJ5X3ZjcHVfZGlydHlfbGltaXQoJmVycik7CiAgICAgaWYg
KGVycikgewogICAgICAgICBobXBfaGFuZGxlX2Vycm9yKG1vbiwgZXJyKTsKICAgICAgICAgcmV0
dXJuOwogICAgIH0KCi0gICAgaGVhZCA9IGluZm87Ci0gICAgZm9yIChsaW1pdCA9IGhlYWQ7IGxp
bWl0ICE9IE5VTEw7IGxpbWl0ID0gbGltaXQtPm5leHQpIHsKKyAgICBmb3IgKGluZm8gPSBoZWFk
OyBpbmZvICE9IE5VTEw7IGluZm8gPSBpbmZvLT5uZXh0KSB7CiAgICAgICAgIG1vbml0b3JfcHJp
bnRmKG1vbiwgInZjcHVbJSJQUklpNjQiXSwgbGltaXQgcmF0ZSAlIlBSSWk2NCAiIChNQi9zKSwi
CiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIiBjdXJyZW50IHJhdGUgJSJQUklpNjQgIiAo
TUIvcylcbiIsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgbGltaXQtPnZhbHVlLT5jcHVf
aW5kZXgsCi0gICAgICAgICAgICAgICAgICAgICAgICAgICAgbGltaXQtPnZhbHVlLT5saW1pdF9y
YXRlLAotICAgICAgICAgICAgICAgICAgICAgICAgICAgIGxpbWl0LT52YWx1ZS0+Y3VycmVudF9y
YXRlKTsKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBpbmZvLT52YWx1ZS0+Y3B1X2luZGV4
LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8tPnZhbHVlLT5saW1pdF9yYXRlLAor
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluZm8tPnZhbHVlLT5jdXJyZW50X3JhdGUpOwog
ICAgIH0KLQotICAgIGdfZnJlZShpbmZvKTsKRml4IG1lbW9yeSBsZWFrLgogfQotLQoyLjM5LjMK
CkknbGwgY2hvb3NlIHRoZSBtZW1vcnkgbGVhayBtb2RpZmljYXRpb25zIHRvIGtlZXAgdGhlIHBh
dGNoIGZvY3VzZWQgb24gYSBzaW5nbGUKaW5kZXBlbmRlbnQgaXNzdWUuCgpPaywgd2lsbCBzZW5k
IGEgcGF0Y2gganVzdCB0byBmaXggdGhpcyBpc3N1ZSwgdGh4CgpBbnl3YXksCgpSZXZpZXdlZC1i
eTogSHltYW4gSHVhbmco6buE5YuHKSA8eW9uZy5odWFuZ0BzbWFydHguY29tPG1haWx0bzp5b25n
Lmh1YW5nQHNtYXJ0eC5jb20+PgoKLS0KQmVzdCByZWdhcmRzCg==

