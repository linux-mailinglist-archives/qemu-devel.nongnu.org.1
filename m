Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 13218816709
	for <lists+qemu-devel@lfdr.de>; Mon, 18 Dec 2023 08:09:57 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rF7kQ-00077A-Hw; Mon, 18 Dec 2023 02:09:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF7kK-00075C-Q1
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:09:00 -0500
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1rF7kJ-00047n-6n
 for qemu-devel@nongnu.org; Mon, 18 Dec 2023 02:09:00 -0500
Received: by mail-pg1-x529.google.com with SMTP id
 41be03b00d2f7-517ab9a4a13so2274190a12.1
 for <qemu-devel@nongnu.org>; Sun, 17 Dec 2023 23:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1702883337; x=1703488137;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mIVFXMcwP6QzSVmitYE3IKYSkOtj5DzYWn2XIM4hTS8=;
 b=av5qORBIN1woRu8YxpFkK0s8NnOxavlZajM11US8fNy7n0Ikl8NhzShHvG9BXE0W49
 pgk1S9NPp7X4Cpz243rt/YZKvrxqDdiSgwdx9TQ8JbcIVLqZ6dqzotyVdPQD5KCvmiVF
 buihg1iPDNfX00eacTmfdZ9CbATLEvf59bmNvO9yLvBPviyUxvNCUZ1vP8TpJn7jd4S8
 JBhxp3E4wrvRQvtKe2wMtaSnxIgDeLtlEsaUwx1wWyMXGi4Bqgt8tB9tFIoifcubzT8f
 gL6EafjpKuOpYy7ffyObIDYMZnYTMzHiPUcTb/nh83OPVMHNHTd0Hy9WFa4Tq6sKZbqr
 gW2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702883337; x=1703488137;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mIVFXMcwP6QzSVmitYE3IKYSkOtj5DzYWn2XIM4hTS8=;
 b=CbvRc8MlJ3fachWDuxBV8hGbwkN7sqw708e40qkzlmNUT8kYke+adTMhtthzODp6r8
 elaSdUslBCaxqFzfsOoSLqPc0CbqEZlDI917MuhJNiasf54orLpkRgzJ0WEzG86mKxEs
 X8SEg/pKYwZCkvcoYExRm/PwnHzEBfZWIeZ2deyhTHLOU1dpBjSGmzTMXsSOKNAslH22
 II8rlxysqIgkHlSwzBoI5RBPU9Qpi1GHZiK7+JOPRNxbk/qfNnPWOcdNRaqCo2BCAqWi
 PgwXrT4/QyvxzDYDKXfUBjthQjdYRyghSPiT10ugR7lEG59EBkSZVNyEZoU58jyX3Jqk
 hnsw==
X-Gm-Message-State: AOJu0YwGq7ntVbrJWaXO9DesFmJBkXzAQ7m4wcoyLVq9uqWIvhCwpGif
 K30SJbZCaxPtG6mBxQn8EDl/bw==
X-Google-Smtp-Source: AGHT+IGFDLhzE2k6TOu85Fu0y/RJ7f/kinYZTzZObk/jOVF0r4uMNGzFBJoD8+9+4KZmXPb0qV2+0Q==
X-Received: by 2002:a05:6a20:3a87:b0:18f:97c:8a40 with SMTP id
 d7-20020a056a203a8700b0018f097c8a40mr17626014pzh.107.1702883337665; 
 Sun, 17 Dec 2023 23:08:57 -0800 (PST)
Received: from [157.82.205.15] ([157.82.205.15])
 by smtp.gmail.com with ESMTPSA id
 b16-20020aa78710000000b006d7daf2f744sm898081pfo.122.2023.12.17.23.08.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 17 Dec 2023 23:08:57 -0800 (PST)
Message-ID: <d8f7d676-56a7-49c6-bb7b-5fa957f4e4cc@daynix.com>
Date: Mon, 18 Dec 2023 16:08:54 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] audio: Do not include ui/dbus.h
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@gmail.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Laurent Vivier <lvivier@redhat.com>,
 qemu-devel@nongnu.org
References: <20231217-dbus-v5-0-8122e822a392@daynix.com>
 <20231217-dbus-v5-2-8122e822a392@daynix.com>
 <CAJ+F1C+MSBdmtebUiiHZVMAxsT6e=diU5_c97u_hgbxON6a4Ng@mail.gmail.com>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <CAJ+F1C+MSBdmtebUiiHZVMAxsT6e=diU5_c97u_hgbxON6a4Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::529;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x529.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/12/18 16:06, Marc-André Lureau wrote:
> Hi
> 
> On Sun, Dec 17, 2023 at 10:14 AM Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
>>
>> ui/dbusaudio.c does not depend on ui/dbus.h
>>
> 
> It uses dbus_win32_import_socket()

Oops. I withdraw this patch. Please dismiss it and review only the first 
one.

