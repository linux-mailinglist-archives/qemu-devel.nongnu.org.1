Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D64D5821655
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 03:03:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKU3A-0003Hb-Ac; Mon, 01 Jan 2024 20:58:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU38-0003HO-Qd
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:34 -0500
Received: from mail-oa1-x36.google.com ([2001:4860:4864:20::36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rKU37-00070a-97
 for qemu-devel@nongnu.org; Mon, 01 Jan 2024 20:58:34 -0500
Received: by mail-oa1-x36.google.com with SMTP id
 586e51a60fabf-20400d5b54eso7076022fac.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jan 2024 17:58:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704160712; x=1704765512; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7qyMzlpzWlHoGSx0bplKdPfg7TJkUYYgysQjBpEEncg=;
 b=wCrmBHiQBmvk9tFIhNgjBNYnvBQ2v9j5Occ7+z4qOupkZyPqGIeiILuSFzaJhnM/Sl
 ffTVI1GH/uzK3XAZBXhwsdSt7+mhCGsKKd1sw63EI44R2hj0d96Dx1GJfs/JYVkOIymj
 tIwibiFbrN5yMh+Z0swkLcFwp9UvkIsXjzObyeXLy4Q3fNYRy50dLXXKmnLbWvOkFbop
 EUR3vpF/wbMerOxM/2B5TA4oxVwIIpVBAQSVYrncE+5ZuqRDAJTdCYP3XVUqivSxJ9F6
 STBTglV+Ie7aXXiMc+l3TMaAsgI4Jp5gJM1UR8doZJY1hjViWJumWETp821F5FpywWwl
 1+vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704160712; x=1704765512;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7qyMzlpzWlHoGSx0bplKdPfg7TJkUYYgysQjBpEEncg=;
 b=f+4hfvxu9Xvryp/jLfrC7ZiGtG9YsIxrpSIhGaFSYi2NZ5SJEiugxdEYSj+K7gPlSz
 lBdd/H1CPp/nuTx5F+Ii65py04wQnqjauYdogkWaoYuq7jt+0Fyrx4uxxm8JOWtusg/c
 ue3/kuIswi3Aksw3u/YQU1WX7r1UIHtxVBge1J63zrXwQMDlR8rqUg0Z+sXhuhYgTDRH
 TrfRYHrdKPlaFA7qsHBC3gHujX7VwfpUToFq7JY6EldCPZLO0RAZ3u/Is6J8q3o5+mdV
 /TShTn1ImhuC69lCfUgd6G2yUM049rfVLcPRFo5DdO1T/7dXdK+c0LLsC943eIzayIyq
 tCXg==
X-Gm-Message-State: AOJu0YyD+w0J+1QoS59w/JJDuSfSXhH+v7sBJ0vun2DaX2wFqXXLTUmG
 dEt9opAuuJ+QLh0zkSIwt4GFS8YodsW8alWPPrsZwk4vtdg=
X-Google-Smtp-Source: AGHT+IERAvOAqKRj6cRuXptjlkI/bmbiVJefHVFdswW3OVZOHLN8smhyxMDvUhSOyw+pi9RglhCPmQ==
X-Received: by 2002:a05:6871:5228:b0:1fa:dac9:1cd2 with SMTP id
 ht40-20020a056871522800b001fadac91cd2mr19439525oac.27.1704160712082; 
 Mon, 01 Jan 2024 17:58:32 -0800 (PST)
Received: from stoup.. (124-149-254-207.tpgi.com.au. [124.149.254.207])
 by smtp.gmail.com with ESMTPSA id
 g33-20020a635221000000b0058ee60f8e4dsm19561891pgb.34.2024.01.01.17.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jan 2024 17:58:31 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 09/33] linux-user: Remove REAL_HOST_PAGE_ALIGN from mmap.c
Date: Tue,  2 Jan 2024 12:57:44 +1100
Message-Id: <20240102015808.132373-10-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240102015808.132373-1-richard.henderson@linaro.org>
References: <20240102015808.132373-1-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4860:4864:20::36;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x36.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

We already have qemu_real_host_page_size() in a local variable.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/mmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4d3c8717b9..53e5486cc8 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -585,7 +585,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
              * the hosts real pagesize. Additional anonymous maps
              * will be created beyond EOF.
              */
-            len = REAL_HOST_PAGE_ALIGN(sb.st_size - offset);
+            len = ROUND_UP(sb.st_size - offset, host_page_size);
         }
     }
 
-- 
2.34.1


