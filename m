Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D137B72F8
	for <lists+qemu-devel@lfdr.de>; Tue,  3 Oct 2023 23:02:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnmVe-0001t6-Pq; Tue, 03 Oct 2023 17:00:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnmVd-0001st-2r
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qnmVY-0007nK-OE
 for qemu-devel@nongnu.org; Tue, 03 Oct 2023 17:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696366843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OadjvY7B6uP1MNJAYcbK+gFb6h15tBHJRQ1VEuApuVU=;
 b=jMKwjr8kNia8vXtsrVjYxmkbi5ptPDWf02wk+AjcJcmu5eE+esZcdi3ZU6AeBA0vuDqMOb
 A4Zil8zeL2GMYryEx75HxBgehvwFScO3CdvfmK+QlS/4gL7NSLKnyeR+UpJLvKGMn40qNs
 7qhbGQMH2oXS2yyfhU2uAPWGbt5FRso=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-Hus_o58ZMGiCDhnYLzFXEg-1; Tue, 03 Oct 2023 17:00:41 -0400
X-MC-Unique: Hus_o58ZMGiCDhnYLzFXEg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40590e6bd67so10201335e9.2
 for <qemu-devel@nongnu.org>; Tue, 03 Oct 2023 14:00:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696366838; x=1696971638;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OadjvY7B6uP1MNJAYcbK+gFb6h15tBHJRQ1VEuApuVU=;
 b=i7mkbZ2U/z8Kf1IgZj1HzlJNNh8IS/n/0JZf6K59AuuWzrZMRQo+T/xiCN9mNWEZT9
 CcKz0zmkJVr9siiZKEX8mD43rcSG+J8FRQ8HVo1DwWsookXVnlE/LOG1A2+/p3mybNSL
 1DyGIBn2bdUGDehuDCVAWAyLpfLEP60hcejUWyYWqdq4w29qugsKZh3+OjKU9SZtq3r1
 rLh8gnk1JdkZm2qWHKoXkiBmiij5FSDrf/eXLxcaFn8Z6nHEuTwfyPzOIdnpf2JjfkqD
 1YPuJAHb/9O+4EgJlSgeE/p2I3YBw3r016OqIqe0wEBwMAxy3or6rexUFsOllg515li1
 uPjA==
X-Gm-Message-State: AOJu0YxnaHhKk/Rm+Jd6QMYO1cR6PnQCcSMgIwsAaDuZaOvt5hB0LPKh
 s8yb35CuQqbF8v/o+/OZ3aj3OTgSxpT2uMRdng0cK7jT8McjOopnCMonxg8eiLcMAFs6rnIlfjI
 5EdzBDVrLWFjtOEstIET1uHU=
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id
 g11-20020a7bc4cb000000b00401cb453fb8mr544846wmk.38.1696366838207; 
 Tue, 03 Oct 2023 14:00:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkk8KF3r4waTlAXlmMgFIk7yqf/FBlNoB4abWI7RHuPPQpC1PdezvZCFW6aOS6Orp05512Xw==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id
 g11-20020a7bc4cb000000b00401cb453fb8mr544825wmk.38.1696366837860; 
 Tue, 03 Oct 2023 14:00:37 -0700 (PDT)
Received: from redhat.com ([2.52.137.96]) by smtp.gmail.com with ESMTPSA id
 l17-20020a1ced11000000b0040588d85b3asm38121wmh.15.2023.10.03.14.00.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Oct 2023 14:00:37 -0700 (PDT)
Date: Tue, 3 Oct 2023 17:00:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, hreitz@redhat.com,
 Raphael Norwitz <raphael.norwitz@nutanix.com>,
 Fam Zheng <fam@euphon.net>, eperezma@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 0/3] vhost: clean up device reset
Message-ID: <20231003170003-mutt-send-email-mst@kernel.org>
References: <20230927192737.528280-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927192737.528280-1-stefanha@redhat.com>
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

On Wed, Sep 27, 2023 at 03:27:34PM -0400, Stefan Hajnoczi wrote:
> Stateful vhost devices may need to free resources or clear device state upon
> device reset. The vhost-user protocol has a VHOST_USER_RESET_DEVICE message for
> this and vDPA has SET_STATUS 0, but only QEMU's vhost-user-scsi device actually
> implements this today.
> 
> This patch series performs device reset across all device types. When
> virtio_reset() is called, the associated vhost_dev's ->vhost_reset_device() is
> called. vhost-user-scsi's one-off implementation is obsoleted and removed.
> 
> This patch affects behavior as follows:
> - vhost-kernel: no change in behavior. No ioctl calls are made.
> - vhost-user: back-ends that negotiate
>   VHOST_USER_PROTOCOL_F_RESET_DEVICE now receive a
>   VHOST_USER_DEVICE_RESET message upon device reset. Otherwise there is
>   no change in behavior. DPDK, SPDK, libvhost-user, and the
>   vhost-user-backend crate do not negotiate
>   VHOST_USER_PROTOCOL_F_RESET_DEVICE automatically.
> - vhost-vdpa: an extra SET_STATUS 0 call is made during device reset.
> 
> I have tested this series with vhost-net (kernel), vhost-user-blk, and
> vhost-user-fs (both Rust and legacy C).
> 
> Stefan Hajnoczi (3):
>   vhost-user: do not send RESET_OWNER on device reset
>   vhost-backend: remove vhost_kernel_reset_device()
>   virtio: call ->vhost_reset_device() during reset

Build failure:
https://gitlab.com/mstredhat/qemu/-/jobs/5215049540


>  include/hw/virtio/vhost.h |  3 +++
>  hw/scsi/vhost-user-scsi.c | 20 --------------------
>  hw/virtio/vhost-backend.c |  6 ------
>  hw/virtio/vhost-user.c    | 13 +++++++++----
>  hw/virtio/vhost.c         |  9 +++++++++
>  hw/virtio/virtio.c        |  4 ++++
>  6 files changed, 25 insertions(+), 30 deletions(-)
> 
> -- 
> 2.41.0


