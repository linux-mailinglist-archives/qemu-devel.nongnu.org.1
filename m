Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A247E91BF
	for <lists+qemu-devel@lfdr.de>; Sun, 12 Nov 2023 18:08:11 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r2DvZ-0003Ud-0M; Sun, 12 Nov 2023 12:07:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2DvX-0003UH-03
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 12:07:15 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r2DvV-0004wu-Cl
 for qemu-devel@nongnu.org; Sun, 12 Nov 2023 12:07:14 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9c603e2354fso748264766b.1
 for <qemu-devel@nongnu.org>; Sun, 12 Nov 2023 09:07:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699808831; x=1700413631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=V4eDBH0B1wyrQjY2Hhhe2UaFe05/5EOmpddl91XbNgM=;
 b=u7S18b9axpiCHnCxPl00DWB0GfLqw8RN9Z+k4wM3Qwv8aoGd5Tj3juqN32nyvYyOU6
 ZYKGu+hRKrRyBmUaAMKn+NRdFx0nwCY0O9V9Ht8Or1saKQTpU+5DQa13zxxxdRNy86mD
 DwHpxTv+uo4XjM0tC+Ey+aYQt6DswPEIoJ7ofKZ4SQ4tgDhUaXQviEQqsKAIvq1er0xg
 Ch12NpAeDqvZIcf8hV2OjU+r+gARIjGo3aDC2ZP296ItpoETwLhq2G0bDkhj7CmoVySm
 M8SMUDdmgdQYsdEMrw7lmSk4Vmc28PkZMc5ueVuXIiTJfMjf+BA6ulLWTdYpopNhdl/h
 RTNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699808831; x=1700413631;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=V4eDBH0B1wyrQjY2Hhhe2UaFe05/5EOmpddl91XbNgM=;
 b=jyCnU/hE7OqehvoIcNTK7L82UdJOFErT0VfvRw5f03KIt+tRyumMCxwQUkE8lIXAiT
 79jVQHAuXEEmqmgafIyMBub2zuLsRj88zKhrBhO5cpovhCo/eZ1kzkOtnEs5Cfs7xicq
 1gX05HA+IZpmu1wP4VSHUTq/aP367tYF0iY/zikwLCaTd91UIJvPjp/4br2a+4NDfjRQ
 S8RK/wHez8XbljE/krdQPOcyHWKAwxh+0jvkSThN+7h9OBusby41B/XmzL5IyShn8Jd0
 wjKpqNc3f95XIMbVroOzRurzl763VPAqCdwYivni/ODepr2z8MA7sm2rfB9VtG9K4Q6q
 xRPQ==
X-Gm-Message-State: AOJu0YyEuv5wjHGCjk7JmAyHg49ivia2o8wFaPTC809bPfMgwMIPq0x9
 68H4ZicbDqPK/sg4aOJ+reY9oA==
X-Google-Smtp-Source: AGHT+IHZqFR4gCgnp/0yoRmKxMoMzAOh3bQ3pwlzRRkLOyy1S04Z7lQ+mvz5kDO7bq8RIIirfryXXg==
X-Received: by 2002:a17:906:7fc1:b0:9e6:2c5a:450a with SMTP id
 r1-20020a1709067fc100b009e62c5a450amr6915926ejs.26.1699808831633; 
 Sun, 12 Nov 2023 09:07:11 -0800 (PST)
Received: from [192.168.69.100]
 (i15-lef02-th2-89-83-217-202.ft.lns.abo.bbox.fr. [89.83.217.202])
 by smtp.gmail.com with ESMTPSA id
 fj10-20020a1709069c8a00b009e7e7c0d1a9sm2129915ejc.185.2023.11.12.09.07.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Nov 2023 09:07:11 -0800 (PST)
Message-ID: <ff2c300b-f125-4ec9-b536-cb36de3371b5@linaro.org>
Date: Sun, 12 Nov 2023 18:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/11] target/hppa: Use only low 2 immediate bits for
 PROBEI
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de
References: <20231111013212.229673-1-richard.henderson@linaro.org>
 <20231111013212.229673-5-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231111013212.229673-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 11/11/23 02:32, Richard Henderson wrote:
> During the conversion to decodetree, the 2-bit mask was lost.
> 
> Fixes: deee69a19fd ("target/hppa: Convert memory management insns")
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/hppa/translate.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


