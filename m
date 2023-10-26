Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 46BE87D8031
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 12:03:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvxCG-0001Z3-61; Thu, 26 Oct 2023 06:02:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qvxCE-0001YB-1o; Thu, 26 Oct 2023 06:02:34 -0400
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <carwynellis@gmail.com>)
 id 1qvxCC-0006uh-0q; Thu, 26 Oct 2023 06:02:33 -0400
Received: by mail-lj1-x22c.google.com with SMTP id
 38308e7fff4ca-2c523ac38fbso10852161fa.0; 
 Thu, 26 Oct 2023 03:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698314549; x=1698919349; darn=nongnu.org;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=byBKN+jk+gsnu050ggiIHn4/Tj/YTevSyKsyGV13nOM=;
 b=Espq58QK9k6UnVd0Pp2EpjBTyWTdo2z1dOJJdN+XKB1liRNb4zQNPVJryb2IsMuFZ3
 R9vr3cPW314XpdPoL0cbro1FTp1K3H6moPUDfcYg52ah78UPdgwE/aWNVB23gHwwQs8l
 bNdN11hdEl9ne74NKBZUWi769UfRxjQgQZ8ghc8+CrKnR3236Dylrsn0UojJxGyCWgmi
 af0kiqPBQ2khM/OfLqYRdYJgGRfPoPv4WEn1Q/NK47FJ4uXeJ4ldU1PGXgHsPR/AabIK
 6p2s7db8pliki6LHCI9X3ocIB9fKi5UHRIgWjRMs8u00FskaHVOkkrFtIb8MR+Bnjlqv
 8EAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698314549; x=1698919349;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=byBKN+jk+gsnu050ggiIHn4/Tj/YTevSyKsyGV13nOM=;
 b=uwsHMHR67xtc7gpax2yrs/wq4IRHXGJrf0BEgSeK7PWNLpRCpdQzJokR75bROwqJZZ
 dMOOOV5teBdHFcF41UdxK++ko48rouGqp6HHiCD88duGGiqjW6N5O7H7ZLn9QYoeD8QU
 E1RkH6znb0I9DRtm8CrTvO2k84BiuE3clWN9ePJ5EymbPZNaF133gExb77JedZNjrmfi
 hmz62hfQytsWi++rYHxapPuntA30UOlzv5DA2x9TQrjckSpeNYBseOVr+8Rh+Cw75pi+
 vbEsLGr2xl5eV2Mf7DNFApweFZShKMVlGlQ+iZNgpxpyS7RoqFjowIdS9r902+Jcybmo
 Todw==
X-Gm-Message-State: AOJu0Yxdz8S0nhapAgZaW1Hqp4F0lGUF52EP8z3Zwdr1a0fk08vwPwC5
 mMkye07NoVtPXNaJHNu4AUw=
X-Google-Smtp-Source: AGHT+IEOEXcEX5Huy4f5ZDwMVLiYSqVR8HuLMLuO+Ej5cxHUam4Q2guXWEk2R+TV7hdJYu5sXEkdfQ==
X-Received: by 2002:a2e:a589:0:b0:2c5:21e3:f209 with SMTP id
 m9-20020a2ea589000000b002c521e3f209mr12810103ljp.23.1698314549085; 
 Thu, 26 Oct 2023 03:02:29 -0700 (PDT)
Received: from smtpclient.apple
 (host86-185-6-213.range86-185.btcentralplus.com. [86.185.6.213])
 by smtp.gmail.com with ESMTPSA id
 p21-20020a05600c431500b003fe61c33df5sm2098414wme.3.2023.10.26.03.02.28
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 26 Oct 2023 03:02:28 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.700.6\))
Subject: Re: [PATCH 1/1] ui/cocoa: add full-screen-scaling display option
From: Carwyn Ellis <carwynellis@gmail.com>
In-Reply-To: <ef3994e1-6989-41c6-8648-f6c943d6fe64@daynix.com>
Date: Thu, 26 Oct 2023 11:02:18 +0100
Cc: QEMU <qemu-devel@nongnu.org>, qemu-trivial@nongnu.org,
 peter.maydell@linaro.org, philmd@linaro.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <FB1DA769-FEFF-4ACF-BB0D-1B5D6B365C1F@gmail.com>
References: <20231025140443.68520-1-carwynellis@gmail.com>
 <20231025140443.68520-2-carwynellis@gmail.com>
 <ef3994e1-6989-41c6-8648-f6c943d6fe64@daynix.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: Apple Mail (2.3731.700.6)
Received-SPF: pass client-ip=2a00:1450:4864:20::22c;
 envelope-from=carwynellis@gmail.com; helo=mail-lj1-x22c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



> On 26 Oct 2023, at 03:51, Akihiko Odaki <akihiko.odaki@daynix.com> =
wrote:
>=20
> On 2023/10/25 23:04, carwynellis@gmail.com wrote:
>> From: Carwyn Ellis <carwynellis@gmail.com>
>> Provides a display option, full-screen-scaling, that enables scaling =
of
>> the display when full-screen mode is enabled.
>> Also ensures that the corresponding menu item is marked as enabled =
when
>> the option is set to on.
>=20
> Hi,
>=20
> Thank you for your contribution.
>=20
> Please drop qemu-trivial@nongnu.org. This change is not that trivial.
> Instead add "Graphics maintainers" listed in MAINTAINERS file to CC.
>=20
> Please also add Signed-off-by tag. See =
docs/devel/submitting-a-patch.rst to know what the tag means.

Hi,

No problem at all. Thanks for getting back to me so quickly! :)=20

I guess I missed this on the email body so I=E2=80=99ll make sure this =
is present when I resubmit.

Thanks

>=20
>> ---
>>  qapi/ui.json |  6 +++++-
>>  ui/cocoa.m   | 33 ++++++++++++++++++++-------------
>>  2 files changed, 25 insertions(+), 14 deletions(-)
>> diff --git a/qapi/ui.json b/qapi/ui.json
>> index 006616aa77..9035b230ce 100644
>> --- a/qapi/ui.json
>> +++ b/qapi/ui.json
>> @@ -1409,13 +1409,17 @@
>>  #     codes match their position on non-Mac keyboards and you can =
use
>>  #     Meta/Super and Alt where you expect them.  (default: off)
>>  #
>> +# @full-screen-scaling: Scale display to fit when full-screen =
enabled.
>> +#     Defaults to "off".
>> +#
>=20
> I think it's better to name zoom-to-fit to align with DisplayGTK.
> It should also have "(Since 8.2)".

I did look for an existing param but missed this one. Thanks!

>=20
>>  # Since: 7.0
>>  ##
>>  { 'struct': 'DisplayCocoa',
>>    'data': {
>>        '*left-command-key': 'bool',
>>        '*full-grab': 'bool',
>> -      '*swap-opt-cmd': 'bool'
>> +      '*swap-opt-cmd': 'bool',
>> +      '*full-screen-scaling': 'bool'
>>    } }
>>    ##
>> diff --git a/ui/cocoa.m b/ui/cocoa.m
>> index d95276013c..7ddc4de174 100644
>> --- a/ui/cocoa.m
>> +++ b/ui/cocoa.m
>> @@ -1671,7 +1671,9 @@ static void create_initial_menus(void)
>>      // View menu
>>      menu =3D [[NSMenu alloc] initWithTitle:@"View"];
>>      [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter =
Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] =
autorelease]]; // Fullscreen
>> -    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" =
action:@selector(zoomToFit:) keyEquivalent:@""] autorelease]];
>> +    menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" =
action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
>> +    [menuItem setState: (stretch_video) ? NSControlStateValueOn : =
NSControlStateValueOff];
>=20
> nit: You don't need parentheses around strech_video.

No problem - will change this.=20

>=20
>> +    [menu addItem: menuItem];
>>      menuItem =3D [[[NSMenuItem alloc] initWithTitle:@"View" =
action:nil keyEquivalent:@""] autorelease];
>>      [menuItem setSubmenu:menu];
>>      [[NSApp mainMenu] addItem:menuItem];
>> @@ -2041,18 +2043,6 @@ static void cocoa_display_init(DisplayState =
*ds, DisplayOptions *opts)
>>        [QemuApplication sharedApplication];
>>  -    create_initial_menus();
>> -
>> -    /*
>> -     * Create the menu entries which depend on QEMU state (for =
consoles
>> -     * and removable devices). These make calls back into QEMU =
functions,
>> -     * which is OK because at this point we know that the second =
thread
>> -     * holds the iothread lock and is synchronously waiting for us =
to
>> -     * finish.
>> -     */
>> -    add_console_menu_entries();
>> -    addRemovableDevicesMenuItems();
>> -
>>      // Create an Application controller
>>      QemuCocoaAppController *controller =3D [[QemuCocoaAppController =
alloc] init];
>=20
> QemuCocoaAppController also has code to initialize stretch_video; it's =
not OK to have code to initialize a same variable in two different =
places.

Ok, I=E2=80=99ll take a look and tidy this up.

>=20
>>      [NSApp setDelegate:controller];
>> @@ -2062,6 +2052,7 @@ static void cocoa_display_init(DisplayState =
*ds, DisplayOptions *opts)
>>          [NSApp activateIgnoringOtherApps: YES];
>>          [controller toggleFullScreen: nil];
>>      }
>> +
>=20
> Don't add a blank line here. It's irrelevant from this change.

Ok.

I=E2=80=99ll aim to get this resubmitted as a V2 later today with the =
appropriate CCs.

Thanks again,
Carwyn


