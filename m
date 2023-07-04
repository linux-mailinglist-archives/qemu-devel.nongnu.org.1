Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 193AF7470F4
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 14:23:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGf3G-0001th-I6; Tue, 04 Jul 2023 08:22:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGf35-0001sB-6k
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:22:27 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qGf30-0007gL-DI
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 08:22:25 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-66767d628e2so3207910b3a.2
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 05:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688473341; x=1691065341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=r8KOACREjFfGNE+uWT17N2lXMicp2YLBF7n+qVDwtU0=;
 b=EMC5JX53FF2zNqAJC1EKnREMGnZSA9QWhshsg8fp5IM4b50Spo5ojI7wF/slf1g+9h
 XorgaPOyQ219LSoSvPrsnfO+98+Ry3uXY+axQOr11aCEc7AtI4MWtYy10isgy1zq6+wv
 kDZDhqtRHfvQB175i2EeAOihkc+fuwrVXxlXELBlDW4wbQFApZWzinTpJxlbxD7mX3BY
 B+3eYa6QJpUKI9fgqGrytQbBzwqHt2rUMFxquKdF2BsYJqhjuVxxqU5GEjCT/0it/wTv
 YD04M3BelRl9g+KPavQ4sIjWvwbU+LqlUihzlqXnKqMXTlwK1vBYJcLFjeOPKgDcgq8j
 Or3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688473341; x=1691065341;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=r8KOACREjFfGNE+uWT17N2lXMicp2YLBF7n+qVDwtU0=;
 b=VYYS6x9vM2O6sJim8WgNn+yswNn/jtlJ9iBJ7pLsquzHuMaMFNgJ+wK8WXErU13HmQ
 h2VyclyVhs6eyqotvdWoCccnx3a/qoZxx/SH0elPVM/N3UKy/WKatyVBM+UG7vB0adHD
 vHswLjqSbX5eqZHruoJbqm0OCx8DD4J1kj6mQNN6DxlagxSTQaiCGi2R1DYM6FkOKAZP
 b7YkpoYkgGkhC3sHrc6ui8rPGt1hBXVEPexVK6fhWeH3XcDhjE5XDXGbN14b/m6gtW70
 F5cyOByZ3sIlE5V7rtVaMcS27a2eYZM3rQzZ/KE4jlX92CyOZw9Z7H4Bo8AQ8EGkpxn/
 B1ow==
X-Gm-Message-State: ABy/qLb6hZooNKX5Dn39wyWCI6r6ost4O7YzGibjwuzA8KengrRl1x1F
 DApaZwbFSS3npsPiZFcqOMIrDwX+W4x/cubRgs4=
X-Google-Smtp-Source: APBJJlE/JVHay6ljI9v7Sb2JY2F3DFfD5qyA+WQsfu55bkUCCx1c9RT8P1IzVx+MhP1tC3R16XJp/A==
X-Received: by 2002:a05:6a00:2493:b0:682:7d8a:f887 with SMTP id
 c19-20020a056a00249300b006827d8af887mr6508791pfv.30.1688473340673; 
 Tue, 04 Jul 2023 05:22:20 -0700 (PDT)
Received: from alarm.flets-east.jp ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 x48-20020a056a000bf000b0064d32771fa8sm11009743pfu.134.2023.07.04.05.22.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 05:22:20 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
To: 
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Sriram Yagnaraman <sriram.yagnaraman@est.tech>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH v4 0/2] pcie: Fix ARI next function numbers
Date: Tue,  4 Jul 2023 21:22:12 +0900
Message-ID: <20230704122215.23270-1-akihiko.odaki@daynix.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::42d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x42d.google.com
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


