Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A244D826BD0
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 11:49:12 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMnB1-0006CR-RH; Mon, 08 Jan 2024 05:48:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnAy-0006AU-Rp
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:48:12 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMnAx-0001V0-7L
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 05:48:12 -0500
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-40e461c1f44so9209555e9.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 02:48:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704710889; x=1705315689; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t0aTiuaMz8o0TP+/qyURDDSQsFN9DEIV0+fQn4GJy+o=;
 b=TT/2rX38Ys1DZ9JNdVSu7W/ZDzOtV1kiZ8KrOkUiTipzJOcc+j5tjwhgU+ExVWLxWB
 jyw86gElWmJV1OZkoArX3NyLPspKpsmxnstwZuQNqJdH/VN+VVmrfDm2ttuH1lBf7VTk
 7jQ5S5ClRfArH7ouhbakKX1en0Qr9idN/+AUDdWWZ22rl840x/LZSgyPordLXHqGtSQC
 htjsCcSHLeXYGMZoQUTfDFe8k390tBpC6plhwvmCqPihqh7M2ZWCvp5g4tGrZTCJZqBE
 eueX4gjLL3Fr2XzszMTL+pZA2Vx7ZlgejBt/TjylMvS4uQKiD9zi+2nER/k2+L0oOk7+
 mCvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704710889; x=1705315689;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t0aTiuaMz8o0TP+/qyURDDSQsFN9DEIV0+fQn4GJy+o=;
 b=Bu5JOLYa+HoQlTKePYgVmlZO583QLNNyoDnGIs0RxsoS+e3tMkp74wrmmYneE3DBh7
 rZXESkH6bqqUDabbx/BBCBXjmPRcom3mGalnrt0XFlSKF4+oQ4wT6RmqT6tQ13hcDnF2
 sr2NRyJloP8xMNoJKWK1rk6j6vX5HInn2vk1iXDmfxFD29cA0zBhwNz/ShE1BnRxV51H
 1C8oSL5YAWXTwtVMADbwnsCRidIzaQJjJ2MlYiAmJ4e8s1kJfCbhn9QBqR5LfhIhOxGM
 iCcxXX0uqnL8RI+2+7Wk1EhGVyxLrxuitlf+yp+Od16ErrFs5jJGA3apHD5W8HADnyjH
 mI3g==
X-Gm-Message-State: AOJu0YyYOlXCTvFt3CAsVhyNshfCMfBL0Ss9Wu12C4qZOQk4InpGucaD
 zKUfEb93DWYWpvDdkAcISAVWPBDbqsfQhg==
X-Google-Smtp-Source: AGHT+IG3USm6TVnsJ/ElhrDbipFo6ir0u2BuXSr4NctphfmwoXBqYDbX8tDg3JpIL/SDqHMou/Tsxg==
X-Received: by 2002:a05:600c:4595:b0:40d:8785:9595 with SMTP id
 r21-20020a05600c459500b0040d87859595mr1755678wmo.183.1704710889640; 
 Mon, 08 Jan 2024 02:48:09 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 p7-20020a05600c358700b0040d3db8186fsm10671017wmq.5.2024.01.08.02.48.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 02:48:09 -0800 (PST)
Message-ID: <3c7f9788-d819-4c65-8159-3d4a2ba4c38c@linaro.org>
Date: Mon, 8 Jan 2024 14:48:08 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/33] migration: Remove qemu_host_page_size
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-12-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-12-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 1/2/24 05:57, Richard Henderson wrote:
> Replace with the maximum of the real host page size
> and the target page size.  This is an exact replacement.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   migration/ram.c | 22 ++++++++++++++++++----
>   1 file changed, 18 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/ram.c b/migration/ram.c
> index 8c7886ab79..aa3109fca3 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -2936,7 +2936,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>   {
>       RAMState **rsp = opaque;
>       RAMBlock *block;
> -    int ret;
> +    int ret, max_hg_page_size;
>   
>       if (compress_threads_save_setup()) {
>           return -1;
> @@ -2951,6 +2951,12 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>       }
>       (*rsp)->pss[RAM_CHANNEL_PRECOPY].pss_channel = f;
>   
> +    /*
> +     * ??? Mirrors the previous value of qemu_host_page_size,
> +     * but is this really what was intended for the migration?
> +     */
> +    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
> +
>       WITH_RCU_READ_LOCK_GUARD() {
>           qemu_put_be64(f, ram_bytes_total_with_ignored()
>                            | RAM_SAVE_FLAG_MEM_SIZE);
> @@ -2959,8 +2965,8 @@ static int ram_save_setup(QEMUFile *f, void *opaque)
>               qemu_put_byte(f, strlen(block->idstr));
>               qemu_put_buffer(f, (uint8_t *)block->idstr, strlen(block->idstr));
>               qemu_put_be64(f, block->used_length);
> -            if (migrate_postcopy_ram() && block->page_size !=
> -                                          qemu_host_page_size) {
> +            if (migrate_postcopy_ram() &&
> +                block->page_size != max_hg_page_size) {
>                   qemu_put_be64(f, block->page_size);
>               }
>               if (migrate_ignore_shared()) {
> @@ -3794,6 +3800,7 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>       int ret = 0;
>       /* ADVISE is earlier, it shows the source has the postcopy capability on */
>       bool postcopy_advised = migration_incoming_postcopy_advised();
> +    int max_hg_page_size;
>   
>       assert(block);
>   
> @@ -3811,9 +3818,16 @@ static int parse_ramblock(QEMUFile *f, RAMBlock *block, ram_addr_t length)
>               return ret;
>           }
>       }
> +
> +    /*
> +     * ??? Mirrors the previous value of qemu_host_page_size,
> +     * but is this really what was intended for the migration?
> +     */
> +    max_hg_page_size = MAX(qemu_real_host_page_size(), TARGET_PAGE_SIZE);
> +
>       /* For postcopy we need to check hugepage sizes match */
>       if (postcopy_advised && migrate_postcopy_ram() &&
> -        block->page_size != qemu_host_page_size) {
> +        block->page_size != max_hg_page_size) {
>           uint64_t remote_page_size = qemu_get_be64(f);
>           if (remote_page_size != block->page_size) {
>               error_report("Mismatched RAM page size %s "

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

