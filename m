Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E30E7D3AB6
	for <lists+qemu-devel@lfdr.de>; Mon, 23 Oct 2023 17:27:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1quwq5-0007eh-6E; Mon, 23 Oct 2023 11:27:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1quwq3-0007d6-DR
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1quwq1-0001Qr-Ko
 for qemu-devel@nongnu.org; Mon, 23 Oct 2023 11:27:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698074848;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r1ML2+eFXc7I0THB3G+jfoCNJSpg2iV1hMPRt0mtI0k=;
 b=CouZZBazZMe7Px6HHO0oEwVNuRKCmxr2Nzgregvn0+QCrdCxk07Xk0sgGDr/TDdutCfvzo
 vkpIBY69pyuvneMP3tV690fItVn4kNtPX1kodZiDfS4lrJ4GPZg+/4ijNlnFXx59TIDCCO
 yvQg235FP8iGZSm/uWuP0FxA3MLpzro=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-49--ucml-piMZKkpIf-H-Xh2A-1; Mon,
 23 Oct 2023 11:27:27 -0400
X-MC-Unique: -ucml-piMZKkpIf-H-Xh2A-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E66B41C2B668;
 Mon, 23 Oct 2023 15:27:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C536E2166B26;
 Mon, 23 Oct 2023 15:27:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C8B9C21E6A1F; Mon, 23 Oct 2023 17:27:25 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Juan Quintela <quintela@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Fabiano Rosas <farosas@suse.de>,  Leonardo Bras
 <leobras@redhat.com>,  Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH] migration/ram: Fix compilation with -Wshadow=local
References: <20231023145044.104866-1-thuth@redhat.com>
Date: Mon, 23 Oct 2023 17:27:25 +0200
In-Reply-To: <20231023145044.104866-1-thuth@redhat.com> (Thomas Huth's message
 of "Mon, 23 Oct 2023 16:50:44 +0200")
Message-ID: <87v8axjr4y.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> No need for a new variable here, especially not for one that shadows
> a variable from the beginning of the function scope. With this change
> the code now successfully compiles with -Wshadow=local.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  migration/ram.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 92769902bb..9de9e54fa9 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -3238,8 +3238,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>  
>          ram_flush_compressed_data(rs);
>  
> -        int ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> -        if (ret < 0) {
> +        if (rdma_registration_stop(f, RAM_CONTROL_FINISH) < 0) {
>              qemu_file_set_error(f, ret);
>          }
>      }

Reviewed-by: Markus Armbruster <armbru@redhat.com>

And queued.  Thanks!


