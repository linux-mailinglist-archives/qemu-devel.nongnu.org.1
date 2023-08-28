Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9767678B71D
	for <lists+qemu-devel@lfdr.de>; Mon, 28 Aug 2023 20:17:10 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qagmd-0001Zz-Nc; Mon, 28 Aug 2023 14:16:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qagma-0001YT-23
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:16:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qagmX-0002Xi-ON
 for qemu-devel@nongnu.org; Mon, 28 Aug 2023 14:16:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693246567;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p7rE36Xu5kFD7ua/KvfZG2rvpsU3e9btKIWca7nJZ+E=;
 b=ewpSokrj9qWApDD6edfG/SOkT8WooITJ5V2RBRc6wL1NNW0b9yYriS6m2OIZa9y/VlGrFM
 el0H9MV6VTA2poUqtHmlNAunFD/7rPQazqoFHHhYkrx3/r+L9nIYc+myrd4UQQYOZADz6i
 6IuYAB7eSmU/2Og4bqXmc3CskaeCLjs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-623-nCiQ23jVNzqTzIXuUwTq5Q-1; Mon, 28 Aug 2023 14:16:06 -0400
X-MC-Unique: nCiQ23jVNzqTzIXuUwTq5Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fe1cdf2024so24483205e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Aug 2023 11:16:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693246565; x=1693851365;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p7rE36Xu5kFD7ua/KvfZG2rvpsU3e9btKIWca7nJZ+E=;
 b=a4zysAK57iU+oROHQIuE2m+j3Um98aogXz13Pko1H0hBhZGI5K9b0AKJcId6lUxzGH
 frScShIRdhcktMkLTqwWx8QEamqaZ/Dibgrsdvrw6ttdH/II7Ai6fxPzlu7rmY/BEfkz
 ZYY1u1JomTWCNIqjsgROkvSA98fHsOAkLlgbLy3nijWxBTaBCb+/4xbEBSyR3kBVm9Pw
 NVjH+gjWjiEySqOhEmLeNPmIfqYOy1cz331I1chhEEt8UfdBKUS6g72BHQ3fQhfFOqaO
 uZ1Ig4jo1W7/V7b95iX8rIYKyZ0+NZQbkAp2m3u14QBPXV+mZ9SNUS8EzDbS3/lhs+5J
 DNFQ==
X-Gm-Message-State: AOJu0Yw+kRGyl6FKv1wWvUoe4jnjnSFh0vFIQz9FRHTNQUgrhAEpt908
 A/+HMoFrf6INlXbwnipNVat+Elu8/ItsE9cgYsxnVIuSwtxHdfUbIX94gfLeQ1GkwDvDgf1lR3l
 z+nUQWwRLoSUQA6M=
X-Received: by 2002:a05:600c:2141:b0:400:57d1:4914 with SMTP id
 v1-20020a05600c214100b0040057d14914mr10909062wml.5.1693246565059; 
 Mon, 28 Aug 2023 11:16:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwDrIo0OFzjEZOkoCNO6A1lPv5ayOVPzvjWHrDW2POBoX1tPYq6VtFYgSRfXrWOx5Z0TXZHg==
X-Received: by 2002:a05:600c:2141:b0:400:57d1:4914 with SMTP id
 v1-20020a05600c214100b0040057d14914mr10909049wml.5.1693246564711; 
 Mon, 28 Aug 2023 11:16:04 -0700 (PDT)
Received: from [192.168.8.103] (tmo-098-91.customers.d1-online.com.
 [80.187.98.91]) by smtp.gmail.com with ESMTPSA id
 13-20020a05600c228d00b003fefd46df47sm14669382wmf.29.2023.08.28.11.16.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Aug 2023 11:16:04 -0700 (PDT)
Message-ID: <24997879-0596-94e0-7f1d-f5eea18fea09@redhat.com>
Date: Mon, 28 Aug 2023 20:16:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] kconfig: Add NVME to s390x machines
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Klaus Jensen <its@irrelevant.dk>, =?UTF-8?Q?C=c3=a9dric_Le_Goater?=
 <clg@redhat.com>, QEMU Trivial <qemu-trivial@nongnu.org>
References: <20230828150148.120031-1-clg@kaod.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230828150148.120031-1-clg@kaod.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -42
X-Spam_score: -4.3
X-Spam_bar: ----
X-Spam_report: (-4.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-2.169, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 28/08/2023 17.01, Cédric Le Goater wrote:
> From: Cédric Le Goater <clg@redhat.com>
> 
> We recently had issues with nvme devices on big endian platforms.
> Include their compilation on s390x to ease tests.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>   hw/nvme/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/nvme/Kconfig b/hw/nvme/Kconfig
> index 8ac90942e55e..cfa2ab0f9d5a 100644
> --- a/hw/nvme/Kconfig
> +++ b/hw/nvme/Kconfig
> @@ -1,4 +1,4 @@
>   config NVME_PCI
>       bool
> -    default y if PCI_DEVICES
> +    default y if PCI_DEVICES || PCIE_DEVICES
>       depends on PCI

hw/nvme/ctrl.c uses INTERFACE_PCIE_DEVICE, so I think looks right to me.

Reviewed-by: Thomas Huth <thuth@redhat.com>


