Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C540F7FB2BA
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 08:29:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7sWE-0001Jt-6s; Tue, 28 Nov 2023 02:28:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7sWC-0001Ji-2z
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 02:28:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1r7sWA-0006Nm-LD
 for qemu-devel@nongnu.org; Tue, 28 Nov 2023 02:28:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701156505;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fiXpuMVAAWLTH8eIrZHcNe+PqhQunIkZ/lb85cFjs5A=;
 b=MeDiEn6WCPLMIWNeb6QZI7biIZSlJzWLNfX5CW1fXNlIbI+tfeLHPqDoFBvJH9ClJo22fU
 KUDFMAjoTUKfLFnechKzIPs3CGG8/FcJRzvb1JpFyOG9i3z7xZffEmDYmYxvtueSM8ib3r
 1BcxPj6izxoFTO8wRelL4bGBB9UofEQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-_HQXNOZNNl-J6AClggUFlg-1; Tue, 28 Nov 2023 02:28:18 -0500
X-MC-Unique: _HQXNOZNNl-J6AClggUFlg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F325185A780;
 Tue, 28 Nov 2023 07:28:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.148])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id EF90520268D8;
 Tue, 28 Nov 2023 07:28:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id EABA721E6A1F; Tue, 28 Nov 2023 08:28:16 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: qemu-devel@nongnu.org,  prerna.saxena@nutanix.com,  quintela@redhat.com,
 berrange@redhat.com,  peter.maydell@linaro.org,  farosas@suse.de
Subject: Re: [PATCH v2] migration: free 'channel' and 'addr' after their use
 in migration.c
References: <20231128065106.120238-1-het.gala@nutanix.com>
Date: Tue, 28 Nov 2023 08:28:16 +0100
In-Reply-To: <20231128065106.120238-1-het.gala@nutanix.com> (Het Gala's
 message of "Tue, 28 Nov 2023 06:51:06 +0000")
Message-ID: <87msuy2v73.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
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

Het Gala <het.gala@nutanix.com> writes:

> 'channel' and 'addr' in qmp_migrate() and qmp_migrate_incoming() are
> not auto-freed. migrate_uri_parse() allocates memory which is
> returned to 'channel', which is leaked because there is no code for
> freeing 'channel' or 'addr'.
> So, free addr and channel to avoid memory leak. 'addr' does shallow
> copying of channel->addr, hence free 'channel' itself and deep free
> contents of 'addr'
>
> Fixes: 5994024f ("migration: Implement MigrateChannelList to qmp
> migration flow")
> Signed-off-by: Het Gala <het.gala@nutanix.com>
> ---
>  migration/migration.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index 28a34c9068..29efb51b62 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2004,6 +2004,8 @@ void qmp_migrate(const char *uri, bool has_channels,
>                            MIGRATION_STATUS_FAILED);
>          block_cleanup_parameters();
>      }
> +    g_free(channel);
> +    qapi_free_MigrationAddress(addr);
>  
>      if (local_err) {
>          if (!resume_requested) {

See my review of v1.


