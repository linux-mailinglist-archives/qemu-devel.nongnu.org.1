Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 135EA77D008
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 18:24:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVwp4-0005dW-17; Tue, 15 Aug 2023 12:23:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVwp0-0005dK-K7
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:23:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVwoz-0000Xx-4V
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 12:23:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692116583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F9UcykFJCok2lrRHedf5S/3rgJx9h5oQBBVX+025xYc=;
 b=c9fvjHFDnOd8+/Ep7q3sWw0fyw1Ke+XFjQVBn3bTNcg5TaZgva9Wi2g5aCLP2cjFRFnujD
 wkjI7MrGOa1pRVN77Oj8rcAeWwZZ/rj545lPaU+Jj/3obXD0+0vXCkOx6uKnkg/PYfEb5O
 DGCkPE0NfVMgcLGDg6c6MTZ2b7h7o/8=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-361-YVnr66xAOAiMMZxrRDZ6Kg-1; Tue, 15 Aug 2023 12:23:01 -0400
X-MC-Unique: YVnr66xAOAiMMZxrRDZ6Kg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 55FD52932486;
 Tue, 15 Aug 2023 16:23:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 137471121314;
 Tue, 15 Aug 2023 16:23:00 +0000 (UTC)
Date: Tue, 15 Aug 2023 11:22:59 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 1/7] include/sysemu/os-posix.h: move *daemonize*
 declaration together
Message-ID: <spv6irkv7exu427tsirclisgyqjsvfeowfobggvhfejnh3ywpq@f22krtelhbex>
References: <cover.1691843673.git.mjt@tls.msk.ru>
 <2321b2404d3bc9b12ac1605dd59b221f61e294b8.1691843673.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2321b2404d3bc9b12ac1605dd59b221f61e294b8.1691843673.git.mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
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

On Sat, Aug 12, 2023 at 03:47:55PM +0300, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/sysemu/os-posix.h | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

> 
> diff --git a/include/sysemu/os-posix.h b/include/sysemu/os-posix.h
> index 1030d39904..65b9c94e91 100644
> --- a/include/sysemu/os-posix.h
> +++ b/include/sysemu/os-posix.h
> @@ -47,13 +47,12 @@ void os_set_line_buffering(void);
>  void os_setup_early_signal_handling(void);
>  void os_set_proc_name(const char *s);
>  void os_setup_signal_handling(void);
> +int os_set_daemonize(bool d);
> +bool is_daemonized(void);
>  void os_daemonize(void);
>  void os_setup_post(void);
>  int os_mlock(void);
>  
> -int os_set_daemonize(bool d);
> -bool is_daemonized(void);
> -
>  /**
>   * qemu_alloc_stack:
>   * @sz: pointer to a size_t holding the requested usable stack size
> -- 
> 2.39.2
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


