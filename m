Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DA77993A
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 23:10:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUZMy-0005ap-H7; Fri, 11 Aug 2023 17:08:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUZMx-0005ZZ-2M
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:08:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qUZMv-0004Ja-6M
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 17:08:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691788103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=L2SX+A+yNz6pCkZqrHgWxU/NB5ARSWAlyqPNlHzV3Lo=;
 b=KKMKiID+/twoN3eYGsuRmbOsgZxb+xizIvMI9ICHKrOtnupZoWbQXBd9jwZuyYEybfA+l0
 FlC16HLhieFnVyCAuwPRPMQdS8y5qIcVIgFK3Wc6GtaRDAJu7zHjBJE0m12Mt/wgq8V9do
 BXp7rub+5q1w8Hm1j3yP/MNjVekIJkI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-IYPI_OwFNbaphuuWnYgs0A-1; Fri, 11 Aug 2023 17:08:22 -0400
X-MC-Unique: IYPI_OwFNbaphuuWnYgs0A-1
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-76cc6815f23so49390585a.1
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 14:08:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691788102; x=1692392902;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=L2SX+A+yNz6pCkZqrHgWxU/NB5ARSWAlyqPNlHzV3Lo=;
 b=BnCXiRjL0lUqeFiAuvRJOyY+IrnChPf7X6CAetSLGth9KUqlhdTqpXG9CRh9pno3+U
 DVmyEoxPhxrxTNEgdHTy8zDDVsP09v/zVTVL1PEP+0u/r7y3hXHdkjk9feETE0YPXy9y
 DOTj4k5ZMzOYyx7DnGCNigDNF5QH5uwy38lpM06WLzz23s6bwaN4oYbV/zC7TXdxSCL0
 LHDQ1yr4EedJuiUgnpP2MQ5wk7OPPtZMWelpv0VWpOVCQ+YX1iQN3f2vOppdsUNcTMbd
 +Rkc8Rw/XKzPnB4TB3NUvkgLhTIL83AeBRUCoiwCws9Ayt+ibFlz29qhcoGn70akb42F
 c8YA==
X-Gm-Message-State: AOJu0YwIEGuSspRs3BPap6EjZOUinNBf+96M40ZtnoJnjUXtGBHPcJrG
 0wbJ3lgfXAcqZBtR1xBAkzmV6GB+sXyH6grMlnM+lSF+wUI2aKpYyZqZYfqmkd1gjVieN6N2GYC
 G+9BhghlKhsQMUkA=
X-Received: by 2002:a05:620a:178f:b0:76c:e2db:42ba with SMTP id
 ay15-20020a05620a178f00b0076ce2db42bamr3627507qkb.4.1691788101989; 
 Fri, 11 Aug 2023 14:08:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH0wMOIfn6dNoQW+ZWKZ12A6YijQA8+QXsgUBIrH10SDeMm3TnctIZ2w8ooFYGk/SW1GJspCg==
X-Received: by 2002:a05:620a:178f:b0:76c:e2db:42ba with SMTP id
 ay15-20020a05620a178f00b0076ce2db42bamr3627489qkb.4.1691788101665; 
 Fri, 11 Aug 2023 14:08:21 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 m23-20020ae9e717000000b00767d8e12ce3sm1439566qka.49.2023.08.11.14.07.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 14:07:57 -0700 (PDT)
Date: Fri, 11 Aug 2023 17:07:56 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: ThinerLogoer <logoerthiner1@163.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 libvir-list@redhat.com
Subject: Re: [PATCH v1 1/3] softmmu/physmem: fallback to opening guest RAM
 file as readonly in a MAP_PRIVATE mapping
Message-ID: <ZNajLPQvks/iSckH@x1n>
References: <6152f171.6a4c.189e069baf7.Coremail.logoerthiner1@163.com>
 <ZNVVmxuQAsSEHqZq@x1n>
 <9feaf960-637b-9392-3c8f-9e1ba1a7ca40@redhat.com>
 <996a69ff-e2dc-0ed0-2ac8-33fd53bd02c2@redhat.com>
 <ZNZez9ICBBf+D/d2@x1n>
 <e07f29a3-482a-3fcb-7aff-c88827c41385@redhat.com>
 <ZNZgRq22IXyqpun7@x1n>
 <b1630542-475a-f5de-bf79-f6519e01a350@redhat.com>
 <ZNZn29wEXUyD5Cc2@x1n>
 <23397e32-4631-6160-d501-8dfa521a890f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <23397e32-4631-6160-d501-8dfa521a890f@redhat.com>
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

On Fri, Aug 11, 2023 at 07:39:37PM +0200, David Hildenbrand wrote:
> On 11.08.23 18:54, Peter Xu wrote:
> > On Fri, Aug 11, 2023 at 06:25:14PM +0200, David Hildenbrand wrote:
> > > On 11.08.23 18:22, Peter Xu wrote:
> > > > On Fri, Aug 11, 2023 at 06:17:05PM +0200, David Hildenbrand wrote:
> > > > > We wouldn't touch "-mem-path".
> > > > 
> > > > But still the same issue when someone uses -object memory-backend-file for
> > > > hugetlb, mapping privately, expecting ram discard to work?
> > > > 
> > > > Basically I see that example as, "hugetlb" in general made the private
> > > > mapping over RW file usable, so forbidden that anywhere may take a risk.
> > > 
> > > These users can be directed to using hugetlb
> > > 
> > > a) using MAP_SHARED
> > > b) using memory-backend-memfd, if MAP_PRIVATE is desired
> > > 
> > > Am I missing any important use case? Are we being a bit to careful about
> > > virtio-balloon and postcopy simply not being available for these corner
> > > cases?
> > 
> > The current immediate issue is not really mem=rw + fd=rw + private case
> > (which was a known issue), but how to make mem=rw + fd=ro + private work
> > for ThinnerBloger, iiuc.
> > 
> > I'd just think it safer to expose that cap to solve problem A (vm
> > templating) without affecting problem B (fallcate-over-private not working
> > right), when B is uncertain.
> 
> Right, and I'm thinking about if B is worth the effort.
> 
> > 
> > I'm also copy Daniel & libvirt list in case there's quick comment from
> > there. Say, maybe libvirt never use private mapping on hugetlb files over
> > memory-backend-file at all, then it's probably fine.
> 
> libvirt certainly allows setting <access mode="shared"/> with <source
> type="file">.
> 
> Could be that they also end up mapping "<hugepages>" to memory-backend-file
> instead of memory-backend-memfd (e.g., compatibility with older kernels?).
> 
> > 
> > In all cases, you and Igor should have the final grasp; no stand on a
> > strong opinon from my side.
> 
> I do value your opinion, so I'm still trying to figure out if there are sane
> use cases that really need a new parameter. Let's recap:
> 
> When opening the file R/O, resulting in fallocate() refusing to work:
> * virtio-balloon will fail to discard RAM but continue to "be alive"
> * virtio-mem will discard any private pages, but cannot free up disk
>   blocks using fallocate.
> * postcopy would fail early
> 
> Postcopy:
> * Works on shmem (MAP_SHARED / MAP_PRIVATE)
> * Works on hugetlb (MAP_SHARED / MAP_PRIVATE)
> * Does not work on file-backed memory (including MAP_PRIVATE)
> 
> We can ignore virtio-mem for now. What remains is postcopy and
> virtio-balloon.
> 
> memory-backend-file with MAP_PRIVATE on shmem/tmpfs results in a double
> memory consumption, so we can mostly cross that out as "sane use case".
> Rather make such users aware of that :D
> 
> memory-backend-file with MAP_PRIVATE on hugetlb works. virtio-balloon is not
> really compatible with hugetlb, free-page-reporting might work (although
> quite non-nonsensical). So postcopy as the most important use case remains.
> 
> memory-backend-file with MAP_PRIVATE on file-backed memory works. postcopy
> does not apply. virtio-balloon should work I guess.
> 
> 
> So the two use cases that are left are:
> * postcopy with hugetlb would fail
> * virtio-balloon with file-backed memory cannot free up disk blocks
> 
> Am I missing a case?

Looks complete.  I don't want to say so, but afaik postcopy should be
"corner case" in most cases I'd say; people do still rely mostly on
precopy.  It's probably a matter of whether we'd like take the risk.

-- 
Peter Xu


