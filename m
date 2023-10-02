Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D2A7B5A04
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 20:27:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnNdM-0004N1-BV; Mon, 02 Oct 2023 14:27:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnNdI-0004MW-Eh
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 14:27:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qnNdH-0001SI-0N
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 14:27:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696271222;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fXN27XwzoteD60cMt972kXTJ4T9Ibx9y54Nbbx/eMUE=;
 b=doGUK+1sKLtAeDDg8essEgxWKOUQEXojBZRv+/SfhBnpl6QiY9Wf6NM0GpZqgaiRP1k84s
 jxxCP7U/jFpkrK62s3FbDPiMvHxAQaZErPl+7/kFkgDBGg08hOJSuGQuR1HnCJXukfTFia
 zlBwhW8IGvsNzgDpFUatxJxf9mlajHs=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-604-uP9F5n2BNfGfnRX_oLvbrA-1; Mon, 02 Oct 2023 14:26:51 -0400
X-MC-Unique: uP9F5n2BNfGfnRX_oLvbrA-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-65aff02d602so751626d6.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 11:26:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696271211; x=1696876011;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fXN27XwzoteD60cMt972kXTJ4T9Ibx9y54Nbbx/eMUE=;
 b=pbvrP/On3p5HDW7CRQFUWB+Yp2RaApdMQW7zXfTcbfIGGXb9SmPdmGphYwNBuCskp2
 YIhTAOLby2FT4p+NqOHXNBO6yNjD/HeiPWRhu8X3UqXH6d8055zf5Uf24ENd7iFpMhhK
 3vHjTPkkz798uXPuHX/NBSRkzGfLnZ4qcHgNvckie0lfAL/1GkAm8FX7qo0AD6P4/rOd
 XHJ9+tlOE9HpIIx778BA6sF/KE4hnCvu1kUhQB7BkeCcZmCAknvfJQFfrANtnLXOR+iD
 3q8kTN9CXA2xNXaqCKlpqjqsrLFtxQcAeuydgmGtn60r66LtrlD0Hg7fR8jvLXpTd101
 z9lQ==
X-Gm-Message-State: AOJu0Yw5ddvnsdIb0CFzVqCiGj1cqhIvBOZxQB+ddGa7swZDVkguoJPN
 rsPOyjz3y90cLXRU0raSU2iH05knyB4uKWK83p/r3251J6Fp/n9/m9MXpdOzKDmKwh4JHFXkQkn
 f6q833bNFDbjB1vQ=
X-Received: by 2002:a05:6214:460c:b0:647:2a0e:573f with SMTP id
 oq12-20020a056214460c00b006472a0e573fmr12904164qvb.8.1696271211056; 
 Mon, 02 Oct 2023 11:26:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0eQDQG7qEiTg5QVP5UAVh0bJ7AYoEB057pM5tDI/opzhM794syFBeqY1iPNBeWHmB4xqaNQ==
X-Received: by 2002:a05:6214:460c:b0:647:2a0e:573f with SMTP id
 oq12-20020a056214460c00b006472a0e573fmr12904150qvb.8.1696271210755; 
 Mon, 02 Oct 2023 11:26:50 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-177-123.web.vodafone.de.
 [109.43.177.123]) by smtp.gmail.com with ESMTPSA id
 p18-20020ae9f312000000b007756f60bcacsm1871925qkg.79.2023.10.02.11.26.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 11:26:50 -0700 (PDT)
Message-ID: <3d754a9a-a854-f71f-e5e8-c133d23a3cd9@redhat.com>
Date: Mon, 2 Oct 2023 20:26:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] MAINTAINERS: Add section for overall sensors
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org,
 Titus Rwantare <titusr@google.com>, Hao Wu <wuhaotsh@google.com>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Corey Minyard <cminyard@mvista.com>, Joel Stanley <joel@jms.id.au>,
 Kevin Townsend <kevin.townsend@linaro.org>,
 Klaus Jensen <k.jensen@samsung.com>,
 Maheswara Kurapati <quic_mkurapat@quicinc.com>,
 Peter Delevoryas <peter@pjd.dev>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@kaod.org>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230220110235.24472-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230220110235.24472-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
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

On 20/02/2023 12.02, Philippe Mathieu-Daudé wrote:
> Sensor devices depend on some bus, not a particular board.
> While merged for a particular board, sensor devices don't
> depend on it. They depend on a bus technology, and can be
> used by any board exposing such bus.
> 
> In order to help merging sensor patches, when they fall out
> of a particular board tree, add a section covering overall
> sensors, to help out with patch review and merge queue
> handling.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Hi, would you like to help co-maintaining?
> 
> Cc: Titus Rwantare <titusr@google.com>
> Cc: Hao Wu <wuhaotsh@google.com>
> Cc: Havard Skinnemoen <hskinnemoen@google.com>
> Cc: Corey Minyard <cminyard@mvista.com>
> Cc: Joel Stanley <joel@jms.id.au>
> Cc: Kevin Townsend <kevin.townsend@linaro.org>
> Cc: Klaus Jensen <k.jensen@samsung.com>
> Cc: Maheswara Kurapati <quic_mkurapat@quicinc.com>
> Cc: Peter Delevoryas <peter@pjd.dev>
> Cc: Cédric Le Goater <clg@kaod.org>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index fd54c1f140..657fadbd6d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3255,6 +3255,12 @@ M: Viktor Prutyanov <viktor.prutyanov@phystech.edu>
>   S: Maintained
>   F: contrib/elf2dmp/
>   
> +Overall sensors
> +M: Philippe Mathieu-Daudé <philmd@linaro.org>
> +S: Odd Fixes
> +F: hw/sensor
> +F: include/hw/sensor
> +
>   I2C and SMBus
>   M: Corey Minyard <cminyard@mvista.com>
>   S: Maintained

Reviewed-by: Thomas Huth <thuth@redhat.com>


