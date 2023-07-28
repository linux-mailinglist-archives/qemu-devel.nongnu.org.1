Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 355C9767065
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 17:22:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPOjV-0002bj-8m; Fri, 28 Jul 2023 10:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPOjO-0002aT-DM
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:46:14 -0400
Received: from smtp-out2.suse.de ([195.135.220.29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <cfontana@suse.de>) id 1qPOjM-0002eo-M6
 for qemu-devel@nongnu.org; Fri, 28 Jul 2023 10:46:14 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D64B11F388;
 Fri, 28 Jul 2023 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1690555570; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjK0WcW+VdseipPEVAmtlsgx0cyfzA94bhI2+qCxkbw=;
 b=vgKEnAmAXS7ZwPfivFDMc5XxbRVcSDpu9FDx1s74j0xYVXnmRIyBggHQIkuPtUCf0fG2sr
 6+9HrLMxlnvh/LFuUeIqWyfyOFbPeLwPxgDMlkDLoAgvKqNV3iRvuRozkVeM0kGXCyHpDp
 rpxIvbd8dl4bwGdh9GTyEKTvsK8KVUM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1690555570;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mjK0WcW+VdseipPEVAmtlsgx0cyfzA94bhI2+qCxkbw=;
 b=X9pbERDeoRb+cg1j0HN4iFoyxee3wCLRoQZ9A0KuRENPezsG3O/cbttz0Mr3UESxplRtSU
 00Cdpg34HqgkxwCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A1C6513276;
 Fri, 28 Jul 2023 14:46:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 8O9mJbLUw2RDMQAAMHmgww
 (envelope-from <cfontana@suse.de>); Fri, 28 Jul 2023 14:46:10 +0000
Message-ID: <efd25473-9547-f671-cba8-40b9d6c9fc28@suse.de>
Date: Fri, 28 Jul 2023 16:46:10 +0200
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
 <16a9cdba-2f84-7d38-aadb-04524fee51e2@suse.de>
 <a1004734-5eb1-032a-f597-c77aa32eee03@linaro.org>
 <d6e0b264-d56a-92d0-a663-9ee3339ea14f@suse.de>
In-Reply-To: <d6e0b264-d56a-92d0-a663-9ee3339ea14f@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=195.135.220.29; envelope-from=cfontana@suse.de;
 helo=smtp-out2.suse.de
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

On 7/28/23 16:40, Claudio Fontana wrote:
> On 7/28/23 16:28, Richard Henderson wrote:
>> On 7/28/23 07:23, Claudio Fontana wrote:
>>>> It is a test environment for building packages, so the guest at the time of the error is running ./configure for the package swig-v4.1.1.tar.gz
>>>>
>>>> checking build system type... s390x-ibm-linux-gnu^M
>>>> checking host system type... s390x-ibm-linux-gnu^M
>>>> checking for a BSD-compatible install... /usr/bin/install -c^M
>>>> checking whether build environment is sane... [New Thread 0x7ffea3fff6c0 (LWP 116436)]
>>>> [New Thread 0x7ffec14e26c0 (LWP 116437)]
>>>> [New Thread 0x7ffecf73e6c0 (LWP 116438)]
>>>> [New Thread 0x7ffecde2c6c0 (LWP 116439)]
>>>> [New Thread 0x7ffec2beb6c0 (LWP 116440)]
>>>> yes^M
>>>> checking for a thread-safe mkdir -p... /usr/bin/mkdir -p^M
>>>> checking for gawk... gawk^M
>>>> checking whether make sets $(MAKE)... yes^M
>>>> checking whether make supports nested variables... yes^M
>>>> checking for s390x-ibm-linux-gnu-gcc... gcc^M
>>>> checking whether the C compiler works... **
>>>>
>>>> So I presume we are in:
>>>>
>>>> AC_PROG_CC
>>>>
>>>
>>>
>>> I am rerunning this over and over, and it seems it always aborts there in the same place.
>>
>> You didn't say what the host is, only qemu-system-s390x.
>> Am I barking up the wrong tree looking at s390x host?
>>
>>
>> r~
> 
> sorry, no it is an x86 host in this case, running openSUSE Tumbleweed.
> 
> 
> 

(gdb) frame 17
#17 0x0000555555abd537 in ld_code4 (env=0x5555566b9f50, s=0x7ffeeedfc2c0, pc=2929224048640) at ../target/s390x/tcg/translate.c:399
399         return (uint64_t)(uint32_t)translator_ldl(env, &s->base, pc);
(gdb) p env
$7 = (CPUS390XState *) 0x5555566b9f50
(gdb) p env[0]
$8 = {regs = {0, 128, 4396110331904, 2929231704344, 2929231698920, 0, 1, 4294967295, 127, 129, 2929167695872, 2929167695874, 
    4396120469352, 2929227322880, 4393751543808, 4397869291280}, vregs = {{4294967296, 4294967296}, {1, 4294967297}, {1, 4294967297}, {
      4294967296, 4294967297}, {4294967297, 4294967297}, {4294967297, 4294967297}, {4294967297, 1}, {4294967297, 4294967296}, {1, 
      4294967296}, {4294967297, 1}, {4294967297, 4294967296}, {0, 4294967296}, {4294967296, 1}, {0, 0}, {0, 1}, {4294967297, 0}, {
      4294967297, 4294967296}, {4294967296, 1}, {0, 1}, {8589934592, 0}, {4294967295, 4294967297}, {1, 4294967296}, {4294967297, 
      4294967296}, {4294967297, 4294967297}, {4294967297, 4294967297}, {1, 4294967297}, {4294967297, 1}, {0, 4294967297}, {1, 0}, {0, 0}, {
      4294967297, 4294967296}, {0, 24}}, aregs = {1023, 2369217472, 0 <repeats 14 times>}, gscb = {0, 0, 0, 0}, etoken = 0, 
  etoken_extension = 0, diag318_info = 0, start_initial_reset_fields = {<No data fields>}, fpc = 0, cc_op = 15, bpbc = false, 
  fpu_status = {float_exception_flags = 0, float_rounding_mode = float_round_nearest_even, 
    floatx80_rounding_precision = floatx80_precision_x, tininess_before_rounding = true, flush_to_zero = false, 
    flush_inputs_to_zero = false, default_nan_mode = false, snan_bit_is_one = false, use_first_nan = false, no_signaling_nans = false, 
    rebias_overflow = false, rebias_underflow = false}, psw = {mask = 505845723963588608, addr = 2929224048638}, 
  crash_reason = S390_CRASH_REASON_UNKNOWN, cc_src = 1, cc_dst = 128, cc_vr = 129, ex_value = 0, ex_target = 10319062, __excp_addr = 0, 
  psa = 27344896, int_pgm_code = 16, int_pgm_ilen = 2, int_svc_code = 90, int_svc_ilen = 2, per_address = 0, per_perc_atmid = 0, cregs = {
    337013264, 74613191, 118912, 0, 65535, 118912, 805306368, 74613191, 32768, 0, 0, 0, 0, 22298631, 3674210304, 118976}, 
  ckc = 15972532250018284863, cputm = 2251799817033977205, todpr = 4, pfault_token = 18446744073709551615, pfault_compare = 0, 
  pfault_select = 0, gbea = 1026, pp = 9223372036854778665, start_normal_reset_fields = {<No data fields>}, 
  riccb = '\000' <repeats 63 times>, pending_int = 0, external_call_addr = 6, emergency_signals = {0, 0, 0, 0}, 
  tlb_fill_tec = 2929224050688, tlb_fill_exc = 17, end_reset_fields = {<No data fields>}, core_id = 4, cpuid = 18014400747208704, 
  tod_timer = 0x5555566ba530, cpu_timer = 0x5555566ba570, cpu_state = 3 '\003', sigp_order = 0 '\000'}
(gdb) p s[0]
$9 = {base = {tb = 0x7fffe4923a00, pc_first = 2929224048638, pc_next = 2929224048638, is_jmp = DISAS_NEXT, num_insns = 1, max_insns = 512, 
    singlestep_enabled = false, host_addr = {0x7fff07ef8ffe, 0x0}}, insn = 0x7ffedc013740, insn_start = 0x7ffedc00b6b8, fields = {
    raw_insn = 18446744073709550296, op = 0, op2 = 0, presentC = 0, presentO = 0, c = {-10352, 32767, -295710720, 32766, -143555232, 
      32767, 1449893712}}, ex_value = 0, pc_tmp = 93825010474832, ilen = 4007641952, cc_op = CC_OP_DYNAMIC, exit_to_mainloop = false}



