Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 24EB97B5811
	for <lists+qemu-devel@lfdr.de>; Mon,  2 Oct 2023 18:56:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qnMCB-0006aa-Ug; Mon, 02 Oct 2023 12:54:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnMC9-0006aH-NK
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 12:54:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qnMC7-0000Ue-SJ
 for qemu-devel@nongnu.org; Mon, 02 Oct 2023 12:54:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696265694;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NIjLk3RmQEbDIMDZKqR75X/0Vn4FtEmICF/nZFmjeZc=;
 b=FCNNp/hKUZf1cJCOCW2DbEUApdjxV3nDpLJhDVzis6AmmT4t+yXWV/+jQ06mBS9UsIkXsj
 2J3iaNVPvHcPHoSUs3n+1lZAAnT/wvK5J/yguKUDgV91oO7ik+2gqfWTAnhVzh7vCjFoAm
 dP1emzDLHoYBA647WeoT+0TROqL0ye0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-459-ay6PKv_YMwS5yJmA_nIQbQ-1; Mon, 02 Oct 2023 12:54:53 -0400
X-MC-Unique: ay6PKv_YMwS5yJmA_nIQbQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-9a9e3f703dfso141915566b.1
 for <qemu-devel@nongnu.org>; Mon, 02 Oct 2023 09:54:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696265692; x=1696870492;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NIjLk3RmQEbDIMDZKqR75X/0Vn4FtEmICF/nZFmjeZc=;
 b=DYg3FKXaQPf7Szjesj89bxLyoiZZ6eterMFQnHQu9Fm8K8x4jlGVqiQkkPrJA4rVBN
 2EwqRRZoh0zcoU1VjW7Hfaa2kW8xC7OitiPfNgdnzEStK1UJYSWrqWl1R9vXmpR3WUYV
 oMLRgNWCcP3hoo82waIjYIytyXLpMtOVcgiFGgMqmisywMaVl4cV5BioVpraLe8vVZHd
 EVj60X9jEhmM36yDEo3wiAHfEvTXMxfrhfY8H4s0cEJheMxCf1COcqduBCWAjvhiJBft
 4fzDHEVCZwbOE+Dgg875XjvsLp+RVN2dd/bVGroHeN6FjpPcCEJIXT78oqxVpaOOQYHh
 tang==
X-Gm-Message-State: AOJu0YwgeYCb2fBwhRaFnwxmUgDa+lRmyYnLMI5gUStyC1qyC2kQllP5
 6x4rfJYngcAliJ9B1iT8q9/ABOTB11zEJnVPPRsBxSrSirRToIqcYt6aB21GFD/oeGqumzK0NfU
 YeBy4hxmy7QHWVzc=
X-Received: by 2002:a17:906:319b:b0:99d:e617:abeb with SMTP id
 27-20020a170906319b00b0099de617abebmr10617837ejy.23.1696265691942; 
 Mon, 02 Oct 2023 09:54:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkFN8HD3ay3JzMiWeNldOeknusd/zh1cfDgqzSP7cEf8GAKHhbmlBrkSCfJ5Yj4h89ayMkvw==
X-Received: by 2002:a17:906:319b:b0:99d:e617:abeb with SMTP id
 27-20020a170906319b00b0099de617abebmr10617820ejy.23.1696265691579; 
 Mon, 02 Oct 2023 09:54:51 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:48f9:bea:a04c:3dfe?
 ([2001:b07:6468:f312:48f9:bea:a04c:3dfe])
 by smtp.googlemail.com with ESMTPSA id
 u23-20020a17090617d700b00993a9a951fasm17675433eje.11.2023.10.02.09.54.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Oct 2023 09:54:51 -0700 (PDT)
Message-ID: <25936fd2-88b9-f880-3e30-c97abc8f559d@redhat.com>
Date: Mon, 2 Oct 2023 18:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] build: Remove --enable-gprof
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org
References: <20230930181841.245024-1-richard.henderson@linaro.org>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230930181841.245024-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.321, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 9/30/23 20:18, Richard Henderson wrote:
> This build option has been deprecated since 8.0.
> Remove all CONFIG_GPROF code that depends on that,
> including one errant check using TARGET_GPROF.
> 
> Signed-off-by: Richard Henderson<richard.henderson@linaro.org>

Acked-by: Paolo Bonzini <pbonzini@redhat.com>


