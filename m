Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C44487DF4E1
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:25:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYcf-0004rO-Ap; Thu, 02 Nov 2023 10:24:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyYcd-0004rF-Ku
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:24:35 -0400
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qyYcb-0006Uj-MY
 for qemu-devel@nongnu.org; Thu, 02 Nov 2023 10:24:35 -0400
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-32d9d8284abso586540f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Nov 2023 07:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698935072; x=1699539872; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=yAFQGJDE/C23pdXk4N0KgItDy90QsCH+ABHO8StoC0w=;
 b=t0Lr83CdBBBDdGI11CoopvQZDIa+uJ5Fl+mhUM9s6J/cZDRHfGsun6avCnWZ/Gupaa
 19wh1D6I4wlkaHB8yQURsol9DlIB+M3zrX8w9hrs2KqawaKETr/7H/F2GpKc6jMoTAu7
 +Inz5FDA+MwzE2pf+eytwvmGHATb7k5V7RNVs5xUNBJa5iC+Of7ryhzHWrAoGcuva/dm
 andKmYQ3e9QMon0/Dv3pi0Q7Hl0yAnppjpQcHatyr5iQ0NIpwNJ2K2OcBvZHyRCUkQdz
 H1dWiGu7/8mtym6tJ2LC4MAXqb49x+/5Rpw74hjL8vmxlFvOlW1IMBncNNh8HZEKDdhG
 4TWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698935072; x=1699539872;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yAFQGJDE/C23pdXk4N0KgItDy90QsCH+ABHO8StoC0w=;
 b=ZuFbpakasXFIi1sUhTRK+IyvzSJfTjrq6XR812Jqg3Lus+ZghacY6pTKoD16M31Vp3
 /Pf7OegDf8oMaRhsxHo02GyiDpaTlUEeXiVODLhQLnbgOrAWTjPanFbVtczpXj/jmZa8
 qTKn7R9SV4cEeagIHcqT+IRyF2F4hxzSgO7M81tMIotiPuDDOi20mbsmMKqkhAJ3/jkZ
 yzdVrm+9Ltphc0TAqEKhHNbaZYlIH12wRkmoO/w0v9yi/i8SW/NiEy/NWgM8g4Ie41sa
 XVVd9+BpoJxIfNV+UTTHV79mL9QJri9TDMfBdFeJh/INSCRm1p86EoAtF8Z3JslsSFBR
 SEaA==
X-Gm-Message-State: AOJu0YyTf2B3iiqAkmxnaJh5Y69CTMPipoH71BykG7FMmNnE79U5fL71
 riMK6ztdCqHEnhkjVY9zxZeKfw==
X-Google-Smtp-Source: AGHT+IGiiKlVkYsgu6Oj2ngzUoeemO5D247iDWnP65sPaewo1PidxGKBzXqMOUfX0JNQB49bZYbNmw==
X-Received: by 2002:a05:6000:1569:b0:32f:7bee:f300 with SMTP id
 9-20020a056000156900b0032f7beef300mr15634586wrz.4.1698935071795; 
 Thu, 02 Nov 2023 07:24:31 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o15-20020a5d58cf000000b0032db1d741a6sm2602150wrf.99.2023.11.02.07.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Nov 2023 07:24:31 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id E4E20656E4;
 Thu,  2 Nov 2023 14:24:30 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Greg Manning <gmanning@rapitasystems.com>
Cc: qemu-devel@nongnu.org,   luoyonggang@gmail.com,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/1] Enable plugin support for windows
In-Reply-To: <20231102110016.9494-1-gmanning@rapitasystems.com> (Greg
 Manning's message of "Thu, 2 Nov 2023 10:59:41 +0000")
User-Agent: mu4e 1.11.23; emacs 29.1
Date: Thu, 02 Nov 2023 14:24:30 +0000
Message-ID: <87msvw44ip.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


(Add Paolo to cc for meson questions)

Greg Manning <gmanning@rapitasystems.com> writes:

> This patch enables plugin support on windows.
>
> qemu plugins on windows now correctly load/link the qemu_plugin_*
> symbols when they are loaded[1]. This works by creating a delay-loaded
> .lib file with dlltool[2], then linking the plugins against that to get
> them compiled. No messing around with function pointers required.
>
> The .lib file is created with "qemu.exe" as the name of the DLL.
> The only input to the creation of the .lib file is a list of
> qemu_plugin_* api symbol names.
>
> When the DLL is being loaded, it will fail to find qemu.exe[3], but
> the windows linker has a 'dll loading failed' hook you can put in the
> plugin.
>
> I've implemented this hook to check if the file that's failed to load is
> 'qemu.exe', and if so, substitute in a handle to the top-level
> executable. Symbol linking then continues in the normal way.
>
> As such, windows plugins work for me, and with minimal change to actual
> qemu code.

Excellent work - I'm glad you can make it work without having to hack
the rest of the plugins too much. I'm afraid I can't do much to test
this but overall I'm much happier to merge this.

However can we split the patches into slightly smaller chunks. Maybe
something like:

  - add the QEMU_PLUGIN_API annotations
  - introduce the windows linker bits
  - filter the plugins that can't be built for windows
  - flip the switch in configure to allow plugins to be built on Windows

Also what are we going to do for testing? Most qemu developers are using
POSIX systems so I'm worried about support bit rotting. We do have some
windows coverage in CI but currently only running qtest. There are some
"make check-tcg" tests which are softmmu but I suspect getting the
cross-compilers on windows would be a blocker. Do we know the state of
the avocado tests? We have some minimal testing there which could be
extended as all you need is avocado working and some binary images to
run. I've just posted a patch to update them:

  Message-Id: <20231101135004.1572916-1-alex.bennee@linaro.org>
  Date: Wed,  1 Nov 2023 13:50:03 +0000
  Subject: [RFC PATCH] tests/avocado: update the tcg_plugins test
  From: =3D?UTF-8?q?Alex=3D20Benn=3DC3=3DA9e?=3D <alex.bennee@linaro.org>

> [1]: Except lockstep, which uses unix sockets. It could be changed to
>      use another communication mechanism, but that felt outside what I'm
>      trying to achieve here.
>
> [2]: This would be the first use of dlltool in qemu. Is that OK? do we
>      need anything in meson to check it exists?

Paolo any comments on the meson bits?

>
> [3]: If qemu moved to a single executable model, and we got the name
>      right when creating the .lib, then the dll hook would not be
>      needed at all.
>
> Limitations/things I'm worried about
>
> * There is some amount of meson/Makefile tweaking going on here, and
>   while what I've got works for me, I'm not very familiar with meson,
>   and might not be doing things The Right Way.
>
> * plugin/FFI bindings authors would have to copy this hook themselves,
>   or implement something equivalent. Also they need the
>   qemu_plugin_api.lib file, which I think I've added to the set of
>   installed files.
>
> * License for win32_linker.c - I'm happy to put this under whatever
>   license seems most convenient. Given qemu-plugin.h is already GPL,
>   all plugins will be GPL anyway.

While there may be private downstream plugins being used behind closed
doors we very much don't want to encourage binary only plugins so GPL is
fine.

> Greg Manning (1):
>   plugins: enable plugins for windows
>
>  configure                      |  9 ++----
>  contrib/plugins/Makefile       | 27 ++++++++++++++++--
>  contrib/plugins/win32_linker.c | 34 +++++++++++++++++++++++
>  include/qemu/qemu-plugin.h     | 50 ++++++++++++++++++++++++++++++++--
>  meson.build                    |  5 ++++
>  plugins/meson.build            | 17 ++++++++++++
>  tests/plugin/meson.build       | 14 ++++++++--
>  7 files changed, 141 insertions(+), 15 deletions(-)
>  create mode 100644 contrib/plugins/win32_linker.c
>
> --
> 2.42.0

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

