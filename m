Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 476757A0222
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 13:06:29 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgkAY-0007KP-Pe; Thu, 14 Sep 2023 07:06:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgkAB-0007D9-17
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:05:38 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qgkA8-0004U0-EO
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 07:05:34 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id DFAC921D73;
 Thu, 14 Sep 2023 14:05:28 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 2D42C280C3;
 Thu, 14 Sep 2023 14:05:21 +0300 (MSK)
Message-ID: <8d43d03d-ac66-0d01-0137-d27eaac628d3@tls.msk.ru>
Date: Thu, 14 Sep 2023 14:05:21 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v3 3/3] linux-user/syscall.c: do_ppoll: eliminate large
 alloca
Content-Language: en-US
From: Michael Tokarev <mjt@tls.msk.ru>
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20230914074337.149897-1-mjt@tls.msk.ru>
 <20230914074337.149897-4-mjt@tls.msk.ru> <ZQLBvThMJK7LzoOw@redhat.com>
 <33f3e825-97ba-eeef-c991-75c2317fdc11@tls.msk.ru>
In-Reply-To: <33f3e825-97ba-eeef-c991-75c2317fdc11@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

14.09.2023 11:26, Michael Tokarev wrote:
> 14.09.2023 11:18, Daniel P. Berrangé wrote:
..
>>> -    struct pollfd *pfd = NULL;
>>> +    struct pollfd *pfd = NULL, *heap_pfd = NULL;
>>
>> g_autofree struct pollfd *heap_pdf = NULL;
>>
> ...
>>>   out:
>>> +    g_free(heap_pfd);
>>
>> This can be dropped with g_autofree usage
> 
> Yes, I know this, - this was deliberate choice.
> Personally I'm just too used to old-school explicit resource deallocations.
> Here, there's a single place where everything gets freed, so there's little
> reason to use fancy modern automatic deallocations. To my taste anyway.
> Maybe some future modifications adding some future ppoll3.. :)
> 
> Sure thing I can drop that and change it to autofree.

Should I? If that's easier in todays world :)

/mjt

