Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CF61577E1FD
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 14:54:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWG1A-0005bb-G1; Wed, 16 Aug 2023 08:52:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qWG12-0005b2-6s; Wed, 16 Aug 2023 08:52:48 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qWG0z-0005lE-Pr; Wed, 16 Aug 2023 08:52:47 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 877271ACDE;
 Wed, 16 Aug 2023 15:52:47 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9F0E41FA39;
 Wed, 16 Aug 2023 15:52:41 +0300 (MSK)
Message-ID: <01d1482b-6b84-b762-f98c-7e0e74087820@tls.msk.ru>
Date: Wed, 16 Aug 2023 15:52:41 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: qemu-system-x86 dependencies
Content-Language: en-US
To: Fourhundred Thecat <400thecat@gmx.ch>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-discuss@nongnu.org, QEMU Developers <qemu-devel@nongnu.org>
References: <ed59d5cc-587e-ae8a-f367-96e4e58b67ce@gmx.ch>
 <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <10b32eab-a19a-a656-b8bd-4aef1f00bf11@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -100
X-Spam_score: -10.1
X-Spam_bar: ----------
X-Spam_report: (-10.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.165,
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

16.08.2023 15:37, Philippe Mathieu-Daudé пишет:
> Cc'ing Michael
> 
> On 16/8/23 13:52, Fourhundred Thecat wrote:
>> Hello,
>>
>> I am trying to install qemu-system-x86 on Debian 12.
>>
>> But through the dependency cascade, it wants to install sound
>> infrastructure with gstreamer libraries. Which leads to absurd
>> dependencies, such as:
>>
>>    libasound2
>>    libgstreamer-plugins-base1.0-0
>>    libopus0
>>    libwayland-server0
>>    libusb-1.0-0
>>
>> Does this madness come from Debian distribution, or from upstream?

I don't know which madness you're talking about. Is it qemu upstream madness
or debian distribution madness?  Maybe if you were be a bit more specific
and share your definition of madness, things would be more clear.  But with
either of the mentioned madness, it might be neither of us are able to
understand, being both mad.

/mjt

