Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 58DFE78401C
	for <lists+qemu-devel@lfdr.de>; Tue, 22 Aug 2023 13:52:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYPvi-0003Fg-9f; Tue, 22 Aug 2023 07:52:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qYPvg-0003FR-Ci; Tue, 22 Aug 2023 07:52:12 -0400
Received: from smtp-out2.suse.de ([2001:67c:2178:6::1d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>)
 id 1qYPvd-0000vR-SX; Tue, 22 Aug 2023 07:52:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 67C471F85D;
 Tue, 22 Aug 2023 11:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692705126; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iu55il7brsUz8rBEuK308QQGaHmjDqbMy8k9/lU8BT8=;
 b=gcMDuXhO4qQLD5BKCcJeQzve2kb97tSjHaZAHocmymMImLNQdltxRIgLSwEq7xTsZsrU71
 l88O9v/6GDqzW0z3S2dQ3Bi0ywxzIcw9VTKdo86k19XkQBAZHniYLTr0mS2meP5bDZjXJU
 yz/NG5wxczlIpXzdmNil9ITsY7j+XIA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692705126;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Iu55il7brsUz8rBEuK308QQGaHmjDqbMy8k9/lU8BT8=;
 b=G7Bo+ZwI002kZaoKkT9JfBt04O2wsix6fPyrElwRG8kuMSbrPShXnH4E/H2l1PNJ/PhbFn
 eTimODiXz7TOU+BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 088AE13919;
 Tue, 22 Aug 2023 11:52:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DBWxAGah5GSGUQAAMHmgww
 (envelope-from <cfontana@suse.de>); Tue, 22 Aug 2023 11:52:06 +0000
Message-ID: <ecaf4816-90d1-9acf-968f-b590a274180b@suse.de>
Date: Tue, 22 Aug 2023 13:52:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 00/10] block: Make raw_co_get_allocated_file_size
 asynchronous
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Jo=c3=a3o_Silva?= <jsilva@suse.de>, Lin Ma <lma@suse.com>,
 Dario Faggioli <dfaggioli@suse.com>, Eric Blake <eblake@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
From: Claudio Fontana <cfontana@suse.de>
In-Reply-To: <20230609201910.12100-1-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:67c:2178:6::1d;
 envelope-from=cfontana@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.767,
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

Hi all,

we currently have to maintain something downstream for this, since the current behavior can compound problems on top of existing bad NFS latency,
could someone continue to help reviewing this work?

Thanks,

Claudio


On 6/9/23 22:19, Fabiano Rosas wrote:
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
> ===
> v1:
> https://lore.kernel.org/r/20230523213903.18418-1-farosas@suse.de
> 
> As discussed in another thread [1], here's an RFC addressing a VCPU
> softlockup encountered when issuing QMP commands that target a disk
> placed on NFS.
> 
> Since QMP commands happen with the qemu_global_mutex locked, any
> command that takes too long to finish will block other threads waiting
> to take the global mutex. One such thread could be a VCPU thread going
> out of the guest to handle IO.
> 
> This is the case when issuing the QMP command query-block, which
> eventually calls raw_co_get_allocated_file_size(). This function makes
> an 'fstat' call that has been observed to take a long time (seconds)
> over NFS.
> 
> NFS latency issues aside, we can improve the situation by not blocking
> VCPU threads while the command is running.
> 
> Move the 'fstat' call into the thread-pool and make the necessary
> adaptations to ensure raw_co_get_allocated_file_size runs in a
> coroutine in the block driver aio_context.
> 
> 1- Question about QMP and BQL
> https://lists.gnu.org/archive/html/qemu-devel/2023-05/msg03141.html
> 
> Fabiano Rosas (8):
>   block: Remove bdrv_query_block_node_info
>   block: Remove unnecessary variable in bdrv_block_device_info
>   block: Allow the wrapper script to see functions declared in qapi.h
>   block: Temporarily mark bdrv_co_get_allocated_file_size as mixed
>   block: Convert bdrv_query_block_graph_info to coroutine
>   block: Convert bdrv_block_device_info into co_wrapper
>   block: Don't query all block devices at hmp_nbd_server_start
>   block: Convert qmp_query_block() to coroutine_fn
> 
> João Silva (1):
>   block: Add a thread-pool version of fstat
> 
> Lin Ma (1):
>   block: Convert qmp_query_named_block_nodes to coroutine
> 
>  block/file-posix.c                 | 40 +++++++++++++++++--
>  block/meson.build                  |  1 +
>  block/monitor/block-hmp-cmds.c     | 22 ++++++-----
>  block/qapi.c                       | 62 +++++++++---------------------
>  blockdev.c                         |  6 +--
>  hmp-commands-info.hx               |  1 +
>  include/block/block-hmp-cmds.h     |  2 +-
>  include/block/qapi.h               | 17 ++++----
>  include/block/raw-aio.h            |  4 +-
>  qapi/block-core.json               |  5 ++-
>  qemu-img.c                         |  2 -
>  scripts/block-coroutine-wrapper.py |  1 +
>  12 files changed, 90 insertions(+), 73 deletions(-)
> 


