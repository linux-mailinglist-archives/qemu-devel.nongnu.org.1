Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFF68275A4
	for <lists+qemu-devel@lfdr.de>; Mon,  8 Jan 2024 17:46:36 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rMslQ-0004mS-6i; Mon, 08 Jan 2024 11:46:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMslM-0004m1-Ts
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:46:08 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rMslJ-0007tg-RZ
 for qemu-devel@nongnu.org; Mon, 08 Jan 2024 11:46:08 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3375a236525so1922283f8f.0
 for <qemu-devel@nongnu.org>; Mon, 08 Jan 2024 08:46:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704732364; x=1705337164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KXvbBEkJ2YEZQ/1hX4sUWoCHwXflhHJTZZGzdRhdH0w=;
 b=VrUJRLZUro4csYbkI/lLFmy9SdSqoH8Jxfuk3feqPBBuspWlk++2oER1JyD1bs+D/a
 OgM3zb+ihVnMKkH4hTzdJcq8BKUMUXlkpHaA5k85ggqK+LrpAUSC28S8fiEMglbfxClz
 l3ZnougcdmdvIXhLsDTacBohHDRLl7bN4FdJ+AjRDArSCZgsl6OJNUSImT6ORMRGV67w
 jfhCQ9Yq2oya3awxMzIis3nmwfFd4K/iyJUo47CVNh+OqpFyxznki4UBHCuHZxg/SmPD
 bfgiFDOKbqKoUP/0BOVcwtCuPavxZMfFS/FfKvd8gCZfr35Jq/4Uf1Odim9L1oUP8K0P
 zSAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704732364; x=1705337164;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KXvbBEkJ2YEZQ/1hX4sUWoCHwXflhHJTZZGzdRhdH0w=;
 b=OoMYGVl0ueX8WS7RXXwmcahIwmALldPTOBWvQIOG9RdDJ6c0JwAIZScjX3ll8JWPeo
 fkoPNv99+Z/2j+y5CnoQ/53ajMXibKklQIJo2JwOtl4TcA6sedx+M68ju5IWImqiATOf
 o9QAmFcdcxhEmTYqGPLXB8VTjvwluKQGhGd28NWYq67BGwAXgGuElVuk1OFDQrfgpv16
 hDFEyUuO/JHpFxrrVqty00o/QqJZp1n5a3s+7S3Ot3cFZJdpSKe31UOUefGVEFzde/2u
 /SsjZWy62siah0vEXcEHqWMABp7yBEAu2f7gdOUjcz1hYGVu/wjNZapKCKHD8gdKiMcg
 QkGA==
X-Gm-Message-State: AOJu0YwptAaFyXCO3PgU3FBIa7EOblIqc7ZWAKOFKM4pwdrjoGwClZ1o
 SVCS8VjlZiYlGn4uE81b63TWGCHtm/cPGw==
X-Google-Smtp-Source: AGHT+IHJWtI431ULoCGNhdRnt8m/sZ16+eLgIMFEao0h4H+jZ1mD2Cgs7u8dLuBtz6XvXA7U4p0b+g==
X-Received: by 2002:a5d:6e84:0:b0:336:6ed3:2ead with SMTP id
 k4-20020a5d6e84000000b003366ed32eadmr2059581wrz.17.1704732363830; 
 Mon, 08 Jan 2024 08:46:03 -0800 (PST)
Received: from [192.168.1.102] ([176.176.175.62])
 by smtp.gmail.com with ESMTPSA id
 l17-20020a5d4bd1000000b00336a1f6ce7csm102034wrt.19.2024.01.08.08.46.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 08 Jan 2024 08:46:03 -0800 (PST)
Message-ID: <8ce11ebb-a1c4-425b-8505-20da142c0b8d@linaro.org>
Date: Mon, 8 Jan 2024 17:46:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] target/xtensa: use generic instruction breakpoint
 infrastructure
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231130171920.3798954-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

On 30/11/23 18:19, Max Filippov wrote:
> Hello,
> 
> this series makes target/xtensa use generic instruction breakpoint
> infrastructure removing its use of tb_invalidate_phys_addr. It also adds
> a new TCG test checking relative priority of icount and ibreak exceptions
> for target/xtensa.
> 
> Max Filippov (2):
>    target/xtensa: use generic instruction breakpoint infrastructure
>    tests/tcg/xtensa: add icount/ibreak priority test

Thanks Max, series queued.


