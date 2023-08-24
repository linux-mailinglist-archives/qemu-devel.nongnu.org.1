Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E61F778646F
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 03:05:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYykQ-0000R6-0f; Wed, 23 Aug 2023 21:02:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykK-00007l-Bl
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:48 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qYykI-0000R7-2g
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 21:02:48 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-68bec3a81c4so300501b3a.1
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 18:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692838965; x=1693443765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/J3OwiFqVwoYplEY/vkfNER1ejXeddYX7iHD/HQTT+U=;
 b=UM4HUJzDeqK7nHD1k2rsWAc5JcXBllrpi43v/zcPlh7ajB6pfca6tfwpi4OafMUGVc
 ucpxPCbY8IaMybuNjgRSWlwAf0D560OxmCLNaKMDb7nyz2d2X1Luzpo5LwETSFvJCoZP
 AHZAlfngqATCQ4OjrMtCiID3STiwHlfKsd1t892xzQ+d7923M4cbjJM/Q2hqWkmxTMMt
 fH1or/V1Ybwh9vmgvMPBxbAg+02ePM9ILEFR1nEDm4NQiI8yJHKKzeOGAdDcHUJhxDnU
 JwZC6Sl54ok7F4H+4qLzHk72s5qUf83PqSw4F6x01KzN4f87UYVo5vLyJ27Ov+rhh1h+
 1isQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692838965; x=1693443765;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/J3OwiFqVwoYplEY/vkfNER1ejXeddYX7iHD/HQTT+U=;
 b=lip8C66lucWBaoITc7TJ03oz7MRO9zTalq3M16rwGDtOS56d3h0VI7wIogOy2F4Sec
 YQSUqIeu5g89vP4sZNesEoIFNSXz53ehnH/7hO98RY2anAJVBthm8QFWqKs0PQpwh2hm
 rMLk+Rt4VqAzQ5NoKNPPPUi36jxrt+gAOzHCZf9tG/V5q2hsN+6ej80UuFo6gMe/EQhf
 WbyjH3a9XWnmabpQq/pcj/Ff8XsdxddayrGMbnEf/1sic7NNhG5zc6+k1/1CHUIwmF6P
 cLvUb2nPMFnv2uKpIwEAR3usHtyzc8Kqxsv4GxII+eTPOjecEmg79EDRjbz1pp/4PpHn
 uXUg==
X-Gm-Message-State: AOJu0YywK4w03pB5D248A6cwOxR5kJDwvm4+W61vwdugEUmNd7B8U7Lk
 AG87cH7o7EaEogErPNZ988b38MuLMoYDESmb1Ug=
X-Google-Smtp-Source: AGHT+IE6B5Y13O1hRPMdMQVNpM0IOV9K9bSejO41NpLwWHu6uS0FFBPCuLmbNIYa+PjmmdFKcaZCAA==
X-Received: by 2002:a05:6a00:4c07:b0:68b:bedd:c2e9 with SMTP id
 ea7-20020a056a004c0700b0068bbeddc2e9mr7930697pfb.16.1692838964838; 
 Wed, 23 Aug 2023 18:02:44 -0700 (PDT)
Received: from stoup.. ([2602:47:d483:7301:72f0:1ea7:85d2:141e])
 by smtp.gmail.com with ESMTPSA id
 c10-20020aa78c0a000000b006875df4773fsm2050789pfd.163.2023.08.23.18.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Aug 2023 18:02:44 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>,
	Ilya Leoshkevich <iii@linux.ibm.com>
Subject: [PATCH 07/13] linux-user: Show heap address in /proc/pid/maps
Date: Wed, 23 Aug 2023 18:02:31 -0700
Message-Id: <20230824010237.1379735-8-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230824010237.1379735-1-richard.henderson@linaro.org>
References: <20230824010237.1379735-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
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

Tested-by: Helge Deller <deller@gmx.de>
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/syscall.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 0b91f996b7..0641d8f433 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -8125,6 +8125,8 @@ static void open_self_maps_4(const struct open_self_maps_data *d,
 
     if (test_stack(start, end, info->stack_limit)) {
         path = "[stack]";
+    } else if (start == info->brk) {
+        path = "[heap]";
     }
 
     /* Except null device (MAP_ANON), adjust offset for this fragment. */
-- 
2.34.1


