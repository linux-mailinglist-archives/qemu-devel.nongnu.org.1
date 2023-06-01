Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E365719673
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4eDd-0002pk-Ii; Thu, 01 Jun 2023 05:03:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4eBt-0001xN-2R
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:01:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4eBr-00010h-9N
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 05:01:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685610110;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=LBK2ZHlnhwAZnozGlGWSDASSu9OSuCWCsY22bn2jebc=;
 b=iofGfUlnZ+fL4mrFBYBqunl9qvuQQeZ9g80O3MlnhsmWuBQDr2YbO8UrZqB8nHWRLKJuXx
 1zoRQPeohKAMwNdwydxWtUGGVq0v2mpfj7wudxLPtq6Hzbf4CeCqUPLNGhg+76Qoerxxec
 WOUDIv7ZnRt7bVR4xrnehATAUovkPc8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-265-ZtwC24zHMpmxCNg5qfiwrw-1; Thu, 01 Jun 2023 05:01:49 -0400
X-MC-Unique: ZtwC24zHMpmxCNg5qfiwrw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com
 [10.11.54.1])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DD5C9801182
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 09:01:48 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id DF2CC40CFD45;
 Thu,  1 Jun 2023 09:01:47 +0000 (UTC)
Date: Thu, 1 Jun 2023 10:01:44 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 15/21] migration/rdma: Remove all uses of RAM_CONTROL_HOOK
Message-ID: <ZHheeOStufQRSOMj@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
 <20230530182531.6371-16-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530182531.6371-16-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.163,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Tue, May 30, 2023 at 08:25:25PM +0200, Juan Quintela wrote:
> Instead of going trhough ram_control_load_hook(), call
> qemu_rdma_registration_handle() directly.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230509120700.78359-5-quintela@redhat.com>
> ---
>  migration/qemu-file.h | 1 -
>  migration/rdma.h      | 3 +++
>  migration/ram.c       | 5 ++++-
>  migration/rdma.c      | 9 +++++----
>  4 files changed, 12 insertions(+), 6 deletions(-)
> 
> diff --git a/migration/qemu-file.h b/migration/qemu-file.h
> index 323af5682f..7cfc20825e 100644
> --- a/migration/qemu-file.h
> +++ b/migration/qemu-file.h
> @@ -41,7 +41,6 @@ typedef int (QEMURamHookFunc)(QEMUFile *f, uint64_t flags, void *data);
>   */
>  #define RAM_CONTROL_SETUP     0
>  #define RAM_CONTROL_ROUND     1
> -#define RAM_CONTROL_HOOK      2
>  #define RAM_CONTROL_FINISH    3
>  #define RAM_CONTROL_BLOCK_REG 4
>  
> diff --git a/migration/rdma.h b/migration/rdma.h
> index c13b94c782..8bd277efb9 100644
> --- a/migration/rdma.h
> +++ b/migration/rdma.h
> @@ -24,10 +24,13 @@ void rdma_start_incoming_migration(const char *host_port, Error **errp);
>  
>  
>  #ifdef CONFIG_RDMA
> +int qemu_rdma_registration_handle(QEMUFile *f);
>  int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags);
>  int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags);
>  #else
>  static inline
> +int qemu_rdma_registration_handle(QEMUFile *f) { return 0; }
> +static inline
>  int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags) { return 0; }
>  static inline
>  int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags) { return 0; }
> diff --git a/migration/ram.c b/migration/ram.c
> index c6fad7b0b3..6f0597814c 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4024,7 +4024,10 @@ static int ram_load_precopy(QEMUFile *f)
>              }
>              break;
>          case RAM_SAVE_FLAG_HOOK:
> -            ram_control_load_hook(f, RAM_CONTROL_HOOK, NULL);
> +            ret = qemu_rdma_registration_handle(f);
> +            if (ret < 0) {
> +                qemu_file_set_error(f, ret);
> +            }
>              break;
>          default:
>              error_report("Unknown combination of migration flags: 0x%x", flags);
> diff --git a/migration/rdma.c b/migration/rdma.c
> index 8001dcb960..a477985c6d 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3530,7 +3530,7 @@ static int dest_ram_sort_func(const void *a, const void *b)
>   *
>   * Keep doing this until the source tells us to stop.
>   */
> -static int qemu_rdma_registration_handle(QEMUFile *f)
> +int qemu_rdma_registration_handle(QEMUFile *f)
>  {
>      RDMAControlHeader reg_resp = { .len = sizeof(RDMARegisterResult),
>                                 .type = RDMA_CONTROL_REGISTER_RESULT,
> @@ -3557,6 +3557,10 @@ static int qemu_rdma_registration_handle(QEMUFile *f)

A few lines above this diff contxt there is a call to

    QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));

which is likely unsafe given that....

>      int count = 0;
>      int i = 0;
>  
> +    if (!migrate_rdma()) {

....we're only checking if this is RDMA here.

> +        return 0;
> +    }
> +
>      RCU_READ_LOCK_GUARD();
>      rdma = qatomic_rcu_read(&rioc->rdmain);
>  

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


