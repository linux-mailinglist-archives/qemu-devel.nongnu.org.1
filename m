Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6928B70E964
	for <lists+qemu-devel@lfdr.de>; Wed, 24 May 2023 01:14:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1bC2-0005Yv-P4; Tue, 23 May 2023 19:13:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bC1-0005Yl-2G
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:13:25 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q1bBz-0005Ww-4R
 for qemu-devel@nongnu.org; Tue, 23 May 2023 19:13:24 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1ae6dce19f7so1825625ad.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 16:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684883600; x=1687475600;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v5ZMY7v+hEy6f6hz7e5KCwcqGgSFUM8FoccxMWbb6pw=;
 b=ZaG5NtHgXOIauuIcN3bR+QQXf3+q93z27g20NpqRo4Bq03cXuAVU2zJlnXJrdTyajt
 P34UEJA75D8WNM42s48pgH4yO+Ht+C4bGLrfjrQazybnk6jDQarWsoFYguMMRjXq/R9Y
 iMd5xIjtODkzza8XPiP7R9ugQzvYvNRMJT9Bibk6PCYioUSaTnp9ShoCon+mILxHS0TU
 wcqKjFgzCMenw5XdXRUwzPTgE6bDFMq3gq+HhNfhmA+vzGkpX+STPmm6xWokfLCHQIPy
 Dupkcjo22lq7XhFXVBwKNe3iEMeU8sxmg2WFCzSFiRzy0CR2zmfYZIHnBy80OFlEUojJ
 vi6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684883600; x=1687475600;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v5ZMY7v+hEy6f6hz7e5KCwcqGgSFUM8FoccxMWbb6pw=;
 b=i+PWy+BKMLAHqFsv9pvMtIa8pDFY9/Ev6bFDPQVpclImK0s9vgvbPAmMBCtWbllFdg
 ETRSCR3vGiILvdY6mrUHqPAc2m8W+wPSLEgawY47CIFFAmMUoXglYdhkzSoGunmPXPE2
 fuDZVt35kTU0a2+c/dfD4/e9V2MM2DUkdamhtGanZdHcTFZph6CkwxZCD3ha5TVZgXED
 sAw5JIVcJhXqcwZjaUJeN4YM7vzEdfngOtxQVe6Aubf6JiyeMuEnN33K1UdNrUBsOo6C
 lDYGseyzXiXGdpYJnMI0pseRHWaZrT5I8DBamKNAwKLgafdmSwq6MtJOLB3iYfwAloK2
 NXHQ==
X-Gm-Message-State: AC+VfDxseLI78h91TC5bwxmvVK/cfrKp7lTW8iaZLRrSyUcL2U3sXz4N
 dmWYekSdH66PpN/IgmmLq4PEnQ==
X-Google-Smtp-Source: ACHHUZ54eQUkQ/lXcQWGi9PzuTFKolblKnSAjnrG6xBvpvJnEXdTjcOwg4uyUZsp3CisPhuJDlPwoQ==
X-Received: by 2002:a17:902:e541:b0:1ac:2f98:e94d with SMTP id
 n1-20020a170902e54100b001ac2f98e94dmr18104365plf.67.1684883599871; 
 Tue, 23 May 2023 16:13:19 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:c13a:d73:4f88:3654?
 ([2602:ae:1598:4c01:c13a:d73:4f88:3654])
 by smtp.gmail.com with ESMTPSA id
 u5-20020a17090341c500b001aae909cfbbsm7296558ple.119.2023.05.23.16.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 May 2023 16:13:19 -0700 (PDT)
Message-ID: <468ad917-112e-7f5f-91b5-91e93d8d918f@linaro.org>
Date: Tue, 23 May 2023 16:13:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 02/11] hw/scsi: Introduce VHOST_SCSI_COMMON symbol in
 Kconfig
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20230523163600.83391-1-philmd@linaro.org>
 <20230523163600.83391-3-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230523163600.83391-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.089,
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

On 5/23/23 09:35, Philippe Mathieu-Daudé wrote:
> Instead of adding 'vhost-scsi-common.c' twice (for VHOST_SCSI and
> VHOST_USER_SCSI), have it depend on VHOST_SCSI_COMMON, selected by
> both symbols.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/scsi/Kconfig     | 6 ++++++
>   hw/scsi/meson.build | 6 ++++--
>   2 files changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

