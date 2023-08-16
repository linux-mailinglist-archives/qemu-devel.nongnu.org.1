Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F5877E515
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 17:25:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWIO3-0004PP-3l; Wed, 16 Aug 2023 11:24:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWINz-0004PB-JF
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:24:39 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qWINx-0000hj-Gt
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 11:24:39 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-68706b39c4cso4852355b3a.2
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 08:24:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692199475; x=1692804275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=53VuhtWzxZLtzA1+G/NGtigHujlW7r8YdLSnHm2Mvx8=;
 b=uDjSSFP0Z0jmbZJZoTeVns3WJL3MsfCWh3qNiEmGQOgMFMMt91c2c4KlktX6ujEQ63
 4iSpTGD3ZMHEbtfH9Wlg3mnImJ6SjoNm4pNpOxUWUfytxAmfYYAYhzy0iaTCa3IOb6/1
 CcczPs4HQoX8ETKdMRPNnecT6tAVHFmDW7hEhTr/fAdWghJ114xHI1pzgql/Y+TIl/Gy
 jQdRiIDjq8Om6mYLcJYe8IykcJ5P1yIybyE6JlQCx+GcF8cWVJ+Vz5QQPxSyi5dOxe3B
 38lO/RKW+ecTLSe9nmGEQDnsIqC1e2kPC5DLN8CYCJU56X1O9dVlzH3b1LqPUzL8p3mo
 oylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692199475; x=1692804275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=53VuhtWzxZLtzA1+G/NGtigHujlW7r8YdLSnHm2Mvx8=;
 b=WJ9n3HnX1/4NOQPqe5KYgy+d6K3lBsk1KxQ1/tCIspShboeE0aXyhNtKr/KIn4KYP6
 gBua7ay5oKmiMZ54EsuZqeLxM9BInzpMOwxeotRGbrPBT1PXgItH/hr43s5lX8oqtUcp
 0uTfX0mpQVtc4jTyf2wCsQwm5WG5ohFPn5JIgK2sq3wE1TDKSNotZeYU8fmFFwG0Ee3w
 2cGmS44RBTeUNbCaJzjvPtDqvCzTCofGcCAsTzUW0Xjp7ue5Q7DCRaoFJPi3KJ7WzzC4
 U535WcfJg8WJBexsZVvm8gIVti+p0zgyqBYIRriW9fEOXvIVmvb2Q4tU6QZflNRIqsrk
 rVFw==
X-Gm-Message-State: AOJu0YxAeKppaB8ahIW1qjNF1bcx1gsyrDHBTAMA9WKz0YDsXSNJZcwD
 OGBSvL4qImmdBBidB5zMr4ee6w==
X-Google-Smtp-Source: AGHT+IEtUiBf54B+f0jKT+RCcY2e8J+7od6W+R27looH/wYpoNSymHpjrXJWTfA6fvif3QgTM/HjRw==
X-Received: by 2002:a05:6a20:13cf:b0:13f:9dbc:e530 with SMTP id
 ho15-20020a056a2013cf00b0013f9dbce530mr2108188pzc.8.1692199475447; 
 Wed, 16 Aug 2023 08:24:35 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:a064:e3f9:a812:973b?
 ([2602:47:d483:7301:a064:e3f9:a812:973b])
 by smtp.gmail.com with ESMTPSA id
 f5-20020aa78b05000000b00682c1db7551sm11115194pfd.49.2023.08.16.08.24.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Aug 2023 08:24:34 -0700 (PDT)
Message-ID: <18da7040-3e81-3f9e-b970-be2fc0dd4b50@linaro.org>
Date: Wed, 16 Aug 2023 08:24:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 01/25] contrib/plugins: Use GRWLock in execlog
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: qemu-devel <qemu-devel@nongnu.org>
References: <20230816145155.21049-1-akihiko.odaki@daynix.com>
 <20230816145155.21049-2-akihiko.odaki@daynix.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230816145155.21049-2-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.165,
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

On 8/16/23 07:51, Akihiko Odaki wrote:
>   static void expand_last_exec(int cpu_index)
>   {
> -    g_mutex_lock(&expand_array_lock);
> +    g_rw_lock_writer_unlock(&expand_array_lock);

lock, not unlock.


r~

