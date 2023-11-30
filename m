Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 673A17FEF57
	for <lists+qemu-devel@lfdr.de>; Thu, 30 Nov 2023 13:43:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r8gMT-0002Rh-IA; Thu, 30 Nov 2023 07:41:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8gMO-0002RO-53; Thu, 30 Nov 2023 07:41:40 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1r8gML-0004GR-VV; Thu, 30 Nov 2023 07:41:39 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-285699ebabcso768355a91.0; 
 Thu, 30 Nov 2023 04:41:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701348095; x=1701952895; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ttz5ZyK0PhLB4iVBa9Dm9UGiS1X02w9fT1O6lBM8Ql0=;
 b=Qw89Ivm0y7kODOpin1NDBw6r8epNpW7pAnLc6nFK/AuFd+ng+CGiBsspHU5VKO8yTc
 5iZAjimrAl4Scu3pNNlKts9vYh2aBBsR4BdYc1SmQRxXkY5k+2kBD7bL715mwNy8XW/Z
 bqxN09jGjhQbWMH11M9Z9270ZYwk9dh/I9WR7EbfNjQxG5CguRq7mLXdcwvMYmpUof1R
 r0SshEAOQoRuJ9re9VSf955BZ6w2Xc0guKk45iMUbh1qgoppkSgcKvX4DaKMZcqzv7G+
 j1xKCZ/FDqDS5xBPVNiMlvqvZe6M6Ye8WiPK1h3TuHcLwyeQ8LXhlk/8evJlzlaiWe8N
 QUVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701348095; x=1701952895;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ttz5ZyK0PhLB4iVBa9Dm9UGiS1X02w9fT1O6lBM8Ql0=;
 b=kiweO8/o3duY149WJlZfrqrHCdSshMlc7ZHXqRhs5dLko4HZqbnv0Sv9eTlI5/hcl6
 T0NGetyNfGaeb6qHVooXRMkwcjUY3rHLTuprJBMpTzpYSpfUItVjEOVhZHPLgQjzNBOq
 FoZnQ2j22D9ncj6RBoknDfj7VtOQ1xGPUQa8DwOJwCSoOkBMQYsVr3XJMNxd6RM9lVIb
 4bR4+4NVzHgBviGo88DjCVq4D3mUDsH1QJRVf4LSo6iPNm91mutHi+/R6E1zd/Jflnfg
 85EwH5/AsySIUTXbVJtiX0PW5GX5Y+/YRcf+CouWBhzqfDe5rVJNmYMW7FgT9CW7BlN/
 Zkxw==
X-Gm-Message-State: AOJu0YyatShPT0WBROBEtGVM1E0+P4zRmjEPD2diytH8e/ALb29sCBpT
 ajQBV+LZI8B9VVnzWyZBKJXGCSoGjwU=
X-Google-Smtp-Source: AGHT+IFaxPadhmF2ksQ08d+OI/ZPO3sdThKZsNnEwQfRdTUfKxyAcPRDzk7ng6YriWOHXdCy195i5w==
X-Received: by 2002:a17:90b:3ecb:b0:286:1e90:fe2f with SMTP id
 rm11-20020a17090b3ecb00b002861e90fe2fmr7286270pjb.15.1701348095512; 
 Thu, 30 Nov 2023 04:41:35 -0800 (PST)
Received: from wheely.local0.net ([124.170.16.164])
 by smtp.gmail.com with ESMTPSA id
 f24-20020a17090ac29800b0028593e9eaadsm3149326pjt.31.2023.11.30.04.41.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Nov 2023 04:41:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: qemu-devel@nongnu.org,
	qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Subject: [PULL 0/2] ppc-for-8.2 queue
Date: Thu, 30 Nov 2023 22:41:09 +1000
Message-ID: <20231130124111.109602-1-npiggin@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

  https://gitlab.com/npiggin/qemu.git tags/pull-ppc-for-8.2-20231130

for you to fetch changes up to e25acd619135c752672de323f22aba8c1d00584e:

  ppc/amigaone: Allow running AmigaOS without firmware image (2023-11-30 22:13:00 +1000)

----------------------------------------------------------------
* Add a default BIOS for the new amigaone machine so it does not
  require out of tree binary blob.
* SLOF update to fix virtio serial bugs.

----------------------------------------------------------------
Alexey Kardashevskiy (1):
      pseries: Update SLOF firmware image

BALATON Zoltan (1):
      ppc/amigaone: Allow running AmigaOS without firmware image

 hw/ppc/amigaone.c |  35 +++++++++++++++++++++++------------
 pc-bios/README    |   2 +-
 pc-bios/slof.bin  | Bin 995176 -> 995000 bytes
 roms/SLOF         |   2 +-
 4 files changed, 25 insertions(+), 14 deletions(-)

