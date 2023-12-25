Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F0B81DE39
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Dec 2023 06:30:29 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rHdWq-00050a-69; Mon, 25 Dec 2023 00:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWn-00050F-FQ
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:25 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1rHdWk-0007HB-LH
 for qemu-devel@nongnu.org; Mon, 25 Dec 2023 00:29:25 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-6d728c75240so3159547b3a.1
 for <qemu-devel@nongnu.org>; Sun, 24 Dec 2023 21:27:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703482038; x=1704086838;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=u/z3o8OdX2D+rDsy1uV+BH1OVy/XGHeA+wR2SVKvkpE=;
 b=2yR4SUg8lNtE6oiXahkPytmA/A3Y62PVBPfrFpXw1lROa5s6ZhkHPL34HIa1nibufq
 /Ss8Jnu/nX0Q+RMdS5jJz2E+fi95gU5mtKConby79iXG08S4g6nzrgAg3zz/fV928HAc
 kQTmpsDL22ckNeyWToZ5s1eCjrUHDiPkLi6xddn8T6c+7+VS9CV9c+KAya2jAZpIHaHq
 I63xDRC/rNW4csTWXxFojXqUMbJD91ulZ+lCkMYQUAqVDpOm+FMexKhOUN7sn9ADjqGd
 CZsPw3sPUSPMGSJB5BgF4nTyeiEfInMrLgBl/LzYGKXvV/68ouJK32yNeT3YTtsAc9bw
 ol+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703482038; x=1704086838;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u/z3o8OdX2D+rDsy1uV+BH1OVy/XGHeA+wR2SVKvkpE=;
 b=ZfFctr6nZ8ZdR9zhB6/X2RIDMklBZQgpHAPc2elmoq2o9q0wLEW8wI/pf8hBr5LasS
 1NFnxrpBol3XNx68Zu7RgLcKpxxfCR6qAloELjvh4M9HjdVaeus6M8i2oP1nmyxLZ22v
 y9UHcOwBPDk5yr3I+14gdVIf+6kyIlepLSMNX6SFMO4TpGAXeVToShWKc84yF6fc4B6L
 g1WWfelR7yOo0/++vfQCUDhL3S5wRWP3GNRhClw4Nk6mV9wyoWNV/SFSTLuVtcjUxnnD
 xx8xFz4jvobMgYEjeIVXW2TZEqGFJX7lcpmxiCpJEReI4a6SsiJdRKtGzmBxqRub3YbW
 L+lA==
X-Gm-Message-State: AOJu0Yxy4Svbbr0518us1ZLaOcL1pQa3pO+Wky9hwM+OFUA5qxOh0b14
 eiw9pEI3inC7LUwmN0tINKSTZLZFnBfn6Bx+PPB5irUx51ZAFw==
X-Google-Smtp-Source: AGHT+IFJhcjyoTWSeiuhZE7f9uf3Rk4MYSw3toj2GdNaJK5zK30eHQYc1YAaEmJ/GJJ97iQNaCN/Tw==
X-Received: by 2002:a05:6a00:1d1a:b0:6d9:bfef:119 with SMTP id
 a26-20020a056a001d1a00b006d9bfef0119mr392303pfx.7.1703482037715; 
 Sun, 24 Dec 2023 21:27:17 -0800 (PST)
Received: from localhost.localdomain ([118.114.58.28])
 by smtp.gmail.com with ESMTPSA id
 f7-20020aa79d87000000b006d991505b4csm4555800pfq.76.2023.12.24.21.27.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 Dec 2023 21:27:17 -0800 (PST)
From: Hyman Huang <yong.huang@smartx.com>
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Hyman Huang <yong.huang@smartx.com>
Subject: [v3 00/10] Support generic Luks encryption  
Date: Mon, 25 Dec 2023 13:26:50 +0800
Message-Id: <cover.1703481378.git.yong.huang@smartx.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42e;
 envelope-from=yong.huang@smartx.com; helo=mail-pf1-x42e.google.com
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

v3:
- Rebase on master
- Add a test case for detached LUKS header
- Adjust the design to honour preallocation of the payload device
- Adjust the design to honour the payload offset from the header,
  even when detached
- Support detached LUKS header creation using qemu-img
- Support detached LUKS header querying
- Do some code clean

Hyman Huang (10):
  crypto: Introduce option and structure for detached LUKS header
  crypto: Support generic LUKS encryption
  qapi: Make parameter 'file' optional for BlockdevCreateOptionsLUKS
  crypto: Introduce creation option and structure for detached LUKS
    header
  crypto: Mark the payload_offset_sector invalid for detached LUKS
    header
  block: Support detached LUKS header creation using blockdev-create
  block: Support detached LUKS header creation using qemu-img
  crypto: Introduce 'detached-header' field in QCryptoBlockInfoLUKS
  tests: Add detached LUKS header case
  MAINTAINERS: Add section "Detached LUKS header"

 MAINTAINERS                                   |   5 +
 block.c                                       |   5 +-
 block/crypto.c                                | 146 ++++++++++--
 block/crypto.h                                |   8 +
 crypto/block-luks.c                           |  49 +++-
 crypto/block.c                                |   1 +
 crypto/blockpriv.h                            |   3 +
 qapi/block-core.json                          |  14 +-
 qapi/crypto.json                              |  13 +-
 tests/qemu-iotests/210.out                    |   4 +
 tests/qemu-iotests/tests/luks-detached-header | 214 ++++++++++++++++++
 .../tests/luks-detached-header.out            |   5 +
 12 files changed, 436 insertions(+), 31 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/luks-detached-header
 create mode 100644 tests/qemu-iotests/tests/luks-detached-header.out

-- 
2.39.1


