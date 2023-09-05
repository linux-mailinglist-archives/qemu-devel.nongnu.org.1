Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D853179212B
	for <lists+qemu-devel@lfdr.de>; Tue,  5 Sep 2023 10:51:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qdRlW-0000hB-Ve; Tue, 05 Sep 2023 04:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRlU-0000ds-FB
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:50:28 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qdRlS-0005wU-9J
 for qemu-devel@nongnu.org; Tue, 05 Sep 2023 04:50:28 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-3fef56f7223so21038995e9.3
 for <qemu-devel@nongnu.org>; Tue, 05 Sep 2023 01:50:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693903824; x=1694508624; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JUEikI+8UdqOc2VGNOxBHLnl97oOfIXpCxawdnlEDMo=;
 b=VqWNloxSjSsDcBLKiuJnNr/9unsJXh/QGCM/ld5jG312XIvja67S3wm7Pb4uMFFGdC
 5SFJVDfPsjd45i9j0QXTKj1LEf9DH12euInkBLvnmYIk0CS7edbfQPYFsTGZTKuPtPFN
 9PcxPn2vi2t0mefbM9Mx4p7NSo6eCpalAycBEQET3mzX6svRGxWd85ba4JwnWvYjzNiU
 BWoAivJ64wdgKhzubT4SCQcUbABoZ+MaQuQh6i98X03PDjq2NLvLL0H0XJUe7em5t2UM
 fJzIf3nyttA8yTGpnjUBhmde4UL2XHXBSH3/GMC2VqEDWtSKNxz/a5u0aRzC6q6nI5px
 1INA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693903824; x=1694508624;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JUEikI+8UdqOc2VGNOxBHLnl97oOfIXpCxawdnlEDMo=;
 b=hgWGuFll3bFtZArhcjsFuvuUN5tfsAVnufY1lrSPtbAqUuBI/l9MYQfXC9cWcE+KkE
 xJSX844481PKiu1VIKixKYr1sopMsrlSzfbTTRk2YF/89mRVps8CphpvPXN6FsvHaaIS
 IIG6q8QKdWvmyhaA2lTWCvF2HlDHedljsoz63k+R7SrYAR+GH8PEPwjNCC2cWWHUycue
 v/WckWKGrrx2BsDD1vYHDCjUniQ+B71XA1aR1tvpElLxPK6UcY1InxxK9xQrgKHvKi5Y
 HPcjbiYwTOxUsC/pVW5gcN7ssLZGkT3OH9G3JN/pSCQrfBoY0Y6XZ+zpmG+tvlH5MOwQ
 YHFQ==
X-Gm-Message-State: AOJu0YzJHRemLdsB3wRekT5JmWEdUtxMvE8hwXzJLXdkUu2wJiFack9z
 QOSBN5EJVjFpt1az/hswKp+GtQ==
X-Google-Smtp-Source: AGHT+IF515yTQ3QeVgzlMYcGEwnuspTWSQLI57f4UYmKfRt8JV1Og5XzZHHbXtor8Un5dILqoPHJBg==
X-Received: by 2002:a05:600c:2283:b0:401:b53e:6c57 with SMTP id
 3-20020a05600c228300b00401b53e6c57mr9928368wmf.9.1693903824586; 
 Tue, 05 Sep 2023 01:50:24 -0700 (PDT)
Received: from [192.168.69.115] (mst45-h01-176-184-47-79.dsl.sta.abo.bbox.fr.
 [176.184.47.79]) by smtp.gmail.com with ESMTPSA id
 y21-20020a05600c365500b003fed7fa6c00sm19490210wmq.7.2023.09.05.01.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 Sep 2023 01:50:24 -0700 (PDT)
Message-ID: <da23f1ce-ce6d-4634-5340-11972a1ecc79@linaro.org>
Date: Tue, 5 Sep 2023 10:50:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 1/5] cxl/mailbox: move mailbox effect definitions to a
 header
Content-Language: en-US
To: Gregory Price <gourry.memverge@gmail.com>, qemu-devel@nongnu.org
Cc: jonathan.cameron@huawei.com, linux-cxl@vger.kernel.org,
 junhee.ryu@sk.com, kwangjin.ko@sk.com,
 Gregory Price <gregory.price@memverge.com>
References: <20230901012914.226527-1-gregory.price@memverge.com>
 <20230901012914.226527-2-gregory.price@memverge.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230901012914.226527-2-gregory.price@memverge.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 1/9/23 03:29, Gregory Price wrote:
> Preparation for allowing devices to define their own CCI commands
> 
> Signed-off-by: Gregory Price <gregory.price@memverge.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c   | 35 +++++++++++++++++++----------------
>   include/hw/cxl/cxl_mailbox.h | 18 ++++++++++++++++++
>   2 files changed, 37 insertions(+), 16 deletions(-)
>   create mode 100644 include/hw/cxl/cxl_mailbox.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


