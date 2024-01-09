Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 456228283B9
	for <lists+qemu-devel@lfdr.de>; Tue,  9 Jan 2024 11:11:02 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rN944-0002yl-LS; Tue, 09 Jan 2024 05:10:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN943-0002y8-8K
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:10:31 -0500
Received: from mail-qv1-xf2f.google.com ([2607:f8b0:4864:20::f2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rN93o-0003LV-9M
 for qemu-devel@nongnu.org; Tue, 09 Jan 2024 05:10:30 -0500
Received: by mail-qv1-xf2f.google.com with SMTP id
 6a1803df08f44-67f9ace0006so11274226d6.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jan 2024 02:10:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1704795015; x=1705399815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FtTN0Js4pLIM3D8VWSYZPlGx0hfktwGOQRJXuU9wkrU=;
 b=mPOvL60qgcQWIZTXwx8vEq+dtrFa//jIUP5NqJg48ZxO6vv6Kkq5QjMeWPu81/IwuC
 FH3hN+BXqTEiqSfyEi2yiabRBVkWbBPNPCOoJY8xV8r/XEupLdh2dDska1XbG372GVMw
 NdVEFN4xfh8smuyZ5Fkp+Vg7rRX0Cd+N/u8RxuQSaDUbsx3tUpESDolQJzsZ+71qFwfA
 QIlT8PdJenvmatYr+GiC7n4e/P4/SG+d9daYdW5XeZoUw7JEmdopfGW1ooBV5Jy2q2vz
 tIAa/6dwB55r4yh5pX+hbcEOyJXPdeFmmmCzVP/Pa9dUw+kxC4guXzNn5uS8AgH8xvZU
 yDfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1704795015; x=1705399815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FtTN0Js4pLIM3D8VWSYZPlGx0hfktwGOQRJXuU9wkrU=;
 b=gkCaM5tSk4mBpmZzBDlRfRjTEff/fvCn9+beWkdC2mUrRvzoLvaJcBbI7Glb7yGNmk
 vJQkLK0psNr1b5G06Re9kxyEuMUzdj/QoRzPjMnz6FIXio5o1ufq+ApZhn2y3o5E+3Fx
 RMXooMWRPeJ10zBgCEB38MIT3gEYE0hkD4MLUhkPUlJ54L7m2xlSb+qddkK0BciN54um
 94NKCQdtVx0SqAq6cCbfmI6UiwqlUDWi34aEBjZN9kUj9hHz1TpielD4yrnlNqMfVTC2
 qFOPAklZibuje/UhQDRIaO5KNuMVLE0FHGxTghincodPvy6Zz1TbpeWllTvlkuyJkFft
 BHtQ==
X-Gm-Message-State: AOJu0YzmiSGwGNn0uF1egguxRqrETZaZt4W0WjmZXbMhc6DqR19nLkuV
 PrTxu7Sy3Bcrk5AxMFMp826QEut4UTFy7g==
X-Google-Smtp-Source: AGHT+IG+TcpjjrIhCG12Fr/QhLX2NwsPx8u4c+YQd1kbx23ikHsJF+Dw9D9Y8/AEWyPQ5mP/ASu5qw==
X-Received: by 2002:a05:6214:2b09:b0:680:d265:6652 with SMTP id
 jx9-20020a0562142b0900b00680d2656652mr4023232qvb.83.1704795015029; 
 Tue, 09 Jan 2024 02:10:15 -0800 (PST)
Received: from [192.168.40.227] ([172.58.27.248])
 by smtp.gmail.com with ESMTPSA id
 z8-20020a0cfec8000000b00681092cb7b4sm756712qvs.103.2024.01.09.02.10.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 09 Jan 2024 02:10:14 -0800 (PST)
Message-ID: <dbeaf8b4-8b5f-43ca-9360-606f99da7ed9@linaro.org>
Date: Tue, 9 Jan 2024 21:10:04 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: testing without the translation cache
Content-Language: en-US
To: Brian Cain <bcain@quicinc.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
Cc: Sid Manning <sidneym@quicinc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Matheus Bernardino (QUIC)" <quic_mathbern@quicinc.com>
References: <SN6PR02MB420583215DEF63E921BBB758B86B2@SN6PR02MB4205.namprd02.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <SN6PR02MB420583215DEF63E921BBB758B86B2@SN6PR02MB4205.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2f;
 envelope-from=richard.henderson@linaro.org; helo=mail-qv1-xf2f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 1/9/24 09:34, Brian Cain wrote:
> Alex,
> 
> A very long time ago QEMU supported disabling the translation cache via “-translation 
> no-cache”.  That option was deliberately removed.  We are looking into a hexagon-specific 
> failure when there’s a TB lookup miss from a cpu_loop_exit_restore().   I’d like to test 
> our fix for this failure and was wondering if there’s any mechanism to disable the cache.  
> There’s a “-accel tcg,tb-size=0” – but this won’t accomplish what I’m looking to do – will 
> it?  If not, is there another way to disable the cache?

There is no way to disable the cache, only to make it small so that it overflows often.


r~


