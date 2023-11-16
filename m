Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F0B7EE3FF
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 16:16:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3e4V-0002rN-G2; Thu, 16 Nov 2023 10:14:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3e4T-0002qr-0a
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:14:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r3e4O-0003G2-PE
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 10:14:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1700147655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=prht84Cl4IFeTviwy5hPtEFOt/MikZdVp7S83A0C5v4=;
 b=gzdl03Apz6wNEaIry9EfUkEUC1E/gNlvON1ZHjpZx+85mjSW0oeTsUt8YZJRQYhCxvbAWe
 jkrScFz8s9LtQtMVL7Nciu2D7Ah2OAT/NoGnn6FsV8LcWCjXHYRO0zoC4oxPCnXkNkrCuW
 +BlWgVipRQo+vVA2i10kLB4uzkPXMeo=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-567-lSMZRbx4O1ymsKQuc_TfQw-1; Thu,
 16 Nov 2023 10:14:09 -0500
X-MC-Unique: lSMZRbx4O1ymsKQuc_TfQw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 10B6D38C6161;
 Thu, 16 Nov 2023 15:14:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AEBFA7AD9;
 Thu, 16 Nov 2023 15:14:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id BCC4121E6A1F; Thu, 16 Nov 2023 16:14:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org,
 Michael Roth <michael.roth@amd.com>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>
Subject: Re: [PATCH] monitor: flush messages on abort
References: <1699027289-213995-1-git-send-email-steven.sistare@oracle.com>
 <ZUUu2IuUQ/Od7+Vr@redhat.com>
 <3d45ebc0-de9f-4051-9c08-47e40fea65da@oracle.com>
 <ZUi7izJoVpU+iiuC@redhat.com> <875y23s918.fsf@pond.sub.org>
 <17078387-f782-42dc-a5bf-25ee22bc518a@oracle.com>
 <87a5rfkn73.fsf@pond.sub.org>
 <1f51f77e-6793-49a8-b6a2-4f3b1d6a761c@oracle.com>
Date: Thu, 16 Nov 2023 16:14:07 +0100
In-Reply-To: <1f51f77e-6793-49a8-b6a2-4f3b1d6a761c@oracle.com> (Steven
 Sistare's message of "Wed, 15 Nov 2023 12:41:35 -0500")
Message-ID: <8734x5ennk.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.117,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 11/15/2023 11:15 AM, Markus Armbruster wrote:
>> Steven Sistare <steven.sistare@oracle.com> writes:
>>> On 11/15/2023 3:41 AM, Markus Armbruster wrote:
>>>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>>>
>>>>> On Fri, Nov 03, 2023 at 03:51:00PM -0400, Steven Sistare wrote:
>>>>>> On 11/3/2023 1:33 PM, Daniel P. Berrang=C3=A9 wrote:
>>>>>>> On Fri, Nov 03, 2023 at 09:01:29AM -0700, Steve Sistare wrote:
>>>>>>>> Buffered monitor output is lost when abort() is called.  The patte=
rn
>>>>>>>> error_report() followed by abort() occurs about 60 times, so valua=
ble
>>>>>>>> information is being lost when the abort is called in the context =
of a
>>>>>>>> monitor command.
>>>>>>>
>>>>>>> I'm curious, was there a particular abort() scenario that you hit ?
>>>>>>
>>>>>> Yes, while tweaking the suspended state, and forgetting to add trans=
itions:
>>>>>>
>>>>>>         error_report("invalid runstate transition: '%s' -> '%s'",
>>>>>>         abort();
>>>>>>
>>>>>> But I have previously hit this for other errors.
>>>>
>>>> Can you provide a reproducer?
>>>
>>> I sometimes hit this when developing new code.  I do not have a reprodu=
cer for upstream
>>> branches. The patch is aimed at helping developers, not users.
>>=20
>> I'm asking because I can't see how the error message could be lost.  A
>> reproducer would let me find out.  "Apply this set of broken patches,
>> then do that" would serve.
>
> $ patch -p1 << EOF
> diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
> index b0f948d..c9a3aee 100644
> --- a/monitor/qmp-cmds.c
> +++ b/monitor/qmp-cmds.c
> @@ -47,8 +47,12 @@ void qmp_quit(Error **errp)
>      qemu_system_shutdown_request(SHUTDOWN_CAUSE_HOST_QMP_QUIT);
>  }
>
> +#include "qemu/error-report.h"
> +
>  void qmp_stop(Error **errp)
>  {
> +    error_report("injected failure");
> +    abort();
>      /* if there is a dump in background, we should wait until the dump
>       * finished */
>      if (qemu_system_dump_in_progress()) {
> EOF
>
> # This example loses the error message:
>
> $ args=3D'-display none -chardev socket,id=3Dmon1,server=3Don,path=3Dmon1=
.sock,wait=3Doff -mon mon1,mode=3Dcontrol'
> $ qemu-system-x86_64 $args < /dev/null &
> [1] 18048
> $ echo '{"execute":"qmp_capabilities"} {"execute":"human-monitor-command"=
,"arguments":{"command-line":"stop"}}' | ncat -U mon1.sock
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 8}, "pack=
age": "v8.1.0-2976-g4025fde-dirty"}, "capabilities": ["oob"]}}
> {"return": {}}
> Ncat: Connection reset by peer.
> $
> [1]+  Aborted                 qemu-system-x86_64 $args < /dev/null
>
>
> # This example preserves the error message. I include it to show the ncat=
-based test is valid.
>
> $ qemu-system-x86_64 $args < /dev/null &
> [1] 18060
> $ echo '{"execute":"qmp_capabilities"} {"execute":"stop"}' | ncat -U mon1=
.sock
> {"QMP": {"version": {"qemu": {"micro": 50, "minor": 1, "major": 8}, "pack=
age": "v8.1.0-2976-g4025fde-dirty"}, "capabilities": ["oob"]}}
> {"return": {}}
> injected failure                <=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D =
qemu stderr
> Ncat: Connection reset by peer.
> $
> [1]+  Aborted                 qemu-system-x86_64 $args < /dev/null
>
> - Steve

Reproduced, thanks!

Confirms my reading of the code.  Two cases:

1. Normal monitor output

   Flushed on newline.  A partial last line can be lost on crash or
   exit().

   Works as intended.

2. Output being captured for QMP command human-monitor-command

   Never flushed.  Instead, the entire buffer is included in the
   command's success response.  Naturally there is no response on crash.

   Works as intended.

Here's how to fish unflushed output out of a core dump:

    (gdb) bt
    #0  0x00007efeba52fecc in __pthread_kill_implementation () at /lib64/li=
bc.so.6
    #1  0x00007efeba4dfab6 in raise () at /lib64/libc.so.6
    #2  0x00007efeba4c97fc in abort () at /lib64/libc.so.6
    #3  0x000055588dcc848c in qmp_stop (errp=3D0x0) at ../monitor/qmp-cmds.=
c:53
    #4  0x000055588dcc36ab in hmp_stop (mon=3D0x7ffc01d47cc0, qdict=3D0x555=
891d19200)
        at ../monitor/hmp-cmds.c:119
    #5  0x000055588dcc714e in handle_hmp_command_exec
        (mon=3D0x7ffc01d47cc0, cmd=3D0x55588f0689d0 <hmp_cmds+7760>, qdict=
=3D0x555891d19200) at ../monitor/hmp.c:1106
    #6  0x000055588dcc737b in handle_hmp_command
        (mon=3D0x7ffc01d47cc0, cmdline=3D0x7efea80036f4 "") at ../monitor/h=
mp.c:1158
    #7  0x000055588dcc8922 in qmp_human_monitor_command
        (command_line=3D0x7efea80036f0 "stop", has_cpu_index=3Dfalse, cpu_i=
ndex=3D0, errp=3D0x7ffc01d47dd0) at ../monitor/qmp-cmds.c:184

    [...]

    (gdb) up 4
    #4  0x000055588dcc36ab in hmp_stop (mon=3D0x7ffc01d47cc0, qdict=3D0x555=
891d19200)
        at ../monitor/hmp-cmds.c:119
    119	    qmp_stop(NULL);
    (gdb) p mon->outbuf
    $1 =3D (GString *) 0x555890a65260
    (gdb) p *$
    $2 =3D {str =3D 0x7efea8002c00 "injected failure\r\n", len =3D 18,=20
      allocated_len =3D 128}


