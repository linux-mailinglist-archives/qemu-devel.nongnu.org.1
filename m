Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 612FC725DEC
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 14:02:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6rqE-0002Tg-B8; Wed, 07 Jun 2023 08:00:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6rpy-0002T2-5L
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:00:31 -0400
Received: from smtp-out1.suse.de ([195.135.220.28])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <farosas@suse.de>) id 1q6rpr-0008It-7O
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 08:00:24 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 622C3219EC;
 Wed,  7 Jun 2023 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1686139217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkVlYK4NBfx/WjoDoWyhANOUhVG12HzcWgiLfwxdC80=;
 b=yDWLUtEedxY1xpuFGkH2v2YcRsqctAqfg1fuxF1iK5IpUfvA2uFC+IQWX9okFDbbFCPwQQ
 9V8OUHZDfyrDsJE7sf76BmEIpDc45GctLiFjT7sVdOHo1bI4a/GK3wUU29OiIrYq2Sykwr
 11wktzxguYNS7hOJGoPntsJ/lpKgUE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1686139217;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tkVlYK4NBfx/WjoDoWyhANOUhVG12HzcWgiLfwxdC80=;
 b=7AYtRMSSrSpPEnUnRXPSlVTdaBd50ODg70bazzUxolDa+DEXR/1+0MRGo0uHeYyDLgUrpo
 wnryarFoJUewwVDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD7BE13776;
 Wed,  7 Jun 2023 12:00:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eMxTKFBxgGQKNgAAMHmgww
 (envelope-from <farosas@suse.de>); Wed, 07 Jun 2023 12:00:16 +0000
From: Fabiano Rosas <farosas@suse.de>
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Jiang
 Jiacheng <jiangjiacheng@huawei.com>, Peter Xu <peterx@redhat.com>, Leonardo
 Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration/multifd: Protect accesses to
 migration_threads
In-Reply-To: <87y1kvoezi.fsf@secure.mitica>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-3-farosas@suse.de> <87y1kvoezi.fsf@secure.mitica>
Date: Wed, 07 Jun 2023 09:00:14 -0300
Message-ID: <87o7lrh48h.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=195.135.220.28; envelope-from=farosas@suse.de;
 helo=smtp-out1.suse.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Juan Quintela <quintela@redhat.com> writes:

> Fabiano Rosas <farosas@suse.de> wrote:
>> This doubly linked list is common for all the multifd and migration
>> threads so we need to avoid concurrent access.
>>
>> Add a mutex to protect the data from concurrent access. This fixes a
>> crash when removing two MigrationThread objects from the list at the
>> same time during cleanup of multifd threads.
>>
>> To avoid destroying the mutex before the last element has been
>> removed, move calls to qmp_migration_thread_remove so they run before
>> multifd_save_cleanup joins the threads.
>>
>> Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
>> Signed-off-by: Fabiano Rosas <farosas@suse.de>
>
> I agree with Peter here.  Why don't you have to protect the walking?
>

Oversight on my part.

>> ---
>>  migration/migration.c  |  5 ++++-
>>  migration/multifd.c    |  3 ++-
>>  migration/threadinfo.c | 19 ++++++++++++++++++-
>>  migration/threadinfo.h |  5 +++--
>>  4 files changed, 27 insertions(+), 5 deletions(-)
>>
>> diff --git a/migration/migration.c b/migration/migration.c
>> index e731fc98a1..b3b8345eb2 100644
>> --- a/migration/migration.c
>> +++ b/migration/migration.c
>> @@ -1146,6 +1146,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>>          qemu_mutex_lock_iothread();
>>  
>>          multifd_save_cleanup();
>> +        qmp_migration_threads_cleanup();
>
> I think I will spare this one as the mutex is static, so we are not
> winning any memory back.
>

Ok

>>      }
>>  
>>      trace_migration_thread_after_loop();
>> +    qmp_migration_threads_remove(thread);
>>      migration_iteration_finish(s);
>
> I can understand moving it here, but why before migration_iteration_finish?
>

Because migration_iteration_finish schedules migrate_fd_cleanup and it
calls qmp_migration_threads_cleanup. So I wanted to be sure that the
removal happens before destroying the mutex.

>>      object_unref(OBJECT(s));
>>      rcu_unregister_thread();
>> -    qmp_migration_threads_remove(thread);
>>      return NULL;
>>  }
>> +    qmp_migration_threads_remove(thread);
>> +
>>      qemu_mutex_lock(&p->mutex);
>>      p->running = false;
>>      qemu_mutex_unlock(&p->mutex);
>>  
>>      rcu_unregister_thread();
>> -    qmp_migration_threads_remove(thread);
>>      trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
>>  
>>      return NULL;
>
> Here it looks like the right place.
>

Yep, we shouldn't really put any new code after that p->running =
false. Because multifd_save_cleanup will happily start cleaning up
everything while this thread is still running if it sees p->running ==
false.

>
>> +#include "qemu/osdep.h"
>> +#include "qemu/queue.h"
>> +#include "qemu/lockable.h"
>>  #include "threadinfo.h"
>
> Ouch, it missed Markus cleanup.  Thanks.
>
> For the rest it looks good.
>
> Later, Juan.

