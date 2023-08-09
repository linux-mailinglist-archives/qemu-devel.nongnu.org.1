Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F482775143
	for <lists+qemu-devel@lfdr.de>; Wed,  9 Aug 2023 05:12:35 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qTZcI-0005X7-Fp; Tue, 08 Aug 2023 23:12:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZcG-0005Ws-8K
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:12:08 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qTZcE-0003K1-Oj
 for qemu-devel@nongnu.org; Tue, 08 Aug 2023 23:12:07 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-5650ec45a7cso1225382a12.3
 for <qemu-devel@nongnu.org>; Tue, 08 Aug 2023 20:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1691550725; x=1692155525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yP891SKAOjwsGnd4VZ2AW1lTXyKoq+BYTQmkv1U3FXw=;
 b=iyEFrG/2G4VLsNi0WyCSIwXvAHCtwxqMXxqPoYVNqp3ZF2f0r0PTqfrw0/p2jUR6q3
 /2axfsr8/cjYT/JC8dEueTz9/nGu+fgLgva5CvlBg2RlkM/SkSva2TnsRIk6H4r3QGa5
 ueIfvRU5RfQLu4Q14M5UC/7XhB9qroqIM/eVpO+L3Ho1lXwmeguNFrJsp1xx+ZdhN1ep
 HgvIwymhrVAMokMdXwrpEp11IEJfpmKNl1coAb3rvtXwhmXvEui0wGO3u/BcsV31SMaZ
 gWpC+5DmloBhQkIGkKl3fHBQM0lG+mzcYb71tSR+vanaF6hduBK5Q16PWJyTu+cMsB0z
 Orfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691550725; x=1692155525;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yP891SKAOjwsGnd4VZ2AW1lTXyKoq+BYTQmkv1U3FXw=;
 b=ihk1YbeZZIQkKMo7fUolrLv6VsX9JjMcagksVfGTFbesT7dljIC1d4GkL8kvVsfeHb
 6lkXL9kQTldLUZ1r0F6kyLifitDY1KXRYg6QkSx0rh5X/eulrlKMpJgg4TFEFjWOEVVF
 WJMFTy934qgDgGEpewZMXUp8JHMWZTP4l0AvbWVueJ8uhqcMavKTQH4Ng28nzJnxasTt
 Int5uDwyUacM0ibkLKCWnMptNr4aXDDqSbKPhE5fGPG8YJ13M7MTYbXFA/QTzjEXmCLv
 ru/ZytpBn6idgfGgR2VBUlbrr6TADVIUgq/QyfV9rMxPavOMUY4nWE9LxrTrl1ARYsn8
 S//Q==
X-Gm-Message-State: AOJu0YxvQnCJY9uTywamoB0875PDXBxI4U9gl8faGtVacYGU8j8GzALM
 9kJfYhSCiXyX+Pa9MK01gy4oCQ==
X-Google-Smtp-Source: AGHT+IHzApQsr6AW6JH6leOGxUZcScUzWDjavr53xOrUNeid/BkT5u6p9FdzwmSMdREwufBXoep6LQ==
X-Received: by 2002:a17:902:da83:b0:1bb:2d0b:1a18 with SMTP id
 j3-20020a170902da8300b001bb2d0b1a18mr1425748plx.50.1691550725299; 
 Tue, 08 Aug 2023 20:12:05 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:aef:cddd:11b6:aee3?
 ([2602:47:d483:7301:aef:cddd:11b6:aee3])
 by smtp.gmail.com with ESMTPSA id
 a7-20020a170902ecc700b001b83e5ec666sm9805421plh.6.2023.08.08.20.12.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Aug 2023 20:12:04 -0700 (PDT)
Message-ID: <b8651c48-b8bf-e7ec-564d-1077d9e58cfb@linaro.org>
Date: Tue, 8 Aug 2023 20:12:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 08/33] Add structs target_freebsd11_nstat and
 target_freebsd11_statfs to bsd-user/syscall_defs.h
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org,
 Stacey Son <sson@freebsd.org>
References: <20230808060815.9001-1-kariem.taha2.7@gmail.com>
 <20230808060815.9001-9-kariem.taha2.7@gmail.com>
 <14d3fa60-0c91-66b7-7887-7854a6a5125a@linaro.org>
 <CANCZdfokHaz0PiLyesK9abDB6CGWzYBhtN=MRhY=JJo1x_DKFw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfokHaz0PiLyesK9abDB6CGWzYBhtN=MRhY=JJo1x_DKFw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -61
X-Spam_score: -6.2
X-Spam_bar: ------
X-Spam_report: (-6.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-4.14,
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

On 8/8/23 19:51, Warner Losh wrote:
>      > +    /* __int32_t  st_lspare; */
> 
>     Why commented out?
> 
> 
> I believe that the element was a padding one ....
> 
>      > +    struct target_freebsd_timespec st_birthtim; /* time of file creation */
> 
>     Does that not place st_birthtim at the wrong place?
> 
> 
> So this winds up in the right place because there's a hole...
> 
> However, having said that, I don't think it should be commented out. It's not
> in the bsd-user branch. And the state of the upstream code is such that we can't
> run full tests easily on the system calls, so we're making sure they basically
> work, but will run the full regression test once some other changes are made
> to allow shared libraries to work (many of the calls in this patch are needed
> to make 'hello world' work).

I think there is not a hole, because the struct is __packed.

(Also, QEMU_PACKED vs __packed?)


r~

