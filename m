Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A67A7C579B
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 16:59:50 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqagJ-00088P-Pc; Wed, 11 Oct 2023 10:59:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqagH-000881-9P
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:59:25 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qqagF-00021o-85
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 10:59:25 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 617351FE46;
 Wed, 11 Oct 2023 14:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1697036361; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFwhVCOyX56HFjAqM77F57+/J4GXaUtYwTf/if4R3Z4=;
 b=dRh+0HGRXvUAM2WSi+4UOojTThG4BIRuemPdCTPLNhv+3MbvXKk9F2bBjNxUChkZbDwZRL
 B/+t1JIk0p+1xIbqXpkUyoAownuJhoKt9FzpyF95GaU93iVrlZk8XlEDMmKZJIW+Jvo1tM
 0ahPETZQrGmzyorXAONH/Gq6RzVujvk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1697036361;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KFwhVCOyX56HFjAqM77F57+/J4GXaUtYwTf/if4R3Z4=;
 b=WFVrI9Y+YQidtusg9LfzpM0KJ4ykjkWLdCafb1OYsCWOvd5EukhxvQI8mTLIGoayNaMLb+
 d+sSy2S/98bXpABA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8AEF138EF;
 Wed, 11 Oct 2023 14:59:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id dnKJLEi4JmVbfQAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 11 Oct 2023 14:59:20 +0000
From: Fabiano Rosas <farosas@suse.de>
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Juan Quintela
 <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Leonardo Bras
 <leobras@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>, Thomas Huth
 <thuth@redhat.com>, Laurent
 Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 7/9] tests/qtest/migration: Define a machine for all
 architectures
In-Reply-To: <ZSa10rRmlqLCl+MX@redhat.com>
References: <20231006123910.17759-1-farosas@suse.de>
 <20231006123910.17759-8-farosas@suse.de> <87h6mx8c86.fsf@secure.mitica>
 <ZSa10rRmlqLCl+MX@redhat.com>
Date: Wed, 11 Oct 2023 11:59:18 -0300
Message-ID: <87edi119yx.fsf@suse.de>
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Oct 11, 2023 at 04:28:41PM +0200, Juan Quintela wrote:
>> Fabiano Rosas <farosas@suse.de> wrote:
>> > Stop relying on defaults and select a machine explicitly for every
>> > architecture.
>> >
>> > This is a prerequisite for being able to select machine types for
>> > migration using different QEMU binaries for source and destination.
>> >
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >  tests/qtest/migration-test.c | 11 ++++++++++-
>> >  1 file changed, 10 insertions(+), 1 deletion(-)
>> >
>> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c
>> > index 46f1c275a2..7c10ac925b 100644
>> > --- a/tests/qtest/migration-test.c
>> > +++ b/tests/qtest/migration-test.c
>> > @@ -746,6 +746,7 @@ static int test_migrate_start(QTestState **from, Q=
TestState **to,
>> >      const char *kvm_opts =3D NULL;
>> >      const char *arch =3D qtest_get_arch();
>> >      const char *memory_size;
>> > +    const char *machine;
>> >=20=20
>> >      if (args->use_shmem) {
>> >          if (!g_file_test("/dev/shm", G_FILE_TEST_IS_DIR)) {
>> > @@ -758,11 +759,13 @@ static int test_migrate_start(QTestState **from,=
 QTestState **to,
>> >      got_dst_resume =3D false;
>> >      if (strcmp(arch, "i386") =3D=3D 0 || strcmp(arch, "x86_64") =3D=
=3D 0) {
>> >          memory_size =3D "150M";
>> > +        machine =3D "pc";
>>=20
>> I would suggest:
>>=20
>>       if (strcmp(arch, "i386")) {
>>           machine =3D "pc";
>>       } else {
>>           machine =3D "q35";
>>       }
>>=20
>> New development is happening in q35, so I think this should be the more =
tested.
>>=20
>> > @@ -774,10 +777,12 @@ static int test_migrate_start(QTestState **from,=
 QTestState **to,
>> >                                        "'nvramrc=3Dhex .\" _\" begin %=
x %x "
>> >                                        "do i c@ 1 + i c! 1000 +loop .\=
" B\" 0 "
>> >                                        "until'", end_address, start_ad=
dress);
>> > +        machine =3D "pseries";
>> >          arch_opts =3D g_strdup("-nodefaults -machine vsmt=3D8");
>> >      } else if (strcmp(arch, "aarch64") =3D=3D 0) {
>> >          memory_size =3D "150M";
>> > -        arch_opts =3D g_strdup_printf("-machine virt,gic-version=3Dma=
x -cpu max "
>> > +        machine =3D "virt";
>> > +        arch_opts =3D g_strdup_printf("-machine gic-version=3Dmax -cp=
u max "
>>=20
>> Does this double -machine command line works?
>
> Why not just call the variable 'machine_opts' and here you can
> do
>
>  -        arch_opts =3D g_strdup_printf("-machine virt,gic-version=3Dmax =
-cpu max "
>  +        machine_opts =3D "virt,gic-version=3Dmax";
>  +        arch_opts =3D g_strdup_printf("-cpu max "

The machine name needs to be standalone so it can be overridden in the
next patch when we compute the common machine type.

Maybe I could add the machine_opts anyway just to make it more explicit.

