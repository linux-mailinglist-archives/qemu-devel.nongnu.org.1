Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1866D7BB483
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 11:49:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qohS0-0005U2-Mh; Fri, 06 Oct 2023 05:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qohRy-0005TB-W9
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:48:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qohRx-0003gX-9l
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 05:48:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696585728;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bfq5X+uSPUpXcBQbxsLnWiayYYPFAUGSIf5+oRb7IIA=;
 b=Mv681+e9pV3xcsB0Z9Yrge/0oKPZJ4PaqMaItBkVd+sqTozcIZORL6zg4OeQOq3W9nSDnr
 L0NQkdxqCn8kbuKApKuZUEtNAlcfsfrKtdZ9MB+J+4tlaliSi8rRFCynu9zCxlhKRS5TpL
 1jDvmdUgxYTBphW7NWlyhQAIJBZcv7U=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-IB2mZe3XNfaRfLXNxb2VAw-1; Fri, 06 Oct 2023 05:48:37 -0400
X-MC-Unique: IB2mZe3XNfaRfLXNxb2VAw-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-32323283257so1456738f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Oct 2023 02:48:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696585716; x=1697190516;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bfq5X+uSPUpXcBQbxsLnWiayYYPFAUGSIf5+oRb7IIA=;
 b=TldTNBJQFSkSflyNUQ5ZaEMD0ZLliTdT91QMKOiasjCclBSmZ25FlH86BfD+xRCzAm
 Joj9qewhSWnDIAsFX+6hxqs8UMtA+ckqDIKCjTwzP29zFmfRExEFpQeL1pAwMOjD97rX
 xVO/ipKes5KmYbeN4JSJSFazKKHsvWZHQD3py5V6Aps83LhAr6g1xQ/zElkND7oDIk2l
 phf9E9qa+mwrJ9+KjEdSkayLrhpbyWYsJKTOG7LHCTAFkRjms9XZehUnmPizc43KieFZ
 +fxc64KoKGftDKKlElxXqGAk0EnabvmncWUd/swJYHTkIe4y8FltQi8MIUvs8QRn8UUt
 8aig==
X-Gm-Message-State: AOJu0YwBhaxpGJcsWCkWQLQP7oReaqzfBhwX5lgE3Q+tiVULe5+EvAf1
 KKNAUHPaD7qhrJK586xDADeB3htVLzQodKG8Y+hF6ULYNJ69B2lk8TyloD3kgki2DhMor9GWV4K
 nqWAZdLl0aflCB+4=
X-Received: by 2002:a5d:5103:0:b0:319:79bb:980c with SMTP id
 s3-20020a5d5103000000b0031979bb980cmr6902602wrt.64.1696585716085; 
 Fri, 06 Oct 2023 02:48:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGt9PVYwPqGFSlPDa161M4rGozfYrRXKLZ8z2ZLwEvottcm13bpTOImg+6MkdoFIpgmurR8w==
X-Received: by 2002:a5d:5103:0:b0:319:79bb:980c with SMTP id
 s3-20020a5d5103000000b0031979bb980cmr6902591wrt.64.1696585715661; 
 Fri, 06 Oct 2023 02:48:35 -0700 (PDT)
Received: from redhat.com ([2a02:14f:170:ca0a:84b4:d350:99ea:3666])
 by smtp.gmail.com with ESMTPSA id
 k21-20020adfb355000000b003296b913bbesm690399wrd.12.2023.10.06.02.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Oct 2023 02:48:34 -0700 (PDT)
Date: Fri, 6 Oct 2023 05:48:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>,
 Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH] vhost: Perform memory section dirty scans once per
 iteration
Message-ID: <20231006054342-mutt-send-email-mst@kernel.org>
References: <20230927111428.15982-1-joao.m.martins@oracle.com>
 <20231003095019-mutt-send-email-mst@kernel.org>
 <6e40003d-d2a6-4120-aa78-de26de088d86@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e40003d-d2a6-4120-aa78-de26de088d86@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Oct 06, 2023 at 09:58:30AM +0100, Joao Martins wrote:
> On 03/10/2023 15:01, Michael S. Tsirkin wrote:
> > On Wed, Sep 27, 2023 at 12:14:28PM +0100, Joao Martins wrote:
> >> On setups with one or more virtio-net devices with vhost on,
> >> dirty tracking iteration increases cost the bigger the number
> >> amount of queues are set up e.g. on idle guests migration the
> >> following is observed with virtio-net with vhost=on:
> >>
> >> 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> >> 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> >> 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> >> 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
> >>
> >> With high memory rates the symptom is lack of convergence as soon
> >> as it has a vhost device with a sufficiently high number of queues,
> >> the sufficient number of vhost devices.
> >>
> >> On every migration iteration (every 100msecs) it will redundantly
> >> query the *shared log* the number of queues configured with vhost
> >> that exist in the guest. For the virtqueue data, this is necessary,
> >> but not for the memory sections which are the same. So
> >> essentially we end up scanning the dirty log too often.
> >>
> >> To fix that, select a vhost device responsible for scanning the
> >> log with regards to memory sections dirty tracking. It is selected
> >> when we enable the logger (during migration) and cleared when we
> >> disable the logger.
> >>
> >> The real problem, however, is exactly that: a device per vhost worker/qp,
> >> when there should be a device representing a netdev (for N vhost workers).
> >> Given this problem exists for any Qemu these days, figured a simpler
> >> solution is better to increase stable tree's coverage; thus don't
> >> change the device model of sw vhost to fix this "over log scan" issue.
> >>
> >> Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> >> ---
> >> I am not fully sure the heuristic captures the myriad of different vhost
> >> devices -- I think so. IIUC, the log is always shared, it's just whether
> >> it's qemu head memory or via /dev/shm when other processes want to
> >> access it.
> > 
> > Thanks for working on this.
> > 
> > I don't think this works like this because different types of different
> > vhost devices have different regions - see e.g. vhost_region_add_section
> > I am also not sure all devices are running at the same time - e.g.
> > some could be disconnected, and vhost_sync_dirty_bitmap takes this
> > into account.
> > 
> 
> Good point. But this all means logic in selecting the 'logger' to take into
> considering whether vhost_dev::log_enabled or vhost_dev::started right?
> 
> With respect to regions it seems like this can only change depending on whether
> one of the vhost devices, backend_type is VHOST_BACKEND_TYPE_USER *and* whether
> the backend sets vhost_backend_can_merge?
> 
> With respect to 'could be disconnected' during migration not devices can be
> added or removed during migration, so might not be something that occurs during
> migration.
> I placed this in log_sync exactly to just cover migration, unless
> there's some other way that disconnects the vhost and changes these variables
> during migration.

The *frontend* can't be added or removed (ATM - this is just because we lack
good ways to describe devices that can be migrated, so all we
came up with is passing same command line on both sides,
and this breaks if you add/remove things in the process).
We really shouldn't bake this assumption into code if we can
help it though.

But I digress.

The *backend* can disconnect at any time as this is not guest visible.

> 
> > But the idea is I think a good one - I just feel more refactoring is
> > needed.
> 
> Can you expand on what refactoring you were thinking for this fix?

Better separate the idea of logging from device. then we can
have a single logger that collects data from devices to decide
what needs to be logged.

> My thinking on this bug was mostly to address the inneficiency with the smallest
> intrusive fix (if at all possible!) given that virtually all multiqueue vhost
> supported QEMU have this problem. And then move into a 'vhost-device for all
> queues' as it feels like the problem here is the 'device per queue pair' doesn't
> scale.
> 
> At the end of the day the problem on this is the vhost object model in log_sync
> not scaling to amount of queues. But you could also argue that if the log is
> shared that you can just log once for all, plus another one for each deviation
> of normal behaviour, like the points you made in the earlier paragraph, and thus
> the thinking behind this patch would still apply?

The thinking is good, but not the implementation.

-- 
MST


