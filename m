Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD279E58D
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 13:00:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgNau-0006UD-Fn; Wed, 13 Sep 2023 06:59:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgNar-0006Th-2W; Wed, 13 Sep 2023 06:59:37 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qgNao-0001Gl-5V; Wed, 13 Sep 2023 06:59:36 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 1FF0E21674;
 Wed, 13 Sep 2023 13:59:29 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5445A27BB6;
 Wed, 13 Sep 2023 13:59:23 +0300 (MSK)
Message-ID: <b905884e-04ad-f195-3228-b0bedc59b66c@tls.msk.ru>
Date: Wed, 13 Sep 2023 13:59:23 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH v5 3/6] target/i386: Call accel-agnostic
 x86_cpu_get_supported_cpuid()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20230913093009.83520-1-philmd@linaro.org>
 <20230913093009.83520-4-philmd@linaro.org>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230913093009.83520-4-philmd@linaro.org>
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

13.09.2023 12:30, Philippe Mathieu-Daudé:
> x86_cpu_get_supported_cpuid() is generic and handles the different
> accelerators. Use it instead of kvm_arch_get_supported_cpuid().
> 
> That fixes a link failure introduced by commit 3adce820cf
> ("target/i386: Remove unused KVM stubs") when QEMU is configured
> as:
..
> Cc: qemu-stable@nongnu.org
> Fixes: 3adce820cf ("target/i386: Remove unused KVM stubs")

This hopefully should not go to -stable as the issue has been
introduced in v8.1.0-291-g3adce820cf which is past latest release.
That's okay though, - just a small side-note.

/mjt

