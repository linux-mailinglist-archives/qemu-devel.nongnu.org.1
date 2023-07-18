Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2449F7583E7
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 19:54:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLosa-0007yW-45; Tue, 18 Jul 2023 13:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLosY-0007yB-4C
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:52:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qLosW-0008WN-KS
 for qemu-devel@nongnu.org; Tue, 18 Jul 2023 13:52:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689702771;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rp4j659McL9Khn1rTdRJV6nkgaP/KKOEMjms7soH6iM=;
 b=ShuarYi4Oip86Ouhxn88pStNxvWkMgJgLpdBE8gGGJhppNmZK7BUxVFMyZmNA4Dl932aox
 ArUaF3o9K96CalFQN4a744/O7g7tjomd5m9LVE0ivV1EbirItywn0x4cqlAPHYVsJlrDtj
 AIIdcvbBKMmWp74ZLvZfImu1n7QRDqk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-Kwj5P9QMPACltEqGpB2LDA-1; Tue, 18 Jul 2023 13:52:47 -0400
X-MC-Unique: Kwj5P9QMPACltEqGpB2LDA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BDCF73C13500;
 Tue, 18 Jul 2023 17:52:46 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.192])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 696B5C2C863;
 Tue, 18 Jul 2023 17:52:42 +0000 (UTC)
Date: Tue, 18 Jul 2023 12:52:31 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 5/5] qemu-nbd: handle dup2() error when qemu-nbd finished
 setup process
Message-ID: <mp2ts4suxv56w5hlzmkz77sfrbkr4jjtviuhfyefvcmqwjv7ue@kvkgz7h5xxyw>
References: <20230717145544.194786-1-den@openvz.org>
 <20230717145544.194786-6-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717145544.194786-6-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Mon, Jul 17, 2023 at 04:55:44PM +0200, Denis V. Lunev wrote:
> Fail on error, we are in trouble.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  qemu-nbd.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/qemu-nbd.c b/qemu-nbd.c
> index f27613cb57..cd0e965705 100644
> --- a/qemu-nbd.c
> +++ b/qemu-nbd.c
> @@ -323,7 +323,12 @@ static void *nbd_client_thread(void *arg)
>                  opts->device, srcpath);
>      } else {
>          /* Close stderr so that the qemu-nbd process exits.  */
> -        dup2(STDOUT_FILENO, STDERR_FILENO);
> +        int err = dup2(STDOUT_FILENO, STDERR_FILENO);
> +        if (err < 0) {

Shorter to drop the temporary variable, and just do:

   if (dup2(...) < 0) {

> +            error_report("Could not set stderr to /dev/null: %s",
> +                         strerror(errno));
> +            exit(EXIT_FAILURE);
> +        }
>      }

Either way,
Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


