Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A10B88A095
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Mar 2024 13:58:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rojt0-0000kj-SM; Mon, 25 Mar 2024 08:57:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rojsy-0000kK-HJ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rojsv-00014X-Vs
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 08:57:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711371424;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xl5I3hOhdrE4SPWwod0YbylVUbyrRQ7fEH20MbloB1Y=;
 b=fecWwC+bQNjX6bptoRvUfydj+X6rWVhXG+US0Sf4ALGlie+fgyUkJworBHSWN1yeCvcWba
 6Wi9TCPNTcaQ+GaaqSQ6BLXzr6UMfqljnooU0sNVH85A9QqCn5m6eu1R3+ROgxfFaXqD+0
 HDplHRP3PUsWQRiB4MhHsZYzojsfi1w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-gMw00uYxOAKs9tulaRQVZg-1; Mon,
 25 Mar 2024 08:57:03 -0400
X-MC-Unique: gMw00uYxOAKs9tulaRQVZg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2F8CD3CBD4E4
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:57:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 106AF40C6DB5
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 12:57:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0819C21E669D; Mon, 25 Mar 2024 13:56:42 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michal Privoznik <mprivozn@redhat.com>
Subject: Re: [PATCH] qapi: document leftover members in qapi/run-state.json
In-Reply-To: <CABgObfbDa57=+tJ_t=nFWY=CnZJq2Kkx7Wdc=PL93NB6yFVBEA@mail.gmail.com>
 (Paolo Bonzini's message of "Mon, 25 Mar 2024 13:04:14 +0100")
References: <20240325104502.1358693-1-pbonzini@redhat.com>
 <87o7b2mtki.fsf@pond.sub.org>
 <CABgObfbDa57=+tJ_t=nFWY=CnZJq2Kkx7Wdc=PL93NB6yFVBEA@mail.gmail.com>
Date: Mon, 25 Mar 2024 13:56:42 +0100
Message-ID: <87plvilbat.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> Il lun 25 mar 2024, 12:36 Markus Armbruster <armbru@redhat.com> ha scritto:
>
>> Paolo Bonzini <pbonzini@redhat.com> writes:
>>
>> > Suggested-by: Markus Armbruster <armbru@redhat.com>
>> > Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
>> > ---
>> >  qapi/run-state.json | 26 +++++++++++++++++++++++++-
>> >  1 file changed, 25 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/qapi/run-state.json b/qapi/run-state.json
>> > index 789fc34559a..cb4a2b43293 100644
>> > --- a/qapi/run-state.json
>> > +++ b/qapi/run-state.json
>> > @@ -377,9 +377,17 @@
>> >  ##
>> >  # @watchdog-set-action:
>> >  #
>> > -# Set watchdog action
>> > +# Set watchdog action.
>> > +#
>> > +# @action: @WatchdogAction action taken when watchdog timer expires.
>> >  #
>> >  # Since: 2.11
>> > +#
>> > +# Example:
>> > +#
>> > +#     -> { "execute": "watchdog-set-action",
>> > +#          "arguments": { "action": "inject-nmi" } }
>> > +#     <- { "return": {} }
>> >  ##
>> >  { 'command': 'watchdog-set-action', 'data' : {'action': 'WatchdogAction'} }
>> >
>>
>> Appreciate the example!
>
> It may even be worth deprecating the command, since action-set is a clean
> superset. But I didn't check if libvirt knows about action-set and it's
> cheap enough to implement watchdog-set-action as well.

Quick grep...  libvirt appears to use watchdog-set-action, but not
action-set.

>> @@ -505,6 +513,22 @@
>> >  #
>> >  # Hyper-V specific guest panic information (HV crash MSRs)
>> >  #
>> > +# @arg1: for Windows, STOP code for the guest crash.  For Linux,
>> > +#        an error code.
>> > +#
>> > +# @arg2: for Windows, first argument of the STOP.  For Linux, the
>> > +#        guest OS id, which has the kernel version in bits 16-47
>>
>> Mind if I capitalize ID?
>>
>
> Go ahead if you are going to queue it.

Done.

Queued, thanks!

[...]


