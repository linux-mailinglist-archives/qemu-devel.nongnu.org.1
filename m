Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9F273575D
	for <lists+qemu-devel@lfdr.de>; Mon, 19 Jun 2023 14:53:05 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBEMz-0005Eg-L0; Mon, 19 Jun 2023 08:52:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBEMy-0005EK-2L
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:52:32 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcin.juszkiewicz@linaro.org>)
 id 1qBEMw-00061U-Hp
 for qemu-devel@nongnu.org; Mon, 19 Jun 2023 08:52:31 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-9741caaf9d4so416093166b.0
 for <qemu-devel@nongnu.org>; Mon, 19 Jun 2023 05:52:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687179148; x=1689771148;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=WHg6Kxw9oXcCg7qjcrpufZ3GjlvbaQFLwe7ZCIiP6Gc=;
 b=ox14YewVLqPkvwugigYhgQ9ioo7sOjwLh1ImBtb8eNdtxX4wexavEhru7gTzcry+t1
 tX2Nkk0iLAhNAQqh3ElUK9CNiXSUaOtbyTd87iddPGB7zB/G3cIeAOw+C9r3PJcIR++6
 A9ORHe3/J+YT9jDso1RU5qNolLDHi+/wawSjlkIAVX7VYP8JJZZxGJ56/BT/WqZd1+PC
 HkV6En/LwUmyqp2y2J9ZyyEsGvPBvZF+7gwesBP3w17K9iEeZChK0x4myq6IoCu1sI1u
 ljeMnVQCXSskjt4UzY8OmoRO4Nif+CIOc7WIG23SN7izUatd7lx/MIcediupVDBJ8npj
 dfgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687179148; x=1689771148;
 h=content-transfer-encoding:in-reply-to:organization:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WHg6Kxw9oXcCg7qjcrpufZ3GjlvbaQFLwe7ZCIiP6Gc=;
 b=lipGfi+eN2RXEl3kpcQXetvhaZ6jL+l22uq69A0MInPqEYi0n0/H7jxBQXv70/Tifu
 +/iAv6li4hiLQYDpC3KVyoOomtexHtU7uU5OtBQdYTpHM+N6pLyMp+mQL/iHA7foaW6m
 cxJ3MYQ2fkVhTvcGEE4n3dxxmE+h2PmJFBniSj4T+a/9llYwLOjRm+ftEDeu1a/BBmxs
 DohJS/7BbK5FZrTc8juX+plDy14bXB7lGyueVsVAVr9L+ipbtxn5dPwsFKb0Zeis6CTd
 LhrmQjZAcfcNUoH9ry8CkG3esM1F2elyzEUSYPxonq0JwssyqewiEypVGFFJBYIeOmbZ
 n53w==
X-Gm-Message-State: AC+VfDyKznzN7BUtIpZ2V1/t6o++inr06A1hUIva/23TcMswd2tFg3iA
 TYDwWgM0wqCddmuz1OrjLwaM+w==
X-Google-Smtp-Source: ACHHUZ7XpkfX8RkyyEpZPJ3GCEYyKJPdrlOv9sEQvBxGbrn2jjMx1/H5gZ4B6wCjbkJKySpf4Uxp4g==
X-Received: by 2002:a17:907:94c1:b0:982:7d5f:f608 with SMTP id
 dn1-20020a17090794c100b009827d5ff608mr8168803ejc.46.1687179148621; 
 Mon, 19 Jun 2023 05:52:28 -0700 (PDT)
Received: from [192.168.200.206] (83.11.39.176.ipv4.supernova.orange.pl.
 [83.11.39.176]) by smtp.gmail.com with ESMTPSA id
 pv19-20020a170907209300b00988ac5482c3sm1403585ejb.69.2023.06.19.05.52.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jun 2023 05:52:28 -0700 (PDT)
Message-ID: <25d9a1e1-7e02-5cc2-ba14-83c47c93a514@linaro.org>
Date: Mon, 19 Jun 2023 14:52:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH 1/1] docs: sbsa: document board to firmware interface
Content-Language: pl-PL, en-GB, en-HK
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Leif Lindholm <quic_llindhol@quicinc.com>,
 Radoslaw Biernacki <rad@semihalf.com>
References: <20230531171834.236569-1-marcin.juszkiewicz@linaro.org>
 <CAFEAcA9dA_Siv5aKbF8Fj6nqm5KsuzU=qjEgiFC2KR6AhyaoDg@mail.gmail.com>
From: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Organization: Linaro
In-Reply-To: <CAFEAcA9dA_Siv5aKbF8Fj6nqm5KsuzU=qjEgiFC2KR6AhyaoDg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=marcin.juszkiewicz@linaro.org; helo=mail-ej1-x632.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.09,
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

W dniu 19.06.2023 o 14:41, Peter Maydell pisze:
> I'm going to apply this to target-arm.next with this squashed in
> to fix a few grammar/format nits and add some text from the comment
> in the source file about the platform version part.

Thanks.

My English grammar sucks so I am glad that you looked and improved that 
text.

