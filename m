Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDD86832A4F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 Jan 2024 14:25:22 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQoqn-0004WG-67; Fri, 19 Jan 2024 08:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoqi-0004Vh-Ey
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:23:56 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rQoqg-0004mt-K7
 for qemu-devel@nongnu.org; Fri, 19 Jan 2024 08:23:55 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C1D11F7F1;
 Fri, 19 Jan 2024 13:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705670632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1imNTgn8PIBGgMLJ5JAwaaSK/xyzO/pVVLWPexHfCes=;
 b=fHatrXBI1wpninIVc/vg1er0vlf+JB9iwv9/Nf+KaINb3LGIr7K5J1yMTRAvaOaNsFwOVU
 wjPQIg8C05D1x0qeqJyZdHYvC0iB4b/lwuIhELgE1+0b+Kida7gTqvL5Be7SbsKwYNw3ET
 1IW1e2Xyn2XUKujy/yhtIyggjWRn42o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705670632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1imNTgn8PIBGgMLJ5JAwaaSK/xyzO/pVVLWPexHfCes=;
 b=CUU7jXlKdWuZjAs4a1NN5LdCKUv680S3BKU3IW+6i55MKjodgVPLX3EzBxHM03TjUolS3G
 9Kw+tPFFv9tcSrDw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1705670632; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1imNTgn8PIBGgMLJ5JAwaaSK/xyzO/pVVLWPexHfCes=;
 b=fHatrXBI1wpninIVc/vg1er0vlf+JB9iwv9/Nf+KaINb3LGIr7K5J1yMTRAvaOaNsFwOVU
 wjPQIg8C05D1x0qeqJyZdHYvC0iB4b/lwuIhELgE1+0b+Kida7gTqvL5Be7SbsKwYNw3ET
 1IW1e2Xyn2XUKujy/yhtIyggjWRn42o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1705670632;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1imNTgn8PIBGgMLJ5JAwaaSK/xyzO/pVVLWPexHfCes=;
 b=CUU7jXlKdWuZjAs4a1NN5LdCKUv680S3BKU3IW+6i55MKjodgVPLX3EzBxHM03TjUolS3G
 9Kw+tPFFv9tcSrDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9F6451388C;
 Fri, 19 Jan 2024 13:23:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id t1NVGed3qmV/HAAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 19 Jan 2024 13:23:51 +0000
From: Fabiano Rosas <farosas@suse.de>
To: peterx@redhat.com, qemu-devel@nongnu.org
Cc: Prasad Pandit <ppandit@redhat.com>, peterx@redhat.com, Bandan Das
 <bdas@redhat.com>, Julia Suvorova <jusual@redhat.com>
Subject: Re: [PATCH 3/3] analyze-migration.py: Remove trick on parsing
 ramblocks
In-Reply-To: <20240117075848.139045-4-peterx@redhat.com>
References: <20240117075848.139045-1-peterx@redhat.com>
 <20240117075848.139045-4-peterx@redhat.com>
Date: Fri, 19 Jan 2024 10:23:49 -0300
Message-ID: <87plxxzcbe.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fHatrXBI;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=CUU7jXlK
X-Spamd-Result: default: False [-3.23 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-2.92)[99.66%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCPT_COUNT_FIVE(0.00)[6];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2C1D11F7F1
X-Spam-Score: -3.23
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
> RAM_SAVE_FLAG_MEM_SIZE contains the total length of ramblock idstr to know
> whether scanning of ramblocks is complete.  Drop the trick.
>
> Signed-off-by: Peter Xu <peterx@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

