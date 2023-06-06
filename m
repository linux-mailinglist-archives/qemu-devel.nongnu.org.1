Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B78F67245AC
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:21:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XYh-0007LW-H3; Tue, 06 Jun 2023 10:21:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6XYf-0007Kq-Oh
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:21:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q6XYd-0007ZS-Dj
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:21:13 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-30af86a96b4so5044325f8f.3
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686061269; x=1688653269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/HdEfN8HPF40oE6Tr9BI2ocyWAYz+T/4aq9lx6Ul+C4=;
 b=DVtqgr8vqRUTZWpdsDt+Yt3XLSooL6RSxTRNdMbhINLDV+Z8GN4QuEA6KEQJHQiKxR
 eNl1w/R/Fi8q16IarLZzj2oekb9Gl0F+9B8kLPaArXLcEwoe3XlkncAT+itGqnVPXjvH
 R0Z9Lq1ewylWTVwB+IxzL4xPcZJW9oJ01KeZfYllnja7JqNfhT8big2rUwZeZ5dWqWNl
 feBfcU+N6ylvy+JS+vwSgKnL7mTO9ZG8wZbXptQ/7hL1DL9UzNQS+8Ov1Nw4aqmbi08c
 T7/yjGyV+81+CnaTmg4F5dU7pikcc4yklH1HitfL/Rbh1tb4K6ewbLuMChe05YY5YOGj
 jkOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061269; x=1688653269;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/HdEfN8HPF40oE6Tr9BI2ocyWAYz+T/4aq9lx6Ul+C4=;
 b=Hy1nXxHizwiaUVe65KWx2ewAzD+x2cAEOaDac+wxU9D9hzLcpnYwJsedWZFLErEl6S
 859fad5LB57pi9vaMap/HvW39K08J0aiyFZnvj4MdRac0xg/o8/acTB61O67VE9W4JTM
 MatJervE06o2fqh6jGHktRWXp9msPGBWEv0TpDHy5SyOkBmMx/sqU4d/soCw2as+6T7R
 0JJl92ufrHLBlO/nuCRHB3GQpd/Lbfj88B7NZBtIrtaKlkCa+qc8Y+tMlDFLyb+y7LSi
 WQ1y4qUHXHW/FReeq53hG8USRiymrBlG95Fu4rqemumoI1imG5rQmi1ggcw4+td9TgIB
 S1/g==
X-Gm-Message-State: AC+VfDwNt78cT4i+j79/jXQTPcIQslZWJR30BPq2EzEaIW0W25hqbAGz
 GVVHglOHWbTdWPoeUjLyMTDPuw==
X-Google-Smtp-Source: ACHHUZ7Ea14Px3mB3KSk1NzGi6IDytly5X96WOlGscarj79pmkVBMLMysXr90uP+oVtRwOm3wSLmnQ==
X-Received: by 2002:adf:e7c3:0:b0:306:2b64:fd1b with SMTP id
 e3-20020adfe7c3000000b003062b64fd1bmr1758869wrn.52.1686061269689; 
 Tue, 06 Jun 2023 07:21:09 -0700 (PDT)
Received: from [192.168.69.115] (vbo91-h01-176-184-50-104.dsl.sta.abo.bbox.fr.
 [176.184.50.104]) by smtp.gmail.com with ESMTPSA id
 h9-20020adfe989000000b00307a86a4bcesm12733684wrm.35.2023.06.06.07.21.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:21:09 -0700 (PDT)
Message-ID: <175b1cfd-510b-a2af-3992-0492a0b777d8@linaro.org>
Date: Tue, 6 Jun 2023 16:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PULL v4 07/27] multi-process: add the concept description to
 docs/devel/qemu-multiprocess
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, thuth@redhat.com,
 Jagannathan Raman <jag.raman@oracle.com>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
References: <20210210092628.193785-1-stefanha@redhat.com>
 <20210210092628.193785-8-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20210210092628.193785-8-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.094,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Hi Jagannathan and Elena,

On 10/2/21 10:26, Stefan Hajnoczi wrote:
> From: John G Johnson <john.g.johnson@oracle.com>
> 
> Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
> Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Message-id: 02a68adef99f5df6a380bf8fd7b90948777e411c.1611938319.git.jag.raman@oracle.com
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>   MAINTAINERS                  |   7 +
>   docs/devel/index.rst         |   1 +
>   docs/devel/multi-process.rst | 966 +++++++++++++++++++++++++++++++++++
>   3 files changed, 974 insertions(+)
>   create mode 100644 docs/devel/multi-process.rst
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 06635ba81a..ddff8d25e8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3200,6 +3200,13 @@ S: Maintained
>   F: hw/semihosting/
>   F: include/hw/semihosting/
>   
> +Multi-process QEMU
> +M: Elena Ufimtseva <elena.ufimtseva@oracle.com>
> +M: Jagannathan Raman <jag.raman@oracle.com>
> +M: John G Johnson <john.g.johnson@oracle.com>

FWIW John's email is bouncing.

> +S: Maintained
> +F: docs/devel/multi-process.rst



