Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C2A1706763
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 14:01:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzFoR-0003eR-PO; Wed, 17 May 2023 07:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzFoP-0003eC-Pv
 for qemu-devel@nongnu.org; Wed, 17 May 2023 07:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1pzFoO-0001UG-6h
 for qemu-devel@nongnu.org; Wed, 17 May 2023 07:59:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684324758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSoSaR/bw/tJAQmzXsG7nWUlLp7d5xTh/FIoiv+XkLs=;
 b=QIw3fJGrrX2jVEi6B+mIX+gmyXBGbEZcDbKrm2tJp6rLfnRoc5CXJ5WvMNcGbVsXW1AtuT
 ztegM6AFvh5VJJ2S5ufI+ueyWwjLAGY7pvo9suhj2hTQ2cHZfEU6H9SEk4ZMkd9bUxTxnr
 s6GCg63OJt3183/r43ZYalKz1BbXQfk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-643-9Gim4-5_N6uu9Ja9QMupfg-1; Wed, 17 May 2023 07:59:15 -0400
X-MC-Unique: 9Gim4-5_N6uu9Ja9QMupfg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3715F185A78B;
 Wed, 17 May 2023 11:59:15 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.91])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EA3F240C6EC4;
 Wed, 17 May 2023 11:59:14 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DE3AB21E6697; Wed, 17 May 2023 13:59:13 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Denis Plotnikov <den-plotnikov@yandex-team.ru>
Cc: qemu-devel@nongnu.org,  yc-core@yandex-team.ru,
 vsementsov@yandex-team.ru,  berrange@redhat.com, marcandre.lureau@gmail.com
Subject: Re: [PATCH v5] qapi/qmp: Add timestamps to qmp command responses
References: <20230426140839.72223-1-den-plotnikov@yandex-team.ru>
Date: Wed, 17 May 2023 13:59:13 +0200
In-Reply-To: <20230426140839.72223-1-den-plotnikov@yandex-team.ru> (Denis
 Plotnikov's message of "Wed, 26 Apr 2023 17:08:39 +0300")
Message-ID: <87bkij419q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Denis Plotnikov <den-plotnikov@yandex-team.ru> writes:

> Add "start" & "end" time values to QMP command responses.
>
> These time values are added to let the qemu management layer get the exact
> command execution time without any other time variance which might be bro=
ught
> by other parts of management layer or qemu internals.
> This helps to look for problems poactively from the management layer side.

proactively

> The management layer would be able to detect problem cases by calculating
> QMP command execution time:
> 1. execution_time_from_mgmt_perspective -
>        execution_time_of_qmp_command > some_threshold
>    This detects problems with management layer or internal qemu QMP comma=
nd
>    dispatching
> 2. current_qmp_command_execution_time > avg_qmp_command_execution_time
>    This detects that a certain QMP command starts to execute longer than
>    usual
> In both these cases more thorough investigation of the root cases should =
be
> done by using some qemu tracepoints depending on particular QMP command u=
nder
> investigation or by other means. The timestamps help to avoid excessive l=
og
> output when qemu tracepoints are used to address similar cases.
>
> Example of result:
>
>     ./qemu/scripts/qmp/qmp-shell /tmp/qmp.socket
>
>     (QEMU) query-status
>     {"end": {"seconds": 1650367305, "microseconds": 831032},
>      "start": {"seconds": 1650367305, "microseconds": 831012},
>      "return": {"status": "running", "singlestep": false, "running": true=
}}
>
> The response of the QMP command contains the start & end time of
> the QMP command processing.
>
> Also, "start" & "end" timestaps are added to qemu guest agent responses as
> qemu-ga shares the same code for request dispatching.
>
> Suggested-by: Andrey Ryabinin <arbn@yandex-team.ru>
> Signed-off-by: Denis Plotnikov <den-plotnikov@yandex-team.ru>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

In review of v3, I asked you to address the following points in the
commit message:

1. Why tracepoints can't do the job

2. Why client-side logging can't do the job

3. Why of all the possible points of interest in a QMP command's flow
   through QEMU, you're picking these two.

If I remember correctly, 1. was discussed during review.  Okay, but you
still need to capture the argument here.

I don't think I've seen answers to 2. or 3. so far.

The management application already knows the time it sends a command and
the time it receives its respose.

The time delta consists of:

1. Network transmission from management application to QEMU

   Hopefully trivial for AF_UNIX, except when suspended.

2. Schedule callbacks from main loop, read from socket

3. Parse received text as JSON into QObject

   Continue to next step only when a complete JSON value is parsed.

4. Queue command (unless command is to be executed out-of-band)

   Takes global monitor lock.  Suspends the monitor when the queue is
   full.

5. Dequeue command (if in-band)

   Takes global monitor lock.  Resumes a suspended monitor.

6. Dispatch command

   Schedules a bottom half in the common case (in-band, not
   coroutine-capable).

7. Unmarshal command arguments from QObject into QAPI C types

8. Execute command handler

9. Marshal command return value from QAPI C type into QObject

10. Wait for bottom half (if used)

11. Marshal response QObject

12. Format response QObject as JSON

13. Queue response text

14. Write out queue to the socket

15. Network transmission from QEMU to management application

Client-side logging can give us time of the first and the last step.

The timestamps you propose are at the beginning of step 6 and the end of
step 11.  They exclude network transmission, some of the marshaling /
unmarshalling, and some of the internal thread synchronization and
scheduling.  Why pick these points?  Why not, for instance, beginning
and end of step 8?  I'm not proposing to do that instead, I'm asking for
rationale!


