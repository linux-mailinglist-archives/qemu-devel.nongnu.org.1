Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FF7813915
	for <lists+qemu-devel@lfdr.de>; Thu, 14 Dec 2023 18:51:59 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rDpqt-00086o-FP; Thu, 14 Dec 2023 12:50:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDpqg-0007uo-ED
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:50:16 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rDpqe-0005mf-Km
 for qemu-devel@nongnu.org; Thu, 14 Dec 2023 12:50:14 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1d03bcf27e9so51351585ad.0
 for <qemu-devel@nongnu.org>; Thu, 14 Dec 2023 09:50:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702576207; x=1703181007; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s6KD8LsMZoeYFtHz7aTePhHAJZRXx7LkCTSbIY3dKEI=;
 b=AFR36Y9e44ezXEJvpexKItYBr25XBkBUyq1roaWxLQnaJva8fIH/+2W7Kzl7slrPeN
 GjvdmmsfGppOJM707E8kBAbsPLNMJd33eXvyv6XtruURzi525YypItAKzJnxaKW9W+Ba
 OZTmRVUWGCkYPuW8MYiBgLP2zoacZyALTrAu+Cw0Eha0CnenrCrO9ZqEZXjV1lg9V3yM
 eFpIei4w9jjTCWFQoPBMion07ufTutDYc8ucm8OW12TyXZdIoKV2o4LBg62vxswMaEm3
 S5f/3XRTJIwcfofggkRFFu/Gp5LzDbU28zidQx1k8mDtcdYsVMNiep6Y7oQzOPxzBTCg
 JjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702576207; x=1703181007;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s6KD8LsMZoeYFtHz7aTePhHAJZRXx7LkCTSbIY3dKEI=;
 b=vClT7eEf7Qj8xKnMlEWuHKuJVaY/w46435tdWpBU9lgT/M1dzsfGe0K1h9++FVS4d7
 8d8FATPGDfqZeG1zjZZerR3jsOkuFHal88X6af65Lwp5ThgVWeScO3zwkSLJAfsxd6QH
 FOka4dtud5AVvdf/StfPEwXJVuvEQly+yU+tp68mI7uMTDp5/Zj1BjDlx8yMw1pySMDz
 HxWq9gnfBHW8UZ0gPuRqVWOtBTka50pKdgaYmu9DG7E0XR5YTeVRpd8K7h1/HIBY3XYT
 O2Znr4uhIMBehnKB6JH0K8x6TcQPGb1Tev9iRhZfIHltrxucAYE70vZIG69ysfdBgsj8
 9HZQ==
X-Gm-Message-State: AOJu0YytFl/Ii7uMnWgyseP5BmXMKzRAHCXmBKMk4UaUTDqjz41rGp4E
 mSlSQyXUVhpzrDXTejHO4Ro91w==
X-Google-Smtp-Source: AGHT+IGRW6+OhC3/QV2kj7AfqXgNczuKJgrUYkRWxS74045K5wPXHq/XDXEyzl8xepSu0Z+tgz1egA==
X-Received: by 2002:a17:902:cece:b0:1d3:6c64:8352 with SMTP id
 d14-20020a170902cece00b001d36c648352mr780159plg.29.1702576207252; 
 Thu, 14 Dec 2023 09:50:07 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 a18-20020a170902ecd200b001cfc1b931a9sm12689350plh.249.2023.12.14.09.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Dec 2023 09:50:06 -0800 (PST)
Message-ID: <175531b5-45a7-401f-8e1f-90343fee696e@linaro.org>
Date: Thu, 14 Dec 2023 09:50:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/ppc/spapr_hcall: Remove unused 'exec/exec-all.h'
 included header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Thomas Huth
 <thuth@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20231212113640.30287-1-philmd@linaro.org>
 <20231212113640.30287-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231212113640.30287-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 12/12/23 03:36, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/ppc/spapr_hcall.c | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

