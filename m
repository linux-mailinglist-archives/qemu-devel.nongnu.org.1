Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 691C179DF95
	for <lists+qemu-devel@lfdr.de>; Wed, 13 Sep 2023 07:56:41 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgIq8-0002wM-TC; Wed, 13 Sep 2023 01:55:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgIq4-0002vy-Lh
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 01:55:00 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgIpy-0002WW-AW
 for qemu-devel@nongnu.org; Wed, 13 Sep 2023 01:54:59 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-502153ae36cso10313412e87.3
 for <qemu-devel@nongnu.org>; Tue, 12 Sep 2023 22:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694584491; x=1695189291; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZKPvNQyBs+vs3I8fZOSjCeF/0yGMYMuEac8xoLH2N7g=;
 b=JtLaR1Np6DcIC77IPAUcsPMJfNzbTRk8OPzNbO5QsOcWvDydJxuc0R/Qk54b4w/cDg
 8K1Pwkucf8JGVaYeG3UP9Vb1SbDYTKhA8N7XQbc0X1FE3uORxRAl7u+zlyiy9eRo0MkI
 CxWciL+Ntkv1rdi5qwqR2awXsFH1x5zBplCHhSA/2n2doLfG5o1wtFdZoHZSYQz2++Up
 plLWQoZb8suAge2j//fUdQCvdaWOhy9A0D7ZCSEbEa55flECiqzdSv/aSMyF9mlo4JfL
 nllA4tKfuDCnot9WytLaG/PdPsJgMgDJtQ/htcmp+emI8oKkWUQic2ETZjF0LoAq8gKs
 OjDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694584491; x=1695189291;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZKPvNQyBs+vs3I8fZOSjCeF/0yGMYMuEac8xoLH2N7g=;
 b=DF7ORiQC2p65gPJ8pAkwfza8XAQXcxRt+32XJPzXnx9AKGce5ouny42tawzRFG+oIN
 imTS4rui+P1KNXQs+cpdYQGdPvrZT3mYd0AHXvdiJDU1ZOaPLxfMrhNdqcBbHnkr5ZtB
 uunV1+ND7+HUjbcRY4KaElB+ToaahQ4Am3N9WKw1oVeNvAjbL+7rRdOfNc+fwgp/tAnj
 M8pfDviAjoaZfsIzM2nregwnC/RPEzlXFKlENNrwGM+Ami9uGp+wKdf9fRG4zTcifVF8
 3Fgh0y0Eow6e19ZbBJILhi8It0didJbmeivi92cKWGAmsjf2GCtn9mb5bwtJedgird1x
 KJEQ==
X-Gm-Message-State: AOJu0YziBjwofi8yGjHJdqcA79HZSK8sG8n1JsH26T6oNs2TJHvCpwrt
 H2/+FsuSjvYonuATQR3OAtgbvg==
X-Google-Smtp-Source: AGHT+IHy7kim5wKyBRfCsYI1k7Ig8jS1Z86GAxcoEIeK2jhCysIA9WfbpxDSV4n9UfdpgCJ+3nqACg==
X-Received: by 2002:a19:2d1b:0:b0:502:a0e9:8820 with SMTP id
 k27-20020a192d1b000000b00502a0e98820mr1001800lfj.47.1694584491300; 
 Tue, 12 Sep 2023 22:54:51 -0700 (PDT)
Received: from [192.168.69.115] (176-131-211-241.abo.bbox.fr.
 [176.131.211.241]) by smtp.gmail.com with ESMTPSA id
 g1-20020a170906394100b0099bc038eb2bsm7717523eje.58.2023.09.12.22.54.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Sep 2023 22:54:50 -0700 (PDT)
Message-ID: <ff8b8e0b-d0b0-6194-4d02-9cbe134d5eac@linaro.org>
Date: Wed, 13 Sep 2023 07:54:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH 3/4] gitlab: make Cirrus CI timeout explicit
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-arm@nongnu.org,
 Stefan Hajnoczi <stefanha@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20230912184130.3056054-1-berrange@redhat.com>
 <20230912184130.3056054-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230912184130.3056054-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x136.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 12/9/23 20:41, Daniel P. Berrangé wrote:
> On the GitLab side we're invoking the Cirrus CI job using the
> cirrus-run tool which speaks to the Cirrus REST API. Cirrus
> sometimes tasks 5-10 minutes to actually schedule the task,
> and thus the execution time of 'cirrus-run' inside GitLab will
> be slightly longer than the execution time of the Cirrus CI
> task.
> 
> Setting the timeout in the GitLab CI job should thus be done
> in relation to the timeout set for the Cirrus CI job. While
> Cirrus CI defaults to 60 minutes, it is better to set this
> explicitly, and make the relationship between the jobs
> explicit
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/cirrus.yml       | 3 +++
>   .gitlab-ci.d/cirrus/build.yml | 2 ++
>   2 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


