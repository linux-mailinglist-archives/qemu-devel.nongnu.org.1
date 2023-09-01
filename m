Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6E0790028
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 17:51:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc6QV-0000dn-Vi; Fri, 01 Sep 2023 11:51:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6QT-0000UC-QA
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:51:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qc6QR-0007Jl-LH
 for qemu-devel@nongnu.org; Fri, 01 Sep 2023 11:51:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693583470;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fi7XjShym3umATXjA2XiTFzPNCTzPN2OfnOZ8h/Aqgo=;
 b=R+dMvbbVdve+IT5iclr2abNZUQMbXjryT2M0wNDkv8uCOfmC6gCVn8/i94z1RB5GZsynYR
 qTAQJu+gLrrw/KJMD1utzMAMMyyZo+oOS5diKIiZ1C0iHJMyAV3N/SgoENQGBUUo53JVcF
 ogKngGE357wRMdiKDqMleThlK4rjyeQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-ok7hJTtoMgyH1I2P9NwuWw-1; Fri, 01 Sep 2023 11:51:09 -0400
X-MC-Unique: ok7hJTtoMgyH1I2P9NwuWw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-63c9463c116so4299156d6.0
 for <qemu-devel@nongnu.org>; Fri, 01 Sep 2023 08:51:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693583468; x=1694188268;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fi7XjShym3umATXjA2XiTFzPNCTzPN2OfnOZ8h/Aqgo=;
 b=bpx8+i+Jz9HWq582s12V8Jlu212/pTmQiZzFrLqKbDFFrauZzkHLhD4m10JcGPyBHK
 wg+m5+IHspXtEXw50WJYTQeQSq1pmlWVfApUZKq6jDUjWy1Qt7emS8HUZdoYDSVLUU/9
 D2/pEQoLZDVgYh+qFa/YtG9DBuVt72eue9mfnUDHe+uKzb/AdWMeGem4EJNGVekIzOCx
 7C60qIS6BXMSQ0qDbHrYQ6mR8SjKjSAmwh/CHXS9GgQ0vF7tYyYVy5ABSQ91FU0HTJgI
 rwWAy9F/6H3kfZ4vJJxGws+aABb9TxhmBKZ+cqketg8cFjrWan3ioWFyOmsMvvi/8vjp
 gJRg==
X-Gm-Message-State: AOJu0YxIAUTpKyWppb2jEK41cxyYasUjNzkEu2iOYPjNkwHrjus7RdHg
 fPT1nyvOuMGy4zh93taOtyc2Qs8hJM+j3F3fYuxjBbCpsfY+ZXCWjg3oZ+jvz0S600Y7Dd7Xh92
 EJDo0t4siIbraA6o=
X-Received: by 2002:a05:620a:45a8:b0:76f:167a:cc5d with SMTP id
 bp40-20020a05620a45a800b0076f167acc5dmr3010916qkb.7.1693583468575; 
 Fri, 01 Sep 2023 08:51:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvcJQTbZ4LdmrjLCNDXm7HzpStzWMcU1ZJ5lT2XrzvJLAvt4vZ1ugllecbFsfQr3hfbelxDQ==
X-Received: by 2002:a05:620a:45a8:b0:76f:167a:cc5d with SMTP id
 bp40-20020a05620a45a800b0076f167acc5dmr3010893qkb.7.1693583468267; 
 Fri, 01 Sep 2023 08:51:08 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 z7-20020ae9c107000000b0076eedc31b5esm1465984qki.128.2023.09.01.08.51.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 08:51:08 -0700 (PDT)
Date: Fri, 1 Sep 2023 11:51:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Juan Quintela <quintela@redhat.com>, Leonardo Bras <leobras@redhat.com>,
 Yanghang Liu <yanghliu@redhat.com>
Subject: Re: [PATCH v2 4/5] vfio/migration: Block VFIO migration with
 postcopy migration
Message-ID: <ZPIIZT6RywNN4M/9@x1n>
References: <20230831125702.11263-1-avihaih@nvidia.com>
 <20230831125702.11263-5-avihaih@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831125702.11263-5-avihaih@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 31, 2023 at 03:57:01PM +0300, Avihai Horon wrote:
> VFIO migration is not compatible with postcopy migration. A VFIO device
> in the destination can't handle page faults for pages that have not been
> sent yet.
> 
> Doing such migration will cause the VM to crash in the destination:
> 
> qemu-system-x86_64: VFIO_MAP_DMA failed: Bad address
> qemu-system-x86_64: vfio_dma_map(0x55a28c7659d0, 0xc0000, 0xb000, 0x7f1b11a00000) = -14 (Bad address)
> qemu: hardware error: vfio: DMA mapping failed, unable to continue
> 
> To prevent this, block VFIO migration with postcopy migration.
> 
> Reported-by: Yanghang Liu <yanghliu@redhat.com>
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>  hw/vfio/migration.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
> 
> diff --git a/hw/vfio/migration.c b/hw/vfio/migration.c
> index 71855468fe..20994dc1d6 100644
> --- a/hw/vfio/migration.c
> +++ b/hw/vfio/migration.c
> @@ -335,6 +335,27 @@ static bool vfio_precopy_supported(VFIODevice *vbasedev)
>  
>  /* ---------------------------------------------------------------------- */
>  
> +static int vfio_save_prepare(void *opaque, Error **errp)
> +{
> +    VFIODevice *vbasedev = opaque;
> +
> +    /*
> +     * Snapshot doesn't use postcopy, so allow snapshot even if postcopy is on.
> +     */
> +    if (runstate_check(RUN_STATE_SAVE_VM)) {
> +        return 0;
> +    }

Just purely curious: will it really work to save a snapshot for the GPU
assigned use case?

> +
> +    if (migrate_postcopy_ram()) {
> +        error_setg(
> +            errp, "%s: VFIO migration is not supported with postcopy migration",
> +            vbasedev->name);
> +        return -EOPNOTSUPP;
> +    }
> +
> +    return 0;
> +}

-- 
Peter Xu


