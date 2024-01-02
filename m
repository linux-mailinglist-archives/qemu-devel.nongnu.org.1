Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4F14822234
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 20:40:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKkbd-0005Yi-9A; Tue, 02 Jan 2024 14:39:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rKkba-0005YU-NZ
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:39:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rKkbY-0006Hb-6R
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:39:13 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A7BC121D7F;
 Tue,  2 Jan 2024 19:39:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704224350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz4mf0O61huSTkxzL+1o5SlNC3Ql8SSETR+PNUtiZbM=;
 b=WUyJl69YxyPQcofsIXSk4GsHuZiSXhLgNORYnlBmE1KymEI0TR4/HGJf71DGflnsPTWJcB
 XSi12EUxX6zEcIFxOcmgGp0ncMaKiVqnapLMqqXp0Di1LmiLUZLrxN+TDMhDF0oFOwtK/n
 Idua8gmYPhLip90puRG3atxqLksmYm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704224350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz4mf0O61huSTkxzL+1o5SlNC3Ql8SSETR+PNUtiZbM=;
 b=J47D8TPXmADd70ogGxP5K3EdWAwHXWfPM4HAVx6+MhFq/fO2BDEegQ0dHie7LXb0lmHTMY
 +vQPMA/1wA0iEEAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704224350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz4mf0O61huSTkxzL+1o5SlNC3Ql8SSETR+PNUtiZbM=;
 b=WUyJl69YxyPQcofsIXSk4GsHuZiSXhLgNORYnlBmE1KymEI0TR4/HGJf71DGflnsPTWJcB
 XSi12EUxX6zEcIFxOcmgGp0ncMaKiVqnapLMqqXp0Di1LmiLUZLrxN+TDMhDF0oFOwtK/n
 Idua8gmYPhLip90puRG3atxqLksmYm8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704224350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Oz4mf0O61huSTkxzL+1o5SlNC3Ql8SSETR+PNUtiZbM=;
 b=J47D8TPXmADd70ogGxP5K3EdWAwHXWfPM4HAVx6+MhFq/fO2BDEegQ0dHie7LXb0lmHTMY
 +vQPMA/1wA0iEEAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2FE6613AC6;
 Tue,  2 Jan 2024 19:39:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id EHUZOl1mlGWPLwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 02 Jan 2024 19:39:09 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 09/11] migration: Fix migration_channel_read_peek()
 error path
In-Reply-To: <20231231093016.14204-10-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-10-avihaih@nvidia.com>
Date: Tue, 02 Jan 2024 16:39:07 -0300
Message-ID: <87edez5xus.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.52
X-Spamd-Result: default: False [-1.52 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-0.22)[72.31%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
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

Avihai Horon <avihaih@nvidia.com> writes:

> migration_channel_read_peek() calls qio_channel_readv_full() and handles
> both cases of return value == 0 and return value < 0 the same way, by
> calling error_setg() with errp. However, if return value < 0, errp is
> already set, so calling error_setg() with errp will lead to an assert.
>
> Fix it by handling these cases separately, calling error_setg() with
> errp only in return value == 0 case.
>
> Fixes: 6720c2b32725 ("migration: check magic value for deciding the mapping of channels")
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

