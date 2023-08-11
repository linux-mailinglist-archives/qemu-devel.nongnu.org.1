Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E52C7786E3
	for <lists+qemu-devel@lfdr.de>; Fri, 11 Aug 2023 07:15:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qUKTI-0008FO-6f; Fri, 11 Aug 2023 01:14:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUKTC-0008Dd-Qi
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 01:13:55 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qUKTA-0003Au-QT
 for qemu-devel@nongnu.org; Fri, 11 Aug 2023 01:13:54 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 35BC919B7D;
 Fri, 11 Aug 2023 08:13:55 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id EA3641D629;
 Fri, 11 Aug 2023 08:13:46 +0300 (MSK)
Message-ID: <09e4c8c9-1eb0-73a8-3219-fd2805d87bbb@tls.msk.ru>
Date: Fri, 11 Aug 2023 08:13:46 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PULL 1/1] target/openrisc: Set EPCR to next PC on FPE exceptions
Content-Language: en-US
To: Stafford Horne <shorne@gmail.com>
Cc: QEMU Development <qemu-devel@nongnu.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230809203432.424071-1-shorne@gmail.com>
 <20230809203432.424071-2-shorne@gmail.com>
 <a5dc02df-158e-4ff8-fce9-e2ec7df980ad@tls.msk.ru> <ZNU/hbdfbAOzp95u@antec>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <ZNU/hbdfbAOzp95u@antec>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -90
X-Spam_score: -9.1
X-Spam_bar: ---------
X-Spam_report: (-9.1 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.156,
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

10.08.2023 22:50, Stafford Horne wrote:
> On Thu, Aug 10, 2023 at 09:35:18AM +0300, Michael Tokarev wrote:
..
>> Is it a -stable material?  It applies cleanly to 8.0 and 7.2.
>> Or maybe it is not needed on older versions, not being noticed before?
> 
> I would say no, it will work on 8.0 an 7.2 but this code path is not very useful
> withouth the other 8.1 Floating Point Exception handling updates.

Thank you for letting me know. This makes good sense, and shares my expectations
too.  This particular situation is rather interesting, that's why I asked.

/mjt


