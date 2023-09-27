Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 09AD07B0912
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 17:42:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlWfr-00089q-G3; Wed, 27 Sep 2023 11:42:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWfp-00089b-AS
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qlWfn-0008Qa-9I
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 11:42:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695829318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k47fJCTbNP/jcjO98mjTRq5fHK/0ZJ3ifuycgIYIJWs=;
 b=O9Dxbkf5MuBFTv5Xx5eDJdp2pRa5iuN8mupRGcLLPLUNKXbZaLzPIkmandCL0sJ6rHqB66
 5Z7/WW3dlJZrOmRC+dYFQhbRMU/SVrOHf7Fx8m+HRxf9qxM8IQyCzwS75CUrWKFKdvYegY
 /YtEUj7LHiRpdGUnraU//qsULzlcVYY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-mE4GVRonMDWvfwlXPML6TQ-1; Wed, 27 Sep 2023 11:41:55 -0400
X-MC-Unique: mE4GVRonMDWvfwlXPML6TQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-31fed999e27so9310373f8f.2
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 08:41:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695829314; x=1696434114;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=k47fJCTbNP/jcjO98mjTRq5fHK/0ZJ3ifuycgIYIJWs=;
 b=CCzJnGcq7Xbi+W/Tqi3IevYFogTsYvjBwgwEvzjyt7AnB0EoD/29/90XSUCPklzCQ3
 6YGEKXvTwYLqwjJhUSTp9fq0pN4LkK26xys0ZhTRbKxb0RUSPJmHgLmtsSzvFlMp2db7
 R9JdOkVFbDm66xvwAf+TWk09B2vJl6WqfwrPIQoxueQLKAeOiIggGdnJsqmWJi5gfcBW
 neq8AbswrjMyJJX8vuAUlhIoZIEK3PoYr8oefYASD6kyNUztrBp0N5ztPflXGHOq8lW9
 y63KrN6oLUvsV9xKSAB+/gHZ+JNuX2npndAjwH+c2Dbpm/XT/VCbGdXr5dLGTDhBQp9p
 YkXQ==
X-Gm-Message-State: AOJu0YyCKX1NiixU4GFnUStgB/7WudtYIB1iL/yr/IXWebxvuG6sCFUl
 qcr3kGXaTKJwxa1y0IfaMPYoWMrl/aDkhhg32F7rH1g18anShjaAxmqx3UF2TbZJfCblJ0RoCVs
 64hy/P6WBeCOaM7w=
X-Received: by 2002:adf:fa88:0:b0:31f:97e2:a924 with SMTP id
 h8-20020adffa88000000b0031f97e2a924mr2096735wrr.14.1695829314656; 
 Wed, 27 Sep 2023 08:41:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHGnLYVvC6NFm+TqZngd+sFe4b2uJBedGS7jHuwGJNbCO0Pp9eK7b1v/U78MpC2autRzOqJYQ==
X-Received: by 2002:adf:fa88:0:b0:31f:97e2:a924 with SMTP id
 h8-20020adffa88000000b0031f97e2a924mr2096723wrr.14.1695829314345; 
 Wed, 27 Sep 2023 08:41:54 -0700 (PDT)
Received: from redhat.com ([2a02:14f:16e:b9f6:556e:c001:fe18:7e0a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a5d4b09000000b0032008f99216sm17683578wrq.96.2023.09.27.08.41.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Sep 2023 08:41:53 -0700 (PDT)
Date: Wed, 27 Sep 2023 11:41:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ilya Maximets <i.maximets@ovn.org>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] virtio: remove unnecessary thread fence while reading
 next descriptor
Message-ID: <20230927114117-mutt-send-email-mst@kernel.org>
References: <20230825170136.1953236-1-i.maximets@ovn.org>
 <CAJSP0QW2LZQgHFSp=ajokFpAzaLWhDXBL0tP8Lj-vXTaMKJcqQ@mail.gmail.com>
 <fd5f15c1-87b7-bd00-be5f-987a02f35482@ovn.org>
 <28993913-624a-a437-1382-54a95933474c@ovn.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <28993913-624a-a437-1382-54a95933474c@ovn.org>
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

On Wed, Sep 27, 2023 at 04:06:41PM +0200, Ilya Maximets wrote:
> On 9/25/23 20:04, Ilya Maximets wrote:
> > On 9/25/23 16:32, Stefan Hajnoczi wrote:
> >> On Fri, 25 Aug 2023 at 13:02, Ilya Maximets <i.maximets@ovn.org> wrote:
> >>>
> >>> It was supposed to be a compiler barrier and it was a compiler barrier
> >>> initially called 'wmb' (??) when virtio core support was introduced.
> >>> Later all the instances of 'wmb' were switched to smp_wmb to fix memory
> >>> ordering issues on non-x86 platforms.  However, this one doesn't need
> >>> to be an actual barrier.  It's enough for it to stay a compiler barrier
> >>> as its only purpose is to ensure that the value is not read twice.
> >>>
> >>> There is no counterpart read barrier in the drivers, AFAICT.  And even
> >>> if we needed an actual barrier, it shouldn't have been a write barrier.
> >>>
> >>> Signed-off-by: Ilya Maximets <i.maximets@ovn.org>
> >>> ---
> >>>  hw/virtio/virtio.c | 2 +-
> >>>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>>
> >>> diff --git a/hw/virtio/virtio.c b/hw/virtio/virtio.c
> >>> index 309038fd46..6eb8586858 100644
> >>> --- a/hw/virtio/virtio.c
> >>> +++ b/hw/virtio/virtio.c
> >>> @@ -1051,7 +1051,7 @@ static int virtqueue_split_read_next_desc(VirtIODevice *vdev, VRingDesc *desc,
> >>>      /* Check they're not leading us off end of descriptors. */
> >>>      *next = desc->next;
> >>
> >> I don't see a caller that uses *next. Can the argument be eliminated?
> > 
> > Yes, it can.  The 'next' was converted from a local variable to
> > an output parameter in commit:
> >   412e0e81b174 ("virtio: handle virtqueue_read_next_desc() errors")
> > 
> > And that didn't actually make sense even then, because all the
> > actual uses of the 'i/next' as an output were removed a few months
> > prior in commit:
> >   aa570d6fb6bd ("virtio: combine the read of a descriptor")
> > 
> > I can post a separate patch for this.
> > 
> >>
> >>>      /* Make sure compiler knows to grab that: we don't want it changing! */
> >>> -    smp_wmb();
> >>> +    barrier();
> >>
> >> What is the purpose of this barrier? desc is not guest memory and
> >> nothing modifies desc's fields while this function is executing. I
> >> think the barrier can be removed.
> > 
> > True.  In fact, that was the first thing I did, but then the comment
> > derailed me into thinking that it somehow can be updated concurrently,
> > so I went with a safer option.  :/
> > It is indeed a local variable and the barrier is not needed today.
> > It had a little more sense before the previously mentioned commit:
> >   aa570d6fb6bd ("virtio: combine the read of a descriptor")
> > because we were reading guest memory before the barrier and used the
> > result after.
> > 
> > I'll remove it.
> 
> Converted this into a cleanup patch set.  Posted here:
>   https://lists.gnu.org/archive/html/qemu-devel/2023-09/msg06780.html
> 
> Best regards, Ilya Maximets.

Ugh, these archives are useless. use lore please. 

-- 
MST


