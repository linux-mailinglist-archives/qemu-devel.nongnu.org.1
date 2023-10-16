Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E97CB4A8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 22:33:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsUFt-0008Mv-4T; Mon, 16 Oct 2023 16:32:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qsUFr-0008Mg-LK; Mon, 16 Oct 2023 16:31:59 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>)
 id 1qsUFp-0001Rx-SB; Mon, 16 Oct 2023 16:31:59 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7C3251FED0;
 Mon, 16 Oct 2023 20:31:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697488315; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fal29ynbjegFpTkwCERYvdV7hDj2+Y487dDihvY24dE=;
 b=TJWeNd5Ww6+pmJ3nYJf1u0uF0r9WgtlasPyIAtEtNCII2hZ4YC/QJdiHoRfLdwlJEcsfWb
 e2KknUxKWJrMUCMwQ6s69cdNts/bCvSwtn1fZ/2KbE0KGYM330rmijhIZvMOJqJgNakkMb
 DiSoXfPYUAuatsQRmnl/SCp+M6CUG+s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697488315;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fal29ynbjegFpTkwCERYvdV7hDj2+Y487dDihvY24dE=;
 b=hCLhNQ5W38xZ8ynSqvd593yY4O/Eamev9K1pHrkO9ACpLeAY10bRsg+42F6ef7Kfqy8DYz
 Oe2jw/vF/RMr7KBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E093B138EF;
 Mon, 16 Oct 2023 20:31:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6FAmJ7qdLWWnFQAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 16 Oct 2023 20:31:54 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Vladimir
 Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, Fam Zheng
 <fam@euphon.net>, Cleber Rosa <crosa@redhat.com>, Eric Blake
 <eblake@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, Peter Xu
 <peterx@redhat.com>, Markus Armbruster <armbru@redhat.com>, John Snow
 <jsnow@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Thomas Huth
 <thuth@redhat.com>
Subject: Re: [PULL 00/38] Migration 20231016 patches
In-Reply-To: <CAJSP0QVaUrcpNT8qPM_4s6=OO3N0XA-nK68scoQYrbqavYZZoQ@mail.gmail.com>
References: <20231016100706.2551-1-quintela@redhat.com>
 <CAJSP0QXkTvJnioak5X1Ya3CC6LmiriFqYhyUV+AJ4=JS4SK97w@mail.gmail.com>
 <87wmvmze0g.fsf@suse.de>
 <CAJSP0QVaUrcpNT8qPM_4s6=OO3N0XA-nK68scoQYrbqavYZZoQ@mail.gmail.com>
Date: Mon, 16 Oct 2023 17:31:51 -0300
Message-ID: <87o7gyz4ug.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Score: -6.82
X-Spamd-Result: default: False [-6.82 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-2.73)[98.80%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_HAM_LONG(-3.00)[-1.000];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; RCPT_COUNT_TWELVE(0.00)[17];
 FREEMAIL_TO(0.00)[gmail.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; MID_RHS_MATCH_FROM(0.00)[]
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

Stefan Hajnoczi <stefanha@gmail.com> writes:

> On Mon, 16 Oct 2023 at 13:13, Fabiano Rosas <farosas@suse.de> wrote:
>>
>> Stefan Hajnoczi <stefanha@gmail.com> writes:
>>
>> > On Mon, 16 Oct 2023 at 06:11, Juan Quintela <quintela@redhat.com> wrot=
e:
>> >>
>> >> The following changes since commit 63011373ad22c794a013da69663c03f129=
7a5c56:
>> >>
>> >>   Merge tag 'pull-riscv-to-apply-20231012-1' of https://github.com/al=
istair23/qemu into staging (2023-10-12 10:24:44 -0400)
>> >>
>> >> are available in the Git repository at:
>> >>
>> >>   https://gitlab.com/juan.quintela/qemu.git tags/migration-20231016-p=
ull-request
>> >>
>> >> for you to fetch changes up to f39b0f42753635b0f2d8b00a26d11bb197bf51=
e2:
>> >>
>> >>   migration/multifd: Clarify Error usage in multifd_channel_connect (=
2023-10-16 11:01:33 +0200)
>> >>
>> >> ----------------------------------------------------------------
>> >> Migration Pull request (20231016)
>> >>
>> >> In this pull request:
>> >> - rdma cleanups
>> >> - removal of QEMUFileHook
>> >> - test for analyze-migration.py
>> >> - test for multifd file
>> >> - multifd cleanups
>> >> - available switchover bandwidth
>> >> - lots of cleanups.
>> >>
>> >> CI: https://gitlab.com/juan.quintela/qemu/-/pipelines/1037878829
>> >>
>> >> Please, apply.
>> >
>> > This CI failure looks migration-related:
>> >
>> > MALLOC_PERTURB_=3D96
>> > PYTHON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build=
/pyvenv/bin/python3
>> > QTEST_QEMU_BINARY=3D./qemu-system-i386
>> > G_TEST_DBUS_DAEMON=3D/home/gitlab-runner/builds/-LCfcJ2T/0/qemu-projec=
t/qemu/tests/dbus-vmstate-daemon.sh
>> > QTEST_QEMU_IMG=3D./qemu-img
>> > QTEST_QEMU_STORAGE_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon
>> > /home/gitlab-runner/builds/-LCfcJ2T/0/qemu-project/qemu/build/tests/qt=
est/migration-test
>> > --tap -k
>> > =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80 =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
>> > stderr:
>> > **
>> > ERROR:../tests/qtest/migration-test.c:1969:file_offset_finish_hook:
>> > assertion failed (cpu_to_be32(*p) =3D=3D QEMU_VM_FILE_MAGIC): (3 =3D=3D
>> > 1363498573)
>>
>> That's the test for the file: transport which got merged in the last
>> PR. I'll look into it.
>
> I have dropped the 20231016 pull request for now and the tests passed
> without it. Maybe there is an interaction with the test you recently
> added and this pull request?

Sorry, I expressed myself poorly. The test _is_ what is breaking this
pull request. The feature was already merged and is working fine.

I commented with a fix on the patch that adds the test.

[PULL 11/38] tests/qtest: migration-test: Add tests for file-based
migration
https://lore.kernel.org/r/20231016100706.2551-12-quintela@redhat.com

