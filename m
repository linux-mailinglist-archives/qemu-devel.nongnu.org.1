Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1665672DE6C
	for <lists+qemu-devel@lfdr.de>; Tue, 13 Jun 2023 11:57:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q90Xy-00069X-Am; Tue, 13 Jun 2023 05:42:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Xw-00068o-Vp
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:42:40 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1q90Xt-0006GS-K7
 for qemu-devel@nongnu.org; Tue, 13 Jun 2023 05:42:40 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-97454836448so755762266b.2
 for <qemu-devel@nongnu.org>; Tue, 13 Jun 2023 02:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1686649356; x=1689241356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QZrSbjS8RmVzW2fTCaSxM9/4oBvnEQ3KsZdf4odoGvk=;
 b=dkREofThKfbGzZpQBLg0/WixVDcJkno8ZYlCvkpnFFzYzfw7NUlxdmnkv5UmqblNCW
 2g+co8E+Xkk+mTx56DYPOr9HS80BQkiu30UITnpsWPg5pFThU74t+qDkBVkQG97J++1w
 d0/7lp0QgJnlob9LqzyUhjS3XJzFv4FobHvF/X9zQ5NiHdAH+tgwjwdAlvgOLpwCfzrz
 S8JCP/dYvCPKrTlB/P1CgW6W+wtU479Rf3Gux0ZVh/iWqnd1GX3XTaqPmY208uBkOt83
 EqDJ/La7CraVaKsZkdYehsK0iWIgM29GAgQ8mwY5SNEpQbEPRzFOGqW/c/pXn3A7XJQe
 ToFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686649356; x=1689241356;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QZrSbjS8RmVzW2fTCaSxM9/4oBvnEQ3KsZdf4odoGvk=;
 b=TJukt872FsOEzcbXIrru5zt4AlgXCZumHEpSJ+UoWqVfvXKvAdVBxn4gknuEX06yAM
 Dg+IwH3iyWT7pywv0yykrVaZ/8an8a55mHYEm7sNLsBoPOCLk0CGWc48TWbUftVDzMWX
 nRn2BGkpSCWOCljELe1sWI61OeYDpGaO3F9wqz9O4Gj4YCcnwu54R9OZkd8xNCWe1qZu
 K9/XE0vXRhRVbEeHpk1cma2Pe77VfhJnZutExVHyJmbnFvylMnI+yug3n2xtSs9UVzcx
 ZCG3WvXLTJzVP3Hau8aWhGUbxSzdkhFUHqTer033Bs8iKHqT8ovP84BUX/PiFrVyOCMR
 di6Q==
X-Gm-Message-State: AC+VfDzhxnX9e0Np9Vxx/vgyHINWc3lYydpi1D4/Iq7wBYFmH745uWqL
 wFcvUJgFSOz+upa4LYkteQhIwfiPDORAUtrvIhPl1A==
X-Google-Smtp-Source: ACHHUZ6ey5zZ3bmJ3LCqAmwiVtJ2aS52pmca3U7sKwaqzB7lPHKlGzdGenPx51HJrYBinMK5+VW0Xg==
X-Received: by 2002:a17:906:7947:b0:969:e95e:e4f3 with SMTP id
 l7-20020a170906794700b00969e95ee4f3mr12231431ejo.55.1686649356004; 
 Tue, 13 Jun 2023 02:42:36 -0700 (PDT)
Received: from [10.10.0.115] ([185.140.244.249])
 by smtp.gmail.com with ESMTPSA id
 k19-20020a170906129300b0097381fe7aaasm6373690ejb.180.2023.06.13.02.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Jun 2023 02:42:35 -0700 (PDT)
Message-ID: <8a247db0-9072-cd80-fcea-4d89a1a4a6de@linaro.org>
Date: Tue, 13 Jun 2023 11:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: Fwd: QEMU AVR Patch - Correct handling of AVR interrupts
Content-Language: en-US
To: Adecy <ld.adecy@gmail.com>
Cc: qemu-devel@nongnu.org, mrolnik@gmail.com, qemu-trivial@nongnu.org
References: <CAB295yB5cFSZpGE74EW5hDMSNGnZfw06UC5ydepUL0sdT96WGg@mail.gmail.com>
 <CAB295yAzhzPpKC7KtpKk6t6x4Dn7Bpam=Nwfx8z0wAkZRP-JSg@mail.gmail.com>
 <268c1ca3-409f-bc43-0e88-c32f1eae71f9@linaro.org>
 <CAB295yBBgRcUdBsP+DDiZU_WZAihdn8LQE_BAyHC=QRonHS8Sw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <CAB295yBBgRcUdBsP+DDiZU_WZAihdn8LQE_BAyHC=QRonHS8Sw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.096,
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

On 12/6/23 19:08, Adecy wrote:
> Hello Phil,
> 
> I believe I have resolved the problem.
> 
> However, I didn't managed to make git send-email work yet. So please 
> find the patch attached.

Maybe sourcehut will be easier, its setup is well documented, see:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-you-cannot-send-patch-emails


