Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FF5B7E2776
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 15:46:23 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r00pO-0000Vl-5X; Mon, 06 Nov 2023 09:43:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00pI-0000S1-D9
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:43:40 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r00p4-0002OV-07
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 09:43:38 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4084e49a5e5so39814115e9.3
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 06:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699281803; x=1699886603; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VspwWeozoJGDtlQ8T8hOs39UsiBdPxZavlM0ksYKgv4=;
 b=pT4r9Zxn5A+IaaoQq2DSjj+PIvmlWWcWZqi5LZ+B6bSx5eGr04LA9GF9vKlJllfIJQ
 wgkulLOl50FnjMQSatQTHL/Q2Si8ix8a9DncRqeshQmYBjf20zHgRrIksddeHdphBMV0
 XGyjNP04rsXA/j3Xj6L3wPh9gO5AJIOj30VIQz+p3aHnwDy1Px779Fo9jyN9WjDcooQC
 LgY0fokrgGMjp9WUQYmCT22sNfpAXSfBRWqbtSaxQHM5agPxvVlcslqcK9LL0NHWDske
 0P0h33SwEdQFA2KSAx8sblZ3ir/F4J8yXo+EPhT1sE64CvASCRLqdg16yJUIpCS0Qg43
 2mDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699281803; x=1699886603;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VspwWeozoJGDtlQ8T8hOs39UsiBdPxZavlM0ksYKgv4=;
 b=ks07qTU+Nx0GrgL3XOfVzzTuYM8HkG68hgNuYAsjXRLYXFO+vK6Hi34HG/LT/SCaym
 Y79HNApO8iQ4BitpvgeX73rV1TE4or8ONdWzwwrc8RQYXG8WrPxVC45acUfBYKGPPXXc
 xFSYmhosb2CaisYepxekyGfiGb4Z3frSxY4SQeJogNCmSQTx4FTi33gWJs425NgIRr5Q
 OHrx6Skb1PpgA5faVT00GiSX/qbvVP5lpele2gg1E9WAzIT5po+7S2etNk1B9vFRbUCL
 hCzwmctmcbAB/vg5Yg1aOxUz7J+AQ+2Vxk2ePCNIbBr+zqODmtP0XyvE5/GCOq5+ryGF
 aTFQ==
X-Gm-Message-State: AOJu0YzoCryFHa0PkUgX1bNhnPbqJQyzPxBqlVvN0U+K3o/avLz8RH5C
 pUCbd+Ixl7twhNwv4cjy/E6V9pBZ+0QDA0kXle8=
X-Google-Smtp-Source: AGHT+IEaMbwYfZx3zclprYVIY4imA3CEGokwKh7BYh/cYnG1hUpEbejjaUS5FLfc5TyLtl0pUB5cRA==
X-Received: by 2002:a05:600c:3594:b0:408:3804:2a20 with SMTP id
 p20-20020a05600c359400b0040838042a20mr23522246wmq.22.1699281803274; 
 Mon, 06 Nov 2023 06:43:23 -0800 (PST)
Received: from [192.168.69.115] (176-131-220-199.abo.bbox.fr.
 [176.131.220.199]) by smtp.gmail.com with ESMTPSA id
 m12-20020a5d56cc000000b003232f167df5sm9592319wrw.108.2023.11.06.06.43.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 06:43:22 -0800 (PST)
Message-ID: <598dd941-e042-e5a9-9bb5-344c1a0115ec@linaro.org>
Date: Mon, 6 Nov 2023 15:43:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 3/4] tcg/optimize: Canonicalize sub2 with constants to add2
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
References: <20231026013945.1152174-1-richard.henderson@linaro.org>
 <20231026013945.1152174-4-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231026013945.1152174-4-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
X-Spam_score_int: -51
X-Spam_score: -5.2
X-Spam_bar: -----
X-Spam_report: (-5.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.085,
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

On 26/10/23 03:39, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/optimize.c | 21 +++++++++++++++++++--
>   1 file changed, 19 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


