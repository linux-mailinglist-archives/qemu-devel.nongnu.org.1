Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D9B7175FA
	for <lists+qemu-devel@lfdr.de>; Wed, 31 May 2023 07:04:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q4Dz6-0005j6-Fv; Wed, 31 May 2023 01:02:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Dyj-0005f7-JC
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:02:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q4Dyh-0000Qb-ND
 for qemu-devel@nongnu.org; Wed, 31 May 2023 01:02:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685509350;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RLG5bUflCJgftCCTm6vyDy7J1U464Pa/HMI3BA+Wobk=;
 b=Hi3/2k9PvSZ2ZPVEKSMTStbtShuyNipEu4PhGCzbRoDmSx9d4w71IUNqY6eNeBr+stsoqH
 VJ6mIDfKZ2XMVw3kmtST7A/i5dRhd4tXIqhn+bwIjZUO0GvRRfPQzJtN0o190oxY/D+s5D
 yTmwImegvuepzjIvEQ13Lh2KQiFgC1o=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-knmlab4oPLOPb4Pdpwugiw-1; Wed, 31 May 2023 01:02:28 -0400
X-MC-Unique: knmlab4oPLOPb4Pdpwugiw-1
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-514b8a3c0d3so549598a12.0
 for <qemu-devel@nongnu.org>; Tue, 30 May 2023 22:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685509347; x=1688101347;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RLG5bUflCJgftCCTm6vyDy7J1U464Pa/HMI3BA+Wobk=;
 b=XtGWn6004Zb8IAXE0fucTM+jSJAjzaPZOZHUeiyVnxjx2ja+x9qRxmf7VMgrvQhUoN
 M1mswZjLJ4Ia3AIZqpPrp1b6Wmq9ISEgoc32KxFCP7jEZAeHDYATB4MiYs1YLPBbGVAf
 pBQuo7ll+gAfzpFHI5bpCaOidgTehgto3IHhRbCWl94TKMg/peNg37IwW0YsgRRDw/42
 2zKYcOcM4S38FQ9E12jGBSaV2FBPzZRMJ9Sh3z4LJKk+BTj7kznI11LDOeZhaGhujPWG
 iQcaAbJM1DUeXGisS5qM+rWNKDyQc+StoM51PpqZw41KbmOjc+KKR1XMNxbPmOHJ0aBe
 aT8Q==
X-Gm-Message-State: AC+VfDweVrZKR7LlCKYO49KLC0kxf5cPqx4dKTAxgFgOWH5Kc+vDsNJV
 nFwe617Har2MVXlFZ6kwIrmDH8s6DYnQFGLy/ZcCbL1ynb58Cj4qFGgCt0O5GNQCkd/s/kaXVoL
 hS+V/K5WRiYDY44o=
X-Received: by 2002:a17:907:a42a:b0:973:d06d:545f with SMTP id
 sg42-20020a170907a42a00b00973d06d545fmr3817766ejc.24.1685509347432; 
 Tue, 30 May 2023 22:02:27 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6zdM+NwwmkOkn1/FbJiRjlucehj0T4IXHzXCwALDcIa2VL48lW4yslmlS4LHzaV6iE2vr57g==
X-Received: by 2002:a17:907:a42a:b0:973:d06d:545f with SMTP id
 sg42-20020a170907a42a00b00973d06d545fmr3817753ejc.24.1685509347078; 
 Tue, 30 May 2023 22:02:27 -0700 (PDT)
Received: from [192.168.8.105] (tmo-065-8.customers.d1-online.com.
 [80.187.65.8]) by smtp.gmail.com with ESMTPSA id
 b13-20020a056402138d00b0050690bc07a3sm5259041edv.18.2023.05.30.22.02.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 May 2023 22:02:26 -0700 (PDT)
Message-ID: <cc482875-6007-466d-808a-fc3ddec2a659@redhat.com>
Date: Wed, 31 May 2023 07:02:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 3/4] tests/qtest: Fix a comment typo in vhost-user-test.c
To: Milan Zamazal <mzamazal@redhat.com>, qemu-devel@nongnu.org
Cc: mst@redhat.com, stefanha@redhat.com, alex.bennee@linaro.org
References: <cover.1685476786.git.mzamazal@redhat.com>
 <89d88ee1cab67b8412617e593ea786f1014d737b.1685476786.git.mzamazal@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <89d88ee1cab67b8412617e593ea786f1014d737b.1685476786.git.mzamazal@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.167,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 24/05/2023 15.34, Milan Zamazal wrote:
> Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
> ---
>   tests/qtest/vhost-user-test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/qtest/vhost-user-test.c b/tests/qtest/vhost-user-test.c
> index e4f95b2858..8ab10732f8 100644
> --- a/tests/qtest/vhost-user-test.c
> +++ b/tests/qtest/vhost-user-test.c
> @@ -281,7 +281,7 @@ static void read_guest_mem_server(QTestState *qts, TestServer *s)
>       /* iterate all regions */
>       for (i = 0; i < s->fds_num; i++) {
>   
> -        /* We'll check only the region statring at 0x0*/
> +        /* We'll check only the region starting at 0x0*/

While you're at it, I'd also add a space between the "0x0" and the "*/".

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>

>           if (s->memory.regions[i].guest_phys_addr != 0x0) {
>               continue;
>           }


