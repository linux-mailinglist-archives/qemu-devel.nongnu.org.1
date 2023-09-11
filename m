Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B01779A7B1
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Sep 2023 13:45:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qffME-0007sR-9P; Mon, 11 Sep 2023 07:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qffM0-0007p0-20
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:45:25 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1qffLj-0002Ap-UB
 for qemu-devel@nongnu.org; Mon, 11 Sep 2023 07:45:19 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 3629420C78;
 Mon, 11 Sep 2023 14:45:03 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 496BB273C9;
 Mon, 11 Sep 2023 14:45:01 +0300 (MSK)
Message-ID: <46e9440e-8c63-621d-dc93-6374984fd5e5@tls.msk.ru>
Date: Mon, 11 Sep 2023 14:45:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] tpm: fix crash when FD >= 1024
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Stefan Berger <stefanb@linux.vnet.ibm.com>
References: <20230911113614.1412887-1-marcandre.lureau@redhat.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230911113614.1412887-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-1.473,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

11.09.2023 14:36, marcandre.lureau@redhat.com:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Replace select() with poll() to fix a crash when QEMU has a large number
> of FDs.
> 
> Fixes:
> https://bugzilla.redhat.com/show_bug.cgi?id=2020133
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   backends/tpm/tpm_util.c | 12 +++---------
>   1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
> index a6e6d3e72f..5f4c9f5b6f 100644
> --- a/backends/tpm/tpm_util.c
> +++ b/backends/tpm/tpm_util.c
> @@ -112,12 +112,9 @@ static int tpm_util_request(int fd,
>                               void *response,
>                               size_t responselen)
>   {
> -    fd_set readfds;
> +    GPollFD fds[1] = { {.fd = fd, .events = G_IO_IN } };
>       int n;
> -    struct timeval tv = {
> -        .tv_sec = 1,
> -        .tv_usec = 0,
> -    };
> +    int timeout = 1000;

You don't need a variable for this in poll().
Besides, this is clear in the context of this patch, which
says tv_sec=1. Without this context, it becomes suspicious
and catches an eye: too long timeout?

>       n = write(fd, request, requestlen);
>       if (n < 0) {
> @@ -127,11 +124,8 @@ static int tpm_util_request(int fd,
>           return -EFAULT;
>       }
>   
> -    FD_ZERO(&readfds);
> -    FD_SET(fd, &readfds);
> -
>       /* wait for a second */
> -    n = select(fd + 1, &readfds, NULL, NULL, &tv);
> +    n = RETRY_ON_EINTR(g_poll(fds, 1, timeout));

It's much better IMHO to use "1000" directly here, esp. since the
comment says about a second.

>       if (n != 1) {
>           return -errno;
>       }


Other than that,

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

/mjt

