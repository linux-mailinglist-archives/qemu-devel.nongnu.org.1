Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9511182FED3
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 03:31:00 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPvga-000409-UV; Tue, 16 Jan 2024 21:29:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPvgY-0003yT-1w
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 21:29:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPvgW-0000Xe-A6
 for qemu-devel@nongnu.org; Tue, 16 Jan 2024 21:29:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705458583;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bZA7Og1ukVCTLBAVrdv/nRxMRRAD6YaeC16AeZ/jLYQ=;
 b=SeuFpwv+CAvKWz0i6eiHpdfOB/aKziQ3liPhdjizyVx2Ys9PDsA7kY0YhzHedbE4/++g9j
 KVjYhsG3j4H8FB/3IiGBgZl+XnxbwBWQmTv6zc4Ye2+1RuOlBV7dm0danbWD9gBdWF3rrn
 xm/GCGCtBlGppbTPRHgYFm1qjavfrZA=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-SSkslTgUMuOw4vJ0-tl-4Q-1; Tue, 16 Jan 2024 21:29:40 -0500
X-MC-Unique: SSkslTgUMuOw4vJ0-tl-4Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-28cb02a6027so1839294a91.0
 for <qemu-devel@nongnu.org>; Tue, 16 Jan 2024 18:29:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705458579; x=1706063379;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bZA7Og1ukVCTLBAVrdv/nRxMRRAD6YaeC16AeZ/jLYQ=;
 b=b9yv0zDiGmMiltapqweDgJ0poFAXCT/JnbLhgG9AxXwe3PymZM3IDEqPsOls5/9YeY
 ztvwHzu6D6l4gucCWR+5h2noBFFnNem821LMmSgA+JpvsiXveAfeVTGDL4+eOBfY145w
 /641bEHjzSdmLi1ZZ8Fhnp3Wmh1uDSWHJPYU2L3lSQ+9CqR0GyimbPRC/vM8d3U2EBt6
 7p53NYVutaJGY7Ro3cfnfsR+wpV6viZ73lA2YMBSdZD3t+VmSPai6W5c3eFbeU5fPZxy
 uLg8RboV6xeC+TseTBbxTFJJurBvXsVoumWbmklrmiVOPRj9Zyh8p+aVoR/2qnVg/LXV
 /6sQ==
X-Gm-Message-State: AOJu0YxfUScqQmzdEtl8akUTOQN8qXZmqAxbLhIoSVzptaitNZ9lyxbJ
 0Nwpj7vlf2mUo5o5+JrkeCeyE1Z7aK5DYUZc4jc+wi05SF1W2c7QlRsZA+nnV7xNslb7f8c+Iol
 ZRFq7L/2Iso9DxNJ+EbaCIus=
X-Received: by 2002:a05:6a20:43a3:b0:19b:20e7:d6b2 with SMTP id
 i35-20020a056a2043a300b0019b20e7d6b2mr6259512pzl.3.1705458579661; 
 Tue, 16 Jan 2024 18:29:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxxIFea0khiDZ2bmSgOGJWCgwmaU8gGFQHVQJJhRa6A32EovEdLz7uv4+KkE8jYZ+Qy0Vjzw==
X-Received: by 2002:a05:6a20:43a3:b0:19b:20e7:d6b2 with SMTP id
 i35-20020a056a2043a300b0019b20e7d6b2mr6259502pzl.3.1705458579344; 
 Tue, 16 Jan 2024 18:29:39 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 px8-20020a17090b270800b0028dc4b598b7sm14380872pjb.55.2024.01.16.18.29.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 16 Jan 2024 18:29:38 -0800 (PST)
Date: Wed, 17 Jan 2024 10:29:31 +0800
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V2 03/11] migration: convert to NotifierWithReturn
Message-ID: <Zac7i3GscXHjO-Qa@x1n>
References: <1705071910-174321-1-git-send-email-steven.sistare@oracle.com>
 <1705071910-174321-4-git-send-email-steven.sistare@oracle.com>
 <ZaTURPKv4_tZtIBH@x1n>
 <d12792a3-1d34-4819-9f95-5cbddbacf1a0@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d12792a3-1d34-4819-9f95-5cbddbacf1a0@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.806,
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

On Tue, Jan 16, 2024 at 03:35:53PM -0500, Steven Sistare wrote:
> On 1/15/2024 1:44 AM, Peter Xu wrote:
> > On Fri, Jan 12, 2024 at 07:05:02AM -0800, Steve Sistare wrote:
> >> Change all migration notifiers to type NotifierWithReturn, so notifiers
> >> can return an error status in a future patch.  For now, pass NULL for the
> >> notifier error parameter, and do not check the return value.
> >>
> >> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> >> ---
> >>  hw/net/virtio-net.c            |  4 +++-
> >>  hw/vfio/migration.c            |  4 +++-
> >>  include/hw/vfio/vfio-common.h  |  2 +-
> >>  include/hw/virtio/virtio-net.h |  2 +-
> >>  include/migration/misc.h       |  6 +++---
> >>  migration/migration.c          | 16 ++++++++--------
> >>  net/vhost-vdpa.c               |  6 ++++--
> >>  ui/spice-core.c                |  8 +++++---
> >>  8 files changed, 28 insertions(+), 20 deletions(-)
> >>
> >> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> >> index 7a2846f..9570353 100644
> >> --- a/hw/net/virtio-net.c
> >> +++ b/hw/net/virtio-net.c
> >> @@ -3529,11 +3529,13 @@ static void virtio_net_handle_migration_primary(VirtIONet *n, MigrationState *s)
> >>      }
> >>  }
> >>  
> >> -static void virtio_net_migration_state_notifier(Notifier *notifier, void *data)
> >> +static int virtio_net_migration_state_notifier(NotifierWithReturn *notifier,
> >> +                                               void *data, Error **errp)
> >>  {
> >>      MigrationState *s = data;
> >>      VirtIONet *n = container_of(notifier, VirtIONet, migration_state);
> >>      virtio_net_handle_migration_primary(n, s);
> >> +    return 0;
> >>  }
> > 
> > I should have mentioned this earlier.. we have a trend recently to modify
> > retval to boolean when Error** existed, e.g.:
> > 
> > https://lore.kernel.org/all/20231017202633.296756-5-peterx@redhat.com/
> > 
> > Let's start using boolean too here?  Previous patches may need touch-ups
> > too for this.
> > 
> > Other than that it all looks good here.  Thanks,
> 
> Boolean makes sense when there is only one way to recover from failure.
> However, when the notifier may fail in different ways, and recovery differs
> for each, then the function should return an int errno.  NotifierWithReturn
> could have future uses that need multiple return values and multiple recovery 
> paths above the notifier_with_return_list_notify level, so IMO the function 
> should continue to return int for generality.

Ah ok.  Please then add a comment either in the commit message or code for
that.  Thanks.

-- 
Peter Xu


