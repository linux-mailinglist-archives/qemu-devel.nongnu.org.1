Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id EE69C7AE039
	for <lists+qemu-devel@lfdr.de>; Mon, 25 Sep 2023 22:14:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkrx1-0004L9-V8; Mon, 25 Sep 2023 16:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qkrwv-0004KF-PH
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:12:57 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qkrwt-0002Ok-Oh
 for qemu-devel@nongnu.org; Mon, 25 Sep 2023 16:12:57 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id A7EFF24F86;
 Mon, 25 Sep 2023 23:13:22 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id A9CE12A9B9;
 Mon, 25 Sep 2023 23:12:52 +0300 (MSK)
Message-ID: <26c46089-828a-721e-21f3-7286f270a60b@tls.msk.ru>
Date: Mon, 25 Sep 2023 23:12:52 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 11/12] hw/core/loader: read_targphys(): add upper bound
Content-Language: en-US
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Joel Stanley <joel@jms.id.au>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Ard Biesheuvel <ardb@kernel.org>
References: <20230925194040.68592-1-vsementsov@yandex-team.ru>
 <20230925194040.68592-12-vsementsov@yandex-team.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230925194040.68592-12-vsementsov@yandex-team.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

25.09.2023 22:40, Vladimir Sementsov-Ogievskiy wrote:
> Coverity doesn't like using "untrusted" values, coming from buffers and
> fd-s as length to do IO and allocations. And that's make sense. The

"And that makes sense".  Just a nitpick in commit comment.

> function is used three times with "untrusted" nbytes parameter. Let's
> introduce at least empirical limit of 1G for it.
> 
> While being here make the function static, as it's used only here.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
>   hw/core/loader.c    | 13 ++++++++++---
>   include/hw/loader.h |  2 --
>   2 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/core/loader.c b/hw/core/loader.c
> index aa02b27089..48cff6f59e 100644
> --- a/hw/core/loader.c
> +++ b/hw/core/loader.c
> @@ -101,17 +101,24 @@ ssize_t load_image_size(const char *filename, void *addr, size_t size)
>       return actsize < 0 ? -1 : l;
>   }
>   
> +#define READ_TARGPHYS_MAX_BYTES (1024 * 1024 * 1024)
>   /* read()-like version */
> -ssize_t read_targphys(const char *name,
> -                      int fd, hwaddr dst_addr, size_t nbytes)
> +static ssize_t read_targphys(const char *name,
> +                             int fd, hwaddr dst_addr, size_t nbytes)
>   {
>       uint8_t *buf;
>       ssize_t did;
>   
> +    if (nbytes > READ_TARGPHYS_MAX_BYTES) {
> +        return -1;

Right now this is not important, since the only user of this
function, load_aout(), ignores errno value and reports general
failure instead.  Original read_targphys() returned errno which
corresponds to failed read().

FWIW, at least load_aout() assumes we've read whole struct exec
from the file in question, which might not be the case.

/mjt

