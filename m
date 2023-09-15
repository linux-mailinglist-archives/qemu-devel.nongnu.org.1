Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A297A2448
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 19:07:56 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhCI4-0005IB-45; Fri, 15 Sep 2023 13:07:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCI1-0005G2-Hs
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:07:33 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qhCHz-0001aJ-Of
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 13:07:33 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-9ada6b0649fso315600066b.1
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 10:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694797650; x=1695402450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XbqSdXH1MoJlTITE7WSI6E/OHMbYZ0n+B+DEnDta5Gg=;
 b=giHpuzpyufvhOqlRsHzC5zFBofXRJXxObqG9aGIn3H3SrQWhFrCPcXfz8bVyOQRGHA
 wbpn/BpbM0OCCey8wc0l97nxaYALW14vjqCfjEL/geDeQTZdNGNHQqkD17eQ5GwG+kNW
 NUseENNvHUAz0RtjtZZ+trFG2CEDKUbBwOJhRRf0S/BJXAXTJZZJAcEzSSo1ARpV/bGc
 nJubhd3Z4AbBVAvah/9lhR8PVBXkJkpqJaQ5gSKB8qSN2RQ95oXq2DMIVJJB4fzMc2i1
 gjim1Zl7tMFRIENLzDMvivnQlEATynUuBFG00URRwfaGhLdAlCVZPimxdCfxP5hISFzd
 HRGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694797650; x=1695402450;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XbqSdXH1MoJlTITE7WSI6E/OHMbYZ0n+B+DEnDta5Gg=;
 b=iLWBpSx8k6RdJvCVa7NKHCwlf4e/TmS9xXF7UoV/MafE2gHiEFW1XqBsDfiSqIjpBg
 ogZMkdDnc8TlXw2MeVRS9j2dhgwbNzdRFQa2dCH5q9vgRf46MbhQTRvQVfSfm36DlHmM
 8H63CV12X4oiz9zORTbtR0JqP0dixp0dhdRiSMKe3NY4Y5bfaVkT50hmXmlnvpMXmXTz
 liEL0AvFEdGKBXQsU/GzW58OcSdD837iHcOtuY/ICw/qQWBw2o0GGnmw6DlkNOSMXWuN
 efsHE6N+ve48f0zJpILxBzlWL1GrZ/40WFVjandTN8kNubyu6/Te+D9dZR2Fec4K7lvu
 YWLQ==
X-Gm-Message-State: AOJu0Yw+TPeWEBOqM5OaxF2RM6oPoW0vkLvpwOI/RIs7FYax2QhbgN0T
 NN41/qvd7/lLp0PnShyoo3qORw==
X-Google-Smtp-Source: AGHT+IHKHPMbyG8LaYxgPp8S/QIojwaDdksanLzU+ridBHRGT3E2ZW1aql2oUcXX4eSqGh0AZeqvMA==
X-Received: by 2002:a17:906:20ce:b0:9a5:d48f:c906 with SMTP id
 c14-20020a17090620ce00b009a5d48fc906mr2427148ejc.15.1694797650258; 
 Fri, 15 Sep 2023 10:07:30 -0700 (PDT)
Received: from [192.168.69.115]
 (6lp61-h01-176-171-209-234.dsl.sta.abo.bbox.fr. [176.171.209.234])
 by smtp.gmail.com with ESMTPSA id
 x8-20020a170906298800b009ad778a68c5sm2663096eje.60.2023.09.15.10.07.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 10:07:29 -0700 (PDT)
Message-ID: <e9585e42-5750-bf32-500d-9b4f1d3ff4b8@linaro.org>
Date: Fri, 15 Sep 2023 19:07:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH 2/3] vdpa net: stop probing if cannot set features
Content-Language: en-US
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Hawkins Jiawei
 <yin31149@gmail.com>, si-wei.liu@oracle.com, Jason Wang
 <jasowang@redhat.com>, Lei Yang <leiyang@redhat.com>
References: <20230915170322.3076956-1-eperezma@redhat.com>
 <20230915170322.3076956-3-eperezma@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230915170322.3076956-3-eperezma@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62e.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 15/9/23 19:03, Eugenio Pérez wrote:
> Otherwise it continues the CVQ isolation probing.
> 

Fixes: 152128d646 ("vdpa: move CVQ isolation check to net_init_vhost_vdpa")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
> ---
>   net/vhost-vdpa.c | 1 +
>   1 file changed, 1 insertion(+)


