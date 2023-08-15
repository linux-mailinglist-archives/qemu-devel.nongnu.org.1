Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A26B77D08A
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Aug 2023 19:05:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVxSL-0000pd-Aa; Tue, 15 Aug 2023 13:03:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVxSK-0000pS-A2
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 13:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qVxSH-0001kS-PT
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 13:03:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692119020;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yce5+i7/MT8Wei0BFHYXQsfDpcEavazc8SzXGT63R+I=;
 b=V4iIGe9Q7ZbLXgfS3B3tS/BNgYgjWyB/cbE9glpK/nEHwe5Hp+r88IQCGVBj3xbo876lHO
 w0TmNHWg9XdtroGIz5oPhh10bkCkeQxrvNz7Tff6w1JmGD0ghVxPP7OAZttcGf6yct+H68
 KM85xRd0YoC2nB0ozpNiToQDkdi0mos=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-413-zesKoyOZNnW3tB6HIppD6Q-1; Tue, 15 Aug 2023 13:03:37 -0400
X-MC-Unique: zesKoyOZNnW3tB6HIppD6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3881185A78F;
 Tue, 15 Aug 2023 17:03:33 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.62])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 3F021C15BAD;
 Tue, 15 Aug 2023 17:03:33 +0000 (UTC)
Date: Tue, 15 Aug 2023 12:03:31 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH RFC 4/7] os-posix.c, softmmu/vl.c: move
 os_parse_cmd_args() into qemu_init()
Message-ID: <4utathdsebnxgsbyyxtxy3fhsjfdkna5kvrndh53mwhbq4joz3@fxvwgltozwhw>
References: <cover.1691843673.git.mjt@tls.msk.ru>
 <ed55f033aceaccebc387bc5d1ed98a989b30ca4a.1691843673.git.mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed55f033aceaccebc387bc5d1ed98a989b30ca4a.1691843673.git.mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
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

On Sat, Aug 12, 2023 at 03:47:58PM +0300, Michael Tokarev wrote:
> This will stop linking softmmu-specific os_parse_cmd_args() into every
> qemu executable which happens to use other functions from os-posix.c,
> such as os_set_line_buffering() or os_setup_signal_handling().
> 
> Also, since there's no win32-specific options, *all* option parsing is
> now done in softmmu/vl.c:qemu_init(), which is easier to read without
> extra indirection, - all options are in the single function now.
> 
> This effectively reverts commit 59a5264b99434.
> 
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  include/sysemu/os-posix.h |  1 -
>  include/sysemu/os-win32.h |  1 -
>  os-posix.c                | 79 ---------------------------------------
>  softmmu/vl.c              | 76 +++++++++++++++++++++++++++++++++++--
>  4 files changed, 73 insertions(+), 84 deletions(-)

> +++ b/os-posix.c

> -    case QEMU_OPTION_chroot:
> -        warn_report("option is deprecated, use '-run-with chroot=...' instead");
> -        os_set_chroot(optarg);
> -        break;

How long has this been deprecated (to make sure code motion still
makes sense, rather than deletion)...

/me reads docs/about/deprecated.rst

Ah, just recently, in 8.1.  Okay.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


