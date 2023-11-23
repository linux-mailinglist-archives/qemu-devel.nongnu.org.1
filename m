Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EF777F5DE3
	for <lists+qemu-devel@lfdr.de>; Thu, 23 Nov 2023 12:35:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r67yl-00028j-UY; Thu, 23 Nov 2023 06:34:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67yh-00028O-T8
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:34:39 -0500
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r67yg-00025K-Bs
 for qemu-devel@nongnu.org; Thu, 23 Nov 2023 06:34:39 -0500
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-507a62d4788so1064766e87.0
 for <qemu-devel@nongnu.org>; Thu, 23 Nov 2023 03:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700739276; x=1701344076; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LBQwTucn6ca5B6tUSsX2IIaRn5LWVeg0GAAl0vJkUCk=;
 b=fHOK5TXhgVyYvt7W60mRSB/u07zzXp85w5z0qSrIopuQNApyWEfL6eNy1NneKxCezM
 avL2Raqz0T6K6PH081w4fwkq696LbuIiXnQo5KysDbNiHH1YnYRGUpXaMB2gZjl8lS8U
 hn3v+IZsLJtlwBc/kLYgTH6m0zfzNlWEFpTdSIoH9RT3pmEISQ7UFa3rqN0lui9lntYx
 5I0UEl27yQGpzS7yt+eYFqjPcCKHnN3WzabCAMygL2sZAkJ/z5Rq0196VTGCLDyTFLCe
 dTJ1uVDlk8FLb2Uw3jZTR9Vq9In3DnCnUL8Au3qbM4j7bU1Ag2hWtb1XAEsm31eBdvrk
 s1ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700739276; x=1701344076;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LBQwTucn6ca5B6tUSsX2IIaRn5LWVeg0GAAl0vJkUCk=;
 b=FLrTvw+CsnTYq3b9iUqAPBnArJ3fZcXXBgRZzHrFNf4fSIw2ivP1VzZENrOuOOPs0T
 wZ8dFPTHIEmXHQNBBEXlgD/q5LORO3Y4phKchVzGiS8SbjOJTI1fwc/oASqeIP3zFPnU
 CDawp6F+1yCeKtcf9PXCK06rTdI36HO9wWI0IIEz9vq5j8/p7QT47brb7VXpiXudXbKW
 A6HVOcWnCVb4dkNLX30uPbW9kjuUziPbRzpI7ODiuy0+282qlDVOtBc3jZLPz3vjEVVN
 bwraStrpkWtORhe5E3U4yHWC0ntPDkx/c1cc87ijhoK16mF2Vp7OgvL08Y7AsO0B39yn
 DMIA==
X-Gm-Message-State: AOJu0YwW00fvNldyCKRJ14/HgWGOwY8DvVD0vpmMfPt4x8lhoCbjETzh
 S6ShPxSdJa7iBt0xTCvXKcrjjA==
X-Google-Smtp-Source: AGHT+IGmLrxcpMwB15q75pIh6TVG+tCS9ohlBePUMCcwYnrC2KrUaJS5vY9oEkdps9J2B7+Jgr86Vw==
X-Received: by 2002:a05:6512:280d:b0:509:4533:ddf2 with SMTP id
 cf13-20020a056512280d00b005094533ddf2mr4607857lfb.11.1700739276413; 
 Thu, 23 Nov 2023 03:34:36 -0800 (PST)
Received: from [192.168.69.100] ([176.176.165.237])
 by smtp.gmail.com with ESMTPSA id
 x9-20020adfdd89000000b00332dc82f70esm1408239wrl.102.2023.11.23.03.34.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 23 Nov 2023 03:34:36 -0800 (PST)
Message-ID: <24a1d197-8c23-4a56-b400-ca0ff1cef44f@linaro.org>
Date: Thu, 23 Nov 2023 12:34:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/21] target/arm/kvm: Move kvm_arm_hw_debug_active and
 unexport
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-7-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231123044219.896776-7-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 23/11/23 05:42, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h |  8 --------
>   target/arm/kvm.c     | 11 +++++++++++
>   target/arm/kvm64.c   |  5 -----
>   3 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


