Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B48287DF4A3
	for <lists+qemu-devel@lfdr.de>; Thu,  2 Nov 2023 15:11:49 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qyYPp-00084p-LK; Thu, 02 Nov 2023 10:11:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qyYPk-00083Y-4f; Thu, 02 Nov 2023 10:11:16 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qyYPh-0005tn-CK; Thu, 02 Nov 2023 10:11:15 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9E8E72FC71;
 Thu,  2 Nov 2023 17:11:16 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 1721732EE9;
 Thu,  2 Nov 2023 17:11:09 +0300 (MSK)
Message-ID: <2b923514-623c-4154-aa7f-b84937db8974@tls.msk.ru>
Date: Thu, 2 Nov 2023 17:11:09 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: -drive if=none: can't we make this the default?
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 "open list:Network Block Dev..." <qemu-block@nongnu.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, "Daniel P. Berrange"
 <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <d9d1ec6c-d812-4994-968d-bd40228dac51@tls.msk.ru>
 <e3bb64a2-fb72-4e8d-a0b2-89ee35365fb3@tls.msk.ru>
 <ZUFK/BHG2WMhAiWG@redhat.com>
 <CAFEAcA_6nPW2f0+zvtYAg6d7ZJJMLxqFzNOyDY0wLgVFNcoahw@mail.gmail.com>
 <ZUN9SZ6VkvLHWNXs@redhat.com>
 <CAFEAcA8hssUvz8kb4VYXNZSyrQhRyo+=AebA-hskm64bmhG-MA@mail.gmail.com>
 <ZUOs7j823+a6FBD2@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZUOs7j823+a6FBD2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -68
X-Spam_score: -6.9
X-Spam_bar: ------
X-Spam_report: (-6.9 / 5.0 requ) BAYES_00=-1.9, RCVD_IN_DNSWL_HI=-5,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

02.11.2023 17:06, Kevin Wolf:
> Am 02.11.2023 um 12:01 hat Peter Maydell geschrieben:
>> Whoops, have I got the terminology wrong again? To me these are
>> "snapshots" (they do store the whole VM state including the current
>> state of the disk, and "qemu-img info" lists them as "snapshots"),
>> whereas I never use the '-snapshot' option, so I never remember
>> that we have two different things here. Sorry for introducing
>> confusion :-(
> 
> It is confusing, -snapshot really doesn't have the best name.

Can we use -ephemeral for this?

/mjt

