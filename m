Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B4AF77A03FA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 14:35:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qglXg-0002BI-PJ; Thu, 14 Sep 2023 08:33:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qglWQ-0001Ro-LM
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:32:44 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qglWJ-0007v1-Ua
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 08:32:38 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-52a1ce52ef4so1074646a12.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 05:32:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694694750; x=1695299550; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=y77LemRAvSjjAxY/Iljm98eTvEMCyTFElmsA3BUeXbE=;
 b=J//91M7XipfHLYz54w0sqajtSEb+G7zSBZrUgA6RdT/EigEmz5Jf2egBD2wlPocvby
 cxZEjt0l/gl70+AV/Ks5eIMcQ+DsUSE8CEhbrLChHoigg7mm5edqG+7vJxiacHhBoqMv
 ScvfwPSFVP5DzqFlAANLWtsMvsAe8R+7tTA3mmzEfmA5Z4hyq2rg2jtXI4TeydHEmlY8
 3L6Z4C+m0ufmYnnikxuK6EvzGr8ARRHPYQ0a5rx2QJXHAk+zj0Fg9F1golkWkH98nJYv
 DzbZhBXQG5Zs6861ecYyw7hpJjHETlQf332RB0pNCPnh2eLOLeuP/3mszqmO1+ztUfm1
 lcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694694750; x=1695299550;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y77LemRAvSjjAxY/Iljm98eTvEMCyTFElmsA3BUeXbE=;
 b=RhHO5IpzExEaADvisThikGEPEV+jUvt28rEeL8zqiDHIZZF85xqW2Awg30Ja4wCn+f
 zDmVa2o/5Ry4rxxjVN6qfSZUNVbnMD+YgfbHqLVeQpoTFxkhYUdpO+hAxW4fStD6YK3U
 zMu/oMHsChpFANhqYAZJMlsRLV/xHOdAVlYnVbLGoS1KUxM0MJsl+ayntgtYMqHIs2lL
 VHJfU3MLnDQOTgm/QY8ofTXVTxcZt6R1pvnKEIidQExxkdYrA9mfTzRTmZm0QszgV8t5
 pozPtiy2gy5XQQ+lCYUIV8dvV742qDtO3MbstTVaZQTFm23fpbVb0PukZPDOmw3dDS1b
 8coA==
X-Gm-Message-State: AOJu0YzhDp0NhoQsrYRDs5FQAm7OZDlrBxsl1VMshHunvCgFellCBIF+
 JRYkz6krMG8kIQcBMsqr592R3XuN9POtynPK7g85Gg==
X-Google-Smtp-Source: AGHT+IFf+qV2A25h4AmbM1+HsL5aHDIh7LinQWynyheOo9qdvqr2rz5ssebnINUHHLXUrFMg221cB/6Sax66zjHuRYI=
X-Received: by 2002:aa7:d793:0:b0:525:7091:124c with SMTP id
 s19-20020aa7d793000000b005257091124cmr4947808edq.19.1694694750020; Thu, 14
 Sep 2023 05:32:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230906140917.559129-1-den@openvz.org>
 <20230906140917.559129-4-den@openvz.org>
 <ZQHZquVrpTFaU7kD@redhat.com>
 <4si43aghmpl4yxtlqhg63q2ivecnsxi5sm67ec5dhtezrhbijy@7zcuqmytr2qt>
 <ZQL8avIMyJq4xvHz@redhat.com>
In-Reply-To: <ZQL8avIMyJq4xvHz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Sep 2023 13:32:09 +0100
Message-ID: <CAFEAcA8bqOw=r=hK+J5G9xqaRei3b1T-SpLAB+He3DadhzUXjQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iotests: distinguish 'skipped' and 'not run' states
To: Kevin Wolf <kwolf@redhat.com>
Cc: Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 14 Sept 2023 at 13:29, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 13.09.2023 um 18:31 hat Eric Blake geschrieben:
> > I guess it boils down to whether there is an actionable response in
> > that message.  If a test is skipped because it is the wrong format
> > (for example, ./check -raw skipping a test that only works with
> > qcow2), there's nothing for me to do.  If a test is skipped because my
> > setup didn't permit running the test, but where I could enhance my
> > environment (install more software, pick a different file system,
> > ...), then having the skip message call that out is useful if I want
> > to take action to get more test coverage.
>
> I'm not sure if there is a clear line to define whether there is an
> actionable response or not, because that completely depends on what the
> user considers an acceptable response.
>
> You have the relatively clear cases like the test being for another
> format, though you could argue that the actionable response is running
> ./check -qcow2 if raw doesn't work - in fact, why don't we allow ./check
> -raw -qcow2 to run both and count it as skipped only if it wasn't run at
> all?
>
> The relatively clear case on the other end of the spectrum is if a tool
> is missing on the host that you could possibly install. Though maybe
> your distro doesn't even package it, so is that still a reasonable
> action to take?

I think for that sort of thing you need to actually collect the
reasons so that at the end you can say "skipped 21 tests because
frobnicator not present on system; skipped 4 tests because
bazulator not present on system". Then when you're running the
tests you can either (a) install the listed tools or (b) know
you can ignore those specific skips as ones you're aware you
can't run. But that would be a lot of pain and effort to implement...

-- PMM

