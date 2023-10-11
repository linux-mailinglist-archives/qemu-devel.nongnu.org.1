Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F4B67C509F
	for <lists+qemu-devel@lfdr.de>; Wed, 11 Oct 2023 12:54:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqWr2-0007aZ-Hb; Wed, 11 Oct 2023 06:54:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqWqp-0007SI-Ae
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:54:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qqWql-0001nh-VJ
 for qemu-devel@nongnu.org; Wed, 11 Oct 2023 06:54:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697021638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=rK8ohOgszENEuj8d+LnSBOk0B0+jpO1xDeAu5aXQouE=;
 b=LBUCSkOztNY3b+PQ8x1vnM4B5i0kMsf3GYvQrGFxdviD5dLFpLiHSod03JyV5LqIHkoDNF
 DNBXQSqon6FFm2fzpaRHwHx5H9Qizg/L2lYip1kS1dq8A+RqVjWOwpKyyCGQPvtcqX5nZ7
 a+84Whsh/Em6WklmZDLA+jqZ9e6FzCs=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-lA4hAcyOPWySDPZqDulp5w-1; Wed, 11 Oct 2023 06:53:56 -0400
X-MC-Unique: lA4hAcyOPWySDPZqDulp5w-1
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-1c9c92c4aaeso8303805ad.1
 for <qemu-devel@nongnu.org>; Wed, 11 Oct 2023 03:53:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697021636; x=1697626436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rK8ohOgszENEuj8d+LnSBOk0B0+jpO1xDeAu5aXQouE=;
 b=p5461f5Jaj18V7CdDnNe0e6erfBbYKhRjmxRPxlumDMt5LtrObYAf0oR9zDnQL/ZhU
 O/HW5tI9C+d14o2nhXaWOT982l81UUB/hU8BHtKyM8tbuErQjbmBGUoi8hdfGEmEXSVx
 4HB4t0bm82NGY0hUJIgpwk6ofK+01WL/Un4JV4gfON7W3Oq7FsHsVYGH9SDbVct7gnv8
 OFrUlRLTcITWfRks0cMxRYJbdIJc5JXwgzjdB8Ip/AE6/9vkWeXcCFyHf1lfbWFM8sVt
 Cl/27rcJDxWU00QlzoTmR2C1dGD4ui81fGOud8g4u8X0pBkC0h14UmdGyk2MyYR+Vwdz
 xZLQ==
X-Gm-Message-State: AOJu0YwNztq2ShgtAiWHyXcl0SWqYyV8fkEleKhnobUZ1lTN5UdB2vI7
 0+788rOfghSOqlwui8p7NNaNu4RL2GGDf6zrbtGX8pKXQX8DEysNRn+oO4iUuXa0sNueBOfn+XK
 5nHnYEuqL10xrAok=
X-Received: by 2002:a17:902:e743:b0:1c8:a132:a00f with SMTP id
 p3-20020a170902e74300b001c8a132a00fmr11112060plf.12.1697021635825; 
 Wed, 11 Oct 2023 03:53:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr/+6+p7thmNNnXVRGVvd56RHX6pSmHnFYvJSMDWPk7jszmi/QsQcFOo2MsyVeweVshLPHdQ==
X-Received: by 2002:a17:902:e743:b0:1c8:a132:a00f with SMTP id
 p3-20020a170902e74300b001c8a132a00fmr11112038plf.12.1697021635449; 
 Wed, 11 Oct 2023 03:53:55 -0700 (PDT)
Received: from localhost.localdomain ([27.6.218.160])
 by smtp.googlemail.com with ESMTPSA id
 j6-20020a170902c3c600b001c7453fae33sm13522567plj.280.2023.10.11.03.53.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 03:53:54 -0700 (PDT)
From: Ani Sinha <anisinha@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: Ani Sinha <anisinha@redhat.com>,
	qemu-devel@nongnu.org
Subject: [PATCH] hw/i386/cxl: ensure maxram is greater than ram size for
 calculating cxl range
Date: Wed, 11 Oct 2023 16:23:35 +0530
Message-ID: <20231011105335.42296-1-anisinha@redhat.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

pc_get_device_memory_range() finds the device memory size by calculating the
difference between maxram and ram sizes. This calculation makes sense only when
maxram is greater than the ram size. Make sure we check for that before calling
pc_get_device_memory_range().

Signed-off-by: Ani Sinha <anisinha@redhat.com>
---
 hw/i386/pc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index f72e2c3b35..948c58171c 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -820,10 +820,12 @@ static void pc_get_device_memory_range(PCMachineState *pcms,
 static uint64_t pc_get_cxl_range_start(PCMachineState *pcms)
 {
     PCMachineClass *pcmc = PC_MACHINE_GET_CLASS(pcms);
+    MachineState *ms = MACHINE(pcms);
     hwaddr cxl_base;
     ram_addr_t size;
 
-    if (pcmc->has_reserved_memory) {
+    if (pcmc->has_reserved_memory &&
+        (ms->ram_size < ms->maxram_size)) {
         pc_get_device_memory_range(pcms, &cxl_base, &size);
         cxl_base += size;
     } else {
-- 
2.42.0


