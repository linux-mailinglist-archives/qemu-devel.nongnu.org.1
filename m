Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC0DBA2B41
	for <lists+qemu-devel@lfdr.de>; Fri, 26 Sep 2025 09:26:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v22lU-0007eI-PE; Fri, 26 Sep 2025 03:21:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v22lB-0007Kp-6a
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:20:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1v22l0-0000fZ-NJ
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 03:20:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758871235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=VinELw6ydp3dgsoXc6HgLqtnSRgTojW1SO0ckdaWQYk=;
 b=WqNfrNOsQKVq8yiF7zCzljKVFyIoyFKmRowDDxvSd9x3v3jINwr/HxutIxEaleX8MPi/7F
 nd18CYAPvvhuTRHahWlYn/r2rP/DqiCjYf9AMTyNjOsOf5t8JbPxkr9s7hflvfeJb4HGBl
 nzGlgBdFti/iKSNdMZnv2Mj7LNuDm4U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-HHC60OiAM8OJSLODJpyP6w-1; Fri, 26 Sep 2025 03:20:33 -0400
X-MC-Unique: HHC60OiAM8OJSLODJpyP6w-1
X-Mimecast-MFC-AGG-ID: HHC60OiAM8OJSLODJpyP6w_1758871232
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e36686ca1so12618785e9.2
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 00:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758871232; x=1759476032;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VinELw6ydp3dgsoXc6HgLqtnSRgTojW1SO0ckdaWQYk=;
 b=Zx0CGslQPbo5DR+EPoDR7eYEXjIoAq9Zj/Ez6++gsQWSBPjTpNiReTPq5ccPi8Dbqr
 8+cXmlgNYJy1myL9jtFbbWhRAn9n3GJnM/K+23HAw5Rw8RaPCIEBe6IxGw5Q/7PvfgGb
 jmr0R+Gjt9EolHXGXnaR5n7qbaqoBsUuYG8xFtC0n4Bg+XS5/iU8Ht7QWiBPlHp0kCxQ
 eumDCWqT/RJ2fT8KeHGEl0Zh7py7TxH4fPLxr/zqlhi+pItyN8/Btn6jhlC0plP8gUta
 DzZ3K+Bb0Y5x7HoPthHh2tzjqFuUlejIfGBHNEjPZcRKL3e+K7b7t6L8H5uXSZu3TIbA
 /wfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV6O8jR3psP5YWxONyBo4Ny7T6w4lW3tMMk6UUGowYbw502NLK3UG1exonmasKPr0UICou2eHNIWCkU@nongnu.org
X-Gm-Message-State: AOJu0Yyr2t77UxcKngqFGmTPHM+VcMKbhyYyGiA/AfAJ6aYwqikVhVLa
 ckNswKOsDzWO50YDq+Lu5Hxf6SCnen125K0ulTCZgxiu8h0hLy3lfeUr+Kmz/sotU+2cSZ7ruew
 1HHDSoV/HWW08O8kqvjIkuCzkd+omIrzQjen2kH8MomV1POvZ6wR2Bc5y
X-Gm-Gg: ASbGncsICKyF+hSJyXXvzGYZkQ/ek+cf6rJ12NmkwhHlAZeYpbYwHUyz23bvNLCumTq
 vSTuRc9+FhsX/axzxDnmWGc4+aFKYp5rnRycqdfBJh+YX8vb0Ei/Z2JH2LpVfI5nlQatGj8/ffl
 wzFGdoyxA7UoOWBYKzJ3LZT5gNPfaSCkTaO7P2Ay/ZKY9soXOtFbMMz0exiL5F715ZBTAISbN8O
 wQ939nwv5uoMr+lWELWVcUM5dXiHxcbsD+9RPxM8a+rbMLEpL1dHQrYmyaI/uOEC7GwJWnnZPyc
 2F7m9vaN1f/9Bt+P8PfUo++KBfLNCqAj4VvzGFltngqdP7WA5CTWJ9ZUVWcAnrogKpRxN7PSnVf
 BurWMGQ==
X-Received: by 2002:a05:600c:8b62:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-46e39bdf9b4mr25035395e9.26.1758871232140; 
 Fri, 26 Sep 2025 00:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiDgzizr52SOtouLjyTVgDlHSR3/bjbj4VZSaffUKV9p00Q6aVP5hRf/ROPGznM83WDGc8bA==
X-Received: by 2002:a05:600c:8b62:b0:45d:5c71:769a with SMTP id
 5b1f17b1804b1-46e39bdf9b4mr25035145e9.26.1758871231750; 
 Fri, 26 Sep 2025 00:20:31 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-212.pools.arcor-ip.net.
 [47.64.114.212]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e2a9af27dsm108684475e9.8.2025.09.26.00.20.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Sep 2025 00:20:31 -0700 (PDT)
Message-ID: <d67d8967-dbe3-4d94-978f-0fcc35b12c17@redhat.com>
Date: Fri, 26 Sep 2025 09:20:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 7/9] tests/functional: Add decorator to skip test on
 missing env vars
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 alex.bennee@linaro.org, berrange@redhat.com
Cc: qemu-arm@nongnu.org, manos.pitsidianakis@linaro.org,
 peter.maydell@linaro.org
References: <20250926051542.104432-1-gustavo.romero@linaro.org>
 <20250926051542.104432-8-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250926051542.104432-8-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

On 26/09/2025 07.15, Gustavo Romero wrote:
> Add a decorator to skip tests on missing env variable(s). Multiple
> variable names can be provided and if one or more of them are not set in
> the test environment the test is skipped and the missing vars are
> printed out.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   tests/functional/qemu_test/__init__.py   |  3 ++-
>   tests/functional/qemu_test/decorators.py | 18 ++++++++++++++++++
>   2 files changed, 20 insertions(+), 1 deletion(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


