Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7587B7E28BF
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 16:33:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r01bB-00008K-9w; Mon, 06 Nov 2023 10:33:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01au-000806-Lx
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:54 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1r01am-0004Nq-OZ
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 10:32:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32fb1d757f7so2447227f8f.0
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 07:32:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699284762; x=1699889562; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=8uZpTC7vfc/gISeKzm+ZO3nrKEzBmGcZTgy+gByZUp0=;
 b=n9sgcm9Q8AF5M/oZgvhLD7tm10iFvKv6sg6Ug5Wp4BNBockuiuUgCx/y3mkg3rvih4
 TAhCQFD2eJzoreyXq6kxpYLWSZ7t21OiU8v/hd2qIxN/6+HfbuYYK1anyocUa4AwHIhk
 x1j6AVjN2nd4/z9T48493N1vZBaSLPfuukN33mDoxz7MkDjnK+Oe4lSZtjqCQ57OuTCd
 Yvzb7iXLcJ//IFRaT1yXbC7akmWeoQn8hLWJc5YofhBn37KEGX2yVda8yD2gfakoy671
 iOpyFhvhxHMPQgZc9cKLJiH8a5LkD8UQn+FIr82LscesZv1sUQzOmPzYsavVCxowO5Q1
 o6ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699284762; x=1699889562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8uZpTC7vfc/gISeKzm+ZO3nrKEzBmGcZTgy+gByZUp0=;
 b=E3cy9ojxlfa5g2S16yecUs/Ix0PL/9ddsCN6bafTpVpVSTh/nXeTgm6rPNjWGn5a3M
 b3Fv9lDyX0tEYWCrl4eNP+tpf98Kixoa83ybLc2UpeRaFEWOmOuHZb0A4D8EILO91Xgl
 pCJVlNAMh1in6pHADUfTrIJwaI0JNCyXxYS3fLDfisVz3c+iacWGO11gSke7e0ahXaYF
 6VJ3FcdKnk/sRJ0YP5rU8/T+TidK86mgRXTmpgGv0nbPnXNCgk+M9BrIMt2Tu7zxFCEL
 VFF766qUvSCOmmGmV+m6AtpGewzoHwDoKpB0FB9wx4u6fMTaByRVpYaS9hmGXoIAFeF7
 1fWw==
X-Gm-Message-State: AOJu0Yxcb6D1a3wcdsru67kCnKSqN5MWP3QwqzNpzA1W3Ps/dVFikdCr
 EI1EsA8ud3e5l/DPfTwmItUSM1f9wlCtjLDQ30Q=
X-Google-Smtp-Source: AGHT+IE0cKtfN7n8+wxzdMUTKzm/QvBbraAz9Vd2iI6Y8cs4n40hF20jVCdDHMtoJ6vqocoW+YDZcw==
X-Received: by 2002:adf:ef02:0:b0:323:1887:dd6d with SMTP id
 e2-20020adfef02000000b003231887dd6dmr26338138wro.3.1699284762205; 
 Mon, 06 Nov 2023 07:32:42 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 d5-20020adff2c5000000b0032da6f17ffdsm9752176wrp.38.2023.11.06.07.32.41
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Nov 2023 07:32:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 06/12] util/filemonitor-inotify: qemu_file_monitor_watch():
 assert no overflow
Date: Mon,  6 Nov 2023 15:32:32 +0000
Message-Id: <20231106153238.1426649-7-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106153238.1426649-1-peter.maydell@linaro.org>
References: <20231106153238.1426649-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x42c.google.com
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

From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>

Prefer clear assertions instead of [im]possible array overflow.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Maksim Davydov <davydov-max@yandex-team.ru>
Message-id: 20231017125941.810461-3-vsementsov@yandex-team.ru
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 util/filemonitor-inotify.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/util/filemonitor-inotify.c b/util/filemonitor-inotify.c
index 2c45f7f1764..2121111f38b 100644
--- a/util/filemonitor-inotify.c
+++ b/util/filemonitor-inotify.c
@@ -81,16 +81,25 @@ static void qemu_file_monitor_watch(void *arg)
 
     /* Loop over all events in the buffer */
     while (used < len) {
-        struct inotify_event *ev =
-            (struct inotify_event *)(buf + used);
-        const char *name = ev->len ? ev->name : "";
-        QFileMonitorDir *dir = g_hash_table_lookup(mon->idmap,
-                                                   GINT_TO_POINTER(ev->wd));
-        uint32_t iev = ev->mask &
-            (IN_CREATE | IN_MODIFY | IN_DELETE | IN_IGNORED |
-             IN_MOVED_TO | IN_MOVED_FROM | IN_ATTRIB);
+        const char *name;
+        QFileMonitorDir *dir;
+        uint32_t iev;
         int qev;
         gsize i;
+        struct inotify_event *ev = (struct inotify_event *)(buf + used);
+
+        /*
+         * We trust the kenel to provide valid buffer with complete event
+         * records.
+         */
+        assert(len - used >= sizeof(struct inotify_event));
+        assert(len - used - sizeof(struct inotify_event) >= ev->len);
+
+        name = ev->len ? ev->name : "";
+        dir = g_hash_table_lookup(mon->idmap, GINT_TO_POINTER(ev->wd));
+        iev = ev->mask &
+            (IN_CREATE | IN_MODIFY | IN_DELETE | IN_IGNORED |
+             IN_MOVED_TO | IN_MOVED_FROM | IN_ATTRIB);
 
         used += sizeof(struct inotify_event) + ev->len;
 
-- 
2.34.1


