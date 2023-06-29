Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2759C742139
	for <lists+qemu-devel@lfdr.de>; Thu, 29 Jun 2023 09:43:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qEmJV-0002Op-ML; Thu, 29 Jun 2023 03:43:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmJF-00028D-2B
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:43:22 -0400
Received: from mail-lf1-x131.google.com ([2a00:1450:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qEmJD-0006Ll-ET
 for qemu-devel@nongnu.org; Thu, 29 Jun 2023 03:43:20 -0400
Received: by mail-lf1-x131.google.com with SMTP id
 2adb3069b0e04-4f766777605so564954e87.1
 for <qemu-devel@nongnu.org>; Thu, 29 Jun 2023 00:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688024597; x=1690616597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=olRZbAHn40veJIowyJI7ddLxPzTbrX9N7lFFpSDjonI=;
 b=yEs29bvbgfHWBntz+Nc3vkyw72y9fPClS3rQJUUT5LvDgKWdnuHDqM7PbezhuHALpd
 jNp48hofe9IN8Kjfh68LF0GznzsiwK74Sb2q1U+fUYlA+HIwCR9SO3c2wpbhYhqq+HJ1
 SH0iC+wBZsy4h1P1UmNitycCUTdt/1/SKxgJCgmlR/BhX77V5CuqN9M2Uw2/qcJQjK0/
 yjoPsG9NMVthZceYrRojA8tgGWgReGN/Fb8U4WrUVxDClGUkB7qQEkHREbJ5gtWHiY21
 Vq2NWquNcD96XUm7gmoBmDAFC348ALbokaKRjFfDEa5XRNiokb8ZipPAz4s6kjy9di+a
 MQxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688024597; x=1690616597;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=olRZbAHn40veJIowyJI7ddLxPzTbrX9N7lFFpSDjonI=;
 b=RJInLRrcHsYGPFEBHQpjrMGmZF8s3gsQIG7z0fIUSuncZCoLsqzqkRDNmMkOlREtmR
 hYwAw6DnRa4mpuC1zNcRRu9If8UpkJAGpRsumNqjR1MybkRUsKEcUErJetpszXoqEPh4
 0skqeiFXaZ9PGSbjNuH1Fq3OKkVK4MmryNF9AJZbLUfyIwId26DdU/8IrABcn+5HP+8F
 J42S+Wf87aE9iMKGeSCDF5piXF1grfhA1h9QGC8xHegwFcnvMCnpzTXR2aUulKvoHy/f
 tRwAvXvj0sCqdlp7C5OK0e3PZipNaRAAkbgqenJjkigUliJ3dl++CUHRyFmncVvgHe0h
 H1sw==
X-Gm-Message-State: AC+VfDzARCyej5JXti+lvtvB/wsAl70QFkeW6+6Cgk3Gn5gDWouaF9Sk
 yyNZXICsw6RIPk+Z+QkaRKh6cO5XgrUvWL+rivo=
X-Google-Smtp-Source: ACHHUZ4FAgdCyS/rL+6wzbTrIhyLwOl900yZLiChQy3dcYNSsLVxeLanZOKP1zBzcvLtB46SgL8q6Q==
X-Received: by 2002:a19:3813:0:b0:4f8:7697:5207 with SMTP id
 f19-20020a193813000000b004f876975207mr16851360lfa.23.1688024597475; 
 Thu, 29 Jun 2023 00:43:17 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.166.242])
 by smtp.gmail.com with ESMTPSA id
 b9-20020a5d40c9000000b0031417fd473csm749605wrq.78.2023.06.29.00.43.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 29 Jun 2023 00:43:16 -0700 (PDT)
Message-ID: <17acd75b-72cb-a4d7-9d06-c78693423b6b@linaro.org>
Date: Thu, 29 Jun 2023 09:43:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/16] hw/i386/pc_q35: Resolve redundant q35_host
 variable
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>, "Michael S. Tsirkin"
 <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230628195204.1241-1-shentey@gmail.com>
 <20230628195204.1241-2-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230628195204.1241-2-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::131;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x131.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 28/6/23 21:51, Bernhard Beschow wrote:
> The variable is redundant to "phb" and is never used by its real type.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/i386/pc_q35.c | 27 +++++++++++++--------------
>   1 file changed, 13 insertions(+), 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


