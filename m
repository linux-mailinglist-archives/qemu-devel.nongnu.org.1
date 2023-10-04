Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 085797B86C0
	for <lists+qemu-devel@lfdr.de>; Wed,  4 Oct 2023 19:41:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qo5oh-0003Zn-J1; Wed, 04 Oct 2023 13:37:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5oe-0003Yu-04
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:37:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qo5oR-00024P-LM
 for qemu-devel@nongnu.org; Wed, 04 Oct 2023 13:37:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696441050;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PstiGGB3qn3D8jCb7jeXQwuehLpvqpSWMSYnr2qacko=;
 b=Nci5pbcFlH+El33kvklA0lXmKD+tcoR3QssvQe/S73inHUWMl1j8kld2A0Y1Nl/GfJPYKm
 TUfH3Lkw4tkNBgFaAUpS6f+GWVMFHw0NqBYkIMp435I7c6jDP60F8/9yD90v8CB3nYR0Ke
 fPdRKgjPXrq1U0NDXZ18/eKtbT0RHuM=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-DBnCACavOk2YUMPS-r1fWA-1; Wed, 04 Oct 2023 13:37:29 -0400
X-MC-Unique: DBnCACavOk2YUMPS-r1fWA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6564dbde089so16948966d6.1
 for <qemu-devel@nongnu.org>; Wed, 04 Oct 2023 10:37:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696441048; x=1697045848;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PstiGGB3qn3D8jCb7jeXQwuehLpvqpSWMSYnr2qacko=;
 b=Za1MnvmeVc6hguFICNmm+eGb0lqhFTO67oUSgB6m2jwCmEX5bE352pLSnEhAqzuWWK
 ezDmUaiqAuYazWFukXKPGcPhB/3bNLW0iEhAVIup4yvbDFVLPWN9x2yGs0CzdwNInPRG
 nFMSHlw8dHUmtuM68qBG5YWkdNs2YtR9WVIZXJEX+uSFpU82N8PuRXchO0d0e/0mdtF4
 XRAbi0AiBA2ROM6l1dXqDeH2gsP0W6Tk7PE55+EBSpX4jKUdpjijbaRZcCwOzPX+X1ig
 JlyWVYbMgjVU2LUuMcoZqF3PPVC9Am+8YMa9CBkE1S4b4Hzmroq8Y0pOn/jGu1iPXfbu
 0IHA==
X-Gm-Message-State: AOJu0YxbY9ZbaKzrEw7Lvpqjh0WeGdhlSfT1oDnyqCNcNo83v4vewBbo
 GdNb6S4NoOZsCYBT6NDqhOrdlKt0T1BmNoKmgJTdAmhQjVHwz/pANJ88Kv20+grZjfhkf9RLvfl
 pGA/S8jxpFmk+1u8=
X-Received: by 2002:a05:6214:5299:b0:656:25fb:2a16 with SMTP id
 kj25-20020a056214529900b0065625fb2a16mr393229qvb.28.1696441048601; 
 Wed, 04 Oct 2023 10:37:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFd7ugUt1PC2cXBHqx1RU9F03bSmwW9+xgJx+nzPDW3nV1MlA2SpNNK9hIqGaaocwWW4q1Rog==
X-Received: by 2002:a05:6214:5299:b0:656:25fb:2a16 with SMTP id
 kj25-20020a056214529900b0065625fb2a16mr393213qvb.28.1696441048289; 
 Wed, 04 Oct 2023 10:37:28 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-176-27.web.vodafone.de.
 [109.43.176.27]) by smtp.gmail.com with ESMTPSA id
 x15-20020a0ce0cf000000b0065b2e561c17sm1473039qvk.123.2023.10.04.10.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Oct 2023 10:37:27 -0700 (PDT)
Message-ID: <5f3b973d-1de6-5c99-cf94-ad9617b2d6da@redhat.com>
Date: Wed, 4 Oct 2023 19:37:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 07/21] qapi: Inline QERR_INVALID_PARAMETER_TYPE definition
 (constant param)
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-block@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>
References: <20231004173158.42591-1-philmd@linaro.org>
 <20231004173158.42591-8-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20231004173158.42591-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.528, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 04/10/2023 19.31, Philippe Mathieu-Daudé wrote:
> Address the comment added in commit 4629ed1e98
> ("qerror: Finally unused, clean up"), from 2015:
> 
>    /*
>     * These macros will go away, please don't use
>     * in new code, and do not add new ones!
>     */
> 
> Mechanical transformation using the following
> coccinelle semantic patch:
> 
>      @match@
>      expression errp;
>      constant param;
>      constant value;
>      @@
>           error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
> 
>      @script:python strformat depends on match@
>      param << match.param;
>      value << match.value;
>      fixedfmt; // new var
>      @@
>      fixedfmt = f'"Invalid parameter type for \'{param[1:-1]}\', expected: {value[1:-1]}"'
>      coccinelle.fixedfmt = cocci.make_ident(fixedfmt)
> 
>      @replace@
>      expression match.errp;
>      constant match.param;
>      constant match.value;
>      identifier strformat.fixedfmt;
>      @@
>      -    error_setg(errp, QERR_INVALID_PARAMETER_TYPE, param, value);
>      +    error_setg(errp, fixedfmt);
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/arm-qmp-cmds.c        | 3 ++-
>   target/s390x/cpu_models_sysemu.c | 3 ++-
>   2 files changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/arm-qmp-cmds.c b/target/arm/arm-qmp-cmds.c
> index b53d5efe13..3c99fd8222 100644
> --- a/target/arm/arm-qmp-cmds.c
> +++ b/target/arm/arm-qmp-cmds.c
> @@ -154,7 +154,8 @@ CpuModelExpansionInfo *qmp_query_cpu_model_expansion(CpuModelExpansionType type,
>       if (model->props) {
>           qdict_in = qobject_to(QDict, model->props);
>           if (!qdict_in) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> +            error_setg(errp,
> +                       "Invalid parameter type for 'props', expected: dict");
>               return NULL;
>           }
>       }
> diff --git a/target/s390x/cpu_models_sysemu.c b/target/s390x/cpu_models_sysemu.c
> index 63981bf36b..4507714493 100644
> --- a/target/s390x/cpu_models_sysemu.c
> +++ b/target/s390x/cpu_models_sysemu.c
> @@ -111,7 +111,8 @@ static void cpu_model_from_info(S390CPUModel *model, const CpuModelInfo *info,
>       if (info->props) {
>           qdict = qobject_to(QDict, info->props);
>           if (!qdict) {
> -            error_setg(errp, QERR_INVALID_PARAMETER_TYPE, "props", "dict");
> +            error_setg(errp,
> +                       "Invalid parameter type for 'props', expected: dict");
>               return;
>           }
>       }

Acked-by: Thomas Huth <thuth@redhat.com>


