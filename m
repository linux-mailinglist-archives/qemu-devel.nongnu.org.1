Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974375F850
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 15:29:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNvd1-0004Gs-Eu; Mon, 24 Jul 2023 09:29:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qNvck-000429-9K
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:29:23 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qNvcg-00081U-Fd
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 09:29:15 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EAC4422949;
 Mon, 24 Jul 2023 13:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690205350; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xsFudOLy2wh7KWMwulcMZ+dVnanlj+y3GezPdkqCzh4=;
 b=DX/W0DTVtjSpcLTLC1xU95bG9qZjAxoqVWA9l2cIJQkpMvZf0R8STcsnJ4zZVvlELI6knS
 Vid9aFV0NMK8D+9ztn6rpS6CpqpJBna2RdRX0agGmxWsk06SCDr3I5OoCcNCamMMPxbXLL
 56oh7hh8ze8pf3Cw0PS/b9ua1zfeyk4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690205350;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xsFudOLy2wh7KWMwulcMZ+dVnanlj+y3GezPdkqCzh4=;
 b=R9b5FUGUXR+gX5u4AYogOBj3eM4A0D1AnNuwcblVHiUD9M0jslAw4IVS2Ve/yYefxZCJcm
 kX95APGYm7pV2HCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7B7DE13476;
 Mon, 24 Jul 2023 13:29:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id SZKqEaZ8vmSEOwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 24 Jul 2023 13:29:10 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, libvir-list@redhat.com, Paolo
 Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>, Eric Blake
 <eblake@redhat.com>, Juan Quintela <quintela@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Subject: Re: [PATCH 02/26] migration/multifd: Protect accesses to
 migration_threads
In-Reply-To: <20230724130639.93135-3-quintela@redhat.com>
References: <20230724130639.93135-1-quintela@redhat.com>
 <20230724130639.93135-3-quintela@redhat.com>
Date: Mon, 24 Jul 2023 10:29:08 -0300
Message-ID: <875y69zbdn.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
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

Juan Quintela <quintela@redhat.com> writes:

> From: Fabiano Rosas <farosas@suse.de>
>
> This doubly linked list is common for all the multifd and migration
> threads so we need to avoid concurrent access.
>
> Add a mutex to protect the data from concurrent access. This fixes a
> crash when removing two MigrationThread objects from the list at the
> same time during cleanup of multifd threads.
>
> Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230607161306.31425-3-farosas@suse.de>
> Signed-off-by: Juan Quintela <quintela@redhat.com>

Hi Juan,

What about re-enabling the /multifd/tcp/plain/cancel test? You had
mentioned that something else was needed, but never said exactly
what...

I've been doing a lot of migration work recently and all of my branches
have this change and the cancel test enabled. No issues so far.


