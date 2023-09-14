Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 963177A0BD0
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Sep 2023 19:32:57 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qgqBi-0002Hi-2t; Thu, 14 Sep 2023 13:31:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgqBf-00029D-QC
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:31:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qgqBe-0004QL-59
 for qemu-devel@nongnu.org; Thu, 14 Sep 2023 13:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1694712689;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kTW8aR86BoxPOwZjyTLOpCBjNAwfZ5GYFXnl8yX3mbE=;
 b=NZEVoo+9bwsGAIf4C6B8XcwVwz0e5hC41k8rAo5zsU9xvPzYaykkEkhYcHNSivpFDCizuH
 KCm1YdqmX+Id5O4gSurJVr2EezDM6UcjaTkyYZuViWxOToYEH4/SaHRPIQWqy2ets0pZZK
 XZU7OMdtq2UuuOCfqb+cP/o2NTOiV1E=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-hjyqeT6qNgaSSkXJ2k0Cvg-1; Thu, 14 Sep 2023 13:31:27 -0400
X-MC-Unique: hjyqeT6qNgaSSkXJ2k0Cvg-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4020645b2a2so9535995e9.2
 for <qemu-devel@nongnu.org>; Thu, 14 Sep 2023 10:31:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694712686; x=1695317486;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kTW8aR86BoxPOwZjyTLOpCBjNAwfZ5GYFXnl8yX3mbE=;
 b=MaHz6zOcVMTpbPVweBecp89hJp8CXvgP1pOM/S3fAZu/LS3qGMD7SBpW2rQYa6Le9a
 iWoeWdazX+Mftr9U3jgfRyzs9zU9vfq87tXEpwE+gIL10nOVarPQXOwoIKo/R0wyKT+5
 ITN9TwiTPUFnlE+dxr3k1JFy0h8/p9Im5UfnEZN7QFomAHZjPxM2Bi0LpbwypFNMizmE
 izyVxTgcmzAQDRCV3MwPx5fUI69lJ2OSaY3WmUDFT/Bway9DqKviieRomXnSkqWtMWg3
 9Q+P1k/n19nOf88OoS2wvAcnsjIKsFZZf7e+PZsyIDO+fxlgOvTG4lil6SdXi4vY2/rz
 beQQ==
X-Gm-Message-State: AOJu0Yz/0Fz77w7FNG+RGYfRGArI+EmNO4ZUHo5JA8NAQL+UlNayWGCY
 MdPFh2S80UxkgRZjJZ2vHNQYGnCGgUi95HplQfgnHZ4pWEMzc5LgLDpd3hyTXXiZKV3jjG09Ya4
 jDVY4eJXv/gWwPTM=
X-Received: by 2002:a1c:7c08:0:b0:3fd:2e89:31bd with SMTP id
 x8-20020a1c7c08000000b003fd2e8931bdmr5543890wmc.14.1694712686275; 
 Thu, 14 Sep 2023 10:31:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEE0Kjh3nNz0qlZy/ewVKymViqLD4eevr7GQayMo94TJcpm8y42XSyA4JPR5zSOmsYcamAGGA==
X-Received: by 2002:a1c:7c08:0:b0:3fd:2e89:31bd with SMTP id
 x8-20020a1c7c08000000b003fd2e8931bdmr5543880wmc.14.1694712685978; 
 Thu, 14 Sep 2023 10:31:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89?
 ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
 by smtp.googlemail.com with ESMTPSA id
 y19-20020a05600c20d300b003feeb082a9fsm2516225wmm.3.2023.09.14.10.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Sep 2023 10:31:25 -0700 (PDT)
Message-ID: <c4dc2292-4690-f16f-4b70-d6f759c16633@redhat.com>
Date: Thu, 14 Sep 2023 19:31:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PULL 4/5] hw/ufs: Support for UFS logical unit
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Jeuk Kim <jeuk20.kim@samsung.com>, Hanna Reitz <hreitz@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, qemu-block@nongnu.org,
 Kevin Wolf <kwolf@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Fam Zheng <fam@euphon.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>
References: <20230907181628.1594401-1-stefanha@redhat.com>
 <20230907181628.1594401-5-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20230907181628.1594401-5-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.473, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On 9/7/23 20:16, Stefan Hajnoczi wrote:
> From: Jeuk Kim<jeuk20.kim@samsung.com>
> 
> This commit adds support for ufs logical unit.
> The LU handles processing for the SCSI command,
> unit descriptor query request.
> 
> This commit enables the UFS device to process
> IO requests.
> 
> Signed-off-by: Jeuk Kim<jeuk20.kim@samsung.com>
> Reviewed-by: Stefan Hajnoczi<stefanha@redhat.com>
> Message-id:beacc504376ab6a14b1a3830bb3c69382cf6aebc.1693980783.git.jeuk20.kim@gmail.com
> Signed-off-by: Stefan Hajnoczi<stefanha@redhat.com>
> ---

Jeuk,

can you explain the differences between scsi-hd and ufs-lu, apart from 
the different bus type?  Ideally, the UFS controller would be in 
hw/scsi/ufs.c and there would be no need for ufs-lu at all.

Would it make sense to allow any SCSI device into a UFS bus without the 
need to have duplicate code?

Thanks!

Paolo


