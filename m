Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1993E7CF5A5
	for <lists+qemu-devel@lfdr.de>; Thu, 19 Oct 2023 12:48:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qtQYU-0006Mz-WE; Thu, 19 Oct 2023 06:47:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYN-0006FE-LI
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:47:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qtQYL-0006Bi-83
 for qemu-devel@nongnu.org; Thu, 19 Oct 2023 06:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697712415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=4LxP8MBppe2M/eC/fHJhQSD7fL0IBXly0uIP/O8N2hI=;
 b=RZlKO5OQYPg7xVzovwOV86e92GzS01DjhumYrWbZG2QsKIGs85VQbNdPSYXdXmZ/nfdO4y
 Gc1Iue0wCHXLDONlaMpLe3C/4w4DnPsC+CTRzt/rBciMxDOYfh2wkbm4fs5J9UakujvB7D
 odtcqccpyjlwgsqN8MeiY3Rumg0dqJc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-314-Z3vCJ5K2PaWhWgHDxvNByA-1; Thu, 19 Oct 2023 06:46:52 -0400
X-MC-Unique: Z3vCJ5K2PaWhWgHDxvNByA-1
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-5362b33e8ffso5992315a12.3
 for <qemu-devel@nongnu.org>; Thu, 19 Oct 2023 03:46:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697712411; x=1698317211;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4LxP8MBppe2M/eC/fHJhQSD7fL0IBXly0uIP/O8N2hI=;
 b=o507J8REWgAUC0n2EDyvdPM4dfkqSpdVuy6QyLTK9f5oNrVjafT2Ik64z6J47tN9df
 toWKMO7DC7RKnmXzS4tZTKH91c1lPuXR8MSS6oHxoa2kyPHBtC3NYBlpJZIlj46uWqUa
 +j9ypbRVpwkcvxex25cTDN4AyH7+DLkzGwbtmsZrEiRyxBaZqcNG5JROGLzNYeHGnxRy
 Ujg9xvG9BKOEUGgdhx5Uy/07zucvHKZIQostcQ8/Evm8IaoQ6ME2y8+Lu3QEw/8s6e82
 6eJB8GhRcFNz0My2l93nYOLk8NqcAfh+7CqILwl4FW3jlnQv6/9urSCXD7TXHXHgkAS2
 1eYw==
X-Gm-Message-State: AOJu0Yzz3maKKl/TfX4fEXJDvvNIdEdKYYhs+mwKmNAah0uvZtApgbcV
 aVIusQzwNkDdBNl+2ZNMCLOd+7/ZvyKtr1pM5qFHrvyFcAfHNQHraMpenPJ4EYqcZLu5+Y7Qdu6
 6qA0EsOGPY2Z+WF20cyTcNO/Hg6ezTcg/G9SOtV8sUpLGnv57++BDC2oNtPXnHATeNexWNRS0zr
 A=
X-Received: by 2002:a17:907:94c1:b0:9be:e90:5016 with SMTP id
 dn1-20020a17090794c100b009be0e905016mr1258506ejc.24.1697712410901; 
 Thu, 19 Oct 2023 03:46:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXo/XTln3ysCu2b7v3zPsxhP7JIwKH/4g0/X0wzkpZkVGzA+Q4SvLNzsTEnI9U58UN3XPqIA==
X-Received: by 2002:a17:907:94c1:b0:9be:e90:5016 with SMTP id
 dn1-20020a17090794c100b009be0e905016mr1258491ejc.24.1697712410441; 
 Thu, 19 Oct 2023 03:46:50 -0700 (PDT)
Received: from [192.168.10.118] ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a1709064b0400b009b947aacb4bsm3306480eju.191.2023.10.19.03.46.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Oct 2023 03:46:49 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 00/19] target/i386: decoder changes for 8.2
Date: Thu, 19 Oct 2023 12:46:29 +0200
Message-ID: <20231019104648.389942-1-pbonzini@redhat.com>
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

The new decoder produces roughly 2% more ops, but after optimization there
are just 0.5% more and almost all of them come from cmp instructions.
For some reason that I have not investigated, these end up with an extra
mov even after optimization:

                                sub_i64 tmp0,rax,$0x33
 mov_i64 cc_src,$0x33           mov_i64 cc_dst,tmp0
 sub_i64 cc_dst,rax,$0x33       mov_i64 cc_src,$0x33
 discard cc_src2                discard cc_src2
 discard cc_op                  discard cc_op

It could be easily fixed by not reusing gen_SUB for cmp instructions,
or by debugging what goes on in the optimizer.  However, it does not
result in larger assembly.

Paolo

v1->v2: call set_cc_op from the delayed flags writeback
	preparation for CC_OP_DYNAMIC
	fix INC/DEC to use delayed flags writeback
	remove cc_srcT from delayed flags writeback
	annotate places that call set_cc_op() from emit functions
	rewrite IMUL expansion to avoid nowb and to commonize flags handling
	introduce tcg_gen_negsetcondi*

Paolo Bonzini (19):
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
  tcg: add negsetcondi
  target/i386: move 60-BF opcodes to new decoder
  target/i386: move operand load and writeback out of gen_cmovcc1
  target/i386: move remaining conditional operations to new decoder
  target/i386: remove now converted opcodes from old decoder
  target/i386: remove gen_op

 include/tcg/tcg-op-common.h          |    4 +
 include/tcg/tcg-op.h                 |    2 +
 target/i386/cpu.c                    |    4 +-
 target/i386/cpu.h                    |    1 +
 target/i386/ops_sse.h                |  128 ++++
 target/i386/tcg/decode-new.c.inc     |  616 ++++++++++++++--
 target/i386/tcg/decode-new.h         |   43 +-
 target/i386/tcg/emit.c.inc           |  745 ++++++++++++++++++-
 target/i386/tcg/ops_sse_header.h.inc |   14 +
 target/i386/tcg/translate.c          | 1001 +++-----------------------
 tcg/tcg-op.c                         |   12 +
 tests/tcg/i386/Makefile.target       |    2 +-
 tests/tcg/i386/test-avx.c            |    8 +
 tests/tcg/i386/test-avx.py           |    3 +-
 tests/tcg/i386/test-flags.c          |   37 +
 15 files changed, 1644 insertions(+), 976 deletions(-)
 create mode 100644 tests/tcg/i386/test-flags.c

-- 
2.41.0


