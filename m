Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 506DF75392C
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 13:01:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKGX0-0006wF-M0; Fri, 14 Jul 2023 07:00:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWs-0006vE-Fi
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qKGWn-00058s-ON
 for qemu-devel@nongnu.org; Fri, 14 Jul 2023 07:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689332399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:  content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Gq6iXikECb+8rgR31Vx549bId6+y4HxlMFX0LhdWhFo=;
 b=ZgRNtjgZUIFIg/Nih1jU3Bl+hlEG+kQVQA0BxmU7fRoznGd8fMLqfU3cNemnDRVq7R69XC
 fEHc8Z69LkSe+xVou+xOtNzFusdXuwjZfzlWMAaEGvSJj8/FVbIDFb8/ixTXCaqo9HG3rb
 JUpkhHV2V0PEkDlYVbbyzEKb6VFDoJ0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-RuVYTDOjOpCxDu9eEcB52Q-1; Fri, 14 Jul 2023 06:59:57 -0400
X-MC-Unique: RuVYTDOjOpCxDu9eEcB52Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fc0627eafbso7986415e9.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jul 2023 03:59:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689332395; x=1691924395;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Gq6iXikECb+8rgR31Vx549bId6+y4HxlMFX0LhdWhFo=;
 b=kFVgvZqbtoTb6Yef9v4xC0IcP4tNgl7HFz+9rONjN3UfrD8Ih7XPSkb8midkLKi6oT
 kSouHUc5CqpTJld4Yoih9yx7mK6HelcRW0RtSpcMcUdM9X3NicAIpGDf/5IAB/N7n32z
 hMgqglndOKmJCJBdckzLJ+fjnPgjz0KF6ofpv6+MmooV3VZcYncxgVBJoQww0oWmYfJZ
 x3nMYZSDeI993BNFOpCkIZxdQtSeIHThLQmntmhQBPr0WMgzBEp50PceryVB+Ej5Ug+z
 YFx7ZuZoAsuKLLdCQfUabZUZRlZSVLjjbA+F72ZnS39ZGPfN5Fh5VYqGLUS3c5uwctE6
 4K5Q==
X-Gm-Message-State: ABy/qLYRYf20YTZav0LsDi2/xbMIWz/JnkgujZKeJuPXgXoXu9Gd3UXA
 qaUOQ9oJePGKJ3ZYs/7sX9n0Daun4+NJih5kdEvt+Zmkkcd+Ykl6+6aeezihRGkfXJ758/W5MQ2
 qrukrTYCFegqmA6jtYkSKsjQy7cI3slHfdgWcuWnCO0CaFFAe877g70lpdZrM2koDj6HEGMjIu8
 c=
X-Received: by 2002:a05:600c:1d18:b0:3fa:94ea:583c with SMTP id
 l24-20020a05600c1d1800b003fa94ea583cmr2078922wms.8.1689332395717; 
 Fri, 14 Jul 2023 03:59:55 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHJKatNLp95j9NuaPcl+X3n4T3YDaJBgudMN1JRIO7SSG5xiVdB9ck0zheID5cbjVVssFHm4A==
X-Received: by 2002:a05:600c:1d18:b0:3fa:94ea:583c with SMTP id
 l24-20020a05600c1d1800b003fa94ea583cmr2078909wms.8.1689332395339; 
 Fri, 14 Jul 2023 03:59:55 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.gmail.com with ESMTPSA id
 c8-20020a7bc848000000b003fc06169ab3sm1154099wml.20.2023.07.14.03.59.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jul 2023 03:59:54 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] Patches for QEMU 8.1 hard freeze
Date: Fri, 14 Jul 2023 12:59:48 +0200
Message-ID: <20230714105953.223485-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

The following changes since commit 3dd9e54703e6ae4f9ab3767f5cecc99edf066668:

  Merge tag 'block-pull-request' of https://gitlab.com/stefanha/qemu into staging (2023-07-12 20:46:10 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 2eb5599e8a73e70a9e86a97120818ff95a43a23a:

  scsi: clear unit attention only for REPORT LUNS commands (2023-07-14 11:10:58 +0200)

----------------------------------------------------------------
* SCSI unit attention fix
* add PCIe devices to s390x emulator
* IDE unplug fix for Xen

----------------------------------------------------------------
Cédric Le Goater (1):
      kconfig: Add PCIe devices to s390x machines

Olaf Hering (1):
      hw/ide/piix: properly initialize the BMIBA register

Stefano Garzarella (3):
      scsi: fetch unit attention when creating the request
      scsi: cleanup scsi_clear_unit_attention()
      scsi: clear unit attention only for REPORT LUNS commands

 configs/devices/s390x-softmmu/default.mak |  1 +
 hw/ide/piix.c                             |  2 +-
 hw/net/Kconfig                            |  4 +-
 hw/pci/Kconfig                            |  3 ++
 hw/s390x/Kconfig                          |  3 +-
 hw/scsi/scsi-bus.c                        | 82 ++++++++++++++++---------------
 hw/usb/Kconfig                            |  2 +-
 include/hw/scsi/scsi.h                    |  1 +
 8 files changed, 53 insertions(+), 45 deletions(-)
-- 
2.41.0


