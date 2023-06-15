Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45C93730E8E
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:11:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9fGH-0005o5-6n; Thu, 15 Jun 2023 01:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1q9fGB-0005m7-Gm
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:11:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1q9fG9-0004Ay-W0
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:11:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686805861;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YFY3HnmHmJ0UcWPx5gVIRWs7AirJ+PzwhJGKjHE1lmk=;
 b=jFnItnvTuUw5tAwsQamt+zRAapx0nbFONbUEXWtfk0V2btEatMVP1V0V1nrXXoaqMiL3/F
 MBYxFiqaU/QBUocHm9mCJOX4249ISqitOBEtQPI3B4i1fP8dYrjzZqQV3DCLgnvMOb1eSU
 zUomxxWvUC1lLcJ7p10b0uwzoq8vTUI=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-60-Bd19eSBKPyes5u7Vc1wWvA-1; Thu, 15 Jun 2023 01:10:59 -0400
X-MC-Unique: Bd19eSBKPyes5u7Vc1wWvA-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1b3e18add74so18405625ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 22:10:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686805858; x=1689397858;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YFY3HnmHmJ0UcWPx5gVIRWs7AirJ+PzwhJGKjHE1lmk=;
 b=CnqO7BzbDclfwvGdbXNS7ceht5fjkBvahhSG8wzLO5rHEn51CBCidPFvn3ACIRYDgK
 fG7oWjDBLwx+QFSQ4D8WmDiaSUg/9rDti9J78CRjlXuWvrevW0VUF1ORES6a8JJz/LaE
 3i7nFWvbfzOX6a8akQJpbQAGxcGsfmh8L5eC2QILkBkJUNuo3+/vIxLZgzFUksrtxqLT
 ORRZO5z3MHaHjNZXW6G/Dp01BzI3yd3Wd+Svolq+VGSQvVjviewI84K2h18DGBleFL6c
 vhtN0I4M4tXmDcAa+LEU9PHqBdGBYXRvGCTxdEVhcPuZI7XJwRPE7HX/l6kXu5QQn6yx
 EcPQ==
X-Gm-Message-State: AC+VfDxA+xU8Ep6m0mDMeWUvcM7oEalVHjE6UxBQthTEvOow1u3VmM7E
 w5WYPXuWMqG9cJuh7LE6QpuyZKTRsbgLlri8UPx7mwYdc/lz360csBPw2fahj51jlypOepWFKNP
 ZZlp7o/wph2rnIl4=
X-Received: by 2002:a17:902:da89:b0:1b5:1475:2efb with SMTP id
 j9-20020a170902da8900b001b514752efbmr1398878plx.5.1686805857973; 
 Wed, 14 Jun 2023 22:10:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5m509IUTCYcL+sTRgXBl3yWehdXj48Z3u65vKMGeE1PGhwpDjvSHooGCPKIpi1oipARc6GmQ==
X-Received: by 2002:a17:902:da89:b0:1b5:1475:2efb with SMTP id
 j9-20020a170902da8900b001b514752efbmr1398868plx.5.1686805857676; 
 Wed, 14 Jun 2023 22:10:57 -0700 (PDT)
Received: from zatzit ([2001:4479:e300:2800:4b3b:7242:1327:c685])
 by smtp.gmail.com with ESMTPSA id
 o4-20020a170902bcc400b001ac897026cesm13050661pls.102.2023.06.14.22.10.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 22:10:57 -0700 (PDT)
Date: Thu, 15 Jun 2023 15:10:53 +1000
From: David Gibson <dgibson@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/3] net: socket: remove net_init_socket()
Message-ID: <20230615151053.5c03f7fe@zatzit>
In-Reply-To: <20230609072748.4179873-4-lvivier@redhat.com>
References: <20230609072748.4179873-1-lvivier@redhat.com>
 <20230609072748.4179873-4-lvivier@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri,  9 Jun 2023 09:27:48 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Move the file descriptor type checking before doing anything with it.
> If it's not usable, don't close it as it could be in use by another
> part of QEMU, only fail and report an error.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  net/socket.c | 43 +++++++++++++++++--------------------------
>  1 file changed, 17 insertions(+), 26 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 6b1f0fec3a10..8e3702e1f3a8 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -463,28 +463,6 @@ static int net_socket_fd_check(int fd, Error **errp)
>      return so_type;
>  }
>  
> -static NetSocketState *net_socket_fd_init(NetClientState *peer,
> -                                          const char *model, const char *name,
> -                                          int fd, int is_connected,
> -                                          const char *mc, Error **errp)
> -{
> -    int so_type;
> -
> -    so_type = net_socket_fd_check(fd, errp);
> -    if (so_type < 0) {
> -        close(fd);
> -        return NULL;
> -    }
> -    switch(so_type) {
> -    case SOCK_DGRAM:
> -        return net_socket_fd_init_dgram(peer, model, name, fd, is_connected,
> -                                        mc, errp);
> -    case SOCK_STREAM:
> -        return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
> -    }
> -    return NULL;
> -}
> -
>  static void net_socket_accept(void *opaque)
>  {
>      NetSocketState *s = opaque;
> @@ -728,21 +706,34 @@ int net_init_socket(const Netdev *netdev, const char *name,
>      }
>  
>      if (sock->fd) {
> -        int fd, ret;
> +        int fd, ret, so_type;
>  
>          fd = monitor_fd_param(monitor_cur(), sock->fd, errp);
>          if (fd == -1) {
>              return -1;
>          }
> +        so_type = net_socket_fd_check(fd, errp);
> +        if (so_type < 0) {
> +            return -1;
> +        }
>          ret = qemu_socket_try_set_nonblock(fd);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret, "%s: Can't use file descriptor %d",
>                               name, fd);
>              return -1;
>          }
> -        if (!net_socket_fd_init(peer, "socket", name, fd, 1, sock->mcast,
> -                                errp)) {
> -            return -1;
> +        switch (so_type) {
> +        case SOCK_DGRAM:
> +            if (!net_socket_fd_init_dgram(peer, "socket", name, fd, 1,
> +                                          sock->mcast, errp)) {
> +                return -1;
> +            }
> +            break;
> +        case SOCK_STREAM:
> +            if (!net_socket_fd_init_stream(peer, "socket", name, fd, 1)) {
> +                return -1;
> +            }
> +            break;
>          }
>          return 0;
>      }
> -- 
> 2.39.2
> 


-- 
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat


