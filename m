Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0E7797DEA
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 23:26:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeMVU-0003Rd-EZ; Thu, 07 Sep 2023 17:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeMVS-0003RN-DP
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 17:25:42 -0400
Received: from mail-oo1-xc31.google.com ([2607:f8b0:4864:20::c31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1qeMVP-00026U-LL
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 17:25:42 -0400
Received: by mail-oo1-xc31.google.com with SMTP id
 006d021491bc7-5717f7b932aso855669eaf.0
 for <qemu-devel@nongnu.org>; Thu, 07 Sep 2023 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694121938; x=1694726738; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I2/VCXJcRXM/Ssq60p4siaCgOUDXwgq69Z+hE3MqL1M=;
 b=qeJiYZKayMRWpIZrw9TFfrg5K+I6xzAmFYuxnFLa5B94zDTygk9vVYGI9czoRvnqh0
 DlihnhZWVaQhNDwtifq65tKLt/K8OAgDg7wc1SaHa30NwOQgBXC4j+DNFD3+pLE+LfUh
 ZAlk3W6VG3EmyljlzOdepprcCd9Q5fjA4AwdZh+cIvXUM5WITL6pn7vJXcz3kjL17Ocj
 QtpUmXqAf0Fcvunrvx/un3xV2PqNudlI8j68XsAq9JP7VVKtYsCyNEkTcdWyA+AZ+ljj
 uWq/WCoJaliR483lHHQHttFkLgs3LZ8n0KIKIX7Jld+WNAHe58NetoFeARCwYGfyJOzr
 QyMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694121938; x=1694726738;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=I2/VCXJcRXM/Ssq60p4siaCgOUDXwgq69Z+hE3MqL1M=;
 b=XZYBT3zL/05TvbNQL0vlucjD5gRsehud5GTimxxKq+Dm3Eprcr/dYma16Bs4MBhJw4
 1sRPK/jqmg4p/384EZ6ch46NB0dbBDVXj4cCU6+9N5tYxhUamKttX2VyhNs08g0ecmmI
 WD7hBKGo2gWmjZ3LZ6p/oeSSIGm3ahevTWRRV0jromv2jP2WNWqfGeqPHrypGAn8APCC
 eLX71GmBBw/XMOT78wxOFUxrkuapLZdXZPalzkHRnlo5fpmKb+MEIUmPvid2ZcvIfad5
 6VuH40r2/d975d1WN2fOYDOScuwQgmt9UNsWGLdxwYaYhTOivUF+vbbAUs5HfSKAi5WR
 Hr3Q==
X-Gm-Message-State: AOJu0Yzsrssd3UsNWXFOau+wD1bV4CKSCHJwsU7Ujn1xLwf2FHQ4e4NG
 WUqUlQOJg1i7edwChUc6Eg4l+NBMguo8mTwJ+AE=
X-Google-Smtp-Source: AGHT+IG7Z/kgkt7wuEotqujlnbnBF5bMn2n710uT5JTnj0eEem0U7uKcyjtaRsrPHBuMAXg7Co8blLGGAN3qMk/CGaw=
X-Received: by 2002:a4a:3906:0:b0:56d:2229:5f94 with SMTP id
 m6-20020a4a3906000000b0056d22295f94mr760268ooa.6.1694121938332; Thu, 07 Sep
 2023 14:25:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-2-stefanha@redhat.com>
 <ZPkiH4WvSs1k43RQ@gallifrey> <20230907140428.GB1363873@fedora>
 <ZPnZCbnpzS2QsEYO@gallifrey>
 <CAJSP0QWGi4y0aanPKs7S0HuOD=Vp4GZ2YURMZovgO9_zDSucng@mail.gmail.com>
 <ZPo4O3k2ikebJS6Y@gallifrey>
In-Reply-To: <ZPo4O3k2ikebJS6Y@gallifrey>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 7 Sep 2023 17:25:26 -0400
Message-ID: <CAJSP0QXM03bF9keeL2qekGn5Qid1y_3nnK7_UighP1hzpSWu6A@mail.gmail.com>
Subject: Re: [RFC 1/3] hmp: avoid the nested event loop in handle_hmp_command()
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com, 
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 kwolf@redhat.com, Maxim Levitsky <mlevitsk@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::c31;
 envelope-from=stefanha@gmail.com; helo=mail-oo1-xc31.google.com
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

On Thu, 7 Sept 2023 at 16:53, Dr. David Alan Gilbert <dave@treblig.org> wro=
te:
>
> * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> > On Thu, 7 Sept 2023 at 10:07, Dr. David Alan Gilbert <dave@treblig.org>=
 wrote:
> > >
> > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > On Thu, Sep 07, 2023 at 01:06:39AM +0000, Dr. David Alan Gilbert wr=
ote:
> > > > > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > > > > Coroutine HMP commands currently run to completion in a nested =
event
> > > > > > loop with the Big QEMU Lock (BQL) held. The call_rcu thread als=
o uses
> > > > > > the BQL and cannot process work while the coroutine monitor com=
mand is
> > > > > > running. A deadlock occurs when monitor commands attempt to wai=
t for
> > > > > > call_rcu work to finish.
> > > > >
> > > > > I hate to think if there's anywhere else that ends up doing that
> > > > > other than the monitors.
> > > >
> > > > Luckily drain_call_rcu() has few callers: just
> > > > xen_block_device_destroy() and qmp_device_add(). We only need to wo=
rry
> > > > about their call stacks.
> > > >
> > > > I haven't looked at the Xen code.
> > > >
> > > > >
> > > > > But, not knowing the semantics of the rcu code, it looks kind of =
OK to
> > > > > me from the monitor.
> > > > >
> > > > > (Do you ever get anything like qemu quitting from one of the othe=
r
> > > > > monitors while this coroutine hasn't been run?)
> > > >
> > > > Not sure what you mean?
> > >
> > > Imagine that just after you create your coroutine, a vCPU does a
> > > shutdown and qemu is configured to quit, or on another monitor someon=
e
> > > does a quit;  does your coroutine get executed or not?
> >
> > I think the answer is that it depends.
> >
> > A coroutine can run for a while and then yield while waiting for a
> > timer, BH, fd handler, etc. If the coroutine has yielded then I think
> > QEMU could terminate.
> >
> > The behavior of entering a coroutine for the first time depends on the
> > API that is used (e.g. qemu_coroutine_enter()/aio_co_enter()/etc).
> > qemu_coroutine_enter() is immediate but aio_co_enter() contains
> > indirect code paths like scheduling a BH.
> >
> > To summarize: =C2=AF\_(=E3=83=84)_/=C2=AF
>
> That does mean you leave your g_new'd data and qdict allocated at
> exit - meh
>
> I'm not sure if it means you're making any other assumptions about what
> happens if the coroutine gets run during the exit path; although I guess
> there are plenty of other cases like that.

Yes, I think QEMU has some resources (memory, file descriptors, etc)
that are not freed on exit.

Stefan

>
> Dave
>
> > Stefan
> >
> > >
> > > Dave
> > >
> > > > Stefan
> > > >
> > > > >
> > > > > Dave
> > > > >
> > > > > > This patch refactors the HMP monitor to use the existing event =
loop
> > > > > > instead of creating a nested event loop. This will allow the ne=
xt
> > > > > > patches to rely on draining call_rcu work.
> > > > > >
> > > > > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > ---
> > > > > >  monitor/hmp.c | 28 +++++++++++++++-------------
> > > > > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > > > > >
> > > > > > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > > > > > index 69c1b7e98a..6cff2810aa 100644
> > > > > > --- a/monitor/hmp.c
> > > > > > +++ b/monitor/hmp.c
> > > > > > @@ -1111,15 +1111,17 @@ typedef struct HandleHmpCommandCo {
> > > > > >      Monitor *mon;
> > > > > >      const HMPCommand *cmd;
> > > > > >      QDict *qdict;
> > > > > > -    bool done;
> > > > > >  } HandleHmpCommandCo;
> > > > > >
> > > > > > -static void handle_hmp_command_co(void *opaque)
> > > > > > +static void coroutine_fn handle_hmp_command_co(void *opaque)
> > > > > >  {
> > > > > >      HandleHmpCommandCo *data =3D opaque;
> > > > > > +
> > > > > >      handle_hmp_command_exec(data->mon, data->cmd, data->qdict)=
;
> > > > > >      monitor_set_cur(qemu_coroutine_self(), NULL);
> > > > > > -    data->done =3D true;
> > > > > > +    qobject_unref(data->qdict);
> > > > > > +    monitor_resume(data->mon);
> > > > > > +    g_free(data);
> > > > > >  }
> > > > > >
> > > > > >  void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
> > > > > > @@ -1157,20 +1159,20 @@ void handle_hmp_command(MonitorHMP *mon=
, const char *cmdline)
> > > > > >          Monitor *old_mon =3D monitor_set_cur(qemu_coroutine_se=
lf(), &mon->common);
> > > > > >          handle_hmp_command_exec(&mon->common, cmd, qdict);
> > > > > >          monitor_set_cur(qemu_coroutine_self(), old_mon);
> > > > > > +        qobject_unref(qdict);
> > > > > >      } else {
> > > > > > -        HandleHmpCommandCo data =3D {
> > > > > > -            .mon =3D &mon->common,
> > > > > > -            .cmd =3D cmd,
> > > > > > -            .qdict =3D qdict,
> > > > > > -            .done =3D false,
> > > > > > -        };
> > > > > > -        Coroutine *co =3D qemu_coroutine_create(handle_hmp_com=
mand_co, &data);
> > > > > > +        HandleHmpCommandCo *data; /* freed by handle_hmp_comma=
nd_co() */
> > > > > > +
> > > > > > +        data =3D g_new(HandleHmpCommandCo, 1);
> > > > > > +        data->mon =3D &mon->common;
> > > > > > +        data->cmd =3D cmd;
> > > > > > +        data->qdict =3D qdict; /* freed by handle_hmp_command_=
co() */
> > > > > > +
> > > > > > +        Coroutine *co =3D qemu_coroutine_create(handle_hmp_com=
mand_co, data);
> > > > > > +        monitor_suspend(&mon->common); /* resumed by handle_hm=
p_command_co() */
> > > > > >          monitor_set_cur(co, &mon->common);
> > > > > >          aio_co_enter(qemu_get_aio_context(), co);
> > > > > > -        AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
> > > > > >      }
> > > > > > -
> > > > > > -    qobject_unref(qdict);
> > > > > >  }
> > > > > >
> > > > > >  static void cmd_completion(MonitorHMP *mon, const char *name, =
const char *list)
> > > > > > --
> > > > > > 2.41.0
> > > > > >
> > > > > >
> > > > > --
> > > > >  -----Open up your eyes, open up your mind, open up your code ---=
----
> > > > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Hap=
py  \
> > > > > \        dave @ treblig.org |                               | In =
Hex /
> > > > >  \ _________________________|_____ http://www.treblig.org   |____=
___/
> > > > >
> > >
> > >
> > > --
> > >  -----Open up your eyes, open up your mind, open up your code -------
> > > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  =
\
> > > \        dave @ treblig.org |                               | In Hex =
/
> > >  \ _________________________|_____ http://www.treblig.org   |_______/
> > >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/

