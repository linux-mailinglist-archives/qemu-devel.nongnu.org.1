Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 116E87CD6A9
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 10:34:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qt1xZ-0000EE-8x; Wed, 18 Oct 2023 04:31:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt1xI-0007xK-4m
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:31:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1qt1xG-00047l-Bh
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 04:31:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697617861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=53NdlOaN5NnsQH2Dn7kiV7xqkY5R8FOtpalIPF4LmRs=;
 b=g9v+RROH0c8LC1KEp4cTMJD2WBoDAPP6w1eixsiWA8HxpHmvblfLwa0u5z0WZcZMzwbhcV
 3E0Zr6FQp3ynMIde2mPIzgfcAyOpKdNK4XGqRtYqH8p3fJ2r7w3lrWukD5PZcWc1aL6X5n
 KsXWBMy5CfYV193RbALfDEUsvPh9jNo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-231-Y-3U-bCnM6CgCtg1eR-n9w-1; Wed, 18 Oct 2023 04:30:58 -0400
X-MC-Unique: Y-3U-bCnM6CgCtg1eR-n9w-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B2670185A7B4;
 Wed, 18 Oct 2023 08:30:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.56])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8ED56492BEF;
 Wed, 18 Oct 2023 08:30:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 82E8721E6A1F; Wed, 18 Oct 2023 10:30:56 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Juan Quintela <quintela@redhat.com>
Cc: qemu-devel@nongnu.org,  libvir-list@redhat.com,  Fabiano Rosas
 <farosas@suse.de>,  qemu-block@nongnu.org,  Leonardo Bras
 <leobras@redhat.com>,  Peter Xu <peterx@redhat.com>,  Fam Zheng
 <fam@euphon.net>,  Stefan Hajnoczi <stefanha@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH v6 2/5] migration: migrate 'inc' command option is
 deprecated.
References: <20231017172307.22858-1-quintela@redhat.com>
 <20231017172307.22858-3-quintela@redhat.com>
Date: Wed, 18 Oct 2023 10:30:56 +0200
In-Reply-To: <20231017172307.22858-3-quintela@redhat.com> (Juan Quintela's
 message of "Tue, 17 Oct 2023 19:23:04 +0200")
Message-ID: <87jzrkwcvz.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Juan Quintela <quintela@redhat.com> writes:

> Use blockdev-mirror with NBD instead.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Acked-by: Stefan Hajnoczi <stefanha@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Juan Quintela <quintela@redhat.com>
> ---
>  docs/about/deprecated.rst      | 9 +++++++++
>  qapi/migration.json            | 8 +++++++-
>  migration/migration-hmp-cmds.c | 5 +++++
>  migration/migration.c          | 5 +++++
>  4 files changed, 26 insertions(+), 1 deletion(-)
>
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 2febd2d12f..b51136f50a 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -461,3 +461,12 @@ Migration
>  ``skipped`` field in Migration stats has been deprecated.  It hasn't
>  been used for more than 10 years.
>  
> +``inc`` migrate command option (since 8.2)
> +''''''''''''''''''''''''''''''''''''''''''
> +
> +Use blockdev-mirror with NBD instead.
> +
> +As an intermediate step the ``inc`` functionality can be achieved by
> +setting the ``block-incremental`` migration parameter to ``true``.
> +But this parameter is also deprecated.
> +

If you need to respin for some other reason, drop the blank line at end
of file.  Same in later patches.

[...]


