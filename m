Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 274A37710A0
	for <lists+qemu-devel@lfdr.de>; Sat,  5 Aug 2023 18:44:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qSKNE-0006fn-Q1; Sat, 05 Aug 2023 12:43:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSKNC-0006fR-5p
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 12:43:26 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qSKNA-0007Bp-CZ
 for qemu-devel@nongnu.org; Sat, 05 Aug 2023 12:43:25 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 30BBA18615;
 Sat,  5 Aug 2023 19:43:40 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 3BE8D1BA25;
 Sat,  5 Aug 2023 19:43:18 +0300 (MSK)
Message-ID: <848a140d-3855-8789-ff90-35952962651b@tls.msk.ru>
Date: Sat, 5 Aug 2023 19:43:18 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Fix scripts/checkpatch.py style failures.
Content-Language: en-US
To: Nathan Egge <negge@xiph.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>, Helge Deller <deller@gmx.de>,
 qemu-devel@nongnu.org
References: <20230805125124.42482-1-negge@xiph.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230805125124.42482-1-negge@xiph.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -69
X-Spam_score: -7.0
X-Spam_bar: -------
X-Spam_report: (-7.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.089,
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

05.08.2023 15:51, Nathan Egge пишет:
> From: "Nathan Egge" <negge@xiph.org>
> 
> Signed-off-by: Nathan Egge <negge@xiph.org>

This needs at least some meaningful subject prefix.
With the subject like it is now, it feels like the
patch is about fixing checkpatch.py script itself.

Something like:

  linux-user/syscall.c: fix coding-style issue (space-around-or)

I think one of the two places should be fixed in a
patch which touches this place in tcg-next series
instead of separately.

/mjt

