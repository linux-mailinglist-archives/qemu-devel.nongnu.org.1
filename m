Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB137F96C3
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:19:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PL0-0003Vd-1f; Sun, 26 Nov 2023 19:18:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PKx-0003VK-7W
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:18:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PKv-0007tB-9P
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:18:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mSPeFLpaQnJGAbfUyNrOGS8HpyRBaanIHxk7Frt78Zc=;
 b=AJ/11+VwhJQK4aOYDH/7gA76939e8GuDZjtsl3RvG1ZQZrwOUbkVGZCLMmYt2hyEZUvrP8
 70pCqNSVUx9QOjV/8z0NDV9NWgkbM2XNCx92wsP4m/xotTOuMnEmESpxZnJTnbEJluwbwp
 vYxp9MANUjHhScCn+ouER4PorSI6YAs=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-DXlsV8jtPK2737yzcyjX2Q-1; Sun, 26 Nov 2023 19:18:48 -0500
X-MC-Unique: DXlsV8jtPK2737yzcyjX2Q-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2859d0d09a3so2620699a91.0
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:18:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044327; x=1701649127;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mSPeFLpaQnJGAbfUyNrOGS8HpyRBaanIHxk7Frt78Zc=;
 b=DFlbsLPEHpItKxXIEJCi70E/QYejscLymBhjSg5+cAxYKMXPhtTqA3+QNQOE4OytAB
 K1CDZPWQGoqIp3ZPGDnOZ5Ncczk8fCUCAlcr/5QXPf/RXTL8YuYx8tZpJ8KapB0vdtYN
 fXocmSorbf+jBGONQcP0UWwV9D9qTKo9IlLW5YxWG1UqL6R4aDpXGQEpa3/XVEfjZ/rd
 j85Lkd8QGrP1dspnd4aKw9To3XjjnTEqhYZKv4X7/KHs1qlC/JD4rKaurUe0LwzGY6mT
 fbFgvlSn91JtZIuhjjK4gxhErnbPWxzExGWFcuI+9X7c2L/K0QTMsp3jfrG5KmEgEXFF
 KDFA==
X-Gm-Message-State: AOJu0YwPeWns1z488yQmQiCrxu/T86n2V7ab3hMwh+w/arquWey9hnZ2
 L+bPKM45xxFwGPoGGCHpUjCQifgO1qKNSmxe/D7gGyLuzgz3ZEZh8rJFq02ktDFtng++JvSWqOZ
 qnPaoJbhhjWuPuQQ=
X-Received: by 2002:a05:6a20:5491:b0:18a:b5c3:55c1 with SMTP id
 i17-20020a056a20549100b0018ab5c355c1mr10932610pzk.57.1701044327747; 
 Sun, 26 Nov 2023 16:18:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHJyVTiGmAv5fBHK9z4SMWOu9Lat+4w20ldrM65TQq8993phossPNRN/aSibsLpZUGkjpNeqQ==
X-Received: by 2002:a05:6a20:5491:b0:18a:b5c3:55c1 with SMTP id
 i17-20020a056a20549100b0018ab5c355c1mr10932592pzk.57.1701044327467; 
 Sun, 26 Nov 2023 16:18:47 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 ik3-20020a170902ab0300b001cfc67d46efsm1386073plb.191.2023.11.26.16.18.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:18:47 -0800 (PST)
Message-ID: <da053a93-f43e-4991-bc68-1246496f7161@redhat.com>
Date: Mon, 27 Nov 2023 11:18:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/21] target/arm/kvm: Unexport kvm_arm_vcpu_finalize
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-17-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-17-richard.henderson@linaro.org>
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
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm_arm.h | 14 --------------
>   target/arm/kvm.c     | 14 +++++++++++++-
>   2 files changed, 13 insertions(+), 15 deletions(-)
> 

Reviewed-by: Gavin Shan <gshan@redhat.com>


