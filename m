Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 242548221B8
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 20:06:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKk4u-0005zM-Ax; Tue, 02 Jan 2024 14:05:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rKk4r-0005yx-Op
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:05:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rKk4q-00016K-5b
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:05:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 67B6021CE3;
 Tue,  2 Jan 2024 19:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704222321; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oz8zUm5OoC74Ngk+w7UOp03ipSgUED/P+gudrvnFu8=;
 b=HdDmp+B4CCdhMzvC4/3lWduysU8teIwrdblOjfkM2KUyp7FQnwJMB8koe1eZHSm02QevDP
 uMMB44OKTpC0CDCYXGGfALEQDnDXqAcd8g84WbqFg4yhUrhyCAsEcAQ4gepe7zGMXUJ9xg
 9/DbfbDwkuIoDKGe6X70FGLa1ynLHOM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704222321;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oz8zUm5OoC74Ngk+w7UOp03ipSgUED/P+gudrvnFu8=;
 b=uOEENS7PWVjcsUONHxvHehz+p9yyvtv/6Le5Uy9/79apANB2ZfiiJOwm21yuUgF+A97GpS
 g2Jt5ghWqyP8EyBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704222320; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oz8zUm5OoC74Ngk+w7UOp03ipSgUED/P+gudrvnFu8=;
 b=Rg3GcfCllwLemcmOVflDlCur/PZ5WIzioYCBPEf/wdI69R7flUp2x/bE7gCZUVt6h3IUqL
 oHwrGNH4Ifw1QY/bI8WcthNjpNITUOG8sGOufzv5pcgxhwBul1Gkhkjy+sLneSZ204v92q
 tpaJ6N+EJFshF/j4YL7qRmpJTtAhCQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704222320;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4oz8zUm5OoC74Ngk+w7UOp03ipSgUED/P+gudrvnFu8=;
 b=fytYztdLXTl8aVOljmzjYAYh4gvPMio0zzoAHVQuQJ1f+KCXKd2VV5hgdI1pAZcFalhAJ+
 ofaC5iTOcUwFwNAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E58CA1340C;
 Tue,  2 Jan 2024 19:05:19 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Wt7dKm9elGXqJwAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 02 Jan 2024 19:05:19 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 05/11] migration/multifd: Fix error message in
 multifd_recv_initial_packet()
In-Reply-To: <20231231093016.14204-6-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-6-avihaih@nvidia.com>
Date: Tue, 02 Jan 2024 16:05:17 -0300
Message-ID: <87mstn5zf6.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.89 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-2.58)[98.14%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[nvidia.com:email,suse.de:dkim,suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=Rg3GcfCl;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=fytYztdL
X-Spam-Score: -2.89
X-Rspamd-Queue-Id: 67B6021CE3
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
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

> In multifd_recv_initial_packet(), if MultiFDInit_t->id is greater than
> the configured number of multifd channels, an irrelevant error message
> about multifd version is printed.
>
> Change the error message to a relevant one about the channel id.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

