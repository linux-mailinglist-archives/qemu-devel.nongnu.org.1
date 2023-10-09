Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B27F97BDCFD
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 15:00:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpprh-0002M2-O9; Mon, 09 Oct 2023 09:00:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qpprd-0002Kv-Ed
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:01 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qppra-0001Vd-Ll
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 09:00:01 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2774f6943b1so3356135a91.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 05:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1696856274; x=1697461074;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ExH8dTqKU6OO/aV8I3AFKwIQLGpPjlwn9+mq0mwG6GQ=;
 b=XFazIEGFmhWQRDabOmQmi4zJJ4IvBqdsQAv+MVi2tTtrGwFQFCowlFSzXXpxr8Stlq
 Xg9kaA08ygqCEFQqI//BV7AinVhRNPzxtPWSuvfGEuWT9gWNFfZLeW4rJobt3DQrz+Ub
 W8SeBBFc5Dw9kH+mfs5/m9iazhqdnc1+RLEUiGtXIt3UrpQrDRbSn+TXP8IThTqKOdtk
 DLGTfbz9llrSoFQ07VOrHIgkKjeAsAllT39Kh5PBkcotjyGUVQhGMnKfaswLu0Bkqz1u
 Rjw1NrspBmLrwXMdHnkv+wRVfg+g+FRQulyCpOqDTI9R3JiHhpYQD99buodcdB6OiHDb
 DqAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696856274; x=1697461074;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ExH8dTqKU6OO/aV8I3AFKwIQLGpPjlwn9+mq0mwG6GQ=;
 b=ujb98Dmlgh0BIm1/DdU9ZwWmJJuXCGIAK8JSqQOaCHNKV39rpKr1i1STBfOqujPqmj
 fsjTAAZo24IskyDmuyLAoE98aKL3KPEzGQSh7oVXGBoILmb4h8d/E4ktQxsRKZo5WLB4
 BPzfZBMQLt369N5dXtHPFiwvjL6jl+BPLxhULLfgmTMFFnl1o8NSrr0Ce6JML1AY3wgQ
 SEKZfhQ6qN1T5B1Hdq0PoRzlPRUCDNU32ILFAMEWf93sK0uia9UUKjGhIIWLLBw9Ai1G
 bTaLRA5bWiKp2puGwNTarQxi4vHZmu7eSUx3Mis+GYKIZVR1eYPY3ZMr4vvUwTX78MHH
 Rk7Q==
X-Gm-Message-State: AOJu0YzjBSiubvOOxyqp8U6+4PutBulDVV/DVZ49Tx3xUsyS6X9DnvoM
 PvfVPZHJhXuRJv4E+IupffkuXe4kfkaS4WEOo6F6QQ==
X-Google-Smtp-Source: AGHT+IFdbuTjJjthtZvmh0lmNxrOtrV92gXhJsPlL7W3RosAREtWVe2ZOmSAgiR9/U3ojqjuTNIDMA==
X-Received: by 2002:a17:90a:2a42:b0:268:b64b:f684 with SMTP id
 d2-20020a17090a2a4200b00268b64bf684mr13387158pjg.33.1696856273616; 
 Mon, 09 Oct 2023 05:57:53 -0700 (PDT)
Received: from localhost.localdomain ([118.114.95.207])
 by smtp.gmail.com with ESMTPSA id
 l12-20020a17090aec0c00b00268b439a0cbsm8300146pjy.23.2023.10.09.05.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Oct 2023 05:57:52 -0700 (PDT)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: Hyman Huang <yong.huang@smartx.com>
Subject: [PULL 0/2] Dirty page rate and dirty page limit 20231009 patches  
Date: Mon,  9 Oct 2023 20:57:39 +0800
Message-Id: <cover.1696855875.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1034;
 envelope-from=yong.huang@smartx.com; helo=mail-pj1-x1034.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 2f3913f4b2ad74baeb5a6f1d36efbd9ecdf1057d:

  Merge tag 'for_upstream' of https://git.kernel.org/pub/scm/virt/kvm/mst/qemu into staging (2023-10-05 09:01:01 -0400)

are available in the Git repository at:

  https://github.com/newfriday/qemu.git tags/dirtylimit-dirtyrate-pull-request-20231009

for you to fetch changes up to 84719f6d0b75448400068adb78d85000e884f0cd:

  migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time (2023-10-08 15:06:12 +0800)

----------------------------------------------------------------
Dirtylimit and dirtyrate 20231009 patches PULL request

Dirty page rate measurement optimization.
Please apply, thanks, Yong.

----------------------------------------------------------------
Andrei Gudkov via (2):
  migration/calc-dirty-rate: millisecond-granularity period
  migration/dirtyrate: use QEMU_CLOCK_HOST to report start-time

 migration/dirtyrate.c | 122 +++++++++++++++++++++++++++---------------
 migration/dirtyrate.h |  12 +++--
 qapi/migration.json   |  58 ++++++++++++++++----
 3 files changed, 134 insertions(+), 58 deletions(-)

-- 
2.39.1


