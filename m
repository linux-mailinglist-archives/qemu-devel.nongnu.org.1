Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C9B67C80E5
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 10:53:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrDss-0006qU-KF; Fri, 13 Oct 2023 04:51:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsP-0006EV-JD
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:34 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1qrDsK-0001YC-Sj
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 04:50:33 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-406618d0992so19363005e9.0
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 01:50:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697187027; x=1697791827; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hGp6KfiXvVmX3sQOMO0j8ragfkcxvzPbKi4/s+Bgkm8=;
 b=CCFftagZou7M4NIW7WbUtrgyZ+V7KMvyL/KvSjBP4BhYdexJTSKj+JHywgwigiB4hg
 YiJ8IJGwJtjMxZJZUQBvNao9UPc/xBoJvAvjf5MVgYs9EwQ6aFA9klljifCkcRdIEJFw
 A5S6L+SaUZiYRvSArZ72kgcN9h7HwYXpakayQt1X7ShdkXi2AKaylCz9LaKIjqBWEi6k
 +VGEHXaGzi6mXPnXeiEYDNa6m3jPUzz/GmwalXda9Kp5pv90CEjv6RQWSHLgGFJQYs51
 5fcWEmwrvPTKsmuf24fYONuV6QgAumsRBeP90X89vMLvShhtQfMm+JOUDUflFyG7v4zD
 9AjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697187027; x=1697791827;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hGp6KfiXvVmX3sQOMO0j8ragfkcxvzPbKi4/s+Bgkm8=;
 b=hQAHPQPHZBaoqxqR+8YHrn1mroQiiGy79d8zTQNw5+tzpFbstfro9SjWGNSsfxOm/s
 ANF1cP37g197NEt733stl4LR6TrrIGIwm6vuMQFdGF4UB1vZy/+Y12EMKDoL7S4efp5Q
 0cqAzMeFiv6jRtro/BmOo/QyOxzwldxhaiWhiU7qFGkHt5f9Ezest4506QJ5bQ50hatO
 JfQGtdglNKjQZfrcMkRiVpdkeMwqWv3JVTHK8FCR5lBiSMd4ZO9o0x6tJVJdZsblgJ3A
 S6ir5dwFUv3t1aorsVAFf3TbmcGYkgHaofHnVTdJwdkrpOnORidwa7X9vj9nEjsB7lfI
 UcLw==
X-Gm-Message-State: AOJu0YxUJN7nibOgOLFDBu7yPl2wcrVW6m0kV9rp+J9ljF1vBjv6sQIE
 0NrUnMRQp5ZZpL+g4T9hI/LgHwdSxLIWoPDgjtw=
X-Google-Smtp-Source: AGHT+IEN/GQyIQE6G4rQkyNu04/Wh00MoF2hvPXLQDHJHqnmiQtfJAB9BPsclU5I32C+d4ANpDa/mA==
X-Received: by 2002:a05:600c:3544:b0:407:39ea:d926 with SMTP id
 i4-20020a05600c354400b0040739ead926mr16370973wmq.9.1697187027139; 
 Fri, 13 Oct 2023 01:50:27 -0700 (PDT)
Received: from localhost.localdomain (adsl-170.109.242.226.tellas.gr.
 [109.242.226.170]) by smtp.gmail.com with ESMTPSA id
 v10-20020a5d678a000000b0032d9f32b96csm569185wru.62.2023.10.13.01.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Oct 2023 01:50:26 -0700 (PDT)
From: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org
Cc: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Michael Roth <michael.roth@amd.com>,
 Konstantin Kostiuk <kkostiuk@redhat.com>
Subject: [RFC PATCH v3 60/78] qga: add fallthrough pseudo-keyword
Date: Fri, 13 Oct 2023 11:46:28 +0300
Message-Id: <e42c16ba150141c248368ab3666aae54b93bd59b.1697186560.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x331.google.com
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

Signed-off-by: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>
---
 qga/main.c                  | 2 +-
 qga/vss-win32/requester.cpp | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/qga/main.c b/qga/main.c
index 8668b9f3d3..40471e8a0b 100644
--- a/qga/main.c
+++ b/qga/main.c
@@ -663,7 +663,7 @@ static gboolean channel_event_cb(GIOCondition condition, gpointer data)
         if (!s->virtio) {
             return false;
         }
-        /* fall through */
+        fallthrough;
     case G_IO_STATUS_AGAIN:
         /* virtio causes us to spin here when no process is attached to
          * host-side chardev. sleep a bit to mitigate this
diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
index 9884c65e70..36fa4fdf28 100644
--- a/qga/vss-win32/requester.cpp
+++ b/qga/vss-win32/requester.cpp
@@ -611,6 +611,7 @@ void requester_thaw(int *num_vols, void *mountpints, ErrorSet *errset)
             break;
         }
         /* fall through if hEventTimeout is signaled */
+        fallthrough;
 
     case (HRESULT)VSS_E_HOLD_WRITES_TIMEOUT:
         err_set(errset, hr, "couldn't hold writes: "
-- 
2.39.2


