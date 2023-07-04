Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E53746E51
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:11:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGcyR-0001d6-RK; Tue, 04 Jul 2023 06:09:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGcyO-0001cU-Dw
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:09:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qGcyM-0006oB-G2
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:09:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688465363;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ReVL85Yw0Dg35VJ3gOFqczUvIkmobJgbQpvwrV7PYfg=;
 b=cGVPRb4kVnLCuP8uS2nv0ARUSfumu3nLRSLA5EeDEAudBWOELGGmRsbNVwSWxiHcKyAgb+
 pOHlagF/i84xRkI/TeJKEd4nKC0HE9so2i7Hb1wdE9S9/TTnckGLGgzO6bxhVCZ5dvTahE
 bhZ4V/1btWkSwBlcyoQU+h8mS0CEutQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-439-5_3RxUOSNXevxEmAHM5jiw-1; Tue, 04 Jul 2023 06:09:22 -0400
X-MC-Unique: 5_3RxUOSNXevxEmAHM5jiw-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-765ab532883so659067885a.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 03:09:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688465362; x=1691057362;
 h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
 :content-language:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ReVL85Yw0Dg35VJ3gOFqczUvIkmobJgbQpvwrV7PYfg=;
 b=lnspm8RBqEgFVWSBbc36/aYsUHzoVYrqbGAiq7GlCSjTrCpQPVX3JknTp+mZOM4dY0
 qyMFNGqYu+hMBnE7HuS+JPvTVO7FpjdVcQtPcy28AIlvoYaOWQnSSSuP+UU+rohbeb60
 LoheLyoB2GEsIp1ztZZOasX81A5v5cx9Sdvk7Mra+A4OvpIgHw9pzw38NwHPyhMKWiFw
 N9MJ8UgWe81yB3TsXRyskETon68V49gwpraJW5EFoRY2KmvtlUb4HsnJlVjF4b3fEwDo
 m2JMkERQoXRlqw9R+DBF6ANK2jt8reEvExogrQDkKQ03xyomJbvJ6Bm8cU1lzgs+hlb/
 TiuA==
X-Gm-Message-State: ABy/qLaf3PI/JtGfCwaQguXwJVzUAM29K0p0nSKKU43peb2Y/ZHgTH9d
 82VTMST8+7Q2kcYz8nrftMbTugwZkIhpltcKo3fvLHdTqeRG2SZyHtWeSfWuFxJIaP2FTdq6vUS
 UdlmgTZKMGQ0FnWE=
X-Received: by 2002:a05:6214:2129:b0:62d:eda3:431d with SMTP id
 r9-20020a056214212900b0062deda3431dmr15679094qvc.20.1688465362234; 
 Tue, 04 Jul 2023 03:09:22 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHaqGHwkAx9B96edHsi6kzzMp09GLVoaczM+7nTQIIXx4eLwWpSRqILSOvs49ytrL0DkKinig==
X-Received: by 2002:a05:6214:2129:b0:62d:eda3:431d with SMTP id
 r9-20020a056214212900b0062deda3431dmr15679081qvc.20.1688465361915; 
 Tue, 04 Jul 2023 03:09:21 -0700 (PDT)
Received: from [192.168.0.5] (ip-109-43-179-126.web.vodafone.de.
 [109.43.179.126]) by smtp.gmail.com with ESMTPSA id
 s16-20020a05621412d000b00636d2482dd4sm2393850qvv.17.2023.07.04.03.09.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Jul 2023 03:09:21 -0700 (PDT)
Message-ID: <0e9bc700-38db-2400-5a3f-3660f5485048@redhat.com>
Date: Tue, 4 Jul 2023 12:09:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230704093204.2579133-1-clg@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH] kconfig: Add PCIe devices to s390xx machines
In-Reply-To: <20230704093204.2579133-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.09, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 04/07/2023 11.32, Cédric Le Goater wrote:
> It is useful to extend the number of available PCI devices to KVM guests
> for passthrough scenarios and also to expose these models to a different
> (big endian) architecture.

Maybe mention that these devices can work on s390x since they support MSI-X 
? (While most of the other devices don't work on s390x since they only 
support legacy interrupts)

> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/s390x/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/s390x/Kconfig b/hw/s390x/Kconfig
> index 5e7d8a2bae8b..373f38adcd6b 100644
> --- a/hw/s390x/Kconfig
> +++ b/hw/s390x/Kconfig
> @@ -10,3 +10,7 @@ config S390_CCW_VIRTIO
>       select SCLPCONSOLE
>       select VIRTIO_CCW
>       select MSI_NONBROKEN
> +    select PCI_EXPRESS
> +    select E1000E_PCI_EXPRESS
> +    select IGB_PCI_EXPRESS
> +    select USB_XHCI_PCI

Please don't use "select" here - you still want these devices to be disabled 
in case you run configure with "--without-default-devices".

You can use "imply" instead of "select" instead.

  Thomas


