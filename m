Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F70F7D8FA8
	for <lists+qemu-devel@lfdr.de>; Fri, 27 Oct 2023 09:23:03 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qwHB1-00061p-Bd; Fri, 27 Oct 2023 03:22:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHAq-0005wZ-UJ; Fri, 27 Oct 2023 03:22:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <xadimgnik@gmail.com>)
 id 1qwHAc-0003ME-RR; Fri, 27 Oct 2023 03:22:24 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-40907b82ab9so16648015e9.1; 
 Fri, 27 Oct 2023 00:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1698391331; x=1698996131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=PqXLD4gsUSCQcm/bEiQQT7bGyjP9upwq2OK6iOIPglM=;
 b=KSO3I/DufhTcP2GwgYSyaeWJ0nEZaXr6GHlalBBpiv+qAFgW390au6qX/S6jqDwmwp
 sa1K2gD9L841s96ySAEnyxMeOMdVR/xEzHAdrU3mK1/wDSzt2kq1h406DVGAYXeeN6cj
 UJNIkEQDrzYa4T62L3tLITRvFjkhFDHCt7pzu9zXVL1+VTcseC9dUDAA9OpLbzUIeyV8
 Y+/FG6PkymhF+GJNzoQ+58RixgA4U6BO2CWcDlGBBWMzAQTfmGoBvBNLBr+H7I0755c/
 ft+zmjVDK7SP33vwSxe5Vexk7oC32MKd8zZRzOQHVEdQrKUgs8bRI+twZMCiBzq4t2vf
 AnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698391331; x=1698996131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PqXLD4gsUSCQcm/bEiQQT7bGyjP9upwq2OK6iOIPglM=;
 b=m6PSOFIAI3hPZx2fJI5u7puLEFZsjfOnRXp38Y7NUo1iKa0n3+/SuyPa4aIb2WhPpH
 DmN4ZNvkHTMGusVaH40a2NGStrHgVUbmstXaPam0ccHkIeXTizzxVGCKV+arOoQGfZSZ
 NrfBEyf3r7kXPJSIvNJTSf0z+PXwAxplQUwAKVfgpjwRKMdfykurmVcEYfls1djWitVD
 tpuQCcrUqmHo/hP7N7J351PMXLjPCC0IZz0YOzJmkMoarFD3A2g79oDqyj9zpoPT7J4g
 75pC00MdhOAThp2N3v6Wlk8MBKJdnhScCJMmf9gdJ2s/YWHSdLSi4uxAag7q6FItMChk
 VaTg==
X-Gm-Message-State: AOJu0YxGBU1mF7gULmgYKxkkfLAvTwSNHyukpoEMjXf4RFESozpoC+BX
 NwoAXwUoSR24vvmT2eUl1Xk=
X-Google-Smtp-Source: AGHT+IGU6tTMgK6RwsBlq8F1RDINHIo2QB0XP1KOkIfo88Tr96dL8LD0Q31Rr4FqnFe7pGXkQLUMWQ==
X-Received: by 2002:a05:600c:2d8c:b0:408:33ba:569a with SMTP id
 i12-20020a05600c2d8c00b0040833ba569amr6011223wmg.8.1698391330510; 
 Fri, 27 Oct 2023 00:22:10 -0700 (PDT)
Received: from [192.168.10.177] (54-240-197-235.amazon.com. [54.240.197.235])
 by smtp.gmail.com with ESMTPSA id
 d16-20020adfef90000000b0032326908972sm1126352wro.17.2023.10.27.00.22.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Oct 2023 00:22:10 -0700 (PDT)
Message-ID: <ae99776d-bf6a-4b24-b617-fde8c76d087d@gmail.com>
Date: Fri, 27 Oct 2023 08:22:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/28] hw/xen: use correct default protocol for
 xen-block on x86
Content-Language: en-US
To: David Woodhouse <dwmw2@infradead.org>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony Perard <anthony.perard@citrix.com>, Paul Durrant <paul@xen.org>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Jason Wang <jasowang@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
 Bernhard Beschow <shentey@gmail.com>, Joel Upham <jupham125@gmail.com>
References: <20231025145042.627381-1-dwmw2@infradead.org>
 <20231025145042.627381-8-dwmw2@infradead.org>
From: "Durrant, Paul" <xadimgnik@gmail.com>
In-Reply-To: <20231025145042.627381-8-dwmw2@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=xadimgnik@gmail.com; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Reply-To: paul@xen.org
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

On 25/10/2023 15:50, David Woodhouse wrote:
> From: David Woodhouse <dwmw@amazon.co.uk>
> 
> Even on x86_64 the default protocol is the x86-32 one if the guest doesn't
> specifically ask for x86-64.
> 
> Fixes: b6af8926fb85 ("xen: add implementations of xen-block connect and disconnect functions...")
> Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
> ---
>   hw/block/xen-block.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 

Reviewed-by: Paul Durrant <paul@xen.org>


