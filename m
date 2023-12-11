Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9A480DF6F
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Dec 2023 00:26:03 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rCpdp-0002E7-Mx; Mon, 11 Dec 2023 18:24:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpdh-0002Dh-P3
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:24:42 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rCpde-0000Ep-L1
 for qemu-devel@nongnu.org; Mon, 11 Dec 2023 18:24:40 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5c6839373f8so3595798a12.0
 for <qemu-devel@nongnu.org>; Mon, 11 Dec 2023 15:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702337076; x=1702941876; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sVML/NmZ7UrHzDCLlaLNOeNkOPfn+GGU4QGv2w/+rUQ=;
 b=h2h2hK1CXLZppLwRrVJk0T8c2T3Q0BtKx+mfKqi3tpBCqqBTp3yc1NCrQFxwgx36i8
 HZ4zZk/k/4OjrDQd929hiRI45blNkrJ52bLU2JvkCvXEa4F3BQEjq/ADoRIHitMXpl90
 wrNIjb8BprN+CXz89SutanIRbF3ayQ5RgmkkwcTqX45ffAXBx4dr7ls1kPnaSWXJX/5C
 KAktZEGVyLsUcYQtjXvsV4T1dysk6W9j+Ts8qi9W6/m4GSIomiTXMwVy1t0wQTvJV4iY
 XbZkTRKRNrf8UJdlTL1wyH6vUQNzqORFD68gAWxFB8Ia9dkeD8YBg8fy0ACaAsOQlPBl
 a+Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702337076; x=1702941876;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sVML/NmZ7UrHzDCLlaLNOeNkOPfn+GGU4QGv2w/+rUQ=;
 b=d7sEKljfxEiB4yLU4hlCWhtdO3NVCoKOFsiwwgmK/F8KnWUzHBLV0skjX5Ba/bG5Dh
 QinsXGj4ajkQdBV9nAP/61t02F+DZyldvNa60RMO+oYh7RNijHSt3eVvXWMXUyl2Ishc
 AIsnLDo8YezA9U8KdHGrnTtDJIRm7R3wqJXwhSXLxeZwUUDhhlmJk1SzHYR10CzDoF/N
 ES8KF3Zv9K/9x8MZTt7qnPLG4hYHbTJ8poLml0DkwCwrZDhfmipi/0vdqemDwVqbUYpw
 hLiGy5O5vvQDBGEnOaVNEnZLvppa2FGs6bCHRPxM26XlY76BpcP8MPeVvJDKyNEl5/nQ
 bsWg==
X-Gm-Message-State: AOJu0YwPYSdjWiVnPI/cRShcieTP6Cir/mzV1wzUKOopojsGcSt8ZtRf
 o6FUyhL7lQu47xafFExlAnSC74mcT25R+4fQpR3/zQ==
X-Google-Smtp-Source: AGHT+IFyxSM1lmLyFWYvGOVqBDrbA+V9MKvbyyVIlKIQSce1DNZSr0ahwF3z9sR5eW/X4aYYtP0riQ==
X-Received: by 2002:a05:6a20:b712:b0:18b:b858:17a5 with SMTP id
 fg18-20020a056a20b71200b0018bb85817a5mr5252575pzb.28.1702337075825; 
 Mon, 11 Dec 2023 15:24:35 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a62ce0e000000b006ce467a2475sm7156727pfg.181.2023.12.11.15.24.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Dec 2023 15:24:35 -0800 (PST)
Message-ID: <e7be515f-b7f3-41d2-8bd3-0e2e213e3b39@linaro.org>
Date: Mon, 11 Dec 2023 15:24:33 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/24] accel/tcg: Un-inline retaddr helpers to
 'user-retaddr.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20231211212003.21686-1-philmd@linaro.org>
 <20231211212003.21686-19-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231211212003.21686-19-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 12/11/23 13:19, Philippe Mathieu-Daudé wrote:
> set_helper_retaddr() is only used in accel/tcg/user-exec.c.
> 
> clear_helper_retaddr() is only used in accel/tcg/user-exec.c
> and accel/tcg/user-exec.c.
> 
> No need to expose their definitions to all user-emulation
> files including "exec/cpu_ldst.h", move them to a new
> "user-retaddr.h" header (restricted to accel/tcg/).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

