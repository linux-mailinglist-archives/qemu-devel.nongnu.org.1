Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03AB872FEFF
	for <lists+qemu-devel@lfdr.de>; Wed, 14 Jun 2023 14:47:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9PbF-0006lL-Ss; Wed, 14 Jun 2023 08:27:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9PbD-0006kO-1G
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:27:43 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q9PbB-00009p-Ea
 for qemu-devel@nongnu.org; Wed, 14 Jun 2023 08:27:42 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-977c89c47bdso108189066b.2
 for <qemu-devel@nongnu.org>; Wed, 14 Jun 2023 05:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686745659; x=1689337659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=o37TAqTGrX8tIz+TVOfb7QMBpiIOZavy3chHP9lBUu4=;
 b=B9wFYQWuioF04zouqk9X+9G3DUnovCM8iMDesjQuv1gqOcstQ8unoxlqjqNzocfcSj
 EjJ0Pc8bDDx34zhYJVRUInfrWOcxjyGyjT5iP4zFxbKSlKz8g/g/78Lk3FDQFIIudz8t
 skVDaz6AIfDrtdnLLZ34L7ChUcOc/q9LJFICCwejRR/3wZUz4Xuxp0rLWGohqC4YiaUI
 YT6e3CqmvohXEKEDS4Zuggkpet+EOAGL8hDp7kALiC8WuFmgOgGb/1BxJGZ4ruwdyPds
 CS0GE9I2RTZxxREmCJcBgAQJgavWU/vacoUsUd3pQm/46wQxOG3Dac7CkJhh+0I5qK5q
 WTYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686745659; x=1689337659;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=o37TAqTGrX8tIz+TVOfb7QMBpiIOZavy3chHP9lBUu4=;
 b=DLBuyE+9xBbyjc574zL/STdZg/+uIdBQKw7z7eUBk2wOVC6/XiMb3XxnHhR8oiTQig
 UjidJ767vGx80vFCSICHP9+HSGLqM0N5jKHhM4bAcpbe1eqknfurPPGhfk3ZPlR/72Ik
 cV/CePAOAC8I2nDd1DNaHrJsPZI10U/9ATcoqM4/Jyn7dbrd4A0x1yC7vtfj8ifG1pm0
 SxXQXMRAweF0Lu2gkRzo5d8KeM0ilS4sAh49t3gXl9YTG9bF3YAmSVj7MBprbpR+xTIm
 9Nc1JkQFlJ5H3hANTragKdrF1P/wDv+ndJLWvg5R4MzMFhLEclZlvx4fYSdrqh22kWeR
 SY6A==
X-Gm-Message-State: AC+VfDz9xb74hGe+ClZ3Xjvozvzloer+9ilLAziUiaC9nHCNSZiZRrpc
 m9ikPDz1MsS49pH4WbBgwPuBJQ==
X-Google-Smtp-Source: ACHHUZ52SWeN5GFil7OlY8XQc8TCkvE/unZpOYzoV57mUbTUNYazoN9jM6ELGCYKp3ZLIA+Jo43mBQ==
X-Received: by 2002:a17:906:fe4d:b0:974:1e0e:91ee with SMTP id
 wz13-20020a170906fe4d00b009741e0e91eemr16521314ejb.13.1686745659393; 
 Wed, 14 Jun 2023 05:27:39 -0700 (PDT)
Received: from [10.14.201.118] ([213.175.39.66])
 by smtp.gmail.com with ESMTPSA id
 e26-20020a1709062c1a00b00974556e50a6sm7992135ejh.114.2023.06.14.05.27.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 05:27:38 -0700 (PDT)
Message-ID: <dca0331c-66fb-1b38-8d45-1e5d7c118494@linaro.org>
Date: Wed, 14 Jun 2023 14:27:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 09/10] memory-device: Refactor memory_device_pre_plug()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>
References: <20230601121447.272487-1-david@redhat.com>
 <20230601121447.272487-11-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230601121447.272487-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.098,
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

On 1/6/23 14:14, David Hildenbrand wrote:
> Let's move memory_device_check_addable() and basic checks out of
> memory_device_get_free_addr() directly into memory_device_pre_plug().
> 
> Separating basic checks from address assignment is cleaner and
> prepares for further changes.
> 
> As all memory device users now use memory_devices_init(), and that
> function enforces that the size is 0, we can drop the check for an empty
> region.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   hw/mem/memory-device.c | 28 ++++++++++++++--------------
>   1 file changed, 14 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


