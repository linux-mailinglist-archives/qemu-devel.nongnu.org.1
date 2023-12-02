Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CD95801B57
	for <lists+qemu-devel@lfdr.de>; Sat,  2 Dec 2023 09:04:08 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r9KwG-0004QJ-9j; Sat, 02 Dec 2023 03:01:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kw5-0004OP-N9
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:16 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1r9Kw3-00053b-Ue
 for qemu-devel@nongnu.org; Sat, 02 Dec 2023 03:01:13 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-58cdc801f69so1941271eaf.3
 for <qemu-devel@nongnu.org>; Sat, 02 Dec 2023 00:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1701504071; x=1702108871;
 darn=nongnu.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:from:to:cc:subject:date:message-id
 :reply-to; bh=a7VZ9FFVn8e4TPvOcMNmTKk40w7o48Xb7nbGO94COXw=;
 b=xJz+ZuCa55tqFTkw8ogzbbWQ3iDX1dFYe18IInYmdKxWGgrSzXF6mOWeo4DjI4pCt2
 AAdHiw09z3beQt5tb6gFYQwKXUsGgWRGfqDMytza+uklqXT7hY2uE3cUIYHB7YHjmtrF
 lLNR/DX4+YEKt3buS4OikIJ3J7BcuqLefkF3yknzi7ew9jDRqC1HcMe4xQeRmI8TMFTQ
 M0hixvxFM2PPj1icUi+Auz9E+yUxtC5RlJ+1DioyttIotNYWlFcR0qFLsrVgaRVxoNOJ
 LlbH7vbUcWhjukGEoZJA7QVYnffcLHjkq6SVCBdF3hgoQBhJMp82M45vVsehtVygELXL
 NxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701504071; x=1702108871;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :mime-version:subject:date:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=a7VZ9FFVn8e4TPvOcMNmTKk40w7o48Xb7nbGO94COXw=;
 b=HRbymeFKfrvi1Gc6kHkpeU9QLpTT5Vl04WNDpWzkFkLtg1ZGnwU3qy1jx5cEoqaFba
 zz1Jwvot3G/CqG+bpinvQ1WHJ1XTf76M6JE/GQQYT1udJc7a20i9bPjhj8WyJzF4cOBl
 ARQr4vJ95mnC4gnU4fKcgW2XBb27LRfJafOkRcvMt2XVbe9GwcZA2FcjUbe62yg3ie3L
 fkri0q/af1vE9r4gWWtiA8GEF4fBqywJZk+M6DG8RVCgqBUR0c8IcFcBtQ55FqJZK8jq
 OISaqP2Dsn8WxRc4erbplM60435zK56ccGMY5Ve1wJQbO8kFCgRERQj+rxdNDA5pEfqI
 PbgQ==
X-Gm-Message-State: AOJu0YwMAEOmVU1inm4cs3B3Yr4YZ+vAi/yI/2NeYGEPHU+pO3HXqYhv
 2PmFkGo17gTDNRG5UcgqNelJDw==
X-Google-Smtp-Source: AGHT+IGiQMioan8eJJanprvh178TFAmpI+yMoG1D4Aqzx29PRDz9v/Dgha+A6mtWQcABpAdmyh2d6Q==
X-Received: by 2002:a05:6358:280e:b0:170:17eb:9c45 with SMTP id
 k14-20020a056358280e00b0017017eb9c45mr1433305rwb.38.1701504070779; 
 Sat, 02 Dec 2023 00:01:10 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 ij9-20020a170902ab4900b001cfd2c5ae6fsm2887482plb.25.2023.12.02.00.01.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 02 Dec 2023 00:01:10 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Date: Sat, 02 Dec 2023 17:00:31 +0900
Subject: [PATCH 08/14] qdev: Add qdev_device_new_from_qdict()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231202-sriov-v1-8-32b3570f7bd6@daynix.com>
References: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
In-Reply-To: <20231202-sriov-v1-0-32b3570f7bd6@daynix.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Alex Williamson <alex.williamson@redhat.com>, 
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>, 
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Yui Washizu <yui.washidu@gmail.com>, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::c32;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-oo1-xc32.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

qdev_device_new_from_qdict() can be used to create a device from QDict
without realizing it.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 include/monitor/qdev.h |  2 ++
 system/qdev-monitor.c  | 23 ++++++++++++++++++++---
 2 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/monitor/qdev.h b/include/monitor/qdev.h
index 1d57bf6577..013108a7dd 100644
--- a/include/monitor/qdev.h
+++ b/include/monitor/qdev.h
@@ -11,6 +11,8 @@ int qdev_device_help(QemuOpts *opts);
 DeviceState *qdev_device_add(QemuOpts *opts, Error **errp);
 DeviceState *qdev_device_add_from_qdict(const QDict *opts,
                                         bool from_json, Error **errp);
+DeviceState *qdev_device_new_from_qdict(const QDict *opts, bool from_json,
+                                        BusState **busp, Error **errp);
 
 /**
  * qdev_set_id: parent the device and set its id if provided.
diff --git a/system/qdev-monitor.c b/system/qdev-monitor.c
index 42aac94b8c..028b97f2b5 100644
--- a/system/qdev-monitor.c
+++ b/system/qdev-monitor.c
@@ -618,6 +618,25 @@ const char *qdev_set_id(DeviceState *dev, char *id, Error **errp)
 
 DeviceState *qdev_device_add_from_qdict(const QDict *opts,
                                         bool from_json, Error **errp)
+{
+    DeviceState *dev;
+    BusState *bus;
+
+    dev = qdev_device_new_from_qdict(opts, from_json, &bus, errp);
+    if (!dev) {
+        return NULL;
+    }
+
+    if (!qdev_realize(dev, bus, errp)) {
+        object_unparent(OBJECT(dev));
+        object_unref(OBJECT(dev));
+    }
+
+    return dev;
+}
+
+DeviceState *qdev_device_new_from_qdict(const QDict *opts, bool from_json,
+                                        BusState **busp, Error **errp)
 {
     ERRP_GUARD();
     DeviceClass *dc;
@@ -720,9 +739,7 @@ DeviceState *qdev_device_add_from_qdict(const QDict *opts,
         goto err_del_dev;
     }
 
-    if (!qdev_realize(dev, bus, errp)) {
-        goto err_del_dev;
-    }
+    *busp = bus;
     return dev;
 
 err_del_dev:

-- 
2.43.0


