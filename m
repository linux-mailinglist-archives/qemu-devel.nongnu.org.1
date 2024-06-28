Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B95891B8F3
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jun 2024 09:51:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sN6Nz-0006pf-NK; Fri, 28 Jun 2024 03:51:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Nv-0006l5-2l
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:51:08 -0400
Received: from mail.ozlabs.org ([2404:9400:2221:ea00::3])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <SRS0=GU6n=N6=kaod.org=clg@ozlabs.org>)
 id 1sN6Nt-0006mj-Bq
 for qemu-devel@nongnu.org; Fri, 28 Jun 2024 03:51:06 -0400
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
 by gandalf.ozlabs.org (Postfix) with ESMTP id 4W9SKz2FdHz4w2K;
 Fri, 28 Jun 2024 17:51:03 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4W9SKy2JkXz4w2H;
 Fri, 28 Jun 2024 17:51:01 +1000 (AEST)
Message-ID: <c663b7d1-97b8-442e-b39a-5dd9caff092a@kaod.org>
Date: Fri, 28 Jun 2024 09:50:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v42 30/98] hw/sd/sdcard: Duplicate WRITE_SINGLE_BLOCK /
 WRITE_MULTIPLE_BLOCK cases
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240628070216.92609-1-philmd@linaro.org>
 <20240628070216.92609-31-philmd@linaro.org>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
In-Reply-To: <20240628070216.92609-31-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2404:9400:2221:ea00::3;
 envelope-from=SRS0=GU6n=N6=kaod.org=clg@ozlabs.org; helo=mail.ozlabs.org
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_MED=-2.3,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 6/28/24 9:01 AM, Philippe Mathieu-Daudé wrote:
> In order to modify the WRITE_SINGLE_BLOCK case in the
> next commit, duplicate it first.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.


> ---
>   hw/sd/sd.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
> 
> diff --git a/hw/sd/sd.c b/hw/sd/sd.c
> index 690a3f275e..5dbfc8000b 100644
> --- a/hw/sd/sd.c
> +++ b/hw/sd/sd.c
> @@ -1461,6 +1461,35 @@ static sd_rsp_type_t sd_normal_command(SDState *sd, SDRequest req)
>   
>       /* Block write commands (Class 4) */
>       case 24:  /* CMD24:  WRITE_SINGLE_BLOCK */
> +        addr = sd_req_get_address(sd, req);
> +        switch (sd->state) {
> +        case sd_transfer_state:
> +
> +            if (!address_in_range(sd, "WRITE_SINGLE_BLOCK", addr,
> +                                  sd->blk_len)) {
> +                return sd_r1;
> +            }
> +
> +            sd->state = sd_receivingdata_state;
> +            sd->data_start = addr;
> +            sd->data_offset = 0;
> +
> +            if (sd->size <= SDSC_MAX_CAPACITY) {
> +                if (sd_wp_addr(sd, sd->data_start)) {
> +                    sd->card_status |= WP_VIOLATION;
> +                }
> +            }
> +            if (sd->csd[14] & 0x30) {
> +                sd->card_status |= WP_VIOLATION;
> +            }
> +            sd->blk_written = 0;
> +            return sd_r1;
> +
> +        default:
> +            break;
> +        }
> +        break;
> +
>       case 25:  /* CMD25:  WRITE_MULTIPLE_BLOCK */
>           addr = sd_req_get_address(sd, req);
>           switch (sd->state) {


