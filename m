Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FE874CF7E
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:09:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlwq-0006xj-3o; Mon, 10 Jul 2023 04:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIlwn-0006wY-1Z
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:08:42 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qIlwk-0006sl-VO
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:08:40 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-55ba5fae2e6so3175379a12.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688976517; x=1691568517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=IO1IkNeXZfzNexFJpBq4yPuK/kXmji2NhPdOlmiR8+o=;
 b=wXJAyrr1F8W81uZTHjy5ix/X6fzOk+SgnIfwbilMwvW2BkQa35OzIwyn4Op9CHi3PE
 MdDLaqGh+jRub1+s5HK2cipP7i8kEb50fvJjhDe2WE78+o1BNSsEuFWo5FdAJyUD42bj
 QH2fS9clQxomGp0MCi4uIp7UgsoBP4wJF2RNskbkTJl8dM9en5cN05YgeM402AQuq+Mr
 RCbjvnx/U9Z5XZt5a4UPj45B8KD5bbTCBlFlolYTqfgZAxqKPdr9NyKaQoKv+PzTOSCc
 wtRMa87CQuHQtk7oKjby92jAeVbKurYm6phZ3P29jXdQUAe11b9Lw8iFaqZQ51RGVCDD
 LdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688976517; x=1691568517;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IO1IkNeXZfzNexFJpBq4yPuK/kXmji2NhPdOlmiR8+o=;
 b=JNwnt18FbSuCeNx7pJQ1p4H/RPxSxlsF9cTrFRpOYgGRwl/jczQx7QTINf7MokbPiG
 7BAI4fotdcKU3yvMPrPgfJa1jiwBavvBad5h1nFnrcuX70eOFeLtGLtnLcs+0mFVqZQK
 bkAqRhXlXZVI5EmTpPtIvN0faREruCiRJxATq6MyIkuHEMht6abqBUKxjQwnglZeBIId
 RogkBg/YEGbBdSeflHTz30OsK6UUils/IAIs1fRMOx5Q7h9HgmkNhFqtod/WSUg2DTKX
 lZRxvZt7JkUTer288l437W3r/n6vZySRLUwYI9jR1HNzA5vM6AXI0+f1gPyhrISzQZtn
 MQjQ==
X-Gm-Message-State: ABy/qLajRNNlwxsv6ruqQKzNxq8uV/2tHbfUsZXlpHQQOksQ3cEDL+by
 vO8NQ6lQtVFgczsqbbvE3iptAx1GydbVfkXLpDM=
X-Google-Smtp-Source: APBJJlHO9HLGBoJNaUyf5gF+v7m04BhhbUnogZWLHWHkNJWrmN5ZWoxyvOuzMc/UBf9UeUxxTQXMWA==
X-Received: by 2002:a05:6a20:a11a:b0:11f:c1a1:8c with SMTP id
 q26-20020a056a20a11a00b0011fc1a1008cmr15844874pzk.54.1688976517390; 
 Mon, 10 Jul 2023 01:08:37 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 q21-20020a62ae15000000b00640dbbd7830sm6814073pff.18.2023.07.10.01.08.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Jul 2023 01:08:36 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v6 0/2] pcie: Fix ARI next function numbers
Date: Mon, 10 Jul 2023 17:08:27 +0900
Message-ID: <20230710080830.19053-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::532;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x532.google.com
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

V5 -> V6:
  Clarify that the requirement to end the linked list of Function numbers is
  not specific to SR-IOV. (Ani Sinha)

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


