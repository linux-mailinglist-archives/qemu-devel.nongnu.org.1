Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A3F980DCD4
	for <lists+qemu-devel@lfdr.de>; Mon, 11 Dec 2023 22:23:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCnjI-000451-Gh; Mon, 11 Dec 2023 16:22:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjH-00040k-01
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:19 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rCnjB-0005i4-Bw
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 16:22:18 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-a1e2ded3d9fso606434366b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 13:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702329731; x=1702934531; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pHOOtAnxrumGhcPX3MIHrVqNAKP2pZj98HD0RrLMt7c=;
 b=yz7aW7jimj8KeyvkTy9Qoiag/AV4enzWhRKg0on5bO84ZxkBy7R+Madqsi/7qGC069
 hwoJoiKwQHjJi6CLr7niYQXZ/leUurpgsNbPUxLkyChUeBy2DJyvIJdCHxZf12vBCnt/
 8+APqd6tyzhm8/us4PIUZxnMvKv2qbpnu972yk8aJf/4HgsOg4QKdVymDPlRMhNxeZ9r
 tMTxrmaLskl4fPQQslz1N7571bSnsJvsLo/fRUsROmPIxm4suEKi810kMOxDpzVkWKmM
 c3xR0PNVaLZBl52YQqfZ1vTfEdscU9hrQ6ShHJQwLl04TS9Gxr8ByqOqUyo/jZZQEs6m
 fpLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702329731; x=1702934531;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pHOOtAnxrumGhcPX3MIHrVqNAKP2pZj98HD0RrLMt7c=;
 b=lGxyopXIl8ZIQg7VSEpohZpJ7e4AIqUCpTbi7P89TDVS2yOAw+2LN2eOZoFgrLNEg3
 D2s/EMh9xlv+TFKgTD0tAxJyvFo6Wd03QkreCLBLAwkSVn0P4Ie+bv5Ek/jXrrh/ysD5
 3K11XYi37LK4zB0Be8YhOojw/StCBl6G+kBztoxsCKnkwqZVA8ZpxQOGiXelQ8sAXtpA
 hWTx+Ug3G5BAGgI8iIIr8H6z9Uty4FxtWuCg1Wa6CuyXXzVJmfB8i6hqZod/OaH7LTGq
 5/674nzviWl7CoXO7r8irqkwxncIPBEKUg8+1G63EGVzwzC5tpetxlxTHDGt3OefI108
 3svQ==
X-Gm-Message-State: AOJu0YyMjijUeWgTUw3O2upwWBgnGvMhX0W8YiPrmRDcG5Rvvea6jPD/
 B42id3y+yW/6RxJaYUfBdUWQy8/v0v2nxAcLpgsTag==
X-Google-Smtp-Source: AGHT+IFfbsKA8wfC8skTB/yoF3/ySzTZdf5W7q0m1rGxxrtoSwlumHzcEZ+qPSObAal65lz1rrWhJg==
X-Received: by 2002:a17:907:9057:b0:a1f:786c:1b6a with SMTP id
 az23-20020a170907905700b00a1f786c1b6amr2301410ejc.52.1702329731750; 
 Mon, 11 Dec 2023 13:22:11 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 tj7-20020a170907c24700b00a1c522990ccsm5332007ejc.85.2023.12.11.13.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 13:22:11 -0800 (PST)
Message-ID: <b977d019-52cb-47d3-88c1-b354db8b330d@linaro.org>
Date: Mon, 11 Dec 2023 22:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/24] exec: Rework of various headers (user focused)
Content-Language: en-US
To: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Alessandro Di Federico <ale@rev.ng>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Peter Xu <peterx@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Claudio Fontana <cfontana@suse.de>, Brian Cain <bcain@quicinc.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20231211212003.21686-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231211212003.21686-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

(Forgot to Cc rev.ng folks)

On 11/12/23 22:19, Philippe Mathieu-Daudé wrote:
> Hi,
> 
> These patches are extracted from a bigger work where
> "exec/{exec,cpu,translate}-all.h" are split in various
> specific APIs. This helped:
>    - differenciate/build:
>        . user VS system
>        . target-specific VS generic
>      which is necessary for heterogeneous build
>    - reduced header pressure
>    - clarify APIs
> 
> This series is focused on user (vs system) cleanups.
> More useful changes will come after.
> 
> Regards,
> 
> Phil.
> 
> Philippe Mathieu-Daudé (24):
>    exec: Include 'cpu.h' before validating CPUArchState placement
>    exec: Expose 'target_page.h' API to user emulation
>    target: Define TCG_GUEST_DEFAULT_MO in 'cpu-param.h'
>    accel: Include missing 'exec/cpu_ldst.h' header
>    semihosting/uaccess: Avoid including 'cpu.h'
>    semihosting/guestfd: Remove unused 'semihosting/uaccess.h' header
>    host/load-extract: Include missing 'qemu/atomic.h' and 'qemu/int128.h'
>    host/atomic128: Include missing 'qemu/atomic.h' header
>    hw/ppc/spapr_hcall: Remove unused 'exec/exec-all.h' included header
>    hw/misc/mips_itu: Remove unnecessary 'exec/exec-all.h' header
>    hw/s390x/ipl: Remove unused 'exec/exec-all.h' included header
>    target/i386: Include missing 'exec/exec-all.h' header
>    accel/tcg: Include missing 'hw/core/cpu.h' header
>    gdbstub: Include missing 'hw/core/cpu.h' header
>    exec/cpu-all: Remove unused headers
>    exec/cpu-all: Reduce 'qemu/rcu.h' header inclusion
>    target/ppc/excp_helper: Avoid 'abi_ptr' in system emulation
>    accel/tcg: Un-inline retaddr helpers to 'user-retaddr.h'
>    exec/user: Do not include 'cpu.h' in 'abitypes.h'
>    exec: Declare abi_ptr type in its own 'tcg/abi_ptr.h' header
>    exec/cpu_ldst: Avoid including 'cpu.h'
>    exec/cpu-all: Restrict inclusion of 'exec/user/guest-base.h'
>    exec/cpu-all: Extract page-protection definitions to
>      page-prot-common.h
>    target: Restrict 'sysemu/reset.h' to system emulation


