Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A50D19DE66F
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Nov 2024 13:28:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tH06N-0003bc-VF; Fri, 29 Nov 2024 07:28:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH06L-0003b8-H7
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 07:28:01 -0500
Received: from smtp-out2.suse.de ([195.135.223.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1tH06J-0008E8-5C
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 07:28:01 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E09E1F38F;
 Fri, 29 Nov 2024 12:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732883274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6Ue4MKmA9n9SMCII0nKZPRr+tlsxWupEt1VyDfNdQ=;
 b=0MqJjbvaJZe9Qv430fJ7GPrbttMssA44WZApWubTyOry5Lv3/plwpxIYYDeiuEFQ7QWQdF
 UpLpN/YJNZNoUx/Vh6qnjx3SN0KygLaYhkHLyMAlCj7S8/r0FdvEHUZC79LHp1MxPafRXF
 hSWY3wzaqyrzF/0PPSwENo6XcMfTe+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732883274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6Ue4MKmA9n9SMCII0nKZPRr+tlsxWupEt1VyDfNdQ=;
 b=KH+85nlv5CD1b8DTYRG80MwT0jCLEDvdQ44QY3JIjzh+2MT8yN7R5LV+g21bZKHIcQUHdB
 5ZaeUDxo+Ght8gBw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0MqJjbva;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=KH+85nlv
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1732883274; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6Ue4MKmA9n9SMCII0nKZPRr+tlsxWupEt1VyDfNdQ=;
 b=0MqJjbvaJZe9Qv430fJ7GPrbttMssA44WZApWubTyOry5Lv3/plwpxIYYDeiuEFQ7QWQdF
 UpLpN/YJNZNoUx/Vh6qnjx3SN0KygLaYhkHLyMAlCj7S8/r0FdvEHUZC79LHp1MxPafRXF
 hSWY3wzaqyrzF/0PPSwENo6XcMfTe+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1732883274;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/G6Ue4MKmA9n9SMCII0nKZPRr+tlsxWupEt1VyDfNdQ=;
 b=KH+85nlv5CD1b8DTYRG80MwT0jCLEDvdQ44QY3JIjzh+2MT8yN7R5LV+g21bZKHIcQUHdB
 5ZaeUDxo+Ght8gBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8AED1133F3;
 Fri, 29 Nov 2024 12:27:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id PTLBE0mzSWe0CwAAD6G6ig
 (envelope-from <farosas@suse.de>); Fri, 29 Nov 2024 12:27:53 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Yong Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, =?utf-8?Q?Daniel?=
 =?utf-8?Q?_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/5] Guestperf: miscellaneous refinement and enrichment
In-Reply-To: <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
References: <cover.1729562974.git.yong.huang@smartx.com>
 <87sesmdfl4.fsf@suse.de>
 <CAK9dgmZvj4W2EBxp1_TcdYs3q2aqaRZGZCAk=FRJk-PaB9y_fw@mail.gmail.com>
Date: Fri, 29 Nov 2024 09:27:50 -0300
Message-ID: <87v7w6jkc9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0E09E1F38F
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MID_RHS_MATCH_FROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
Received-SPF: pass client-ip=195.135.223.131; envelope-from=farosas@suse.de;
 helo=smtp-out2.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Yong Huang <yong.huang@smartx.com> writes:

> On Wed, Oct 23, 2024 at 11:06=E2=80=AFPM Fabiano Rosas <farosas@suse.de> =
wrote:
>
>> yong.huang@smartx.com writes:
>>
>> > From: Hyman Huang <yong.huang@smartx.com>
>> >
>> > v3:
>> > 1. Remove the two redundant assignments in [PATCH v2 2/5] suggested by
>> Daniel
>> >
>> > Please review, thanks
>> > Yong
>> >
>> > v2:
>> > 1. Update the MAINTAINERS section suggested by Fabiano Rosas
>> > 2. Ensure the dependencies when build the initrd-stress.img suggested =
by
>> Daniel
>> > 3. Fix some bugs
>> >
>> > v1:
>> > The previous patchset:
>> >
>> https://lore.kernel.org/qemu-devel/cover.1722957352.git.yong.huang@smart=
x.com/
>> > does not made the necessary changes and tests for the upstream version.
>> >
>> > This patchset works for that:
>> > 1. Move the guestperf to scripts directory suggested by Fabiano Rosas
>> > 2. Make initrd-stress.img built by default suggested by Fabiano Rosas
>> > 3. Make the necessary changes to adapt the latest multifd behavior
>> > 4. A nitpick for multifd migration
>> > 5. Support multifd compression option
>> >
>> > Hyman Huang (5):
>> >   tests/migration: Move the guestperf tool to scripts directory
>> >   tests/migration: Make initrd-stress.img built by default
>> >   guestperf: Support deferred migration for multifd
>> >   guestperf: Nitpick the inconsistent parameters
>> >   guestperf: Introduce multifd compression option
>> >
>> >  MAINTAINERS                                   |  5 +++
>> >  .../migration/guestperf-batch.py              |  0
>> >  .../migration/guestperf-plot.py               |  0
>> >  {tests =3D> scripts}/migration/guestperf.py     |  0
>> >  .../migration/guestperf/__init__.py           |  0
>> >  .../migration/guestperf/comparison.py         | 15 ++++++++-
>> >  .../migration/guestperf/engine.py             | 33 ++++++++++++++++---
>> >  .../migration/guestperf/hardware.py           |  0
>> >  .../migration/guestperf/plot.py               |  0
>> >  .../migration/guestperf/progress.py           |  0
>> >  .../migration/guestperf/report.py             |  0
>> >  .../migration/guestperf/scenario.py           |  7 ++--
>> >  .../migration/guestperf/shell.py              |  3 ++
>> >  .../migration/guestperf/timings.py            |  0
>> >  tests/migration/meson.build                   | 30 +++++++++--------
>> >  15 files changed, 73 insertions(+), 20 deletions(-)
>> >  rename {tests =3D> scripts}/migration/guestperf-batch.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf-plot.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf/__init__.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf/comparison.py (89%)
>> >  rename {tests =3D> scripts}/migration/guestperf/engine.py (93%)
>> >  rename {tests =3D> scripts}/migration/guestperf/hardware.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf/plot.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf/progress.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf/report.py (100%)
>> >  rename {tests =3D> scripts}/migration/guestperf/scenario.py (93%)
>> >  rename {tests =3D> scripts}/migration/guestperf/shell.py (98%)
>> >  rename {tests =3D> scripts}/migration/guestperf/timings.py (100%)
>>
>> Reviewed-by: Fabiano Rosas <farosas@suse.de>
>>
>>
>> Thinking out loud a little bit, it's still somewhat obscure from which
>> directory this script should be called. None of these invocations work:
>>
>> $ ./scripts/migration/guestperf.py
>>
>> $ ./build/scripts/migration/guestperf.py
>>
>> $ cd scripts/migration
>> $ ./guestperf.py
>>
>> $ cd build/scripts/migration
>> $ ./guestperf.py
>>
>> Failed to open file =E2=80=9Ctests/migration/initrd-stress.img=E2=80=9D:=
 open() failed:
>> No such file or directory
>>
>> This is the only one that works:
>> $ cd build
>> $ ./scripts/migration/guestperf.py
>>
>> Maybe we could improve that somehow in the future.
>>
>>
> This patchset could be queued now,
> Or after refining the documents mentioned above later?

I think it's ok. Let me just rebase this on top of the other series that
touches the tests/migration/ directory. I'll repost soon.

