Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D28067CADC8
	for <lists+qemu-devel@lfdr.de>; Mon, 16 Oct 2023 17:40:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsPgX-0002hF-KF; Mon, 16 Oct 2023 11:39:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsPgV-0002h5-Cc
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:39:11 -0400
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <yong.huang@smartx.com>)
 id 1qsPgS-00062F-JR
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 11:39:11 -0400
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-1c9e072472bso26898245ad.2
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 08:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=smartx-com.20230601.gappssmtp.com; s=20230601; t=1697470623; x=1698075423;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TtSD3wBsyNY2HvowCS/i6/2spuTn2x/yXfPUYsPQYe8=;
 b=CWWflNF7h0FWuEuC3Ea2lDDkc63KUUrzg2BGtFErvjWcPfEDiVR1+SPGjtnps2oYru
 9WJoeS2xpx545cbw0Kk5hCFfPoQIb0fcUva5YbYMslrpG9Y7pQaAjyr6LmkYx3Ti/bXe
 JheIto66vqaiaRXH4Z3RwlyefnDvVCeHghkH9UbX+4G7MKvgo1SsvIl06PpsYNSezzgT
 v04AnbSJVTvDizk+XJoZHCzRGhGbNnV2ug5VcatUgImZaRME77GRcCnB1/YX4pfPB/qo
 XbListCbBFzlQOQd8wVBbqeIXpBSB7YQsduk/8GN5cJ1hMDQ4bAVjA/t6pql6WCMQInJ
 fU2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697470623; x=1698075423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
 :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TtSD3wBsyNY2HvowCS/i6/2spuTn2x/yXfPUYsPQYe8=;
 b=eRq1psjuzSZhpsyVIGLVR2Trr56hefsKWTrxnosNm381+qCz8KhooVLpu9OofAh/ul
 YWZ7fF2QMVEFxOMPn4pbMRCA3CuFvLhfAQ1Y00fLHWk8s8vgbqqv1r8w0xoY3b3oLN9M
 5i+tEmsr2Zu9tHNNTE7WV/keLoxP1qkdSYUU73IxjmH/s9ySR8bdylNHXXmlnNge+qK0
 gbgM9IiyXKf9o1YHyUkI3ts/8xHDCxtHKUfQU/LeN7IdZsTj4eAoUQ6zTPLekRBGJQnZ
 ujKFTZazXQCy4sqE7vl7Va6Ru3OXqNWXC1sQjkuAHTH5R0PZYrTt1XIz9gLKWPH66ioj
 Brdg==
X-Gm-Message-State: AOJu0Yyjp1m5vJTMXqsA2w3YifRGs7oxf9tIc8aF4xUSa41nbzb+8GiB
 Ss88TeaidkgHdHkmgXyBylee1Q==
X-Google-Smtp-Source: AGHT+IFbDr6x5/k3FQZ27dJleQtTmzJNg8QRNCuN7x37GiTDDz1TLBGebRoXg24/xJomPmbSoZowvQ==
X-Received: by 2002:a17:902:e851:b0:1ca:42b:f60d with SMTP id
 t17-20020a170902e85100b001ca042bf60dmr8217682plg.55.1697470623332; 
 Mon, 16 Oct 2023 08:37:03 -0700 (PDT)
Received: from [26.26.26.1] ([205.198.122.37])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a170902e80500b001c60c3f9508sm8615824plg.230.2023.10.16.08.37.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Oct 2023 08:37:02 -0700 (PDT)
Message-ID: <a64e46aa-7ce4-84a7-543b-7a4379c0806d@smartx.com>
Date: Mon, 16 Oct 2023 23:37:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] softmmu/dirtylimit: Fix usleep early return on signal
To: alloc young <alloc.young@outlook.com>
Cc: qemu-devel@nongnu.org
References: <SA1PR11MB6760A4AD57255448B62EDE38F5E4A@SA1PR11MB6760.namprd11.prod.outlook.com>
 <CAK9dgmYVeGGf=2jawm77DtiOeqvnN_dEiLvOWK3-r1zzC1DJ8A@mail.gmail.com>
 <SA1PR11MB6760DAE48226BAAF55B7DF2FF5E8A@SA1PR11MB6760.namprd11.prod.outlook.com>
From: Hyman Huang <yong.huang@smartx.com>
In-Reply-To: <SA1PR11MB6760DAE48226BAAF55B7DF2FF5E8A@SA1PR11MB6760.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62a;
 envelope-from=yong.huang@smartx.com; helo=mail-pl1-x62a.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-3.339, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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


在 2023/9/5 10:17, alloc young 写道:
>
>
> On 2023/9/4 21:27, Yong Huang wrote:
>>
>>
>> On Fri, Sep 1, 2023 at 10:19 AM <alloc.young@outlook.com 
>> <mailto:alloc.young@outlook.com>> wrote:
>>
>>     From: alloc <alloc.young@outlook.com 
>> <mailto:alloc.young@outlook.com>>
>>
>>     Timeout functions like usleep can return early on signal, which 
>> reduces
>>     more dirty pages than expected. In dirtylimit case, dirtyrate meter
>>     thread needs to kick all vcpus out to sync. The callchain:
>>
>>     vcpu_calculate_dirtyrate
>>          global_dirty_log_sync
>>              memory_global_dirty_log_sync
>>                  kvm_log_sync_global
>>                      kvm_dirty_ring_flush
>>                          kvm_cpu_synchronize_kick_all <---- send vcpu 
>> signal
>>
>>     For long time sleep, use qemu_cond_timedwait_iothread to handle 
>> cpu stop
>>     event.
>>
>>
>> The Dirty Limit algorithm seeks to keep the vCPU dirty page rate within
>> the set limit; since it focuses more emphasis on processing time and
>> precision, I feel that improvement should strive for the same result.
>> Could you please provide the final test results showing the impact of
>> that improvement?
> Use the command line below with initrd built in tests/migration, guest 
> runs stress at 5GiB/s. Migration with dirty limit on and default 
> parameters, migration can't finish within 1 hour. The default vcpu 
> dirty limit set is 1 MB/s, however, the mig_src.log show copy rate at 
> 128MiB/s. With this patch, migration finsih in 39s.
>
> /usr/libexec/qemu-kvm -display none -vga none -name 
> mig_src,debug-threads=on -monitor stdio -accel 
> kvm,dirty-ring-size=4096 -cpu host -kernel 
> /boot/vmlinuz-5.14.0-70.22.1.el9_0.x86_64 -initrd 
> /root/initrd-stress.img -append noapic edd=off printk.time=1 
> noreplace-smp cgroup_disable=memory pci=noearly console=ttyS0 debug 
> ramsize=1 ncpus=1 -chardev 
> file,id=charserial0,path=/var/log/mig_src.log -serial 
> chardev:charserial0 -m 1536 -smp 1
>
I calculated the migration time and success probability using the

QEMU test/migration/guestperf.py script. With the patch, performance

seems to not increase. Would you kindly post the test case's specifics?

IMHO, conducting tests more than once and obtaining probability

statistics data could be more compelling.

Thanks, Yong

>
>>
>>     Signed-off-by: alloc <alloc.young@outlook.com
>>     <mailto:alloc.young@outlook.com>>
>>     ---
>>       softmmu/dirtylimit.c | 19 +++++++++++++++++--
>>       1 file changed, 17 insertions(+), 2 deletions(-)
>>
>>     diff --git a/softmmu/dirtylimit.c b/softmmu/dirtylimit.c
>>     index fa959d7743..ee938c636d 100644
>>     --- a/softmmu/dirtylimit.c
>>     +++ b/softmmu/dirtylimit.c
>>     @@ -411,13 +411,28 @@ void dirtylimit_set_all(uint64_t quota,
>>
>>       void dirtylimit_vcpu_execute(CPUState *cpu)
>>       {
>>     +    int64_t sleep_us, endtime_us;
>>     +
>>     +    dirtylimit_state_lock();
>>           if (dirtylimit_in_service() &&
>>  dirtylimit_vcpu_get_state(cpu->cpu_index)->enabled &&
>>               cpu->throttle_us_per_full) {
>>               trace_dirtylimit_vcpu_execute(cpu->cpu_index,
>>                       cpu->throttle_us_per_full);
>>     -        usleep(cpu->throttle_us_per_full);
>>     -    }
>>     +        sleep_us = cpu->throttle_us_per_full;
>>     +        dirtylimit_state_unlock();
>>     +        endtime_us = qemu_clock_get_us(QEMU_CLOCK_REALTIME) + 
>> sleep_us;
>>     +        while (sleep_us > 0 && !cpu->stop) {
>>     +            if (sleep_us > SCALE_US) {
>>     +                qemu_mutex_lock_iothread();
>>     + qemu_cond_timedwait_iothread(cpu->halt_cond,
>>     sleep_us / SCALE_US);
>>     +                qemu_mutex_unlock_iothread();
>>     +            } else
>>     +                g_usleep(sleep_us);
>>     +            sleep_us = endtime_us -
>>     qemu_clock_get_us(QEMU_CLOCK_REALTIME);
>>     +        }
>>     +    } else
>>     +        dirtylimit_state_unlock();
>>       }
>>
>>       static void dirtylimit_init(void)
>>     --     2.39.3
>>
>>
>>
>> -- 
>> Best regards

