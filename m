Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70297B5367
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 14:48:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnIL9-0004pY-1c; Mon, 02 Oct 2023 08:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIL6-0004p1-NK
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:47:56 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qnIL4-0004TH-3O
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 08:47:56 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so29944335e9.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 05:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696250870; x=1696855670; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6URmOwNyAeSp6hL1YltpNKdAqLmn8ZBThKIYRhMNJeE=;
 b=QvUH6TixftADaiZwjr4pCXfFRyPoRX6cRuYMhWKaFSDWZQmLkGAqWOnW6Ro7emoF43
 99WURoF8Gy8aka1N10wNlFEPDvQYGv/DjTNBY7tsEksFSu+t3aNsO8JFj8LJczuMbwYD
 IE52oveg66C2Vl89umYa6Oxdt8lbbFps6z/nbpCRt4goYwbW01xfXiVt4Pm4I1wlbNEj
 LsvllG8LyIux/HyYV4Nz6Inzab5D67lm+pGVxSKyxlv4HNlXsXhvCmR8DALsFezF6OLs
 v6UCN53F8tlBnibpZ0GA/qKQoUSO7U3M5lIvWo6/7r2Pw3XEKt53zSqpYmN7cGPVu6f3
 V1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696250870; x=1696855670;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6URmOwNyAeSp6hL1YltpNKdAqLmn8ZBThKIYRhMNJeE=;
 b=h0VkRMdrlYoBpRIRubeW6T61I/4DZhH8IjDeE3wukMmnA30DICTl9EtJlrFlupY1iH
 tuIVOewFU8hmWKKq6SvNP/4WROJIqp75pNdfUBb7T91ION+LfjxSgd8XSBvXr3U0Lygy
 gO1/TetFt770mh1rj7wfiRg0u5xYOFLRUL36RKdQOdP9gtmXLa85v78e2c7sOICxe0zj
 zVV7Dr5N+/PBXM/C9HB/dSz3DRbF8uXzv6YXFBdEyU8t1TUCcziLSsqPl7RfprGMn9O0
 HGW1YC+fmNwqqUaYn8Fu3AXIO9Z0uDUH5Xhuw/w4ji1QUf3e2sCvcmwe++rIT1Ti9sIb
 IwKg==
X-Gm-Message-State: AOJu0YyuqnmSG9gRUY2jNm/k7QVnZxXKaxIUzhYMKNk0W54Z7DlpqWNp
 SZOzxPG6eiTvYV3OOiuu9v9cAw==
X-Google-Smtp-Source: AGHT+IElD14MerT7hOyB2AAexGUD+ZkxyE+hJ/BNt/R1uVk2FKwRdscHA/6FrVIMjJq+Hqj3WkO1YQ==
X-Received: by 2002:a5d:40c8:0:b0:323:264d:9cef with SMTP id
 b8-20020a5d40c8000000b00323264d9cefmr9018069wrq.12.1696250870315; 
 Mon, 02 Oct 2023 05:47:50 -0700 (PDT)
Received: from [192.168.69.115] (sto93-h06-176-172-7-203.dsl.sta.abo.bbox.fr.
 [176.172.7.203]) by smtp.gmail.com with ESMTPSA id
 n16-20020a5d51d0000000b0031f300a4c26sm6584195wrv.93.2023.10.02.05.47.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 05:47:49 -0700 (PDT)
Message-ID: <5148f40c-acec-b414-011f-e6cee970c1df@linaro.org>
Date: Mon, 2 Oct 2023 14:47:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 8/8] MAINTAINERS: Update PPC TCG target with tests
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: Daniel Henrique Barboza <danielhb413@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20231002122326.365368-1-clg@kaod.org>
 <20231002122326.365368-9-clg@kaod.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231002122326.365368-9-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.321,
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

On 2/10/23 14:23, Cédric Le Goater wrote:
> Cc: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@kaod.org>
> ---
>   MAINTAINERS | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


