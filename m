Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5466D7EBABE
	for <lists+qemu-devel@lfdr.de>; Wed, 15 Nov 2023 02:00:19 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r34Fd-00025C-Ja; Tue, 14 Nov 2023 19:59:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34Fa-00024w-OU
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:59:26 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r34FY-0004VP-ON
 for qemu-devel@nongnu.org; Tue, 14 Nov 2023 19:59:26 -0500
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1cc3216b2a1so49233215ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Nov 2023 16:59:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700009963; x=1700614763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FV3rRVZ2yEwbZWoGAQ8+VFpOeOGtIJFAcaP+rvzI0NM=;
 b=bz53TL9oY05OL4nyJLBGXwcNgByUL6fuuu+qmW2wALUNDRZUCE5qSWIlxY5f5fA0tF
 yEf9avI4XPqeIqz3e4xRC2u91khdcMm+WoLITSchhA7HJ2wACq6J+1+5w6QbVvBKVYQ/
 yo9eweLO3oegLxtEM96xalP6z3cWHmJrgeSKdB51QNHWiQFr1LT8BdBqWZmw23ArT9dX
 eu0AJRgHcaWX7uzS/frKoILx0W9w6Z92uqFUqtq6SMY01WdDWrUq/yTOWf973S+1OrLO
 XAXLVMj74TbSTi06Ftf9ac5whqfDcivUSZjpNnNMxNY/umXRx3t6IMr8dzt6bms+8o/I
 qZPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700009963; x=1700614763;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FV3rRVZ2yEwbZWoGAQ8+VFpOeOGtIJFAcaP+rvzI0NM=;
 b=O8isOtdILjH6fhuZRHUcRIdgCkuEFGXiY6jaEJ8FY44ZhcN3S1exQcy1CuI1wOB+2/
 ++djNY+vVq0/D/X1qt29yQI3lOwXSTtNLK2qVGjCVZkFaY1MqXEn8haL+ArMzpZJ3cym
 ctfrqcrcuxAhrvi4h/wMWRI9vhJxq78qGPyuDlTvgX0qghhNI5OYrlyanBxdOCpWNJcg
 E1G3qpV17uxUaHvvyOUwmzZ+mwrUT/MqSwSrbF7fafKlJE4VyeDAn0sarOl4n5lQuKvf
 4eA5sg9rF+1CEWGpfe4rx2hr6OatpwSTChMJAAyTBsz1Hc55ttxspahmvk7b01wcTd1k
 Hsuw==
X-Gm-Message-State: AOJu0YzJHzAYn3SeVGu0YiKgep61/Mal1VpMG+h0chxUfhQynyWghuYX
 CkVbZzltWUZOlCAB/6Xs5pgo7ClTPz20k0I8Eo4=
X-Google-Smtp-Source: AGHT+IGDfjFH0ozmyGRRzOJzfqN9OP4LofuPIpFwSrzTMWgFyg6WFISLcCXE0fGE1im8+UyH9mBdDA==
X-Received: by 2002:a17:902:e809:b0:1cc:25b7:e30d with SMTP id
 u9-20020a170902e80900b001cc25b7e30dmr4206984plg.60.1700009963207; 
 Tue, 14 Nov 2023 16:59:23 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 j18-20020a170902759200b001c0ce518e98sm6279922pll.224.2023.11.14.16.59.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Nov 2023 16:59:22 -0800 (PST)
Message-ID: <d438ccf9-f48c-4dec-a826-077aa544f38a@linaro.org>
Date: Tue, 14 Nov 2023 16:59:21 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/31] target/loongarch: Use generic cpu_list()
Content-Language: en-US
To: Gavin Shan <gshan@redhat.com>
Cc: qemu-devel@nongnu.org
References: <20231114235628.534334-1-gshan@redhat.com>
 <20231114235628.534334-14-gshan@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231114235628.534334-14-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 11/14/23 15:56, Gavin Shan wrote:
> Before it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
> la132-loongarch-cpu
> la464-loongarch-cpu
> max-loongarch-cpu
> 
> After it's applied:
> 
> [gshan@gshan q]$ ./build/qemu-system-loongarch64 -cpu ?
> Available CPUs:
>    la132
>    la464
>    max
> 
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   target/loongarch/cpu.c | 15 ---------------
>   target/loongarch/cpu.h |  4 ----
>   2 files changed, 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

