Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F38A7BD96A
	for <lists+qemu-devel@lfdr.de>; Mon,  9 Oct 2023 13:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qpoI9-0001ky-P7; Mon, 09 Oct 2023 07:19:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpoI4-0001kY-D8
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:19:12 -0400
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qpoI2-0006qN-ID
 for qemu-devel@nongnu.org; Mon, 09 Oct 2023 07:19:12 -0400
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-98377c5d53eso759572566b.0
 for <qemu-devel@nongnu.org>; Mon, 09 Oct 2023 04:19:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1696850348; x=1697455148; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uM24XXHNOlojaGvihP4K0iwPL3Q5ePeZkzDc4bGG7nI=;
 b=N2PN12L9DqwBmTMjNNpxOOF26ZDNA4fl1fHFU32Nl7ih4MezzaRdexKKEpWYXpWOpZ
 ywr7bcdIE9kXwr11hh4E3jBGSubSPKemM/z7P2w5FpDWcNucPO/pbHASpMJAkXCA8arO
 8FQclz1yfjbe/obl4voBGFXSdogNUkFYEKTmvrOF5St2ONkMn+N7poMS1e9x4vFlWqpb
 yr6ryC1e21JRxcwoDj5XMGgg+Atp9opRMSZd31/wksmcn7tCcPyMygNcb/4gQvMwT8uO
 OUsmRasqm0HXeCrTeV5iQFPXnV5tEeN340YpnJD3bQjlKajJ84RsgCoq8ITAmXPnmXIS
 3OqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696850348; x=1697455148;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uM24XXHNOlojaGvihP4K0iwPL3Q5ePeZkzDc4bGG7nI=;
 b=oWwCNMykcnGYhzlEqVPXjbebeCjBtwOkMtjexb5U93jzVwfp3Y3lvh/6xcBDrzL8FJ
 hZgNkZWVZy/0Y09MF82mDFe1U9YOeO+0JvbTXJ1REF1gX4hGSlxsH2s38aLPt5rzEsTL
 6KsQE6qCKgsIfXSBvZ1JIr+4iW5Fu++dgpzWPP5bimNdksVXlfbkD5zEZGzSnwvLOH9i
 Py6hAVA6i3VrIJ9A3hIksPUFj3dAt7y2e37tOCz3vwh06ZgBxyBntddN/eF4NS/iw1Bi
 HI/jLo8v8HBQm2jxjrg6BOAbcrUHaDVv5RKYeWbHjAySwEjeHhTPv20Jl0brImnvFJ6q
 4Pvw==
X-Gm-Message-State: AOJu0YyP6gaZm7GtTmsJzEO8nHTB9iVH8vuOPGUqPspyxa3HElXnTDpA
 8DyGwkSTPLsLeXa5UCnS0lwMPQ==
X-Google-Smtp-Source: AGHT+IFDjrdkjafiAsaVDm0qoAv+L9PRXXn3eP6/f+7wmvpVIF5q3/ADLRdKOAk2ekoN149YmHTWdA==
X-Received: by 2002:a17:906:3ca1:b0:9ad:e4e1:1476 with SMTP id
 b1-20020a1709063ca100b009ade4e11476mr10181885ejh.77.1696850348468; 
 Mon, 09 Oct 2023 04:19:08 -0700 (PDT)
Received: from [192.168.69.115]
 (thr44-h01-176-170-217-185.dsl.sta.abo.bbox.fr. [176.170.217.185])
 by smtp.gmail.com with ESMTPSA id
 j17-20020a170906831100b0098e78ff1a87sm6519291ejx.120.2023.10.09.04.19.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Oct 2023 04:19:08 -0700 (PDT)
Message-ID: <78921033-d8f5-d736-0437-b805e78c1a55@linaro.org>
Date: Mon, 9 Oct 2023 13:19:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH] qapi: Belatedly update CompatPolicy documentation for
 unstable
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: eblake@redhat.com
References: <20231009110449.4015601-1-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231009110449.4015601-1-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62f.google.com
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

On 9/10/23 13:04, Markus Armbruster wrote:
> Commit 57df0dff1a1 (qapi: Extend -compat to set policy for unstable
> interfaces) neglected to update the "Limitation" paragraph to mention

With retrospective, 'experimental' seems more meaningful. Anyway,
too  late.

> feature 'unstable' in addition to feature 'deprecated'.  Do that now.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>   qapi/compat.json | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/qapi/compat.json b/qapi/compat.json
> index f4c19837eb..42034d9368 100644
> --- a/qapi/compat.json
> +++ b/qapi/compat.json
> @@ -43,8 +43,8 @@
>   # This is intended for testing users of the management interfaces.
>   #
>   # Limitation: covers only syntactic aspects of QMP, i.e. stuff tagged
> -# with feature 'deprecated'.  We may want to extend it to cover
> -# semantic aspects and CLI.
> +# with feature 'deprecated' or 'unstable'.  We may want to extend it
> +# to cover semantic aspects and CLI.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



