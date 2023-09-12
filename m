Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D94079D6B2
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Sep 2023 18:47:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qg6Xi-0007vY-UI; Tue, 12 Sep 2023 12:47:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qg6Xh-0007vG-1f
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:47:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1qg6Xd-0007sf-L9
 for qemu-devel@nongnu.org; Tue, 12 Sep 2023 12:47:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694537228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dcaJk/hLPZKr76cuKVBFzbxziNBoIRvo2XEcNqjxpXk=;
 b=MdVXH+oxWhdcwxF/xR2fpGtbYO6p1qJ6mvQLD6rKlRqBRNb/EpYsR3/rEgaC5P5aDuS/2t
 exP5OTTptZBQmQlEM+AjYyQXBOzR+ikGZZyLbJxrUSqpQzFz/3xys7VGglO2QgRCCQ1x44
 cbisiN0vsXliwd8PpMdH4kOQqJ8Pedo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-18-CEZD7YMkOqCr5PusShUvzg-1; Tue, 12 Sep 2023 12:47:07 -0400
X-MC-Unique: CEZD7YMkOqCr5PusShUvzg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CBB7B29AA3B1;
 Tue, 12 Sep 2023 16:47:06 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.83])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7949140C6EA8;
 Tue, 12 Sep 2023 16:47:05 +0000 (UTC)
Date: Tue, 12 Sep 2023 18:47:04 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Eduardo Habkost <eduardo@habkost.net>, pbonzini@redhat.com,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Maxim Levitsky <mlevitsk@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Subject: Re: [RFC 3/3] qmp: make qmp_device_add() a coroutine
Message-ID: <ZQCWCEzSj8P1sdyW@redhat.com>
References: <20230906190141.1286893-1-stefanha@redhat.com>
 <20230906190141.1286893-4-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906190141.1286893-4-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 06.09.2023 um 21:01 hat Stefan Hajnoczi geschrieben:
> It is not safe to call drain_call_rcu() from qmp_device_add() because
> some call stacks are not prepared for drain_call_rcu() to drop the Big
> QEMU Lock (BQL).
> 
> For example, device emulation code is protected by the BQL but when it
> calls aio_poll() -> ... -> qmp_device_add() -> drain_call_rcu() then the
> BQL is dropped. See bz#2215192 below for a concrete bug of this type.
> 
> Another limitation of drain_call_rcu() is that it cannot be invoked
> within an RCU read-side critical section since the reclamation phase
> cannot complete until the end of the critical section. Unfortunately,
> call stacks have been seen where this happens (see bz#2214985 below).
> 
> Switch to call_drain_rcu_co() to avoid these problems. This requires
> making qmp_device_add() a coroutine. qdev_device_add() is not designed
> to be called from coroutines, so it must be invoked from a BH and then
> switch back to the coroutine.
> 
> Fixes: 7bed89958bfbf40df9ca681cefbdca63abdde39d ("device_core: use drain_call_rcu in in qmp_device_add")
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2215192
> Buglink: https://bugzilla.redhat.com/show_bug.cgi?id=2214985
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Can you please include the relevant information directly in the commit
message instead of only referencing Bugzilla? Both bugs only contain
half of the story - I'm not even sure if the link with the stack trace
is publically accessible - and then I think you got some information
only from reproducing it yourself, and this information is missing from
the bug reports. (The other question is how long the information will
still be available in Bugzilla.)

>  qapi/qdev.json         |  1 +
>  include/monitor/qdev.h |  3 ++-
>  monitor/qmp-cmds.c     |  2 +-
>  softmmu/qdev-monitor.c | 34 ++++++++++++++++++++++++++++++----
>  hmp-commands.hx        |  1 +
>  5 files changed, 35 insertions(+), 6 deletions(-)
> 
> diff --git a/qapi/qdev.json b/qapi/qdev.json
> index 6bc5a733b8..78e9d7f7b8 100644
> --- a/qapi/qdev.json
> +++ b/qapi/qdev.json
> @@ -79,6 +79,7 @@
>  ##
>  { 'command': 'device_add',
>    'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
> +  'coroutine': true,
>    'gen': false, # so we can get the additional arguments
>    'features': ['json-cli', 'json-cli-hotplug'] }
>  
> diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
> index 1d57bf6577..1fed9eb9ea 100644
> --- a/include/monitor/qdev.h
> +++ b/include/monitor/qdev.h
> @@ -5,7 +5,8 @@
>  
>  void hmp_info_qtree(Monitor *mon, const QDict *qdict);
>  void hmp_info_qdm(Monitor *mon, const QDict *qdict);
> -void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
> +void coroutine_fn
> +qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp);
>  
>  int qdev_device_help(QemuOpts *opts);
>  DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index b0f948d337..a7419226fe 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -202,7 +202,7 @@ static void __attribute__((__constructor__)) monitor_init_qmp_commands(void)
>      qmp_init_marshal(&qmp_commands);
>  
>      qmp_register_command(&qmp_commands, "device_add",
> -                         qmp_device_add, 0, 0);
> +                         qmp_device_add, QCO_COROUTINE, 0);
>  
>      QTAILQ_INIT(&qmp_cap_negotiation_commands);
>      qmp_register_command(&qmp_cap_negotiation_commands, "qmp_capabilities",
> diff --git a/softmmu/qdev-monitor.c b/softmmu/qdev-monitor.c
> index 74f4e41338..85ae62f7cf 100644
> --- a/softmmu/qdev-monitor.c
> +++ b/softmmu/qdev-monitor.c
> @@ -839,8 +839,28 @@ void hmp_info_qdm(Monitor *mon, const QDict *qdict)
>      qdev_print_devinfos(true);
>  }
>  
> -void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> +typedef struct {
> +    Coroutine *co;
> +    QemuOpts *opts;
> +    Error **errp;
> +    DeviceState *dev;
> +} QmpDeviceAdd;
> +
> +static void qmp_device_add_bh(void *opaque)
>  {
> +    QmpDeviceAdd *data = opaque;
> +
> +    data->dev = qdev_device_add(data->opts, data->errp);
> +    aio_co_wake(data->co);
> +}
> +
> +void coroutine_fn
> +qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
> +{
> +    QmpDeviceAdd data = {
> +        .co = qemu_coroutine_self(),
> +        .errp = errp,
> +    };
>      QemuOpts *opts;
>      DeviceState *dev;
>  
> @@ -852,7 +872,13 @@ void qmp_device_add(QDict *qdict, QObject **ret_data, Error **errp)
>          qemu_opts_del(opts);
>          return;
>      }
> -    dev = qdev_device_add(opts, errp);
> +
> +    /* Perform qdev_device_add() call outside coroutine context */
> +    data.opts = opts;
> +    aio_bh_schedule_oneshot(qemu_coroutine_get_aio_context(data.co),
> +                            qmp_device_add_bh, &data);
> +    qemu_coroutine_yield();
> +    dev = data.dev;

I wonder if we should make no_co_wrapper etc. available outside of the
block layer, so we could just declare a qdev_co_device_add() and call it
here and the code would automatically be generated.

This doesn't work today because the script generates only a single
source file for all wrappers, which is linked with all of the tools. So
putting qdev functions there would make the build fail.

I had a similar case in the virtio_load() fix where I decided to write
the wrapper manually instead. But having two cases in such a short time
frame might be a sign that we actually have enough potential users that
making the generator work for it would be worth it.

Kevin


