Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D70A2787532
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 18:24:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZD7w-0001xH-I7; Thu, 24 Aug 2023 12:24:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZD7s-0001wv-11
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:24:04 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZD7k-00055x-UZ
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 12:24:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id AB9441CAD8;
 Thu, 24 Aug 2023 19:24:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A83C5219C0;
 Thu, 24 Aug 2023 19:23:53 +0300 (MSK)
Message-ID: <8eb65239-f29e-df5c-f0c0-abd97574254d@tls.msk.ru>
Date: Thu, 24 Aug 2023 19:23:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: Failing avocado tests in CI (was: Re: [PULL 00/24] tcg +
 linux-user queue for 8.1-rc3)
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>
References: <20230806033715.244648-1-richard.henderson@linaro.org>
 <772eb951-8a43-902b-3737-e52b44f7dcdb@redhat.com>
 <59a970fb-ad7b-d30b-1290-7b167bec0226@linaro.org> <87sf88fobd.fsf@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <87sf88fobd.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -97
X-Spam_score: -9.8
X-Spam_bar: ---------
X-Spam_report: (-9.8 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.919,
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

24.08.2023 18:31, Alex Bennée wrote:
..
> which bisects to:
> 
>    commit f7eaf9d702efdd02481d5f1c25f7d8e0ffb64c6e (HEAD, refs/bisect/bad)
>    Author: Richard Henderson <richard.henderson@linaro.org>
>    Date:   Tue Aug 1 10:46:03 2023 -0700
> 
>        accel/tcg: Do not issue misaligned i/o

It's not the first time something bisects to this commit.
But I can't find other relevant cases right now..

/mjt

