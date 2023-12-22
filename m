Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6324081C712
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 10:02:25 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGbP1-0005Ab-EK; Fri, 22 Dec 2023 04:01:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbOx-0005AR-DL
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:03 -0500
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1rGbOv-0002Ua-RR
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 04:01:03 -0500
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-5c21e185df5so1262321a12.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 01:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1703235660; x=1703840460; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9yAIpgz2Vh0MKn7myhvNTnAj6CrivJQ1z40FyPTPo4A=;
 b=nNFZ7bcc2qYi9cKhEGp7BEMn2RqNSOiJY+Kdf4UWjOGfGFnbgBfvA+a5l30nBoCw0Q
 r6kvyeRvpq4PCZnJCuSlct60ZwYRkeFyA0F6/QxxG9BdyXDuagBeyyCW6ojPFWwJbrLd
 zyDXQHdWGXlA5qqq9KBScWLt1O81YGP1cCEyzfRXadoeIZZgIurUb3t/2unOfcukcFzU
 6zy0a9/FwtcAEnVGRifJDfnZ3RkbkMVaEtcx+DOtTakJmskw7WMrAHNqEgUA3xCQoWDe
 +kZhgVFXe/uQz7Zh6/aBN0FKluFhXNis8gF+y0j5w41We4SEsHBQ2tDv6dWlKIUkpXJv
 NuMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703235660; x=1703840460;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9yAIpgz2Vh0MKn7myhvNTnAj6CrivJQ1z40FyPTPo4A=;
 b=Rp9p/X5XJseZuJ9Zm9tqtnaXN9sT+b2OQVs/poqLvsNFYcUWiBBqNItD1y1NfQPlHn
 VWazvlZNKB3CJM1V//v6xBZXKWKX6q0UCs1bsT+cNxpx3qcm5cCiqGGeCqBm04HMf8oX
 dvLL2lJdlVXdx45hXnhWmTtt7rk7HLXYsyn86pqq5EQ3Wc9qddkJtMdtZT1EJeVSoP/D
 USho4QYJanEJOCqALVDNwwzBHKquscV2tVsrMA1W/OREhBURDE1j3QXjEjATa3berGIm
 ccPLlTDfkN8hz/i1b0uZVPYDOn7zHDN2/BATdr+tfLgk+g8CRFxCxdlLaUKqptFmvR/C
 5PzQ==
X-Gm-Message-State: AOJu0YwYSFJJxgBpw5nae8/EPUmLt/eOrKGmpy8+Qzu/bf0Mdn0kPt4t
 NuI+YI23kFkCIq0tiLX8Neo=
X-Google-Smtp-Source: AGHT+IEbr3uxUm+2S8AOgDuc1pktqVBO/7dV02DFJEJgswOajy2l/V1V51Ixzvzyu72zOLD4TQpmHA==
X-Received: by 2002:a05:6a20:8e0c:b0:18d:10d7:3313 with SMTP id
 y12-20020a056a208e0c00b0018d10d73313mr1286628pzj.20.1703235659632; 
 Fri, 22 Dec 2023 01:00:59 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
 by smtp.gmail.com with ESMTPSA id
 f23-20020a056a000b1700b006d990040342sm400560pfu.155.2023.12.22.01.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 01:00:58 -0800 (PST)
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
To: Jonathan Cameron <jonathan.cameron@huawei.com>,
 Davidlohr Bueso <dave@stgolabs.net>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>, linux-cxl@vger.kernel.org,
 qemu-devel@nongnu.org
Subject: [PATCH v2 0/4] A Followup for "QEMU: CXL mailbox rework and features
 (Part 1)"
Date: Fri, 22 Dec 2023 18:00:47 +0900
Message-Id: <20231222090051.3265307-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.39.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
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

v1: https://lore.kernel.org/qemu-devel/20231127105830.2104954-1-42.hyeyoo@gmail.com

Changes from v1:
    - Added patch 1 that fixes a build failure in Jonathan's tree.
    - Added patch 3, as (partially) suggested by Davidlohr Buseo.
      One difference is that I dropped sanitize_running(), because
      cxl_dev_media_diabled() is enough for checking if the media is
      disabled (which implies sanitation is in progress)
    - Added patch 4 that dicards all event logs during sanitation

    Thanks everyone for giving feedbacks!

This is a fixup for the recent patch series "QEMU: CXL mailbox rework and
features (Part 1)" [1].

I don't mind if patch 1 is squashed into the problematic patch, as the
patch is not mainlined yet. This is based on Jonathan
Cameron's git tree (https://gitlab.com/jic23/qemu/-/tree/cxl-2023-11-02)

Sequence of Patches:

   1. Fix build error when CXL is not enabled, because of mismatching
      definition in cxl_type3_stubs.c
 
   2. Make mdev_reg_read() actually read registers, instead of
      returning a dummy value. This fixes Media Status being incorrectly
      read as "Enabled" while sanitation is in progress.

   3. Introduce cxl_dev_media_disabled() and replace sanitize_running()
      with it. Also add an assert() to check the media is correctly disabled
      during sanitation. (Now enabling when already enabled, or vice versa
      raises an assert failure.)

   4. Drop all event records during sanitation, as per spec.

[1] https://lore.kernel.org/linux-cxl/20231023160806.13206-1-Jonathan.Cameron@huawei.com

Hyeonggon Yoo (4):
  hw/cxl: fix build error in cxl_type3_stubs.c
  hw/cxl/device: read from register values in mdev_reg_read()
  hw/cxl/mbox: replace sanitize_running() with cxl_dev_media_disabled()
  hw/cxl/events: discard all event records during sanitation

 hw/cxl/cxl-device-utils.c   | 17 +++++++++++------
 hw/cxl/cxl-events.c         | 13 +++++++++++++
 hw/cxl/cxl-mailbox-utils.c  |  7 +++++--
 hw/mem/cxl_type3.c          |  4 ++--
 hw/mem/cxl_type3_stubs.c    |  4 ++--
 include/hw/cxl/cxl_device.h | 16 ++++++++++------
 6 files changed, 43 insertions(+), 18 deletions(-)

-- 
2.39.3


