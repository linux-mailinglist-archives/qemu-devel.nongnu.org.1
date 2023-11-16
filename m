Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B37337EDC62
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:52:39 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3XAx-0003JW-6U; Thu, 16 Nov 2023 02:52:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XAv-0003G3-Gi
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:52:33 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3XAt-000165-Py
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:52:33 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-32f737deedfso335139f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:52:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700121150; x=1700725950; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RWuu26MSVGnxWPCs7sTkKg1s6DMwMXLKcNAVvmmemuA=;
 b=C1Rjbf77dHn7VDnPNdzsFTRzcBf/JArl6VQAS0fK08lZ16csccE8LMi57ZppmHtj6j
 8WjZL1uO3Cb5ZDueBvVg5Yvhxm06vzRgLdg39fnmOC2+Sn1aP3XvVlUnQflHhBESry9E
 xaIUuLwoJpTzME9GroNNdaIshAnOnT3KV34RrrYJd8qsBC0GLwS/N2+LX13Cdsk9k3Gn
 H4KVjxsXy0Gh55Nu39jlbHGbggSCKfycE93pEXV3mEteFhYLZFSVoN15vUdk9MfVtK1j
 zxdPz//uqXtITrruWMrPQOul8DU5jX3/b7/rq3J9BPJECRhgCjzcnVTosSTgoctsgN7g
 saUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700121150; x=1700725950;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWuu26MSVGnxWPCs7sTkKg1s6DMwMXLKcNAVvmmemuA=;
 b=NQin8ZxkK9jAMDw3VKKtZn2No4g772R+OzWSgI6jK3JskPWs2S++UGixsWZYwBhGIM
 Mk/O3yCpuH7Yd2YfWTZ1otsWgP1EN6pubgZNcQfApmVMrGk7P9nqhMT/spYzuhkRfku+
 mSiWdcqQn/4o4Q3sKDdxwCMhljW1bMCDObmwz0qUBaLlCEfd3BfEKBbPWX4iMBds+AWd
 /LXHw1lC+nlTI9zfoBv5cNbeFWmjaxXZL75oAppycfeuRF8TnElA/1IAfFiqMKM3rBPj
 uQMqfL3Ge1FauWoaj7MOtZzV7aEIGPb2mGgZVuML9HlslhWqKCwXw20Bov+jbhrs/Ire
 huHg==
X-Gm-Message-State: AOJu0YxDlkCyDKLb5IvlVCzkBCcKd69+h1nX/wFXQAAQWOivlyK3i59m
 ans04FQCVOk4k2kyuaMF7ZcVKw==
X-Google-Smtp-Source: AGHT+IFUA+xqyZQcJV/cmZGtjOamkdJGdlBtHGcfaRM+ALmFAnmEsEs+zIKN9UCep9Gs4sRWm17eVw==
X-Received: by 2002:a5d:59a6:0:b0:32d:b2e0:ed76 with SMTP id
 p6-20020a5d59a6000000b0032db2e0ed76mr13720275wrr.49.1700121150443; 
 Wed, 15 Nov 2023 23:52:30 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 m4-20020a056000024400b0032fb0e2087asm12582889wrz.82.2023.11.15.23.52.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:52:30 -0800 (PST)
Message-ID: <2aa0fcb3-8118-4eb9-8f8c-a9a56b9f732b@linaro.org>
Date: Thu, 16 Nov 2023 08:52:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/31] target/cris: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, qemu-ppc@nongnu.org,
 imp@bsdimp.com, kevans@freebsd.org, richard.henderson@linaro.org,
 pbonzini@redhat.com, peter.maydell@linaro.org, imammedo@redhat.com,
 b.galvani@gmail.com, strahinja.p.jankovic@gmail.com, sundeep.lkml@gmail.com,
 kfting@nuvoton.com, wuhaotsh@google.com, nieklinnenbank@gmail.com,
 rad@semihalf.com, quic_llindhol@quicinc.com, marcin.juszkiewicz@linaro.org,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, wangyanan55@huawei.com,
 laurent@vivier.eu, vijai@behindbytes.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, bin.meng@windriver.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, mrolnik@gmail.com,
 edgar.iglesias@gmail.com, bcain@quicinc.com, gaosong@loongson.cn,
 aurelien@aurel32.net, jiaxun.yang@flygoat.com, aleksandar.rikalo@syrmia.com,
 chenhuacai@kernel.org, shorne@gmail.com, npiggin@gmail.com, clg@kaod.org,
 ysato@users.sourceforge.jp, kbastian@mail.uni-paderborn.de,
 jcmvbkbc@gmail.com, shan.gavin@gmail.com
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-11-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-11-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 15/11/23 00:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-cris -cpu ?
> Available CPUs:
>    crisv8
>    crisv9
>    crisv10
>    crisv11
>    crisv17
>    crisv32
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-cris -cpu ?
> Available CPUs:
>    crisv10
>    crisv11
>    crisv17
>    crisv32
>    crisv8
>    crisv9
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/cris/cpu.c | 38 --------------------------------------
>   target/cris/cpu.h |  3 ---
>   2 files changed, 41 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


