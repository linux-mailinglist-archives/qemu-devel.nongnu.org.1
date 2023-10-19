Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A97CF93C
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 14:43:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtSN3-0002JW-FQ; Thu, 19 Oct 2023 08:43:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSMu-0002HX-1V
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:43:16 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qtSMs-0003Gn-Gb
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 08:43:15 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4083f613275so12373995e9.2
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 05:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697719393; x=1698324193; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fSbi8YAvF7elK9VBpLDP7jqWL+BJNgPQlgL+AJlHZdo=;
 b=qKnfrqjS4d4H2Zf/TP1VLShTx5XPTvl33q43cjPxU0apugyJkZ20A1tGV5CO0KC7Bf
 suAUsUmcB2GSm8TihbjIVl88iPwAjKBHfBQ9yHUekvuCz6+9JOg3GNyPGmwfwBuJBKl9
 JdOSDDHAcqKK4tMhyMiHUFFnnZSJSvxRPYrrqxMa6xhrugrkOx9pw+3SbOWfXeCY33h4
 TQoTImlwgoFjYLTDP0S72xYKElichsnq4fF3WQBzvNt/+Ak1qECyNu0Txpc9RIyZ3FM8
 wvrJkJFSAkWcTbvD0i2WvXQMKwKN76sJ7olpXnPNkH/ich0M1rFfR1OmUVjYjuupzrzr
 iwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697719393; x=1698324193;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=fSbi8YAvF7elK9VBpLDP7jqWL+BJNgPQlgL+AJlHZdo=;
 b=IY4kph6GoQbtfM46AlLzAL14kGxdD5kFujK3wqog5N7ZAUzJrOxnxZrB9wN/nGQzeF
 y+1rMfcH+Pf/uL9TgBEKxLSC7e8Mfazg0sBQurrCETVV73kujA6fwpYHO8Q7qcu3BhIZ
 w1OpjfF+qaBxKuRXNZNBHRDkHDEc2Zbd7X6TVLNbiyolpyYYs3Hn+GPmvBSOiChuG+qs
 GDBj9Nijo+n/CcRTSCxLw2SbbH8l1ab3H5CVK77OkYl/iueV/Ifgv9Sfwadjkjy1INi8
 h3yHyPDwQGi1ybeyNpJKSHQeW1peMAx/8g3NezdYU8S8lZperQf0WWmVu8qUdYhPLXdI
 GMPg==
X-Gm-Message-State: AOJu0YzufLdD9zGC3qY6gq9s2/ydkbV93k43e/0JQVdq5FycfbODzqYY
 eFgAA1o5p31ajli+3xlfkWMaDQ==
X-Google-Smtp-Source: AGHT+IGqMfrpKgI8gvYT6dpFCV8zXXkHttgRjapdg6aHe8DDk3wTUhRpH638FZLN/6J3AyokBuFlOQ==
X-Received: by 2002:a05:600c:5118:b0:401:2ee0:7558 with SMTP id
 o24-20020a05600c511800b004012ee07558mr1722591wms.32.1697719392702; 
 Thu, 19 Oct 2023 05:43:12 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 o24-20020a05600c339800b0040303a9965asm4322681wmp.40.2023.10.19.05.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 05:43:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id EB4991FFBB;
 Thu, 19 Oct 2023 13:43:11 +0100 (BST)
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
 <2e08cff874b2f9fc4143bdcde87ebba9b70b356c.1697183699.git.manos.pitsidianakis@linaro.org>
 <871qdsb4qd.fsf@linaro.org> <2q0zq.6gn2tubfhjrk@linaro.org>
 <87sf689is8.fsf@linaro.org>
 <CAFEAcA9DQ6oR3fNicuUpntfZ8QdSA8PqO5irRuzNrpkpXUJUCA@mail.gmail.com>
User-agent: mu4e 1.11.22; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, Gerd Hoffmann
 <kraxel@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>, Eric
 Auger <eric.auger@redhat.com>, Song Gao <gaosong@loongson.cn>, Xiaojuan
 Yang <yangxiaojuan@loongson.cn>, Richard Henderson
 <richard.henderson@linaro.org>, qemu-devel <qemu-devel@nongnu.org>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>
Subject: Re: [RFC PATCH v2 01/78] include/qemu/compiler.h: replace
 QEMU_FALLTHROUGH with fallthrough
Date: Thu, 19 Oct 2023 13:42:00 +0100
In-reply-to: <CAFEAcA9DQ6oR3fNicuUpntfZ8QdSA8PqO5irRuzNrpkpXUJUCA@mail.gmail.com>
Message-ID: <87ttqm940w.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 18 Oct 2023 at 14:12, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>>
>> Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:
>>
>> > On Wed, 18 Oct 2023 13:32, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> >>> diff --git a/audio/pwaudio.c b/audio/pwaudio.c
>> >>> index 3ce5f6507b..bf26fadb06 100644
>> >>> --- a/audio/pwaudio.c
>> >>> +++ b/audio/pwaudio.c
>> >>> @@ -1,29 +1,29 @@
>> >>>  /*
>> >>>   * QEMU PipeWire audio driver
>> >>>   *
>> >>>   * Copyright (c) 2023 Red Hat Inc.
>> >>>   *
>> >>>   * Author: Dorinda Bassey       <dbassey@redhat.com>
>> >>>   *
>> >>>   * SPDX-License-Identifier: GPL-2.0-or-later
>> >>>   */
>> >>>  +#include <spa/param/audio/format-utils.h>
>> >>> +#include <spa/utils/ringbuffer.h>
>> >>> +#include <spa/utils/result.h>
>> >>> +#include <spa/param/props.h>
>> >>>  #include "qemu/osdep.h"
>> >>>  #include "qemu/module.h"
>> >>>  #include "audio.h"
>> >>>  #include <errno.h>
>> >>>  #include "qemu/error-report.h"
>> >>>  #include "qapi/error.h"
>> >>> -#include <spa/param/audio/format-utils.h>
>> >>> -#include <spa/utils/ringbuffer.h>
>> >>> -#include <spa/utils/result.h>
>> >>> -#include <spa/param/props.h>
>> >>
>> >>Was this an autofmt change sneaking in? osdep.h should always be first
>> >>per style.rst.
>> >
>> > It should have been mentioned in the commit message and in a code
>> > comment. libspa throws errors because the preprocessor changes
>> > `fallthrough` to our macro definition. I do not like the reordering.
>> > My other thought was to undef fallthrough and re-include
>> > "qemu/compiler.h" after the libspa includes.
>>
>> Ahh this stuff:
>>
>>   #if defined(__clang__) && defined(__cplusplus) && __cplusplus >=3D 201=
103L
>>      /* clang's fallthrough annotations are only available starting in C=
++11. */
>>   #  define SPA_FALLTHROUGH [[clang::fallthrough]];
>>   #elif __GNUC__ >=3D 7 || __clang_major__ >=3D 10
>>   #  define SPA_FALLTHROUGH __attribute__ ((fallthrough));
>>   #else
>>   #  define SPA_FALLTHROUGH /* FALLTHROUGH */
>>   #endif
>>
>> I think this is papering over a potential problem we might have with
>> multiple libraries and probably an argument in favour of an explicit
>> QEMU_FALLTHROUGH macro to avoid the attribute clash.
>
> Is there a reason this thread lost the qemu-devel cc ?

Not deliberately. I think my mail clients objected to open list:ARM SMMU
<qemu-arm@nongnu.org> and skipped the last two CC's and I didn't notice.

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

