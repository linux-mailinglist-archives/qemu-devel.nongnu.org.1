Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6EC7803F09
	for <lists+qemu-devel@lfdr.de>; Mon,  4 Dec 2023 21:10:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAFGD-0004Hh-Dt; Mon, 04 Dec 2023 15:09:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rAFGA-0004HJ-Cy
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 15:09:42 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rAFG8-00035p-Gh
 for qemu-devel@nongnu.org; Mon, 04 Dec 2023 15:09:42 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 994791FE71;
 Mon,  4 Dec 2023 20:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701720578; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYyhhgoYB5hBo4Ih4qm3w3HCLLiPeY4GWRU6HmpHRls=;
 b=OAi0dxierpG9AWX3dwWfJFEnzYWB+l1gXFoYkhf4ktq/xsUfQYaISLwM5EZeZenmdIRg+D
 IiupsQXkKMFrf4p1AHo3ceIekI1d2vmFi4UbWCQuQ34X+FDzUceMkzu38r7EpWAlKiLz+H
 TSbOVxIvSoOrbhPn/JeiYQ++IlSp8Sk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701720578;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aYyhhgoYB5hBo4Ih4qm3w3HCLLiPeY4GWRU6HmpHRls=;
 b=hYLB8bIqV06dXdb9Uqnawmlg1tg6hqoyrT9e4rK3SJM1f+WN+xtAiOOgD9J88rTCBlA+xx
 ouQy1jPcY37KL/Cg==
Date: Mon, 4 Dec 2023 21:09:37 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Message-ID: <20231204200937.GA9696@kitsune.suse.cz>
References: <20231204194039.56169-1-philmd@linaro.org>
 <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -4.10
X-Spamd-Result: default: False [-4.10 / 50.00]; ARC_NA(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FREEMAIL_TO(0.00)[gmail.com]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FUZZY_BLOCKED(0.00)[rspamd.com]; SUBJECT_HAS_QUESTION(0.00)[]
Received-SPF: pass client-ip=195.135.223.131; envelope-from=msuchanek@suse.de;
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

On Mon, Dec 04, 2023 at 02:50:17PM -0500, Stefan Hajnoczi wrote:
> On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> >
> > Unplugging vCPU triggers the following assertion in
> 
> Unplugging leaks the tcg context refcount but does not trigger the
> assertion directly. Maybe clarify that by changing the wording:
> 
> "Plugging a vCPU after it has been unplugged triggers..."
> 
> > tcg_register_thread():
> >
> >  796 void tcg_register_thread(void)
> >  797 {
> >  ...
> >  812     /* Claim an entry in tcg_ctxs */
> >  813     n = qatomic_fetch_inc(&tcg_cur_ctxs);
> >  814     g_assert(n < tcg_max_ctxs);
> >
> > Implement and use tcg_unregister_thread() so when a
> > vCPU is unplugged, the tcg_cur_ctxs refcount is
> > decremented.
> >
> > Reported-by: Michal Suchánek <msuchanek@suse.de>
> > Suggested-by: Stefan Hajnoczi <stefanha@gmail.com>
> > Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> > ---
> > RFC: untested
> > Report: https://lore.kernel.org/qemu-devel/20231204183638.GZ9696@kitsune.suse.cz/
> > ---
> >  include/tcg/startup.h           |  5 +++++
> >  accel/tcg/tcg-accel-ops-mttcg.c |  1 +
> >  accel/tcg/tcg-accel-ops-rr.c    |  1 +
> >  tcg/tcg.c                       | 17 +++++++++++++++++
> >  4 files changed, 24 insertions(+)
> >
> > diff --git a/include/tcg/startup.h b/include/tcg/startup.h
> > index f71305765c..520942a4a1 100644
> > --- a/include/tcg/startup.h
> > +++ b/include/tcg/startup.h
> > @@ -45,6 +45,11 @@ void tcg_init(size_t tb_size, int splitwx, unsigned max_cpus);
> >   */
> >  void tcg_register_thread(void);
> >
> > +/**
> > + * tcg_unregister_thread: Unregister this thread with the TCG runtime
> > + */
> > +void tcg_unregister_thread(void);
> > +
> >  /**
> >   * tcg_prologue_init(): Generate the code for the TCG prologue
> >   *
> > diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-mttcg.c
> > index fac80095bb..88d7427aad 100644
> > --- a/accel/tcg/tcg-accel-ops-mttcg.c
> > +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> > @@ -120,6 +120,7 @@ static void *mttcg_cpu_thread_fn(void *arg)
> >
> >      tcg_cpus_destroy(cpu);
> >      qemu_mutex_unlock_iothread();
> > +    tcg_unregister_thread();
> >      rcu_remove_force_rcu_notifier(&force_rcu.notifier);
> >      rcu_unregister_thread();
> >      return NULL;
> > diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
> > index 611932f3c3..c2af3aad21 100644
> > --- a/accel/tcg/tcg-accel-ops-rr.c
> > +++ b/accel/tcg/tcg-accel-ops-rr.c
> > @@ -302,6 +302,7 @@ static void *rr_cpu_thread_fn(void *arg)
> >          rr_deal_with_unplugged_cpus();
> >      }
> >
> > +    tcg_unregister_thread();
> >      rcu_remove_force_rcu_notifier(&force_rcu);
> >      rcu_unregister_thread();
> >      return NULL;
> > diff --git a/tcg/tcg.c b/tcg/tcg.c
> > index d2ea22b397..5125342d70 100644
> > --- a/tcg/tcg.c
> > +++ b/tcg/tcg.c
> > @@ -781,11 +781,18 @@ static void alloc_tcg_plugin_context(TCGContext *s)
> >   * modes.
> >   */
> >  #ifdef CONFIG_USER_ONLY
> > +
> >  void tcg_register_thread(void)
> >  {
> >      tcg_ctx = &tcg_init_ctx;
> >  }
> > +
> > +void tcg_unregister_thread(void)
> > +{
> > +}
> > +
> >  #else
> > +
> >  void tcg_register_thread(void)
> >  {
> >      TCGContext *s = g_malloc(sizeof(*s));
> > @@ -814,6 +821,16 @@ void tcg_register_thread(void)
> >
> >      tcg_ctx = s;
> >  }
> > +
> > +void tcg_unregister_thread(void)
> > +{
> > +    unsigned int n;
> > +
> > +    n = qatomic_fetch_dec(&tcg_cur_ctxs);
> > +    g_free(tcg_ctxs[n]);
> > +    qatomic_set(&tcg_ctxs[n], NULL);
> > +}
> 
> tcg_ctxs[n] may not be our context, so this looks like it could free
> another thread's context and lead to undefined behavior.

There is cpu->thread_id so perhaps cpu->thread_ctx could be added as
well. That would require a bitmap of used threads contexts rather than a
counter, though.

Thanks

Michal

