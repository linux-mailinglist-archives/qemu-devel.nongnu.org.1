Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D81E381E81F
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 16:41:21 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI9Wu-0002PX-RU; Tue, 26 Dec 2023 10:39:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9Ws-0002PF-TC
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:39:38 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI9Wq-0001DB-Bd
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 10:39:38 -0500
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-40d5aefcc2fso4229665e9.0
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 07:39:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703605174; x=1704209974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mv3usI1oZYXHqHKRguWQGNokM6pPpcPITlS7hYttots=;
 b=Y4XhpV2jpkhIVvorvt7bNUCLhbJCJwBu9W9IMdWoFS0RxaooQF4xUyYeOhfVOQpmeM
 dWkzlhZNeiaJOAM0pYqbanExfXp8lrD7nS5V7osUEo6U9YdPqSUNLq2lRl4pgA9LoEJx
 VJGKBac+EtuBmuQtlU7e+oxm98z41ylvKg+XaJ4lKleJSM3Y/WLq6pW2StjFemPICdB/
 8D38FUfE7V67JscccR8eCFDS8AbkXWTFFcrpRtkM6aJ1E4v7uaG0MiNhBZR/Z4J4N0/R
 3q1lu5VQUU5DItbDUXTcpTabrCrQlw6nSjnhG1ucPVpswNgqrPwXsPz754Wg4NxCzD5A
 e0Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703605174; x=1704209974;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mv3usI1oZYXHqHKRguWQGNokM6pPpcPITlS7hYttots=;
 b=k82/16OiEWB4zraOMO0SC6QYU+PIiCryj7+aS/V+8tnAHn6EuiUtjPkOv+ylcrv9Wj
 2IERqAWYhC8h4r/UR+AEvoks/I8Bcu5ODTvmwgOqs2rAjG/fPNRJrYfjCckCdwzC0pKo
 Ks7JWPffpe7Krakw9AzrJvpvLZSrp57KP1usgI9U4Bx6YfGc08/F107++CtXK8EBnNg2
 /oxg78or3w480T1IeF0c8FrG4eVeaEifypNsYUGvguwV3lFsG7J/eNFDgMiVcZYahxnB
 fMThdSIQ0vAPMwX8TEJbLxb1w7rQ3j4ynjGO5rypsHg5E2so28eKWycac8eDS+gVTmow
 oEtQ==
X-Gm-Message-State: AOJu0Yx7jXYdgbda72CqXlXmU1e2B2Lbm/7RcdXT37B+WDNaqfvsll9+
 X6rDxA6m90K/AKKH1fEvSRr1LNM0B8n4V2R5eGKdylV930A=
X-Google-Smtp-Source: AGHT+IEyDDHpxjGz79sT1/+ljs1fL42QOaz3uO3Fmlsm9L14bqGE0vAnuK8GC9oUFEhXCk1Hwhzl6g==
X-Received: by 2002:a05:600c:2195:b0:40d:30c0:dda4 with SMTP id
 e21-20020a05600c219500b0040d30c0dda4mr3947731wme.150.1703605174282; 
 Tue, 26 Dec 2023 07:39:34 -0800 (PST)
Received: from [192.168.111.175] (97.red-95-127-47.staticip.rima-tde.net.
 [95.127.47.97]) by smtp.gmail.com with ESMTPSA id
 j16-20020a05600c191000b0040c11fbe581sm21164634wmq.27.2023.12.26.07.39.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 07:39:33 -0800 (PST)
Message-ID: <a349160a-0f78-4947-9473-db2c28092277@linaro.org>
Date: Tue, 26 Dec 2023 16:39:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/7] Trivial patches for 2023-12-25
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org
References: <20231225081007.78141-1-mjt@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231225081007.78141-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

Hi,

On 25/12/23 09:10, Michael Tokarev wrote:

> ----------------------------------------------------------------
> trivial patches for 2023-12-25

> ----------------------------------------------------------------
> Akihiko Odaki (2):
>        qemu-options: Unify the help entries for cocoa
>        qemu-options: Tell more for -display cocoa
> 
> Elen Avan (1):
>        include/ui/rect.h: fix qemu_rect_init() mis-assignment
> 
> Jai Arora (1):
>        accel/kvm: Turn DPRINTF macro use into tracepoints
> 
> Natanael Copa (1):
>        target/riscv/kvm: do not use non-portable strerrorname_np()
> 
> Samuel Tardieu (1):
>        docs/tools/qemu-img.rst: fix typo (sumarizes)
> 
> Stefan Weil via (1):
>        virtio-blk: Fix potential nullpointer read access in virtio_blk_data_plane_destroy

This last patch has as author:

From: Stefan Weil via <qemu-trivial@nongnu.org>


