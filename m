Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9EB78C32F
	for <lists+qemu-devel@lfdr.de>; Tue, 29 Aug 2023 13:19:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qawjv-0008JP-Hw; Tue, 29 Aug 2023 07:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawjt-0008Id-CE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:18:29 -0400
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qawjp-0008Rj-JE
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 07:18:29 -0400
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-3fe32016bc8so37011985e9.1
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 04:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693307904; x=1693912704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ebSnWThMNdFwbeh0aiVYqPHw1qvgtsVIqbhElbwLVkM=;
 b=x9NwqTQB8N5YkaPdUhA82YTGBV9hrMwwvRt1JDUTbL3KJhes3qAowDaUNzuNO1IsDl
 psSRtDH07PPTMLluJWaNfnLcbN459TFGTy+Zbh6/Z7SJBRKnpeRYx6eNUIY8cGPI85SN
 WxSjt7MwitLAYlxapWo33MGcfgemnfb4PpL447NaUxnHgBYMftd+y586nrwdjLuoNiWA
 53C+cvFoeENFG2/ihagqoK9YJU+G28ZvS+zxmPfQqP+EPBQQV69cZ22Waq10D5PAN766
 HRUlA1buLlok/67BcAnWsaMu/GFXpjWT9V9r/a2csyXMrQM+B2x6MxdFMFpKQxxkggN9
 XD4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693307904; x=1693912704;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ebSnWThMNdFwbeh0aiVYqPHw1qvgtsVIqbhElbwLVkM=;
 b=dOI0DZCXbFYBQNkuuvwmlxxVfDDsEVom5r7nfPJIaMjSldfqellWjUqkkhy4blYLTk
 WojD2pB/Yu6PkGpuyR2z4Qchksr9W/p/zUjLE2JLGmXyY5ypWbARW6W8aVw2eIKKYur7
 nJkmMLcIsxOtft0yLKY+WN+RN6HZSH2fh5GuzoSJCeyMZAT99tPxaR4ZMpi2yy+jMHHt
 xgNw16koSggD6olflWLouqXioZltaCpis+0uz/yuV+eacLsHAitmXXCFX+xLN6KeVh99
 Kfx3i0+TKfMTxGndejIGG/1qio1k9swDexRNqJrWxK7Bqdj9prW51Hno03Nugu6tXs9I
 TcRQ==
X-Gm-Message-State: AOJu0Yzbb4CHjtpEJMqPGrUDbqBFq7kzUAUvh2stuop1TcUkcPwwhkdX
 ZcyoPSzd5jpbBMVcwIA3IGrgjg==
X-Google-Smtp-Source: AGHT+IF2mkBL+XE2SJXn6+3C4idETiwFDz9TwV2KF+d/wTaXuxcFdqVaSA3Mzi0+OT/9fH78Dz2bbw==
X-Received: by 2002:a05:600c:2307:b0:3fb:e189:3532 with SMTP id
 7-20020a05600c230700b003fbe1893532mr20646528wmo.20.1693307903816; 
 Tue, 29 Aug 2023 04:18:23 -0700 (PDT)
Received: from [192.168.69.115] (sml13-h01-176-184-15-56.dsl.sta.abo.bbox.fr.
 [176.184.15.56]) by smtp.gmail.com with ESMTPSA id
 16-20020a05600c229000b003fff96bb62csm13633505wmf.16.2023.08.29.04.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 04:18:23 -0700 (PDT)
Message-ID: <b3103564-c1ba-d9ae-2552-6905aa942053@linaro.org>
Date: Tue, 29 Aug 2023 13:18:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 04/11] softmmu/physmem: Remap with proper protection in
 qemu_ram_remap()
Content-Language: en-US
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Thiner Logoer <logoerthiner1@163.com>,
 =?UTF-8?Q?Daniel_P_=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Xiao Guangrong <xiaoguangrong.eric@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, Greg Kurz <groug@kaod.org>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20230823153412.832081-1-david@redhat.com>
 <20230823153412.832081-5-david@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230823153412.832081-5-david@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.169,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 23/8/23 17:34, David Hildenbrand wrote:
> Let's remap with the proper protection that we can derive from
> RAM_READONLY.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>   softmmu/physmem.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


