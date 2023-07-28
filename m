Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6C37660C9
	for <lists+qemu-devel@lfdr.de>; Fri, 28 Jul 2023 02:37:44 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qPBOU-00065e-DY; Thu, 27 Jul 2023 20:31:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPBOP-00065Q-Lv
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:31:42 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1qPBOO-0001AH-1H
 for qemu-devel@nongnu.org; Thu, 27 Jul 2023 20:31:41 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1b8ad9eede0so12570605ad.1
 for <qemu-devel@nongnu.org>; Thu, 27 Jul 2023 17:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1690504298; x=1691109098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G1D4Iz2+82TpRZU4lEBcp/9r0ojDM4mrF7QC7469i20=;
 b=QojrNwL8mrBzs88FFOtnU277FLzhSy/z0joTtfG5dwgMRkpXPxuEBjZUmPlzreFOl0
 H7JdYTqFZiQCTQBQL00JWnNfoZ25NG+ZobeAzeKE9eNUsSZmzacX7C9ATUOcFwvmuY2C
 yf2rXg5mDXgFUBTFfw5+Ck5DVV95vBRAIHtc/lF+VMupWcWuV/rQck25Ra6d6E2wM3jB
 ap0saXJ0epXLsIq/AXs1bCOi7HrOhTqVyqrdIVAfExNXKj9FnT2YrCvU2E5eiUSN9gZ8
 SEW6L3Di1+UI2JHLByQAau1+mNfDWgIiqrBMV3MGmW4d778qGKONsWtN/NQHrvLcL+yh
 kUQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690504298; x=1691109098;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G1D4Iz2+82TpRZU4lEBcp/9r0ojDM4mrF7QC7469i20=;
 b=WXmJ0YqVoRJ47yuvNbuWqL2Z9JNM5AkAYWar/PFJeK9jfjIznVViDGDLiRE82MNc1T
 9T0Nd79RoIxy4YY/L7EcSWooRT4WUlVBL1a8VngmQ96CrxMvkJIZtufkeFbI3e2VDrB4
 QfFGng+V7OF/2UEwL0CFXOaz+te71k3FI4VHH3Es8c7Q+dd6cDO7jwJwvMNI3l4qBYgv
 OYbN1DzrIiltbRvg/+FK5zy5+FhCEFZ8r9eqRMTE2qXosZeuHzRqcA1SaMBe1OXx4h/W
 8JqpdndGHChoDxTGY2Epp2YZnmf4RHcDCb9SkDslw4rOEJmxUqR1d57xlgUrCkecnIFy
 T8Gw==
X-Gm-Message-State: ABy/qLa5AW9h91NHZC9xgyI4TB8oEHwoHzSX85ZjNassBjXW7kHsQlK4
 RGyWKxp8avxJRqxVSU5gxJ9q8ynB+HQCO+uF4Kc=
X-Google-Smtp-Source: APBJJlFcbjSNsJT99mVU8O0X9vG8egssfAJFxvxW2HqL0MiQ+kSTilf6DVCUmOW4XuoOGdoibODEjA==
X-Received: by 2002:a17:903:124e:b0:1b8:b41e:66b4 with SMTP id
 u14-20020a170903124e00b001b8b41e66b4mr171413plh.67.1690504298270; 
 Thu, 27 Jul 2023 17:31:38 -0700 (PDT)
Received: from ?IPV6:2602:ae:154e:c001:943b:b6e1:1f00:9721?
 ([2602:ae:154e:c001:943b:b6e1:1f00:9721])
 by smtp.gmail.com with ESMTPSA id
 jn13-20020a170903050d00b001b895a18472sm2213156plb.117.2023.07.27.17.31.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jul 2023 17:31:37 -0700 (PDT)
Message-ID: <8faebb0b-b70b-101f-2f4a-9e434cb765f1@linaro.org>
Date: Thu, 27 Jul 2023 17:31:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] bsd-user: Properly allocate guest virtual address space
Content-Language: en-US
To: Warner Losh <imp@bsdimp.com>
Cc: qemu-devel@nongnu.org
References: <20230727161148.444988-1-richard.henderson@linaro.org>
 <CANCZdfrLKgVJhXqZ8nJdyoKOsLKscFPYSsZ=w6mSbusn0aX5Ww@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CANCZdfrLKgVJhXqZ8nJdyoKOsLKscFPYSsZ=w6mSbusn0aX5Ww@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 7/27/23 17:09, Warner Losh wrote:
> Yes. FreeBSD's bsd-user binary will only run on 64-bit hosts. The project
> has started phasing out support for 32-bit hosts, and the role of bsd-user
> (package builder tool) is such that 32-bit hosts don't make sense.

Ok, fine.

> I've tested this out, and it works for me. Any chance we can get this into
> 8.1 as a bug fix for the last minute breakage of bsd-user (without this and
> another patch, the static hello world that used to work broke). I can send
> that second patch out for review. I can queue this fix in the mean time for
> whenever the tree opens up.

Yes. I can queue this to tcg-next, which will have another round before rc2.
Send the alignment patch tomorrow and I can include that too.


r~

