Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E2A681CE4F
	for <lists+qemu-devel@lfdr.de>; Fri, 22 Dec 2023 19:17:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rGk4F-0000up-9B; Fri, 22 Dec 2023 13:16:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4D-0000ud-Ie
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rGk4A-000686-Ik
 for qemu-devel@nongnu.org; Fri, 22 Dec 2023 13:16:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703268968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Xj/ATv5p7S9zdwanp/L+hUtLKqEMp8uyCuAiJhC3kyc=;
 b=AQ6fq0pUgBmnBYSE0SIO6klLsYztV5FGWqSmp51PwIfMVRo3UUQUrbTUJkvTqN2+yk2RVY
 G4IjaVwXyF04nuTwRoYoyvYk3utRauLZoH7EHgcJnOxJkEJI5jEeSwNQzzLys99e+bCZ60
 hdB59v1WvDLHIKsznQxCifEDYKi4cuo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467--ifIozowNQe77K6yYj72lA-1; Fri, 22 Dec 2023 13:16:07 -0500
X-MC-Unique: -ifIozowNQe77K6yYj72lA-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-40d2f7007e6so16689275e9.1
 for <qemu-devel@nongnu.org>; Fri, 22 Dec 2023 10:16:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703268965; x=1703873765;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xj/ATv5p7S9zdwanp/L+hUtLKqEMp8uyCuAiJhC3kyc=;
 b=c7FraABZJXiGOcBS8NK6xULn0dzNG+y5W5RtqeszP+Xxeylla+/Ox9PmYvAHSSigWw
 KB2khc3qqE0Nv5yLgtdTdmDT0/B3g1GsHm/xdf6bbyZEzjewDdcTlpYtq9bMdp0B13I0
 LhGigLp1qXhhVc4HRBlTh4jW3pTqPPoHChUU/BRhsKowFbrE/RObfQyXEe9s3wvB2pl4
 k5jm610arHLJvTlzfywaD7JFWUI2Hx3n4SvaemF0SFDq+wFrUxqRkbIx2AP5/rPr94xK
 NENF/RcEDTY1Lsda3rL/P8L57e2pZDzbxgpFFrmMFQUX1o1q8ekL8SQEwBNfUxWNBxaE
 qeFg==
X-Gm-Message-State: AOJu0YycNsZeJ1KCiWVltZel9CXAZZEG2+IBXiJ85KhOCp0fiVV2DeW3
 rs3XG+USPXrCkmZucEuepJyBYOfg7XGh6kIeNx1vMj3sQpY/822l6+qLWSvxlVx02iB3aszK877
 KcrqloHYgWDOnhPlYqjKvCOJGuA1iqQ0LJKEXpXB3QdbFk/rGcCJVjheT6WJgDmDc328he9El6Y
 B3gTqL990=
X-Received: by 2002:a05:600c:4f54:b0:40d:4aab:5389 with SMTP id
 m20-20020a05600c4f5400b0040d4aab5389mr360600wmq.106.1703268965394; 
 Fri, 22 Dec 2023 10:16:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGidTCi1/v/hpZ7HvE6L6n5RJpOQXctYLwnBispbCwVhg+4FVZXqj39oKjQM1SGl+OFM2/LNw==
X-Received: by 2002:a05:600c:4f54:b0:40d:4aab:5389 with SMTP id
 m20-20020a05600c4f5400b0040d4aab5389mr360594wmq.106.1703268964964; 
 Fri, 22 Dec 2023 10:16:04 -0800 (PST)
Received: from [192.168.10.118] ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.gmail.com with ESMTPSA id
 hn34-20020a05600ca3a200b0040d1bd0e716sm7549149wmb.9.2023.12.22.10.16.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Dec 2023 10:16:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/22] target/i386: first part of TCG changes for 9.0
Date: Fri, 22 Dec 2023 19:15:41 +0100
Message-ID: <20231222181603.174137-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.082,
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

The main things here are a bunch of cleanups to the common logic of
the new decoder, some changes to translate.c that prepare for redoing
one-byte opcodes in the new framework, and the implementation of the
CMPccXADD instruction that is new in Sierra Forest processors.

These are all relatively innocuous changes, and easy to bisect in
case things go wrong.

Paolo


Paolo Bonzini (22):
  target/i386: optimize computation of JL and JLE from flags
  target/i386: speedup JO/SETO after MUL or IMUL
  target/i386: remove unnecessary arguments from raise_interrupt
  target/i386: remove unnecessary truncations
  target/i386: clean up cpu_cc_compute_all
  target/i386: document more deviations from the manual
  target/i386: reimplement check for validity of LOCK prefix
  target/i386: avoid trunc and ext for MULX and RORX
  target/i386: rename zext0/zext2 and make them closer to the manual
  target/i386: add X86_SPECIALs for MOVSX and MOVZX
  target/i386: do not decode string source/destination into decode->mem
  target/i386: do not clobber A0 in POP translation
  target/i386: do not clobber T0 on string operations
  target/i386: split eflags computation out of gen_compute_eflags
  target/i386: do not use s->tmp4 for push
  target/i386: do not use s->tmp0 for jumps on ECX ==/!= 0
  target/i386: extract gen_far_call/jmp, reordering temporaries
  target/i386: prepare for implementation of STOS/SCAS in new decoder
  target/i386: move operand load and writeback out of gen_cmovcc1
  target/i386: adjust decoding of J operand
  target/i386: introduce flags writeback mechanism
  target/i386: implement CMPccXADD

 target/i386/cpu.c                |   2 +-
 target/i386/cpu.h                |   5 +-
 target/i386/tcg/cc_helper.c      |   6 +-
 target/i386/tcg/decode-new.c.inc | 152 +++++++++++++------
 target/i386/tcg/decode-new.h     |  29 +++-
 target/i386/tcg/emit.c.inc       | 224 +++++++++++++++++++++------
 target/i386/tcg/excp_helper.c    |   7 +-
 target/i386/tcg/fpu_helper.c     |  10 +-
 target/i386/tcg/helper-tcg.h     |   3 +-
 target/i386/tcg/int_helper.c     |   8 +-
 target/i386/tcg/misc_helper.c    |   4 +-
 target/i386/tcg/seg_helper.c     |   8 +-
 target/i386/tcg/translate.c      | 250 ++++++++++++++++++-------------
 tests/tcg/i386/Makefile.target   |   2 +-
 tests/tcg/i386/test-flags.c      |  37 +++++
 15 files changed, 509 insertions(+), 238 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c

-- 
2.43.0


