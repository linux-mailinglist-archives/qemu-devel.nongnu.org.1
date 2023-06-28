Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C7974103B
	for <lists+qemu-devel@lfdr.de>; Wed, 28 Jun 2023 13:42:33 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qETYL-0006Pi-MT; Wed, 28 Jun 2023 07:41:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETYJ-0006P8-W3
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:41:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qETYI-0000ZX-EI
 for qemu-devel@nongnu.org; Wed, 28 Jun 2023 07:41:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687952497;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=bVe0AXR/IrR5T+jZWXBtQ32QBZJysMyjmWEbEwEpiV0=;
 b=fMMAgWKYkvO8twgm56mDixYfquialkpqIG2vGOpOjeQv2LBMmFcG9GFgLasAwH7/OUYe1D
 OiLAb5OXbBSbBeZKngmM22w4wfNmSrGuAf+rRLTpdouBrwfhfVCRHPScEEdjRm47vDF3gN
 zrS6Rj24kHZznq/rEZpbqXXWKVu6hgQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-qTph24RbNLiw1kkHqq3C_A-1; Wed, 28 Jun 2023 07:41:36 -0400
X-MC-Unique: qTph24RbNLiw1kkHqq3C_A-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4fb89482cd6so1428966e87.1
 for <qemu-devel@nongnu.org>; Wed, 28 Jun 2023 04:41:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687952494; x=1690544494;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bVe0AXR/IrR5T+jZWXBtQ32QBZJysMyjmWEbEwEpiV0=;
 b=VWpC4Z32rfatxzriwBwp4u44dAAcuEOyl4nLt9p1wveQkPiUqEoP/02Fka505AfL9p
 CpSCIb1lds2JZEDAnaH4nmhzFHlUpEdE7OBbuIjsy3vdtuvjzU+4anTu6MNM3oDtAibR
 j7WCoLvdenapwCP178Kuyaf+fmRcMq6m5R+TUxgKK2zu2g6Qcmc3fQUpblg520rub7hg
 s5Ojc8vZ5jB0QAJopSCsYVDqNLHHsGhjOWxNgT+SHvgVRj+H84Cus3x1KkLbJIMJIgGO
 CWGAlgdRbxyBzWTFVzW32SAuD6kxrQFhpXVcaKUFL6L/8NvNgJPNco2ocQ+WWZNnqOQh
 Krpw==
X-Gm-Message-State: AC+VfDxwgtCE/DOZbWJNgZ9mzuLoMbGazNnIVVYq4cdUKyWXU4fmeZjF
 eVvpyvDst31pdTnmqxnqfcxhPpwr8y6FmTEFyT3RUhaSENKDdj8Xb1JBaapGnEwEdv4+xnUjXL7
 Y8N1nwLs+wni4fUPuo4Mne2IMPTphHi5lrhTg6KskrVJ1IeFYFoanX78V0sq6EngKn8SaovQ=
X-Received: by 2002:a19:915d:0:b0:4f6:1805:6095 with SMTP id
 y29-20020a19915d000000b004f618056095mr21963191lfj.8.1687952494118; 
 Wed, 28 Jun 2023 04:41:34 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7MTUIlfPDgo+G2EDr6DyKf9UrIVTymWdFuB9OCcMnpN5MHNEqPTACr4YkzE9xa+hVUVSzSmQ==
X-Received: by 2002:a19:915d:0:b0:4f6:1805:6095 with SMTP id
 y29-20020a19915d000000b004f618056095mr21963179lfj.8.1687952493748; 
 Wed, 28 Jun 2023 04:41:33 -0700 (PDT)
Received: from redhat.com ([176.12.183.225]) by smtp.gmail.com with ESMTPSA id
 r11-20020adfce8b000000b00313f3c11512sm7725753wrn.89.2023.06.28.04.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jun 2023 04:41:33 -0700 (PDT)
Date: Wed, 28 Jun 2023 07:41:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/1] virtio: regression fix
Message-ID: <cover.1687952477.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit a0d7215e339b61c7d7a7b3fcf754954d80d93eb8:

  vhost-vdpa: do not cleanup the vdpa/vhost-net structures if peer nic is present (2023-06-26 09:50:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 0585e97f070014265e5ec3b28d27dcb963cde25b:

  net/vhost-net: do not assert on null pointer return from tap_get_vhost_net() (2023-06-28 07:38:59 -0400)

----------------------------------------------------------------
virtio: regression fix

A regression was introduced in the last pull request. Fix it up.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Ani Sinha (1):
      net/vhost-net: do not assert on null pointer return from tap_get_vhost_net()

 hw/net/vhost_net.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)


