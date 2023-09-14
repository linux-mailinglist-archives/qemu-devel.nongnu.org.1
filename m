Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B93D97A09EB
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 17:57:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgoiV-0000yE-4D; Thu, 14 Sep 2023 11:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgoiT-0000on-18
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:57:17 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgoiQ-0000sQ-QX
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 11:57:16 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 27DBE2185C;
 Thu, 14 Sep 2023 15:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694707032; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EfFdZEuonjM68bai/z8oQRcqO0fqJKYCMVwwzvWZhg=;
 b=qRxLtpERNQRWUU9nbdK8xH3YE/gi7vmchGLVYfyBk+GX7Pv2GXjv0yG7vUBZK5Hi6p951x
 bdSWyBYf+INPB1WyNRPKgtHGyWN7trphjVvmGy3UwoA9wtpQidi6BOCZ6Kjzn3ABEeTY4U
 QDO7VoZCENdvd/gnI6+BiADdnJuhygM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694707032;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7EfFdZEuonjM68bai/z8oQRcqO0fqJKYCMVwwzvWZhg=;
 b=9yY6D7s1OQ1Hy9/fr2GJdR+mysPrxe9r5dTxuO6DPHuzpsOGRti6G64SCgM2XgwlFWKr+e
 DDcdAKUROYrtkOCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 96DD113580;
 Thu, 14 Sep 2023 15:57:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5mV5FVctA2VzIwAAMHmgww
 (envelope-from <farosas@suse.de>); Thu, 14 Sep 2023 15:57:11 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <ZQMoUzRH1BZKs39g@x1n>
References: <20230913192301.GA917052@fedora> <87r0n1kggo.fsf@suse.de>
 <ZQMfIO3oiqTsawtU@x1n> <87edj0kcz7.fsf@suse.de> <ZQMoUzRH1BZKs39g@x1n>
Date: Thu, 14 Sep 2023 12:57:08 -0300
Message-ID: <87bke4kasr.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Thu, Sep 14, 2023 at 12:10:04PM -0300, Fabiano Rosas wrote:
>> Peter Xu <peterx@redhat.com> writes:
>>=20
>> > On Wed, Sep 13, 2023 at 04:42:31PM -0300, Fabiano Rosas wrote:
>> >> Stefan Hajnoczi <stefanha@redhat.com> writes:
>> >>=20
>> >> > Hi,
>> >> > The following intermittent failure occurred in the CI and I have fi=
led
>> >> > an Issue for it:
>> >> > https://gitlab.com/qemu-project/qemu/-/issues/1886
>> >> >
>> >> > Output:
>> >> >
>> >> >   >>> QTEST_QEMU_IMG=3D./qemu-img MALLOC_PERTURB_=3D116 QTEST_QEMU_=
STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DA=
EMON=3D/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BI=
NARY=3D./qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/mig=
ration-test --tap -k
>> >> >   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95
>> >> >   stderr:
>> >> >   qemu-system-x86_64: Unable to read from socket: Connection reset =
by peer
>> >> >   Memory content inconsistency at 5b43000 first_byte =3D bd last_by=
te =3D bc current =3D 4f hit_edge =3D 1
>> >> >   **
>> >> >   ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: asser=
tion failed: (bad =3D=3D 0)
>> >> >   (test program exited with status code -6)
>> >> >
>> >> > You can find the full output here:
>> >> > https://gitlab.com/qemu-project/qemu/-/jobs/5080200417
>> >>=20
>> >> This is the postcopy return path issue that I'm addressing here:
>> >>=20
>> >> https://lore.kernel.org/r/20230911171320.24372-1-farosas@suse.de
>> >> Subject: [PATCH v6 00/10] Fix segfault on migration return path
>> >> Message-ID: <20230911171320.24372-1-farosas@suse.de>
>> >
>> > Hmm I just noticed one thing, that Stefan's failure is a ram check iss=
ue
>> > only, which means qemu won't crash?
>> >
>>=20
>> The source could have crashed and left the migration at an inconsistent
>> state and then the destination saw corrupted memory?
>>=20
>> > Fabiano, are you sure it's the same issue on your return-path fix?
>> >
>>=20
>> I've been running the preempt tests on my branch for thousands of
>> iterations and didn't see any other errors. Since there's no code going
>> into the migration tree recently I assume it's the same error.
>>=20
>> I run the tests with GDB attached to QEMU, so I'll always see a crash
>> before any memory corruption.
>
> Okay, maybe that stops you from seeing the above check_guests_ram() error?
> Worth checking whether it fails differently always if you just don't atta=
ch
> gdb to it; I had a feeling that it'll always fail in the other way (I thi=
nk
> migration-test will say something like "qemu killed" etc. in most cases),
> further to identify the issues.
>
>>=20
>> > I'm also trying to reproduce either of them with some loads.  I think =
I hit
>> > some but it's very hard to reproduce solidly.
>>=20
>> Well, if you find anything else let me know and we'll fix it.
>
> I think Stefan's issue is the one I triggered once, but only once; I did
> see check_guests_ram() lines.
>
> I ran concurrently 10 migration-tests (on 8 cores; just to make scheduler
> start to really work), each looping over preempt/plain for 500 times and
> hit nothing..  I'm trying again with a larger host with more instances, so
> far I've run 200 loops over 40 instances running together, I hit
> nothing.. but I'm keeping trying.

I managed to reproduce it. It's not the return path error. In hindsight
that's obvious because that error happens in the 'recovery' test and this
one in the 'plain' one. Sorry about the noise.

This one reproduced with just 4 iterations of preempt/plain. I'll
investigate.

