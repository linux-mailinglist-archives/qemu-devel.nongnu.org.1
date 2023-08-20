Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AD8D781E16
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:21:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjIU-0008MK-VP; Sun, 20 Aug 2023 10:20:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjIS-0008JR-OX
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:20:52 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjIQ-00067U-MU
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:20:52 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-1c4c6717e61so1862127fac.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692541249; x=1693146049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pJnsSCagSfVMaIlcW4ELCtv0XA1S444fz2hjQaUH7SE=;
 b=WVgmx3RUgEar9ecjbw9jznaruc9Bbfi+E24sfE+qqHZ82n9bwnlJpWqosotv675Qz0
 lSd+sxAcIVOmvEkEzrZkPt90nGN3tjzZtS6jdNqzv1bSL1x0iVwtPAhFOrxa7XZ9jQAm
 Q53n/L0GFakBZ16+Pifp0lgDB1aRkQTsQ4KW8/+if1ZdoEQSBIFoDVFP18g0vvJJwHzK
 b7qUUwGmjyi2vw5xbQKUW2iKGI4MZFcIzFkqyN6rGbo8cz/gfHs9QLTm88OmuT9oT3mI
 kWRS5FHYzcUdObdbm+DjgRQmCyg0m2XSnQ3qQFtZBsxgKDQnRU/sy39yFcyw59vXIPhg
 9NHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692541249; x=1693146049;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pJnsSCagSfVMaIlcW4ELCtv0XA1S444fz2hjQaUH7SE=;
 b=eonf4CcerED/+z5hxhmzPMiymk83f90LcVLl3MoT0jZIfo7TcgEw/ju6KWfOBYtAcy
 S8h22CT/VT7gMO5srZir6lBfcHdkCfnNRwvGD92a7sbF1wTgZ6LgI9VwZbUhQnzmkFWX
 sUvAy978Vj/+sSCS/QGoJN46LaJNraBVus8jRApk+TvVHeRdC2HrbkEu97kVC0+afPlM
 8PA+axq3OGs/MMV2+3FqK0xSUIUPjRZ0FNHr39UwixE/c9PQ96CIEqp+ZV2321ICy/DD
 MMVcAUCGmM5ktSEvEuuqGQS3RzvM4at1HNZMcO50YiEjKoxnbLA3yvIVP2vdNn5OoPvE
 k5uA==
X-Gm-Message-State: AOJu0Ywr3MkkGyROp3idJlXs0uMVguhxw5uLtKyZHGEmYHw1FGyQdw1e
 ZQyfNRhgTmoBNleu0R1Waxuo9Q==
X-Google-Smtp-Source: AGHT+IERHmDhpiSY08iCI4dtoMiNYID+7XVn353Raucq8fnyunEmtu52bavFtD5VZBWv75B0WP1TvA==
X-Received: by 2002:a05:6870:4712:b0:1b0:3075:2f9d with SMTP id
 b18-20020a056870471200b001b030752f9dmr6501639oaq.34.1692541248928; 
 Sun, 20 Aug 2023 07:20:48 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 71-20020a17090a09cd00b0026b70d2a8a2sm4924116pjo.29.2023.08.20.07.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:20:48 -0700 (PDT)
Message-ID: <11b4c59a-7fca-ec9f-428c-35dd4b02beda@linaro.org>
Date: Sun, 20 Aug 2023 07:20:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 10/22] Implement shmid_ds conversion between host and
 target.
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-11-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-11-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
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

On 8/19/23 02:47, Karim Taha wrote:
> +    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
> +        return -TARGET_EFAULT;
> +    }
> +    if (host_to_target_ipc_perm(target_addr, &(host_sd->shm_perm))) {
> +        return -TARGET_EFAULT;
> +    }

While it works, ideally you wouldn't double-lock a memory range, once here and once in 
host_to_target_ipc_perm.  You could split out the middle of the function as 
host_to_target_ipc_perm__locked.

Anyway,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

