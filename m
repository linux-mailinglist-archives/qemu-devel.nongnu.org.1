Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD79911971
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jun 2024 06:29:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKVtT-0007Lu-ME; Fri, 21 Jun 2024 00:28:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVtS-0007Ll-J6
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:28:58 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sKVtR-0000gv-4J
 for qemu-devel@nongnu.org; Fri, 21 Jun 2024 00:28:58 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1f6b0a40721so12007575ad.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 21:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718944135; x=1719548935; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fpDg4HqN0DCtw76m7x7h4xzuJTfnp4R4L1eVRi8kwJU=;
 b=D2vvcH4rP7zS2g5pvQ5tQNXCB3u9C/EGR0GKtSDgiBCxFT8VTfraOCR2/YmWD0LYZQ
 lZ6wM+HeWTjMOVd9UgNzJ3NeMjnCLu6d67NFL+DFCUroKO3/TDp/cZkFQuguQSnKaxZ1
 X9AT3JUSvUNgRU/qb2prJhZxzjE8ox5j+j4ds5XGdUExBkaYGqL67KgU+iTeuf6phHMS
 7i5b6R3fkjvcWnnQPRzp65ofj7U6CPAYwgjgkMCDm6sgeDARYtxYRLcN29joOUkehBtp
 ajxvNs0GfxKpCtdWIQjO3505qxaAIwI+MZkFKNj2e5amflk/J8nBrQn1zvwCX/YV8Su/
 O99A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718944135; x=1719548935;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fpDg4HqN0DCtw76m7x7h4xzuJTfnp4R4L1eVRi8kwJU=;
 b=njg4wQaqHojHEHDTW+96FqWqEGelSwkiQnyxRumtzn1lkUkP5QPKCIfsxN33KKlHC2
 egjj9P8KG3ijoLnPBQdnHbWBdZFNRLQGIUokTPgBsu/QnlUeoR7U99o0NgPk4w1LqNNs
 OHaBt0xpl7lQoa6XQR1cQfZHR7y2KRdEVOYhTvN2FzOQv5HG6AfhaOT9ZxZmN/mbsXPV
 2BAGewSNOISv9KR3rNbY2ycNDTCsrtsW1g26VH6jI1LiLVc8lVy2eGjNcWdmkYQjrMCi
 i8zdBnnaCIrCRC3YfDT4KEbAeNL/PUJMhYekDzXWLFs10rNX9TFUSBHpZeDrn+UreF+R
 0o3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXrsvqWofAldEvC54Nl1lhaagwiOiXYqBYGcWkKIwoTfKRXM08wjMPrHhHac78kEOChITZu6f7K2UuDgtljKvp0phPgFn8=
X-Gm-Message-State: AOJu0YzFhACs0uXsAVPvrFQNkoki9FOdfUYQ7fAPzhUJ/TltPixKxAuN
 O8Zhaz+aSNYJv88zKSW8ME2yF4F2JvqHH/1gNpbaxUF2l18esHq/95U7wijXqVo=
X-Google-Smtp-Source: AGHT+IFf7tB4ntmlyxSpYFZizmZocv74KLz3E8JrGGIblwQkfdpVtpmxvmqNguPGpHRC1EtED5jefA==
X-Received: by 2002:a17:902:d2c4:b0:1f9:9a53:c7b2 with SMTP id
 d9443c01a7336-1f9aa3edf7cmr85896755ad.32.1718944130415; 
 Thu, 20 Jun 2024 21:28:50 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f9eb3d4c3fsm4515005ad.195.2024.06.20.21.28.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Jun 2024 21:28:50 -0700 (PDT)
Message-ID: <e033c27d-7fa4-4e8e-ae6b-5d8b71bde9b2@linaro.org>
Date: Thu, 20 Jun 2024 21:28:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/9] target/arm: Fix exception case in
 allocation_tag_mem_probe
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, peter.maydell@linaro.org, alex.bennee@linaro.org
References: <20240617062849.3531745-1-gustavo.romero@linaro.org>
 <20240617062849.3531745-5-gustavo.romero@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617062849.3531745-5-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 6/16/24 23:28, Gustavo Romero wrote:
> If page in 'ptr_access' is inaccessible and probe is 'true'
> allocation_tag_mem_probe should not throw an exception, but currently it
> does, so fix it.
> 
> Signed-off-by: Gustavo Romero<gustavo.romero@linaro.org>
> Reviewed-by: Alex Bennée<alex.bennee@linaro.org>
> ---
>   target/arm/tcg/mte_helper.c | 3 +++
>   1 file changed, 3 insertions(+)

Oops.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

