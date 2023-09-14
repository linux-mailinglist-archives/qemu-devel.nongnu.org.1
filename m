Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 411AE7A0B64
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:16:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgpwr-0000w5-8C; Thu, 14 Sep 2023 13:16:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgpwo-0000vp-EE
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:16:10 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qgpwm-00012b-2v
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:16:09 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1c1e3a4a06fso9910315ad.3
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1694711766; x=1695316566;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YXp0Ut+FB5UDtbASO1P6DlxLBIIFWsMw1xHW2dsVbb4=;
 b=vu6pkkX1tqZbxRXa0H5nKmUb61W0u+VMFN23anWV2+0OTt9lTuxgvs7yEZ9GTe2F+R
 KiLZQ8/0dTzMs2Xvx+JI+TLcuZYy6MzyqTT8Qeq+mkg/ddMCLwVlQYw/D87hXIYyBAth
 M1p8Zh8xqWzjB6XuPo6zvvocE8sMPg4QicQ2k3hvGP+ftdQ+wX+TJ6d2vCpbu6i6P/gG
 LS5djUgVgdqCAVYZXWfdOCcJCevEGy4JomRfXHuaZPEu1Z6kEJJ8GUOP53PLe1WbvvGo
 OVHQSKa+o8fQj8MKQsGkVi3d0LeQE0I+ldUVhKND8mwpjY2M+y15McbQz7EmCAUQyyfV
 ICqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694711766; x=1695316566;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YXp0Ut+FB5UDtbASO1P6DlxLBIIFWsMw1xHW2dsVbb4=;
 b=iSj1bVz/cUp8nzJjGWH7JiBrHOnb5iQf+49xZCggTDCfHgy75nDxDAB0esT4g3w2hV
 MnYSNS2tPqK9VmTjVKYQbGseeUGKBY2zXokiYVd1QVzThk1+VmzEfcWIYc30rWsBsU/f
 FtAmIYLSj5o+8a01HpxLIViNyrVforQZWtUuAn9k7O21ILV97n5r50no7rQ1l+witKPV
 uJW4XjtviKUBEPnY54j6IvOdaJU8xb9FAF+OWVFyZcagyqsoLb+h/JeVhw+Sr+iyWkNG
 l0iKLqU0m3Ik9NSJ6zkfGpAV5ODF7XvdKuZadSB5e+Z5AidIY6+9F/HgbaC/8g3n/LIU
 qXOA==
X-Gm-Message-State: AOJu0YwRDvyRftr9JBcJB1uazKW3RzQhPlxSrzasQ5lP84nNEr2uHq6M
 DeplTz03TIbOeOPB8v64Phgb0A==
X-Google-Smtp-Source: AGHT+IEV0NMgd5JuIC2DhwI1HO1vkcRD//a/o/il5chGR9ItNT030DvBKUNHUOAn1B0gcDZMrIYh/A==
X-Received: by 2002:a17:902:6a83:b0:1bf:78d:5cde with SMTP id
 n3-20020a1709026a8300b001bf078d5cdemr5587592plk.59.1694711766353; 
 Thu, 14 Sep 2023 10:16:06 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a170902a40400b001b03a1a3151sm1836001plq.70.2023.09.14.10.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 10:16:05 -0700 (PDT)
Message-ID: <b354bac2-5bf6-404d-b3ce-4a7df3338a09@daynix.com>
Date: Fri, 15 Sep 2023 02:16:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/12] plugins: Check if vCPU is realized
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Richard Henderson <richard.henderson@linaro.org>
References: <20230912224107.29669-1-akihiko.odaki@daynix.com>
 <20230912224107.29669-4-akihiko.odaki@daynix.com>
 <bf33447c-119f-c4b9-5f80-d4ad6169c708@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <bf33447c-119f-c4b9-5f80-d4ad6169c708@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2023/09/13 15:17, Philippe Mathieu-Daudé wrote:
> On 13/9/23 00:40, Akihiko Odaki wrote:
>> The created member of CPUState tells if the vCPU thread is started, and
>> will be always false for the user space emulation that manages threads
>> independently.
> 
> Per the docstring:
> 
>   /**
>    * CPUState:
> 
>    * @created: Indicates whether the CPU thread has been
>    *           successfully created.
> 
> Each CPU DeviceClass's DeviceRealize() handler which calls
> qemu_init_vcpu(). Ah, what we miss is:
> 
> -- >8 --
> --- a/accel/tcg/user-exec-stub.c
> +++ b/accel/tcg/user-exec-stub.c
> @@ -14,6 +14,7 @@ void cpu_remove_sync(CPUState *cpu)
> 
>   void qemu_init_vcpu(CPUState *cpu)
>   {
> +    cpu->created = true;
>   }
> ---
> 
> Missed in commit c7f0f3b1c8 ("qtest: add test framework").

I think the member is never set for user space emulation since it was 
introduced with commit d6dc3d424e ("qemu: introduce iothread (Marcelo 
Tosatti)")

> 
> Does that help?

That will work, but I don't think it makes sense to set this member 
while the other members related to vCPU thread like the "thread" member 
are unset.

