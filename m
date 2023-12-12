Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C47D280E9DB
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 12:11:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rD0eI-0000s1-Eq; Tue, 12 Dec 2023 06:10:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0eC-0000rK-KG
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:09:56 -0500
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rD0e9-0002XV-4j
 for qemu-devel@nongnu.org; Tue, 12 Dec 2023 06:09:56 -0500
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2c9f099cf3aso83101801fa.1
 for <qemu-devel@nongnu.org>; Tue, 12 Dec 2023 03:09:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702379390; x=1702984190; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KNbxQVyn2jk2N+B84Cxn+gXD+XfZeL9bIb/cDyyNmWM=;
 b=AIDEGvbI6Sx4L1uci0xyLJSV34aqfPCIGj26JY250p/TR5I3aUK12f2amS8c+1fF0T
 3Vc4ujjBir0RcG1m7dHzWB0cu83CzHtjprB/XABLvktDkp4uwlPmpRi2z1+Sf0d4UOZl
 zvfmgixZN7d6kyOvtcC37qca0GpDTWvArcKTHDhTsUbr6fu7jWoGl3tQMJxxr9598F6i
 cMWm4RLQzLVF97qdauPMhkLstuDcHbd+UeXCR0EXrqbHMhTMWBmiG2+Fv51KY00KA/p0
 8gU9YesBeL9MNcQtXYWxygxqxv4KAPCd2WcrzEJwdZyfoE9U4jMv4y0Wyws2BBFeoH/D
 OmQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702379390; x=1702984190;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KNbxQVyn2jk2N+B84Cxn+gXD+XfZeL9bIb/cDyyNmWM=;
 b=YuK4gqJ1yq6EKUviVTrjghPQMNJLRgOvded6DlJ8ECYOKC8XZOV/iKWYO384XBcFCu
 n6wgl00HmLuT8pqzHELoYjBTUsIALBh8yJBqbsQWOC/FQlVHjx/Yi43vJ7twLFCF4Ptm
 hMN60iKbKDLac1NvDJE489EHWs0WiE1BT4MI4jdlvajRzcyG0YZTevpM6qaXq9mMZQPD
 kMp/gBhPeCooXeufk1r+O2ioFQMNkNUn6W72ALc8X0NDg4C0FhpR7BivXyWW/9B4nY8U
 hEBI+6g3yrDq6YnffrF4lOMu0dzL5/1TNSsGX4pD0y7kkYWlPkLWdPpiJ261SVpSzYs3
 kT6Q==
X-Gm-Message-State: AOJu0YwTvsQbJ72mbTDMAeqUtNzbRYDOBIrw8MjOTsRQ9jfdfKWSJ8SS
 44uIYb60uaTNO/5wawvy5DTw8A==
X-Google-Smtp-Source: AGHT+IEf+Cnvmwn0GdfrThon8dNN055odG5AEPQ+vegqBm/AMPVYgP60Hkgjt7P744GEiZYQQIrKKg==
X-Received: by 2002:a05:651c:997:b0:2cc:21cb:4192 with SMTP id
 b23-20020a05651c099700b002cc21cb4192mr2609179ljq.97.1702379390393; 
 Tue, 12 Dec 2023 03:09:50 -0800 (PST)
Received: from [192.168.69.100] ([176.176.175.193])
 by smtp.gmail.com with ESMTPSA id
 o20-20020a17090611d400b00a0d02cfa48bsm6089725eja.213.2023.12.12.03.09.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Dec 2023 03:09:50 -0800 (PST)
Message-ID: <f19ce7e7-9f9a-44f2-b315-5705fe24dbcb@linaro.org>
Date: Tue, 12 Dec 2023 12:09:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] accel/tcg: Make use of qemu_target_page_mask() in
 perf.c
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231212003837.64090-1-iii@linux.ibm.com>
 <20231212003837.64090-2-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231212003837.64090-2-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 12/12/23 01:34, Ilya Leoshkevich wrote:
> Stop using TARGET_PAGE_MASK in order to make perf.c more
> target-agnostic.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   accel/tcg/perf.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


