Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 71BF67A7558
	for <lists+qemu-devel@lfdr.de>; Wed, 20 Sep 2023 10:07:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qisEV-0005ds-EO; Wed, 20 Sep 2023 04:06:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qisET-0005cb-B6
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:06:49 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qisER-0002pz-O5
 for qemu-devel@nongnu.org; Wed, 20 Sep 2023 04:06:49 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-59be6605e1dso70750977b3.3
 for <qemu-devel@nongnu.org>; Wed, 20 Sep 2023 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1695197206; x=1695802006;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VRT2ifSiyxkep05tvhCKGJzMwggYcgdJ7ZMgq7QI+ZE=;
 b=A4xvtCwH5BMQY7pH8aMC+Eb4ET2V+Eg7sqPSX1P+h9mqzuuLRY8jqVYRlri52eZW+Y
 zsn5NVjSgTSFgcJzaj2CI4lAWBSTjTOXbriJ0UYrvl3kNBwc6+elAkW+JItmT4AYnRES
 oXG4tbIdcC/o1VbbXZbJfBvthgFOPblG3fDadhD2uOyPRAju0H2uIk3CbyhXBkdMSpOy
 LEHsMNdBT5U936/kqE8GCn8snM8DjYToMXjyGY7I3SrYT/94ziDX4fnqs2TYScEFAsnC
 vyZ+4SktIDzZAb02xqAIi20WyH936A7lmaKNnledvfCD6aC5mYHAKh3LKuUbdtFG3SEv
 KSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695197206; x=1695802006;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VRT2ifSiyxkep05tvhCKGJzMwggYcgdJ7ZMgq7QI+ZE=;
 b=saILFNKzEXVl4O1Jqc1IgLaVSm/nI45ZxMqSwz7vG0RgajXzDbK8toDviCxqT1JJSf
 gALW6wEmw29iCh+sZgIU5TN2ctEckyO3yzNbPkmtBQLjNptNhEX5JwFdQddpyMYz1KAh
 JAq4vppSYg0qDzU4qpu/VDqry5plK1HUnFyxdDA+ehHlGbipDjuSSngHjuBwub1RPqPN
 Nm/egqKA/rLqx9KTF48zGb/s9L4UZqHfriK7AJ6n5CKyN9u+TiomHgoOXZ5WrZzXS0n9
 cADHgXABZEhwoeKx1zmkMmuj1sDd79cihaUFsVtemNoBOM5051wJbgL7etG1HLIpi4iK
 oOmw==
X-Gm-Message-State: AOJu0Yybo2CrCGQtqSdfSXBeZUm9rh6sMD+T7rHU5/Gj6PgwW9LSmHKF
 65eLI4EYJmk5RINSeGp95UDzd8TVxD9kwt/JbL6GUg==
X-Google-Smtp-Source: AGHT+IEtHrF4WWw3x8TE9HM2uauRb5dCJD8hc5mRQtDDKDyd+Fbl7MTVsXOkJCR33P5zUBwUbuUHJA==
X-Received: by 2002:a0d:cac8:0:b0:583:f02e:b92c with SMTP id
 m191-20020a0dcac8000000b00583f02eb92cmr1614019ywd.17.1695197206539; 
 Wed, 20 Sep 2023 01:06:46 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 a16-20020aa78650000000b006862b2a6b0dsm2378596pfo.15.2023.09.20.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 01:06:46 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, peterx@redhat.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, stefanha@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v5 5/5] vfio-user: Fix config space access byte order
Date: Wed, 20 Sep 2023 01:06:22 -0700
Message-Id: <20230920080622.3600226-6-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920080622.3600226-1-mnissler@rivosinc.com>
References: <20230920080622.3600226-1-mnissler@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=mnissler@rivosinc.com; helo=mail-yw1-x1131.google.com
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


