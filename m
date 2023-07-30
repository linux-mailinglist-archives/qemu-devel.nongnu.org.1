Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A85ED768685
	for <lists+qemu-devel@lfdr.de>; Sun, 30 Jul 2023 18:49:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qQ9JM-0008LU-Fc; Sun, 30 Jul 2023 12:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQ9JK-0008L6-T5
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:30:26 -0400
Received: from mout.gmx.net ([212.227.15.18])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1qQ9JJ-0000wN-1d
 for qemu-devel@nongnu.org; Sun, 30 Jul 2023 12:30:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de;
 s=s31663417; t=1690734620; x=1691339420; i=deller@gmx.de;
 bh=FQ0+4UJTlGFglkV5PDHtWriV9JJEijSTX1f8Cfgj9uw=;
 h=X-UI-Sender-Class:Date:From:To:Subject;
 b=eZYOiV5KzpljE4r9c3YaRmlxVZU4gt2Xd8J1vCsWIj/STeALhR1OVmmbMA00JtRUB1TCIel
 aIYSoswMI2QSIc6H8jsluvKaO3IvG0GLk6K31LysHs/ZXdcc19F1iPEso8r4b1u0HtcY/ylwd
 8e8VAGzEujBFzPygk8XpAbtaFowtIE6G0DhVLx7R/fwdWCkv2fleSp/lOToeKW9pz9GU8rGsr
 PQWQen0btLZO+KAGTY8HWFxEpHeQ7gDW5X+4PY/GkELTv4feRJOxu899XH6XG+FDRsX9PD3J0
 x3ra64NujtpsN1vvNWr9Y33ZuQuF7o6gDlc6Gb0ILySBF2AZvcPQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from p100 ([94.134.144.241]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MfHEP-1px8LP2BMh-00gniA; Sun, 30
 Jul 2023 18:30:20 +0200
Date: Sun, 30 Jul 2023 18:30:19 +0200
From: Helge Deller <deller@gmx.de>
To: Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Subject: [PATCH] target/hppa: Move iaoq registers and thus reduce generated
 code size
Message-ID: <ZMaQGwK1Ikj27ZPk@p100>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Provags-ID: V03:K1:llv/z49cooYYgX94gJz0KmRRKcVa1rhVcp5XIKV4EyXXWJkJTHD
 XUZvUxMlIexqhEH+4PnaYLYujbLsaAMPRCgPuMgLREaQRRiCOsl7LfiD5s5DGckyQ7E6pRD
 kutSEfAgLZyti3fsJHDRZ7qaH9UsgGLLGuAxifEFPpBHi39Hc6ETimVxLAblkStglPq/JeK
 AsHiXQmfca5kNl7PoOKYw==
UI-OutboundReport: notjunk:1;M01:P0:d9Nh2afesoo=;o9fbB/uzYPI4pmD6FZ/O8vwMLfC
 Qm23f3pMz+ui0Lx8jxNQ5Ct7eka4F4g4IYdP5Jy6um7oF/pHfyoLaiVmxeAlbsslY35vWEdil
 Nlc39lYIwmFztFGAAS6/VhtwpZOIQ/j4IMiVZaVKYUAd/10fzgCVwQb6J0su69Ld3EJeobl6X
 YcicjZfPkNwCp3xhHJVWC8rLu6bj5uT+c1tdtMuwIU4Uqwzeu+0LMv7D+qOvzOAZMQ48SmYJc
 3TO1h++j82w3a5qqUl2pm1JD9WPTzwjBfzBSr2Atz5LAmBNmpRHPGvwfkAdV2YCdQabuPqOI1
 L+lAsvn9MdW+zk+I+gfddE9HyVZzm6+kYVb5oPn8GGDJM0dDuumenYO5ivgNW3gm4BCnc6ecq
 NQao1Hcztlzsdu3elBYFTrQhnbdVEMqGtS2XCBZJI0R1Pj0f+SdQoaJAGhUXlUi6BUxUYWDqm
 AHz8Rx3UmjyxBryA+uV8P9WiIZT4z44uMZVtPCku6aCk4iBfcRG1G+yct4c7Dm2OLr6QpsCJ8
 Xl1iXoP08OIrHqzfFXbCgNLzEjsFE0btO5a+Gu7P1svWrKzOJTDXCoEaWvY2U6O6SSP5MK25c
 yKJquba4ERF2N6BFoZY/Lmw1L/d10PzkcL4WWn+kOuGrwounVd+b9jjBwgsV3RPmTUwh9UjN8
 32zD+QPAs+vl1yGR//yXEndNek3fgsEAvwCPQ6NCNpaSfI4s7skGPnKfEabsRIXoOwXPKD0i1
 zSGauW7ilvS973fvCrZho4ENtomhYP2PdTtFvK8kb1z8EkSLA+vvbNmc6P4Tm1uyA+BjEA8IP
 QvdSEtJDcFyC7r6NNQ7RKRhPOzx2oyMxMT8qnHebnl+wLKvD4K6QAopWsVVtShkwtprPwP6sN
 mURdAq9AtUnTasSl8VTqzJscihTiPdZnLByUibqzogFMT6ahNNUDtod/nTrZFZYv1TJx2dkr6
 0oSFcl9wfaWXrCSRcfWugL/pZuY=
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=212.227.15.18; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On hppa the Instruction Address Offset Queue (IAOQ) registers specifies
the next to-be-executed instructions addresses. Each generated TB writes t=
hose
registers at least once, so those registers are used heavily in generated
code.

Looking at the generated assembly, for a x86-64 host this code
to write the address $0x7ffe826f into iaoq_f is generated:
0x7f73e8000184:  c7 85 d4 01 00 00 6f 82  movl     $0x7ffe826f, 0x1d4(%rbp=
)
0x7f73e800018c:  fe 7f
0x7f73e800018e:  c7 85 d8 01 00 00 73 82  movl     $0x7ffe8273, 0x1d8(%rbp=
)
0x7f73e8000196:  fe 7f

With the trivial change, by moving the variables iaoq_f and iaoq_b to
the top of struct CPUArchState, the offset to %rbp is reduced (from
0x1d4 to 0), which allows the x86-64 tcg to generate 3 bytes less of
generated code per move instruction:
0x7fc1e800018c:  c7 45 00 6f 82 fe 7f     movl     $0x7ffe826f, (%rbp)
0x7fc1e8000193:  c7 45 04 73 82 fe 7f     movl     $0x7ffe8273, 4(%rbp)

Overall this is a reduction of generated code (not a reduction of
number of instructions).
A test run with checks the generated code size by running "/bin/ls"
with qemu-user shows that the code size shrinks from 1616767 to 1569273
bytes, which is ~97% of the former size.

Signed-off-by: Helge Deller <deller@gmx.de>

diff --git a/target/hppa/cpu.h b/target/hppa/cpu.h
index 9fe79b1242..75c5c0ccf7 100644
=2D-- a/target/hppa/cpu.h
+++ b/target/hppa/cpu.h
@@ -168,6 +168,9 @@ typedef struct {
 } hppa_tlb_entry;

 typedef struct CPUArchState {
+    target_ureg iaoq_f;      /* front */
+    target_ureg iaoq_b;      /* back, aka next instruction */
+
     target_ureg gr[32];
     uint64_t fr[32];
     uint64_t sr[8];          /* stored shifted into place for gva */
@@ -186,8 +189,6 @@ typedef struct CPUArchState {
     target_ureg psw_cb;      /* in least significant bit of next nibble *=
/
     target_ureg psw_cb_msb;  /* boolean */

-    target_ureg iaoq_f;      /* front */
-    target_ureg iaoq_b;      /* back, aka next instruction */
     uint64_t iasq_f;
     uint64_t iasq_b;


