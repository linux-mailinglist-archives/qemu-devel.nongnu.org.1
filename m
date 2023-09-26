Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 805A97AF501
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 22:25:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlEbJ-0006Va-F4; Tue, 26 Sep 2023 16:24:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEbH-0006VL-AO
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:24:07 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qlEbF-0004V4-O3
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 16:24:07 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-51e28cac164so23609406a12.1
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 13:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695759844; x=1696364644; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCXTNdvE506jIzf0d2eabIqRsVbej6eZMk1ZK0W7V6c=;
 b=sNZLHgDMSBDQ7jiz082qVlSFxjGhbH2w1QUVOS25ku+TnWZKNHtAB8ZDvbtcs0lbw5
 ddz2BbpiEE2+IVQvxAg4qBE99bw/xXOrPczCvfQTBdL7tWfg2Z6HrwLVGl+IkY7a8cTr
 QGSxe4ewQRtiVnTcctuR7rAGuX86rSraosF2JYNgpWoXmNkVOa0hwY7C8N89/bZ7uDt7
 l1G5viySseJESS7c+N0q3V0WZYNcHIe1GwKbaHJfWVcrOUiSxY43hD7+LzjzGIMQdAs3
 9fjZlXVf7Tc0dOuu++9d87VBZF2wvJwn+JLs8rJ2UsCyzMQ09VH9AN5MTIoP4MAgYHCr
 G/uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695759844; x=1696364644;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCXTNdvE506jIzf0d2eabIqRsVbej6eZMk1ZK0W7V6c=;
 b=LC+3hftB0L+XO0OK09hsiRFvG97zrdbB77por5t4z6GHvpawQdBsJSh+JDY3Re0wtc
 XeD51mKx9AWBGEEOIlId+gfDW2AvXaEv0MvXwLW0BJl9SEh+tCOqd9kgmWztm/IOIUAt
 aSIWfW/vmIcFCw0CXoeYMutQIzRkJMNniQw6s9O4qHnwuWo1YgptmxY+rXdXZMk+gySl
 V0jZupRdb01HvgyLx1P4+OMtjOKeo6B6TapVHz71w2fs+WqvkXrl6WHJUIALRHZbRGdj
 XLTd1qcnad+oqY5I6M/wjgsI4qa2qORyOWklLkMdJ5+PXd1RcQ1m8gbz+oUbwk1m53/0
 qCJg==
X-Gm-Message-State: AOJu0Yz+yh+VT2/vfVptLqc36Za2f0l3hxE9YH9fmJF2bxPCDZrAA6dP
 j9rOp4miYhQIUNpL9irUkJWyIOdGkkz/pmZorAScMg==
X-Google-Smtp-Source: AGHT+IEx2pfhILGEJOikokdhY6xHpQPRubY3DjADaG7rd0Mf/dXaMGeNMO664QOocf06gus2nx72BzOHY0VvIhzPu5s=
X-Received: by 2002:a05:6402:2794:b0:530:cc8c:9e41 with SMTP id
 b20-20020a056402279400b00530cc8c9e41mr6100627ede.19.1695759843829; Tue, 26
 Sep 2023 13:24:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
 <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
 <CAFEAcA85LwsFiBxbDiki6-8FAbmZSFFH7Esf+x8stiPDjww_KA@mail.gmail.com>
 <o4gb5k2pa2h7krwvstec2qdfvrsnzlc2l3q3da476bofdepazf@mzqnyast5uw5>
In-Reply-To: <o4gb5k2pa2h7krwvstec2qdfvrsnzlc2l3q3da476bofdepazf@mzqnyast5uw5>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 21:23:45 +0100
Message-ID: <CAFEAcA-weYPrZ+asFSvApXzJo=ZHUJGi4hB8ku710SBEUiuWjw@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
To: Eric Blake <eblake@redhat.com>
Cc: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org, kwolf@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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

On Tue, 26 Sept 2023 at 20:42, Eric Blake <eblake@redhat.com> wrote:
>
> On Tue, Sep 26, 2023 at 02:46:44PM +0100, Peter Maydell wrote:
> > On Tue, 26 Sept 2023 at 14:40, Eric Blake <eblake@redhat.com> wrote:
> > >
> > > On Tue, Sep 26, 2023 at 01:28:01PM +0300, andrey.drobyshev@virtuozzo.com wrote:
> > > > From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > > >
> > > > This fixes authorship of commits 2848289168, 52b10c9c0c as the mailing
> > > > list rewrote the "From:" field in the corresponding patches.  See commit
> > > > 3bd2608db7 ("maint: Add .mailmap entries for patches claiming list
> > > > authorship") for explanation.
> > > >
> > > > Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > > > ---
> > > >  .mailmap | 1 +
> > > >  1 file changed, 1 insertion(+)
> > >
> > > Reviewed-by: Eric Blake <eblake@redhat.com>
> >
> > Hi Eric -- you wrote commit 3bd2608db72997, which included the
> > comment for this bit of .mailmap:
> >
> > +# Next, translate a few commits where mailman rewrote the From: line due
> > +# to strict SPF, although we prefer to avoid adding more entries like that.
> >
> > What did you mean by "we prefer to avoid adding more entries" ?
> > It reads to me like "don't add more entries even if we get more
> > accidental attributed-to-the-list commits" (and I was actually
> > thinking about replying to this patch to say "the mailmap file
> > says we shouldn't add more of these lines"), but presumably since
> > you've reviewed this patch that wasn't the actual intention.
> > Maybe the comment could use clarification.
>
> Indeed, it is meant more along the lines of "because our build process
> was tweaked to warn us in advance of merging more commits that suffer
> from the same problem, we shouldn't be having to continually increase
> the size of this section", or even "if you end up adding a line here,
> please also take the time to figure out what part of our build process
> failed to catch it in advance" (in this particular instance, the
> failure was effectively that we were grepping for 'via qemu-devel',
> not 'via qemu-.*').  If wording along those lines is better, or if you
> have other ideas, I'm happy to turn it into a formal commit to improve
> the comment in that file.

Yes, I think something like that would be clearer; thanks!

-- PMM

