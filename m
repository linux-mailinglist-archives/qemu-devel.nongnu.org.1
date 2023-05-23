Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7B270E299
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:13:25 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1VYH-0003ms-E9; Tue, 23 May 2023 13:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1VYF-0003kY-F1
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:11:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1VYD-0002jH-RS
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684861916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=chhc2T97NrMu9FeMjIRL2KxcIVgjY5/38Lo1CPig6YE=;
 b=H1oEGbKMOAHpQsohAmvbKoYXrW4KC4DOgO+UGua6YhjCtJ0fzOKGN/5pI8fJ1axXnGUbzW
 xy3zcjerZO8tZLUJtTV5iLrnnd/gXC7DOGO+q/tAQhH3RTaieaT01enQu9wfDhaRQuYS0f
 azOkRcad0YCMAWIkL8nijlZ0ERbr+t4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-wqvx9AZCOMKgSOn_6pWKWg-1; Tue, 23 May 2023 13:11:54 -0400
X-MC-Unique: wqvx9AZCOMKgSOn_6pWKWg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f5fc8581a9so524965e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:11:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684861914; x=1687453914;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=chhc2T97NrMu9FeMjIRL2KxcIVgjY5/38Lo1CPig6YE=;
 b=YhlQcAixjrOkmQxWPj5RujpvMSRKIpdLKboKVv143oOekRAflaYKHwax4h0+ZKVW93
 NGdi54N0qqr1tV4oNvcTAlM0Cy0720pVDYY2y03ytvHu2bE4f4X/tgv6jKIcoABWrD1x
 cUEmuh2AYD99VuRuary0aDn/W/WBvrpki86yE8uVUWIkcj/ZHhDE7CLE8zJVSKlD1In2
 HYfOcvAa2bNvaa65vv8w127Zmnw0mwpq3Hjslouo7pKVI9INvzGPTV0OQokniZ8URAaw
 8szda2p+shwUAbaI1megXiwXyRfOcOiWEFzRSCU8SIsElpJ+5W2v8vHIncA/xwLEGmjt
 3m2w==
X-Gm-Message-State: AC+VfDyK+/lgT3Ucz1LWTHUZ3Sqobvg4X/UhWlYCejFaLrNyxMujRANp
 PV/OcHbXWBOK6/+TnZ8FkS57U0HOPABa7vmZrilz8doS8HlaqaaBTFiDLjkZJLg/P5hLzcWL5gV
 HQY9Di4J5D4CnPBw=
X-Received: by 2002:a7b:cd8a:0:b0:3f6:a66:a372 with SMTP id
 y10-20020a7bcd8a000000b003f60a66a372mr2318080wmj.1.1684861913893; 
 Tue, 23 May 2023 10:11:53 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4SeMb1VTRdze+BOULqop95IPWYfqGu2SWOb6uFjFXIPuhJb9hn073Uu1FvFIJfwCbgY4MlOw==
X-Received: by 2002:a7b:cd8a:0:b0:3f6:a66:a372 with SMTP id
 y10-20020a7bcd8a000000b003f60a66a372mr2318073wmj.1.1684861913650; 
 Tue, 23 May 2023 10:11:53 -0700 (PDT)
Received: from [192.168.8.105] (tmo-117-143.customers.d1-online.com.
 [80.187.117.143]) by smtp.gmail.com with ESMTPSA id
 f4-20020a1c6a04000000b003f1978bbcd6sm3659131wmc.3.2023.05.23.10.11.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 10:11:53 -0700 (PDT)
Message-ID: <e682f6d5-acbe-7910-54ef-4d75c88a3d28@redhat.com>
Date: Tue, 23 May 2023 19:11:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <CAFEAcA9GamGybSzd8FKBtmZ2qMgjRFy6D=Vhu1y0dL8m9Sa80w@mail.gmail.com>
 <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 1/2] docs: sbsa: correct graphics card name
In-Reply-To: <20230523155644.678524-1-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 23/05/2023 17.56, Marcin Juszkiewicz wrote:
> We moved from VGA to Bochs to have PCIe card.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   docs/system/arm/sbsa.rst | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/docs/system/arm/sbsa.rst b/docs/system/arm/sbsa.rst
> index b499d7e927..fea4992df2 100644
> --- a/docs/system/arm/sbsa.rst
> +++ b/docs/system/arm/sbsa.rst
> @@ -27,6 +27,6 @@ The sbsa-ref board supports:
>     - System bus EHCI controller
>     - CDROM and hard disc on AHCI bus
>     - E1000E ethernet card on PCIe bus
> -  - VGA display adaptor on PCIe bus
> +  - Bochs display adaptor on PCIe bus
>     - A generic SBSA watchdog device
>   

While you're at it, I'd suggest to replace "adaptor" with "adapter" which 
seems to be way more common in the QEMU sources:

$ grep -r adaptor * | wc -l
5
$ grep -r adapter * | wc -l
385

With that changed:
Reviewed-by: Thomas Huth <thuth@redhat.com>


PS: An idea for another patch: I think the "config SBSA_REF" in 
hw/arm/Kconfig should select BOCHS_DISPLAY now, since this board seems to 
always require this card now (is there a reason why it can't be disabled 
with "-vga none" or "-nodefaults"?)


