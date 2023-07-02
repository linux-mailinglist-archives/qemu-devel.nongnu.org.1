Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D54A4744FD2
	for <lists+qemu-devel@lfdr.de>; Sun,  2 Jul 2023 20:42:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qG216-00063a-LE; Sun, 02 Jul 2023 14:41:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qG213-00063S-3W
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 14:41:45 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qG211-0002hq-8C
 for qemu-devel@nongnu.org; Sun, 02 Jul 2023 14:41:44 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AE75810E15;
 Sun,  2 Jul 2023 21:41:38 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DC40111210;
 Sun,  2 Jul 2023 21:41:36 +0300 (MSK)
Message-ID: <31a0d821-5dde-9677-d11a-3686b8246e86@tls.msk.ru>
Date: Sun, 2 Jul 2023 21:41:36 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] linux-user/i386: Properly align signal frame
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu
References: <20230524054647.1093758-1-richard.henderson@linaro.org>
 <9d06173b-f739-df6b-263f-bb426e2fef97@linaro.org>
 <9311fdff-325b-6591-99e8-7ea0cb027ae6@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <9311fdff-325b-6591-99e8-7ea0cb027ae6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.09,
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

30.06.2023 20:53, Richard Henderson wrote:
> Ping 2.
> 
> On 6/20/23 15:26, Richard Henderson wrote:
>> Ping.
>>
>> On 5/24/23 07:46, Richard Henderson wrote:
>>> The beginning of the structure, with pretaddr, should be just below
>>> 16-byte alignment.  Disconnect fpstate from sigframe, just like the
>>> kernel does.

This smells like a -stable material too (I tagged it "stable" in my inbox
a month ago already), as it is fixing real bug which people are hitting.

/mjt

