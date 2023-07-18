Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E72275720D
	for <lists+qemu-devel@lfdr.de>; Tue, 18 Jul 2023 05:06:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qLb0o-0003QX-Aj; Mon, 17 Jul 2023 23:04:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gaosong@loongson.cn>)
 id 1qLb0l-0003Q9-D7
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 23:04:27 -0400
Received: from mail.loongson.cn ([114.242.206.163])
 by eggs.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <gaosong@loongson.cn>) id 1qLb0h-0007H5-On
 for qemu-devel@nongnu.org; Mon, 17 Jul 2023 23:04:26 -0400
Received: from loongson.cn (unknown [10.20.42.57])
 by gateway (Coremail) with SMTP id _____8BxHOstAbZke2UGAA--.11581S3;
 Tue, 18 Jul 2023 11:04:14 +0800 (CST)
Received: from [10.20.42.57] (unknown [10.20.42.57])
 by localhost.localdomain (Coremail) with SMTP id
 AQAAf8CxF8wZAbZkB4UyAA--.33956S3; 
 Tue, 18 Jul 2023 11:04:12 +0800 (CST)
Subject: Re: [PATCH 0/6] linux-user: brk() syscall fixes and armhf static
 binary fix
To: Helge Deller <deller@gmx.de>, Michael Tokarev <mjt@tls.msk.ru>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20230717213545.142598-1-deller@gmx.de>
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
From: Song Gao <gaosong@loongson.cn>
Message-ID: <703ab494-1778-c50a-d46f-988fab846da3@loongson.cn>
Date: Tue, 18 Jul 2023 11:03:53 +0800
User-Agent: Mozilla/5.0 (X11; Linux loongarch64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20230717213545.142598-1-deller@gmx.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID: AQAAf8CxF8wZAbZkB4UyAA--.33956S3
X-CM-SenderInfo: 5jdr20tqj6z05rqj20fqof0/
X-Coremail-Antispam: 1Uk129KBj93XoW7Ww1UCFWxAw1xtr1fGw47ZFc_yoW8Wr4rp3
 s3GrsxGr1rJrsxKayfXw1xZ3ZYgF4kGw1UGw13X34SvFy8CF1jvw1qgF45KasxCrW0kFsr
 tryUGryDCryY93gCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
 sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
 0xBIdaVrnRJUUUBFb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
 IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
 e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
 0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
 xVW8Jr0_Cr1UM2kKe7AKxVWUXVWUAwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
 AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWU
 AVWUtwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
 8JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_
 Jr0_Gr1l4IxYO2xFxVAFwI0_Jrv_JF1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
 xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
 cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
 AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
 14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07jjWlkUUUUU=
Received-SPF: pass client-ip=114.242.206.163; envelope-from=gaosong@loongson.cn;
 helo=mail.loongson.cn
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-0.097,
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

Hi,  Helge

Could you see the following bugs:
https://gitlab.com/qemu-project/qemu/-/issues/1707

This issue is also caused by  the commit  86f04735ac.

Thanks.
Song Gao


在 2023/7/18 上午5:35, Helge Deller 写道:
> Commit 86f04735ac ("linux-user: Fix brk() to release pages") introduced the
> possibility for userspace applications to reduce memory footprint by calling
> brk() with a lower address and free up memory.
> This change introduced some failures for applications with errors like
> - accesing bytes above the brk heap address on the same page,
> - freeing memory below the initial brk address,
> and introduced a behaviour which isn't done by the kernel (e.g. zeroing
> memory above brk).
>
> This patch set fixes those issues and have been tested with existing
> programs (e.g. upx).
>
> Additionally it includes one patch to allow running static armhf executables
> (e.g. fstype) which was broken since qemu-8.0.
>
> Helge
>
> Helge Deller (6):
>    Revert "linux-user: Make sure initial brk(0) is page-aligned"
>    linux-user: Fix qemu brk() to not zero bytes on current page
>    linux-user: Prohibit brk() to to shrink below initial heap address
>    linux-user: Fix signed math overflow in brk() syscall
>    linux-user: Fix strace output for old_mmap
>    linux-user: Fix qemu-arm to run static armhf binaries
>
>   linux-user/elfload.c |  7 +++++++
>   linux-user/strace.c  | 49 ++++++++++++++++++++++++++++++++++++++++----
>   linux-user/syscall.c | 25 +++++++++++++---------
>   3 files changed, 67 insertions(+), 14 deletions(-)
>
> --
> 2.41.0
>


