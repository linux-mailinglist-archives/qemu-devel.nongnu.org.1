Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EB98082C6D5
	for <lists+qemu-devel@lfdr.de>; Fri, 12 Jan 2024 22:40:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rOPEw-0004C4-Mp; Fri, 12 Jan 2024 16:38:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rOPEk-00040c-5W
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1rOPEg-0001gL-0k
 for qemu-devel@nongnu.org; Fri, 12 Jan 2024 16:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705095518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ShPJwf4O2RVGKo2HkK7H2wYjysaGHZN9xk6jxLkHa+Q=;
 b=Y1BeYW5Qjc1fndZn6W4dFkh1GrwPe7zaZkmnWUw5rz4mrxEppsf4D2LWPDKaCH9pqfL+nJ
 +1UhbcMd4boJ5lU1sOq2C7TAGjTEOCTai809vitalBY8J6ZzVd0eISFv6s48giAsJ6b10+
 4izdoZ42PSt5b82OlNfJQ/Ws9KwhxRM=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-CBDG2UvnP7eXA_iojFftDg-1; Fri, 12 Jan 2024 16:38:35 -0500
X-MC-Unique: CBDG2UvnP7eXA_iojFftDg-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3608dc76b97so66877225ab.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jan 2024 13:38:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705095512; x=1705700312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ShPJwf4O2RVGKo2HkK7H2wYjysaGHZN9xk6jxLkHa+Q=;
 b=FEaijVwQdImYW1t40a36M3IFkMQFXrkd5ENcTV9d5v+55+vWstjd15ZYs4S+ETqHtS
 Jb6AQ2OTZyDhBup4+HsGtzPbivbOrFCn63vOFKW78yyp64ZnyidFKQa+eJjbVfIP/cdS
 enQxQd3MtG3nvZZoA+H8OLdOsUBDp9WF/LasQ/kHMuTR9rjz+43jUzbwJuD8MOjdoyiR
 osMtlUakunMYZVQQyE5OCy5kJxRceiP1L3HSd4R1uW5MX9CEvlWuDCBidF1nobZ6FvRZ
 ezCwJvYHtke7PMF+Kg4Za/kjl3232FIJmVlcRSbW8fY1yq4EZQuUvChDHoPKvF+Bro2B
 VTow==
X-Gm-Message-State: AOJu0YwrvdmlVUCAWeFzpNaxcxrsj7VCb6mqT0kbaxH+LdXQSbaM00GG
 XMplb/q+PjflNMVltPtaZvajMdGMPrDdQ6CBu1LkbT2ayvloULHtTwqsX3Vd41ahSrPkXCBNlow
 gkFeJ9EG8vaMpP2Rem1bOcVg=
X-Received: by 2002:a05:6e02:10c8:b0:360:4f83:313f with SMTP id
 s8-20020a056e0210c800b003604f83313fmr1611776ilj.103.1705095512795; 
 Fri, 12 Jan 2024 13:38:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFmd/D9C8yf5SCvryXzRNxMECu4mS4h4pJ2GkKnzG9bmnBUNaKLEDYLTSZft3QFEk7LKdfJQ==
X-Received: by 2002:a05:6e02:10c8:b0:360:4f83:313f with SMTP id
 s8-20020a056e0210c800b003604f83313fmr1611761ilj.103.1705095512546; 
 Fri, 12 Jan 2024 13:38:32 -0800 (PST)
Received: from redhat.com ([38.15.60.12]) by smtp.gmail.com with ESMTPSA id
 bk8-20020a056e02328800b0035fda20a688sm1187129ilb.60.2024.01.12.13.38.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jan 2024 13:38:31 -0800 (PST)
Date: Fri, 12 Jan 2024 14:38:30 -0700
From: Alex Williamson <alex.williamson@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Fabiano Rosas
 <farosas@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang
 <jasowang@redhat.com>, Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann
 <kraxel@redhat.com>, Marc-Andre Lureau <marcandre.lureau@redhat.com>, David
 Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 00/11] allow cpr-reboot for vfio
Message-ID: <20240112143830.377d9f0f.alex.williamson@redhat.com>
In-Reply-To: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.09,
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

On Fri, 12 Jan 2024 07:04:59 -0800
Steve Sistare <steven.sistare@oracle.com> wrote:

> Allow cpr-reboot for vfio if the guest is in the suspended runstate.  The
> guest drivers' suspend methods flush outstanding requests and re-initialize
> the devices, and thus there is no device state to save and restore.  The
> user is responsible for suspending the guest before initiating cpr, such as
> by issuing guest-suspend-ram to the qemu guest agent.
> 
> Most of the patches in this series enhance migration notifiers so they can
> return an error status and message.  The last two patches register a notifier
> for vfio that returns an error if the guest is not suspended.

Hi Steve,

This appears to only support legacy container mode and not cdev/iommufd
mode.  Shouldn't this support both?  Thanks,

Alex

> Steve Sistare (11):
>   notify: pass error to notifier with return
>   migration: remove error from notifier data
>   migration: convert to NotifierWithReturn
>   migration: remove migration_in_postcopy parameter
>   migration: MigrationEvent for notifiers
>   migration: MigrationNotifyFunc
>   migration: per-mode notifiers
>   migration: refactor migrate_fd_connect failures
>   migration: notifier error checking
>   vfio: register container for cpr
>   vfio: allow cpr-reboot migration if suspended
> 
>  hw/net/virtio-net.c            |  14 ++---
>  hw/vfio/common.c               |   2 +-
>  hw/vfio/container.c            |  11 +++-
>  hw/vfio/cpr.c                  |  39 ++++++++++++++
>  hw/vfio/meson.build            |   1 +
>  hw/vfio/migration.c            |  13 +++--
>  hw/virtio/vhost-user.c         |  10 ++--
>  hw/virtio/virtio-balloon.c     |   3 +-
>  include/hw/vfio/vfio-common.h  |   6 ++-
>  include/hw/virtio/virtio-net.h |   2 +-
>  include/migration/misc.h       |  21 +++++---
>  include/qemu/notify.h          |   7 ++-
>  migration/migration.c          | 117 +++++++++++++++++++++++++++--------------
>  migration/postcopy-ram.c       |   3 +-
>  migration/postcopy-ram.h       |   1 -
>  migration/ram.c                |  12 ++---
>  net/vhost-vdpa.c               |  15 +++---
>  ui/spice-core.c                |  19 +++----
>  util/notify.c                  |   5 +-
>  19 files changed, 206 insertions(+), 95 deletions(-)
>  create mode 100644 hw/vfio/cpr.c
> 


