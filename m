Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5D81ED09
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Dec 2023 08:55:48 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rIOkg-00018d-7N; Wed, 27 Dec 2023 02:54:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peng.ji@smartx.com>)
 id 1rIOAr-0003pX-AM
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:17:54 -0500
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peng.ji@smartx.com>)
 id 1rIOAo-0002YZ-5s
 for qemu-devel@nongnu.org; Wed, 27 Dec 2023 02:17:53 -0500
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-28c934be96fso82938a91.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 23:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1703661346; x=1704266146;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VfN8R8zSYlE0qLIcZonxoq9AhKpNo7T7Py57bnuksGg=;
 b=Vb8nMYfNHSJytTOIH0WbZQPUOe7Xt96ssLSdpf4AtPcC6jef8373ybTdWegz5M2Oev
 SNNLCsWue1f5TFCt+JbgriCo1LwJbuJQuqK++pZiLKOtK+sn6rPB0CqPJ4tGUf3zwvdR
 ClM9kXsv9OOpgB2S69g61XGK/k0Tmup8lpSS+BDHoI8Iv5y01/ZaQnPM9UAoTLMAjI1x
 P8VhvjH8CPy/Cvd9fWJx3pD9Eg3tQqI8DkX4nWN/ESP9mjpniuwYf4uATRG1wnLwYoGe
 bJrK7yPShyAlh/LbW7PlAlSfSJ3LIscub+eO5mfxkIIr7w8OXQEX0Tj0lgNt/qpRUBvz
 jIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703661346; x=1704266146;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VfN8R8zSYlE0qLIcZonxoq9AhKpNo7T7Py57bnuksGg=;
 b=QaPFeKupfEPQ26TsWl/8vP6TXrdaPgx6YNyU/0QxALgjxFdSZhsRHt6I6FKvJTgs0R
 GZHtoD/Z2Uw5zaK2y6Pg0EuTnECx09/xeKdg8yrRRrkF8cdiKgtIZgjqKMZibYz3ubEB
 CVmf77L2/hw0xT4FTsImrDb9d+xBE5DxxQyd5l3Om+yxlgXW8SBZ/eX5kH5ti7JVDDfM
 L/OSsmOijKmDWSyFClFbMNE27uF2US/S/l5/OSNKZR9oBAh5QRB8CNSIzzu1v9Y2iAwU
 SuU4MnZLZwRPaFcPvn9OI31k4fssSXPh8qKtqVEX2R6U00u7oeh5l8qWhtkcnLKlC8M0
 uKXg==
X-Gm-Message-State: AOJu0Yxaqn/djKfKAGea53LPTgDcGg7L+ZTQVSqeRU7s5H4HCQegNWX8
 +okIsTqpStQk4wsHJsygYE+Uv24pUSS/sHLPZkDBJLqCV0PJn8KK170=
X-Google-Smtp-Source: AGHT+IGrYTojZMEEWOWP98tZxaRQtYqwVll5Fq8GuO6xXW3LG5E7vxGfEr1kKVaKt81X4QWqVEJqiQ==
X-Received: by 2002:a17:90b:1e46:b0:28b:f18f:1bff with SMTP id
 pi6-20020a17090b1e4600b0028bf18f1bffmr1984746pjb.57.1703661345491; 
 Tue, 26 Dec 2023 23:15:45 -0800 (PST)
Received: from localhost.localdomain ([221.122.98.162])
 by smtp.gmail.com with ESMTPSA id
 st14-20020a17090b1fce00b0028a4c85a55csm3155911pjb.27.2023.12.26.23.15.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Dec 2023 23:15:45 -0800 (PST)
From: peng.ji@smartx.com
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Konstantin Kostiuk <kkostiuk@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Yan Vugenfirer <yvugenfi@redhat.com>,
 Peng Ji <peng.ji@smartx.com>
Subject: [PATCH] qga-win: Fix guest-get-fsinfo multi-disks collection
Date: Wed, 27 Dec 2023 15:15:40 +0800
Message-Id: <20231227071540.4035803-1-peng.ji@smartx.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::1031;
 envelope-from=peng.ji@smartx.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 27 Dec 2023 02:54:38 -0500
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

From: Peng Ji <peng.ji@smartx.com>

When a volume has more than one disk, all disks cannot be
returned correctly because there is not enough malloced memory
for disk extents, so before executing DeviceIoControl for the
second time, get the correct size of the required memory space
to store all disk extents.

Signed-off-by: Peng Ji <peng.ji@smartx.com>
---
 qga/commands-win32.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 697c65507c..a1015757d8 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -935,6 +935,8 @@ static GuestDiskAddressList *build_guest_disk_info(char *guid, Error **errp)
         DWORD last_err = GetLastError();
         if (last_err == ERROR_MORE_DATA) {
             /* Try once more with big enough buffer */
+            size = sizeof(VOLUME_DISK_EXTENTS) +
+               (sizeof(DISK_EXTENT) * (extents->NumberOfDiskExtents - 1));
             g_free(extents);
             extents = g_malloc0(size);
             if (!DeviceIoControl(
-- 
2.27.0


