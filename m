Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4122A7E3B59
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:53:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Kd3-0007eE-1L; Tue, 07 Nov 2023 06:52:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Kd1-0007e0-4k
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:52:19 -0500
Received: from zero.eik.bme.hu ([152.66.115.2])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1r0Kcx-0005G4-P6
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:52:18 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id DC2DF75A4BC;
 Tue,  7 Nov 2023 12:52:27 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D034775A4B9; Tue,  7 Nov 2023 12:52:27 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id CDB2775A4B8;
 Tue,  7 Nov 2023 12:52:27 +0100 (CET)
Date: Tue, 7 Nov 2023 12:52:27 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Stefan Hajnoczi <stefanha@redhat.com>
cc: qemu-devel@nongnu.org
Subject: Re: QEMU entering soft freeze for 8.2 release cycle
In-Reply-To: <20231107105603.GA993420@fedora>
Message-ID: <bc415368-0e5a-5712-edb6-c0046f090a7b@eik.bme.hu>
References: <20231107105603.GA993420@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
X-Virus-Scanned: ClamAV using ClamSMTP
Received-SPF: pass client-ip=152.66.115.2; envelope-from=balaton@eik.bme.hu;
 helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
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

On Tue, 7 Nov 2023, Stefan Hajnoczi wrote:
> Hi,
> QEMU is entering soft freeze for the 8.2 release cycle. After today's
> pull requests, only bug fixes will be merged until the 8.2 release is
> stablized around December 12th. New features can be merged into -next
> trees by maintainers, but will not be merged into qemu.git/master.

You seem to be ahead of everyone else. It's still midday here and other 
people may just start working so maybe you should use US time zone for 
starting the freeze just to make sure people in that part of the world 
also on the same page.

Regards,
BALATON Zoltan

> The release schedule is here:
> https://wiki.qemu.org/Planning/8.2
>
> Please remember to update the changelog if your work has landed in 8.2:
> https://wiki.qemu.org/ChangeLog/8.2
>
> Let me know if you have any questions!
>
> Thanks,
> Stefan
>

