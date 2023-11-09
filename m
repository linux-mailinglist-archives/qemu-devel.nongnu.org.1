Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7938A7E6B28
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 14:21:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r14xW-00049H-9o; Thu, 09 Nov 2023 08:20:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r14xR-00047X-1W; Thu, 09 Nov 2023 08:20:29 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r14xN-0003vY-EA; Thu, 09 Nov 2023 08:20:28 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 0FEAE31ADF;
 Thu,  9 Nov 2023 16:20:22 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id DD58034484;
 Thu,  9 Nov 2023 16:20:13 +0300 (MSK)
Message-ID: <f7f5288a-c2dd-4831-8bac-31286f53f394@tls.msk.ru>
Date: Thu, 9 Nov 2023 16:20:13 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Fix SVE STR increment
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231031143215.29764-1-richard.henderson@linaro.org>
 <874jhv86a4.fsf@draig.linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <874jhv86a4.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

09.11.2023 15:23, Alex Bennée:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> The previous change missed updating one of the increments and
>> one of the MemOps.  Add a test case for all vector lengths.
>>
>> Cc: qemu-stable@nongnu.org
>> Fixes: e6dd5e782be ("target/arm: Use tcg_gen_qemu_{ld, st}_i128 in gen_sve_{ld, st}r")
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> 
> This was Cd'd for stable but didn't make it in. There is a trivial
> re-base conflict but I can re-send the patch if that helps.

Nope, I picked it up, here:

  https://gitlab.com/mjt0k/qemu/-/commits/staging-8.1/?ref_type=heads

commit eabe320b, committed 5 days ago, - about the time when it has
been committed to master.

I want to send announce for the next 8.1 release, just haven't decided
when to do that, - usually there's quite a few fixes coming during the
freeze. Maybe the best is to get 8.1.3 now and 8.1.4 together with 8.2.0.

/mjt

