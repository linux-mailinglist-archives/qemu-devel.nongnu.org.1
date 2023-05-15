Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DF12D7036D4
	for <lists+qemu-devel@lfdr.de>; Mon, 15 May 2023 19:14:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pybll-000091-76; Mon, 15 May 2023 13:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyblj-00006U-6Z
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:13:55 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyblh-0000HE-4s
 for qemu-devel@nongnu.org; Mon, 15 May 2023 13:13:54 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1aaec6f189cso88735285ad.3
 for <qemu-devel@nongnu.org>; Mon, 15 May 2023 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684170832; x=1686762832;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MnFNVb9cHbtHXABfBU7V5sT+EU2a8+Y+b3a/BBkYwOo=;
 b=inVDK+KpIAfpajMBkWnG+uenfszgGGFgVgtxT42EijZKq/ucFlGr82D3XWC0wDe71V
 QJWD7F7yMTypKYSp/mbplqQT1iDgc5l8I0trLZnRLHx6BeOtRpGcUL4AYLl6LmE22NQe
 Bq/ibKICVMIIwmEzbRzGmWTNJ79UfvdEehqfSrDIyJIVhw061YNw9n14QcdsHRVpYU1d
 2wzcd2bT4WFo+iQ8utLXdFTk7DV8M8m7FhXhFBzyKphn09S+KR7n6X9EBXJJi60ivWLD
 vg1GOjwJ2WGfJQm5dWTs+6mExKBgafLoZiusJ+VQefOCknqudAkmd+Jc/XCiXL1V0FLI
 s0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684170832; x=1686762832;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MnFNVb9cHbtHXABfBU7V5sT+EU2a8+Y+b3a/BBkYwOo=;
 b=dHwrzu3EdOCxSavC+5zeS4ERV0ddk6Y1tIGg64H6tzhm42tTfJ952VFJlsojsQli75
 NDT46Rri1zKHJakbhpb8mxzaz+sAgfEWu+Q68NyoMvANSuLvM+upUGNOXoutSpA3CHtN
 bAK26wqufAAbFCvH3OsPA4folKCBggs9nU3afvsNagrxX6FH7x8hSXCRDbbW1jS3ro/4
 +Zcbt9aRMwiCMrxVm5v+C81i6d5DG8G4nRgh7S+YWk+XL/kDIOjp0Oq9KWFqqhne/yzv
 Fe8lqEMEYD/BMknGMT55cNJK/c+izHqdQwMDAfHkth7vXljJ/AmEe3t/chfoFYarQqKe
 VvBg==
X-Gm-Message-State: AC+VfDyXAKKiiaW3/9+s0wQheU0Fy2Yb5FTa3htFzl4sBUBYxiqwXq4j
 s/c2HIWUM2/qnUVXsMBKaDez5lyzyVUM/8LZTqg=
X-Google-Smtp-Source: ACHHUZ7XTheGfmirg4adwMuDHzYgPcmY5XjyGC6Hd43GAoRdBs7aqmKbNsUnwxIlxD1/Kle3SxUlRg==
X-Received: by 2002:a17:902:ec87:b0:19f:87b5:1873 with SMTP id
 x7-20020a170902ec8700b0019f87b51873mr46804577plg.62.1684170831673; 
 Mon, 15 May 2023 10:13:51 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9902:96ac:8d8c:4366?
 ([2602:ae:1598:4c01:9902:96ac:8d8c:4366])
 by smtp.gmail.com with ESMTPSA id
 q12-20020a17090311cc00b001ae1a35eb35sm2631678plh.178.2023.05.15.10.13.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 May 2023 10:13:51 -0700 (PDT)
Message-ID: <7d4484c4-6b58-62a2-1590-7e98c115e542@linaro.org>
Date: Mon, 15 May 2023 10:13:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PULL 0/5] loongarch-to-apply queue
Content-Language: en-US
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20230515111908.2606580-1-gaosong@loongson.cn>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230515111908.2606580-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.811,
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

On 5/15/23 04:19, Song Gao wrote:
> The following changes since commit 8844bb8d896595ee1d25d21c770e6e6f29803097:
> 
>    Merge tag 'or1k-pull-request-20230513' ofhttps://github.com/stffrdhrn/qemu  into staging (2023-05-13 11:23:14 +0100)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20230515
> 
> for you to fetch changes up to 7ef0eb35a4e6961d7e40f03f16ed241c95ae93f9:
> 
>    hw/intc: Add NULL pointer check on LoongArch ipi device (2023-05-15 19:09:33 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20230515

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


