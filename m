Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3EA704F55
	for <lists+qemu-devel@lfdr.de>; Tue, 16 May 2023 15:30:34 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pyukS-00023M-52; Tue, 16 May 2023 09:29:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyukP-00020K-Iu
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:29:49 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1pyukN-0007sO-S8
 for qemu-devel@nongnu.org; Tue, 16 May 2023 09:29:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1ab13da70a3so137035945ad.1
 for <qemu-devel@nongnu.org>; Tue, 16 May 2023 06:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684243786; x=1686835786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K/oA4c+2kq4EQBn0hR2ZekbXOtXn2MOwpDAGpPiYsIA=;
 b=lueUU1/a8lGXML2uIviJlrbtUBBuRPvG/aLap5SnKxebZ4JqzBXo/3GeBckyJa4PaY
 QUW3pElgTtQwk/drj6b4p1pmn29PhLPXehWHWINARLA2vxDLNUlXAwTl3bUzPcvoZnKf
 qeKJYJ29UFBIMtdlaFJP8BOw+q96n4AK3pw+S58Nf3Gr5hRTkH379N3Kb1Iz9i8zfa1r
 fJV0xRk2wuTRNT+svDNVrGNpl8CAu8FZ3ADbjNU5mh0ZPw/HLrz0i8EXO751mlQj40C2
 8LcvtCrhccAeeTgk3cQU0LvndSN2MCvdhnA5J91c5lU/I2Mye97X74CJ5qevQ3Q53JMb
 FxSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684243786; x=1686835786;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K/oA4c+2kq4EQBn0hR2ZekbXOtXn2MOwpDAGpPiYsIA=;
 b=iLciCfDVhNozeuUXtdkcc04SNHf+JsIggediHhlBEvwmoYOStPdgLWcVx6LuuIZwiq
 HYu+0UiU3rrd/PR1ePab5BVdbLDyoQaGL31JYABQ/TsXxfArJ2IwYsty7QuePe0/U7lU
 iB5w6WZ0AbbgX8x6joL7W54nkcXP8kEK/y86LEoWlbMJnUlXvzjzmJmOcVDtxFn33oRx
 1mIzqEq5HUnyYDUzQr5ARxV+3FKV1xIjKmb6f/fM1btnYtQxcGm4U6K8SZ0yv89S8L/k
 cnRQZYho3jMeyMV4TwntXVMOfTgeKiarf+VTwWZrcE9xOGEugeuVIzMc1e9r7lEgB4aY
 Hhvw==
X-Gm-Message-State: AC+VfDyIa+Nn/g/oc4OLX6fSo3yqXn8bKCBY2ish/WqXx2H0uH0GAMuO
 njBJjef0YHm1+CJgyOapXeb4mg==
X-Google-Smtp-Source: ACHHUZ7OTh9LJNHHNHl0XA6szY01kdYggDwnucHgf7lKbAPu+lxDKP0zZn9QoF1KmY+UchEgFOZ2og==
X-Received: by 2002:a17:902:db08:b0:1ad:e198:c4f2 with SMTP id
 m8-20020a170902db0800b001ade198c4f2mr18943274plx.18.1684243785959; 
 Tue, 16 May 2023 06:29:45 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:ec81:440e:33a4:40b9?
 ([2602:ae:1598:4c01:ec81:440e:33a4:40b9])
 by smtp.gmail.com with ESMTPSA id
 m5-20020a170902db0500b001ac7f583f72sm15460163plx.209.2023.05.16.06.29.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 May 2023 06:29:45 -0700 (PDT)
Message-ID: <d8faf35f-ec66-9bce-e34e-4bde0b4fcd24@linaro.org>
Date: Tue, 16 May 2023 06:29:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] qapi/parser: Fix type hints
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com
References: <20230511111709.971477-1-armbru@redhat.com>
 <cb6582b2-9542-4ebb-d188-34287f9fb3dd@linaro.org>
 <87sfbwx339.fsf@pond.sub.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <87sfbwx339.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.666,
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

On 5/15/23 22:22, Markus Armbruster wrote:
>> https://gitlab.com/qemu-project/qemu/-/jobs/4289613692#L574
>>
>>    File "/builds/qemu-project/qemu/scripts/qapi/parser.py", line 566, in QAPIDoc
>>      def _match_at_name_colon(string: str) -> Optional[re.Match[str]]:
>> TypeError: 'type' object is not subscriptable
> 
> Life's too short for wrestling with such pigs.  Unless John has better
> ideas, I'll *remove* these return type annotations.  Maybe these pigs
> will behave after John's Python venv work lands.
> 

That is exactly the idea that I had as well.

r~

