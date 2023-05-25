Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 689C6711A1D
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 00:21:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2JJu-00027U-OA; Thu, 25 May 2023 18:20:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3Kd9vZAgKCtAFw7G8xwG2AA270.yA8C08G-z0H079A929G.AD2@flex--talumbau.bounces.google.com>)
 id 1q2JJs-00025n-JK
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:28 -0400
Received: from mail-io1-xd49.google.com ([2607:f8b0:4864:20::d49])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3Kd9vZAgKCtAFw7G8xwG2AA270.yA8C08G-z0H079A929G.AD2@flex--talumbau.bounces.google.com>)
 id 1q2JJq-0004SJ-Th
 for qemu-devel@nongnu.org; Thu, 25 May 2023 18:20:28 -0400
Received: by mail-io1-xd49.google.com with SMTP id
 ca18e2360f4ac-76c5c78bc24so31556439f.2
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 15:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20221208; t=1685053225; x=1687645225;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=4cMvgGN5jzGaGfRSZF3eild5fkvOSBVOFI0ZHu7w7Hw=;
 b=J+NKjPtLyljqS7tpbK6nNpA5igNAy3Kyp4N11DqBWNqtHhLVMcbpftBk1J+5t8Fnp5
 iLODQY4jMS48+wbk3M3qjuEO4pQgGXK2cjIXpxv0LUSZwcgvBqSZCSxnAHfRQLYOIM7P
 NWiaDbncu9arR05XhhAfVl0g11edH4gh9m1KvLdITijYzOR1fpUNXL/ai10omIUQ2pA5
 iKvi70CuT1Mgnc9fAU1r39sCB1ppAKZjCtSEhk0KkzNN5yIPaz545OBLj0zxl2Tu4S6N
 uaOl9TUnNCJXThJQh98hAIh6/lLpAj+tuQcoOx7EYSQT1MtYWmL7O/s7bt3nbAKGQ08h
 8HUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685053225; x=1687645225;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4cMvgGN5jzGaGfRSZF3eild5fkvOSBVOFI0ZHu7w7Hw=;
 b=dNOTUvCh4EImRCi8TyA/bTESijReUst3v2COMdC9W/T8JdfKJmbtlOjVKEgjB4z/87
 uMXtnLN+xg9AvjvoJiasGpXmYAVl4iMTjmM9Vq1YtfMk0JYhNIfZLwQX9aJQn1q11lX8
 xGW02JVGKKGcUFOLJ1AqQd2JNrECgKKh7qjqPpWXXHQbtQ5pOPn0W9RxzoP+ZqfOQkmY
 iXgg2pshxYWR3BKNq3SqA8LBavNVjNWcJyiux7UIFLM6WEmlNiOMfaU3Fs2e5KK3AT6F
 7GiDuNeEwGJ9l3126/pmhVSA2OncUU4w+t54ILffUi1V+MQhtBsq6wZ1UkdrW2DVL8KF
 i1bw==
X-Gm-Message-State: AC+VfDw/a+jl+AnQxCPFManps7sK+k3I58e8I2FkaEJdb/L9KirYF0Iu
 QbQ7apn9HsFhOl9GEmwvBWmmq8WjuzbKApRq6vM5KknUDNVDTA3Gmu+2fr06qAX7ZHpByFB0nTX
 rnWpoINEVeGkbcTpNWYAUpN4YHb2SPK0MkengLMEMAUMhOaW5dmWnX2ivh8lfyZXhHQ==
X-Google-Smtp-Source: ACHHUZ5gSsYihOU/xjt27sq6scp7ahHAdVFG82Kj2KENmUDu43KeiKxciNBupPs6j+hBQ8/VJK0hcR15S6GNdw==
X-Received: from talumbau.c.googlers.com
 ([fda3:e722:ac3:cc00:2b:ff92:c0a8:90d])
 (user=talumbau job=sendgmr) by 2002:a92:cb44:0:b0:335:479a:8eaa with SMTP id
 f4-20020a92cb44000000b00335479a8eaamr13163675ilq.6.1685053225074; Thu, 25 May
 2023 15:20:25 -0700 (PDT)
Date: Thu, 25 May 2023 22:20:15 +0000
In-Reply-To: <20230525222016.35333-1-talumbau@google.com>
Mime-Version: 1.0
References: <20230525222016.35333-1-talumbau@google.com>
Message-ID: <20230525222016.35333-5-talumbau@google.com>
Subject: [RFC PATCH v2 4/5] virtio-balloon: Add HMP functions for Working Set
From: "T.J. Alumbaugh" <talumbau@google.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Yuanchu Xie <yuanchu@google.com>, 
 Yu Zhao <yuzhao@google.com>, "Dr. David Alan Gilbert" <dave@treblig.org>, 
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 "=?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?=" <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, 
 Eric Blake <eblake@redhat.com>, "T.J. Alumbaugh" <talumbau@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::d49;
 envelope-from=3Kd9vZAgKCtAFw7G8xwG2AA270.yA8C08G-z0H079A929G.AD2@flex--talumbau.bounces.google.com;
 helo=mail-io1-xd49.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

- Adds 'working_set_request', 'working_set_config' HMP functions

Start qemu with '-monitor telnet:127.0.0.1:4444,server=on,wait=off'

>> telnet localhost 4444

(qemu) working_set_config 200 800 3000 750 1000
(qemu) working_set_request
(qemu) qom-get /machine/peripheral/balloon0 guest-working-set
{
    "working_set": {
        "ws3": {
            "memory-size-bytes": {
                "anon": 298287104,
                "file": 647041024
            },
            "idle-age": 4294967292
        },
        "ws2": {
            "memory-size-bytes": {
                "anon": 4505600,
                "file": 2252800
            },
            "idle-age": 3000
        },
        "ws1": {
            "memory-size-bytes": {
                "anon": 1228800,
                "file": 614400
            },
            "idle-age": 800
        },
        "ws0": {
            "memory-size-bytes": {
                "anon": 409600,
                "file": 204800
            },
            "idle-age": 200
        }
    }
}

Signed-off-by: T.J. Alumbaugh <talumbau@google.com>
---
 hmp-commands.hx            | 26 ++++++++++++++++++++++++++
 hw/core/machine-hmp-cmds.c | 21 +++++++++++++++++++++
 include/monitor/hmp.h      |  2 ++
 3 files changed, 49 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 2cbd0f77a0..8ed044b23f 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -1398,6 +1398,32 @@ SRST
   Request VM to change its memory allocation to *value* (in MB).
 ERST
 
+    {
+        .name       = "working_set_config",
+        .args_type  = "i0:i,i1:i,i2:i,refresh:i,report:i",
+        .params     = "bin intervals 0-2, refresh and report thresholds",
+        .help       = "Working Set intervals, refresh/report thresholds (ms)",
+        .cmd        = hmp_working_set_config,
+    },
+
+SRST
+``working_set_config``
+  Set the intervals (in ms), refresh, report thresholds for Working Set reporting
+ERST
+
+    {
+        .name       = "working_set_request",
+        .args_type  = "",
+        .params     = "",
+        .help       = "Request the Working Set of the guest.",
+        .cmd        = hmp_working_set_request,
+    },
+
+SRST
+``working_set_request``
+  Request the Working Set from the guest.
+ERST
+
     {
         .name       = "set_link",
         .args_type  = "name:s,up:b",
diff --git a/hw/core/machine-hmp-cmds.c b/hw/core/machine-hmp-cmds.c
index c3e55ef9e9..3c0a7694a2 100644
--- a/hw/core/machine-hmp-cmds.c
+++ b/hw/core/machine-hmp-cmds.c
@@ -237,6 +237,27 @@ void hmp_balloon(Monitor *mon, const QDict *qdict)
     hmp_handle_error(mon, err);
 }
 
+void hmp_working_set_request(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_working_set_request(&err);
+    hmp_handle_error(mon, err);
+}
+
+void hmp_working_set_config(Monitor *mon, const QDict *qdict)
+{
+    uint64_t i0 = qdict_get_int(qdict, "i0");
+    uint64_t i1 = qdict_get_int(qdict, "i1");
+    uint64_t i2 = qdict_get_int(qdict, "i2");
+    uint64_t refresh = qdict_get_int(qdict, "refresh");
+    uint64_t report = qdict_get_int(qdict, "report");
+    Error *err = NULL;
+
+    qmp_working_set_config(i0, i1, i2, refresh, report, &err);
+    hmp_handle_error(mon, err);
+}
+
 void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
 {
     Error *err = NULL;
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index 13f9a2dedb..a1e6c5e92a 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -59,6 +59,8 @@ void hmp_nmi(Monitor *mon, const QDict *qdict);
 void hmp_info_network(Monitor *mon, const QDict *qdict);
 void hmp_set_link(Monitor *mon, const QDict *qdict);
 void hmp_balloon(Monitor *mon, const QDict *qdict);
+void hmp_working_set_config(Monitor *mon, const QDict *qdict);
+void hmp_working_set_request(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
-- 
2.41.0.rc0.172.g3f132b7071-goog


