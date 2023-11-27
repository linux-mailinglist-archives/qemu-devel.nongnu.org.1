Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 317397F9E0F
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 12:00:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7ZKI-0003lO-Hp; Mon, 27 Nov 2023 05:58:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7ZKA-0003l1-LW
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:58:46 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7ZK7-000664-7U
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 05:58:45 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cf80a7be0aso33312935ad.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 02:58:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701082720; x=1701687520; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=6aN4QhFaL8apbxcsvPexuVCG1iRmcUPijDiXk4+v4kI=;
 b=UfAmw583f+KRhjnVy13yf6WModigmA6fHcAIp3dtRvs8OnqbXH1AmL+VKIEv4BW3gl
 ueTwK9ZTkxwmMCrr/0wpWmHSGS7Q8vZ68+HgtX4O4KqhbMvGJmtLvaRK6MVzaUqmWHrh
 GstT7Zfyb7fCb/lSo6BquQ8KMGeDxeKvy/VjWB98eiIAz/O/HZluuz5jqy1P+OxIUSQz
 vCpM83qpyBtXofn7pmAppH/mMxVv8dTVyB7bOEFsnF7eXsoM0t3jjo2Kmpp+H4w5Rtsb
 HQ6lBxw6g0VJPPCnD+vzntnnhZte4P3dizt0+U248VCkMuWCsN/lvA38ozSJ3kajaxZu
 1hSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701082720; x=1701687520;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6aN4QhFaL8apbxcsvPexuVCG1iRmcUPijDiXk4+v4kI=;
 b=XUIe6Nub6ksVCxL9bwWt+93znoRcwiI5610aH50/pTjqKI2181+6aS5NcWnPw8rOTf
 7eCz08UPwOfEC3OGcAPrjSLQwTZii2Kpn9jw05OcI6XhWS0cDQfzwFPxJvLZ4IIUKSt5
 PA5ftIkhqbeM9xy/KrSEvSOPtEgkx/B1aTAs6D/0le9mDGk1gMywW+Xjs0Rugl7tapXU
 C24pxWyM3ygw8PORZW7yBVPtFpvqa4ieua1eA2T7aUyMfGpObOAw0wV5LzsUUdzeInEM
 o1hUbSy7/lXL1/ttbTonB4mWmBrmRgOvvb2xUaGGp7S4JfF/y2W+laH1I8H9CxIvBmdf
 MQZQ==
X-Gm-Message-State: AOJu0YyKwXbH6maUOxxvAdrXFjIkp/jfsMZx8/b5oHjnojPUGxrc5HAq
 6HqYtjqBa4Svcs1Do5xjpe0=
X-Google-Smtp-Source: AGHT+IGXajPLrjeSXNjubKZPYJj5JX4juxBeAPD0E2rIK0KNdHZ+tVHdj88eypV3YdtUeyyAt6Docw==
X-Received: by 2002:a17:90b:4a4e:b0:285:68f3:80c4 with SMTP id
 lb14-20020a17090b4a4e00b0028568f380c4mr13974926pjb.45.1701082720203; 
 Mon, 27 Nov 2023 02:58:40 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 mp21-20020a17090b191500b002801ca4fad2sm7508351pjb.10.2023.11.27.02.58.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Nov 2023 02:58:39 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Fan Ni <fan.ni@samsung.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: linux-cxl@lore.kernel.org, qemu-devel@nongnu.org,
 Davidlohr Bueso <dave@stgolabs.net>, Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH v1 0/2] A Fixup for "QEMU: CXL mailbox rework and features
 (Part 1)"
Date: Mon, 27 Nov 2023 19:58:28 +0900
Message-Id: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=1, HK_RANDOM_FROM=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Hi, this is a fixup for the recent patch series "QEMU: CXL mailbox rework and
features (Part 1)" [1].

This fixes two problems:

   1. Media Status in memory device status register not being correctly
      read as "Disabled" while sanitation is in progress.

   2. QEMU assertion failure when it issues an MSI-X interrupt
      (indicating the completion of the sanitize command).

[1] https://lore.kernel.org/linux-cxl/20231023160806.13206-1-Jonathan.Cameron@huawei.com

Hyeonggon Yoo (2):
  hw/cxl/device: read from register values in mdev_reg_read()
  hw/mem/cxl_type3: allocate more vectors for MSI-X

 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 hw/mem/cxl_type3.c          |  2 +-
 include/hw/cxl/cxl_device.h |  4 +++-
 3 files changed, 15 insertions(+), 8 deletions(-)

-- 
2.39.1


