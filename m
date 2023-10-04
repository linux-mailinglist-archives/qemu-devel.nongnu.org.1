Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EA43B7B7B1A
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 11:06:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnxhb-0000JS-58; Wed, 04 Oct 2023 04:57:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxhX-0000FS-MK
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:57:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnxhV-0002EB-U3
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 04:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696409869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xABv1eu7kBKoAyjzNCC6eSzeLK84Y5zhYEDZCeq4Nos=;
 b=cWqMwDJ56sIYO1RbGem2lsrq/wOAnxa6UZ3wW5eqgDbGTCGNL58tn2SCRiM2yHwlmQAKvL
 JugBsH5t2mi8Nrq4MouDHbVb30M7X4sKLopGAKcLgqxUNQBOpZwipx2Ks3O3HM5z5v/CMR
 KKfckCIIXkzFcBGrc52gZXFNm9WiCBk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Rc59x1--MNu6x79gb0wpQQ-1; Wed, 04 Oct 2023 04:57:38 -0400
X-MC-Unique: Rc59x1--MNu6x79gb0wpQQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-40590e6bd67so13626425e9.2
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 01:57:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696409857; x=1697014657;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xABv1eu7kBKoAyjzNCC6eSzeLK84Y5zhYEDZCeq4Nos=;
 b=E2nMZPMWZQyZfDHOaymwHJNYt0T+/Bay4GgaEWbfSc2XQmkB3t267nUcijIbH9cuc7
 oeZIgwUUNqz+r8+fdrD7YP8USL6BciMiA0MZePal9RaYTXOI07e5zdEeYoGYhtBUEinO
 uxLeSHZiiocVbZYp5wZ1qfNTDcnhDG4n8ldSOColv6nXKMcAwg4wPhS57FX6pGlfAG5R
 JCT2KCIabhAknCBTJNQD/VOrjw7vPvGXjE6wfxi8W5Czu41DpUQUVMVBJLnR6OuxPy4N
 GJKmqzbb8a5l+ec8uhtciW2htEGJjWdMqa8Y0Oehun8/x+iQ6WN7IMEDdL6USAkEROgV
 7EXw==
X-Gm-Message-State: AOJu0Yz4IWZPEJt5qqFRqJXGjarSAHzW9q2z6F7VZ5WSw/0iojiBfQEr
 00gjnAQAoqSV7CHz/IVoNYYyCo0SnCkMZU2ffWFUQ9YlWWcr9D8xmDmtQjvUPlTAj+tLepOoCfY
 cn9ER8wEN1OneOaU=
X-Received: by 2002:a1c:791a:0:b0:406:5308:cfeb with SMTP id
 l26-20020a1c791a000000b004065308cfebmr1732785wme.11.1696409856815; 
 Wed, 04 Oct 2023 01:57:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXhRfVkuxXF66F42JfMhbB01j8TaACY/gln6c/SABjFD6B1vG79mkKCpNQXx65tc+PXGi1qg==
X-Received: by 2002:a1c:791a:0:b0:406:5308:cfeb with SMTP id
 l26-20020a1c791a000000b004065308cfebmr1732769wme.11.1696409856422; 
 Wed, 04 Oct 2023 01:57:36 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 a15-20020a5d570f000000b003217cbab88bsm3460601wrv.16.2023.10.04.01.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Oct 2023 01:57:35 -0700 (PDT)
Date: Wed, 4 Oct 2023 04:57:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-trivial@nongnu.org
Subject: Re: [PATCH] hw/net/vhost_net: Silence compiler warning when
 compiling with -Wshadow
Message-ID: <20231004045724-mutt-send-email-mst@kernel.org>
References: <20231004084939.96349-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004084939.96349-1-thuth@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Oct 04, 2023 at 10:49:39AM +0200, Thomas Huth wrote:
> Rename the innermost local variables to avoid compiler warnings
> with "-Wshadow".
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge

> ---
>  hw/net/vhost_net.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/net/vhost_net.c b/hw/net/vhost_net.c
> index 57427a3997..e8e1661646 100644
> --- a/hw/net/vhost_net.c
> +++ b/hw/net/vhost_net.c
> @@ -313,8 +313,8 @@ fail:
>                  /* Queue might not be ready for start */
>                  continue;
>              }
> -            int r = vhost_net_set_backend(&net->dev, &file);
> -            assert(r >= 0);
> +            int ret = vhost_net_set_backend(&net->dev, &file);
> +            assert(ret >= 0);
>          }
>      }
>      if (net->nc->info->poll) {
> @@ -629,8 +629,8 @@ err_start:
>      if (net->nc->info->type == NET_CLIENT_DRIVER_TAP) {
>          file.fd = VHOST_FILE_UNBIND;
>          file.index = idx;
> -        int r = vhost_net_set_backend(&net->dev, &file);
> -        assert(r >= 0);
> +        int ret = vhost_net_set_backend(&net->dev, &file);
> +        assert(ret >= 0);
>      }
>  
>      vhost_dev_stop(&net->dev, vdev, false);
> -- 
> 2.41.0


