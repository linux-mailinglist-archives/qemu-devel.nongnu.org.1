Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 027CA9BD734
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Nov 2024 21:46:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8QRP-0002zS-TY; Tue, 05 Nov 2024 15:46:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8QQe-0002m3-Ku
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 15:45:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1t8QQc-0003tJ-Uo
 for qemu-devel@nongnu.org; Tue, 05 Nov 2024 15:45:32 -0500
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9902F1FF01;
 Tue,  5 Nov 2024 20:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730839529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZeVL87JRty7zVMmQoZWfP2E5ZVMko2Jp5CgR70KZz4=;
 b=dOh5sqJEJ8SjAGPlFWaO4qXUpVpcXNOAQ8UNC87cfgLkHqEyJXkyC0LzXWOR90l9yDrmdB
 tH/ftPC0FKuU1uYef4nRFR6s8FAUjZavDd2FMWva/1MeY1pskEYehwy9gpI0rNhJAW+Yu8
 VyA6/FOtlXYWvlOXim4/Elw1C8LxsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730839529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZeVL87JRty7zVMmQoZWfP2E5ZVMko2Jp5CgR70KZz4=;
 b=0N8xoY5R+7+1hIOQyZpm04kO1vd7vM45eIUdltlQ5FQfmuvY+bZbB70pw+V0k3UfNbpK8B
 4DsoIe0luSwZ8sAw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1730839529; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZeVL87JRty7zVMmQoZWfP2E5ZVMko2Jp5CgR70KZz4=;
 b=dOh5sqJEJ8SjAGPlFWaO4qXUpVpcXNOAQ8UNC87cfgLkHqEyJXkyC0LzXWOR90l9yDrmdB
 tH/ftPC0FKuU1uYef4nRFR6s8FAUjZavDd2FMWva/1MeY1pskEYehwy9gpI0rNhJAW+Yu8
 VyA6/FOtlXYWvlOXim4/Elw1C8LxsV4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1730839529;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CZeVL87JRty7zVMmQoZWfP2E5ZVMko2Jp5CgR70KZz4=;
 b=0N8xoY5R+7+1hIOQyZpm04kO1vd7vM45eIUdltlQ5FQfmuvY+bZbB70pw+V0k3UfNbpK8B
 4DsoIe0luSwZ8sAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 147DE1394A;
 Tue,  5 Nov 2024 20:45:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JBD2MuiDKmepEAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 05 Nov 2024 20:45:28 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, Peter Maydell <peter.maydell@linaro.org>, Pierrick
 Bouvier <pierrick.bouvier@linaro.org>
Subject: Re: [PATCH] migration: Check current_migration in
 migration_is_running()
In-Reply-To: <20241105182725.2393425-1-peterx@redhat.com>
References: <20241105182725.2393425-1-peterx@redhat.com>
Date: Tue, 05 Nov 2024 17:45:26 -0300
Message-ID: <877c9h2yvt.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.98%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

> Report shows that commit 34a8892dec broke iotest 055:
>
> https://lore.kernel.org/r/b8806360-a2b6-4608-83a3-db67e264c733@linaro.org
>
> When replacing migration_is_idle() with "!migration_is_running()", it was
> overlooked that the idle helper also checks for current_migration being
> available first.
>
> The check would be there if the whole series was applied, but since the
> last patches in the previous series rely on some other patches to land
> first, we need to recover the behavior of migration_is_idle() first before
> that whole set will be merged.
>
> I left migration_is_active / migration_is_device alone, as I don't think
> it's possible for them to hit his case (current_migration not initialized).
> Also they're prone to removal soon from VFIO side.
>
> Cc: Fabiano Rosas <farosas@suse.de>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Fixes: 34a8892dec ("migration: Drop migration_is_idle()")
> Reported-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Tested-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

