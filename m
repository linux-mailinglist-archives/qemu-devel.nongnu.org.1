Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB77EE171
	for <lists+qemu-devel@lfdr.de>; Thu, 16 Nov 2023 14:21:50 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r3cJD-0007To-Aa; Thu, 16 Nov 2023 08:21:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cJB-0007TN-Hm
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:21:25 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r3cJ7-0004af-BI
 for qemu-devel@nongnu.org; Thu, 16 Nov 2023 08:21:23 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-40a4d04af5cso5771325e9.0
 for <qemu-devel@nongnu.org>; Thu, 16 Nov 2023 05:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700140879; x=1700745679; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lzURwf51z/kgo8BUf8SZ1FfJfn+CyvPV4/i5NprL4cE=;
 b=K4Q4lbea75d+0Ec37DQzuZR/u2eXfMNRyzJukHflaJV9WTwyv3JFqZs/0JaKG2eRO7
 xkbkAeqAi75WNGAQOrksq4qUCH+AENaTlVn7h+ckvQ+KFjl4XToF+pYEEvLt4/toaG/3
 j6F0EYQkdmgzZxxBgJlTfHMIYVq+kfa4BPgpasoKkc01uitkYIxATLWcPSauJOOxYCqX
 7GNvRrCrjsQCF975kOhNdMjQwHQy0IX8vYS8/VBoVANf0/iOp+NUDt9mYJvAbszTV9Mk
 9haFj25xADWQ7ieSPQP6wnduLcsoiAF4jC2cBXtziBPqjvxVp32CovyGbERWmgWSxTjm
 Vw4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700140879; x=1700745679;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lzURwf51z/kgo8BUf8SZ1FfJfn+CyvPV4/i5NprL4cE=;
 b=YlEODQSEUt5Ny3WH493mOMkd2lQ6i0GD3lYsyYu5t+PaZNtqux+kjWIw6KDKzxLQrx
 p8NtKwnJGifoLlvGSq/rqMUtXVRmVEd5JUECyVp78aE74nljs4IHI5RjhntA7YIuprFI
 ynin+DKI8MZfQ0dB1BKu5c2AmIAEpv6MuUUbuVbg101plFh+MC9ZU/ROF0iuF9g3RrgK
 eK9AO71GoOnVwRlT5zPZUY4mwIEhNGbN81UaSlB16S189seanxXeISByCXX7m+gdIlHW
 1h10N7w9LYETktpyRgpSglCuGOGdlfi4/Vt84W0D3IHUGoAtBvaF0PvVQWXTXxMUjP4+
 Jv1Q==
X-Gm-Message-State: AOJu0Yw41h+QqEtOtWimZyuDtlfgSEDGneK9IbB1MaI+iwRGrp2OzQ/w
 jlMPF0Fs809gFLZdcsZzCXRSGg==
X-Google-Smtp-Source: AGHT+IEBW6zE4hK786YvZVu2FUlTRxUwAuxjVYFZ9HDVflOY6YmjD1VanV7N/hVdLW+vjKb43k7Gng==
X-Received: by 2002:a05:600c:4f54:b0:408:4120:bad2 with SMTP id
 m20-20020a05600c4f5400b004084120bad2mr11726867wmq.9.1700140879244; 
 Thu, 16 Nov 2023 05:21:19 -0800 (PST)
Received: from [192.168.69.100] ([176.187.220.205])
 by smtp.gmail.com with ESMTPSA id
 z6-20020a05600c0a0600b004068e09a70bsm3718284wmp.31.2023.11.16.05.21.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Nov 2023 05:21:18 -0800 (PST)
Message-ID: <862c25dd-1393-4ffd-9880-2e405ec037ca@linaro.org>
Date: Thu, 16 Nov 2023 14:21:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qom/object: Limit type names to alphanumerical and some
 few special characters
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>
References: <20231114130415.283228-1-thuth@redhat.com>
 <CAFEAcA_LcmowH28KG9LXRQRPFkAbmDCoPz5RDDK0TG+Am-p73w@mail.gmail.com>
 <e04933cf-1c74-4475-8007-888d9d0591f2@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e04933cf-1c74-4475-8007-888d9d0591f2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 16/11/23 12:17, Thomas Huth wrote:
> On 14/11/2023 14.21, Peter Maydell wrote:
>> On Tue, 14 Nov 2023 at 13:05, Thomas Huth <thuth@redhat.com> wrote:

> There just seem to be two stragglers left:
> 
> 1) #define TYPE_DUMMY "qemu:dummy" in tests/unit/test-io-task.c ...
>     easy to fix, it's just a unit test anyway
> 
> 2) #define TYPE_RAM_DISCARD_MANAGER "qemu:ram-discard-manager"
>     in include/exec/memory.h ... I believe it should be OK to
>     simply rename it, since it's about an interface type...
>     Or do we use these interface names in migration streams, too?

No, QOM interfaces aren't part of any state, so not migrated.


