Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1295573E532
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 18:34:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDp9e-00029i-Dv; Mon, 26 Jun 2023 12:33:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDp9b-00029G-Ll; Mon, 26 Jun 2023 12:33:27 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qDp9Z-0006wN-Ti; Mon, 26 Jun 2023 12:33:27 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 48A96EEC7;
 Mon, 26 Jun 2023 19:33:24 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 0E2A7F76B;
 Mon, 26 Jun 2023 19:33:23 +0300 (MSK)
Message-ID: <83af5e1c-adf4-3710-60d1-f89b13eba124@tls.msk.ru>
Date: Mon, 26 Jun 2023 19:33:22 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PULL v2 1/3] target/hppa: Fix OS reboot issues
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-stable <qemu-stable@nongnu.org>, Michael Roth <michael.roth@amd.com>
References: <20230624115007.30332-1-deller@gmx.de>
 <20230624115007.30332-2-deller@gmx.de>
 <c2917053-e8df-c2bc-9565-6d5f257db901@tls.msk.ru>
 <6a7e29ed-3ce9-c228-2d29-96151a5f8ccb@gmx.de>
 <45215ee6-b36f-5c90-6937-9f45277598ea@gmx.de>
 <cec99847-86d5-40ed-6f87-b0e9106d403b@tls.msk.ru>
 <a4fcdfa9-aeda-1c89-3c8e-7559626c929b@gmx.de>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <a4fcdfa9-aeda-1c89-3c8e-7559626c929b@gmx.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

26.06.2023 19:20, Helge Deller wrote:
..
> starting in both branches (staging-7.2 and staging-8.0) this works for me:
> 
> git cherry-pick bb9c998ca9343d445c76b69fa15dea9db692f526
> git cherry-pick 50ba97e928b44ff5bc731c9ffe68d86acbe44639
> git cherry-pick 069d296669448b9eef72c6332ae84af962d9582c
> git cherry-pick 34ec3aea54368a92b62a55c656335885ba8c65ef

Got it. Somehow I missed bb9c998ca9343d445c76b69fa15dea9db692f526.
It all works fine now.

Thank you!

/mjt

