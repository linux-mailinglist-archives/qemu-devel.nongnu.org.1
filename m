Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C66781E40
	for <lists+qemu-devel@lfdr.de>; Sun, 20 Aug 2023 16:26:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qXjMr-0001RK-25; Sun, 20 Aug 2023 10:25:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjMo-0001R6-W5
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:25:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qXjMl-0006rT-4q
 for qemu-devel@nongnu.org; Sun, 20 Aug 2023 10:25:21 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1bdcb800594so13881265ad.1
 for <qemu-devel@nongnu.org>; Sun, 20 Aug 2023 07:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692541516; x=1693146316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7/9MZe/Yllt4OSPa3gZtSFCVfF0JbuhfrgaaozADvCI=;
 b=AKd8CfPGNK7dfrefdw89+QnvyPxMjTXOnU4R9vjzymWYAP5GxYONPE3v617QUDUFYR
 mmZVJSsqDGDVv9CFzUVKNvaJ+55tdN5C52lqGf8AVqZVItQcaYJRGkFGHkfkpnGONht+
 iTwoz87d84q2ZmzmVHO8fBmy1IQWM5AHxGuo5eJLUelkWXWyxTHrRLCqv1POmJ2VXr59
 R86WNlVWhOPTl6JL2ABJJMSEgUUbFk8EHsWbtwgmhainFIpzUaRTiNgpSnx4WmySc2Eo
 wzWnOJRkkIblS3QmCA1g+RAGJBFvHSNDlZIdCyLiE+KK7HS+h95P1PpwP6RzNMFKWm8+
 Sohg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692541516; x=1693146316;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7/9MZe/Yllt4OSPa3gZtSFCVfF0JbuhfrgaaozADvCI=;
 b=QytVV9ugPS1BxxNy4GKFYz7aPUKJiGF3i0Ks8u8x6Omd3T9La01WfX/O2OKyLNtzVm
 9gR+E0iWJNEP5Nd4SF4IpMT+SIoHGjMovawXtAzsmrxOCtTwDU26Ncd/Yy90CyDR/SJF
 02v/T4cHYXyhP+71V5/Vjfb7o65QmJHXB1GC0Pt4rE4LcvxkHfzHezjwiCuOOEchHwRH
 3jgQGSCl1ItTEwqOxHqoC3kt0d3S8NqdCXnQOfSrSWOVaH39P88ObuPPyp9vYE6Ydzn5
 ej6ovM6qA1DGqRUBTeHViLtas9/BVVYXcvX/yDvZsk3kJb0xV2vdWhNEPM6u860fp9St
 ikxQ==
X-Gm-Message-State: AOJu0YycQF3k/W2yavOhl2ltfm6Ug+6sDq0qXkxg9NgKup7r5wSOoTth
 hdkc7FkgW2Ogef0djchyOnFWDQ==
X-Google-Smtp-Source: AGHT+IGw1dzbVnr0EhygsKdQtJGVsTvWgQ1KadDkBOv/fko+7yQEWJBF1RAFLWhQnnFouU8mKlPpHw==
X-Received: by 2002:a17:902:e84f:b0:1bc:506a:58f2 with SMTP id
 t15-20020a170902e84f00b001bc506a58f2mr2956928plg.46.1692541516300; 
 Sun, 20 Aug 2023 07:25:16 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:347d:4d37:bdd7:f5e5?
 ([2602:47:d483:7301:347d:4d37:bdd7:f5e5])
 by smtp.gmail.com with ESMTPSA id
 jj4-20020a170903048400b001b9f7bc3e77sm1395027plb.189.2023.08.20.07.25.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Aug 2023 07:25:15 -0700 (PDT)
Message-ID: <7865c37c-c8ff-5387-33b9-20dc099f90b7@linaro.org>
Date: Sun, 20 Aug 2023 07:25:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 12/22] Implement mmap(2) and munmap(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230819094806.14965-1-kariem.taha2.7@gmail.com>
 <20230819094806.14965-13-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230819094806.14965-13-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.279,
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

On 8/19/23 02:47, Karim Taha wrote:
> +    case TARGET_FREEBSD_NR_mmap: /* mmap(2) */
> +        ret = do_bsd_mmap(cpu_env, arg1, arg2, arg3, arg4, arg5, arg6, arg7,
> +           arg8);

Indentation.  Align after (.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

