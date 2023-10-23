Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 560DB7D386C
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 15:50:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quvJd-000632-3H; Mon, 23 Oct 2023 09:49:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quvJR-00060J-R5
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:49:46 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1quvJQ-0000LG-02
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 09:49:45 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B3A451FE17;
 Mon, 23 Oct 2023 13:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1698068982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtbVTj45tLEDoHgwwv+wFhUCRHehlYIJQJwfA95gcDM=;
 b=gST1vcTJV92TFOa2C7c7ddLZ8ieda/DriuhIcVB29iQGe/YXeVjx8TOwDx0kw+93hwOAnZ
 N0+xE+QnXoEhVOc1soJDuqpMvUiyFqWwsIXYaQa60NBt0VRx1yElwwxoyBombgD8Fz7V8v
 tGuV2daiWA2A0nx/ksRPkQzqkQYcfWM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1698068982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NtbVTj45tLEDoHgwwv+wFhUCRHehlYIJQJwfA95gcDM=;
 b=RBFfYgdK7QOF9nEl/m6bR7DyTQNmsS8Y5TI/Ckd2bBVr9tVraDTDAxFBmA2anPcFeZWHDL
 clHNbhxAsIzWEPAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3CA54132FD;
 Mon, 23 Oct 2023 13:49:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id tAqfAvZ5NmXAWgAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 23 Oct 2023 13:49:42 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>, Juan
 Quintela <quintela@redhat.com>, Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH v2 06/11] migration: Move busy++ to
 migrate_with_multithread
In-Reply-To: <20231019110724.15324-7-quintela@redhat.com>
References: <20231019110724.15324-1-quintela@redhat.com>
 <20231019110724.15324-7-quintela@redhat.com>
Date: Mon, 23 Oct 2023 10:49:39 -0300
Message-ID: <877cnd1ma4.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -7.10
X-Spamd-Result: default: False [-7.10 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[99.99%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[web.de];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 RCPT_COUNT_FIVE(0.00)[6];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 FREEMAIL_CC(0.00)[redhat.com,web.de]
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

eviewed-by: Fabiano Rosas <farosas@suse.de>Juan Quintela <quintela@redhat.com> writes:

> And now we can simplify save_compress_page().
>
> Reviewed-by: Lukas Straub <lukasstraub2@web.de>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Reviewed-by: Fabiano Rosas <farosas@suse.de>

