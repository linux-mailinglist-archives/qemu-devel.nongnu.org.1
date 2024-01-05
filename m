Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 04748825C4C
	for <lists+qemu-devel@lfdr.de>; Fri,  5 Jan 2024 23:00:07 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rLsDe-0008Hq-IS; Fri, 05 Jan 2024 16:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLsDc-0008HQ-BJ
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 16:59:08 -0500
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rLsDa-0003Nu-QF
 for qemu-devel@nongnu.org; Fri, 05 Jan 2024 16:59:08 -0500
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-50e741123acso18687e87.0
 for <qemu-devel@nongnu.org>; Fri, 05 Jan 2024 13:59:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704491945; x=1705096745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=I9vsxN6mOsRFQtS2KehWZO3St/3z9ERBRFRWJPDQsVI=;
 b=spiyabBpPbDbz29iJtL/doGavDXAbjJbAprxo2bLcLVvhQdCaMupt7uRgrmfn8nF4p
 fw9T4PlPuJkTIkmiiHu0BKH639zHlzx9Z+/Lnsoa0OjrS2ykvhRcGuB/C1vtZM/oITF/
 Z2Xwxze8BenBlG65NnATwC2vkDs8HBaddEKQIm55oxwm9eXX4A+JOUFtepyw0tQPA78d
 Z9AFwHEplvPgAHvvIFMZSv9shlNnmHmXx+g1Crz4FUgZ2JFqGEPmPZr1mjALIpYnyGv4
 AXlH//OeXpXrn5uAKlMsl9C2nRm1ZRsVUO1Uk8077QoIgprHDjIhxHgQdLg15aEfEp5I
 2RpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704491945; x=1705096745;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=I9vsxN6mOsRFQtS2KehWZO3St/3z9ERBRFRWJPDQsVI=;
 b=SCLx6TBLoJbVLTSy98y9vtDxaw/e/2xdehcm7ng8AAYEMo2rA86yjG3CvrBNP038Ql
 W4Pm5HqtBgGc8yjqW+xFlz/bkMZj1DVgmj+u5i4SoOhifds4drdIIl9deT5gmWZHF4+l
 6Cs5ijA6p75ZkGrScSRfHGhLU3fC6DJjSYko6L8MfplaWTVGfxdd0DpvJ80UdqvaoWpk
 f9ebjbko3JGieBeQzA9Pq4tVtl11u4F83+yuENuxi3ZhFw6UMhztK2XssG6WknNMaHNE
 VF0VnqckD3/NExgeT96GzPw2weYUyu+yICynUNIWJETvPvC9hS1Elaf9IkChzHmmGl5b
 uV6w==
X-Gm-Message-State: AOJu0YzNEjEdqv4JnCdHEmXDiKXUgpc07Gj0MjJTTEQ9yvMblAKZ5ElM
 t4vUafNzkCPyBsxL6taaVhnPjtFcx6rjnO4tFrl+Fct6tBE=
X-Google-Smtp-Source: AGHT+IF0lXnrinzEBf2HezVQ0WOVLaeIbm3HA+wI7BuCi1zzR1m37r4srTrQr90ajJulbibXl7mjIA==
X-Received: by 2002:ac2:59cc:0:b0:50e:80dc:b11b with SMTP id
 x12-20020ac259cc000000b0050e80dcb11bmr34906lfn.44.1704491945155; 
 Fri, 05 Jan 2024 13:59:05 -0800 (PST)
Received: from [192.168.69.100] (juv34-h02-176-184-26-1.dsl.sta.abo.bbox.fr.
 [176.184.26.1]) by smtp.gmail.com with ESMTPSA id
 g13-20020a17090669cd00b00a274f3396a0sm1305063ejs.145.2024.01.05.13.59.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jan 2024 13:59:04 -0800 (PST)
Message-ID: <8b4825a1-4ad4-4121-8079-3431d688f1b0@linaro.org>
Date: Fri, 5 Jan 2024 22:59:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/m68k/mcf5206: Embed m5206_timer_state in
 m5206_mbar_state
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20231221122939.11001-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221122939.11001-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

On 21/12/23 13:29, Thomas Huth wrote:
> There's no need to explicitely allocate the memory here, we can
> simply embed it into the m5206_mbar_state instead.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/mcf5206.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)

Patch merged as commit 5e077a7767.

