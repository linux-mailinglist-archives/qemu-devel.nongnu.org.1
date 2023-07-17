Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6DF756CB7
	for <lists+qemu-devel@lfdr.de>; Mon, 17 Jul 2023 21:05:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLTW1-0003lv-TQ; Mon, 17 Jul 2023 15:04:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLTVz-0003lG-KP
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:04:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLTVy-0003I4-2d
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 15:04:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689620649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NigUNFyvDGd6KFUBo5WRVEnX3zhb/G6akeFFQDMQrLQ=;
 b=e6u79fntpjAVJaJbdEO6R/zH5/wOuWWjArqz+uBhSfqCRdgbRZB1ZgwvF6Ov09Dr3fY6wG
 S6e5vHv/6/mRcH9O/xPuOkGVK62dkbUuA4bqepyj/1KlGErSsjaABswYSETSP4SSpl7+on
 AXNRYB4ICYteKWBRQW0PHNtND+8RMdo=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-460-_W53bRrfOueZCDxkyt24QA-1; Mon, 17 Jul 2023 15:04:05 -0400
X-MC-Unique: _W53bRrfOueZCDxkyt24QA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C13281C07581;
 Mon, 17 Jul 2023 19:04:04 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.85])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 02B311454142;
 Mon, 17 Jul 2023 19:04:03 +0000 (UTC)
Date: Mon, 17 Jul 2023 14:04:02 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>, qemu-stable@nongnu.org
Subject: Re: [PATCH 2/5] qemu-nbd: fix regression with qemu-nbd --fork run
 over ssh
Message-ID: <itps4q6icdu52qtjk46by4mg6syz7lobzzgskefkpln5fkcz6u@renougv655gd>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-3-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145544.194786-3-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, Jul 17, 2023 at 04:55:41PM +0200, Denis V. Lunev wrote:
> Commit e6df58a5578fee7a50bbf36f4a50a2781cff855d
>     Author: Hanna Reitz <hreitz@redhat.com>
>     Date:   Wed May 8 23:18:18 2019 +0200
>     qemu-nbd: Do not close stderr
> has introduced an interesting regression. Original behavior of
>     ssh somehost qemu-nbd /home/den/tmp/file -f raw --fork
> was the following:
>  * qemu-nbd was started as a daemon
>  * the command execution is done and ssh exited with success
> 
> The patch has changed this behavior and 'ssh' command now hangs forever.
> 
> According to the normal specification of the daemon() call, we should
> endup with STDERR pointing to /dev/null. That should be done at the
> very end of the successful startup sequence when the pipe to the
> bootstrap process (used for diagnostics) is no longer needed.
> 
> This could be achived in the same way as done for 'qemu-nbd -c' case.
> That was commit 0eaf453e, also fixing up e6df58a5. STDOUT copying to
> STDERR does the trick.
> 
> This also leads to proper 'ssh' connection closing which fixes my
> original problem.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: <qemu-stable@nongnu.org>
> ---
>  qemu-nbd.c | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index 77f98c736b..186ce9474c 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -274,6 +274,7 @@ static void *show_parts(void *arg)
>  
>  struct NbdClientOpts {
>      char *device;
> +    bool fork_process;
>  };
>  
>  static void *nbd_client_thread(void *arg)
> @@ -317,7 +318,7 @@ static void *nbd_client_thread(void *arg)
>      /* update partition table */
>      pthread_create(&show_parts_thread, NULL, show_parts, opts->device);
>  
> -    if (verbose) {
> +    if (verbose && !opts->fork_process) {

It seems a bit odd to use the global 'fork' but the local
'opts->fork_process' in the same conditional.  Perhaps patch 1/5
should be modified to also pass verbose through opts?

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


