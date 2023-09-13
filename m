Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF4E79F4AA
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 00:05:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgXy2-0000ay-3q; Wed, 13 Sep 2023 18:04:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgXy0-0000an-JY
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:04:12 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qgXxy-0004CV-O7
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 18:04:12 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-401b3ea0656so3177295e9.0
 for <qemu-devel@nongnu.org>; Wed, 13 Sep 2023 15:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1694642648; x=1695247448; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=9Nh9Ku9G0jLAsAlwqX6aZx9WkNK2QitNUWZ5FlfLWL0=;
 b=RgKuKXfm/qeSd3yVgjPJMqJdnTg3naWkbh5vwPrl7DBqm+q5EgKFb9xUCkqJp6eYEW
 MsZvmdBh6bnE+qPsu+V48HHpaTdsKayScV1jX0xNhgCHaTy5J+ERBMr4BS/l9fzBBUWW
 VWs/UcL+VNx4+hstNUb+A6UM3EQFB2dNdTFGQj05xp56DtNlO5oQHrTy/iOGvSIYvwJp
 QCmjfKWaK97JEpBsGCCI9Pd7jscoS7GLkj8mmtg93T03Ky97ZLN4PsrUFBLazg3ks4aQ
 Lhnypbuw34oJN3BmqFfO9brKZekBWoFoaf+BM5l6rshBY1vmo5dFFOmPL+guEUrF0tEW
 axrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694642648; x=1695247448;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9Nh9Ku9G0jLAsAlwqX6aZx9WkNK2QitNUWZ5FlfLWL0=;
 b=q7uW4SSkNEPYMRW+UwJDVpL1h9zNZIX1IQEEbFYw3F9CdMAl6VJfH3xMmzC197A/Am
 vaPKenK+GOqOymTuP7LKaeGSxQQvu2APgEPLMO9k5e0wcUi+32desaC5WGpuNfIZXKKF
 HOribACoeZBtTC8BVwZnWk3sHKe4nytkj2dXsg3/pTP6OCR25nxI54Pky2+4x25jGYnY
 sbdTGhB0pEXE0D+nozm8AK0KXZKHGB08dGtwDIdIbZIzIjs12vNXpcoVkD8n8BKX2oWE
 I8HiEFJqIw9Q2vKLnDx0vKjP9QjKkfYhZFHORCPZQrXeCPsenhQtTLoumqZP1cdngPFw
 N0LA==
X-Gm-Message-State: AOJu0YzCcqqPX+jTx3FI7oRm6QSqeAMqRbXA1s9idPMPCTIIZmHeEVhJ
 XIo3cFcmCDoWCCnKL1q/vxA=
X-Google-Smtp-Source: AGHT+IHPKuxYQZRoo0ZkgLcpoGU6/eD8lzSNgaDN2UAw2ZdUS/P2zjHTyE9eE6Zh6eL9F36McCSkFw==
X-Received: by 2002:a7b:c4d8:0:b0:401:b3a5:ebf8 with SMTP id
 g24-20020a7bc4d8000000b00401b3a5ebf8mr2903009wmk.16.1694642647956; 
 Wed, 13 Sep 2023 15:04:07 -0700 (PDT)
Received: from karim ([197.39.126.129]) by smtp.gmail.com with ESMTPSA id
 26-20020a05600c231a00b003fe1a96845bsm3126686wmo.2.2023.09.13.15.04.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 Sep 2023 15:04:07 -0700 (PDT)
From: Karim Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
Subject: Re: [PATCH v3 17/23] bsd-user: Implement mincore(2)
In-Reply-To: <d019b498-d0ef-e006-a0c3-a2dfa29a5d35@linaro.org>
References: <20230909193704.1827-1-kariem.taha2.7@gmail.com>
 <20230909193704.1827-18-kariem.taha2.7@gmail.com>
 <d019b498-d0ef-e006-a0c3-a2dfa29a5d35@linaro.org>
Date: Thu, 14 Sep 2023 01:02:41 +0300
Message-ID: <874jjx91fi.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Richard Henderson <richard.henderson@linaro.org> wrote:

> On 9/9/23 12:36, Karim Taha wrote:
>> From: Stacey Son <sson@FreeBSD.org>
>> 
>> Signed-off-by: Stacey Son <sson@FreeBSD.org>
>> Signed-off-by: Karim Taha <kariem.taha2.7@gmail.com>
>> ---
>>   bsd-user/bsd-mem.h            | 22 ++++++++++++++++++++++
>>   bsd-user/freebsd/os-syscall.c |  4 ++++
>>   2 files changed, 26 insertions(+)
>> 
>> diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
>> index 0e16051418..1dabbe36e6 100644
>> --- a/bsd-user/bsd-mem.h
>> +++ b/bsd-user/bsd-mem.h
>> @@ -189,4 +189,26 @@ static inline abi_long do_bsd_minherit(abi_long addr, abi_long len,
>>       return get_errno(minherit(g2h_untagged(addr), len, inherit));
>>   }
>>   
>> +/* mincore(2) */
>> +static inline abi_long do_bsd_mincore(abi_ulong target_addr, abi_ulong len,
>> +        abi_ulong target_vec)
>> +{
>> +    abi_long ret;
>> +    void *p;
>> +    abi_ulong vec_len = DIV_ROUND_UP(len,TARGET_PAGE_SIZE);
>> +
>> +    if (!guest_range_valid_untagged(target_addr,len) || !page_check_range(target_addr, len, PAGE_VALID)) {
>> +        return -TARGET_EFAULT;
>> +    }
>> +
>> +    p = lock_user(VERIFY_WRITE, target_vec, vec_len, 0);
>> +    if (p == NULL) {
>> +        return -TARGET_EFAULT;
>> +    }
>> +    ret = get_errno(mincore(g2h_untagged(target_addr), len, p));
>> +    unlock_user(p, target_vec, 0);
>
> You don't need the lock/unlock_user at all.  It is wrongly checking for WRITE.
>
>
> r~
>
AFAIU, the host is writing to the target's memory, right?

So this is similar to IPC_STAT case from the shmctl(2) syscall,
where host_to_target_shmid_ds, which has a `lock_user(VERIFY_WRITE,...)`, writes the struct `dsarg` set by
the host syscall `shmctl` at the address `buff` in the target memory.

Is it correct if the host writes to the target without
locking? for example, `mincore(g2h_untagged(target_addr), len, p)` can be done
without locking.

The locking was suggested by you in response to the v1 implementation
which used `lock_user_string`.

>> +
>> +    return ret;
>> +}
>> +
>>   #endif /* BSD_USER_BSD_MEM_H */
>> diff --git a/bsd-user/freebsd/os-syscall.c b/bsd-user/freebsd/os-syscall.c
>> index f5d60cf902..8d1cf3b35c 100644
>> --- a/bsd-user/freebsd/os-syscall.c
>> +++ b/bsd-user/freebsd/os-syscall.c
>> @@ -527,6 +527,10 @@ static abi_long freebsd_syscall(void *cpu_env, int num, abi_long arg1,
>>           ret = do_bsd_minherit(arg1, arg2, arg3);
>>           break;
>>   
>> +    case TARGET_FREEBSD_NR_mincore: /* mincore(2) */
p>> +        ret = do_bsd_mincore(arg1, arg2, arg3);
>> +        break;
>> +
>>   #if defined(__FreeBSD_version) && __FreeBSD_version >= 1300048
>>       case TARGET_FREEBSD_NR_shm_open2: /* shm_open2(2) */
>>           ret = do_freebsd_shm_open2(arg1, arg2, arg3, arg4, arg5);

