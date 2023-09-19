Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DD5757A6892
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:04:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidBY-0003DE-Dh; Tue, 19 Sep 2023 12:02:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qidBC-00033J-VW
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:02:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qidB9-0002Kw-2E
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:02:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695139341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KBQe3PLAWwnhHX8S7+9YPCF/lR9EYqU6vwixiSDKLEY=;
 b=IrnIzcIIkayWKNOtqWlPLPuPbGNDFz7GeNgWmClaa+0DEvP6PmG1mG+fu+Y0CDeJhs5BBv
 iCXdIP86rMq97HJ+yyNNv39RZUMLhrcKQERo3/H+u0x4ATMKnbe6uBd51VGz1CI6z9GleM
 aXvefwv6gaTAbUtRPLFt0zlfk4mWH5Y=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-mjMViMWSNfe7AE7GoSg76g-1; Tue, 19 Sep 2023 12:02:19 -0400
X-MC-Unique: mjMViMWSNfe7AE7GoSg76g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-64726969c8bso15586506d6.0
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:02:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139339; x=1695744139;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KBQe3PLAWwnhHX8S7+9YPCF/lR9EYqU6vwixiSDKLEY=;
 b=g+0+xwZiiIDZtsaEgQ5f8eEFMx5XYraFQYzOdvf9Q73YEo7xhY270fp/VQL/lWE7iR
 Ithr55BJZdAU26MayQW/UOF1q8TUGKkpshCvkW/PRzbI3H7OIo9iJRghBy4A6W8BEBxL
 3TbYg8HVhmMgd4sb6/FR+pbrvm6qejrycoJ7tRut3Y6+PUhF9Vnu52DmQy02/6+g96jk
 OEv4VrtFveRUvEyQvzCKuu8iLCVJbEWkexAHYtxOjOB7qhoqBzIFVBZnwaof+ekZOeJJ
 2iTWjA3BoizRnLACl5On/DG6sC4XKxddZrTD/sMgugInJ5Nh0hxo6H1rQNt/Asj78mbN
 FlVw==
X-Gm-Message-State: AOJu0YxHD0jriO5NLIGUiU6gXqvdrG3sC7FVHI3xkQ4hAFEaUjtY7Hu+
 ZXxzpmNaS1603oCCclYVHEtpFLNs4P+kyoXEev6P3zxr9iRiTlrXvpN54R2rrcH7zNe7YKs0zT6
 7zKtGywMJYllZM+k=
X-Received: by 2002:ad4:5f4f:0:b0:656:32c1:b043 with SMTP id
 p15-20020ad45f4f000000b0065632c1b043mr14893846qvg.3.1695139339264; 
 Tue, 19 Sep 2023 09:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzQbLYPT9E6wN//+51/pAOBxeOeQYXm3A9LKaJ8AIKp3QqjRGvhvlMfBYwKL72BCkzbapEEA==
X-Received: by 2002:ad4:5f4f:0:b0:656:32c1:b043 with SMTP id
 p15-20020ad45f4f000000b0065632c1b043mr14893829qvg.3.1695139338960; 
 Tue, 19 Sep 2023 09:02:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h20-20020a0cf414000000b0065647f59c4esm2914713qvl.51.2023.09.19.09.02.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:02:18 -0700 (PDT)
Date: Tue, 19 Sep 2023 12:02:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, leobras@redhat.com
Subject: Re: [PATCH 20/52] migration/rdma: Drop dead qemu_rdma_data_init()
 code for !@host_port
Message-ID: <ZQnGCOlrmFUL7+aB@x1n>
References: <20230918144206.560120-1-armbru@redhat.com>
 <20230918144206.560120-21-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230918144206.560120-21-armbru@redhat.com>
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

On Mon, Sep 18, 2023 at 04:41:34PM +0200, Markus Armbruster wrote:
> qemu_rdma_data_init() neglects to set an Error when it fails because
> @host_port is null.  Fortunately, no caller passes null, so this is

Indeed they all seem to be non-null.

Before this patch, qemu_rdma_data_init() can still tolerant NULL, not
setting errp but still returning NULL showing an error.

After this patch, qemu_rdma_data_init() should crash at inet_parse() if
it's null.

Would it be simpler and clearer if we just set ERROR() for !host_port?

Thanks,

> merely a latent bug.  Drop the flawed code handling null argument.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  migration/rdma.c | 29 +++++++++++++----------------
>  1 file changed, 13 insertions(+), 16 deletions(-)
> 
> diff --git a/migration/rdma.c b/migration/rdma.c
> index d3dc162363..cc59155a50 100644
> --- a/migration/rdma.c
> +++ b/migration/rdma.c
> @@ -2716,25 +2716,22 @@ static RDMAContext *qemu_rdma_data_init(const char *host_port, Error **errp)
>      RDMAContext *rdma = NULL;
>      InetSocketAddress *addr;
>  
> -    if (host_port) {
> -        rdma = g_new0(RDMAContext, 1);
> -        rdma->current_index = -1;
> -        rdma->current_chunk = -1;
> +    rdma = g_new0(RDMAContext, 1);
> +    rdma->current_index = -1;
> +    rdma->current_chunk = -1;
>  
> -        addr = g_new(InetSocketAddress, 1);
> -        if (!inet_parse(addr, host_port, NULL)) {
> -            rdma->port = atoi(addr->port);
> -            rdma->host = g_strdup(addr->host);
> -            rdma->host_port = g_strdup(host_port);
> -        } else {
> -            ERROR(errp, "bad RDMA migration address '%s'", host_port);
> -            g_free(rdma);
> -            rdma = NULL;
> -        }
> -
> -        qapi_free_InetSocketAddress(addr);
> +    addr = g_new(InetSocketAddress, 1);
> +    if (!inet_parse(addr, host_port, NULL)) {
> +        rdma->port = atoi(addr->port);
> +        rdma->host = g_strdup(addr->host);
> +        rdma->host_port = g_strdup(host_port);
> +    } else {
> +        ERROR(errp, "bad RDMA migration address '%s'", host_port);
> +        g_free(rdma);
> +        rdma = NULL;
>      }
>  
> +    qapi_free_InetSocketAddress(addr);
>      return rdma;
>  }
>  
> -- 
> 2.41.0
> 

-- 
Peter Xu


