Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 30F7380E8FD
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 11:23:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCzuG-0006Zb-Bz; Tue, 12 Dec 2023 05:22:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rCzuB-0006ZE-Tx
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:22:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rCzu8-0007oW-Qb
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 05:22:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1702376539;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=9G4k22RlMM8V3jhifG5e+dATGxcx5D79xgWJ3cFwNwo=;
 b=VnQTaOqMDn39NtP0Cf8hBq8KXELUD/2MolSh7aw7pGo/pijZxg/CxosQqkzvC0HcOanU28
 Z7zRql0JR9W6QZ8DWhpFGZ2p6PW/7YOn6atOSs2Nho5uYL0sq+3w/x3y5RJZDd3ZLt3ogf
 rVnejVTA3g5KDlMI7w/FlBGKVU4DcT8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-O7Ld7nxGNzqe5q4gKFPJIA-1; Tue, 12 Dec 2023 05:22:17 -0500
X-MC-Unique: O7Ld7nxGNzqe5q4gKFPJIA-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-40c28da6667so34160425e9.3
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 02:22:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702376536; x=1702981336;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9G4k22RlMM8V3jhifG5e+dATGxcx5D79xgWJ3cFwNwo=;
 b=tfz9Pba0FTZ4V+bOFqm9sLqN86h8zvv7KtrAvwDacFdh6kdJ0CUOtS7ktgX4jtP3e7
 ebufjeMJB46QSD7YsnV/KFRRfxa1myhOAxUoNaiqqBF/K4i7wHqwo8KA84DYHBQOAuk1
 EseXqAYl6+gMfNNQR72tu7d+hXTAaFpD2ow1uN7rS4d7xbde8wo59K1JZod6pPGoxnIY
 VoHTA+o0lb1uAX/ha1NVxzHeEMUs+M19hB389ectE5mDk50BbZpMMKgQ3jJH0GizBo8P
 68Y6lFbJpjc90K0Ihmm7jPdRhtZQfZQDe1bNhzTb6evIzWToEGwz0iQsVwhTqbrUwVHU
 /vfg==
X-Gm-Message-State: AOJu0YxzpA8vNOBkX2/g4LmnCcIOLyQ2GYn5I5BjUvG+qg6NYd4AjHvO
 wGY2DfXfjvyeS0ihxPtR3jUA3HkEmaEvNmY5XYMnQX9KNFWBlk0kgH6nUIHB5ukWVwmSPOZdDm3
 CvXZWq/Egt1NhLVHX38eMD+inGhDmUYSn2VYo5B0OXo7wCHG7tMxPpQIccwcB5e/K/RwEDgL4AN
 g=
X-Received: by 2002:a05:600c:4306:b0:40b:5f03:b44d with SMTP id
 p6-20020a05600c430600b0040b5f03b44dmr1678831wme.367.1702376536037; 
 Tue, 12 Dec 2023 02:22:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGfZmIvCRfi61k8eHVLEkEU3DoP1hysO674NjU3SBG1+5Q/0fXpgfyuDnwP75NH6Ao255eZIQ==
X-Received: by 2002:a05:600c:4306:b0:40b:5f03:b44d with SMTP id
 p6-20020a05600c430600b0040b5f03b44dmr1678823wme.367.1702376535635; 
 Tue, 12 Dec 2023 02:22:15 -0800 (PST)
Received: from [10.201.49.8] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 f9-20020a05600c154900b0040c4be1af17sm4519916wmg.21.2023.12.12.02.22.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Dec 2023 02:22:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
Subject: [PULL for-8.2 0/2] Fix for building with Xen 4.18
Date: Tue, 12 Dec 2023 11:22:12 +0100
Message-ID: <20231212102214.243921-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit abf635ddfe3242df907f58967f3c1e6763bbca2d:

  Update version for v8.2.0-rc2 release (2023-11-28 16:31:16 -0500)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 94353dcc5f9a91d111e264d8a4b130fe1aab7535:

  xen: fix condition for skipping virtio-mmio defines (2023-12-12 11:14:54 +0100)

(Compared to the patch that was posted, this is split the change
in two commits but otherwise is the same).

----------------------------------------------------------------
Fix for building with Xen 4.18

----------------------------------------------------------------
Paolo Bonzini (2):
      meson, xen: fix condition for enabling the Xen accelerator
      xen: fix condition for skipping virtio-mmio defines

 include/hw/xen/xen_native.h |  2 +-
 meson.build                 | 17 ++++++++++-------
 2 files changed, 11 insertions(+), 8 deletions(-)
-- 
2.43.0


