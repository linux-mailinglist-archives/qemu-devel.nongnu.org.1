Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DEA7671CD
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 18:26:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPPxo-0004uk-K1; Fri, 28 Jul 2023 12:05:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPPxl-0004tX-Ja
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:09 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPPxi-0004Zt-KP
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 12:05:08 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-686b643df5dso1725773b3a.1
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 09:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690560305; x=1691165105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FcU+UOJdmeV/npAZIUansWBdewwqMd6hTognTFL0avY=;
 b=l0qxufo1qcJe6b+i8B3qNfrURmqAY+0pc5PfICpmNXg3pAW6hQ5RqtCnfjtikkD9od
 6TeTEPUjKJ+jT0sK7n2JnTVszXSFBJFe6fVXvRCGhxZrBpVUJHWn16r4EBmUuFzqlY+A
 QNPPCv4kkU5ioUT3iEU4tGQAP++FvF/f/FESwnlU+VkgrznB7M/yUuGs+22BHkB9/z1v
 PaGapYRX7SEQT9Le9u3vJZ5NO1ABdIInCeZMZt5sz1UFul04xO7M93G4Z8CuRubW8sfl
 LPd4Hrzb9psSKm+4SnV7+rP44hl/YZz7rAFblWrIxzEWi2msWPTQB4uYmfEUK+ZOf8s0
 uZgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690560305; x=1691165105;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FcU+UOJdmeV/npAZIUansWBdewwqMd6hTognTFL0avY=;
 b=ZYgsEl5eM2OvJd7Bog4+YEm4AAAYyxQZg43dB1xXezwt4AIB29JdpQaJXoOglfihaf
 nisLovp7z8N4qLK4fGA5yrUGlAzDlOcbch/P+nwfuuVJPgAfCex04oYWl2tKBva7s1d9
 UaIRcsuDtA2VDSnMCrPbWqBGIDn9eThe38lDm65elsuQjRDQ98/VoI3Db+uZczYfirvP
 vVql+yY2sRjGbTzNlMjKVQ/S5i3ouckWjChQivZaDEyDxLlkM3NtVaXRZX6rCRR+0PVo
 Zj2wjfNUUngqjc+rTod31IKrJXdBJi8smudqT7lBRkL4YsCovgd6Q0Iz5F9ew8/i8fvz
 dmLg==
X-Gm-Message-State: ABy/qLYJjiHWf5WtH4IWg5GoqeRMgt6uNzUQdncs+Om7cHaHJO+pLy/Z
 qkQ63gXKn8NkbGznIHHM81WOeA==
X-Google-Smtp-Source: APBJJlExiJWqK2iBgNumJwsUXbX8EAL0dG2vzlb5bIsiJCsKyLL4Btli+rVPIouV3d8e/jteLCPuvg==
X-Received: by 2002:a05:6a20:9681:b0:13a:59b1:c88b with SMTP id
 hp1-20020a056a20968100b0013a59b1c88bmr1670228pzc.45.1690560304817; 
 Fri, 28 Jul 2023 09:05:04 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 t10-20020a63954a000000b005634bd81331sm3619036pgn.72.2023.07.28.09.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 09:05:04 -0700 (PDT)
Message-ID: <6a3e8443-2d0a-451e-a481-cc26575d8211@linaro.org>
Date: Fri, 28 Jul 2023 09:05:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
To: Claudio Fontana <cfontana@suse.de>, Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x434.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01, WEIRD_PORT=0.001 autolearn=ham autolearn_force=no
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

On 7/28/23 06:29, Claudio Fontana wrote:
> On 7/27/23 19:41, Richard Henderson wrote:
>> On 7/21/23 02:08, Claudio Fontana wrote:
>>> Thread 3 "qemu-system-s39" received signal SIGABRT, Aborted.
>>> [Switching to Thread 0x7ffff53516c0 (LWP 215975)]
>>> (gdb) bt
>>> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
>>> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
>>> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
>>> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
>>> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
>>> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
>>> #6  0x0000555555b962a9 in page_unlock (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:397
>>> #7  0x0000555555b96580 in tb_unlock_pages (tb=0x7fffefffeb00) at ../accel/tcg/tb-maint.c:483
>>> #8  0x0000555555b94698 in cpu_exec_longjmp_cleanup (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:556
>>
>>
>> https://patchew.org/QEMU/20230726201330.357175-1-richard.henderson@linaro.org/
>>
>>
>> r~
> 
> Hi Richard,
> 
> I applied your patch, however I still encounter an assert:
> 
> ERROR:../accel/tcg/tb-maint.c:367:assert_no_pages_locked: assertion failed: (g_hash_table_size(ht_pages_locked_debug) == 0)
> Bail out! ERROR:../accel/tcg/tb-maint.c:367:assert_no_pages_locked: assertion failed: (g_hash_table_size(ht_pages_locked_debug) == 0)


Ok, this is a different problem.  And tricky...



> 
> Thread 6 "qemu-system-s39" received signal SIGABRT, Aborted.
> [Switching to Thread 0x7ffeef5fe6c0 (LWP 116343)]
> 0x00007ffff730dabc in __pthread_kill_implementation () from /lib64/libc.so.6
> (gdb) bt
> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
> #5  0x0000555555b96f82 in assert_no_pages_locked () at ../accel/tcg/tb-maint.c:367
> #6  0x0000555555b976cc in page_collection_lock (start=6674, last=6674) at ../accel/tcg/tb-maint.c:614
> #7  0x0000555555b9877c in tb_invalidate_phys_range (start=27336872, last=27336879) at ../accel/tcg/tb-maint.c:1197
> #8  0x0000555555b6b25e in invalidate_and_set_dirty (mr=0x5555563f6e90, addr=27336872, length=8) at ../softmmu/physmem.c:2542
> #9  0x0000555555b6d72d in address_space_stq_internal
>      (as=0x5555566b7350, addr=27336872, val=2930044561408, attrs=..., result=0x0, endian=DEVICE_NATIVE_ENDIAN)
>      at /root/git/qemu/memory_ldst.c.inc:495
> #10 0x0000555555b6d7aa in address_space_stq (as=0x5555566b7350, addr=27336872, val=2930044561408, attrs=..., result=0x0)
>      at /root/git/qemu/memory_ldst.c.inc:510
> #11 0x0000555555a9fff6 in stq_phys (as=0x5555566b7350, addr=27336872, val=2930044561408)
>      at /root/git/qemu/include/exec/memory_ldst_phys.h.inc:55
> #12 0x0000555555aa0630 in s390_cpu_tlb_fill
>      (cs=0x555556663c80, address=2930044559360, size=1, access_type=MMU_INST_FETCH, mmu_idx=0, probe=false, retaddr=0)
>      at ../target/s390x/tcg/excp_helper.c:194
> #13 0x0000555555ba8a89 in probe_access_internal
>      (env=0x555556666460, addr=2930044559360, fault_size=1, access_type=MMU_INST_FETCH, mmu_idx=0, nonfault=false, phost=0x7ffeef5fcfd0, pfu\
> ll=0x7ffeef5fcfc8, retaddr=0, check_mem_cbs=false) at ../accel/tcg/cputlb.c:1530
> #14 0x0000555555ba90f0 in get_page_addr_code_hostp (env=0x555556666460, addr=2930044559360, hostp=0x7ffeef5fd2f0)
>      at ../accel/tcg/cputlb.c:1695
> #15 0x0000555555ba122d in translator_access (env=0x555556666460, db=0x7ffeef5fd2c0, pc=2930044559360, len=4)
>      at ../accel/tcg/translator.c:257
> #16 0x0000555555ba15e2 in translator_ldl (env=0x555556666460, db=0x7ffeef5fd2c0, pc=2930044559360) at ../accel/tcg/translator.c:351

#16: load for translation,
#15: translation for next page
#12: tlb_fill for next page
#11: store, updating access bit on the PTE
#8: invalidate the page table page, which was also marked code?!?
#5: assert no pages locked -- we never expected to invalidate in this context.

It's the page containing both code and a page table entry that concerns me.  It seems like 
a kernel bug, though obviously we shouldn't crash.  I'm not sure what to do about it.


r~

