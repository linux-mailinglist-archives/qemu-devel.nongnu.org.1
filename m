Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB957AB4F5
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Sep 2023 17:42:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qjiIk-0008LU-43; Fri, 22 Sep 2023 11:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIh-0008KL-Uk
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qjiIg-0002nS-AJ
 for qemu-devel@nongnu.org; Fri, 22 Sep 2023 11:42:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695397355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=gsVjqFIe4ZqGpI3Je461Y+CkZ2SHeWeV0NQChxrRW8k=;
 b=Rw+BVCYn2tixaaIFQ7Ov+Oq7IUMeVIlicaL4rEinSiPUjWfdC8MBwagiE2NWNDujfrKObt
 FYZxw/WhsjfSKYQj4NbzVU5VbptEd2MJTpfX5C1bBaFrnrEaqSaKXJi5vUakvxXzh2wQa5
 kRdzVw72yIF88caXPN5YU88f8T+KoZY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-259-XZImGRg8MrmIYTY9mnFg-g-1; Fri, 22 Sep 2023 11:42:33 -0400
X-MC-Unique: XZImGRg8MrmIYTY9mnFg-g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fe1521678fso17744525e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Sep 2023 08:42:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695397350; x=1696002150;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gsVjqFIe4ZqGpI3Je461Y+CkZ2SHeWeV0NQChxrRW8k=;
 b=G6PQXfZjFjA+RSknFZvvto/2HQMZE0v1Q/iypGUG4hKJAzYkHkps0jaABWbgGknxXJ
 KrgmKbO0R3FjpIMkbF/aiTNMdrY0mInljdL4DM7c2mRXlUvaQJzgLa6Tjj0nqxxHjbL3
 Rz7Br4jQu/yH0/NBbxQTfunYKaGEI5mmmNKMiQ4XWtJP+QLQbS5bVw4q3IjnbkJWy2qW
 BAaGqit6AfSdjQQCK87oTN1IE6KCS4DpYE0KYZcEgbKxF0aRaJo3wX1buOXtyW59QZ8l
 VRGEQNGr+A7talclXJY3I8Fc/kfPxRnHnJYdiQ0L7cBup5oiuIBNF3BnAJknSOmQ+NzT
 W22Q==
X-Gm-Message-State: AOJu0YyCCGYz6U05nrMHf5tuRBhL6ZCRtaRT8feyHXr0VVzPC/aNjrbl
 LbVoda1y+oT+rnEVJ8DvJC1o/MznoTvuMA2Qom4SYRzK0nMgrIfz/rPsKSvYr1cbEn3SVUgl23U
 uohgt7/+LPOTrL9bhpBqa2NzbMoEyRMMYMRaD6EFAdlYJOL3Es+LY2l38deSYKpAwv0L5wUuJrH
 U=
X-Received: by 2002:a05:600c:224e:b0:3fe:5501:d284 with SMTP id
 a14-20020a05600c224e00b003fe5501d284mr7637673wmm.11.1695397350656; 
 Fri, 22 Sep 2023 08:42:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHWDy3ir1jsA5PSRi0ScvqVrKxGyYz/ZsQ60LsWAc1o/daPJioza1z0W8wkgdk0p9GNj2iuXg==
X-Received: by 2002:a05:600c:224e:b0:3fe:5501:d284 with SMTP id
 a14-20020a05600c224e00b003fe5501d284mr7637652wmm.11.1695397350157; 
 Fri, 22 Sep 2023 08:42:30 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 s17-20020a1cf211000000b003fe2a40d287sm4965357wmc.1.2023.09.22.08.42.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Sep 2023 08:42:29 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: balaton@eik.bme.hu
Subject: [PULL v2 0/9] i386, audio changes for 2023-09-22
Date: Fri, 22 Sep 2023 17:42:19 +0200
Message-ID: <20230922154228.304933-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

The following changes since commit 005ad32358f12fe9313a4a01918a55e60d4f39e5:

  Merge tag 'pull-tpm-2023-09-12-3' of https://github.com/stefanberger/qemu-tpm into staging (2023-09-13 13:41:57 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to adf7f6b72fb6d10e00e93d04dfa33ce8c5e384c8:

  vl: recognize audiodev groups in configuration files (2023-09-22 17:35:11 +0200)

Zoltan suggested keeping the default audio backends, so I am sending a reduced
version of the pull request.

----------------------------------------------------------------
* add host ticks function for RISC-V
* target/i386: Export GDS_NO bit
* target/i386: add support for bit 56 of MSR_IA32_VMX_BASIC
* first part of audiodev cleanups

----------------------------------------------------------------
LIU Zhiwei (1):
      qemu/timer: Add host ticks function for RISC-V

Martin Kletzander (5):
      hw/input/tsc210x: Extract common init code into new function
      hw/audio: Simplify hda audio init
      hw/audio/lm4549: Add errp error reporting to init function
      hw/display/xlnx_dp.c: Add audiodev property
      tests/qtest: Specify audiodev= and -audiodev

Paolo Bonzini (2):
      target/i386: enumerate bit 56 of MSR_IA32_VMX_BASIC
      vl: recognize audiodev groups in configuration files

Pawan Gupta (1):
      target/i386: Export GDS_NO bit to guests

 docs/config/q35-emulated.cfg            |  4 ++
 docs/config/q35-virtio-graphical.cfg    |  4 ++
 hw/audio/hda-codec.c                    | 32 +++++++++-------
 hw/audio/intel-hda.c                    |  4 +-
 hw/audio/intel-hda.h                    |  2 +-
 hw/audio/lm4549.c                       |  3 +-
 hw/audio/lm4549.h                       |  3 +-
 hw/audio/pl041.c                        |  2 +-
 hw/display/xlnx_dp.c                    |  6 +++
 hw/input/tsc210x.c                      | 68 ++++++++++++---------------------
 include/qemu/timer.h                    | 22 +++++++++++
 scripts/kvm/vmxcap                      |  1 +
 softmmu/vl.c                            | 10 +++++
 target/i386/cpu.c                       |  3 +-
 target/i386/cpu.h                       |  1 +
 tests/qtest/es1370-test.c               |  3 +-
 tests/qtest/fuzz/generic_fuzz_configs.h |  6 ++-
 tests/qtest/intel-hda-test.c            | 15 +++++---
 18 files changed, 115 insertions(+), 74 deletions(-)
-- 
2.41.0


