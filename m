Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 749EE7DB269
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 05:04:41 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxJVj-0004Nk-Mc; Mon, 30 Oct 2023 00:04:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qxJU7-0003Kh-EX; Mon, 30 Oct 2023 00:02:46 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qxJU4-00046e-It; Mon, 30 Oct 2023 00:02:38 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1cc3bc5df96so4615685ad.2; 
 Sun, 29 Oct 2023 21:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698638552; x=1699243352; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=T9xwwqyH8DZWZsemtC7IXbeBlliZTnYxaAeLaDpVfzw=;
 b=a3WdXnZa0apjR7ehK6j/Wt4y+fxM93WLlJ/Ls0niH0ITid06TWTOMg4DubaaZHP5hl
 ZPSHmq/JhURmBYxffDRrPaq7ngytTTyD11P8psElfHBxxOgbCLOzyFe++s6XV0A1WNMR
 GqGY6la2UCt0H/mNh528PFzVquHWyeEMuSrHOljU7zPv2CI62XD9+bRC5J4Lxegqu9p2
 cRez76/L/auC/h5y3UDgu3K1QurtjjwSkfRJGH9e6CNhGe+7zq46leF+/y/Ed7u/cwul
 J0aU9/ccrkmxjr0Ub2E+q1q4HIEMKobYmgzGyK5ePYafPebKLwCwNp07kY2WPvnhXjk4
 Qk8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698638552; x=1699243352;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T9xwwqyH8DZWZsemtC7IXbeBlliZTnYxaAeLaDpVfzw=;
 b=Xq6WA47NbqMBm7V9mroDl/85KAN2bYi0XNxCKaSWPwxtflk30dj15e4CP4yTCRmOK8
 UGjpOFpXYE7mRbxVpt2p0Q9KKD4sdTP11fmzdTZNt4NrUnI3iVUGWxcGgq5mOi2KqcRL
 +llaftsWoylBjDgFpznlLVs2QuSubcxMftnr7qNzA6SvsELpD3ET/WFdv2lyfvXr0gQH
 ZnDwxfoc9AnWdDsNiEIDVdv7TKk5gtlK9OYeGEH4R38YRDQoC24xNGWi9WY7eS86eIdE
 9sLWfGYkW2RMYeFzCFYRY7awRjRh96p9u8g1ParVFjFYy/YFbOQZnr2GCL+j08xRcGAU
 FdGw==
X-Gm-Message-State: AOJu0YyJkPCp+mo0qD/6aaCdDVpj/zCftYzTlrAJlAXRD15o/wlfOkst
 Hy5TjqnFwafWYUIC9KY/PpA5nN4BnKCVkQ==
X-Google-Smtp-Source: AGHT+IF/NUSWehkjySf4+II6sBF2xZm6+iNHBa/lBfWI4mmwXFoPJeKqLybVezO4Ga2H3IKrVfvzPQ==
X-Received: by 2002:a17:903:124a:b0:1cc:bfd:b221 with SMTP id
 u10-20020a170903124a00b001cc0bfdb221mr6773676plh.31.1698638551700; 
 Sun, 29 Oct 2023 21:02:31 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 jc3-20020a17090325c300b001cc3b988fd6sm2278339plb.265.2023.10.29.21.02.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 29 Oct 2023 21:02:31 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: jeuk20.kim@samsung.com, pbonzini@redhat.com, fam@euphon.net,
 qemu-block@nongnu.org
Subject: [PULL 0/1] ufs queue
Date: Mon, 30 Oct 2023 13:02:18 +0900
Message-Id: <cover.1698631179.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit c60be6e3e38cb36dc66129e757ec4b34152232be:

  Merge tag 'pull-sp-20231025' of https://gitlab.com/rth7680/qemu into staging (2023-10-27 09:43:53 +0900)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20231030

for you to fetch changes up to 096434fea13acd19f4ead00cdf9babea8dc7e61e:

  hw/ufs: Modify lu.c to share codes with SCSI subsystem (2023-10-30 10:28:04 +0900)

----------------------------------------------------------------
ufs queue:

* Modify lu.c to share codes with SCSI

----------------------------------------------------------------
Jeuk Kim (1):
      hw/ufs: Modify lu.c to share codes with SCSI subsystem

 hw/ufs/lu.c            | 1473 ++++++++----------------------------------------
 hw/ufs/trace-events    |   25 -
 hw/ufs/ufs.c           |  202 +------
 hw/ufs/ufs.h           |   36 +-
 include/block/ufs.h    |    2 +-
 tests/qtest/ufs-test.c |   37 +-
 6 files changed, 315 insertions(+), 1460 deletions(-)

