Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A6828073AA
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:27:17 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAtmh-0002jV-Nm; Wed, 06 Dec 2023 10:25:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rAtmY-0002ig-36
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:25:51 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rAtmU-0007Yq-9Y
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:25:48 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id ACC3D1FD16;
 Wed,  6 Dec 2023 15:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701876344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdzWwIQQjd739v8vrOHVGXEi/TcgW4AJ329yxpeNHU4=;
 b=WRf+4uXhK8acJg7aJKlhZqavYHvUoAvtrmmGwci3HGa6oaSu1UgJYWI+LO5vx4Z3CkTXGR
 wjiJaKOkNuuZIntJ+AR/Nf9MZl0AlWV2xQWTk0eIfx8WL9K52o/3vI0YT5ZSLD2SYwcCmj
 VsoDijbaMNLw+hXutB0ugiISb56ns5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701876344;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bdzWwIQQjd739v8vrOHVGXEi/TcgW4AJ329yxpeNHU4=;
 b=R/iKFj12xksX9nPWA1ljctj9g6o7TFu/OK5hE+b9aHNn1B3C9QbT9ddOmMyg8eobikC0hv
 SUgKajJLLOTGclCg==
Date: Wed, 6 Dec 2023 16:25:43 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Miguel Luis <miguel.luis@oracle.com>
Cc: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Message-ID: <20231206152543.GJ9696@kitsune.suse.cz>
References: <20231204194039.56169-1-philmd@linaro.org>
 <4fd5951c-b19a-48fe-bef2-4383fcbbae46@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4fd5951c-b19a-48fe-bef2-4383fcbbae46@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -0.10
X-Spamd-Result: default: False [-0.10 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[linaro.org,nongnu.org,redhat.com,gmail.com];
 SUBJECT_HAS_QUESTION(0.00)[]
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

On Wed, Dec 06, 2023 at 01:17:08PM -0100, Miguel Luis wrote:
> Hi!
> 
> On 04/12/2023 18:40, Philippe Mathieu-Daudé wrote:
> > Unplugging vCPU triggers the following assertion in
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
> 
> 
> I've had addressed this issue before (posted at [1]) and had exercised
> it with vCPU hotplug/unplug patches for ARM although I was not sure about what
> would be needed to be done regarding plugins on the context of
> tcg_unregister_thread. I guess they would need to be freed also?

Doesn't it have the same problem that it will randomly free some context
which is not necessarily associated with the unplugged CPU?

Consider machine with 4 CPUs, they are likely added in order - cpu0
getting context0, cpu1 context1, etc.

Unplug CPU 1. Given that context 3 is top the would be unallocated by
the decrement, or am I missing something?

Thanks

Michal

> 
> Thank you
> 
> Miguel
> 
> [1]: https://lore.kernel.org/qemu-devel/20230926103654.34424-5-salil.mehta@huawei.com/

