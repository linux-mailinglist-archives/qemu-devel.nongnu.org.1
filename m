Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 398C97D7B73
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 06:22:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvrrk-0007Ac-3n; Thu, 26 Oct 2023 00:21:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrrg-0007AH-7p
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:21:00 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qvrrb-0005Hg-B2
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 00:20:59 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-27d18475ed4so382288a91.0
 for <qemu-devel@nongnu.org>; Wed, 25 Oct 2023 21:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1698294049; x=1698898849; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dJIYL5eAPvSKXcy9LTY86iHBS7ZTqJBglQ7gQGUTuP4=;
 b=kkTxzE/bvSayePtYgKCZPMZDbN/cOcS+Tw6azShw62JFR+i5SujApR8nS0QUKIqPMZ
 YbdPYJFzBxl3LIszitNLtps5n7mbfWm94bDTTL6gPuu343c4wabgD8sr32Ht+mo2wjvI
 zUNqGNUG86k2jibRXWM7rgbynuJSz/3HupbHER7a8TyJYCu0rpnIKQ7n9zFLbmfHD07A
 OnhZZ328WX3b6PFzeSqAhg6zMc7gF6Iwec010xYMypjPnGTrXeSWgfxYjtKGKn5vkNTC
 1tJqSPtJenAcgis7NLekho+SOXMiNWo3I2lwBlNAdl0th2/4wWI8R4G8j3MASfPf+HlI
 v2Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698294049; x=1698898849;
 h=content-transfer-encoding:in-reply-to:references:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dJIYL5eAPvSKXcy9LTY86iHBS7ZTqJBglQ7gQGUTuP4=;
 b=S/3NZIkRP2FeVq14qUJo5F3rjeWGmW54ZMMyqYyPfXfxrVIhxB764Kz9oPSQimi+wI
 QKPW0j0pDfQnLla3uyV4dQSdGHeWUooJYVbys8PUtrV3Zn3f32QY7cWmiAfA08E2h5gj
 UkRCyA9cQb1NTTuJnknH6AP4QsuHUR6/HEI1L3S875yVmpK4OXZAUggYIcmob/V6bpwe
 NiYy6zB+H/OtygPJwhlgISL0PPDl2jVzTF84XfeGuMm/iwGIop7HvBju2Rjsr7w/JznX
 WDbomF0va9zsuI/gnpn2gSWM7cWBDzhjL4QIdbdORz+DDdxhpAa3kwRKOJbhYbYVR0jd
 pKyg==
X-Gm-Message-State: AOJu0Yxfokc4o2yW6Z+TYj2wNdXVR4TdljYHYOWuBkCn3iy/zDHIvK9/
 DcLtzTWOMl7cTylJjQmt0dNQ2DcRw04HTymsXk0=
X-Google-Smtp-Source: AGHT+IEEnxELMlMGtfYB68Wa7oX2fMXPqtTMjAXVjUbRC9W7oZcNcPSibZ0bHfD1I+xSh5Q4qYLyAQ==
X-Received: by 2002:a17:90a:7887:b0:274:6839:6a8c with SMTP id
 x7-20020a17090a788700b0027468396a8cmr14294226pjk.6.1698294049187; 
 Wed, 25 Oct 2023 21:20:49 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.149.95])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a194c00b00279060a0fccsm759059pjh.9.2023.10.25.21.20.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Oct 2023 21:20:48 -0700 (PDT)
Message-ID: <aa715385-3508-473f-bc40-3cd6e2e0e87b@linaro.org>
Date: Wed, 25 Oct 2023 21:20:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] tcg: Always implement neg and movcond
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
References: <20231026041404.1229328-1-richard.henderson@linaro.org>
In-Reply-To: <20231026041404.1229328-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On 10/25/23 21:13, Richard Henderson wrote:
> Having opcodes always present means that we can remove some tests.
> NOT and MOVCOND were *almost* always present anyway.
> 
> A close candidate is NOT.  The hiccup is s390x: except for the most
> recent hardware revision, there is no single insn which can implement
> the operation.
> 
> I experimented with replacements:
> 
>      i32: xilf r,-1             (6 bytes, requires R=X)
>           lcr r,x; ahi r,-1     (6 bytes)
>      i64: lcgr r,x; aghi r,-1   (8 bytes)
> 
> But both don't compare well with the current
> 
>           lghi tmp,-1           (4 bytes, shared)
>           xgrk r,x,tmp          (4 bytes)
> 
> With the constant -1 managed by register allocation, it gets loaded
> once and then reused between operations.
> 
> An alternative might be to assume the presence of all opcodes during
> initial expansion and lower them later, after optimization.  I'm close
> to doing just that for the more complex opcodes like deposit anyway,
> because the expansion is too complex for the optimizer to do anything
> sensible after constant propagation.

Oh, for the record,

Based-on: 20231025072707.833943-1-richard.henderson@linaro.org
("tcg: Introduce TCG_COND_TST{EQ,NE}")


r~

