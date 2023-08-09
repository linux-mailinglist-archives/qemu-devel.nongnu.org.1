Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E9AF7775136
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:06:30 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZW3-0002Rb-DN; Tue, 08 Aug 2023 23:05:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZW0-0002RF-Lo
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:05:40 -0400
Received: from mail-ot1-x335.google.com ([2607:f8b0:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZVx-00022u-Sa
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:05:39 -0400
Received: by mail-ot1-x335.google.com with SMTP id
 46e09a7af769-6bca3588edbso4337505a34.0
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691550336; x=1692155136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eV5cYUVKwD61JXHP+Bbt/G/gZmCAjoi/zJMx2VayMt0=;
 b=AcjU+VjbCUGJYDBlA6rjE48pXAPtmn57D7X8tnYNMCV9f0DNvHig7ACh3ZlHuHd0wp
 5xC08OCu2XYmYlueayTsyOw+Ce9LKVE6E94m/c1Qhdx3I6lrNxK/oYLwORzhA9AnrGDI
 DM/S9x+yutySf49zxRGPtq/ooDidAn1iumNXsGrYiBIw8rek9UE5/nfqhW3FnYY8bzUI
 8AqGOQBkM3YesWuooy229TV2pxRYkt/sMLwGjSVmclC2wbvrcrG2CBbskvnmqN5K2ugi
 65q9qy2OOeUdytcUwXWmn7VAr2PQKoM6w87G1ZB+SW8rpvBThiVg+Dn1f+WnpGTvg61I
 BX6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691550336; x=1692155136;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eV5cYUVKwD61JXHP+Bbt/G/gZmCAjoi/zJMx2VayMt0=;
 b=hzqgAyXW3BmbNLLnvvLxBfJisSphD4xT5nm1uplE3141NIvBOYPBHl4oE9phODkiju
 Ff4Uo6OjIvjxgvQcghumb9XKByBEXyhRlGhNfGVXtZyrYB/jbQjcmU/qF2lTOdxyDKXQ
 cA1NueTrj9V/0A75L+LT6F2wD1Y2aX827jlDeyxf3t7MDqG3ewPBWPnaBTbJh8LlLvU1
 Qg9d4EBCpbjWpWZCKifC5hWzYO8VXkIgt0x4DhB5U7sY2mVTfVhq8lgbDU0cSledBodF
 lDeMX8TVvmIfgW4cvU/o1pq3zscxwoV2kahMmPByMB/FMZmrU3ntZ+Rw3HDkMGKYRbXW
 JG1g==
X-Gm-Message-State: AOJu0Yw2Q1TMnJFx1HGnd7xT40uFLyGlk32LLq5OdX6HcZ1TR1DOf+RA
 cYj9XOxBrhidPmzOmtPmDLyNUA==
X-Google-Smtp-Source: AGHT+IEVANpJcsjUVmk2s8VDn36VrxDDDFDG774OT6EWeiJ7rXsIdWPSk1elQmSbifjgozWRDBj/zA==
X-Received: by 2002:a9d:731a:0:b0:6b9:c5b5:6a96 with SMTP id
 e26-20020a9d731a000000b006b9c5b56a96mr1399741otk.6.1691550336643; 
 Tue, 08 Aug 2023 20:05:36 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:aef:cddd:11b6:aee3?
 ([2602:47:d483:7301:aef:cddd:11b6:aee3])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a63b40d000000b0056129129ef8sm6380714pgf.18.2023.08.08.20.05.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:05:36 -0700 (PDT)
Message-ID: <51f6d14a-bf36-1d3a-e9ee-de86bc506eaf@linaro.org>
Date: Tue, 8 Aug 2023 20:05:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/33] Disable clang warnings arising from bsd-user/qemu.h
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org,
 Kyle Evans <kevans@freebsd.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-3-kariem.taha2.7@gmail.com>
 <612acdbb-865d-0e32-9212-df9440a0e8bb@linaro.org>
 <CANCZdfoLG8vpwgnxB2hW1ZoNeoTZvQuMfXYkB45eLisEtgbLYA@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfoLG8vpwgnxB2hW1ZoNeoTZvQuMfXYkB45eLisEtgbLYA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::335;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x335.google.com
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

On 8/8/23 19:56, Warner Losh wrote:
> Looking at this now, This bug is in clang 7, from 2018. For FreeBSD, we don't support
> anything older than clang 12 or 13 However, the bug still exists in clang 16, the latest.
> I believe this was also copied verbatim from linux-user, so let's leave it and then make
> this one of the common things as a followup... ok?

Ah.  In which case this should simply be moved to qemu/compiler.h.


r~

