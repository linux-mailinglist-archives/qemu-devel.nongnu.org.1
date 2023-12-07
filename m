Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B72807E12
	for <lists+qemu-devel@lfdr.de>; Thu,  7 Dec 2023 02:43:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rB3P4-0005Ys-Ld; Wed, 06 Dec 2023 20:42:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rB3P0-0005YP-Qk
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 20:42:10 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <tcminyard@gmail.com>)
 id 1rB3Ov-0005Kq-6e
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 20:42:10 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-58ceabd7cdeso94470eaf.3
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 17:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701913324; x=1702518124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
 bh=H7wX1g8ErUuZrNl6IcPD2hjmRBi2T1I24DAn6TkN584=;
 b=AbRWXWWzRmJcOqDESqXg/xYAow+WYW11tXEa64N4XsPC3sT3wruSWahadfpkmy/FqK
 sv6c7sretIGLNbDlCMtzcZA6BQHmrK8UabDJZH86+nB0Fx22usUR+3IfgizDKfK7CJmt
 1GnNuq8bXHBrJ6bzlxFfS1FPI7hSjOrLthloDG8EjCotVRgB7WeiIEu/WEjCuUNi2isc
 /tX+59LyFufjuYGhBB/yVNX3L7FiM/kuM8A78EKx+PKaHb3rhnQMYKkfu8r89AUooYMn
 sIqGsW1KdfpLeXG2CUjXJV5ceiNQQEkVeK8dD8q4e6RJHFqFVvST1OdNojLx26J4dNIl
 kSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701913324; x=1702518124;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:sender:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H7wX1g8ErUuZrNl6IcPD2hjmRBi2T1I24DAn6TkN584=;
 b=OEBZS4tuwutORYSJvhczagOcKP+WatLSGOS8ZWhxaEbZ0qoaQNvi49de+VYPxcRUp4
 29t1ahk+u5fTFdCARaH0Jv9+ZT3THV0Q29QKYW0aczXcsH9eywlY0t/WL3SKXjBEHrmk
 jeM2RXxdRdpPdceZ6utOC/KS74d9bZ7WBszhr7WezqdHawFg7JcQ8U9iDiLwg6467o7C
 JBrCfk/teuqucam2GTH9ON9RN7Bds1UeiS/my2NXSvna06axpOJPjtAcFwJHD3FXAhMJ
 Wky4Rx3sPU4oPjYDo38pbUMEaI++JSstFz3fmOR+zFgRSsTkOJvqQPCWbVhKrBo2b04T
 MSng==
X-Gm-Message-State: AOJu0Yyweo1E6hzJZUDw94W4zUVFN8Bm263u9uK0PSlNKPk9A+oMmNpn
 1l3kTPGL7X2T/5nuyOiDTw==
X-Google-Smtp-Source: AGHT+IHDA7zJvNxdHJrXYh7RyOQJEyVBClc5kaEYLyDiBQkBAmlSKUNtdtKmQBTX7ivN3eHF8EpqyQ==
X-Received: by 2002:a05:6820:611:b0:58e:2591:7df8 with SMTP id
 e17-20020a056820061100b0058e25917df8mr1981933oow.3.1701913323950; 
 Wed, 06 Dec 2023 17:42:03 -0800 (PST)
Received: from serve.minyard.net ([47.189.89.62])
 by smtp.gmail.com with ESMTPSA id
 m25-20020a9d7ad9000000b006d84f49497fsm54021otn.23.2023.12.06.17.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Dec 2023 17:42:02 -0800 (PST)
Received: from dell1.minyard.net (unknown
 [IPv6:2001:470:b8f6:1b:8ff4:f8fd:ca3:53c6])
 by serve.minyard.net (Postfix) with ESMTPA id 49A5B1800BD;
 Thu,  7 Dec 2023 01:42:02 +0000 (UTC)
From: minyard@acm.org
To: qemu-devel@nongnu.org
Cc: Potin Lai <potin.lai.pt@gmail.com>, Patrick Venture <venture@google.com>,
 Hao Wu <wuhaotsh@google.com>, Titus Rwantare <titusr@google.com>,
 Corey Minyard <minyard@acm.org>
Subject: [PULL 0/2] Pull request for some I2C changes
Date: Wed,  6 Dec 2023 19:41:46 -0600
Message-Id: <20231207014148.3116889-1-minyard@acm.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=tcminyard@gmail.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.25,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

From: Corey Minyard <minyard@acm.org>

Some minor I2C changes.  One has been sitting in my queue forgotten for
a while, but still needs to go in.  The other is fairly recent.  Both
are for BMC related stuff.

These are available at:
   https://github.com/cminyard/qemu.git i2c-for-release-2023-12-06
and signed by me.

Potin Lai (1):
  hw/i2c: add pca9543 i2c-mux switch

Titus Rwantare (1):
  hw/sensor: enable setting adm1272 temperature with qmp

 hw/i2c/i2c_mux_pca954x.c         | 12 ++++++++++++
 hw/sensor/adm1272.c              | 27 ++++++++++++++++++++++++++-
 include/hw/i2c/i2c_mux_pca954x.h |  1 +
 tests/qtest/adm1272-test.c       | 28 +++++++++++++++++++++++++++-
 4 files changed, 66 insertions(+), 2 deletions(-)

-- 
2.34.1


