Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5238A81FA8D
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Dec 2023 19:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIvWx-0001iR-P0; Thu, 28 Dec 2023 13:54:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rIvWw-0001iJ-Ez
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:54:54 -0500
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rIvWv-0004hv-1D
 for qemu-devel@nongnu.org; Thu, 28 Dec 2023 13:54:54 -0500
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1d426ad4433so21176735ad.0
 for <qemu-devel@nongnu.org>; Thu, 28 Dec 2023 10:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703789571; x=1704394371;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hPCN8F/O1sWqT2QMqtWnbh/ci3PTcSv6SePUIMbcb/c=;
 b=Z61+Sj3IAW0gmpi1vTqP2dqGjkR+vJ/zLMrrr+vv0PBQIGVf6V2aY/mJH750wTg7oL
 5hNygYNGW7243Gm1VP4O6TAfzuw1/CWQzejU/G5PYFfrcAXwU0kjPjScUehg7fCcceYt
 q4inw9yhZYh3MxI1v3tPdYTwbjy/Kee+fCtSrWcHViGMcaCKsciDR60rNEWKgFXQXxzh
 /eHefmNsomGGhPsujZYUmbE8w6f3fRW5fK0IRSWNvO4/ogxBcBqAeCiMI63/A7AAaceq
 9ILaykkKRySAW39mJ9vulncprVc4TyUdhlAb/4WDR70ddP02P4CcR5AQSHqW1GA52fPg
 SC9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703789571; x=1704394371;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hPCN8F/O1sWqT2QMqtWnbh/ci3PTcSv6SePUIMbcb/c=;
 b=djzIh0YCVP+zgyaS50NmyNWO5D6mOPrLTxSH/oa1Kgp1keW2xe5JSlSFItREet+09a
 AVGT4y2qXfFsnfGULlKFnS/R5ALwlobiYZ6xSiWJa4IOtSjkaAjsjdPAjnWLQpkEKwsz
 sJgT1fW3V+JJQC49+SUXKgZkxnATtY7RZNwaeRlMZlwRw8aAyERfvWQkXxi5kL9DMLQu
 tcP2IhYvfnfVbQf61BumBgW9R1W2qm3JDAQd02CX9jRb7SAJq6quKeO+KQdpV+FynPtQ
 vXJnRuUBW6/gNiXpQNBAK4QQ4yO1/shxc8B+w3tqVEOtnIhOfCK+cVQuNHmEcNTw0XX2
 cgCw==
X-Gm-Message-State: AOJu0YzrFlnXaZRwYeCjmDQwmZmDPVLr0u07BoawjzhT5uH5z+N+PsLO
 FH+Vg50qGq8lbEyBuuIRU+8nTVA3dZ8Xig/mMG/m5sUlXHUR0Fnb
X-Google-Smtp-Source: AGHT+IEvKKpQvk+soUQauyaoafNtFAeSIJATZLS/U00vnta70kfp59vbKZuvcT3ol2tMc88TNj0vtQ==
X-Received: by 2002:a17:902:7ec2:b0:1d4:2836:640f with SMTP id
 p2-20020a1709027ec200b001d42836640fmr3516379plb.112.1703789570933; 
 Thu, 28 Dec 2023 10:52:50 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.180])
 by smtp.gmail.com with ESMTPSA id
 h24-20020a170902ac9800b001d36dbb22a9sm14312694plr.4.2023.12.28.10.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Dec 2023 10:52:50 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 yong.huang@smartx.com
Subject: [PATCH 2/2] hmp: Drop unknown feature and status bits
Date: Fri, 29 Dec 2023 02:52:32 +0800
Message-Id: <aa3532d51fdd94ca74d5fc10207d2913821704a3.1703787712.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1703787712.git.yong.huang@smartx.com>
References: <cover.1703787712.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::629;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x629.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The QMP command "x-query-virtio-status" outputs the full
feature and status bit information, so there is no need
to maintain it in the HMP output; drop it.

Signed-off-by: Hyman Huang <yong.huang@smartx.com>
---
 hw/virtio/virtio-hmp-cmds.c | 13 -------------
 1 file changed, 13 deletions(-)

diff --git a/hw/virtio/virtio-hmp-cmds.c b/hw/virtio/virtio-hmp-cmds.c
index 721c630ab0..f9a7384604 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -25,10 +25,6 @@ static void hmp_virtio_dump_protocols(Monitor *mon,
         }
     }
     monitor_printf(mon, "\n");
-    if (pcol->has_unknown_protocols) {
-        monitor_printf(mon, "  unknown-protocols(0x%016"PRIx64")\n",
-                       pcol->unknown_protocols);
-    }
 }
 
 static void hmp_virtio_dump_status(Monitor *mon,
@@ -43,10 +39,6 @@ static void hmp_virtio_dump_status(Monitor *mon,
         }
     }
     monitor_printf(mon, "\n");
-    if (status->has_unknown_statuses) {
-        monitor_printf(mon, "  unknown-statuses(0x%016"PRIx32")\n",
-                       status->unknown_statuses);
-    }
 }
 
 static void hmp_virtio_dump_features(Monitor *mon,
@@ -73,11 +65,6 @@ static void hmp_virtio_dump_features(Monitor *mon,
         }
         monitor_printf(mon, "\n");
     }
-
-    if (features->has_unknown_dev_features) {
-        monitor_printf(mon, "  unknown-features(0x%016"PRIx64")\n",
-                       features->unknown_dev_features);
-    }
 }
 
 void hmp_virtio_query(Monitor *mon, const QDict *qdict)
-- 
2.39.1


