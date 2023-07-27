Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D2D7765714
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:11:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2Q1-0003HO-JW; Thu, 27 Jul 2023 10:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP2Pt-0003HF-TQ
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:56:39 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qP2Ps-0006ON-2G
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:56:37 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31759e6a4a1so1130101f8f.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690469794; x=1691074594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6mFWdub+Jo1J5CTw4M6CLKVxZPFOBxMz9Qy0Tpa0dzk=;
 b=AYZ6Fu6y7UOKvdc6wTM9GaKY5oz99KXM2Ddxgy2fjavpRozsqkjwvqbiAIIzoBdZJa
 cPL8gbndmD4ajo7whsoV/q3l70wtLjta51Idyktr6IS01kHk/Rizq00ADzCcSTf1ICqx
 n+PZOXpkSzcHDdzDgdfrjydhBSx2fhg7Bhbzl07JBWbU/GszIVU/A/vxXVQuF+b6iKo5
 PN7l7eqw2Rjg8aAoaMpMMY2SLTY6PWh8vgfpq7VosMp8eRc+GUh8qGCeQs/4xsmZT6T1
 MvQVY+AV5JYZ333DoLfd9LGHN/U+CusBxCOIzbTQ3mOJ4ZqS7zST8FmxP5DOTrvdJEw7
 F0Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690469794; x=1691074594;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6mFWdub+Jo1J5CTw4M6CLKVxZPFOBxMz9Qy0Tpa0dzk=;
 b=LHDtb6pKomu001ZXzS854HxD+HGvZzex804CVRowTVZRMWbMUt8KSrBs8N1Mzk68Qr
 0egl+G8BsLqCsF7eXQbFmjEuPzIyH5SgxHspmsNgfduYLKJAx4L4RPPj2/YQVP01uOAY
 U5HVKPQ5phAbbnM6fXqs1qFtpWfDE1hDotejl23v4lFRs1NCq6Vs6Tzm5+ssTHYaAxNP
 oYVaa21J+c9yqSrhtueAShRuJRJKvCAV8A7vQfs2C+IPPhNZ4uGjHqmI8/VQjRsnpeL/
 FxnlHnxJK484kipKDgMtY/l51sSj8giRMx7nn2byUR+LbYVYOqYqZdp4sAQtivK6uio1
 zS4Q==
X-Gm-Message-State: ABy/qLY7D231//cE7ak6qEXsTRTeNDDSSFQoaXMtobwSv0hiwqx0mUnj
 DGTz06R2QUjWdRjcfQnHhfKvsCbYjGKOIT4mi8BJQw==
X-Google-Smtp-Source: APBJJlHP5O2Tu+UsaEgsnC5s/9/NeQQzLgkugoPLun6i0gYV/78CYR6oSlZNgNW/3uzIjnC2wA6lVQ+Jffe5OWsAsJs=
X-Received: by 2002:a5d:694a:0:b0:314:dea:f1f8 with SMTP id
 r10-20020a5d694a000000b003140deaf1f8mr2073906wrw.11.1690469794292; Thu, 27
 Jul 2023 07:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
 <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
 <E1qOWH5-0002Du-U6@lists.gnu.org>
 <CAFEAcA8UdN4-DU4dAiY3VGLA77mLK-ohfFJs5+5fDt3v1mAAcg@mail.gmail.com>
 <9a05f370-1857-2c28-a184-a5197455b314@linaro.org>
In-Reply-To: <9a05f370-1857-2c28-a184-a5197455b314@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 27 Jul 2023 15:56:23 +0100
Message-ID: <CAFEAcA-4qzq7hivk-vuZMfxOaMXU7zusATtotiashNqrSbupSg@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
To: Richard Henderson <richard.henderson@linaro.org>
Cc: dinglimin@cmss.chinamobile.com, Michael Tokarev <mjt@tls.msk.ru>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x432.google.com
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

On Wed, 26 Jul 2023 at 16:21, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/26/23 02:43, Peter Maydell wrote:
> > (Something went wrong with the quoting in your email. I've
> > fixed it up.)
> >
> > On Wed, 26 Jul 2023 at 05:38, <dinglimin@cmss.chinamobile.com> wrote:
> >> Peter Maydell wrote:
> >>> The third part here, is that g_malloc() does not ever
> >>> fail -- it will abort() on out of memory. However
> >>> the code here is still handling g_malloc() returning NULL.
> >>> The equivalent for "we expect this might fail" (which we want
> >>> here, because the guest is passing us the length of memory
> >>> to try to allocate) is g_try_malloc().
> >
> >> g_malloc() is preferred more than g_try_* functions, which return NULL on error,
> >> when the size of the requested allocation  is small.
> >> This is because allocating few bytes should not be a problem in a healthy system.
> >
> > This is true. But in this particular case we cannot be sure
> > that the size of the allocation is small, because the size
> > is controlled by the guest. So we want g_try_malloc().
>
> And why do we want to use g_try_malloc instead of just sticking with malloc?

The only real reason is just consistency -- the project uses
the glib malloc wrappers, and in theory any use of raw
malloc() ought to be either:
 * something that's third party library code (eg libdecnumber)
 * because it's going into a standalone program that doesn't
   link against glib
 * for a special case reason which is documented in a
   nearby comment (eg because the memory is going to be
   passed to some library which documents that it will assume
   it can free() the memory)

We're down to very few uses of malloc() that don't fall
into one of those cases:

bsd-user/elfload.c
a few uses in disas/ (m68k, sparc, nios2)
hw/audio/fmopl.c
semihosting/uaccess.c
target/xtensa/translate.c
contrib/elf2dmp/
(and maybe tests/qtest/fuzz/qtest_wrappers.c : I'm not
sure what environment that gets built in.)

The main reason we get patches like this is that the
"bite sized tasks" list at
https://wiki.qemu.org/Contribute/BiteSizedTasks
has an entry for "convert malloc uses to g_new or similar".
The trouble with that is that almost all of the low-hanging
fruit was converted a long time ago, so the remainder
are getting increasingly tricky to analyse and increasingly
less worthwhile...

thanks
-- PMM

