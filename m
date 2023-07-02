Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF777744D87
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 14:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFvmt-0001wE-Vh; Sun, 02 Jul 2023 08:02:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFvms-0001vz-1d
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:02:42 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qFvmq-0003ii-4n
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 08:02:41 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1b8918dadbdso1568265ad.1
 for <qemu-devel@nongnu.org>; Sun, 02 Jul 2023 05:02:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688299358; x=1690891358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=t49yORRj7RqxcO0+wUvRvnCtFjuToXZNb0rYF/8t+gk=;
 b=FHerak3DMk8NiIUoIzQeQBBkmvYMbyYNNVjM8eCbmUTCRTPawU0QLseQOzU55/+zyk
 jOIMBfvwwq4qlKp0QbsFxkefYhiESGuB6B6r9n36ABkFxHhiCBiPsIq+3YHGo73LaEu1
 1y5/i7D6wXosIej7u+LvFS9dhU17luoZwiEBL30+bDgh44KnbcKOlqHWibwVx6bCgrmD
 ahegK4O9TPCnIOx7VDK0uFAPe4oFud60RhA5UylDD5prKTpF+XHlCWGvY/YiCYcNVM/I
 NDj13EAdajyuNWF+aybihH4ocWIYIJdR9njNuJwHSpAoCz3/YiBbs5l6aEUBVyLOJkuk
 p1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688299358; x=1690891358;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=t49yORRj7RqxcO0+wUvRvnCtFjuToXZNb0rYF/8t+gk=;
 b=ML/xTjPEwJQERoxMAIWj17xCZz2QDL9gbekPqZBVPtPSmAKAwwDzOqjV4dg5/JJdLB
 MVyjebIpNIS9bPlYdoaSyHcoYgxUaA+Ohe/UFW79VLuuutGvT/y/Go6tgYJe84glnhyH
 ChT5SXAn9dlSL79JgREMgju1KjzELyplpaS6tKUcbsCYEzV7wB2YWXV0utBUcfaTjTMQ
 PcGqB6KGw0HX2OU0DHjiqxOnUOP2cvyRVDc4vC9ZQVyBGfhKT4Rgolazt2N8aSyuIgTW
 RjugxBjlSIqlnJbjRf6ZUfQz6lqPM2/nR7jHXz9wZMM8r1MzgXFQirmKhG5F5fGely0S
 W4LQ==
X-Gm-Message-State: ABy/qLYFWlgpUAeqLC4Eljvzd+1boUZ07bKNYaHkZ2n91XlIYTjvKgWG
 SVvbyTJNbu8QQ+1NuasavSa2rc/wC0v4zCawKS4=
X-Google-Smtp-Source: APBJJlGztGCVO2L0RLDUivowezNHf6r52A00HbDv33MNxqCp1VdFuB4wxtozBuDbDfVgawvRubuOKw==
X-Received: by 2002:a17:903:41c7:b0:1b6:c139:9b23 with SMTP id
 u7-20020a17090341c700b001b6c1399b23mr7147385ple.26.1688299358489; 
 Sun, 02 Jul 2023 05:02:38 -0700 (PDT)
Received: from alarm.. ([157.82.204.253]) by smtp.gmail.com with ESMTPSA id
 n9-20020a170902d2c900b001b008b3dee2sm7215563plc.287.2023.07.02.05.02.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 05:02:37 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v3 0/2] pcie: Fix ARI next function numbers
Date: Sun,  2 Jul 2023 21:02:25 +0900
Message-ID: <20230702120229.66978-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::633;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x633.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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


