Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D1827C80EA
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:54:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDpo-0007Ub-Hm; Fri, 13 Oct 2023 04:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpT-0007H7-1b
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:31 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDpR-0000ln-2k
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:47:30 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-32d8c2c6dfdso1801649f8f.1
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:47:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697186846; x=1697791646; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j6411C84hzCso6efgdlF1FtGvgMuI+MuD4W1Tr+vAms=;
 b=U8MFTqGocE8U7281JjVIrFbwEJ48AS5dysvqQPyi12cdumtIs52pqoKP3S6ed72Fwq
 hAA/5WpqMSprL5Wly+D+sOO00jwmBHtIakQOTrFQW7U2+UuryZJ8UwH83G8w/x6L/XX4
 UgUhKM0IPISJ/Wvh13tkY1K06GepbOlcKAekmBQL0j3ZvDYvzHHPDInwR0rhO8jESdNq
 nMaVMbqs4R0ljX9v42y8ArhyaA6mGrHR2/6IW80Bxg2ei7L+fOBlozPH/jLYpcCZonk9
 Y1eg+8GHj2omEigkqh1Kxq2WKKy+14JK0Fp+MCKRRcDS6UvaR9NqI4eQZdU4BrCnlim+
 X8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697186846; x=1697791646;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j6411C84hzCso6efgdlF1FtGvgMuI+MuD4W1Tr+vAms=;
 b=Zv2Je+KWIW7LPnG4UXw6PT/4w75nKnjywN+jU5gcbeci9+2z6BBs9l04MhrHIQWG57
 sEZbRToRmGk2LsGHHkkaFAeUJKC+sRwMxWXgPh3JU9356d+GAoft61oMXl9MgveSuX7K
 9rhvuIILn7CRb5tzy9ff/AwDho5ukZMaWlBTsqo3hLaDn4ia0zNkfaae5sJ8GzVWdbgJ
 b13xNNlkVF84orMLwudySbDj2qhYCqdQ2rP2DD517ZcZHQ7f9hpYaLuL2pAH9mVKk8So
 0Gs1GNuI1EBI5Zq/3NJwMREc7QU1buMGxB85Hc5174I1qATSb7PQfvShJU0Gn1idxhDX
 MGCg==
X-Gm-Message-State: AOJu0YwfqDrhHAx9zIFG06CZqZQqp45kSbLabKc63NeehzZ8sPpP4ASh
 boOjrnkjPDzqyhwU7qhHkghbvyc5+boZb8Kuvu4=
X-Google-Smtp-Source: AGHT+IFZbicYzoiCc0Nzc3MFABaq3kLZu5iuXKNF5951ReVs0qyCs4wwhRgVX9VYt3R0wnkiOneOnw==
X-Received: by 2002:a5d:6681:0:b0:319:72f8:7249 with SMTP id
 l1-20020a5d6681000000b0031972f87249mr21189813wru.66.1697186845926; 
 Fri, 13 Oct 2023 01:47:25 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.47.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:47:25 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Subject: [RFC PATCH v3 07/78] hw/virtio/virtio-balloon.c: add fallthrough
 pseudo-keyword
Date: Fri, 13 Oct 2023 11:45:35 +0300
Message-Id: <cbaaabeb326d8868c7fc7403693af9778123c9ae.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 hw/virtio/virtio-balloon.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/virtio/virtio-balloon.c b/hw/virtio/virtio-balloon.c
index d004cf29d2..0f0d94bd94 100644
--- a/hw/virtio/virtio-balloon.c
+++ b/hw/virtio/virtio-balloon.c
@@ -673,6 +673,7 @@ virtio_balloon_free_page_hint_notify(NotifierWithReturn *n, void *data)
          * Set S_DONE before migrating the vmstate, so the guest will reuse
          * all hinted pages once running on the destination. Fall through.
          */
+        fallthrough;
     case PRECOPY_NOTIFY_CLEANUP:
         /*
          * Especially, if something goes wrong during precopy or if migration
-- 
2.39.2


