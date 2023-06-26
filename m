Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6A3273E0E3
	for <lists+qemu-devel@lfdr.de>; Mon, 26 Jun 2023 15:42:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDmTK-0005UN-DZ; Mon, 26 Jun 2023 09:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qDmT7-0005P4-Um
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:41:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clegoate@redhat.com>)
 id 1qDmT6-0003Jm-G5
 for qemu-devel@nongnu.org; Mon, 26 Jun 2023 09:41:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687786883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SesPdDB5G7wLG5jzAVmKUYNLiBdJAPCjiw273zB6iAk=;
 b=IwIXwfV4AWY41hDb/Wd8Z8ryx0BNsSI8+qoZzoOLvJwwNlKA+Mmyuv8IYZIGEvfZBgLSLt
 SRIGSHAxJy/Akgsj6M/h62G7T4hUPORmfZRTAvWEug6f5jwHAgRbqblSIfl5BjSnFGY2gV
 MNsmjMYYei43UqD+0iCzRgpTEBtFilI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-FEsqVSQxOEOa4F9N3w0Rsw-1; Mon, 26 Jun 2023 09:41:22 -0400
X-MC-Unique: FEsqVSQxOEOa4F9N3w0Rsw-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-62fe5abe808so17831726d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 Jun 2023 06:41:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687786881; x=1690378881;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SesPdDB5G7wLG5jzAVmKUYNLiBdJAPCjiw273zB6iAk=;
 b=jmuGI+7VuqaMGVUYiE8qwUCmKRq/2sQ4d8w5hv205d98LubTqJ1Geg3Z45/BitJnTe
 KXEDpFcJsYPBRXRlP9IvJwmaXDIrLrvCXMywM4WgmlckLdyNZOLi614qhWY9rmyu/759
 G4YcMr3TUqCbgbjAhZC5P5pEeYTtqre7ZEPxiNts0UKViauD1+isHmMcypgshze1uJKB
 hcvuwh8vzYun75QX96odeF4GoXRNx13F9LGmmHovLVTj5ATBmX7yaEiCNiKcYIsuPCut
 phIvoLjEZ5cNA2SY5JCL7X5A+xq/qi+2vWh6QFibr4c/URV6kNUxVNAuWmPfMdQ4geZD
 wgwQ==
X-Gm-Message-State: AC+VfDzeJnHcBbbvTipw5py+YScDMmfzLjeNI/EcgwbbyEO/HZ++CISI
 Ee/EC0LM8U3VKG3wqcqRVRr6EXf/1uW1LJpsqYt9T0D72v6e7jrX7Ta5opX8gxRVM/I/bBMa/g8
 o+x5y35JsUmW4JGc=
X-Received: by 2002:ad4:576e:0:b0:62d:e6f1:6bea with SMTP id
 r14-20020ad4576e000000b0062de6f16beamr28826816qvx.10.1687786881537; 
 Mon, 26 Jun 2023 06:41:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5KtnlG9BCTVfS5tgi0KIoecbpmcxjkgTfwjT2n7RGY+LOlHTUFzv3WiFphyb/OTZ/HlVPeSQ==
X-Received: by 2002:ad4:576e:0:b0:62d:e6f1:6bea with SMTP id
 r14-20020ad4576e000000b0062de6f16beamr28826803qvx.10.1687786881318; 
 Mon, 26 Jun 2023 06:41:21 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 dk13-20020a056214092d00b005dd8b9345besm3196677qvb.86.2023.06.26.06.41.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Jun 2023 06:41:20 -0700 (PDT)
Message-ID: <6542ed31-8986-c6f1-5d5a-69cd4ce9c6c0@redhat.com>
Date: Mon, 26 Jun 2023 15:41:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 2/4] pc-bios/s390-ccw: Provide space for initial stack
 frame in start.S
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 mrezanin@redhat.com, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
References: <20230626132138.87668-1-thuth@redhat.com>
 <20230626132138.87668-3-thuth@redhat.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clegoate@redhat.com>
In-Reply-To: <20230626132138.87668-3-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clegoate@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001,
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

On 6/26/23 15:21, Thomas Huth wrote:
> Providing the space of a stack frame is the duty of the caller,
> so we should reserve 160 bytes before jumping into the main function.
> Otherwise the main() function might write past the stack array.
> 
> While we're at it, add a proper STACK_SIZE macro for the stack size
> instead of using magic numbers (this is also required for the following
> patch).
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>


Reviewed-by: Cédric Le Goater <clg@redhat.com>

Thanks,

C.

> ---
>   pc-bios/s390-ccw/start.S | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/s390-ccw/start.S b/pc-bios/s390-ccw/start.S
> index d29de09cc6..29b0a9ece0 100644
> --- a/pc-bios/s390-ccw/start.S
> +++ b/pc-bios/s390-ccw/start.S
> @@ -10,10 +10,12 @@
>    * directory.
>    */
>   
> +#define STACK_SIZE 0x8000
> +
>       .globl _start
>   _start:
>   
> -    larl    %r15,stack + 0x8000     /* Set up stack */
> +    larl    %r15,stack + STACK_SIZE - 160   /* Set up stack */
>   
>       /* clear bss */
>       larl    %r2,__bss_start


