Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC0C81FF48
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Dec 2023 13:02:52 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rJBYz-0005SI-6P; Fri, 29 Dec 2023 07:02:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rJBYu-0005Rj-L9
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:02:01 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1rJBYs-00023X-EP
 for qemu-devel@nongnu.org; Fri, 29 Dec 2023 07:02:00 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-554909ac877so4904769a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Dec 2023 04:01:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703851315; x=1704456115; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7+PHEaS0uCelKNM/s+1g0UXrfcWmC0+x6QCJnv5+scU=;
 b=GtJy73grY02ZF95GZMBspfFaRe8r4LmIPWFn4HBEnXgLkAgLDeXGiqOWIPqCRnrN2N
 uTNw1oZWweYNiad69qpTsSiGSMj9KPo7nxNzlK3SU15e0Xrn3uW2M3WGepQhlVMAOqvZ
 DB2lLRPWfNBr/Vfvp6oY3wLLS81+g+8av383IXUFk23CprbO33cBi9tAhS827C6PK0o3
 0g7Yylo0m4V50DQiX8ECwfUqQn0hufnujhUcP4RMS8reK+djcHrvWIKz9LC29fzSkFTY
 Gg4/97H18GwRV3rQqlLHx34NI7r9aEyD9E4g2Jt0Dv5cS+pGzeIRUkf1Iuwk7xUkkQBR
 6l2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703851315; x=1704456115;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7+PHEaS0uCelKNM/s+1g0UXrfcWmC0+x6QCJnv5+scU=;
 b=epfzyooQuXIrO4+fymTLuY47ZKz8pBfFjVCVmX6MKYWvXMokv2RVAzpBmaYiCagbyt
 d0LtnpMcJEfxJOcXHaZk/0M/vgOBv6Q6MNqz5SCt3sEoM0VRutqgDc4Bgk1WT5z3tp20
 2egE4uNeGrlcQzpN5xVxUHdxD3wPODB9jtFITTNKyQnVOVbV30CL0JlhulHaCCEUdX78
 e0RAqOY4fwYgu7atK0Hq44rsERaAOCrrT3EJ8GFEV9uMBdmFod2xzcmqKobvSAKqFkAJ
 iTG9/MfOMkiiyRyRvtt2IHx6tt+sXFM879FlJdRUhyZQZPq5eXnmRsbPV9mYsomsvB15
 ItZg==
X-Gm-Message-State: AOJu0YzGOVhZrFVOeuVFDlcpriQckSA2h7PxspOKRfwv+MRHZSVIssmC
 EiUeZxj+UICIMsqDYlC19pMp22zcgzRrlg==
X-Google-Smtp-Source: AGHT+IH5xkbbiRCWwd5HRM/QMzeVNNp2Bk+Fzq9GsDodmws8JChoTWvJbvpCZmEfZbTLTIQhtcEqHA==
X-Received: by 2002:a17:907:1114:b0:a23:53f8:c956 with SMTP id
 qu20-20020a170907111400b00a2353f8c956mr4117740ejb.42.1703851315094; 
 Fri, 29 Dec 2023 04:01:55 -0800 (PST)
Received: from [192.168.200.206] (83.11.185.71.ipv4.supernova.orange.pl.
 [83.11.185.71]) by smtp.gmail.com with ESMTPSA id
 p9-20020a170907910900b00a26ac5e3683sm7549570ejq.100.2023.12.29.04.01.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Dec 2023 04:01:54 -0800 (PST)
Message-ID: <c9f9c9a8-acd4-42cc-8dd8-ccaad6d74cba@linaro.org>
Date: Fri, 29 Dec 2023 13:01:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] ARM Sbsa-ref: Enable CPU cluster topology
Content-Language: pl-PL, en-GB, en-HK
To: Xiong Yining <xiongyining1480@phytium.com.cn>, rad@semihalf.com,
 peter.maydell@linaro.org, quic_llindhol@quicinc.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, chenbaozi@phytium.com.cn
References: <20231227120722.1683361-1-xiongyining1480@phytium.com.cn>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <20231227120722.1683361-1-xiongyining1480@phytium.com.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ed1-x532.google.com
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

W dniu 27.12.2023 o 13:07, Xiong Yining pisze:
> Enable CPU cluster support on SbsaQemu platform, so that users can
> specify a 4-level CPU hierarchy sockets/clusters/cores/threads. And this
> topology can be passed to the firmware through DT cpu-map.
> 
> xiongyining1480 (2):
>    hw/arm/sbsa-ref:Enable CPU cluster on ARM sbsa machine
>    hw/arm/sbsa-ref: Add cpu-map to device tree
> 
>   hw/arm/sbsa-ref.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)
> 

Tested-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

Booted system with "-smp 8,sockets=2,clusters=2,cores=1,threads=2" and 
got what I wanted:

         cpus {
                 #size-cells = <0x00>;
                 #address-cells = <0x02>;

                 cpu-map {
                         socket0 {
                                 cluster0 {
                                         core0 {
                                                 thread0 {
                                                         cpu = <0x8007>;
                                                 };
                                                 thread1 {
                                                         cpu = <0x8006>;
                                                 };
                                         };
                                 };
                                 cluster1 {
                                         core0 {
                                                 thread0 {
                                                         cpu = <0x8005>;
                                                 };
                                                 thread1 {
                                                         cpu = <0x8004>;
                                                 };
                                         };
                                 };
                         };
                         socket1 {
                                 cluster0 {
                                         core0 {
                                                 thread0 {
                                                         cpu = <0x8003>;
                                                 };
                                                 thread1 {
                                                         cpu = <0x8002>;
                                                 };
                                         };
                                 };
                                 cluster1 {
                                         core0 {
                                                 thread0 {
                                                         cpu = <0x8001>;
                                                 };
                                                 thread1 {
                                                         cpu = <0x8000>;
                                                 };
                                         };
                                 };
                         };
                 };

                 cpu@0 {
                         phandle = <0x8007>;
                         reg = <0x00 0x00>;
                 };

                 cpu@1 {
                         phandle = <0x8006>;
                         reg = <0x00 0x01>;
                 };

                 cpu@2 {
                         phandle = <0x8005>;
                         reg = <0x00 0x02>;
                 };

                 cpu@3 {
                         phandle = <0x8004>;
                         reg = <0x00 0x03>;
                 };

                 cpu@4 {
                         phandle = <0x8003>;
                         reg = <0x00 0x04>;
                 };

                 cpu@5 {
                         phandle = <0x8002>;
                         reg = <0x00 0x05>;
                 };

                 cpu@6 {
                         phandle = <0x8001>;
                         reg = <0x00 0x06>;
                 };

                 cpu@7 {
                         phandle = <0x8000>;
                         reg = <0x00 0x07>;
                 };
         };

