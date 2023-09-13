Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F82A79F24A
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 21:44:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgVlO-000798-BM; Wed, 13 Sep 2023 15:43:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgVlK-00077Y-Ka
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:42:58 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qgVl5-0000Cz-9U
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 15:42:58 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D14F321886;
 Wed, 13 Sep 2023 19:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1694634154; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f01QA1azbWEuKe4UQkyLp8pFNmoA9Vh72SF3DmIUazU=;
 b=bwM+RbGp8J8EDxU5T6IOTWrzWo0hqxaSaG+8XFp3lvVoS6clOE+7V1MkwLfhT/iklCiKVa
 Czgc8P5IfmXnj6DjwfFLTsVWdoLJbG99OYCIkbiNvWoTXKL+hTa51yKR8Jpl/c7pzGODlO
 FYGe4mS5sM1NZUFpVRbXpb1vDR+9v5o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1694634154;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=f01QA1azbWEuKe4UQkyLp8pFNmoA9Vh72SF3DmIUazU=;
 b=+TYY9Qd/EhzhJrNApFLerwxMpy5RSDYqkjK+aAhcHFlVRhndCuzHhgB2Do+ArTNGk3XpQA
 qUYijgCaNI5FnIAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4D8BB13440;
 Wed, 13 Sep 2023 19:42:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6X+LA6oQAmUMcwAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 13 Sep 2023 19:42:34 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Stefan Hajnoczi <stefanha@redhat.com>, Juan Quintela
 <quintela@redhat.com>, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: QEMU migration-test CI intermittent failure
In-Reply-To: <20230913192301.GA917052@fedora>
References: <20230913192301.GA917052@fedora>
Date: Wed, 13 Sep 2023 16:42:31 -0300
Message-ID: <87r0n1kggo.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:67c:2178:6::1c; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

Stefan Hajnoczi <stefanha@redhat.com> writes:

> Hi,
> The following intermittent failure occurred in the CI and I have filed
> an Issue for it:
> https://gitlab.com/qemu-project/qemu/-/issues/1886
>
> Output:
>
>   >>> QTEST_QEMU_IMG=3D./qemu-img MALLOC_PERTURB_=3D116 QTEST_QEMU_STORAG=
E_DAEMON_BINARY=3D./storage-daemon/qemu-storage-daemon G_TEST_DBUS_DAEMON=
=3D/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh QTEST_QEMU_BINARY=
=3D./qemu-system-x86_64 /builds/qemu-project/qemu/build/tests/qtest/migrati=
on-test --tap -k
>   =E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95 =E2=9C=80  =E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=
=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=
=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=E2=80=95=
=E2=80=95
>   stderr:
>   qemu-system-x86_64: Unable to read from socket: Connection reset by peer
>   Memory content inconsistency at 5b43000 first_byte =3D bd last_byte =3D=
 bc current =3D 4f hit_edge =3D 1
>   **
>   ERROR:../tests/qtest/migration-test.c:300:check_guests_ram: assertion f=
ailed: (bad =3D=3D 0)
>   (test program exited with status code -6)
>
> You can find the full output here:
> https://gitlab.com/qemu-project/qemu/-/jobs/5080200417

This is the postcopy return path issue that I'm addressing here:

https://lore.kernel.org/r/20230911171320.24372-1-farosas@suse.de
Subject: [PATCH v6 00/10] Fix segfault on migration return path
Message-ID: <20230911171320.24372-1-farosas@suse.de>

