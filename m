Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D1F2765949
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 18:56:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3ZY-0008Kz-L6; Thu, 27 Jul 2023 12:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3ZU-0008JL-Oc
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qP3ZS-0003RQ-Ty
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 12:10:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690474233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nXYAM2/blIxvIXpTgJL/08VCLsWjAekSlPsIqUXZIGA=;
 b=F6v0nnVCmLhhygKI/S704z1zKKwSsTWQmgX/AoYCbdfRYTVwFPPf63JADLFRSiF5zxXnvi
 xnZl9RtPooLSK1AenA9WoyU+EFXvEHs+zU+LAgXp9nWADSsKixdaC58gzAnAWeD+uo5aX5
 yCGfOsxmgD+6QkHEuQqnXbXxQmCXnKE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-AEreIhNsOOyQYCOSn83xCQ-1; Thu, 27 Jul 2023 12:10:31 -0400
X-MC-Unique: AEreIhNsOOyQYCOSn83xCQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fc00d7d62cso6704395e9.2
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 09:10:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690474230; x=1691079030;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nXYAM2/blIxvIXpTgJL/08VCLsWjAekSlPsIqUXZIGA=;
 b=KVyW8OkcpvPz4SI8WuT7bntN84pRXfw2PWqY1HIzs2zCQo6W+y9yhR8OtagERqXSuM
 Bcp+svY26M3D211Rvvrj6CxdMSAqQvyop+Ov9zpzrTeg5D9Vqpem0Kd376exDFKNd5nz
 LbW5I8szn7ON0aQHRENfmmGg6Hk5JsFVj85S/yZVieP7PIMQqNC6qRjUNunFaUEwc6sf
 4+H+ajyYVnLY60SIhFmBFBBP9ZO7kfMwzHg3OWF/s6XiPDW9nPbUcaq9gAwKUo7KjyFQ
 zCmJGPCDZuiU1RL+fgiWQEV+XUh/4cXBVclmUAn3RGsyYciNslJdt0emqzLOEY4RO4G4
 gBKg==
X-Gm-Message-State: ABy/qLZ/aMkx3h1gTt0ykB9DTGkxRARmg8q9hBBLLcUnkvqe6k9a1hwP
 aYb0v3IL1PAWfiq/SsQHeLhAJ2GRz0bgKtLTfz7i9NKIX8Bha9sxB90XxyWu3LaiGHotNvffxtq
 7vSYf9TgHr0Rux33KIsmI4NZlsZR4pqjqbtoh5OQ2oEgywxrP4R2fCCKads1mnAQgSMMT+xdPCq
 c=
X-Received: by 2002:adf:fc50:0:b0:313:ecd3:7167 with SMTP id
 e16-20020adffc50000000b00313ecd37167mr2046770wrs.42.1690474230237; 
 Thu, 27 Jul 2023 09:10:30 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHiXuQvSBLMjqq5GTgX54bx5MsWKEATOGfoC6TQVr4zxAvrqcWHmpaUVpTwWbtGUhbXH5Uj9g==
X-Received: by 2002:adf:fc50:0:b0:313:ecd3:7167 with SMTP id
 e16-20020adffc50000000b00313ecd37167mr2046752wrs.42.1690474229816; 
 Thu, 27 Jul 2023 09:10:29 -0700 (PDT)
Received: from step1.redhat.com ([193.207.170.163])
 by smtp.gmail.com with ESMTPSA id
 w4-20020adfec44000000b00317614b6a5dsm2461681wrn.50.2023.07.27.09.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Jul 2023 09:10:28 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 0/4] block/blkio: fix opening virtio-blk drivers
Date: Thu, 27 Jul 2023 18:10:16 +0200
Message-ID: <20230727161020.84213-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=sgarzare@redhat.com;
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

There is a problem with virtio-blk-vhost-vdpa.
The first patch does some preparation changes. The second and third patches
fix the issues, the last patch tries to prepare QEMU for a future version of
libblkio where we can use blkio_set_fd() to check whether the property is
supported or not.

While testing, I realized that the main problem was that qemu_open() does not
support UDS, but still the problem with blkio_connect() which can fail remains.

v2:
- added first patch in preparation of the others
- reworked patch 2 retrying blkio_connect [Stefan]
- added patch 3 since qemu_open() fails in UDS
- changed patch 4 commit description [Stefan]

v1: https://lore.kernel.org/qemu-devel/20230724154611.178858-1-sgarzare@redhat.com/

Based on stefanha/block branch.

Stefano Garzarella (4):
  block/blkio: move blkio_connect() in the drivers functions
  block/blkio: retry blkio_connect() if it fails using `fd`
  block/blkio: fall back on using `path` when `fd` setting fails
  block/blkio: use blkio_set_int("fd") to check fd support

 block/blkio.c | 108 +++++++++++++++++++++++++++++++++++---------------
 1 file changed, 75 insertions(+), 33 deletions(-)

-- 
2.41.0


