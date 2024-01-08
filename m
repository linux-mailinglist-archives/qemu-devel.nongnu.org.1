Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C338269E7
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 09:56:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMlOu-0002e3-0S; Mon, 08 Jan 2024 03:54:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlOs-0002ds-0b
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:54:26 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1rMlOq-0000Il-Cl
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 03:54:25 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3376ead25e1so249199f8f.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 00:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704704062; x=1705308862; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fkzhTKhg+6/GqPvJ12eM9pPHPs8EEAwPEtZwFcA1zGQ=;
 b=v4lvWPc9BsF0y+iCxhqkImCQOwKTHgZgOQ8/61Aa4XikHcrdoIiuYdhkIdAx8+LBq7
 AVp7at9hv6YUQG7qO/tHdsJ/07avAjWQDWVgTtRDTD2AXiI0HoKWLfJjLJiab16YhX9w
 Fc2/AbJAXKzdfYQ1pngLCf3BFbdYHxd3vOfBxcbXA567Vd+gO9+UprQj/1EAMyL5IlvC
 G28kOXmBTba9EzLX8oYUnfOkH0eZ72QysPTAwCmph7RPcqEl+tio/Fj8N6shmt+DMFmu
 lqQbHt0Lv0wD24lZyfjbMEHTAZeBjeikL+D28BaCgBfgpG2OtGnW7hrFUCM5dOK4p4DJ
 Immw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704704062; x=1705308862;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fkzhTKhg+6/GqPvJ12eM9pPHPs8EEAwPEtZwFcA1zGQ=;
 b=nRECFX8o3qBeZPmZsM3D+aArB5aDwzK0RIU0Ao1lhy2JF+MrY9uY4jAPqZI+XqPFH4
 iMcm2HtGnlKKOspzEaLJHM50RDGU6B758fHbf42WodTYuTqpJfaSdz2avQ6bqGoz8jAS
 nz5NZb6v+p4ltKjH0gqjuyaKjNr7vZff9TkLjh1TPSV4+sNfLe7xmNQWLYp+E1m8ZS2Q
 KiGWDyHL2tXFCH+KL09AVUbxpI5q7eEw57ytvRImV7mB9AUVvf99buprjb7f+Om7X3TW
 FomQMn0hutt/Vu711nzTKc9cUW5la8Vxj5Jn5uFdP70ZxFP4HYOY9bfne7Zo1iDGH/hr
 E45Q==
X-Gm-Message-State: AOJu0YzXtO7hBjXWwOb5SDzrg9+SBF0ohZhH2FcjaON3Va2gtmU2BxTJ
 5Sid4Laq8I52tlXTelgEIkovN586HJIWXg==
X-Google-Smtp-Source: AGHT+IGzRVP13j8biYhdebsamf+LjY7Bd+/0ChHZ7vgEGz5c+FbUtkE77KFUSlaWcgp8PBEZPBk0Ag==
X-Received: by 2002:adf:f0cc:0:b0:333:2fd2:2f08 with SMTP id
 x12-20020adff0cc000000b003332fd22f08mr1467303wro.129.1704704062218; 
 Mon, 08 Jan 2024 00:54:22 -0800 (PST)
Received: from [192.168.1.24] ([102.35.208.160])
 by smtp.gmail.com with ESMTPSA id
 t14-20020adfe44e000000b0033740e109adsm7234714wrm.75.2024.01.08.00.54.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 00:54:21 -0800 (PST)
Message-ID: <718d9ce9-e8b7-49ea-bfa4-57c85ad7f89f@linaro.org>
Date: Mon, 8 Jan 2024 12:54:19 +0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/33] linux-user: Adjust SVr4 NULL page mapping
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240102015808.132373-1-richard.henderson@linaro.org>
 <20240102015808.132373-3-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20240102015808.132373-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wr1-x433.google.com
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
> Use TARGET_PAGE_SIZE and MAP_FIXED_NOREPLACE.
> 
> We really should be attending to this earlier during
> probe_guest_base, as well as better detection and
> emulation of various Linux personalities.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   linux-user/elfload.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/linux-user/elfload.c b/linux-user/elfload.c
> index cf9e74468b..f3c1e0fb64 100644
> --- a/linux-user/elfload.c
> +++ b/linux-user/elfload.c
> @@ -3911,8 +3911,9 @@ int load_elf_binary(struct linux_binprm *bprm, struct image_info *info)
>                  and some applications "depend" upon this behavior.  Since
>                  we do not have the power to recompile these, we emulate
>                  the SVr4 behavior.  Sigh.  */
> -            target_mmap(0, qemu_host_page_size, PROT_READ | PROT_EXEC,
> -                        MAP_FIXED | MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +            target_mmap(0, TARGET_PAGE_SIZE, PROT_READ | PROT_EXEC,
> +                        MAP_FIXED_NOREPLACE | MAP_PRIVATE | MAP_ANONYMOUS,
> +                        -1, 0);
>           }
>   #ifdef TARGET_MIPS
>           info->interp_fp_abi = interp_info.fp_abi;

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

