Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E4680A1B6
	for <lists+qemu-devel@lfdr.de>; Fri,  8 Dec 2023 12:02:10 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rBYbx-00049D-RT; Fri, 08 Dec 2023 06:01:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBYbw-00048o-M3
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:01:36 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rBYbu-00027q-Sx
 for qemu-devel@nongnu.org; Fri, 08 Dec 2023 06:01:36 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40c19f5f822so11042605e9.1
 for <qemu-devel@nongnu.org>; Fri, 08 Dec 2023 03:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1702033293; x=1702638093; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HsEyCJ3Qz/EwQ3LPrHOOunmMJhnJYVq6PScBSKlDqoQ=;
 b=Nu3g+JYQtExyoPrz7mfQG+5S3hyJ5VbLcvgDElFTpino2qtQ5BTkBCzkv2IDgwfRK7
 GD+QHjICy9SNT8Kku75y3WkOFmfhE4ZAtEmsJEuJyxIgXijaRPHpptghjKkvtauCibXr
 yspVbnogcqDqYXJxYEReBnvxBxLiChM2KpGrbZ53MBaM0q+JaakNC7GIkPkW64vmL1Ah
 3xatOQtRI0qC3en1SmmbbBObI9KKDinYSARuAe0aKc9JewFIXJV9PMBP3jLHZdA2pYA9
 e6OQxnl4sQkuEmwq9iolxK1Ae9i0U4ghftFU7pJZlJkcsHMqkM8ww5YyHKDXs0bb8L7m
 1PjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1702033293; x=1702638093;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HsEyCJ3Qz/EwQ3LPrHOOunmMJhnJYVq6PScBSKlDqoQ=;
 b=cIFlvJDYTUq32SnJApcOp0CFUfEQEOfYQRifOSecuYKGxU/9Ioueyb/PwC4AnIL/Wy
 EACUzRa258/Xr2gmmi+7fmFs2tKwrAhoVDN0KwNR4jHVoQlhOJvR0HBzCiQLHd1X7Sak
 QgMt9xoFsij1a64xtg98LUFbKciv3rcRHoGxfK/FOlldxmQJNnQc/DusU4Byl7aoK0Df
 VNCMZ174BF41SbcwEAODuD/MVyN6z7jnHqJGqO4zigyg1HlbgohEFOuBA3z5QEmAf/9K
 yIrDyCq5l5dkFhjJnKvrrV+YDLPLCxrNeWCRRlGMyY/BJksqWI9FowHfW9BcY4H8kYap
 wzhg==
X-Gm-Message-State: AOJu0YyDD1dMWMmXSjWB2doskHjTx6hy7XM6cNLk155818Hj60h8fRFz
 tNgyS1KYTIW0NnrkGyKnQjjcwg==
X-Google-Smtp-Source: AGHT+IE9J7Eh94n4qaxB+OZGd96rjKibcUDDeYknfkQ2DUjnMPAdfwfAAmMLUaOhAIDlx838cY4wOg==
X-Received: by 2002:a05:600c:a383:b0:40c:2ace:6e58 with SMTP id
 hn3-20020a05600ca38300b0040c2ace6e58mr391284wmb.182.1702033293289; 
 Fri, 08 Dec 2023 03:01:33 -0800 (PST)
Received: from [192.168.69.100] ([176.176.146.181])
 by smtp.gmail.com with ESMTPSA id
 g11-20020a05600c310b00b004090798d29csm2492256wmo.15.2023.12.08.03.01.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 Dec 2023 03:01:32 -0800 (PST)
Message-ID: <f833be50-547c-41cc-87b8-85dd18a4a70e@linaro.org>
Date: Fri, 8 Dec 2023 12:01:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] accel/tcg: Move perf and debuginfo support to tcg
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, David Hildenbrand <david@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
References: <20231208003754.3688038-1-iii@linux.ibm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231208003754.3688038-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

Hi Richard,

On 8/12/23 01:35, Ilya Leoshkevich wrote:
> v2: https://patchew.org/QEMU/20230630234230.596193-1-iii@linux.ibm.com/
> v2 -> v3: Rebased.
>            This series was lost and forgotten until Philippe reminded me
>            about it.
> 
> v1: https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg07037.html
> v1 -> v2: Move qemu_target_page_mask() hunk to patch 1.
>            Fix typos.
> 
> Hi,
> 
> This series is a follow-up to discussion in [1]; the goal is to build
> perf and debuginfo support only one time.
> 
> Best regards,
> Ilya
> 
> [1] https://lists.gnu.org/archive/html/qemu-devel/2023-06/msg06510.html
> 
> Ilya Leoshkevich (4):
>    target: Make qemu_target_page_mask() available for *-user
>    tcg: Make tb_cflags() usable from target-agnostic code
>    accel/tcg: Remove #ifdef TARGET_I386 from perf.c
>    accel/tcg: Move perf and debuginfo support to tcg

If you R-b/A-b this series, I'd rather integrate it in my exec/ rework.

Regards,

Phil.

