Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 45D127EDBC9
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 08:09:56 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3WVH-0004wa-Il; Thu, 16 Nov 2023 02:09:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WVD-0004wA-2C
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:09:27 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3WVA-0000Kt-GD
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 02:09:26 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4083f61322fso3327455e9.1
 for <qemu-devel@nongnu.org>; Wed, 15 Nov 2023 23:09:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700118562; x=1700723362; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=itpIvRPGh2BcrSYp0/DZr3YvPo92ZkJr+NW6dvwhfQQ=;
 b=wRB+St32uRwPzpGnPYEXbyP6aElvOhQu5HaqcM1+QmrZ1aDpU7MsOkyC9v62S+8Ayj
 cXIQ3pjr4rub6XNOGQLl+5KAou7TLEQc7TGIx7V9RQipglh4xkoK7BEkCIuZlJi8wQ1M
 LxkVzuRigy0nW+nGNomvyC5fXu7PnR1hqXuhNdPUCHFEklWEpQvqRghAtI7aRr7xklP/
 8p5qLFg9I5DY9hJODaoCyGIPQX031gwaRM3pD05GcW8llK9cArFi+n43Xmtg1D9ExGWr
 hzugvb7ZHnH2YAVGh2LxWfkm0HGaUTP5sFdJNojbDZigrTY8/PCrfqP6u55O27c0KRvO
 wwvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700118562; x=1700723362;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=itpIvRPGh2BcrSYp0/DZr3YvPo92ZkJr+NW6dvwhfQQ=;
 b=Gq32s45mbQ/OoxKItrR09o0kLdbAjlFbyC5LiEBcy2hMOiL7TCsD9TL7eOiUiOdIIJ
 7r7AON36noAA6DTRTXN2dkyjzjt2ccLXiivo5w5pw/4JuI5PdkdTZN7sWauk8WxqfhJZ
 3IefoCIgCz6HA85OBscYyErOxU7KQJ0lobM3ZZRxcEzQ4nnyo4Up32tg/pzfsXc8jNYl
 VOo8xh2P/vT7o3JZCyLH+I/2YmbsUqCb/09aKUQT1VMQvh3r1LB7ECk44qGFDE4mu+Yb
 4Nwa08LuKrHL0SALmP7xQQrTQjbBAXOtteRzd8qpSIOxd7rD0wmfpuZVoysL5JQCOmDK
 nMIw==
X-Gm-Message-State: AOJu0YwYJPF0+ZMpCY8wH9xdm51MPCzUudgIYqlrRS4IcY2VQ5OzHCKt
 EdDY6QRP99xJjBzxAM0bxbCkgA==
X-Google-Smtp-Source: AGHT+IGqUAaU90nIUIyonOF6KIpWQhK/AN0ibsABcCfFXtuCnnsQ3KP9F17cpXYHD+C8P/ipdK3KOQ==
X-Received: by 2002:a5d:6483:0:b0:32d:9876:571c with SMTP id
 o3-20020a5d6483000000b0032d9876571cmr12918721wri.63.1700118562235; 
 Wed, 15 Nov 2023 23:09:22 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 n7-20020a5d4847000000b0032d88e370basm12580260wrs.34.2023.11.15.23.09.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Nov 2023 23:09:21 -0800 (PST)
Message-ID: <54a0922f-c10a-44a6-9a5e-26acab83f096@linaro.org>
Date: Thu, 16 Nov 2023 08:09:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/31] target/hppa: Remove object_class_is_abstract()
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
 <20231114235628.534334-3-gshan@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231114235628.534334-3-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 15/11/23 00:55, Gavin Shan wrote:
> No need to check if @oc is abstract because it has been covered
> by cpu_class_by_name().

Since commit 3a9d0d7b64 ("hw/cpu: Call object_class_is_abstract() once 
in cpu_class_by_name()") ...

> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/hppa/cpu.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


