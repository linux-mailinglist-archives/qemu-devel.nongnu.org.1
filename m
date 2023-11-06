Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 117957E2636
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 14:59:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r006Z-0007b0-3Y; Mon, 06 Nov 2023 08:57:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1r006W-0007aS-BC; Mon, 06 Nov 2023 08:57:24 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ivarhol-21@enst.fr>)
 id 1r006U-0008Lz-Ew; Mon, 06 Nov 2023 08:57:24 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 8E65120607;
 Mon,  6 Nov 2023 14:57:16 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id cOsY3OnJ6v-4; Mon,  6 Nov 2023 14:57:16 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id 1C16E205F7;
 Mon,  6 Nov 2023 14:57:16 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr 1C16E205F7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1699279036;
 bh=k8D20BWyjJjiJ1XukyijOfCLVXq8WqVZg8rLnZRPjZw=;
 h=Date:From:To:Message-ID:MIME-Version;
 b=MMUcJxsfJt7eYyQbGx+ZhO1+ziQ/X3+We8FkaOeq9Lp7mdN/4axo50Qqcsc6OTVP3
 7EhV+OHJRgsP7fpRJldKtSYg/6SmX8gcvPKiG0sGob/ZSJw2R8Mhn3oIFCSfCxhe3/
 EINIe72wU2HRL5Xo2U11Xfe3H97jAAjoyiFtwo1o=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id LW4Sy1VxqVSO; Mon,  6 Nov 2023 14:57:15 +0100 (CET)
Received: from zmail-tp2.enst.fr (zmail-tp2.enst.fr [137.194.2.199])
 by zproxy4.enst.fr (Postfix) with ESMTP id AE04D20578;
 Mon,  6 Nov 2023 14:57:15 +0100 (CET)
Date: Mon, 6 Nov 2023 14:57:15 +0100 (CET)
From: =?utf-8?B?SW7DqHM=?= Varhol <ines.varhol@telecom-paris.fr>
To: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: Arnaud Minier <arnaud.minier@telecom-paris.fr>, alistair@alistair23.me, 
 peter maydell <peter.maydell@linaro.org>
Message-ID: <1353832942.8123338.1699279035562.JavaMail.zimbra@enst.fr>
Subject: Adding support of ARM board B-L475E-IOT01A using STM32L475 SoC
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [137.194.2.223]
X-Mailer: Zimbra 9.0.0_GA_4564 (ZimbraWebClient - FF119 (Linux)/9.0.0_GA_4571)
Thread-Index: nKl23wLJrfRlX/NmoX4VoM60upk07w==
Thread-Topic: Adding support of ARM board B-L475E-IOT01A using STM32L475 SoC
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=ivarhol-21@enst.fr; helo=zproxy4.enst.fr
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

Hello,

Along with my fellow student Arnaud Minier, we're looking to implement supp=
ort for a new ARM board for a university project.

As of now we've have implemented a minimal version for the machine and the =
SoC without any syscfg, timers or usart implementation.=20
We have looked at the relevant informations about the procedure to submit a=
 patch, however we aren't sure if we should submit a patch now already,=20
as a way to get acquainted with the procedure and expectations, or if we sh=
ould rather implement more peripherals and submit the patch all at once.

For further details about project, the end-goal is to emulate a maximum of =
peripherals and be able to display an emulated LED matrix driven by the QEM=
U-emulated board.

How we're proceding for now is replicating code designed for the stm32f405 =
SoC and other specific stm32f4xx code and adapting it for the stm32l475 SoC=
 (both are Cortex-M4 SoC).=20
Is it alright if the patch commits reflect this copy-paste then incremental=
y change details procedure ?


Of course, we would greatly appreciate any guidance, suggestions, or insigh=
ts you may offer regarding our current progress and the best course of acti=
on.=20
Moreover, if there are other pertinent issues we should consider, we are ea=
ger to learn and adapt our approach accordingly.

Thank you for your time and consideration.

Best regards,

In=C3=A8s Varhol

