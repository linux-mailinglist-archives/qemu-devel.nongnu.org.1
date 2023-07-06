Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AC27498A2
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 11:39:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHLRk-0007hd-8k; Thu, 06 Jul 2023 05:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHLRh-0007gy-Ve
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 05:38:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qHLRg-0003ZX-Jr
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 05:38:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688636319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rkAPeRv4AAWOMTeTvOzzjebibiSJdNDWBcIdJ9ll5mE=;
 b=JCLamQhjGcmsI4KlqzIVWdHGxsWRqfaUm5x+IfdkeXWAalkh3RGd+mHIz/YYAuzuj+MJoz
 /vqonikiybnz/adRyKKm1zyoxJwtN32MAaiCnuW300IFz+3ysYuDPQha8Rg/9ExQS2K2d7
 V2R4dB8/cnSEMZ5QGQUehR9JdfqBiGg=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-720v7fR-NziJrTcZ5zySEw-1; Thu, 06 Jul 2023 05:38:38 -0400
X-MC-Unique: 720v7fR-NziJrTcZ5zySEw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-992e6840901so66953566b.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 02:38:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688636317; x=1691228317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rkAPeRv4AAWOMTeTvOzzjebibiSJdNDWBcIdJ9ll5mE=;
 b=M1BdPsJxHhJAia+R6gz7jVB72mcJIEIrj6lkl2kZkNOZoExlKckzTRdx2DTDNaoiIm
 uBC6AlzlBTtsllitqXJcOUaxlSNykv3F/dnBU0Uj9r+Q19y8pi4d6zOthGiYDD9tdj2c
 hVnQ0sA8jcq5DMluGPzVl45I5TnkGDqA/Knbt5wj1tpeZmBv39OS+II7zK/0IX52B83Q
 g+lIAjSyzCMOgnYzY6KzhkCnYb1azmv+I3iC4O/lcno/SPsFeTLZ5D0maXkOw4OcKCeN
 rPhsFgQodxOPkC+BOPZJWj8wqEtXTm3ap/Tio9hlgwkEkLD4hy10EzRU8Eqmb7u486Dm
 SXAw==
X-Gm-Message-State: ABy/qLYDbHxT5vPiZAphq4duUN61Sii/YluN0/EhgCtvteRR3a8lLhc8
 +fjFUze5Lihu3FGrF1K5WLZowoOzW9GFvy8Ewp/Y10cmaVMiwx69nVzHDr1vNzQG4UMGPSH2KJ1
 M8axY6tdNKqglom8=
X-Received: by 2002:a17:907:969f:b0:953:834d:899b with SMTP id
 hd31-20020a170907969f00b00953834d899bmr4445169ejc.29.1688636317344; 
 Thu, 06 Jul 2023 02:38:37 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGkzq5AjhTPL0xep6tpLTTfE/6OBgDYyHB+bVA2CllFg+WQgmSBnSbzCd5tA6IT+Wg/oWIYlA==
X-Received: by 2002:a17:907:969f:b0:953:834d:899b with SMTP id
 hd31-20020a170907969f00b00953834d899bmr4445160ejc.29.1688636317090; 
 Thu, 06 Jul 2023 02:38:37 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045?
 ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
 by smtp.googlemail.com with ESMTPSA id
 dc7-20020a170906c7c700b00992076f4a01sm560602ejb.190.2023.07.06.02.38.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 02:38:36 -0700 (PDT)
Message-ID: <f45b0555-0808-0e99-24cb-fbf24bc2277e@redhat.com>
Date: Thu, 6 Jul 2023 11:38:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] kconfig: Add PCIe devices to s390x machines
Content-Language: en-US
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
References: <20230705152301.2850086-1-clg@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230705152301.2850086-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 7/5/23 17:23, Cédric Le Goater wrote:
> +    imply E1000E_PCI_EXPRESS
> +    imply IGB_PCI_EXPRESS
> +    imply USB_XHCI_PCI

"imply" should only be used whenever the device can be created with the 
front-end/back-end combo command line options, and as far as I can see 
this is not the case here.

You could set CONFIG_PCIE_DEVICES=y in s390-softmmu.mak and make these 
three devices "default y if PCI_DEVICES || PCIE_DEVICES".

Paolo


