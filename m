Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B9768B39525
	for <lists+qemu-devel@lfdr.de>; Thu, 28 Aug 2025 09:27:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urX1t-0004T2-LG; Thu, 28 Aug 2025 03:26:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1M-0004GU-Nt; Thu, 28 Aug 2025 03:26:11 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wilfred.opensource@gmail.com>)
 id 1urX1H-0005Mm-LQ; Thu, 28 Aug 2025 03:26:08 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-246151aefaaso14169815ad.1; 
 Thu, 28 Aug 2025 00:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1756365961; x=1756970761; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RjacYaLKOhLtcN2plgF+C3NWVsLcWnhBIR1v/WVcDRc=;
 b=k21dXQYdRkKwUuT+EnmLGb3KoEDAa6pkfDeshRRdxHC0F/yKZ/dy3vegR0o3GQt7+2
 9M4KKVCwFDRR/VHRWAGhbzsQ7O5NcxtVUNKyX3E6dI7/OpDZb603H3VIu9cy9NyOQ8Gd
 oeuoJw0RdPNhE4EW4K5L1/i/jjnQWKIipUr6WRjfNdEgAjBtI5MdI9o0Pr9LVdkPYQVU
 rgU+muX4ijbA51aiVa0jzviHVSte25JwzwzbdXiZKdIk4v9JFH7e87M3vWZWEX9cKZ39
 BkIJkoo14FrmkZSEJ0stJks4M5QfvG0yI1P1RwEy+UdmvpalyZOyfBIa0CokscDSPU1z
 S4BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756365961; x=1756970761;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=RjacYaLKOhLtcN2plgF+C3NWVsLcWnhBIR1v/WVcDRc=;
 b=ncIPOP3jLJMaLK9somrm1WuFv52FpEM1LJpXu3cy6axrdQXF/5R5GTIt6IWQJSpHqp
 IwtQjrlaJFUnhEizhOAl6kXZ1zO5Ic66sWtqyR+NX3kCgySQtcpIQY822ArDQCKh2KcW
 0ZnnedhhibcgOfH7X71g5r/rnK2+NopnNH6FaU+NWfjYrjLMPLs4apct9qyQbGxUtplk
 eKrMuE8FbUZEBEfM156Q8gkVXuAWQOFvNt8pDpAQmnnkkFEFbq4Qbo2wbDR+KcqBy0x9
 rWIuWd4j5THjeSZX/kVZ+D2lyaglZ7xtU3n+z/X7vLLqWyKa8OnbKbn/HmtFOAm1LvUz
 cWcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeakmmkezw6mOiPwpxjOMB7QY5RZQPel1OEdgtkkS9zA7+f+Z5d0IgX22b0Whe57OMIy9dT+m6Q/h7Fg==@nongnu.org,
 AJvYcCV3KU9Wu+NBvRVRX+NCc5p6tpIIxkXHv7UWqij6dNdI1Pugtk04cGG61f3J4PMRmCA07JYuSLQSW90s@nongnu.org
X-Gm-Message-State: AOJu0YwbpHNvywmshN84nK3cDQem+FCDhyb78+Kl+7ZmtpDp3WxpHpOZ
 gv6NkT3bfwdCck18wpuubjNGgvProf8ARXIxVkxIJvZx5OIyZwPDapzM
X-Gm-Gg: ASbGncuTfYORnGjwNN133f5Fqfbri/tzHntw4NwVn83LhfTSAkzYy7zqLNAyGMAUIMy
 n2vihvh3fvinUg5csLvKLiqLipyF2n85T9v0a1olkIo5cmmHqNlJkD0exCx6tRuivz68YsRiSYW
 r7WvEvTvOKHJY8M+bysKUH/QVuU3RbIxgN4ei1Nb4Y6hPLEo1/7Y5TRYvSkxBMnr6fFZZnVg1Az
 vp7vM7p8I7AxwZQetxietBInRRZSG2aqrRF4z4Lg3i89mwPbd2jeANnCAMZRhmmpNm2oFDq+HFu
 Lok7rSZ4QynlTN9nTJBhh9Jp9vw7bnqQ7kRGmpxgXJo5mXRujVOvGgtmruJmunyNk40okIKTCK/
 cA3wfBF4npev3vBi+zeGD5lx7Py9fauxtxtAr
X-Google-Smtp-Source: AGHT+IEaiU6QgRcG8htPDvaxwJq7c3fZMpgwcWvJeNKCz/xC/tgpHeBjnRoR5czn+mauKhxLWSiG4Q==
X-Received: by 2002:a17:902:e5cc:b0:246:d5b3:6310 with SMTP id
 d9443c01a7336-2487539f6b8mr91260575ad.23.1756365961394; 
 Thu, 28 Aug 2025 00:26:01 -0700 (PDT)
Received: from fedora ([159.196.5.243]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24884a629fcsm51009775ad.19.2025.08.28.00.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Aug 2025 00:26:00 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Cc: Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Wilfred Mallawa <wilfred.mallawa@wdc.com>
Subject: [PATCH v2 1/5] spdm-socket: add seperate send/recv functions
Date: Thu, 28 Aug 2025 17:25:29 +1000
Message-ID: <20250828072532.425592-3-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250828072532.425592-2-wilfred.opensource@gmail.com>
References: <20250828072532.425592-2-wilfred.opensource@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=wilfred.opensource@gmail.com; helo=mail-pl1-x634.google.com
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

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

This is to support uni-directional transports such as SPDM over Storage.
As specified by the DMTF DSP0286.

Also update spdm_socket_rsp() to use the new send()/receive() functions. For
the case of spdm_socket_receive(), this allows us to do error checking
in one place with the addition of spdm_socket_command_valid().

Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 backends/spdm-socket.c       | 56 +++++++++++++++++++++++++++++-------
 include/system/spdm-socket.h | 35 ++++++++++++++++++++++
 2 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/backends/spdm-socket.c b/backends/spdm-socket.c
index 2c709c68c8..3d264814df 100644
--- a/backends/spdm-socket.c
+++ b/backends/spdm-socket.c
@@ -184,28 +184,62 @@ int spdm_socket_connect(uint16_t port, Error **errp)
     return client_socket;
 }
 
-uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
-                         void *req, uint32_t req_len,
-                         void *rsp, uint32_t rsp_len)
+static bool spdm_socket_command_valid(uint32_t command)
+{
+    switch (command) {
+    case SPDM_SOCKET_COMMAND_NORMAL:
+    case SPDM_SOCKET_STORAGE_CMD_IF_SEND:
+    case SPDM_SOCKET_STORAGE_CMD_IF_RECV:
+    case SOCKET_SPDM_STORAGE_ACK_STATUS:
+    case SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE:
+    case SPDM_SOCKET_COMMAND_CONTINUE:
+    case SPDM_SOCKET_COMMAND_SHUTDOWN:
+    case SPDM_SOCKET_COMMAND_UNKOWN:
+    case SPDM_SOCKET_COMMAND_TEST:
+        return true;
+    default:
+        return false;
+    }
+}
+
+uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+                             void *rsp, uint32_t rsp_len)
 {
     uint32_t command;
     bool result;
 
-    result = send_platform_data(socket, transport_type,
-                                SPDM_SOCKET_COMMAND_NORMAL,
-                                req, req_len);
-    if (!result) {
+    result = receive_platform_data(socket, transport_type, &command,
+                                   (uint8_t *)rsp, &rsp_len);
+
+    /* we may have received some data, but check if the command is valid */
+    if (!result || !spdm_socket_command_valid(command)) {
         return 0;
     }
 
-    result = receive_platform_data(socket, transport_type, &command,
-                                   (uint8_t *)rsp, &rsp_len);
+    return rsp_len;
+}
+
+bool spdm_socket_send(const int socket, uint32_t socket_cmd,
+                      uint32_t transport_type, void *req, uint32_t req_len)
+{
+    return send_platform_data(socket, transport_type,
+                              socket_cmd, req, req_len);
+}
+
+uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
+                         void *req, uint32_t req_len,
+                         void *rsp, uint32_t rsp_len)
+{
+    bool result;
+
+    result = spdm_socket_send(socket, SPDM_SOCKET_COMMAND_NORMAL,
+                              transport_type, req, req_len);
     if (!result) {
         return 0;
     }
 
-    assert(command != 0);
-
+    rsp_len = spdm_socket_receive(socket, transport_type, (uint8_t *)rsp,
+                                  rsp_len);
     return rsp_len;
 }
 
diff --git a/include/system/spdm-socket.h b/include/system/spdm-socket.h
index 5d8bd9aa4e..2b7d03f82d 100644
--- a/include/system/spdm-socket.h
+++ b/include/system/spdm-socket.h
@@ -50,6 +50,35 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
                          void *req, uint32_t req_len,
                          void *rsp, uint32_t rsp_len);
 
+/**
+ * spdm_socket_rsp: Receive a message from an SPDM server
+ * @socket: socket returned from spdm_socket_connect()
+ * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @rsp: response buffer
+ * @rsp_len: response buffer length
+ *
+ * Receives a message from the SPDM server and returns the number of bytes
+ * received or 0 on failure. This can be used to receive a message from the SPDM
+ * server without sending anything first.
+ */
+uint32_t spdm_socket_receive(const int socket, uint32_t transport_type,
+                             void *rsp, uint32_t rsp_len);
+
+/**
+ * spdm_socket_rsp: Sends a message to an SPDM server
+ * @socket: socket returned from spdm_socket_connect()
+ * @socket_cmd: socket command type (normal/if_recv/if_send etc...)
+ * @transport_type: SPDM_SOCKET_TRANSPORT_TYPE_* macro
+ * @req: request buffer
+ * @req_len: request buffer length
+ *
+ * Sends platform data to a SPDM server on socket, returns true on success.
+ * The response from the server must then be fetched by using
+ * spdm_socket_receive().
+ */
+bool spdm_socket_send(const int socket, uint32_t socket_cmd,
+                      uint32_t transport_type, void *req, uint32_t req_len);
+
 /**
  * spdm_socket_close: send a shutdown command to the server
  * @socket: socket returned from spdm_socket_connect()
@@ -60,6 +89,9 @@ uint32_t spdm_socket_rsp(const int socket, uint32_t transport_type,
 void spdm_socket_close(const int socket, uint32_t transport_type);
 
 #define SPDM_SOCKET_COMMAND_NORMAL                0x0001
+#define SPDM_SOCKET_STORAGE_CMD_IF_SEND           0x0002
+#define SPDM_SOCKET_STORAGE_CMD_IF_RECV           0x0003
+#define SOCKET_SPDM_STORAGE_ACK_STATUS            0x0004
 #define SPDM_SOCKET_COMMAND_OOB_ENCAP_KEY_UPDATE  0x8001
 #define SPDM_SOCKET_COMMAND_CONTINUE              0xFFFD
 #define SPDM_SOCKET_COMMAND_SHUTDOWN              0xFFFE
@@ -68,7 +100,10 @@ void spdm_socket_close(const int socket, uint32_t transport_type);
 
 #define SPDM_SOCKET_TRANSPORT_TYPE_MCTP           0x01
 #define SPDM_SOCKET_TRANSPORT_TYPE_PCI_DOE        0x02
+#define SPDM_SOCKET_TRANSPORT_TYPE_SCSI           0x03
+#define SPDM_SOCKET_TRANSPORT_TYPE_NVME           0x04
 
 #define SPDM_SOCKET_MAX_MESSAGE_BUFFER_SIZE       0x1200
+#define SPDM_SOCKET_MAX_MSG_STATUS_LEN            0x02
 
 #endif
-- 
2.51.0


