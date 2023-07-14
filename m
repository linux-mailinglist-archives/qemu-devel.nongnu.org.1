Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9A6753B59
	for <lists+qemu-devel@lfdr.de>; Fri, 14 Jul 2023 14:55:04 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qKIJa-0001iF-4z; Fri, 14 Jul 2023 08:54:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKIJS-0001ha-QC; Fri, 14 Jul 2023 08:54:22 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qKIJQ-0002Ov-Fb; Fri, 14 Jul 2023 08:54:22 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 57FE613E5D;
 Fri, 14 Jul 2023 15:54:25 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 464E114C0A;
 Fri, 14 Jul 2023 15:54:09 +0300 (MSK)
Message-ID: <2250131a-3c06-ae3b-d3e3-8b0be13cfb32@tls.msk.ru>
Date: Fri, 14 Jul 2023 15:54:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH, trivial 00/29] tree-wide spelling fixes in comments and
 some messages
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20230714113834.1186117-1-mjt@tls.msk.ru>
 <CAFEAcA9RjLeu2pqFMaKzCOd7GeSwYbCs-E7kXwuvTEy59W70=Q@mail.gmail.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <CAFEAcA9RjLeu2pqFMaKzCOd7GeSwYbCs-E7kXwuvTEy59W70=Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.091,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

14.07.2023 15:44, Peter Maydell wrote:
..
>> Michael Tokarev (29):
>>    tree-wide spelling fixes in comments and some messages: block
>>    tree-wide spelling fixes in comments and some messages: bsd-user
> 
> This would be easier to deal with if it followed our
> standard convention of putting the subsystem name at the
> front of the subject line, not the end.

Well, as usual, good thoughts come after the thing's done already :)

I pushed whole series to my qemu tree clone on gitlab:

  https://gitlab.com/mjt0k/qemu/-/commits/spelling

Here, it is actually easier to review because gitlab diff highlights
actually changed words in addition to lines.


> and it's not possible to tell which I might care about
> reviewing from the list-of-emails pane without clicking
> through each time...

I'm sorry about that.  Here I have such window layout so whole subject
fits on the screen, and actual message is below the list of messages.
I don't think re-sending it is a good idea though.. ;)

Thank you!

/mjt

