Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACEC724910
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 18:27:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6ZVU-0000uo-Lm; Tue, 06 Jun 2023 12:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ZVS-0000tp-9u
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:26:02 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6ZVP-00022F-Lc
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 12:26:02 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-51452556acdso3688130a12.2
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686068758; x=1688660758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=egCSYAdVTdNTDAYsfTmx8TEi8hcbvHOd5ttkDL5a96Q=;
 b=GsU5eyEouosEGykccMnwPgwcRXlupR4jbvbLqOMZ01i+ceApO56B37bpQR36eYMH4z
 RlMYVQYTzSaiE40ax8YGebgj3XM7PkAS5+pxDeUIp/bUDGqO11JsVrngWcLZlE/BJYcO
 9Ro6Wqx4CDu0DXS9PYBnGAeIfN3wofzzBYyJbgF0sz9XT17bBNrdOprcqQ+9tVHVdd/7
 8pLTA1yxMtr/4q9H57cgtIKLGgLIpKI06DQZJ3VFaJhEIEYT8HCTGD6VdAnDGk4NteCE
 Z1tp5dDT8oOKSPNQh2nipIZEccU/r44ewUW5qi9EUTwxr3leOBteZ06trA5xSSmcXFa+
 X6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686068758; x=1688660758;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=egCSYAdVTdNTDAYsfTmx8TEi8hcbvHOd5ttkDL5a96Q=;
 b=NC4KYnJkd6Lg1lVp/1+F3wJSpeE4qgC/G+4BiYXc/tWEiEgyT6fHa/c5ZMxGZNPDFM
 wgaOK8hd024tKH0/zpALXFzJ1yqVhZXBikLnQzs6qHkliaRB96QGny6ysQEcHe5Ys1aZ
 xvU7Eza1P1ugHqiwYgq+3UKjHULbCvF4ymPsrmBQ5qYQ5N3ICwqlfqVpYb6X4nGCW9L3
 hRrqL0OoKYbUVAIY7wkMvvLJhETEaA1CPq8HMt6GxV9tp/A47QgPk1EDqzdxvhu/uSnL
 EAU/l4+Z36NSVChVKvGZPphXvzA13jhpnvN1zH2mq7LPN8WZ1K58m16m8jiSyq3Ltmhl
 Xvuw==
X-Gm-Message-State: AC+VfDzeYd9wbSRJiZJ8HRp2n83+z9B0jyFaQxxYYtDyUwWno4zM092s
 Y1n8uUwl0h7tjYKGN5CaJyP8s4+PdJNaLL++qxg=
X-Google-Smtp-Source: ACHHUZ6dc2uXZ2EsVzJbOjW1EjPF9TMCCPx43mipQvvWt0baVEzhuWTaXbE965LVnA3wDSqSlFkEpA==
X-Received: by 2002:a05:6a21:3804:b0:105:63b0:5bf8 with SMTP id
 yi4-20020a056a21380400b0010563b05bf8mr217154pzb.18.1686068757963; 
 Tue, 06 Jun 2023 09:25:57 -0700 (PDT)
Received: from stoup.. ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 s17-20020aa78291000000b006413e6e7578sm7060840pfm.5.2023.06.06.09.25.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jun 2023 09:25:57 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com,
	berrange@redhat.com,
	jsnow@redhat.com
Subject: [PATCH] gitlab: Disable io-raw-194 for build-tcg-disabled
Date: Tue,  6 Jun 2023 09:25:56 -0700
Message-Id: <20230606162556.58110-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
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

This test consistently fails on Azure cloud build hosts in
a way that suggests a timing problem in the test itself:

--- .../194.out
+++ .../194.out.bad
@@ -14,7 +14,6 @@
 {"return": {}}
 {"data": {"status": "setup"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
-{"data": {"status": "postcopy-active"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 {"data": {"status": "completed"}, "event": "MIGRATION", "timestamp": {"microseconds": "USECS", "seconds": "SECS"}}
 Gracefully ending the `drive-mirror` job on source...
 {"return": {}}

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 .gitlab-ci.d/buildtest.yml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.gitlab-ci.d/buildtest.yml b/.gitlab-ci.d/buildtest.yml
index 0f1be14cb6..000062483f 100644
--- a/.gitlab-ci.d/buildtest.yml
+++ b/.gitlab-ci.d/buildtest.yml
@@ -236,7 +236,7 @@ build-tcg-disabled:
     - cd tests/qemu-iotests/
     - ./check -raw 001 002 003 004 005 008 009 010 011 012 021 025 032 033 048
             052 063 077 086 101 104 106 113 148 150 151 152 157 159 160 163
-            170 171 183 184 192 194 208 221 226 227 236 253 277 image-fleecing
+            170 171 183 184 192 208 221 226 227 236 253 277 image-fleecing
     - ./check -qcow2 028 051 056 057 058 065 068 082 085 091 095 096 102 122
             124 132 139 142 144 145 151 152 155 157 165 194 196 200 202
             208 209 216 218 227 234 246 247 248 250 254 255 257 258
-- 
2.34.1


