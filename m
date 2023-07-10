Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3C274E1D6
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 01:07:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIzwk-0004Pk-IV; Mon, 10 Jul 2023 19:05:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwd-0003Z9-GC
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qIzwb-0004ru-AL
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 19:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689030324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CpelzGsd50X9x3Tst4WfltV5TKRJ5M8f+SltSoP+x1c=;
 b=T4NaMyARvIz1KmFUkN7neE12D5uK2mRCWVsvjBaN51/Og5JmCMmvqDEAZkeJNV8q3DR7hy
 kdpsd+xnBjtnWIYZE3M/ug9SEfydGjSwydUOEs0G3ejQydJnbs5JuKIZA/Ms+7Msl8wXRM
 MWPhgMvx9kiNWtnNiOr1mJ+r5IhjdUI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-5-CinlWnN1Mw69i1g43iUviw-1; Mon, 10 Jul 2023 19:05:23 -0400
X-MC-Unique: CinlWnN1Mw69i1g43iUviw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fc020021efso22651945e9.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 16:05:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689030322; x=1691622322;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CpelzGsd50X9x3Tst4WfltV5TKRJ5M8f+SltSoP+x1c=;
 b=ehZrqNIAnB1Q0eBm7EykzmBuKS0Z2HfceAsLoTlfsSHYGA/tuLKt7tj9fcglzlxyKW
 l7tGwQGOHAwEYbZpwtQHrp7fvsK+JYm+lQwJndAyg9JkIfh16CCgOvBYiPADmePC/ujV
 bIkPvQwnRTnXtxjdL47ZbLyAqawuFEsFIO1BlcvVLMgaaCnQranCcDnAmF0NGyp6W7Te
 z/bZs7DTH9ieH03orqluq7/0En+RDUn1qTuxjhwpBx2qddv/+EEzqANnfA55LcTYHWr+
 oT1ZH/VwzuM9Tgv+QLOavy8Css6mVDQyys4cqp8thTCjjbPNy5aGjdPQbPwMlhsMIc3X
 C5zQ==
X-Gm-Message-State: ABy/qLZXsZEhcYAej9jXut4g5Czcl4veg56vpLSStdVupf6hx9ufy4o2
 pKt8ETM+popxddgqRicC/aLansHW8Wzv3qWqapFDRA9g63IXk7RgFTzLpsiLC4fe5X+c9wZXacN
 LWvzneF24VrpZltLECgxk9p2KC4Jh/MrLoxFh3HjcBDSo5K4yHk8f8F1uZ9cqvgZcy1Oy
X-Received: by 2002:a7b:ce91:0:b0:3f8:f663:921d with SMTP id
 q17-20020a7bce91000000b003f8f663921dmr13511280wmj.41.1689030321824; 
 Mon, 10 Jul 2023 16:05:21 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFKS7kXBaVmFoFLcU9FRC/SXfBtolXr6LyEgezNL27uH32rsq9cuRZcS2H66M8Zn1/dHA43JQ==
X-Received: by 2002:a7b:ce91:0:b0:3f8:f663:921d with SMTP id
 q17-20020a7bce91000000b003f8f663921dmr13511265wmj.41.1689030321605; 
 Mon, 10 Jul 2023 16:05:21 -0700 (PDT)
Received: from redhat.com ([2.52.3.112]) by smtp.gmail.com with ESMTPSA id
 l20-20020a7bc354000000b003fbb8c7c799sm11470984wmj.30.2023.07.10.16.05.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 16:05:21 -0700 (PDT)
Date: Mon, 10 Jul 2023 19:05:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Hawkins Jiawei <yin31149@gmail.com>,
 Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>
Subject: [PULL 61/66] vhost: Fix false positive out-of-bounds
Message-ID: <b77a5f22aca4cef2dc893ea544841bdd95dc83ba.1689030052.git.mst@redhat.com>
References: <cover.1689030052.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1689030052.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
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

From: Hawkins Jiawei <yin31149@gmail.com>

QEMU uses vhost_svq_translate_addr() to translate addresses
between the QEMU's virtual address and the SVQ IOVA. In order
to validate this translation, QEMU checks whether the translated
range falls within the mapped range.

Yet the problem is that, the value of `needle_last`, which is calculated
by `needle.translated_addr + iovec[i].iov_len`, should represent the
exclusive boundary of the translated range, rather than the last
inclusive addresses of the range. Consequently, QEMU fails the check
when the translated range matches the size of the mapped range.

This patch solves this problem by fixing the `needle_last` value to
the last inclusive address of the translated range.

Note that this bug cannot be triggered at the moment, because QEMU
is unable to translate such a big range due to the truncation of
the CVQ command in vhost_vdpa_net_handle_ctrl_avail().

Fixes: 34e3c94eda ("vdpa: Add custom IOTLB translations to SVQ")
Signed-off-by: Hawkins Jiawei <yin31149@gmail.com>
Message-Id: <ee31c5420ffc8e6a29705ddd30badb814ddbae1d.1688743107.git.yin31149@gmail.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 hw/virtio/vhost-shadow-virtqueue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/virtio/vhost-shadow-virtqueue.c b/hw/virtio/vhost-shadow-virtqueue.c
index 1b1d85306c..49e5aed931 100644
--- a/hw/virtio/vhost-shadow-virtqueue.c
+++ b/hw/virtio/vhost-shadow-virtqueue.c
@@ -111,7 +111,7 @@ static bool vhost_svq_translate_addr(const VhostShadowVirtqueue *svq,
         addrs[i] = map->iova + off;
 
         needle_last = int128_add(int128_make64(needle.translated_addr),
-                                 int128_make64(iovec[i].iov_len));
+                                 int128_makes64(iovec[i].iov_len - 1));
         map_last = int128_make64(map->translated_addr + map->size);
         if (unlikely(int128_gt(needle_last, map_last))) {
             qemu_log_mask(LOG_GUEST_ERROR,
-- 
MST


