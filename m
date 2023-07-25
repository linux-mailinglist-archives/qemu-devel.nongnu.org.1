Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 094DA761642
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 13:38:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOGLI-0001yU-6h; Tue, 25 Jul 2023 07:36:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOGLF-0001y2-J9
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:36:37 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qOGLD-0007oM-Tb
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 07:36:37 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-316eabffaa6so4040966f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 04:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690284994; x=1690889794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bC0bCZ58IqNs3NqhqGiDnifR7I06Ib8a2gTe2OIYgyk=;
 b=DxLsfi1KSNWceDtjDZtGQD1Rl4pXbMEQADx2+pipGvZcQKHZ76iVWzmr/r29nyhVds
 r2ZGdC2234FL1uvTr11pgDjynIqBbk7laVXg+FDb8kuO5VRc1Rk5Z5F6tGNv3h7ClHHx
 WxmzrHDpOiaunVBOXJ1uMhapRMUoiMJRFzdKa0PyQp3S/ld+tCboOrnnYAns9l86I+bw
 Sx5ui0U6q+EG8fALeN4qZfNfUigTZTlb7nldv4KEaZd5QGQWUzVTNCt1uO9ioBPku7xy
 viOc0uxacXiWJRwcziO5Fs3Re2JDod5oaB5IvgQfu0Uzis4ZwW4I9iOSyyp5IMe8605Q
 55qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690284994; x=1690889794;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bC0bCZ58IqNs3NqhqGiDnifR7I06Ib8a2gTe2OIYgyk=;
 b=C8ht5qtDu+qlnJkbVDcclsYawXLUntN8G9iXvezh6A6jfkbWPChg4ha8mkm5zKRkuW
 NGUHboRH0Tr8DQSGaP8r0D8mXuqGj3Utjbr1HqA0URx/7Q7KOKduypDNcHGCM3mI1uAM
 KtJfvknBih/ukMC4oLrZrw6dDv0IbBDPZPHy1SZNJ0geelZ6PZS5K0uYHuiadDkaLCHt
 T8FM/x/0ldbwq7nphonS1h4WOOxsk+ybse2kPUmcLKDauTFr13aGQsZ/4MuatwmWbzIw
 dn5lsxoJi/MPGvpDkuYNKai64xiJ4y80mMXWHxPuWRZOoRUScKSICNv5qLoq5t+WIZW+
 Ilrg==
X-Gm-Message-State: ABy/qLYwQ27I3Idgc2ZznAxozXn6RJPGCGWCXiCsu/MAufABz0EiBBQj
 xotQO0ltxlcICL8K6dF/X4wi1SO13IenJs0zymg=
X-Google-Smtp-Source: APBJJlFDt6x+db+7PjHK62TROdghcr3FNlHXv1qGWcqlCQ3M/RLIn+WjiE6xOJEZGESKjEAeXGTjHw==
X-Received: by 2002:adf:f1c4:0:b0:315:a043:5e0a with SMTP id
 z4-20020adff1c4000000b00315a0435e0amr9096563wro.56.1690284993979; 
 Tue, 25 Jul 2023 04:36:33 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 m9-20020a5d56c9000000b00313e2abfb8dsm16263596wrw.92.2023.07.25.04.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Jul 2023 04:36:33 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Yuval Shaia <yuval.shaia.ml@gmail.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Subject: [PATCH for-8.1] hw/rdma/vmw/pvrdma_cmd: Use correct struct in
 query_port()
Date: Tue, 25 Jul 2023 12:36:32 +0100
Message-Id: <20230725113632.2386874-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x435.google.com
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

In query_port() we pass the address of a local pvrdma_port_attr
struct to the rdma_query_backend_port() function.  Unfortunately,
rdma_backend_query_port() wants a pointer to a struct ibv_port_attr,
and the two are not the same length.

Coverity spotted this (CID 1507146): pvrdma_port_attr is 48 bytes
long, and ibv_port_attr is 52 bytes, because it has a few extra
fields at the end.

Fortunately, all we do with the attrs struct after the call is to
read a few specific fields out of it which are all at the same
offsets in both structs, so we can simply make the local variable the
correct type.  This also lets us drop the cast (which should have
been a bit of a warning flag that we were doing something wrong
here).

Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I don't know anything about the rdma code so this fix is based
purely on looking at the code, and is untested beyond just
make check/make check-avocado.
---
 hw/rdma/vmw/pvrdma_cmd.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/rdma/vmw/pvrdma_cmd.c b/hw/rdma/vmw/pvrdma_cmd.c
index c6ed0259821..d31c1875938 100644
--- a/hw/rdma/vmw/pvrdma_cmd.c
+++ b/hw/rdma/vmw/pvrdma_cmd.c
@@ -129,14 +129,13 @@ static int query_port(PVRDMADev *dev, union pvrdma_cmd_req *req,
 {
     struct pvrdma_cmd_query_port *cmd = &req->query_port;
     struct pvrdma_cmd_query_port_resp *resp = &rsp->query_port_resp;
-    struct pvrdma_port_attr attrs = {};
+    struct ibv_port_attr attrs = {};
 
     if (cmd->port_num > MAX_PORTS) {
         return -EINVAL;
     }
 
-    if (rdma_backend_query_port(&dev->backend_dev,
-                                (struct ibv_port_attr *)&attrs)) {
+    if (rdma_backend_query_port(&dev->backend_dev, &attrs)) {
         return -ENOMEM;
     }
 
-- 
2.34.1


