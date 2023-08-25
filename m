Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4D4788BBB
	for <lists+qemu-devel@lfdr.de>; Fri, 25 Aug 2023 16:30:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZXoy-0002Ye-V3; Fri, 25 Aug 2023 10:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXow-0002KP-Vx
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:29:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qZXou-0005pa-IP
 for qemu-devel@nongnu.org; Fri, 25 Aug 2023 10:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692973791;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DxUUTahaAg1/3ABIcmZbydF2fb97ch5H0c/OAT+bVY=;
 b=GJuDiibbGnusI2j4U4j3y6kMkrcWhIwDxt35a2lqpEy863Klcj/CL+4y3cc0P3P7e4yGKO
 xghVePlKBkliZFDtBihv8c6+H1qK0N+Dh18qhsFAOLrmeuJyUOhgD13YbOxp5RfktPZuUg
 rDducGf/MyA4uBla898azWXsWvoEV+0=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-kpo_gxRYM6qGbsGbNHmJHg-1; Fri, 25 Aug 2023 10:29:49 -0400
X-MC-Unique: kpo_gxRYM6qGbsGbNHmJHg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-99beea69484so80115266b.0
 for <qemu-devel@nongnu.org>; Fri, 25 Aug 2023 07:29:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692973788; x=1693578588;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9DxUUTahaAg1/3ABIcmZbydF2fb97ch5H0c/OAT+bVY=;
 b=XYWJRkzL4IDanPBJB2xQRukRC8XegkAfUjTI7UH/BcCG94nPa9z71w63/QTBuvVKci
 3TWzQ8xFclTR1NLebNXQIdCT5jFWDhiThryKeZK5V6FU3WnCiZsd4l6xplUWQcGQzxvt
 aJZPtV2kkecO8eTHrsDkyhWb5tW/1Vy/9TEtNBdXfO1wzPmw0mMdMx6RpGeksSZ2NM7G
 3CXk1KqppPp6givlNptla1aLQFV8b+mOs0GwX03AwDLrJAwgN5yKVilDyDzLOa4i83Zx
 YJsde+ayipQIocdH+enJ4r/yZ7xj+KgCF4K/+uI9A3R8PyaSIBz07p54KKHAQsh1cgIy
 3qXA==
X-Gm-Message-State: AOJu0Yz2RtNdzUzdKC5FCozZMRU9V+Me+xK1XtdWNmYRNrquYaMW5jpL
 z1edusNrw6iTFr01c8wgSAF5gStu6rjF8Mir16bYQqwUbLVP8dR6j8njhuQHhX/zK3G/mQWSM33
 hd4rFePZuGLxzm6Q=
X-Received: by 2002:aa7:d502:0:b0:523:f5fc:7b6b with SMTP id
 y2-20020aa7d502000000b00523f5fc7b6bmr15901866edq.3.1692973788629; 
 Fri, 25 Aug 2023 07:29:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF95cL1V9gMUkwv284Ge54vkqjjBbpnhnhFEG0HxzTlL5qB8uV7deF+4ExgntHPqjPakWayiQ==
X-Received: by 2002:aa7:d502:0:b0:523:f5fc:7b6b with SMTP id
 y2-20020aa7d502000000b00523f5fc7b6bmr15901855edq.3.1692973788384; 
 Fri, 25 Aug 2023 07:29:48 -0700 (PDT)
Received: from ?IPV6:2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37?
 (p200300cfd70f5ee06d7a84866b838d37.dip0.t-ipconnect.de.
 [2003:cf:d70f:5ee0:6d7a:8486:6b83:8d37])
 by smtp.gmail.com with ESMTPSA id
 l20-20020aa7c3d4000000b0051e0be09297sm1068058edr.53.2023.08.25.07.29.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Aug 2023 07:29:47 -0700 (PDT)
Message-ID: <09a970c3-efa6-ddb8-0467-08b2f5a9136d@redhat.com>
Date: Fri, 25 Aug 2023 16:29:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/6] qemu-iotests: 024: add rebasing test case for
 overlay_size > backing_size
Content-Language: en-US
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, den@virtuozzo.com
References: <20230601192836.598602-1-andrey.drobyshev@virtuozzo.com>
 <20230601192836.598602-3-andrey.drobyshev@virtuozzo.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230601192836.598602-3-andrey.drobyshev@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.57, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 01.06.23 21:28, Andrey Drobyshev via wrote:
> Before previous commit, rebase was getting infitely stuck in case of
> rebasing within the same backing chain and when overlay_size > backing_size.
> Let's add this case to the rebasing test 024 to make sure it doesn't
> break again.
>
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>   tests/qemu-iotests/024     | 57 ++++++++++++++++++++++++++++++++++++++
>   tests/qemu-iotests/024.out | 30 ++++++++++++++++++++
>   2 files changed, 87 insertions(+)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


