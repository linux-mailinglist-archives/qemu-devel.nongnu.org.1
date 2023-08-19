Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E2935781910
	for <lists+qemu-devel@lfdr.de>; Sat, 19 Aug 2023 12:44:48 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXJRP-00085c-JV; Sat, 19 Aug 2023 06:44:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXJRN-00085M-Qx
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 06:44:21 -0400
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qXJRL-00070t-CR
 for qemu-devel@nongnu.org; Sat, 19 Aug 2023 06:44:21 -0400
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-4fe8c16c1b4so2560970e87.2
 for <qemu-devel@nongnu.org>; Sat, 19 Aug 2023 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692441857; x=1693046657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=J+pbVaIbzmh1d2Ayv0tZyTxgD4//ROa6WL0TUyPjRqc=;
 b=Q4EOxVE86AXWDHEhBiaw1o9hJImAeCO0T3Qvfn9MZ4jAzIwdpR6achsO53q799Q4Kt
 AD3/xewYVEhWJ5vKYMxamFebRZaxDwG2aNvwIAvuZg/Vb5Yx7QfUG937RpGCbt3llnJQ
 m7cAyA7i/mtIHZYcwm1BSeYIzFarTaasn+9S9RP+ycnHAOSAFFsNbbet1fedCgtC5UEo
 R4id5G2/mS4mX6MEeiKrVpIYcH8Pnk2wY5etWOv3uD4D9WTsIvLfxTT58NH6b00+e99E
 B2+KDsAPhJUmOVUZTn3WIupwMtHrT/Yk3UNd1YUroPX9MWbYow38bHkzPAtASa/MWDSP
 9QPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692441857; x=1693046657;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=J+pbVaIbzmh1d2Ayv0tZyTxgD4//ROa6WL0TUyPjRqc=;
 b=CfF4/CCSE4WclnHLcLEpo1fckDZMNPX5iJJEATFvyveincIdXbLBOXsvXjkI08PQac
 W+pPT2+n9UNjZK9yejFFzoLIEZZXCYG3aOQrtlrD6hOluR6C0sWzrKvUjAvY95R7GugY
 n7RxKnba0RtnOb1Mc9G4vorDviVJNYXiEXKVjBAc7lHwffNm2wa9WhIXCZemcDEAvJyZ
 o+tuxkZFvESzHY2m3VRyyad83sGGeV0ODogArS+3w8rNfFrLDthjIc9mmtOT4zV7O7/3
 SXIAF2rsIMbVDyH9UOQ3m396T/PmsZs6blkiK0NkGSL4rRCcRt1y5tHGA62yolX2bDEm
 0ZmQ==
X-Gm-Message-State: AOJu0YxvLyjdPSGWOCiMsQv3Hi4zIIrGFsCPu6zM0moXQdgHPBXX64A7
 jlvNdE4SXzZeHx8+nNkUTI8dXg==
X-Google-Smtp-Source: AGHT+IFRf+XnXQgjMbJdhswjEezZ0LyXEWpD7Nsvp6W0QY7Dge1qi0wwyKHq6NuesFHJpn2zu2Ej2Q==
X-Received: by 2002:a05:6512:11e3:b0:4fb:ca59:42d7 with SMTP id
 p3-20020a05651211e300b004fbca5942d7mr1157711lfs.33.1692441857377; 
 Sat, 19 Aug 2023 03:44:17 -0700 (PDT)
Received: from [192.168.69.115] (cnf78-h01-176-184-27-220.dsl.sta.abo.bbox.fr.
 [176.184.27.220]) by smtp.gmail.com with ESMTPSA id
 c23-20020a197617000000b004fdc0f2caafsm757846lff.48.2023.08.19.03.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Aug 2023 03:44:17 -0700 (PDT)
Message-ID: <7dbdecd7-e3f1-beae-9fbc-55973c8035e2@linaro.org>
Date: Sat, 19 Aug 2023 12:44:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH 0/3] bsd-user: image_info cleanups
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com
References: <20230818175736.144194-1-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230818175736.144194-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::129;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x129.google.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.862,
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

On 18/8/23 19:57, Richard Henderson wrote:

> Richard Henderson (3):
>    bsd-user: Remove ELF_START_MMAP and image_info.start_mmap
>    bsd-user: Remove image_info.mmap
>    bsd-user: Remove image_info.start_brk

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


