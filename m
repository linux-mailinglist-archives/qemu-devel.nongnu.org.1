Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 94DD2727C8D
	for <lists+qemu-devel@lfdr.de>; Thu,  8 Jun 2023 12:16:54 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q7Cfy-0004xL-0v; Thu, 08 Jun 2023 06:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Cfs-0004vb-3b
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:15:24 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1q7Cfq-0001CJ-8R
 for qemu-devel@nongnu.org; Thu, 08 Jun 2023 06:15:23 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5149bdb59daso594179a12.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jun 2023 03:15:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686219321; x=1688811321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xgu28jpocbhFGCVocir4cdnMERoI7inGsyIoxg2QWx0=;
 b=QRUsYFYG8wSG6LQvTBb87vZJoJrRmgaB3QCw4+8GspFt4sf8JSllJ30DNWC9A6U426
 fFJpbV8KFAPRhU4ts4VLhZrgeIXRspi9t8kWrZ5zc/nuAahwJ0aeMe7QwGefe1/GQX8M
 MaNVLsck29IIDXTDxlwWRpTePksBrodpqQ+6QZbzveCWKhfMlml/Nd1I5vL2fKHvRjaG
 HGWdWiNoSBRiamEmf0YWqubLSgU607absnB/XOyjbTGomzNeiYX72eH6vQj7bUwR+1/Y
 PHtXI84T9UYOhilpzv3r5gmjlI3Bv9Y4OBU2ZJw9JKxDCEKCBBYFG/QOEjNmaajIgUmm
 owjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686219321; x=1688811321;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xgu28jpocbhFGCVocir4cdnMERoI7inGsyIoxg2QWx0=;
 b=Qp7pI5fwZjQXlxjJNzZzFQ+PE3IAgv0i2OFfZJGQ7fUmh5/dQ6rTrbibcd2FDv5Mkt
 6my62kyh/7EAZUfmITxRvp0QnymItxCmRi1frvLwGz5mVBBcM5hyDrpmnL097kWKuAvV
 Ec/7WrG/x4xAZp4CKuvcb2ZIL+4l6ZLNNtu5t1RUFBMRsrlvKCOezrBntQPJy9hufo7k
 sWKBkOwuqiTd27Uk3ESKXhM8/1MDHnR76GVdKvmaCbevrXBbmgFeyByt952YbMQkLnSa
 aCZlYFrRJJxqg1ITFIiW1kaDCYZ8wvxv5C4sQUtrNryp+S+ao5z0t9b3VTg6UhHzi1r3
 TJGg==
X-Gm-Message-State: AC+VfDz5CqwES4YqgJJF9btRHXllYYkLSYOTWaOLSYBSghMphBoBd5fF
 O4nQ1VB5nuBZd4/Lk/q3aqqdO+n9O28lnudFxKBljw==
X-Google-Smtp-Source: ACHHUZ5p3M7LFBA71RUuaHeHt66n8RDdG1T9SfbK7HnHGnrIv0dHDD8dBbdt7Mr5QL4frcbl9IyH9m8LYUIMUGHVUZo=
X-Received: by 2002:aa7:c692:0:b0:514:9e3c:d826 with SMTP id
 n18-20020aa7c692000000b005149e3cd826mr7037403edq.5.1686219320750; Thu, 08 Jun
 2023 03:15:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230607085555.51643-1-quic_acaggian@quicinc.com>
In-Reply-To: <20230607085555.51643-1-quic_acaggian@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Jun 2023 11:15:09 +0100
Message-ID: <CAFEAcA_rJDE4oeqU-Mk0FgpG9UXUZQSN6QvAEXoXs9B4qw67+w@mail.gmail.com>
Subject: Re: [PATCH v2] hvf: Report HV_DENIED error
To: Antonio Caggiano <quic_acaggian@quicinc.com>
Cc: qemu-devel@nongnu.org, Cameron Esfahani <dirty@apple.com>, 
 Roman Bolshakov <r.bolshakov@yadro.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x529.google.com
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

On Wed, 7 Jun 2023 at 09:56, Antonio Caggiano <quic_acaggian@quicinc.com> wrote:
>
> On MacOS 11 and subsequent versions, in case the resulting binary is not
> signed with the proper entitlement, handle and report the HV_DENIED
> error.
>
> Signed-off-by: Antonio Caggiano <quic_acaggian@quicinc.com>
> ---
> v2: Use architecture specific defines from AvailabilityMacros.h to enable the
>     HV_DENIED case only on MacOS 11 and subsequent versions.
>
>  accel/hvf/hvf-all.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/accel/hvf/hvf-all.c b/accel/hvf/hvf-all.c
> index 754707dbfb..1eacfc6a95 100644
> --- a/accel/hvf/hvf-all.c
> +++ b/accel/hvf/hvf-all.c
> @@ -38,6 +38,11 @@ void assert_hvf_ok(hv_return_t ret)
>      case HV_UNSUPPORTED:
>          error_report("Error: HV_UNSUPPORTED");
>          break;
> +#if __MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
> +    case HV_DENIED:
> +        error_report("Error: HV_DENIED");
> +        break;
> +#endif

This doesn't seem to be the right ifdef guard:

../../accel/hvf/hvf-all.c:41:40: warning: 'MAC_OS_VERSION_11_0' is not
defined, evaluates to 0 [-Wundef]
#if __MAC_OS_X_VERSION_MIN_REQUIRED >= MAC_OS_VERSION_11_0
                                       ^
../../accel/hvf/hvf-all.c:42:10: error: use of undeclared identifier 'HV_DENIED'
    case HV_DENIED:
         ^
../../accel/hvf/hvf-all.c:44:14: error: expected ';' after break statement
        break
             ^
             ;

Our other version checks like this all do
#if defined(MAC_OS_VERSION_11_0) && MAC_OS_VERSION_MIN_REQUIRED >=
MAC_OS_VERSION_11_0
or similar.

>      default:
>          error_report("Unknown Error");
>      }
> --
> 2.40.0

thanks
-- PMM

