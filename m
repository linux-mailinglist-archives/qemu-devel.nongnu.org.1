Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D42381D28B
	for <lists+qemu-devel@lfdr.de>; Sat, 23 Dec 2023 06:43:27 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGulq-0004xe-CX; Sat, 23 Dec 2023 00:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGuln-0004x9-PZ
 for qemu-devel@nongnu.org; Sat, 23 Dec 2023 00:41:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rGull-00083I-0b
 for qemu-devel@nongnu.org; Sat, 23 Dec 2023 00:41:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703310111;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GS96X8qOc6/Bn0+JhACnt5sIUiP+b4w6+0Hm8a9ctzs=;
 b=PpaDmkvVTDuabgRRdnXbliYsE97oiUHs88t9d1QGP2z4Z4BK7JGy8prjL902Tjn5cRBV8E
 AtKgU3VVNjmLEX6NssKNryvRotHcype2586CY3drof4tlRMoir/ktmklejdm/b91YOcQJw
 vSpmRiuKM+N3k8q39jOzEFrpGGHGqhA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-S1iFWfl3N2azg6tkHjkWSQ-1; Sat, 23 Dec 2023 00:41:47 -0500
X-MC-Unique: S1iFWfl3N2azg6tkHjkWSQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D8998350E1;
 Sat, 23 Dec 2023 05:41:47 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.129])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 056922166B31;
 Sat, 23 Dec 2023 05:41:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id DB95821E6920; Sat, 23 Dec 2023 06:41:45 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH V6 03/14] cpus: stop vm in suspended runstate
In-Reply-To: <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com> (Steven
 Sistare's message of "Fri, 22 Dec 2023 10:53:24 -0500")
References: <1701380247-340457-1-git-send-email-steven.sistare@oracle.com>
 <1701380247-340457-4-git-send-email-steven.sistare@oracle.com>
 <87bkaiig2s.fsf@pond.sub.org>
 <9d613137-24aa-4323-aee1-0d38b91339c5@oracle.com>
Date: Sat, 23 Dec 2023 06:41:45 +0100
Message-ID: <87sf3ta31i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

Steven Sistare <steven.sistare@oracle.com> writes:

> On 12/22/2023 7:20 AM, Markus Armbruster wrote:
>> Steve Sistare <steven.sistare@oracle.com> writes:
>> 
>>> Currently, a vm in the suspended state is not completely stopped.  The VCPUs
>>> have been paused, but the cpu clock still runs, and runstate notifiers for
>>> the transition to stopped have not been called.  This causes problems for
>>> live migration.  Stale cpu timers_state is saved to the migration stream,
>>> causing time errors in the guest when it wakes from suspend, and state that
>>> would have been modified by runstate notifiers is wrong.
>>>
>>> Modify vm_stop to completely stop the vm if the current state is suspended,
>>> transition to RUN_STATE_PAUSED, and remember that the machine was suspended.
>>> Modify vm_start to restore the suspended state.
>> 
>> Can you explain this to me in terms of the @current_run_state state
>> machine?  Like
>> 
>>     Before the patch, trigger X in state Y goes to state Z.
>>     Afterwards, it goes to ...
>
> Old behavior:
>   RUN_STATE_SUSPENDED --> stop --> RUN_STATE_SUSPENDED
>
> New behavior:
>   RUN_STATE_SUSPENDED --> stop --> RUN_STATE_PAUSED
>   RUN_STATE_PAUSED    --> cont --> RUN_STATE_SUSPENDED

This clarifies things quite a bit for me.  Maybe work it into the commit
message?

>>> This affects all callers of vm_stop and vm_start, notably, the qapi stop and
>>> cont commands.  For example:
>>>
>>>     (qemu) info status
>>>     VM status: paused (suspended)
>>>
>>>     (qemu) stop
>>>     (qemu) info status
>>>     VM status: paused
>>>
>>>     (qemu) cont
>>>     (qemu) info status
>>>     VM status: paused (suspended)
>>>
>>>     (qemu) system_wakeup
>>>     (qemu) info status
>>>     VM status: running
>>>
>>> Suggested-by: Peter Xu <peterx@redhat.com>
>>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>>> ---
>>>  include/sysemu/runstate.h |  5 +++++
>>>  qapi/misc.json            | 10 ++++++++--
>>>  system/cpus.c             | 19 ++++++++++++++-----
>>>  system/runstate.c         |  3 +++
>>>  4 files changed, 30 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
>>> index f6a337b..1d6828f 100644
>>> --- a/include/sysemu/runstate.h
>>> +++ b/include/sysemu/runstate.h
>>> @@ -40,6 +40,11 @@ static inline bool shutdown_caused_by_guest(ShutdownCause cause)
>>>      return cause >= SHUTDOWN_CAUSE_GUEST_SHUTDOWN;
>>>  }
>>>  
>>> +static inline bool runstate_is_started(RunState state)
>>> +{
>>> +    return state == RUN_STATE_RUNNING || state == RUN_STATE_SUSPENDED;
>>> +}
>>> +
>>>  void vm_start(void);
>>>  
>>>  /**
>>> diff --git a/qapi/misc.json b/qapi/misc.json
>>> index cda2eff..efb8d44 100644
>>> --- a/qapi/misc.json
>>> +++ b/qapi/misc.json
>>> @@ -134,7 +134,7 @@
>>>  ##
>>>  # @stop:
>>>  #
>>> -# Stop all guest VCPU execution.
>>> +# Stop all guest VCPU and VM execution.
>> 
>> Doesn't "stop all VM execution" imply "stop all guest vCPU execution"?
>
> Agreed, so we simply have:
>
> # @stop:
> # Stop guest VM execution.
>
> # @cont:
> # Resume guest VM execution.

Yes, please.

>>>  #
>>>  # Since: 0.14
>>>  #
>>> @@ -143,6 +143,9 @@
>>    # Notes: This function will succeed even if the guest is already in
>>    #     the stopped state.  In "inmigrate" state, it will ensure that
>>>  #     the guest remains paused once migration finishes, as if the -S
>>>  #     option was passed on the command line.
>>>  #
>>> +#     In the "suspended" state, it will completely stop the VM and
>>> +#     cause a transition to the "paused" state. (Since 9.0)
>>> +#
>> 
>> What user-observable (with query-status) state transitions are possible
>> here?
>
> {"status": "suspended", "singlestep": false, "running": false}
> --> stop -->
> {"status": "paused", "singlestep": false, "running": false}
>
>>>  # Example:
>>>  #
>>>  # -> { "execute": "stop" }
>>> @@ -153,7 +156,7 @@
>>>  ##
>>>  # @cont:
>>>  #
>>> -# Resume guest VCPU execution.
>>> +# Resume guest VCPU and VM execution.
>>>  #
>>>  # Since: 0.14
>>>  #
>>> @@ -165,6 +168,9 @@
>>    # Returns: If successful, nothing
>>    #
>>    # Notes: This command will succeed if the guest is currently running.
>>    #     It will also succeed if the guest is in the "inmigrate" state;
>>    #     in this case, the effect of the command is to make sure the
>>>  #     guest starts once migration finishes, removing the effect of the
>>>  #     -S command line option if it was passed.
>>>  #
>>> +#     If the VM was previously suspended, and not been reset or woken,
>>> +#     this command will transition back to the "suspended" state. (Since 9.0)
>> 
>> Long line.
>
> It fits in 80 columns, but perhaps this looks nicer:
>
> #     If the VM was previously suspended, and not been reset or woken,
> #     this command will transition back to the "suspended" state.
> #     (Since 9.0)

It does :)

docs/devel/qapi-code-gen.rst section "Documentation markup":

    For legibility, wrap text paragraphs so every line is at most 70
    characters long.

>> What user-observable state transitions are possible here?
>
> {"status": "paused", "singlestep": false, "running": false}
> --> cont -->
> {"status": "suspended", "singlestep": false, "running": false}
>
>>> +#
>>>  # Example:
>>>  #
>>>  # -> { "execute": "cont" }
>> 
>> Should we update documentation of query-status, too?
>
> IMO no. The new behavior changes the status/RunState field only, and the
> domain of values does not change, only the transitions caused by the commands
> described here.

I see.

But if we change the stop's and cont's description from "guest VCPU
execution" to "guest VM execution", maybe we want to change
query-status's from "Information about VCPU run state" to "Information
about VM run state.

> - Steve
>
>>    ##
>>    # @StatusInfo:
>>    #
>>    # Information about VCPU run state
>>    #
>>    # @running: true if all VCPUs are runnable, false if not runnable
>>    #
>>    # @singlestep: true if using TCG with one guest instruction per
>>    #     translation block
>>    #
>>    # @status: the virtual machine @RunState
>>    #
>>    # Features:
>>    #
>>    # @deprecated: Member 'singlestep' is deprecated (with no
>>    #     replacement).
>>    #
>>    # Since: 0.14
>>    #
>>    # Notes: @singlestep is enabled on the command line with '-accel
>>    #     tcg,one-insn-per-tb=on', or with the HMP 'one-insn-per-tb'
>>    #     command.
>>    ##
>>    { 'struct': 'StatusInfo',
>>      'data': {'running': 'bool',
>>               'singlestep': { 'type': 'bool', 'features': [ 'deprecated' ]},
>>               'status': 'RunState'} }
>> 
>>    ##
>>    # @query-status:
>>    #
>>    # Query the run status of all VCPUs
>>    #
>>    # Returns: @StatusInfo reflecting all VCPUs
>>    #
>>    # Since: 0.14
>>    #
>>    # Example:
>>    #
>>    # -> { "execute": "query-status" }
>>    # <- { "return": { "running": true,
>>    #                  "singlestep": false,
>>    #                  "status": "running" } }
>>    ##
>>    { 'command': 'query-status', 'returns': 'StatusInfo',
>>      'allow-preconfig': true }
>> 
>> [...]


