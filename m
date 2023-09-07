Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A9A10797D8E
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Sep 2023 22:47:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeLtW-0007xX-0r; Thu, 07 Sep 2023 16:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeLtS-0007vA-9o
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 16:46:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeLtQ-000504-3S
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 16:46:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694119582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oJIGrJ3k7zmlW3i/1gB2kKmGnSrvB7I9m5JunKoMsIY=;
 b=JyZaeAP+qhMLMNkgm5A8AI9+ZusFcdqDeJKUwWau0fWruRQVYR61MRu4DWn7F6QJaJ1jd0
 GcW7UlkgQ2NEBHS+iEkfiL38IUdof/VPP5fllvlqTmBla6Be3xrBz15ppFqfQSbB6lnsQ6
 VpyEtJBJgcWtQXOSdlShxGuaqx87TEg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-RAuclzp7OKCFWSH5UqCoXA-1; Thu, 07 Sep 2023 16:46:19 -0400
X-MC-Unique: RAuclzp7OKCFWSH5UqCoXA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5B5562820538;
 Thu,  7 Sep 2023 20:46:19 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5D2E240ED773;
 Thu,  7 Sep 2023 20:46:18 +0000 (UTC)
Date: Thu, 7 Sep 2023 15:46:16 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 1/8] qemu-nbd: improve error message for dup2 error
Message-ID: <2fswbmge4koa6qyfyxorjim74orvyzk6ftbh6yyvxlr4hvthf5@ocafdfch7ndk>
References: <20230906093210.339585-1-den@openvz.org>
 <20230906093210.339585-2-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906093210.339585-2-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Sep 06, 2023 at 11:32:03AM +0200, Denis V. Lunev wrote:
> This error is happened when we are not able to close the pipe to the

s/is happened when/happens if/

> parent (to trace errors in the child process) and assign stderr to
> /dev/null as required by the daemonizing convention.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> Suggested-by: Eric Blake <eblake@redhat.com>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index aaccaa3318..4575e4291e 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -324,7 +324,7 @@ static void *nbd_client_thread(void *arg)
>      } else {
>          /* Close stderr so that the qemu-nbd process exits.  */
>          if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
> -            error_report("Could not set stderr to /dev/null: %s",
> +            error_report("Could not release pipe to parent: %s",
>                           strerror(errno));
>              exit(EXIT_FAILURE);
>          }
> @@ -1181,7 +1181,7 @@ int main(int argc, char **argv)
>  
>      if (fork_process) {
>          if (dup2(STDOUT_FILENO, STDERR_FILENO) < 0) {
> -            error_report("Could not set stderr to /dev/null: %s",
> +            error_report("Could not release pipe to parent: %s",
>                           strerror(errno));
>              exit(EXIT_FAILURE);
>          }
> -- 
> 2.34.1
>

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


