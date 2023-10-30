Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A55467DB599
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 10:01:31 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxO82-0003i4-4Z; Mon, 30 Oct 2023 05:00:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxO7x-0003hk-27
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:00:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1qxO7v-0000SL-DW
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 05:00:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698656402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Xmt6Vbi8/f2MxwxYBQdoxn+u7EVbvygfr9wDg4tnFSk=;
 b=JjDm6d22dOkbzMO4enz6+r4ybDOhQkPfJPFtILK8aQNkWZvJlGKCEKA8IqR8Uhc+/7JnzM
 T1fxMQrWmljbIRovlYOk/Gv0AuKN0uWcnK+FOUyPkztXF2QbkrybKQNZtQTHQAhUA6B5Wc
 2jpqzXM6jqPJCxdJSrtwzZaA94jITnA=
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com
 [209.85.221.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-_XQT9QRDP0Coz_ZT_73umQ-1; Mon, 30 Oct 2023 05:00:00 -0400
X-MC-Unique: _XQT9QRDP0Coz_ZT_73umQ-1
Received: by mail-vk1-f197.google.com with SMTP id
 71dfb90a1353d-4ab9d742f96so65565e0c.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 02:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698656400; x=1699261200;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Xmt6Vbi8/f2MxwxYBQdoxn+u7EVbvygfr9wDg4tnFSk=;
 b=IG1iWrKfIYTjUQ+Fq4xLYTBXEF+hpo0xMpWli3RHQgdbqAz0izMDgOpGuaoPDxekFO
 2Z6UnVVqxmb5/5kJOhT5p25ZAl77ZxG3/w12pTb4EkAGaj7ml6LLBoSfCPhnNqRuf+Rc
 ZCj3ebWTfQR3FV5dxknniQHYoJytNYrFodCERnSMRj5XHDFh6GWtb+hTf/i2aApu733t
 NzRhaT5Gdo9LGFsoX1IMel5kTVRZiUw4Gnvf+v8feS3bK6NA3rX99qAKdDK9T9XGdjEm
 W2PfIPmGZHNifjdepJp/7+x8V31RyGERoWai3YB4K3Yl2AcWcXiE2/RkOC8bF5/F/BQi
 WWaA==
X-Gm-Message-State: AOJu0YxwcLJHy5+zp6H29pxLt268Dug8/FL9T8Glj5bk8S8VKfybhBGs
 PzfSvcqh0m4oMy6dXpYXpLn+cKIEo9+YkWzyg83OmUi0AssORLeAsV6+nHdFHao9eDfCAC0ZCj8
 NOvzNlmwJyi+u3nDh04o071lSlAfvDY9J64aJzy46Gj/oHXl7+Gd7t+aB60Fqt9sO0BHJ
X-Received: by 2002:a1f:b201:0:b0:493:3491:ce89 with SMTP id
 b1-20020a1fb201000000b004933491ce89mr5120626vkf.14.1698656399987; 
 Mon, 30 Oct 2023 01:59:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgKDkI12+j6YxDEjIqCqrv7kwsDFvrsyiSZAQOudky0k+gmZtPsOz4d7FhiW8R21uZr3sCtg==
X-Received: by 2002:a1f:b201:0:b0:493:3491:ce89 with SMTP id
 b1-20020a1fb201000000b004933491ce89mr5120616vkf.14.1698656399548; 
 Mon, 30 Oct 2023 01:59:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 c11-20020a0ce14b000000b0065823d20381sm3241993qvl.8.2023.10.30.01.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 01:59:59 -0700 (PDT)
Message-ID: <1d97bad3-e529-4cf1-a3e4-f3b684b07223@redhat.com>
Date: Mon, 30 Oct 2023 09:59:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] util/uuid: Define UUID_STR_LEN from UUID_NONE string
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Fam Zheng <fam@euphon.net>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
References: <20231027065443.1305431-1-clg@redhat.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <20231027065443.1305431-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.478,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/27/23 08:54, Cédric Le Goater wrote:
> Cc: Fam Zheng <fam@euphon.net>
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
> 
>   Follow up on :
>   
>   https://lore.kernel.org/qemu-devel/20231026070636.1165037-1-clg@redhat.com/
> 
>   include/qemu/uuid.h | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/include/qemu/uuid.h b/include/qemu/uuid.h
> index 356efe7b5797911640ed347fc08f4ef5ebbd0476..869f84af09ddc4aa80d53e133c323781ade4d190 100644
> --- a/include/qemu/uuid.h
> +++ b/include/qemu/uuid.h
> @@ -78,9 +78,10 @@ typedef struct {
>                    "%02hhx%02hhx-" \
>                    "%02hhx%02hhx%02hhx%02hhx%02hhx%02hhx"
>   
> -#define UUID_STR_LEN (36 + 1)
> -
>   #define UUID_NONE "00000000-0000-0000-0000-000000000000"
> +QEMU_BUILD_BUG_ON(sizeof(UUID_NONE) - 1 != 36);
> +
> +#define UUID_STR_LEN sizeof(UUID_NONE)
>   
>   void qemu_uuid_generate(QemuUUID *out);
>   

Applied to vfio-next.

Thanks,

C.


