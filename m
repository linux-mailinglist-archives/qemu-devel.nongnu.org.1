Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D0828706F18
	for <lists+qemu-devel@lfdr.de>; Wed, 17 May 2023 19:12:16 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzKgs-0003i9-2g; Wed, 17 May 2023 13:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzKgp-0003hX-Di
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:11:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1pzKgn-0005b7-SG
 for qemu-devel@nongnu.org; Wed, 17 May 2023 13:11:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684343509;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfzrbZiPy11LudaEU0g7LcaDYrj91Opf744F/X5Xjqs=;
 b=Y4IVfxgSJ019qp7wpaYf19wdaviQrBVjYN6ZDoj5SL8du6yOpydU/3lE2GSp3rC9gqidGm
 YSDUMFO8rrWQtT7xvzr/b0IafSOnAM5BYKw3i2gFhGm2v2LsD9qVThs4gJqRBH8dM8WEJq
 5lZHfFbq2Hf6WLSfC9ErwSM1OZiWtjQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-RmR4zsynPxGIL8xa8SPe0w-1; Wed, 17 May 2023 13:11:47 -0400
X-MC-Unique: RmR4zsynPxGIL8xa8SPe0w-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-94a34a0b75eso113159466b.1
 for <qemu-devel@nongnu.org>; Wed, 17 May 2023 10:11:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684343506; x=1686935506;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OfzrbZiPy11LudaEU0g7LcaDYrj91Opf744F/X5Xjqs=;
 b=ZruwtqsahdYNj7LzhjvBG/z7BLe9uGsQLUjPHMBWYLY9Wqh/sGv2UuNGcbi2USr/i8
 97Jxgn+xOI6itvzVSz0ChzKpnvvUIJ3MpSFVrNTk6DtZLU6Hx+dApkFVY8Rl8rclU//t
 3R0ckUuuYrEJPZzyasPhnQ17atcf21K3/zb3V2h5ustGHIUbaYAYpbaPtAv3T/pzTSGR
 EkcRJdYwWhYGMqDn+bFneBwROm3SltLLJf7PhIiEhgoZrh32ElgnZPMoBQxjI59JLAfc
 5zA4Tgl/C2plorw2TRSH4ruPebUuYJBG2OwTUU6p79ZyA1LJhS++VYoXW3MiRA4SvalG
 rRCw==
X-Gm-Message-State: AC+VfDyij4eAR8rV8Z8d+b5OXvf7ru8EFw7JG7PMbedyLk4nhAF5LuHJ
 OpPOWlU2vFGEmof4hHC/hUZT0PSEa4MW2nGZyneWXt6LiXhb5R4XHc9BrSXJOGieQqcyACkc3EJ
 0zwC10AkG7dT401E=
X-Received: by 2002:a17:907:6d9b:b0:96a:316f:8abf with SMTP id
 sb27-20020a1709076d9b00b0096a316f8abfmr26576046ejc.20.1684343506612; 
 Wed, 17 May 2023 10:11:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5N4VE+2alIacnmdqGImGn79Hc1vadyXfkP4Dm/Bg7u01Og0L/u0+bgehCdGpG5NDRkl5/pWQ==
X-Received: by 2002:a17:907:6d9b:b0:96a:316f:8abf with SMTP id
 sb27-20020a1709076d9b00b0096a316f8abfmr26576018ejc.20.1684343506281; 
 Wed, 17 May 2023 10:11:46 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 kn3-20020a1709079b0300b0096a27dbb5b2sm10431368ejc.209.2023.05.17.10.11.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 May 2023 10:11:45 -0700 (PDT)
Message-ID: <65fd93e7-c4fc-0686-d795-d542617d94af@redhat.com>
Date: Wed, 17 May 2023 19:11:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v8.0.1 00/36] Patch Round-up for stable 8.0.1, freeze on
 2023-05-27
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-stable@nongnu.org
Cc: qemu-devel@nongnu.org, Michael Roth <michael.roth@amd.com>
References: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230517073442.3622973-0-mjt@msgid.tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.412, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 5/17/23 10:00, Michael Tokarev wrote:
> Hi everyone,
> 
> The following new patches are queued for QEMU stable v8.0.1:
> 
>    https://gitlab.com/qemu-project/qemu/-/commits/staging-8.0
> 
> Patch freeze is 2023-05-27, and the release is planned for 2023-06-29:
> 
>    https://wiki.qemu.org/Planning/8.0
> 
> Please respond here or CCqemu-stable@nongnu.org  on any additional patches
> you think should (or shouldn't) be included in the release.
> 
> I'd like to include a few more changes in 8.0.1 release, for example
> https://lore.kernel.org/all/20230301142926.18686-1-yuval.shaia.ml@gmail.com/
> "hw/pvrdma: Protect against buggy or malicious guest driver", and especially
> https://lore.kernel.org/all/20230503002701.854329-1-leobras@redhat.com/
> "hw/pci: Disable PCI_ERR_UNCOR_MASK register for machine type < 8.0"
> and a few others, but we can wait forever.  I pinged patches which seems
> like should be in -stable.

I'll send several more in a pull request tomorrow.

Paolo


