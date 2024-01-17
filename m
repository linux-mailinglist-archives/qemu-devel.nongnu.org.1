Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 006CF83016C
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 09:42:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ1Ud-0000Qp-D6; Wed, 17 Jan 2024 03:41:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1Ub-0000PS-6m
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:41:49 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ1UZ-000191-OX
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 03:41:48 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-33678156e27so9254218f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 00:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705480906; x=1706085706; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aMh1hByec0kum6Bq/vfECM33YJogl2Scd13XilaRg8A=;
 b=jV2zcxdNJs5VQPIDCUXI3/HooRJScD9sRRKkSnudn+RMK53M3HpMulS/5bhDk175yP
 j+byrMj5PxjdQdyHdXIconenIAn1a5003uEMI1YAiMeOcr7IMfZgXiy8tuPbOC77xi05
 AapmLB29Q5zL1y4U5fXEdzMD0zJiTn9NzgYX6LDebomgbT+DvsBLObLN/kzk1uIrs20h
 15M+u+A8maC6T3qnK90+1luxalEA0FhCT7f7vJm1awsP3C1cvaAY6ptFMgNme48yFjeW
 0PSZ4wGyf7y39mGm8+0z5EvHmmQtdKFvkt9smc/4aEgYdS4Ljf5qLBB30+gGqUzRSmZd
 mUBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705480906; x=1706085706;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aMh1hByec0kum6Bq/vfECM33YJogl2Scd13XilaRg8A=;
 b=SmUIAD3ykdWf3QwGz/hpX6meIuZasaNmxhTbHHkB90gFIE7jkLc1ZEwFOp9ozfuTcM
 QMxwy9Hc00iLid/euID382ronDIeMl7bjcdNub/UMPxBH1LVwRKXQYmapaX8iMSope82
 AfytkWFapEFCzDJEJutQ1UduAD/dXJC0KI5ZHiqdJ6iXfdHWRtWg9wis+2ymZytIczZK
 9eCU4IpGHS8tN5Cezb/hkgTbWwMr4zT1NG2jkJbWkK4C5nqqQ/TUOymgjJN26ZBbnOWU
 0wfsvTY6ubWfXbJHSmfJpL4uvBmZ4Ig7i0WH1OaNmzncy6nTlSosdSPzoiK9zdf0JhPt
 eMtw==
X-Gm-Message-State: AOJu0YxHfNz+nOGBxDnUnpdf9HzbOlmCMzRNcpguIkyYaKySXzXg6mtU
 ibIZ0v+41/0He4pjDneznSrib5zasiOUVA==
X-Google-Smtp-Source: AGHT+IFfsToE62dJv/0RgOxZPaSLo5z6XmbdIC2QLBeiubRGIG8afXU/fqT8E55v8SZSvdGhVhiWjw==
X-Received: by 2002:a05:6000:1201:b0:337:bfe8:5bfd with SMTP id
 e1-20020a056000120100b00337bfe85bfdmr696145wrx.50.1705480905830; 
 Wed, 17 Jan 2024 00:41:45 -0800 (PST)
Received: from [192.168.69.100] ([176.176.156.199])
 by smtp.gmail.com with ESMTPSA id
 y3-20020adfee03000000b003368c8d120fsm1123217wrn.7.2024.01.17.00.41.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 00:41:45 -0800 (PST)
Message-ID: <d35b7cdb-c996-4682-943e-880ecb3b0084@linaro.org>
Date: Wed, 17 Jan 2024 09:41:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] hw/pflash: implement update buffer for block writes
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
References: <20240108160900.104835-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240108160900.104835-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 8/1/24 17:08, Gerd Hoffmann wrote:

> Gerd Hoffmann (3):
>    hw/pflash: refactor pflash_data_write()
>    hw/pflash: use ldn_{be,le}_p and stn_{be,le}_p
>    hw/pflash: implement update buffer for block writes

Series:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued, thanks!

