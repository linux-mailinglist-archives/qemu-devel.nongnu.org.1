Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C171691B993
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 10:13:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6ig-0002sZ-C4; Fri, 28 Jun 2024 04:12:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sN6ie-0002s4-FD
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:12:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sN6ic-00057t-Im
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 04:12:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719562349;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=IS+Yz4+qV2Bgsf/Pp17U4lhZGBAGViAT+TUtb8f80GQ=;
 b=isMddxEbKL3rdJca/983fkW42eVFcxmdX4OhgA59+9oOly/S6rfGfAwMqu6Lq/kCqDym6b
 wkPfAzQMIc8vvMwWHr3aaDD4+6B2adFB5r64LXhZ0Sl3tocI1SZ7iHiCHkTr7u7MWlE7Kg
 iQCx9i9Y8xX6e7hY8eats6K9hlpXWZM=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-s_DQXfbVNnWnWxdq0lmfAg-1; Fri,
 28 Jun 2024 04:12:25 -0400
X-MC-Unique: s_DQXfbVNnWnWxdq0lmfAg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 292201944DDB; Fri, 28 Jun 2024 08:12:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.106])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFE6F300021A; Fri, 28 Jun 2024 08:12:22 +0000 (UTC)
Date: Fri, 28 Jun 2024 09:12:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Gregor Haas <gregorhaas1997@gmail.com>
Cc: qemu-devel@nongnu.org, yaoxt.fnst@fujitsu.com
Subject: Re: [PATCH v2] hw/core/loader: allow loading larger ROMs
Message-ID: <Zn5wUyy2qWpUAtZo@redhat.com>
References: <20240628005817.1672298-1-gregorhaas1997@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240628005817.1672298-1-gregorhaas1997@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.212,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On Thu, Jun 27, 2024 at 05:58:17PM -0700, Gregor Haas wrote:
> The read() syscall is not guaranteed to return all data from a file. The
> default ROM loader implementation currently does not take this into account,
> instead failing if all bytes are not read at once. This change loads the ROM
> using load_image_size() instead, which correctly reads all data using
> multiple calls to read().
> 
> Signed-off-by: Gregor Haas <gregorhaas1997@gmail.com>
> ---
>  hw/core/loader.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index 2f8105d7de..8216781a75 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -1115,14 +1115,13 @@ ssize_t rom_add_file(const char *file, const char *fw_dir,
>  
>      rom->datasize = rom->romsize;
>      rom->data     = g_malloc0(rom->datasize);
> -    lseek(fd, 0, SEEK_SET);
> -    rc = read(fd, rom->data, rom->datasize);
> +    close(fd);
> +    rc = load_image_size(rom->path, rom->data, rom->datasize);
>      if (rc != rom->datasize) {
>          fprintf(stderr, "rom: file %-20s: read error: rc=%zd (expected %zd)\n",
>                  rom->name, rc, rom->datasize);
>          goto err;
>      }
> -    close(fd);

This method can be simplified much more.
All of the original 'open', lseek, g_malloc0, read & close, can be
replaced by something approximately like this (untested):

   g_autoptr(GError) gerr = NULL;
   if (!g_file_get_contents(file, &rom->data, &rom->datasize, &gerr)) {
       fprintf(stderr, "unable to load ROM '%s': %s", file, gerr->message);
       goto err;
   }
   

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


