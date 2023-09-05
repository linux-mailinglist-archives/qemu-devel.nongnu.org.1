Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C893F791FFC
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 03:45:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdL6b-00064d-Ms; Mon, 04 Sep 2023 21:43:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdL6Z-00063V-Pw
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 21:43:47 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qdL6X-0008JK-6I
 for qemu-devel@nongnu.org; Mon, 04 Sep 2023 21:43:47 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b9e478e122so1657404a34.1
 for <qemu-devel@nongnu.org>; Mon, 04 Sep 2023 18:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693878223; x=1694483023; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LY+W9KfuuYShEFQz81qZQBg2mi4f5TEzyLErCP6gn5k=;
 b=zsQh6pyeBxnCe3uX2E2SN2ERF/BLKZ/JEcMQg4aLT8bmwIIQclUxyin53Vuj0HVkQ7
 TxWYwX9kyCe3UwcHRIVsBz6sPJ11zp6N7+19Cu241zvh8UWFYDy8i53MdRIGEsX5i2A1
 jUhQccgjv/Ndh9hn1QuZaVRO/iGQtlrcWS/ERrJ6/PsK41GA9zo13rCctHSzsV9ZJ1Aj
 ZzgfXC5/9H4GdJojql7HIEGet84HBD3h2BQX2IuxeyWp/w848RRv5m3JAGKDCcPTdvwE
 PZNu+PBfZtidB7k2oISwA5Ak8Xwg8g9ohNcR6NJsJLwe60FAykcMzJRx64c8XqG84/Gg
 EUrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693878223; x=1694483023;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LY+W9KfuuYShEFQz81qZQBg2mi4f5TEzyLErCP6gn5k=;
 b=AdsNtl5G7QL2ncMPa4aqxNAaYSU8WUhiMk8S1436JJWdYzGvC9/x4c04VuDQPJ2Vcv
 nQDRs0bJfO8afOmBogeTn87c6kobM5B2IzsL3keyRRXm3wFsxMyHMNyDnYlQQZThxOFj
 ObA2j8dG6Vd3aK7YTttmZLPSUlj5+v9Tjmv/05B33VPvv6DLVlnsVBgvs74infv7FhXE
 7sHYGpBidMMPgeWpEshN2sZmh6kvtJlZtDceG3+xsoEyz6RrTtRlhpxWDGQQr+T2Xv6q
 fwW8K/4V5JAWiGYXn5X5rx2woI4IE+PZIr9vqBpDE1fC+XpJ44GhlWwwqFCaGNiJtWW7
 47ug==
X-Gm-Message-State: AOJu0Yx9KoXHGgx8XlifaxpyfcZaEMF/g78rXsvGafKHjpAlWarxBtRn
 VZ22yB+ziKQGvWJzpQqIj3z/Cw==
X-Google-Smtp-Source: AGHT+IEGxnTr4QlrsQQ8bMTdPqsKBduByVvm22+xqLWAUNPxjZsqJBO8e7QkYInG0n2tHdRi1rRmZQ==
X-Received: by 2002:a05:6358:7248:b0:134:c37f:4b64 with SMTP id
 i8-20020a056358724800b00134c37f4b64mr11107981rwa.30.1693878223648; 
 Mon, 04 Sep 2023 18:43:43 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 27-20020a17090a031b00b002680b2d2ab6sm10461800pje.19.2023.09.04.18.43.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Sep 2023 18:43:42 -0700 (PDT)
Message-ID: <1cef49ab-9c64-6b12-c5b8-f7b0986ca6d7@linaro.org>
Date: Mon, 4 Sep 2023 18:43:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 10/22] Implement shmid_ds conversion between host and
 target.
To: Kariiem Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-11-kariem.taha2.7@gmail.com>
 <11b4c59a-7fca-ec9f-428c-35dd4b02beda@linaro.org> <87sf7vlk56.fsf@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sf7vlk56.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 9/3/23 01:45, Kariiem Taha wrote:
> Richard Henderson <richard.henderson@linaro.org> writes:
> 
>> On 8/19/23 02:47, Karim Taha wrote:
>>> +    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
>>> +        return -TARGET_EFAULT;
>>> +    }
>>> +    if (host_to_target_ipc_perm(target_addr, &(host_sd->shm_perm))) {
>>> +        return -TARGET_EFAULT;
>>> +    }
>>
>> While it works, ideally you wouldn't double-lock a memory range, once here and once in
>> host_to_target_ipc_perm.  You could split out the middle of the function as
>> host_to_target_ipc_perm__locked.
> 
> Hi Richard,
> 
> Can you please verify the correctness of the following refactoring?
>      void host_to_target_ipc_perm__locked(abi_ulong target_addr,
>              struct ipc_perm *host_ip)
>      {
>          struct target_ipc_perm *target_ip = g2h_untagged(target_addr);
>          __put_user(host_ip->cuid, &target_ip->cuid);
>          __put_user(host_ip->cgid, &target_ip->cgid);
>          __put_user(host_ip->uid, &target_ip->uid);
>          __put_user(host_ip->gid, &target_ip->gid);
>          __put_user(host_ip->mode, &target_ip->mode);
>          __put_user(host_ip->seq, &target_ip->seq);
>          __put_user(host_ip->key, &target_ip->key);
>      }
> 
>      abi_long host_to_target_shmid_ds(abi_ulong target_addr,
>              struct shmid_ds *host_sd)
>      {
>          struct target_shmid_ds *target_sd;
>          target_sd = lock_user(VERIFY_WRITE, target_addr, sizeof(*target_sd), 0);
>          if (!target_sd){
>              return -TARGET_EFAULT;
>          }
> 
>          host_to_target_ipc_perm__locked(target_addr, &(host_sd->shm_perm));

No.  You'd pass &target_sd->shm_perm, not target_addr, and you don't use g2h at all.


r~


