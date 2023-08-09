Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DCC77661E
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 19:06:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTmd9-00083Q-5S; Wed, 09 Aug 2023 13:05:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmd7-00083I-Qv
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:05:53 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1qTmd6-0005v4-AC
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 13:05:53 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-3fe1d462762so59967375e9.0
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 10:05:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691600750; x=1692205550;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zXJRvhlNVxhV/ZXt6z1LO0/uMiF+pRiIi1N6kD2x7Xc=;
 b=p4Jg0+BtWWiAhiOjDuwcRCONGAHTt3qosbc7nql5TCScckLrXdVuhTo3wX5DCWkAJu
 893txGktV9X1YRckHC3Jz+6w3PKEhR0gQn43I6dAtAqUTaizUfnxECUbn/YgSvSc6ljh
 oUTIvdcaWUoY0MmjMJHtYBkVfSq9cpOCPOP7o6+wQfLchX6pPQfftrTFJ4TdeqBv5Mde
 nO95pbBI7m+FdAvrv6zKCSHSbF35rPIzrIECsfNgi8igK3xmr0AWHxIP5tU+EF4lO9gi
 KU7LOc8eokotiS8Dw2kONc9mfCvKTR5J98FJdy7NT524A+EYt/5WTGnQUW+fQZ4Nalfm
 WjRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691600750; x=1692205550;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to:date
 :subject:cc:to:from:user-agent:references:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zXJRvhlNVxhV/ZXt6z1LO0/uMiF+pRiIi1N6kD2x7Xc=;
 b=V+qmH3Hksf4/1+0aabWHICtDc48OdKLi229kbfCExyL6DdDKLUrWD4SScwcgqob8Zv
 i/pxXZgQIIFzDXNff76uYBa6AnRsTr5fxmyyVylmRSRMw05bCp+EBa9ylTozyGZCxnf/
 kZrOK1/jnzx+nPWsHAl2hdSx2HwHm9ZUk/Iho9jkFJ9Ri8bREcPCfnBjMTgWM8SZt/pz
 NSfXYXiuQqqMBXy9Tq6stZTGXjjTfHKvViaS0QBAkyGIqjW8bazy8ESbR4T4K24T5eiZ
 azgkBR4YIHYPzS8iYCE6jiVDzdVUnQk67ydTX5ljLlYS8kWReeNif7qmRiKEqvcF6aB7
 r10A==
X-Gm-Message-State: AOJu0YxvOG1ZyHb20+LM5VnTeAlZRi3IZDIzarODpBIij1DL28+E92MF
 U75AputyAqiZ6jWhFQ79mPffKV7YdND98ONvrz8=
X-Google-Smtp-Source: AGHT+IF+BgAqV/rtxxCkysFyJ+eJSFmLxSjjy/b8CE3kkvtIMiKsS1j1g+6qH5tYcGaAhXbY8WWQ4Q==
X-Received: by 2002:a7b:c4cb:0:b0:3fc:f9c:a3e6 with SMTP id
 g11-20020a7bc4cb000000b003fc0f9ca3e6mr2520689wmk.9.1691600750554; 
 Wed, 09 Aug 2023 10:05:50 -0700 (PDT)
Received: from zen.linaroharston ([85.9.250.243])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c00d600b003fc080acf68sm2504762wmm.34.2023.08.09.10.05.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Aug 2023 10:05:50 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C4D051FFBB;
 Wed,  9 Aug 2023 18:05:49 +0100 (BST)
References: <20230808141739.3110740-1-fufuyqqqqqq@gmail.com>
 <20230808141739.3110740-6-fufuyqqqqqq@gmail.com>
 <7bebed42-a081-c2d8-d931-9a12e7258d63@linaro.org>
User-agent: mu4e 1.11.13; emacs 29.1.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Yeqi Fu <fufuyqqqqqq@gmail.com>, qemu-devel@nongnu.org, Laurent Vivier
 <laurent@vivier.eu>
Subject: Re: [RFC v4 05/11] linux-user/elfload: Add support for parsing
 symbols of native libraries.
Date: Wed, 09 Aug 2023 18:04:16 +0100
In-reply-to: <7bebed42-a081-c2d8-d931-9a12e7258d63@linaro.org>
Message-ID: <878rak4042.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


Richard Henderson <richard.henderson@linaro.org> writes:

> On 8/8/23 07:17, Yeqi Fu wrote:
>> This commit addresses the need to parse symbols of native libraries.
>> The base address of a shared library is determined by the dynamic
>> linker. To simplify the process, we focus on the last three digits,
>> which reside within the same page and remain unaffected by the base
>> address.
>> Signed-off-by: Yeqi Fu<fufuyqqqqqq@gmail.com>
>> ---
>>   linux-user/elfload.c | 85 +++++++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 80 insertions(+), 5 deletions(-)
>
> I'm not keen on this.  I would much prefer the native library to be
> self-contained and not rely on symbols in this fashion.

Didn't we have an example build that allowed us to extend the metadata
and insert string pointers into the instruction stream? Did that prove
unworkable? I know there was some hoop jumping required in the inline
assembler but I thought that had been solved.

>
>
> r~


--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

