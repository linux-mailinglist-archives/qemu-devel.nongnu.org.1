Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 623528186CF
	for <lists+qemu-devel@lfdr.de>; Tue, 19 Dec 2023 13:00:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rFYkj-0007jB-Um; Tue, 19 Dec 2023 06:59:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYkh-0007j2-8y
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:59:11 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rFYkf-00040F-GD
 for qemu-devel@nongnu.org; Tue, 19 Dec 2023 06:59:11 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6d741fb7c8eso2113566b3a.2
 for <qemu-devel@nongnu.org>; Tue, 19 Dec 2023 03:59:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702987148; x=1703591948;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QBCmXlcPQLnvzfr7BErdsRGIOlx39GK74XQfC7yhRPA=;
 b=BwGW0m+uaaVOwLK10PExtiY6MpeRxohjENUgfWrAEdICax3P7ta1DP1IGg7QTHHcHf
 Rukl/0NNTEUcXoTybjg4l7aVj2gR8NSjar/7DwrRfYc8nS9CV44p7uEfbO+lbvUqmtR3
 5aZYrht058B7xF4rC7xJBdIFuBA2ifiD/Mxdcyfwp/+k5Vw45mFvlUXx5vLBANjVY9o/
 nNo67AsHZwztqFYNPbXfclVgvOlbxovjZAheQ8BCv2gfedxbV792TiZymNxO6TJ2XUmh
 XB+ExvEoWVr1qWdW91EJdPXjo/t4TvQ+Fwq0BlKfW8zX+mbVXSgnm9+bxF7dEZgrYrSM
 VGsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702987148; x=1703591948;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QBCmXlcPQLnvzfr7BErdsRGIOlx39GK74XQfC7yhRPA=;
 b=Y7KsnTIXrgqRb7vV28wrHoM+UgfGvbujVcISpwJ8q/Sz32jYVkwe91emh6hW0qkvR4
 1p17op0kCQ7XouiZmCsTWDkMd+6IFzPY7LZ6zv0hirDiZ3UWLIFGsxySURiunLwifslE
 KroTg3rCnC0OCW/X/sW1TPLpaFO+sK7mDoIpvH1iOwPYX6uuw9hCfxFUWxWMTWRziQhf
 qn3J9LAJ4llSHMRy/4NqBsXix9eQUX3S7r5hROuL90b595xViDC1NoD0U8zI6WaAnFYj
 sv6TwN+hKkiAPm/81zQv077LlXW4xx0pCa54SFnAEP5amwQr9x1Wl8ZAXK8jCJ8Q0O3I
 LKLw==
X-Gm-Message-State: AOJu0Yxr2SMBAFPKDmnPVB1snOkb3DbE/1hs699QbpkOWZ18+PSk0tGI
 rCvnSWVzH3URqcKi3VsfLwLTaw==
X-Google-Smtp-Source: AGHT+IF+txC8DqatBGA36KgNCzFDOAs3WSN79XlOg3N+e6UtKeNHtQZccnuFCVldD01fvjUBUBDwzg==
X-Received: by 2002:a05:6a20:8f2a:b0:191:618a:6146 with SMTP id
 b42-20020a056a208f2a00b00191618a6146mr17594052pzk.40.1702987147759; 
 Tue, 19 Dec 2023 03:59:07 -0800 (PST)
Received: from localhost ([157.82.205.15]) by smtp.gmail.com with UTF8SMTPSA id
 r9-20020a17090a0ac900b0028ae54d988esm1456953pje.48.2023.12.19.03.59.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Dec 2023 03:59:07 -0800 (PST)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/2] tap: Use g_spawn_sync() and
 g_spawn_check_wait_status()
Date: Tue, 19 Dec 2023 20:58:56 +0900
Message-Id: <20231219-glib-v1-0-1b040d286b91@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAICFgWUC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDI2NDI0NL3fSczCRdA2OTRGOTpCQD0xQLJaDSgqLUtMwKsDHRsbW1ACsk2Xd
 WAAAA
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.12.4
Received-SPF: none client-ip=2607:f8b0:4864:20::435;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x435.google.com
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

g_spawn_sync() gives an informative message if it fails to execute
the script instead of reporting exiting status 1.

g_spawn_check_wait_status() also gives an message easier to understand
than the raw value returned by waitpid().

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (2):
      glib-compat: Define g_spawn_check_wait_status()
      tap: Use g_spawn_sync() and g_spawn_check_wait_status()

 include/glib-compat.h |  2 ++
 net/tap.c             | 52 ++++++++++++++++++++++-----------------------------
 2 files changed, 24 insertions(+), 30 deletions(-)
---
base-commit: 9c74490bff6c8886a922008d0c9ce6cae70dd17e
change-id: 20231219-glib-034a34bb05d8

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


