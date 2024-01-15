Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AEA8A82D445
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 07:45:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPGi7-0006np-EL; Mon, 15 Jan 2024 01:44:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGi5-0006nf-Kd
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:44:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPGi4-00087o-0G
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 01:44:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705301075;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsKXQlPhW/YL8kt2ioRLmX2RFNOAuFYMTJjZ+w4TqYk=;
 b=U2WJQ/24eBtI5WknLGEADxIfAbyjTDADEBQ17iW/EUI9k4QbQpQXIJuBlCOoAC7fW2N1ZL
 laFUh7msUA3pf7LKcGuiztFe5ICMdtpXjk+M1QCNDLeS8+p7roeUVq9rRUuSoMBe59iHHI
 jxzU4Cv8jjrW/w208aTewj/jxsFBsDI=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-qaV_yTOwOY6GzS_u64iEtg-1; Mon, 15 Jan 2024 01:44:33 -0500
X-MC-Unique: qaV_yTOwOY6GzS_u64iEtg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6d724647a7fso1420811b3a.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 22:44:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705301072; x=1705905872;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MsKXQlPhW/YL8kt2ioRLmX2RFNOAuFYMTJjZ+w4TqYk=;
 b=QzVE2xkPdWLQ9ALGKpvCN8mhy71z7aNiPCPL0H2I7AyIroNTJlFVLzxUmpXEyLzsev
 k3PV6X8beehrKzj+/AnMj9igoJESISB7b9rH70m6fGaK8LdsrIMYy4IYsiuT+5kxQEN5
 KqgLN3oB/e5euQDSTVZTo8vHoNfh/A0Ryq4LHdFS5KJPPA4fbSaZKdRbQBwgnV07eLi1
 yI7vYYSpT1NeQvifn6uofqjuxRmR/hgtuiS3YC31LF3m8NQ7V3KHIPCjJMs2mtIXBQqH
 Tv5YutOBEdkjRJmj+nwJxMthkw488vJmk/iH61WUwz+0mbV0QqSmFA34LhgHUyOz5MyQ
 utiA==
X-Gm-Message-State: AOJu0YyeSfksKrwGddTsGQHR4t/xheg+QAuJ4FPjOxN+0BcwiFR0bMoF
 N5XMsmZLMAzcQbdKM5DdoBJ/kmjtwZhQvNLMr3y4cDQWelH5KhQjwYFS2i/LXlKEr8Kqy54sCEY
 ZjWOm14Jyd5wWhOJ0RiXrhzM=
X-Received: by 2002:aa7:9dc6:0:b0:6d9:383b:d91a with SMTP id
 g6-20020aa79dc6000000b006d9383bd91amr12209856pfq.1.1705301072450; 
 Sun, 14 Jan 2024 22:44:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkzZEHn+sXcndpqDaGtj53Aico0+vGl5yQwhU3Lc8VPAGsHv9jkPSkGvSBnvZxBj3aZIDtCg==
X-Received: by 2002:aa7:9dc6:0:b0:6d9:383b:d91a with SMTP id
 g6-20020aa79dc6000000b006d9383bd91amr12209837pfq.1.1705301072115; 
 Sun, 14 Jan 2024 22:44:32 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 j10-20020aa78d0a000000b006d9ee2d286esm7187438pfe.18.2024.01.14.22.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 22:44:31 -0800 (PST)
Date: Mon, 15 Jan 2024 14:44:20 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 03/11] migration: convert to NotifierWithReturn
Message-ID: <ZaTURPKv4_tZtIBH@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-4-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1705071910-174321-4-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -48
X-Spam_score: -4.9
X-Spam_bar: ----
X-Spam_report: (-4.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Jan 12, 2024 at 07:05:02AM -0800, Steve Sistare wrote:
> Change all migration notifiers to type NotifierWithReturn, so notifiers
> can return an error status in a future patch.  For now, pass NULL for the
> notifier error parameter, and do not check the return value.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  hw/net/virtio-net.c            |  4 +++-
>  hw/vfio/migration.c            |  4 +++-
>  include/hw/vfio/vfio-common.h  |  2 +-
>  include/hw/virtio/virtio-net.h |  2 +-
>  include/migration/misc.h       |  6 +++---
>  migration/migration.c          | 16 ++++++++--------
>  net/vhost-vdpa.c               |  6 ++++--
>  ui/spice-core.c                |  8 +++++---
>  8 files changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 7a2846f..9570353 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -3529,11 +3529,13 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
>      }
>  }
>  
> -static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
> +static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
> +                                               void *data, Error **errp)
>  {
>      MigrationState *s = data;
>      VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
>      virtio_net_handle_migration_primary(n, s);
> +    return 0;
>  }

I should have mentioned this earlier.. we have a trend recently to modify
retval to boolean when Error** existed, e.g.:

https://lore.kernel.org/all/20231017202633.296756-5-peterx@redhat.com/

Let's start using boolean too here?  Previous patches may need touch-ups
too for this.

Other than that it all looks good here.  Thanks,

-- 
Peter Xu


