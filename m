Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 896BC7F9697
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 00:40:44 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7OjW-0005Tn-KQ; Sun, 26 Nov 2023 18:40:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7OjJ-0005Sx-3b
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:40:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7OjH-0001oo-MM
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 18:40:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701041997;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gZKIbTYTvGr8CbY02R6jzJ0PLUSPv4EjopwHDZ4KPP4=;
 b=SL98oEFGWx1YBoOOage4HfG/VCl3Jl6Q+KQCcVdYQE5I0yfXIlD5CDtTUDnKpOSFVBugoo
 tOgN9gcYJIrS4b6VYewng4OE3u/468RnBQoqJcsYvX9C/NbkiwQ82jdQTABED6h3+LTd+g
 HSre4kXq7md9YAB7QW6f1XRcNRV9qHk=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-361-1rjEKaqHO0CUBezfsGYEDA-1; Sun, 26 Nov 2023 18:39:55 -0500
X-MC-Unique: 1rjEKaqHO0CUBezfsGYEDA-1
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2859fe4461aso1756216a91.1
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 15:39:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701041994; x=1701646794;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gZKIbTYTvGr8CbY02R6jzJ0PLUSPv4EjopwHDZ4KPP4=;
 b=G7wN8DSugMGOxHmiD5cK0oAWRqMzwAl0THrCd/L1P/OF4KEqSGed25KGJT0yscdAw9
 DLZWt5XqEpKhrC8CldlcHnf90ytLR0cGJriqRASxrPDvpNv6+opYWHLvZ/3dAxIdKuN6
 Fs9Y9BQEpTjJHT1kHlWBugNziM/RL/kdg7WqyYl4cDPE71YIBAwnIF0BLjosWmk4e4E7
 54rggGxmx1e0fqCDWVYknGcRfgYH4HqNmDBvRqaDmjhR7Tk5mAZ8YZyvsrwVphhZdVcM
 MSbolGGw8G+ZFlPz1J1a5V8SbORiaVyYfW788ntH0w/E6fuHuMbIvwe1JnYRGPEpsrpD
 szpw==
X-Gm-Message-State: AOJu0YzORXvoV0nGLmmJlZoPGwJHzMdOqRSvw1GbSK13xQ9i/cfrALKc
 /ML0cMKx/jidiajNp3QCmQSpB/69Dt0wtw7Lu+TJFAz3G1kDBO1fpXVheW0pNus4Hh8AUoV+siw
 xglApqRmo4RG1nBQaUY3ZRBE=
X-Received: by 2002:a17:90b:3b51:b0:285:b906:a3d3 with SMTP id
 ot17-20020a17090b3b5100b00285b906a3d3mr2467067pjb.2.1701041994556; 
 Sun, 26 Nov 2023 15:39:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9BIvD0b5RBvIZ5wEz1J1bXMxEWNCQUxeEnodkul7ZEA38kIFctWDDsERftONq5Q4+WcPOKQ==
X-Received: by 2002:a17:90b:3b51:b0:285:b906:a3d3 with SMTP id
 ot17-20020a17090b3b5100b00285b906a3d3mr2467058pjb.2.1701041994234; 
 Sun, 26 Nov 2023 15:39:54 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 k24-20020a170902ba9800b001cfd049528esm428805pls.110.2023.11.26.15.39.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 15:39:53 -0800 (PST)
Message-ID: <24373ab9-f5ee-4acb-b9f9-a281b857dd9e@redhat.com>
Date: Mon, 27 Nov 2023 10:39:50 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] target/arm: kvm64: remove a redundant
 KVM_CAP_SET_GUEST_DEBUG probe
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Chao Du <duchao@eswincomputing.com>
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-3-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-3-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 11/23/23 15:42, Richard Henderson wrote:
> From: Chao Du <duchao@eswincomputing.com>
> 
> The KVM_CAP_SET_GUEST_DEBUG is probed during kvm_init().
> gdbserver will fail to start if the CAP is not supported.
> So no need to make another probe here, like other targets.
> 
> Signed-off-by: Chao Du <duchao@eswincomputing.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-Id: <20231025070726.22689-1-duchao@eswincomputing.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm64.c | 28 +++++++---------------------
>   1 file changed, 7 insertions(+), 21 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


