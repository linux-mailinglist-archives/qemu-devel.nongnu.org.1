Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 400E97E724E
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 20:29:14 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r1Ah2-0004gl-AY; Thu, 09 Nov 2023 14:27:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r1Ah0-0004eu-Bf
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:27:54 -0500
Received: from mail-cwxgbr01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:261b::700]
 helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r1Agy-00052F-6t
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 14:27:54 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLg/Y+HzhZtsgbosMehfgpes7RTxkFiuXFkGGkiewjslJq+zJnipdI2k9a3NGhm3xYxf868WT6gJn1FZjuIcvY6acRtiqMihav4rMuvnHp0iNCQA51wDVNDOmGTtBlTEntdNubFJSrIwg14HwieS13KUw4PnO6o9nSiIKeAPYfLBeEOf0GB2GAatsInd9m5AaODl3xioAqBbJ3HsMgCycZ/jRjcNwehfbgiE+Q0u2xMK7jB+w2AatkeWKtoNg8G1dPwVdvBE0z7TiytrlU6I1FkrPd7ijRkX78gbo4hAMJ+fuPH6WPlehkMmrNOnLTHxMg68YyD0tjl+IznC2LFY9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ehFZPwaTN6DKEx3W8r+12Pyv5Jz5UTB6+FIuO7TnNFg=;
 b=IbdgL8MutIDVY27rQJWAcPeeXvvS3AXV4BypcZUA1qo1/C6FBV4Jw5dGL7hmydI5SrN/fTo2Xl8Kgp9O2mlPmYah22FUT3R45hvlQ98uAPeL9mgPC7vDjWB39YcWb2W41cfq4Z3SVCJ7y7f6k2GS6xRlwNx/+Is7DUz1Q0ETAvRw/wUPQhTBy4hYixjfI2Gl7R9AtDrrpkQZ7r1JfvD/LJG3E4lUDwi7xkCl0WjwfTnNysA7oCD6N6qA2UW1qb5noIc6DoW0NTQdLwp1jShiN3J3Yool8R2+pfWi/s8c4aT0hnwUOh2QgYYdy8l49rXIfQjRp/LUjiCuEUvj7f5lww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ehFZPwaTN6DKEx3W8r+12Pyv5Jz5UTB6+FIuO7TnNFg=;
 b=dSubMag1e2XIjKROhIKjHDBbTV1vHLNca/zxRZi180oEcf6YguOWld+9ZUPmFYeWpvmBnOafKi9vv2QBWit4nn8fmCPm9qD9ryJzwWBzfAkmIMZgl0yBCQCGA1zPQbVIjztGz28tVnUF32j4QxJeFqBJYFmE4SHHdcA8yYrDWl8=
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by CWXP123MB2888.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:3d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 19:27:48 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 19:27:48 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3 0/1] plugins: fix win plugin tests on cross compile
Thread-Topic: [PATCH v3 0/1] plugins: fix win plugin tests on cross compile
Thread-Index: AQHaEwpnGS/gt3aevUaWaX74pb2D4LByJrukgAA3GJc=
Date: Thu, 9 Nov 2023 19:27:48 +0000
Message-ID: <CWXP123MB4341D73041E478DCB3F6D1C1D7AFA@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
References: <20231109124326.21106-1-gmanning@rapitasystems.com>
 <87msvm7w1p.fsf@draig.linaro.org>
In-Reply-To: <87msvm7w1p.fsf@draig.linaro.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP123MB4341:EE_|CWXP123MB2888:EE_
x-ms-office365-filtering-correlation-id: ab51ab0e-c15d-4b29-5d80-08dbe159f523
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tC7Rr+vfscs5MzJ7SOoVr0KoIiN0ba0j2vMINrIn61bjVl/ZT1cw17iM1YC/Y4fxKECKR+xzOia0kQiqYdwPlzYafDiPiEISWgCCpd8ORzjvRBntfJScrhkDZzQNBKnkR7/zDJtN17X/67jFLtnBQ6a8BPdWbCpBoQa18lNxF6x6aMBWMOJdZpwBTXtFcT7uaeC9/BP6wO4g2Gv1yiin4lVjvKjFl9BSVQ0F/cbBGtnxHKgFcPKPi1kVjd4iM8TkrQUkRpz+bN5el8gQGHbP7KWJO5Qp82qrMxVe0MvwuJ+QyU0jejXhtELRZvaIWGJ5hUQs/yjGmbpGcbo8nLKP6X5GlzpmyL8SQkt8Qe+m5WjxGUMSGInGKpYUizXP6Lz0ikSzD1K8mtVP2n/c+87ytYm9s9Ss4H0+NFxA/0zKNs1UWykVKX9TWI9EnPGGf9AXaC8zB1yM3Ek4MCJzTxyENqHJR/lhUk81q9TY46PzsfYCGAXOOTAK9CE4QHO7vcj0oGF8Kkdi93pCDHkTM7FEcc77vldQprLvmtZVntS3ZC9ppoQh0Zm6kyERgolG/QerN8q8jD5qLyg2P+FnYhpOxFIsYw1x+G5mZMd0mocR2EB2u52V3RQGdT81+j0x9YJhvrHLm/NuCBM43J5l4IVx5A==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(346002)(366004)(39850400004)(136003)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(33656002)(38070700009)(52536014)(4326008)(55016003)(478600001)(5660300002)(83380400001)(8936002)(8676002)(6506007)(2906002)(66476007)(66556008)(64756008)(76116006)(54906003)(26005)(66946007)(91956017)(316002)(9686003)(66446008)(6916009)(7696005)(71200400001)(86362001)(122000001)(41300700001)(38100700002)(460985005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?ysF5VZ6Po6yi5TrtS9bXOa5iTknfA1GFa1/llw6giqUD/T5H1T7G9UIJtw?=
 =?iso-8859-1?Q?Cv6iNJS/m3vJoApI3XjbUvO22fT34sWG/5Pxlft97LCPfthrpym8vyKkWk?=
 =?iso-8859-1?Q?kLQxypZJPox3vl/yWxs87fBEavZRJ3qThDUn4+08t4ip+c5dckUvdqSTGL?=
 =?iso-8859-1?Q?pk4DPAZenp5UXsbTwtt5jarC69Z3zok3EjPXNFimeQh7rBPcWjQt5sVpAE?=
 =?iso-8859-1?Q?yo3DOAelecANfzydIsSLSjE/g31kk9IH0AD9G0drQ9Pz9dU/+McmbdSjoJ?=
 =?iso-8859-1?Q?/BOxz8Uy6yr9ifP4B/9/wIVjyV9CXVutwtwn+d5QtujI3tW5/cgYKPZ/Gk?=
 =?iso-8859-1?Q?DEgwtdpeKS1yj15aXanHRGAQ0C81unWSo2wFnv2i7705NuTnVDfHpho15V?=
 =?iso-8859-1?Q?MlSmI1RG72SF52QnnUOgK2++alA2wwvZgIReGPojJZZMc+ZkI74X+qWKdu?=
 =?iso-8859-1?Q?ohdfyRic2pUqAVtoZ/jj8lDnTOfs8xcF5J+mipmE7u6qVwocorm6Y71vmO?=
 =?iso-8859-1?Q?wf3CVM4AvENMZ618bKyuwLr4mZjvpuVOqPaJPkH0VQ1Ss9Ye/qhBYiJe8o?=
 =?iso-8859-1?Q?NeeuDyBI62L8rSFSYNgaaOg4hB3C1+raHRfCe0FaicHZcKhG0htLi//1sb?=
 =?iso-8859-1?Q?XRwkBqcbSFdhDdB/VwCgRYH5KuO7I2meJx2kXkmO2WbuWirJfVhixATvdn?=
 =?iso-8859-1?Q?ox6yAJC99eUeie1j8ABXlpU9veH9RjK1xux5uh+EzmWZ2hc8nmdntrUNgy?=
 =?iso-8859-1?Q?TCAHBGA3L70ANKYWFltcQ7giXN8LoGtVhnkbdx6k2gEupNVbr02L2KQGhK?=
 =?iso-8859-1?Q?eBGqg9zT0XlBhdgiwFatZ03cN6THUH78KZRaXmDaRiFnZL1cw2xEGzS4w+?=
 =?iso-8859-1?Q?4OV2e1ttKDAnYebKlLV6Ykn0jEll8p6DZA/pZ9g5ir3iuPen/q/taBizzh?=
 =?iso-8859-1?Q?hv/gNAcw4BlIlU6Y1HuTGnMY2ve8jPsL1OpK/NakBXcMG8UepyxXsZ+5zJ?=
 =?iso-8859-1?Q?qiBMHYMtbZds1zvjl71Pcq9RIiaMcLaU+XlgE33c7pIt+7JwDOagziCUkA?=
 =?iso-8859-1?Q?tnyAu0NCfHg4JCe/VtLCwE05ijm4e8apdtkW/JCFTofnGbHmP7TIW2O+pQ?=
 =?iso-8859-1?Q?Z5F6PImYQAdnXyaZSVwJ6BsrZOXFqPZ7Zxek9nr1rB8NlbevXxmNc+3tjX?=
 =?iso-8859-1?Q?rO+Zggd2Zps5svK+xNGDf3+3HSFTWue0pAX6Nmo+dMB9b8Ubcrk1TvYIcw?=
 =?iso-8859-1?Q?KapABHLTzR/6uZ7cxfMA5RLPSWoD2xGCsw8A4diLyyIz06R9oKewKLgMtz?=
 =?iso-8859-1?Q?JB48nd8+xAgPAfwPmU3SzS4FZdKmfaxzcHgSRwfWGd9i6PNBlWxGJbZ62K?=
 =?iso-8859-1?Q?HT9s3a2IBdxbuAH6P24CjgQ1Ji/Cpz4QGBogMqhO8Mcn5AT1s05bCZ2qK7?=
 =?iso-8859-1?Q?cizVJISDqXQVoj0HLBPzEpJSjuW8li0t4MIv7Bgbiq5YB6YxdswyDn0TNh?=
 =?iso-8859-1?Q?b6cZ46Tk0EXX2ayOU4nJl2bsvC6mKMW9ABUkJQnZ3ZcHberkYruoBiMGct?=
 =?iso-8859-1?Q?Ygnr+hcAghtZRApW/Rk9H1EJjEwYUBayoN02m6L957DjPQmSd0KKcoVvja?=
 =?iso-8859-1?Q?UFQLPv/WyoH4YSsj8c2rZYHMr9kp6pG5jt?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: ab51ab0e-c15d-4b29-5d80-08dbe159f523
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 19:27:48.3992 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9wpjCwMVZc0kqiA2/CX51DrWX16aW03tsdwX4okxKa6lH950wV1iXHonaTaH/bxh4c5qLmsCkMstnvJr0dqvhqUf504J7n9sZWaVrtKNktg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWXP123MB2888
Received-SPF: pass client-ip=2a01:111:f403:261b::700;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-CWX-obe.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
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

Alex Benn=E9e <alex.bennee@linaro.org> writes:=0A=
=0A=
> Greg Manning <gmanning@rapitasystems.com> writes:=0A=
=0A=
> > v1-v2: Added the signed-off-by line.=0A=
> > v2-v3: Fixed the issue reference.=0A=
> >=0A=
> > Greg Manning (1):=0A=
> >   plugins: fix win plugin tests on cross compile=0A=
> >=0A=
> >  .gitlab-ci.d/crossbuilds.yml | 2 +-=0A=
> >  contrib/plugins/Makefile     | 2 +-=0A=
> >  plugins/meson.build          | 2 +-=0A=
> >  tests/plugin/meson.build     | 3 ++-=0A=
> >  4 files changed, 5 insertions(+), 4 deletions(-)=0A=
=0A=
> Actually I'm still seeing failures:=0A=
=0A=
>   FAILED: qemu-system-aarch64.exe=0A=
>   x86_64-w64-mingw32-gcc -m64 -mcx16 @qemu-system-aarch64.exe.rsp=0A=
>   /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/b=
in/ld: libcommon.fa.p/os-win32.c.obj: in function `set_dll_delaylink_hook':=
=0A=
>   /builds/stsquad/qemu/build/../os-win32.c:83: undefined reference to `g_=
module_symbol'=0A=
>   /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/b=
in/ld: /builds/stsquad/qemu/build/../os-win32.c:89: undefined reference to =
`g_module_symbol'=0A=
>   collect2: error: ld returned 1 exit status=0A=
>   [2104/3331] Linking target qemu-system-aarch64w.exe=0A=
>   FAILED: qemu-system-aarch64w.exe=0A=
>   x86_64-w64-mingw32-gcc -m64 -mcx16 @qemu-system-aarch64w.exe.rsp=0A=
>   /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/b=
in/ld: libcommon.fa.p/os-win32.c.obj: in function `set_dll_delaylink_hook':=
=0A=
>   /builds/stsquad/qemu/build/../os-win32.c:83: undefined reference to `g_=
module_symbol'=0A=
>   /usr/lib/gcc/x86_64-w64-mingw32/12.2.1/../../../../x86_64-w64-mingw32/b=
in/ld: /builds/stsquad/qemu/build/../os-win32.c:89: undefined reference to =
`g_module_symbol'=0A=
>   collect2: error: ld returned 1 exit status=0A=
>   [2105/3331] Compiling C object libqemu-loongarch64-softmmu.fa.p/hw_loon=
garch_virt.c.obj=0A=
>   ninja: build stopped: subcommand failed.=0A=
>   make: *** [Makefile:162: run-ninja] Error 1=0A=
=0A=
Oh, that's weird. I can't immediately repro it on WSL. It reminds me of the=
 thing=0A=
I had to do to get the plugins to compile - they needed glib passing to=0A=
the linker explicitly (in contrib/plugins/Makefile):=0A=
=0A=
LDLIBS +=3D $(shell $(PKG_CONFIG) --libs glib-2.0)=0A=
=0A=
Greg.=

