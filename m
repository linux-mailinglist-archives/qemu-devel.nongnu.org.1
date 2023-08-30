Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BAA5978E08D
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 22:24:58 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbRjp-0006lE-AO; Wed, 30 Aug 2023 16:24:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbRjn-0006l6-29
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:24:27 -0400
Received: from mail-ot1-x32c.google.com ([2607:f8b0:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qbRjk-00075p-JO
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 16:24:26 -0400
Received: by mail-ot1-x32c.google.com with SMTP id
 46e09a7af769-6bf298ef1f5so188057a34.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 13:24:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1693427063; x=1694031863;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J5AMALSbpTvDIIDXan1gEk+pQdMoh+7IcjQ6UJ0J+Ec=;
 b=ML0iOf4aNO2hw6CtUAUVtoVIWfWn+/a6NPDjxsUgGHvO81fezjO+LMtltS3Q/1EisK
 WC7elw5pRFx3eJS0QcuhIyTdKQsmG5XTBqRU2atZzpKon3+qj8lNv/KCrTUEcStL6oCR
 3KnnH4w2/S1yoHBianShnwRO3UAmIthsT7P0trODmnvWKuzAh7gPcvaAc7oMkwOou++g
 zC5BiZwh38ob9GQIdBpMO6jkL+LW+DbfrD/j+a7zjJd07kLm9br0XE0iiO389gL87H4b
 fYNS48Q/YUr/8AEwiswh1SCP2POwmYgS/WtqqLYW63bWFDJ2wIghbd6X1iW2NWezzAAD
 7Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693427063; x=1694031863;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J5AMALSbpTvDIIDXan1gEk+pQdMoh+7IcjQ6UJ0J+Ec=;
 b=kf8yBz0pqkkzw8eAEs2s+Fh35+98i9kTXyU9HlCYfocKJI0Nswjeo+1Oe4/y84sjTt
 4z69OVdTGStRseA0we7sbl5lT0MKt4YUKxb9qqGZCgb5vil0MiYJmqRoG1j+CAP/gUJI
 iojM5t/4ZvhtDNhlr9LEs0z+B2D6VkqsDYMv/LsqKHijBsa15uuJ5kFkOB1wuPUmlkwg
 QSieXrk3dfrwDvlQnDc1ucwfnPt7mz6ch9MB7aM6zmqIsTR7yN8JJOMB+HJQqymCoehF
 4ScctqswtfD5v0xAlnuiZqrzGns3zYnIRpYffAVfgnrkGyATfX6PebvhkFGEOii2Vavp
 mxhg==
X-Gm-Message-State: AOJu0YznHxDURRoZbUHkDN4iv6erbYB3vDZRqMgIFdogad3c9XYNnRg4
 zMhLFccsQAaRrdVkdxz6nBsTPA==
X-Google-Smtp-Source: AGHT+IEmN/whkhuVjvUeP2WzbjAWz9KksNOXqt7ciYVQ7ZlUsIo+f1N2VNcCd99d6UjqFHP4O/K5Dg==
X-Received: by 2002:a9d:74d0:0:b0:6bd:9fa:34ff with SMTP id
 a16-20020a9d74d0000000b006bd09fa34ffmr3340244otl.9.1693427063434; 
 Wed, 30 Aug 2023 13:24:23 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m185-20020a633fc2000000b005642314f05fsm1200pga.1.2023.08.30.13.24.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 13:24:22 -0700 (PDT)
Message-ID: <a3ab68f7-ed60-43af-9268-2905b98b81aa@daynix.com>
Date: Thu, 31 Aug 2023 05:24:20 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RESEND v5 20/26] gdbstub: Remove gdb_has_xml variable
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Mikhail Tyutin <m.tyutin@yadro.com>,
 Aleksandr Anenkov <a.anenkov@yadro.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20230818033648.8326-1-akihiko.odaki@daynix.com>
 <20230818033648.8326-21-akihiko.odaki@daynix.com> <87il8wr2qw.fsf@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <87il8wr2qw.fsf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::32c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-ot1-x32c.google.com
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

On 2023/08/31 0:02, Alex Bennée wrote:
> 
> Akihiko Odaki <akihiko.odaki@daynix.com> writes:
> 
>> GDB has XML support since 6.7 which was released in 2007.
>> It's time to remove support for old GDB versions without XML support.
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> In principle I'm fine with this but should we not catch GDB's which
> don't send qXfer:features:read earlier?
> 

I don't think so. qXfer:features:read was introduced very long ago so 
practically such a condition should only happen with a failing GDB. 
There is nothing special for qXfer:features:read that differentiates 
from many other possible GDB failures that we do not catch.

