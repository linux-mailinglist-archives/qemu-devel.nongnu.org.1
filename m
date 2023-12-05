Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D1898805F8C
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 21:35:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAc7r-0005Od-Ei; Tue, 05 Dec 2023 15:34:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rAc7p-0005OO-61
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:34:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rAc7n-0007w7-Cn
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 15:34:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701808472;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P5TwCx/9HL+8vDH7H3KT4cb57WEhYmiKdiaY9LWeRcw=;
 b=YM45xDA0VcMAa+UaVa/RBDBfRvZeCfVZHaQi5orOMueJRerKjnBa/9+eLKk1Tt7RpHayAl
 9mmIp6zrc49HgzVLyOp3osBakmCEw/09g1tfM8fFiNN/1bhMII5NnfEtoE4ZrNuNU5V52V
 /bK1UcuxeoKxrsX7u1uASYtsxaF4tME=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-iL7LB5MyPwGriRscMn2dFg-1; Tue, 05 Dec 2023 15:34:30 -0500
X-MC-Unique: iL7LB5MyPwGriRscMn2dFg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 04AD3863E88;
 Tue,  5 Dec 2023 20:34:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id BA53C492C25;
 Tue,  5 Dec 2023 20:34:29 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADBA021E6A01; Tue,  5 Dec 2023 21:34:28 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Annie Li <annie.li@oracle.com>
Cc: qemu-devel@nongnu.org,  imammedo@redhat.com,  miguel.luis@oracle.com
Subject: Re: [RFC PATCH 01/11] acpi: hmp/qmp: Add hmp/qmp support for
 system_sleep
In-Reply-To: <20231205002356.1239-1-annie.li@oracle.com> (Annie Li's message
 of "Tue, 5 Dec 2023 00:23:56 +0000")
References: <20231205002143.562-1-annie.li@oracle.com>
 <20231205002356.1239-1-annie.li@oracle.com>
Date: Tue, 05 Dec 2023 21:34:28 +0100
Message-ID: <87r0k075ij.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

You neglected to cc: QAPI schema maintainers.  I found it by chance.
Next time :)

Annie Li <annie.li@oracle.com> writes:

> Following hmp/qmp commands are implemented for pressing virtual
> sleep button,
>
> hmp: system_sleep
> qmp: { "execute": "system_sleep" }
>
> These commands put the guest into suspend or other power states
> depending on the power settings inside the guest.

How is this related to system_wakeup?

> Signed-off-by: Annie Li <annie.li@oracle.com>
> ---
>  hmp-commands.hx            | 14 ++++++++++++++
>  hw/core/machine-hmp-cmds.c |  5 +++++
>  hw/core/machine-qmp-cmds.c |  9 +++++++++
>  include/monitor/hmp.h      |  1 +
>  qapi/machine.json          | 18 ++++++++++++++++++
>  qapi/pragma.json           |  1 +
>  6 files changed, 48 insertions(+)
>
> diff --git a/hmp-commands.hx b/hmp-commands.hx
> index 765349ed14..bd01e49ec5 100644
> --- a/hmp-commands.hx
> +++ b/hmp-commands.hx
> @@ -652,6 +652,20 @@ SRST
>    whether profiling is on or off.
>  ERST
>  
> +    {
> +        .name       = "system_sleep",
> +        .args_type  = "",
> +        .params     = "",
> +        .help       = "send ACPI sleep event",

Suggest "push the virtual sleep button", because it's easier to
understand, and consistent with the documentation below.

> +        .cmd = hmp_system_sleep,
> +    },
> +
> +SRST
> +``system_sleep``
> +  Push the virtual sleep button; if supported the system will enter
> +  an ACPI sleep state.
> +ERST
> +
>      {
>          .name       = "system_reset",
>          .args_type  = "",
> diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
> index a6ff6a4875..641a365e3e 100644
> --- a/hw/core/machine-hmp-cmds.c
> +++ b/hw/core/machine-hmp-cmds.c
> @@ -185,6 +185,11 @@ void hmp_system_reset(Monitor *mon, const QDict *qdict)
>      qmp_system_reset(NULL);
>  }
>  
> +void hmp_system_sleep(Monitor *mon, const QDict *qdict)
> +{
> +    qmp_system_sleep(NULL);
> +}
> +
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict)
>  {
>      qmp_system_powerdown(NULL);
> diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
> index 3860a50c3b..9f1e636c90 100644
> --- a/hw/core/machine-qmp-cmds.c
> +++ b/hw/core/machine-qmp-cmds.c
> @@ -257,6 +257,15 @@ void qmp_system_reset(Error **errp)
>      qemu_system_reset_request(SHUTDOWN_CAUSE_HOST_QMP_SYSTEM_RESET);
>  }
>  
> +void qmp_system_sleep(Error **errp)
> +{
> +    if (!qemu_wakeup_suspend_enabled()) {
> +        error_setg(errp,
> +                   "suspend from running is not supported by this guest");
> +        return;
> +    }

This can't be right: it either fails or does nothing.

I guess you're leaving the "do something" part to later patches.  That's
okay, but it needs a TODO comment here, and a prominent mention in the
commit message.

> +}
> +
>  void qmp_system_powerdown(Error **errp)
>  {
>      qemu_system_powerdown_request();
> diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
> index 13f9a2dedb..d72a3b775c 100644
> --- a/include/monitor/hmp.h
> +++ b/include/monitor/hmp.h
> @@ -45,6 +45,7 @@ void hmp_quit(Monitor *mon, const QDict *qdict);
>  void hmp_stop(Monitor *mon, const QDict *qdict);
>  void hmp_sync_profile(Monitor *mon, const QDict *qdict);
>  void hmp_system_reset(Monitor *mon, const QDict *qdict);
> +void hmp_system_sleep(Monitor *mon, const QDict *qdict);
>  void hmp_system_powerdown(Monitor *mon, const QDict *qdict);
>  void hmp_exit_preconfig(Monitor *mon, const QDict *qdict);
>  void hmp_announce_self(Monitor *mon, const QDict *qdict);
> diff --git a/qapi/machine.json b/qapi/machine.json
> index b6d634b30d..3ac69df92f 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -297,6 +297,24 @@
>  ##
>  { 'command': 'system_reset' }
>  
> +##
> +# @system_sleep:
> +#
> +# Requests that a guest perform a ACPI sleep transition by pushing a virtual
> +# sleep button.

Imperative mood, please: "Request that ..."

I think "the guest" would be better.

Limit line length to 70, please.

> +#
> +# Notes: A guest may or may not respond to this command. This command
> +#        returning does not indicate that a guest has accepted the request
> +#        or that it has gone to sleep.

Please format like

    # Notes: A guest may or may not respond to this command.  This command
    #    returning does not indicate that a guest has accepted the request
    #    or that it has gone to sleep.
  
> +#
> +# Example:
> +#
> +# -> { "execute": "system_sleep" }
> +# <- { "return": {} }
> +#
> +##
> +{ 'command': 'system_sleep' }
> +
>  ##
>  # @system_powerdown:
>  #
> diff --git a/qapi/pragma.json b/qapi/pragma.json
> index 0aa4eeddd3..ef15229854 100644
> --- a/qapi/pragma.json
> +++ b/qapi/pragma.json
> @@ -23,6 +23,7 @@
>          'set_password',
>          'system_powerdown',
>          'system_reset',
> +        'system_sleep',
>          'system_wakeup' ],
>      # Commands allowed to return a non-dictionary
>      'command-returns-exceptions': [

I figure you spell system_sleep with '_' instead of '-' for consistency
with existing system_FOO commands.  That's okay, but I recommend to
point it out in the commit message.


