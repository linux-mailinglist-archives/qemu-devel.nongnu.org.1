Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 62A2C7C8388
	for <lists+qemu-devel@lfdr.de>; Fri, 13 Oct 2023 12:45:27 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qrFex-0001D5-5F; Fri, 13 Oct 2023 06:44:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrFet-0001AY-DU
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:44:43 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1qrFer-0006GK-Rx
 for qemu-devel@nongnu.org; Fri, 13 Oct 2023 06:44:43 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-99c3d3c3db9so310554566b.3
 for <qemu-devel@nongnu.org>; Fri, 13 Oct 2023 03:44:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1697193880; x=1697798680; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2wHLSAdjLeNF2/FQgsGVCLY74CY9RHO/j4MK/K7oNks=;
 b=VB0tIKOYKcOBZ4kzCPD22R5H8QrQvNJgHrfCsSHIYERrfkUH62k8YiWBFFgOIG2oVb
 RpWH/PdcDJNU6sI+PCwHKhKnPVHJbLy1bgpDKJSyIb9uBlmOsPgh0g3QcouN1fRo/Vi9
 kQm63e/mTJdYIAepeub1+1A7qtNUTgai71IxYxY1LaucNJFqEyBSZtMU4g203RqfWbCX
 WZ0YWpGyXaf2iJanT1qgiwk7ocveQ1XD6/mjeS0wGLNQ7R/X5U0tnVL1V0g/jkZvBO2J
 wJV/smQAbLzlN+cYYQFNJJEg6l6GoW+dQrEwEL82NENPQ3rL3cRrzaPn/jpMUkoUv7HQ
 7nKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697193880; x=1697798680;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2wHLSAdjLeNF2/FQgsGVCLY74CY9RHO/j4MK/K7oNks=;
 b=WsNEmTVOrfDsoBTXvrkl1gbZaWMcHQ36OrBkqJzHaj5Y8lnkFdHM8w4xtBv550/tv9
 5DT7B1qcx+YLDXLU/C7Gt8J9Y0WrhDt78qC3HBf5kzWUJe7u4MDl1wSUukTpkM7wW6na
 3l+w0WRoR1AcdEPYqmoZd9ZKZq64U7DlpKLeU3IEJ84PpnFKkzR9oS1ZG03ZXTn9uBFA
 EHejcXzS3l4vILUPoHqSQJ4WCr3PO31ScR8UPj2Hb8jrpLAQoqr/qVE5ZIlOljmyqiRi
 Cj3cGtrznkYB9i2vQl5O2je00Wm3oGxDPPsk60H6DCDUMv6vjaq/9hNAJ23OavCZeqXd
 2mBg==
X-Gm-Message-State: AOJu0Yx141344MrDttCoDKPs/YvUXrKvDGwL7g/+klpJS3kBoS90MRPm
 aEkF7BV4lVp1IjEqaISp7qwBp4Kt/2q3JwROINs=
X-Google-Smtp-Source: AGHT+IEwFbeRtgpqut7TrOtoz9a/yb70BsGxJ3uhWMdbzbW8gaBv++afntc2ce0hLxuK8Tb9BWKFlg==
X-Received: by 2002:a17:907:7787:b0:9b2:6f52:586d with SMTP id
 ky7-20020a170907778700b009b26f52586dmr23757157ejc.50.1697193880220; 
 Fri, 13 Oct 2023 03:44:40 -0700 (PDT)
Received: from [192.168.69.115] ([176.172.118.168])
 by smtp.gmail.com with ESMTPSA id
 g7-20020a1709067c4700b009ad88839665sm12321082ejp.70.2023.10.13.03.44.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Oct 2023 03:44:39 -0700 (PDT)
Message-ID: <45a43795-d9fe-41e7-029d-34ffa1def192@linaro.org>
Date: Fri, 13 Oct 2023 12:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [RFC PATCH v3 00/78] Strict disable implicit fallthrough
Content-Language: en-US
To: Emmanouil Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-devel@nongnu.org
References: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <cover.1697186560.git.manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x631.google.com
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.339,
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

On 13/10/23 10:45, Emmanouil Pitsidianakis wrote:
> --
> Resending because --function-context was accidentally used in the
> previous version. Sincere apologies for the noise.

Thanks. TBH I discarded v1/v2 for that reason.

> --
> 
> Hello,
> 
> This RFC is inspired by the kernel's move to -Wimplicit-fallthrough=3
> back in 2019.[0]
> We take one step (or two) further by increasing it to 5 which rejects
> fall through comments and requires an attribute statement.


