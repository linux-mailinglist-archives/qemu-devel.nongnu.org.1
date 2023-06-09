Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A11FD72A4AF
	for <lists+qemu-devel@lfdr.de>; Fri,  9 Jun 2023 22:21:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7ibx-0005Q4-LJ; Fri, 09 Jun 2023 16:21:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7ibZ-0005A4-5t; Fri, 09 Jun 2023 16:21:05 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>)
 id 1q7ibX-0000mW-CR; Fri, 09 Jun 2023 16:21:04 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 9365ABD4A;
 Fri,  9 Jun 2023 23:20:52 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 4AE11B1DB;
 Fri,  9 Jun 2023 23:20:50 +0300 (MSK)
Message-ID: <f0d91602-e41a-1e13-08a4-b6ff2565b4f1@tls.msk.ru>
Date: Fri, 9 Jun 2023 23:20:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] vnc: move assert in vnc_worker_thread_loop
Content-Language: en-US
To: Anastasia Belova <abelova@astralinux.ru>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230609092306.19836-1-abelova@astralinux.ru>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230609092306.19836-1-abelova@astralinux.ru>
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

09.06.2023 12:23, Anastasia Belova wrote:
> job may be NULL if queue->exit is true. Check
> it before dereference job.
> 
> Fixes: f31f9c1080 ("vnc: add magic cookie to VncState")
> Signed-off-by: Anastasia Belova <abelova@astralinux.ru>
> ---
>   ui/vnc-jobs.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/ui/vnc-jobs.c b/ui/vnc-jobs.c
> index 886f9bf611..fcca7ec632 100644
> --- a/ui/vnc-jobs.c
> +++ b/ui/vnc-jobs.c
> @@ -250,12 +250,13 @@ static int vnc_worker_thread_loop(VncJobQueue *queue)
>       /* Here job can only be NULL if queue->exit is true */
>       job = QTAILQ_FIRST(&queue->jobs);
>       vnc_unlock_queue(queue);
> -    assert(job->vs->magic == VNC_MAGIC);
>   
>       if (queue->exit) {
>           return -1;
>       }
>   
> +    assert(job->vs->magic == VNC_MAGIC);
> +

This is a good one, I like it :)

Reviewed-by: Michael Tokarev <mjt@tls.msk.ru>

It can be applied though -trivial queue.

Thank you!

/mjt

