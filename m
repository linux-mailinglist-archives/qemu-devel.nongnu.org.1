Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1971C7C0486
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 21:24:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqIKl-0004Hw-0Z; Tue, 10 Oct 2023 15:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqIKf-0004EQ-3o
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 15:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qqIKd-0006Gl-36
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 15:23:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696965829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tdf9tlvmJoBIA1xq4cZfUcUDAPDqsQ0GCpezIfRWQwg=;
 b=dzWe39tHKcMLV/3grgZniYrvib1vlzXA2DHAAylpm2566jnHEJjzZHh4nJzmqMc/DI3RJL
 kHR9vXyNuQpKiQwb91C2DlrdJXTzk4ybZnHLfHo6rrfojmdSmOBixz1rJCy/ki8+c8u65g
 UN+GmXUKPwdIuc+d9Bd/3dubiAi7Ctw=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-XMLUADQHOJelpO6CJJA7Wg-1; Tue, 10 Oct 2023 15:23:43 -0400
X-MC-Unique: XMLUADQHOJelpO6CJJA7Wg-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41b19426eedso7952331cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 12:23:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696965823; x=1697570623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tdf9tlvmJoBIA1xq4cZfUcUDAPDqsQ0GCpezIfRWQwg=;
 b=QcNCel/4JkTT/gJBeawo+51sCsPrCzlz26C0Tt8MfcJgGJRsnXk/yZ5dOri2Z982iu
 BssuGa062DMAnBBRaD/SDbZa9/4iP3oKsGtfIpQ6BIubVKR2BOxe8Dq3zY91J14jeNrI
 +UdXxbzbPm9g/Z9ooDY/rJRyXihiqXqUqjcKbpReic47Tjz/joYS0zqIMTMrPo/7TPqP
 zfBHwJi/AIJvq12qFxUgRh3QHifaHkiknfyX2FEBeCuQyqXm+SsUo3SwNVuQIboQ0FQj
 d9i7Wwc9bsbGb7Q7CKY5KevVQdrYDwCHNTAU9Ihr3Ou9jTTuV0QV7OFcl0CVA5Tr7J7Z
 GUqA==
X-Gm-Message-State: AOJu0YyKV6B9Zc64dVSeXcndw1ESMV6/L3tBVOo3wh8tgFNBpUN0SB8Y
 kOkV+a4DlwjUqezQnVBNdnVAN9EtIQZo2go2wpAZvLAe+AdgWWCO6PGuPyyRfLR1WPAO6WJx1Gl
 XkHgL+OqPZmVoMhE=
X-Received: by 2002:a05:6214:2303:b0:658:30c4:206 with SMTP id
 gc3-20020a056214230300b0065830c40206mr21316610qvb.0.1696965822990; 
 Tue, 10 Oct 2023 12:23:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCPKsvkCSkv8LRvuhRydv7mXCd2iXQSXiZ/hxzJSiU36tnBKr7s/Q74b81kL0NWe5/M5+o2A==
X-Received: by 2002:a05:6214:2303:b0:658:30c4:206 with SMTP id
 gc3-20020a056214230300b0065830c40206mr21316590qvb.0.1696965822723; 
 Tue, 10 Oct 2023 12:23:42 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 s14-20020a0cdc0e000000b00656329bb3b1sm5015676qvk.10.2023.10.10.12.23.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 12:23:42 -0700 (PDT)
Date: Tue, 10 Oct 2023 15:23:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Dmitry Frolov <frolov@swemel.ru>
Cc: Juan Quintela <quintela@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org,
 sdl.qemu@linuxtesting.org
Subject: Re: [PATCH v1] migration: fix RAMBlock add NULL check
Message-ID: <ZSWkvPH0asP8xXSu@x1n>
References: <20231010104851.802947-1-frolov@swemel.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231010104851.802947-1-frolov@swemel.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Oct 10, 2023 at 01:48:53PM +0300, Dmitry Frolov wrote:
> qemu_ram_block_from_host() may return NULL, which will be dereferenced w/o

AFAIU this path is only called from trusted sites, so I don't see why it
can be NULL?  Do you have any scenario that can trigger this?

> check. Usualy return value is checked for this function.
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
> 
> Fixes: c7c0e72408df5e7821c0e995122fb2fe0ac001f1 ("migration/ram: Handle RAM block resizes during precopy")

Normally if we attach Fixes it means we want to backport it to stable.
Here I'd like to double check on above to see whether we'd need a Fixes.

> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

The patch itself looks all fine; though if I'm going to add some print, I'd
print something more to make it at least try to be more useful (host,
old_size, new_size).  I had a feeling that we can already assert.

Thanks,

> ---
>  migration/ram.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index e4bfd39f08..bd4b7574e1 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -4281,6 +4281,11 @@ static void ram_mig_ram_block_resized(RAMBlockNotifier *n, void *host,
>      RAMBlock *rb = qemu_ram_block_from_host(host, false, &offset);
>      Error *err = NULL;
>  
> +    if (!rb) {
> +        error_report("RAM block not found");
> +        return;
> +    }
> +
>      if (migrate_ram_is_ignored(rb)) {
>          return;
>      }
> -- 
> 2.34.1
> 
> 

-- 
Peter Xu


