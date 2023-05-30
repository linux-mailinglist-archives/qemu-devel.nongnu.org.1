Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FBD9715468
	for <lists+qemu-devel@lfdr.de>; Tue, 30 May 2023 06:09:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q3qfE-0007Y8-22; Tue, 30 May 2023 00:08:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3qfA-0007T9-AC
 for qemu-devel@nongnu.org; Tue, 30 May 2023 00:08:48 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q3qf8-0007cl-DM
 for qemu-devel@nongnu.org; Tue, 30 May 2023 00:08:48 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1b04949e4e9so8109005ad.3
 for <qemu-devel@nongnu.org>; Mon, 29 May 2023 21:08:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685419724; x=1688011724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bbTiuxR4Qn6WFXGuZXNpDTwSswhPCOOhltxSdj3uzLU=;
 b=LGU1uukI+UM7OH1RIItxXoJqtLoFK72csEkKHoAE7hBtV9NWCEfU7zCeIpbZtP+m98
 inJ3HTkNVMEdKUwP9ar8Ck/8YyHQmIbkUdcqkuxxC73MIWt/rCioL/yiVTr0EYRKRtYz
 Bv1mPALtpdtF9YlLDH9euGfa8wq7KWfhvGKbe8X5MK2zFTcVTU0CFuk3QP0oPvpxl7eF
 sPKuT44k+tjpvh1uSc96BSU/nTWlIECtE+z9etXaFKcMA0HYTf7mkPTBDeAY+UqbGuUs
 8KpSI9CUUe4GvkYruFVdFZ6h0ojiTHuoFSh7nkoC/P3do6BdSUebaYXTln13Re5VjRyW
 hXJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685419724; x=1688011724;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bbTiuxR4Qn6WFXGuZXNpDTwSswhPCOOhltxSdj3uzLU=;
 b=kxR+M+ZkgCS1JE29sTAZ6aNAN9kwYo4m1iouqutoB6Nq8hCVsq8fbd+TtpvzmJ6kRZ
 N/114zEcnkysuArvNd93WLkabRjS9tVPXcli1DfkIiDM16CZaKfwEsDchy/O8dFpn7Z+
 MHw1pAcvmtuplTk3kO8AmDdPk0Dm7OyrhEf6oRiodArX1OJJ2qnx9jCkhMhcaM91GK9/
 qiOPwRQCfvc2JRDvxXzdsoL31ECCRAFYDGeuEhgp1En8k31LGVwIC3DIieznxqQNxyWX
 kmlAv9aX9snxTHJlF4ipuU5VGnGVGoiknV8WcaZEXrIvE1oMS+Ecufps9gBCy/R0xkEm
 t7FQ==
X-Gm-Message-State: AC+VfDzwMQrsZxms9/TOXOGSAO6k+f003b9CeTfj7UrcnAbrsFK0ZvOf
 ht/9ILNzOadf1f07n3v5onn2V88s4MdNpriabt0=
X-Google-Smtp-Source: ACHHUZ6MrOi3CNK1+vjYly0ZYs4ubpOS7i2rb5KIftjGXLXQKDHkWcBbyVKE3zWNgZpaqbBc9KL5dQ==
X-Received: by 2002:a17:902:e74c:b0:1ab:267e:2f2d with SMTP id
 p12-20020a170902e74c00b001ab267e2f2dmr1357777plf.48.1685419723898; 
 Mon, 29 May 2023 21:08:43 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:9923:e5b8:e7d9:7a28?
 ([2602:ae:1598:4c01:9923:e5b8:e7d9:7a28])
 by smtp.gmail.com with ESMTPSA id
 z1-20020a170903018100b001b03a1a3151sm2572471plg.70.2023.05.29.21.08.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 29 May 2023 21:08:43 -0700 (PDT)
Message-ID: <586a2a70-99bb-c0a9-14d1-a154cbecc13e@linaro.org>
Date: Mon, 29 May 2023 21:08:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] tcg: Add tlb_index_and_entry() function
Content-Language: en-US
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20230530000543.4F83174632B@zero.eik.bme.hu>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230530000543.4F83174632B@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.091,
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

On 5/29/23 17:05, BALATON Zoltan wrote:
> The tlb index and entry are often retrieved together and tlb_entry()
> already calls tlb_index() so it could easily return it. Add a
> tlb_index_and_entry() function that does that to simplify callers and
> maybe avoid some duplicate calculations.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

The compiler does a good job removing duplicate calculations already.
What effect do you see with this?


r~

