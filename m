Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CD6897914D5
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Sep 2023 11:37:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qd60B-00064B-0J; Mon, 04 Sep 2023 05:36:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qd608-000621-2m
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:36:08 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1qd605-0001vb-Lm
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 05:36:07 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-68a3cae6d94so1084750b3a.0
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 02:36:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1693820163; x=1694424963; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Nrk3a84zKucr6Kw+Ypq/qexuTh4tB+pqH5JqoD4Vds=;
 b=H32CpHAY2sX+phOmYHkqmQg4oC31NtbnwxvvqNl1ATNn0ERJU92SfblqTOZlBAeoB7
 ZtjcZ3ZHJpQfmLGHZAFn5v5ARmcB6ScyoFlU4Pta+11Hy1U6PoHLIcgKgaJQ9DEpo/v6
 H75d8BuDyzZZyrdQ8eu0QZjcR2ZTXlm6GbhN97NB0m0ljp79dYk31Kcl0rKsAhDuvS+G
 ftxc6V2lk6fLTtyUllufkMxTu84YyX/SLRqkqR0oEZ6OZHThtNgqL6SwRhfkSZURkLY8
 KT4eeRweWzK4lcnfRe01iJl4tkeZndbQQ1uFx9k7UKnvozIhhWfGLldSaFjQNGTry4OA
 +Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693820163; x=1694424963;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Nrk3a84zKucr6Kw+Ypq/qexuTh4tB+pqH5JqoD4Vds=;
 b=P7WtCUlV5WnPyzWB6yon34lE9aQckQtcW8MbSs6S13p9r+9udm2ycP7BRDOcvtib13
 JUqa0GtDh+ooy7+me2G11a7je5o41jns2xxuq5Jqm0xZUeELa0jjTX0yEW7hJEro6Ksx
 qHM85pST2X1bWsItvLQGVb9VnLo56yTvT88yJjKmJwk0oYYDkIL88p8G32V8fAqVOyAo
 EP5tMpqLqZP2GvygOu2BBHY6QBljwPlZ0UR3l/zpOxddzh2R3otP0TYwD0z53AZYW+oU
 4Rq67M0YxSfo58sRfNrMDOPpxHUir7XrQN75vPoS6lo+XqAU34GL+jcK9avpj3xhiMaX
 iHEg==
X-Gm-Message-State: AOJu0Yx+AFi0qWLrSHa2E2dhy9+ByyOI812NGjr9dlfb6/4Ina0iEYGr
 LN6HI6A4blZwmLCkVtDLyyfm+wMTwrNADjlES76Cug==
X-Google-Smtp-Source: AGHT+IHb2urSoRINpJXJpLE+X3/adI5XMRJMdWPQA2yFNWRk6V/CJyHCP0mV6tevnT0hLAjWOCJvVgxSNpzRdy0RtQI=
X-Received: by 2002:a05:6a20:6a04:b0:14c:def1:984c with SMTP id
 p4-20020a056a206a0400b0014cdef1984cmr12782409pzk.19.1693820163570; Mon, 04
 Sep 2023 02:36:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230823070735.363197-1-chigot@adacore.com>
 <CAFEAcA9EHpyPuJOCAbLCn8=F+aaSZ=yzwDPwT70VUyCgMDLmYw@mail.gmail.com>
In-Reply-To: <CAFEAcA9EHpyPuJOCAbLCn8=F+aaSZ=yzwDPwT70VUyCgMDLmYw@mail.gmail.com>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Mon, 4 Sep 2023 11:35:52 +0200
Message-ID: <CAJ307EjBudxJTFo9HQMttKzKwQN0WaRzenhDKRL_wDGTHCtdhg@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] gdbstub: replace exit(0) with proper shutdown
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=chigot@adacore.com; helo=mail-pf1-x42f.google.com
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

On Mon, Sep 4, 2023 at 11:23=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Wed, 23 Aug 2023 at 08:07, Cl=C3=A9ment Chigot <chigot@adacore.com> wr=
ote:
> >
> > This replaces the exit(0) call by a shutdown request, ensuring a proper
> > cleanup of Qemu. Otherwise, some connections could be broken without
> > being correctly flushed.
> >
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > ---
> >  gdbstub/gdbstub.c |  3 +--
> >  gdbstub/softmmu.c | 13 +++++++++++++
> >  gdbstub/user.c    |  2 ++
> >  3 files changed, 16 insertions(+), 2 deletions(-)
> >
> > diff --git a/gdbstub/gdbstub.c b/gdbstub/gdbstub.c
> > index 5f28d5cf57..358eed1935 100644
> > --- a/gdbstub/gdbstub.c
> > +++ b/gdbstub/gdbstub.c
> > @@ -1298,7 +1298,6 @@ static void handle_v_kill(GArray *params, void *u=
ser_ctx)
> >      gdb_put_packet("OK");
> >      error_report("QEMU: Terminated via GDBstub");
> >      gdb_exit(0);
> > -    exit(0);
> >  }
> >
> >  static const GdbCmdParseEntry gdb_v_commands_table[] =3D {
> > @@ -1818,7 +1817,7 @@ static int gdb_handle_packet(const char *line_buf=
)
> >          /* Kill the target */
> >          error_report("QEMU: Terminated via GDBstub");
> >          gdb_exit(0);
> > -        exit(0);
> > +        break;
> >      case 'D':
> >          {
> >              static const GdbCmdParseEntry detach_cmd_desc =3D {
> > diff --git a/gdbstub/softmmu.c b/gdbstub/softmmu.c
> > index f509b7285d..fa9b09537d 100644
> > --- a/gdbstub/softmmu.c
> > +++ b/gdbstub/softmmu.c
> > @@ -434,6 +434,19 @@ void gdb_exit(int code)
> >      }
> >
> >      qemu_chr_fe_deinit(&gdbserver_system_state.chr, true);
> > +
> > +    /*
> > +     * Shutdown request is a clean way to stop the QEMU, compared
> > +     * to a direct call to exit(). But we can't pass the exit code
> > +     * through it so avoid doing that when it can matter.
> > +     * As this function is also called during the cleanup process,
> > +     * avoid sending the request if one is already set.
> > +     */
> > +    if (code) {
> > +        exit(code);
> > +    } else if (!qemu_shutdown_requested_get()) {
> > +        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
> > +    }
> >  }
>
> This definitely doesn't look right. Either exit() is OK
> to call, or it is not. We shouldn't be exiting one way
> if the exit status is 0 and another way if it is non-0.

I do agree but AFAIK, this isn't possible to pass the exit code using
qemu_system_shutdown_request.
Would it make more sense to trigger a SHUTDOWN_CAUSE_GUEST_PANIC
instead ? This would result in a non-0 exit code and the already
available gdb_trace would show the real exit code if needed.

Cl=C3=A9ment

