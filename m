Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A174A7F7BC5
	for <lists+qemu-devel@lfdr.de>; Fri, 24 Nov 2023 19:08:34 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r6aaC-0002yr-S3; Fri, 24 Nov 2023 13:07:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6aZz-0002vC-0O
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:07:03 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1r6aZx-0004tI-7F
 for qemu-devel@nongnu.org; Fri, 24 Nov 2023 13:07:02 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40839652b97so14658035e9.3
 for <qemu-devel@nongnu.org>; Fri, 24 Nov 2023 10:06:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1700849219; x=1701454019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nwk41YM/As4/nWtSBVjJdN3lwy3gQo3BCw2PzO+/0Hc=;
 b=JDvPTtjyrT1LuyWY3SjAyp8vgTLNGgvQQ8f69UhwGnUyFmIlL1J+uYcL+m1yYnkY0j
 4VV1/2uRftMCcgheNNK3xFNqyf2DUUcACqw5RptzHGzYPlMuUqsWGG+a89CfRYd4x/3H
 IpnvbLbr0HxiSKR0FpQF1M9INRs19QDQb8EENRDX1e2Ur+Gc6pU3+p5b4mPLJ7IapCXl
 PwwjS/YQ7cjFyN1hUvSJhj7HeWN7BeeDauutM43zErILTSk1ZTEuRLZ03HIYDjhqOrYk
 EvGW2DBAy1lbEkqMUiZ4QEO+LEe48gpPrEwFSaeswaPSxzqBwEz6wKCVVylUIM80QUEi
 xJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1700849219; x=1701454019;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nwk41YM/As4/nWtSBVjJdN3lwy3gQo3BCw2PzO+/0Hc=;
 b=PmFkd13aPcydog6nZdm2WaOlkI1UNmpboEzDo3QOJBCB2LrSjScJSBjDQCB2ooWZBp
 bu5RLUSmQW0nKp4Jg6LsKVzrNtT2TXSs9lJLMl7ytVA9EPMY7IAL5kM7M0yISBihyujE
 ex4DYy5mLgpMUUnYZLsi0Q0oyL6Iukjgxb2xka0pn6z0M4RKG97BHMpZVuVgWr+09PTS
 4v9Zn/wLecaq5LpOKXntSzD+XZGVdXc62rvo47gTzdXjXPyHKhzXWfCCsrPDeA8gHmy3
 7r2gWXA35tIU7m+Qyn5Ut3bQ3FOO0Dw5wK820rOsQcRdeUrh09Rk22cEEm0CFxAnXA4o
 SELA==
X-Gm-Message-State: AOJu0Yz7OQtH32BddTgmvPmqn7357AXw+X4XNPWKmaHQKGMr+aB4DSo+
 26NZ6IxmFZKGgoRAIcAseutohg==
X-Google-Smtp-Source: AGHT+IFKs5+DX/hDIpTOyevU2kUzMlgHIEAxxto7o3liu4ct3XTBFWAcadNgn8WLggd8tW287TmVkw==
X-Received: by 2002:a05:600c:444d:b0:40b:3d70:7bea with SMTP id
 v13-20020a05600c444d00b0040b3d707beamr1393102wmn.22.1700849218661; 
 Fri, 24 Nov 2023 10:06:58 -0800 (PST)
Received: from [192.168.69.100] ([176.187.218.17])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a05600c1c0900b0040b3515cdf8sm5795297wms.7.2023.11.24.10.06.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 Nov 2023 10:06:58 -0800 (PST)
Message-ID: <17904233-306a-42a0-b385-d21a46863fb5@linaro.org>
Date: Fri, 24 Nov 2023 19:06:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-8.2 1/2] qdev: Fix crash in array property getter
Content-Language: en-US
To: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, armbru@redhat.com, peter.maydell@linaro.org,
 Dan Hoffman <dhoff749@gmail.com>
References: <20231121173416.346610-1-kwolf@redhat.com>
 <20231121173416.346610-2-kwolf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231121173416.346610-2-kwolf@redhat.com>
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

On 21/11/23 18:34, Kevin Wolf wrote:
> Passing an uninitialised list to visit_start_list() happens to work for
> the QObject output visitor because it treats the pointer as an opaque
> value and never dereferences it, but the string output visitor expects a
> valid list to check if it has more than one element.
> 
> The existing code crashes with the string output visitor if the
> uninitialised value is non-NULL. Passing an explicit NULL would fix the
> crash, but still result in wrong output.
> 
> Rework get_prop_array() so that it conforms to the expectations that the
> string output visitor has. This includes building a real list first and
> using visit_next_list() to iterate it.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/1993
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>   hw/core/qdev-properties.c | 33 ++++++++++++++++++++++++++-------
>   1 file changed, 26 insertions(+), 7 deletions(-)

Per 
https://lore.kernel.org/qemu-devel/CAFXChKJ+OoxXH0Krvvc0-84VwTkat1CciOL=59+gyH+WYWEV_A@mail.gmail.com/
Tested-by: Dan Hoffman <dhoff749@gmail.com>


