Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1DD829CBD
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 15:43:15 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNZmm-0004ok-35; Wed, 10 Jan 2024 09:42:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNZmj-0004oG-IO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 09:42:25 -0500
Received: from smtp-out1.suse.de ([2a07:de40:b251:101:10:150:64:1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rNZmh-0004Xr-T9
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 09:42:25 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8576121D10;
 Wed, 10 Jan 2024 14:42:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704897741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMyz/S/2QLSbHXMX3Jhe/vKYVlCvWteWyykfrZKEC+4=;
 b=bhy/ncx2ebbtAGNPgOQe1720w04FsQx+HSUuE2muXamlIWwn76cT/BSHYW+ndv3Yyi/4+Y
 uUGSTzML0eIZ/wt+VG6ICydcZF9ZeWYcO527ULsLdloUenysWSWcyKlM6057ofW+FQSERB
 tYtbEqISucseASRc1PwTmi8sssSYyO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704897741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMyz/S/2QLSbHXMX3Jhe/vKYVlCvWteWyykfrZKEC+4=;
 b=q92o+trF/npREN7wnyO24KHtLCndWvjQmojq7Z5pdxHTAx2B7HivX8PEfTIbHFz9YzW2vQ
 V5GovqV+egyAmdDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704897741; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMyz/S/2QLSbHXMX3Jhe/vKYVlCvWteWyykfrZKEC+4=;
 b=bhy/ncx2ebbtAGNPgOQe1720w04FsQx+HSUuE2muXamlIWwn76cT/BSHYW+ndv3Yyi/4+Y
 uUGSTzML0eIZ/wt+VG6ICydcZF9ZeWYcO527ULsLdloUenysWSWcyKlM6057ofW+FQSERB
 tYtbEqISucseASRc1PwTmi8sssSYyO8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704897741;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eMyz/S/2QLSbHXMX3Jhe/vKYVlCvWteWyykfrZKEC+4=;
 b=q92o+trF/npREN7wnyO24KHtLCndWvjQmojq7Z5pdxHTAx2B7HivX8PEfTIbHFz9YzW2vQ
 V5GovqV+egyAmdDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0C7601398A;
 Wed, 10 Jan 2024 14:42:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XXraMMysnmUIIAAAD6G6ig
 (envelope-from <farosas@suse.de>); Wed, 10 Jan 2024 14:42:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, =?utf-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>
Subject: Re: [PATCH v3 4/4] [NOT FOR MERGE] tests/qtest/migration: Adapt
 tests to use older QEMUs
In-Reply-To: <ZZ4YOw6Cy5EYo_f4@x1n>
References: <20240105180449.11562-1-farosas@suse.de>
 <20240105180449.11562-5-farosas@suse.de> <ZZuvDREDrQ07HsGs@x1n>
 <877ckj3kfp.fsf@suse.de> <ZZzC1n0GotQZukqJ@x1n> <87zfxe7eev.fsf@suse.de>
 <ZZ4YOw6Cy5EYo_f4@x1n>
Date: Wed, 10 Jan 2024 11:42:18 -0300
Message-ID: <87zfxd6yid.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="bhy/ncx2";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=q92o+trF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 TO_DN_SOME(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_COUNT_THREE(0.00)[3]; DKIM_TRACE(0.00)[suse.de:+];
 MX_GOOD(-0.01)[]; RCPT_COUNT_SEVEN(0.00)[7];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_MATCH_FROM(0.00)[];
 BAYES_HAM(-3.00)[100.00%]; ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; RCVD_TLS_ALL(0.00)[]
X-Spam-Score: -4.51
X-Rspamd-Queue-Id: 8576121D10
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

Peter Xu <peterx@redhat.com> writes:

> On Tue, Jan 09, 2024 at 11:46:32AM -0300, Fabiano Rosas wrote:
>> Hm, it would be better to avoid the extra maintenance task at the start
>> of every release, no? It also blocks us from doing n-2 even
>> experimentally.
>
> See my other reply, on whether we can use "n-1" for migration-test.  If
> that can work for us, then IIUC we can avoid either "since:" or any
> relevant flag, neither do we need to unmask tests after each releases.  All
> old tests should always "just work" with a new qemu binary.

Hmm.. There are some assumptions here:

1) New code will always be compatible with old tests. E.g. some
   patchseries changed code and changed a test to match the new
   code. Then we'd need a flag like 'since' anyway to mark that the new
   QEMU cannot be used with the old test.

   (if new QEMU is not compatible with old tests without any good
   reason, then that's just a regression I think)

2) There would not be issues when fixing bugs/refactoring
   tests. E.g. old tests had a bug that is now fixed, but since we're
   not using the new tests, the bug is always there until next
   release. This could block the entire test suite, specially with
   concurrency bugs which can start triggering due to changes in timing.

3) New code that can only be reached via new tests cannot cause
   regressions. E.g. new code is added but is kept under a machine
   property or migration capability. That code will only show the
   regression after the new test enables that cap/property. At that
   point it's too late because it was already released.

In general I like the simplicity of your approach, but it would be
annoying to change this series only to find out we still need some sort
of flag later. Even worse, #3 would miss the point of this kind of
testing entirely.

#1 could be mitigated by a "no changes to tests rule". We'd start
requiring that new tests be written and an existing test is never
altered. For #2 and #3 I don't have a solution.

