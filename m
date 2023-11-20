Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3087F1582
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 15:17:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r553y-0001si-HM; Mon, 20 Nov 2023 09:15:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r553i-0001pp-P4
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:15:36 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r553g-0006Qy-UJ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 09:15:30 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5394021904;
 Mon, 20 Nov 2023 14:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700489723; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U37v592RcmqRZZHUbXX73IXh4pT7ZY9dHjeGfan+pmo=;
 b=lQsjWVPsTP3bj/SudMXXZ+N21iuaU5nKtYUIE3O1bLLFo+XD2F2b84A/HxRk6piNWIezGR
 OOYG3xRocc0JWK3eq6ltD/VoZcoG2oUS7utF8dvWX9agNkdKe+Y0Flzs7TqrIwwVYeCkA0
 IakQ3JS+p4glfHEBxEzhZT3iZ7jB6KI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700489723;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U37v592RcmqRZZHUbXX73IXh4pT7ZY9dHjeGfan+pmo=;
 b=0T2jND39q0zjPbsUnJHf3kyQ9zBmnL4vksiMhe6NuH7AUrM/PqLYKJcH8BQIwbA0Nj3tI4
 4aWoHfF5pPad5fCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CFD6013499;
 Mon, 20 Nov 2023 14:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id v4CkJvppW2VnGgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 20 Nov 2023 14:15:22 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V5 02/12] cpus: stop vm in suspended state
In-Reply-To: <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-3-git-send-email-steven.sistare@oracle.com>
Date: Mon, 20 Nov 2023 11:15:20 -0300
Message-ID: <87il5w5x53.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.30
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[43.15%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

Steve Sistare <steven.sistare@oracle.com> writes:

> A vm in the suspended state is not completely stopped.  

Is this a statement of a fact about VMs in the suspended state in
general or is this describing what this patch is trying to fix?

> The VCPUs have been paused, but the cpu clock still runs, and runstate
> notifiers for the transition to stopped have not been called.

...it reads like the latter, but then why aren't we fixing this at the
moment we put the VM in the suspend state?

> Modify vm_stop_force_state to completely stop the vm if the current
> state is suspended, to be called for live migration and snapshots.

Hm, this changes the meaning of the "force" from:

"force a state even if already stopped"

into:

"force a complete stop if already suspended, otherwise just set the
state"

I don't know what to make of this, shouldn't all vm_stops cause a
complete stop?

We need to at least resolve the overloading of the 'force' term.

>
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/cpus.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/system/cpus.c b/system/cpus.c
> index f72c4be..c772708 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -255,6 +255,8 @@ void cpu_interrupt(CPUState *cpu, int mask)
>  static int do_vm_stop(RunState state, bool send_stop, bool force)
>  {
>      int ret = 0;
> +    bool running = runstate_is_running();
> +    bool suspended = runstate_check(RUN_STATE_SUSPENDED);
>  
>      if (qemu_in_vcpu_thread()) {
>          qemu_system_vmstop_request_prepare();
> @@ -267,10 +269,12 @@ static int do_vm_stop(RunState state, bool send_stop, bool force)
>          return 0;
>      }
>  
> -    if (runstate_is_running()) {
> +    if (running || (suspended && force)) {
>          runstate_set(state);
>          cpu_disable_ticks();
> -        pause_all_vcpus();
> +        if (running) {
> +            pause_all_vcpus();
> +        }
>          vm_state_notify(0, state);
>          if (send_stop) {
>              qapi_event_send_stop();

