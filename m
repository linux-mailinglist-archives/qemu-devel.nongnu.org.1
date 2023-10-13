Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2897C7F54
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:04:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrD3x-0008Hm-FI; Fri, 13 Oct 2023 03:58:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3v-0008Da-Qp
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:23 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrD3k-0006kh-N4
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:58:23 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-405361bba99so18252665e9.2
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:58:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183890; x=1697788690; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtdJELuGCqaz6k9Vi6yvdb+Hy9MnEYqnd5uLlh799bE=;
 b=Vimehvkzmr9QGcvvvPY60jdR4NnoXUICxNIL42VlvlNAJxm8jAi2fZhQNwSjWGE5R4
 ljGlS7dG0FnmMV9n2v/Bv+sEKzBsOCLSm1J8woZyjERzD4MEcl6ZIHQAcEGDTnPmWWuP
 xzSayA6iPuT6bDg1fE1AHgJ3KqIaCpBT9hA9IQe3L2yHBqdzlgLVliFNPqnlQRUSO1H2
 VTAljXFxPx8I4680PJssQ4OFHOk9maOkUHDbge/rR9o/z93jUsivwskQcjpR9OgWfAQW
 rVYORXGjV1QqyMjxJB32HHHjUnlok5060VOp0Yf3Z5PpzDgEhkUMjF4I6AC/eqZY+Tko
 IX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183890; x=1697788690;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtdJELuGCqaz6k9Vi6yvdb+Hy9MnEYqnd5uLlh799bE=;
 b=TQbxw967AlTpzEUQQnGJqjL9JX0PNHW+wNsF5SNVj2fu+AgV73utpre/mM3O0i4eJn
 9MjmceHoi6Jyw6G2nBUHJBoeJet8TE7aCEu02qWxbPGdUfiPqGOfEtfL5XG7gfLHVa7z
 1ebX/YcC1dLi4Uo5qb0IQXBmV2Zl4v1vK94vHR+QCoG65PCNB4VNA8ZjUqgL56VEA+cT
 ssSiHi3XQ3br4J+xZE1/HMRHrIisXxgbBd2WmaBD+/lKH1JizSlRS4vHcT8tGrPueDEJ
 qbB87jo3P0rJ1v71kNej6vmeDMtTkpHDFh9wInsmrobFUv/v+j5ph2HG7zqQ+2gM8t1I
 ZMUw==
X-Gm-Message-State: AOJu0Yx0TBCd418x60whhTE36q5NN/F7aNq/q3z7GUNSKgFGlc2/uV3g
 xSoafBibmYhuIa81zFW+uRtZY1jUxc/mS7JcWvg=
X-Google-Smtp-Source: AGHT+IHdKmRv5dkITpwFwdKa9tzJZQVXFBqxxbg+VFRbbXkwspfip4PH4517UWtjbv5I6oyXl7DALQ==
X-Received: by 2002:a7b:c419:0:b0:3fe:d630:f568 with SMTP id
 k25-20020a7bc419000000b003fed630f568mr22450024wmi.39.1697183890700; 
 Fri, 13 Oct 2023 00:58:10 -0700 (PDT)
Received: from localhost.localdomain (adsl-26.37.6.0.tellas.gr. [37.6.0.26])
 by smtp.gmail.com with ESMTPSA id
 a10-20020a05600c224a00b003fe23b10fdfsm1798183wmm.36.2023.10.13.00.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:58:09 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH v2 07/78] hw/virtio/virtio-balloon.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:56:34 +0300
Message-Id: <40e39148a03476f886d37500e4104fad64107d63.1697183699.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183699.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x329.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

In preparation of raising -Wimplicit-fallthrough to 5, replace all
fall-through comments with the fallthrough attribute pseudo-keyword.

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d004cf29d2..0f0d94bd94 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -636,56 +636,57 @@ static int
 virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
 {
     VirtIOBalloon *dev = container_of(n, VirtIOBalloon, free_page_hint_notify);
     VirtIODevice *vdev = VIRTIO_DEVICE(dev);
     PrecopyNotifyData *pnd = data;
 
     if (!virtio_balloon_free_page_support(dev)) {
         /*
          * This is an optimization provided to migration, so just return 0 to
          * have the normal migration process not affected when this feature is
          * not supported.
          */
         return 0;
     }
 
     /*
      * Pages hinted via qemu_guest_free_page_hint() are cleared from the dirty
      * bitmap and will not get migrated, especially also not when the postcopy
      * destination starts using them and requests migration from the source; the
      * faulting thread will stall until postcopy migration finishes and
      * all threads are woken up. Let's not start free page hinting if postcopy
      * is possible.
      */
     if (migrate_postcopy_ram()) {
         return 0;
     }
 
     switch (pnd->reason) {
     case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
         virtio_balloon_free_page_stop(dev);
         break;
     case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
         if (vdev->vm_running) {
             virtio_balloon_free_page_start(dev);
             break;
         }
         /*
          * Set S_DONE before migrating the vmstate, so the guest will reuse
          * all hinted pages once running on the destination. Fall through.
          */
+        fallthrough;
     case PRECOPY_NOTIFY_CLEANUP:
         /*
          * Especially, if something goes wrong during precopy or if migration
          * is canceled, we have to properly communicate S_DONE to the VM.
          */
         virtio_balloon_free_page_done(dev);
         break;
     case PRECOPY_NOTIFY_SETUP:
     case PRECOPY_NOTIFY_COMPLETE:
         break;
     default:
         virtio_error(vdev, "%s: %d reason unknown", __func__, pnd->reason);
     }
 
     return 0;
 }
-- 
2.39.2


