Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ABB1A7FE0E3
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 21:21:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8R21-0002dd-Kc; Wed, 29 Nov 2023 15:19:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1r8R1z-0002ch-53; Wed, 29 Nov 2023 15:19:35 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1r8R1w-0000X8-Ny; Wed, 29 Nov 2023 15:19:34 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7B0EC219C5;
 Wed, 29 Nov 2023 20:19:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1701289168; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltK4vFx5VWsh2lZkRoSa0YlWHrq5gR0k3QUnWz3f974=;
 b=zD4JIq6IUihylGmT4Ky6b6X++57pY7+V2e/a/NzV0BpXtABQZFr/4NpA9bVq3Xgg4Wj6XH
 Xo3tVS6VbrGfhOjz2EuZpGegzxfyrN4KPal+jNgVCOSMqVxa8+rI7wqtBKLW5VoHj01nmW
 x4mgKZhNkL6FQebTSZOd13B5EuaBpRA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1701289168;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ltK4vFx5VWsh2lZkRoSa0YlWHrq5gR0k3QUnWz3f974=;
 b=ldp8ng08clxE4c0GzmKwLTaDjtyIPDQGpeyqXkNi8CGMu+YsRH8yedr/yB1lkg8jiJxHTK
 rqLlVn918E3BlxDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E83841388B;
 Wed, 29 Nov 2023 20:19:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id L2h3K8+cZ2XSPQAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 29 Nov 2023 20:19:27 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Hanna Czenczek <hreitz@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Markus Armbruster
 <armbru@redhat.com>, =?utf-8?Q?Jo=C3=A3o?= Silva <jsilva@suse.de>, Lin Ma
 <lma@suse.com>,
 Claudio Fontana <cfontana@suse.de>, Dario Faggioli <dfaggioli@suse.com>,
 Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v2 09/10] block: Convert qmp_query_block() to coroutine_fn
In-Reply-To: <b1f840cc-82c7-4ff5-8ab8-38382e425181@redhat.com>
References: <20230609201910.12100-1-farosas@suse.de>
 <20230609201910.12100-10-farosas@suse.de>
 <b1f840cc-82c7-4ff5-8ab8-38382e425181@redhat.com>
Date: Wed, 29 Nov 2023 17:19:25 -0300
Message-ID: <87wmu09usy.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-2.91 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_SPAM_SHORT(1.19)[0.397];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
X-Spam-Score: -2.91
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:1;
 envelope-from=farosas@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Hanna Czenczek <hreitz@redhat.com> writes:

> On 09.06.23 22:19, Fabiano Rosas wrote:
>> This is another caller of bdrv_get_allocated_file_size() that needs to
>> be converted to a coroutine because that function will be made
>> asynchronous when called (indirectly) from the QMP dispatcher.
>>
>> This QMP command is a candidate because it calls bdrv_do_query_node_info=
(),
>> which in turn calls bdrv_get_allocated_file_size().
>>
>> We've determined bdrv_do_query_node_info() to be coroutine-safe (see
>> previous commits), so we can just put this QMP command in a coroutine.
>>
>> Since qmp_query_block() now expects to run in a coroutine, its callers
>> need to be converted as well. Convert hmp_info_block(), which calls
>> only coroutine-safe code, including qmp_query_named_block_nodes()
>> which has been converted to coroutine in the previous patches.
>>
>> Now that all callers of bdrv_[co_]block_device_info() are using the
>> coroutine version, a few things happen:
>>
>>   - we can return to using bdrv_block_device_info() without a wrapper;
>>
>>   - bdrv_get_allocated_file_size() can stop being mixed;
>>
>>   - bdrv_co_get_allocated_file_size() needs to be put under the graph
>>     lock because it is being called wthout the wrapper;
>>
>>   - bdrv_do_query_node_info() doesn't need to acquire the AioContext
>>     because it doesn't call aio_poll anymore;
>>
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> ---
>>   block.c                        |  2 +-
>>   block/monitor/block-hmp-cmds.c |  2 +-
>>   block/qapi.c                   | 18 +++++++++---------
>>   hmp-commands-info.hx           |  1 +
>>   include/block/block-hmp-cmds.h |  2 +-
>>   include/block/block-io.h       |  2 +-
>>   include/block/qapi.h           | 12 ++++--------
>>   qapi/block-core.json           |  2 +-
>>   8 files changed, 19 insertions(+), 22 deletions(-)
>
> After this series has been sent, we got some usages of=20
> GRAPH_RDLOCK_GUARD_MAINLOOP() that no longer fit with this patch =E2=80=
=93 I=E2=80=99ve=20
> also mentioned one case on patch 7, not yet realizing that this was a=20
> new thing.=C2=A0 Those must now be fixed (e.g. in qmp_query_block(), or i=
n=20
> bdrv_snapshot_list()), or they=E2=80=99ll crash.

Hi, thanks for the reviews!

Yes, there's been a lot of changes since this series was sent. I'll
rebase it and re-evaluate. Stefan just sent an AioContext series which
will probably help bring the complexity of down for this series. Let's
see how it goes.

