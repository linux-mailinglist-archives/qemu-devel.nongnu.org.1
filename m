Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BF4B37BB525
	for <lists+qemu-devel@lfdr.de>; Fri,  6 Oct 2023 12:29:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qoi3m-0002D6-GT; Fri, 06 Oct 2023 06:27:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoi39-00029G-Rb
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:27:16 -0400
Received: from forwardcorp1a.mail.yandex.net
 ([2a02:6b8:c0e:500:1:45:d181:df01])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vsementsov@yandex-team.ru>)
 id 1qoi35-0004VW-S7
 for qemu-devel@nongnu.org; Fri, 06 Oct 2023 06:27:14 -0400
Received: from mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 (mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net
 [IPv6:2a02:6b8:c18:d11:0:640:6943:0])
 by forwardcorp1a.mail.yandex.net (Yandex) with ESMTP id 4C25660BCB;
 Fri,  6 Oct 2023 13:27:06 +0300 (MSK)
Received: from [IPV6:2a02:6b8:b081:7322::1:25] (unknown
 [2a02:6b8:b081:7322::1:25])
 by mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net (smtpcorp/Yandex) with
 ESMTPSA id 5RWoqZ5OouQ0-YUqBfdLW; Fri, 06 Oct 2023 13:27:05 +0300
Precedence: bulk
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
 s=default; t=1696588025;
 bh=mrXvaMc9ThVICBPhy8iEHXq7BWMihvvgwO4bp1q2zn8=;
 h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
 b=KXUWd79dRs7Qq3WewEPjL1z7wGaHsiWmltMXIAaLE44T3S6xj3C5+TUhegGmHSUfO
 cbEWFy3el4509QGajSW8jJ/T7Db9BFJPS6Y5Ntil83uC5dB+BktEsrrJDllEcZy/Fs
 lyaUddvA+mDLXZ1z+b9YwjPS5ZBbUDTblG3KTeys=
Authentication-Results: mail-nwsmtp-smtp-corp-main-83.vla.yp-c.yandex.net;
 dkim=pass header.i=@yandex-team.ru
Message-ID: <42bc3ca1-a28f-4d8e-b1ed-af696a4c2a3e@yandex-team.ru>
Date: Fri, 6 Oct 2023 13:27:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] coverity: physmem: use simple assertions instead of
 modelling
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, david@redhat.com,
 peterx@redhat.com, peter.maydell@linaro.org, yc-core@yandex-team.ru
References: <20231005140326.332830-1-vsementsov@yandex-team.ru>
 <CABgObfbpt3ci2Wu8pVzdWgG2Y1PfkWPy73aC8VRgLSVvLLFF5w@mail.gmail.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
In-Reply-To: <CABgObfbpt3ci2Wu8pVzdWgG2Y1PfkWPy73aC8VRgLSVvLLFF5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a02:6b8:c0e:500:1:45:d181:df01;
 envelope-from=vsementsov@yandex-team.ru; helo=forwardcorp1a.mail.yandex.net
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
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

On 06.10.23 01:53, Paolo Bonzini wrote:
> On Thu, Oct 5, 2023 at 4:04 PM Vladimir Sementsov-Ogievskiy
> <vsementsov@yandex-team.ru> wrote:
>> +            /*
>> +             * Assure Coverity (and ourselves) that we are not going to OVERRUN
>> +             * the buffer by following ldn_he_p().
>> +             */
>> +            assert((l == 1 && len >= 1) ||
>> +                   (l == 2 && len >= 2) ||
>> +                   (l == 4 && len >= 4) ||
>> +                   (l == 8 && len >= 8));
> 
> I'll queue it shortly, but perhaps you can try if assert(l <= len) is enough?
> 
> Alternatively I can try applying the patch on top of the tree that we
> test with, and see how things go.
> 

I've now made 4 runs:

master:
patched = master + this patch
l_len = master + this patch, but reduce assertion to assert(l <= len)
no_assert = master + this patch, but drop assertion at all. (actully, just drop the modelling)

results:
+---------------+--------+-------+-----------+---------+
|               | master | l_len | no_assert | patched |
+---------------+--------+-------+-----------+---------+
| total         | 673    | 757   | 757       | 665     |
+---------------+--------+-------+-----------+---------+
| OVERRUN       | 28     | 116   | 116       | 27      |
+---------------+--------+-------+-----------+---------+
| RESOURCE_LEAK | 85     | 85    | 85        | 82      |
+---------------+--------+-------+-----------+---------+
| UNINIT        | 52     | 48    | 48        | 48      |
+---------------+--------+-------+-----------+---------+


Command to generate results:

DIR=../cov-master; rm -rf $DIR; git clean -fxd && ./configure --target-list=x86_64-softmmu --enable-debug --disable-docs --disable-xen --extra-cflags='-fno-lto' --cc=gcc --host-cc=gcc --cxx=g++ && cov-build --dir $DIR make -j20 && cov-make-library --output-file $DIR/qemu-model scripts/coverity-scan/model.c && cov-analyze --dir $DIR --model-file $DIR/qemu-model

(then, change code, change DIR and rerun, and so on)


So, assert(l <= len) doesn't help :(.

Looking at first OVERRUN problem, that we have only in l_len and no_assert, in win_dump.c:

202  	static void check_kdbg(WinDumpHeader *h, bool x64, Error **errp)
203  	{
204  	    const char OwnerTag[] = "KDBG";
205  	    char read_OwnerTag[4];
206  	    uint64_t KdDebuggerDataBlock = WIN_DUMP_FIELD(KdDebuggerDataBlock);
207  	    bool try_fallback = true;
208  	
209  	try_again:

(1) Event cond_false: 	Condition "0 /* !(sizeof (cpus.tqh_first) <= 8) */", taking false branch.
(2) Event loop_end: 	Reached end of loop.
(3) Event overrun-buffer-val: 	Overrunning array "read_OwnerTag" of 4 bytes by passing it to a function which accesses it at byte offset 7.

210  	    if (cpu_memory_rw_debug(first_cpu,
211  	            KdDebuggerDataBlock + KDBG_OWNER_TAG_OFFSET,
212  	            (uint8_t *)&read_OwnerTag, sizeof(read_OwnerTag), 0)) {
213  	        error_setg(errp, "win-dump: failed to read OwnerTag");
214  	        return;
215  	    }

So, the problem is that on the code path Coverity knows exact bound (like 4), but unsure about len variable.

> 
>>               val = ldn_he_p(buf, l);
>>               result |= memory_region_dispatch_write(mr, addr1, val,
>>                                                      size_memop(l), attrs);
>> @@ -2784,6 +2793,15 @@ MemTxResult flatview_read_continue(FlatView *fv, hwaddr addr,
>>               l = memory_access_size(mr, l, addr1);
>>               result |= memory_region_dispatch_read(mr, addr1, &val,
>>                                                     size_memop(l), attrs);
>> +
>> +            /*
>> +             * Assure Coverity (and ourselves) that we are not going to OVERRUN
>> +             * the buffer by following stn_he_p().
>> +             */
>> +            assert((l == 1 && len >= 1) ||
>> +                   (l == 2 && len >= 2) ||
>> +                   (l == 4 && len >= 4) ||
>> +                   (l == 8 && len >= 8));
>>               stn_he_p(buf, l, val);
>>           } else {
>>               /* RAM case */
>> --
>> 2.34.1
>>
> 

-- 
Best regards,
Vladimir


