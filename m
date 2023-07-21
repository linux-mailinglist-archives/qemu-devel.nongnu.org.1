Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 007AE75CC3F
	for <lists+qemu-devel@lfdr.de>; Fri, 21 Jul 2023 17:44:09 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qMsIQ-0000R2-Cs; Fri, 21 Jul 2023 11:43:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsI8-0000H1-Ru
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:43:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qMsI6-0000Wi-JA
 for qemu-devel@nongnu.org; Fri, 21 Jul 2023 11:43:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689954218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lt3emaolROe+8dTv7wxBa7ytnsbtIcGSVQN16Nu1yHE=;
 b=CXoLjv084Yrloqoy9+xQETUk7oGB1/hbMdggxGaZ5Q8egRKOaFcDpYfj1mNDGSlEsaijJp
 nPTB7Uxl5NobiRSvJ4jqoUpKZBY9ah/41SQFQeQkJNqqx0aIG1iu9l9YHP/B7Nlx/d2yOa
 QUAKK+3ipspY3/3ihz6GQfAo66xRBUg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-dutJx_twOieLGt2H-BTQQw-1; Fri, 21 Jul 2023 11:43:36 -0400
X-MC-Unique: dutJx_twOieLGt2H-BTQQw-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-94a34d3e5ebso138975966b.3
 for <qemu-devel@nongnu.org>; Fri, 21 Jul 2023 08:43:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689954215; x=1690559015;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lt3emaolROe+8dTv7wxBa7ytnsbtIcGSVQN16Nu1yHE=;
 b=RycSQUpPLt4jcRXPH+uD6JSWryyf7efxts2ylOvHkEyYFJQFq5cGWM+frnlH5hddV4
 dQCbo8grDVA7eFIetYKRBjxKafqHR41gl+FXgiIy1+FzDppcEnCRtWwfJlIAOAIGP+5g
 BaC4rJgr4rP5UFju7trOP7lCMWqS5EOOX5brevNHNCK+hBYzKj8Kox4mMFn0dd4E5ZYE
 npp/xsb2YpVTcnLrVHQwbvmCrtVYu5RCQgtdy+VisUhvSHpvelGrJEDC8LORZCvAtbi6
 cF+O1eeZlxuVQGUlPxXYnAzGOUpF3UmDKpVOztDtUWMueh4kCFnn8yoP/GsKTnp7LLOX
 5oSw==
X-Gm-Message-State: ABy/qLZDdqhg9i7+JU6+1OGTxzIDPKxUVNB0BVSIBpF5F/Jw2dyjNHun
 O5EPVH1ebmBlYHiy8tMjCgxWheU08ckYJ2ce0vnAo9JFm0JR/KpVPFZgZElcMVo0sMbTQ2QdUFS
 TMrf7fhR85RjNjv8=
X-Received: by 2002:a17:906:3193:b0:993:d7ff:afe7 with SMTP id
 19-20020a170906319300b00993d7ffafe7mr1934385ejy.13.1689954215187; 
 Fri, 21 Jul 2023 08:43:35 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEHOU3HQ5wHz2hcrw1opr4SBHqiqoN6nV5JatLePGjPpPFcIaxZjrn9ErDoAdAHnsIl4bfQUA==
X-Received: by 2002:a17:906:3193:b0:993:d7ff:afe7 with SMTP id
 19-20020a170906319300b00993d7ffafe7mr1934375ejy.13.1689954214993; 
 Fri, 21 Jul 2023 08:43:34 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 k16-20020a1709063fd000b009894b476310sm2299825ejj.163.2023.07.21.08.43.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 21 Jul 2023 08:43:34 -0700 (PDT)
Message-ID: <4bdcb849-5da8-078b-8d8a-cad23e7d488c@redhat.com>
Date: Fri, 21 Jul 2023 17:43:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 4/6] test-throttle: test read only and write only
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: arei.gonglei@huawei.com, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 berrange@redhat.com
References: <20230713064111.558652-1-pizhenwei@bytedance.com>
 <20230713064111.558652-5-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230713064111.558652-5-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 13.07.23 08:41, zhenwei pi wrote:
> Reviewed-by: Alberto Garcia <berto@igalia.com>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   tests/unit/test-throttle.c | 66 ++++++++++++++++++++++++++++++++++++++
>   1 file changed, 66 insertions(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


