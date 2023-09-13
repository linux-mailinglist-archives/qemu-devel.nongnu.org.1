Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C660679F5B4
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 01:50:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgZaq-0003wt-LT; Wed, 13 Sep 2023 19:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgZap-0003wi-5p
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 19:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qgZan-00082e-H8
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 19:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694648900;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1AYyX9WTtHPOrKduKPjBG8D2slAPQJ9b9mLB1jebxpc=;
 b=Ywqjy00lYUWzKIskl0yKzj/YbUKRiQo3y/HNL1E4VDJAL02lF2TdznIrXuBF89IIm/8vls
 K4bPY4pUS+yKZ2GYOINGi37J0vdECdy5/Px5Z+/fTltgxY1YBrtg2htjNInShPxkkpNPj/
 pBU+ZJGeH7NmakkEgBHlZo7IoZbkzE4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-ozu9MYLkPbaoKonmkLUgnQ-1; Wed, 13 Sep 2023 19:48:18 -0400
X-MC-Unique: ozu9MYLkPbaoKonmkLUgnQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-411f4a7ddbdso752271cf.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 16:48:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694648898; x=1695253698;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AYyX9WTtHPOrKduKPjBG8D2slAPQJ9b9mLB1jebxpc=;
 b=gg2C5NUPVg9yfkHUzsxoilYjYNlMdJvIrUJWFC7iQ1b/qeCo2giLzm0mN78kofESWS
 2FVflOsECdzXtbWg3/5JYFm4TUbt5p99Cs1G4pPM9VJfN2d3BZ/9zbWRUK3NXg7VNjEH
 GekIQ/YoKq9YvZPUus3HgrPv7vPpLw02SDPdT8l/91XxAoyZO2v0Edw570ZztB87AZkH
 KqfzQEARbdwzcpQbvz2VjVEohytnQVyTFtgTqQhhBXyfousClSrqzmS/Kd1qcxWWXeWO
 ss7KnUvVkVIeROSnOxKvBF6vguS+BsjDVTIfja2JMmgPxImjHC5kjXmQ0P67nsXbmnSN
 I6vA==
X-Gm-Message-State: AOJu0YxbiiecjkoG+REV5VsptsUlcyfOWQG/5qCcK2OIymNOyr67vVYc
 0a5c2Edpofvi1f7fW+5LttrZ1BKOevBoTX9l52JEePDFwz1d3929TXOBewpmVs6E7dY6aOZgCKx
 kzVwxh73hp/h0ocE=
X-Received: by 2002:a05:622a:134a:b0:410:839d:942f with SMTP id
 w10-20020a05622a134a00b00410839d942fmr4346010qtk.6.1694648898191; 
 Wed, 13 Sep 2023 16:48:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHj999EnxCWMS/Q0zS5uSfdrFLiOS6JeDQCHvEIjXoSKnVtCPhaTDbXKWjL73pvjBs/XveFAw==
X-Received: by 2002:a05:622a:134a:b0:410:839d:942f with SMTP id
 w10-20020a05622a134a00b00410839d942fmr4345998qtk.6.1694648897860; 
 Wed, 13 Sep 2023 16:48:17 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 fu32-20020a05622a5da000b00407906a4c6fsm106734qtb.71.2023.09.13.16.48.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 16:48:17 -0700 (PDT)
Date: Wed, 13 Sep 2023 19:48:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v6 09/10] migration/yank: Keep track of registered yank
 instances
Message-ID: <ZQJKQLNNZe772MUA@x1n>
References: <20230911171320.24372-1-farosas@suse.de>
 <20230911171320.24372-10-farosas@suse.de> <ZQIX+KUgL5V6H/gj@x1n>
 <87jzstkaen.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87jzstkaen.fsf@suse.de>
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

On Wed, Sep 13, 2023 at 06:53:20PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Sep 11, 2023 at 02:13:19PM -0300, Fabiano Rosas wrote:
> >> The core yank code is strict about balanced registering and
> >> unregistering of yank functions.
> >> 
> >> This creates a difficulty because the migration code registers one
> >> yank function per QIOChannel, but each QIOChannel can be referenced by
> >> more than one QEMUFile. The yank function should not be removed until
> >> all QEMUFiles have been closed.
> >> 
> >> Keep a reference count of how many QEMUFiles are using a QIOChannel
> >> that has a yank function. Only unregister the yank function when all
> >> QEMUFiles have been closed.
> >> 
> >> This improves the current code by removing the need for the programmer
> >> to know which QEMUFile is the last one to be cleaned up and fixes the
> >> theoretical issue of removing the yank function while another QEMUFile
> >> could still be using the ioc and require a yank.
> >> 
> >> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> >> ---
> >>  migration/yank_functions.c | 81 ++++++++++++++++++++++++++++++++++----
> >>  migration/yank_functions.h |  8 ++++
> >>  2 files changed, 81 insertions(+), 8 deletions(-)
> >
> > I worry this over-complicate things.
> 
> It does. We ran out of simple options.
> 
> > If you prefer the cleaness that we operate always on qemufile level, can we
> > just register each yank function per-qemufile?
> 
> "just" hehe
> 
> we could, but:
> 
> i) the yank is a per-channel operation, so this is even more unintuitive;

I mean we can provide something like:

void migration_yank_qemufile(void *opaque)
{
    QEMUFile *file = opaque;
    QIOChannel *ioc = file->ioc;

    qio_channel_shutdown(ioc, QIO_CHANNEL_SHUTDOWN_BOTH, NULL);
}

void migration_qemufile_register_yank(QEMUFile *file)
{
    if (migration_ioc_yank_supported(file->ioc)) {
        yank_register_function(MIGRATION_YANK_INSTANCE,
                               migration_yank_qemufile,
                               file);
    }
}

> 
> ii) multifd doesn't have a QEMUFile, so it will have to continue using
>     the ioc;

We can keep using migration_ioc_[un]register_yank() for them if there's no
qemufile attached.  As long as the function will all be registered under
MIGRATION_YANK_INSTANCE we should be fine having different yank func.

> 
> iii) we'll have to add a yank to every new QEMUFile created during the
>      incoming migration (colo, rdma, etc), otherwise the incoming side
>      will be left using iocs while the src uses the QEMUFile;

For RDMA, IIUC it'll simply be a noop as migration_ioc_yank_supported()
will be a noop for it for either reg/unreg.

Currently it seems we will also unreg the ioc even for RDMA (even though we
don't reg for it).  But since unreg will be a noop it seems all fine even
if not paired.. maybe we should still try to pair it, e.g. register also in
rdma_start_outgoing_migration() for the rdma ioc so at least they're paired.

I don't see why COLO is special here, though.  Maybe I missed something.

> 
> iv) this is a functional change of the yank feature for which we have no
>     tests.

Having yank tested should be preferrable.  Lukas is in the loop, let's see
whether he has something. We can still smoke test it before a selftest
being there.

Taking one step back.. I doubt whether anyone is using yank for migration?
Knowing that migration already have migrate-cancel (for precopy) and
migrate-pause (for postcopy).  I never used it myself, and I don't think
it's supported for RHEL.  How's that in suse's case?

If no one is using it, maybe we can even avoid registering migration to
yank?

> 
> If that's all ok to you I'll go ahead and git it a try.
> 
> > I think qmp yank will simply fail the 2nd call on the qemufile if the
> > iochannel is shared with the other one, but that's totally fine, IMHO.
> >
> > What do you think?
> >
> > In all cases, we should probably at least merge patch 1-8 if that can
> > resolve the CI issue.  I think all of them are properly reviewed.
> 
> I agree. Someone needs to queue this though since Juan has been busy.

Yes, I'll see what I can do.

-- 
Peter Xu


