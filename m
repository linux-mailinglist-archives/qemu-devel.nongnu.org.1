Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC6F78CFF0
	for <lists+qemu-devel@lfdr.de>; Wed, 30 Aug 2023 01:09:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qb7nU-00014d-2s; Tue, 29 Aug 2023 19:06:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6eO-0007zr-Vs
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:53:29 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qb6eM-0002WZ-Pj
 for qemu-devel@nongnu.org; Tue, 29 Aug 2023 17:53:28 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1bdf4752c3cso30261005ad.2
 for <qemu-devel@nongnu.org>; Tue, 29 Aug 2023 14:53:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1693346003; x=1693950803; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xI3Cb6r/fEqozdLmtb+6yeCBY8u8qkPog4BZACo/w1M=;
 b=VG3w2L1Ym7qgxIdy8iRGSdCConh6AVXGF1loCruqR51KW3rfw3XjapxYOn9NdA85oe
 3HhFoEmEol9kazk1m9IvevBDDIr4m+gcyoLJTSxLhD7zQtxQpd+X/dgvnZ3ldj0kvipY
 ovb9nbmWdRvCaJ4BSNEtpjUxJiiVV/2sul8eTOpi/WYBGkuXiqF4dYoSTX2ieII4Vmt7
 +rZn+GMxrOMLIN2FZpM7ncTssAjFJoEmNSCMPdu+dsC5GGvghSUFbaw6MzrFrB0317Hm
 rjFM5OZVbL1LjSGUKQ2WH+6xoHEttzsjXSJ20YzmUf+ErO/2RmPIW3rocsEROkrwkgBo
 UmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693346003; x=1693950803;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xI3Cb6r/fEqozdLmtb+6yeCBY8u8qkPog4BZACo/w1M=;
 b=UdU/SknN8LMo4WtbVyXAxywntoKakuWtd53vb/8v1lK2dChlHKgKedlw2OAWHA4rsW
 nGW4Xe67Lxg6OrE3nQX2iECFLR4/bNSVo/SMEEOF3GxpMC9BRYY+9BSs5FPqX7gvLihB
 IAkW8NylakKMLlFkQlUW5Wd1oEYT61kY/kPi9Of2SuM0boeWIctjGgBWUeXL3znAjzN2
 iqqdxeGZsr+bMIT33jp6yeReGg9Nl3p8JzA3D2j9j7WBAIPXgLiqzh/O1Q7chT8SJoVN
 X5uDYIPsIcZTi2FFGws66phSJBZcmQZiR+uLWRVBWleLv38Tv2/yANxEb5QUFf5vX6i+
 /brQ==
X-Gm-Message-State: AOJu0YyjNRQifYNW1j2mmYpyavz39m5sIUCSjpLU2APvAPNGw2h2IhdP
 MTKnmcQnvZFMBVr7sp8kt+w3Zw==
X-Google-Smtp-Source: AGHT+IG8+tHHEul7mjD1EKOTdhm32ZAZoN3b1gyAvweL+6eGhllbalMcOaFQirtnl8S3Yk6DRIelxg==
X-Received: by 2002:a17:902:76c7:b0:1bb:b86e:8d6d with SMTP id
 j7-20020a17090276c700b001bbb86e8d6dmr266178plt.29.1693346002984; 
 Tue, 29 Aug 2023 14:53:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 jd13-20020a170903260d00b001b81a97860asm9869103plb.27.2023.08.29.14.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Aug 2023 14:53:22 -0700 (PDT)
Message-ID: <f63aeecc-00f7-850b-c02c-bf2a2246f780@linaro.org>
Date: Tue, 29 Aug 2023 14:53:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 32/32] bsd-user: Implement pdfork(2) system call.
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: Karim Taha <kariem.taha2.7@gmail.com>, qemu-devel@nongnu.org,
 Stacey Son <sson@freebsd.org>
References: <20230827155746.84781-1-kariem.taha2.7@gmail.com>
 <20230827155746.84781-33-kariem.taha2.7@gmail.com>
 <02510730-72e8-9b0e-483c-048c7301328f@linaro.org>
 <CANCZdfoKOotS+S01bFbSXYFrqwOaFYf6xb_aAOR5eq13jYeKmg@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfoKOotS+S01bFbSXYFrqwOaFYf6xb_aAOR5eq13jYeKmg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-1.242,
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

On 8/29/23 14:27, Warner Losh wrote:
>      > +    if (put_user_s32(fd, target_fdp)) {
>      > +        return -TARGET_EFAULT;
>      > +    }
> 
>     I *think* this copy belongs in the parent?
> 
> 
> I think that it's copied out in both cases. For normal fork, this would
> be 0 for the pid. However, it appears to return the same FD to both
> the parent and child (see your next comment), so it should be in both
> paths. And even if it returned something different for parent and child
> (which seems unlikely given how the code is setup), we want to return
> the fd each one sees. So either way, I think this code is correct.
> 
>     It's really hard to follow the path of new
>     process creation within the freebsd kernel.
> 
> 
> Agreed.

I think that the child never returns from do_fork.  The child pid == 0 happens as part of 
do_fork or vm_forkproc or somesuch, but the new process definitely begins life at fork_return.

Therefore only the parent passes returns from fork1 to set *fdp.


r~

