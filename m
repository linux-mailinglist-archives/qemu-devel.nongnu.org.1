Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 61652730E8A
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:09:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9fEZ-0004gR-Jk; Thu, 15 Jun 2023 01:09:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1q9fET-0004fl-MV
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:09:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1q9fES-0003cA-40
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:09:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686805755;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MBdNqz8YuutfJ4dhkh9tPWAHj665As8ZDYxrFoKXW4g=;
 b=bctnLgBXADNGn9sB/gDO3BGzu270eL0j83+PImiJUVC+gNr2mfvAr20C1RT9xX6r2audiF
 loxigmwbdaO+GsF4Sw5lisgp5t4/MGyeepGU+sMET1vYuchCzeNoqoLXg47Xe8Q43hAwol
 6EL13bzwgijDRChcOYBcpFMGmbK2xh8=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-qc4Ll-jYNcSBGT2bMedhJA-1; Thu, 15 Jun 2023 01:09:13 -0400
X-MC-Unique: qc4Ll-jYNcSBGT2bMedhJA-1
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-53f6e194e7bso5527473a12.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 22:09:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686805752; x=1689397752;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MBdNqz8YuutfJ4dhkh9tPWAHj665As8ZDYxrFoKXW4g=;
 b=f327Tg+VCE61dd+z26FhfcPAbJG5Q9BCLT9FFAvefAjxV0yiICCX7LdXReU7xdofbY
 HqSBP83NGVzheFMYKKdfVqXvhNj/W3tWcovYN0kA7s7v0KrAeDvJ5jYMZCnc3MyDeGbz
 1447kVyxQwMXEJk8LF1PKCe2p3+z56yaBv/DkRgc4AnZyDeZIpLnVfVRaYtjInJTMDE6
 eOxeqEn7EGIAQ1qkHRNCZb+DXoHsqRQ5Q+mkLIbzeqdMZwZUQRFYDYAEJnchcUY1LpC2
 4oSshj+N3MhSMHv/O/Zq1tGhlRC1BZ4MzFuC9uve9dC15KY6WEUzGJ9+T+KJLh9TtLzq
 WsbQ==
X-Gm-Message-State: AC+VfDxBBgVQf8LN01/Q23bMb8z27J+IXyabGV5c6zfL0F+5JO+VuooI
 vr2raSK5pfoJpCL8UU/lJ6Ab/4+v13SmkXmi0KmaWr3zORRID7mWPOYzYUNk7/Sz1FVUSVDKpkk
 oM/schtOBAzc1hiBQhqN7OaE=
X-Received: by 2002:a05:6a20:1603:b0:11a:908:eab8 with SMTP id
 l3-20020a056a20160300b0011a0908eab8mr4434305pzj.53.1686805751958; 
 Wed, 14 Jun 2023 22:09:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5nnRP0c5XtvuCT1QEBfMrBRuWupaMZJ/rsiGmP82sZ1ss3PMmkymN7fsOUWqW/CO/VyrZkcQ==
X-Received: by 2002:a05:6a20:1603:b0:11a:908:eab8 with SMTP id
 l3-20020a056a20160300b0011a0908eab8mr4434292pzj.53.1686805751683; 
 Wed, 14 Jun 2023 22:09:11 -0700 (PDT)
Received: from zatzit ([2001:4479:e300:2800:4b3b:7242:1327:c685])
 by smtp.gmail.com with ESMTPSA id
 i8-20020a170902c94800b001b02df0ddbbsm6484831pla.275.2023.06.14.22.09.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 22:09:10 -0700 (PDT)
Date: Thu, 15 Jun 2023 15:09:06 +1000
From: David Gibson <dgibson@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 2/3] net: socket: move fd type checking to its own function
Message-ID: <20230615150906.2bf4ca97@zatzit>
In-Reply-To: <20230609072748.4179873-3-lvivier@redhat.com>
References: <20230609072748.4179873-1-lvivier@redhat.com>
 <20230609072748.4179873-3-lvivier@redhat.com>
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

On Fri,  9 Jun 2023 09:27:47 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


> ---
>  net/socket.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index 24dcaa55bc46..6b1f0fec3a10 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -446,16 +446,32 @@ static NetSocketState *net_socket_fd_init_stream(NetClientState *peer,
>      return s;
>  }
>  
> +static int net_socket_fd_check(int fd, Error **errp)
> +{
> +    int so_type, optlen = sizeof(so_type);
> +
> +    if (getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
> +        (socklen_t *)&optlen) < 0) {
> +        error_setg(errp, "can't get socket option SO_TYPE");
> +        return -1;
> +    }
> +    if (so_type != SOCK_DGRAM && so_type != SOCK_STREAM) {
> +        error_setg(errp, "socket type=%d for fd=%d must be either"
> +                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
> +        return -1;
> +    }
> +    return so_type;
> +}
> +> 
>  static NetSocketState *net_socket_fd_init(NetClientState *peer,
>                                            const char *model, const char *name,
>                                            int fd, int is_connected,
>                                            const char *mc, Error **errp)
>  {
> -    int so_type = -1, optlen=sizeof(so_type);
> +    int so_type;
>  
> -    if(getsockopt(fd, SOL_SOCKET, SO_TYPE, (char *)&so_type,
> -        (socklen_t *)&optlen)< 0) {
> -        error_setg(errp, "can't get socket option SO_TYPE");
> +    so_type = net_socket_fd_check(fd, errp);
> +    if (so_type < 0) {
>          close(fd);
>          return NULL;
>      }
> @@ -465,10 +481,6 @@ static NetSocketState *net_socket_fd_init(NetClientState *peer,
>                                          mc, errp);
>      case SOCK_STREAM:
>          return net_socket_fd_init_stream(peer, model, name, fd, is_connected);
> -    default:
> -        error_setg(errp, "socket type=%d for fd=%d must be either"
> -                   " SOCK_DGRAM or SOCK_STREAM", so_type, fd);
> -        close(fd);
>      }
>      return NULL;
>  }
> -- 
> 2.39.2
> 


-- 
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat


