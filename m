Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F89C7887C4
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 14:49:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZWEN-0005KY-QM; Fri, 25 Aug 2023 08:48:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZWEL-0005K9-2m
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 08:48:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qZWEI-0002W2-G5
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 08:48:00 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 321F01CE63;
 Fri, 25 Aug 2023 15:48:14 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 9390521CCC;
 Fri, 25 Aug 2023 15:47:51 +0300 (MSK)
Message-ID: <a3b80858-4021-b57a-cd15-336048b6a6a5@tls.msk.ru>
Date: Fri, 25 Aug 2023 15:47:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH] fix leaks found wtih fuzzing
Content-Language: en-US
To: Dmitry Frolov <frolov@swemel.ru>, kraxel@redhat.com,
 marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: sdl.qemu@linuxtesting.org
References: <20230825115818.1091936-1-frolov@swemel.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230825115818.1091936-1-frolov@swemel.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -84
X-Spam_score: -8.5
X-Spam_bar: --------
X-Spam_report: (-8.5 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.57,
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

25.08.2023 14:58, Dmitry Frolov wrote:
> It is true, that there is no problem during runtime
> from the first sight, because the memory is lost just
> before qemu exits. Nevertheless, this change is necessary,
> because AddressSanitizer is not able to recognize this
> situation and produces crash-report (which is
> false-positive in fact). Lots of False-Positive warnings
> are davaluing problems, found with fuzzing, and thus the
> whole methodology of dynamic analysis.
> This patch eliminates such False-Positive reports,
> and makes every problem, found with fuzzing, more valuable.
> 
> Fixes: 060ab76356 ("gtk: don't exit early in case gtk init fails")
> 
> Signed-off-by: Dmitry Frolov <frolov@swemel.ru>

A nitpkck: I'm suggesting subject prefix to be "ui/gtk:".

With that fixed (can be done at apply time),

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

