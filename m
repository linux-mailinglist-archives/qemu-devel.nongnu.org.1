Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A760804FDC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Dec 2023 11:10:24 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rASNU-0006Pk-Pl; Tue, 05 Dec 2023 05:10:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rASNS-0006PI-8R
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 05:10:06 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rASNQ-0001s4-Ob
 for qemu-devel@nongnu.org; Tue, 05 Dec 2023 05:10:05 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95C901FB86;
 Tue,  5 Dec 2023 10:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701771000; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlMBlmMVQDhfJK4oW9jmBohXdifPev0Ysiee1WdHbTc=;
 b=fp+zflDXOgy2lTgRr3Nu49Tlbl2IiUUyI6lJScsVPoPpCk9M8qP2/4D7k/ON5BKtKGQX1/
 kOhNWTswioLmqW/pilt5AoJ2hNq9RwwuaV1b0OW2W+fcuysCOh6T+0EJ0hyZ8FQnMxI6xq
 K1IHQ3DSIS1Xr69BwhiKwPaibrtQCGI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701771000;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wlMBlmMVQDhfJK4oW9jmBohXdifPev0Ysiee1WdHbTc=;
 b=8nTU5BUanUmO4nHkQbChc/4KWt0z8JYnjGXBNjU3vSpUjVazGUqT8z/WVyOn0OZs6fsdm/
 7q82PAtg00Cf44DQ==
Date: Tue, 5 Dec 2023 11:09:59 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Message-ID: <20231205100959.GB9696@kitsune.suse.cz>
References: <20231204194039.56169-1-philmd@linaro.org>
 <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
 <20231204200937.GA9696@kitsune.suse.cz>
 <caa90c99-aada-467b-a005-84642cd55a86@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <caa90c99-aada-467b-a005-84642cd55a86@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-1.30 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_LONG(-1.00)[-1.000]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.999];
 DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,linaro.org,nongnu.org,redhat.com];
 BAYES_HAM(-0.00)[17.21%]; SUBJECT_HAS_QUESTION(0.00)[]
X-Spam-Score: -1.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=msuchanek@suse.de; helo=smtp-out2.suse.de
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

On Mon, Dec 04, 2023 at 03:02:45PM -0800, Richard Henderson wrote:
> On 12/4/23 12:09, Michal Suchánek wrote:
> > On Mon, Dec 04, 2023 at 02:50:17PM -0500, Stefan Hajnoczi wrote:
> > > On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > > +void tcg_unregister_thread(void)
> > > > +{
> > > > +    unsigned int n;
> > > > +
> > > > +    n = qatomic_fetch_dec(&tcg_cur_ctxs);
> > > > +    g_free(tcg_ctxs[n]);
> > > > +    qatomic_set(&tcg_ctxs[n], NULL);
> > > > +}
> > > 
> > > tcg_ctxs[n] may not be our context, so this looks like it could free
> > > another thread's context and lead to undefined behavior.
> 
> Correct.
> 
> > There is cpu->thread_id so perhaps cpu->thread_ctx could be added as
> > well. That would require a bitmap of used threads contexts rather than a
> > counter, though.
> 
> Or don't free the context at all, but re-use it when incrementing and
> tcg_ctxs[n] != null (i.e. plugging in a repacement vcpu).  After all, there
> can only be tcg_max_ctxs contexts.

But you would not know which contexts are in use and which aren't without
tracking the association of contexts to CPUs.

Unless there is a cpu array somewhere and you can use the same index for
both to create the association.

Thanks

Michal

