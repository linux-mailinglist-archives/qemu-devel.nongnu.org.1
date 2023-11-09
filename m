Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36B167E6C82
	for <lists+qemu-devel@lfdr.de>; Thu,  9 Nov 2023 15:38:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r16AE-0005CH-B3; Thu, 09 Nov 2023 09:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r16A9-00058S-Vw; Thu, 09 Nov 2023 09:37:42 -0500
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1r16A8-00072I-2V; Thu, 09 Nov 2023 09:37:41 -0500
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 6640B31CAC;
 Thu,  9 Nov 2023 17:37:43 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 54CE734571;
 Thu,  9 Nov 2023 17:37:35 +0300 (MSK)
Message-ID: <fdd986e0-54cb-41ac-93e1-7770bb7f1649@tls.msk.ru>
Date: Thu, 9 Nov 2023 17:37:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/arm: Fix SVE STR increment
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Naresh Kamboju <naresh.kamboju@linaro.org>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org, qemu-stable@nongnu.org,
 Anders Roxell <anders.roxell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231031143215.29764-1-richard.henderson@linaro.org>
 <874jhv86a4.fsf@draig.linaro.org>
 <f7f5288a-c2dd-4831-8bac-31286f53f394@tls.msk.ru>
 <87y1f76oa6.fsf@draig.linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <87y1f76oa6.fsf@draig.linaro.org>
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

09.11.2023 16:37, Alex Bennée wrote:
> Awesome, I shall try to remember to check that branch first ;-)

I tend to avoid pushing stuff to main qemu repo,
to avoid spending CI minutes.  But from time to time I do push there.

> Have a Tested-by: Alex Bennée <alex.bennee@linaro.org>
> 
> for the branch fix.

Woops. You ruined my branch, so I had to force-push it with your new tag :)

/mjt

