Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 489F176F98F
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:29:14 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRnMu-0001Uz-7x; Fri, 04 Aug 2023 01:28:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnMp-0001Uj-Q6
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:28:51 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRnMo-0002zh-9P
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:28:51 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1bc34b32785so12235675ad.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126928; x=1691731728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o/jDagpIwCbKuaxqyzG6Q+FKbbAR/vTSYH+PUW5wHH8=;
 b=LU83CHWdTV1fLQGsUoAVQQYxoN7iRnp3SzQsre+MTWvw4L8qEDcezPFGqN2yTWtYKC
 c8gOSuylyoReTO6yHcvWVbbQINHuEa3dzs8JxIHgpEtQmWQ1Oml03O6v99NVTniKIcEU
 2oMuQ/U0lM0Yd37qDkMUbvVAQ9HjsberrHs7KJWGod/Jti8ncMrJQObac7bCVv4L+pWB
 enuWskyj7jzhau5mUsMsqxnEoIc+9A1KI7028OZyA7HJXaUKMocrlog/IqBTIJVFM3Iu
 rLLvKuZTQKKCVF7ZoUHNebY4ZYInJUHZIFczgEOgp6vrk2X0UNZWOfvld1i9M2+StsR5
 0W5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126928; x=1691731728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o/jDagpIwCbKuaxqyzG6Q+FKbbAR/vTSYH+PUW5wHH8=;
 b=jaPOrR1pwFTMTzhEvbRDqz22lO/reqiP1ZWeQgYFHWbHDq/8MqB4hGYnIWmJBK85Vb
 hPqZlz+oAKul9hF1by0K6u7j6orWYwh+5lHWZQ6I9z32O7lmP7qVB8AVHDIouewbsZDd
 IQgQCXAuBVwbE0JHTVzjr7IZKsfQPsg7OywPB0UqKFWF8ZnvrGBgTIqK7ORFxGRnEFnc
 W6jHk8QvL6r+FWksq3hwCSEhttyek5b0je7UVL84zoBrLqfZqodL+AzQlEKMFn/ENeoL
 1LWiqMUfsZTb61FFOBFc+KI7FQB2zHlDhEexn1FTaYhlfOh1fqQvPGWYpJ9xXNWSifrG
 xumg==
X-Gm-Message-State: AOJu0Yx1xUZ3OAMc135y70ND0OmrPbYcPk+u1Meo/i3FQuYMCRrCJS3s
 K1UGRu4oFSVH0UKWCFw/ELfd2Y7dw28MQjI34/k=
X-Google-Smtp-Source: AGHT+IGzAD63j+nyK0QwoJ+uta2FDL5Ez+lXAsotPZqV/3UbdFRGj214sz5KD17tTrZz2RbTO5tSBg==
X-Received: by 2002:a17:902:a70f:b0:1bc:4171:67e3 with SMTP id
 w15-20020a170902a70f00b001bc417167e3mr632811plq.31.1691126928269; 
 Thu, 03 Aug 2023 22:28:48 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 jh21-20020a170903329500b001b8c3c7b102sm764864plb.127.2023.08.03.22.28.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:28:47 -0700 (PDT)
Message-ID: <a975e11f-662a-da2a-fa2a-12531405185d@daynix.com>
Date: Fri, 4 Aug 2023 14:28:46 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 15/17] linux-user: Do not adjust image mapping for host
 page size
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-16-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-16-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::62d;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2023/08/04 10:45, Richard Henderson wrote:
> Remove TARGET_ELF_EXEC_PAGESIZE, and 3 other TARGET_ELF_PAGE* macros
> based off of that.  Rely on target_mmap to handle guest vs host page
> size mismatch.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

