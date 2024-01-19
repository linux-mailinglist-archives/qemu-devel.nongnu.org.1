Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57F31832A63
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:26:46 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQotO-0001JP-6f; Fri, 19 Jan 2024 08:26:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQotG-0000zY-Hm
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:26:36 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQotE-00082u-Ev
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:26:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E4AD71F7F4;
 Fri, 19 Jan 2024 13:26:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705670791; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSNDn0GzJ/nuhopzVLJCZ6mL1xK7Tfr7A7p9A2wCKVg=;
 b=h9Pu+edpGXegQmgvuZS84hx0Dq2BXp4n6AuapNMLc8C1kZIzazyl3iXSNUYAzUOGnAufns
 /GwbvB9jMP+BHAk2OVv/t2YJgcwop90OBpuC4dprdmmbs4eKW4LPUTjNX0B6Um5hVp7d7/
 x3cqyJDKCqkIUDxz7p7T5XSh73kb26g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705670791;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSNDn0GzJ/nuhopzVLJCZ6mL1xK7Tfr7A7p9A2wCKVg=;
 b=ZdddyWR8niIhwg/+Edo8FkMTNHfEZy1wIaFpxZ+kXvoIEQ4otP0wYb3Izlue0C1EB8te1T
 mHueJaRSmPC8+mAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705670790; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSNDn0GzJ/nuhopzVLJCZ6mL1xK7Tfr7A7p9A2wCKVg=;
 b=lNDVo+ruma+JoYG8H8W4KqhN+iBylK6pJiHamPKBGQHsOCGHEqkrBx/K6CStIELlqb/HH5
 SdeM7n5B1ihSareYDyoJS6kVODHc4//e6UVlQWSMMlDlrwW8RKg5LmsqGsTkrVySoMeDwo
 JuCErszD6v5Re1XKrYKR/3pLg9365kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705670790;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YSNDn0GzJ/nuhopzVLJCZ6mL1xK7Tfr7A7p9A2wCKVg=;
 b=rGhbgzOW6XIm+MJ6La6Wwg0BjLGAqPzF5jVwhWwpKw2/RhUdClhIFmHYET05MhZl7Mo1l3
 /ck6evw3Sm+rmQAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6120A13894;
 Fri, 19 Jan 2024 13:26:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Ijw2CoZ4qmWCHQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 13:26:30 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com, Bandan Das
 <bdas@redhat.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH 1/3] migration: Make threshold_size an uint64_t
In-Reply-To: <20240117075848.139045-2-peterx@redhat.com>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-2-peterx@redhat.com>
Date: Fri, 19 Jan 2024 10:26:27 -0300
Message-ID: <87jzo5zc70.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=lNDVo+ru;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=rGhbgzOW
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.38 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; BAYES_HAM(-2.87)[99.44%];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -4.38
X-Rspamd-Queue-Id: E4AD71F7F4
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
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

peterx@redhat.com writes:

> From: Peter Xu <peterx@redhat.com>
>
> It's always used to compare against another uint64_t.  Make it always clear
> that it's never a negative.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

