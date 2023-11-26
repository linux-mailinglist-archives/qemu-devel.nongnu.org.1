Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AB03E7F92A0
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 13:46:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7EVN-00058d-It; Sun, 26 Nov 2023 07:44:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1r7EVE-00058O-Pg
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 07:44:48 -0500
Received: from zproxy2.enst.fr ([2001:660:330f:2::dd])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1r7EV8-0006zw-AH
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 07:44:47 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id C4CE2805F7;
 Sun, 26 Nov 2023 13:44:35 +0100 (CET)
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id mHhWE2IvLWlf; Sun, 26 Nov 2023 13:44:35 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy2.enst.fr (Postfix) with ESMTP id 7FEF580668;
 Sun, 26 Nov 2023 13:44:35 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy2.enst.fr 7FEF580668
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1701002675;
 bh=TgIjoaQr6482qDEmXy0I6CdFHdKj4Zj//PDYQaOo+1g=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=GOnkkZmxrNKySE2ZqNzyTBnKsEnJz1zfYHwuleAkgABCyASj6qUoRqBBHeTry6Mbj
 t3NYjf/NzQ/gwga2IkGlXBGOokrxUL09lX60pqYjId2t3PYNIkTdksdtrCDSQVyRxt
 pl16ucPkQ4mMBA2VvpvkDBWM/LeiOE05uhgyCJnE=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy2.enst.fr ([IPv6:::1])
 by localhost (zproxy2.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id I1-2-mo9AHT8; Sun, 26 Nov 2023 13:44:35 +0100 (CET)
Received: from buffy (unknown [IPv6:2a01:e34:ec63:e440:3bba:56bc:e324:3f15])
 by zproxy2.enst.fr (Postfix) with ESMTPSA id 4564D805F7;
 Sun, 26 Nov 2023 13:44:35 +0100 (CET)
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
To: Petr Cvek <petrcvekcz@gmail.com>
Cc: pbonzini@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
Date: Sun, 26 Nov 2023 13:37:44 +0100
In-reply-to: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
Message-ID: <87msv065vx.fsf@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::dd;
 envelope-from=samuel.tardieu@telecom-paris.fr; helo=zproxy2.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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


Petr Cvek <petrcvekcz@gmail.com> writes:

> GCC defines __i386__ for i386 and i486, which both lack RDTSC=20
> instruction.
> The i386 seems to be impossible to distinguish, but i486 can be=20
> identified
> by checking for undefined __i486__.

Couldn't you check for an undefined __tune_i386__, which would be=20
set by both GCC and LLVM when using -march=3Di386.

  Sam
--=20
Samuel Tardieu
T=C3=A9l=C3=A9com Paris - Institut Polytechnique de Paris

