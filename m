Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5397A08B3
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:11:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgnyz-0005RH-C6; Thu, 14 Sep 2023 11:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgnyv-0005L2-6i
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:10:15 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgnyr-0007J0-S5
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:10:12 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 392371F750;
 Thu, 14 Sep 2023 15:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694704208; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Osxso0dUols1dfJiET/+UkCUDHeL0h7y3jNGQPYbcBU=;
 b=dRB1nSa9hW9lV6JMZifScn1yf0GzFYPpzrdGbn7nkbd63NnmNvrCgBuzhGrYjMXo8gg3+U
 WlHx/KSXpu5MPL669BfYIy0/Mw/2ln52ytI6wnFyKhYFPwN/08wvyscDiToxiGwYcWeViQ
 gNCLV86Tj8unMfiiDxepWrLGQXZBNj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694704208;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Osxso0dUols1dfJiET/+UkCUDHeL0h7y3jNGQPYbcBU=;
 b=hYW7i6nXn7wAdcICpwb1ZdszSqzKbKfoCo42vqSbGO8yCxobZfeERSnrCuV4ZoWjUG/VQ0
 y/C/nUdC47EJq9Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A65CC13580;
 Thu, 14 Sep 2023 15:10:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id oI5lGU8iA2UpCwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 14 Sep 2023 15:10:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <ZQMfIO3oiqTsawtU@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n>
Date: Thu, 14 Sep 2023 12:10:04 -0300
Message-ID: <87edj0kcz7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.29; envelope-from=farosas@suse.de;
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Sep 13, 2023 at 04:42:31PM -0300, Fabiano Rosas wrote:
>> Stefan Hajnoczi <stefanha@redhat.com> writes:
>>=20
>> > Hi,
>> > The following intermittent failure occurred in the CI and I have filed
>> > an Issue for it:
>> > https://gitlab.com/qemu-project/qemu/-/issues/1886
>> >
>> > Output:
>> >
>> >   >>> QTEST_QEMU_IMG=3D./qemu-img MALLOC_PERTURB_=3D116 QTEST_QEMU_STO=
RAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMO=
N=3D/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINAR=
Y=3D./qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/migrat=
ion-test --tap -k
>> >   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95
>> >   stderr:
>> >   qemu-system-x86_64: Unable to read from socket: Connection reset by =
peer
>> >   Memory content inconsistency at 5b43000 first_byte =3D bd last_byte =
=3D bc current =3D 4f hit_edge =3D 1
>> >   **
>> >   ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertio=
n failed: (bad =3D=3D 0)
>> >   (test program exited with status code -6)
>> >
>> > You can find the full output here:
>> > https://gitlab.com/qemu-project/qemu/-/jobs/5080200417
>>=20
>> This is the postcopy return path issue that I'm addressing here:
>>=20
>> https://lore.kernel.org/r/20230911171320.24372-1-farosas@suse.de
>> Subject: [PATCH v6 00/10] Fix segfault on migration return path
>> Message-ID: <20230911171320.24372-1-farosas@suse.de>
>
> Hmm I just noticed one thing, that Stefan's failure is a ram check issue
> only, which means qemu won't crash?
>

The source could have crashed and left the migration at an inconsistent
state and then the destination saw corrupted memory?

> Fabiano, are you sure it's the same issue on your return-path fix?
>

I've been running the preempt tests on my branch for thousands of
iterations and didn't see any other errors. Since there's no code going
into the migration tree recently I assume it's the same error.

I run the tests with GDB attached to QEMU, so I'll always see a crash
before any memory corruption.

> I'm also trying to reproduce either of them with some loads.  I think I h=
it
> some but it's very hard to reproduce solidly.

Well, if you find anything else let me know and we'll fix it.

