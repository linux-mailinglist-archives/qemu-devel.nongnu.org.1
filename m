Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7357E3AC1
	for <lists+qemu-devel@lfdr.de>; Tue,  7 Nov 2023 12:06:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r0Jtu-0002kO-PD; Tue, 07 Nov 2023 06:05:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0Jtm-0002eS-Qn
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:05:34 -0500
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r0Jtj-00057U-4s
 for qemu-devel@nongnu.org; Tue, 07 Nov 2023 06:05:34 -0500
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-53dfc28a2afso9306476a12.1
 for <qemu-devel@nongnu.org>; Tue, 07 Nov 2023 03:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699355129; x=1699959929; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4K2J9d83ldHFiX6Kit/m94EXtSLO8C4qjHADXq627NQ=;
 b=wk00VyBPoaAaFn9iPGPm3sAEZhAso1uRQRgh5KrXrC7MNL+0SXiszp79mGL0GYLoT1
 VZpC/fkd/Ra7GUjhPOfashMB3hAH6yEx83b/Y95bdaQBNnek6K99rQ/N3bwVNmmW4eWx
 NWN6zqlhAgwl1M4pVNiPhbgIWsMPwrALAfkBCV8KPfyubZDerW3t9hPVm3JfcY6AoHUi
 IdBQJ/7c0UNHOJNzZesRfxw7HeN7/4kRHjcrCbf7823nGlntqScLWp8gUlsjpejsxCMA
 dPT2NdVCzNAJnMq/VwNLSZ1m5c7YVHgLc/2N5N0v1ro+MnNqy/HUSWjGb07UC2wmt+Ss
 zdKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699355129; x=1699959929;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4K2J9d83ldHFiX6Kit/m94EXtSLO8C4qjHADXq627NQ=;
 b=CBXDnKSphMWuaZHHbYdiovIHbiioZG+LdeMnP9p8+DdXYGM7HZ5mqFfYLLHDuvCOK8
 Gwvw8DpUrNK9ybdwA3RWwDZ1DUQxTaXk+lxiJCRkq1tNcnYYnrvbzqKtB1Y0whX5Vvfy
 +ckLSFMejr0/kDKan3fJixSe+ukAZQzAoptbkYviJKf/8SPQm7Ru04c3+yf3S//LhMDY
 9IYvsNiGcckwuskv0wKL1JE9qT0vvF7uz+iQBnHlddYPH1N9n3B8PTS7y23Rg5vdq21g
 NabUxnw3AIDBzsQPvfigu+qWu3MuOqrYhTeapLof24mvXc7bdac/fSk//LF9IlixGdDU
 iP7w==
X-Gm-Message-State: AOJu0YwGl6IfhGXKSp2+ntX/eSC8y52CKs4JQvSyhdkn0ND52RxK41dY
 LogmTdtbOv+VhW0Wt5Tj0AxbbQ==
X-Google-Smtp-Source: AGHT+IHdj4JD+/zmbDoIA9CZVqdIJr/0qRTTxmo6ciyHTf8vMWCb7Al7WF0Exn65824ExmRGsJr1aw==
X-Received: by 2002:a50:bb08:0:b0:530:77e6:849f with SMTP id
 y8-20020a50bb08000000b0053077e6849fmr26925586ede.27.1699355129400; 
 Tue, 07 Nov 2023 03:05:29 -0800 (PST)
Received: from [192.168.69.115] ([176.187.216.69])
 by smtp.gmail.com with ESMTPSA id
 u24-20020a50d518000000b0053e07fe8d98sm5455414edi.79.2023.11.07.03.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Nov 2023 03:05:29 -0800 (PST)
Message-ID: <0f0b4c0e-63c5-4388-8b21-f13594f03094@linaro.org>
Date: Tue, 7 Nov 2023 12:05:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Add include/hw/xtensa/mx_pic.h to the XTFPAG
 machine section
Content-Language: en-US
To: Max Filippov <jcmvbkbc@gmail.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
References: <20231107102104.14342-1-thuth@redhat.com>
 <CAMo8BfKAwHJLK44FjJ_bCK7tkQjvM=USpu_jL+0jAk2ou+Bscg@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAMo8BfKAwHJLK44FjJ_bCK7tkQjvM=USpu_jL+0jAk2ou+Bscg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52c.google.com
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

On 7/11/23 11:44, Max Filippov wrote:
> On Tue, Nov 7, 2023 at 2:21 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> These machines are the only user of the mx_pic code, so the
>> header (which is currently "unmaintained" according to the
>> MAINTAINERS file) should be added to this section.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   MAINTAINERS | 1 +
>>   1 file changed, 1 insertion(+)
> 
> Typo in subject: s/XTFPAG/XTFPGA/
> Otherwise:
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued with typo fixed, thanks!


