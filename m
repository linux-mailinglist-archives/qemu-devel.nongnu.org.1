Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 362BA8295CD
	for <lists+qemu-devel@lfdr.de>; Wed, 10 Jan 2024 10:09:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rNUWM-0001yI-Oh; Wed, 10 Jan 2024 04:05:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNUWD-0001uM-MP
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:05:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rNUWB-0006rs-DO
 for qemu-devel@nongnu.org; Wed, 10 Jan 2024 04:05:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1704877498;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V9GfwuQ+sjl9OorcJiwKSHXUSyhvs3TQ4cKuHzbwpG4=;
 b=SJnMxTfTNPIJTS+KjRIQPQwJ3Lkn+4lRASeoVigzsAHGVpa28KLkFICqYFhjScmYVSEFjU
 XwsZR1fOKT1aPGeqCQAa9WXooAerzFSLN3juTggaqXBwWey8YnvyuCiSWEdIpOXgrDDJbk
 RO850ielQQ+8xeMY7NPXMvmrRb01BJE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-TcCgA9bROhe-DMpEGfR5IQ-1; Wed, 10 Jan 2024 04:04:56 -0500
X-MC-Unique: TcCgA9bROhe-DMpEGfR5IQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8F0E3811E86;
 Wed, 10 Jan 2024 09:04:56 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.108])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id CDFB61C060B1;
 Wed, 10 Jan 2024 09:04:54 +0000 (UTC)
Date: Wed, 10 Jan 2024 09:04:51 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, armbru@redhat.com,
 Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZZ5dnIBIIqFvVvw3@redhat.com>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231127202612.23012-5-farosas@suse.de>
User-Agent: Mutt/2.2.10 (2023-03-25)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.493,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Mon, Nov 27, 2023 at 05:25:46PM -0300, Fabiano Rosas wrote:
> Make sure the data is flushed to disk before closing file
> channels. This will ensure data is on disk at the end of a migration
> to file.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  io/channel-file.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
Acked-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/io/channel-file.c b/io/channel-file.c
> index a6ad7770c6..d4706fa592 100644
> --- a/io/channel-file.c
> +++ b/io/channel-file.c
> @@ -242,6 +242,11 @@ static int qio_channel_file_close(QIOChannel *ioc,
>  {
>      QIOChannelFile *fioc = QIO_CHANNEL_FILE(ioc);
>  
> +    if (qemu_fdatasync(fioc->fd) < 0) {
> +        error_setg_errno(errp, errno,
> +                         "Unable to synchronize file data with storage device");
> +        return -1;
> +    }
>      if (qemu_close(fioc->fd) < 0) {
>          error_setg_errno(errp, errno,
>                           "Unable to close file");
> -- 
> 2.35.3
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


