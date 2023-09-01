Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B833678FBAC
	for <lists+qemu-devel@lfdr.de>; Fri,  1 Sep 2023 12:16:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qc1CB-0000I7-S3; Fri, 01 Sep 2023 06:16:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qc1Bz-00005v-H1; Fri, 01 Sep 2023 06:16:01 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1qc1Bx-0002Fh-9u; Fri, 01 Sep 2023 06:15:55 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 20FB91E747;
 Fri,  1 Sep 2023 13:16:26 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 5572D25077;
 Fri,  1 Sep 2023 13:15:50 +0300 (MSK)
Message-ID: <a9aa3e9e-dbde-54ed-1df0-749f483806f6@tls.msk.ru>
Date: Fri, 1 Sep 2023 13:15:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 0/3] hw/mips/jazz: Rework the NIC init code
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-trivial@nongnu.org
References: <20230825175123.624114-1-thuth@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230825175123.624114-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -103
X-Spam_score: -10.4
X-Spam_bar: ----------
X-Spam_report: (-10.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.478,
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

25.08.2023 20:51, Thomas Huth wrote:
> The NIC init code of the jazz machines is rather cumbersome, with
> a for-loop around it that is always left after the first iteration.
> This patch series reworks this a little bit to make the code more
> readable and shorter.
> 
> Thomas Huth (3):
>    hw/mips/jazz: Remove the big_endian variable
>    hw/mips/jazz: Move the NIC init code into a separate function
>    hw/mips/jazz: Simplify the NIC setup code

Thomas, after comments for "hw/mips/jazz: Remove the big_endian variable",
will you respin?

Thanks!

/mjt



