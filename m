Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A0EE171962F
	for <lists+qemu-devel@lfdr.de>; Thu,  1 Jun 2023 11:00:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4e9Z-0008AT-J9; Thu, 01 Jun 2023 04:59:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4e9P-00083d-Tu
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1q4e9N-0000JJ-Vc
 for qemu-devel@nongnu.org; Thu, 01 Jun 2023 04:59:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685609957;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=XYC0DC/7eTzxPNa+Ms91rrv8vKvxw1L4Dlre5wpJ02M=;
 b=OpZ/znam9/NCA3tpvivQ9krFOnFyJgXsZ0VThB0hHfYZ3Bf4k12MEbDZNWlNDyF12LdurD
 ZMsyIKZ2WEg7LEgfIY+BaYKXE27jNhzlP96QFW00CEDqUsqTo2tP6jsiC+LbXcrR80SgU7
 O82fBVbcTpgFQOk4Jtafk1h7O9imXUg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-96-7nmOho0-M3OVhHaN3jnnsQ-1; Thu, 01 Jun 2023 04:59:16 -0400
X-MC-Unique: 7nmOho0-M3OVhHaN3jnnsQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BF8941C05AAA
 for <qemu-devel@nongnu.org>; Thu,  1 Jun 2023 08:59:15 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.153])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E89E6492B00;
 Thu,  1 Jun 2023 08:59:12 +0000 (UTC)
Date: Thu, 1 Jun 2023 09:58:45 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Peter Xu <peterx@redhat.com>
Subject: Re: [PULL 14/21] migration/rdma: Unfold ram_control_after_iterate()
Message-ID: <ZHhdxQJHn25Qjmh2@redhat.com>
References: <20230530182531.6371-1-quintela@redhat.com>
 <20230530182531.6371-15-quintela@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230530182531.6371-15-quintela@redhat.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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

On Tue, May 30, 2023 at 08:25:24PM +0200, Juan Quintela wrote:
> Once there:
> - Remove unused data parameter
> - unfold it in its callers
> - change all callers to call qemu_rdma_registration_stop()
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> Message-Id: <20230509120700.78359-4-quintela@redhat.com>
> ---
>  migration/qemu-file.h |  2 --
>  migration/rdma.h      |  3 +++
>  migration/qemu-file.c | 12 ------------
>  migration/ram.c       | 17 ++++++++++++++---
>  migration/rdma.c      |  6 ++----
>  5 files changed, 19 insertions(+), 21 deletions(-)
> 

> diff --git a/migration/rdma.c b/migration/rdma.c
> index 6ca89ff090..8001dcb960 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -3891,15 +3891,14 @@ int qemu_rdma_registration_start(QEMUFile *f, uint64_t flags)
>   * Inform dest that dynamic registrations are done for now.
>   * First, flush writes, if any.
>   */
> -static int qemu_rdma_registration_stop(QEMUFile *f,
> -                                       uint64_t flags, void *data)
> +int qemu_rdma_registration_stop(QEMUFile *f, uint64_t flags)
>  {
>      QIOChannelRDMA *rioc = QIO_CHANNEL_RDMA(qemu_file_get_ioc(f));

Again casting to a QIOChannelRDMA....

>      RDMAContext *rdma;
>      RDMAControlHeader head = { .len = 0, .repeat = 1 };
>      int ret = 0;
>  
> -    if (migration_in_postcopy()) {
> +    if (!migrate_rdma() || migration_in_postcopy()) {

...before checking if this is actually an RDMA migration


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


