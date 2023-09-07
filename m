Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9101F797E89
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Sep 2023 00:03:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qeN4i-0000RG-Mq; Thu, 07 Sep 2023 18:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeN4f-0000QJ-Mw
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 18:02:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qeN4c-00089C-5X
 for qemu-devel@nongnu.org; Thu, 07 Sep 2023 18:02:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694124121;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xoT6NIICaERNrnte9kspFcdVTPRGu5HYC05FKDLJz1k=;
 b=GrEvZEY9wh19ZRs4tEybyQI4dR7hbT3eWuC7EvWy/oDF0RKoHspJEJ8lbHgIiByl79w/Wq
 +zXAJGw5ufAfEmVMuF1hOM3yC8thyqX5Fu4Y9sLQCMGbVgbxf8v0U70Xa3aXUyS+WyDBoM
 VJl3maG91eH9vlRc+L9D+MCd+uTP1B0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-wq_ur8ugPTWw4wZN-8A_uA-1; Thu, 07 Sep 2023 18:01:58 -0400
X-MC-Unique: wq_ur8ugPTWw4wZN-8A_uA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8EAE78007CE;
 Thu,  7 Sep 2023 22:01:57 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.21])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 79228493110;
 Thu,  7 Sep 2023 22:01:56 +0000 (UTC)
Date: Thu, 7 Sep 2023 17:01:54 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 7/8] qemu-nbd: document -v behavior in respect to --fork
 in man
Message-ID: <425v5322enzl7b3uccmxp7ugqvbtl6siqiiyqbe5zv57rc7pe5@jccxt37pj2fw>
References: <20230906093210.339585-1-den@openvz.org>
 <20230906093210.339585-8-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906093210.339585-8-den@openvz.org>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
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

On Wed, Sep 06, 2023 at 11:32:09AM +0200, Denis V. Lunev wrote:
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Eric Blake <eblake@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>  docs/tools/qemu-nbd.rst | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/docs/tools/qemu-nbd.rst b/docs/tools/qemu-nbd.rst
> index faf6349ea5..5c48ee7345 100644
> --- a/docs/tools/qemu-nbd.rst
> +++ b/docs/tools/qemu-nbd.rst
> @@ -197,7 +197,9 @@ driver options if :option:`--image-opts` is specified.
>  
>  .. option:: -v, --verbose
>  
> -  Display extra debugging information.
> +  Display extra debugging information. This option also keeps opened original
> +  *STDERR* stream if ``qemu-nbd`` process is daemonized due to other options
> +  like :option:`--fork` or :option:`-c`.

As a native speaker, I find the following a bit easier to parse:

This option also keeps the original *STDERR* stream open if ...

I can make that touchup as part of queuing the series.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


