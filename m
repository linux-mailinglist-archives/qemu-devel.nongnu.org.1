Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 970B3766EF2
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:00:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPNaj-0003xQ-2J; Fri, 28 Jul 2023 09:33:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNag-0003wy-Qn
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:33:10 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPNaf-0003wz-38
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 09:33:10 -0400
Received: by mail-pf1-x42d.google.com with SMTP id
 d2e1a72fcca58-686f94328a4so1075576b3a.0
 for <qemu-devel@nongnu.org>; Fri, 28 Jul 2023 06:33:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690551187; x=1691155987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=etzukGYNm2ZQ41Bi6imrOfI5r/ZZyTtIfH43OiTfjlA=;
 b=AmnpmBIjdXQRXRi/RJooSv4PjWwUY3Z1aan02tR84XMPPSkXYuZzRQlMtjra7bqDEl
 71yGyuY529y/xhjCifJsM+/dADxR3+IfGtvTA3kbZeBQf6tCEPpD7Y4OlVVmAAPrlEgu
 8XPf6vFYqTgpblnVD/u2QndOLePmG8kQtd9mMt2eHJXyyenkFZnl2pvKB5QaQK/xIXh5
 Q+WHIUhTMMfAehDnQQAWNc5zcDCpNc3+NXKILs7aVdozUb4j+9LjWFc0RWyqra3Kdtsz
 bxfQ1GKJl7gMAxk1Fzz3/zzsp88Rp2LTK0ZcXitbzM8HxJXLBpc3mp8xLSwNirrgG5CL
 PMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690551187; x=1691155987;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=etzukGYNm2ZQ41Bi6imrOfI5r/ZZyTtIfH43OiTfjlA=;
 b=Wix2QqJlFIiVtvfpLbGTTe/Z8dEf0lu+IvpUSvbCFey2rEsMfBaB6sGuMlEB5vQ833
 HCe0eFtGIO53xXFvtMTeU/hP48SmNycKPalQHLduI16ZKcB40o18sE4RKRTVVSJl2Hr8
 ponQsP3yTFu9XG71cLFUELP3FZfT8i2lazV0yMovusQCTtr5u5IhSheONacLWQDCaIj2
 JDOBn2C3B+ko/Ea11cZWgTf0gw+0wwcCMXx32gHYcS9DDQFmhmT9P+sjPMvTG5MlCm+E
 ee0r38fwkvcXWBo18P5omCgCjJBZ5TTZgROO7Oi4DpaQMpePxJA3OyDJA5nxmifuJhL0
 SLtw==
X-Gm-Message-State: ABy/qLaqb2HKiDky2/DTvIPpm6m76wiOLKTm7p02SO8Fs51Fu7Yh/w3I
 KbrfMVRLeTUPB4Zaa/ac2j1rkQ==
X-Google-Smtp-Source: APBJJlHv81RvEE1UpHsyZhxK3waxXaHqFKyE3QT7lwSIKET4Wjt907yucuLvvaZOvxqoHoouFh+A1g==
X-Received: by 2002:a05:6a20:7da9:b0:127:72c3:6428 with SMTP id
 v41-20020a056a207da900b0012772c36428mr2512716pzj.18.1690551187561; 
 Fri, 28 Jul 2023 06:33:07 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:cfba:2f6a:7070:67a9?
 ([2602:ae:154e:c001:cfba:2f6a:7070:67a9])
 by smtp.gmail.com with ESMTPSA id
 k22-20020aa792d6000000b00686bef8e55csm3213108pfa.39.2023.07.28.06.33.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Jul 2023 06:33:07 -0700 (PDT)
Message-ID: <2a417aaa-9ef9-6e24-cc54-e76e2d25b968@linaro.org>
Date: Fri, 28 Jul 2023 06:33:05 -0700
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
Received-SPF: pass client-ip=2607:f8b0:4864:20::42d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

What's the test case?


r~

