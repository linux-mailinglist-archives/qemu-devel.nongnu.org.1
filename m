Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C73CB8307A9
	for <lists+qemu-devel@lfdr.de>; Wed, 17 Jan 2024 15:12:32 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rQ6dN-0001fL-Gc; Wed, 17 Jan 2024 09:11:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6dL-0001el-HJ
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:11 -0500
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rQ6dJ-0002Yb-T4
 for qemu-devel@nongnu.org; Wed, 17 Jan 2024 09:11:11 -0500
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a2dda9d67ceso366511866b.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jan 2024 06:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1705500668; x=1706105468; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u+pqUiRWhykiVeOu13nHBhA2bPaBp+OyNTb+94/gvY8=;
 b=hn7o/oldoksMyQoORrfSXp0cilVJ2PSX10wLP0HtaTsmmZIDzBDzvSCRuEIFbrpPHJ
 kUuvQiwyXJbJChF9FizpFKkbkdyzrZgrvSUY0s2dZt0RQ7OlzG7RAXlV9gqi7G37lQ6Y
 Nni6EkeMiihK+guF7v9Gvf37CUNZxOzh2x0w7hv0dosHznUnDaAQezhU1lrwK7+BlLzn
 aZLWtwny09vP5QNi47O++CQg1pJJ2rbc/mb3eVpTfFVywdCdpeelI78EXt1eGJbx4pNs
 yr2BkKVHYaVtVE1NgWDeW7K236p3KAf30wCatph54NPpzwfRljGS9c1m8RX5fb6vD/WF
 uvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705500668; x=1706105468;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u+pqUiRWhykiVeOu13nHBhA2bPaBp+OyNTb+94/gvY8=;
 b=PJBO6z3Lm7v6S0FEj4d3L79kF96/VfRZcv7qs+wUSnkPjWsn8KNep8Zze0EWz+vvEx
 vkrmHC2ddQ9jgRlFdFmrd8yS/hG/Ij9AoinU312nuzHM/0ga8uwx6xwZOufXJm6wtAPZ
 OCiLAqr+SCq1EkS1McvEwzHUcHeU2Z4YuTh10UNu3xvN9LbJyVnlWJ8SpSepvKZxeoGm
 Kl/T9tvrooGX4YuexlBdFdWWZpYIAwzIdccf6f/4VUlVGI5y7zwSRrcBNB+CIDd8tDSd
 oI6n2AkdLpuLQ4r30sCP6qeWkFMUGCsRI2/+n9A7em+xkO2hI2SAWx9+XK9DhY5Io/rS
 9l7g==
X-Gm-Message-State: AOJu0YyXazM1s4OxHzQZ0Ykfbk4PEuaOClS7CK2x3CfgWzkULRdWPWvo
 NmWiw69AuuZ4fxfpsy6ayLYzeTiKr/Wssg==
X-Google-Smtp-Source: AGHT+IFeypG5qMz4NKVvsWnmpwgUaEeFX1GVywiPf7jMEXpAb9hs6g7sFBU1AG2Xh4qk01MtEmh/LQ==
X-Received: by 2002:a17:907:94d3:b0:a28:a9f4:5b85 with SMTP id
 dn19-20020a17090794d300b00a28a9f45b85mr5225451ejc.58.1705500668154; 
 Wed, 17 Jan 2024 06:11:08 -0800 (PST)
Received: from [192.168.69.100] ([176.187.212.26])
 by smtp.gmail.com with ESMTPSA id
 vw13-20020a170907a70d00b00a2e92247a1fsm1681587ejc.62.2024.01.17.06.11.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jan 2024 06:11:07 -0800 (PST)
Message-ID: <2d6aa6a4-c7e9-435a-81f2-9adac94825c3@linaro.org>
Date: Wed, 17 Jan 2024 15:11:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] qemu-options: Remove the deprecated -singlestep option
Content-Language: en-US
To: Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?=
 <berrange@redhat.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
References: <20240112100059.965041-1-thuth@redhat.com>
 <20240112100059.965041-6-thuth@redhat.com> <87y1coi116.fsf@pond.sub.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <87y1coi116.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

On 17/1/24 13:42, Markus Armbruster wrote:
> Thomas Huth <thuth@redhat.com> writes:
> 
>> It's been marked as deprecated since QEMU 8.1, so it should be fine
>> to remove this now.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
> 
> Should we drop HMP command singlestep, too?

Yes, patch on the way.


