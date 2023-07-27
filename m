Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 729A37654E8
	for <lists+qemu-devel@lfdr.de>; Thu, 27 Jul 2023 15:25:46 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qP0tK-0005mE-T1; Thu, 27 Jul 2023 09:18:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qP0tJ-0005ln-52
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:18:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1qP0tH-0000AY-DW
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 09:18:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690463929;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=s4OUjzJzBiN6lpFa7RP5ciiL3Gg720Rke8ZIrPI3zMA=;
 b=A0Y/1HYm3oWpSnQVlcsB19wD3Twb8h/umVOEIWkqXY0pMuG8SwDjYf5B+C07VMkHn3n7VL
 05qCZVnw755NqHZg2juVcscG0BiFxsc1a+JlJuL6hLfiiCX11ljbk0qL25eonxskL2GtT+
 ZhNbVtgfjctELSFS5gOmY2JhIZpBl2s=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-651-MDjm9GIiPd6fthulA7C1zQ-1; Thu, 27 Jul 2023 09:18:47 -0400
X-MC-Unique: MDjm9GIiPd6fthulA7C1zQ-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-3fd2e286689so5374265e9.3
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 06:18:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690463926; x=1691068726;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s4OUjzJzBiN6lpFa7RP5ciiL3Gg720Rke8ZIrPI3zMA=;
 b=Z6ry7XRHBJpyqtbby4aUP6pdRnmqMD7Urthc50fbCKJKfbmczAtAWzCr4ZVCsY5AeY
 Awp/JYg7Y8tJqGLl2OMMrJoEMAg73BHRckjmL4wnouqmwiWQ29sBWjMiU8YDNEm1LVvI
 tbnt/Lg1sqe4CDBY7h76VvGL35JO2j60B5A7Wph27HvCmEbtoiOkrmakRmIcNnfp1Zs0
 GVyy9KHRRROTTw4E/Ko9UvxhQfGRDscJJDYaFMEa0t1TguE8qvN6VD7YhBJIV0C4oC1a
 JW1fp7CmffzBMbqRWrH98Bw+Sfr+tyYccTZ/gmDC/tNH8ffp/ZYbztbJbee/Z3OBEIXo
 KotA==
X-Gm-Message-State: ABy/qLZe6qtiULIVnnHEr3iww+t75tOolVQhfZ75fyXQmSKeu+xCYGLH
 ZMcLPnDiOXB2ujd31QQOHog9ppt7jYYCktP9QoSOaG7TniO2RhMu72vAIdqINxKk/3l7p+zYpQR
 sZRb7vC3shzQhvE8=
X-Received: by 2002:adf:f80b:0:b0:314:15b7:20a5 with SMTP id
 s11-20020adff80b000000b0031415b720a5mr1604552wrp.54.1690463926310; 
 Thu, 27 Jul 2023 06:18:46 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGt7DtEA2u+7gEIm1Wwuy2fbQxYcfHP3wvwup9lpwGSfAJWGcbBCgskVlNr54lkultkQsZT3Q==
X-Received: by 2002:adf:f80b:0:b0:314:15b7:20a5 with SMTP id
 s11-20020adff80b000000b0031415b720a5mr1604535wrp.54.1690463925910; 
 Thu, 27 Jul 2023 06:18:45 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 x2-20020adfffc2000000b0031755da6a8asm2077860wrs.33.2023.07.27.06.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 06:18:45 -0700 (PDT)
Message-ID: <183e16a8-55c3-7550-a9ff-21f31f65d0e5@redhat.com>
Date: Thu, 27 Jul 2023 15:18:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2] softmmu/physmem: try opening file readonly before
 failure in file_ram_open
Content-Language: en-US
To: Thiner Logoer <logoerthiner1@163.com>, qemu-devel@nongnu.org
Cc: imammedo@redhat.com
References: <20230726145912.88545-1-logoerthiner1@163.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20230726145912.88545-1-logoerthiner1@163.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 26.07.23 16:59, Thiner Logoer wrote:
> Users may give "-mem-path" a read only file and expect the file
> to be mapped read-write privately. Allow this but give a warning
> since other users may surprise when the ram file is readonly and
> qemu suddenly aborts elsewhere.
> 
> Suggested-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Thiner Logoer <logoerthiner1@163.com>
> ---
> 
> See the previous version at:
> https://lore.kernel.org/qemu-devel/96a462ec-6f9d-fd83-f697-73e132432ca4@redhat.com/T/
> 
> verified, this patch works for my setup, both functionality and the warning
> are expected behavior.
> 
> Also another problem when I look at the file_ram_open
> 
> When readonly is true and the path is a directory, the open will succeed but
> any later operations will fail since it is a directory fd. This may require
> additional commits which is out of my scope. Merely record the question here.
> 
>   softmmu/physmem.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/softmmu/physmem.c b/softmmu/physmem.c
> index 3df73542e1..e8279d69d4 100644
> --- a/softmmu/physmem.c
> +++ b/softmmu/physmem.c
> @@ -1296,6 +1296,7 @@ static int file_ram_open(const char *path,
>       char *sanitized_name;
>       char *c;
>       int fd = -1;
> +    bool first_trial = true;
>   
>       *created = false;
>       for (;;) {
> @@ -1332,6 +1333,18 @@ static int file_ram_open(const char *path,
>                   break;
>               }
>               g_free(filename);
> +        } else if (first_trial && !readonly && errno == EACCES) {

I guess it's better to only retry on private mappings, for shared 
mappings that cannot possibly work.

> +            /* @path may be a read only file */
> +            fd = open(path, O_RDONLY);
> +            if (fd >= 0) {
> +                /*
> +                 * Sometimes this behavior is not desired. Fire a warning but
> +                 * continue.
> +                 */
> +                warn_report("backing store %s is opened readonly because the"
> +                            "file is not writable", path);


Makes sense, this used to not work in the past, now it works with a 
warning. Now it will work in many cases (except when ftruncate/fallocate 
would be required, and at least most fallocate callers can handle errors 
gracefully).


-- 
Cheers,

David / dhildenb


