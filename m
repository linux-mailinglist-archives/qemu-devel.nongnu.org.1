Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F5DE830E9D
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 22:25:37 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQDOd-0006PG-AN; Wed, 17 Jan 2024 16:24:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQDOb-0006P7-Bz
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:24:25 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQDOY-0007lb-Nv
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 16:24:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FCDB21F6F;
 Wed, 17 Jan 2024 21:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705526659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfTWgVho4lqDFyp7QC/hvVskn++4DB5xMKgNJ9xXVLM=;
 b=TOQl+OHMEU0A+kX7a3bpXhOckaVbhewi7n0B/TrNa025mK75MhvmiQKnTmcJcP51cBQYSL
 8VDEN1zOEamRoP/UuiJgfbIsliUKZed6Lp1uXBtcSgAgJxCXu3vs0+NQxFYKnOucp5V30h
 RwK+nAvukN2v1J7TN6O/C6sQOY8X5xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705526659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfTWgVho4lqDFyp7QC/hvVskn++4DB5xMKgNJ9xXVLM=;
 b=3gzUtpyhPFULzQRwEkOnF9hZTz5HRaIzqWQIT4RaneJYGqyKHEQ/Nqphvdvvfsg7wOYaYw
 3zg4NfgR1HVAXSDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705526659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfTWgVho4lqDFyp7QC/hvVskn++4DB5xMKgNJ9xXVLM=;
 b=TOQl+OHMEU0A+kX7a3bpXhOckaVbhewi7n0B/TrNa025mK75MhvmiQKnTmcJcP51cBQYSL
 8VDEN1zOEamRoP/UuiJgfbIsliUKZed6Lp1uXBtcSgAgJxCXu3vs0+NQxFYKnOucp5V30h
 RwK+nAvukN2v1J7TN6O/C6sQOY8X5xI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705526659;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TfTWgVho4lqDFyp7QC/hvVskn++4DB5xMKgNJ9xXVLM=;
 b=3gzUtpyhPFULzQRwEkOnF9hZTz5HRaIzqWQIT4RaneJYGqyKHEQ/Nqphvdvvfsg7wOYaYw
 3zg4NfgR1HVAXSDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC8DD13808;
 Wed, 17 Jan 2024 21:24:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KK9SKIJFqGWiBAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 17 Jan 2024 21:24:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PULL 08/41] target/arm: Set CTR_EL0.{IDC,DIC} for the 'max' CPU
In-Reply-To: <20240111110505.1563291-9-peter.maydell@linaro.org>
References: <20240111110505.1563291-1-peter.maydell@linaro.org>
 <20240111110505.1563291-9-peter.maydell@linaro.org>
Date: Wed, 17 Jan 2024 18:24:16 -0300
Message-ID: <877ck7d56n.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=TOQl+OHM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=3gzUtpyh
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 5FCDB21F6F
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

Peter Maydell <peter.maydell@linaro.org> writes:

> The CTR_EL0 register has some bits which allow the implementation to
> tell the guest that it does not need to do cache maintenance for
> data-to-instruction coherence and instruction-to-data coherence.
> QEMU doesn't emulate caches and so our cache maintenance insns are
> all NOPs.
>
> We already have some models of specific CPUs where we set these bits
> (e.g.  the Neoverse V1), but the 'max' CPU still uses the settings it
> inherits from Cortex-A57.  Set the bits for 'max' as well, so the
> guest doesn't need to do unnecessary work.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Tested-by: Miguel Luis <miguel.luis@oracle.com>
> ---
>  target/arm/tcg/cpu64.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
>
> diff --git a/target/arm/tcg/cpu64.c b/target/arm/tcg/cpu64.c
> index fcda99e1583..40e7a45166f 100644
> --- a/target/arm/tcg/cpu64.c
> +++ b/target/arm/tcg/cpu64.c
> @@ -1105,6 +1105,16 @@ void aarch64_max_tcg_initfn(Object *obj)
>      u = FIELD_DP32(u, CLIDR_EL1, LOUU, 0);
>      cpu->clidr = u;
>  
> +    /*
> +     * Set CTR_EL0.DIC and IDC to tell the guest it doesnt' need to
> +     * do any cache maintenance for data-to-instruction or
> +     * instruction-to-guest coherence. (Our cache ops are nops.)
> +     */
> +    t = cpu->ctr;
> +    t = FIELD_DP64(t, CTR_EL0, IDC, 1);
> +    t = FIELD_DP64(t, CTR_EL0, DIC, 1);
> +    cpu->ctr = t;
> +
>      t = cpu->isar.id_aa64isar0;
>      t = FIELD_DP64(t, ID_AA64ISAR0, AES, 2);      /* FEAT_PMULL */
>      t = FIELD_DP64(t, ID_AA64ISAR0, SHA1, 1);     /* FEAT_SHA1 */

Hi, we're introducing new regression tests to migration and this patch
shows up in the bisect of an issue. I need some help figuring out
whether this is an actual regression or something else.

The migration is TCG QEMU 8.2.0 -> TCG QEMU master.

On the destination side (contains this patch) we're hitting this
condition:

bool write_list_to_cpustate(ARMCPU *cpu)
{
...
        /*
         * Write value and confirm it reads back as written
         * (to catch read-only registers and partially read-only
         * registers where the incoming migration value doesn't match)
         */
        write_raw_cp_reg(&cpu->env, ri, v);
        if (read_raw_cp_reg(&cpu->env, ri) != v) {
--->        ok = false;
        }

Thread 1 "qemu-system-aar" hit Breakpoint 3, write_list_to_cpustate (cpu=0x555557a2f8f0) at ../target/arm/helper.c:190
190                 ok = false;
(gdb) p ri->name
$7 = 0x555557ab9ae0 "CTR"
(gdb) p/x v
$3 = 0x8444c004
(gdb) p/x read_raw_cp_reg(&cpu->env, ri)
$4 = 0xb444c004

Is there any particularity in reading/writing to that register? This is
during post_load and 'v' is what came in the migration stream.

