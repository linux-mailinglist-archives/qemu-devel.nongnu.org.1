Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7956077BC2F
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 16:56:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVYz6-0006qk-MX; Mon, 14 Aug 2023 10:55:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVYz3-0006qT-Lt
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:55:54 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1qVYz2-0004PE-2O
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 10:55:53 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B453821878;
 Mon, 14 Aug 2023 14:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1692024949; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2/h4vIDKmHpZ2cSpUMrZj6Dl+oqkGSr9jH2l/JxTQk=;
 b=QbxlXaCxqHNIqGUfXafLQPeIK0zAYL/sJ+NvoSKUaFVR4rUPAcbxDwfOY/31TXroDlQrpA
 4rwa/Fi8z7C3TP8z8md7S3KSoXtV8RXYDBOLptKdbu+CDx+4svotP1QlgzIeLx3hrvh9/t
 CHhpumgyhIefC7nheO6ZbNDSfeR2z0I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1692024949;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=B2/h4vIDKmHpZ2cSpUMrZj6Dl+oqkGSr9jH2l/JxTQk=;
 b=Y+5lO85N06YpWF5mc//n+1KSWVfQPkua8PdaFfhWpUR+7EPGWo8ZAyP0Pp+NaJoAmnj+QE
 HmriCxGmNr7DLuCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 433A9138EE;
 Mon, 14 Aug 2023 14:55:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id u7QLBHVA2mR9CAAAMHmgww
 (envelope-from <farosas@suse.de>); Mon, 14 Aug 2023 14:55:49 +0000
From: Fabiano Rosas <farosas@suse.de>
To: "chenyuhui (A)" <chenyuhui5@huawei.com>, Juan Quintela
 <quintela@redhat.com>, qemu-devel@nongnu.org
Cc: xuyinghua3@huawei.com, liheng.liheng@huawei.com, renxuming@huawei.com,
 pengyi.pengyi@huawei.com, yubihong@huawei.com, zhengchuan@huawei.com,
 huhao33@huawei.com, caozhongwang1@huawei.com, caiqingmu@huawei.com, Peter
 Xu <peterx@redhat.com>
Subject: Re: [PATCH] migrate/multifd: fix coredump when the multifd thread
 cleanup
In-Reply-To: <731ee7bd-8935-7970-e217-888a4199ba95@huawei.com>
References: <20230621081826.3203053-1-zhangjianguo18@huawei.com>
 <87wmzwsxmz.fsf@suse.de> <53a69e3b-f9f7-b2c1-9487-f9992ffec2a3@huawei.com>
 <ae697c8c-5d57-071c-240a-6f1e8307bdbd@huawei.com>
 <dd678c96-6065-0c53-9543-312a647298e2@huawei.com> <ZL/97XT8wRq1hsVN@x1n>
 <731ee7bd-8935-7970-e217-888a4199ba95@huawei.com>
Date: Mon, 14 Aug 2023 11:55:46 -0300
Message-ID: <87h6p1vfkd.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
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

"chenyuhui (A)" via <qemu-devel@nongnu.org> writes:

> On 2023/7/26 0:53, Peter Xu wrote:
>> On Tue, Jul 25, 2023 at 04:43:28PM +0800, chenyuhui (A) wrote:
>>> @Peter Xu @Fabiano Rosas
>>> Kindly ping on this.
>>=20
>> Ah I see what's missing - please copy maintainer (Juan) for any migration
>> patches, especially multifd ones..  I'm doing that for this one, but I'd
>> suggest you repost with a whole patch and information put into commit ms=
g.
>>=20
>> Thanks.
>>=20
> Hi, Juan
> This is a patch for migration=EF=BC=8Cplease take a look.
>
> From: Yuhui Chen <chenyuhui5@huawei.com>
> Date: Tue, 25 Jul 2023 10:45:48 +0800
> Subject: [PATCH] migrate/multifd: fix coredump when the multifd thread cl=
eanup
>
> There is a coredump while trying to destroy mutex when
> p->running is false but p->mutex is not unlock.
> Make sure all mutexes has been released before destroy them.
>
> Signed-off-by: Yuhui Chen <chenyuhui5@huawei.com>
> ---
>  migration/multifd.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 3387d8277f..3a085bf3ec 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -521,9 +521,7 @@ void multifd_save_cleanup(void)
>      for (i =3D 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p =3D &multifd_send_state->params[i];
>
> -        if (p->running) {
> -            qemu_thread_join(&p->thread);
> -        }
> +        qemu_thread_join(&p->thread);
>      }
>      for (i =3D 0; i < migrate_multifd_channels(); i++) {
>          MultiFDSendParams *p =3D &multifd_send_state->params[i];

Hi,

I took another look at this and noticed that we're not even holding the
lock in the other threads when accessing p->running.

Also, the save_cleanup() function can be called before
qemu_thread_create(), which means p->thread.thread would have a bogus
value and qemu_thread_join() would abort the QEMU process.

What we need here is to stop setting p->running from inside the thread
altogether. The flag is only effectively protecting the
qemu_thread_join() from being called before the thread's creation. We
can post to sem_sync regardless of the thread state because we only
destroy it a few lines down in the same function. And there's already
p->quit which is being accessed properly and sends the thread out of the
loop.

So I suggest this pattern:

qemu_sem_post(&p->sem_sync);
if (p->running) {
    qemu_thread_join(&p->thread);
    p->running =3D false;
}

It would also be nice to move the p->running =3D true closer to the
qemu_thread_create() call at multifd_channel_connect().


