Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED857F1E28
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 21:48:47 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r5BAl-0000MO-UA; Mon, 20 Nov 2023 15:47:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r5BAk-0000MC-OQ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 15:47:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r5BAg-0005i2-JU
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 15:47:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 959621F8A3;
 Mon, 20 Nov 2023 20:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700513224; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Bki/zjuQo7vXeNf7dD5mxYffuygWovlM9h2hNQpLu8=;
 b=p/2PlTr7NIp80l3vuY8P1ahlaaX8oSQzVtgtHC4vmBcoUTCTScCpi9zEPzQJO7tq8EizKq
 hutSsvQvlfJgZyRtoZO+u44QMfW2ertxmwIw5CWyh/UtRx3kWqLcLkE+Rc857qGESEA/Va
 sHVRnCGNc9XCABdqjjWYbb0vP5HKR1g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700513224;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9Bki/zjuQo7vXeNf7dD5mxYffuygWovlM9h2hNQpLu8=;
 b=W7SV153gjo3xFJiQIRzG1Fh1eJyZ6TWjqioBz/ghMdNNsQtKTeNpfe+xwp0WiuJFP+iAi6
 rE3V0Zqwsm20mFAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2D9F613499;
 Mon, 20 Nov 2023 20:47:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kfx6OsfFW2VnbgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 20 Nov 2023 20:47:03 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
In-Reply-To: <ZVu6ohk8_8xzyL-x@x1n>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
 <ZVu6ohk8_8xzyL-x@x1n>
Date: Mon, 20 Nov 2023 17:47:01 -0300
Message-ID: <87zfz840fu.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.14
X-Spamd-Result: default: False [-1.14 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[19.07%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.04)[-0.222]; RCPT_COUNT_SEVEN(0.00)[8];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Mon, Nov 13, 2023 at 10:33:50AM -0800, Steve Sistare wrote:
>> A vm in the suspended state is not completely stopped.  The VCPUs have been
>> paused, but the cpu clock still runs, and runstate notifiers for the
>> transition to stopped have not been called.  Modify vm_stop_force_state to
>> completely stop the vm if the current state is suspended, to be called for
>> live migration and snapshots.
>> 
>> Suggested-by: Peter Xu <peterx@redhat.com>
>> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
>> ---
>>  system/cpus.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>> 
>> diff --git a/system/cpus.c b/system/cpus.c
>> index f72c4be..c772708 100644
>> --- a/system/cpus.c
>> +++ b/system/cpus.c
>> @@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
>>  static int do_vm_stop(RunState state, bool send_stop, bool force)
>>  {
>>      int ret = 0;
>> +    bool running = runstate_is_running();
>> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
>>  
>>      if (qemu_in_vcpu_thread()) {
>>          qemu_system_vmstop_request_prepare();
>> @@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
>>          return 0;
>>      }
>>  
>> -    if (runstate_is_running()) {
>> +    if (running || (suspended && force)) {
>>          runstate_set(state);
>>          cpu_disable_ticks();
>
> Not directly relevant, but this is weird that I just notice.
>
> If we disable ticks before stopping vCPUs, IIUC it means vcpus can see
> stall ticks.  I checked the vm_start() and indeed that one did it in the
> other way round: we'll stop vCPUs before stopping the ticks.
>
>> -        pause_all_vcpus();
>> +        if (running) {
>> +            pause_all_vcpus();
>> +        }
>>          vm_state_notify(0, state);
>>          if (send_stop) {
>>              qapi_event_send_stop();
>
> IIUC the "force" is not actually needed.  It's only used when SUSPENDED,
> right?

That's the overloading I'm complaining about. We're using "force" to say
both: "include suspended" and: "set the state". This is basically taking
knowledge from the callsite being the migration code and encoding it in
that flag.

I'd prefer something like:

static int do_vm_stop(RunState state, bool send_stop, bool set_state,
                      bool include_suspended);


