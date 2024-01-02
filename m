Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22578822238
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 20:43:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKkf2-0006tc-MR; Tue, 02 Jan 2024 14:42:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rKkf0-0006tR-W5
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:42:47 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rKkez-0006nq-F6
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 14:42:46 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1400221FEC;
 Tue,  2 Jan 2024 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704224564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPAA24SIaTTXAM5D+PIsIGf/4Kx+9Gihr01J+1aApi0=;
 b=cb00E5XVny2ePO3SLffmr7Dbr9eS5U+/dCg2ZWOd8bnJ8RSQTu5J11/soYmoeIG1vQStaA
 09lmzv82m7xZTM4QHmdHfz1pvFBaw4DKhc+FUyuphigsUvW+RVh1HPS9T4o6lXCWqMiBzl
 LFW8CnK4VQmQai+gF/5Z6K0l8w57XMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704224564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPAA24SIaTTXAM5D+PIsIGf/4Kx+9Gihr01J+1aApi0=;
 b=W/TTtCoxn/wUerQbJvPbcephJjJseHpFavuQZAzkwP/NeusuuRCyoLBXgEV3PigiH/VBUR
 ATPxr3FmEgFSL0Bw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704224564; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPAA24SIaTTXAM5D+PIsIGf/4Kx+9Gihr01J+1aApi0=;
 b=cb00E5XVny2ePO3SLffmr7Dbr9eS5U+/dCg2ZWOd8bnJ8RSQTu5J11/soYmoeIG1vQStaA
 09lmzv82m7xZTM4QHmdHfz1pvFBaw4DKhc+FUyuphigsUvW+RVh1HPS9T4o6lXCWqMiBzl
 LFW8CnK4VQmQai+gF/5Z6K0l8w57XMI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704224564;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KPAA24SIaTTXAM5D+PIsIGf/4Kx+9Gihr01J+1aApi0=;
 b=W/TTtCoxn/wUerQbJvPbcephJjJseHpFavuQZAzkwP/NeusuuRCyoLBXgEV3PigiH/VBUR
 ATPxr3FmEgFSL0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92C9713AC6;
 Tue,  2 Jan 2024 19:42:43 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id invSFjNnlGVtMAAAD6G6ig
 (envelope-from <farosas@suse.de>); Tue, 02 Jan 2024 19:42:43 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Li
 Zhijian <lizhijian@fujitsu.com>, Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH 10/11] migration: Remove unnecessary usage of local Error
In-Reply-To: <20231231093016.14204-11-avihaih@nvidia.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-11-avihaih@nvidia.com>
Date: Tue, 02 Jan 2024 16:42:41 -0300
Message-ID: <87bka35xou.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=cb00E5XV;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="W/TTtCox"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.37 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 BAYES_HAM(-1.86)[94.19%]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; MX_GOOD(-0.01)[];
 RCPT_COUNT_SEVEN(0.00)[7];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,nvidia.com:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -3.37
X-Rspamd-Queue-Id: 1400221FEC
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

> According to Error API, usage of ERRP_GUARD() or a local Error instead
> of errp is needed if errp is passed to void functions, where it is later
> dereferenced to see if an error occurred.
>
> There are several places in migration.c that use local Error although it
> is not needed. Change these places to use errp directly.
>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

