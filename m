Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D05768F87
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:04:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNsS-0002CF-6b; Mon, 31 Jul 2023 04:03:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsO-0002Bc-V1
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:36 -0400
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsN-0005zg-9e
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:36 -0400
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-1b9c368f4b5so33403005ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:03:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690790613; x=1691395413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mLTJ6OySdKa0e08zgg6P2LepbGVDXAFUy1gJglbhNWE=;
 b=cVtjcAZJbmxLH2BnoYQxo615LeJQCz2sNapuOOGdqUHjCbUtD2MSRNCG2nVD6Rl1Hs
 HC5hqgPXREwxq3NZvSxqq+sI2mOBN+2/tT0gYsANMX9EVgmGI3RFcMoSLJKHqPdUk8XG
 8Qxb6g52beqOxwbMvT9hW7umzQOuzeCpgol6D7NKuiiH2sdnxwmDTO7YU2bTtaHdKj1X
 149vIxtN4D+IYAvg5BTRCl00iagvGmdTE6BgHWspTZSSz3giWDC4/qVqkxVQVlXO5cX9
 JD4VhwEtSYRoi0nVkGAS3dU4PQsyjTNtmdGyuHBQGzMonYTqFCtdqPDaGtXMiWsQADBc
 0Kyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790613; x=1691395413;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mLTJ6OySdKa0e08zgg6P2LepbGVDXAFUy1gJglbhNWE=;
 b=XMzqUs4zQRiUmAyvmI016dSIS2XNDC9/BAuJxCKJjPt9//E/fiKveg9+fcg1vvmZHC
 2i/KeGAXFjwVzyjM6z7Z7lMxMgYxSdEpcJqte7Li33jyyPyX2esft82DuCIZNevlbJQ3
 2dq5f7OpRZ1ZNrzsmetqGsOsRs6Ww3pUq6mmsIS6PDfeSvJLyi70RgS8bpYUUohOhYKW
 Kj4ESTALkM+ysDxlECJLOUWJuuiaSMO1U1/9YvwJ1QVaqFbMRGeR6+t+eSqHx55y631J
 wV6k2zTpV2Lx10xqdcPKnxIC1rV35frool3wnIRaYsdYO1E3UaRrh20hObjwerFlou9S
 8O2Q==
X-Gm-Message-State: ABy/qLYvIAINTLIZiCWLa2WdM6A5lqHOcm/tG28MWpIm5Q9fQBOsUmRL
 dXxfz2exFq7gV/sXDZ+H+mkkW3i+9iniYCu2wMg=
X-Google-Smtp-Source: APBJJlFjOMtLEl7xHaChjPAxZGlFiVW0nrMuaF+IXIodiP2DK/X54ZqFbCEmvbDgMEQqRcvILN4nSg==
X-Received: by 2002:a17:903:186:b0:1bb:9efe:b1be with SMTP id
 z6-20020a170903018600b001bb9efeb1bemr10685956plg.30.1690790613305; 
 Mon, 31 Jul 2023 01:03:33 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm7883559plb.105.2023.07.31.01.03.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:03:33 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 1/5] linux-user: Unset MAP_FIXED_NOREPLACE for host
Date: Mon, 31 Jul 2023 17:03:10 +0900
Message-ID: <20230731080317.112658-2-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230731080317.112658-1-akihiko.odaki@daynix.com>
References: <20230731080317.112658-1-akihiko.odaki@daynix.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::634;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x634.google.com
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

Passing MAP_FIXED_NOREPLACE to host will fail if the virtual
address space is reserved with mmap. Replace it with MAP_FIXED.

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
 linux-user/mmap.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index a5dfb56545..2f26cbaf5d 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -610,6 +610,8 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int target_prot,
             goto fail;
         }
 
+        flags = (flags & ~MAP_FIXED_NOREPLACE) | MAP_FIXED;
+
         /*
          * worst case: we cannot map the file because the offset is not
          * aligned, so we read it
-- 
2.41.0


