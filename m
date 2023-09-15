Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 69FFB7A1EE2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 14:39:23 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qh85o-0001y5-Aq; Fri, 15 Sep 2023 08:38:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh85j-0001xi-HD
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:38:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qh85h-0005FN-Ti
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 08:38:35 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-68fb6fd2836so1891034b3a.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 05:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694781512; x=1695386312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XYDfENl0grPBJ5QQ022juh9QfWvazFf1qp1xJk+/RkA=;
 b=LXgnwFXE7g0yHxtuPdhXYd2trFVz6szDYT8uFVm6DdC87ECpOjlw4PPyfz6vRunSkZ
 OrcsnmSgAxCj68CsvpEPElByQpt189q6WDE4Ibtl2XhblZMpr5gI/l3OEFSOIxQm3GIk
 sVTVje1h0aIuj3VZVxSBueUA2/zz6dA3Vh/TFUtlEM6qIhFhMZL/yLWGIWJ0jc/j4jma
 U0DjbwxoFqh0eUWorJXVfc8EcJiwneaVb0KkLo1vIAfFnC1AUvEUSR08MSdA6IrU545j
 9d0NYRxlmRWQ08u5JcJDrrDCZqYPSOSa3BW0Y6Ta7SuORpQxRswr26PDJsAouLY74cHS
 wHDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694781512; x=1695386312;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XYDfENl0grPBJ5QQ022juh9QfWvazFf1qp1xJk+/RkA=;
 b=ayTFRtlysIahcm7xPbJlh/KvTB7lcP9e519b9/g90qCXk3WoIolZDYwLxNGWpGCKDo
 qAFv41om+FD5oYre7ymEeJ3azQle6kpuyFTsu2dIltSs89qIuPTp7CV3ZqgRVc+VQw7B
 okVeml9lwwiDQJkxpv9wNB02FYhDS60jSTjXJL9woN6lx3IJ5tacgKmomdjEEpD/BQbS
 IWn87Fw7MHz6MiOk2FyqQG74bVNAkdwexMejj3+8RQJ5/J6TanYB/lUABoAih8NT2pTa
 wS0Ml67EVUevnxiHx15FB7EWkKvIDSf0l1SdjCPLgqAvQGoaChkKPgdgOx+HhQ9McZmZ
 FSfA==
X-Gm-Message-State: AOJu0YzW/8KZMhCMFZ8R0VJXZ9zJILPjBgvMNk6ERub2svw0HRMYWw/g
 eNv1lFEnHNE28d7xuEz4Txgf9Ry7bOAezykkSEk=
X-Google-Smtp-Source: AGHT+IHzBmj99OXwcvhVh4sUJIbOeOnYlK9IttNiMAxvCZagXxX66fHJRVs+/n234HQoGf/GlxN3sQ==
X-Received: by 2002:a05:6a00:139b:b0:690:41a1:9b6a with SMTP id
 t27-20020a056a00139b00b0069041a19b6amr1822306pfg.5.1694781511981; 
 Fri, 15 Sep 2023 05:38:31 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a637e03000000b0057754ae4eb7sm2696045pgc.39.2023.09.15.05.38.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 05:38:31 -0700 (PDT)
Message-ID: <df9a0aec-52f8-5a70-eb4d-758fd7be48a0@linaro.org>
Date: Fri, 15 Sep 2023 05:38:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v5 22/23] bsd-user: Implement shmat(2) and shmdt(2)
Content-Language: en-US
To: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org
Cc: imp@bsdimp.com, Stacey Son <sson@FreeBSD.org>
References: <20230914204107.23778-1-kariem.taha2.7@gmail.com>
 <20230914204107.23778-23-kariem.taha2.7@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230914204107.23778-23-kariem.taha2.7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.473,
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

On 9/14/23 13:41, Karim Taha wrote:
> From: Stacey Son<sson@FreeBSD.org>
> 
> Use `WITH_MMAP_LOCK_GUARD` instead of mmap_lock() and mmap_unlock(),
> to match linux-user implementation, according to the following commits:
> 
> 69fa2708a216df715ba5102a0f98468b540a464e linux-user: Use WITH_MMAP_LOCK_GUARD in target_{shmat,shmdt}
> ceda5688b650646248f269a992c06b11148c5759 linux-user: Fix shmdt
> 
> Signed-off-by: Stacey Son<sson@FreeBSD.org>
> Signed-off-by: Karim Taha<kariem.taha2.7@gmail.com>
> ---
>   bsd-user/bsd-mem.h            | 87 +++++++++++++++++++++++++++++++++++
>   bsd-user/freebsd/os-syscall.c |  8 ++++
>   bsd-user/mmap.c               |  2 +-
>   bsd-user/qemu.h               |  1 +
>   4 files changed, 97 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

