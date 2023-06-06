Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 244FA724B9D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:44:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6beS-0001Y8-SL; Tue, 06 Jun 2023 14:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6beL-0001WN-K0
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:43:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6beI-0002F3-BV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:43:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686076995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gJLVoyOSGvP3jJScIXHc4vh7rj7/iMeXi8/1dKOqoRs=;
 b=XwPUGhMHL6lJ8fPh84jr5v6tmPPFc7Ux4bzH/G19hw+iwywi+EkOMrhaa0txVZO2Vqg/VO
 8EDpg8WIWBb2IcpwaDil7emlNwmCrLuTfMkVTm8TEOoC8wEa7eFd7XJiIZ4yBGSVr2qMKd
 C+hS/7iKQ8hGP2fPFPlPOn04/OTybpo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-117-Joh8GLQYOwiJRg1xH12QAg-1; Tue, 06 Jun 2023 14:43:14 -0400
X-MC-Unique: Joh8GLQYOwiJRg1xH12QAg-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-3f6c58d57adso9678301cf.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 11:43:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686076994; x=1688668994;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gJLVoyOSGvP3jJScIXHc4vh7rj7/iMeXi8/1dKOqoRs=;
 b=Tq1U07jAQLYID7lT6Mc/65iP7u4OT5hf2vXLTLFCqMqQ/MAgwQo+yLlbagKdlbJ18Y
 AnulxJ7oGZq6cA/DC1AZDpAQI1AXXHF6Ku7woM7t11vcCTzN+SMipBpMk5ZxeM4cZJGW
 LlautBRJsHsdgzykRuueRY1I8cQOos8py4GeIbr8Sm361c260BJLKmyIDSw2wG8uEs8u
 yTlgDZSdMd/7l5tgKO4vbvqV7gDLoYOjbyScUwHYgqEN7bp2x52DdVHhxfX6bwRA3dSd
 FR8MgxPPwR3RkGVRsRXA25o6sTRYAGFYYtIrlPL+LOP4n34ZYhfJX97Aq36qF141K1RF
 Pncg==
X-Gm-Message-State: AC+VfDwmSDo8cDwWjrkK9oee+xFic9KmPtdIhYIkE+cTaUeWSmTvLxDL
 4J3jep+ptgdlYx1o8pUwxnLET95fMUX4Ab5OewegsAFC30B5vg5rJRZVaK7S1Ym1Wij2EnZ+lVu
 k4hl9IPv8s6I/tko=
X-Received: by 2002:ac8:5f0c:0:b0:3f6:b465:8ccc with SMTP id
 x12-20020ac85f0c000000b003f6b4658cccmr4378157qta.1.1686076994004; 
 Tue, 06 Jun 2023 11:43:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6cwPL7oVgS9KtqYM95AjcAYnLBuS37BOXb7D3ydeSQwGWALrd/FxYOHOfJ0MHhHVbS7XS9Kg==
X-Received: by 2002:ac8:5f0c:0:b0:3f6:b465:8ccc with SMTP id
 x12-20020ac85f0c000000b003f6b4658cccmr4378136qta.1.1686076993670; 
 Tue, 06 Jun 2023 11:43:13 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 f9-20020ac81c89000000b003f394decd08sm5665946qtl.62.2023.06.06.11.43.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 11:43:13 -0700 (PDT)
Date: Tue, 6 Jun 2023 14:43:11 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 2/3] migration/multifd: Protect accesses to
 migration_threads
Message-ID: <ZH9+P/6abfn9bUY3@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606144551.24367-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, Jun 06, 2023 at 11:45:50AM -0300, Fabiano Rosas wrote:
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
>          qemu_mutex_lock(&s->qemu_file_lock);
>          tmp = s->to_dst_file;
>          s->to_dst_file = NULL;
> @@ -1405,6 +1406,8 @@ void migrate_init(MigrationState *s)
>      s->vm_old_state = -1;
>      s->iteration_initial_bytes = 0;
>      s->threshold_size = 0;
> +
> +    qmp_migration_threads_init();
>  }
>  
>  int migrate_add_blocker_internal(Error *reason, Error **errp)
> @@ -2997,10 +3000,10 @@ static void *migration_thread(void *opaque)
>      }
>  
>      trace_migration_thread_after_loop();
> +    qmp_migration_threads_remove(thread);
>      migration_iteration_finish(s);
>      object_unref(OBJECT(s));
>      rcu_unregister_thread();
> -    qmp_migration_threads_remove(thread);
>      return NULL;
>  }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 5ec1ac5c64..ee7944560a 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -762,12 +762,13 @@ out:
>          qemu_sem_post(&multifd_send_state->channels_ready);
>      }
>  
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
> diff --git a/migration/threadinfo.c b/migration/threadinfo.c
> index c3e85c33e8..1fe64a02dd 100644
> --- a/migration/threadinfo.c
> +++ b/migration/threadinfo.c
> @@ -10,23 +10,40 @@
>   *  See the COPYING file in the top-level directory.
>   */
>  
> +#include "qemu/osdep.h"
> +#include "qemu/queue.h"
> +#include "qemu/lockable.h"
>  #include "threadinfo.h"
>  
> +QemuMutex migration_threads_lock;
>  static QLIST_HEAD(, MigrationThread) migration_threads;
>  
> +void qmp_migration_threads_init(void)
> +{
> +    qemu_mutex_init(&migration_threads_lock);
> +}
> +
> +void qmp_migration_threads_cleanup(void)
> +{
> +    qemu_mutex_destroy(&migration_threads_lock);
> +}
> +
>  MigrationThread *qmp_migration_threads_add(const char *name, int thread_id)
>  {
>      MigrationThread *thread =  g_new0(MigrationThread, 1);
>      thread->name = name;
>      thread->thread_id = thread_id;
>  
> -    QLIST_INSERT_HEAD(&migration_threads, thread, node);
> +    WITH_QEMU_LOCK_GUARD(&migration_threads_lock) {
> +        QLIST_INSERT_HEAD(&migration_threads, thread, node);
> +    }
>  
>      return thread;
>  }
>  
>  void qmp_migration_threads_remove(MigrationThread *thread)
>  {
> +    QEMU_LOCK_GUARD(&migration_threads_lock);
>      if (thread) {
>          QLIST_REMOVE(thread, node);
>          g_free(thread);

qmp_query_migrationthreads() better also have the lock?

Other than that looks good, thanks!

> diff --git a/migration/threadinfo.h b/migration/threadinfo.h
> index 61b990f5e3..eb7f8e5bb2 100644
> --- a/migration/threadinfo.h
> +++ b/migration/threadinfo.h
> @@ -10,8 +10,6 @@
>   *  See the COPYING file in the top-level directory.
>   */
>  
> -#include "qemu/queue.h"
> -#include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-commands-migration.h"
>  
> @@ -23,5 +21,8 @@ struct MigrationThread {
>      QLIST_ENTRY(MigrationThread) node;
>  };
>  
> +void qmp_migration_threads_init(void);
> +void qmp_migration_threads_cleanup(void);
> +
>  MigrationThread *qmp_migration_threads_add(const char *name, int thread_id);
>  void qmp_migration_threads_remove(MigrationThread *info);
> -- 
> 2.35.3
> 

-- 
Peter Xu


