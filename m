Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3638973D7D0
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 08:38:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDfqh-0003fH-5s; Mon, 26 Jun 2023 02:37:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDfqf-0003eq-Of
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:37:17 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qDfqd-0000ui-IX
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 02:37:17 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-4fb41682472so1164755e87.2
 for <qemu-devel@nongnu.org>; Sun, 25 Jun 2023 23:37:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687761433; x=1690353433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GPz8/V17VD8qdtZV6+3P5oo02FRjvvImb1FS+IkpNN8=;
 b=Jq6hdNB02BR9J8cQrZUkGQHAb9FWNoJq1L4mN4EvgBIgXqdXcSVvJE4eq0r7m0VvsD
 zPCbz5F8UipxfA1dadBbq7aiAS+yeqmHJDLrKmjuYc3XYSgdS1vTDw+U71KSzWnI4NB9
 +Mw6kGGuihgKshweNP81z3omHcs+Z+ilUSYTOeHB/aZ+SBYKp8/54IG4Rzg6B9s0yzcm
 a28aKOMJHD9Wu1RssxhpuEeLoBWM57fbf8iAqr+9i0yeyOTd3aOj7n55NeYsTlDWZ5CR
 ri1jqQHDczfgpkqhasV240fYJob/ydzlGSTicOIo6u/JfH1jYCi7rwzx1sxIuXZlG20E
 Ia6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687761433; x=1690353433;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GPz8/V17VD8qdtZV6+3P5oo02FRjvvImb1FS+IkpNN8=;
 b=jtgI7TtqzA8iwR0XEFqiXi0EphAqRByEHAKvbM7bct1uAUXe+p6aQTGedOovQPuTo1
 EIG9bUYsJtLASDYoE9fRy5v44pM9z3JTjB3LE+Ze5AeTtYnnJfyGnhZSV7bPSZkDncVx
 ZTbO5Dtr6dwsFsBbTtkMoxy8bgRkaiERIGRVYG1Q8PJXxCKyYu/kXgTulkjg7aacQrLf
 a0G+qFTZ7m3gm3tYnrGX7z4yhmhQYw9ApDLkSLa6Es8ZuOo42f/EOa35X8lDEwh2ZY8l
 QWnNi3noQsDMRK6UGUylAekOi6/lO5bpDr4eBjgftLLA5Mm5o0FI7ypT6IwC8aq+Q8kn
 M3nQ==
X-Gm-Message-State: AC+VfDwpkZcRNnYQXyAKgvLEktYrmqtG5K1l5CFEpPM7pnl694TTwrrU
 0YwZCULHtqDGl2Kfs6iD61yoZw==
X-Google-Smtp-Source: ACHHUZ6StoQChb5zgJxa7/0r83FiOu0AiFnt6Q0ReBl1Jpj+MJdv9CeQLgCknDQFJLzWcp1/PLM9ZQ==
X-Received: by 2002:a19:e602:0:b0:4f9:5711:2eb8 with SMTP id
 d2-20020a19e602000000b004f957112eb8mr9357245lfh.33.1687761433236; 
 Sun, 25 Jun 2023 23:37:13 -0700 (PDT)
Received: from [192.168.1.208] ([139.47.42.170])
 by smtp.gmail.com with ESMTPSA id
 w10-20020a1cf60a000000b003f9bd9e3226sm6625406wmc.7.2023.06.25.23.37.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 23:37:12 -0700 (PDT)
Message-ID: <a614493f-1e3e-1d6b-13df-702be2b1bd8e@linaro.org>
Date: Mon, 26 Jun 2023 08:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/30] Next patches
To: quintela@redhat.com
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Eric Blake <eblake@redhat.com>, Fam Zheng <fam@euphon.net>,
 Leonardo Bras <leobras@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-block@nongnu.org
References: <20230622165527.2417-1-quintela@redhat.com>
 <1f5c4a38-6ae2-53dd-d739-65accb1d86a8@linaro.org>
 <87leg719rs.fsf@secure.mitica>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87leg719rs.fsf@secure.mitica>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x134.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 6/26/23 00:01, Juan Quintela wrote:
> Richard Henderson <richard.henderson@linaro.org> wrote:
>> On 6/22/23 18:54, Juan Quintela wrote:
>>> The following changes since commit b455ce4c2f300c8ba47cba7232dd03261368a4cb:
>>>     Merge tag 'q800-for-8.1-pull-request'
>>> ofhttps://github.com/vivier/qemu-m68k  into staging (2023-06-22
>>> 10:18:32 +0200)
>>> are available in the Git repository at:
>>>     https://gitlab.com/juan.quintela/qemu.git  tags/next-pull-request
>>> for you to fetch changes up to
>>> 23e4307eadc1497bd0a11ca91041768f15963b68:
>>>     migration/rdma: Split qemu_fopen_rdma() into input/output
>>> functions (2023-06-22 18:11:58 +0200)
>>> ----------------------------------------------------------------
>>> Migration Pull request (20230621) take 2
>>> In this pull request the only change is fixing 32 bits complitaion
>>> issue.
>>> Please apply.
>>> [take 1]
>>> - fix for multifd thread creation (fabiano)
>>> - dirtylimity (hyman)
>>>     * migration-test will go on next PULL request, as it has failures.
>>> - Improve error description (tejus)
>>> - improve -incoming and set parameters before calling incoming (wei)
>>> - migration atomic counters reviewed patches (quintela)
>>> - migration-test refacttoring reviewed (quintela)
>>
>> New failure with check-cfi-x86_64:
>>
>> https://gitlab.com/qemu-project/qemu/-/jobs/4527202764#L188
> 
> First of all, is there a way to get to the test log?  In particular, I
> am interested in knowing at least what test has failed (yes,
> migration-test don't tell you much more).
> 
> After a bit more wrestling, I have been able to get things compiling
> with this command:
> 
> $ /mnt/code/qemu/full/configure --enable-cfi
> --target-list=x86_64-softmmu --enable-cfi-debug --cc=clang --cxx=clang++
> --disable-docs --enable-safe-stack --disable-slirp
> 
> It should basically be the one that check-cfi-x86_64 is using if I
> understand the build recipes correctly (that is a BIG IF).
> 
> And it passes for me with flying colors.
> Here I have Fedora38, builder has F37.
> 
>> /builds/qemu-project/qemu/build/pyvenv/bin/meson test  --no-rebuild -t
>> 0  --num-processes 1 --print-errorlogs
>>    1/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/qom-test
>>    OK 6.55s   8 subtests passed
>> ▶   2/350 ERROR:../tests/qtest/migration-test.c:320:check_guests_ram:
>> assertion failed: (bad == 0) ERROR
>>    2/350 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test
>>    ERROR 151.99s   killed by signal 6 SIGABRT
>>>>>
>>      G_TEST_DBUS_DAEMON=/builds/qemu-project/qemu/tests/dbus-vmstate-daemon.sh
>>      MALLOC_PERTURB_=3 QTEST_QEMU_IMG=./qemu-img
>>      QTEST_QEMU_STORAGE_DAEMON_BINARY=./storage-daemon/qemu-storage-daemon
>>      QTEST_QEMU_BINARY=./qemu-system-x86_64
>>      /builds/qemu-project/qemu/build/tests/qtest/migration-test --tap
>>     -k
>> ――――――――――――――――――――――――――――――――――――― ✀  ―――――――――――――――――――――――――――――――――――――
>> stderr:
>> qemu-system-x86_64: Unable to read from socket: Connection reset by peer
> 
> This is the interesting bit, why is the conection closed.
> 
>> Memory content inconsistency at 4f65000 first_byte = 30 last_byte = 2f
>> current = 88 hit_edge = 1
>> **
>> ERROR:../tests/qtest/migration-test.c:320:check_guests_ram: assertion failed: (bad == 0)
>>
>> (test program exited with status code -6)
> 
> This makes zero sense, except if we haven't migrated all the guest
> state, that it is what it has happened.
> 
> Is there a place on the web interface to see the full logs?  Or that is
> the only thing that the CI system stores?

The "full logs" are

https://gitlab.com/qemu-project/qemu/-/jobs/4527202764/artifacts/download?file_type=trace


r~

