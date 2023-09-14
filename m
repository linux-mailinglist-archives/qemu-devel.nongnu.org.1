Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B337A0A75
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 18:09:06 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgosj-00085S-EV; Thu, 14 Sep 2023 12:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgosi-00085K-5j
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:07:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qgosg-0003Oz-Kg
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 12:07:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694707669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Az8ZxPLm0rmkC1LTrowXFJYbH4Umkg0WKL0/WVd4X9A=;
 b=GRtJMiKnSQAkEBbmgL3zUypCZ0QFtrVCd973/X7i4Q1kk1Oz3ApHqERkvOzqc5DTlUzAho
 nJXIXTDLuksX/58Vt2MAhk5mafv5a9mB4RTnufjX4A7N81jWGxz/2U/dHHiLEz9JP0rlRc
 MwD2nqDyOUB2XQbPc9N42lHNyqEcBKU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-312-hYDmuHuhNDe2qIzP3qdXIw-1; Thu, 14 Sep 2023 12:07:47 -0400
X-MC-Unique: hYDmuHuhNDe2qIzP3qdXIw-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-31c5cc3b512so754404f8f.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 09:07:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694707666; x=1695312466;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Az8ZxPLm0rmkC1LTrowXFJYbH4Umkg0WKL0/WVd4X9A=;
 b=lhjJxODA19CydwXq3Tss351vhsoNzWDFSTA5JSYYaNH+WDMUlX1UYR/VaCPIMJLXIa
 sqfWr30gfxb1u375kOh52BjC4hcfbURxaVVe9jhh+LsHGW0hKEFejFIrji9aVP4HmVkE
 uglWRyk4Awe62c/OPjmaDtriWjEp5/Y99hWMv0RafkyMp+pUhtCsyZ7XA0+dMcN+PifE
 3Z/OS02tkmb4i/YTYZpSKGgcxyl4nrJpsWqo9rIqC/JM6kC5oaHGoiT+1w58nys7KoLu
 2IZSXqlsHQwn2BfcxmWf9Tg+Tk5+/BYduiNMTF8mApYiCFL4/NZflntdy68em3A5kNIE
 xGAg==
X-Gm-Message-State: AOJu0YzgJH1XJID35e3FDL3phD2RkRSHZNqBE6TsGDdFRHgNa9yemHkW
 yvV2qVlFZ3WpP4lvdgcA8y/tWhVZx7tjLz6pxJTvPs8ib/fQlXLpiAvGcIsbcNlMtH424iiJ4HP
 7c0cBSu5mRK/M8AU=
X-Received: by 2002:a5d:680c:0:b0:31a:ed75:75d9 with SMTP id
 w12-20020a5d680c000000b0031aed7575d9mr4997327wru.16.1694707666653; 
 Thu, 14 Sep 2023 09:07:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYbF2aVsB9xQ/6LrTpbd6U2Rn7OeNJNcHO6I7qE59fuCj1nHQkyaxyjnA+VagttQUGbuwPYQ==
X-Received: by 2002:a5d:680c:0:b0:31a:ed75:75d9 with SMTP id
 w12-20020a5d680c000000b0031aed7575d9mr4997301wru.16.1694707666310; 
 Thu, 14 Sep 2023 09:07:46 -0700 (PDT)
Received: from [192.168.0.2] (ip-109-43-179-28.web.vodafone.de.
 [109.43.179.28]) by smtp.gmail.com with ESMTPSA id
 r4-20020adfdc84000000b0031753073abcsm2117881wrj.36.2023.09.14.09.07.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 09:07:45 -0700 (PDT)
Message-ID: <9b8cad7b-8daf-caf5-2c4b-b465abee191f@redhat.com>
Date: Thu, 14 Sep 2023 18:07:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/9] gitlab: fix typo/spelling in comments
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Joel Stanley <joel@jms.id.au>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>, qemu-arm@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, John Snow <jsnow@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Peter Maydell <peter.maydell@linaro.org>, Laurent Vivier
 <lvivier@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>
References: <20230914155422.426639-1-alex.bennee@linaro.org>
 <20230914155422.426639-3-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230914155422.426639-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -1
X-Spam_score: -0.2
X-Spam_bar: /
X-Spam_report: (-0.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 14/09/2023 17.54, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/base.yml | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/.gitlab-ci.d/base.yml b/.gitlab-ci.d/base.yml
> index 188a770799..ef173a34e6 100644
> --- a/.gitlab-ci.d/base.yml
> +++ b/.gitlab-ci.d/base.yml
> @@ -68,7 +68,7 @@ variables:
>   
>       #############################################################
>       # Stage 2: fine tune execution of jobs in specific scenarios
> -    # where the catch all logic is inapprorpaite
> +    # where the catch all logic is inappropriate
>       #############################################################
>   
>       # Optional jobs should not be run unless manually triggered

Reviewed-by: Thomas Huth <thuth@redhat.com>


