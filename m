Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FBF705864
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 22:12:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pz11m-0003xM-4J; Tue, 16 May 2023 16:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pz11j-0003qV-Q4; Tue, 16 May 2023 16:12:07 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1pz11h-00011y-Sl; Tue, 16 May 2023 16:12:07 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 13F6E654D;
 Tue, 16 May 2023 23:11:58 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 8F0BA5BF3;
 Tue, 16 May 2023 23:11:56 +0300 (MSK)
Message-ID: <fa44c412-d40b-cd7e-f861-850991169fb5@msgid.tls.msk.ru>
Date: Tue, 16 May 2023 23:11:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tcg/i386: Set P_REXW in tcg_out_addi_ptr
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20230512171755.1237329-1-richard.henderson@linaro.org>
Content-Language: en-US
Cc: qemu-stable <qemu-stable@nongnu.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230512171755.1237329-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-2.666,
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

12.05.2023 20:17, Richard Henderson wrote:
> The REXW bit must be set to produce a 64-bit pointer result; the
> bit is disabled in 32-bit mode, so we can do this unconditionally.
> 
> Fixes: 7d9e1ee424b0 ("tcg/i386: Adjust assert in tcg_out_addi_ptr")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1592
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1642

This looks like stable-8.0 material.



