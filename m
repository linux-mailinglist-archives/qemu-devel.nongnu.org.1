Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ADBB74934C
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 03:50:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHE6c-0006VP-Fq; Wed, 05 Jul 2023 21:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qHE6Z-0006Tr-NM
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 21:48:23 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1qHE6X-0003fP-Uk
 for qemu-devel@nongnu.org; Wed, 05 Jul 2023 21:48:23 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1b89114266dso577615ad.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jul 2023 18:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20221208.gappssmtp.com; s=20221208; t=1688608097; x=1691200097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gU70VpfM87e6ULqNKG/vpSviy8zys685M/LeGPSsD6U=;
 b=ah9EittjefdUK1kvrLONZeA217ZVm/7BOuvXSl587jgWrO5kNyzvZ3q6dvuqSGWU5Q
 9DnyS5yWu3P6Ouq0jm23by4dSNv2NroEK+enZgII5cu2rYOkrQ2o6dKjmb4ZC3VvxhlX
 KxHUkUz2g2mrnicuQ28LcFzsEeFoGbV1BzG7tpnUm3H/FCt9d6rnuXGMm2zUgyKmfn+5
 R3OvY1epgsa4Kp2bSUWhY0WHqjYntNB7nUEC4mqMYO0nsJEL6nc4+UpccyH150jT9t0x
 mFoFFR4fnBFriSxPS8Y9e1uoJoIW3E9SLdh2BEpONuwkf26rJlJSVZTzRtvK4//0/Dnf
 aFXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688608097; x=1691200097;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gU70VpfM87e6ULqNKG/vpSviy8zys685M/LeGPSsD6U=;
 b=ftMshsAlyUKjqKQScPUteXl4iTB3cKrqawQa1C0nxsy6Zw3iP+d9xG1+jsXcxfrAT/
 xN5TO3+kES0L8uyNVrUmBQmVAgj3tuKjjpe8ufgcNaCcCpnj5NcQu9quY1B/NGS/pOfJ
 0tpCInRjGNjgnK5IWc1tHCZAvMKxkvQ19b+pZ1PDnl4SOI515WAu+Ac0noiuP8zyMwZZ
 RwBh71Y1KpcVGVWPZ4h64ooa4magvF6/mnUKZHjGIUzUWZbwIdbX0C9/Jmgg75rk7Msp
 ZbPz1WDzPQpbtbBQRxak2x9CjFLKSGWaooGNGKIQaNL9h8uc16XdrY9u1hbKggO9hypp
 yeQw==
X-Gm-Message-State: ABy/qLas6F6NR+GYcr5P4wJCj69NXhH5sNYOi4CvSFaoVLfPAi1onby5
 I0S4a+sMGHQqiePuTYwx40tZLw==
X-Google-Smtp-Source: APBJJlGQFQ4iXmMXmy49gfYSDzMcgHg/dieyhESF7+LSBA4YqNGlNyTvXHpSEJg2QXEOH6OJP58opA==
X-Received: by 2002:a17:902:b186:b0:1b8:adc:7c3d with SMTP id
 s6-20020a170902b18600b001b80adc7c3dmr701917plr.40.1688608096739; 
 Wed, 05 Jul 2023 18:48:16 -0700 (PDT)
Received: from ?IPV6:2400:4050:a840:1e00:78d2:b862:10a7:d486?
 ([2400:4050:a840:1e00:78d2:b862:10a7:d486])
 by smtp.gmail.com with ESMTPSA id
 w14-20020a170902e88e00b001b858a5affasm118812plg.162.2023.07.05.18.48.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jul 2023 18:48:16 -0700 (PDT)
Message-ID: <cc5fce4f-ef17-4a92-ec20-d24aca64e0a6@daynix.com>
Date: Thu, 6 Jul 2023 10:48:13 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v8 5/6] hw/pci: warn when PCIe device is plugged into
 non-zero slot of downstream port
To: Ani Sinha <anisinha@redhat.com>, qemu-devel@nongnu.org,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Cc: jusual@redhat.com, imammedo@redhat.com
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-6-anisinha@redhat.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20230705115925.5339-6-anisinha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: none client-ip=2607:f8b0:4864:20::631;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x631.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001,
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

On 2023/07/05 20:59, Ani Sinha wrote:
> PCIe downstream ports only have a single device 0, so PCI Express devices can
> only be plugged into slot 0 on a PCIe port. Add a warning to let users know
> when the invalid configuration is used. We may enforce this more strongly later
> once we get more clarity on whether we are introducing a bad regression for
> users currently using the wrong configuration.
> 
> The change has been tested to not break or alter behaviors of ARI capable
> devices by instantiating seven vfs on an emulated igb device (the maximum
> number of vfs the igb device supports). The vfs are instantiated correctly
> and are seen to have non-zero device/slot numbers in the conventional PCI BDF
> representation.
> 
> CC: jusual@redhat.com
> CC: imammedo@redhat.com
> CC: mst@redhat.com
> CC: akihiko.odaki@daynix.com
> 
> Resolves: https://bugzilla.redhat.com/show_bug.cgi?id=2128929
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> Reviewed-by: Julia Suvorova <jusual@redhat.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

