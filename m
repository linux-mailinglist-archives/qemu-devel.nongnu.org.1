Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF987AAF64
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 12:23:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjdJs-0003bL-1e; Fri, 22 Sep 2023 06:23:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjdJp-0003aq-UO
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:23:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qjdJm-0006Go-J7
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 06:23:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695378205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MOpPYxL42GKs0jJm+ztk/5+3c6vMTjxmqEKKWtoWqqE=;
 b=Pjos0H91EkPOtEOPzcUJuK3CUMfaBnJnIbh7ScATfAz9C7gunNNOdh7X6CguF7e8bhXH/k
 dTY3kYRrt+WViqm2FS+DzFatJMIDuUSnNCFTSX9epoyoai4RGhmS/CGi5fKGi8ltS9ji4X
 fVF76NmypZZKu9kyYv/MwBBX9o/xMr8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-689-Wo56DK6hNUCsRN5HdWKJdg-1; Fri, 22 Sep 2023 06:23:24 -0400
X-MC-Unique: Wo56DK6hNUCsRN5HdWKJdg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-9ae12311183so156469366b.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 03:23:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695378203; x=1695983003;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MOpPYxL42GKs0jJm+ztk/5+3c6vMTjxmqEKKWtoWqqE=;
 b=xRw9Ie2HGTrurO7HfECpp+W7gsojlxKrdADSbOSf7WEFjeXrfzmQS5CA8F/PZQBUwg
 O0Gski9T80+L8Vg6+VWNplaO7tcZwPBXM35+EGE36RMUGjAxNGdqqKdZ2s3X+6SqGsn5
 06civtVbL+AtGd4mFC3GBcVU9NCaq08YSb41sIoui+Y+ZB2BELGs7Qk5erhn4TpMDue8
 ZPXyEESE3on4G7bC2+ft1xvqdd4idin/zMHGrlPlMdiKcv20kcURBIl6+evSXQNfdyjD
 nKqtw8bbLpfnt0vpEnOzsRgQVzI/flQ/5cdamR31ckTQN/nTDLattTKCK0eJz7DRkio3
 oAmw==
X-Gm-Message-State: AOJu0YwvQVj50m3y7j+1cuiTqBS+rVMBZunlDcyr3gFfbHkS6T7Q8pVn
 BtXEwY3lcHPW9vd/mbJKv+uWR1N0DGVVfEo5MmDJdFvHcFSzLLG9CM1ADQ/6KZfmrD88H6XGAo/
 jy3HgG/RdBLR6KPw=
X-Received: by 2002:a17:906:159:b0:9a1:f21e:cdff with SMTP id
 25-20020a170906015900b009a1f21ecdffmr8216736ejh.23.1695378202676; 
 Fri, 22 Sep 2023 03:23:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0Na5qYZdgcyXXYnEbBJZ8Xsqj172ijeEG71mN3id7uiA6+RyRP76+T6DGqqJzns6tlKXy+g==
X-Received: by 2002:a17:906:159:b0:9a1:f21e:cdff with SMTP id
 25-20020a170906015900b009a1f21ecdffmr8216717ejh.23.1695378202381; 
 Fri, 22 Sep 2023 03:23:22 -0700 (PDT)
Received: from redhat.com ([2.52.150.187]) by smtp.gmail.com with ESMTPSA id
 lv23-20020a170906bc9700b0099d798a6bb5sm2494904ejb.67.2023.09.22.03.23.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 03:23:21 -0700 (PDT)
Date: Fri, 22 Sep 2023 06:23:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-arm@nongnu.org, Coiby Xu <Coiby.Xu@gmail.com>
Subject: Re: [PATCH v2 17/22] util/vhost-user-server: Clean up local variable
 shadowing
Message-ID: <20230922062306-mutt-send-email-mst@kernel.org>
References: <20230904161235.84651-1-philmd@linaro.org>
 <20230904161235.84651-18-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230904161235.84651-18-philmd@linaro.org>
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

On Mon, Sep 04, 2023 at 06:12:29PM +0200, Philippe Mathieu-Daudé wrote:
> Fix:
> 
>   util/vhost-user-server.c: In function ‘set_watch’:
>   util/vhost-user-server.c:274:20: warning: declaration of ‘vu_fd_watch’ shadows a previous local [-Wshadow=compatible-local]
>     274 |         VuFdWatch *vu_fd_watch = g_new0(VuFdWatch, 1);
>         |                    ^~~~~~~~~~~
>   util/vhost-user-server.c:271:16: note: shadowed declaration is here
>     271 |     VuFdWatch *vu_fd_watch = find_vu_fd_watch(server, fd);
>         |                ^~~~~~~~~~~
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge.

> ---
>  util/vhost-user-server.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/util/vhost-user-server.c b/util/vhost-user-server.c
> index cd17fb5326..5073f775ed 100644
> --- a/util/vhost-user-server.c
> +++ b/util/vhost-user-server.c
> @@ -271,7 +271,7 @@ set_watch(VuDev *vu_dev, int fd, int vu_evt,
>      VuFdWatch *vu_fd_watch = find_vu_fd_watch(server, fd);
>  
>      if (!vu_fd_watch) {
> -        VuFdWatch *vu_fd_watch = g_new0(VuFdWatch, 1);
> +        vu_fd_watch = g_new0(VuFdWatch, 1);
>  
>          QTAILQ_INSERT_TAIL(&server->vu_fd_watches, vu_fd_watch, next);
>  
> -- 
> 2.41.0
> 
> 


