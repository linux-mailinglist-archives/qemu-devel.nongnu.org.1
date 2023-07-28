Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3718A766F7B
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 16:29:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPONg-00012o-WD; Fri, 28 Jul 2023 10:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPONa-00012V-5e
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:23:42 -0400
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPONY-0003rq-Hm
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:23:41 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EB5A1219B1;
 Fri, 28 Jul 2023 14:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690554218; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/S+C171uhvNrT7zgRa58XtOxIVOREm/i+g9XEbhTIs=;
 b=efxen4fRTo87I4h8slB2/bQ0PspcTKvMYd42wJ6d5MisH80MXGMLp/mC+MShwwZK/pYASJ
 mzm6jO5WhE/DZsNJLPZyFpZsrPp4xvoDc+M5oxCmuimMAuSKf6SNjxNd2Sxbbo1y9QzEry
 Xjxg1CuSz5bTfwQzhkXqcGLoXpnWniQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690554218;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=K/S+C171uhvNrT7zgRa58XtOxIVOREm/i+g9XEbhTIs=;
 b=wk3yQR7eYwIhpBqeXri9Tqn3BstIx8V+HQ+RG+X/4YaQdTwpJMUhU8oVqIK5ZVokXJI6Xz
 iExvF40UCvu2soDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB78313276;
 Fri, 28 Jul 2023 14:23:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fcntK2rPw2SHJQAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 28 Jul 2023 14:23:38 +0000
Message-ID: <16a9cdba-2f84-7d38-aadb-04524fee51e2@suse.de>
Date: Fri, 28 Jul 2023 16:23:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: assert fails in s390x TCG
Content-Language: en-US
From: Claudio Fontana <cfontana@suse.de>
To: Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>
References: <eaec32e3-d56a-e6a7-fcbe-860948e79658@suse.de>
 <def2df0d-fb58-8e67-a0eb-7d646da3be42@linaro.org>
 <0e06f694-7aeb-66d1-48d8-317a93f8f741@suse.de>
 <2a417aaa-9ef9-6e24-cc54-e76e2d25b968@linaro.org>
 <77b0a57e-68f6-8515-b3fa-3ec9988894bc@suse.de>
In-Reply-To: <77b0a57e-68f6-8515-b3fa-3ec9988894bc@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:67c:2178:6::1c;
 envelope-from=cfontana@suse.de; helo=smtp-out1.suse.de
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 7/28/23 15:45, Claudio Fontana wrote:
> On 7/28/23 15:33, Richard Henderson wrote:
>> On 7/28/23 06:29, Claudio Fontana wrote:
>>> On 7/27/23 19:41, Richard Henderson wrote:
>>>> On 7/21/23 02:08, Claudio Fontana wrote:
>>>>> Thread 3 "qemu-system-s39" received signal SIGABRT, Aborted.
>>>>> [Switching to Thread 0x7ffff53516c0 (LWP 215975)]
>>>>> (gdb) bt
>>>>> #0  0x00007ffff730dabc in __pthread_kill_implementation () at /lib64/libc.so.6
>>>>> #1  0x00007ffff72bc266 in raise () at /lib64/libc.so.6
>>>>> #2  0x00007ffff72a4897 in abort () at /lib64/libc.so.6
>>>>> #3  0x00007ffff76f0eee in  () at /lib64/libglib-2.0.so.0
>>>>> #4  0x00007ffff775649a in g_assertion_message_expr () at /lib64/libglib-2.0.so.0
>>>>> #5  0x0000555555b96134 in page_unlock__debug (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:348
>>>>> #6  0x0000555555b962a9 in page_unlock (pd=0x7ffee8680440) at ../accel/tcg/tb-maint.c:397
>>>>> #7  0x0000555555b96580 in tb_unlock_pages (tb=0x7fffefffeb00) at ../accel/tcg/tb-maint.c:483
>>>>> #8  0x0000555555b94698 in cpu_exec_longjmp_cleanup (cpu=0x555556566a30) at ../accel/tcg/cpu-exec.c:556
>>>>
>>>>
>>>> https://patchew.org/QEMU/20230726201330.357175-1-richard.henderson@linaro.org/
>>>>
>>>>
>>>> r~
>>>
>>> Hi Richard,
>>>
>>> I applied your patch, however I still encounter an assert:
>>>
>>> ERROR:../accel/tcg/tb-maint.c:367:assert_no_pages_locked: assertion failed: (g_hash_table_size(ht_pages_locked_debug) == 0)
>>> Bail out! ERROR:../accel/tcg/tb-maint.c:367:assert_no_pages_locked: assertion failed: (g_hash_table_size(ht_pages_locked_debug) == 0)
>>
>> What's the test case?
>>
>>
>> r~
> 
> It is a test environment for building packages, so the guest at the time of the error is running ./configure for the package swig-v4.1.1.tar.gz
> 
> checking build system type... s390x-ibm-linux-gnu^M
> checking host system type... s390x-ibm-linux-gnu^M
> checking for a BSD-compatible install... /usr/bin/install -c^M
> checking whether build environment is sane... [New Thread 0x7ffea3fff6c0 (LWP 116436)]
> [New Thread 0x7ffec14e26c0 (LWP 116437)]
> [New Thread 0x7ffecf73e6c0 (LWP 116438)]
> [New Thread 0x7ffecde2c6c0 (LWP 116439)]
> [New Thread 0x7ffec2beb6c0 (LWP 116440)]
> yes^M
> checking for a thread-safe mkdir -p... /usr/bin/mkdir -p^M
> checking for gawk... gawk^M
> checking whether make sets $(MAKE)... yes^M
> checking whether make supports nested variables... yes^M
> checking for s390x-ibm-linux-gnu-gcc... gcc^M
> checking whether the C compiler works... **
> 
> So I presume we are in:
> 
> AC_PROG_CC
> 


I am rerunning this over and over, and it seems it always aborts there in the same place.

C
 


