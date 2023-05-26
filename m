Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C5FEA712F05
	for <lists+qemu-devel@lfdr.de>; Fri, 26 May 2023 23:41:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q2fAg-0004LW-NW; Fri, 26 May 2023 17:40:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2fAa-0004Ks-0P
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:40:21 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1q2fAX-00035Z-Hq
 for qemu-devel@nongnu.org; Fri, 26 May 2023 17:40:19 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-52cb8e5e9f5so943019a12.0
 for <qemu-devel@nongnu.org>; Fri, 26 May 2023 14:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1685137212; x=1687729212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tx/MORQqSMeYeMmTHu24SX47GIE5TgDFj1CY3kxzrWA=;
 b=bqWydNL+J/LiUFhnDAAac9DHpWerHv7NxX0QBkEF7ep562rh1h6wBRNKUMVMQ++zBs
 XIFxi5nJjxiD42BJVqLbgMN4/3A4+hz5AQf3Y61RRICji+SRCVhCh7lCiv9ezEmZdFzq
 d53MlHCiArgXYReDJWfHVA5XaJ/vbq2SN9d8Rs/Q/N3/ZygPWleQ931dF7m4MCLcDOsN
 HEO3jIGnnt1LybeqC1zSwPO+RqW2yIqNl+9O384kJBWTzoLSLan9fqSr9fvmTjCrBBaE
 J281hUvU06o1ZJ/2+pNcY/A6cZEv0+dyCoSVQYdXCKCh10CIIFGRJgrtS3qS45x5IbPW
 3UMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685137212; x=1687729212;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tx/MORQqSMeYeMmTHu24SX47GIE5TgDFj1CY3kxzrWA=;
 b=O+v4Xkotn+Q+tE69ijyqrNjAsVuroKYTLbsr+hQ4ayUDXbgUZ1JLT3sN7+cpMIVxNW
 28nnxYp4GRN3gPkOY6uTTTnILTtmoszDJO+3iBm12zKKIIq1nglZzEF/mCN5duZvJtyk
 OTKWY9DLzvn/Jw6G2kXKJL9Ju3nDs5JVBzewCtXcgOz3LtyzJnXkklQye/3ErecNhCAZ
 WPDu+sPt8BlHQaMvi2+1GceR3wRMk21COaqma2m9WsmecA0ouzE4u3Fjdcl2YMZD85KP
 CqDo/ZN7EKfZyZf1KjWrh+X7NeF7Y0FOwc7WxrGP32+IJkQdjbve6p0R4I9JlX4A0kgl
 Cjmw==
X-Gm-Message-State: AC+VfDy18aA1EpEAxTavHKoRqNuUhTAbe8vzgkTdOpRKBTxINzOVEwvH
 o3VmXC9OA90XEWm97lGXiwucJg==
X-Google-Smtp-Source: ACHHUZ6vznHtb/LMtDAF9K84cdawar8cTiH1iXgDaiFZiRFz2o6KNR8ES9mqVgkVTm5m4WY+XWsK4Q==
X-Received: by 2002:a17:903:244b:b0:1a6:7ea8:9f4f with SMTP id
 l11-20020a170903244b00b001a67ea89f4fmr425435pls.26.1685137212037; 
 Fri, 26 May 2023 14:40:12 -0700 (PDT)
Received: from ?IPV6:2602:ae:1598:4c01:86cc:4482:68db:2c0f?
 ([2602:ae:1598:4c01:86cc:4482:68db:2c0f])
 by smtp.gmail.com with ESMTPSA id
 bh7-20020a170902a98700b001ac444fd07fsm3663581plb.100.2023.05.26.14.40.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 May 2023 14:40:11 -0700 (PDT)
Message-ID: <6846939e-be03-e7db-5921-0f09c81a0cb3@linaro.org>
Date: Fri, 26 May 2023 14:40:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PULL 0/5] Hexagon update
Content-Language: en-US
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, peter.maydell@linaro.org, bcain@quicinc.com,
 quic_mathbern@quicinc.com, stefanha@redhat.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com
References: <20230526142028.1277954-1-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20230526142028.1277954-1-tsimpson@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.092,
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

On 5/26/23 07:20, Taylor Simpson wrote:
> The following changes since commit a3cb6d5004ff638aefe686ecd540718a793bd1b1:
> 
>    Merge tag 'pull-tcg-20230525' ofhttps://gitlab.com/rth7680/qemu  into staging (2023-05-25 11:11:52 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/quic/qemu  tags/pull-hex-20230526
> 
> for you to fetch changes up to 7d196e2196d50e0dda0f87f396d4f4a7ad9aafbe:
> 
>    Hexagon (target/hexagon) Change Hexagon maintainer (2023-05-26 07:03:41 -0700)
> 
> ----------------------------------------------------------------
> Hexagon update

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/8.1 as appropriate.


r~


