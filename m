Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C07174A53A
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 22:51:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHVva-0004VC-R1; Thu, 06 Jul 2023 16:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVvY-0004Uz-3V; Thu, 06 Jul 2023 16:50:12 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <danielhb413@gmail.com>)
 id 1qHVvW-000532-H1; Thu, 06 Jul 2023 16:50:11 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-6b5f362f4beso980906a34.2; 
 Thu, 06 Jul 2023 13:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1688676608; x=1691268608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6euJUEjoJcxx+jyv7OneEGA6vqtlfmKNk64IHkM4DA8=;
 b=RiI6fPV7qj2i/eVMhHxjlJ+Alq+qvwPNg8Yuvnpo8yz8b6LHxW0obmniAj7A07q0hb
 KsVzFtJ3w3W6Wg8nPzF0MrseKhC/iFm7uKAZJG52VqYfwouSvCJo9IFSBUSyjVfKrNwJ
 WRppwQLeIQHpqWdc5XZ7j2D9IzC/uWn7fpy1iSlxz0M47oVB2WV6yScUXfszM7djiImr
 t4bUFGQc+d8xb2mrRMdl50uLd5ahZD2PmZYOZNdhyg9HTz238HqQ9zl7XW/fyO+bDrdH
 eBy7JsI03s2IBrGR2bPXPDD4mNLMjeGfb53NJuRzxTjo3fW/5WkDkj/FNWJtVm6SKhTV
 bWXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688676608; x=1691268608;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6euJUEjoJcxx+jyv7OneEGA6vqtlfmKNk64IHkM4DA8=;
 b=jyZCOvA7rf3RWyCS7qI7PR7FXUGf0AiJV0h5hEy0VmrWwWQRcqakyPmEJPY9dX2VU1
 lnTjSjn4luJs6aM0gUWojEfzEc7HuDES1P3QMra4dhLZdOXVwEmltnhwllm3P06GOUiT
 7Tb+Hc5A5x1yC5VJNFQ/lmiyyYc9hDeg8KLMNxoRE0Km2XJkXNh/wXeT2Q8GKT0bvt5k
 XgFjl62yCCF2s8qHGgTuoS00m7VkDILpp83lWrF+AZ5d1M6CwJXtqj1RxJCPddq/tet7
 QfbA2KONjNks0HS0hKtmVmjWryOQY75rrDt2y+i8hOjl2IcOSF5sa5+pCYXCLpWkUOFL
 sVYw==
X-Gm-Message-State: ABy/qLagYTx+uESC30D4owJxQTKe1SJNrWZVPdWrF+I/RYWbKJnrIGku
 0fjJnod5Oya/1euiELx2lSh6SXZB2fY=
X-Google-Smtp-Source: APBJJlF/eaOxyOT6DCOv7wG1+M2JWc5qgzjySIwHA54DA/N1Hpatb66XGvo3UooclPOGx/NkFqBOrg==
X-Received: by 2002:a9d:6393:0:b0:6b8:70a2:cfe9 with SMTP id
 w19-20020a9d6393000000b006b870a2cfe9mr3398800otk.20.1688676608309; 
 Thu, 06 Jul 2023 13:50:08 -0700 (PDT)
Received: from [192.168.68.107] (201-69-66-110.dial-up.telesp.net.br.
 [201.69.66.110]) by smtp.gmail.com with ESMTPSA id
 q6-20020a056830018600b006b87c41a57esm1073286ota.11.2023.07.06.13.50.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jul 2023 13:50:07 -0700 (PDT)
Message-ID: <ba50f55b-1c48-df50-a16c-95f0f51f48f8@gmail.com>
Date: Thu, 6 Jul 2023 17:50:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3] target/ppc: Machine check on invalid real address
 access on POWER9/10
Content-Language: en-US
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 David Gibson <david@gibson.dropbear.id.au>, Greg Kurz <groug@kaod.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20230703120301.45313-1-npiggin@gmail.com>
 <CTUWXISZHAI1.3A3FS0U9SD90B@wheely>
From: Daniel Henrique Barboza <danielhb413@gmail.com>
In-Reply-To: <CTUWXISZHAI1.3A3FS0U9SD90B@wheely>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=danielhb413@gmail.com; helo=mail-ot1-x32f.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, NICE_REPLY_A=-0.091,
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



On 7/6/23 04:32, Nicholas Piggin wrote:
> On Mon Jul 3, 2023 at 10:03 PM AEST, Nicholas Piggin wrote:
>> ppc currently silently accepts invalid real address access. Catch
>> these and turn them into machine checks on POWER9/10 machines.
> 
> Would there be any objections to merging this and the checkstop patch?
> We could disable this one before release if it turns out to cause
> breakage.

I don't have objections but his bad boy has no acks.

Cedric, if you vouch for this change send a R-b and I'll queue this up.


Thanks,


Daniel

> 
> I don't think it needs to rebase, and passes clang build and make check
> here. Just messed up the separator on the changelog of the checkstop
> patch.
> 
> Thanks,
> Nick
> 
> 
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> Since v1:
>> - Only implement this for POWER9/10. Seems like previous IBM processors
>>    may not catch this, trying to get info.
>>
>> Since v2:
>> - Split out from larger series since it is independent.

