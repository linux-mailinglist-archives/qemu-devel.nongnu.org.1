Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5172D790B46
	for <lists+qemu-devel@lfdr.de>; Sun,  3 Sep 2023 10:48:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qcilW-0008Da-4e; Sun, 03 Sep 2023 04:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qcilT-0008Bg-J5
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 04:47:27 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <kariem.taha2.7@gmail.com>)
 id 1qcilR-0007XL-BO
 for qemu-devel@nongnu.org; Sun, 03 Sep 2023 04:47:27 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-500a398cda5so881420e87.0
 for <qemu-devel@nongnu.org>; Sun, 03 Sep 2023 01:47:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1693730843; x=1694335643; darn=nongnu.org;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=7pHb6PaK3SY0yZiCttfJw84LyOOmMPCUvTiPy6cgDt8=;
 b=hsrpcuJ0u4FwAV3sh7Zh/Ns1MZkapBQeY42AZxNULGKCfSETk7/5bJxoohZasae4/h
 UeuknHzqEwT+9VfOpIXtaU6C9fVJkVQ4e/buEpYgUdpJMBgVwxnu7M6+QgYwwvpTw9I3
 cedB4BEro7mOdEc/JADPs/oEXOhb2ZRG4H1ceSl/WIJ4eP06MSChpIaEiDc6rd84djyu
 kHDGorYXMP+vUB8JV16mFIFhCJ0CDjoY6DjRSZZOCMR7zpUXL0mCpPtrQx/bAnucYGHD
 +am4zpGtPJYdDimNd6H49b58NLmRqQ8wKh3ig0R7o4AtPWmCBN10D4OX7YAhnQDe5mrx
 atvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693730843; x=1694335643;
 h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7pHb6PaK3SY0yZiCttfJw84LyOOmMPCUvTiPy6cgDt8=;
 b=LxyPQTATAOMYC48c36qxDHRSBEFsBLFnq0vBOVOSdLUr6cBwZAFk4hafUpr/Ko1/GH
 A2+l/Wv37PZU+pXtUZhBRH31bRz9Xn85VCWj1qte2nT5F7AnqG36GJevahZRMM8pKzho
 TDxBCtabKgWE8XxMT05DZVnmkKU5Cfl+O7ogzLt205P/VFIIc3ws8eicCqnhHzt9nfx9
 O2rlg0y6/rQ3j+F1jDW6VKXYgl2b88da+zWqBJdFhLcoDlogNh389Zz5kt3zQr4OzQjA
 LP4Jq4PizWiJ/CothGt/RTKj2b4QmXeUhKT1Vaj+9+sSuH2KU+27GK8/MRXX8OvKYItc
 xQPQ==
X-Gm-Message-State: AOJu0YxFXoGzOpEZB1PXNUziWl/cB14QQIDFAQ+IjDaLtyIJnBweZnL/
 3hv6zWZxfY3Hg2jiX+yQMzw=
X-Google-Smtp-Source: AGHT+IH1d4heQD0uZH4+33Cff/eybdpJHvSkkYnfs2PmyMK/8OiRppL1NDhKfhShyMOjn/uGfd3ljQ==
X-Received: by 2002:a05:6512:234d:b0:4fd:fd97:a77b with SMTP id
 p13-20020a056512234d00b004fdfd97a77bmr5157132lfu.50.1693730843032; 
 Sun, 03 Sep 2023 01:47:23 -0700 (PDT)
Received: from karim ([197.39.197.201]) by smtp.gmail.com with ESMTPSA id
 l8-20020a05600c1d0800b003fef6881350sm10804264wms.25.2023.09.03.01.47.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Sep 2023 01:47:22 -0700 (PDT)
From: Kariiem Taha <kariem.taha2.7@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Stacey Son <sson@FreeBSD.org>
Subject: Re: [PATCH 10/22] Implement shmid_ds conversion between host and
 target.
In-Reply-To: <11b4c59a-7fca-ec9f-428c-35dd4b02beda@linaro.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-11-kariem.taha2.7@gmail.com>
 <11b4c59a-7fca-ec9f-428c-35dd4b02beda@linaro.org>
Date: Sun, 03 Sep 2023 11:45:57 +0300
Message-ID: <87sf7vlk56.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=kariem.taha2.7@gmail.com; helo=mail-lf1-x12a.google.com
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

Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/19/23 02:47, Karim Taha wrote:
>> +    if (!lock_user_struct(VERIFY_WRITE, target_sd, target_addr, 0)) {
>> +        return -TARGET_EFAULT;
>> +    }
>> +    if (host_to_target_ipc_perm(target_addr, &(host_sd->shm_perm))) {
>> +        return -TARGET_EFAULT;
>> +    }
>
> While it works, ideally you wouldn't double-lock a memory range, once here and once in 
> host_to_target_ipc_perm.  You could split out the middle of the function as 
> host_to_target_ipc_perm__locked.

Hi Richard,

Can you please verify the correctness of the following refactoring?
    void host_to_target_ipc_perm__locked(abi_ulong target_addr,
            struct ipc_perm *host_ip)
    {
        struct target_ipc_perm *target_ip = g2h_untagged(target_addr);
        __put_user(host_ip->cuid, &target_ip->cuid);
        __put_user(host_ip->cgid, &target_ip->cgid);
        __put_user(host_ip->uid, &target_ip->uid);
        __put_user(host_ip->gid, &target_ip->gid);
        __put_user(host_ip->mode, &target_ip->mode);
        __put_user(host_ip->seq, &target_ip->seq);
        __put_user(host_ip->key, &target_ip->key);
    }

    abi_long host_to_target_shmid_ds(abi_ulong target_addr,
            struct shmid_ds *host_sd)
    {
        struct target_shmid_ds *target_sd;
        target_sd = lock_user(VERIFY_WRITE, target_addr, sizeof(*target_sd), 0);
        if (!target_sd){
            return -TARGET_EFAULT;
        }

        host_to_target_ipc_perm__locked(target_addr, &(host_sd->shm_perm));
        __put_user(host_sd->shm_segsz, &target_sd->shm_segsz);
        __put_user(host_sd->shm_lpid, &target_sd->shm_lpid);
        __put_user(host_sd->shm_cpid, &target_sd->shm_cpid);
        __put_user(host_sd->shm_nattch, &target_sd->shm_nattch);
        __put_user(host_sd->shm_atime, &target_sd->shm_atime);
        __put_user(host_sd->shm_dtime, &target_sd->shm_dtime);
        __put_user(host_sd->shm_ctime, &target_sd->shm_ctime);
        unlock_user_struct(target_sd, target_addr, 1);

        return 0;
    }

As far as I understood the `page_check_range` function, defined at
accel/tcg/user-exec.c::523:

-The locked range is (target_addr, target_addr + sizeof(target_ipc_perm) -1) in case of
     host_to_target_ipc_perm function.

-The locked range is (target_addr, taregt_addr + sizeof(target_shmid_ds) -1) in case of
      host_to_target_shmid_ds function.

Since `host_to_target_shmid_ds` struct has larger size, in the original
code, is the sucess of the first lock guarantees the sucess of the
second?

If I got it wrong, please elaborate further.

If I'm correct, do you think I should call g2h_untagged in
`host_to_target_ipc_perm__locked` directly, or should I receive it as a
paremeter?

--
Kariiem Taha

