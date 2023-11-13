Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5825F7EA1BB
	for <lists+qemu-devel@lfdr.de>; Mon, 13 Nov 2023 18:15:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2aWk-0003Sm-AH; Mon, 13 Nov 2023 12:15:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2aWh-0003S0-Mr
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:15:07 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r2aWf-0006Cv-LY
 for qemu-devel@nongnu.org; Mon, 13 Nov 2023 12:15:07 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-53db360294fso7288938a12.3
 for <qemu-devel@nongnu.org>; Mon, 13 Nov 2023 09:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699895703; x=1700500503; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zocZ/cIXdh4K5L+0XDt5NYnTLiEd+VgIcEWDI9rbgBw=;
 b=oZ7Dnwn5JNBP3OzLRk4kZKDYxfl0hWfX5YCjFQafhs9Mt2L93scRssGP/S2R2549T7
 QRh1nynfi4Cxr3SHbH24ZOyCk+Ep+U9MW8XKdyN5xL4WreGjmnGnaofI8lQoEWzVIlkM
 QXvvXhHOlxrn2nzp/z53vDatMxtLbG7ynb1dMTlY4JI/pMSVkMw+5u/Au4AmBrWr06W0
 p4VD9vSkjO/d505HiUOoDYs0rXEUGBkxfHeauHUiz9v5iD2ZBwDJFf35pv2NwMGhLuLn
 eviEbqmbpvnFzHMrdg0+8nE2QU/Qxjw3pz69A56KgwYk2KsX2GODPvOzZ1HXOFaREVba
 cqyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699895703; x=1700500503;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zocZ/cIXdh4K5L+0XDt5NYnTLiEd+VgIcEWDI9rbgBw=;
 b=DNTWmG0aJcMYMb/olMKzYhrHM6tt03etm0YM0O6eMA1tmW4RDMgLhg7aW5lgzgLwB6
 BqU2dnw7pqdCoqYkBfG91IsiKgG9FRHuMb0BulYmdPYU1No+Y8MAxnEp1Ldm/sCOvfUm
 wYOLaE+sXN18XhKA2rw413YWmENupLZLvykzK2aWgDwyJ4dv1dZq6NdKD6/1H/H7TQBk
 248X/znZhZKpAl/pUEwDdzABqkcW4+7XZexIr4V10Zv6oMvEITXsq2iU4PUJ04eMJcXy
 3Po0lfSKDkPZkEp2+whcGbUHWXzozKIwGGXeDtbESgFBMujGFarUO470q47Mirne+Ew0
 PWiw==
X-Gm-Message-State: AOJu0Yz2GiuhBke8gOlNd+GwgxWAbBI0yHbLvyGkEB/YK4HU/1UxeLZ+
 uadL0HZJnm7Gyyw9yehfZrPnya8P3pQ8hLFLME1/ww==
X-Google-Smtp-Source: AGHT+IEhr0Y5Apl7Z56Qu4jWwlXhQijr6y6QD7/30v8vnPg7tM51yRcGGgr0TBC1d1D5nJw7JDv5Pl+8IQRbiGEIJWA=
X-Received: by 2002:a05:6402:1015:b0:53b:3225:93c2 with SMTP id
 c21-20020a056402101500b0053b322593c2mr5331537edu.8.1699895703704; Mon, 13 Nov
 2023 09:15:03 -0800 (PST)
MIME-Version: 1.0
References: <20231108162356.36670-1-smitterl@redhat.com>
 <35f75a44-b76d-456a-b7b8-67bc3e0cad9c@redhat.com>
In-Reply-To: <35f75a44-b76d-456a-b7b8-67bc3e0cad9c@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Nov 2023 17:14:52 +0000
Message-ID: <CAFEAcA9pXGj3zJLx_WMv1kzgp9ccRb7VbextXjrunZLh+s7D0A@mail.gmail.com>
Subject: Re: [PATCH] risu: Add test summary
To: Thomas Huth <thuth@redhat.com>
Cc: Sebastian Mitterle <smitterl@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, 13 Nov 2023 at 17:04, Thomas Huth <thuth@redhat.com> wrote:
>
> On 08/11/2023 17.23, Sebastian Mitterle wrote:
> > Currently, a successful test run finishes silently with exit code 0.
> > The last message on the console is "starting image" which can leave
> > the user wondering if they executed the commands correctly.
>
> Thanks for the patch, I think this is a good idea - it also initially
> puzzled me a couple of times due to the missing feedback.
>
> > Now add a summary of the number of executed instructions in case
> > of success. Don't add that message when printing the trace to
> > stdout (`-t -`).
> >
> > Tested:
> > a) master/apprentice mode
> > b) trace mode to file
> > c) trace mode to stdout
> >
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Sebastian Mitterle <smitterl@redhat.com>
> > ---
> >   risu.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/risu.c b/risu.c
> > index 36fc82a..740663a 100644
> > --- a/risu.c
> > +++ b/risu.c
> > @@ -551,6 +551,7 @@ int main(int argc, char **argv)
> >       struct option *longopts;
> >       char *shortopts;
> >       stack_t ss;
> > +    int ret;
> >
> >       longopts = setup_options(&shortopts);
> >
> > @@ -635,8 +636,15 @@ int main(int argc, char **argv)
> >       arch_init();
> >
> >       if (ismaster) {
> > -        return master();
> > +        ret = master();
> >       } else {
> > -        return apprentice();
> > +        ret = apprentice();
> >       }
> > +
> > +    if (ret == EXIT_SUCCESS && (!trace || (trace  && strcmp(trace_fn, "-") != 0))) {
>
> There's a superfluous white space here ------------^
>
> Apart from that, I wonder whether the check for trace-to-stdout is really
> necessary, since you print the message to stderr below instead?

Yes, we print other kinds of progress chatter to stderr and we
don't need to check for trace-to-stdout in those other places.

thanks
-- PMM

