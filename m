Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 00C7E7D0385
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 23:09:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtaGf-0003F5-EW; Thu, 19 Oct 2023 17:09:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtaGe-00036Y-1D
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:09:20 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qtaGc-0002JX-9S
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 17:09:19 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BCE5A1FD82;
 Thu, 19 Oct 2023 21:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697749754; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMBWKXa539XnlF4/5fu/qOcA4ub2oAWTI4Rybrkn4o8=;
 b=njwErqwAC4ou9TziN2F7n/Mi5BE5fOpmBmr2yEBXgndhR6PhvhxOs5CPZsjJU8lpuTa6OW
 Ga+tN7kIsijwc1SfvMUyNSXX4fDzQJIKCDWSFPu8Q04sTJ024OrDdfzQpHDKUJ5V/EqaYN
 Ms9FfPrO/+IUwcd9pT0CW2zuMtZGi4Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697749754;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DMBWKXa539XnlF4/5fu/qOcA4ub2oAWTI4Rybrkn4o8=;
 b=4ySYtqT13D138pN60LVIcl+Bn1uClQFEHUNYW/dU7eFF3GgBsPpBG9/c8ataFKfN7RnJhU
 ziOrrD3W/Pv9SQAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 51D75139C2;
 Thu, 19 Oct 2023 21:09:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fMa6B/qaMWVPQAAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 19 Oct 2023 21:09:14 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH v4 1/5] migration: Refactor error handling in source
 return path
In-Reply-To: <20231017202633.296756-2-peterx@redhat.com>
References: <20231017202633.296756-1-peterx@redhat.com>
 <20231017202633.296756-2-peterx@redhat.com>
Date: Thu, 19 Oct 2023 18:09:11 -0300
Message-ID: <87o7gu5ngo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -5.05
X-Spamd-Result: default: False [-5.05 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.95)[86.59%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-3.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[5];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2001:67c:2178:6::1d; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> rp_state.error was a boolean used to show error happened in return path
> thread.  That's not only duplicating error reporting (migrate_set_error),
> but also not good enough in that we only do error_report() and set it to
> true, we never can keep a history of the exact error and show it in
> query-migrate.
>
> To make this better, a few things done:
>
>   - Use error_setg() rather than error_report() across the whole lifecycle
>     of return path thread, keeping the error in an Error*.
>
>   - With above, no need to have mark_source_rp_bad(), remove it, alongside
>     with rp_state.error itself.
>
>   - Use migrate_set_error() to apply that captured error to the global
>     migration object when error occured in this thread.
>
>   - Do the same when detected qemufile error in source return path
>
> We need to re-export qemu_file_get_error_obj() to do the last one.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

