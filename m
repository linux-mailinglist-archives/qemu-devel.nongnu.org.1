Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E287FDF5E
	for <lists+qemu-devel@lfdr.de>; Wed, 29 Nov 2023 19:34:35 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8PN7-0008PT-Id; Wed, 29 Nov 2023 13:33:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8PN4-0008O0-6w
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:33:14 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r8PMz-0004l1-H7
 for qemu-devel@nongnu.org; Wed, 29 Nov 2023 13:33:13 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40b2ddab817so415035e9.3
 for <qemu-devel@nongnu.org>; Wed, 29 Nov 2023 10:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1701282787; x=1701887587; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aVwxodo2zusWStQM6g81KbgKbYTWKMyHf4Tq00VloAI=;
 b=Y7ILW0LXNYulHg1fI6GHmKQE2gZyHmbQaop17cwjlLjiSQhFFerwopt+iezIyf/V/H
 yKRJk1F7q+cnYMX0EMX1y5GG92Zc7zQk2lR6GBR3kRml2oBeO5+uTi7WTi139VMET78F
 q3hgd8Lk1MRH2qjWGJjDBcUeX+WAjEYwKzmBehXhAnvoUj039vQz0MGv5KRO+TmnYQj/
 WvZHFKyKlj0NitnD8DQoeX6lNf+Oa646HIUC7onh1x7GXJWbo6h++Z6WfpswBPQGIgwW
 GkcUCIr88V3jWhLOebRWKKezoolRDHSGCCxfz9Uj4gXS/eoLicrRDsMYuqOaO5NNQ5+g
 onfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701282787; x=1701887587;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVwxodo2zusWStQM6g81KbgKbYTWKMyHf4Tq00VloAI=;
 b=eUqmiQuEPbuBz9F+b52gLKWjy0T+s2tA6mCMU8D5to32heyO/WD+48eX90FFLDaiyq
 WUpgwm9yr3cZKGaQ5MUJ0tk25QS2q1LEt6LDFT9vsiMC7ssMOIR41ivTvAM6v51zif9V
 /YS6Ee9bVKS8OYWxdVC+Yfdze8EV4hrSkIiSzN6m36AIuQMjchoVOeBQcpojzhLKdwqK
 g/AW0rk9gCvt4WTQhI8U4DsLY6E89kRQXxmm4JxSgTezRc4Ketyxq0GGSBANQD8zKKdi
 vdq5QHsyZTGMie3/mkvvgqjc3h0idAIhVRfeL6Vf7Ox3p+tQWYQL6HLKo9s3ni/7F/oQ
 Zlqg==
X-Gm-Message-State: AOJu0Yy8SesVr7n0oqja0MNmCosglfot9MInxhs+6lSu2ArJQCYIlOuW
 ocZSvT5L3rRg1IRhqypnuLORE/BRJaBb/Yk9JnldiA==
X-Google-Smtp-Source: AGHT+IFVPyGrxMzWoKOegeDj+25aYq2UhcQV4GmSbQYrZyicVPMeJWkNawWSWVt/3/iDUyBNu/Fc3g==
X-Received: by 2002:a05:600c:4ec7:b0:40b:4b69:b189 with SMTP id
 g7-20020a05600c4ec700b0040b4b69b189mr4594454wmq.26.1701282786696; 
 Wed, 29 Nov 2023 10:33:06 -0800 (PST)
Received: from localhost.localdomain (28.red-95-127-46.staticip.rima-tde.net.
 [95.127.46.28]) by smtp.gmail.com with ESMTPSA id
 fk14-20020a05600c0cce00b0040b2a52ecaasm3147617wmb.2.2023.11.29.10.32.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 29 Nov 2023 10:32:59 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>
Subject: [PATCH] hw/core/cpu: Update description of CPUState::node
Date: Wed, 29 Nov 2023 19:32:43 +0100
Message-ID: <20231129183243.15859-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

'next_cpu' was converted to 'node' in commit bdc44640cb
("cpu: Use QTAILQ for CPU list").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/hw/core/cpu.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 134ecb907e..3208b938f7 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -430,7 +430,7 @@ struct qemu_work_item;
  * @gdb_regs: Additional GDB registers.
  * @gdb_num_regs: Number of total registers accessible to GDB.
  * @gdb_num_g_regs: Number of registers in GDB 'g' packets.
- * @next_cpu: Next CPU sharing TB cache.
+ * @node: QTAILQ of CPUs sharing TB cache.
  * @opaque: User data.
  * @mem_io_pc: Host Program Counter at which the memory was accessed.
  * @accel: Pointer to accelerator specific state.
-- 
2.41.0


