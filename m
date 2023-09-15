Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 455BC7A1D41
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 13:18:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh6pB-0003Nv-QO; Fri, 15 Sep 2023 07:17:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qh6pA-0003Ne-D6
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qh6p8-0006lW-G1
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 07:17:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694776641;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cXwsKpI636H2G49Ty4gU/pdXhzfeIKbsPovFrMje47o=;
 b=RGpfP8YMWcXn+UKZvTOVJE74ebXnEQMoEM65mGHnh1C7vlf7wXoFYhkURfzbzMG/3j7EgA
 9MbddQtAXat+UpX82jFcUYJagsW2vcWZGueALFtRy2cAnfhU0WqVashwM0XzM4D+lI63/A
 XADU4H2V0RA7s7hPeZMIswJ1yIoP3Ck=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-OUraLFv2PI2jtos3-BgxHA-1; Fri, 15 Sep 2023 07:17:19 -0400
X-MC-Unique: OUraLFv2PI2jtos3-BgxHA-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2b9d0b3a572so25339751fa.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 04:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694776638; x=1695381438;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cXwsKpI636H2G49Ty4gU/pdXhzfeIKbsPovFrMje47o=;
 b=pfumuGd/uzSzq+qYVx1Ylcyhd+YL92FKoavcVP11KtofUsO1W3d9F72OqDN8OKYHcq
 ogic/4fjnZzPgmsG/W2UoktS8x8/bS7zcoe0SNKqAwn3VOXFZarM8Mm0Bvzv9Cr4H6T8
 SAXLCfYe0YUtRvlrk4VT+WxYlBnFmaSw35IWLzEGzjRoaq50nWDbCTH5rf1Kp/GElzCj
 7x0XAWheCPEhMYOnXyw4UDhG/iZS7OB9HdobLCYcIS8FXZ8A5SLMqB5plqUU0qB/XREU
 vABEt5M9SQXSSbDzkqoaQ+l6cIlKrLs5jooEFYbYgaRPNNfdOKW5PggVbkdRv4MAuoBX
 TRyw==
X-Gm-Message-State: AOJu0YzlT3ChSbqJjEd2mUyeQK8Dwt597MLf49TvxZrbotuCkdnyS4hm
 m5w1Ms2sCVrJ7V8Lyb9AklACVhVDzSh69prDPJTaKKVozpbUu7GxN1Rcz3QiU0WiJiQSI1E/QDS
 7Ny9Pv++kIW5masA=
X-Received: by 2002:a2e:83c7:0:b0:2bb:997a:493e with SMTP id
 s7-20020a2e83c7000000b002bb997a493emr1108778ljh.35.1694776638356; 
 Fri, 15 Sep 2023 04:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVILKnHPKigqbMyOGt4vbE9GfzDGSBMu947FVQM6GnfZpFRtna2s15ZSyk9eD84rdODUOZxw==
X-Received: by 2002:a2e:83c7:0:b0:2bb:997a:493e with SMTP id
 s7-20020a2e83c7000000b002bb997a493emr1108771ljh.35.1694776637968; 
 Fri, 15 Sep 2023 04:17:17 -0700 (PDT)
Received: from redhat.com ([2.52.27.167]) by smtp.gmail.com with ESMTPSA id
 jp27-20020a170906f75b00b0099bd046170fsm2282291ejb.104.2023.09.15.04.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Sep 2023 04:17:17 -0700 (PDT)
Date: Fri, 15 Sep 2023 07:17:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH 0/4] virtio-blk: prepare for the multi-queue block layer
Message-ID: <20230915071655-mutt-send-email-mst@kernel.org>
References: <20230914140101.1065008-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230914140101.1065008-1-stefanha@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Sep 14, 2023 at 10:00:57AM -0400, Stefan Hajnoczi wrote:
> The virtio-blk device will soon be able to assign virtqueues to IOThreads,
> eliminating the single IOThread bottleneck. In order to do that, the I/O code
> path must support running in multiple threads.
> 
> This patch series removes the AioContext lock from the virtio-blk I/O code
> path, adds thread-safety where it is required, and ensures that Linux AIO and
> io_uring are available regardless of which thread calls into the block driver.
> With these changes virtio-blk is ready for the iothread-vq-mapping feature,
> which will be introduced in the next patch series.
> 
> Based-on: 20230913200045.1024233-1-stefanha@redhat.com ("[PATCH v3 0/4] virtio-blk: use blk_io_plug_call() instead of notification BH")
> Based-on: 20230912231037.826804-1-stefanha@redhat.com ("[PATCH v3 0/5] block-backend: process I/O in the current AioContext")


virtio bits:

Reviewed-by: Michael S. Tsirkin <mst@redhat.com>

feel free to merge

> Stefan Hajnoczi (4):
>   block/file-posix: set up Linux AIO and io_uring in the current thread
>   virtio-blk: add lock to protect s->rq
>   virtio-blk: don't lock AioContext in the completion code path
>   virtio-blk: don't lock AioContext in the submission code path
> 
>  include/hw/virtio/virtio-blk.h |   3 +-
>  block/file-posix.c             |  99 +++++++++++++++---------------
>  hw/block/virtio-blk.c          | 106 +++++++++++++++------------------
>  3 files changed, 98 insertions(+), 110 deletions(-)
> 
> -- 
> 2.41.0


