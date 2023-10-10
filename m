Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 274987BF7E3
	for <lists+qemu-devel@lfdr.de>; Tue, 10 Oct 2023 11:51:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qq9Nt-0006MS-V9; Tue, 10 Oct 2023 05:50:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9Nl-0006Fq-KN
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qq9NV-0003t5-Rd
 for qemu-devel@nongnu.org; Tue, 10 Oct 2023 05:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696931411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzlqfLMI90FvqxE3Zbk7F049uM7oauvw63r14pDiCKI=;
 b=AnXT7BzZJGwkk5MqdDozyG/sVMR5Gb8uWbTkET61p4GhicrfsMnynG1kAqLMyFoohBckSu
 kBxjDv6AhedLLzMTpA6bfMfeQnS+b5IxtUePSJ8tZ28PS9WBfiwXFNKTd75MI7ykDq0Hfv
 bFaQ46ge0EvbYdB10O2a3uLY80M+npg=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-f8Bv_ovFOI2YXCw1A1KruA-1; Tue, 10 Oct 2023 05:50:00 -0400
X-MC-Unique: f8Bv_ovFOI2YXCw1A1KruA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-419923ea68cso63772361cf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Oct 2023 02:50:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696931400; x=1697536200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FzlqfLMI90FvqxE3Zbk7F049uM7oauvw63r14pDiCKI=;
 b=ZNelA8odM73s+LLn2ChrkTQSNcSziGdLvFv/aOk4wAQUJnLfS0jHabgRw6TlfWFGaM
 JXyK4tFnMCUgzAMfPb/tLjk82bvMGiYmAc8fmSnIA7vyHEqK53hTM5wqLQiORNsl9UN2
 LWsLN7kYMQbJoZMFsyybhm01OoD2qUWUVVZpXWQaP04Xn5woxaFx0ysw6jnXoXxrS0Iw
 sgxKuV8vxNazyAJMyhZBnRwTsiOXIazx7Hyh+L/cavZFM7Z1iJt+knEF3F9OdQevh4Q5
 m55212xHap9yOnNi8AgRi89j3UCCZId9xBGXqSyXg6iobj9Z8f5GDMjiV4lFdnMhZzhY
 2AyA==
X-Gm-Message-State: AOJu0YyNQ7vCxIobk4qDhnqbZSooH0Db12QCx4EsSN7CdMD+A0JhtIdy
 BLt643orkDbpu+XqC4l2i8RGSvUpbB8PrmhLRCIrS5brhv/TMM4eme0QxdetWyp7Uw9pxca2/Zb
 WbZW0uJn9xuoPHX4=
X-Received: by 2002:a05:622a:15d3:b0:419:50c7:f6e9 with SMTP id
 d19-20020a05622a15d300b0041950c7f6e9mr21036171qty.25.1696931400219; 
 Tue, 10 Oct 2023 02:50:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFF2P8x0PulP5PNGrnKuNej40VZOM458VVs4Pao2lMGqVxGIG87+xO59sAx4ZgeJl9beCC71Q==
X-Received: by 2002:a05:622a:15d3:b0:419:50c7:f6e9 with SMTP id
 d19-20020a05622a15d300b0041950c7f6e9mr21036154qty.25.1696931399902; 
 Tue, 10 Oct 2023 02:49:59 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-176.web.vodafone.de.
 [109.43.176.176]) by smtp.gmail.com with ESMTPSA id
 e1-20020ac81301000000b0040331a24f16sm4348896qtj.3.2023.10.10.02.49.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Oct 2023 02:49:59 -0700 (PDT)
Message-ID: <d69ced42-5fba-8dcc-5137-2fa95b97482e@redhat.com>
Date: Tue, 10 Oct 2023 11:49:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/4] tests/qtest: Use qtest_get_arch_bits()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 qemu-block@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20231010074952.79165-1-philmd@linaro.org>
 <20231010074952.79165-3-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231010074952.79165-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-3.339, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/10/2023 09.49, Philippe Mathieu-Daudé wrote:

Some short patch description, please! Why is this necessary/useful?
(I think I know, but other might not, and it is also important for the history)

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/qtest/arm-cpu-features.c | 49 ++++++++++++++++------------------
>   tests/qtest/bios-tables-test.c | 16 +++++------
>   2 files changed, 30 insertions(+), 35 deletions(-)

  Thomas


