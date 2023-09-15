Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id BA70C7A26A2
	for <lists+qemu-devel@lfdr.de>; Fri, 15 Sep 2023 20:55:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qhDxH-0008Ub-Im; Fri, 15 Sep 2023 14:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhDxD-0008UG-6B
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:54:11 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qhDxB-0005sB-MP
 for qemu-devel@nongnu.org; Fri, 15 Sep 2023 14:54:10 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5657add1073so1811343a12.0
 for <qemu-devel@nongnu.org>; Fri, 15 Sep 2023 11:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1694804048; x=1695408848; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=RMHYMDweSIDEzd38f742fSSNn+Sn6GEZeco5jcEMZH8=;
 b=HEbkACHeN8FVVpIa7XIQFtkwkVOcBG2oUphwWoaXslOtguSFxPMVH+Vj5koqn84+MV
 9ClFXDwrPV0+QcDgc/Pbwjc2NVG8l0HxXig0cOHiHomFZxpuB6qCmn2dAjivpaheVRZL
 q+PIRWWIr9Epd5N6fEgejcd9Yx7f2mxz6tQWfhwSFlhI1iNLAgskwTbIcjSQtPbu4fRd
 PbEilwmQtLZ1rTHY2JaAY7CE7EySnYE912DYRCfHif7cCfpoZ/yucTCFbI/ObZaiScoP
 bS0i8C74wLtIpjLyJhMRhmc+hb16c9z/yDnDYDT5K9asTCxcngohaoEurbW+S1o/jIhG
 XOPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1694804048; x=1695408848;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RMHYMDweSIDEzd38f742fSSNn+Sn6GEZeco5jcEMZH8=;
 b=BFOk/UTMj39zLi4lrm4m6+zhTyAPX23LL8F84auR1UaJho3Lo/sFKPp+gWM6iogzUD
 hprwb8JiB1w/2LZG4R+t3Ciij5qmsAIRmXzfze1U8wtpcw3WGRS0VT2npriir7Pu/C/h
 7iGr+FLHIbMEdXz5jm6MYcO+UT1l1wmShldCpqdhsJ904Sx0576qhSVdynyl6LxNgXCt
 S4iCF8E46AvX65bMvGbAoR2/l6CNIi6akwcmPAJ47bnfYl5IYEUqe2xKBoMLk5YIj+hW
 ZPJhk4EhVe12LtQWrfIUVRBzceJLWKsdFs6YlOBndq1rjNsbncY5xKLLbUFAs9j7REqN
 TwXw==
X-Gm-Message-State: AOJu0YwyTZn00SYYWeZX4gL4UbSTJKvn+NJo5O8oGoneHqdw5amHofc6
 9e78IW7Sm4Al1rZdDs/SN0miwnSni27lBY6DJAY=
X-Google-Smtp-Source: AGHT+IES+88KqfXNxbM4KxS8Nxvy1Up/9NjcAgU/r5kQTSdugq5kSXh/l1ULHFxjBGHsysHTx71stw==
X-Received: by 2002:a17:90a:a891:b0:273:ec82:5554 with SMTP id
 h17-20020a17090aa89100b00273ec825554mr3479878pjq.9.1694804047979; 
 Fri, 15 Sep 2023 11:54:07 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.131.115])
 by smtp.gmail.com with ESMTPSA id
 g23-20020a17090a579700b00268dac826d4sm3286052pji.0.2023.09.15.11.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 Sep 2023 11:54:07 -0700 (PDT)
Message-ID: <2d2b9fca-94ae-8a8f-1380-35eedeadee13@linaro.org>
Date: Fri, 15 Sep 2023 11:54:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v2 0/3] accel/tcg: Alternate fix for #1866
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20230915163254.123338-1-richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20230915163254.123338-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 9/15/23 09:32, Richard Henderson wrote:
> Supercedes: 20230914174436.1597356-1-richard.henderson@linaro.org
> ("[PATCH 0/6] accel/tcg: Always require can_do_io (#1866)")
> 
> An alternate fix for #1866 without touching can_do_io, and is
> perhaps a bit cleaner and clearer.
> 
> Instead, the current cpu checks whether an address space update
> is required on each entry to the slow path.  This certainly
> catches all i/o.  It easily works for the sequential case of
> two i/o, the first of which changes the address space and the
> second of which requires the new address space.
> 
> I've done a tiny bit of performance testing between the two
> solutions and it seems to be a wash.  So now it's simply a
> matter of cleanliness.

Ho hum, this doesn't fix the x86_64 ovmf issue also quoted in #1866.


r~


