Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ED3FA7C4DD
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Apr 2025 22:28:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u0ncY-0003jP-2S; Fri, 04 Apr 2025 16:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0ncV-0003ix-PH
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 16:26:31 -0400
Received: from smtp-out2.suse.de ([2a07:de40:b251:101:10:150:64:2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1u0ncO-0007m4-Uw
 for qemu-devel@nongnu.org; Fri, 04 Apr 2025 16:26:31 -0400
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C860B1F385;
 Fri,  4 Apr 2025 20:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743798379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81DisTSNMAFPiUwB6tyb2VFUV+gb/wlkzdSznIfbMbI=;
 b=nigxdKPiVzPhRTYy7jQmkLyfcmITac21SLTHTrw+4s2BGa+ttQ2RhxMWZEgLUyA5lPdsxc
 vGXZz/eH1jZCp//mrxGFPr+NSYIjBK/nrVYUTDRPcr3nMBWeGBj3fz8sNCvXwWDawPvlwI
 TJLXGx8HjmUD5FsVonlxLiwuSf5hCRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743798379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81DisTSNMAFPiUwB6tyb2VFUV+gb/wlkzdSznIfbMbI=;
 b=8MISIcNVL/b7PLjP0jebttc/b/71QehNhEeK4vnPBbniqqzZ7utAwAjrDgIqFEf+jVBH8+
 ioxEaScXTqEyUrCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1743798379; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81DisTSNMAFPiUwB6tyb2VFUV+gb/wlkzdSznIfbMbI=;
 b=nigxdKPiVzPhRTYy7jQmkLyfcmITac21SLTHTrw+4s2BGa+ttQ2RhxMWZEgLUyA5lPdsxc
 vGXZz/eH1jZCp//mrxGFPr+NSYIjBK/nrVYUTDRPcr3nMBWeGBj3fz8sNCvXwWDawPvlwI
 TJLXGx8HjmUD5FsVonlxLiwuSf5hCRM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1743798379;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=81DisTSNMAFPiUwB6tyb2VFUV+gb/wlkzdSznIfbMbI=;
 b=8MISIcNVL/b7PLjP0jebttc/b/71QehNhEeK4vnPBbniqqzZ7utAwAjrDgIqFEf+jVBH8+
 ioxEaScXTqEyUrCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AEC01364F;
 Fri,  4 Apr 2025 20:26:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 8G1dOmpA8GdpTQAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 04 Apr 2025 20:26:18 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Prasad Pandit
 <ppandit@redhat.com>, Juraj Marcin <jmarcin@redhat.com>, Marco Cavenati
 <Marco.Cavenati@eurecom.fr>
Subject: Re: [PATCH 1/4] migration/savevm: Add a compatibility check for
 capabilities
In-Reply-To: <875xjua4pe.fsf@suse.de>
References: <20250327143934.7935-1-farosas@suse.de>
 <20250327143934.7935-2-farosas@suse.de> <Z-Vms2l4jZ_eV-aa@redhat.com>
 <875xjua4pe.fsf@suse.de>
Date: Fri, 04 Apr 2025 17:26:16 -0300
Message-ID: <87semnk713.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.996]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_COUNT_TWO(0.00)[2];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email, suse.de:mid,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -4.30
Received-SPF: pass client-ip=2a07:de40:b251:101:10:150:64:2;
 envelope-from=farosas@suse.de; helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>
>> On Thu, Mar 27, 2025 at 11:39:31AM -0300, Fabiano Rosas wrote:
>>> It has always been possible to enable arbitrary migration capabilities
>>> and attempt to take a snapshot of the VM with the savevm/loadvm
>>> commands as well as their QMP counterparts
>>> snapshot-save/snapshot-load.
>>>=20
>>> Most migration capabilities are not meant to be used with snapshots
>>> and there's a risk of crashing QEMU or producing incorrect
>>> behavior. Ideally, every migration capability would either be
>>> implemented for savevm or explicitly rejected.
>>
>> IMHO, this a prime example of why migration config shouldn't be held
>> as global state, and instead passed as parameters to the commands
>> that need them.  The snapshot-save/load commands would then only
>> be able to accept what few settings are actually relevant, instead
>> of inheriting any/all global migration state.
>>
>
> Right, I remember we got caught around the fact that some migration
> options are needed during runtime as well... but I don't remember the
> details, let try to find that thread.
>

Found it: https://lore.kernel.org/r/ZVM5xmsaE41WJYgb@redhat.com

I don't think it's *too* hard to start passing the configuration to
qmp_migrate & friends. We just need to figure out a path for the
compatibility.

I'm thiking of:

1) Unifying capabilities and parameters in a MigrationConfig
structure. We take the opportunity to fix the tls options to 'str'
instead of StrOrNull.

2) Deprecate migrate-set-capabilities. There are no capabilities
anymore.

3) Deprecate migate-set-parameters. There are no parameters
anymore. Alternatively, reuse the existing command, but have it take the
additional capabilities as optional (everything else is already
optional).

4) Depending on what we do on (3), add a new migrate-set-config command
that sets every option. All as optional. This would be nice because we
wouldn't need to worry about breaking compat on the tls options, we just
define the new command in the correct way.

5) Add a {'*config': MigrationConfig} entry to qmp_migrate and
migrate_set_{config|parameters}. Here is where I have questions, because
ideally we'd have a way to limit the migrate_set_config command to only
the options that can be set at runtime. But I can't see a way of doing
that without the duplication of the options in the QAPI .json file. I'm
inclined to allow the whole set of options and do some tracking on the
side in options.c in the migration code.

(same issue for savevm really. To allow it to (say) work with
mapped-ram, we'd need a duplicate mapped-ram entry in migration.json)

About (2) and (3). If we use this unified MigrationConfig, I can keep
the old commands working (along with the query_* variants), by defining
a compat function that converts from those commands specific format into
the new format. But then there's the question of what do we do when a
new capability/parameter comes along? Can we declare that the old
commands will not see the new data and that's it? If there's no
distinction between caps and params anymore, there isn't even a way to
decide which command to use.

>>> Add a compatibility check routine and reject the snapshot command if
>>> an incompatible capability is enabled. For now only act on the the
>>> two that actually cause a crash: multifd and mapped-ram.
>>>=20
>>> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2818
>>
>> Issue is 2881 not 2818                                   ^^^^^^^
>>
>
> It seem that was your own C-t =3D)
>
>>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>>> ---
>>>  migration/options.c | 26 ++++++++++++++++++++++++++
>>>  migration/options.h |  1 +
>>>  migration/savevm.c  |  8 ++++++++
>>>  3 files changed, 35 insertions(+)
>>
>> With regards,
>> Daniel

