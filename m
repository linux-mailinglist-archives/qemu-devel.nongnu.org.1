Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B5678D62E
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 15:36:36 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbLM0-0002B2-GM; Wed, 30 Aug 2023 09:35:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbLLy-0002AL-QM
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:35:26 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qbLLw-0006B7-Hw
 for qemu-devel@nongnu.org; Wed, 30 Aug 2023 09:35:26 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b962535808so86031941fa.0
 for <qemu-devel@nongnu.org>; Wed, 30 Aug 2023 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693402521; x=1694007321; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1U7ju8XFKPycKDCQ/yxIgMKNKlhb7Jdzn8K53dVCr6U=;
 b=EeQHoqrb73/J9RaFZE1bVt0K0TR52+8fjVJPyvPhr3iTzOcV94mKoyx7Gqx7TtKfTU
 HSfJ0phm3MPklOhtvfE4nwxqa4blLv2D0E43ror/6I0VlOCTU7GZeaPwf9WjrYG5La5q
 OWFr+gFxqTfwRT9SqjmK1PF7/4Q5tcI/9UTOfk+PlgjOQHLfsAiVvL6cd1/cuWD9ANBQ
 2laE06a2E1TUOKVIOJ5P4SWxCADa7FRMGbk7XHUe6vboDv8trhexwzXLX1rpV9UgSxff
 WBXm/exxDrca4uYTQPilzCJqtQ9SEpmeHD+7suqfS3h+sCDnzbFe6IcfjnAiC0yI1+Hv
 ewdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693402521; x=1694007321;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1U7ju8XFKPycKDCQ/yxIgMKNKlhb7Jdzn8K53dVCr6U=;
 b=C24h+1+UQ8SSfqXDpmSHkdOEUwi2GaIAJelNArIKMnls+AXXW+YTBpZutMWg53hpTb
 HMDsku5wOgExDXLLO4KkHhafV3FVmwXp/VK9xmgGyFNza5xOhL5iLTWjCO2HhtTgBx+R
 +BOnLIak2oxi0y0pKUzbENSOf+qyML/tOqdZOpWGQmNK1QB8a/st5uUJaitSeWGfhwqt
 npQA6fSLJYIsjDbVByBEZKpStawVhRuG5AkhUtavCHpPDpjFGlNww6xhmw8j8ieJkEDy
 GP8gDlge3b7oAX2WBjBpuQL++sBzMXJOsrvh3HSdQLDiP/wbCDdqAy2dnR+F8q1KJUN/
 4Xkw==
X-Gm-Message-State: AOJu0Yy3sA62lfyOqif00wTKHCMp88JuCCMIcaGPJhqnrNIHlcRV/8yM
 FuetaB717J3hP/ckMiegqHeLE73upAOjvcPFvQpsUFDk
X-Google-Smtp-Source: AGHT+IGrbwOO/ccWbbXJhGPovBEFbN+CxIVaSzg39OJu40gQvlMrg0UJrl9BsfdjKdALjuQQLi4XAQ==
X-Received: by 2002:a05:651c:10cf:b0:2bb:b56b:f67e with SMTP id
 l15-20020a05651c10cf00b002bbb56bf67emr1891805ljn.19.1693402519963; 
 Wed, 30 Aug 2023 06:35:19 -0700 (PDT)
Received: from [192.168.69.115] ([176.176.142.89])
 by smtp.gmail.com with ESMTPSA id
 v17-20020a17090606d100b0098669cc16b2sm7122416ejb.83.2023.08.30.06.35.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Aug 2023 06:35:19 -0700 (PDT)
Message-ID: <ad508b5a-6cff-7138-1350-62a5bc513299@linaro.org>
Date: Wed, 30 Aug 2023 15:35:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH v3 0/6] hw/virtio: Build vhost-vdpa.o once for all targets
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20230710094931.84402-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230710094931.84402-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x232.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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
Errors-To: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org
Sender: qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org

Hi Michael,

This series is now fully reviewed.

On 10/7/23 11:49, Philippe Mathieu-Daudé wrote:
> Missing review: patch #4
> 
> Since v2:
> - Added R-b tags
> - Addressed Richard's review comment: page_mask = -page_size
> 
> Philippe Mathieu-Daudé (6):
>    hw/virtio: Propagate page_mask to
>      vhost_vdpa_listener_skipped_section()
>    hw/virtio: Propagate page_mask to vhost_vdpa_section_end()
>    hw/virtio/vhost-vdpa: Inline TARGET_PAGE_ALIGN() macro
>    hw/virtio/vhost-vdpa: Use target-agnostic qemu_target_page_mask()
>    hw/virtio: Build vhost-vdpa.o once
>    hw/virtio/meson: Rename softmmu_virtio_ss[] -> system_virtio_ss[]
> 
>   hw/virtio/vhost-vdpa.c | 36 +++++++++++++++++++++---------------
>   hw/virtio/meson.build  | 25 +++++++++++++------------
>   2 files changed, 34 insertions(+), 27 deletions(-)
> 


