Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 116317E2973
	for <lists+qemu-devel@lfdr.de>; Mon,  6 Nov 2023 17:12:53 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r02DC-0008Da-EQ; Mon, 06 Nov 2023 11:12:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r02D9-0008Co-J4
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:12:23 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1r02D7-0003XR-6q
 for qemu-devel@nongnu.org; Mon, 06 Nov 2023 11:12:23 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1cc9b626a96so22226795ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 Nov 2023 08:12:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1699287140; x=1699891940; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5goKHWyeuFy/ivXB5+wzUlXySj3e57WmOnN64CKOVQc=;
 b=ZH4f7TYvI8zAkXNr9wYrj2LjpQYLa+62QGqrXqhgdaXO8cTGAig0Ich5pENsI6oo+5
 L6Cz7KbG833twHgTQXOeTWDiquI58MoCWD7wJFK7HjZl3SBqgLpNlKYoWzqtzU7m5+yA
 TpsAn+S1pWLX1dfFm2o8jtDHsBP9lilKRA3U59e5AjmwSrn1h/8kLm+73Io3YK4iIpD2
 bDNuvPw339jsZlLqo9OopY0V+rwK6+j3DA5IkVD0maUw21t2MofGvChR3p6Lj7T/dKDU
 JPLSYrKl0V/4FpLjdTyfoko3JnLB04uO6G9Keb4pLQtanhP3twTZLMe5pQg1UThOJs79
 iZUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699287140; x=1699891940;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5goKHWyeuFy/ivXB5+wzUlXySj3e57WmOnN64CKOVQc=;
 b=pCe3OA6k76AQT+MUK80IaU4EB5Ms7xXyCDJSaPV/nXXzW/89XsH0j4h6OOAO7fg1dR
 5BFaOnT/qlU1OAqT0he8x8vVQ0m/qlx+7EoOyUjRjHGEy4WWGb9zvXXaOGbSqptDbxyB
 f5pea+S1XBCWa+FrFXC4XRwuz6U5mXTBgVdvyGGvSt701Y48iEnFH3pqz8YtoKi1sZpI
 4atB3Dn63ODxjT0W3WH1AIkJLac/rVF9tIYUHu9wio0EljcRibDSR9Wla/gAlrxtVbs0
 hEE3CtzidIMphPYdGuNoCD1EF46j/4G9q1TrkGt2LnnnbpSZMe9ASw9BSbTSZCANFapI
 sHfw==
X-Gm-Message-State: AOJu0Yy0fcrhVBvsDMRryfEl8JR+PlRq67oQ+x+NQTlSoEDSrJYu3afE
 KNSXSK0CNk31ZNG6jTsMgGj5BQ==
X-Google-Smtp-Source: AGHT+IEM6x8eEVA+m3dZIsD5snzdcmPsMrwlHppZzRcq0iePdY3K02Bn1Ve7T8jc61vMHPMaPA5S6Q==
X-Received: by 2002:a17:903:2808:b0:1cc:31c4:377b with SMTP id
 kp8-20020a170903280800b001cc31c4377bmr18535674plb.63.1699287139722; 
 Mon, 06 Nov 2023 08:12:19 -0800 (PST)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001bc930d4517sm6072709pld.42.2023.11.06.08.12.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Nov 2023 08:12:19 -0800 (PST)
Message-ID: <ed50d5e8-faa9-4857-a223-3945a5db5f33@linaro.org>
Date: Mon, 6 Nov 2023 08:12:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/5] tests/tcg/s390x: Test CLC with inaccessible second
 operand
Content-Language: en-US
To: Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>
References: <20231106093605.1349201-1-iii@linux.ibm.com>
 <20231106093605.1349201-3-iii@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20231106093605.1349201-3-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 11/6/23 01:31, Ilya Leoshkevich wrote:
> Add a small test to prevent regressions.
> 
> Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> ---
>   tests/tcg/s390x/Makefile.target |  1 +
>   tests/tcg/s390x/clc.c           | 48 +++++++++++++++++++++++++++++++++
>   2 files changed, 49 insertions(+)
>   create mode 100644 tests/tcg/s390x/clc.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

