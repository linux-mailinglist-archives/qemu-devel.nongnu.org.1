Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A621981E735
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Dec 2023 12:56:40 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rI61n-0004ec-F5; Tue, 26 Dec 2023 06:55:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI61j-0004eQ-IZ
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:55:16 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rI61g-0008Ip-EC
 for qemu-devel@nongnu.org; Tue, 26 Dec 2023 06:55:15 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-40d4ee4cbbcso29820235e9.2
 for <qemu-devel@nongnu.org>; Tue, 26 Dec 2023 03:55:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1703591710; x=1704196510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0RLt0wWdyWg6imwNkuLscoujrh1SIp+Lkfe4BwE965E=;
 b=pKHBG80ydFZDow+xz3ivN7TJ5eVe9dKgqhPOMCm+syXFQESh6HcFZ//No2CE/cPfy7
 OMm+YOqmIQyYrUm++GCz72fYEz61JPox+fHvFRpCFvj3RDwLOwJ+VdrhA3d8XeQYZhh1
 hoKaQh5g+E9rgIZ4vhsKde64DJKYLMIz3w33JpjgYwuI9BAqpr6s/+PJTIV4E4bsRKea
 8VhdzxeGFcE0xGWsqw9zIt07L7JFAR1SalGOFD7nAcIRYWE+M/w+/d1k2eqfd+Nso5qH
 OsZBJ4Whrj4bRVac/Xc/iFM6y5Pwg5svC0dHrKgghwlYgJAlVSnXDfHCchMng4V2ojdT
 +3fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703591710; x=1704196510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0RLt0wWdyWg6imwNkuLscoujrh1SIp+Lkfe4BwE965E=;
 b=K+QdIEkcIfuG6iObAfEgoj1SwD8MZFe0n3qsaN7BYgAL1gS/WlBT1GAlCK3FghyoFA
 ZABYu880dyLtqxgAfzQI8tGKq6No6ioydvTLmx9UugqLxkP7vJYZ4IoXpppy8bpkvhDp
 Ea0LVgdFsOUisV5NBv45gVrXevQIxRJn0t8AXljUQKBKTTo/I49Xl8gK0fEbbKNOeUXa
 By2ui+YEjCgUnwFBgjRuVsECF+FvHdYYvZ6ipLCMqepUiwW5pchTr3sR0jkZKFIH6Gou
 a7B7W9ldGLI4sGekTCgDHs7DvvFlS40I1N7OvqQJfEHge3bcSzuM+qcz7ggzRWQwEFES
 rQcw==
X-Gm-Message-State: AOJu0Ywvqu86gwEt0+bawwUVDev1r75zBO6LS03B8X50WB/iffkkBJDt
 DOOIswKTBVSqHfRe5fpnwWdV1ZCim4d/jmBsSFSYe3zQ+b8=
X-Google-Smtp-Source: AGHT+IHtoklzeZkJ/TAJOzCJCpDN8OSVdqrohhy2LBSKma9U/v5f84VwdtiYoCWzXu80CuxIN/Lxsg==
X-Received: by 2002:a05:600c:468c:b0:40d:4d91:60a7 with SMTP id
 p12-20020a05600c468c00b0040d4d9160a7mr3228703wmo.128.1703591709813; 
 Tue, 26 Dec 2023 03:55:09 -0800 (PST)
Received: from [192.168.96.175] (137.red-95-127-43.staticip.rima-tde.net.
 [95.127.43.137]) by smtp.gmail.com with ESMTPSA id
 s10-20020adfdb0a000000b003367d48520dsm12509840wri.46.2023.12.26.03.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Dec 2023 03:55:09 -0800 (PST)
Message-ID: <58639d51-4530-47cb-a03d-48237a6bf16e@linaro.org>
Date: Tue, 26 Dec 2023 12:55:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/m68k/mcf5206: Embed m5206_timer_state in
 m5206_mbar_state
Content-Language: en-US
To: Thomas Huth <huth@tuxfamily.org>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
References: <20231221122939.11001-1-huth@tuxfamily.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20231221122939.11001-1-huth@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 21/12/23 13:29, Thomas Huth wrote:
> There's no need to explicitely allocate the memory here, we can
> simply embed it into the m5206_mbar_state instead.
> 
> Signed-off-by: Thomas Huth <huth@tuxfamily.org>
> ---
>   hw/m68k/mcf5206.c | 20 ++++++++------------
>   1 file changed, 8 insertions(+), 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


