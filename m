Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9677079EE0E
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 18:11:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgSSd-0000Wi-35; Wed, 13 Sep 2023 12:11:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgSSa-0000WE-71; Wed, 13 Sep 2023 12:11:24 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgSSX-0000OH-Ok; Wed, 13 Sep 2023 12:11:23 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id BA1FF2189C;
 Wed, 13 Sep 2023 19:11:23 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 7D58027D69;
 Wed, 13 Sep 2023 19:11:17 +0300 (MSK)
Message-ID: <62907ae5-8857-68f9-283d-e6e762cf226a@tls.msk.ru>
Date: Wed, 13 Sep 2023 19:11:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Stable-8.0.5 00/66] v2 Patch Round-up for stable 8.0.5, freeze
 on 2023-09-19
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org
References: <qemu-stable-8.0.5-20230913160844@cover.tls.msk.ru>
 <ZQHXW74CpyTIVYET@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZQHXW74CpyTIVYET@redhat.com>
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

13.09.2023 18:38, Kevin Wolf wrote:
..
>> I'm not sure about this change for now:
>>   56 92e2e6a86733 Kevin Wolf:
>>     virtio: Drop out of coroutine context in virtio_load()
...
> What is the change in commit 92e2e6a86733 that could affect this bug? I
> only changed the migration code path, but the Gitlab issue doesn't
> mention migration at all. In the issue itself, I can only see it linked
> to a different commit (0d58c660 softmmu: Use async_run_on_cpu in
> tcg_commit).
> 
> Did you mean a different commit or a different issue?

Yes, you're exactly right, I meant the 0d58c660 softmmu one, not
virtio-coroutine one.  That's me doing stuff early morning in
-ENOCOFFEE mode :)

Please excuse me for the noise. There's a bit too many patches :)

Thank you!

/mjt


