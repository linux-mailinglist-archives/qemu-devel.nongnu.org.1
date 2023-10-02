Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EBC17B5574
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 16:52:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnKGW-0004ad-Db; Mon, 02 Oct 2023 10:51:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnKGQ-0004Z4-5U
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:51:15 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnKGL-0002ia-M3
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 10:51:12 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3226cc3e324so15509229f8f.3
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 07:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696258267; x=1696863067; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=orhq1PJZDoPKy8xHZuyWsMeErcuX16uJJZ3QYCyEs3I=;
 b=pRPNKRBY2ECMiAtfp6EtJZCkQtrJWpVaMUVuOvJwCCIBkL6+wCg6PSZmhdjDeDK+/2
 I2c/MI4C7O+spzpxwnl6YCLn2fANAZjoD38mW8Jn/dmOuotUTsB+ejfH1PRM4M9eUyEi
 PnwJmlzhxhGc9PgmOsx3dDdDMECjzmt9I637DON/TAEuostSjQBJMxGBkPtWYWsQ7dSk
 hlM6b6sb0R0/7RvWNU2hIOEsN0Gd20cCK3t3pwcQnDwwXkcYPu/WbKWHYjdx6yjOxsi9
 wqQl8WRwUfXVCEsP7Wms0hxZ9P/uLHNc9h4l1w+BNS0008qyzTiMgiJmI9qlEfklZ8Z1
 SnKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696258267; x=1696863067;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=orhq1PJZDoPKy8xHZuyWsMeErcuX16uJJZ3QYCyEs3I=;
 b=gjXHgeW9eCRlwIQVa/l9udEJ7spNnjeuTpUj7szsxIJhgFEuvinxiRl25OlCpGb/jk
 sv7q2+reP17XFDyUpdaRj7Gkzb13ngx0cAWrwdFy2Gzh7kiLHHKJH/zyDXs21TcYdSZz
 WZEPOxz+Dzs5n3wNdVRy1did8+YFcGFDnQxLXirf24Fu/wpMindvBrWIgYHGPj6++ODM
 SbxUtV4Oi4CHH1WsjY83v+9C0V1n2eFXMYOjUpOE0kiz61IAiJ7rc+aXesO8mNePxTMp
 eSM9X95dtl1mr18JPY4NKB3YRXVvDukQvaHehrr/yA9PoL9Lq/PO9KcAkhnU+rU34dwW
 YjIA==
X-Gm-Message-State: AOJu0YyPC68ykeEg6oH0KmmfNJPHk0EFLFccFdAqcwN7xNz48RsKz6DT
 0Z+mLnFFF21TGnzNdP94YMB43EFpz5S9ZR+13aK7bg==
X-Google-Smtp-Source: AGHT+IEfcJ39jrU4bJnQ7E/4UpGul+XN4Wh1sNsz7bMtpb4CwmiQnZc85ZYilZbCO1Z+8IowZLAQPg==
X-Received: by 2002:adf:f28b:0:b0:320:8d6:74f5 with SMTP id
 k11-20020adff28b000000b0032008d674f5mr10335338wro.28.1696258267575; 
 Mon, 02 Oct 2023 07:51:07 -0700 (PDT)
Received: from m1x-phil.lan (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 y5-20020adfd085000000b003217c096c1esm9474253wrh.73.2023.10.02.07.51.06
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 02 Oct 2023 07:51:07 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Beraldo Leal <bleal@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PATCH 0/2] tests: Drop mentions of SoftMMU
Date: Mon,  2 Oct 2023 16:51:02 +0200
Message-ID: <20231002145104.52193-1-philmd@linaro.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

We want to clarify when code depends on a software
MMU, or when it depends on TCG system emulation.

This series replaces 'softmmu' by TCG when relevant,
or simply remove it.

Philippe Mathieu-Daudé (2):
  tests/vm/ubuntu.aarch64: Correct comment about TCG specific delay
  tests/unit/test-seccomp: Remove mentions of softmmu in test names

 tests/unit/test-seccomp.c | 24 ++++++++++++------------
 tests/vm/ubuntu.aarch64   |  2 +-
 2 files changed, 13 insertions(+), 13 deletions(-)

-- 
2.41.0


