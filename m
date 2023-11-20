Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81547F19BB
	for <lists+qemu-devel@lfdr.de>; Mon, 20 Nov 2023 18:21:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r57x7-0007Qk-Pb; Mon, 20 Nov 2023 12:20:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r57x6-0007QO-JJ
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:20:52 -0500
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1r57x4-000553-TA
 for qemu-devel@nongnu.org; Mon, 20 Nov 2023 12:20:52 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 14A152187E;
 Mon, 20 Nov 2023 17:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1700500849; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZ4YViJVXGLz6e64NV/8t08kjICm/T4+ZBztI96hQ0Y=;
 b=J0CsJlOu+agoURTaSG7WGuo7ZWdRzpWUmXGmj3N7Tr6xgdcf/PW+pEzA6JvDf7Wuqtq38n
 roqDFXc6waQTZN6Nf4vuoMODrAQk2wezGkrikYhHW4jg9ex7kIkygJzkOEMdM01uMsBicH
 T56iQ4ExTrwkBA1hLYYSJNJfpKYqbZs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1700500849;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZ4YViJVXGLz6e64NV/8t08kjICm/T4+ZBztI96hQ0Y=;
 b=BAqm6dHzwMP7ptCW4Dr6LrDQrGOMt5CJ+9e9OKswGLYzFJFAof+mspePpETSCiWCzDZXzA
 gmq1VCLFsfyghhDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 925D0134AD;
 Mon, 20 Nov 2023 17:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id lpGDF3CVW2XZDAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 20 Nov 2023 17:20:48 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Steve Sistare <steven.sistare@oracle.com>
Subject: Re: [PATCH V5 04/12] cpus: start vm in suspended state
In-Reply-To: <1699900440-207345-5-git-send-email-steven.sistare@oracle.com>
References: <1699900440-207345-1-git-send-email-steven.sistare@oracle.com>
 <1699900440-207345-5-git-send-email-steven.sistare@oracle.com>
Date: Mon, 20 Nov 2023 14:20:46 -0300
Message-ID: <87fs105ok1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.24
X-Spamd-Result: default: False [-1.24 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.00)[34.08%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.14)[-0.694]; RCPT_COUNT_SEVEN(0.00)[9];
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

> Provide the vm_resume helper which resumes the vm in the requested state,
> correctly restoring the suspended state.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/sysemu/runstate.h |  8 ++++++++
>  system/cpus.c             | 11 +++++++++++
>  2 files changed, 19 insertions(+)
>
> diff --git a/include/sysemu/runstate.h b/include/sysemu/runstate.h
> index 9e78c7f..3fa28a4 100644
> --- a/include/sysemu/runstate.h
> +++ b/include/sysemu/runstate.h
> @@ -50,6 +50,14 @@ void vm_start(void);
>   */
>  int vm_prepare_start(bool step_pending, RunState state);
>  
> +/**
> + * vm_resume: If @state is a running state, start the vm and set the state,
> + * else just set the state.
> + *
> + * @state: the state to restore
> + */
> +void vm_resume(RunState state);
> +
>  int vm_stop(RunState state);
>  int vm_stop_force_state(RunState state);
>  int vm_shutdown(void);
> diff --git a/system/cpus.c b/system/cpus.c
> index 4d05d83..1d867bb 100644
> --- a/system/cpus.c
> +++ b/system/cpus.c
> @@ -725,6 +725,17 @@ void vm_start(void)
>      }
>  }
>  
> +void vm_resume(RunState state)
> +{
> +    if (state == RUN_STATE_RUNNING) {
> +        vm_start();
> +    } else if (state == RUN_STATE_SUSPENDED) {
> +        vm_prepare_start(false, state);
> +    } else {
> +        runstate_set(state);
> +    }
> +}
> +
>  /* does a state transition even if the VM is already stopped,
>     current state is forgotten forever */
>  int vm_stop_force_state(RunState state)

Reviewed-by: Fabiano Rosas <farosas@suse.de>

