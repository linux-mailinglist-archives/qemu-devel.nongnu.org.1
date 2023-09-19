Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F0487A689B
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Sep 2023 18:09:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qidHT-0001p6-G1; Tue, 19 Sep 2023 12:08:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHO-0001nY-My
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:51 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qidHM-0004hf-V9
 for qemu-devel@nongnu.org; Tue, 19 Sep 2023 12:08:50 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso46170715ad.3
 for <qemu-devel@nongnu.org>; Tue, 19 Sep 2023 09:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695139726; x=1695744526;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRT2ifSiyxkep05tvhCKGJzMwggYcgdJ7ZMgq7QI+ZE=;
 b=PF7sQjctIrynWSKWCdfg4m+CvXMQNf356/WYCqEPgqrtQcnqdrIWe/oPQRuqwOmxZ8
 aB83BuxULfrSWlKE+ZuE5t8RUOz12aH1ZEi1J0AK1bx/SadQf5BlGAgu+yxU3CHK8JZU
 bGkC8VKGT9V+qb1QfmUWr6iBLEKbADXkAYz+LUIXOUv2WDHscbcwumeQJw7Dt/KN4aHT
 HomNMGMqSQiKjXo99VaXM8IIK5cnVSGI+cNN+0v1lsokOBi+ksbeu5MGEd6d/Ft0qYyo
 fhUNZAw9WWHaIR4KM5XTUTNHy44jzVPajavfdFcC4CQ2mYTCxU0wzXRw7TzLnqf0aF4p
 tHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695139726; x=1695744526;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRT2ifSiyxkep05tvhCKGJzMwggYcgdJ7ZMgq7QI+ZE=;
 b=qsfAzsmrudlDT5FF6+HjytEsGIlttxowqsDFM+77ukFV11qtx+wRTpaU1hTthl8qOQ
 JK0mXHPk3kbk2+kcxxisFlZ6GZ2cRUZnILQGDfJ/MzrudiiJJucFyLLDwC4HSu6ENgK/
 V+2ymttFEa+6b46HRXPrygZEw4LqIjzGsj9Oj4wH8J2hBTeCFbQpR+a6kmuBGXLN8RRe
 t2vUHaOJhSWReOGcs1YRvz5m9OuctpR1Wt7v7UKyVyAfediY+sMrQq9B80doT+rWFOVF
 V2Y8PMxlafnCoq31GyIEI6xf/rbMg37dIQlBbuwVlPpNibZYH3vrf9dDKL0GqiyF+K0g
 1f5g==
X-Gm-Message-State: AOJu0YxJZI04Gnsa/CJXa0prB44vuJRdomG9fVdh6GxTezXcxZuIl1pi
 E6MmP11kHCgpzX0SHo0kp2uosTH0+K/HMeIY24xZGg==
X-Google-Smtp-Source: AGHT+IHYawBtyKq1aclH6J9xdKjkxTX+VN46y8E93SDILIVSj6fwGO3pG9CSG0Lu6qZc/yaEgM6YjA==
X-Received: by 2002:a17:902:ea09:b0:1c3:29c4:c4e4 with SMTP id
 s9-20020a170902ea0900b001c329c4c4e4mr13423483plg.36.1695139726555; 
 Tue, 19 Sep 2023 09:08:46 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 l9-20020a170902d34900b001b8a1a25e6asm8086308plk.128.2023.09.19.09.08.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Sep 2023 09:08:46 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, stefanha@redhat.com,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>, Peter Xu <peterx@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v4 5/5] vfio-user: Fix config space access byte order
Date: Tue, 19 Sep 2023 09:08:13 -0700
Message-Id: <20230919160814.3343727-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230919160814.3343727-1-mnissler@rivosinc.com>
References: <20230919160814.3343727-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

PCI config space is little-endian, so on a big-endian host we need to
perform byte swaps for values as they are passed to and received from
the generic PCI config space access machinery.

Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
---
 hw/remote/vfio-user-obj.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
index 6a561f7969..6043a91b11 100644
--- a/hw/remote/vfio-user-obj.c
+++ b/hw/remote/vfio-user-obj.c
@@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
     while (bytes > 0) {
         len = (bytes > pci_access_width) ? pci_access_width : bytes;
         if (is_write) {
-            memcpy(&val, ptr, len);
+            val = ldn_le_p(ptr, len);
             pci_host_config_write_common(o->pci_dev, offset,
                                          pci_config_size(o->pci_dev),
                                          val, len);
@@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
         } else {
             val = pci_host_config_read_common(o->pci_dev, offset,
                                               pci_config_size(o->pci_dev), len);
-            memcpy(ptr, &val, len);
+            stn_le_p(ptr, len, val);
             trace_vfu_cfg_read(offset, val);
         }
         offset += len;
-- 
2.34.1


