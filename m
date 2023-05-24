Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BD49570F490
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 12:50:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1m32-0004ZY-IM; Wed, 24 May 2023 06:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1m30-0004Xh-7q
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1q1m2x-0005KA-MR
 for qemu-devel@nongnu.org; Wed, 24 May 2023 06:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684925320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X15Mf24DkIGVaX1jnOTT/tlssYH8biTu4oGf/QpgFNA=;
 b=cMwwj1I1Xl+rHLkLiKVM/5GF7EUFQvO7vkkZEY2ND9lBX6WITwkM7T7a6KZGkxVGw/ndtW
 J1vr+kYhxqQ1pJkPXwrFJIcfFpUZo89swuSBJSuvFAW6oHHKDzEg7NgdQItTg2IxKAQpaQ
 H+7H3kuHyw2uPZ/Nkj0q5qBxrbrBE28=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-PkLXhSQwPHKBhNRX5-kscg-1; Wed, 24 May 2023 06:48:38 -0400
X-MC-Unique: PkLXhSQwPHKBhNRX5-kscg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f50aa22cd2so5113285e9.1
 for <qemu-devel@nongnu.org>; Wed, 24 May 2023 03:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684925317; x=1687517317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=X15Mf24DkIGVaX1jnOTT/tlssYH8biTu4oGf/QpgFNA=;
 b=k7kNJ+gxN/hQ1zX8pgAnrjeQhhPwBxKPmynC0kuWZIvgiL7vkNqhIvlNctem66Q//4
 Bk60k6eScmRma1Xq/zp+93cCkScmmbw1SiEfvZNw2X2B7bClE2vzNQX+a+QOqDHt2+UE
 GAsByel8o1CtGigI1aeE4Bbqtau9IcQfgXaK58c7ioGErFKoUfy3TPyGvDbue+0zm5kt
 V1jxPoANF8uQu6idGRV0iJ7LNIerSuHQyaaoLw89sOgw12XZaHrAC//OcSdK4GCUWsrq
 U/NwRbT4l190QMeuC2seFkmTU3ZlPYo944/cFr7k6TgTtVWLmnxvMvZtJpGK2bUZtQWD
 Il8w==
X-Gm-Message-State: AC+VfDyCvcs7jOAGPuNVyRXU9YBbHGireb8lpZ+ubcNQvjxsNUbsd6oC
 w0I1P+UJgazasSp1ZZ5Thg5sxCBg4piw0gPmwexgeHNpcJMpZh3YnZ1v5Kb7QYNO0CUQICtKWZU
 G5DUWih8bBsSqJY0=
X-Received: by 2002:a05:600c:ad2:b0:3f6:d2:d8c0 with SMTP id
 c18-20020a05600c0ad200b003f600d2d8c0mr9367742wmr.19.1684925317659; 
 Wed, 24 May 2023 03:48:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7WMPPn2BtinfxHo6IMua8QEfKBaJ7CTVvZxTaSIPrWxruwM3c/Px6oUAn7YfCWfPauNzn52Q==
X-Received: by 2002:a05:600c:ad2:b0:3f6:d2:d8c0 with SMTP id
 c18-20020a05600c0ad200b003f600d2d8c0mr9367722wmr.19.1684925317388; 
 Wed, 24 May 2023 03:48:37 -0700 (PDT)
Received: from [192.168.0.3] (ip-109-43-176-64.web.vodafone.de.
 [109.43.176.64]) by smtp.gmail.com with ESMTPSA id
 b21-20020a05600c4e1500b003f4283f5c1bsm7127605wmq.2.2023.05.24.03.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 May 2023 03:48:36 -0700 (PDT)
Message-ID: <933facc7-d6e8-0b6d-d115-a0777bb82a4e@redhat.com>
Date: Wed, 24 May 2023 12:48:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 2/5] Add Bochs to list of vga_interfaces
Content-Language: en-US
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20230524102729.810892-1-marcin.juszkiewicz@linaro.org>
 <20230524102729.810892-3-marcin.juszkiewicz@linaro.org>
From: Thomas Huth <thuth@redhat.com>
In-Reply-To: <20230524102729.810892-3-marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-0.089, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 24/05/2023 12.27, Marcin Juszkiewicz wrote:
> arm/sbsa-ref uses Bochs-display graphics card and without it being
> present in vga_interfaces "-vga none" argument handling cannot be added.
> 
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
> ---
>   include/sysemu/sysemu.h | 2 +-
>   softmmu/vl.c            | 6 ++++++
>   2 files changed, 7 insertions(+), 1 deletion(-)

Sorry for not noticing it earlier ... but while you're at it, please also 
add an entry for VGA_BOCHS to pci_vga_init(), so that other machines could 
benefit from this automatically, too.

  Thomas



