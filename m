Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 29FE0807062
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 13:58:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rArSF-0007Dn-Ol; Wed, 06 Dec 2023 07:56:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rArS1-0007Bq-ST
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 07:56:33 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <msuchanek@suse.de>) id 1rArRx-0002j0-ET
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 07:56:27 -0500
Received: from kitsune.suse.cz (unknown [10.100.12.127])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 94ADE22035;
 Wed,  6 Dec 2023 12:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701867380; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wvhofv+y/lIzbpw4SmcXdrCuPWvfV2hiI2e55Wb8/w=;
 b=jeOPo4z6RlRGqTKl5kVDI2sN3nij16DDzszX2aY88VHbjveQyJn7BlIhPbtOvR4LSRrQyz
 dWcr5hMU81WXOUytEbX5v7rbkZPuKU53N5JyNPKXCB4tGMP4YxVchqaYpYiBxRtwvroENy
 JNsLH0o8osyFS0SjEelKHchkA3FPfhM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701867380;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/Wvhofv+y/lIzbpw4SmcXdrCuPWvfV2hiI2e55Wb8/w=;
 b=9U3RYB/Y3mxwfIkyNaFZF+ycxbmrdj3YB1HAv9Z4KwhPR1nNY0ShBCpGmjr7KegNDpzii/
 uKFmVMi02ULOqKDQ==
Date: Wed, 6 Dec 2023 13:56:19 +0100
From: Michal =?iso-8859-1?Q?Such=E1nek?= <msuchanek@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [RFC PATCH-for-8.2?] accel/tcg: Implement tcg_unregister_thread()
Message-ID: <20231206125619.GH9696@kitsune.suse.cz>
References: <20231204194039.56169-1-philmd@linaro.org>
 <CAJSP0QUjZQQCk+VSJyxLq2jzuK=nxXDCiBn-r4dVzNPOCgH67w@mail.gmail.com>
 <20231204200937.GA9696@kitsune.suse.cz>
 <caa90c99-aada-467b-a005-84642cd55a86@linaro.org>
 <20231205100959.GB9696@kitsune.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231205100959.GB9696@kitsune.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -0.30
X-Spamd-Result: default: False [-0.30 / 50.00]; ARC_NA(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_COUNT_ZERO(0.00)[0];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 FREEMAIL_CC(0.00)[gmail.com,linaro.org,nongnu.org,redhat.com];
 BAYES_HAM(-0.00)[15.85%]; SUBJECT_HAS_QUESTION(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=msuchanek@suse.de;
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

On Tue, Dec 05, 2023 at 11:09:59AM +0100, Michal Suchánek wrote:
> On Mon, Dec 04, 2023 at 03:02:45PM -0800, Richard Henderson wrote:
> > On 12/4/23 12:09, Michal Suchánek wrote:
> > > On Mon, Dec 04, 2023 at 02:50:17PM -0500, Stefan Hajnoczi wrote:
> > > > On Mon, 4 Dec 2023 at 14:40, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
> > > > > +void tcg_unregister_thread(void)
> > > > > +{
> > > > > +    unsigned int n;
> > > > > +
> > > > > +    n = qatomic_fetch_dec(&tcg_cur_ctxs);
> > > > > +    g_free(tcg_ctxs[n]);
> > > > > +    qatomic_set(&tcg_ctxs[n], NULL);
> > > > > +}
> > > > 
> > > > tcg_ctxs[n] may not be our context, so this looks like it could free
> > > > another thread's context and lead to undefined behavior.
> > 
> > Correct.
> > 
> > > There is cpu->thread_id so perhaps cpu->thread_ctx could be added as
> > > well. That would require a bitmap of used threads contexts rather than a
> > > counter, though.
> > 
> > Or don't free the context at all, but re-use it when incrementing and
> > tcg_ctxs[n] != null (i.e. plugging in a repacement vcpu).  After all, there
> > can only be tcg_max_ctxs contexts.
> 
> But you would not know which contexts are in use and which aren't without
> tracking the association of contexts to CPUs.
> 
> Unless there is a cpu array somewhere and you can use the same index for
> both to create the association.

I tried to use cpu_index for correlating the tcg_ctx with cpu. I added
some asserts that only null contexts are allocated and non-null contexts
released but qemu crashes somewhere in tcg sometime after the guest gets
to switch root.

Thanks

Michal

