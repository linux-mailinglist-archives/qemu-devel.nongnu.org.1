Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EDDFB75FB1D
	for <lists+qemu-devel@lfdr.de>; Mon, 24 Jul 2023 17:47:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qNxlS-00065j-A8; Mon, 24 Jul 2023 11:46:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qNxlQ-00065b-BI
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:46:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sgarzare@redhat.com>)
 id 1qNxlO-0007fP-Hq
 for qemu-devel@nongnu.org; Mon, 24 Jul 2023 11:46:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690213580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=I5XhTEKat0JQCqpAX1P+Ujyg5PWWa2c4e2kQmhE0Smg=;
 b=N28Z7rVPlW6OU1WxFR0t9JrMx93e6Bb3FtoyoxnfECpmX2WRDNB2ADDF6jRW1731WYHFwr
 UdEAM+UnyOXGJal2EPeBD9iHzAHzTGU9exx1seww2dNQYdhvySD8mgJX4aRf5wPZ4coPMT
 J0j70fS61RGBxorufichWKk/HWjVxOw=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-MsN_FFqMPFm4K2V-7OiWcg-1; Mon, 24 Jul 2023 11:46:19 -0400
X-MC-Unique: MsN_FFqMPFm4K2V-7OiWcg-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4055c2b8870so25125231cf.2
 for <qemu-devel@nongnu.org>; Mon, 24 Jul 2023 08:46:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690213578; x=1690818378;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I5XhTEKat0JQCqpAX1P+Ujyg5PWWa2c4e2kQmhE0Smg=;
 b=EDVs0C3o1XmlVLpB5CvOZGZK0nq5LCf6dteMJCilnVDgOhEYae4SoyWZuSAJGZY6Oz
 wR2JwNtRrAq2SY4Mfgdak+8Y5igsOLwTTFs0qD1WKNcyxILjlRvfxVF8G4l0WvRq8/9R
 122utg4JfqO5C7cz6QCESdQGzglDJHn2ZAsZ5JwaHWgn4l54fZEAPfQ6IyRUdVf44h0d
 7DcMkm2Io3yO1D5PFQ3atY3EZJL0SKc7QA1OjiBZdkq7ymCcTghFbrNz5r+lVKJJKhVW
 OKm/32Cfkoj+TtNVzre72uTdBLtvdGm4pMqZz0TIC56snFqhNFy93ODWlFPIJv15apsP
 JUmg==
X-Gm-Message-State: ABy/qLYpvDHGfr+RytPyG/EhAdqSocJlP02rYyQ7g4Mv92v+ytRFRyga
 EQYvKWGgoEQy1c1ItJlB2U+LJcED32obTgMsfCeKnEER+038Luv2Fm1A2cHAdSBUEnzYciOVHkI
 MJlIBvZGF1AIsSTdQ2l8CwhUHXsKaf6bLohujw/OlFl+Zon5xgZMqHTJPTrs8dF6e8gACxKW/Km
 4=
X-Received: by 2002:ac8:7dc4:0:b0:405:433f:3aeb with SMTP id
 c4-20020ac87dc4000000b00405433f3aebmr149174qte.34.1690213578568; 
 Mon, 24 Jul 2023 08:46:18 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGPcxTv5Pq9AhOkVWYn7d69kwSPR4I4iBOHlm/vNhRRHP+qKbVTAEAYMWEDuXxbPnDR3Yt0Yw==
X-Received: by 2002:ac8:7dc4:0:b0:405:433f:3aeb with SMTP id
 c4-20020ac87dc4000000b00405433f3aebmr149155qte.34.1690213578275; 
 Mon, 24 Jul 2023 08:46:18 -0700 (PDT)
Received: from step1.redhat.com ([5.77.105.74])
 by smtp.gmail.com with ESMTPSA id
 z8-20020ac84308000000b0040321ca109fsm3414232qtm.96.2023.07.24.08.46.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jul 2023 08:46:17 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH 0/2] block/blkio: fix opening virtio-blk drivers
Date: Mon, 24 Jul 2023 17:46:09 +0200
Message-ID: <20230724154611.178858-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.41.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sgarzare@redhat.com;
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

There is a problem with virtio-blk-vhost-vdpa. The first patch
fixes the issue, the second patch tries to prepare QEMU for a
future version of libblkio where we can use blkio_set_fd() to
check whether the property is supported or not.

Stefano Garzarella (2):
  block/blkio: fix opening virtio-blk drivers
  block/blkio: use blkio_set_int("fd") to check fd support

 block/blkio.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

-- 
2.41.0


