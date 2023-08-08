Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BDE04774F6E
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 01:39:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTWHm-0008FY-UR; Tue, 08 Aug 2023 19:38:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWHj-0008Er-9v
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:38:44 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTWHg-0006qJ-0b
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 19:38:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6874d1c8610so4554750b3a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 16:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691537918; x=1692142718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XlLk9r6mE3VW5HZrkMuy9yPpkkwT++yVnix6Rs1+aLU=;
 b=JfrCYKFWUVvtd+9Ei1ik2TRaRCSlUnocU9osi4a1ao54Zlcb5wRIufrQzVv+8vpz6n
 1Nfm1KM6jnx/RnEco5R+1wLtdIcqykQmVu0Md+e/CAR369HKtnj9ea58DPl1fX6cM2/k
 KMyRBiXCz/F0fgqfsxWoOgoHXfIVPkNm/PSxDwkRq+fikfbSXGu8bjRzuyEQC9TOzJTO
 3zvz0zoqsuhUIL2Waui58Tbp7RtqPa2F6eacqWvxiM3d9FwIUhzUblkF62XhXwMXEOX1
 Yjb+LgSdi7pjuh7dLSrwQY+R94zPO66Du5VfilHNFt2lPPuYv8G2/lnkOvCBUrA2rv8o
 IyKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691537918; x=1692142718;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XlLk9r6mE3VW5HZrkMuy9yPpkkwT++yVnix6Rs1+aLU=;
 b=aCMQtsoU5IsJYoiHcSTJewDU/OfoQS/v424Tkk+IYQn1f58dEgDxhj1cIcnFgf8pBt
 l4jXTG0bVh25bVgVZ7HUUF72ZtOo3CyP2/TkchXmRD2Sijfkyjp33FnGAxKrTkRMeBWZ
 dyzYbe88XKd1aeW+IZgxxxNWs7JqiK2LjfL5xOZIx/qbu8ks4fe9D3xrRVTH9ZIIJTR3
 ldB3ETWpOldLUJVX1OntVRUhYm1UCNDlvYy4fbz9CLFadLxsLgqPb4XqI7Sr7y0/G1FB
 +rYpf8Um9qXZ/CShbtZRVdjD4nzq9WCokB8CIwBZt79pi6AUsDyJxmq2sdZkRezET7+L
 vqNg==
X-Gm-Message-State: AOJu0Yx4RcnnUjLYy3oW6jx3Ep2vL6vj3EVX7ZAIoogI+D2AXxqHgsHA
 O3hxi260GWfsroOiwGryYbR0Ow==
X-Google-Smtp-Source: AGHT+IEViuAWk3060Xo5eegRfgyuG8bP2X5+V9vW3E325k9WVVGC/AIrg0ceGRqf/Derye1Hu/+kmw==
X-Received: by 2002:a05:6a20:8f09:b0:132:cd2d:16fd with SMTP id
 b9-20020a056a208f0900b00132cd2d16fdmr1156319pzk.38.1691537918131; 
 Tue, 08 Aug 2023 16:38:38 -0700 (PDT)
Received: from ?IPV6:2602:47:d490:6901:63dc:2a47:f4bc:4a95?
 ([2602:47:d490:6901:63dc:2a47:f4bc:4a95])
 by smtp.gmail.com with ESMTPSA id
 s9-20020a62e709000000b0066a6059d399sm8589067pfh.116.2023.08.08.16.38.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 16:38:37 -0700 (PDT)
Message-ID: <241ffb64-10a0-7e19-24e0-94140ade1e79@linaro.org>
Date: Tue, 8 Aug 2023 16:38:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 0/3] fix ppc64le build, fully kill alpha and s390 linux-user
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20230808184551.684522-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230808184551.684522-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 11:45, Paolo Bonzini wrote:
> The following changes since commit 9400601a689a128c25fa9c21e932562e0eeb7a26:
> 
>    Merge tag 'pull-tcg-20230806-3' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-08-06 16:47:48 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 971fac2731e60f2143f35648b14fd2f1b5b2c1af:
> 
>    configure: unify case statements for CPU canonicalization (2023-08-08 20:44:11 +0200)
> 
> ----------------------------------------------------------------
> * cleanup architecture canonicalization once and for all

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


