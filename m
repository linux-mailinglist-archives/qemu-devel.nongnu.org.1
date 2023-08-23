Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F217850A3
	for <lists+qemu-devel@lfdr.de>; Wed, 23 Aug 2023 08:28:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qYhKP-0004Wl-4a; Wed, 23 Aug 2023 02:26:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhKJ-0004WN-JF
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:26:47 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qYhKH-0005A8-UX
 for qemu-devel@nongnu.org; Wed, 23 Aug 2023 02:26:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id C40761C3E6
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:26:59 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 61E402126D
 for <qemu-devel@nongnu.org>; Wed, 23 Aug 2023 09:26:41 +0300 (MSK)
Message-ID: <2c59728b-004c-d81c-eb45-cede21cf246b@tls.msk.ru>
Date: Wed, 23 Aug 2023 09:26:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 00/24] tree-wide spelling fixes
Content-Language: en-US
To: qemu-devel@nongnu.org
References: <20230823055155.1917375-1-mjt@tls.msk.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230823055155.1917375-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -86
X-Spam_score: -8.7
X-Spam_bar: --------
X-Spam_report: (-8.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.767,
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

This is interesting.

So, I forgot to remove old, already sent patches from the work dir
(usually I remove whole thing but didn't do that now).  So I had
2 patch series in the same dir, one old already sent and applied,
and one new.  And did git send-email series/* - which obviously
included both.

But the fun part is the References: headers and hence threading.

I used git format-patch --cover-letter $since-commit.  Git created the
cover letter with Message-Id 20230823055155.1917375-1-mjt@tls.msk.ru.
And used this Id in References: header of the *first* patch.

But in all subsequent patches 2..24, it used *another* ID in the
References: header, the one taken from the *old* cover letter,
which it replaced when generating the new cover.

Obviously I did not edit the messages, did not specify anything
more fancy besides --cover-letter, - the only issue was that I
had another 4-file patch series in the same dir.

This smells like an.. interesting bug in git.. :)

/mjt

