Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B06347F92CC
	for <lists+qemu-devel@lfdr.de>; Sun, 26 Nov 2023 14:06:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7Eom-0000Ht-S6; Sun, 26 Nov 2023 08:05:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1r7Eob-0000Fb-2H
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 08:04:49 -0500
Received: from zproxy4.enst.fr ([2001:660:330f:2::df])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <samuel.tardieu@telecom-paris.fr>)
 id 1r7EoY-0002OF-LT
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 08:04:48 -0500
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id B3E15206FC;
 Sun, 26 Nov 2023 14:04:42 +0100 (CET)
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10032) with ESMTP
 id fO9awxgxRhyP; Sun, 26 Nov 2023 14:04:42 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
 by zproxy4.enst.fr (Postfix) with ESMTP id EF39D20700;
 Sun, 26 Nov 2023 14:04:41 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.10.3 zproxy4.enst.fr EF39D20700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=telecom-paris.fr;
 s=A35C7578-1106-11E5-A17F-C303FDDA8F2E; t=1701003882;
 bh=sMNCcs8QmzBZfvIU12/0SrHrU0F6fH/1C5AsulMQvoY=;
 h=From:To:Date:Message-ID:MIME-Version;
 b=rSeyrBjNVfOFqKkhrLnJNNctVmD924Ni9/at6eafkIEqzEgGX1n1nmC4IzLNeyHem
 cLrnL1Ee+H/DRmriK7gOjNV/+wv+Rb1GH/rQaFKbmOJBuPCJHFFewV2wnVaCxuWtX1
 JqvmXqlIrlOIxG2X71xWk6H+cYZcBJNS5j3qTvOM=
X-Virus-Scanned: amavis at enst.fr
Received: from zproxy4.enst.fr ([IPv6:::1])
 by localhost (zproxy4.enst.fr [IPv6:::1]) (amavis, port 10026) with ESMTP
 id 0R2-9HLegSKx; Sun, 26 Nov 2023 14:04:41 +0100 (CET)
Received: from buffy (unknown [IPv6:2a01:e34:ec63:e440:3bba:56bc:e324:3f15])
 by zproxy4.enst.fr (Postfix) with ESMTPSA id 7174B206FC;
 Sun, 26 Nov 2023 14:04:41 +0100 (CET)
References: <6826113a-d428-401e-b5a3-56ad5d8fbaa4@gmail.com>
 <87msv065vx.fsf@telecom-paris.fr>
 <3380b626-0d94-489f-bf98-6146c1420a51@gmail.com>
User-agent: mu4e 1.10.8; emacs 29.1
From: Samuel Tardieu <samuel.tardieu@telecom-paris.fr>
To: Petr Cvek <petrcvekcz@gmail.com>
Cc: pbonzini@redhat.com, marcel.apfelbaum@gmail.com, mst@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] qemu/timer: Don't use RDTSC on i486
Date: Sun, 26 Nov 2023 14:03:22 +0100
In-reply-to: <3380b626-0d94-489f-bf98-6146c1420a51@gmail.com>
Message-ID: <87il5o64yf.fsf@telecom-paris.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2001:660:330f:2::df;
 envelope-from=samuel.tardieu@telecom-paris.fr; helo=zproxy4.enst.fr
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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


Petr Cvek <petrcvekcz@gmail.com> writes:

> Actually I was thinking about mentioning it in the commit=20
> message also, but I wasn't able
> to find any specification for that (if all compilers use it).

Note that this change would be safe: at worst, some compilers=20
don't use __tune_i386__ and the situation would be the same as=20
today without the patch.

> Other problem is the __tune_i386__ is also set when -mtune=3Di386=20
> (but with -march=3Di686).

Indeed, this is the case for GCC (not clang).

  Sam
--=20
Samuel Tardieu
T=C3=A9l=C3=A9com Paris - Institut Polytechnique de Paris

