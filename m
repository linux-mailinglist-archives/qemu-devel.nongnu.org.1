Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 37BD67973C8
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 17:31:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeGxe-0004r1-IO; Thu, 07 Sep 2023 11:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeGxV-0004oH-A4
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:30:18 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeGxR-0003S6-5X
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 11:30:17 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-57128297bd7so667051eaf.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 08:30:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694100610; x=1694705410; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bu5xAVI86a78zIuRpJMIl7yUpkIIIks1oQwtFGLvG/4=;
 b=GCkfHs2vVU6p/Yhg1NuFe4JE4oWmtoc2C9K7zzwE71P/UNWriVXz7chh+ZY2eZIzkl
 tpWItxVdksO77f/7mmhXchNURRnDKmtuPbOA2kKklexRt6ox49KXPW7OhpLMOQkmooCY
 A/9vB5UYtKrRrBZCEZ5nuq5k8wF+UonCrqbP4Z83PzCVV1foBCT4skmU67ye3v+A559g
 IKr+XzEqO2DscastXgY5RaFZNiNyzTBE/swbETnpHHo4VIRcvIUAIShd49C9f4Ey3yga
 Ek+wx/wn4E0+xXoxED5TCBP/d1JAF9Vzsx0bi/XQLrTZL6pU7aKAk2sauLoOCTVKq9VM
 /cMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694100610; x=1694705410;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bu5xAVI86a78zIuRpJMIl7yUpkIIIks1oQwtFGLvG/4=;
 b=H+4sllXkYmVuOA5BLsGVaiTaOHEUhlamcXKWiYXBeFynZjGCsWIkT8PGUAdzTiwKF7
 jIvwksw3f26eTT3W0sKNpo+o1jQjL+vAqOjXNyNRk+S4xqriPLxwtR9Zib+oEmhYcuXb
 sWkUGUsVmwCyVFHpntk+OwgoZtk3sfV/mSA13D7s+7rPmBEPIa7o7kP23nL/VATdaX6k
 Vg6aIqnVsezGLCiAC7H2u+wywRj4ztdVyEcVY2UCNnIagdQHrZygYUYQLUlPAb9eaxCK
 vDQOmd3cKzQCSqNPgbwXQVH7523QOu3Km4zUkAsJ5v2yGFgYGeN+C9gucA6dNq/y3152
 G+Pg==
X-Gm-Message-State: AOJu0YzohyMIPVoZFAd3OI7fF8txU/v5h9azWL2JSrjJGvB4MtMhmr76
 TPVA4HDwvHOikG7FEq96+MG7+mHACKGE6cCEF24=
X-Google-Smtp-Source: AGHT+IFL27HCzZnxkANJPiNOYHR9CkJugPRgpcND65q81whVaooXT5cNMMMMt9wYdwLkZn3px6dj7UtokKyK5Y6/6mg=
X-Received: by 2002:a4a:840f:0:b0:571:28d5:2c71 with SMTP id
 l15-20020a4a840f000000b0057128d52c71mr15427854oog.2.1694100610028; Thu, 07
 Sep 2023 08:30:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <1fa3ad95-c335-7e97-42f0-00dca5c5ba48@redhat.com>
 <20230907140006.GA1363873@fedora>
 <CABgObfZXE+AupVGZTbm-W4RXbQPBiqSAgo+U4k1Eza=U1sortA@mail.gmail.com>
In-Reply-To: <CABgObfZXE+AupVGZTbm-W4RXbQPBiqSAgo+U4k1Eza=U1sortA@mail.gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Sep 2023 11:29:57 -0400
Message-ID: <CAJSP0QUZXcHKQKka1LEM8OcBp1L2FQp0TZfvLNe3ZVy-HnkPzw@mail.gmail.com>
Subject: Re: [RFC 0/3] qmp: make qmp_device_add() a coroutine
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc2b.google.com
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

On Thu, 7 Sept 2023 at 10:26, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> On Thu, Sep 7, 2023 at 4:00=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.c=
om> wrote:
> > While I agree that the issue would not happen if monitor commands only
> > ran in the iohandler AioContext, I don't think we can change that.
> > When Kevin implemented coroutine commands in commit 9ce44e2ce267 ("qmp:
> > Move dispatcher to a coroutine"), he used qemu_get_aio_context()
> > deliberately so that AIO_WAIT_WHILE() can make progress.
>
> Ah, you are referring to
>
> +        /*
> +         * Move the coroutine from iohandler_ctx to qemu_aio_context for
> +         * executing the command handler so that it can make progress if=
 it
> +         * involves an AIO_WAIT_WHILE().
> +         */
> +        aio_co_schedule(qemu_get_aio_context(), qmp_dispatcher_co);
> +        qemu_coroutine_yield();
>
> > I'm not clear on the exact scenario though, because coroutines shouldn'=
t
> > call AIO_WAIT_WHILE().
>
> I think he meant "so that an AIO_WAIT_WHILE() invoked through a bottom
> half will make progress on the coroutine as well".
>
> However I am not sure the comment applies here, because
> do_qmp_dispatch_bh() only applies to non-coroutine commands; that
> commit allowed monitor commands to run in vCPU threads when they
> previously weren't.
>
> Thinking more about it, I don't like that the
>
>     if (!!(cmd->options & QCO_COROUTINE) =3D=3D qemu_in_coroutine()) {
>     }
>
> check is in qmp_dispatch() rather than monitor_qmp_dispatch().
>
> Any caller of qmp_dispatch() knows if it is in a coroutine or not.
> qemu-ga uses neither a coroutine dispatcher nor coroutine commands.
> QEMU uses non-coroutine dispatch for out-of-band commands (and we can
> forbid coroutine + allow-oob at the same time), and coroutine dispatch
> for the others.
>
> So, moving out of coroutine context (through a bottom half) should be
> done by monitor_qmp_dispatch(), and likewise moving temporarily out of
> the iohandler context in the case of coroutine commands. In the case
> of !req_obj->req you don't need to do either of those. qmp_dispatch()
> can still assert that the coroutine-ness of the command matches the
> context in which qmp_dispatch() is called.
>
> Once this is done, I think moving out of coroutine context can use a
> BH that runs in the iohandler context.

I'll wait for Kevin's input and will then revisit the patches based on
the conclusion we come to.

Stefan

