Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E66C6827145
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 15:27:30 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMqa1-0003gq-Ln; Mon, 08 Jan 2024 09:26:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMqZy-0003f3-Mo
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:26:14 -0500
Received: from smtp-out1.suse.de ([195.135.223.130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1rMqZv-0001ow-JX
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 09:26:14 -0500
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id BD5CC22009;
 Mon,  8 Jan 2024 14:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704723967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5m/h/MsSVvU/3GrDF6IclWAP1urLRyACObbS49lOL0=;
 b=L+SoGJIz5f6XbXqoBBdzdLsHxVhCs3VqnrWfFgQSDxGbDy5er4K4kDaiPzcsuYbRfrzcOY
 9ybSTvCA/7GikqeUKkFvF+u1ptTcTrnyckZhFHns0U1XBsGvDMfYQFn6dkjF8UImj18cku
 Q8X3JCq7cAYzHPdMg8+9hGvt9KrZhlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704723967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5m/h/MsSVvU/3GrDF6IclWAP1urLRyACObbS49lOL0=;
 b=u959xNd0QVFOD1yw5DSunctmR6uHhAVAo7J5uTYqG+GsY3Pw4CFH964KA/+kgIBJNnnrr/
 fLyXq4jfZT93i1AA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1704723967; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5m/h/MsSVvU/3GrDF6IclWAP1urLRyACObbS49lOL0=;
 b=L+SoGJIz5f6XbXqoBBdzdLsHxVhCs3VqnrWfFgQSDxGbDy5er4K4kDaiPzcsuYbRfrzcOY
 9ybSTvCA/7GikqeUKkFvF+u1ptTcTrnyckZhFHns0U1XBsGvDMfYQFn6dkjF8UImj18cku
 Q8X3JCq7cAYzHPdMg8+9hGvt9KrZhlo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1704723967;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q5m/h/MsSVvU/3GrDF6IclWAP1urLRyACObbS49lOL0=;
 b=u959xNd0QVFOD1yw5DSunctmR6uHhAVAo7J5uTYqG+GsY3Pw4CFH964KA/+kgIBJNnnrr/
 fLyXq4jfZT93i1AA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 467DE1392C;
 Mon,  8 Jan 2024 14:26:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGbbA/8FnGU0IQAAD6G6ig
 (envelope-from <farosas@suse.de>); Mon, 08 Jan 2024 14:26:07 +0000
From: Fabiano Rosas <farosas@suse.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jiang
 Jiacheng <jiangjiacheng@huawei.com>, Leonardo Bras <leobras@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo
 Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 3/3] tests/qtest: Re-enable multifd cancel test
In-Reply-To: <ZZuZcCxxIS6j_jHD@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-4-farosas@suse.de> <87ttvjoexo.fsf@secure.mitica>
 <ZZuZcCxxIS6j_jHD@x1n>
Date: Mon, 08 Jan 2024 11:26:04 -0300
Message-ID: <87frz73nr7.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -4.30
X-Spamd-Result: default: False [-4.30 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; BAYES_HAM(-3.00)[100.00%];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 MID_RHS_MATCH_FROM(0.00)[]
Received-SPF: pass client-ip=195.135.223.130; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
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

> On Wed, Jun 07, 2023 at 10:27:15AM +0200, Juan Quintela wrote:
>> Fabiano Rosas <farosas@suse.de> wrote:
>> > We've found the source of flakiness in this test, so re-enable it.
>> >
>> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
>> > ---
>> >  tests/qtest/migration-test.c | 10 ++--------
>> >  1 file changed, 2 insertions(+), 8 deletions(-)
>> >
>> > diff --git a/tests/qtest/migration-test.c b/tests/qtest/migration-test=
.c
>> > index b0c355bbd9..800ad23b75 100644
>> > --- a/tests/qtest/migration-test.c
>> > +++ b/tests/qtest/migration-test.c
>> > @@ -2778,14 +2778,8 @@ int main(int argc, char **argv)
>> >      }
>> >      qtest_add_func("/migration/multifd/tcp/plain/none",
>> >                     test_multifd_tcp_none);
>> > -    /*
>> > -     * This test is flaky and sometimes fails in CI and otherwise:
>> > -     * don't run unless user opts in via environment variable.
>> > -     */
>> > -    if (getenv("QEMU_TEST_FLAKY_TESTS")) {
>> > -        qtest_add_func("/migration/multifd/tcp/plain/cancel",
>> > -                       test_multifd_tcp_cancel);
>> > -    }
>> > +    qtest_add_func("/migration/multifd/tcp/plain/cancel",
>> > +                   test_multifd_tcp_cancel);
>> >      qtest_add_func("/migration/multifd/tcp/plain/zlib",
>> >                     test_multifd_tcp_zlib);
>> >  #ifdef CONFIG_ZSTD
>>=20
>> Reviewed-by: Juan Quintela <quintela@redhat.com>
>>=20
>>=20
>> There was another failure with migration test that I will post during
>> the rest of the day.  It needs both to get it right.
>
> This one didn't yet land upstream.  I'm not sure, but maybe Juan was sayi=
ng
> about this change:
>
>         commit d2026ee117147893f8d80f060cede6d872ecbd7f
>         Author: Juan Quintela <quintela@trasno.org>
>         Date:   Wed Apr 26 12:20:36 2023 +0200
>
>         multifd: Fix the number of channels ready

That's not it. It was something in the test itself around the fact that
we use two sets of: from/to. There was supposed to be a situation where
we'd start 'to2' while 'to' was still running and that would cause
issues (possibly with sockets).

I think what might have happened is that someone merged a fix through
another tree and Juan didn't notice. I think this is the one:

  commit f2d063e61ee2026700ab44bef967f663e976bec8
  Author: Xuzhou Cheng <xuzhou.cheng@windriver.com>
  Date:   Fri Oct 28 12:57:32 2022 +0800
=20=20
      tests/qtest: migration-test: Make sure QEMU process "to" exited after=
 migration is canceled
=20=20=20=20=20=20
      Make sure QEMU process "to" exited before launching another target
      for migration in the test_multifd_tcp_cancel case.
=20=20=20=20=20=20
      Signed-off-by: Xuzhou Cheng <xuzhou.cheng@windriver.com>
      Signed-off-by: Bin Meng <bin.meng@windriver.com>
      Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
      Message-Id: <20221028045736.679903-8-bin.meng@windriver.com>
      Signed-off-by: Thomas Huth <thuth@redhat.com>

> Fabiano, did you try to reproduce multifd-cancel with current master?  I'm
> wondering whether this test has already been completely fixed, then maybe
> we can pick up this patch now.

Yes, let's merge it. I have kept it enabled during testing of all of the
recent race conditions we've debugged and haven't seen it fail. Current
master also looks fine.

