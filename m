Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 407E282D821
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 12:10:05 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPKqi-0007ii-OU; Mon, 15 Jan 2024 06:09:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKqg-0007iH-2k
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:09:46 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rPKqe-0006Fj-C8
 for qemu-devel@nongnu.org; Mon, 15 Jan 2024 06:09:45 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-559737bac29so36472a12.1
 for <qemu-devel@nongnu.org>; Mon, 15 Jan 2024 03:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705316982; x=1705921782; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xqod7xxMWcZdpg2R+S3wQU2fQ9+Cx5wKb7Yfr85NHpc=;
 b=zkzfddZIU0Ilk4P1EchX0Tu1GWkfMTa1Em+cxhRgCk/E+34onh6nvt03kTZTdDwAvQ
 raRaWga+3yXwnt3qYglic0yFaHssxQaTHK6MQ77epVQENFKXovNz10q9hSjrBGma48te
 8JhgY/6gOvmJf4IU633CZqEwKRwFcliPkcGbEIg9vSSVJai2blb2DLfr0qeCh7SMIU3O
 mxPlYCYQ5GK92c1cINRqRoaEjP2bqL+i8segO0KI4Z72dlF/sKIJ2cTUdOvZv4tJL9xQ
 CM4id2FgMb1xBvoY2nFpgt8ZyiwvrOzfpehYyx54r/PS28kx7prWhWXd+qlcH561xxE6
 tFmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705316982; x=1705921782;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xqod7xxMWcZdpg2R+S3wQU2fQ9+Cx5wKb7Yfr85NHpc=;
 b=X/fB3yuf5K9N5dvdLqjSBzFl+mF4ns+TgbKjsUt1XOj0pA2AH9Vf4OOcaL96UIQVQB
 a+g5RbN8W62VE8xXGmAyjUs/gJiQHsWedgaz6Kif5H6ig0KBdxEbC6xkqLoZiFHbpEDa
 W6rAbIKEerWnIVV5mUQgjeVTfSOpQAyeZVjc7N3WfVMB8GpkaQ9KUjz1l7IXLQD6uZke
 dAwWDG1kukcdAIu7SQVT3NOK8xzaWxCme90jKB/HX4zwYluHjXR51mZ46ORWF5XUAsjt
 RDneQXfRGP6URYRhif66gfK/EF9GVdlzPRbVCKVnEShq/AYfcaFGDCpzZigutlxYZ90s
 toCw==
X-Gm-Message-State: AOJu0YydTz+FhipMs+AywEuDKd7jQ0EtYO/vHo20OoP5Rp/zhItXeI7E
 SBqeLNd6WiuABahHjZaY6iFs1QpemhjXPQ==
X-Google-Smtp-Source: AGHT+IF5uqY6YanTaXQzFSMWJ+RyW8D1dw4zeQRN6A3WJ8mnBD7apf6V2q6fVvh/9Ukd+8R6PVNzgw==
X-Received: by 2002:a05:6402:1ca7:b0:557:7f96:1d12 with SMTP id
 cz7-20020a0564021ca700b005577f961d12mr2241616edb.44.1705316982725; 
 Mon, 15 Jan 2024 03:09:42 -0800 (PST)
Received: from [192.168.1.102] ([176.187.209.30])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a056402414e00b00557535489adsm5378573eda.37.2024.01.15.03.09.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jan 2024 03:09:42 -0800 (PST)
Message-ID: <c48dc7a4-c59d-43e7-8d14-62a20a4cc785@linaro.org>
Date: Mon, 15 Jan 2024 12:09:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/11] MAINTAINERS: Update hw/core/cpu.c entry
Content-Language: en-US
To: Zhao Liu <zhao1.liu@linux.intel.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>
References: <20240115094852.3597165-1-zhao1.liu@linux.intel.com>
 <20240115094852.3597165-2-zhao1.liu@linux.intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240115094852.3597165-2-zhao1.liu@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x532.google.com
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

On 15/1/24 10:48, Zhao Liu wrote:
> From: Zhao Liu <zhao1.liu@intel.com>
> 
> The hw/core/cpu.c was split as hw/core/cpu-common.c and
> hw/core/cpu-sysemu.c in the commit df4fd7d5c8a3 ("cpu: Split as
> cpu-common / cpu-sysemu").
> 
> Update the related entry.
> 
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   MAINTAINERS | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Oops, thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



