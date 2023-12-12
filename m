Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 713FB80F5A7
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 19:47:43 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD7lk-0001yc-9N; Tue, 12 Dec 2023 13:46:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rD7lE-0001yJ-Dh
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 13:45:40 -0500
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1rD7l8-0004XB-Cv
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 13:45:37 -0500
Received: from zero.eik.bme.hu (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 5427A75A406;
 Tue, 12 Dec 2023 19:45:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by zero.eik.bme.hu (zero.eik.bme.hu [127.0.0.1]) (amavisd-new, port 10028)
 with ESMTP id ThqTUj2XEpUh; Tue, 12 Dec 2023 19:45:22 +0100 (CET)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 24414756094; Tue, 12 Dec 2023 19:45:22 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 22C75756078;
 Tue, 12 Dec 2023 19:45:22 +0100 (CET)
Date: Tue, 12 Dec 2023 19:45:22 +0100 (CET)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: Marek Glogowski <smarkusg@gmail.com>
cc: Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Rene Engel <ReneEngel80@emailn.de>, qemu-devel@nongnu.org
Subject: Inconsistent qemu-system-ppc speed on Apple M1 (was: Re: [PATCH v6]
 ui/cocoa: Use NSWindow's ability to resize)
Message-ID: <bea2e165-5203-5b9c-f36e-4c9fc91b9447@eik.bme.hu>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset=US-ASCII
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
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

On Tue, 12 Dec 2023, Marek Glogowski wrote:
> Additionally, how can I use this message on qemu-devel.
> It has a post for people who use Macos or Asahi Linux. Verify random qemu
> sessions under Macos .Some are faster others are slow.
> The topic is posted on qemu-discuss@nongnu.org (I don't know if developers
> look there often)
>
> https://lists.nongnu.org/archive/html/qemu-discuss/2023-12/msg00008.html
>
> The program posted there was prepared by one of the maintainers of ppc qemu
> machines "BALATON Zoltan".
>
> We are starting to gather as much information as possible for it.
> I hope nobody will be offended about this information in this topic. I do
> not want to start a topic and litter other lists

It's better to do that in a separate thead, I've changed the subject 
accordingly. I only came up with the idea and scripted it but the actual 
test case comes from Marek and the original report from Rene Engel.

This problem was first seen running AmigaOS with qemu-system-ppc but then 
we also reproduced it with Linux guest with the test in the qemu-discuss 
messgage linked above. The runs are not exactly random but there seem to 
be slow and fast sessions with the slow one about half the expected speed. 
If we get a fast or slow session seems to be random. This was seen on 
Apple M1 and Apple M1 Max under macOS but could not reproduce on x86_64 
host under Linux or Apple M2 host under Linux so it may either be related 
to Apple M1 or macOS host.

What could be tested to narrow it further may be trying the test on Apple 
M1 under Linux or Apple M2 under macOS. (And maybe trying some other 
qemu-system target on Apple M1 macOS to see if it's specific to 
qemu-system-ppc.) Then the question is what might cause it. Marek tested 
that these always run on Performance cores and also experimented with 
taskpolicy -B but that does not seem to change anything. Lacking a better 
idea I could think of frequency scaling maybe but I don't know how to 
check that under macOS. Or maybe something about how macOS schedules QEMU 
thread? Does anybody have an idea how to debug this further?

Thank you,
BALATON Zoltan

