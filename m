Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B2F307656B7
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 17:04:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP2QT-0003P9-RC; Thu, 27 Jul 2023 10:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qP2QO-0003Os-LX
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:57:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qP2QM-0006Vg-Lj
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 10:57:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690469825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wmS9UZ85DD3NYYTes09Kr8GZag0Z775xiJRBNzjRk+0=;
 b=G+NnE7K0FKQy3g4ygxupoThcPC1/bdlJkS9aaKn+jsX/iDY6dIKzc1lBpVdZ9/woymHa7i
 9HQG8QbNhGQLNLxRw0q48BBvjTn0vTmQMslvK1OEApbJHpQBHgV49Aw/OAujpDAELmiGTF
 4gDdcTpVhSZvgEdRONXuWk1beSiXVe8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-681-2bicz8AZOAqkOj6hr0fHww-1; Thu, 27 Jul 2023 10:57:04 -0400
X-MC-Unique: 2bicz8AZOAqkOj6hr0fHww-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bcf56a2e9so62687666b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 07:57:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690469823; x=1691074623;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wmS9UZ85DD3NYYTes09Kr8GZag0Z775xiJRBNzjRk+0=;
 b=QeCNB8M6UvH+GDgTV8/H5njkdy1qU68OM4Ggv6wz8V6VC+vagwjIHMcE+Eku6RCUGJ
 Mzu8aeUGIYfsjxxLQ+Qflv7RTA9Q/CeoFlSF32Rt2FRUfBzNg9xWRkOWD9/xTGoE/dZA
 Bncg0iT5AUY0iCqPsWSnOYTCUF7uzCyagjOthPdUNBMETu/zGoPNa70qrvFFC6QkUUF0
 20K7UPzSVw6uiZS4SYv2uJ+yWk/ftR6oauAEsbqQ5Z8mcHnxDGBckZ4kCtY1AmGCY/w1
 kx3pZHNQCi/a1H+24AE5G64TdOHbN77O7B12BqMtSKGsjckOn9P6EPA284BFDQzjfOgq
 Yk/g==
X-Gm-Message-State: ABy/qLYSeIefQA/ysEg80v08pGDTLBCTPdDb9nSXzQr2PqaLcfOUObs2
 1GCkY5pZK1kFezYgIOj7GvGIQklDc4Q3AriEwvtPOklhRtkfvERgnccQMPH2b4uM7OS4ta2Fq7S
 jLKSLMM3s6/tUN8E=
X-Received: by 2002:a17:907:7798:b0:99b:d580:546c with SMTP id
 ky24-20020a170907779800b0099bd580546cmr2705123ejc.23.1690469823300; 
 Thu, 27 Jul 2023 07:57:03 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE0ODdJ1wmvZ/QPM5X33mEzRkE67fm04mkbPTtcoqIKT5b9ErdqjzcuxDAKD43B5Le4aOGnBw==
X-Received: by 2002:a17:907:7798:b0:99b:d580:546c with SMTP id
 ky24-20020a170907779800b0099bd580546cmr2705106ejc.23.1690469823004; 
 Thu, 27 Jul 2023 07:57:03 -0700 (PDT)
Received: from redhat.com ([2.52.14.22]) by smtp.gmail.com with ESMTPSA id
 se27-20020a170906ce5b00b00992d122af63sm873792ejb.89.2023.07.27.07.57.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 07:57:02 -0700 (PDT)
Date: Thu, 27 Jul 2023 10:56:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Albert Esteve <aesteve@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@gmail.com, cohuck@redhat.com,
 Fam Zheng <fam@euphon.net>, kraxel@redhat.com
Subject: Re: [PATCH v4 3/4] vhost-user: add shared_object msg
Message-ID: <20230727105523-mutt-send-email-mst@kernel.org>
References: <20230626073426.285659-1-aesteve@redhat.com>
 <20230626073426.285659-4-aesteve@redhat.com>
 <20230710150030-mutt-send-email-mst@kernel.org>
 <CADSE00+MYYeTto5CCROpynB2p+FjcCASp6azyxb2FVRm7VhBrw@mail.gmail.com>
 <20230717100739-mutt-send-email-mst@kernel.org>
 <CADSE00Jm45pbhvWgN8uQGjqZkEZr2UEHV2ARuqWheT-pXL-85Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CADSE00Jm45pbhvWgN8uQGjqZkEZr2UEHV2ARuqWheT-pXL-85Q@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jul 27, 2023 at 04:48:30PM +0200, Albert Esteve wrote:
> 
> 
> On Mon, Jul 17, 2023 at 4:11 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> 
> 
> 
> 
> 
>     On Mon, Jul 17, 2023 at 01:42:02PM +0200, Albert Esteve wrote:
>     > Hi Michael,
>     >
>     > True. It may be a good idea to impose a limit in the number of entries
>     that can
>     > be added to the table.
>     > And fail to add new entries once it reaches the limit.
>     >
>     > Not sure what would be a good limit though. For example, https://
>     www.kernel.org
>     > /doc/html/v4.9/media/uapi/v4l/vidioc-reqbufs.html#c.v4l2_requestbuffers
>     > does not limit the number of buffers that can be allocated
>     simultaneously, it
>     > is an unsigned 32-bits value.
>     > However, I guess 16-bits (65535) would suffice to cover the vast majority
>     of
>     > usecases. Or even lower, and
>     > can be adjusted later, as this API gets (more) used.
>     >
>     > Does that make sense?
>     >
>     > Thanks.
>     > BR,
>     > Albert
> 
>     let's not top-post please.
> 
>     Maybe. Another concern is qemu running out of FDs with a bad backend.
> 
>     Question: why does qemu have to maintain these UUIDs in its memory?
> 
>     Can't it query the backend with UUID and get the fd back?
> 
> 
> In the end, we have one backend sharing an object with other backends.
> From the importer POV, it does not know who the exporter is, so it cannot
> go pocking other backends until it finds the one that is holding a resource
> with
> the same UUID, it relies on qemu providing this information.
> 
> If we do not want qemu to hold the fds, we could, for instance, store
> references to
> backends that act as exporters. And then, once an importer requests for a
> specific
> object with its UUID, we ask for the fd to the exporter(s), hoping to find it.


right. I'd do this. and then the existing table can be regarded
as a cache.

> But the current solution sounds better fit to the shared objects virtio
> feature.
> I would be more keen to look into something like what Gerd suggested, limiting
> the memory that we use. 
> 
> Nonetheless, in qemu we are storing fds, and not mmaping the dmabufs.
> So I think limiting the number of entries should suffice, to ensure
> that we do not run out of FDs, and memory.

my point is you really don't know how much to limit it.
if there's ability to drop the entries then you
can do this, and cache things in memory.


> 
> 
>     And then, the hash table in QEMU becomes just a cache
>     to speed up lookups.
> 
>     --
>     MST
> 
> 


