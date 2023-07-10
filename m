Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B1A674CF76
	for <lists+qemu-devel@lfdr.de>; Mon, 10 Jul 2023 10:08:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qIlvp-0005du-55; Mon, 10 Jul 2023 04:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlvS-0005bG-Ua
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qIlvQ-0006gR-S4
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 04:07:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688976435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dVgYQGG2MblQPh1KswH8sUdqO1b1dXo9y6S3k4CW9+k=;
 b=SaCOP8W9jYhSirrfNcfAZ4Ws53PIMxuL+gUEI3S5NGfEwHxitfJeS/9Br+ZUWhAM38xOhp
 MZsmdfo2BjfsoIT9Jdz7DrJd3ln8IpoRSykbMo+AkBVaxC+E182WzioTkPd0lmeJsZ1g4A
 HOiXS/RMA7WhWKpoyjLO4/gbDXF1jIE=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-145-DftGGDqAMNqRIUGCfJcpQQ-1; Mon, 10 Jul 2023 04:07:14 -0400
X-MC-Unique: DftGGDqAMNqRIUGCfJcpQQ-1
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4033e4d51ecso45111911cf.0
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 01:07:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688976431; x=1691568431;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dVgYQGG2MblQPh1KswH8sUdqO1b1dXo9y6S3k4CW9+k=;
 b=lLiYdECT07ywQxlKog02ZT4U741fAif89kZiFzSvLocg95TZX/osr3qulPEHpvnNLG
 Jgw/PP24lDIjThHS+IMRe3I0ZEO+9hq8NqOxi66wWKCzQwL02QDHYRDbyptT5vmRiWFB
 Av+Fz+JxTNZjbeGe9aq1P/ibduLlYA4k1Wr+fGOS4de1cVnkMphAah6PuWPR9Eici0Cu
 aWOSKOOzEhq8CzMQ9Nh8dmPCLklWEbIWgFPcLwE/YzYpMx1++KAaEoJWRl2EkbXkVC++
 9GB9el8ZMoCm7Z9+pHmYXIgaWKrbKFGN1ufuXSF+dUPzZfxJUcBGYtixcLKmatSRHwsO
 PRhQ==
X-Gm-Message-State: ABy/qLaerFIfcgu4rHYy1JCYWi7GeZPNq2WN1Y4787VEZ6cCwy5OPsgf
 jY5gk+DYhOEmbd7C8yZLn0GtWXMGA7lxxfZ/lq3q0FjVuiB83qKB2/pqFTUweaYLgFqGflj/ocO
 7X6FL2Ui9wBMQdnU=
X-Received: by 2002:a05:622a:130a:b0:3f3:96a3:c76f with SMTP id
 v10-20020a05622a130a00b003f396a3c76fmr12889372qtk.22.1688976430916; 
 Mon, 10 Jul 2023 01:07:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGRxJjnX8fWteTJyfFLH4aqVv/PQGL2GcDA7pGPQi8K6QKiX6LJxh3PvIMIUsqWKGXhBj0Bew==
X-Received: by 2002:a05:622a:130a:b0:3f3:96a3:c76f with SMTP id
 v10-20020a05622a130a00b003f396a3c76fmr12889358qtk.22.1688976430704; 
 Mon, 10 Jul 2023 01:07:10 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-116.web.vodafone.de.
 [109.43.179.116]) by smtp.gmail.com with ESMTPSA id
 i3-20020ac871c3000000b003f7fd3ce69fsm4719132qtp.59.2023.07.10.01.07.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Jul 2023 01:07:10 -0700 (PDT)
Message-ID: <d63639e1-2028-4882-c62b-b2c48443a962@redhat.com>
Date: Mon, 10 Jul 2023 10:07:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 3/4] QGA VSS: Print error in err_set
Content-Language: en-US
To: Konstantin Kostiuk <kkostiuk@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
References: <20230710074639.996030-1-kkostiuk@redhat.com>
 <20230710074639.996030-4-kkostiuk@redhat.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230710074639.996030-4-kkostiuk@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01,
 RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 10/07/2023 09.46, Konstantin Kostiuk wrote:
> Signed-off-by: Konstantin Kostiuk <kkostiuk@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   qga/vss-win32/requester.cpp | 8 +++++---
>   1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/qga/vss-win32/requester.cpp b/qga/vss-win32/requester.cpp
> index e85b9bc633..f3eafacfc1 100644
> --- a/qga/vss-win32/requester.cpp
> +++ b/qga/vss-win32/requester.cpp
> @@ -26,9 +26,11 @@
>   
>   #define DEFAULT_VSS_BACKUP_TYPE VSS_BT_FULL
>   
> -#define err_set(e, err, fmt, ...)                                           \
> -    ((e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__, \
> -                                   err, fmt, ## __VA_ARGS__))
> +#define err_set(e, err, fmt, ...) {                                         \
> +    (e)->error_setg_win32_wrapper((e)->errp, __FILE__, __LINE__, __func__,  \
> +                                   err, fmt, ## __VA_ARGS__);               \
> +    qga_debug(fmt, ## __VA_ARGS__);                                         \
> +}
>   /* Bad idea, works only when (e)->errp != NULL: */
>   #define err_is_set(e) ((e)->errp && *(e)->errp)
>   /* To lift this restriction, error_propagate(), like we do in QEMU code */

Reviewed-by: Thomas Huth <thuth@redhat.com>


