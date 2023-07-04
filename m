Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A92746B81
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 10:07:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGb3l-0006mF-FI; Tue, 04 Jul 2023 04:06:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3k-0006li-3z
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:52 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1qGb3g-0000rN-Dp
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 04:06:51 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6686ef86110so2564275b3a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 01:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20221208.gappssmtp.com; s=20221208; t=1688458006; x=1691050006; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=dSQNJxzoGgRyw577WtrT9Nv069O9k73QukTdwTWMRR4=;
 b=vLXeIB7xMiD2N7YTVOMOjzSAjrfZ5g0aTW/pyExJ5k6bP9AoNg8raAEQcvgEDukh83
 syOIX8vwBcLNnQ6W0LfManihW3nVNjj8vNQC+em12LX2GglCa5XqLRXmn2ZxafxhuYm8
 qdESxtgytEl+XZ+r+n4bHZWUw1HOaf/xbBCXu5J1VWCeD6EBfoYtewvVj/MTMdZ3WXtZ
 EIhOaqxqM8yGcqW+TQ0PFzB1DlDTcZ+rlOy+jbfoU4RHnf8i6c0Zx2Q8Ru/DzlBGABwq
 dJH8TtAkxlD47Kl3++g+t0LGgg1QrFzfGtkYX9rUVW0GFfCUUMVpuJZrkVCl/FKMzuDq
 JA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688458006; x=1691050006;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dSQNJxzoGgRyw577WtrT9Nv069O9k73QukTdwTWMRR4=;
 b=aEOwCMN/y6A8Kn5NEQ84RMLHYWOPv87xwrzi5mBAFDwCd1JWpVy+Dx2I3Q9MDZOlq2
 g2ORALAWWib+SD/nQNflJIzhTDNsXtrpoB8TMNaltQ3mcrGvPdlJV/EZdiWJfGljGoNA
 4S5gOYQC0pautkjfMr1a+1gH6SK49ECIkhkG6VY2uHHMsUFCsTmuHgNtXwybI8NS1eOp
 giqlTXXbFP3qO+tIxELd1oBa7OHL9yyCPzA3/gNaJdBSnxukL2miWIABfSQVlOlgFfMP
 0rzi12/piuzNr5GhU2CBYi3We9VzZYeIpe5e73wLwo42IWqCoaSMneySTZi68tre0iT9
 /hRg==
X-Gm-Message-State: ABy/qLYo37Ywmshy3J3ijiQhBO7didMflR1K6C4+Q4B2EMnZguimwsf7
 n4a7+zaS1wpuJa9lz+FtDTtIJHOboN+Ko2ur54KUVw==
X-Google-Smtp-Source: APBJJlEA1H/lyb4hg9CTLFyWFRfGnUQS9qB3Yl1nDQIrhPeOgshnjyv9OIZ7BgJFcgP36k22cDWq9w==
X-Received: by 2002:a05:6a00:158b:b0:668:94a2:2ec7 with SMTP id
 u11-20020a056a00158b00b0066894a22ec7mr13200624pfk.25.1688458005726; 
 Tue, 04 Jul 2023 01:06:45 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([66.220.2.162])
 by smtp.gmail.com with ESMTPSA id
 u1-20020aa78381000000b00662c4ca18ebsm15113101pfm.128.2023.07.04.01.06.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 01:06:45 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 stefanha@redhat.com, David Hildenbrand <david@redhat.com>,
 john.levon@nutanix.com, Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH 0/3] Support message-based DMA in vfio-user server
Date: Tue,  4 Jul 2023 01:06:24 -0700
Message-Id: <20230704080628.852525-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series adds basic support for message-based DMA in qemu's vfio-user
server. This is useful for cases where the client does not provide file
descriptors for accessing system memory via memory mappings. My motivating use
case is to hook up device models as PCIe endpoints to a hardware design. This
works by bridging the PCIe transaction layer to vfio-user, and the endpoint
does not access memory directly, but sends memory requests TLPs to the hardware
design in order to perform DMA.

Note that in addition to the 3 commits included, we also need a
subprojects/libvfio-user roll to bring in this bugfix:
https://github.com/nutanix/libvfio-user/commit/bb308a2e8ee9486a4c8b53d8d773f7c8faaeba08
Stefan, can I ask you to kindly update the
https://gitlab.com/qemu-project/libvfio-user mirror? I'll be happy to include
an update to subprojects/libvfio-user.wrap in this series.

Finally, there is some more work required on top of this series to get
message-based DMA to really work well:

* libvfio-user has a long-standing issue where socket communication gets messed
  up when messages are sent from both ends at the same time. See
  https://github.com/nutanix/libvfio-user/issues/279 for more details. I've
  been engaging there and plan to contribute a fix.

* qemu currently breaks down DMA accesses into chunks of size 8 bytes at
  maximum, each of which will be handled in a separate vfio-user DMA request
  message. This is quite terrible for large DMA acceses, such as when nvme
  reads and writes page-sized blocks for example. Thus, I would like to improve
  qemu to be able to perform larger accesses, at least for indirect memory
  regions. I have something working locally, but since this will likely result
  in more involved surgery and discussion, I am leaving this to be addressed in
  a separate patch.

Mattias Nissler (3):
  softmmu: Support concurrent bounce buffers
  softmmu: Remove DMA unmap notification callback
  vfio-user: Message-based DMA support

 hw/remote/vfio-user-obj.c |  62 ++++++++++++++++--
 softmmu/dma-helpers.c     |  28 --------
 softmmu/physmem.c         | 131 ++++++++------------------------------
 3 files changed, 83 insertions(+), 138 deletions(-)

-- 
2.34.1


