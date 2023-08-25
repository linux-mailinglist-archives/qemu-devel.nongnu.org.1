Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BB2C07881F8
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 10:24:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZS5t-0006x5-Ng; Fri, 25 Aug 2023 04:23:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZS5r-0006we-VE; Fri, 25 Aug 2023 04:22:59 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qZS5n-0006wF-FF; Fri, 25 Aug 2023 04:22:59 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bee82fad0fso5509605ad.2; 
 Fri, 25 Aug 2023 01:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692951773; x=1693556573;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L1twLz0HPvzAjIroRmi3QEESpiAkFL7rV0W+vQb7/pE=;
 b=BRqlnBQ4/yr2xX5x6+EvAscB1SUdJoK1zx84GyzJ/qXV2dNHIpt9V3GsQeanI4g7Eg
 j7pcXMypL+nWDckuI/k7cY/lfQTnjufAr2PRf5l92la04X+iERB/kbVGLz0cEe4XZD7b
 6Ci+BNue5WfJzkQEzFErvJxv0SVlRgf1Hp4Z/sdQVKhqpUQB+dbJWzSXfQx6PUpUrsK6
 o+W9nWqAUP0FwC8ltb7VEGFg8ixOV8NGWFRaoBZ9xkj15lohxJfijxyDcKCTqkcsJdIZ
 +QFhxiTTFmtU2CxfrMalD5O5OTdGqYULFMIrHNt8xE3KF/1aIjmTgtbQOBrnCwNeDDlW
 IHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692951773; x=1693556573;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=L1twLz0HPvzAjIroRmi3QEESpiAkFL7rV0W+vQb7/pE=;
 b=gP8Hh8CfriNB0ZNFhSu6h2+aYonuvESOrcLShVGukhNnqMtfHfi5J6R8no1Tqbi43f
 sBaLU9eALn719UTYarxtFQkD9Rn7aH6k4svmIARytw9V/UGXANRrPRZvqLTBfTvLKm2/
 cYeC0Tg8lJdAxpH1ql+h3vVQVzpmWQWYdx70GdECABiiJd09//9P78lT8Lk9WIB3zL+C
 Fh4gQ4AHCT5jzsABhjDklYp2r/FChIC7mjHOX2qpsxMXdMQsi/NLqPpaMHu9/g9Yonpu
 RS18sL1s0LVt8KbCFn+jRas5QuX2FSzWxeuYoNsWMIdxWcpTvahk03zsCu0cBJjPXqxz
 K4NA==
X-Gm-Message-State: AOJu0YwWy1Z2InOEghdkOH9TMFSPZtgdQeiLrcjuwzyYHbm+mdacQvLZ
 8//krR/xquBPWx1Pddm3kBw=
X-Google-Smtp-Source: AGHT+IFuf3ZKTS5Z/W9z6Pvv1Fnb9cCJLRJvGSCtm4P8WQAVeUHzm9PSfgp9hkrWtuE+H6QPakJEYg==
X-Received: by 2002:a17:902:efd3:b0:1bc:2036:2219 with SMTP id
 ja19-20020a170902efd300b001bc20362219mr12682843plb.41.1692951773036; 
 Fri, 25 Aug 2023 01:22:53 -0700 (PDT)
Received: from localhost ([1.146.69.243]) by smtp.gmail.com with ESMTPSA id
 x2-20020a170902ea8200b001bb97e51ab4sm1051616plb.98.2023.08.25.01.22.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 01:22:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 25 Aug 2023 18:22:48 +1000
Message-Id: <CV1HBDIQZEBS.3FH95D6WMLXV0@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Pavel Dovgalyuk" <pavel.dovgalyuk@ispras.ru>, "Pavel Dovgalyuk"
 <pavel.dovgaluk@ispras.ru>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, "Paolo Bonzini" <pbonzini@redhat.com>
Subject: Re: [RFC v2 PATCH] record-replay: support SMP target machine
X-Mailer: aerc 0.15.2
References: <20230811014700.39172-1-npiggin@gmail.com>
 <48d32058-dd1b-a2ed-42f2-e21c099bc0e3@ispras.ru>
In-Reply-To: <48d32058-dd1b-a2ed-42f2-e21c099bc0e3@ispras.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Aug 22, 2023 at 2:44 PM AEST, Pavel Dovgalyuk wrote:
> On 11.08.2023 04:47, Nicholas Piggin wrote:
> > RR CPU switching is driven by timers and events so it is deterministic
> > like everything else. Record a CPU switch event and use that to drive
> > the CPU switch on replay.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> > This is still in RFC phase because so far I've only really testd ppc
> > pseries, and only with patches that are not yet upstream (but posted
> > to list).
> >=20
> > It works with smp 2, can step, reverse-step, reverse-continue, etc.
> > throughout a Linux boot.
>
> I still didn't have time to test it, but here are some comments.

That's okay, I got a little further, mainly adding vmstate to
migrate it (otherwise we can only use the initial snapshot).

Unless there is more interest, I will focus on getting ppc fixes
upstream first. Let me know if you have more time to look, I can
send you the latest.

[snip]

> > @@ -294,9 +346,9 @@ static void *rr_cpu_thread_fn(void *arg)
> >               qatomic_set_mb(&cpu->exit_request, 0);
> >           }
> >  =20
> > -        if (all_cpu_threads_idle()) {
> > -            rr_stop_kick_timer();
> > +        qatomic_set(&rr_next_cpu, cpu);
>
> This does not seem to be in the mainline.

Sorry I meant to sqush that in or send it out. The kick timer
init vs start needed to be moved to make it work.

[snip]

> > -bool replay_exception(void)
> > +bool replay_switch_cpu(void)
> > +{
> > +    if (replay_mode =3D=3D REPLAY_MODE_RECORD) {
> > +        g_assert(replay_mutex_locked());
> > +        replay_save_instructions();
> > +        replay_put_event(EVENT_SWITCH_CPU);
> > +        return true;
> > +    } else if (replay_mode =3D=3D REPLAY_MODE_PLAY) {
> > +        bool res =3D replay_has_switch_cpu();
> > +        if (res) {
> > +            replay_finish_event();
> > +        } else {
> > +            g_assert_not_reached();
> > +        }
> > +        return res;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> > +bool replay_has_switch_cpu(void)
>
> Is this function really needed?

I found it was easier to fit in the way the CPU scheduling is done
in rr.

I think that main scheduling loop could be refactored a bit that
could then avoid the need for this (e.g., a helper function to
return the next CPU and all the selection code including rr is
in there). But that became non-trivial and looks like the code is
a bit delicate. I might try to tackle that afterwards.

Thanks,
Nick

