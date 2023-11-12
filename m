Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 142DC7E8FDB
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 14:07:04 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2A9w-00042E-On; Sun, 12 Nov 2023 08:05:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r2A9k-00041c-GW
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 08:05:40 -0500
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1r2A9h-0005P1-B5
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 08:05:40 -0500
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6b7f0170d7bso3599270b3a.2
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 05:03:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1699794213; x=1700399013;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TX+yB45rLri+05I5YQWsoEBShsOcCj8lD5a7qYa+dsA=;
 b=TBE6vsrfYSmLiMWHdXMCS4Ny6bx7PNFedTIEwNw1TepqxB1dspcjSUfhPic+smN3J5
 eRUJJJZK+irfp1s9HxHfEfZqwvBOL3M7jZYcAaj88cxe/uw5iBxo4GBEeqr2ykpJg8hk
 BtL9wHYYc0Hg6ZtuzsvayytnJxH/yAp77OxqHk5y/nbPdAtJDUbpQbjjCHfazThwS6lO
 KR2YbIOwghDiK5TaU8KNunvVa2AE/ZHjqB2ztjE2wH4OXYBnOCPmD9Kv+3jQunFH+KD1
 OfLgxSLm+wfaRVxyIgLdMkLKVpNn8doefE5dmRpQMhYgTJqiUleOAMFB0ydz1NZpf2qq
 RvoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699794213; x=1700399013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TX+yB45rLri+05I5YQWsoEBShsOcCj8lD5a7qYa+dsA=;
 b=YJA54Q51n/4mO7oXoHaNPFKrblIgQq29fHOiyRCIcO8N88xmbHFYteF34AK1BCP4mS
 SKgCEhPq7dA+HS+Jl97Ihs2674lGh+ydCtXnqQetIVZvwH9MBaH2ehMV8g6pXzqZtHNh
 jg7gVRh3xRM4kUNeal6tEk+6pPQS+/NKMXzZEhpaKY08DwA2cN/7zy+NRC21JYwLZ1YS
 0TvLT8BPKYPjrggd2UaArfdpxW1KLooCFJtjyjZx2rn65wOho6wJiLNp9T3w9qWtWaWJ
 b1vla9gypdEMXkpqqsFFE3VznPSiooGQboYKy3KZEfsXYxw0nBIQeHFOTrw6AvAO66PC
 n4vg==
X-Gm-Message-State: AOJu0Yy5KRdT0VeX96la7KV8ktuaHTVSFdZpH+FsyOl8MIwCoXKvNLCn
 7EWGKd2WQH1/zKTaNkblf2Zy7tyMS5R2cZwe8Vmwsg==
X-Google-Smtp-Source: AGHT+IHWNZtNNaLCPq+9InDpBJx2eK81S7T0dJE2Yb4LNvvTQdvaXds66Su4FGm8m8gX/rU9D4gNfQ==
X-Received: by 2002:aa7:8e1a:0:b0:6bd:f760:6a9d with SMTP id
 c26-20020aa78e1a000000b006bdf7606a9dmr4157824pfr.14.1699794212450; 
 Sun, 12 Nov 2023 05:03:32 -0800 (PST)
Received: from localhost.localdomain ([125.69.8.82])
 by smtp.gmail.com with ESMTPSA id
 ey8-20020a056a0038c800b006c2fcb25c15sm2477684pfb.162.2023.11.12.05.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 12 Nov 2023 05:03:31 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Hyman Huang <yong.huang@smartx.com>
Subject: [RFC 0/2] vhost-user-test: Add negotiated features check 
Date: Sun, 12 Nov 2023 21:03:18 +0800
Message-Id: <cover.1699793550.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42b;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

The patchset "Fix the virtio features negotiation flaw" fix a
vhost-user negotiation flaw:
c9bdc449f9 vhost-user: Fix the virtio features negotiation flaw
bebcac052a vhost-user: Refactor the chr_closed_bh
937b7d96e4 vhost-user: Refactor vhost acked features saving

While the test case remain unmerged, the detail reference:
https://lore.kernel.org/qemu-devel/cover.1667232396.git.huangy81@chinatelecom.cn/

Since Michael pointed out that the info virtio makes sense to query
the negotiation feature, this patchset uses the x-query-virtio-status
to retrieve the features instead of exporting netdev capabilities and
information as we did in the previous patchset to aid in confirming
the negotiation's validity.

To do that, we first introduce an "show-bits" argument for
x-query-virtio-status such that the feature bits can be used
directly, and then implement the test case for negotiated features
check. As we post, the code is divided into two patches.

Please review, thanks,
Yong

Hyman Huang (2):
  qapi/virtio: introduce the "show-bits" argument for
    x-query-virtio-status
  vhost-user-test: Add negotiated features check

 hw/virtio/virtio-hmp-cmds.c   |   2 +-
 hw/virtio/virtio-qmp.c        |  21 ++++++-
 qapi/virtio.json              |  49 ++++++++++++++++-
 tests/qtest/vhost-user-test.c | 100 ++++++++++++++++++++++++++++++++++
 4 files changed, 167 insertions(+), 5 deletions(-)

-- 
2.39.1


