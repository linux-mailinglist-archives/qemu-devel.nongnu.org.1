Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1173E7113B2
	for <lists+qemu-devel@lfdr.de>; Thu, 25 May 2023 20:30:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2FiO-0006it-5T; Thu, 25 May 2023 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FiL-0006id-FI
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:29:29 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2FiJ-0002GS-Po
 for qemu-devel@nongnu.org; Thu, 25 May 2023 14:29:29 -0400
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-64d2467d640so74590b3a.1
 for <qemu-devel@nongnu.org>; Thu, 25 May 2023 11:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685039366; x=1687631366;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uKACPzrv6hqkGClezXwchSBgyJy8s7TNKnVLvoRITzI=;
 b=rs56Wi506GIkPS8oLYET9caO4wgmqfdm76qyKu1y5q2GVSIsB5hbZt9GVCYYtEXC/u
 9Wq1gCp9nPRtJACfQMqdfJLCzh0N69OsKB8LQ4iymJR0e5oB87ZzyFtRYqmaLvzzf5YU
 BcyArG2hNpeIWZebiQGEiy3y7379VV27HmX8IPMnMmwFgcURb8KLApCXyWQMyYHXgva/
 i2G3dhTJPNNoBimhNCG5jSJtnY3j8U2FMzm7zZ9XLqIahOrxkEieqpCLSb75z1Eb4qKN
 8ygcl12CktmX+Na2uaD0AUDnfiQgiCHMROEl0GyK6EZ/zmsgwvZ+XHG50D3/PcJlvsNi
 ACAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685039366; x=1687631366;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uKACPzrv6hqkGClezXwchSBgyJy8s7TNKnVLvoRITzI=;
 b=WqRiWzfigyHCxvMFcOtlJbz9WkVpeY+cVMATwvx1E/KAjKuNHuf+gI70J8jhP/cKOI
 ipE8tpFmYFYYviVS5S6AVqE0qZ66hqTUHec86fJVmjmswSL5CQozski8eSHEsYRgWB5/
 iZq/D1g46iMCZXU7EReEyeLSROKK6mtseA7Duo/mVY9aZWAo1lx7mcgRPlLV4Qceb0Rg
 ga6fAkS4gKBsXBMZnduIeah4uR9YKJ0gN+Nrn/t9q2VooZYbFwrmwG5anTrodvVsIxn7
 NJQOrl10YiizJxI5GFsyNoApTgTFoqTdlZcP+PoS8dbvaJkpqMJsxX7BJpSU8tqAXphd
 9CJw==
X-Gm-Message-State: AC+VfDztaGOvK68sxNBFmA+/KjWMldI6WQKx1AQBcE9NQlSCJsXjcHqM
 9oXwtQqUmK66sTo/Ebax3uQGdebxFYnEbS0EMow=
X-Google-Smtp-Source: ACHHUZ4fWhO/omS9SQwvLCjYcx6pJc29grUYRa5QnXzMkFxKCZlTFtl/DAl8fTC6fsx/aWB0uUw/xQ==
X-Received: by 2002:a05:6a20:4423:b0:10c:14c2:b766 with SMTP id
 ce35-20020a056a20442300b0010c14c2b766mr15282331pzb.35.1685039365687; 
 Thu, 25 May 2023 11:29:25 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:7ac5:31cc:3997:3a16?
 ([2602:ae:1598:4c01:7ac5:31cc:3997:3a16])
 by smtp.gmail.com with ESMTPSA id
 2-20020a631842000000b0052c22778e64sm1447654pgy.66.2023.05.25.11.29.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 May 2023 11:29:25 -0700 (PDT)
Message-ID: <d1ab807e-3a9a-91b9-ad52-2d46c06ff54b@linaro.org>
Date: Thu, 25 May 2023 11:29:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: io-qcow2 failures on zfs
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel <qemu-devel@nongnu.org>
References: <7b1805ad-56fd-77f7-48f7-fdf80f6a2e5b@linaro.org>
In-Reply-To: <7b1805ad-56fd-77f7-48f7-fdf80f6a2e5b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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

Ping.

On 5/19/23 15:44, Richard Henderson wrote:
> I'm doing some testing on one of the Linaro build machines and I reliably see
> 
> Summary of Failures:
> 
> 712/790 qemu:block / io-qcow2-150                                                 ERROR 
>         5.24s   exit status 1
> 777/790 qemu:block / io-qcow2-copy-before-write                                   ERROR 
>        16.31s   exit status 1
> 779/790 qemu:block / io-qcow2-244                                                 ERROR 
>        37.10s   exit status 1
> 
> This is x86_64 ubuntu 22.04, same as my laptop, so the only thing I can think is the 
> filesystem type:
> 
> hackpool-0/home/richard.henderson /home/richard.henderson zfs 
> rw,nosuid,nodev,noatime,xattr,noacl 0 0
> 
> Any thoughts?
> 
> 
> r~


