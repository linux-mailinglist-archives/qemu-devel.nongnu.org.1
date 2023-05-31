Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 562C4717D37
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 12:29:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4J4C-0005rO-Qt; Wed, 31 May 2023 06:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4J48-0005ph-FD
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:28:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1q4J46-0002vS-SM
 for qemu-devel@nongnu.org; Wed, 31 May 2023 06:28:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685528905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=v+6awSCGx3H4rFHYZE5eZfMNTZ+0ih4FzZm7rqNZenk=;
 b=BideDNBmENTwXh26K/TvaXv3Vh+Xj4c6gA7/qJcUH96FVoxPibcK/zIiGrRvw77A6jew5I
 OhCNWniCSB4f0pNal2ZiPbgx+toTXQP0cTtLFzL0e2jHzoJwh7jZMFpIYpfznIHpTKuEyr
 pVlrMvrqOEJtmbtft++lekd/jXjkUGU=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-3jahvaB4OXuU3rVOPBPAXg-1; Wed, 31 May 2023 06:28:24 -0400
X-MC-Unique: 3jahvaB4OXuU3rVOPBPAXg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f42bcef2acso25504065e9.2
 for <qemu-devel@nongnu.org>; Wed, 31 May 2023 03:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685528903; x=1688120903;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v+6awSCGx3H4rFHYZE5eZfMNTZ+0ih4FzZm7rqNZenk=;
 b=IpNW/xtoDjpWWt0+a9bnqEFifKtnLsyHL+jVZVJ9qAjDphiuP57i7+TPT6DogoOFnL
 mJ9K/n2WscAaECwJhIFRs9fh9iO8pEqdEgNnUKQFCeBW3R3AUMjn6QkeIMO1AlFSYfEX
 MlFnYemR3+N3lWdrCDn5aXgxVAlTUK4IkS7r0xy5LkePIO9zZgJhrq3520/GXZVF9Iv+
 ykeS466IzXjAk6YsWJNxkSCZ8anYF7uSTGBftR7Gwnx2dwJ6jaTeE3b7uNgv++C6jCpc
 Frkk5+DxKUfEyOTcbPV8B0dsYMehlLAslaggmhO5Z7ttzwhSbmxe/7Bt7Qf9nv7C/n5X
 yZ4w==
X-Gm-Message-State: AC+VfDwWDs/5t5kOH30nwK2330wnBnU20vSqPIi/CEVtCl4ME+BUELm7
 Wfa42ZO4Fn3Ig7FItMg+dPXQdWdVVQO1S0Mr7zexpnpoA3clHWEuQfbCtf1z26ZzJrR8vxxH2gO
 SJ8Gcv7EPKXdyYsM=
X-Received: by 2002:a5d:5706:0:b0:309:3e6f:6725 with SMTP id
 a6-20020a5d5706000000b003093e6f6725mr3690684wrv.4.1685528902880; 
 Wed, 31 May 2023 03:28:22 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7jIiDpauRZrvUN8drwdMucYisgD9/e/Os3Ce8BLbJ7uwHEWLM+Ai09pZ8wqoorcKJkbv1gEA==
X-Received: by 2002:a5d:5706:0:b0:309:3e6f:6725 with SMTP id
 a6-20020a5d5706000000b003093e6f6725mr3690666wrv.4.1685528902533; 
 Wed, 31 May 2023 03:28:22 -0700 (PDT)
Received: from redhat.com ([2.52.11.69]) by smtp.gmail.com with ESMTPSA id
 b17-20020adff251000000b002c71b4d476asm6300597wrp.106.2023.05.31.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 May 2023 03:28:21 -0700 (PDT)
Date: Wed, 31 May 2023 06:28:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: "T.J. Alumbaugh" <talumbau@google.com>, qemu-devel@nongnu.org,
 Yuanchu Xie <yuanchu@google.com>, Yu Zhao <yuzhao@google.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [RFC PATCH v2 1/5] virtio-balloon: Add Working Set Reporting
 feature
Message-ID: <20230531062642-mutt-send-email-mst@kernel.org>
References: <20230525222016.35333-1-talumbau@google.com>
 <20230525222016.35333-2-talumbau@google.com>
 <ada6956d-028f-2c62-d3f9-3d6b2ae3c42e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada6956d-028f-2c62-d3f9-3d6b2ae3c42e@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, May 31, 2023 at 10:12:26AM +0200, David Hildenbrand wrote:
> On 26.05.23 00:20, T.J. Alumbaugh wrote:
> 
> Hi,
> 
> please try writing a comprehensive patch description: the goal should be
> that one can understand what's happening in the single patch without all of
> the following patches at hand. [ that's how I am reading them, and ahve to
> ask many stupid questions :P ]
> 
> > Balloon header includes:
> >   - feature bit for Working Set Reporting
> >   - number of Working Set bins member in balloon config
> >   - types for communicating Working Set information
> > 
> 
> Can you briefly summarize how all the bits here interact?
> 
> I assume, once VIRTIO_BALLOON_F_WS_REPORTING has been negotiated
> 
> (1) There is a new virtqueue for sending WS-related requests from the
>     device (host) to the driver (guest).

this belongs in driver description, indeed.

> -> How does a request look like?
> -> How does a response look like?
> -> Error cases?

These last 3 are best in the spec, not in driver.

> (2) There is a new config space option.
> 
> -> Who's supposed to read this, who's supposed to write it?
> -> Can it be changed dynamically?
> -> What's the meaning / implication of that value.

same. best in spec.

> > Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
> > ---
> >   .../standard-headers/linux/virtio_balloon.h   | 20 +++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> > 
> > diff --git a/include/standard-headers/linux/virtio_balloon.h b/include/standard-headers/linux/virtio_balloon.h
> > index f343bfefd8..df61eaceee 100644
> > --- a/include/standard-headers/linux/virtio_balloon.h
> > +++ b/include/standard-headers/linux/virtio_balloon.h
> > @@ -37,6 +37,7 @@
> >   #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
> >   #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
> >   #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
> > +#define VIRTIO_BALLOON_F_WS_REPORTING	6 /* Working set report virtqueues */
> 
> ... are there multiple virtqueues? How many?
> 
> >   /* Size of a PFN in the balloon interface. */
> >   #define VIRTIO_BALLOON_PFN_SHIFT 12
> > @@ -59,6 +60,9 @@ struct virtio_balloon_config {
> >   	};
> >   	/* Stores PAGE_POISON if page poisoning is in use */
> >   	uint32_t poison_val;
> > +	/* Stores the number of histogram bins if WS reporting in use */
> > +	uint8_t working_set_num_bins;
> > +	uint8_t padding[3];
> >   };
> >   #define VIRTIO_BALLOON_S_SWAP_IN  0   /* Amount of memory swapped in */
> > @@ -116,4 +120,20 @@ struct virtio_balloon_stat {
> >   	__virtio64 val;
> >   } QEMU_PACKED;
> > +enum virtio_balloon_working_set_op {
> > +    VIRTIO_BALLOON_WS_REQUEST = 1, /* a Working Set request from the host */
> > +    VIRTIO_BALLOON_WS_CONFIG = 2,  /* a Working Set config from the host */
> > +};
> > +
> > +struct virtio_balloon_working_set {
> > +	/* A tag for additional metadata */
> > +	__virtio16 tag;
> > +	/* The NUMA node for this report. */
> > +	__virtio16 node_id;
> 
> How will we handle the case when the guest decides to use a different NUMA
> layout (e.g., numa disabled, fake numa, ...).
> 
> Is the guest supposed to detect that and *not* indicate a NUMA ID then?
> 
> 
> Also, I wonder
> 
> > +	uint8_t reserved[4];
> > +	__virtio64 idle_age_ms;
> > +	/* A bin each for anonymous and file-backed memory. */
> 
> Why not have them separately, and properly named?
> 
> I'm not sure if it's a good idea to distinguish them based on anon vs.
> file-backed.
> 
> What would you do with shmem? It can be swapped like anon memory, ... if
> swap is enabled.
> 
> What's the main motivation for splitting this up? Is the "file-backed" part
> supposed to give some idea about the pagecache size? But what about mlock or
> page pinning?
> 
> 
> Now I should take a step back and read the cover letter :)
> 
> -- 
> Thanks,
> 
> David / dhildenb


