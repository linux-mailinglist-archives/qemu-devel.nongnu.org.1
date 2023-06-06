Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D698724B8D
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 20:38:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6bZU-00007I-3z; Tue, 06 Jun 2023 14:38:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6bZS-000072-Dm
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:38:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q6bZP-0000Ch-OR
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 14:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686076694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rNseYPd9aWr0S/H3pc64tIMFT3KDdLFcyqCiasOzQ+Q=;
 b=QXQWg9IAH6eSSG1nhxV4X/ELSRVosNHwUNQAAV/VU68GVKZnS3LKZDACz9sLtHQ9PqI6Az
 B+CJ5a440tSCCUmOtcm25ZUlIZX5/iGurcSTbni4CogfX6wt1471x5eiUvgxlSfzfDnSlM
 sSCZ3qrCHOA8pNL8s2VTm6CLNNcxNlg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-614-5vu1YP3nOGOU1IhpYt9AXg-1; Tue, 06 Jun 2023 14:38:13 -0400
X-MC-Unique: 5vu1YP3nOGOU1IhpYt9AXg-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-62b6792293dso1164266d6.1
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 11:38:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686076692; x=1688668692;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rNseYPd9aWr0S/H3pc64tIMFT3KDdLFcyqCiasOzQ+Q=;
 b=grYGFeLAOXft4WpJsVDVjGhMDV70jaiBd+DXdBqaT9Q/tPoUTeX7+sxY0WFgrbT/St
 xs1VzhBmYHwP3NIETX0bXyLAo5Td5XFDP5aYtMS50cHiG8M5H93+KauztEwH4zanGPWi
 WQgtAuQ1c74SZsrQ2BneWsqEU7HVMAnul3AX7G+X3nE6F0TVj2nI5ppvduUwEU+GJmpM
 brn5On868n9LamuUjSmMo19hUujLVpGOlfJU/tlTpNGHOjSlYNoCgZIhpONuOpbvQ6dn
 A3Ya0eSdqJd0avTKpHY/Ws5yOux0Mg3R4rAd27fEIHrDyGCYL06aFsXCWwYCWU/2aUQZ
 gZtg==
X-Gm-Message-State: AC+VfDwCdetWl2tx90ftJZq/+/wK7t1V9wdyFxUPinkfra/4fhRgsaP4
 awrU20nvpILCFILnduy6nGI2UtM0G1VpmVTJD2/SDTpxk5vPcMwTkmwTpnq9436qqENRGB8claI
 pqbY0UT3Dk9BT7J8=
X-Received: by 2002:a05:6214:252a:b0:626:273e:c35c with SMTP id
 gg10-20020a056214252a00b00626273ec35cmr3268497qvb.2.1686076692645; 
 Tue, 06 Jun 2023 11:38:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WBw/IUIy4K3xEobQX7bvmOREzmUTAbCDgsOZAo2aq5CkM64eMCJvShRjNRcFwZW6Rl4bIUQ==
X-Received: by 2002:a05:6214:252a:b0:626:273e:c35c with SMTP id
 gg10-20020a056214252a00b00626273ec35cmr3268488qvb.2.1686076692373; 
 Tue, 06 Jun 2023 11:38:12 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 hg9-20020a05622a610900b003f532993912sm5688673qtb.74.2023.06.06.11.38.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 11:38:11 -0700 (PDT)
Date: Tue, 6 Jun 2023 14:38:10 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 Jiang Jiacheng <jiangjiacheng@huawei.com>,
 Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH 1/3] migration/multifd: Rename threadinfo.c functions
Message-ID: <ZH99EuY3c/RqIELY@x1n>
References: <20230606144551.24367-1-farosas@suse.de>
 <20230606144551.24367-2-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230606144551.24367-2-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Tue, Jun 06, 2023 at 11:45:49AM -0300, Fabiano Rosas wrote:
> The code in threadinfo.c is only used for the QMP command
> query-migrationthreads. Make it explicit that this is something
> related to QMP.
> 
> The current names are also too generic for a piece of code that
> doesn't affect the migration directly in any way.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Looks good here, but shall we reserve the qmp_* prefix to mostly qmp stuff
only?  Dropping "qmp_" in the new names would look better to me..

> ---
>  migration/migration.c  | 4 ++--
>  migration/multifd.c    | 4 ++--
>  migration/threadinfo.c | 4 ++--
>  migration/threadinfo.h | 5 ++---
>  4 files changed, 8 insertions(+), 9 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index dc05c6f6ea..e731fc98a1 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2922,7 +2922,7 @@ static void *migration_thread(void *opaque)
>      MigThrError thr_error;
>      bool urgent = false;
>  
> -    thread = MigrationThreadAdd("live_migration", qemu_get_thread_id());
> +    thread = qmp_migration_threads_add("live_migration", qemu_get_thread_id());
>  
>      rcu_register_thread();
>  
> @@ -3000,7 +3000,7 @@ static void *migration_thread(void *opaque)
>      migration_iteration_finish(s);
>      object_unref(OBJECT(s));
>      rcu_unregister_thread();
> -    MigrationThreadDel(thread);
> +    qmp_migration_threads_remove(thread);
>      return NULL;
>  }
>  
> diff --git a/migration/multifd.c b/migration/multifd.c
> index 0bf5958a9c..5ec1ac5c64 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -651,7 +651,7 @@ static void *multifd_send_thread(void *opaque)
>      int ret = 0;
>      bool use_zero_copy_send = migrate_zero_copy_send();
>  
> -    thread = MigrationThreadAdd(p->name, qemu_get_thread_id());
> +    thread = qmp_migration_threads_add(p->name, qemu_get_thread_id());
>  
>      trace_multifd_send_thread_start(p->id);
>      rcu_register_thread();
> @@ -767,7 +767,7 @@ out:
>      qemu_mutex_unlock(&p->mutex);
>  
>      rcu_unregister_thread();
> -    MigrationThreadDel(thread);
> +    qmp_migration_threads_remove(thread);
>      trace_multifd_send_thread_end(p->id, p->num_packets, p->total_normal_pages);
>  
>      return NULL;
> diff --git a/migration/threadinfo.c b/migration/threadinfo.c
> index 1de8b31855..c3e85c33e8 100644
> --- a/migration/threadinfo.c
> +++ b/migration/threadinfo.c
> @@ -14,7 +14,7 @@
>  
>  static QLIST_HEAD(, MigrationThread) migration_threads;
>  
> -MigrationThread *MigrationThreadAdd(const char *name, int thread_id)
> +MigrationThread *qmp_migration_threads_add(const char *name, int thread_id)
>  {
>      MigrationThread *thread =  g_new0(MigrationThread, 1);
>      thread->name = name;
> @@ -25,7 +25,7 @@ MigrationThread *MigrationThreadAdd(const char *name, int thread_id)
>      return thread;
>  }
>  
> -void MigrationThreadDel(MigrationThread *thread)
> +void qmp_migration_threads_remove(MigrationThread *thread)
>  {
>      if (thread) {
>          QLIST_REMOVE(thread, node);
> diff --git a/migration/threadinfo.h b/migration/threadinfo.h
> index 4d69423c0a..61b990f5e3 100644
> --- a/migration/threadinfo.h
> +++ b/migration/threadinfo.h
> @@ -23,6 +23,5 @@ struct MigrationThread {
>      QLIST_ENTRY(MigrationThread) node;
>  };
>  
> -MigrationThread *MigrationThreadAdd(const char *name, int thread_id);
> -
> -void MigrationThreadDel(MigrationThread *info);
> +MigrationThread *qmp_migration_threads_add(const char *name, int thread_id);
> +void qmp_migration_threads_remove(MigrationThread *info);
> -- 
> 2.35.3
> 

-- 
Peter Xu


