Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0036C80C1AA
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 08:14:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCaTM-0007Pu-FH; Mon, 11 Dec 2023 02:13:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCaTI-0007Oc-1N
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:12:56 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tomoyuki.hirose@igel.co.jp>)
 id 1rCaTG-0005Hy-15
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 02:12:55 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1d0bb7ff86cso37866325ad.1
 for <qemu-devel@nongnu.org>; Sun, 10 Dec 2023 23:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=igel-co-jp.20230601.gappssmtp.com; s=20230601; t=1702278771; x=1702883571;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=54nPGnT5HMFJ+D3y4ItQpsodJ9bd1MLW9qB1ra8Wiqs=;
 b=N0Dyk9Z+3gxPxEINyukIvGQuJXMmT5KI9zkA3L0kE+dLb/cDuCFaYmZwXezCT2Dtdc
 3VULZ844QWlJyUrBr+O0MYQRDAVGLXFEnk1lrj7WXQLX9cmfYu8S9aptICwZqiJfjyzd
 YjxLEyn0MJS9yKB2oTXPC5Pv42bDcqC8pLdAshYbWUYLM2dzDeu+SeAf+G3tSOF2rvNl
 xxm6c8wCiIPWZTh9weV139gTmj1oHBgO30qAQrZaseHboNyz1FPMX4FnSLAqyci9fCcG
 N/0N5tCaFZbRJpW1gg5E8fQbRo/clNkT53O0JJ6rIHS84CmBGZC/QkSPNzybw9VRKgNh
 PzmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702278771; x=1702883571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=54nPGnT5HMFJ+D3y4ItQpsodJ9bd1MLW9qB1ra8Wiqs=;
 b=Wv9gEjw0ufHHWPWVawJNBT5JdnWZgAVYNEC7hpZmKNMLSpKZfXqf9qnUKB2rQoIwgo
 CaTyCsNVeJUbsSnAafPLilyTAHspQHs1q9IX39ibJDd3yUf3ct9IToEZj/sMOwFplSRv
 UwflSsmTcLRkVRHbAyec7J/YwZjzF+ci8k5+t7fOgdI/R3BGbplEf2kl2/wAQZWs2cbs
 049G47NXb3ZKlg4JHfeN7GCp2CrugpHBx2asmN6oI0x+hrck9I40+e4KvtqHOLwXn6u7
 nYbQXXKAq3RB6+Vw4eTgGRMuG/cLBWKv5nvKFJNJ8jW5lxKdZto/w0clZ4rArT1UyTZb
 oUXQ==
X-Gm-Message-State: AOJu0YwvXt+M5rXHNqA9ShKpXwG0UD3cC65yrLsgJkOKJj4Hos79/wui
 4xiF8i0slfekkiTMlA8+CYrPgJMYbkq1Cem1YbE=
X-Google-Smtp-Source: AGHT+IEuvUQvUxF2Re5E/HpN9hTeTXydpPD9UHX6rcuthUUblMaU5dPPvxSM1dRTIcwaib4ezoMQJQ==
X-Received: by 2002:a17:902:7202:b0:1d0:5fd7:867c with SMTP id
 ba2-20020a170902720200b001d05fd7867cmr5346031plb.4.1702278771274; 
 Sun, 10 Dec 2023 23:12:51 -0800 (PST)
Received: from ThinkPad-T14-hirose.hq.igel.co.jp (napt.igel.co.jp.
 [219.106.231.132]) by smtp.gmail.com with ESMTPSA id
 v23-20020a170902e8d700b001d08e080042sm5842150plg.43.2023.12.10.23.12.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 10 Dec 2023 23:12:50 -0800 (PST)
From: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
To: qemu-devel@nongnu.org
Cc: Tomoyuki HIROSE <tomoyuki.hirose@igel.co.jp>
Subject: [PATCH 0/2] support unaligned access for some xHCI registers
Date: Mon, 11 Dec 2023 16:12:02 +0900
Message-Id: <20231211071204.30156-1-tomoyuki.hirose@igel.co.jp>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=tomoyuki.hirose@igel.co.jp; helo=mail-pl1-x62e.google.com
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
Controller Capability Registers are not prohibited. But current
implementation does not support unaligned access to 'MemoryRegion'.
These patches contain 2 changes:
1. support unaligned access to 'MemoryRegion'
2. allow unaligned access to Host Controller Capability Registers.

Tomoyuki HIROSE (2):
  system/memory.c: support unaligned access
  hw/usb/hcd-xhci.c: allow unaligned access to Capability Registers

 hw/usb/hcd-xhci.c |  4 +++-
 system/memory.c   | 22 ++++++++++++++++------
 2 files changed, 19 insertions(+), 7 deletions(-)

-- 
2.39.2


