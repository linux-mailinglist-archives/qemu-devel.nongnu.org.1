Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E28017AB4CB
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:30:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qji6d-0005PO-VE; Fri, 22 Sep 2023 11:30:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qji6P-0005KU-FA
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:29:58 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qji6I-00007V-Fb
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:29:55 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4051fea48a8so26024285e9.2
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:29:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695396589; x=1696001389; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NVF3Nkth4giVKdzfl1RSEmEQYi2EYDdx4MRHrnjWkQ0=;
 b=k0/YzH35ghikYlIiEdjrT7N2qCzplHzm7VQX4yYnxYrUbofTpH2HsuqDumFKcnxEh7
 6aLhiECsfpTspaU/qJa1cKz+F8jLSZBgpcW0dfmjaJOTF+xiN7aGHs6iiwqHggjuJrAq
 Tu/l9C6KPj1pn9C4vmO0OYubPbPn4U7KZi/OTW3Z2iPHvyMFK0HVgcCXuHAi8suAYer1
 NJVVXsShH9xBhwtgg88WnMZRx7UNmciTPprY8aE4frRA1UUAD2frmbV2eTWZLQyw7R1T
 aY4sqLnUtNe9iZBKADck9+CczcBk5jkyTHAYLll2mDUKBMsrMXnclTSXO9bNlyTNTQsX
 se2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695396589; x=1696001389;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NVF3Nkth4giVKdzfl1RSEmEQYi2EYDdx4MRHrnjWkQ0=;
 b=dJNMhTNcsTk9vwtXnfJTnajy03/RB+58zG7YohlPgBQ0PFdMM+0w0qudtooaYrh9L7
 AD0XdrSiwk9/1nAnDOhrInWJojN12REdBU6g0/rtG3t7xtzv+GI1MLYEcuR1lNHgXZHm
 WgE4Lf95QxO9oZhJOMbsx0+NK634pHCAch/Gc6+Ego3FzYa2A2hwohzkYvNmepv0uggd
 UAnKH/wvOOKCFamO6+9k0/zk/w6TuqzgF8SkxnlqVBo54QrqIya/o0wrtf4Knn5TWmVH
 FVwMUC4AP4SXAHFBbE8RVm3wWw96kSQgvqktnfTNB+4Pszu1oPQPbalt+8WSgZNf2HF3
 fk6A==
X-Gm-Message-State: AOJu0Yy1DTukDRFmw5XkbSHxdlYyF+ntnqSDe41akhemT1P+pdMVd8XQ
 zFRYmAfaHH9toiUrptR6HznYDpbYD/yHOF4JZmI=
X-Google-Smtp-Source: AGHT+IHM3fq7WEIkIK/XpYcSJ7tSHI+gtIawuMkUBXqlQGA2Xu/MfbB08jc100PRmJmCG3uEyBE8zg==
X-Received: by 2002:a05:600c:2206:b0:403:ca21:6348 with SMTP id
 z6-20020a05600c220600b00403ca216348mr8025091wml.18.1695396589133; 
 Fri, 22 Sep 2023 08:29:49 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 c22-20020a05600c171600b00405442edc69sm777137wmn.14.2023.09.22.08.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:29:48 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: Eric Auger <eric.auger@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: [PATCH 2/4] hw/misc/arm_sysctl.c: Avoid shadowing local variable
Date: Fri, 22 Sep 2023 16:29:42 +0100
Message-Id: <20230922152944.3583438-3-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230922152944.3583438-1-peter.maydell@linaro.org>
References: <20230922152944.3583438-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Avoid shadowing a local variable in arm_sysctl_write():

../../hw/misc/arm_sysctl.c: In function ‘arm_sysctl_write’:
../../hw/misc/arm_sysctl.c:537:26: warning: declaration of ‘val’ shadows a parameter [-Wshadow=local]
  537 |                 uint32_t val;
      |                          ^~~
../../hw/misc/arm_sysctl.c:388:39: note: shadowed declaration is here
  388 |                              uint64_t val, unsigned size)
      |                              ~~~~~~~~~^~~

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/misc/arm_sysctl.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/misc/arm_sysctl.c b/hw/misc/arm_sysctl.c
index 42d46938543..3e4f4b05244 100644
--- a/hw/misc/arm_sysctl.c
+++ b/hw/misc/arm_sysctl.c
@@ -534,12 +534,12 @@ static void arm_sysctl_write(void *opaque, hwaddr offset,
                     s->sys_cfgstat |= 2;        /* error */
                 }
             } else {
-                uint32_t val;
+                uint32_t data;
                 if (!vexpress_cfgctrl_read(s, dcc, function, site, position,
-                                           device, &val)) {
+                                           device, &data)) {
                     s->sys_cfgstat |= 2;        /* error */
                 } else {
-                    s->sys_cfgdata = val;
+                    s->sys_cfgdata = data;
                 }
             }
         }
-- 
2.34.1


