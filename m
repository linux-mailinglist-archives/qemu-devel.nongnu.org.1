Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F497BF4F4
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 09:55:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq7Yj-00060J-2h; Tue, 10 Oct 2023 03:53:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YX-0005pq-Tm; Tue, 10 Oct 2023 03:53:29 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qq7YW-0005LP-CP; Tue, 10 Oct 2023 03:53:29 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-6969b391791so3638103b3a.3; 
 Tue, 10 Oct 2023 00:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1696924406; x=1697529206; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fLLT5ObzM5KwZn8Whir/m9IL59w1BchNaowOLYzDN5M=;
 b=KE4cataAgP/WGjg9n0IsyxguZ/S56BKt+4CGkKT8X7D4FfLCJqETnzV0HBCs7k42pR
 B8I0aVNhaXfXSogIh2+qYUF8VkI7vKIF1ocWSae4OM+uZibqmVn6dnxJ5+hlBYtO6p/i
 mIo2SAFRdEKBuSQI8Y5StA4uHtRMrzv7iV2ymRJDH/r9Bx8NGdQATQAs+HYah3qMK4e3
 fYSszkPQrtcuuZ9eY1mHTCKFtSXKg+W9EFEo9h6YNLjhUusHL+LC0M5/kkUVEBKNgS3d
 ZfT/d/YhrHBCkiOVotvM9fzxhuDzsIvZ2HtloR0NpTKhVN4U844hM0uNealdx88XZA2C
 BMDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696924406; x=1697529206;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fLLT5ObzM5KwZn8Whir/m9IL59w1BchNaowOLYzDN5M=;
 b=W1FtAD1HChtFNIsPMmF8ScPhlTDS5FVJy2DcGhtJ+6ftHIEKH8QQVZ5DGkDI1dzleF
 IvUQd9/7Us/2uPeANSUjkhTIMYK+B4V2b47Pjtua2RK8Be7R+0cAO2xuFWSoVfc4HxNZ
 G5VHlYUVPjLTQw3u/v751n8ousP5TXdX40QszD/oIWqgZCONzO0K/1D79dDpQcJ+h9LL
 ZbiCB89VtbXTjrgcJ9v3TUWql/W5ffUve/gbgmHQNNDh9047gMFOBnpe/dpo0SCnH+6H
 dj64kReyv+yPHAOfotMMNtZuYR38F9tIt8S/Yc69RneL8T/5urj5orapL4+DfureYpKd
 eudw==
X-Gm-Message-State: AOJu0YzcorJDj8gj34eSSKG/85uDainbtCoRCTEklHcgbrQVtGTbzRSK
 WK6WoJgvvAKRYZkv6S9jrcy9z5Mf9mc=
X-Google-Smtp-Source: AGHT+IFoCVXayD5MC7U6976MFuH6jyYim/JWHmql35AW2Osix0YGGEuaNR6FvAQBVhlaSQzM0bdVAA==
X-Received: by 2002:a05:6a21:191:b0:160:18d6:a3d7 with SMTP id
 le17-20020a056a21019100b0016018d6a3d7mr20195671pzb.1.1696924406592; 
 Tue, 10 Oct 2023 00:53:26 -0700 (PDT)
Received: from wheely.local0.net (27-33-247-209.tpgi.com.au. [27.33.247.209])
 by smtp.gmail.com with ESMTPSA id
 a21-20020a62e215000000b0069353ac3d3esm7548102pfi.38.2023.10.10.00.53.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 00:53:26 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, qemu-devel@nongnu.org
Subject: [RFC PATCH 10/11] ppc/spapr: change pseries machine default to
 POWER10 CPU
Date: Tue, 10 Oct 2023 17:52:37 +1000
Message-ID: <20231010075238.95646-11-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231010075238.95646-1-npiggin@gmail.com>
References: <20231010075238.95646-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

POWER10 is the latest pseries CPU.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 hw/ppc/spapr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index d4230d3647..9d3475d64b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4661,7 +4661,7 @@ static void spapr_machine_class_init(ObjectClass *oc, void *data)
 
     smc->dr_lmb_enabled = true;
     smc->update_dt_enabled = true;
-    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power9_v2.2");
+    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power10_v2.0");
     mc->has_hotpluggable_cpus = true;
     mc->nvdimm_supported = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_ENABLED;
-- 
2.42.0


