Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 513D282195E
	for <lists+qemu-devel@lfdr.de>; Tue,  2 Jan 2024 11:03:06 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rKbbS-0004MU-HY; Tue, 02 Jan 2024 05:02:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbbQ-0004MJ-QV
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:02:28 -0500
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rKbbP-0005RS-0L
 for qemu-devel@nongnu.org; Tue, 02 Jan 2024 05:02:28 -0500
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-3368d1c7b23so8080173f8f.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jan 2024 02:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704189744; x=1704794544; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O3zv3DCz8YuDDWauYuEviHrRb1Ea1pjL4v1Gln5GIhI=;
 b=d51h56TcMM4HSXLpLNqcBKO9hwBfOXX8f+UzDMX6pWIrO6dmYEojoy7Kd4sy74gA5V
 BmxPbKBF3YAjeMs04ObfpBmBPZDqhFUJYmMLU4aR7VGTZY+3kw/zRiVBlmLHQi1WVYyV
 h6+3uzoJ2WVUxl9MHazTsuULv9MHTPgg6n1PVW4YI7Q88rOTgl7CvCAYPe9S9EUgmH2j
 bTChnBfWPowaF+Qhs/KS131pYmcpt1+d6PP+JZmJ6c5K+H0IY45XCHG+6nVN9I4MayZs
 ga/rKqyQaaoPA+jDix0IjwDL7a+4HCsBs92HaP3+2hoTqLwmihtTsHjvpXVsLwpqAEAq
 PwbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704189744; x=1704794544;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O3zv3DCz8YuDDWauYuEviHrRb1Ea1pjL4v1Gln5GIhI=;
 b=Uag9GgHTq3uoGr969mpn6aU5HYMk0/urGB8+UFHwB3M2qerJHKjC1zvvE6u7gX5IcV
 uiRmwjXPVBt2FzJVHVS/semKLUbmx5rhWgGpX8kk5B+Hz71gbgtdw9DHRk/dMKEeU1/I
 scxxlLYItskZxxJbcHp38IU6Cnu0yAZxf9++rQvKAtfoHNxGaZmRAadSg02G7ZX1Pn4D
 ZmaW//MnfjB+EtjKZy8ZMz2jdRWLajdY3P8fYqo+JfWhhbS10wwW4/iEoi7ZxuabfgkD
 GkcjEomgW3ugJYPW4OfYBueG/VgFVTjAbRoLGSkAhirYn12oE35Y/eieOqbvLsu9LmfX
 tLCA==
X-Gm-Message-State: AOJu0Yz0S+b6/ZZV2TcbJliDe8Sgh0k5YOmwuK3XFo8wazaqNga0JonX
 REFn3TBz6ux7ROrU+U6d/kxr+J8Ka8LKcQ==
X-Google-Smtp-Source: AGHT+IFQvQm+iNPL8s1oVJ5IHn1pqOWV1aGJNliGWO5LwWtbZPX0Btp8kL5cm62DjyFqUuIf0EFgRw==
X-Received: by 2002:a05:600c:a4b:b0:40d:7822:bf4b with SMTP id
 c11-20020a05600c0a4b00b0040d7822bf4bmr3318972wmq.133.1704189744136; 
 Tue, 02 Jan 2024 02:02:24 -0800 (PST)
Received: from [192.168.69.100] (sal63-h02-176-184-16-71.dsl.sta.abo.bbox.fr.
 [176.184.16.71]) by smtp.gmail.com with ESMTPSA id
 a4-20020adff7c4000000b003366da509ecsm28030822wrq.85.2024.01.02.02.02.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jan 2024 02:02:23 -0800 (PST)
Message-ID: <1302ee65-e7e7-4404-8c4e-b3b36500f9c1@linaro.org>
Date: Tue, 2 Jan 2024 11:02:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] migration: Refactor migration_incoming_setup()
Content-Language: en-US
To: Avihai Horon <avihaih@nvidia.com>, qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Leonardo Bras <leobras@redhat.com>,
 Li Zhijian <lizhijian@fujitsu.com>
References: <20231231093016.14204-1-avihaih@nvidia.com>
 <20231231093016.14204-4-avihaih@nvidia.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231231093016.14204-4-avihaih@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 31/12/23 10:30, Avihai Horon wrote:
> Commit 6720c2b32725 ("migration: check magic value for deciding the
> mapping of channels") extracted the only code that could fail in
> migration_incoming_setup().
> 
> Now migration_incoming_setup() can't fail, so refactor it to return void
> and remove errp parameter.
> 
> Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> ---
>   migration/migration.c | 15 +++------------
>   1 file changed, 3 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


