Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC7B75AE2B
	for <lists+qemu-devel@lfdr.de>; Thu, 20 Jul 2023 14:19:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMSc3-0005fO-2z; Thu, 20 Jul 2023 08:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMSbn-0005f2-93
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:18:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qMSbl-00018u-6A
 for qemu-devel@nongnu.org; Thu, 20 Jul 2023 08:18:14 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5217ad95029so888885a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jul 2023 05:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689855490; x=1690460290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=YAEOlkP2Oa5Qo8r0YV9dMc40Loi3P9Ig+H6nILNIY6U=;
 b=DcmkGtbSNmSODRyy4MROYFz0Nu/1uS2QpkW3i7RUmdpJonHWKAsmGC9AK5gGOEqr3V
 M46iY4DAPK/V8Zp87sqTKD78/ZUgQhX5SGl2xJD4LicOpvd0fu/fsdfDElvdRJY4ILJ0
 +CFVtsI1BrJ7MHeqIi93oNPXicWZdKPSvsN5wAFDC3uNWvUEuU+5vbIy75n4DQsMrsUM
 HWUHVSaSNQTCiNipdf56QQJ6x+JiZKVWqSFawo3AjDkotmhphtsNxViM3qzyA8DD4/NW
 JHNljL2A69b3PrvwYVCLnOXg1Pxz5jj8mOILeVf8zfrTv5CjPhsZ03FqKJ0R/8cNF2Rz
 UKCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689855490; x=1690460290;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YAEOlkP2Oa5Qo8r0YV9dMc40Loi3P9Ig+H6nILNIY6U=;
 b=gUoyogZY02xX8AgdnFgHTuU7qj6d16NNREnUuGkpXVvYmVQkewQnkXXaaiHpo+JKbX
 alJurS7cm2i+mCkqpZIiS1H8WUyHfYU98ZdApCl1FQEjGrghNrxdCJ8BB57a6rq7fONZ
 RuNdumVI2PoW+oZlMmmFdkax9UvsG207T+lgw+k7jnBT8k5lqLVSUbZEOzPTjNPxowKp
 NT6YdZWnkQiSyG0/xoDYQeUmYUBE5VeB8XRTNDzB4kTO7Pdze94q8hjZy3PaWab/DMGL
 hbtTYCR1CBa1wGI12UiepBnQ0mHNHhz0ydEJoP5WCbiOCXZKXKGJyI+PIDT6MITOU5aR
 Pa9A==
X-Gm-Message-State: ABy/qLYwnKbKnNez/ZztBiqif0f9JMG0CUsvjoArBQ/MZ27bwRLmWJ8R
 MiDmzu8W8VUlVY6gpSiOY0WAaBzDE7L+0/sK+KxeoQ==
X-Google-Smtp-Source: APBJJlEMy4OJSL4BEkBiRtUTSQcuQzGoNCL6ZKUO7pt0xeq99H8ofoat2Y6LzD5LqEH9kjYy3YXG48mRJtLSnxQoJZw=
X-Received: by 2002:aa7:d392:0:b0:50b:c085:1991 with SMTP id
 x18-20020aa7d392000000b0050bc0851991mr4916092edq.19.1689855489670; Thu, 20
 Jul 2023 05:18:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230716170150.22398-1-richard.henderson@linaro.org>
 <CAFEAcA9dD8SmAFQrt9eRfsMuG3vEh03ex9b+LsgTjg2TRcbiJQ@mail.gmail.com>
 <60ac1fd4-f58f-361e-6b37-3226862f296a@linaro.org>
In-Reply-To: <60ac1fd4-f58f-361e-6b37-3226862f296a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2023 13:17:58 +0100
Message-ID: <CAFEAcA_6+gALRGH3Uk-LS5_DtmLXwPSZGu_kGRUOA4ZW+UQveA@mail.gmail.com>
Subject: Re: [PATCH for-8.1] accel/tcg: Take mmap_lock in load_atomic16_or_exit
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Mon, 17 Jul 2023 at 19:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 7/17/23 11:12, Peter Maydell wrote:
> > On Sun, 16 Jul 2023 at 18:03, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> For user-only, the probe for page writability may race with another
> >> thread's mprotect.  Take the mmap_lock around the operation.  This
> >> is still faster than the start/end_exclusive fallback.
> >>
> >> Remove the write probe in load_atomic8_or_exit.  There we don't have
> >> the same machinery for testing the existance of an 8-byte cmpxchg.
> >
> > "existence"
> >
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>   accel/tcg/ldst_atomicity.c.inc | 54 +++++++++++++++-------------------
> >>   1 file changed, 24 insertions(+), 30 deletions(-)
> >>
> >> diff --git a/accel/tcg/ldst_atomicity.c.inc b/accel/tcg/ldst_atomicity.c.inc
> >> index 4de0a80492..e7170f8ba2 100644
> >> --- a/accel/tcg/ldst_atomicity.c.inc
> >> +++ b/accel/tcg/ldst_atomicity.c.inc
> >> @@ -152,19 +152,6 @@ static uint64_t load_atomic8_or_exit(CPUArchState *env, uintptr_t ra, void *pv)
> >>           return load_atomic8(pv);
> >>       }
> >>
> >> -#ifdef CONFIG_USER_ONLY
> >> -    /*
> >> -     * If the page is not writable, then assume the value is immutable
> >> -     * and requires no locking.  This ignores the case of MAP_SHARED with
> >> -     * another process, because the fallback start_exclusive solution
> >> -     * provides no protection across processes.
> >> -     */
> >> -    if (page_check_range(h2g(pv), 8, PAGE_WRITE_ORG)) {
> >> -        uint64_t *p = __builtin_assume_aligned(pv, 8);
> >> -        return *p;
> >> -    }
> >> -#endif
> >
> > I don't really understand the comment in the commit message:
> > why would it be wrong to wrap this "test writeability and
> > do the operation" in the mmap-lock, the same way we do for the
> > 16-byte case?
>
> It would not be wrong.  I was just thinking of the cmpxchg8 part, for which we do not have
> a configure probe, and for which I *think* there's no call, because there are no 32-bit
> hosts that have cmpxchg8 but not the full CONFIG_ATOMIC64.

But this piece of code the patch deletes isn't doing a
cmpxchg8, it just does a plain load. If "take the lock
and do the operation" is faster than always using the
fallback code for the atomic16 case, why don't we make
the same tradeoff choice in atomic8  ?

thanks
-- PMM

