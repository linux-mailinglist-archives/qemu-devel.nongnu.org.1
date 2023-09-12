Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E40BB79D725
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 19:05:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6oY-0000PT-T5; Tue, 12 Sep 2023 13:04:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg6oV-0000LU-LZ
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:04:36 -0400
Received: from mail-oa1-x32.google.com ([2001:4860:4864:20::32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qg6oS-00049v-T8
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 13:04:35 -0400
Received: by mail-oa1-x32.google.com with SMTP id
 586e51a60fabf-1d1b55882a4so3994441fac.1
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 10:04:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694538271; x=1695143071; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2BNY9C6UqYa2E/0UCQZg0BTnAVMaFmn13+Q3pyJqHF4=;
 b=i1q3CoDwk1xrI2zN4KG1HgL9I1D66N8t011NN07PBy0HwudDthQnHWY5+a9XrboxFY
 CcCOtE/vt5CkvI5h+PAgtPvZRleJ9U6JP1bbki58N8gAvNkaFC/bwBV9M0CbTvS15LU2
 V7wvG49JjRHEyhl30CztuP0iua/kpafBMxszZAwirTasV/jMT9IvzGXU6M1YYbK1urjP
 3caLXgU8Epv+WyQNyaOJnsHsillJ2HJxGDgPNU+INnyNBO6wAr5tLVEjl7PDK6kbPCox
 0NMuj6NgqJ4Nbc/24HkBDlrtVMwtwDtEsEWC2IkVWZE2syrRJsIeEZf3AiUnBVZc0SYD
 nBaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694538271; x=1695143071;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2BNY9C6UqYa2E/0UCQZg0BTnAVMaFmn13+Q3pyJqHF4=;
 b=OLTQAGXomuN4wCQg65jLHCOb0/tM2LqO7wM/ryLnIsUNNyDuUG4/HnKJqyz5uhKjyh
 MhUBkfZsGj/Z++FQVDzVnEAZZ2xnBKFb6EOMy7Gj+L1L5SbzKsNQQ4HRLDFneBPw9ihk
 zNC1Hgn2ZIg7Va1Kti9LLzvYewFq8/2xLqOPUjTJsfdkBvyoH7z8WypFplHqztC8G9ge
 YuOT4P4zee5gtUMwTt79pEjkaAMRaoWwFz5s60Jbg2bDXHpLQNDeaoASSXPy+CQVwqKG
 qxqpZ/08YLqHvZlQ9dO+Xt0NAu76DgMKF2CtCe7F6xuPEHo3qlwa1wZ9hlkwC1fqrJRf
 qhMQ==
X-Gm-Message-State: AOJu0Yx7G5BCtU3iWCxtbatpwql5ofRA0NSJ89oJp2SiMzc9GOlUuHkj
 hkkm4hMlW57DF3auxpz3u6cg49xBG4Wj3nYc5fCEgDu0
X-Google-Smtp-Source: AGHT+IH8wM+ySjSJaIqnK2jM2elZvrF0oGjLiKJi7djPnA+HBWC3KhY5iSX8lJFdmSYFYD9tws7r0rrcGsH3y9A5QXc=
X-Received: by 2002:a05:6870:a116:b0:1bc:11ec:1752 with SMTP id
 m22-20020a056870a11600b001bc11ec1752mr114065oae.36.1694538271575; Tue, 12 Sep
 2023 10:04:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-4-stefanha@redhat.com>
 <ZQCWCEzSj8P1sdyW@redhat.com>
In-Reply-To: <ZQCWCEzSj8P1sdyW@redhat.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 12 Sep 2023 13:04:17 -0400
Message-ID: <CAJSP0QUx6EZmV5Y4RcA2NYWKJn1s_yn0oGpH=FWNp=GKNXZbjw@mail.gmail.com>
Subject: Re: [RFC 3/3] qmp: make qmp_device_add() a coroutine
To: Kevin Wolf <kwolf@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, 
 Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2001:4860:4864:20::32;
 envelope-from=stefanha@gmail.com; helo=mail-oa1-x32.google.com
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

On Tue, 12 Sept 2023 at 12:47, Kevin Wolf <kwolf@redhat.com> wrote:
>
> Am 06.09.2023 um 21:01 hat Stefan Hajnoczi geschrieben:
> > It is not safe to call drain_call_rcu() from qmp_device_add() because
> > some call stacks are not prepared for drain_call_rcu() to drop the Big
> > QEMU Lock (BQL).
> >
> > For example, device emulation code is protected by the BQL but when it
> > calls aio_poll() -> ... -> qmp_device_add() -> drain_call_rcu() then the
> > BQL is dropped. See bz#2215192 below for a concrete bug of this type.
> >
> > Another limitation of drain_call_rcu() is that it cannot be invoked
> > within an RCU read-side critical section since the reclamation phase
> > cannot complete until the end of the critical section. Unfortunately,
> > call stacks have been seen where this happens (see bz#2214985 below).
> >
> > Switch to call_drain_rcu_co() to avoid these problems. This requires
> > making qmp_device_add() a coroutine. qdev_device_add() is not designed
> > to be called from coroutines, so it must be invoked from a BH and then
> > switch back to the coroutine.
> >
> > Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
> > Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
> > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
>
> Can you please include the relevant information directly in the commit
> message instead of only referencing Bugzilla? Both bugs only contain
> half of the story - I'm not even sure if the link with the stack trace
> is publically accessible - and then I think you got some information
> only from reproducing it yourself, and this information is missing from
> the bug reports. (The other question is how long the information will
> still be available in Bugzilla.)

Yes, I'll include the details in the commit description.

>
> >  qapi/qdev.json         |  1 +
> >  include/monitor/qdev.h |  3 ++-
> >  monitor/qmp-cmds.c     |  2 +-
> >  softmmu/qdev-monitor.c | 34 ++++++++++++++++++++++++++++++----
> >  hmp-commands.hx        |  1 +
> >  5 files changed, 35 insertions(+), 6 deletions(-)
> >
> > diff --git a/qapi/qdev.json b/qapi/qdev.json
> > index 6bc5a733b8..78e9d7f7b8 100644
> > --- a/qapi/qdev.json
> > +++ b/qapi/qdev.json
> > @@ -79,6 +79,7 @@
> >  ##
> >  { 'command': 'device_add',
> >    'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
> > +  'coroutine': true,
> >    'gen': false, # so we can get the additional arguments
> >    'features': ['json-cli', 'json-cli-hotplug'] }
> >
> > diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> > index 1d57bf6577..1fed9eb9ea 100644
> > --- a/include/monitor/qdev.h
> > +++ b/include/monitor/qdev.h
> > @@ -5,7 +5,8 @@
> >
> >  void hmp_info_qtree(Monitor *mon, const QDict *qdict);
> >  void hmp_info_qdm(Monitor *mon, const QDict *qdict);
> > -void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
> > +void coroutine_fn
> > +qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
> >
> >  int qdev_device_help(QemuOpts *opts);
> >  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
> > diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> > index b0f948d337..a7419226fe 100644
> > --- a/monitor/qmp-cmds.c
> > +++ b/monitor/qmp-cmds.c
> > @@ -202,7 +202,7 @@ static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
> >      qmp_init_marshal(&qmp_commands);
> >
> >      qmp_register_command(&qmp_commands, "device_add",
> > -                         qmp_device_add, 0, 0);
> > +                         qmp_device_add, QCO_COROUTINE, 0);
> >
> >      QTAILQ_INIT(&qmp_cap_negotiation_commands);
> >      qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
> > diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> > index 74f4e41338..85ae62f7cf 100644
> > --- a/softmmu/qdev-monitor.c
> > +++ b/softmmu/qdev-monitor.c
> > @@ -839,8 +839,28 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
> >      qdev_print_devinfos(true);
> >  }
> >
> > -void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> > +typedef struct {
> > +    Coroutine *co;
> > +    QemuOpts *opts;
> > +    Error **errp;
> > +    DeviceState *dev;
> > +} QmpDeviceAdd;
> > +
> > +static void qmp_device_add_bh(void *opaque)
> >  {
> > +    QmpDeviceAdd *data = opaque;
> > +
> > +    data->dev = qdev_device_add(data->opts, data->errp);
> > +    aio_co_wake(data->co);
> > +}
> > +
> > +void coroutine_fn
> > +qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> > +{
> > +    QmpDeviceAdd data = {
> > +        .co = qemu_coroutine_self(),
> > +        .errp = errp,
> > +    };
> >      QemuOpts *opts;
> >      DeviceState *dev;
> >
> > @@ -852,7 +872,13 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> >          qemu_opts_del(opts);
> >          return;
> >      }
> > -    dev = qdev_device_add(opts, errp);
> > +
> > +    /* Perform qdev_device_add() call outside coroutine context */
> > +    data.opts = opts;
> > +    aio_bh_schedule_oneshot(qemu_coroutine_get_aio_context(data.co),
> > +                            qmp_device_add_bh, &data);
> > +    qemu_coroutine_yield();
> > +    dev = data.dev;
>
> I wonder if we should make no_co_wrapper etc. available outside of the
> block layer, so we could just declare a qdev_co_device_add() and call it
> here and the code would automatically be generated.
>
> This doesn't work today because the script generates only a single
> source file for all wrappers, which is linked with all of the tools. So
> putting qdev functions there would make the build fail.
>
> I had a similar case in the virtio_load() fix where I decided to write
> the wrapper manually instead. But having two cases in such a short time
> frame might be a sign that we actually have enough potential users that
> making the generator work for it would be worth it.

In principal I'm happy to do that. Before I continue working on the
coroutine version of qmp_device_add(), please let us know your
thoughts about Paolo's idea.

If I understand correctly, Paolo's idea is to refactor the monitor
code so that non-coroutine monitor commands run in the iohandler
AioContext, thus avoiding the drain_call_rcu() vs nested event loops
issue. It would not be necessary to make qmp_device_add() a coroutine
anymore since drain_call_rcu() could be called safely.

Does that sound okay or are you aware of a case where this doesn't work?

Stefan

