Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE7AA89661
	for <lists+qemu-devel@lfdr.de>; Tue, 15 Apr 2025 10:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4bWx-0000RE-F8; Tue, 15 Apr 2025 04:20:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4bW7-0006wx-Vv; Tue, 15 Apr 2025 04:19:42 -0400
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1u4bW6-0002gK-0m; Tue, 15 Apr 2025 04:19:39 -0400
Received: by mail-pj1-x1032.google.com with SMTP id
 98e67ed59e1d1-301918a4e1bso4091852a91.1; 
 Tue, 15 Apr 2025 01:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744705175; x=1745309975; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XrDiOYjsuFKr2Zw5X/tf1rgIMsS7YJEeIOntY/YtLzQ=;
 b=WxtVu91ia6wihIEodp9mV/2hN57Md+E2qo1ZJ95/k0RTjlYXfE5UxyzqXelFDxlABq
 Zm9r3S5wVqlcn4tGdWleLONpGtgzug8YLHg9K9TuZY1/MgOzJoD73DCuEcJ8LHQsvtU6
 vLC6HmYXN1XC09DrfN9vQhskqultkFh8TZzIJws+N8mOQW5mdkxyU2hMi1h/W1mJdDmG
 ml8R6I+eg1rmsdwThGEQlPMVj9yu+s5IbOkaiUIqVI5Z0S7xHQeEFFH3cHDg0ZI1nLui
 +H6z8UOUakgwD0XoohZWqxyfacPoWRrnXTsX+pLDJFK9mC4aiJWzuDVeCOu9/H3gIMJs
 s4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744705175; x=1745309975;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XrDiOYjsuFKr2Zw5X/tf1rgIMsS7YJEeIOntY/YtLzQ=;
 b=ap1hk1andNaCsHrh3vrVnpJeCQAjSoCvuZq5XB3OaLNx+kgzF3MVYPrWw/exCoC5es
 n1366Or686X92zgmTlT/pg7x9/cpqo3DjY/ZqeqG2fp/OetSFwbcE08Er8ZkiuQHMdqF
 kq0U3VSO3KucujfzsR2FUmZLB+Boos4GSxcDLRwbysaDqrbPKZ/qcJKKiCdo0MajxdFc
 WMjoMqCu1pybMBwnn+SQXLPVj0D5piRzwDVcuLVn4GGMitql5OTtCS0QxvwmhxkTzhYR
 rUUoq2bmun6+MrXE/LIaHU2oheSqHsTxzZORbUssnc4J+Xwqg2jE2HVcudEfUrcjk1Rp
 wRqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVvSn4FcHK1UHaVam7cLIyzEkyZOtesJxjvCkQ4nVfDsJEAp8kkQYTNheCcU04XA3ZBTBRTnce9/CbXsQ==@nongnu.org,
 AJvYcCW6onh/0ITTc+bnH3ParA1ueA0GfJqP0XleTzBogM4zNLwjVjCxBvbqrF+gRUbyvSJXR5NvQJWu3RV6@nongnu.org
X-Gm-Message-State: AOJu0YwI9C2rdvR5ue3g4RXs0wZ3ZOH3Qye0JEEuy/7b5+ln+0e0USXg
 YF2RkWcrLBpycZ5hqRfTUzh1W4zZwiuDP8ArZkUJ7qHNK5xH1MfHmiJKCA==
X-Gm-Gg: ASbGnctLyzSqH9Buv9eDHWym6jQl5lce3FByhbXrcG2iM1rdAKw6Xy+lLlK005o0gRf
 5I6mLPi/+oVTPFDWeG9q/LwhiEtOpIr5W2Mwe35R/X9fOUdYD9mJlzoqFDmXxX0FU2twOzeanO9
 zLScRwcWrXOj9GIFeW4Qcv/CUBwVyhIA/U64GtCfeT3/RQW73DCP4HBkgWddn06sdH10SIbj0Zs
 FooLUa8zaWuWvqRPtZ6FKykdXJVwe3JbrSMl9h5FN8BLyZRBHyC0HtDkdQOg07YXDQg9dyInoJL
 h2Jzj9Nhfbgoa+RNcAzWVyrjKezkF9V63yWlR/pBfajlnI4F5wCjw+lFxQSKaWldoQiXqAAVbpv
 4KR/5k0iFVM0vPGmNhTX1GprRVeLOBmg9qnzTBEHH
X-Google-Smtp-Source: AGHT+IFcGP2dFZiCMWuuGvpaIzTMhsxrLRNSBrpGHVVniy2h6MSPQ6SBV2/bd9yj4YXpqQP3XK4SRg==
X-Received: by 2002:a17:90b:6ce:b0:2ee:7c65:ae8e with SMTP id
 98e67ed59e1d1-30823670b82mr24718444a91.11.1744705175318; 
 Tue, 15 Apr 2025 01:19:35 -0700 (PDT)
Received: from wheely.local0.net
 (ppp118-208-164-196.cbr-trn-nor-bras39.tpg.internode.on.net.
 [118.208.164.196]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-306df08f63bsm12543098a91.24.2025.04.15.01.19.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Apr 2025 01:19:34 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Coiby Xu <Coiby.Xu@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Emanuele Giuseppe Esposito <e.emanuelegiuseppe@gmail.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
Subject: [RFC PATCH 0/2] tests/qtest: Enable spapr dma tests
Date: Tue, 15 Apr 2025 18:19:12 +1000
Message-ID: <20250415081914.378236-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1032;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1032.google.com
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

I took a look at the spapr buggy msix fixme in qtests... AFAIKS
it turns out to be DMA entirely broken due to iommu not set up.
Adding a quick workaround for spapr gets everything working
properly other than exposing bugs in msi message endianness
conversions.

Thanks,
Nick

Nicholas Piggin (2):
  tests/qtest: Fix virtio msix message endianness
  tests/qtest: Enable spapr dma with linear iommu map

 tests/qtest/libqos/pci.h               |  4 ----
 hw/ppc/spapr_iommu.c                   |  9 ++++++++-
 tests/qtest/e1000e-test.c              | 23 +++--------------------
 tests/qtest/igb-test.c                 | 21 ---------------------
 tests/qtest/libqos/generic-pcihost.c   |  1 -
 tests/qtest/libqos/pci-pc.c            |  3 ---
 tests/qtest/libqos/pci-spapr.c         |  7 ++++---
 tests/qtest/libqos/pci.c               | 14 --------------
 tests/qtest/libqos/virtio-pci-modern.c |  9 +++++++--
 tests/qtest/libqos/virtio-pci.c        |  7 +++++--
 tests/qtest/vhost-user-blk-test.c      |  6 ------
 tests/qtest/virtio-blk-test.c          | 12 ------------
 12 files changed, 27 insertions(+), 89 deletions(-)

-- 
2.47.1


