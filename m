Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 898AE7C9401
	for <lists+qemu-devel@lfdr.de>; Sat, 14 Oct 2023 12:02:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrbSg-0002Sf-0h; Sat, 14 Oct 2023 06:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSe-0002SO-2o
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qrbSc-0003xl-FR
 for qemu-devel@nongnu.org; Sat, 14 Oct 2023 06:01:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697277688;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0hEhZVtKxcOFMhQ+y2LGspTTNbkk04Cqm8aRW+Oqzao=;
 b=DRTn6vkyU9dx3OnAHEwgucalfD+RRK8lsDjJts+Tuk12s01XjMCApqiXxUDAI1DFGJ94Pg
 l0C1shH3La9u/s6C+6o0Ueg0zjlPE1r5R/J9qTm/XHBpBFK9J93V7c2jlpb92SlaNuFEAd
 zvsBJKq2y9oVE8TCRfbiMUI/0RYMqzY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-496-MnTBx4fkPdus24tTg9DOng-1; Sat, 14 Oct 2023 06:01:25 -0400
X-MC-Unique: MnTBx4fkPdus24tTg9DOng-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-53db360296eso2477210a12.3
 for <qemu-devel@nongnu.org>; Sat, 14 Oct 2023 03:01:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697277683; x=1697882483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0hEhZVtKxcOFMhQ+y2LGspTTNbkk04Cqm8aRW+Oqzao=;
 b=HheMIx2FuuF9bajPmgrMlrZ6ZtFM4yqANeLt2io/RZMgHqQrC2hkb1nNMmRTILdxKs
 5D/9PSRZfzDREHUXUEZ9q0Y3NFt9i8dtr1mPj6/iVJ3ZInIbdhl/yQTGB4m/NrpYE8CK
 Cs2zTKui49PKFsGiwRo3KIF5DfzZuoNrrLLrH4m+fg5YsnwvNybAGmPiUMU8FDcJYMpm
 gIMFxAvK7AlRG+LD137UddXJB4bm4EeFeJCbAcFtuXo42YGxDICyq4Jp9lVD8xedSSLA
 ZxOOZhAc7C1re8WqcJLpO9/CtCvPWoT1h9e4OJ2CRvnRFTAlBYYR3X5Y9A/nQ6MkJXZb
 iybQ==
X-Gm-Message-State: AOJu0Yzo4GDiy+VTcKpSbl2I0K2sCsipm5wUbc6E7gLpP2GjKUW6QuXQ
 qlNNFwweOtDWI4hBXRNQZAHKiu3QOBV8W69Vn2M0eXHaGN4XXvtOemyi+4mFGXiLQVlBx18Fq6Z
 nar+kUi4fhTEHG+/fJfi5TRN23dAiW/lZfmNxc3BtoES/JYDisJUAEqufrPdUWMFN3ILWFMJtdZ
 Y=
X-Received: by 2002:a50:9f4f:0:b0:53e:3b8f:8a5a with SMTP id
 b73-20020a509f4f000000b0053e3b8f8a5amr3516566edf.39.1697277683685; 
 Sat, 14 Oct 2023 03:01:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJPPzLv3B2hhTU+kbdrp8cTBhg+XQsWcEuRBKrHmE3YSF576uFmn2++7wMIe9KBmgTcGh/qQ==
X-Received: by 2002:a50:9f4f:0:b0:53e:3b8f:8a5a with SMTP id
 b73-20020a509f4f000000b0053e3b8f8a5amr3516549edf.39.1697277683161; 
 Sat, 14 Oct 2023 03:01:23 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 p14-20020aa7cc8e000000b005340d9d042bsm12318850edt.40.2023.10.14.03.01.22
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Oct 2023 03:01:22 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/18] target/i386: decoder changes for 8.2
Date: Sat, 14 Oct 2023 12:01:02 +0200
Message-ID: <20231014100121.109817-1-pbonzini@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This includes:

- implementing SHA and CMPccXADD instruction extensions

- introducing a new mechanism for flags writeback that avoids a
  tricky failure

- converting the more orthogonal parts of the one-byte opcode
  map, as well as the CMOVcc and SETcc instructions.

Tested by booting several 32-bit and 64-bit guests.

Paolo


Paolo Bonzini (18):
  target/i386: group common checks in the decoding phase
  target/i386: validate VEX.W for AVX instructions
  target/i386: implement SHA instructions
  tests/tcg/i386: initialize more registers in test-avx
  tests/tcg/i386: test-avx: add test cases for SHA new instructions
  target/i386: accept full MemOp in gen_ext_tl
  target/i386: introduce flags writeback mechanism
  target/i386: implement CMPccXADD
  target/i386: do not clobber A0 in POP translation
  target/i386: reintroduce debugging mechanism
  target/i386: move 00-5F opcodes to new decoder
  target/i386: adjust decoding of J operand
  target/i386: split eflags computation out of gen_compute_eflags
  target/i386: move 60-BF opcodes to new decoder
  target/i386: move operand load and writeback out of gen_cmovcc1
  target/i386: move remaining conditional operations to new decoder
  target/i386: remove now converted opcodes from old decoder
  target/i386: remove gen_op

 target/i386/cpu.c                    |    4 +-
 target/i386/ops_sse.h                |  128 ++++
 target/i386/tcg/decode-new.c.inc     |  605 ++++++++++++++--
 target/i386/tcg/decode-new.h         |   41 +-
 target/i386/tcg/emit.c.inc           |  726 ++++++++++++++++++-
 target/i386/tcg/ops_sse_header.h.inc |   14 +
 target/i386/tcg/translate.c          | 1001 +++-----------------------
 tests/tcg/i386/Makefile.target       |    2 +-
 tests/tcg/i386/test-avx.c            |    8 +
 tests/tcg/i386/test-avx.py           |    3 +-
 tests/tcg/i386/test-flags.c          |   37 +
 11 files changed, 1593 insertions(+), 976 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c

-- 
2.41.0


