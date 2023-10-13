Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 92C9F7C7F03
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 09:53:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrCw5-0004Kh-3u; Fri, 13 Oct 2023 03:50:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCw2-0004Jt-KR
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:14 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrCvx-00047R-D1
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 03:50:14 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-32d3755214dso1743125f8f.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 00:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697183400; x=1697788200; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KtdJELuGCqaz6k9Vi6yvdb+Hy9MnEYqnd5uLlh799bE=;
 b=pGCRRdIvFtks2OP68Ivj+4q/H4EgNbHhO3R4m+yw4HzPCPJNSSDfPYePs9sqm7tSs0
 VslbYY7GKZQaUJiGCYGhupmPZWotzLURuxZl4gf5z3u0QFTWO0TYLHxmNRKo3+oCwC5C
 eNDw2Ukym76uwmGW+FJ/9zZjc0uaPswaqBsjN7DRS8S7rL58ejPqJyQeNZJci6bhx0y2
 mKVU5z41dtsFaHvt6r6ZaZwDIiDVfJFpng3fFWUxG1Gg9gorfMcJc3CkhnR58jNNxfNN
 hgj9O1TNPRSU+QrELgDinG/iZz9/zRRHQm04lwKevYLtZW7scQ74vhvmu6wAQcgclTIn
 4wBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697183400; x=1697788200;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=KtdJELuGCqaz6k9Vi6yvdb+Hy9MnEYqnd5uLlh799bE=;
 b=Ifkz14isZl5mjj4OoBA4O4VoWtCHM32tMvnHAUm52ui7Ex4rXM4kCcT9Ima6oaJqnS
 he7v7BkR1SZ+Qjy5zZExB0DyLC0nKGK7Y65RWYZJxfN3NcgAQydZl4P13Lwnt/6wVQm2
 tf03+C3CLWKErtKMEvle9tmy6aqzxver3NSve8o9RV78ABZVRpf28y6MZsaaQBOiM2Rn
 0Tg3ZbrfF9G2PDmwCsn8deYl9WIr77R6IpAZT6dEDJZU/gATUczAhW4jQgJRVpm9HD66
 LTEqNm2LTkQiNvwYyeCt7URn14FK7xUuFb4TAbg+b75YlhVgVCGm0tv7RIFwqKQ7x8MB
 8Mig==
X-Gm-Message-State: AOJu0Yy7ev4mNFwtg1aauHmO1n8oIZXxBuR3QxVe8g2dKudMYmGjm6oV
 C6Dl+XU1YPmNC4x8h383fm+kxsf2YXCAlD5zve0=
X-Google-Smtp-Source: AGHT+IET0HvyD6sCeHO46tAY6b9w/YNZYqzvUtTO/6oT8HFbQnNTNYt6WW66tv5etfDqm6vCj107Aw==
X-Received: by 2002:adf:f68f:0:b0:317:f714:3be6 with SMTP id
 v15-20020adff68f000000b00317f7143be6mr20483928wrp.61.1697183399753; 
 Fri, 13 Oct 2023 00:49:59 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 m8-20020adfa3c8000000b0032d7fde2d3csm7990663wrb.79.2023.10.13.00.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 00:49:59 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-arm@nongnu.org,
	qemu-block@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>
Subject: [RFC PATCH 07/78] hw/virtio/virtio-balloon.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 10:47:11 +0300
Message-Id: <40e39148a03476f886d37500e4104fad64107d63.1697183082.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
References: <cover.1697183081.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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


