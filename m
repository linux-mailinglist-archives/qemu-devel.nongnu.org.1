Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6BEE745DFC
	for <lists+qemu-devel@lfdr.de>; Mon,  3 Jul 2023 15:56:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGK1r-0006YX-Fm; Mon, 03 Jul 2023 09:55:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qGK1n-00060z-NF; Mon, 03 Jul 2023 09:55:43 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qGK1l-0000Ts-MI; Mon, 03 Jul 2023 09:55:43 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 400A91FE8C;
 Mon,  3 Jul 2023 13:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1688392538; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qvOw4Hgat/+2oj0L3Woup6clmTBUDZjBq5SYxuP7qU=;
 b=CW/0vB8WQn9A2DXsizj0WSi1L+D0w42pzr+0AeGTp3+p3bl08JYSr5bJSoviZRGGFy1Bz1
 zo67sZsA/nffA2p/AB+HPcRTefwizBSHnB+JFKZfnWM19IH0EjUzWig+5pR766dkfpg77E
 ny40XbugO4DLbuygRICeH4H2g3Ep+14=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1688392538;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6qvOw4Hgat/+2oj0L3Woup6clmTBUDZjBq5SYxuP7qU=;
 b=zWXcVfWISuTE8T3vPiWEVYMVEWBPj5tIl/3u067lGtk5AIgaSuGXxsjjW9sm6NR11VDllO
 +8AKmW/qXTkbEYAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BC8DB13276;
 Mon,  3 Jul 2023 13:55:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XQN/IVnTomShKwAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 03 Jul 2023 13:55:37 +0000
From: Fabiano Rosas <farosas@suse.de>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Hanna Reitz
 <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Jo?=
 =?utf-8?Q?=C3=A3o?= Silva
 <jsilva@suse.de>, Lin Ma <lma@suse.com>, Claudio Fontana
 <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>, Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v2 00/10] block: Make raw_co_get_allocated_file_size
 asynchronous
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
References: <20230609201910.12100-1-farosas@suse.de>
Date: Mon, 03 Jul 2023 10:55:34 -0300
Message-ID: <87wmzhp0a1.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

Fabiano Rosas <farosas@suse.de> writes:

> Hi,
>
> The major change from the last version is that this time I'm moving
> all of the callers of bdrv_get_allocated_file_size() into
> coroutines. I had to make some temporary changes to avoid asserts
> while not all the callers were converted.
>
> I tried my best to explain why I think the changes are safe. To avoid
> changing too much of the code I added a change that removes the
> dependency of qmp_query_block from hmp_nbd_server_start, that way I
> don't need to move all of the nbd code into a coroutine as well.
>
> Based on:
>  [PATCH v2 00/11] block: Re-enable the graph lock
>  https://lore.kernel.org/r/20230605085711.21261-1-kwolf@redhat.com
>
> changes:
>
>   - fixed duplicated commit message [Lin]
>   - clarified why we need to convert info-block [Claudio]
>   - added my rationale of why the changes are safe [Eric]
>   - converted all callers to coroutines [Kevin]
>   - made hmp_nbd_server_start don't depend on qmp_query_block
>
> CI run: https://gitlab.com/farosas/qemu/-/pipelines/895525156

Ping, this seems to have fallen through the cracks.

