Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 068F07E3EE2
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 13:43:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0LQQ-0007ag-1f; Tue, 07 Nov 2023 07:43:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r0LQM-0007TY-OZ; Tue, 07 Nov 2023 07:43:18 -0500
Received: from mail-lo4gbr01on20701.outbound.protection.outlook.com
 ([2a01:111:f403:261a::701]
 helo=GBR01-LO4-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r0LQH-0000ZH-Gh; Tue, 07 Nov 2023 07:43:18 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i2B8g/Qpi6jruj9Rocy67HD7YxOb9wGiO/UM/eE+LPM9c7W4GOQxUDdIqQyR4ewprFTEjgxjQwt3nGnHjxWWKSYDtVITXLCR8IQaI54Ks8EKvFMkqy9vlZPSauYthSn2dFVWQjrHpvjJ+Z+ZmVqErQtWxpF6Up0+jWH+OjsTMGNL6/sedXIi0kfap75FQ/Daca/2jgkK2Cx0EPw/L7IfUHefscktZkuUtR+Ch1SMGTpOloeweeWubAI94ODLvNzfDEQquxSNgOvxqSL2AhfNrlosg9ibM3YsL0q5AezDLkkpXRFxN7LaMw+kER2vv5UdHx2pcAbhgeoUDivMh+ysWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dM03CzI2oDRqAa+Wa0EP1RB+j2+LNnfj3f4IYa8miCY=;
 b=Behe4k77rUFYwQAC7E/gclsxKur4gUvnoRL4QTC2+lAyXxFuwmrPaKaUEdsNGr6EuEomwMT2ht4VnaBkc7P4xkiAXNZFO9rswgCIsRF6/D3reAqWJWAhWE5O6m3AGy9wm2kMkCxNmFWaHhxOzagZVNUht4gi7DMuI8xHegszT/KuOU0zMvQweabF4O92J9dMKwPdO3LS1XBV0rg/984c3lA1y+QtF/q5/X3QXGWUP56Ha7kgQtXVVOEVsAkx9+Dki4CYS/XvsefdbE17arJWQftiVM42bDSgGnkm//0yoAapIqSukLtJNdtOYsYqoXIIP/iaWNzytnJeVpzZu6qKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dM03CzI2oDRqAa+Wa0EP1RB+j2+LNnfj3f4IYa8miCY=;
 b=TGDAS81mt41E/mFf0KDUxJ0OeaI4YxR8+7EQpgIRaVXSJaf8v4GBRlk/seKitQjYijiKXJfpLIOlUDxPi+8/TUtdvDio0WcCtQIzmAsNiLftraLhAd+Bvx9/eqjv1E9fCjNDvWXFw5DQmQX88p8CqxnuGdrt8LRxI51zVfCwrlo=
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by CWLP123MB5795.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:15f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 12:43:06 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::ce49:22a9:ed78:7f39]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::ce49:22a9:ed78:7f39%3]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 12:43:06 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Alex_Benn=E9e?=
 <alex.bennee@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 =?iso-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>, Peter Maydell
 <peter.maydell@linaro.org>, =?iso-8859-1?Q?Marc-Andr=E9_Lureau?=
 <marcandre.lureau@redhat.com>, Laurent Vivier <laurent@vivier.eu>, Mahmoud
 Mandour <ma.mandourr@gmail.com>, Cleber Rosa <crosa@redhat.com>, Wainer dos
 Santos Moschetta <wainersm@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>, John
 Snow <jsnow@redhat.com>, =?iso-8859-1?Q?Daniel_P=2E_Berrang=E9?=
 <berrange@redhat.com>, Chris Wulff <crwulff@gmail.com>, Marek Vasut
 <marex@denx.de>, Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 14/22] plugins: make test/example plugins work on windows
Thread-Topic: [PATCH 14/22] plugins: make test/example plugins work on windows
Thread-Index: AQHaEOI/He2Vr1tjpkGxX3DlH73njbBunB2AgAAAbBCAACdUgg==
Date: Tue, 7 Nov 2023 12:43:06 +0000
Message-ID: <CWXP123MB4341C5B85F101081C325619CD7A9A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
References: <20231106185112.2755262-1-alex.bennee@linaro.org>
 <20231106185112.2755262-15-alex.bennee@linaro.org>
 <ea92d71f-35a3-4a5f-bece-01436a33e1e8@redhat.com>
 <CWXP123MB4341A5286537C5060BA71FB8D7A9A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
In-Reply-To: <CWXP123MB4341A5286537C5060BA71FB8D7A9A@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP123MB4341:EE_|CWLP123MB5795:EE_
x-ms-office365-filtering-correlation-id: 5444803c-ed6c-4e5e-19d3-08dbdf8f173f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5aPE0ZP2SqgP6dIyCPxu063rQb7SjnaY7jg+ca2nUJ3prJZxA3d63DP7BSTqpSACGAmwB2bIIq3j/8awCWqtLWHHJhrc14+tihHshcV/PTZsS8r3oKD4vawsplJndf36Wrqe4USKzMQbh3GYWOO6U2xdvP56t3t2CLHZ2Cyz+yaWf7/gu3Cgs+VLyM0SNM/s1cfFldHiioKE+iczQeWUVx7KVQlKL3NdyMMKzoYqImw3Sb/36/zaleIKByDG+0Pfd/LnQxAeCgqHZMQYTEMkvmmeFoaXj2CvIRTJ71sW0WKfNSBjuy7Jr6YyXdxxIp5PljQx2559bSsFpEO69o9chRkYTTKsBBWBY7pPwGZj0lGoYaVrOvNVsNKNWL25z+07YrH6w7NZ+lmBQe3ozOycIz8hnss+7fiX3U2aIEaMRwjo7iCZXVV71th95aaelzHv1WfTd78qkH4+tcbf6V0W5k3wvxSUCuh+4kSJpTiYxiFQYxv4HoPDoox57ynf6Ba/r+e0aUNkxODZ4iB2xp9sH0VdooXf5r2ackIzHfJq+RtOdyHUfrJ6UOrHFewhFh2hM0J3bVl7kojKuPwv6zphYpWhddwF5yI+i5FfuKS2QCzxgiYuCPGCiRw6TeFE6saMcYeTHRIenLKZy/8sIxvuLA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(376002)(396003)(136003)(39840400004)(366004)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(55016003)(478600001)(38070700009)(86362001)(83380400001)(38100700002)(122000001)(33656002)(7696005)(6506007)(76116006)(9686003)(2940100002)(316002)(66446008)(66946007)(64756008)(54906003)(66476007)(91956017)(71200400001)(45080400002)(110136005)(66556008)(26005)(19627235002)(7416002)(2906002)(5660300002)(41300700001)(8676002)(8936002)(52536014)(4326008)(460985005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?fOKjvpELjisnRUM8VaG98BUoJIUe90g6XFBAZA6yKmyGkNp0cdKBlfhtqY?=
 =?iso-8859-1?Q?A1jHfpby6GGOTVjD7f12xIjD2qGbXL3tajDPoCXQg/oAqs6Fzf7fnHR6dJ?=
 =?iso-8859-1?Q?lGAYLeraEFEnNL8hKIZU2EwbnWFRh88S56vdqfiWyMS8f14+OoKFNdV0kA?=
 =?iso-8859-1?Q?lh4VW7fCuKCImlNBg653vxJIL5Ip1RmtdNz3mmfIZFX3kDH/7OPLHXF+jB?=
 =?iso-8859-1?Q?P4l+Fc2NJGHG5P7n1zBsD969UTBK83YUL6HaXlVrjEAVJ4u8l8OBBR03H+?=
 =?iso-8859-1?Q?MabXrsjPsmq4Qotk5nODdM60weRKp1kBfrWjXfgTfAnTlAM6kDYj2wO5r9?=
 =?iso-8859-1?Q?4vpo0KxEFmAXtsr2ALKBfmucb3ya/iZ32scTMt8mbduUFF98qkL1THQLrD?=
 =?iso-8859-1?Q?S9UPOKP4zEMwEBqyimfgnahkvohfyU2MzpbemXClOnAdilLrop/TsETGcV?=
 =?iso-8859-1?Q?fZWahD8VACWYh8nsRR/tdbGbU4MMqIQh1+56ONPwTICqs8ruI0UkxbhhJb?=
 =?iso-8859-1?Q?3JJIKAMz86Oz5/dDhNe2+sjPgGHAChrBLeLqtzTXXlpTnP0HVCkhVOhGP4?=
 =?iso-8859-1?Q?q0LQJ+qYhQXLBF8zHKzWVsbilguVpi/0VNEqas/dCn8yfzprfhlmZHjRV1?=
 =?iso-8859-1?Q?fC5gIwNcjjwjtLQSQo1IeurW/t1YoDbQ7azHpJXAjOyFxWMsRep+3mM84n?=
 =?iso-8859-1?Q?IKXAf9hvgU3xgkB06yBTopy+MKoZbDw2Dwy/CFqdvG/ChIKCdMEiKPUoKv?=
 =?iso-8859-1?Q?t5H79QTI7fSXKdo229UfmDOM9keaiMeehS/GAYj8118IJYTOo0/b6Ww49V?=
 =?iso-8859-1?Q?HX0fueRDa+PFuYujkaTsWHl/eBCKqwcsf5OZOsdSUZRlU3a9ec9KNy7z2x?=
 =?iso-8859-1?Q?r4UmCr/YnqkYqcGN0awlnOap2EGWOmOce0SQDVxmZ1hMsFMmkVfnZD6ErT?=
 =?iso-8859-1?Q?1hJJntZXKi8QW6t+r00R31jKcFNi5AHfgPsXBO7DybD2ZihMsFzOpiDHXr?=
 =?iso-8859-1?Q?r1/ieymKEEeSxs98nGfav9R0fJa04LG72gY8cRuetoNCJbzsEJlHa7BNMy?=
 =?iso-8859-1?Q?Lro6VHwQzwLaYQpJLUyupFHZcduN3oL8hfQHOdVjTR0NgVLfhnx848/hCG?=
 =?iso-8859-1?Q?45jqsGrA+fYP3jyhhZvkVLSmLr6/mQrz4ZRC3/49ffewRIysvFz/dbxayf?=
 =?iso-8859-1?Q?J1xoos8iyPAD+rXr+9pXnaFnr1U5ZiI2GYDbbe2lD5dOaVEbeR9dlaNqnY?=
 =?iso-8859-1?Q?b9DbHkcBC3dOPyXRcQqtHVyIqsOjSoGUKIBcquTxHM+z9Hha0PjVOGHw4l?=
 =?iso-8859-1?Q?9dP5TAqqwIBvtS6UJAbc1a5X0TNWfy8Z1vzY0urvrt5F/AX3AmGhtR4Sp1?=
 =?iso-8859-1?Q?ZByvr4eA5/vlM0IX045jbG4MpEGEd6+7yIChOsHBjat8DeM1D1Bxeon7mZ?=
 =?iso-8859-1?Q?Q1zeMOhwnvwm5HOktVud/cVQHC17p+haQUAYdoPK4ADWMHJMY+uzYzXeTo?=
 =?iso-8859-1?Q?xsUrbBExTdwmL9oN9V56OoIG0CDow93+B2uY/W55blDMWgwNZ+4dDF8RCb?=
 =?iso-8859-1?Q?VFTJ4zHXvlIp54bw5b9YYw9FXZUxs1RBBwGjNivCNpQBjPPKtGCT3ntQ/J?=
 =?iso-8859-1?Q?khUjHKNpggcGwHJBjKHyNvzMdlT6US5Uqs?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5444803c-ed6c-4e5e-19d3-08dbdf8f173f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 12:43:06.6138 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eGKumavHKd8o1fLUr8+0KfRjoNMY87nckdclyXtDixSWXphAuo0V+Tiuua6fMtTBa/qhFUGgaU/fll4SzbJpQ0CwFnar03ORf0MQBKUfLX4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP123MB5795
Received-SPF: pass client-ip=2a01:111:f403:261a::701;
 envelope-from=gmanning@rapitasystems.com;
 helo=GBR01-LO4-obe.outbound.protection.outlook.com
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

> > A bit more important: would it make sense to include the hook *in the
> > QEMU executable itself*, rather than in the DLL?  If it works, it would
> > be much preferrable.  You still would have to add the .lib file to the
> > compilation, but win32_linker.c could simply be placed in os-win32.c
> > with fewer changes to meson.build and the makefiles.

> My initial trials of this didn't work. But having read the docs again, I'=
m
> going to have another go at it now...

Here is a diagram of what's going on.

  /---dynamic load------v
qemu               libplugin.dll
  ^---delay load--------/

First, qemu dynamically loads the plugin, which does no linking. It finds
the function qemu_plugin_install, and invokes it. As soon as libplugin.dll
calls any qemu_plugin_* function, the delay loader steps in and searches fo=
r
qemu.exe. It fails to find it, and the delay failure helper steps in and
returns the right reference to the top level executable. Everything gets
linked OK.

Windows will look for __pfnDliFailureHook2 in the module doing the delay
loading, which in this case is the plugin DLL. So, the __pfnDliFailureHook2
function pointer needs to be in the plugin DLL. We could have qemu set the
value of that pointer before it calls install, but I can't find the way to
expose a function pointer in such a way that `g_module_symbol` can find it.
Possibly we could pass in a pointer to it in qemu_plugin_install or a new
qemu_plugin_set_linker_fn, but that is getting back to the sort of
shenanigans we're trying to avoid, and which previous attempts at windows
plugins were based on.

so: maybe, but I'm not sure it would be any tidier.

Greg.
--

Follow Rapita Systems on LinkedIn<https://www.linkedin.com/company/rapita-s=
ystems?utm_source=3Drs_email_sig>

