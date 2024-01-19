Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 447388331AA
	for <lists+qemu-devel@lfdr.de>; Sat, 20 Jan 2024 00:44:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQyWk-0006fW-QO; Fri, 19 Jan 2024 18:43:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQyWi-0006fD-Pg
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:43:56 -0500
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQyWh-0002fi-6f
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 18:43:56 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 03FF11F818;
 Fri, 19 Jan 2024 23:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OntPJWnvs95mgXlCUBrMbQE7wqOTjtNG7ktI29DZ60g=;
 b=UU/2rCRyzaxNCL4utPlcN/LUIxFiNEBg9W3yumcMs01Qcf5jyf63sqGADWoCv8LvuC0HEW
 S+w/EOo0a7e3i1iauLE99mS5oMbKi1Bp8yHj9ADIFJ/t0O2f1dWffJxXJUVcZ3m0ExTSuh
 YJAcZiiOJmkJMAyKmmBfdl2KOZkpZsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OntPJWnvs95mgXlCUBrMbQE7wqOTjtNG7ktI29DZ60g=;
 b=86Xvyd9hmMZxJd/NdYXRt62kJ617CBMSvZK4+mC2gaok1bKmjcfwKGRi19iTxv1QOka72i
 WcGnEnSuMDN8W4DA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705707834; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OntPJWnvs95mgXlCUBrMbQE7wqOTjtNG7ktI29DZ60g=;
 b=UU/2rCRyzaxNCL4utPlcN/LUIxFiNEBg9W3yumcMs01Qcf5jyf63sqGADWoCv8LvuC0HEW
 S+w/EOo0a7e3i1iauLE99mS5oMbKi1Bp8yHj9ADIFJ/t0O2f1dWffJxXJUVcZ3m0ExTSuh
 YJAcZiiOJmkJMAyKmmBfdl2KOZkpZsM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705707834;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OntPJWnvs95mgXlCUBrMbQE7wqOTjtNG7ktI29DZ60g=;
 b=86Xvyd9hmMZxJd/NdYXRt62kJ617CBMSvZK4+mC2gaok1bKmjcfwKGRi19iTxv1QOka72i
 WcGnEnSuMDN8W4DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7D4FD1375D;
 Fri, 19 Jan 2024 23:43:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7qQRETkJq2WEVQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 23:43:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>
Subject: Re: [PATCH 1/5] migration: Fix use-after-free of migration state
 object
In-Reply-To: <20240119233922.32588-2-farosas@suse.de>
References: <20240119233922.32588-1-farosas@suse.de>
 <20240119233922.32588-2-farosas@suse.de>
Date: Fri, 19 Jan 2024 20:43:50 -0300
Message-ID: <87ttn8vqh5.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -1.42
X-Spamd-Result: default: False [-1.42 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.12)[67.11%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
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

Fabiano Rosas <farosas@suse.de> writes:

> We're currently allowing the process_incoming_migration_bh bottom-half
> to run without holding a reference to the 'current_migration' object,
> which leads to a segmentation fault if the BH is still live after
> migration_shutdown() has dropped the last reference to
> current_migration.
>
> In my system the bug manifests as migrate_multifd() returning true
> when it shouldn't and multifd_load_shutdown() calling
> multifd_recv_terminate_threads() which crashes due to an uninitialized
> multifd_recv_state.
>
> Fix the issue by holding a reference to the object when scheduling the
> BH and dropping it before returning from the BH. The same is already
> done for the cleanup_bh at migrate_fd_cleanup_schedule().
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1969

