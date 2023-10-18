Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EAFD7CD3B6
	for <lists+qemu-devel@lfdr.de>; Wed, 18 Oct 2023 07:56:37 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qszXP-0005IQ-Gi; Wed, 18 Oct 2023 01:56:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qszXJ-0005Ga-OH
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qszXH-0003KQ-UW
 for qemu-devel@nongnu.org; Wed, 18 Oct 2023 01:56:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697608559;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=soquRUSeJwubM3VRgkN8E/H24tKTEkIYCIq/CNEvxBM=;
 b=H4h5H/i3TkvkG7GceZzQ/+kjP+KlcEnkTx4XJlKQm0/Hfn9e6DzPu954G40a/+km/gLvvA
 fpA8qgY4GaIog6ekUYnuQlvNfjufkdwqqGLManIr3146KoXLXPoi1si70X8sJedecOER4l
 2+rZXgUfzw87/KiaNAPREP/670K44bM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-1htNtBlIMGiTqHFT2UEO2g-1; Wed, 18 Oct 2023 01:55:57 -0400
X-MC-Unique: 1htNtBlIMGiTqHFT2UEO2g-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-402cd372b8bso50521045e9.2
 for <qemu-devel@nongnu.org>; Tue, 17 Oct 2023 22:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697608556; x=1698213356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=soquRUSeJwubM3VRgkN8E/H24tKTEkIYCIq/CNEvxBM=;
 b=gdOLYrtz/GiHlwje5zo/DHMP+s7R7kB/Vr/CdjF9pnRnasjerccJZxBT2ohDidK8gn
 9LfQux5IrT/Q7D7yKZxB1qiibUJGXvtnO7Zgt7sSq6b6fkY33fh3LlrzAoYgVqePNVZS
 uTzmiDzbdX/DUrYR9CYPGBik8N1d3M7Wv+M8ecUF6cDAqkfUjepXgPuzxb21Hz9HvR5k
 PiaYY0R7FZkO2euHCjLqtnsdrdn7FaXCPL/1+Q90D665VM5L5oIlD+yAeReZeBVEtb60
 qeawMBuu1oCvi/g852X2q/9gs3gKMyHSzQq/UOITFJBDNYKD7xA5j5gPM/tjZQXt7v3j
 0TMg==
X-Gm-Message-State: AOJu0YxYXNfgm8AI4fn9iQJGONrEJdw0hjIkO1H5FbtMWwhgUEJh2KzC
 ONsJMhSU7Y1yRPdt7CyBTLziFlp6Zsok/TIpa8XJjZ/CG+PH5OoLRcgsX+l11u+s/ie7DW4M1TF
 Yx1CMy4z9Ch9v68I=
X-Received: by 2002:a05:600c:3507:b0:408:3e7a:82ea with SMTP id
 h7-20020a05600c350700b004083e7a82eamr277158wmq.1.1697608556353; 
 Tue, 17 Oct 2023 22:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFfhuvA0OyJBJP0VoBnOLHANEls14FhyQdNVJbjgAe+kosEajvMTfsl9SGV1XrcdRJkHGkIFA==
X-Received: by 2002:a05:600c:3507:b0:408:3e7a:82ea with SMTP id
 h7-20020a05600c350700b004083e7a82eamr277146wmq.1.1697608555949; 
 Tue, 17 Oct 2023 22:55:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f2:2037:f34:d61b:7da0:a7be])
 by smtp.gmail.com with ESMTPSA id
 h17-20020a05600c499100b0040772138bb7sm712363wmp.2.2023.10.17.22.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Oct 2023 22:55:55 -0700 (PDT)
Date: Wed, 18 Oct 2023 01:55:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Cc: Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org,
 Jason Wang <jasowang@redhat.com>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [PATCH] vhost: Perform memory section dirty scans once per
 iteration
Message-ID: <20231018015401-mutt-send-email-mst@kernel.org>
References: <20230927111428.15982-1-joao.m.martins@oracle.com>
 <20231003095019-mutt-send-email-mst@kernel.org>
 <6e40003d-d2a6-4120-aa78-de26de088d86@oracle.com>
 <20231006054342-mutt-send-email-mst@kernel.org>
 <454ea1c5-7e77-41b5-b6e6-88efb6c437a3@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <454ea1c5-7e77-41b5-b6e6-88efb6c437a3@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Tue, Oct 17, 2023 at 05:32:34PM -0700, Si-Wei Liu wrote:
> 
> 
> On 10/6/2023 2:48 AM, Michael S. Tsirkin wrote:
> > On Fri, Oct 06, 2023 at 09:58:30AM +0100, Joao Martins wrote:
> > > On 03/10/2023 15:01, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 27, 2023 at 12:14:28PM +0100, Joao Martins wrote:
> > > > > On setups with one or more virtio-net devices with vhost on,
> > > > > dirty tracking iteration increases cost the bigger the number
> > > > > amount of queues are set up e.g. on idle guests migration the
> > > > > following is observed with virtio-net with vhost=on:
> > > > > 
> > > > > 48 queues -> 78.11%  [.] vhost_dev_sync_region.isra.13
> > > > > 8 queues -> 40.50%   [.] vhost_dev_sync_region.isra.13
> > > > > 1 queue -> 6.89%     [.] vhost_dev_sync_region.isra.13
> > > > > 2 devices, 1 queue -> 18.60%  [.] vhost_dev_sync_region.isra.14
> > > > > 
> > > > > With high memory rates the symptom is lack of convergence as soon
> > > > > as it has a vhost device with a sufficiently high number of queues,
> > > > > the sufficient number of vhost devices.
> > > > > 
> > > > > On every migration iteration (every 100msecs) it will redundantly
> > > > > query the *shared log* the number of queues configured with vhost
> > > > > that exist in the guest. For the virtqueue data, this is necessary,
> > > > > but not for the memory sections which are the same. So
> > > > > essentially we end up scanning the dirty log too often.
> > > > > 
> > > > > To fix that, select a vhost device responsible for scanning the
> > > > > log with regards to memory sections dirty tracking. It is selected
> > > > > when we enable the logger (during migration) and cleared when we
> > > > > disable the logger.
> > > > > 
> > > > > The real problem, however, is exactly that: a device per vhost worker/qp,
> > > > > when there should be a device representing a netdev (for N vhost workers).
> > > > > Given this problem exists for any Qemu these days, figured a simpler
> > > > > solution is better to increase stable tree's coverage; thus don't
> > > > > change the device model of sw vhost to fix this "over log scan" issue.
> > > > > 
> > > > > Signed-off-by: Joao Martins <joao.m.martins@oracle.com>
> > > > > ---
> > > > > I am not fully sure the heuristic captures the myriad of different vhost
> > > > > devices -- I think so. IIUC, the log is always shared, it's just whether
> > > > > it's qemu head memory or via /dev/shm when other processes want to
> > > > > access it.
> > > > Thanks for working on this.
> > > > 
> > > > I don't think this works like this because different types of different
> > > > vhost devices have different regions - see e.g. vhost_region_add_section
> > > > I am also not sure all devices are running at the same time - e.g.
> > > > some could be disconnected, and vhost_sync_dirty_bitmap takes this
> > > > into account.
> > > > 
> > > Good point. But this all means logic in selecting the 'logger' to take into
> > > considering whether vhost_dev::log_enabled or vhost_dev::started right?
> > > 
> > > With respect to regions it seems like this can only change depending on whether
> > > one of the vhost devices, backend_type is VHOST_BACKEND_TYPE_USER *and* whether
> > > the backend sets vhost_backend_can_merge?
> > > 
> > > With respect to 'could be disconnected' during migration not devices can be
> > > added or removed during migration, so might not be something that occurs during
> > > migration.
> > > I placed this in log_sync exactly to just cover migration, unless
> > > there's some other way that disconnects the vhost and changes these variables
> > > during migration.
> > The *frontend* can't be added or removed (ATM - this is just because we lack
> > good ways to describe devices that can be migrated, so all we
> > came up with is passing same command line on both sides,
> > and this breaks if you add/remove things in the process).
> > We really shouldn't bake this assumption into code if we can
> > help it though.
> > 
> > But I digress.
> > 
> > The *backend* can disconnect at any time as this is not guest visible.
> > 
> > > > But the idea is I think a good one - I just feel more refactoring is
> > > > needed.
> > > Can you expand on what refactoring you were thinking for this fix?
> > Better separate the idea of logging from device. then we can
> > have a single logger that collects data from devices to decide
> > what needs to be logged.
> Discussion. I think the troublemaker here is the vhost-user clients that
> attempt to round down&up to (huge) page boundary and then has to merge
> adjacent sections, leading to differing views between vhost devices. While I
> agree it is a great idea to separate logging from device, it isn't clear to
> me how that can help the case where there could be a mix of both vhost-user
> and vhost-kernel clients in the same qemu process, in which case it would
> need at least 2 separate vhost loggers for the specific vhost type? Or you
> would think there's value to unify the two distinct subsystems with one
> single vhost logger facility?

Yes - I think we need a logger per backend type. Reference-count them, too.

> Noted the vhost logging interface (vhost
> kernel or vhost userspace) doesn't support the notion of separate logging of
> memory buffer sections against those for VQs, all QEMU can rely on is
> various sections in the memory table and basically a single dirty bitmap for
> both guest buffers and VQs are indistinctively shared by all vhost devices.
> How does it help to just refactor QEMU part of code using today's vhost
> backend interface, I am not sure.
> 
> Regardless, IMHO for fixing stable p.o.v it might be less risky and valuable
> to just limit the fix to vhost-kernel case (to be more precise,
> non-vhost-user type and without vhost_backend_can_merge defined), my 2c.
> 
> 
> Regards,
> -Siwei
> > 
> > > My thinking on this bug was mostly to address the inneficiency with the smallest
> > > intrusive fix (if at all possible!) given that virtually all multiqueue vhost
> > > supported QEMU have this problem. And then move into a 'vhost-device for all
> > > queues' as it feels like the problem here is the 'device per queue pair' doesn't
> > > scale.
> > > 
> > > At the end of the day the problem on this is the vhost object model in log_sync
> > > not scaling to amount of queues. But you could also argue that if the log is
> > > shared that you can just log once for all, plus another one for each deviation
> > > of normal behaviour, like the points you made in the earlier paragraph, and thus
> > > the thinking behind this patch would still apply?
> > The thinking is good, but not the implementation.
> > 


