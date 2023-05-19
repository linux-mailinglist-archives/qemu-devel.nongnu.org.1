Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E4778709B6C
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:37:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q02A3-0007um-Qq; Fri, 19 May 2023 11:36:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q02A0-0007uO-E0
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:36:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1q029y-0008AD-PJ
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:36:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684510610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PfoKIpKBm5HHTwpcLTv6VTrGR3w4U9wAmvdVPCebNiM=;
 b=Bl5v4Gc0foP5tg5pxZE61IGOzCS9xKyqsqAWaD0xyFwqxIgBdfh1DdH8U2+ODv8Z2Nu8aI
 w48xRRA8fKAM1L2a7v1A4Rd5jqal7FawqDxeFls8YHGTFMxHrix38N3nUDmP0pks7GFMiD
 f3LlnUq4ZeWjcwZGHN6LXvJCEu1W+u0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-i7ENZMfdM9Gi7rd_Ta2JRw-1; Fri, 19 May 2023 11:36:48 -0400
X-MC-Unique: i7ENZMfdM9Gi7rd_Ta2JRw-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-95847b4b4e7so443681466b.3
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510607; x=1687102607;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PfoKIpKBm5HHTwpcLTv6VTrGR3w4U9wAmvdVPCebNiM=;
 b=dcGruiUgps7TF2yafB1atnBKoF963Lj6qVTsbb+A+ssuUgTLNvUW6k7MvlXMSHpUQa
 m0hvFOPZVp97m4vH4bE8DwzmRo9300YizGliHEfLBz1orFxru4CfDQR0Q3ARJm55N7cS
 bxfWTZz2yFbV2LTaEUcvLjepyv49Aen5PNqjNBp02DpRfsaGD90y/3/kWzZLH9/Yf8/p
 aqHohqF7zoSxCP8OK7QrWzCmVRjXJBOMBcuGlweoEJllFcGZyj73lH5MiZXgtcSWmgcE
 G10t6dNxo0jMm77GGfz773kxUS2MIUkiyCZ0hCooWyWKAN+zHxkS46LwIER6SrwhX5qC
 exug==
X-Gm-Message-State: AC+VfDznmokqVf2Fkut4pLF1g64kgrbpjNeGKOl6u5rhoxIEnp/wHsW2
 MLqxvvKjSiGBhFhG/8z+XCYKGPkV7D2N+YjVrRHprUGZX9Y36Utc3GSSVVTddrzGOgfY+JHtTeH
 VqFzVxTe2d0P1oBM=
X-Received: by 2002:a17:907:72cc:b0:96f:136e:eadd with SMTP id
 du12-20020a17090772cc00b0096f136eeaddmr2366816ejc.66.1684510607655; 
 Fri, 19 May 2023 08:36:47 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7gXtqFASf21wIq7BeSyLuRncEpRzzgfR4PO7PtFRwjweuV6v+/vBy4g/4zYo3eAvdTxTZr0w==
X-Received: by 2002:a17:907:72cc:b0:96f:136e:eadd with SMTP id
 du12-20020a17090772cc00b0096f136eeaddmr2366806ejc.66.1684510607414; 
 Fri, 19 May 2023 08:36:47 -0700 (PDT)
Received: from ?IPV6:2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3?
 (p200300cfd723b0c78fa2ce552d0c5fa3.dip0.t-ipconnect.de.
 [2003:cf:d723:b0c7:8fa2:ce55:2d0c:5fa3])
 by smtp.gmail.com with ESMTPSA id
 e10-20020a170906844a00b009662d0e637esm1291951ejy.155.2023.05.19.08.36.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 May 2023 08:36:46 -0700 (PDT)
Message-ID: <8af0e1cc-a7f1-2170-0e1a-8c771030f3ba@redhat.com>
Date: Fri, 19 May 2023 17:36:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 19/19] cutils: Improve qemu_strtosz handling of
 fractions
Content-Language: en-US
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, richard.henderson@linaro.org
References: <20230512021033.1378730-1-eblake@redhat.com>
 <20230512021033.1378730-20-eblake@redhat.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230512021033.1378730-20-eblake@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.527, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 12.05.23 04:10, Eric Blake wrote:
> We have several limitations and bugs worth fixing; they are
> inter-related enough that it is not worth splitting this patch into
> smaller pieces:
>
> * ".5k" should work to specify 512, just as "0.5k" does
> * "1.9999k" and "1." + "9"*50 + "k" should both produce the same
>    result of 2048 after rounding
> * "1." + "0"*350 + "1B" should not be treated the same as "1.0B";
>    underflow in the fraction should not be lost
> * "7.99e99" and "7.99e999" look similar, but our code was doing a
>    read-out-of-bounds on the latter because it was not expecting ERANGE
>    due to overflow. While we document that scientific notation is not
>    supported, and the previous patch actually fixed
>    qemu_strtod_finite() to no longer return ERANGE overflows, it is
>    easier to pre-filter than to try and determine after the fact if
>    strtod() consumed more than we wanted.  Note that this is a
>    low-level semantic change (when endptr is not NULL, we can now
>    successfully parse with a scale of 'E' and then report trailing
>    junk, instead of failing outright with EINVAL); but an earlier
>    commit already argued that this is not a high-level semantic change
>    since the only caller passing in a non-NULL endptr also checks that
>    the tail is whitespace-only.
>
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/1629
> Fixes: cf923b78 ("utils: Improve qemu_strtosz() to have 64 bits of precision", 6.0.0)
> Fixes: 7625a1ed ("utils: Use fixed-point arithmetic in qemu_strtosz", 6.0.0)
> Signed-off-by: Eric Blake <eblake@redhat.com>
>
> ---
>
> v2: more changes, handle negatives differently, catch fractions that
> round to 0 but don't underflow [Hanna]
> ---
>   tests/unit/test-cutils.c | 50 +++++++++-------------
>   util/cutils.c            | 89 ++++++++++++++++++++++++++++++----------
>   2 files changed, 86 insertions(+), 53 deletions(-)

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


