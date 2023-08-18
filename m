Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 40BBD7814D4
	for <lists+qemu-devel@lfdr.de>; Fri, 18 Aug 2023 23:36:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qX77F-0005QZ-Oo; Fri, 18 Aug 2023 17:34:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX77D-0005Q7-LY
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 17:34:43 -0400
Received: from mail-oi1-x22c.google.com ([2607:f8b0:4864:20::22c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qX77B-0001ch-Hk
 for qemu-devel@nongnu.org; Fri, 18 Aug 2023 17:34:43 -0400
Received: by mail-oi1-x22c.google.com with SMTP id
 5614622812f47-3a5ad44dc5aso945142b6e.3
 for <qemu-devel@nongnu.org>; Fri, 18 Aug 2023 14:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1692394480; x=1692999280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Kg0NpMDYj/VEmRYCYk7sG3b54bH/NzRhMi5BS91Y4LI=;
 b=eostx1GZOmjxQTA+8goUrCvoPUrkC5B9FmQzTd9HxYG6gJIPo6i1K+zUoT8NykJVzS
 lW+ZG+qm4jpya6awes+fGY0N1p1b9Ugys/hy+M12CtYiDt9U4WzoEi3+qobOxG0mgh/F
 USHICmu+BDtgXFwk/WzrjdU0t+3ROCAgf04xphH+mLvRMt49cyfPJLRdspS7CP6g/rIm
 gGa4pAEWPudVQtv5mrx97o4reY125kd5P2Lh+F7VMAfI6DDFakgJSHV6BhnqG2SYUMRT
 RPJ3jJ+/OnQMjWEC/Qjme54Mw+PNe5qXxoswlmJgX5Y+qMWCzHpSxAELyADngXmPnRsb
 PsbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692394480; x=1692999280;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Kg0NpMDYj/VEmRYCYk7sG3b54bH/NzRhMi5BS91Y4LI=;
 b=OfXN4iijosQwKLzxNu84/0c6Zi9/hCuVIG/H4+bAutX2sW6N4rlRfILk4MJqrDPWjH
 90mJH0+NW56cphJ/SBlHCNJUrSnLnkiOuKIBR5eAXfksCOTv9Uch8jGPelmJnFbQ+f1x
 E3UzrJUqwiSfi6kBnhbvzGP9iDeoRftnQp2AC9NbKpZoevrkGJSIAn4wJVnvQpRQMNK6
 HrpbD9ETahlemsk9wVBgC9w3UriU8+juufH99i3jqOJDnuodw6K/PDMskScKxt1eHdsc
 nuNbx7+LR5V7Gm71dnoCwvFAc0uaEXjHIu4ZPNY8NkpXHgpuKs2CyA885j6znCrmUQmg
 A3ug==
X-Gm-Message-State: AOJu0Yxwr4OWf7VyGZlYmpv2UWk++ltHCKemAT5cPNBKLqcWGIRA6TC3
 2YteB9mFYBllNbwY+AuHYFI8dTdMvHyTXKHayY4=
X-Google-Smtp-Source: AGHT+IHN+qA8KC2DjkcruTYoQzP7xUh4CV8FTFEr7TGINEos31zXvh6CjoP2KYI3sj6RHzHytTkEvA==
X-Received: by 2002:a05:6358:6f16:b0:12f:158e:ed88 with SMTP id
 r22-20020a0563586f1600b0012f158eed88mr458915rwn.22.1692394479960; 
 Fri, 18 Aug 2023 14:34:39 -0700 (PDT)
Received: from ?IPV6:2602:47:d483:7301:cf24:6daf:2b9e:7972?
 ([2602:47:d483:7301:cf24:6daf:2b9e:7972])
 by smtp.gmail.com with ESMTPSA id
 q23-20020a637517000000b00563c1aa277asm2001444pgc.6.2023.08.18.14.34.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 18 Aug 2023 14:34:39 -0700 (PDT)
Message-ID: <12d3d8a9-1823-abcd-97ff-aacd531a2724@linaro.org>
Date: Fri, 18 Aug 2023 14:34:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/3] bsd-user: Remove image_info.start_brk
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
References: <20230818175736.144194-1-richard.henderson@linaro.org>
 <20230818175736.144194-4-richard.henderson@linaro.org>
 <CANCZdfpqzRb--EBJnvxRjQHvssAWMWyWLL9qjArksk5pNROj4w@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfpqzRb--EBJnvxRjQHvssAWMWyWLL9qjArksk5pNROj4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::22c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x22c.google.com
X-Spam_score_int: -55
X-Spam_score: -5.6
X-Spam_bar: -----
X-Spam_report: (-5.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-3.454,
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

On 8/18/23 11:22, Warner Losh wrote:
> Forgot on 1/3 to mention I'm planning on doing a pull request right after the
> release (subject to our release engineer's ok) and can include this there.

Excellent, thanks.

r~

