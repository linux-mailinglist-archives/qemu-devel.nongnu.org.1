Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 919F07DD0CB
	for <lists+qemu-devel@lfdr.de>; Tue, 31 Oct 2023 16:44:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxqv9-0001X8-2j; Tue, 31 Oct 2023 11:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxqv7-0001Wd-6H
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:44:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qxqv2-0004Yj-Ax
 for qemu-devel@nongnu.org; Tue, 31 Oct 2023 11:44:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698767078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFMxO+D0OQrOVPSmF6alxRjV7AdXmijM8SRnRVWICXI=;
 b=fxweM5WEFCBppOOEbdvOI8El3GIkw9Ww8B8TNNAWfnXAkaN6q7YG9ZqcTTFBMlDIZwS4qK
 wl3ov8uDMguWVmYEgeVYiKkgcXmxM/q5wTml6W5H2/FoAU466ONrxl7KvcgQ5JAFEOxRni
 /NiKhnbsA0xetueXLavQmx8HWU7jWNM=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-Q5VwRE91OzepvjCWCR8f9g-1; Tue, 31 Oct 2023 11:44:36 -0400
X-MC-Unique: Q5VwRE91OzepvjCWCR8f9g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-66d7b75c854so13482186d6.1
 for <qemu-devel@nongnu.org>; Tue, 31 Oct 2023 08:44:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698767076; x=1699371876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFMxO+D0OQrOVPSmF6alxRjV7AdXmijM8SRnRVWICXI=;
 b=WxH4f64j6xMRLnWr2pqRsMDD3KllygQmL2iEgJ5PEUA7dis8HHSg0+qlgqqWOVSxZ7
 UZjLe/xaNoLQLy+QWoPg+LdsteHPkQpux1GdCRg+BsneETcwskmP7wHT4ndTpq+JR0pK
 luhQF05WcUod3u8kFlstKAbPhDMF3yKyD2L/IBrKOSRu0st0biJEUMvOyUnTvLEsuM+r
 8ntvCsoPHeQ8ICaqoDJaWv5UZBWYtFcyxSjXCcsm6anTVTmvCVp0gbuQotZI98NXENlE
 ikArdoAA/8VAXVOM6hFHEZhUu3nXbn3JbNzYDnj8EzPZUbiCrj9KRm/jV33rg4DIro1h
 JMMg==
X-Gm-Message-State: AOJu0Yy6hADjKBVL9MrhBaOr79+7tdGNekTJU7LA/NuL2MSQdR9Lttvf
 1G+ITkJk+5bhi8LfV7h8+nvC7MAA4zK47ctVHuWGlwTqpWkbE6QtKppY1KcVqpneknnzojw+6el
 6pH1eTJM9x5ylOps=
X-Received: by 2002:ad4:4aea:0:b0:66d:169a:a661 with SMTP id
 cp10-20020ad44aea000000b0066d169aa661mr13109387qvb.4.1698767076349; 
 Tue, 31 Oct 2023 08:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsRG/iTqQ6ZORgVVLCOwjFGXNFXHjJFUXFaOMRO80d/6dHJIGrqKMNLm3I9pTUnJ7pLrI/MQ==
X-Received: by 2002:ad4:4aea:0:b0:66d:169a:a661 with SMTP id
 cp10-20020ad44aea000000b0066d169aa661mr13109368qvb.4.1698767076091; 
 Tue, 31 Oct 2023 08:44:36 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 ev10-20020a0562140a8a00b0066cfd398ab5sm618956qvb.146.2023.10.31.08.44.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Oct 2023 08:44:35 -0700 (PDT)
Date: Tue, 31 Oct 2023 11:44:33 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>
Subject: Re: [PATCH V2 4/6] cpr: relax vhost migration blockers
Message-ID: <ZUEg4e9JIQdW+b0D@x1n>
References: <1698263069-406971-1-git-send-email-steven.sistare@oracle.com>
 <1698263069-406971-5-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1698263069-406971-5-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.481,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Copy qemu-block, virtio

On Wed, Oct 25, 2023 at 12:44:27PM -0700, Steve Sistare wrote:
> vhost blocks migration if logging is not supported to track dirty
> memory, and vhost-user blocks it if the log cannot be saved to a shm fd.
> 
> vhost-vdpa blocks migration if both hosts do not support all the device's
> features using a shadow VQ, for tracking requests and dirty memory.
> 
> vhost-scsi blocks migration if storage cannot be shared across hosts,
> or if state cannot be migrated.
> 
> None of these conditions apply if the old and new qemu processes do
> not run concurrently, and if new qemu starts on the same host as old,
> which is the case for cpr.
> 
> Narrow the scope of these blockers so they only apply to normal mode.
> They will not block cpr modes when they are added in subsequent patches.
> 
> No functional change until a new mode is added.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> Reviewed-by: Juan Quintela <quintela@redhat.com>
> ---
>  hw/scsi/vhost-scsi.c | 2 +-
>  hw/virtio/vhost.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/scsi/vhost-scsi.c b/hw/scsi/vhost-scsi.c
> index 14e23cc..bf528d5 100644
> --- a/hw/scsi/vhost-scsi.c
> +++ b/hw/scsi/vhost-scsi.c
> @@ -208,7 +208,7 @@ static void vhost_scsi_realize(DeviceState *dev, Error **errp)
>                  "When external environment supports it (Orchestrator migrates "
>                  "target SCSI device state or use shared storage over network), "
>                  "set 'migratable' property to true to enable migration.");
> -        if (migrate_add_blocker(&vsc->migration_blocker, errp) < 0) {
> +        if (migrate_add_blocker_normal(&vsc->migration_blocker, errp) < 0) {
>              goto free_virtio;
>          }
>      }
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index d737671..f5e9625 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -1527,7 +1527,7 @@ int vhost_dev_init(struct vhost_dev *hdev, void *opaque,
>      }
>  
>      if (hdev->migration_blocker != NULL) {
> -        r = migrate_add_blocker(&hdev->migration_blocker, errp);
> +        r = migrate_add_blocker_normal(&hdev->migration_blocker, errp);
>          if (r < 0) {
>              goto fail_busyloop;
>          }
> -- 
> 1.8.3.1
> 

-- 
Peter Xu


