Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED520785F86
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 20:25:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYsWa-0000t3-Du; Wed, 23 Aug 2023 14:24:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qYsWH-0000qx-1z
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:23:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1qYsWD-0007SN-Lu
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 14:23:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692815022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R9xgtio7QM8+a2dOulQOl9fYMIea5inHg296/g6ntps=;
 b=h194L43tnNYVwkE5TfyJRg1aNAQCVNbOVAQ3LPZ8Y9oMQNSs32WUA01LKmBYO9Ycv0fi1X
 FpBk3WM39YMdPIDpzoqZRdpH7rwza+sl3z2GZUUDJL4gfbOfyFUUmpCZiB7WMM7eovNZeX
 N/M0HIjGkJjR73TkZyu2qZtMe9+L9yw=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-180-T5UCPh2UMnycpqjZtxxHmw-1; Wed, 23 Aug 2023 14:23:39 -0400
X-MC-Unique: T5UCPh2UMnycpqjZtxxHmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C4C7238035A7;
 Wed, 23 Aug 2023 18:23:38 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.128])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7FC422026D76;
 Wed, 23 Aug 2023 18:23:38 +0000 (UTC)
Date: Wed, 23 Aug 2023 13:23:36 -0500
From: Eric Blake <eblake@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 24/24] misc/other: spelling fixes
Message-ID: <jmq5dlhxylaq47ortk242z3yqnmkgcfdvcbia3rgu4tuwblbj7@3t64tyl7fdxv>
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
 <20230823065335.1919380-23-mjt@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230823065335.1919380-23-mjt@tls.msk.ru>
User-Agent: NeoMutt/20230517
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 23, 2023 at 09:53:35AM +0300, Michael Tokarev wrote:
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
> ---
>  accel/tcg/tb-maint.c       | 2 +-
>  backends/tpm/tpm_ioctl.h   | 2 +-
>  chardev/char-socket.c      | 6 +++---
>  chardev/char.c             | 2 +-
>  contrib/plugins/cache.c    | 2 +-
>  contrib/plugins/lockstep.c | 2 +-
>  crypto/afalg.c             | 2 +-
>  crypto/block-luks.c        | 6 +++---
>  crypto/der.c               | 2 +-
>  crypto/der.h               | 6 +++---
>  linux-user/flatload.c      | 2 +-
>  linux-user/syscall.c       | 4 ++--
>  nbd/client-connection.c    | 2 +-
>  net/checksum.c             | 4 ++--
>  net/filter.c               | 4 ++--
>  net/vhost-vdpa.c           | 8 ++++----
>  semihosting/config.c       | 2 +-
>  semihosting/syscalls.c     | 4 ++--
>  softmmu/icount.c           | 2 +-
>  softmmu/ioport.c           | 2 +-
>  20 files changed, 33 insertions(+), 33 deletions(-)

Wide-ranging; but since the nbd/ change caught my eye (rather, my mail
filters), I went ahead and reviewed the entire patch.

> +++ b/crypto/block-luks.c

> @@ -424,5 +424,5 @@ qcrypto_block_luks_store_header(QCryptoBlock *block,
>  
>  /*
> - * Loads the main LUKS header,and byteswaps it to native endianess
> + * Loads the main LUKS header,and byteswaps it to native endianness

While touching this line,

s/header,and/header, and/

> +++ b/net/filter.c
> @@ -93,5 +93,5 @@ ssize_t qemu_netfilter_pass_to_next(NetClientState *sender,
>          /*
>           * if qemu_netfilter_pass_to_next been called, means that
> -         * the packet has been hold by filter and has already retured size
> +         * the packet has been hold by filter and has already returned size

More than just a typo in this sentence.  Maybe:

If qemu_netfilter_pass_to_next has been called, it means that the
packet was held by a filter and has already returned size...

>           * to the sender, so sent_cb shouldn't be called later, just
>           * pass NULL to next.

With those tweaks,

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


