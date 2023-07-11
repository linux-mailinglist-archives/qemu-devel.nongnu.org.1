Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4EC74EA5E
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 11:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ9cY-0003eJ-3G; Tue, 11 Jul 2023 05:25:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJ9cV-0003e6-Ml
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:25:19 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qJ9cU-0006iN-2Y
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 05:25:19 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-3fbc63c2e84so60477535e9.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jul 2023 02:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1689067515; x=1691659515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yNJqA25knk0SRhnPHxoou3h3UV/E9hCTPsG01Y7opXQ=;
 b=g1P+Lh5JgILD48rTquPPoKmfBWaQsFSZrIzcoOxodAHn2uR+MMzBHNBYdEEtUxnLky
 nuwttSL6mwE4Cbz1faAkgfliRkikF86oU4/RiaMY4iVG6nwBE5nd7wd+fUkyoQP24Swi
 9UYi7iDaTmYLHpVtD7okGGg79+uSflU+qZRMcVznt4/dGyVr4ikSvlWd2cIN47zzeLbV
 huqkz5SiUbEnvX4IdItvJlh5iBi3BsgJHFIQWOyzSvl2x7iFo8VriB48HmSGFcaK7kVO
 /IrcbrBrC0fabyP51s306bij7tErjK7SvL8cYrnOkpm5Y3eOYxdHjxj6F4rohZFbcyMe
 OerA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689067515; x=1691659515;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yNJqA25knk0SRhnPHxoou3h3UV/E9hCTPsG01Y7opXQ=;
 b=USySjX2JPsYZh5Dn7EE5bdR4vE0w3iJHIfVeZE5ceBQrOmlgqgmJGUtC/7OB+tjn9i
 3/Rdq52iQIx+6AoHkPO8q2Sfdb+mvyxqDfaBvvUGFyBaSN43dGznFNPRvZtnboWSe03g
 6flYtnE33Y2Q5cm0+UYvommxfFNlR0Mc8oXZGt9tCvH3GHnLHuaNeP+kblzYG0ljMuay
 BUJDM2yvdpTS4IZN3gmdAuXN5XkLP5F+xWDmvSJhT1Ld2KmzkyyCdy7Fzq9/0ldv9rF2
 Eoxjw3U0pfM8cQK2o+ZiEBPOdfBQOFFz33izJVFBOj8r9W8BO9LrrjG6hAsXU9Vv1T0Z
 4n2g==
X-Gm-Message-State: ABy/qLZXW1nTeOS37HrE/kxqL5p1pFAyrvFBWgs3Nzn9XPvov6iW/eDB
 9X8TN3CufvZJjJ+YOwEQMvXrmQ==
X-Google-Smtp-Source: APBJJlEErinLQC/KdyG+/9W+jUWOT5vl3rp63IkbPP+TIt69TnjDj6cRFi4XdxkKnExfhyiDFnw0cQ==
X-Received: by 2002:adf:de8e:0:b0:30f:d1e3:22b7 with SMTP id
 w14-20020adfde8e000000b0030fd1e322b7mr16187222wrl.6.1689067514922; 
 Tue, 11 Jul 2023 02:25:14 -0700 (PDT)
Received: from [192.168.8.133] ([85.255.236.57])
 by smtp.gmail.com with ESMTPSA id
 i4-20020adfefc4000000b0031431fb40fasm1729798wrp.89.2023.07.11.02.25.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Jul 2023 02:25:14 -0700 (PDT)
Message-ID: <2a09d9f9-1f50-16e6-14b3-dd4501fb76eb@linaro.org>
Date: Tue, 11 Jul 2023 10:25:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [hotfix PATCH-for-8.1] meson: Fix cross-building for RISCV host
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230711085409.53309-1-philmd@linaro.org>
 <45565778-bab4-36dc-bd97-e7fdd13b3b9c@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <45565778-bab4-36dc-bd97-e7fdd13b3b9c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32e.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.101,
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

On 7/11/23 10:02, Philippe Mathieu-Daudé wrote:
> On 11/7/23 10:54, Philippe Mathieu-Daudé wrote:
>> While when building on native Linux the host architecture
>> is reported as "riscv32" or "riscv64", when cross-compiling
>> it is detected as "riscv". Meson handles the cross-detection
>> but displays a warning:
>>
>>    WARNING: Unknown CPU family riscv, please report this at 
>> https://github.com/mesonbuild/meson/issues/new
>>
>> Commit 278c1bcef5 was tested on native host but not under
>> cross environment, and now we get there [*]:
> 
> Richard, if this works for you, please scratch this " [*]",
> I meant to list "https://gitlab.com/qemu-project/qemu/-/jobs/4627545569#L128" but then 
> realized this link will
> expire in few days so be irrelevant in the commit desc.

Thanks.  I'll apply this after the current run completes.


r~

