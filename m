Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 083C480C1AB
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 08:14:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCaTY-0007UO-OY; Mon, 11 Dec 2023 02:13:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCaTU-0007Ti-7x
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:13:08 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCaTS-0005Qe-Fb
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:13:07 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d053c45897so36329945ad.2
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 23:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702278785; x=1702883585;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n76IMce3vLufNQdY3USLbCOIA4KvM6PYInLd1jOjkBA=;
 b=0I316LdvYl/4r9EgOOKy1W7ultmZ8tGxgyxAEoMyw12d9vzuf1JAbQYv048Ady+eFh
 d0F7Wvdt2hZbLRjqsQCvZeleDMugMtZLt7gAe584K6T8YXoqnaxkSSIAzi/1MIAfESy4
 Luqh0Z5u919lfUixdX/3lzewhP3eDc0XcS2qiDZVwHl2s4MjLPvpbnSvKpMR3YPXXmRD
 z/2Jq+wxzC30HaEyKs2YD8yzslR9M1QbR5oeF2m/K9jQWWKhf4pkinh6dxs9bFpcgPmu
 x+U3t1FoOcelF4tarxO8g00+dMwGXrTnFbsbkUyRrw6lfb0JNyYpOAB2EipKvGp10NJ1
 SMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702278785; x=1702883585;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=n76IMce3vLufNQdY3USLbCOIA4KvM6PYInLd1jOjkBA=;
 b=jvYh7vNJWwF7+Ihfm/LIbnTh8yUA4Dn059NWf/eLFjWjy8MvxhrPLSBLzZWUms69W/
 zf/iGRY+WOi5sVMB+jNp4SNlVJWofVRTkZCWMxEYAmFmcZB0F/WbGwbFFj2RKgRl9dXM
 RmtmGUq4m1BNnSdyrS9MzoVS6fjfDChhsgRiBp6tXMVUSd5YQh6gucZbFGX25j9vU4JJ
 wU8R2Nonj17U6Vt77BA3OPM/EZTVDLF1Z7IMlh8pj2IC+V5fVstI4qs6CIFfEFvVl80e
 D1IOJPJcNpg+iBxuYoSFKs/1zgJrK++lNvPid+wzap1bGcu+GJaIUSMoPRjoyNwa+Mmu
 5/xA==
X-Gm-Message-State: AOJu0Yzk1izULQ7gvAMtHoMrluSB1CpOmRh7RiEiHwXFDjP5/+JXxmab
 qZ4If/CPyF0J8UaygVjfaiJ6e9MYgYrYMyl79fM=
X-Google-Smtp-Source: AGHT+IHxKbI22OS6/KS+W3pnCOoWNzmovNJhK1dCgoQIo9rQoaGdM4sjObX18QVpXhCvSN+7946eQw==
X-Received: by 2002:a17:902:a517:b0:1d0:6ffd:9e28 with SMTP id
 s23-20020a170902a51700b001d06ffd9e28mr3228380plq.122.1702278784908; 
 Sun, 10 Dec 2023 23:13:04 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 v23-20020a170902e8d700b001d08e080042sm5842150plg.43.2023.12.10.23.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 23:13:04 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>,
 Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 2/2] hw/usb/hcd-xhci.c: allow unaligned access to Capability
 Registers
Date: Mon, 11 Dec 2023 16:12:04 +0900
Message-Id: <20231211071204.30156-3-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
References: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x630.google.com
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

According to xHCI spec rev 1.2, unaligned access to xHCI Host
Controller Capability Registers is not prohibited. In Addition, the
limit of access size is also unspecified. Actually, some real devices
allow unaligned access and 8-byte access to these registers.
This commit makes it possible to unaligned access and 8-byte access
to Host Controller Capability Registers.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/143
Signed-off-by: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
---
 hw/usb/hcd-xhci.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
index 4b60114207..41abeb9ac5 100644
--- a/hw/usb/hcd-xhci.c
+++ b/hw/usb/hcd-xhci.c
@@ -3181,9 +3181,11 @@ static const MemoryRegionOps xhci_cap_ops = {
     .read = xhci_cap_read,
     .write = xhci_cap_write,
     .valid.min_access_size = 1,
-    .valid.max_access_size = 4,
+    .valid.max_access_size = 8,
+    .valid.unaligned = true,
     .impl.min_access_size = 4,
     .impl.max_access_size = 4,
+    .impl.unaligned = false,
     .endianness = DEVICE_LITTLE_ENDIAN,
 };
 
-- 
2.39.2


