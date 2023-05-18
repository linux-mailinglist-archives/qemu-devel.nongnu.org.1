Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57BB0708610
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 18:29:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzgUH-000614-JI; Thu, 18 May 2023 12:28:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzgUF-00060w-Tg
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:28:19 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pzgUE-0007nA-8l
 for qemu-devel@nongnu.org; Thu, 18 May 2023 12:28:19 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-64d2da6a0f9so40712b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 09:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684427296; x=1687019296;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gALyqwckLOjKVI/UMJ85Y4Pgw5Qc6o2oxa6ldQNSFC8=;
 b=AgmsqNdx7JG524w5uhHV0crMin/gwdzIxQ/9LK/Q2qF4E1SNuYprisAH2UHvRt56ht
 eTVoCCrgf37VkXy6/SEtC4oXhqSVT4Lse9HT9vZ+Tcgc8JCmKZJ5iznuiWNCROt0Iquk
 y2cCEzOmO5r9XMrZmHhKTyyg4qepSx2xN7vbws8KMEmScteHhQK4ujrCoGAf/Q7SLyx2
 OdTcyR1jONn9fNBlnyRNjdxwW061qQxuHSuMUeYXWoEckjrKPbGQHoRzNJtmNpmDfJRF
 32f+yoHnnOoAvBtUINVPt0fk2j2Y56xJf0Bt3anVzmrRv5IUeMB/uJh9o5bcQw1T2y8A
 0ciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684427296; x=1687019296;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gALyqwckLOjKVI/UMJ85Y4Pgw5Qc6o2oxa6ldQNSFC8=;
 b=mBMVfzha6fGyfz2W1ubwMLEMlKcDwJSJHmki+QCGvI/9Lgc3DQM8UYAy5u/9oovhQv
 GwjDrkWhFBionVQuAA3BYTYrJX/1lDm+2q6lgOdZ79WvfUGaB19vKO5Pc5kZ5mttbvcD
 X8DbjAo/voguQ7tbYh5Nb07P4M44nU6ni8COD8zHnJxWgOKP8g+mFSd/Q/ClWEItByCO
 dLFgsYFkgCf68FsqtdVaBAFcgjNiheqqkXklITJXTtEr79b97aTaK1hNXDjfpgtW023I
 z4rIDITn3lewx/e5dfxzJo6KeoWNnjoG0AEiYga3ZRnMFA7CZtQ8D8Ct0SXCdORH40Dn
 5Smw==
X-Gm-Message-State: AC+VfDyeCYVImD7mvu5amztthwdb69LiskE8+zWlAm6OSXNqJ05W1GHd
 HJp6RUlnHy79dX1PGfps03ggXA==
X-Google-Smtp-Source: ACHHUZ5leRo776jvZ7cTGucKAC8n3FX58pk2FzP9GApriH5GpI965ZxdrawR5FT71MvORyMnsC3e/g==
X-Received: by 2002:a05:6a00:1311:b0:636:f899:46a0 with SMTP id
 j17-20020a056a00131100b00636f89946a0mr5208154pfu.15.1684427296060; 
 Thu, 18 May 2023 09:28:16 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:5dd2:c230:399b:cdc1?
 ([2602:ae:1598:4c01:5dd2:c230:399b:cdc1])
 by smtp.gmail.com with ESMTPSA id
 f12-20020aa78b0c000000b0063b7f3250e9sm1558361pfd.7.2023.05.18.09.28.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 May 2023 09:28:15 -0700 (PDT)
Message-ID: <f2eab727-5fd3-71d7-7610-0c7ad6af3b01@linaro.org>
Date: Thu, 18 May 2023 09:28:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL v3 00/68] i386, build system, KVM changes for 2023-05-18
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230518114025.1006732-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230518114025.1006732-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.544,
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

On 5/18/23 04:40, Paolo Bonzini wrote:
> The following changes since commit d27e7c359330ba7020bdbed7ed2316cb4cf6ffc1:
> 
>    qapi/parser: Drop two bad type hints for now (2023-05-17 10:18:33 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to fe3ab4eb2de46076cbafcbc86b22e71ad24894c6:
> 
>    docs/devel: update build system docs (2023-05-18 13:35:28 +0200)
> 
> ----------------------------------------------------------------
> * kvm: enable dirty ring for arm64
> * target/i386: new features
> * target/i386: AVX fixes
> * configure: create a python venv unconditionally
> * meson: bump to 0.63.0 and move tests from configure
> * meson: Pass -j option to sphinx
> * drop support for Python 3.6
> * fix check-python-tox
> * fix "make clean" in the source directory
> 
> ----------------------------------------------------------------
> v2->v3:
>          fix cut-and-paste typo in "build: move warning flag selection to meson"

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


