Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 89FA674AED1
	for <lists+qemu-devel@lfdr.de>; Fri,  7 Jul 2023 12:38:01 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHiqL-0003io-JH; Fri, 07 Jul 2023 06:37:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHiq9-0003Sw-5Z
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:37:30 -0400
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qHiq7-0005TU-KP
 for qemu-devel@nongnu.org; Fri, 07 Jul 2023 06:37:28 -0400
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-4fbc0314a7bso2700735e87.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jul 2023 03:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688726246; x=1691318246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZbEBsRqCFQakLXTfzhvUlLRM0RGI+OBD8s0upgSeKdU=;
 b=QKiCKzvVPv5SLdkX9i2nYyjjk548yz5hAk/wz/SjRwKjIzZtsOAYodYgVCxHyhgEXs
 4IIhYbt2u+WXZMW/EmqtuD9hdvxL2/R4No48oo/WIdK2RvBh52r7tfaUW6XfykHPOfS5
 S5H+c+Z+tvk4ha4gDVGX7TuI33wFHprte0So5l7mmq9LxhCnALGxANhxJJr6PcCNbVHi
 Ax+sa7NkTFMnyzuJL9ebvw6EAGd+dZFslvG1ZUcK9qVjL8+PYjrzm3JuGZaE3dC81guu
 8fkLbgO3yO7rvxh8xZdf/Do2BSKq5QxXSWnALvnbr5w8Qu9hXLFaqGEWVnu1Q9WUfv4d
 dKOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688726246; x=1691318246;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZbEBsRqCFQakLXTfzhvUlLRM0RGI+OBD8s0upgSeKdU=;
 b=cLtva1iTBIJXUmw61LyBnlFxfx9vRn8IAguI1pzVi1LCgzRBMTFBzVMi3zy3Fc2nUX
 FhPulgu0/DfnxTZEUPLAbrIuUtUa/91Zam8TyEQFelY4yLW31L/YZm6BIkvSVrhUvkGS
 b298iVgNvOt9EXBySR9R22A/A9oPEle4Ty3h9329aPX/X3Off5Z8MakjiYfQDC4LSZQg
 UL0cUdZCgtjVXz66bZsoiMQyh1pL5QXWtFdg9CtX0ahsw7gXtb47UC+WZJQ7LX1nm7p2
 Q1W89S2KoF37Wgdr8Eu6C9ZwNtV+FIU2z8cCcrkU1NbdEdjqg1hPu/EkzthcOlDvW7el
 ssrg==
X-Gm-Message-State: ABy/qLY1gBBba2ILo6s+XpfEhzq66yc9zU3YqFkOXqVJswRyoDod2Xm+
 Zpg+A3YcJqCxExxx2HczpQbhvA==
X-Google-Smtp-Source: APBJJlG1YnyDsdbf9lo/j4co7eqTzTFyF55oP793ebEkWNHhx6PAacjWhMdkDoviBfO+GVg2lgiE6g==
X-Received: by 2002:a19:ca48:0:b0:4f7:6775:2a66 with SMTP id
 h8-20020a19ca48000000b004f767752a66mr3208491lfj.53.1688726245701; 
 Fri, 07 Jul 2023 03:37:25 -0700 (PDT)
Received: from [192.168.82.227] ([91.223.100.9])
 by smtp.gmail.com with ESMTPSA id
 eq18-20020a056512489200b004f4b42e2d7dsm628716lfb.230.2023.07.07.03.37.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jul 2023 03:37:25 -0700 (PDT)
Message-ID: <5f63f6fa-7829-dbf1-6f9f-7c51dee44455@linaro.org>
Date: Fri, 7 Jul 2023 11:37:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/2] accel/tcg: Split out cpu_exec_longjmp_cleanup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: rjones@redhat.com, peterz@infradead.org, arnd@arndb.de,
 naresh.kamboju@linaro.org, anders.roxell@linaro.org, daniel.diaz@linaro.org,
 ben.copeland@linaro.org, pbonzini@redhat.com
References: <20230706170537.95959-1-richard.henderson@linaro.org>
 <20230706170537.95959-2-richard.henderson@linaro.org>
 <7de8bc57-ffd8-d259-8426-3d8a0c4cde44@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <7de8bc57-ffd8-d259-8426-3d8a0c4cde44@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=richard.henderson@linaro.org; helo=mail-lf1-x130.google.com
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

On 7/7/23 09:09, Philippe Mathieu-Daudé wrote:
> On 6/7/23 19:05, Richard Henderson wrote:
>> Share the setjmp cleanup between cpu_exec_step_atomic
>> and cpu_exec_setjmp.
>>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>   accel/tcg/cpu-exec.c | 43 +++++++++++++++++++------------------------
>>   1 file changed, 19 insertions(+), 24 deletions(-)
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 

Sorry, Phil, missed applying this this morning before sending v2.
I'll update the branch now.


r~

