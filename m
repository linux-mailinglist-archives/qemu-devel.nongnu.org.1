Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C40B0768F86
	for <lists+qemu-devel@lfdr.de>; Mon, 31 Jul 2023 10:04:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQNsP-0002BO-1V; Mon, 31 Jul 2023 04:03:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsN-0002BD-PW
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:36 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qQNsM-0005zY-4n
 for qemu-devel@nongnu.org; Mon, 31 Jul 2023 04:03:35 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1b8ad8383faso36037285ad.0
 for <qemu-devel@nongnu.org>; Mon, 31 Jul 2023 01:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1690790612; x=1691395412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=q3QyGAkEs1Y8bd2mhvAi+cgH5Ugs+8r1XJByBS1rISQ=;
 b=orB03koFPvKz0owhUIi2aSjVD8kLCyEtIQrHgODAX5I4/hSdm12Ue9XLZAIkl3Mj8H
 HYpbK4pIwzkVfYCGq1rRvb4tFqGpjNMj1cAZ6EqX15nunu5Ng/EDztxmQcYtX+OFvjpR
 ImvBwyA1BVZaiCEsufZiWG7HmococGH5Ke9Te6QdxqT851pWewjmfnIecgW0nAlChfu4
 zSI+I8OF19IvybH7dSSlyqbya7PXq1mzR7Nqud7eTv126EBEyxnk49RwwtfI2NFuROqM
 ZY/L/ZKqQssj4OAV9ENmFsS9ti5zeSlx27WNAzEhFO6NjaGKV6tsb5nsKYo4TRHx1zTG
 5H7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690790612; x=1691395412;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q3QyGAkEs1Y8bd2mhvAi+cgH5Ugs+8r1XJByBS1rISQ=;
 b=WYJY5zzX6UbYULQhCntabaVmIkBxt8XlRUm/RLqNve7oVxa3JBNzle4G5ujFGWzRts
 5Z6yf4WLk1zbpyE0WsXTDYHmpKL0duq0MNDodmmN4BDQMs3174ph8PiDWRFF74kYtRjK
 D/NJEHaZME2ORSmbtSOPhitUNd4s0dBhMdkdqYPRvEZ6rzV1heDuT1eBgTNHt3wrXraN
 7n1FNIKqGYPN4l9Ff4LKgwRc25FE9wG0Y5AIJ/19PqmYdiQ9ErKuFV5nHBaaeM0zVVj4
 SlVXi8ANy7aj4nh2Ct65hhxIdTHli69+bSIsb8UPtxvXu8VfHc7Rz6tByz2mad8QMHNf
 q0Kg==
X-Gm-Message-State: ABy/qLa47dXKZnmWdZ67am47N8aQeeoTrN44tkYYr7Oeg8H9Dydf0VbE
 eoVbKG/489BJ1BVo8U7BcMT4x5Ou1KOPvbl1MHE=
X-Google-Smtp-Source: APBJJlETvJPSOlOgM0k0N8K9zQLEOyjQ/4PM2ZmiXT1P73y70pL1RxEtddY1t9C6b+aS/1EGiBB0+Q==
X-Received: by 2002:a17:902:9b94:b0:1bb:a6db:3fd0 with SMTP id
 y20-20020a1709029b9400b001bba6db3fd0mr7959246plp.69.1690790611861; 
 Mon, 31 Jul 2023 01:03:31 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 jb22-20020a170903259600b001b89466a5f4sm7883559plb.105.2023.07.31.01.03.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Jul 2023 01:03:31 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 0/5] linux-user: brk/mmap fixes
Date: Mon, 31 Jul 2023 17:03:09 +0900
Message-ID: <20230731080317.112658-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::636;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x636.google.com
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

linux-user was failing on M2 MacBook Air. Digging into the details, I found
several bugs in brk and mmap so here are fixes.

Akihiko Odaki (5):
  linux-user: Unset MAP_FIXED_NOREPLACE for host
  linux-user: Do not call get_errno() in do_brk()
  linux-user: Use MAP_FIXED_NOREPLACE for do_brk()
  linux-user: Do nothing if too small brk is specified
  linux-user: Do not align brk with host page size

 linux-user/elfload.c |  4 +--
 linux-user/mmap.c    |  2 ++
 linux-user/syscall.c | 67 +++++++++-----------------------------------
 3 files changed, 17 insertions(+), 56 deletions(-)

-- 
2.41.0


