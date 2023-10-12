Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 908BF7C65A4
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 08:33:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqpF3-00015x-J3; Thu, 12 Oct 2023 02:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qqpF0-00015F-LZ; Thu, 12 Oct 2023 02:32:14 -0400
Received: from mail-il1-x136.google.com ([2607:f8b0:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1qqpEy-0008A7-Vp; Thu, 12 Oct 2023 02:32:14 -0400
Received: by mail-il1-x136.google.com with SMTP id
 e9e14a558f8ab-3573e6dd79bso2092995ab.2; 
 Wed, 11 Oct 2023 23:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1697092331; x=1697697131; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XCulkwoLnD+LK+KCtx/oQwybkPJ7p0R9yLX534U9enA=;
 b=Mp+PEclW90vktEkjdEmNtJDDax6vIxwmZ+MhTmPbiPVa/5PbcgRDTCM85du/2Dayzl
 Tcwo2tk4sDRi3wVy7nrAFlhQB430UdxDcnATI8vNyKYww9E2AZ0qn81HCeZVYBC9o7yx
 vafy+NsscCfH7jzGwqFdrHXz94O3xZUJzFlzwIibA3hg1V5mNqo8s51+aB9EkS7FNHNU
 n9DiMaM4vGGTZodjRxcOF6AKhn5FSCDzHWMpH9ixmrFYekCqB8x4c80OiESVvmXSNlnb
 gGJDmWTq6mzizDUVjKeQybrUptzZKK+aT7aiWNFoFnuxvRbUk2eBF8gNfr4yd34zm+3h
 ydEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697092331; x=1697697131;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XCulkwoLnD+LK+KCtx/oQwybkPJ7p0R9yLX534U9enA=;
 b=JTKQlOXnDor0QYNAT60egqxSidw1PC+XGHFVLL7RGn8PLy6/chtojkbvSzccD2+4yC
 FwpjYWYClpmsY/s9a4K3LFNtbzPVjq0fugn1r/9rH4fLzqrYJe0rVnQMdcjmy8RvYCpj
 UCfu8iFPG7cr56WhLBX7kG9ySCbKvQeAtEd0MliJ0WuZdncyOs4WSsMShsUTAIrMhs/c
 cTny+HF6LODsBdGvBMsNfju9v/hrTAuXBu/WqE+8icWnpiZOcUt6xVc8xCrw5l6DG55l
 1UcZm+jUjN8E6TgeJWd5Twyd0q/v2wEyoEeo7JUrq3APCyAPPWKHl3kE2YWBVEK9Ygjx
 R4/A==
X-Gm-Message-State: AOJu0YwugPMGeN0AteQqhFjo2eBvosNSkoSw6kTMJhDvsEnMAL9sP8cO
 OL9HRRjt/eTkH+VCCnrvCe8=
X-Google-Smtp-Source: AGHT+IGpoHhwjiJ59bA8tM4bfqO/iaxvx97+9u6K6ncvbRI6A9Vtr0OCjD4IJepSQ0qeCX5zrh1IZw==
X-Received: by 2002:a92:c56e:0:b0:351:50f1:1f98 with SMTP id
 b14-20020a92c56e000000b0035150f11f98mr25495797ilj.32.1697092330726; 
 Wed, 11 Oct 2023 23:32:10 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([218.147.112.168])
 by smtp.gmail.com with ESMTPSA id
 x19-20020a63b213000000b0059c3ba41db7sm929558pge.30.2023.10.11.23.32.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Oct 2023 23:32:10 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: stefanha@redhat.com,
	qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 bmeng.cn@gmail.com
Subject: [PULL 0/2] hw/ufs: fixes
Date: Thu, 12 Oct 2023 15:31:55 +0900
Message-Id: <cover.1697090890.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::136;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-il1-x136.google.com
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

The following changes since commit a51e5124a655b3dad80b36b18547cb1eca2c5eb2:

  Merge tag 'pull-omnibus-111023-1' of https://gitlab.com/stsquad/qemu into staging (2023-10-11 09:43:10 -0400)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20231012

for you to fetch changes up to 8466aa53d623377e114895c6563face25370d7da:

  hw/ufs: Fix incorrect register fields (2023-10-12 14:29:20 +0900)

----------------------------------------------------------------
hw/ufs: fixes

----------------------------------------------------------------
Jeuk Kim (2):
      hw/ufs: Fix code coverity issues
      hw/ufs: Fix incorrect register fields

 hw/ufs/lu.c            | 16 +++++++---------
 hw/ufs/ufs.c           | 10 +++++-----
 include/block/ufs.h    |  4 ++--
 tests/qtest/ufs-test.c |  2 +-
 4 files changed, 15 insertions(+), 17 deletions(-)

