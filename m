Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE3E9B791B
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Oct 2024 11:54:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6SnW-0000KH-5r; Thu, 31 Oct 2024 06:53:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6SnT-0000Jx-BX
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:52:59 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6SnR-0000xr-KZ
 for qemu-devel@nongnu.org; Thu, 31 Oct 2024 06:52:59 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5c948c41edeso958121a12.1
 for <qemu-devel@nongnu.org>; Thu, 31 Oct 2024 03:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730371975; x=1730976775; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LhsDv5nM9ndoOIXvTkoDTGa/izKIPZpSaFQSe40301Q=;
 b=Enxf30VZN3GJMpS6Di6NpWvKSh5248pX/Qinxr2hOtXF7O7pUBqQ9S0RgmounoZqAP
 rGjn0yFTYnaZLfABApC65Jzkn4cr8VfupI3NeexSrQv6WVnTgrC5hMseQznIzQKNdYh6
 aKFf75pubyFlqF6wZ0cOnt8f65IYZHgW+zKVomi+TwRasR/9H6fjyxn1rtRomNEVx8jT
 +QDhUaIaYsX2ydW6GIRJxmwrV1vXUnxDA5z/qvFQjTj68l91qqQyjaG7ltDHi6tqfezC
 OyGhaPk8hYYX+0QrRDeh3gqtQqsYD2V+wmpzHpt/lPuI9Cp28Jk3vLaPN30Vcg+a4+Vy
 yBSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730371975; x=1730976775;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LhsDv5nM9ndoOIXvTkoDTGa/izKIPZpSaFQSe40301Q=;
 b=DGB6brIZz6xOgrD2T+PlOynfcq6QMBTstJbvXQV349fbFmnSkRONnHrj3Cl33gJsRi
 OuPKfOKMXjybF0Gd1y02PKBdCQLFv8anwvuuI3dHjmUT7nq2xm1KJIqEIt7eokRdxeX4
 6tA3X8RGhSaf7o+IwswUuwa/haA4vDMoNaqVKurotlq/Tf3SaWDH4Uoea5Ouey55Z2Bt
 jyYqhtljFaq7ucFhslmiWQb+gR/5p6CfeAyNa+bL+GJP05oeXhagwD54nPB9JdsrQgLa
 1cc/VnjbQvrUDU55msdeMxujtTqyna2+UOsgzpjhhPxTu/bvd2XD/Awq/vlEGrQTftaM
 3V5A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWW/gRxRtJzKuZMVeLAKYdENbbbKhVBOrPgiKhv4cJ0Cxb1ldWE0CROKEFN7m4UWoa7M/yzMAEiyLzE@nongnu.org
X-Gm-Message-State: AOJu0YznlFIJikUH5WSDsAxfMb5oWfKWw2dG41G4152ZLjYn5FnTzl93
 1KI1xqyAtB1hCLyuiLUflMzWtRRqg0JwAzbja15eS8x1xGHJsWr7YB0X+HXIK/QRwwdFnEkG6kc
 bQVVTk5xgsSY9ZR73/78NCEisqtipd/zQnzROUg==
X-Google-Smtp-Source: AGHT+IHiMu31IdRjcPj/yvqmIFMt3vimBtFw86Wx4uv6fOpCoPaqWP4quugWTwax3LSTBvofXDM3cKtgjKQfOUbh+QM=
X-Received: by 2002:a05:6402:210d:b0:5c9:74e3:acbb with SMTP id
 4fb4d7f45d1cf-5cea9678020mr2185106a12.10.1730371974644; Thu, 31 Oct 2024
 03:52:54 -0700 (PDT)
MIME-Version: 1.0
References: <20241030140656.36540-1-abelova@astralinux.ru>
 <CAGCz3vuqRAkPtRRpqbPM+3z5iqVHOkr5fYotmva=6uqA7JnGcQ@mail.gmail.com>
 <ZyLPzbDy_0cI7HyD@gallifrey>
In-Reply-To: <ZyLPzbDy_0cI7HyD@gallifrey>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Oct 2024 10:52:43 +0000
Message-ID: <CAFEAcA8r-TtExvoxU7qDV+QpjU3fPFH2hexsog+kbpRo++V3gQ@mail.gmail.com>
Subject: Re: [PATCH] monitor: fix cases in switch in memory_dump
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Phil Dennis-Jordan <lists@philjordan.eu>,
 Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org, 
 sdl.qemu@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Thu, 31 Oct 2024 at 00:32, Dr. David Alan Gilbert <dave@treblig.org> wrote:
>
> * Phil Dennis-Jordan (lists@philjordan.eu) wrote:
> > On Wed 30. Oct 2024 at 15:09, Anastasia Belova <abelova@astralinux.ru>
> > wrote:
> >
> > > default case has no condition. So if it is placed
> > > higher that other cases, they are unreachable.
> > >
> > > Move dafult case down.
> > >
> >
> > The stylistic merits might be debatable, but: the order of cases in a
> > switch block in C does not matter, the default case can appear anywhere.
> > The other cases are still reachable. So at minimum, the commit message is
> > incorrect.
>
> I'd agree;  the analysis is wrong - it works as intended.
> As for style, I'd normally agree that 'default' at end makes sense,
> but:
>   a) I hate duplicating code
>   b) in a way this reads nicely:
>                  default:
>                  case 1:
>
>       'default is the same as case 1'.

Is it actually possible to get here with a wsize that
isn't 1,2,4 or 8, though? This function is used only
by the hmp 'x' and 'xp' commands. Those document that
the valid size specifications are b, h, w or g (for
8, 16, 32 or 64 bits), and monitor_parse_arguments()
doesn't seem to have any undocumented handling that
would result in a different size value. And the
code in memory_dump() doesn't do anything sensible
with a wsize other than 1, 2, 4 or 8 -- if you hand
it a wsize of 3, for instance, I think it will print
every third byte.

So I think that probably the default case here should
be g_assert_not_reached().

Disclaimer: I haven't played with the x and xp commands
to confirm that we really don't ever get here with a
funny wsize value.

thanks
-- PMM

