Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A8C4760F77
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 11:38:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOESt-0005s5-Lw; Tue, 25 Jul 2023 05:36:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOESg-0005rS-7s
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 05:36:11 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOESd-0006ZN-Bm
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 05:36:09 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-4f4b2bc1565so8097776e87.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690277763; x=1690882563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=OAbwSATIkqUeAcjuLuwJuiCVeDFy28mcRLEHFXvnLQM=;
 b=BZA+8FPjs9LkgW/6RwaUVDno0VlM3JUa+Oa4gXA+s2q9kL92GhBwq3nIFRt4ZYORgy
 d7VNPjjc2a/fPHoUKVO5sILTH5yv9hB+vTUJUvQUcy9t9req3Ik8lfATiz0I0ugnV7M8
 nmWzS1LGz+ODRAJwuFrhGXQ8gp63VuNOsmfDpIV7eZ/4Bg7bxegf5ARJFMUV0sG8aUYt
 2Fiq3ChKg1QX7crpnQB1667e70MAeVRBsJB1Wj1+eE2g/78Bbxh5GRQIqy14b9kDsoE1
 hVTyS6AzNF6E0IdzGRzejIIJUAFFlUvT7MH1kuh6OOFQHO3Rw51xbeRtH4OmcDbp2EyH
 Tz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690277763; x=1690882563;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OAbwSATIkqUeAcjuLuwJuiCVeDFy28mcRLEHFXvnLQM=;
 b=J0psljz0I9XGODJ2BEIS49PM45+717iRNv7UhpnvPcx+vZJ8LYh5j18r+z+itTXNy3
 3nelSV+E8I+GZEr5WHlrBuXbAh62h/zuGL0MUJJPdFT6PFEpj8ck7jFtqzzJTBVcBiZ0
 0lcI/icsvfASc7sjsd+erJPV8hQPi20ERawCMtEjISid429/7SBwMgrQcxkJFJI0roeT
 5JO6Ez9tBqHYkBDYiver5N0taZ08BKkmNhwl4cF2x276xkf5ghK91hqhgFhDgeOqYoaO
 risJin/zoiAh+rBKUHm4XHeEcgWcXM2xyr7HnhYLLUJrPgZIHb32G7R3BgedkmE0v48m
 MeiQ==
X-Gm-Message-State: ABy/qLa6+aMtLm7ULCRNI3ejZ95xVFl2QSS0tMOoAjwPpnzo/Cwp2Z3c
 0eH6D1yMeqk59WlJhvJT8pkuC7+tpY2qn4W7UD/xSdrPh5EUXCss
X-Google-Smtp-Source: APBJJlFexq7SbqyKojxz2Yp+rQaeBrFlYMn/Gkj/G7iTVTWwb8qts1v/xBnVhPmBoe7WCXZ+TYJ1xL+aN2e0LHZehOI=
X-Received: by 2002:a05:6512:39d0:b0:4fb:9631:4bb with SMTP id
 k16-20020a05651239d000b004fb963104bbmr8027779lfu.11.1690277762801; Tue, 25
 Jul 2023 02:36:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230725080630.1083-1-dinglimin@cmss.chinamobile.com>
 <20230725090039.1271-1-dinglimin@cmss.chinamobile.com>
 <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
In-Reply-To: <106cf02f-f746-e216-22be-8f7594028695@tls.msk.ru>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Jul 2023 10:35:51 +0100
Message-ID: <CAFEAcA-ErMrk60uZMu8M-0G15aTvhOZsYsvJD1F-YbLGOFDBYA@mail.gmail.com>
Subject: Re: [PATCH] semihosting/uaccess.c: Replaced a malloc call with
 g_malloc.
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: dinglimin <dinglimin@cmss.chinamobile.com>, richard.henderson@linaro.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Tue, 25 Jul 2023 at 10:13, Michael Tokarev <mjt@tls.msk.ru> wrote:
>
> 25.07.2023 12:00, dinglimin wrote:
> > Replaced a call to malloc() and its respective call to free() with g_malloc() and g_free().
> >
> > Signed-off-by: dinglimin <dinglimin@cmss.chinamobile.com>
> >
> > V1 -> V2:if cpu_memory_rw_debug failed, still need to set p=NULL
> > ---
> >   semihosting/uaccess.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/semihosting/uaccess.c b/semihosting/uaccess.c
> > index 8018828069..2ac754cdb6 100644
> > --- a/semihosting/uaccess.c
> > +++ b/semihosting/uaccess.c
> > @@ -14,10 +14,10 @@
> >   void *softmmu_lock_user(CPUArchState *env, target_ulong addr,
> >                           target_ulong len, bool copy)
> >   {
> > -    void *p = malloc(len);
> > +    void *p = g_malloc(len);
> >       if (p && copy) {
> >           if (cpu_memory_rw_debug(env_cpu(env), addr, p, len, 0)) {
> > -            free(p);
> > +            g_free(p);
> >               p = NULL;
> >           }
> >       }
>
> Ok, that was the obvious part.  Now a next one, also obvious.
>
> You changed lock_user to use g_malloc(), but unlock_user
> still uses free() instead of g_free().  At the very least
> the other one needs to be changed too.  And I'd say the callers
> should be analyzed to ensure they don't free() the result
> (they should not, think it is a bug if they do).

We can be pretty sure the callers don't free() the returned
value, because the calling code is also used in user-mode,
where the lock/unlock implementation is entirely different
and calling free() on the pointer will not work.

> lock_user/unlock_user (which #defines to softmmu_lock_user/
> softmmu_unlock_user in softmmu mode) is used a *lot*.

The third part here, is that g_malloc() does not ever
fail -- it will abort() on out of memory. However
the code here is still handling g_malloc() returning NULL.
The equivalent for "we expect this might fail" (which we want
here, because the guest is passing us the length of memory
to try to allocate) is g_try_malloc().

thanks
-- PMM

