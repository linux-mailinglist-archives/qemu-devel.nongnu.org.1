Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C6927A0F0F
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 22:35:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgt2n-00069k-HP; Thu, 14 Sep 2023 16:34:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgt2l-00069H-TU
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:34:31 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qgt2k-0003uS-BF
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 16:34:31 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9a65f9147ccso186190066b.1
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 13:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694723668; x=1695328468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dxgQToQ6L5P+lLrdOc7K+KddDdTU2BxQc4ww2Mix52Y=;
 b=ONrFvXMZrmOhtr/1zyaRCcQcBIR6+yeN19ExM4gMOmfw5edBzpXW3+sETflCxI6pui
 P5p9/jQe4YFXu6R+Rq9gLxH7LP4+wmpgmkXdbb+cGMVEcXlHn79HG97djd0feaMsEXaJ
 jCvufFB+7v4bOXn+vzPBWJV4JLMOc2Eak7CLEDSwnossBnUU8j8gxKX3a4kfePO4SV3y
 6mLw7dewDRj08/Jn0JXedNUSB2P0UC6FDcawy7Gj/X2nBnvVaRaCua899TzOJ5jYJXyS
 ogUCmnf3CXu7mypcZE3zKZWPw5YlJLYoA+GB+uPB99lUk7bPYs7WK6DcI+8xupuJcTmJ
 ++NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694723668; x=1695328468;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dxgQToQ6L5P+lLrdOc7K+KddDdTU2BxQc4ww2Mix52Y=;
 b=rZN7iQC5SF2LICX2c7Tzc7DiPsPf44LcpUinFbks51T7ePVysqGxGIF05daHne/AbW
 yKDU7BlzhIgpBWbQ3qvmmH+iOXAxfepM6FFiks4UD35aBc1mS6Was8i1rMdJmU+dZnfG
 11HcDPwrLiN0sPoDOgRzkB0T2NvVZ5folOy7aHGEqH3Z36lfEQK4UKl8NXuJCFbK5Dmb
 +8BYz0V4w9M2lflS7RXmsNNAOwQXaSGMapsw9QlQV1tguHjwi8pk++bYmQMlBa480nM5
 TiNkQVA+amOwvjiSRUDCz9uOsKln3a+XSwn9OI/WmVzy64U8y5wyvhU9P8gI0KHhXnX2
 yUmg==
X-Gm-Message-State: AOJu0Yz9wamoh87hSGk99utjYAKeqfRQmvPY+82Ys7ul5XxnMbyPNGZk
 nwI4kHqkZzNaij4rJ08ZbqD1UTEV9lqbvol0FHg=
X-Google-Smtp-Source: AGHT+IGm9M9W0mQxoMQrZj7L7om9l1V1IU71Wy8023NyzElRP/4IfN2t2eb4a6TMPSE/gL1Qn+W3QQ==
X-Received: by 2002:ac2:4e03:0:b0:502:d862:cc36 with SMTP id
 e3-20020ac24e03000000b00502d862cc36mr6299173lfr.53.1694723354861; 
 Thu, 14 Sep 2023 13:29:14 -0700 (PDT)
Received: from [192.168.69.115] (176-131-223-129.abo.bbox.fr.
 [176.131.223.129]) by smtp.gmail.com with ESMTPSA id
 y3-20020a17090629c300b009929d998abcsm1450464eje.209.2023.09.14.13.29.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 13:29:14 -0700 (PDT)
Message-ID: <836cac9d-fc75-deb6-5648-0ea6b614abcf@linaro.org>
Date: Thu, 14 Sep 2023 22:29:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v3 5/5] vfio-user: Fix config space access byte order
To: Mattias Nissler <mnissler@rivosinc.com>, qemu-devel@nongnu.org
Cc: john.levon@nutanix.com, Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jagannathan Raman <jag.raman@oracle.com>, stefanha@redhat.com,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230907130410.498935-1-mnissler@rivosinc.com>
 <20230907130410.498935-6-mnissler@rivosinc.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230907130410.498935-6-mnissler@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 7/9/23 15:04, Mattias Nissler wrote:
> PCI config space is little-endian, so on a big-endian host we need to
> perform byte swaps for values as they are passed to and received from
> the generic PCI config space access machinery.
> 
> Signed-off-by: Mattias Nissler <mnissler@rivosinc.com>
> ---
>   hw/remote/vfio-user-obj.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/remote/vfio-user-obj.c b/hw/remote/vfio-user-obj.c
> index cee5e615a9..d38b4700f3 100644
> --- a/hw/remote/vfio-user-obj.c
> +++ b/hw/remote/vfio-user-obj.c
> @@ -281,7 +281,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
>       while (bytes > 0) {
>           len = (bytes > pci_access_width) ? pci_access_width : bytes;
>           if (is_write) {
> -            memcpy(&val, ptr, len);
> +            val = ldn_le_p(ptr, len);
>               pci_host_config_write_common(o->pci_dev, offset,
>                                            pci_config_size(o->pci_dev),
>                                            val, len);
> @@ -289,7 +289,7 @@ static ssize_t vfu_object_cfg_access(vfu_ctx_t *vfu_ctx, char * const buf,
>           } else {
>               val = pci_host_config_read_common(o->pci_dev, offset,
>                                                 pci_config_size(o->pci_dev), len);
> -            memcpy(ptr, &val, len);
> +            stn_le_p(ptr, len, val);
>               trace_vfu_cfg_read(offset, val);
>           }
>           offset += len;

This makes sense,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


