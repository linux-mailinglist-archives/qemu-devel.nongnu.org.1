Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C10F7972F4
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 16:07:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeFfC-0002X4-F9; Thu, 07 Sep 2023 10:07:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1qeFf9-0002Wq-0m
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:07:15 -0400
Received: from mx.treblig.org ([2a00:1098:5b::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dg@treblig.org>) id 1qeFf4-00007Y-Kn
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 10:07:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=treblig.org
 ; s=bytemarkmx;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID
 :Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID
 :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
 Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
 :List-Post:List-Owner:List-Archive;
 bh=+veBLRB4yjgvttecAMtQrN2LzAFFVEsaNzJMuqPHczY=; b=J0jFFcaVvbZS2Ky/CU1Vcco0BE
 5uFWP6jmKOhJYDSygeYj5SEGurPlG8E9CAvPyFScnRaIxgN8BgyqENJusnABFMqnxiWXDTtvirNJj
 jrpReeZmiTU1rdRXEDH4hSU6mhintBljh3GKsSu3N+3DM22wgGg8MRsqSkCV7R/HW+GLXSHat0bbI
 RnzwG8iVhsrfTQZacKkHWjk5m2np8uqJmBokbH+4Ki2X0oS2izIGm3Gq7v8VkBB8BV9FI6Lg9heuR
 MCgqsQ9VCo44u4/CvBq5F/TOUFKL8U+Rz7hahQo7R/Gg25ulo2t9xRqTXEBDqB3yAegzN7+/mWmJA
 ONLG5eYg==;
Received: from dg by mx.treblig.org with local (Exim 4.94.2)
 (envelope-from <dg@treblig.org>)
 id 1qeFez-00ANIR-Lf; Thu, 07 Sep 2023 14:07:05 +0000
Date: Thu, 7 Sep 2023 14:07:05 +0000
From: "Dr. David Alan Gilbert" <dave@treblig.org>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 pbonzini@redhat.com, Markus Armbruster <armbru@redhat.com>,
 Eric Blake <eblake@redhat.com>, kwolf@redhat.com,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 1/3] hmp: avoid the nested event loop in handle_hmp_command()
Message-ID: <ZPnZCbnpzS2QsEYO@gallifrey>
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-2-stefanha@redhat.com>
 <ZPkiH4WvSs1k43RQ@gallifrey> <20230907140428.GB1363873@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20230907140428.GB1363873@fedora>
X-Chocolate: 70 percent or better cocoa solids preferably
X-Operating-System: Linux/5.10.0-23-amd64 (x86_64)
X-Uptime: 14:05:45 up 62 days, 23:37, 1 user, load average: 0.00, 0.00, 0.00
User-Agent: Mutt/2.0.5 (2021-01-21)
Received-SPF: pass client-ip=2a00:1098:5b::1; envelope-from=dg@treblig.org;
 helo=mx.treblig.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

* Stefan Hajnoczi (stefanha@redhat.com) wrote:
> On Thu, Sep 07, 2023 at 01:06:39AM +0000, Dr. David Alan Gilbert wrote:
> > * Stefan Hajnoczi (stefanha@redhat.com) wrote:
> > > Coroutine HMP commands currently run to completion in a nested event
> > > loop with the Big QEMU Lock (BQL) held. The call_rcu thread also uses
> > > the BQL and cannot process work while the coroutine monitor command is
> > > running. A deadlock occurs when monitor commands attempt to wait for
> > > call_rcu work to finish.
> > 
> > I hate to think if there's anywhere else that ends up doing that
> > other than the monitors.
> 
> Luckily drain_call_rcu() has few callers: just
> xen_block_device_destroy() and qmp_device_add(). We only need to worry
> about their call stacks.
> 
> I haven't looked at the Xen code.
> 
> > 
> > But, not knowing the semantics of the rcu code, it looks kind of OK to
> > me from the monitor.
> > 
> > (Do you ever get anything like qemu quitting from one of the other
> > monitors while this coroutine hasn't been run?)
> 
> Not sure what you mean?

Imagine that just after you create your coroutine, a vCPU does a
shutdown and qemu is configured to quit, or on another monitor someone
does a quit;  does your coroutine get executed or not?

Dave

> Stefan
> 
> > 
> > Dave
> > 
> > > This patch refactors the HMP monitor to use the existing event loop
> > > instead of creating a nested event loop. This will allow the next
> > > patches to rely on draining call_rcu work.
> > > 
> > > Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> > > ---
> > >  monitor/hmp.c | 28 +++++++++++++++-------------
> > >  1 file changed, 15 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > > index 69c1b7e98a..6cff2810aa 100644
> > > --- a/monitor/hmp.c
> > > +++ b/monitor/hmp.c
> > > @@ -1111,15 +1111,17 @@ typedef struct HandleHmpCommandCo {
> > >      Monitor *mon;
> > >      const HMPCommand *cmd;
> > >      QDict *qdict;
> > > -    bool done;
> > >  } HandleHmpCommandCo;
> > >  
> > > -static void handle_hmp_command_co(void *opaque)
> > > +static void coroutine_fn handle_hmp_command_co(void *opaque)
> > >  {
> > >      HandleHmpCommandCo *data = opaque;
> > > +
> > >      handle_hmp_command_exec(data->mon, data->cmd, data->qdict);
> > >      monitor_set_cur(qemu_coroutine_self(), NULL);
> > > -    data->done = true;
> > > +    qobject_unref(data->qdict);
> > > +    monitor_resume(data->mon);
> > > +    g_free(data);
> > >  }
> > >  
> > >  void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
> > > @@ -1157,20 +1159,20 @@ void handle_hmp_command(MonitorHMP *mon, const char *cmdline)
> > >          Monitor *old_mon = monitor_set_cur(qemu_coroutine_self(), &mon->common);
> > >          handle_hmp_command_exec(&mon->common, cmd, qdict);
> > >          monitor_set_cur(qemu_coroutine_self(), old_mon);
> > > +        qobject_unref(qdict);
> > >      } else {
> > > -        HandleHmpCommandCo data = {
> > > -            .mon = &mon->common,
> > > -            .cmd = cmd,
> > > -            .qdict = qdict,
> > > -            .done = false,
> > > -        };
> > > -        Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, &data);
> > > +        HandleHmpCommandCo *data; /* freed by handle_hmp_command_co() */
> > > +
> > > +        data = g_new(HandleHmpCommandCo, 1);
> > > +        data->mon = &mon->common;
> > > +        data->cmd = cmd;
> > > +        data->qdict = qdict; /* freed by handle_hmp_command_co() */
> > > +
> > > +        Coroutine *co = qemu_coroutine_create(handle_hmp_command_co, data);
> > > +        monitor_suspend(&mon->common); /* resumed by handle_hmp_command_co() */
> > >          monitor_set_cur(co, &mon->common);
> > >          aio_co_enter(qemu_get_aio_context(), co);
> > > -        AIO_WAIT_WHILE_UNLOCKED(NULL, !data.done);
> > >      }
> > > -
> > > -    qobject_unref(qdict);
> > >  }
> > >  
> > >  static void cmd_completion(MonitorHMP *mon, const char *name, const char *list)
> > > -- 
> > > 2.41.0
> > > 
> > > 
> > -- 
> >  -----Open up your eyes, open up your mind, open up your code -------   
> > / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
> > \        dave @ treblig.org |                               | In Hex /
> >  \ _________________________|_____ http://www.treblig.org   |_______/
> > 


-- 
 -----Open up your eyes, open up your mind, open up your code -------   
/ Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \ 
\        dave @ treblig.org |                               | In Hex /
 \ _________________________|_____ http://www.treblig.org   |_______/

