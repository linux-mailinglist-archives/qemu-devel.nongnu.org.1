Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BE1670AD6E
	for <lists+qemu-devel@lfdr.de>; Sun, 21 May 2023 12:25:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q0gEP-0004Fq-8L; Sun, 21 May 2023 06:24:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEM-0004FO-Nu
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:02 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jiaxun.yang@flygoat.com>)
 id 1q0gEL-0003J5-2y
 for qemu-devel@nongnu.org; Sun, 21 May 2023 06:24:02 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
 by mailout.nyi.internal (Postfix) with ESMTP id 0478B5C0100;
 Sun, 21 May 2023 06:23:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
 by compute6.internal (MEProxy); Sun, 21 May 2023 06:23:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to; s=fm2; t=1684664637; x=1684751037; bh=eEpkqUg/EL
 1KXSu/ZgC9VV6JDPEbCiaA1xMECrtfny0=; b=GKldhiOY/zbm0lfP4GyPAQ5fbt
 sZQmpaRQ1Ky662oYQz39xOKI71bDmMjvYfoeIl2+ZhSOLSKQCXh804/GRHsuXtfg
 086DN6dDbs4rNICU0JKpJzhb0CIMbPl8V/w2lWKKxPioELZndSkh9ip2BTL5doFh
 ylKoDSuvO8oZnmHDTpjfMaKiJ71ZLUhP+MNQNfMYN4ufrjwuZucwKcgd1b/6CCO7
 U6ClJPrUa36Bfbvf7uCe1BvSHkz1zi4+kL++kyfMRNbfmO9H6+EzAN/VdsBHVnzh
 1kAaeRoOD70lHt/GijA/XFWWuLIML6tuGZttZ4w3gtJmryn7Sj9WtWqbojyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:message-id:mime-version:reply-to:sender:subject
 :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
 :x-sasl-enc; s=fm1; t=1684664637; x=1684751037; bh=eEpkqUg/EL1KX
 Su/ZgC9VV6JDPEbCiaA1xMECrtfny0=; b=LC9pH3aXA+h4kiugL1gXlTS55Uiw/
 1zUyxRRJcXU1QFBOTouwjS9a/oogiTW5VcGOiY3kXjhJgnHyrMHUIK69xFF+t1GK
 vG9oxrvJyr/2zc4r8y931hEx0pt5DCFaYNoJrKYFRLYY9pi7aYPiY2B4LJkw0EMQ
 9tLgEX4XlrVHrtA7X2Ul63ivQ9TRGADypFpnPy68UN04phd+f1r5xmQlBZyh+uzc
 pOFANE876VczRKt9YaW/y5LZMULtRr6QGtROXyD9yzL69JAGF9aCQpQ0WVaLDj31
 7Vnk5SOk8OkjUFr5o2vITFddhI3ECUjYOlzynFxw0CBTL3k6FWaZH+kdw==
X-ME-Sender: <xms:PPFpZI_ELEChhlU6YWlcvsVB5dpPDGxi97EVs8Bv069cS1EL9ZtH-A>
 <xme:PPFpZAtHcgn5UVSpsUPW1-8uAa2JDYT1IjTZBUlbnY72AY1aP9xZddDGgoyy7XNpw
 p40NIuzbsoBTCW0Osk>
X-ME-Received: <xmr:PPFpZOB5ALHMAtNzGAqD7ZUh__T5o2FvY96TPQManCdhecA9QUmldUczThmF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiledgvdejucetufdoteggodetrfdotf
 fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
 uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
 ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
 fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
 ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
 tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
 grthdrtghomh
X-ME-Proxy: <xmx:PPFpZIeQFqo5lgfayjjErV-i91MvwRtJAn1rLJcohl2MSRvcL-PwRA>
 <xmx:PPFpZNOXLDy2gsHU1Y5jg28OCAnh2EqT6qpa4Sp42FRIkQDv4o6EUg>
 <xmx:PPFpZCnTziAnfbEOcFLcCp06mpMwUwwjFuvN9EdIxafITutU91waMQ>
 <xmx:PfFpZAeq943bPGnUuVZCktEys9IB5TExNbiRmEYHjJg6V2FOVHVudA>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 May 2023 06:23:55 -0400 (EDT)
From: Jiaxun Yang <jiaxun.yang@flygoat.com>
To: qemu-devel@nongnu.org
Cc: yangxiaojuan@loongson.cn, gaosong@loongson.cn, philmd@linaro.org,
 chenhuacai@kernel.org, crosa@redhat.com, wainersm@redhat.com,
 bleal@redhat.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 0/4] hw/mips/loongson3_virt: Wire up loongarch_ipi device
Date: Sun, 21 May 2023 11:23:03 +0100
Message-Id: <20230521102307.87081-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=66.111.4.25; envelope-from=jiaxun.yang@flygoat.com;
 helo=out1-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

Hi all,

This series wires up loongarch_ipi device for loongson3-virt,
which is required for SMP support.

We also add a new test for loongson3-virt for acceptance harness.

Thanks
- Jiaxun

Jiaxun Yang (4):
  hw/intc/loongarch_ipi: Bring back all 4 IPI mailboxes
  hw/intc/loongarch_ipi: Guard LoongArch only features with ifdef
  hw/mips/loongson3_virt: Wire up loongarch_ipi device
  tests/avocado: Add boot_linux_console test for loongson3-virt

 hw/intc/loongarch_ipi.c             | 26 ++++++++++++++--
 hw/mips/Kconfig                     |  1 +
 hw/mips/loongson3_bootp.c           |  2 --
 hw/mips/loongson3_bootp.h           |  3 ++
 hw/mips/loongson3_virt.c            | 20 +++++++++++--
 include/hw/intc/loongarch_ipi.h     |  4 ++-
 tests/avocado/boot_linux_console.py | 46 +++++++++++++++++++++++++++++
 7 files changed, 94 insertions(+), 8 deletions(-)

-- 
2.39.2 (Apple Git-143)


