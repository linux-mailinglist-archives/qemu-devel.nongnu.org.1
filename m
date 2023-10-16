Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 656FB7CA735
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 13:55:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsMBp-0002rr-BI; Mon, 16 Oct 2023 07:55:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMBn-0002qq-QZ
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:55:15 -0400
Received: from oxygen.pond.sub.org ([94.130.129.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@pond.sub.org>)
 id 1qsMBl-0005Iv-He
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 07:55:15 -0400
Received: from blackfin.pond.sub.org (p4fd04c8c.dip0.t-ipconnect.de
 [79.208.76.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (Client did not present a certificate)
 by oxygen.pond.sub.org (Postfix) with ESMTPSA id 99C6726A3A;
 Mon, 16 Oct 2023 14:13:38 +0200 (CEST)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 17EDE21E6A1F; Mon, 16 Oct 2023 13:55:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Fabiano
 Rosas <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PATCH v3 0/4] qapi/migration: Dedup migration parameter
 objects and fix tls-authz crash
In-Reply-To: <20230905162335.235619-1-peterx@redhat.com> (Peter Xu's message
 of "Tue, 5 Sep 2023 12:23:31 -0400")
Date: Mon, 16 Oct 2023 09:08:40 +0200
Lines: 63
References: <20230905162335.235619-1-peterx@redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Message-ID: <87h6mqixya.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=94.130.129.15; envelope-from=armbru@pond.sub.org;
 helo=oxygen.pond.sub.org
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Let me try to summarize our findings so far.

PATCH 1 has been merged.  PATCH 2 has been queued, but not merged (not
sure why, accident?).

The remaining two are the actual de-triplication:

PATCH 3: Fuse MigrationParameters and MigrateSetParameters

PATCH 4: De-document MigrationParameter

The latter is a much simpler problem, so let's discuss it first.


Enum MigrationParameter is used only internally.  It's in the QAPI
schema just because we want code generated for it.  It shouldn't be
documented in the QEMU QMP Reference Manual, but is, because the
generator is too stupid to elide internal-only stuff.

PATCH 4 moves it out of the schema.  It has to add back the lost
generated code in hand-written form, which is a bit unfortunate.  I
proposed to instead drop most of the useless doc comment by exploiting a
QAPI generator loophole.

Aside: the QAPI generator should elide internal-only stuff from the QEMU
QMP Reference manual, and it should not require doc comments then.
Future work, let's not worry about it now.


The fusing of MigrationParameters and MigrateSetParameters is kind of
stuck.  Several options, all with drawbacks or problems:

1. Pick StrOrNull for the tls_FOO members

   This is what PATCH 3 does.  Blocked on the pre-existing class of
   crash bugs discussed in

    Subject: QAPI string visitors crashes
    Message-ID: <875y3epv3y.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/875y3epv3y.fsf@pond.sub.org/

   Needs fixing, but when a fix will be available is unclear.

2. Pick str for the tls_FOO members

   This is what v1 did.  Incompatible change: JSON null no longer works.
   Libvirt doesn't use it (it uses deprecated "" instead), but we cannot
   know for sure nothing else out there uses it.

   I don't think reducing development friction (that's what
   de-duplication accomplishes) justifies breaking our compatibility
   promise.

   To keep the promise, we'd have to deprecate null, un-deprecate "",
   let the grace period pass, and only then de-duplicate.

3. Do nothing, live with the duplication

   Giving up like this would be sad.  Unless we commit to a more
   complete overhaul of migration's QAPI/QMP configuration interface,
   but I doubt we're ready for that.

Thoughts?

