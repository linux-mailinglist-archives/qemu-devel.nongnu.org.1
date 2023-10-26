Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DB9927D7B0E
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 04:53:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvqTh-00034i-QG; Wed, 25 Oct 2023 22:52:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvqTZ-00034X-Rr
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 22:52:01 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qvqTY-0007s2-0B
 for qemu-devel@nongnu.org; Wed, 25 Oct 2023 22:52:01 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6c4a25f6390so260789a34.2
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 19:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1698288718; x=1698893518;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DTa1hWAss41rdi8M/7WpcSe6hTI05krwXDqPtBKgtQw=;
 b=TKFnPrIv9nQSDWJzLujsexFnGE7Da2SfptOW8K/A7E3ldu+Om6TxOkrWDQ0FPK4Iy0
 es+jBuOPqxA/hlI0aadYYy2l9a9YE2Es2jg1hNJlQIbhQIo1g6M57xojz3y94tTDKt66
 NWRiuC23VVMmGiEMfiKy2uMjXImwzY61isVPxuJRnb17NG6gsBhpCTH1W76KF+b2Kt4e
 Z84gyvBB7Jf5NnIiHvErP00d7Te/FqVSJ6ciOC5KhcYhDfjOyQy0vVgK50XZ+QQtTE8y
 cCzN0lffPvwxuj/Rc1ah4HK5esPlpc+kEZOlnfWEQVN6jWamI3h18RjmA/piu0Zvh+My
 hxyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698288718; x=1698893518;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DTa1hWAss41rdi8M/7WpcSe6hTI05krwXDqPtBKgtQw=;
 b=fG4RhS3myOtVuDVvilyqaN6Pq8jgRaGMNXIFHQ42QNF94JajxGksFuYvRb1OlRKO8d
 vLNTEBe4cvjSNPNp0TON9n25e79WRF2kgF8RG66Uy3B0ZBn+lRANnyYpV7tyu9SrsIZd
 PBIuAfMWvdlG/6YkPKkhcePTeSPnmZhPetZS/cqhi5XW8vak2pmyx2E2XQjinNF9vkuB
 2UTPfmq0ytoanNcN0tO5J8gmgMm6mY5WQFSu0GyGM8A9UXtbB+uEeR9FJD/V+6FSkuqW
 fdn/29e+AU3azkkk4I4d6cKcAnBxqYTxLaFVVbC4SQyi4nmGXhUpbLSdvWgE43rgVZZG
 Lqyw==
X-Gm-Message-State: AOJu0Yyn6Q2/l/MkW4+mxH/G2hMlN0umWtL81oFQP6uTW8kkSJGerz5G
 h8mLcje++2AwWOxvOqQlQ5vMKg==
X-Google-Smtp-Source: AGHT+IEr2RS0SXPOB7aLGjhv82G5iCQmsUcFG8U0CWhJgjiBn9SvKKOIVYyQbSjaGy/jz9OJ7lU9hg==
X-Received: by 2002:a9d:7d09:0:b0:6c4:c151:8ebe with SMTP id
 v9-20020a9d7d09000000b006c4c1518ebemr14956933otn.22.1698288718697; 
 Wed, 25 Oct 2023 19:51:58 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 y15-20020aa79aef000000b0068883728c16sm10416368pfp.144.2023.10.25.19.51.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 19:51:58 -0700 (PDT)
Message-ID: <ef3994e1-6989-41c6-8648-f6c943d6fe64@daynix.com>
Date: Thu, 26 Oct 2023 11:51:55 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ui/cocoa: add full-screen-scaling display option
To: carwynellis@gmail.com, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, philmd@linaro.org
References: <20231025140443.68520-1-carwynellis@gmail.com>
 <20231025140443.68520-2-carwynellis@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20231025140443.68520-2-carwynellis@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32f;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/10/25 23:04, carwynellis@gmail.com wrote:
> From: Carwyn Ellis <carwynellis@gmail.com>
> 
> Provides a display option, full-screen-scaling, that enables scaling of
> the display when full-screen mode is enabled.
> 
> Also ensures that the corresponding menu item is marked as enabled when
> the option is set to on.

Hi,

Thank you for your contribution.

Please drop qemu-trivial@nongnu.org. This change is not that trivial.
Instead add "Graphics maintainers" listed in MAINTAINERS file to CC.

Please also add Signed-off-by tag. See docs/devel/submitting-a-patch.rst 
to know what the tag means.

> ---
>   qapi/ui.json |  6 +++++-
>   ui/cocoa.m   | 33 ++++++++++++++++++++-------------
>   2 files changed, 25 insertions(+), 14 deletions(-)
> 
> diff --git a/qapi/ui.json b/qapi/ui.json
> index 006616aa77..9035b230ce 100644
> --- a/qapi/ui.json
> +++ b/qapi/ui.json
> @@ -1409,13 +1409,17 @@
>   #     codes match their position on non-Mac keyboards and you can use
>   #     Meta/Super and Alt where you expect them.  (default: off)
>   #
> +# @full-screen-scaling: Scale display to fit when full-screen enabled.
> +#     Defaults to "off".
> +#

I think it's better to name zoom-to-fit to align with DisplayGTK.
It should also have "(Since 8.2)".

>   # Since: 7.0
>   ##
>   { 'struct': 'DisplayCocoa',
>     'data': {
>         '*left-command-key': 'bool',
>         '*full-grab': 'bool',
> -      '*swap-opt-cmd': 'bool'
> +      '*swap-opt-cmd': 'bool',
> +      '*full-screen-scaling': 'bool'
>     } }
>   
>   ##
> diff --git a/ui/cocoa.m b/ui/cocoa.m
> index d95276013c..7ddc4de174 100644
> --- a/ui/cocoa.m
> +++ b/ui/cocoa.m
> @@ -1671,7 +1671,9 @@ static void create_initial_menus(void)
>       // View menu
>       menu = [[NSMenu alloc] initWithTitle:@"View"];
>       [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Enter Fullscreen" action:@selector(doToggleFullScreen:) keyEquivalent:@"f"] autorelease]]; // Fullscreen
> -    [menu addItem: [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease]];
> +    menuItem = [[[NSMenuItem alloc] initWithTitle:@"Zoom To Fit" action:@selector(zoomToFit:) keyEquivalent:@""] autorelease];
> +    [menuItem setState: (stretch_video) ? NSControlStateValueOn : NSControlStateValueOff];

nit: You don't need parentheses around strech_video.

> +    [menu addItem: menuItem];
>       menuItem = [[[NSMenuItem alloc] initWithTitle:@"View" action:nil keyEquivalent:@""] autorelease];
>       [menuItem setSubmenu:menu];
>       [[NSApp mainMenu] addItem:menuItem];
> @@ -2041,18 +2043,6 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>   
>       [QemuApplication sharedApplication];
>   
> -    create_initial_menus();
> -
> -    /*
> -     * Create the menu entries which depend on QEMU state (for consoles
> -     * and removable devices). These make calls back into QEMU functions,
> -     * which is OK because at this point we know that the second thread
> -     * holds the iothread lock and is synchronously waiting for us to
> -     * finish.
> -     */
> -    add_console_menu_entries();
> -    addRemovableDevicesMenuItems();
> -
>       // Create an Application controller
>       QemuCocoaAppController *controller = [[QemuCocoaAppController alloc] init];

QemuCocoaAppController also has code to initialize stretch_video; it's 
not OK to have code to initialize a same variable in two different places.

>       [NSApp setDelegate:controller];
> @@ -2062,6 +2052,7 @@ static void cocoa_display_init(DisplayState *ds, DisplayOptions *opts)
>           [NSApp activateIgnoringOtherApps: YES];
>           [controller toggleFullScreen: nil];
>       }
> +

Don't add a blank line here. It's irrelevant from this change.

