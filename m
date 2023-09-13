Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4663379E0D5
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 09:28:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgKGw-0004Ei-NN; Wed, 13 Sep 2023 03:26:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgKGt-0004EV-7I
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:26:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgKGq-0006Sr-Kd
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 03:26:46 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 191B321511;
 Wed, 13 Sep 2023 10:26:45 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9D15E27A94;
 Wed, 13 Sep 2023 10:26:39 +0300 (MSK)
Message-ID: <9b7b9d2a-e8fc-658d-634b-15983c594658@tls.msk.ru>
Date: Wed, 13 Sep 2023 10:26:39 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: CI container image interference between staging and staging-7.2
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <CAJSP0QXukZuLRF0x1Yt06n2rbeOMAAG0SRsx4Z_QTTro9vMFTw@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAJSP0QXukZuLRF0x1Yt06n2rbeOMAAG0SRsx4Z_QTTro9vMFTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -83
X-Spam_score: -8.4
X-Spam_bar: --------
X-Spam_report: (-8.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

13.09.2023 02:07, Stefan Hajnoczi wrote:
> Hi,
> TL;DR Michael: Please check that the staging-7.2 branch has Dan's
> commit e28112d00703abd136e2411d23931f4f891c9244 ("gitlab: stable
> staging branches publish containers in a separate tag").
...

Mea cupla, Stefan.  I'm always forgetting about the fact that ci controls
don't work on older branches in one way or another. Sigh.

The patch(es) you're talking about - I didn't pick them up for 7.2 (which
was the branch in question this time, which interfered with your testing),
thinking it would be ok.  Yes, after this fiasco (which is the first one
actually), it looks like I should re-consider doing this.

It needs quite a few changes in there. And one of them is to actually
look at QEMU_CI={0,1,2} variable when pushing staging-N.M branches.  Right
now - and this is what I forgot this time once again, - I used QEMU_CI=1
so the job does not auto-start, but forgot that in 7.2 it auto-starts
regardless of QEMU_CI value.

I don't push staging-N.M branches often, usually doing all the CI on
a my gitlab repository instead. And when I do push to qemu-project,
I either intend to skip automatic job run, to run just the tests I'm
interested in, or push it at a time when no other pipelines are to be
run (which is easy due to time zone differences).

But actually I'm a bit surprised this issue happened to begin with.
Maybe something else is missing still.  The thing is that after
Daniel's changes, qemu/staging container tags should be named differently,
no?   Ah. No. Staging didn't change, it was staging-N.M which were
renamed.  Once again, I'm sorry for not thinking well enough about this, -
after container tags renaming I was kinda sure main staging tags were
different from old staging-N.M, which is not the case..

Please excuse me for this trouble.  Things like these usually takes quite
some time to figure out.. :(  I'll make sure this wont happen again,
one way or another.

Thank!

/mjt

