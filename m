Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 719687C6FC9
	for <lists+qemu-devel@lfdr.de>; Thu, 12 Oct 2023 15:54:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qqw8I-00074U-Tz; Thu, 12 Oct 2023 09:53:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqw89-0006wG-Tc
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:53:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qqw88-0005V4-6n
 for qemu-devel@nongnu.org; Thu, 12 Oct 2023 09:53:37 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4065f29e933so11652395e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Oct 2023 06:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697118814; x=1697723614; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hYzC3ACi1HPe/aVL/qw7dh1sRErz5sf+6ilXAvxWujs=;
 b=Qq16PCxw+eU/l44S2cc6pacRBqSOOSnb5prSH/K86+id1yNBn+YIvQTC8Bq/04wF4A
 FV43h+GCFoaQxzdVVvLanwH6sMteSUVPot2FrwO/3rfAnl/kR1wn2ZDGCQ3++hHrmKrp
 U+Df52VaWKsnewcip2vW5HBgxV20EQ8H9b0kx++gBY7+i8Yzmy2gYmZJqVgSzjlymeOq
 7+zT0M8bH0NoEj9oqZJ0+CRj+yBfswhTHprnoo9qoE/zpydGNfVtgQzzDjbZApCQGLxm
 CiOi+d3AxcKtd4yzvVUz7LZZ7YAPdkFfNb4ugPeyHCUIRXGytUCtrGLRIloDZCaz1eal
 uepQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697118814; x=1697723614;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hYzC3ACi1HPe/aVL/qw7dh1sRErz5sf+6ilXAvxWujs=;
 b=V7vkiGVdZ5ZiEv3ql1D1MwB/dfJfzVAmL4L6vEuZwc+9PGPO3rWGBcKTKh9SvdfNmM
 SJMIdmcQferzQPNVwJv1JLlqeOikTUknZartEvwMQtK3SSqxe4N/A0e9UXnjAAJCzsxT
 4ExoeqIEF63Taz62o/BV+70b5u6IaY56GNiTC8wc/mqcgcDw3RUbpX4udvps7tinPb6C
 ouCUc+Bbxzj/facW9q3OYjJWtWKgYJxdNmr8gUAb/PkhCqq0BptuWCSoAaB0cpAXn/33
 1fexC3q/BQfd7PCrSRLPePDdZ035yRXBOt5F3cTSloHIV38K/rClhLKolBGDzf5H+Cj3
 Nj/A==
X-Gm-Message-State: AOJu0YzLdXRF7YstpwfL1vyjv0hGksERMcbpZGW7VdndUUGzunWU4uUk
 oCL7aSbrr2/ixjWpwBALt4fPOdEtsJD8n7JTrOdMhQ==
X-Google-Smtp-Source: AGHT+IH2GWBa8w5KpKXtkHYeOly+UAZt/kyYrWGScB3w3AcynNgs8xDvylnu6q0sqWjqxYRRkj2RGA==
X-Received: by 2002:adf:9795:0:b0:32d:8547:e440 with SMTP id
 s21-20020adf9795000000b0032d8547e440mr4581893wrb.38.1697118814510; 
 Thu, 12 Oct 2023 06:53:34 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-232.abo.bbox.fr.
 [176.131.211.232]) by smtp.gmail.com with ESMTPSA id
 x11-20020adff0cb000000b00323293bd023sm18642270wro.6.2023.10.12.06.53.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Oct 2023 06:53:34 -0700 (PDT)
Message-ID: <cde8c0de-1233-007a-097b-c7638f773829@linaro.org>
Date: Thu, 12 Oct 2023 15:53:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 1/3] migration/multifd: Remove direct "socket" references
Content-Language: en-US
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Leonardo Bras <leobras@redhat.com>
References: <20231012134343.23757-1-farosas@suse.de>
 <20231012134343.23757-2-farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231012134343.23757-2-farosas@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 12/10/23 15:43, Fabiano Rosas wrote:
> We're about to enable support for other transports in multifd, so
> remove direct references to sockets.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>   migration/multifd.c | 22 ++++++++++++++++------
>   1 file changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


