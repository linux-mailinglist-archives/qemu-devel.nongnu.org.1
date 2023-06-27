Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C7573F505
	for <lists+qemu-devel@lfdr.de>; Tue, 27 Jun 2023 09:01:08 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qE2gn-0002Io-Pr; Tue, 27 Jun 2023 03:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qE2gl-0002H7-6k
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qE2gj-0006CS-1q
 for qemu-devel@nongnu.org; Tue, 27 Jun 2023 03:00:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687849231;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lYcF3+P1zCPxumvuID3WLXhdl7cW70OI4glzMlXgk8Y=;
 b=fDA2sHRo/qZ6x7J2RMqAgTYqhAjzvLE7lec7cPvlmwTVvkxCLujznjO4Myk0rZd6Mfdg1Z
 UW2P7h1LhAk8FiO2WXtHHPvfQ+9PrIvg/3Qt6lnPjlziC19L6fMUYKalBaRwvETVLTnY1r
 jmREp+R46jzh17NY6gEetfyUE7qq1Tw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-368-4yzxIORiPluYzwu2Yr1Sdg-1; Tue, 27 Jun 2023 03:00:29 -0400
X-MC-Unique: 4yzxIORiPluYzwu2Yr1Sdg-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-30932d15a30so3006195f8f.1
 for <qemu-devel@nongnu.org>; Tue, 27 Jun 2023 00:00:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687849228; x=1690441228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lYcF3+P1zCPxumvuID3WLXhdl7cW70OI4glzMlXgk8Y=;
 b=akJIbCKfGTVQAVe64Pbq9WzAPUB12QkEAp1Av2FGouCdpaWbwndiqUIcKIcOsuIvYh
 bobTQ1gAOVNpCFxB1je1acqcmoTWtn9mOnoco/GV1Qe2KX2uWW7b6jMOYIGGJtM7Bpxf
 zNv4tFIrQC3V5MOf1718C85abSrd6spGhHp4eww2YvOd7hdtYoYH+28S4ZP0QA0RsLoo
 hiVPjaFPJYMRlniN3Tdt9XoO7OzGNqJ/KMCxNVbE4DB6oH3DA0xw4YmlFjK02i/sQ/v+
 6JBg14Jm+7+pqcV9R35OzTRLknRuafkbBcxo2i1hrkeaVNrx/Bwf0BcSqShZhIRCtfbE
 OwCw==
X-Gm-Message-State: AC+VfDw3XjppSqObpNox4vwjmO7zMTLTFC6u31LzhvmLy7fsjFmAhUge
 BtYPLmHFHR6SH2NdkQbOfbmjTazxYeQ3tTJP0abt5kRMplBMNlVe7hHAV9dI6+SttUjPenRrflR
 jfPUedaREQaKJRC0=
X-Received: by 2002:adf:fe43:0:b0:313:ec16:b243 with SMTP id
 m3-20020adffe43000000b00313ec16b243mr6756984wrs.47.1687849228235; 
 Tue, 27 Jun 2023 00:00:28 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6R8Wd/UgUTmWUAbfNASZX6eFsESefiBs8mdSI7/54GvinnpZBNr/v8DfZhH0fZMU+KRpw0JQ==
X-Received: by 2002:adf:fe43:0:b0:313:ec16:b243 with SMTP id
 m3-20020adffe43000000b00313ec16b243mr6756970wrs.47.1687849227973; 
 Tue, 27 Jun 2023 00:00:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 w7-20020a5d4047000000b003063772a55bsm9426660wrp.61.2023.06.27.00.00.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Jun 2023 00:00:27 -0700 (PDT)
Message-ID: <8edd4b7f-5c6b-db99-a838-484cb49bcb27@redhat.com>
Date: Tue, 27 Jun 2023 09:00:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] icount: don't adjust virtual time backwards after warp
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-stable <qemu-stable@nongnu.org>
References: <20230627061406.241847-1-npiggin@gmail.com>
Content-Language: en-US
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230627061406.241847-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 6/27/23 08:14, Nicholas Piggin wrote:
> The icount-based QEMU_CLOCK_VIRTUAL runs ahead of the RT clock at times.
> When warping, it is possible it is still ahead at the end of the warp,
> which causes icount adaptive mode to adjust it backward. This can result
> in the machine observing time going backwards.
> 
> Prevent this by clamping adaptive adjustment to 0 at minimum.

Queued, thanks.

Paolo

> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   softmmu/icount.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/softmmu/icount.c b/softmmu/icount.c
> index 4504433e16..486ea7ef41 100644
> --- a/softmmu/icount.c
> +++ b/softmmu/icount.c
> @@ -259,11 +259,16 @@ static void icount_warp_rt(void)
>           warp_delta = clock - timers_state.vm_clock_warp_start;
>           if (icount_enabled() == 2) {
>               /*
> -             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too
> -             * far ahead of real time.
> +             * In adaptive mode, do not let QEMU_CLOCK_VIRTUAL run too far
> +             * ahead of real time (it might already be ahead so careful not
> +             * to go backwards).
>                */
>               int64_t cur_icount = icount_get_locked();
>               int64_t delta = clock - cur_icount;
> +
> +            if (delta < 0) {
> +                delta = 0;
> +            }
>               warp_delta = MIN(warp_delta, delta);
>           }
>           qatomic_set_i64(&timers_state.qemu_icount_bias,


