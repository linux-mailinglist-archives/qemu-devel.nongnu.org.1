Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C047D724C94
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 21:10:20 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6c46-00073Z-KW; Tue, 06 Jun 2023 15:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6c43-00072k-Ak
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:09:55 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6c41-0003xy-AD
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 15:09:55 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-655fce0f354so1950178b3a.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 12:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686078592; x=1688670592;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3e8FIf1U4H0d3sQIJ5HljJnjvsHiICbzU6F9yeYmQpE=;
 b=XBIf8jqnk+pgQS/WOUGd8awY5O9Ea8xxstBrrvdkl9NdIBUQ+c0kNAGil4SEiDPvON
 QxpXzElC55uiFCeo5h/tQcYsLi/OnXe4Ud1Fl3QteuhRva1YVeQo8ITcKoffPZY5swqR
 4CA1QZJFMqiZchtprOum4FSI5IiblL8RsqfgoPzRlmwQ2kpTA228B5UC28/quaA/0l5K
 0phjB0UOfnLzojsGIMn+JyXv00/ii8uExreymEn712lU8bhDC5sIahy93fkYXFgB3syR
 hri06HT+ptjwUTvEcya3/+wHSau7tqAz5G27nwiJUPLTONvpoRlgl++j7rx+NvQr9gMM
 9w6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686078592; x=1688670592;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3e8FIf1U4H0d3sQIJ5HljJnjvsHiICbzU6F9yeYmQpE=;
 b=JpwBZIUVMCU/TsUMl2ZbawHYPjWr1i+fpekKakY+bRKroExs56NyR+PkDuGRRRqtXx
 hFJYLWCWgEJH3IkJyAIddG5WDFzPIxBRA90LXhVyypZMU7IW0Hetwo2KXbhEDB3fsPBW
 SaKadaMI9RaAd7oTaAuJR6mUlNtGENeXh0o4Q70MZY82qcQ5wWhYCHw5Vya5NTy4PbZy
 Oo1BnnWM1vTqcSxxR5v4pHZa41US4y4y8KH/IigNU/jmwya4DgcFms5y80oWCdslFAke
 NnD80FKY37/iFXKdf2BySw3thBaqCIPRGR4Ix1kKqHRbsMHo5dZp1K2vEy9wWhjV4KdB
 1/jw==
X-Gm-Message-State: AC+VfDxGeuDVWUi0OT3WgYczkinKdigk+FI+YYdFMvB5KLnow81yCb7s
 NWiYN1cClF183LpfTjYeREwLSQ==
X-Google-Smtp-Source: ACHHUZ4xhXq2OekxNPFaCXhU0UvKO5S9cy9DrOjwRFQKyVSgMuKg55sXzZAvFrj26QZsmLHzJW/EOw==
X-Received: by 2002:a05:6a00:2408:b0:654:4989:f2b with SMTP id
 z8-20020a056a00240800b0065449890f2bmr1649487pfh.1.1686078591631; 
 Tue, 06 Jun 2023 12:09:51 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:b7fa:ce59:1445:805a?
 ([2602:ae:1598:4c01:b7fa:ce59:1445:805a])
 by smtp.gmail.com with ESMTPSA id
 x21-20020a62fb15000000b0064fff9f540csm7048526pfm.164.2023.06.06.12.09.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 12:09:51 -0700 (PDT)
Message-ID: <a25d529a-ec4c-56c3-fa4b-eb9ea807cbc3@linaro.org>
Date: Tue, 6 Jun 2023 12:09:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 00/21] (Mostly) build system patches for 2023-06-06
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230606143116.685644-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230606143116.685644-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x432.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
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

On 6/6/23 07:30, Paolo Bonzini wrote:
> The following changes since commit 369081c4558e7e940fa36ce59bf17b2e390f55d3:
> 
>    Merge tag 'pull-tcg-20230605' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-06-05 13:16:56 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 6f3ae23b29ad5831902e3ecdc7e443bbbf295bde:
> 
>    configure: remove --with-git-submodules= (2023-06-06 16:30:01 +0200)
> 
> ----------------------------------------------------------------
> * finish atomics revamp
> * meson.build tweaks
> * revert avocado update
> * always upgrade/downgrade locally installed Python packages
> * switch from submodules to subprojects
> * remove --with-git= option
> * rename --enable-pypi to --enable-download, control submodules and subprojects too

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


