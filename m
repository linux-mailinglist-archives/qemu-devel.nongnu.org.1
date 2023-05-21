Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B3AF70B0FB
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 23:50:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0qvA-0000W2-Qj; Sun, 21 May 2023 17:48:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0qv9-0000Vm-DG
 for qemu-devel@nongnu.org; Sun, 21 May 2023 17:48:55 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0qv7-00067f-Bc
 for qemu-devel@nongnu.org; Sun, 21 May 2023 17:48:55 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
 by mailout.nyi.internal (Postfix) with ESMTP id 6E5B75C00CB;
 Sun, 21 May 2023 17:48:51 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
 by compute3.internal (MEProxy); Sun, 21 May 2023 17:48:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1684705731; x=1684792131; bh=vWQkaGUuW8
 Af8s/Yb4YqWoUNRgc5Zk78PE43/1qSN9w=; b=LCtGt0AP+B5ZzX1BQc/No+0ezy
 qvoDRb3ikY3ZocBH+GPi4/qWRwXCUy38iCnFHVqVemu4D7hkcieIphRg2RJvkJO9
 juvq1gvUIiQ/gnTvhS59Uda2t5w+JbTNI6CwlKpFwCVRuXEqQvGY6oMKQavbvMUt
 /RVLQFHPzd0rrDazjtNkMTIOr576uIJXbY9mUhvOTcfvICyndrj33iGpefE7ats3
 Ocz+aEFmIRO/OAO8S1xxCgErfi3SkAH9cXkL0X75B8BOQr+88Pef3KHOkbf96WHo
 ODfba1ocL7zhlAMde1X1Wz6MZYIbiSEH50KOIfYc4/v4vXnAZxEPcah6eevQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684705731; x=1684792131; bh=vWQkaGUuW8Af8
 s/Yb4YqWoUNRgc5Zk78PE43/1qSN9w=; b=NsIkcQkLsKGueT9iOt+haV7k9oDR6
 kgUvZ5wmp5q0PBy7oAGM7GP6XsPARNKwnAkoWH8Y+8PA6D8ah6PnVqX1nH7/od4C
 b5DO/S5TJ7DKnnEPoOH0woI6cIMOR31iAGBlpBAg1LDTLJuZLwxVhWu3GqtYyQV+
 kSeJnPZsaeNV4qNtMA81QyAD7C6FiD2urJfpH5w0hMxE+AW6Rd/VNsx8Zww0JLkr
 XFP3Fq0eoOyNGC2gT0l757MeLm4vuw2stWVoK5ySoS8q/hxFWC9WR2RwC4Zy2oZz
 Bz9sho/yV89vkLn3v1JxhUWkcyG8JvZ09u9Z24H+WZqwsuJPntdneqHAw==
X-ME-Sender: <xms:w5FqZLQPK3xkny5TZRjbeu9UD4cWO_CeIqHz8zRn9GkItT4gC77laA>
 <xme:w5FqZMyDV2jrA_cLbkeVz3ydZ6tJuFSsQAY1MuhvgjBrzWrxukEVoMYyW5jRJQimx
 tUIPAvwfdbBV-_Xn2g>
X-ME-Received: <xmr:w5FqZA2-HG3mJQx6Niy6PLq4jjG_AgqTTstWJ9JtVh94Ix1LVL-QsYVqCqtS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejtddgtddvucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
 fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdeuteekleeuudfgueethe
 dtuddthfdtleffgefhieehfeeigedvtdeuveetiedunecuffhomhgrihhnpehkvghrnhgv
 lhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehjihgrgihunhdrhigrnhhgsehflhihghhorghtrdgtohhm
X-ME-Proxy: <xmx:w5FqZLAF3AbPGfz0MmfT9GOZBpKyy_GyIUEV0NbMAjcMZm7XimLmoQ>
 <xmx:w5FqZEhQTrNW7MNpBkF2PqWJmHaLDjyFUbb7UjZNTj1dPlWsR0D6Ew>
 <xmx:w5FqZPp6v6dqoR56Fk3cQEVFXOgfFooaf1J6V62O5OTR1m-zD9s1vw>
 <xmx:w5FqZMdfxX8V8NGuj_nAWYrtPvYzdvbnrJw93QXjCVcYIZl83Pd73w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 17:48:50 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/2] MIPS: Enable Loongson-3A4000 TCG for system emulation
Date: Sun, 21 May 2023 22:48:30 +0100
Message-Id: <20230521214832.20145-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.27; envelope-from=jiaxun.yang@flygoat.com;
 helo=out3-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi there,

This series enables Loongson-3A4000 TCG for system emulation.
It Implemented Loongson CSR insertions which is required for
Linux Kernel to probe CPU features and removed CPU type restrictions
for loongson3_virt board.

This series is based on two of my previous series[1] [2]. However it's
just a soft dependency for me to do boot test, feel free to apply this
series without them.

Note that loongarch_ipi is still not hooked up in IOCSR. I've sucessfully
done it locally but I just want to confirm some details on hardware.

Thanks
- Jiaxun

[1]: https://lore.kernel.org/qemu-devel/20230521102307.87081-1-jiaxun.yang@flygoat.com/T/#t
[2]: https://lore.kernel.org/qemu-devel/0bb0cded-8450-536e-b90f-1a9d33311c2a@linaro.org/T/#t

Jiaxun Yang (2):
  target/mips: Implement Loongson CSR instructions
  hw/mips/loongson3_virt: Remove CPU restrictions for TCG

 hw/mips/loongson3_virt.c             |  4 --
 target/mips/cpu-defs.c.inc           |  9 ++++
 target/mips/cpu.c                    |  8 ++++
 target/mips/cpu.h                    | 40 ++++++++++++++++
 target/mips/helper.h                 |  4 ++
 target/mips/internal.h               |  2 +
 target/mips/tcg/lcsr.decode          | 17 +++++++
 target/mips/tcg/lcsr_translate.c     | 69 ++++++++++++++++++++++++++++
 target/mips/tcg/meson.build          |  2 +
 target/mips/tcg/op_helper.c          | 16 +++++++
 target/mips/tcg/sysemu/lcsr_helper.c | 45 ++++++++++++++++++
 target/mips/tcg/sysemu/meson.build   |  4 ++
 target/mips/tcg/sysemu_helper.h.inc  |  8 ++++
 target/mips/tcg/translate.c          |  3 ++
 target/mips/tcg/translate.h          |  7 +++
 15 files changed, 234 insertions(+), 4 deletions(-)
 create mode 100644 target/mips/tcg/lcsr.decode
 create mode 100644 target/mips/tcg/lcsr_translate.c
 create mode 100644 target/mips/tcg/sysemu/lcsr_helper.c

-- 
2.39.2 (Apple Git-143)


