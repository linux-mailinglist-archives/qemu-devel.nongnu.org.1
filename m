Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9800F79A003
	for <lists+qemu-devel@lfdr.de>; Sun, 10 Sep 2023 23:01:18 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qfRYB-0001ql-ET; Sun, 10 Sep 2023 17:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfRXx-0001on-DG; Sun, 10 Sep 2023 17:00:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qfRXt-0007R2-UH; Sun, 10 Sep 2023 17:00:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 45FCB2093B;
 Mon, 11 Sep 2023 00:00:39 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 825C1270CB;
 Mon, 11 Sep 2023 00:00:38 +0300 (MSK)
Message-ID: <8b3ee6b8-3f4f-3128-610d-8fa3595c16e5@tls.msk.ru>
Date: Mon, 11 Sep 2023 00:00:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: QEMU Developers <qemu-devel@nongnu.org>,
 qemu-stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
Subject: QEMU Stable series
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
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

Hi!

For quite some time I'm collecting stuff for stable, pocking various
people with questions about stable, etc, so has become somewhat more
visible and somewhat annoying too :)  Especially when I publish the
next stable patch round-up, which has not only become larger when
counting individual patches, but also multiplied by now 3 stable
series.  So I guess you wondered what's going on, what's the buzz
is all about, and when this ever stop... :)

Seriously though, I stepped up to maintain -stable series just out of
nowhere, just because I had issues with qemu in debian and thought to
do something with that, but instead of collecting stuff privately
inside debian, I decided to give it a more visible try, to see how
it will work out, without understanding how it will be.

Meanwhile, next debian stable has been released, codenamed Bookworm,
which has qemu version 7.2.  And it should be supported for the next
2 years until next debian release.

We never had any long-maintained releases in QEMU before, usually the
previous series maintenance stopped once next major release is out.
Right now there's stable-7.2 and stable-8.0 still in existance even
after 8.1 has been released.  I should draw the line somewhere, even
while so far, the whole stuff has been quite easy (but time-consuming).

For now I decided I'll stop publishing stable-8.0 releases.  This one
had a number of linux-user issues, a big share of which Richard fixed
at the very end of 8.1 development cycle.  There will be one more 8.0
stable release at least (see below for the details), together with the
first 8.1 stable.

I think this is more appropriate to drop support for previous stable
not with next major, but with first major stable release instead, -
this way users have much more choices for smooth upgrade to the next
major version.  So stable-8.0 will end with 8.1.1.  Unless there's
a good reason to continue.

Speaking of 7.2 (which has its share of linux-user bugs too), - so
far I plan to continue maintaining it for a while.  So please bear
with me, don't be surprised I'll ask about 7.2 backports of something
from time to time.  I don't yet want to make an official statement
about this one, like "it will be LTS supported for 10 years from now", -
just like with me stepping in last winter for stable maintenance,
it's more like an experiment right now, to see how things will go.
Let's say 7.2 is an ELTS series, - not Extended long-term support
but Experimental, - both looks big and nice, but there's a tiny
detail ;)

Qemu is still a fast-moving target, with numerous changes in core
areas, so things aren't easily backportable to older releases.

Also, it's interesting whenever this whole stable rustling is useful
for someone else, who uses which releases, etc.  Maybe we can share
efforts in this area.

Thanks,

/mjt

Let's see how it goes.

