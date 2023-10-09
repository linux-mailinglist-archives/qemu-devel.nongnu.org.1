Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D56777BD3B7
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 08:44:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpjz4-0004Vc-5W; Mon, 09 Oct 2023 02:43:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjz1-0004VN-Bd
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:43:15 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpjyv-0005zG-TP
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 02:43:15 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-9b64b98656bso702956366b.0
 for <qemu-devel@nongnu.org>; Sun, 08 Oct 2023 23:43:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696833788; x=1697438588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TTyDaamtNrrjBHfWRxXnpWF2gt0yHGMNP7oqLm/HbE8=;
 b=EZElrx+clfBLMSo6ul+uNu0Sma3bcTr1SnWAxqEXRE1xlrJfk5pcsfDuiiGKFV9Yy4
 +GG/o/qay5P3SNw6/ah1yU0BiQV1Z03Ua4leIulzzd1goFGlVCmlq1ltfsN5v9rrQQow
 tSB+c6G68Y+uqrgTTT+3nqI00HCb8ni0PtCq/WFF+Vq+SwyntgxteuxhWXCQ+bhGiTJP
 miZLftW+H61vcoGjBiSG2hYkpJLU+imhXuCJfiUL7RUiVC3fpRhJUc11BNKniTPLP55x
 8hyCBRoCsmKxgi1CfBQXXZcjOJ8b7gHIsGNYotTsy6IsFs8/0eJBzo96gndTGEjmvS1J
 ULug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696833788; x=1697438588;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TTyDaamtNrrjBHfWRxXnpWF2gt0yHGMNP7oqLm/HbE8=;
 b=UAGjQOkzXwEnsPO4vvR6v0aMD2yHd36orub4EbIfbqB2nz+eILtGx5sSRczDQmwZqd
 Aya1mHuQrxyOm5udMebzOx8eDGcWa6UVza4soqL6lBJgTI5OhxZzXqrfQXg6toE4JQ58
 xy0KSQTppKdMgY+ih9vv4JKt6vfzi4SXsE464EyYJRuTWRbeBy0mjEtkqHIdCbOuWjVW
 SsLtuHm9V2tdo0AORxLmhp8fhgMGJn9Fxl9oUE0SSav4OXqYak5gceopWKO6RIxx7mAy
 OJbnsT0hhHuNfghrDEXjUU+50Ad+nqEJVgAIvx06oJiP02wAjoy4dEi6Ile9wssEIWlx
 FUZQ==
X-Gm-Message-State: AOJu0YzVitWXj6JMqL5AvLb90U0iyinS8MLpR5fkR6DOpR6rDIdM0Xtg
 DMF1KPup2sW+8tHz6exantS6Ew==
X-Google-Smtp-Source: AGHT+IFJvBzvwDb3WvMEw8ip3PAM7ixIKV3qBl8Yy/tPDCA9/e8/UKqM6s9Ua6h+/7Z557YXiXzsUQ==
X-Received: by 2002:a17:906:5a6b:b0:9a1:e8c0:7e2e with SMTP id
 my43-20020a1709065a6b00b009a1e8c07e2emr12708486ejc.14.1696833787993; 
 Sun, 08 Oct 2023 23:43:07 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 y23-20020a1709064b1700b009aa292a2df2sm6281610eju.217.2023.10.08.23.43.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Oct 2023 23:43:07 -0700 (PDT)
Message-ID: <187100e7-a516-4024-1739-a08c630d76f3@linaro.org>
Date: Mon, 9 Oct 2023 08:43:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v2 3/3] target/hexagon: avoid shadowing globals
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
To: Brian Cain <bcain@quicinc.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org,
 peter.maydell@linaro.org, quic_mathbern@quicinc.com, stefanha@redhat.com,
 ale@rev.ng, anjo@rev.ng, quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>
References: <20231005222206.2784853-1-bcain@quicinc.com>
 <20231005222206.2784853-4-bcain@quicinc.com>
 <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
In-Reply-To: <48c5233c-c294-f50d-a438-f7f6a63c113b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -38
X-Spam_score: -3.9
X-Spam_bar: ---
X-Spam_report: (-3.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.818,
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

On 9/10/23 08:09, Philippe Mathieu-Daudé wrote:
> Hi Brian,
> 
> On 6/10/23 00:22, Brian Cain wrote:
>> The typedef `vaddr` is shadowed by `vaddr` identifiers, so we rename the
>> identifiers to avoid shadowing the type name.
> 
> This one surprises me, since we have other occurences:
> 
> include/exec/memory.h:751:bool memory_get_xlat_addr(IOMMUTLBEntry 
> *iotlb, void **vaddr,
>      include/qemu/plugin.h:199:void qemu_plugin_vcpu_mem_cb(CPUState 
> *cpu, uint64_t vaddr,
> target/arm/internals.h:643:G_NORETURN void 
> arm_cpu_do_unaligned_access(CPUState *cs, vaddr vaddr,
> target/i386/tcg/helper-tcg.h:70:G_NORETURN void 
> handle_unaligned_access(CPUX86State *env, vaddr vaddr,
> ...
> 
> $ git grep -w vaddr, | wc -l
>       207
> 
> What is the error/warning like?

OK I could reproduce, I suppose you are building with Clang which
doesn't support shadow-local so you get global warnings too (as
mentioned in this patch subject...):

In file included from ../../gdbstub/trace.h:1,
                  from ../../gdbstub/softmmu.c:30:
trace/trace-gdbstub.h: In function '_nocheck__trace_gdbstub_hit_watchpoint':
trace/trace-gdbstub.h:903:106: error: declaration of 'vaddr' shadows a 
global declaration [-Werror=shadow]
   903 | static inline void _nocheck__trace_gdbstub_hit_watchpoint(const 
char * type, int cpu_gdb_index, uint64_t vaddr)
       | 
                                 ~~~~~~~~~^~~~~
In file included from include/sysemu/accel-ops.h:13,
                  from include/sysemu/cpus.h:4,
                  from ../../gdbstub/softmmu.c:21:
include/exec/cpu-common.h:21:18: note: shadowed declaration is here
    21 | typedef uint64_t vaddr;
       |                  ^~~~~
trace/trace-gdbstub.h: In function 'trace_gdbstub_hit_watchpoint':
trace/trace-gdbstub.h:923:96: error: declaration of 'vaddr' shadows a 
global declaration [-Werror=shadow]
   923 | static inline void trace_gdbstub_hit_watchpoint(const char * 
type, int cpu_gdb_index, uint64_t vaddr)
       | 
                       ~~~~~~~~~^~~~~
include/exec/cpu-common.h:21:18: note: shadowed declaration is here
    21 | typedef uint64_t vaddr;
       |                  ^~~~~

Clang users got confused by this, IIUC Markus and Thomas idea is
to only enable these warnings for GCC, enforcing them for Clang
users via CI (until Clang get this option supported). Personally
I'd rather enable the warning once for all, waiting for Clang
support (or clean/enable global shadowing for GCC too).

See this thread:
https://lore.kernel.org/qemu-devel/11abc551-188e-85c0-fe55-b2b58d35105d@redhat.com/

Regards,

Phil.

