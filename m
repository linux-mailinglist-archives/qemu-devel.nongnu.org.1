Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D28677942E
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 18:18:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUUq2-00019J-7O; Fri, 11 Aug 2023 12:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUq0-000194-7H
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:18:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qUUpy-0002u4-Nq
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 12:18:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691770685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=M1n0dUBoe6R7rj5pNoHWGq+QUWKU5JnXu+Z3+LuF/kE=;
 b=hiHZhE9jxRdSds6lEz8MMxGG3lZ8zO2ngnAXVskLKKqV28MjzSSpJM0wQuXhH41w3Ht1R5
 GfWwxdwrjzBbTTRHpM4FE8osdrutzXsRUPtGr4fuZfKUbsB9Ezuk7FKjrlFVrDIhT6NAOe
 8JfviVbB+RnNxZ7O00kOEIEGxrvFDjk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-OW7NC0-HNk2A2-iZxhipdQ-1; Fri, 11 Aug 2023 12:18:04 -0400
X-MC-Unique: OW7NC0-HNk2A2-iZxhipdQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-51d981149b5so1433019a12.3
 for <qemu-devel@nongnu.org>; Fri, 11 Aug 2023 09:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691770682; x=1692375482;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M1n0dUBoe6R7rj5pNoHWGq+QUWKU5JnXu+Z3+LuF/kE=;
 b=X5221a3hSi1uKPxuGsaAyTbpRM75uo9ULmTrszmkTSU3Xj5T3FNbWAfZv1qX07UvP+
 0+ZN1O+0901O6JtadBTgbOIYf3JATcjAChvx+hBHeJRJTqjGcHhQ34VzMrvDSEBNI2Bf
 +5vpL/pCHllONP9s06+wyso4oO4uaKAtm2ckrvYc4FJbVHycrIBYdJbLtEo2ik/C14uE
 vqxWptGTIBL4N8XODZXK4l5Hvwz+FvbSPNPEZPA2KK3cMXSwMClBApMzV9Qa7Kdfz3oN
 Qbod7bhhgQEISY0RUJt7SmxW7ezvZPEPMn9F5bWfPN9f1P7Ndn/lvcwfatyYyQ55u280
 z5eQ==
X-Gm-Message-State: AOJu0Yw/UgDegEGhBPFG00xMKEwKTbQMPnmmMH6zX+tJ06U/sxewQBKi
 9ZczkeOOKNRre6TYsdDPg2K620UDYZBysc8WnevMmNd83Xif4cthT7vNY5r5bebWyCZfSWFptHB
 4EfZFFa/JQUPGuBHdr0vompevrhQW+X58c6PN4ghO+lRCwYmzv5zTX2IwB5aqVEPPrIPw
X-Received: by 2002:a17:906:3292:b0:99b:eca2:47a8 with SMTP id
 18-20020a170906329200b0099beca247a8mr2103160ejw.38.1691770682494; 
 Fri, 11 Aug 2023 09:18:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGncaSCwUfjvc609njvEtDbZ1iI1wwH6URF8XXG0XgTgkk8edYBeIQs6r862KEN0vjNTz/CFQ==
X-Received: by 2002:a17:906:3292:b0:99b:eca2:47a8 with SMTP id
 18-20020a170906329200b0099beca247a8mr2103146ejw.38.1691770682151; 
 Fri, 11 Aug 2023 09:18:02 -0700 (PDT)
Received: from redhat.com ([2.55.42.146]) by smtp.gmail.com with ESMTPSA id
 lw12-20020a170906bccc00b0099ce23c57e6sm2424084ejb.224.2023.08.11.09.18.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Aug 2023 09:18:01 -0700 (PDT)
Date: Fri, 11 Aug 2023 12:17:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 0/2] pci: last minute bugfixes
Message-ID: <cover.1691770630.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 15b11a1da6a4b7c6b8bb37883f52b544dee2b8fd:

  cryptodev: Handle unexpected request to avoid crash (2023-08-03 16:16:17 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream

for you to fetch changes up to 0f936247e8ed0ab5fb7e75827dd8c8f73d5ef4b5:

  pci: Fix the update of interrupt disable bit in PCI_COMMAND register (2023-08-11 12:15:24 -0400)

----------------------------------------------------------------
pci: last minute bugfixes

two fixes that seem very safe and important enough to sneak
in before the release.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Guoyi Tu (1):
      pci: Fix the update of interrupt disable bit in PCI_COMMAND register

Jason Chien (1):
      hw/pci-host: Allow extended config space access for Designware PCIe host

 hw/pci-host/designware.c | 1 +
 hw/pci/pci.c             | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)


