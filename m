Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A28F730E86
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 07:09:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9fDT-0004Mh-8X; Thu, 15 Jun 2023 01:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1q9fDO-0004MK-D7
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@redhat.com>)
 id 1q9fDM-0003Q2-75
 for qemu-devel@nongnu.org; Thu, 15 Jun 2023 01:08:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686805686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNjhiCBcwL3hFzg9J2Q/A83n5MxTIt3bqPrQEGrE0gY=;
 b=DmbM4d2su6iY8FzndfCa7kF+gkAh2r7NFJRVNbYdLgsEBMDuZvAPHUkyjP9av5CjRV+CAd
 I0D5KfpoE41P/2VwNRQ2qOIyyoFI2u1ewx/ouYCHroVU/EUW2RswUoSNlLWRxYOBYCl3Ss
 qAd+np5luKe/rGImvtcYergNugsh78E=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-9GvRboTGOIuKttezcfpwsw-1; Thu, 15 Jun 2023 01:06:59 -0400
X-MC-Unique: 9GvRboTGOIuKttezcfpwsw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b04dbcf0dbso2739735ad.1
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 22:06:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686805618; x=1689397618;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UNjhiCBcwL3hFzg9J2Q/A83n5MxTIt3bqPrQEGrE0gY=;
 b=RvEK9Q9ZfmFBPEepzKUL2tmk6btozQ9clN4Hbu1/XgzyHJ2sMj+0CnhHhgF62Aac+p
 84qXXNciqBVHrC8bLxmG1Yv/lGWoL3SfGXWXrQFj1zNF4iGnzv0kvkW1dHTrEOmHx98T
 3KYhwWNSbfBs3OC3yET7MIHlpXYstY/lSx41mEgQM+wdvVgYim9BavJ5ONK8z/KQBi2p
 ujf/nkHLlA2V0UFjjLZLzNUEZy3o5OTj0N+Aj9zk7pDO+Iz+uFfTkQ8Iux/Qfp6bUXAN
 19ymPaNuMn9QYwWKAdHQIrFa8ndK9otCaGNcMPKNor2KgV8YTxSRFkJdzozjSWC+nDhX
 10Sw==
X-Gm-Message-State: AC+VfDwl/lt2v/R6Bya0WR0+So5bzF7DWqHgC3/6h4m5rF1M0vi4tDZ3
 GGtMM4B7K8sjr/oItMIn6G1SzTRphy7wH79ZUcB4bAUkFe46U/4ksB6s20Ndn87f29cwb640cKz
 VGj0umJQPvtsdJEc=
X-Received: by 2002:a17:902:cf46:b0:1ac:820e:c34a with SMTP id
 e6-20020a170902cf4600b001ac820ec34amr3518470plg.0.1686805617993; 
 Wed, 14 Jun 2023 22:06:57 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ47vPJzOtJi2+5nnjgFFPhvRYszvsVaXzd4jbnw+7+Zr4K/IHZFZQw5d70qjDke3/SCCpbvzA==
X-Received: by 2002:a17:902:cf46:b0:1ac:820e:c34a with SMTP id
 e6-20020a170902cf4600b001ac820ec34amr3518458plg.0.1686805617660; 
 Wed, 14 Jun 2023 22:06:57 -0700 (PDT)
Received: from zatzit ([2001:4479:e300:2800:4b3b:7242:1327:c685])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a170902820800b001ac7c725c1asm13149863pln.6.2023.06.14.22.06.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jun 2023 22:06:56 -0700 (PDT)
Date: Thu, 15 Jun 2023 15:06:52 +1000
From: David Gibson <dgibson@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] net: socket: prepare to cleanup net_init_socket()
Message-ID: <20230615150652.0dacc153@zatzit>
In-Reply-To: <20230609072748.4179873-2-lvivier@redhat.com>
References: <20230609072748.4179873-1-lvivier@redhat.com>
 <20230609072748.4179873-2-lvivier@redhat.com>
Organization: Red Hat
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=dgibson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri,  9 Jun 2023 09:27:46 +0200
Laurent Vivier <lvivier@redhat.com> wrote:

> Use directly net_socket_fd_init_stream() and net_socket_fd_init_dgram()
> when the socket type is already known.
> 
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>

This makes sense as a clean up regardless of the rest of the series.

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>


> ---
>  net/socket.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/net/socket.c b/net/socket.c
> index ba6e5b0b0035..24dcaa55bc46 100644
> --- a/net/socket.c
> +++ b/net/socket.c
> @@ -587,7 +587,7 @@ static int net_socket_connect_init(NetClientState *peer,
>              break;
>          }
>      }
> -    s = net_socket_fd_init(peer, model, name, fd, connected, NULL, errp);
> +    s = net_socket_fd_init_stream(peer, model, name, fd, connected);
>      if (!s) {
>          return -1;
>      }
> @@ -629,7 +629,7 @@ static int net_socket_mcast_init(NetClientState *peer,
>          return -1;
>      }
>  
> -    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
> +    s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
>      if (!s) {
>          return -1;
>      }
> @@ -683,7 +683,7 @@ static int net_socket_udp_init(NetClientState *peer,
>      }
>      qemu_socket_set_nonblock(fd);
>  
> -    s = net_socket_fd_init(peer, model, name, fd, 0, NULL, errp);
> +    s = net_socket_fd_init_dgram(peer, model, name, fd, 0, NULL, errp);
>      if (!s) {
>          return -1;
>      }
> -- 
> 2.39.2
> 


-- 
David Gibson <dgibson@redhat.com>
Principal Software Engineer, Virtualization, Red Hat


