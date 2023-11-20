Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AED677F144E
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 14:22:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r54EM-0007dw-NP; Mon, 20 Nov 2023 08:22:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r54EF-0007di-KR
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:22:20 -0500
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r54EB-0008U6-Sq
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 08:22:17 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 05EFB1F891;
 Mon, 20 Nov 2023 13:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700486534; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kI8bvTJSKqe8Sb0SNOR9vhAbmkU/76DGMIx74ogbUf0=;
 b=ZLUH3od+R+AVCaUxl06hcUeYYAEuNuVbOIJLYvDUNGEicwFeh1TstObDl+seV3x2vz2IEu
 mI+CC38z0030HEPf6ChmUaqzozj+bNXqBIP6mFMpiEpf2mxMlTLOKnjTQ3b8Fq7jXqAcFt
 Kz1SPNn78QhZq+uqpL+KLiLzV9Zc3do=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700486534;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kI8bvTJSKqe8Sb0SNOR9vhAbmkU/76DGMIx74ogbUf0=;
 b=/oatLIV5ZEjeH3tAOCqLEwtnTYqs06EILH4HNVLLGE06vxDesCBnAjCjLax5wnLpD1VkYq
 lT8SKDVV9CbFj6BQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 92051134AD;
 Mon, 20 Nov 2023 13:22:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id zcuEF4VdW2XjeAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 20 Nov 2023 13:22:13 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V5 01/12] cpus: refactor vm_stop
In-Reply-To: <1699900440-207345-2-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-2-git-send-email-steven.sistare@oracle.com>
Date: Mon, 20 Nov 2023 10:22:11 -0300
Message-ID: <87leas5zlo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.63
X-Spamd-Result: default: False [-1.63 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.33)[75.95%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.19)[-0.968]; RCPT_COUNT_SEVEN(0.00)[9];
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

Steve Sistare <steven.sistare@oracle.com> writes:

> Refactor the vm_stop functions into one common subroutine do_vm_stop called
> with options.  No functional change.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  system/cpus.c | 44 +++++++++++++++++---------------------------
>  1 file changed, 17 insertions(+), 27 deletions(-)
>
> diff --git a/system/cpus.c b/system/cpus.c
> index 0848e0d..f72c4be 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -252,10 +252,21 @@ void cpu_interrupt(CPUState *cpu, int mask)
>      }
>  }
>  
> -static int do_vm_stop(RunState state, bool send_stop)
> +static int do_vm_stop(RunState state, bool send_stop, bool force)
>  {
>      int ret = 0;
>  
> +    if (qemu_in_vcpu_thread()) {
> +        qemu_system_vmstop_request_prepare();
> +        qemu_system_vmstop_request(state);
> +        /*
> +         * FIXME: should not return to device code in case
> +         * vm_stop() has been requested.
> +         */
> +        cpu_stop_current();
> +        return 0;
> +    }

At vm_stop_force_state(), this block used to be under
runstate_is_running(), but now it runs unconditionally.

At vm_shutdown(), this block was not executed at all, but now it is.

We might need some words to explain why this patch doesn't affect
functionality.

> +
>      if (runstate_is_running()) {
>          runstate_set(state);
>          cpu_disable_ticks();
> @@ -264,6 +275,8 @@ static int do_vm_stop(RunState state, bool send_stop)
>          if (send_stop) {
>              qapi_event_send_stop();
>          }
> +    } else if (force) {
> +        runstate_set(state);
>      }
>  
>      bdrv_drain_all();
> @@ -278,7 +291,7 @@ static int do_vm_stop(RunState state, bool send_stop)
>   */
>  int vm_shutdown(void)
>  {
> -    return do_vm_stop(RUN_STATE_SHUTDOWN, false);
> +    return do_vm_stop(RUN_STATE_SHUTDOWN, false, false);
>  }
>  
>  bool cpu_can_run(CPUState *cpu)
> @@ -656,18 +669,7 @@ void cpu_stop_current(void)
>  
>  int vm_stop(RunState state)
>  {
> -    if (qemu_in_vcpu_thread()) {
> -        qemu_system_vmstop_request_prepare();
> -        qemu_system_vmstop_request(state);
> -        /*
> -         * FIXME: should not return to device code in case
> -         * vm_stop() has been requested.
> -         */
> -        cpu_stop_current();
> -        return 0;
> -    }
> -
> -    return do_vm_stop(state, true);
> +    return do_vm_stop(state, true, false);
>  }
>  
>  /**
> @@ -723,19 +725,7 @@ void vm_start(void)
>     current state is forgotten forever */
>  int vm_stop_force_state(RunState state)
>  {
> -    if (runstate_is_running()) {
> -        return vm_stop(state);
> -    } else {
> -        int ret;
> -        runstate_set(state);
> -
> -        bdrv_drain_all();
> -        /* Make sure to return an error if the flush in a previous vm_stop()
> -         * failed. */
> -        ret = bdrv_flush_all();
> -        trace_vm_stop_flush_all(ret);
> -        return ret;
> -    }
> +    return do_vm_stop(state, true, true);
>  }
>  
>  void qmp_memsave(int64_t addr, int64_t size, const char *filename,

