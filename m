Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0117618B7
	for <lists+qemu-devel@lfdr.de>; Tue, 25 Jul 2023 14:48:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qOHRe-0007el-Fv; Tue, 25 Jul 2023 08:47:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOHRb-0007c1-JI
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:47:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1qOHRY-00059c-JP
 for qemu-devel@nongnu.org; Tue, 25 Jul 2023 08:47:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690289230;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=sBEuv0tCJc8eX/yOWjLEnalpSx9cpWx5eKvD+ap8VqU=;
 b=B7PqaKPE05+7MjJkpjXUczoKSAQXHBa4bLE6AqzyvxxBJkep2xdVu1MySk5RpEbf6nQsXC
 iWc5D/46G2mOmdJWWFdnzkJt6g8u41yCix3sOl/7+6aFL4ECLYB6W+u/0PVgKiyYMqJRSU
 PpJXLwYON58x6VtOHMuRCk/H/VEpAv0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-Sn7_AXDzN9O9YbZ0dWiAxA-1; Tue, 25 Jul 2023 08:47:09 -0400
X-MC-Unique: Sn7_AXDzN9O9YbZ0dWiAxA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-315a03cae87so3076750f8f.0
 for <qemu-devel@nongnu.org>; Tue, 25 Jul 2023 05:47:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690289228; x=1690894028;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sBEuv0tCJc8eX/yOWjLEnalpSx9cpWx5eKvD+ap8VqU=;
 b=Zx64qFHsCKK4AZ8rSPOi1Aa1VmSH74nS7zy54ZdFIftAYAQu/IXSWdu/BJT2Rr89pL
 APScW+ol4h1ErLtE4v6s/j2GrTpXJQHOCKLJIeTw/qCBiqM5c4p2ub0qJzJnknhEUfZS
 IfspE6VebL2e/Jaqg491KaP5Safhm3TlwvJffia97Vw762kvtzrsI/2aUYpN8AcvLIEx
 CRrkxrWehTMQXnhNT+iNCv4lyRnPk46iIK0KE+VxHKCD/ED5BUgovRVeAigVm8beX3Mn
 p0ORu80eB7+pPvg/UrA4F18pTjyDCRQUv8oV8d+iY1cQ7UaTCA6CNTL6JxIyabb/0zwX
 Lc4g==
X-Gm-Message-State: ABy/qLbhcq0C4n+cVrshHRzMaH7jMBrysG9ApSCdDFY6EQ4iI/cGSQsZ
 eVs5AyMBP18+1rXx43gOAxwKcIE1hkwilOjNHKpt8FZ6nsgU36d1D+2siAOO3rGlPQwkxWPe5Zo
 7pwzhsKDuVdntQ8g=
X-Received: by 2002:a05:6000:180d:b0:317:5cfb:44c7 with SMTP id
 m13-20020a056000180d00b003175cfb44c7mr2171613wrh.30.1690289228485; 
 Tue, 25 Jul 2023 05:47:08 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGws8+iJA5HUpqpH8sJjGYyiFtDyrmgt+CEXjGtjovyt3xTI1TY9JR2KSaiv+5w65EYPrya9A==
X-Received: by 2002:a05:6000:180d:b0:317:5cfb:44c7 with SMTP id
 m13-20020a056000180d00b003175cfb44c7mr2171593wrh.30.1690289228225; 
 Tue, 25 Jul 2023 05:47:08 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-177-31.web.vodafone.de.
 [109.43.177.31]) by smtp.gmail.com with ESMTPSA id
 f12-20020a7bcc0c000000b003fc0062f0f8sm13346012wmh.9.2023.07.25.05.47.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jul 2023 05:47:07 -0700 (PDT)
Message-ID: <c6c1e1da-f5f1-1535-9b9d-88278c050cb9@redhat.com>
Date: Tue, 25 Jul 2023 14:47:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2] kvm: Remove KVM_CREATE_IRQCHIP support assumption
Content-Language: en-US
To: Andrew Jones <ajones@ventanamicro.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, mtosatti@redhat.com, peter.maydell@linaro.org,
 pasic@linux.ibm.com, borntraeger@linux.ibm.com, dbarboza@ventanamicro.com,
 kvm@vger.kernel.org, qemu-arm@nongnu.org, qemu-s390x@nongnu.org
References: <20230725122601.424738-2-ajones@ventanamicro.com>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230725122601.424738-2-ajones@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.091, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
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

On 25/07/2023 14.26, Andrew Jones wrote:
> Since Linux commit 00f918f61c56 ("RISC-V: KVM: Skeletal in-kernel AIA
> irqchip support") checking KVM_CAP_IRQCHIP returns non-zero when the
> RISC-V platform has AIA. The cap indicates KVM supports at least one
> of the following ioctls:
> 
>    KVM_CREATE_IRQCHIP
>    KVM_IRQ_LINE
>    KVM_GET_IRQCHIP
>    KVM_SET_IRQCHIP
>    KVM_GET_LAPIC
>    KVM_SET_LAPIC
> 
> but the cap doesn't imply that KVM must support any of those ioctls
> in particular. However, QEMU was assuming the KVM_CREATE_IRQCHIP
> ioctl was supported. Stop making that assumption by introducing a
> KVM parameter that each architecture which supports KVM_CREATE_IRQCHIP
> sets. Adding parameters isn't awesome, but given how the
> KVM_CAP_IRQCHIP isn't very helpful on its own, we don't have a lot of
> options.
> 
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>
> ---
> 
> While this fixes booting guests on riscv KVM with AIA it's unlikely
> to get merged before the QEMU support for KVM AIA[1] lands, which
> would also fix the issue. I think this patch is still worth considering
> though since QEMU's assumption is wrong.
> 
> [1] https://lore.kernel.org/all/20230714084429.22349-1-yongxuan.wang@sifive.com/
> 
> v2:
>    - Move the s390x code to an s390x file. [Thomas]
>    - Drop the KVM_CAP_IRQCHIP check from the top of kvm_irqchip_create(),
>      as it's no longer necessary.

Looks good now!

Reviewed-by: Thomas Huth <thuth@redhat.com>



