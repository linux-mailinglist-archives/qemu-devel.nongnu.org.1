Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id AA6B97DB568
	for <lists+qemu-devel@lfdr.de>; Mon, 30 Oct 2023 09:48:16 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qxNvv-0008ME-GE; Mon, 30 Oct 2023 04:47:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxNvt-0008Lo-A9
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:47:37 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qxNvr-0006EW-Qd
 for qemu-devel@nongnu.org; Mon, 30 Oct 2023 04:47:37 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-313e742a787so2370365f8f.1
 for <qemu-devel@nongnu.org>; Mon, 30 Oct 2023 01:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698655651; x=1699260451; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uZFt+iX/VdIt8zF1JJDuvkFPjV9LsKLkjBi1n3iR7fc=;
 b=EZVMgnNLrJ7C22x3m9Bzzwzwu9/qLUsdAZO5BzNeNcsV20m6/M6i5Nha2k3sxqax5u
 7KkOiDJNDGnxDdn5YFE2VRN6vQ/rYUMU7SkL3WMFUcBBkawI7oYms5k4MHEPiSyL8hT+
 M5nIlbSDRxyjLycMrrP38IrovXn5jFUqxzWuROcoqkxWU2h6n/N1p3I5RKQz8XkGmaZe
 uP5YsOBTRAgr1ThISKSTrF9+e8xm+mjZOrIL1XH0BIaXSaFnomNrIbkU+mpOIWfcrckX
 NZ5fyOeOtT1En6HLgYuOI3iUu7SL77lukezMW1f0UgD7ygOEqyCmq+kF302tM5ISN2m6
 PZ5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698655651; x=1699260451;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uZFt+iX/VdIt8zF1JJDuvkFPjV9LsKLkjBi1n3iR7fc=;
 b=HmisFrEaxGEdtgwahOT6jyKokMXGZ3AMNlYFJ/lc4MaflIyVRjFgxtKy5LcvLgwQiQ
 CNc/zKhQiyWcjfE7Iic2OKZqcSSdfMM9ZQZ+1881WqZmWLO321IkOVE9uqNo/ZA8s1fN
 RF/bAGpjptkA/g6LwhMLzh1fI4BYi0pjkxqpYg1tqXSYLl1Df76/zpMGavqzhgq9twvV
 T+pieOTMoijap9iRPXkhoxDhtbIdgkxVu6BkHcfDXpJ7l1F13s0fVFURQVgJuWOsH2lU
 IyuVSLcVZW6YaoN0qlwhaxbXMrdNN9LeFdHknQ3i+BSVudquela4uLomdG3RA68rdBDg
 3ITw==
X-Gm-Message-State: AOJu0Yw3sWNQFKKxv9kGMJaNm248clXDhg1jGTpjwb51o9os/rxKNB70
 4qSlAkLf+I+yqf89o2GHPUA04w==
X-Google-Smtp-Source: AGHT+IE1huV5Ma28JuGOrz3MQtM141X04sTllvV6zEJ3vB/CrhZ7biZ72OjabUn8IBcOebyHBtxnSQ==
X-Received: by 2002:a05:6000:178e:b0:32f:8c9a:67 with SMTP id
 e14-20020a056000178e00b0032f8c9a0067mr562627wrg.0.1698655651169; 
 Mon, 30 Oct 2023 01:47:31 -0700 (PDT)
Received: from [192.168.69.115] ([176.170.212.50])
 by smtp.gmail.com with ESMTPSA id
 x14-20020a5d444e000000b0031980294e9fsm7738786wrr.116.2023.10.30.01.47.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 30 Oct 2023 01:47:30 -0700 (PDT)
Message-ID: <96d26981-a0e7-fdfa-844e-18ddabba79cf@linaro.org>
Date: Mon, 30 Oct 2023 09:47:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH v6 5/5] default-configs: Add TARGET_XML_FILES definition
Content-Language: en-US
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Mikhail Tyutin <m.tyutin@yadro.com>, Aleksandr Anenkov
 <a.anenkov@yadro.com>, qemu-devel@nongnu.org, Fabiano Rosas
 <farosas@suse.de>, Laurent Vivier <laurent@vivier.eu>
References: <20231030054834.39145-1-akihiko.odaki@daynix.com>
 <20231030054834.39145-6-akihiko.odaki@daynix.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20231030054834.39145-6-akihiko.odaki@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.972,
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

On 30/10/23 06:46, Akihiko Odaki wrote:
> loongarch64-linux-user has references to XML files so include them.
> 
> Fixes: d32688ecdb ("default-configs: Add loongarch linux-user support")
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
>   configs/targets/loongarch64-linux-user.mak | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


