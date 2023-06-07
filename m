Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D479D725797
	for <lists+qemu-devel@lfdr.de>; Wed,  7 Jun 2023 10:27:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6oUn-00078x-18; Wed, 07 Jun 2023 04:26:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6oUi-00078X-MV
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:26:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <quintela@redhat.com>)
 id 1q6oUh-00023u-78
 for qemu-devel@nongnu.org; Wed, 07 Jun 2023 04:26:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686126374;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=prZkupzqhjmKzL4p+6F51orufl+dT0jkgz/AzqLL9MI=;
 b=UviK9F+XD3FBzsHcwV7e1ojI1xvPFPSeMmq59W8pEREQQk74Cl4inViDfqaoDMJHOvx8cJ
 HNT3yiP4tWlW5id9UtMrqYqa1HifnxTzc33e8yjM6y6si74//kBRtt4tL2X7NxRuYylaD+
 b0r+FdRXb35j6A6rOBfNfDzvASZzsBU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-Mk8ZKf0zP7yyNFn3gw2Xdg-1; Wed, 07 Jun 2023 04:26:13 -0400
X-MC-Unique: Mk8ZKf0zP7yyNFn3gw2Xdg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-30a5d4e5731so3069174f8f.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jun 2023 01:26:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686126372; x=1688718372;
 h=mime-version:message-id:date:reply-to:user-agent:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=prZkupzqhjmKzL4p+6F51orufl+dT0jkgz/AzqLL9MI=;
 b=dKr9damM9diHC3CSPxoQrjn6sbhyATaDjBgQQqNmuVbXrAWtezNGqXDtg5Ur7Iu8MS
 8OazA2eWf1rV7ly7+74aQIahXf/ZvcnrD5+8Gq2P9lGvzcS/dC5JepEYxSg4ge4POcCn
 +zx8GsLO024ZW4hEsMRnerxxtzY9ZFrZvRGKzps7XbLw49kCC058ckkI3yszlA5m60wg
 h26WtLC8NBTQV5qFkyD9mfowF7Wq9Rvbm4zwXU2X9hZcP1i2WhEuunCu6yAdJDrBA85a
 +sQyKs7HKYCQA7VCjfHD8VmKwvmDXbA9QqE6nOiOc8Zmlag43r+XZM1FBGs8uvxCSE9z
 rjKA==
X-Gm-Message-State: AC+VfDyehp2TYuMXiACobZ9AEVU7BcGEZNpwrbFV4W0mHO7GCJ3pUqsF
 s0QeSZYftI8djO6YFwaSnX6encNqbYojPkyOMvUI6AR9dWJKuCN01EKN098nQSWjCsSfRHPNPSx
 r2dlW85A84PN2b3E=
X-Received: by 2002:a5d:4d49:0:b0:2f9:c2ab:e1de with SMTP id
 a9-20020a5d4d49000000b002f9c2abe1demr3420788wru.14.1686126371854; 
 Wed, 07 Jun 2023 01:26:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4fB4BqH0alOIwC9TvDhL8ZfjIvy0kYIIgpM3mksNEShPSfbabp2K3vRNufPRv0vUFHg2eekg==
X-Received: by 2002:a5d:4d49:0:b0:2f9:c2ab:e1de with SMTP id
 a9-20020a5d4d49000000b002f9c2abe1demr3420776wru.14.1686126371511; 
 Wed, 07 Jun 2023 01:26:11 -0700 (PDT)
Received: from redhat.com (static-92-120-85-188.ipcom.comunitel.net.
 [188.85.120.92]) by smtp.gmail.com with ESMTPSA id
 w2-20020adfd4c2000000b0030aeb3731d0sm14614849wrk.98.2023.06.07.01.26.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jun 2023 01:26:10 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,  Jiang
 Jiacheng <jiangjiacheng@huawei.com>,  Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration/multifd: Protect accesses to
 migration_threads
In-Reply-To: <20230606144551.24367-3-farosas@suse.de> (Fabiano Rosas's message
 of "Tue, 6 Jun 2023 11:45:50 -0300")
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-3-farosas@suse.de>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Date: Wed, 07 Jun 2023 10:26:09 +0200
Message-ID: <87y1kvoezi.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=170.10.129.124; envelope-from=quintela@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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
Reply-To: quintela@redhat.com
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Fabiano Rosas <farosas@suse.de> wrote:
> This doubly linked list is common for all the multifd and migration
> threads so we need to avoid concurrent access.
>
> Add a mutex to protect the data from concurrent access. This fixes a
> crash when removing two MigrationThread objects from the list at the
> same time during cleanup of multifd threads.
>
> To avoid destroying the mutex before the last element has been
> removed, move calls to qmp_migration_thread_remove so they run before
> multifd_save_cleanup joins the threads.
>
> Fixes: 671326201d ("migration: Introduce interface query-migrationthreads")
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

I agree with Peter here.  Why don't you have to protect the walking?

> ---
>  migration/migration.c  |  5 ++++-
>  migration/multifd.c    |  3 ++-
>  migration/threadinfo.c | 19 ++++++++++++++++++-
>  migration/threadinfo.h |  5 +++--
>  4 files changed, 27 insertions(+), 5 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index e731fc98a1..b3b8345eb2 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1146,6 +1146,7 @@ static void migrate_fd_cleanup(MigrationState *s)
>          qemu_mutex_lock_iothread();
>  
>          multifd_save_cleanup();
> +        qmp_migration_threads_cleanup();

I think I will spare this one as the mutex is static, so we are not
winning any memory back.

>      }
>  
>      trace_migration_thread_after_loop();
> +    qmp_migration_threads_remove(thread);
>      migration_iteration_finish(s);

I can understand moving it here, but why before migration_iteration_finish?

>      object_unref(OBJECT(s));
>      rcu_unregister_thread();
> -    qmp_migration_threads_remove(thread);
>      return NULL;
>  }
> +    qmp_migration_threads_remove(thread);
> +
>      qemu_mutex_lock(&p->mutex);
>      p->running = false;
>      qemu_mutex_unlock(&p->mutex);
>  
>      rcu_unregister_thread();
> -    qmp_migration_threads_remove(thread);
>      trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
>  
>      return NULL;

Here it looks like the right place.


> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qemu/lockable.h"
>  #include "threadinfo.h"

Ouch, it missed Markus cleanup.  Thanks.

For the rest it looks good.

Later, Juan.


