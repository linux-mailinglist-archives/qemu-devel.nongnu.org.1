Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EF70980ECC9
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 14:06:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD2SG-0005ZB-EV; Tue, 12 Dec 2023 08:05:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aminier-21@enst.fr>)
 id 1rD2Rp-0005Yc-CN
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 08:05:18 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aminier-21@enst.fr>)
 id 1rD2Rf-0005Ea-TV
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 08:05:15 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id DD5AB206AB
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 14:05:01 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id Z2qCELAco975 for <qemu-devel@nongnu.org>;
 Tue, 12 Dec 2023 14:05:00 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id C2DD620705
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 14:05:00 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr C2DD620705
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1702386300;
 bh=Kb4uZj1RvSZOS+QaL7XcgAwPasfFQIPBGskIvjEHizo=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=tyRfwQSLtkNE7juHnEiN2acF/abQKAc3fgvkYShekvYndXyivqUrUs3FoZ70xTXYR
 dA8wfm17fYtNVPvgcZMsCTWKp5rzFZEdHotdFRNoklSLbtjNb9ZdEgyfeYGjQHrNKR
 57KfWWU4eFYJs30302LDoBF0no/Ddf0SHbsIzcdY=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id GpkCL_6Dp2p9 for <qemu-devel@nongnu.org>;
 Tue, 12 Dec 2023 14:05:00 +0100 (CET)
Received: from zmail-tp1.enst.fr (zmail-tp1.enst.fr [137.194.2.198])
 by zproxy4.enst.fr (Postfix) with ESMTP id A915D20702
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 14:05:00 +0100 (CET)
Date: Tue, 12 Dec 2023 14:05:00 +0100 (CET)
From: Arnaud Minier <arnaud.minier@telecom-paris.fr>
To: qemu-devel@nongnu.org
Message-ID: <1001572703.6422667.1702386300513.JavaMail.zimbra@enst.fr>
Subject: Questions about clocks emulation
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [::ffff:109.10.162.38]
X-Mailer: Zimbra 9.0.0_GA_4564 (ZimbraWebClient - FF119 (Linux)/9.0.0_GA_4571)
Thread-Index: WISEgJdrUvGkU2wfIBilAOtem35T+g==
Thread-Topic: Questions about clocks emulation
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=aminier-21@enst.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.25,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

I tried to implement the RCC (Reset and Clock Control) for the STM32L4x5_SoC but ran into some problems regarding clock emulation in Qemu.
In this SoC, it is possible to change the source of several clocks used for devices like the CPU, the USART, and approximately every other device on the SoC.
This change can be made at runtime by writing into a specific register.
I tried to model this by using the clocks in hw/core/clock.c by I noticed that it is not possible to change a clock's source once it has been assigned (see clock_set_source()).
It prevents me from implementing a clock tree similar to the one on the hardware.

Is this limitation there for some reason or has it simply not been implemented?

Thanks,
Arnaud Minier

