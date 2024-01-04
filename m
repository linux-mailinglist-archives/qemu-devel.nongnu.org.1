Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AD182460A
	for <lists+qemu-devel@lfdr.de>; Thu,  4 Jan 2024 17:23:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLQUw-0000x5-2r; Thu, 04 Jan 2024 11:23:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLQUt-0000wD-Ka
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:23:07 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rLQUs-0006E8-4c
 for qemu-devel@nongnu.org; Thu, 04 Jan 2024 11:23:07 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d3ed1ca402so4871595ad.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jan 2024 08:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1704385264; x=1704990064;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nLUzGfzUZUvPQFou46dKVJl/tbVU2f+F7XMXWWcrcu4=;
 b=Rns4f9QDBfDIPTJNv2NeMbnts2aUAg+rREb83TJfH1+WO3F2Ko7XzTuE5MmKewWNdl
 edyrXcLikOyCb43kffTcaXrE25OOxgpaeZkYCs5T3gXcbL2ln6pODgglMm+Rveq6acio
 9Lygr36Suecgyssrvgl8HrsP+TKt6v9WtTsUMYb8rCqFJvoILEl6szPmFu/wwoPYTgzH
 GZ3qVUYTBQBw/4KEtisX5IGFWJ0nJLl+8j7yQejBv4Zj8EyTLuvNLrkvNLL0m46HwL+B
 vvCLMW/vnfen6qiWlF8V/oEAMFdTxfSyFHa2OF9dDJHkAOhGdLsaSWVFOC7ls6BeBmhU
 XLnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704385264; x=1704990064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nLUzGfzUZUvPQFou46dKVJl/tbVU2f+F7XMXWWcrcu4=;
 b=KERWbDUdVS7HxONddNzWlq9mIF+2pin2rF920fEBlPeDXZf9QSDhzB5ZjPgIX6edDR
 kHfAg6RgyDvDbYPdfZVfcca+ZuYouuo0pCD8uQOV6QnEauga4f9Xn3KAzdyFramKpzpf
 5ZGtdbzK4OuwXJ9QPvb3njwLEOH7q8s1JG2jOW6pw3Wr9tPw8gd6o2HtoUuOeUBPAHsB
 fBIfBq6hBXhKO+Ij0pMs6GVRua5Xp8so2mzfY3j+eOSivW1wS3cYInTcTp1OWFWGqzoG
 UvPkXNsoQuJ146966PmQo899VPH7KoANmfsIsIcNpaaWFd4xsdSwAle+G3jgVtUDMHSl
 9M4Q==
X-Gm-Message-State: AOJu0YwudLSU91HT4mEs3oA6H2CGMoZxtVRl1jEI7g803H56DVhVLckL
 M7HjCZ/Ack4c4+qR7hS0SuvUJt/1QIqE73/4KvV9OeLw8nrXtJu1
X-Google-Smtp-Source: AGHT+IH/rvZ2B2U4ykO+HTdOX5wgyl5IeV/ATxBXGncQ4oYm3E4O9cnhImHlsMfO6azoLiGr5nIH7g==
X-Received: by 2002:a17:902:db09:b0:1d4:22ab:e378 with SMTP id
 m9-20020a170902db0900b001d422abe378mr873941plx.116.1704385263915; 
 Thu, 04 Jan 2024 08:21:03 -0800 (PST)
Received: from localhost.localdomain ([118.114.59.173])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902ee4500b001d06b63bb98sm25987314plo.71.2024.01.04.08.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Jan 2024 08:21:03 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>, yong.huang@smartx.com
Subject: [PATCH v2 2/2] hmp: Drop unknown feature and status bits
Date: Fri,  5 Jan 2024 00:19:35 +0800
Message-Id: <6f0de9a1c82f64c4055908573d82a1c86c4d99e8.1704382761.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <cover.1704382761.git.yong.huang@smartx.com>
References: <cover.1704382761.git.yong.huang@smartx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62b;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62b.google.com
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
index 4fabba4f9c..ae27968523 100644
--- a/hw/virtio/virtio-hmp-cmds.c
+++ b/hw/virtio/virtio-hmp-cmds.c
@@ -27,10 +27,6 @@ static void hmp_virtio_dump_protocols(Monitor *mon,
         }
     }
     monitor_printf(mon, "\n");
-    if (pcol->has_unknown_protocols) {
-        monitor_printf(mon, "  unknown-protocols(0x%016"PRIx64")\n",
-                       pcol->unknown_protocols);
-    }
 }
 
 static void hmp_virtio_dump_status(Monitor *mon,
@@ -47,10 +43,6 @@ static void hmp_virtio_dump_status(Monitor *mon,
         }
     }
     monitor_printf(mon, "\n");
-    if (status->has_unknown_statuses) {
-        monitor_printf(mon, "  unknown-statuses(0x%016"PRIx32")\n",
-                       status->unknown_statuses);
-    }
 }
 
 static void hmp_virtio_dump_features(Monitor *mon,
@@ -81,11 +73,6 @@ static void hmp_virtio_dump_features(Monitor *mon,
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


