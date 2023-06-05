Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B72DC72300F
	for <lists+qemu-devel@lfdr.de>; Mon,  5 Jun 2023 21:47:40 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6G9f-0003KG-GP; Mon, 05 Jun 2023 15:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6G9Z-0003Jx-Fp
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:46:10 -0400
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q6G9T-0005ru-U4
 for qemu-devel@nongnu.org; Mon, 05 Jun 2023 15:46:09 -0400
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-5559cd68b67so3589778eaf.3
 for <qemu-devel@nongnu.org>; Mon, 05 Jun 2023 12:46:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685994362; x=1688586362;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=INGAZcQDxlPGPyWEV8MmTxezMHH8cgV+qw7bXIm2LzU=;
 b=XkbZCyKmy1CEUSOWKNH3kFQ3O3nTt/1LuBrdBG5YKphHlYZt6MQKykIcq+04ef4sS6
 tyaoeoQW5i0I3ozY0V1T4MwQY3d2bfBUPB8AKGRTeVZVF1/ykdkwpCzDfTp2Q2xZiX4F
 V5gsX7LV7a/93HPWO/T4rZDgSknUFRGQi/sY8KnKvWYfORancvVrq18NhFDKkhy1t2ne
 R9GyJdo3VNXlRtmwd/Q8FfsWmHc4ti7c+oqTaFkXZJ3IX4DP7mI4isETGV+h8Wk0FRog
 xpEuf7XU4h3u5UTx0Ln4wegXfQcnQLMKl8qE81KGLLKb1qUSNmVEfmld+9rkbsc3JnDs
 82Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685994362; x=1688586362;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=INGAZcQDxlPGPyWEV8MmTxezMHH8cgV+qw7bXIm2LzU=;
 b=f1ltV990HyHTjFQqV8GUOPrdcVKVsaWXN+YJVqY5r02oEt2l3W1X8xCXscQjI9R/bW
 ZJMOMIl1I6rkiziIJc0TyDWW+yirweqF5uOxbwUeOWKGt3nmCeakCHyc+wh8Vf81Uyme
 qbrPnvVNRcmtNqvB8CZHBJ4U/liNwj3sJFOxwDvxf8BbAgf6BIKKQwCyM4ppmHYevi0U
 /ZkupBZn1Hx6dJyVs9BuJYkHkt4XxSKgMR8zoVLVnjrlXQwwbf3aIC+H9NofS0QtT0R0
 SmWT1P6lP7GbdA9L0eUmBC84XDM4w8mHGeGJ8aU8wgQsIBUNvPGm/r/Cu+36sMcXkWY3
 pVIQ==
X-Gm-Message-State: AC+VfDw7vbESbKWI1yh0vj76OsbLZyMKSyupT9ar3+xiN6Id0nRuQ9SD
 q3QkT6yHdpAWn4K5HJh/NOD70Q==
X-Google-Smtp-Source: ACHHUZ73AhGjudJpIx0GdJDgZYsIt7oDjx2gLh2isPWwQAMa2zR5eqez4IF9JWW9ayCd0EdwLmP+Ag==
X-Received: by 2002:a05:6358:4e92:b0:129:b810:926b with SMTP id
 ce18-20020a0563584e9200b00129b810926bmr216313rwb.4.1685994362217; 
 Mon, 05 Jun 2023 12:46:02 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:3f85:a600:6a3e:e465?
 ([2602:ae:1598:4c01:3f85:a600:6a3e:e465])
 by smtp.gmail.com with ESMTPSA id
 s1-20020a17090a13c100b00258f9597e9fsm4987901pjf.45.2023.06.05.12.46.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Jun 2023 12:46:01 -0700 (PDT)
Message-ID: <a4ca1e4b-5a91-178d-ca44-aeb195b19915@linaro.org>
Date: Mon, 5 Jun 2023 12:45:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/3] qemu-sparc queue 20230605
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
References: <20230605113253.455937-1-mark.cave-ayland@ilande.co.uk>
 <f3070fb9-e175-eadc-e4bd-c0395b593195@linaro.org>
 <65c71dff-e4fa-4c75-e0cb-c0033c835f44@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <65c71dff-e4fa-4c75-e0cb-c0033c835f44@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

On 6/5/23 12:33, Philippe Mathieu-Daudé wrote:
> On 5/6/23 19:26, Richard Henderson wrote:
>> On 6/5/23 04:32, Mark Cave-Ayland wrote:
>>> The following changes since commit 848a6caa88b9f082c89c9b41afa975761262981d:
>>>
>>>    Merge tag 'migration-20230602-pull-request' ofhttps://gitlab.com/juan.quintela/qemu  
>>> into staging (2023-06-02 17:33:29 -0700)
>>>
>>> are available in the Git repository at:
>>>
>>>    https://github.com/mcayland/qemu.git  tags/qemu-sparc-20230605
>>>
>>> for you to fetch changes up to 36c9189890bfb936b1b086da639e37fd92b50215:
>>>
>>>    hw/isa/i82378: Remove unused "io" attribute (2023-06-05 07:43:23 +0100)
>>>
>>> ----------------------------------------------------------------
>>> qemu-sparc queue
>>>
>>> Hi Richard,
>>>
>>> This is one of Bernhard's cleanup series where all patches have been
>>> reviewed/acked. Please apply.
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> Also merged as commit afa351fe36 :P
> 
Bah, yes, wrong reply hotkey.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


