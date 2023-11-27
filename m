Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 683C07F96BD
	for <lists+qemu-devel@lfdr.de>; Mon, 27 Nov 2023 01:16:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7PHf-0001uA-0a; Sun, 26 Nov 2023 19:15:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PHV-0001rc-VB
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:15:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1r7PHU-0007Vk-6k
 for qemu-devel@nongnu.org; Sun, 26 Nov 2023 19:15:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701044108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yRJ5jXl6tck+tu66/ZGulwwqt94sxCAUwTAfJhhAslE=;
 b=URJ3gt4HTvgjUQZBRIe5q3MC8234xlfWtQ6XIrjlaoXyPC8mV3DT4HX7E3/mf1dS6w1Naj
 SjuTyETZPtDDgAIetsFU7tezZpTBrbNWPVVlZtA/wxlIH4L0PG69KHdn5IPFPoH5AYHcdD
 O2pKJthbInMWtggfHCcU2tlO88BykT8=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-186-Mv3kbRMWP6mLJ9BI8uzxVQ-1; Sun, 26 Nov 2023 19:15:06 -0500
X-MC-Unique: Mv3kbRMWP6mLJ9BI8uzxVQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 d2e1a72fcca58-6cbe0378d0eso5203520b3a.3
 for <qemu-devel@nongnu.org>; Sun, 26 Nov 2023 16:15:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701044105; x=1701648905;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yRJ5jXl6tck+tu66/ZGulwwqt94sxCAUwTAfJhhAslE=;
 b=oZ1bq8lZ725mW/zU1U2/QHUesvrSWD1eyCCf+kWm0keF2+msy8MYGnnQS2efiDNWXY
 sNvahHR5WYe4iC6Zgdb+wvIugS8mBPMif5bDTu+BaZeYGpIgfCWSxLHNAXkvvr6kWjS4
 Lv+nULekF3dB341t4RD8TFt7tA09yJG2ieSGfUe03RWJdJ6sPMGSSq1OjCEVTkVUHjum
 CzBlmpdAGyA3R9TetRpZJPASg0NCnhOuKPlwA7WGKX4fvlL+V4hiV+ZakGpEKTjVHrv3
 QCKZ1GKLU6E+XzN8zXnE70Z2iuPPaLZgUU9v/FMn/YGuXgWWqu4oZqZX1b5zDoTZS+wx
 2k5A==
X-Gm-Message-State: AOJu0Yyont0lnd7/KDH4Ol02Em9pHUef2yB+RB/2VwOr1KrwU9W+bQZt
 KPsdzuZ0S0TnSfT6OqBdS+3Zh/mlcPKl3+nndfWd+FNH3YdD1LdwOL/vuhgFhsg9A9HdGR/UwAO
 HjeElzSsusZmgtEQ=
X-Received: by 2002:a05:6a00:99e:b0:6c5:e1f:184a with SMTP id
 u30-20020a056a00099e00b006c50e1f184amr13206778pfg.28.1701044105395; 
 Sun, 26 Nov 2023 16:15:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEpQU83B7vga1Hz+qEsaINkcsVlECW664IED6uqyEvr8AT10+GRlP3BIRNDDbrayuX8SzEzNw==
X-Received: by 2002:a05:6a00:99e:b0:6c5:e1f:184a with SMTP id
 u30-20020a056a00099e00b006c50e1f184amr13206764pfg.28.1701044105132; 
 Sun, 26 Nov 2023 16:15:05 -0800 (PST)
Received: from [192.168.68.51] ([43.252.115.3])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a056a00098c00b006cd88728572sm1292054pfg.211.2023.11.26.16.15.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 26 Nov 2023 16:15:04 -0800 (PST)
Message-ID: <4857dd95-e152-49f2-8ccc-05179767d28f@redhat.com>
Date: Mon, 27 Nov 2023 11:14:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/21] target/arm/kvm: Merge kvm64.c into kvm.c
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20231123044219.896776-1-richard.henderson@linaro.org>
 <20231123044219.896776-15-richard.henderson@linaro.org>
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <20231123044219.896776-15-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 11/23/23 15:42, Richard Henderson wrote:
> Since kvm32.c was removed, there is no need to keep them separate.
> This will allow more symbols to be unexported.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/kvm.c       | 789 +++++++++++++++++++++++++++++++++++++++
>   target/arm/kvm64.c     | 820 -----------------------------------------
>   target/arm/meson.build |   2 +-
>   3 files changed, 790 insertions(+), 821 deletions(-)
>   delete mode 100644 target/arm/kvm64.c
> 

With Phil's comments addressed:

Reviewed-by: Gavin Shan <gshan@redhat.com>


