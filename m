Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D8C176F973
	for <lists+qemu-devel@lfdr.de>; Fri,  4 Aug 2023 07:14:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRn8l-0008Mh-Kq; Fri, 04 Aug 2023 01:14:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRn8j-0008FL-Hm
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:14:17 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qRn8i-0005Ha-0p
 for qemu-devel@nongnu.org; Fri, 04 Aug 2023 01:14:17 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-686efb9ee0cso1519840b3a.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 22:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1691126054; x=1691730854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tkk7f1HcHrO8aidNkFQ+N+qk98lahUdsGNiSv8HjKYY=;
 b=o/fuxGrLxHn2pjLMrqUYz2JBl395uFzrDsLhhdsFHHr32KmiKX0jXZdEeYn5zbIKaF
 YFTriusOBUru6rvoVXDBUEuR2E2wtnuMGQn29thfkdGpWjkpi+HgfwAbKnNvNRLcGjSu
 7xQsbQx5WNSxK8ADMpf5EbY7mc1HzcDY1zz9ds/ZTk3Kb+xK2tV75oJywxCwsNFvFCFR
 CMVudveKWg9uhb/7YgSPKX+7jAJdc2CUM6ppbq+4aeHfF0r4AmijN6esQbbnw/2DxFG9
 WqG8rca9RujPZ/RUvhu2UD7hUik8lDK/Lao4ky9CDBjI9jJUgd6Oo8z1xnHr+p3Adzyz
 ycHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691126054; x=1691730854;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tkk7f1HcHrO8aidNkFQ+N+qk98lahUdsGNiSv8HjKYY=;
 b=T/mIoGoMsvELKG5iyjnwH9fXLokE7+0l0gEg27czM+LdkjGFyfobn4+dvA4PjgGi/9
 cTZ19+K2fCIOfnB+mM9vqKbrygSFa+Y4Ldvta0WAZKHAbHEV2uaymqTqEiQCnbGlX8YG
 MkzGJzvPWYRrdC1l9zRW8ti45I906ERcfM8umQcWa1RYQxtGTo4BGEeo1t8b0Ogc2zcI
 18D9y+kTKuqlad8HqKdx1Vnp9FPje8TSHH2Ua6Ts600nR8TKyI7fjBHK2HoFUj4QUelK
 BX70qkA1Akj4iZg7qPeyuWZ61sq1s6KwNeDO2esD3K9YaGSxvB7UiRKZ0q/ExWQq7LXX
 B0AQ==
X-Gm-Message-State: AOJu0YzW6IH2HzqBFw2n6mcpXJ/MRuxiAQJwuId4YGSfMM2azv/CSGVl
 +gk8uDm08mxf7NUx9xZgkpXM7A==
X-Google-Smtp-Source: AGHT+IHbm9WAk4Fzkvm13IxDs04h1rBMXBhvxxgAGRw0j0HQGkabnhPAsqlGFkOwDRRN4hG3x0CcJw==
X-Received: by 2002:a05:6a20:728e:b0:138:48d7:4a31 with SMTP id
 o14-20020a056a20728e00b0013848d74a31mr905752pzk.62.1691126054181; 
 Thu, 03 Aug 2023 22:14:14 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 m6-20020aa78a06000000b0068732995941sm694719pfa.79.2023.08.03.22.14.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Aug 2023 22:14:13 -0700 (PDT)
Message-ID: <52d22722-6159-6250-5262-bfb55b576753@daynix.com>
Date: Fri, 4 Aug 2023 14:14:11 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 08/17] linux-user: Adjust task_unmapped_base for
 reserved_va
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: joel@jms.id.au, laurent@vivier.eu, deller@gmx.de
References: <20230804014517.6361-1-richard.henderson@linaro.org>
 <20230804014517.6361-9-richard.henderson@linaro.org>
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230804014517.6361-9-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::436;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pf1-x436.google.com
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
> Ensure that the chosen values for mmap_next_start and
> task_unmapped_base are within the guest address space.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

