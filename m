Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 73EB97940C2
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Sep 2023 17:51:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdunG-0007LC-5a; Wed, 06 Sep 2023 11:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdunD-0007Ka-3r
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:50:11 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdunA-0003CU-9a
 for qemu-devel@nongnu.org; Wed, 06 Sep 2023 11:50:10 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-9a5dff9d2d9so572514266b.3
 for <qemu-devel@nongnu.org>; Wed, 06 Sep 2023 08:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694015406; x=1694620206; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=+rRIwcjOH2r4WbSDDIHNEM6vSs/hrMgoev6dBCYQW0Y=;
 b=oRI3lbfdRhm8IqAqFhoqeFYC23qtakPXLoFnbG8aTSjRH/WaP9rcFmGUcBXupB2eSD
 Xu9rDgKsQZaxknPPSNWnb6ypANd9WfN/oqtuN6a2Vq8zF2MTu4wKIe/KrH+TwXwMu56i
 NJ/NDM/oPngPx7HwKp9XPfky8d4wNpGeyApxTdhJSpw/s3vGonyEdpBVwTRTaZKsaXKp
 +K+fFlv96/j09BpRw+N20goXos1BPPhjor+PEsYT0MhC3plsuNfpX8suHr3yP1Bly3R5
 Smbk8WiOy9wb5PQPtdST/s+n+bD86XmvabjSIbUopQVtb0mSO2J8ZGxqTypd+y7V3YvZ
 26Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1694015406; x=1694620206;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+rRIwcjOH2r4WbSDDIHNEM6vSs/hrMgoev6dBCYQW0Y=;
 b=bPDPpZVCG5mnahaYj/mo+n5R098iIygo8nbbqcUiamJnwueGZrbNgAbssOGA6vaoYl
 xUtlT+lPl3pWNpCX0fEBK9fMp29uPzdbvpJboICoeYQcIk05QPVcvIdeEwiJiJHMPDQI
 CNbGxfNKTJXuPFK8OGmxsMhTAFQ/JCmR94WsfXEywVotYIidgdvFVNdAfZGGrx2gMKTV
 k53O+SqViHQ8qlch3YT5xZx8XNRT3/IpFkNtyxRXih4QiB/hsBJ56ALvKddLO5HQJFkg
 MNYgRAMK0OCatspQL20xgwE58GkONEmynPIYF964hxWo5GMoMf9C6WgP8dos4xY5bH/d
 S+Og==
X-Gm-Message-State: AOJu0YzsF2pj4ZiSzCuuHCX276ETbqEjTQgCw2tPEFpJsvx+7BYqoXBT
 UyzZDEoeT0lMNM+Gp9wtQ0WufA==
X-Google-Smtp-Source: AGHT+IEHbO78u8I6HgemecOdqmGX194cxUTXqyey99tmvLufKTTPfV6KmMGM4J2gkg7I57uUWjxJsg==
X-Received: by 2002:a17:906:10dc:b0:9a5:a068:5548 with SMTP id
 v28-20020a17090610dc00b009a5a0685548mr2514085ejv.75.1694015406488; 
 Wed, 06 Sep 2023 08:50:06 -0700 (PDT)
Received: from [192.168.69.115] (cou50-h01-176-172-51-223.dsl.sta.abo.bbox.fr.
 [176.172.51.223]) by smtp.gmail.com with ESMTPSA id
 lu7-20020a170906fac700b0099bcf1c07c6sm9185805ejb.138.2023.09.06.08.50.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Sep 2023 08:50:05 -0700 (PDT)
Message-ID: <67d4c8dc-24d7-afa3-27b1-d6e756a597b9@linaro.org>
Date: Wed, 6 Sep 2023 17:50:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: mips system emulation failure with virtio
Content-Language: en-US
To: Richard Purdie <richard.purdie@linuxfoundation.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <4f2a4b734b20b80857d56af986335f78a92a0fff.camel@linuxfoundation.org>
 <87pm2whfyn.fsf@linaro.org>
 <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <0cbd86af5501f18007a926598c6e2232af240d00.camel@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

+rth/pm215/dhildenb

On 5/9/23 16:50, Richard Purdie wrote:
> On Tue, 2023-09-05 at 14:59 +0100, Alex Bennée wrote:
>> Richard Purdie <richard.purdie@linuxfoundation.org> writes:
>>
>>> With qemu 8.1.0 we see boot hangs fox x86-64 targets.
>>>
>>> These are fixed by 0d58c660689f6da1e3feff8a997014003d928b3b (softmmu:
>>> Use async_run_on_cpu in tcg_commit) but if I add that commit, mips and
>>> mips64 break, hanging at boot unable to find a rootfs.
>>
>> (Widen CC list)
>>
>>>
>>> We use virtio for network and disk and both of those change in the
>>> bootlog from messages like:
>>>
>>> [    1.726118] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
>>> [    1.728864] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
>>> [    1.729948] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
>>> ...
>>> [    2.162148] virtio_blk virtio2: 1/0/0 default/read/poll queues
>>> [    2.168311] virtio_blk virtio2: [vda] 1184242 512-byte logical
>>>
>>> to:
>>>
>>> [    1.777051] virtio-pci 0000:00:13.0: enabling device (0000 -> 0003)
>>> [    1.779822] virtio-pci 0000:00:14.0: enabling device (0000 -> 0003)
>>> [    1.780926] virtio-pci 0000:00:15.0: enabling device (0000 -> 0003)
>>> ...
>>> [    1.894852] virtio_rng: probe of virtio1 failed with error -28
>>> ...
>>> [    2.063553] virtio_blk virtio2: 1/0/0 default/read/poll queues
>>> [    2.064260] virtio_blk: probe of virtio2 failed with error -28
>>> [    2.069080] virtio_net: probe of virtio0 failed with error -28
>>>
>>>
>>> i.e. the virtio drivers no longer work.
>>
>> Interesting, as you say this seems to be VirtIO specific as the baseline
>> tests (using IDE) work fine:
>>
>>    ➜  ./tests/venv/bin/avocado run ./tests/avocado/tuxrun_baselines.py:test_mips64
>>    JOB ID     : 71f3e3b7080164b78ef1c8c1bb6bc880932d8c9b
>>    JOB LOG    : /home/alex/avocado/job-results/job-2023-09-05T15.01-71f3e3b/job.log
>>     (1/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64: PASS (12.19 s)
>>     (2/2) ./tests/avocado/tuxrun_baselines.py:TuxRunBaselineTest.test_mips64el: PASS (11.78 s)
>>    RESULTS    : PASS 2 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 0 | CANCEL 0
>>    JOB TIME   : 24.79 s
>>
>>> I tested with current qemu master
>>> (17780edd81d27fcfdb7a802efc870a99788bd2fc) and mips is still broken
>>> there.
>>>
>>> Is this issue known about?
>>
>> Could you raise a bug at:
>>
>>    https://gitlab.com/qemu-project/qemu/-/issues
> 
> Done, https://gitlab.com/qemu-project/qemu/-/issues/1866
> 
>> I'm curious why MIPS VirtIO is affected but nothing else is...
> 
> Me too, it seems there is a real code issue somewhere in this...

This seems to fix the issue for me, but I'm not really sure what
I'm doing after various hours debugging, so sharing here before
I take some rest:

-- >8 --
diff --git a/softmmu/physmem.c b/softmmu/physmem.c
index 18277ddd67..ec31ebcb56 100644
--- a/softmmu/physmem.c
+++ b/softmmu/physmem.c
@@ -2517,7 +2517,7 @@ static void tcg_commit(MemoryListener *listener)
       * That said, the listener is also called during realize, before
       * all of the tcg machinery for run-on is initialized: thus halt_cond.
       */
-    if (cpu->halt_cond) {
+    if (cpu->halt_cond && !qemu_cpu_is_self(cpu)) {
          async_run_on_cpu(cpu, tcg_commit_cpu, RUN_ON_CPU_HOST_PTR(cpuas));
      } else {
          tcg_commit_cpu(cpu, RUN_ON_CPU_HOST_PTR(cpuas));
---

That said, the same logic moved generically to async_run_on_cpu()
also works ...:

-- >8 --
diff --git a/cpus-common.c b/cpus-common.c
index 45c745ecf6..b0539c4fb8 100644
--- a/cpus-common.c
+++ b/cpus-common.c
@@ -167,6 +167,9 @@ void do_run_on_cpu(CPUState *cpu, run_on_cpu_func 
func, run_on_cpu_data data,

  void async_run_on_cpu(CPUState *cpu, run_on_cpu_func func, 
run_on_cpu_data data)
  {
+    if (qemu_cpu_is_self(cpu)) {
+        return func(cpu, data);
+    }
      struct qemu_work_item *wi;

      wi = g_new0(struct qemu_work_item, 1);
---

Regards,

Phil.

