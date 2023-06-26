Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C83073D9D7
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 10:34:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDhfP-0005Lj-Hi; Mon, 26 Jun 2023 04:33:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhfD-0005K6-8z
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qDhfA-0005ia-Ub
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 04:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687768407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=TaCA9HrbOsMp5KekAe1LfdLuEYecO/pXTAG3bs5m4j4=;
 b=Z+K19IOfrXmlxqKRfpcFuV1ZotKMh4hE+wjQ/QSZoVIaZIMJu6R+luj6RNeh1uxuWOvAXo
 KQahl8QBi9LvvskIplbAU6+KbYmjGQz/QGt1kL/BQEuR9XRInUajuUMcjqKyoz3xRhf4GI
 Jbuy4r40T3coCIh7pppblXLeuyLHZyI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-91cYqbWbMReZX4_vhXP14A-1; Mon, 26 Jun 2023 04:33:20 -0400
X-MC-Unique: 91cYqbWbMReZX4_vhXP14A-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f9d7ff4b6aso18720015e9.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 01:33:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687768399; x=1690360399;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TaCA9HrbOsMp5KekAe1LfdLuEYecO/pXTAG3bs5m4j4=;
 b=REFRurlbsOXCDpNDSKqOfnQZP/BkdCwym903WtMuCTw7NJppffhjKpA/nA0kJf/O2m
 obbiNosSoUvnKXCqnHgLW8W1XKIPuMgcMeV2M38KbtculyxR4qUL2J+k1T2sHhgSHLPL
 +rMeTm5tcqsNNrFLltQf28cahyCPrtsiVjBVUdhtCYleml/hj7aERUPZnawY+MBDFOSX
 LmHuR5UJc5kBlb+9RYggqhZI5LJWrDPbQwge0W7KWd8kXLNTMfdLmr4r/RRrk6/biiEl
 lA/d0UrC5LmkqcC3cwhgFKfQLYAhCWkZLTrOr2m3Ampjn7jc50/XCsl4O+Oi4P0XxkYU
 BpZA==
X-Gm-Message-State: AC+VfDwc0EHqx2YYBixLyHqOu0l660kf4SDY1Vf2QigYyzqOAyOAHS/b
 latOnaq9psRgxa9n9a59+fhOLODPk9Zggy4XdmawZr5GabnTJlzY7P+qN/6AIiJ6EaZvDIYAdpf
 yfYdkyyYaGCkfUe1eyvtSSadU6owknl5947e5z6CKQXasN66IY38bvlbvbMhgBBMYYidV01qO1D
 w=
X-Received: by 2002:adf:ffce:0:b0:30a:ec3b:58d8 with SMTP id
 x14-20020adfffce000000b0030aec3b58d8mr23118139wrs.3.1687768398937; 
 Mon, 26 Jun 2023 01:33:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5OzB9cd9DZ1OUAalEvqDVpxlfqZcmButgtNiv/ex/ib8Ju/ofIxZz0i4QH0tit86IaDePmHA==
X-Received: by 2002:adf:ffce:0:b0:30a:ec3b:58d8 with SMTP id
 x14-20020adfffce000000b0030aec3b58d8mr23118121wrs.3.1687768398426; 
 Mon, 26 Jun 2023 01:33:18 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 f13-20020a5d50cd000000b0030647d1f34bsm6710259wrt.1.2023.06.26.01.33.17
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 01:33:17 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 0/3] target/i386: allow using named CPU modeles with user
 mode emulation
Date: Mon, 26 Jun 2023 10:33:14 +0200
Message-ID: <20230626083317.144746-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

When running qemu-i386 even with -cpu Nehalem (aka x86_64-v2), it raises the
warning

  TCG doesn't support requested feature: CPUID.80000001H:EDX.lm [bit 29]

Likewise using qemu-x86_64 with -cpu Haswell, it raises warnings for

  TCG doesn't support requested feature: CPUID.01H:ECX.pcid [bit 17]
  TCG doesn't support requested feature: CPUID.01H:ECX.x2apic [bit 21]
  TCG doesn't support requested feature: CPUID.01H:ECX.tsc-deadline [bit 24]
  TCG doesn't support requested feature: CPUID.07H:EBX.invpcid [bit 10]

Even though x86_64-v3 is the level that qemu-user is supposed to provide.
These are two related problems:

- for Haswell, the 4 missing features are only relevant to code running
  in kernel mode; we can ignore them and mark them as supported even
  though they are not.  The supported features are only used to print
  the warnings

- for qemu-i386, the issue is that this emulator is restricted to running
  programs on a 32-bit processor, even though it is actually emulating
  programs that use the 32-bit kernel ABI on any processor.  The behavior
  the processor in compatibility (32-bit CS, EFER.LMA=1) mode is mostly
  the same as when EFER.LMA=0 and the little code that is needed to handle
  64-bit ring-0 is even present in the qemu-i386 binary, just hidden
  behind checks for HF_LMA_MASK.  So, LM can also be treated as a feature
  that is only relevant in kernel mode; not entirely, so this cannot yet
  be extended to bsd-user, but the required changes are minimal.

Other CPU models have warnings for the ARCH_CAPABILITIES MSR; hide
them as well in a similar manner.

Based-on: <20230623131711.96775-1-pbonzini@redhat.com>

Paolo Bonzini (3):
  target/i386: ignore ARCH_CAPABILITIES features in user mode emulation
  target/i386: ignore CPL0-specific features in user mode emulation
  target/i386: emulate 64-bit ring 0 for linux-user if LM feature is set

 linux-user/i386/cpu_loop.c  |  57 ++++++++++----------
 target/i386/cpu.c           | 103 +++++++++++++++++++++++++++++++++---
 target/i386/tcg/translate.c |   6 ++-
 3 files changed, 126 insertions(+), 40 deletions(-)

-- 
2.41.0


