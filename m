Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E3770BFDA
	for <lists+qemu-devel@lfdr.de>; Mon, 22 May 2023 15:35:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q15fR-0004As-4G; Mon, 22 May 2023 09:33:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q15fO-00049s-O3
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:33:38 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q15f6-0002n8-Te
 for qemu-devel@nongnu.org; Mon, 22 May 2023 09:33:38 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-3f607766059so6433855e9.3
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 06:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684762398; x=1687354398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eAqy626rW++xLAMh6iH0sVsFJqdlfh9yO8K1GrCaw8g=;
 b=TOBtK94d6QU3dGqxao9iO0sv0DV7yOsRuaF0k3KVUFuVurZ93Pi7ewtOku1FzU4PXt
 LudDWHa9j2uv6HtMaeV7Me7mwnqm+sgPJQpVQ6BzhMlUxzKOXtl7T2K3aZgYGF8tLMzh
 RGR484Jq9UQgQk+EHTkU2MRr0H4lJVpe+PONnHmojsG7IFVVhkuICIjK3q6DAq3Dw/Sn
 sq3LUNtrGZOHOXmB9+1uSRGP9wD6u45H7iSGf3AqQi3KSKIV42yqHmXjQ7Fu8CA5zInu
 CHzGnm0j30DS4mMLu5Xth1RSrlKQ4pymL7iOWWOiDgPhP1dhG6Fy77FL5umL6sPq/h2t
 OByg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684762398; x=1687354398;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eAqy626rW++xLAMh6iH0sVsFJqdlfh9yO8K1GrCaw8g=;
 b=gCNSDQ49OaQw7VB80scHYdIefgGTCIoe42R4P+SuEbjE12h0M+vqv9Vw+6yv/R1rA9
 F/WAzXqNePtPcQZ3h3p0HAmA47EUCjmm5hxE7h1lSapBBCgkyc+ZtGaakYONV6Mvw1F1
 /HaFHIqgSpL6QriH0xOZjUzfICk7W2kNM3XJanOnns6W/4nana1m1rq1DwkbYa0+Vlo4
 Xbe/ZI7JSTACerJqnlxNxMKqP1rQ/Fz1FsjaJMWYGPF2UPp3Pta4OIxdZbh2oxFMH+X0
 lAC3DMIyUtjJT/q+wnFUBPDGaaGOK1QzkMT7lHqn4MfehT+U9QOOan8r/ZQMDs2CmkBM
 iZGg==
X-Gm-Message-State: AC+VfDyx1XAczWAr+xnDJOIyyhZsKJ2DQA3ZU+VNm1RRaCFi2rZLudDt
 Myd03Q4unLzTPWb2Ixe//EWpoRwkAmKsiR8y9Nk=
X-Google-Smtp-Source: ACHHUZ79w/GOeA1Go2IXcEyei1M4RWeFGfy3/65AA129mUHpWmZM7rDaQlbAt+QCq4yAZjWOWcb+yg==
X-Received: by 2002:a05:600c:292:b0:3f6:468:79b8 with SMTP id
 18-20020a05600c029200b003f6046879b8mr2385945wmk.22.1684762398281; 
 Mon, 22 May 2023 06:33:18 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.153.164])
 by smtp.gmail.com with ESMTPSA id
 x11-20020a05600c21cb00b003f427db0015sm8420942wmj.38.2023.05.22.06.33.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 May 2023 06:33:17 -0700 (PDT)
Message-ID: <1e1c53d7-227a-dfcd-c76f-da02027edde7@linaro.org>
Date: Mon, 22 May 2023 15:33:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
Subject: Re: [PATCH] machine: do not crash if default RAM backend name has
 been stollen
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: wangyanan55@huawei.com, pbonzini@redhat.com, thuth@redhat.com
References: <20230522131717.3780533-1-imammedo@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230522131717.3780533-1-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 22/5/23 15:17, Igor Mammedov wrote:
> QEMU aborts when default RAM backend should be used (i.e. no
> explicit '-machine memory-backend=' specified) but user
> has created an object which 'id' equals to default RAM backend
> name used by board.
> 
>   $QEMU -machine pc \
>         -object memory-backend-ram,id=pc.ram,size=4294967296
> 
>   Actual results:
>   QEMU 7.2.0 monitor - type 'help' for more information
>   (qemu) Unexpected error in object_property_try_add() at ../qom/object.c:1239:
>   qemu-kvm: attempt to add duplicate property 'pc.ram' to object (type 'container')
>   Aborted (core dumped)
> 
> Instead of abort, check for the conflicting 'id' and exit with
> an error, suggesting how to remedy the issue.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> CC: thuth@redhat.com
> ---
>   hw/core/machine.c | 8 ++++++++
>   1 file changed, 8 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


