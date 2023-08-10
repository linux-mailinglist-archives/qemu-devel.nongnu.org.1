Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 63776776D81
	for <lists+qemu-devel@lfdr.de>; Thu, 10 Aug 2023 03:28:43 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTuSS-00036f-2b; Wed, 09 Aug 2023 21:27:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTuSQ-00035r-V4
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 21:27:22 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTuSP-0000G7-EL
 for qemu-devel@nongnu.org; Wed, 09 Aug 2023 21:27:22 -0400
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-6bcaa6d5e2cso391007a34.3
 for <qemu-devel@nongnu.org>; Wed, 09 Aug 2023 18:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691630839; x=1692235639;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/T8OtNbbPK084bpQmMglzYUguZoPB43wUgaseZT2Eak=;
 b=XFA4CSGR8SKxMz/0OqffQTtkT8YL7XLGVJaeOYLoBG13EQLYF/wvUF7pvukl2ICv5q
 p8pj3dgkJU08psno/QwOTPmC60cPyXZpNQIXfECr3vhq2pfaY8iNoQmiIEOrVMPvqqnB
 IihR737QtB1l8rfJJ1kVsGBByghK+HjPysEsZL71fogfkV41NWLVZ4E5e4dZ3CFQrWcq
 R/TiY/aVBcXBzopX5LDUB6/PMedcoupSDWe8cSNb1CKun8uscLsx54YpgmUjuKdKafcm
 ZvL+mRZPWfBZaTN+mltHaCPQXHc5SNHHw6FUg0YOGMTvMPbXjt07ky7pcY6WSKWfcDjb
 6lKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691630839; x=1692235639;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/T8OtNbbPK084bpQmMglzYUguZoPB43wUgaseZT2Eak=;
 b=W1KCkObaMmywnz7MFNvQpiSoulfZeSeNWeMnXHLthItUxOvz8VDZsqtD9X914LkCXK
 m5+cT5gHvl7YeGJg89eT0yGOo+GW0ZX0FvgbPLJAh8zSLleuAB3VVX3Ehp613Cttmfui
 b8LB0NXtoBHfS2KuUgwMXJcNBTGov9930TakDLDDCXG70XyTxG6nnUco/UiF8WvbMIqi
 ngYhKMD/EGBwWYu5txZk8bfT32wGOjh9DCLcddisbdt+qPeDZFP+PYoYjvd0rCb3zZ9E
 YQzx6NJPTyXLoYwi3txe73WWS8wDpTxRJk2iskATqYiQUtbGmBytd4Bvlm8NRNSFVDFa
 vxSQ==
X-Gm-Message-State: AOJu0YzM1Sc2EwLRw6OJK8O3yDsH8cQdXog6F7EUlTgGes6GYYBbVmk1
 G+lbhm9OgOSanBwW1im91zb8aQ==
X-Google-Smtp-Source: AGHT+IFskeOaX0CWnrkPqze2oVVmcqwrEvftxsasUabjPqU76l00Mgtwmoig69wBG2jXQV45ZJsB7g==
X-Received: by 2002:a05:6808:1311:b0:3a3:6450:f5c4 with SMTP id
 y17-20020a056808131100b003a36450f5c4mr1614799oiv.4.1691630839642; 
 Wed, 09 Aug 2023 18:27:19 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:6bf0:9674:6ac4:f74c?
 ([2602:47:d483:7301:6bf0:9674:6ac4:f74c])
 by smtp.gmail.com with ESMTPSA id
 22-20020a17090a19d600b00263d3448141sm254391pjj.8.2023.08.09.18.27.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Aug 2023 18:27:18 -0700 (PDT)
Message-ID: <129c90ab-14cc-04bb-493a-d4524b54c02f@linaro.org>
Date: Wed, 9 Aug 2023 18:27:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH][RFC] Add crash handler for qemu-linux-user
Content-Language: en-US
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <ZNQcQxcL/22LmrVP@p100>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <ZNQcQxcL/22LmrVP@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/9/23 16:07, Helge Deller wrote:
> +            /* did qemu source code crashed? */
> +            if (unlikely(!h2g_valid(host_addr))) {
> +                qemu_show_backtrace(info);
> +            }

This won't do anything at all when reserved_va == 0,
i.e. 64-bit guest on 64-bit host, or any 32-bit host.

The idea of having a backtrace is nice, I suppose, we just need a better detector. Between 
host_signal_pc() and adjust_signal_pc(), we should be able to determine if the access is 
being done on behalf of the guest.  If it isn't, it's a qemu bug.


r~



