Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E311476599F
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 19:13:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP3Ac-0001IW-NQ; Thu, 27 Jul 2023 11:44:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP3Aa-0001ID-UY
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:44:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1qP3AZ-0005VI-Lb
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 11:44:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690472690;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RWW2XSst7NrjgvOWxajdFN3wR9RCO2mnqsbm9xL5FxQ=;
 b=Fu87dKlMiFApfSRngZhuKk0+ID/ofu1ZfUKX0/JdgS56if/tG10c6s4dRsa0YxMXbZQPCC
 P/zyZdUiHfIzJCcNS3+TX5pOgG9QxCx/sDfwJy/DPH2lgF5RemfSXlLiGKmQeFgOMBwsUo
 wVMnEW+hek1DF5F6QXOkSg5HqI0oLxE=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-Yi6cDeglPB2vebbRg0AVYQ-1; Thu, 27 Jul 2023 11:44:49 -0400
X-MC-Unique: Yi6cDeglPB2vebbRg0AVYQ-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-997c891a88dso65713266b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 08:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690472688; x=1691077488;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RWW2XSst7NrjgvOWxajdFN3wR9RCO2mnqsbm9xL5FxQ=;
 b=B7+l7DXP6+z6JVWylFkCnV4UfBu7CYN68Q/GIXm9dO36WVSOP3xdTm4BU3oHKYLwdu
 ZgWCuaLwe+x7pGHY3QeGHzCFQQslR7MWq0WHlR+I2FbEZGPcnf6dCTk7Hm6X1wN0xSbW
 2EekAOcuQZh9XmLdf0KxvNirJv3f11cHPurdwJHkIg44bH+6vl6mVEtqkxdkEyDaeK2/
 7nc87mNFwomPb3MGXrwlQmfqA9YZ32aWb3OVljmqicbgL0F9/+2UN2K83e4jaA2y6qhV
 gRBT/LgBCK2imy3AMp4RJ7fZAkpq1RK8FU0SPmjaNOetq5ykvMRJRuDCqOzRKQhTAZRb
 1Cjw==
X-Gm-Message-State: ABy/qLaFg62/HhC0Vu53KO5gCZdzy3tkIQINpvtBpfN8TC7XAiDzeHpj
 3QFoC2kFMyVw8aa+e1+sL5xU2NUc3JAE9Nu/TnM2azivz0PSo/XIMqsnqxMKOi7t9tWo3XpeX9w
 QCqERRcDJtvSrVjM=
X-Received: by 2002:a17:906:53cc:b0:987:fe18:1c56 with SMTP id
 p12-20020a17090653cc00b00987fe181c56mr2550226ejo.47.1690472688127; 
 Thu, 27 Jul 2023 08:44:48 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEm52NkA3Z0uUCUbppqsRT9x+lDkYfcG9hh2cLfBLhC/+Qp4J+gM+Mw4pHPDUmqsmrWcuIo1A==
X-Received: by 2002:a17:906:53cc:b0:987:fe18:1c56 with SMTP id
 p12-20020a17090653cc00b00987fe181c56mr2550206ejo.47.1690472687760; 
 Thu, 27 Jul 2023 08:44:47 -0700 (PDT)
Received: from ?IPV6:2003:cf:d71a:f311:3075:1f38:7e25:e17a?
 (p200300cfd71af31130751f387e25e17a.dip0.t-ipconnect.de.
 [2003:cf:d71a:f311:3075:1f38:7e25:e17a])
 by smtp.gmail.com with ESMTPSA id
 pv24-20020a170907209800b009920e9a3a73sm893067ejb.115.2023.07.27.08.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 08:44:47 -0700 (PDT)
Message-ID: <aa10c7e8-0941-8f10-39c4-0bae8f79b10e@redhat.com>
Date: Thu, 27 Jul 2023 17:44:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 7/9] throttle: use THROTTLE_MAX/ARRAY_SIZE for hard code
Content-Language: en-US
To: zhenwei pi <pizhenwei@bytedance.com>, berto@igalia.com, kwolf@redhat.com, 
 groug@kaod.org, qemu_oss@crudebyte.com
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, berrange@redhat.com
References: <20230724100939.1022984-1-pizhenwei@bytedance.com>
 <20230724100939.1022984-8-pizhenwei@bytedance.com>
From: Hanna Czenczek <hreitz@redhat.com>
In-Reply-To: <20230724100939.1022984-8-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 24.07.23 12:09, zhenwei pi wrote:
> The first dimension of both to_check and
> bucket_types_size/bucket_types_units is used as throttle direction,
> use THROTTLE_MAX instead of hard coded number. Also use ARRAY_SIZE()
> to avoid hard coded number for the second dimension.
>
> Hanna noticed that the two array should be static. Yes, turn them
> into static variables.
>
> Signed-off-by: zhenwei pi <pizhenwei@bytedance.com>
> ---
>   util/throttle.c | 11 ++++++-----
>   1 file changed, 6 insertions(+), 5 deletions(-)

Using ARRAY_SIZE() for the other dimension is quite nice, too, indeed.  
Thanks!

Reviewed-by: Hanna Czenczek <hreitz@redhat.com>


