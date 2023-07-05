Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C9E4A747B89
	for <lists+qemu-devel@lfdr.de>; Wed,  5 Jul 2023 04:26:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGsC2-0007n6-6O; Tue, 04 Jul 2023 22:24:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGsBz-0007mS-P3
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 22:24:31 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGsBx-0002EP-VX
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 22:24:31 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-666eb03457cso3017003b3a.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 19:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688523868; x=1691115868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LSQjhHiAUbRfXq114tdLPljZaEqDOzXkcBfl2K5kawU=;
 b=OVhBlVvTysabHySvN2KZvCqLeASK/g+Xw5oOceA5DKKqo4SNvZsbHCHZSk4pBM/Sjo
 sYN8IVarcafNuAxcvdjTkxfZFyXdIWtRLktIhA1Cyz61y0oxQe3GGD8SdgqpD+qRtyI6
 SoEDFp1KN17FrjGtwsDoBUrNSeaSWmVoTtkQmtMPIPH52z+9grMB+vypi+Daeu9V8gcB
 oys5dnfP5iQtgzEFXzi2BKlmRyY7c6jbefRUmcPWIWf4QWJ6gvh8pjnnNvx+RjOtY7XV
 Iym2tIwRbmnmLn63CScgdLIXfIagANkJ36+jKU6oeJdx6+KxkrdOudl32cLqNTyeqTj5
 +qiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688523868; x=1691115868;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LSQjhHiAUbRfXq114tdLPljZaEqDOzXkcBfl2K5kawU=;
 b=fFFLHvgSCfUudZdRvhQy76srhYle8PB1R9YAxRp5AITWv2M2diT3dJZp+P41KaHdfu
 5HPJvmKnYTgsXxJCv05d9Cip++K7YuH6PC5WLYPq/kvxYDlkFSHzRQADbAdmwiWVzADE
 8qPq9i5/Gbqi+pBzd9JbTsEMy/Ql+lTJteEj1K9QiI/FdBTt85BPZiEISS8LSgbv4pE9
 VkuYdd7XUjL22CjYbxU5ILy5+GFiOaqwuHvveMB7pkjUfgk6Ng/39d8AhDOhQAn6I4Y7
 p1Q1rW4T0+19ONcahGJ12R0K0DPq0u5fv5Rg2rSBkzTpkZ1qw5HUydqq6KkFp0WGtHhn
 OFyQ==
X-Gm-Message-State: AC+VfDxFP0AhtMllb7QDHgzgAi0IvqqE4GJu7OTsq0LjpLArzeVjySc6
 injf9C2EeYWyG3SD1jRABC2Oay5RwXy5d59GOcQ=
X-Google-Smtp-Source: ACHHUZ61lEvdVnlNEkpRYYNDM3gbWljgtT7roEZHbq8k6AV08nYGDbqH5fU31dE3/P0AAifeuGkifw==
X-Received: by 2002:a05:6a20:1044:b0:12c:e3c8:8c7 with SMTP id
 gt4-20020a056a20104400b0012ce3c808c7mr11523006pzc.41.1688523868346; 
 Tue, 04 Jul 2023 19:24:28 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 u10-20020a17090282ca00b001b8062c1db3sm15235365plz.82.2023.07.04.19.24.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 19:24:27 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v5 0/2] pcie: Fix ARI next function numbers
Date: Wed,  5 Jul 2023 11:24:18 +0900
Message-ID: <20230705022421.13115-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::430;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x430.google.com
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

The ARI next function number field is undefined for VF. The PF should
end the linked list formed with the field by specifying 0.

Supersedes: <20230701070133.24877-1-akihiko.odaki@daynix.com>
("[PATCH 0/4] pci: Compare function number and ARI next function number")

V4 -> V5:
  Added references to the specification. (Igor Mammedov)

V3 -> V4:
  Corrected the default value of x-pcie-ari-nextfn-1. (Igor Mammedov)
  Added an explanation for migration compatibility. (Igor Mammedov)

V2 -> V3:
  Moved the logic to PCI common infrastucture (Michael S. Tsirkin)

V1 -> V2:
  Fixed migration. (Michael S. Tsirkin)
  Added a caveat comment. (Michael S. Tsirkin)

Akihiko Odaki (2):
  pcie: Use common ARI next function number
  pcie: Specify 0 for ARI next function numbers

 docs/pcie_sriov.txt   | 4 ++--
 include/hw/pci/pci.h  | 2 ++
 include/hw/pci/pcie.h | 2 +-
 hw/core/machine.c     | 1 +
 hw/net/igb.c          | 2 +-
 hw/net/igbvf.c        | 2 +-
 hw/nvme/ctrl.c        | 2 +-
 hw/pci/pci.c          | 2 ++
 hw/pci/pcie.c         | 4 +++-
 9 files changed, 14 insertions(+), 7 deletions(-)

-- 
2.41.0


