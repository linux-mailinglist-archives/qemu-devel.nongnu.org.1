Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B5E991DFFA
	for <lists+qemu-devel@lfdr.de>; Mon,  1 Jul 2024 14:55:42 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGZE-00087C-B7; Mon, 01 Jul 2024 08:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGZA-0007vw-Gd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:55:32 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGZ5-0005e6-JQ
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:55:31 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4257a390a4eso12510915e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838525; x=1720443325; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xAZY3KwQVvcIInlMOR/b8oGpaTozUJdYUcKYuEK8xMw=;
 b=eV/6nCsAhv6ocCmAPTzF8MSsvT+or+QywaKcseG7Y6fwH1+RGSo2AF8ApM2+heeXnA
 7e+Z32uiDTs08+hgcOf0valUuJWRiruvJB06+W8RTaRkJxokG27siijvKLsbMoJpqKyP
 XY/6cu3MuxH6dbEDOd2alU+lxVVSk+75WrUgiONAo3NX8ujyCMaQ3DJYSgxQgxmvadxa
 UiT3eCUlciCsa0M2DqLnedhtMvvpjGlQyVqLvmncZwynVh7qA7rDr8GKJ/4SC/kMtgW9
 4k4Unbvu95sX+i7/I1a17rbyjX1lEFvOh3ggX+yKnORsI7+6omqF3lwkaF6xqI5+zN31
 Y2hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838525; x=1720443325;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xAZY3KwQVvcIInlMOR/b8oGpaTozUJdYUcKYuEK8xMw=;
 b=JnSinxxsMHg0VcESNzF3bUKQP+gu3lhuqsdN35rlbMJYuJmJfX2Xbmh/h7D9GgPEZo
 HwfxVnjYxVLx65h1TZHH7Cd7eQRUboqy2SaOcLZLbzCapmFLuA09XvwBoHj93TlVaiZp
 s/pYlX2Lg7wP3xR3hjMsdoD9GcfBDhMow4TqFQY19UY3WEJ0uOqO6K5PkgR3KzlBbjtG
 2rpJpplZqk/8i+tQ4a4mme0/6VVcr3AJuDUtSsW7I+44cr1oiYZOw1Fb1R0+J7eaB0+w
 GPQD3Vvx4TsmAyA+WPWCvI9ssqgGsM5CNz6LscTEwoCW1CTpq9YusTSBxgN95S8URR5Y
 oqnA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIIFOdYTxHJvvp0SYzYy1/+y2NWICS7qTdugSZdesDWflrTd1x95D7muFCJUGwtLnaQXChed2pdIanvmTZuZmqyAAWSjY=
X-Gm-Message-State: AOJu0Yx5smZPvwPZKXsKLKMiPd2KfQCeSscF3KdDdYFJvBZ6SMHap4Zk
 3CPUx2FsYP+JoAvu2LhJP3kMBfypGkszXuALnwVdV5PtrEKPlo4jGs3CLhRKcXE=
X-Google-Smtp-Source: AGHT+IFLAe9UNwKPMtbujWGkKRDPAafVnTFJSxfViUbtpX0Tm22pbytFj6AmFDKNAHKtbrriI60DlA==
X-Received: by 2002:a05:600c:3b09:b0:424:a721:1d0f with SMTP id
 5b1f17b1804b1-4257a020eeemr36572665e9.29.1719838524673; 
 Mon, 01 Jul 2024 05:55:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4257dee5f2asm63843755e9.22.2024.07.01.05.55.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:55:24 -0700 (PDT)
Message-ID: <ddb08424-4211-4202-aa73-ef5fc7c11404@linaro.org>
Date: Mon, 1 Jul 2024 14:55:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/14] hw/arm: convert 'virt' machine definitions to
 use new macros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> This changes the DEFINE_VIRT_MACHINE macro to use the common
> helpers for constructing versioned symbol names and strings,
> bringing greater consistency across targets.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/virt.c | 28 +++++++++++++++-------------
>   1 file changed, 15 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


