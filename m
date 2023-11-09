Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DA0B67E6A93
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 13:29:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r148n-00041A-TV; Thu, 09 Nov 2023 07:28:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r148m-00040l-9I
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:28:08 -0500
Received: from mail-cwxgbr01on20700.outbound.protection.outlook.com
 ([2a01:111:f403:261b::700]
 helo=GBR01-CWX-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gmanning@rapitasystems.com>)
 id 1r148k-0008ND-4e
 for qemu-devel@nongnu.org; Thu, 09 Nov 2023 07:28:08 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m83GSLWAPayJPOvvC4im8uUEmsJJdlashZN5q4OYa8NTOeq/BeogvqKUqGulg7jeT4hyrDetaN4/iD8y+lxSjSYs3asQKLEAaoUybPyoEdnOXyq42VDLK13Qp1MxidLKap2jQ5y2P1TjWi/yZe9zWQena3+pwZS8Ix83RL73/oLq9Jk6MQdn/rzmKtUGPxGJ3OyXKwvwejjlp0Wq0keJmpbpR+A7ZxuRN2EUy4lz1e4XrESiEcslUXJHGxRZn9ueRmnyj5a1SaaXferjAD0mRQVS6P/RAdvxp9WeXlV/RnKgyIwA1QBIpQrwUhYa7rJsku7Icb+wiAzsjg9tV8IapA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U/rPh48wVc6yKbm0fu3pTCzB8+u2ImDUxOLuh7TuhKQ=;
 b=KeYs38yaCWyd7nYlaxOlwMVzPthdP7oxRHIaMft/zOL04S3tLVFr/i2/s7OIds90YbjRvbBszpUw223X6P6wbbuEiI/2kFT5On+kEB7TIcGapiFQH8fK6RkuRnRhqK4TiS9HiQFvC+WjZ4YsEM/kCBKDUhe/6EWswyscJGhjiLqedyQlSjzIUZqGdxvSL5cXRpv+WaKBrCjmWTQ69nqcYMjoDyktxSRMBW8h4O56iaqpAU6MFKt2hSmonx/bS/DU4UbgU7nmyfRX9wFu9Fo0MW7fL3Vhh0+tBf5LvWQY/FZCgDvBMGWP8+XrFo5HduDcMp35ltN7vIFSyIrgLmdXbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=rapitasystems.com; dmarc=pass action=none
 header.from=rapitasystems.com; dkim=pass header.d=rapitasystems.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rapitasystems.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U/rPh48wVc6yKbm0fu3pTCzB8+u2ImDUxOLuh7TuhKQ=;
 b=Kz0h/adoYdZkVz3L42H8sJPi4Mif9uGaCzIeuWvMjU/wMyNCLi4ogfM+0Tnvhc9rsWYyBT54k0wzF9RJ901J+VzmBARu288vVlcTzdvsbaa6jdFIGPmDSz1i9ybIUPaDQCa49HOs08ORRdWIh/rKJYjd+KV39rPCWbWayauNmmw=
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:d8::10)
 by LO6P123MB6616.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:2b2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.18; Thu, 9 Nov
 2023 12:28:02 +0000
Received: from CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0]) by CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
 ([fe80::e732:bfe0:f22b:d2c0%4]) with mapi id 15.20.6977.019; Thu, 9 Nov 2023
 12:28:02 +0000
From: Greg Manning <gmanning@rapitasystems.com>
To: Paolo Bonzini <pbonzini@redhat.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: =?iso-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v2 1/1] plugins: fix win plugin tests on cross compile
Thread-Topic: [PATCH v2 1/1] plugins: fix win plugin tests on cross compile
Thread-Index: AQHaEu6Iq0GdCBFi0E+hB8EgI3WY1LBxuYUAgAAvUG4=
Date: Thu, 9 Nov 2023 12:28:02 +0000
Message-ID: <CWXP123MB4341863026707A4849C894FDD7AFA@CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM>
References: <20231109092418.84-1-gmanning@rapitasystems.com>
 <20231109092418.84-2-gmanning@rapitasystems.com>
 <edbf6575-08cf-49a5-8ac9-caf65d90c63a@redhat.com>
In-Reply-To: <edbf6575-08cf-49a5-8ac9-caf65d90c63a@redhat.com>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=rapitasystems.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CWXP123MB4341:EE_|LO6P123MB6616:EE_
x-ms-office365-filtering-correlation-id: bf1aadcf-5096-40d7-c0bc-08dbe11f50fa
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +kHEMlEaSXXlpu7l65f2Doo69AkEthKlswcoVbC4xAHTT9zlpcC/bok86xSW1moQokRs940y4NG48OX9roWQzOcukmMsa6YqzkmUN3KqQswq7CK/4/NYBi9qdxqGRz7phtHJhveqKn78hsi3IBS3Djno82GowKm+a/5hCp8Mp/7dNs0IIvmlgbdXhc1q/+UhiQ2m4LxJn7MrthVxkLFP++IV1J6bToio3CYXp5YYyDqmrZaNzwrAQEjmNIAF4ZJsejkgNF4/Yxus/nSw/jRkFUrodC84VkrCiJ1kdQDyJOH5h+/wtA5B4GFR+TRak96+UUNOJHXqiFlPqP1jMItjxo6CzxVjYCqooD00Ux+gbRiMVWP3V72LWdXxu76iiFdCzMwj+dPgSRF4Y+iOIMx46qkt4BsxWOq9YHX2jHq3XJ8o5OQSkxn8rqETWK+vK1CDbvJ/kxDbdwxL2taCbWhaRgoI98vKK/tKNBxRU+kWSfUVr9no6A1FkyKufrGEbX87m+m53oP7E2kKblbgR+6DAe/bc4abXd8Ba79h0iKY6BxcGoLG/Njn6qMNFNwhMcRfQSGqYc+ClYZm2F3pCKMoHXrxKVVckHSlRI0lPlOnCLE=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230031)(39840400004)(136003)(396003)(366004)(376002)(346002)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(8676002)(316002)(76116006)(4326008)(64756008)(66946007)(66446008)(66556008)(38100700002)(7696005)(6506007)(8936002)(52536014)(71200400001)(66476007)(53546011)(5660300002)(4744005)(9686003)(55016003)(91956017)(110136005)(478600001)(966005)(26005)(2906002)(122000001)(41300700001)(86362001)(38070700009)(33656002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?mhyQyYSthLvA01HbX1198aGnPl3CL9v0zPYmBIIjmYmcDHSN1/BULpAIwD?=
 =?iso-8859-1?Q?KrfmtOIGzVmNyIJa3xgn7sxHgGZB8cTH8AZNlvt79BjGJRKr83qtaa/njn?=
 =?iso-8859-1?Q?G2Jey2sY0eYdnpiTGttRd8h9VrjQ4vzod3NleUX2PgQ7fFq7YyxbEzIMAG?=
 =?iso-8859-1?Q?5cRHWlYkZmEkkjTRcDE9Vp219pMjaJtpqZYeC9q0rhlApzj+AWYkqxbZIe?=
 =?iso-8859-1?Q?ciESKnTOfvIQDE0PNDE/0SS6FvujBmhYXygoZN107/fMjQhkAsaQ9BOnaQ?=
 =?iso-8859-1?Q?Rfm2tj8CcQDHTqN+Y2W1ZTfrCRRuUlszaYg/Dn0bDmumlU4gPYyIfJj/jX?=
 =?iso-8859-1?Q?S031PF5ZLJVoyXe9w4r+LgdYzmTkxhh8/dkXXXMCrTwNhA4wzgqliX7UKB?=
 =?iso-8859-1?Q?Ds9wrV2A0tVCRq1HwDXx8Hz37CFMEz8NntHN8YO8qXL+Z+qrfc1Jk35tja?=
 =?iso-8859-1?Q?bmB90t6Rscdm5DaXJJf9wjKQfuKBJ7/VsB2K7PE+PjtxJMILpmgAQew7bl?=
 =?iso-8859-1?Q?KLEZvAVvL9G3I4PX9V6Fu4r5C2gSw1njxnM6l39mNeJwsO9Tb/0LMBz4G1?=
 =?iso-8859-1?Q?f9HvIGPmEoeK1Mlr+d2KMvwMpVUoXn7ubuA+Sk1EQS6w08dWWNajb6X3pQ?=
 =?iso-8859-1?Q?QA6t+G7pJm2qxQOF3Mqo3hE71smdMjuUxKXWH5YB6qKpOz0NEbXcLOdPR0?=
 =?iso-8859-1?Q?mcyo0gd4y+fIZuuFVoWfF9PzjIQnidKHXH9TpC97QMYMpxh2cl1Yg+B83F?=
 =?iso-8859-1?Q?ZYUjd33RWN2u+j37Dcu9VLxNnRarmK37EEYbpDXh7FXlrTVWPNU+cJLl0R?=
 =?iso-8859-1?Q?N7yROie3aeP7hRC8iKGtG1vUrkEBhhYsGZ2Imc9UjS33i9BkbRk1uqddEA?=
 =?iso-8859-1?Q?NO0uySK7rjOYE21H0k7H8xq3aRcNyK2ORz2LlykINl6oK7wy8F7yf2JMnc?=
 =?iso-8859-1?Q?B18psj4UeMePC02balHhJM3zuiT0MLHmklXtPKoEBbqq5Rkjs6fAWlBbh1?=
 =?iso-8859-1?Q?cKZesd7nvLU1IiAuyPsejDK+lYVEnytYnLGj5dwdpLK2Ulzv/e1Q7OPgiy?=
 =?iso-8859-1?Q?2Fj2XPihxGkqPuz2h9nyfjKwWCjWAEwnI2JkDu/defuCApzxJ7c83VE4eA?=
 =?iso-8859-1?Q?Xqzn4igaa/w2vItrbcpjgEVRJJ/ng0Vp2S5pXOIUnl0rO/N4w2vLFJuq63?=
 =?iso-8859-1?Q?DBdIDJe3IKX9EIfSw0mxou7fItrB9wNOChP4jo5lV4t19kWWLQj9ezaRJ+?=
 =?iso-8859-1?Q?eBV0tDHmLuH0NUJlmoemFn7gFa58EL5gG8tRul39yTYoTI4hlrGP14+x6h?=
 =?iso-8859-1?Q?SAehdxwHARbqAXT/XQzEgglk4raqZEDimpIGG/+8R3891YAUTGvZvBw1Hc?=
 =?iso-8859-1?Q?fqSViGFmYuUboGvhqNH3/4F7eUhP0RpVpVztezOsqaELjBPvr2CDlYeXhF?=
 =?iso-8859-1?Q?cVy4yS4qdLLk0sYhNHmkQZuLdixeBcbEQbp03URcn08val/DxGmZs3dMYG?=
 =?iso-8859-1?Q?CWWuLK391swoXoxRnPO0+mRfD/pXED3MMOqrf0njGcTkZGj52uafSJmW/n?=
 =?iso-8859-1?Q?mkY7RCZRPHJT9wazW9eVGHPTangi89cGgAq/du78MDRR20xtf96G6XR8he?=
 =?iso-8859-1?Q?BMnEND436ZtJzNWHfcWtbrx95fQc1Fn8sa?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: rapitasystems.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CWXP123MB4341.GBRP123.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: bf1aadcf-5096-40d7-c0bc-08dbe11f50fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 12:28:02.1369 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 63a1ab10-c4bd-4b99-881c-0040cec74971
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +ig31ZpPi49DCS7HD/zwnP5vBNAsqHiq41CFLt4tZmsN7dA/F6h16Egn9EmIQ9FDeyh1Sw5EAUBOrkcqpLlCil8/SL9VQZOkB3IM3s2WCe4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P123MB6616
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

> On 11/9/23 10:24, Greg Manning wrote:=0A=
> >        t +=3D shared_module(i, files(i + '.c') + '../../contrib/plugins=
/win32_linker.c',=0A=
> >                          include_directories: '../../include/qemu',=0A=
> > -                        objects: [win32_qemu_plugin_api_lib],=0A=
> > +                        link_depends: [win32_qemu_plugin_api_lib],=0A=
> > +                        link_args: ['-Lplugins', '-lqemu_plugin_api'],=
=0A=
> >                          dependencies: glib)=0A=
>=0A=
> Does it work if you use win32_qemu_plugin_api_lib.full_path() for the=0A=
> link_args?  (If so it can be fixed when applying).=0A=
=0A=
full_path() doesn't exist on the return type of configure_file.=0A=
=0A=
I've had a play around and not found a better method that works. Have tried=
 various combinations of=0A=
custom_target vs configure_file, declare_dependency and cc.find_library(), =
but can't get it to:=0A=
* work from unbuilt=0A=
* add the file to the installer=0A=
* typecheck=0A=
=0A=
all at the same time. Possibly related is: https://github.com/mesonbuild/me=
son/issues/5093=0A=
=0A=
Greg.=

