Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A7667873BD
	for <lists+qemu-devel@lfdr.de>; Thu, 24 Aug 2023 17:10:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qZBy7-0006Uj-3L; Thu, 24 Aug 2023 11:09:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZBy5-0006Td-CM
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:09:53 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qZBy3-0007e2-5y
 for qemu-devel@nongnu.org; Thu, 24 Aug 2023 11:09:53 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-317f1c480eeso5963557f8f.2
 for <qemu-devel@nongnu.org>; Thu, 24 Aug 2023 08:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692889789; x=1693494589;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6gV6I3xfy/hyfKDidqkpk7fy5DI5Iz3O/ffqQXi+d2A=;
 b=lV/hz2C3k8xE0X4ZIkTcM07by1ZiQ10G17UtGwoXMCVmDEgjwDn6arEm6rpVFFV45A
 UoQF4x30LBv4KhAC0iwNCJ+uHUjcY/UvX0KRm1wg/h929xk69YgyrT3w//rLMvTWcaAy
 rBKnkBnvTh6lb6NGZCUVBJNY9rQbNdV4GVTcPuckoarsjtwj4gyT5OtXSrExKzbL0QVI
 yR+1xbsFax9+kuBcP1Ki0YKp8uQktXrRzZf+0vvaJH34lw8UwADV1tnJyD8MP8HgQfOa
 JrIRoXiPa5iun0yTWzrZa1BrOvgZy4rPyJAZhpP0bq30ksD2/g+BZhz2kCllKyhZ8YQA
 ksBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692889789; x=1693494589;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6gV6I3xfy/hyfKDidqkpk7fy5DI5Iz3O/ffqQXi+d2A=;
 b=hE4gcnVvS7w71bs7HuteyYTLcIUc70Fh3rKxmeLbhcZb6Irv+FnjsEjPgJZoM0v4p4
 Ew8DQRPfTcPy6Z+uKFNPeFazSPkeF2ZExmIgqQhbBWCgXJKO7/AperbokoDJiGMFCWd/
 e6rPdoC8gp+kptbJtDU0wLS7dzXVjEaPRmmB64JvRWVnLTZaGDSkj/3Z/ifc9hLCQWRf
 40DLUWEjVSfHz0C+TxsQayfKtJeNyL3pGwxLf1uvVQGaeaQnDIZQ+UsrxsZo3AEPGnKN
 +riW8jBdSW2kyBeAinAlVwFZuUifistn18tcR0PI8qHDv2zcAL7KUVPhB8iGElVggGJi
 mq6w==
X-Gm-Message-State: AOJu0Yye7TBWzBbbt9REYr7xLJSHAmOKsaph6015bhK1baeKftHY+TJg
 fD5A87s6CnPeHMtER5dpapyFfgo/yOEy4xsBdWo=
X-Google-Smtp-Source: AGHT+IFy5aHi1TJBsq6Q7W0oLcXZ5KPO5x2IM1840vZq2iFdJrDCJzxlmXpwQ44I1ARDPmSWLRWndw==
X-Received: by 2002:a5d:4573:0:b0:313:ebf3:f817 with SMTP id
 a19-20020a5d4573000000b00313ebf3f817mr11728285wrc.22.1692889788989; 
 Thu, 24 Aug 2023 08:09:48 -0700 (PDT)
Received: from [192.168.69.115] ([176.164.238.90])
 by smtp.gmail.com with ESMTPSA id
 w1-20020a5d6081000000b0031773e3cf46sm22335601wrt.61.2023.08.24.08.09.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Aug 2023 08:09:48 -0700 (PDT)
Message-ID: <7a42f1f9-c492-f6ff-fd4d-2c84052835de@linaro.org>
Date: Thu, 24 Aug 2023 17:09:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [POC 2/2] add test exposing AHCI reset issue
Content-Language: en-US
To: Fiona Ebner <f.ebner@proxmox.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, lvivier@redhat.com, pbonzini@redhat.com,
 srowe@mose.org.uk, mike.maslenkin@gmail.com, qemu-block@nongnu.org,
 t.lamprecht@proxmox.com, a.lauterer@proxmox.com
References: <20230824133831.617833-1-f.ebner@proxmox.com>
 <20230824133831.617833-2-f.ebner@proxmox.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230824133831.617833-2-f.ebner@proxmox.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.919,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 24/8/23 15:38, Fiona Ebner wrote:
> Fails without the previous commit "hw/ide: reset: cancel async DMA
> operation before reseting state".
> 
> I haven't ever written such a test before, but I wanted something to
> expose the problem more easily. It hardcodes the behavior that the
> pending write actually is done during reset, which might not be ideal.
> It could just check that the first sector is still intact instead.
> 
> If I should make this a proper test, I'd be happy about some guidance,
> but not sure if required for such a specific one-off issue. After all,
> a different variation of the bug might have written to some other
> sector not covered by this test.
> 
> Signed-off-by: Fiona Ebner <f.ebner@proxmox.com>
> ---
>   tests/qtest/ahci-test.c | 81 +++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 81 insertions(+)

Per our style, variables are allocated on function prologue,
otherwise the test LGTM:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


