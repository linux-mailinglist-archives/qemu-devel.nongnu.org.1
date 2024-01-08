Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78A3E826F0A
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 13:54:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMp8Z-0002rW-3E; Mon, 08 Jan 2024 07:53:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMp8X-0002pY-4s
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:53:49 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMp8V-0006ES-8W
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 07:53:48 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-40d87df95ddso19852715e9.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 04:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704718425; x=1705323225; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VV9/+OLmK5xN+yi6h1UWmlCcRSnCJF6qnpWCvfwCLLc=;
 b=bMr1zPrcH2I5vRM4URbW+MsfJzfiYk9CBrJ9f3SiHzjp7dFSyNJRGiXU7zZom2/Hk2
 05kWWaf7dgxBmqz7/MDhDPd6Uvzj8zvbhnO3XgrXqpmnlq2KL5Eve+sdsmt+YYNRwWVy
 yMmThUpg+snXNatcvZzHDG6Q3b+EoCmsmqvMSmL/Rd0lTaeCrK4JdgfK6RLk6RWweoZ6
 bEQhzRzU7uhFSZBPaYOq2E1Hpkfpx4K8AZgqLHNabAbMW/nG8Rq/K5fBlAh6JAKb5Vcp
 RD99kUlvb10atF7qk3O2d3oiFFgUo+IoaKGZxDW3MYx8+s61gcnJ8N88mWCJRDs0OQJ6
 SPAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704718425; x=1705323225;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VV9/+OLmK5xN+yi6h1UWmlCcRSnCJF6qnpWCvfwCLLc=;
 b=BFLF4EH9BwIiJTJIVy//gooj4nNNexOgLm/rI84aIDbnFwbx2ZdsqQQtRWh8lDYdNu
 v+DM0yb+xVvar0n8ui8Te57Vj/Usnnr5EwtBzq2PgbR1s59gD+iajQUHuguHg7wdAI1e
 RTuEXJKWogOOieORD4V08maSJ5KRCy9jNRXR8/yBHbEqr0BLrirgBoFEEEbJypdlehUG
 SsFm36A25DM9uGiD9HA6mtAAL/wgMLsOsRY1C72CFeo8Af8f29+E+s37qXiI6mH3VWhf
 h2xw4oJKlPPqss81ZocgMdSvlpJkvR0MjxVNQP6BWDujs4XwIQB+IuxVVMXOjWugNOSE
 5fcA==
X-Gm-Message-State: AOJu0Yyu5EKK8WyzNOB8Zk522FAtn3YNGlOSoiZsYz4chrq3o3KdA851
 qmflpRkMRKBmWK3r9kCX80uyF+p4CFE00w==
X-Google-Smtp-Source: AGHT+IGZrVLQgniQBbWWZxvtx3WpQsJN/JB7XB8RLNg6WzilQvnQM7/smx6/LleiXmrqd8d72fDqjg==
X-Received: by 2002:a05:600c:4515:b0:40d:3bd1:3dce with SMTP id
 t21-20020a05600c451500b0040d3bd13dcemr940174wmo.305.1704718425431; 
 Mon, 08 Jan 2024 04:53:45 -0800 (PST)
Received: from localhost.localdomain ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 je4-20020a05600c1f8400b0040e38b7cfdasm11020634wmb.4.2024.01.08.04.53.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 08 Jan 2024 04:53:45 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Gerd Hoffmann <kraxel@redhat.com>,
	qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/2] hw/pflash: implement update buffer for block writes
Date: Mon,  8 Jan 2024 13:53:40 +0100
Message-ID: <20240108125342.48298-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Respin of Gerd's series [*] using the LD/ST API.

v1 [*] cover:

  When running qemu with edk2 efi firmware on aarch64 the efi
  variable store in pflash can get corrupted.  qemu not doing
  proper block writes -- flush all or nothing to storage -- is
  a hot candidate for being the root cause.

  This little series tries to fix that with an update buffer
  where block writes are staged, so we can commit or discard
  the changes when the block write is completed or canceled.

[*] https://lore.kernel.org/qemu-devel/20240105135855.268064-1-kraxel@redhat.com/

Gerd Hoffmann (1):
  hw/pflash: implement update buffer for block writes

Philippe Mathieu-Daudé (1):
  hw/block/pflash_cfi01: Use the LD/ST API in pflash_data_read/write

 hw/block/pflash_cfi01.c | 165 +++++++++++++++++++++-------------------
 1 file changed, 86 insertions(+), 79 deletions(-)

-- 
2.41.0


