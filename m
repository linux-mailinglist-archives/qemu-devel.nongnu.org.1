Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BACC7245A8
	for <lists+qemu-devel@lfdr.de>; Tue,  6 Jun 2023 16:20:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q6XXS-0005fg-Pm; Tue, 06 Jun 2023 10:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6XXR-0005cb-3v
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q6XXP-000766-KV
 for qemu-devel@nongnu.org; Tue, 06 Jun 2023 10:19:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1686061194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GLk2DYumS/fBSJ0k9e3ySyuc3BsI6QIzXl05sEIrU3k=;
 b=ER6kHSqAL7HL0NSqi5Z6dnWrCc4NSt147Iua0Y4dRjc1LBUwREtJB0YZ7O2FWKegygXoHI
 qVl2f1LvnJ/hc5vCLfJV/pc9wiEViQt6N6TMwdSAJ4GwXX8ItUYsAv2jjxMGU6pjJ2Jybb
 PyqKR9YRYHfbpVCFCQKOvmYE+Sr4ftA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663--giEZwZzMiSjMYk1TV2LcA-1; Tue, 06 Jun 2023 10:19:52 -0400
X-MC-Unique: -giEZwZzMiSjMYk1TV2LcA-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30b88392ac6so3354401f8f.0
 for <qemu-devel@nongnu.org>; Tue, 06 Jun 2023 07:19:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686061191; x=1688653191;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GLk2DYumS/fBSJ0k9e3ySyuc3BsI6QIzXl05sEIrU3k=;
 b=cSNIih5VkqAwAL0JvIEUlqwf67zH/OqSgCfrrsykNTi2wP07cHe85giUiCs/BM8Euz
 TMo9EWb30cS97jIDSQryEZg35o0Kmxku4XBOVRaul0+dZ7WgL5hhvnSPn/UTUv2iPcGQ
 jB40JldcqWRp6WUm9CR6r3rT9kYOR8JQpIbvx+ljPbme5sX+jf7/sXBgfpeEGXIF+vTJ
 nCQ372NbWIt5zjQR/Nhvfe9/+gVRvlcM5r/XG8x7wc1cqhLPG3DDlt4Hn0I4TSyHdpkj
 bOfSDm725XBVGDH/OS/RjPS5D0isCWNcOekPX7TZlq6VJVFY51sace8deM0hlu3ZY5ev
 fdYQ==
X-Gm-Message-State: AC+VfDwn2MxSHxBANFmt5WmzZMPIbnCgeMXrRtZ96OV2JoiN2GU7DM9c
 w8csfiNPxlpvu7gG9kryJpL1148S5nI3RYuzNwABC5LLavQPTUx4qssHFSnuGcgzMq8CIxB3nk7
 4VJa+VGLSJO0I9kw=
X-Received: by 2002:adf:f74e:0:b0:30a:e92c:25fa with SMTP id
 z14-20020adff74e000000b0030ae92c25famr1965959wrp.60.1686061190907; 
 Tue, 06 Jun 2023 07:19:50 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7xt2HY226Iy0cb/gBSyOTyICtzgHB5q/+TaPI+PNJv3p2lveI2ozN+1sqg/jUSbnweRkuBwg==
X-Received: by 2002:adf:f74e:0:b0:30a:e92c:25fa with SMTP id
 z14-20020adff74e000000b0030ae92c25famr1965940wrp.60.1686061190642; 
 Tue, 06 Jun 2023 07:19:50 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-42-114-92.web.vodafone.de.
 [109.42.114.92]) by smtp.gmail.com with ESMTPSA id
 h7-20020adff4c7000000b002f28de9f73bsm12688981wrp.55.2023.06.06.07.19.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Jun 2023 07:19:50 -0700 (PDT)
Message-ID: <b08eedaf-120a-8c05-c946-b65abe4741c9@redhat.com>
Date: Tue, 6 Jun 2023 16:19:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] hw/remote/proxy: Remove dubious 'event_notifier-posix.c'
 include
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 John G Johnson <john.g.johnson@oracle.com>,
 QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230606134913.93724-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230606134913.93724-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.094, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 06/06/2023 15.49, Philippe Mathieu-Daudé wrote:
> event_notifier-posix.c is registered in meson's util_ss[] source
> set, which is built as libqemuutil.a.p library. Both tools and
> system emulation binaries are linked with qemuutil, so there is
> no point in including this source file.
> 
> Introduced in commit bd36adb8df ("multi-process: create IOHUB
> object to handle irq").
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Note, --enable-multiprocess doesn't seem to be covered in CI.
> ---
>   hw/remote/proxy.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/hw/remote/proxy.c b/hw/remote/proxy.c
> index 1c7786b52c..2052d721e5 100644
> --- a/hw/remote/proxy.c
> +++ b/hw/remote/proxy.c
> @@ -22,7 +22,6 @@
>   #include "qom/object.h"
>   #include "qemu/event_notifier.h"
>   #include "sysemu/kvm.h"
> -#include "util/event_notifier-posix.c"
>   
>   static void probe_pci_info(PCIDevice *dev, Error **errp);
>   static void proxy_device_reset(DeviceState *dev);

Reviewed-by: Thomas Huth <thuth@redhat.com>


