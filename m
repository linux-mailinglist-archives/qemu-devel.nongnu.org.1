Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B753174B2AA
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 16:06:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHm4i-0007B8-S7; Fri, 07 Jul 2023 10:04:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4g-0007Ak-3Y
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHm4d-0006M2-U2
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 10:04:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688738678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rBnN1MMNDLoJzaTmRCVkC+Vc41Ac07W6gnA+jLJ/Fm8=;
 b=GRWmRxRD2PjOx5msaAGCsKAQGK8zshvLOGas9L2SbSoC5QNqbw6w/CeeCqztL0NnkFbLWo
 ncUSMTMIEID66KKhCo0eZwUyr/eGp1Sl7WH7Y9iGyMics0jk2dARxqi1q1UPnJOSN9aRRe
 hV6Nw1+gsrPgyLEUaeBE4Fs8NKefTYE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-194-MFLXmIWuMIyN5PAH8rm_Zg-1; Fri, 07 Jul 2023 10:04:36 -0400
X-MC-Unique: MFLXmIWuMIyN5PAH8rm_Zg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-99388334de6so129553166b.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 07:04:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688738674; x=1691330674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rBnN1MMNDLoJzaTmRCVkC+Vc41Ac07W6gnA+jLJ/Fm8=;
 b=OF7yBx7SWmNUgex993PIMx7k/Wk+ERXHnx7Iz4KWWXnl6Y24nHQtyl8lWqXsnJNoya
 6jUMwBbEV/CE3HrzJp6OJzu9NFvNefMRs9UJoZ+AgTG9txM8Ujf17L8UeDRpkeRm79vs
 uw6xxBXB2N2UkUz/MgOwJOfEAe1ahQaKWbWTemX2e/p2KAjq2rS9Q/6ZZOkvo7kf2YqV
 9xLAaUwmzn5Dv37aKuI40PUpSJmSm15q9mXt9X1IafLrgXph503AcVEMAZRF1++iUonX
 N3fC9BcGYx64nTYQwRJQU20MueuMl2/4TwaeDUB7gingY7zF0Yn4NAGkpEYB3cjrTgya
 MJMA==
X-Gm-Message-State: ABy/qLacpDpPqThb49GlDTaCJFtBJ6qTUwKzTedpmJBeQfwo353zMztG
 k+AVFTzNyuF8UTwX+UMfUURV9aoKwff5q0mcEgRXD75sGS6cGjXbczRezprHyXvVK0Y2qpEejJX
 JKB/CIuIxntmHk5iXDdZ2WEzrTiUILFb9VO+hTBEnvwR4YsQ3j9hS2gZT49a99qLiQK5r1GbDAi
 4=
X-Received: by 2002:a17:907:75db:b0:992:9a5e:3172 with SMTP id
 jl27-20020a17090775db00b009929a5e3172mr3811522ejc.59.1688738674605; 
 Fri, 07 Jul 2023 07:04:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlG8Q+opWj41nK12as1RXIlKpC7FwzzFCNMkNqztiMS3YZ7mqaQvdKOE85GjHijgM5YQjh93FQ==
X-Received: by 2002:a17:907:75db:b0:992:9a5e:3172 with SMTP id
 jl27-20020a17090775db00b009929a5e3172mr3811505ejc.59.1688738674197; 
 Fri, 07 Jul 2023 07:04:34 -0700 (PDT)
Received: from [192.168.122.1] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 j10-20020a17090686ca00b0098e16f8c198sm2272343ejy.18.2023.07.07.07.04.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Jul 2023 07:04:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/9] Final batch of patches for QEMU 8.1 soft freeze
Date: Fri,  7 Jul 2023 16:04:23 +0200
Message-ID: <20230707140432.88073-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
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

The following changes since commit 97c81ef4b8e203d9620fd46e7eb77004563e3675:

  Merge tag 'pull-9p-20230706' of https://github.com/cschoenebeck/qemu into staging (2023-07-06 18:19:42 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6d5e9694ef374159072984c0958c3eaab6dd1d52:

  target/i386: Add new CPU model GraniteRapids (2023-07-07 12:52:27 +0200)

----------------------------------------------------------------
* Granite Rapids CPU model
* Miscellaneous bugfixes

----------------------------------------------------------------
Fiona Ebner (1):
      qemu_cleanup: begin drained section after vm_shutdown()

Lei Wang (1):
      target/i386: Add few security fix bits in ARCH_CAPABILITIES into SapphireRapids CPU model

Paolo Bonzini (1):
      python: bump minimum requirements so they are compatible with 3.12

Tao Su (5):
      target/i386: Adjust feature level according to FEAT_7_1_EDX
      target/i386: Add support for MCDT_NO in CPUID enumeration
      target/i386: Allow MCDT_NO if host supports
      target/i386: Add new bit definitions of MSR_IA32_ARCH_CAPABILITIES
      target/i386: Add new CPU model GraniteRapids

Thomas Huth (1):
      meson.build: Remove the logic to link C code with the C++ linker

 meson.build                |  22 ++----
 python/qemu/qmp/qmp_tui.py |   5 +-
 python/setup.cfg           |   2 +-
 python/tests/minreqs.txt   |   9 ++-
 qga/meson.build            |   2 +-
 scripts/main.c             |   1 -
 softmmu/runstate.c         |  20 +++---
 target/i386/cpu.c          | 172 +++++++++++++++++++++++++++++++++++++++++++++
 target/i386/cpu.h          |   8 +++
 target/i386/kvm/kvm.c      |   4 ++
 10 files changed, 210 insertions(+), 35 deletions(-)
 delete mode 100644 scripts/main.c
-- 
2.41.0


