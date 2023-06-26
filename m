Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BFD7573D7B6
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:21:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfax-00081U-EX; Mon, 26 Jun 2023 02:21:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfaa-0007u6-7t; Mon, 26 Jun 2023 02:20:48 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3]
 helo=gandalf.ozlabs.org)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org>)
 id 1qDfaX-00054G-NU; Mon, 26 Jun 2023 02:20:39 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4QqHlQ5LjVz4wb6;
 Mon, 26 Jun 2023 16:20:34 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits))
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4QqHlM6pDzz4wb3;
 Mon, 26 Jun 2023 16:20:31 +1000 (AEST)
Message-ID: <ea305c7b-503a-2e63-3c0a-9e4e842921d0@kaod.org>
Date: Mon, 26 Jun 2023 08:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v7 9/9] hw/net: ftgmac100: Drop the small packet check in
 the receive path
Content-Language: en-US
To: Bin Meng <bmeng@tinylab.org>, Jason Wang <jasowang@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Andrew Jeffery <andrew@aj.id.au>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20230625015321.77987-1-bmeng@tinylab.org>
 <20230625015321.77987-10-bmeng@tinylab.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20230625015321.77987-10-bmeng@tinylab.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=U+Ap=CO=kaod.org=clg@ozlabs.org; helo=gandalf.ozlabs.org
X-Spam_score_int: -40
X-Spam_score: -4.1
X-Spam_bar: ----
X-Spam_report: (-4.1 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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

On 6/25/23 03:53, Bin Meng wrote:
> Now that we have implemented unified short frames padding in the
> QEMU networking codes, the small packet check logic in the receive
> path is no longer needed.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Bin Meng <bmeng@tinylab.org>

Reviewed-by: Cédric Le Goater <clg@kaod.org>

Thanks Bin,

C.


> 
> ---
> 
> Changes in v7:
> - new patch: "hw/net: ftgmac100: Drop the small packet check in the receive path"
> 
>   hw/net/ftgmac100.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
> diff --git a/hw/net/ftgmac100.c b/hw/net/ftgmac100.c
> index d3bf14be53..702b001be2 100644
> --- a/hw/net/ftgmac100.c
> +++ b/hw/net/ftgmac100.c
> @@ -968,14 +968,6 @@ static ssize_t ftgmac100_receive(NetClientState *nc, const uint8_t *buf,
>           return -1;
>       }
>   
> -    /* TODO : Pad to minimum Ethernet frame length */
> -    /* handle small packets.  */
> -    if (size < 10) {
> -        qemu_log_mask(LOG_GUEST_ERROR, "%s: dropped frame of %zd bytes\n",
> -                      __func__, size);
> -        return size;
> -    }
> -
>       if (!ftgmac100_filter(s, buf, size)) {
>           return size;
>       }


