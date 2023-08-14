Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196177B4A6
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 10:51:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVTGu-0000FY-EO; Mon, 14 Aug 2023 04:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qVTGs-0000FA-ON
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:49:54 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qVTGq-0004xK-Lh
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 04:49:54 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-5236b2b4cdbso5199825a12.3
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 01:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692002990; x=1692607790;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=vHed+cI8WwN0W75+6FogRDEwr6sVO/ERyhD23Ehy2uA=;
 b=Vv8aC07AlvUXlwc94SvlB8hLicOG9UtOQMB8oTjunEMN4O2Qo+aVa85Va8AXCwaP4L
 ztjex0Gu38bs0t61iAfY/8WRdt7omceFoGNd5oRNDWYQI7XPz4qEvw4bPVWx0RQ54xr+
 tLV8Uj5BWIiBQlKqDicrmi51hukmbO4UH2/JyspgkxTaT5XWUOHtYxvA4ecThvugeZrF
 q+fz1rzOD4uvstCWaUhwj+xmy6kEO9ZeVhI3Ht0HXzCk40kBtBoU+5mTeHfE9s1VPwwU
 ZwJ6KcT6GnuXZ6aHRpXsUbH5W4tVL5IHRXlrhedS/alQSp99/nisD/PkCrVyxHCvoQjU
 hBTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692002990; x=1692607790;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vHed+cI8WwN0W75+6FogRDEwr6sVO/ERyhD23Ehy2uA=;
 b=ko4B+GYWuDJfpFn/e3boY6lBUIJBU4KM8OhuOGkS9JbcTQJwzaKwcCTF4LyqBYpS2D
 YAE3fetocjbyU0Y7lwtu74FC75tdGENs0tdDxh+qRW69vSseVG4XPBapc4eMj4d5opgP
 nRrbIoKMAktqgAQcRynOAXChc89QxtX6+BcF3maxgEvdfQsyoAM573zIK0O6V+cnMh6M
 DYJNIrYPhV7JgTwySi71bXiTH+3A0IKL4lnLTnCzRxTYHQqluNeGcpQQ29zv8iP7Lglw
 dY5g/TvngtxZbrNZgm8KQKqLVSQJ8zB/Iv3I4hCZbGSsdKLdWYdxMupYXXhxGWhJyFTg
 rnlw==
X-Gm-Message-State: AOJu0YzYrQNNG3QgwGbst51nsZjqx+tN1tebPpYr1j+GtbHcq/kuo+tp
 Gay/3DmK96dVtmBpdIo8PxHoDbn2WIX9KaUWP7Q=
X-Google-Smtp-Source: AGHT+IG5aG8n69+RWi0XlGHHJYCsVmdSkLKoX4L3eGXNyiQhpIXVX4E9Ln2aV/HAZ0k7XkGwarUivQ==
X-Received: by 2002:a50:fe99:0:b0:523:1a09:4e2b with SMTP id
 d25-20020a50fe99000000b005231a094e2bmr5137837edt.40.1692002990398; 
 Mon, 14 Aug 2023 01:49:50 -0700 (PDT)
Received: from [192.168.200.206] (83.11.3.31.ipv4.supernova.orange.pl.
 [83.11.3.31]) by smtp.gmail.com with ESMTPSA id
 w4-20020a056402128400b005232c051605sm5211269edv.19.2023.08.14.01.49.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Aug 2023 01:49:49 -0700 (PDT)
Message-ID: <05428cf5-c2b9-7e4e-8add-1085cc97a8fd@linaro.org>
Date: Mon, 14 Aug 2023 10:49:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] target/arm: Implement cortex-a710
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20230810023548.412310-1-richard.henderson@linaro.org>
 <20230810023548.412310-6-richard.henderson@linaro.org>
 <CAFEAcA_Lzj1LEutMro72fCfqiCWtOpd+5b-YPcfKv8Bg1f+rCg@mail.gmail.com>
 <17230fdc-6daf-82be-e665-97ca64d16feb@linaro.org>
 <CAFEAcA8viVtMGqBJ9D-2rehecb7QB7-F8PObhNTY9U-D=aNMTg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA8viVtMGqBJ9D-2rehecb7QB7-F8PObhNTY9U-D=aNMTg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

W dniu 10.08.2023 o 19:12, Peter Maydell pisze:
> On Thu, 10 Aug 2023 at 18:05, Richard Henderson
>> On 8/10/23 08:49, Peter Maydell wrote:
>>> On Thu, 10 Aug 2023 at 03:36, Richard Henderson

>>> Will sbsa-ref want this core ?

>> It only has 40 PA bits, and I think sbsa-ref requires 48.

> Yes, it does want 48 (we ran into that with some other core).

sbsa-ref needs PA > 40 bit as memory starts at 2^40.

Cortex A57/A72 have only 44 bits for PA space and are fine.

 From v9 cores I look forward for Neoverse-N2/V2 cores.

My "AArch64 cpu cores info table" [1] lists all/most of Arm designed 
cores with some basic information (arch level, 32bit, PA/VA, granules, SVE).

1. https://marcin.juszkiewicz.com.pl/download/tables/arm-cpu-cores.html


