Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C66D7032A7
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 18:16:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyarU-0000ao-6T; Mon, 15 May 2023 12:15:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pyarL-0000ad-97
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:15:39 -0400
Received: from isrv.corpit.ru ([86.62.121.231])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mjt@tls.msk.ru>) id 1pyarG-000471-Is
 for qemu-devel@nongnu.org; Mon, 15 May 2023 12:15:39 -0400
Received: from tsrv.corpit.ru (tsrv.tls.msk.ru [192.168.177.2])
 by isrv.corpit.ru (Postfix) with ESMTP id 635C56026;
 Mon, 15 May 2023 19:15:31 +0300 (MSK)
Received: from [192.168.177.130] (mjt.wg.tls.msk.ru [192.168.177.130])
 by tsrv.corpit.ru (Postfix) with ESMTP id 46E6155AD;
 Mon, 15 May 2023 19:15:30 +0300 (MSK)
Message-ID: <e1dbf758-d7b5-756c-2fff-576d651d6d7e@msgid.tls.msk.ru>
Date: Mon, 15 May 2023 19:15:30 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH qemu] timer/i8254: Fix one shot PIT mode
Content-Language: en-US
To: Damien Zammit <damien@zamaudio.com>, qemu-devel@nongnu.org
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230226015755.52624-1-damien@zamaudio.com>
From: Michael Tokarev <mjt@tls.msk.ru>
In-Reply-To: <20230226015755.52624-1-damien@zamaudio.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=86.62.121.231; envelope-from=mjt@tls.msk.ru;
 helo=isrv.corpit.ru
X-Spam_score_int: -106
X-Spam_score: -10.7
X-Spam_bar: ----------
X-Spam_report: (-10.7 / 5.0 requ) BAYES_00=-1.9, NICE_REPLY_A=-3.811,
 RCVD_IN_DNSWL_HI=-5, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

26.02.2023 04:58, Damien Zammit wrote:
> Currently, the one-shot (mode 1) PIT expires far too quickly,
> due to the output being set under the wrong logic.
> This change fixes the one-shot PIT mode to behave similarly to mode 0.
> 
> TESTED: using the one-shot PIT mode to calibrate a local apic timer.

Has this been forgotten, or is it not needed anymore?

Thanks,

/mjt

>   hw/timer/i8254_common.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/hw/timer/i8254_common.c b/hw/timer/i8254_common.c
> index 050875b497..9164576ca9 100644
> --- a/hw/timer/i8254_common.c
> +++ b/hw/timer/i8254_common.c
> @@ -52,10 +52,8 @@ int pit_get_out(PITChannelState *s, int64_t current_time)
>       switch (s->mode) {
>       default:
>       case 0:
> -        out = (d >= s->count);
> -        break;
>       case 1:
> -        out = (d < s->count);
> +        out = (d >= s->count);
>           break;
>       case 2:
>           if ((d % s->count) == 0 && d != 0) {
> --
> 2.39.0
> 
> 
> 


