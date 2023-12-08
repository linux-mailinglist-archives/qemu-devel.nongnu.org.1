Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48DF480A957
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 17:38:38 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBdqt-0000T3-PR; Fri, 08 Dec 2023 11:37:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBdqq-0000Qk-1W
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 11:37:20 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rBdqo-0004dq-7N
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 11:37:19 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0E52321C90;
 Fri,  8 Dec 2023 16:37:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702053435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DasXawo5e673AVjZNF2CiNGwB0hRQYG1MCo80/1KNVY=;
 b=dqrURRA0xlvHVlo5qC2yguaR+JSBjBRA9a3Gg0iBui2UZXjlQbKboNG/APriFr/BsTg0c2
 7SwtcPUkaoXK0suoZq1OhP/+00oEFEonVJDHdEX40aBxEESTjsCeo31ekGVR2+6CwRpO0o
 wrkJMMk76xiKBqQyp2jKFicClW2EcnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702053435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DasXawo5e673AVjZNF2CiNGwB0hRQYG1MCo80/1KNVY=;
 b=x0vSPM4gpMvdcQOFzaDEYQ9nv1EzlYsmSucaSHduqLv7yuBKqH+sAJT0p4gXNB9NjmFiW6
 i8XfKSJ/yjBaHbBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1702053435; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DasXawo5e673AVjZNF2CiNGwB0hRQYG1MCo80/1KNVY=;
 b=dqrURRA0xlvHVlo5qC2yguaR+JSBjBRA9a3Gg0iBui2UZXjlQbKboNG/APriFr/BsTg0c2
 7SwtcPUkaoXK0suoZq1OhP/+00oEFEonVJDHdEX40aBxEESTjsCeo31ekGVR2+6CwRpO0o
 wrkJMMk76xiKBqQyp2jKFicClW2EcnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1702053435;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DasXawo5e673AVjZNF2CiNGwB0hRQYG1MCo80/1KNVY=;
 b=x0vSPM4gpMvdcQOFzaDEYQ9nv1EzlYsmSucaSHduqLv7yuBKqH+sAJT0p4gXNB9NjmFiW6
 i8XfKSJ/yjBaHbBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D1A512FF7;
 Fri,  8 Dec 2023 16:37:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RVI7FTpGc2XaDgAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 08 Dec 2023 16:37:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V7 05/12] migration: propagate suspended runstate
In-Reply-To: <1701883417-356268-6-git-send-email-steven.sistare@oracle.com>
References: <1701883417-356268-1-git-send-email-steven.sistare@oracle.com>
 <1701883417-356268-6-git-send-email-steven.sistare@oracle.com>
Date: Fri, 08 Dec 2023 13:37:12 -0300
Message-ID: <87wmtoy7k7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[28.27%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[9];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -0.30
Authentication-Results: smtp-out1.suse.de;
	none
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
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

> If the outgoing machine was previously suspended, propagate that to the
> incoming side via global_state, so a subsequent vm_start restores the
> suspended state.  To maintain backward and forward compatibility, reclaim
> some space from the runstate member.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  migration/global_state.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)
>
> diff --git a/migration/global_state.c b/migration/global_state.c
> index 4e2a9d8..d4f61a1 100644
> --- a/migration/global_state.c
> +++ b/migration/global_state.c
> @@ -22,7 +22,16 @@
>  
>  typedef struct {
>      uint32_t size;
> -    uint8_t runstate[100];
> +
> +    /*
> +     * runstate was 100 bytes, zero padded, but we trimmed it to add a
> +     * few fields and maintain backwards compatibility.
> +     */
> +    uint8_t runstate[32];
> +    uint8_t has_vm_was_suspended;
> +    uint8_t vm_was_suspended;
> +    uint8_t unused[66];
> +
>      RunState state;
>      bool received;
>  } GlobalState;
> @@ -35,6 +44,10 @@ static void global_state_do_store(RunState state)
>      assert(strlen(state_str) < sizeof(global_state.runstate));
>      strpadcpy((char *)global_state.runstate, sizeof(global_state.runstate),
>                state_str, '\0');
> +    global_state.has_vm_was_suspended = true;
> +    global_state.vm_was_suspended = vm_get_suspended();
> +
> +    memset(global_state.unused, 0, sizeof(global_state.unused));
>  }
>  
>  void global_state_store(void)
> @@ -68,6 +81,12 @@ static bool global_state_needed(void *opaque)
>          return true;
>      }
>  
> +    /* If the suspended state must be remembered, it is needed */
> +
> +    if (vm_get_suspended()) {
> +        return true;
> +    }
> +
>      /* If state is running or paused, it is not needed */
>  
>      if (strcmp(runstate, "running") == 0 ||
> @@ -85,6 +104,7 @@ static int global_state_post_load(void *opaque, int version_id)
>      Error *local_err = NULL;
>      int r;
>      char *runstate = (char *)s->runstate;
> +    bool vm_was_suspended = s->has_vm_was_suspended && s->vm_was_suspended;

Why do you need has_vm_was_suspended? If they're always read like this,
then one flag should do, no?

>  
>      s->received = true;
>      trace_migrate_global_state_post_load(runstate);
> @@ -93,7 +113,7 @@ static int global_state_post_load(void *opaque, int version_id)
>                  sizeof(s->runstate)) == sizeof(s->runstate)) {
>          /*
>           * This condition should never happen during migration, because
> -         * all runstate names are shorter than 100 bytes (the size of
> +         * all runstate names are shorter than 32 bytes (the size of
>           * s->runstate). However, a malicious stream could overflow
>           * the qapi_enum_parse() call, so we force the last character
>           * to a NUL byte.
> @@ -110,6 +130,14 @@ static int global_state_post_load(void *opaque, int version_id)
>      }
>      s->state = r;
>  
> +    /*
> +     * global_state is saved on the outgoing side before forcing a stopped
> +     * state, so it may have saved state=suspended and vm_was_suspended=0.
> +     * Now we are in a paused state, and when we later call vm_start, it must
> +     * restore the suspended state, so we must set vm_was_suspended=1 here.
> +     */
> +    vm_set_suspended(vm_was_suspended || r == RUN_STATE_SUSPENDED);
> +
>      return 0;
>  }
>  
> @@ -134,6 +162,9 @@ static const VMStateDescription vmstate_globalstate = {
>      .fields = (VMStateField[]) {
>          VMSTATE_UINT32(size, GlobalState),
>          VMSTATE_BUFFER(runstate, GlobalState),
> +        VMSTATE_UINT8(has_vm_was_suspended, GlobalState),
> +        VMSTATE_UINT8(vm_was_suspended, GlobalState),
> +        VMSTATE_BUFFER(unused, GlobalState),
>          VMSTATE_END_OF_LIST()
>      },
>  };

