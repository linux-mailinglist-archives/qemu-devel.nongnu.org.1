Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D13A3707DCB
	for <lists+qemu-devel@lfdr.de>; Thu, 18 May 2023 12:15:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1pzaea-0004UW-BO; Thu, 18 May 2023 06:14:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzaeT-0004U7-8s
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:14:29 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1pzaeR-00040n-If
 for qemu-devel@nongnu.org; Thu, 18 May 2023 06:14:29 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-510d967249aso2449745a12.1
 for <qemu-devel@nongnu.org>; Thu, 18 May 2023 03:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1684404865; x=1686996865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=tykwjg27hapnRImi6qarWqlaeMlnB1oJTRTSY29t998=;
 b=Njrm0N7u5pqaqM6QCFd79gbuBZ2IVG959L7XvDF50mRg+OC3BeXTHmL0iZV+26aNwn
 d26NXRk8TgVsbR7duNJFb8lQbdsyuPnmKhWVk+j4Jd+HZEoRsspXTb+oiGwkERsVoQWT
 RIy987i/YXm9+bKWJZD4aHZhg560/dG0G8/DV3wKIbFvd3Ul0Wl/SxlPZe9jl+t6ck/M
 4UCjnGYv8BuNezYkEauEVruEr8T12Wr0Tw3KjTdE5KAoOm+hF0WKMS4uzuOyl3zT4k2g
 OJf1ZmD8rdhFMiDe6IAUaWXVAenxkwDdRpNUCQ/6P1jGSZ1oSeN7lx4NF8FjcfQU3LTq
 3Qow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684404865; x=1686996865;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tykwjg27hapnRImi6qarWqlaeMlnB1oJTRTSY29t998=;
 b=Dl7ZvY9C/MPEDoUOBT5LussUPTaLwUUUtg9p/7keldUK/95yLsdvcE9Rf82Iu9UlqT
 zLAy9vH/VJVHazJFNJBZIkRGFrogJGbsrKbXPFRkAQGi7LgyVXMkZGbqMuEHRujPEABd
 /G9LLWM2AuS8p5XE0HS/Nkfl2doN/Qw5PR5kq8MIfyRTs/Dt62rWYFP9RDZUFuewZ2of
 PjZ/ceXNQUB60vHMvRHPT8rN6Y0gU/QlpjPfyQlOnNeoOK//bFwrvFydjBfWjHH4YWtL
 V4nRozL1bORxfqF9CyatNrZiP0T/YLAKetO2bkk6L9yrqx5GXXS4/Z27nbBaHQQGnSwl
 lEQw==
X-Gm-Message-State: AC+VfDzNPpI3VXWL3tTPvkkFuaZfKP9Ho/OT+rYYHm3t6+4lift/Vg07
 ex+TUPD8UmSD1fxxjorpvRCujfQrbfKvkMqeVFWSog==
X-Google-Smtp-Source: ACHHUZ5XeFBsUhF92ZtZFme11QGmo/tNAcQzWSSBy/Sd4AwexX4Z74yZWEMdGiCCCLeRPrCfpWI/uwZOGAO4Q/zClmM=
X-Received: by 2002:a17:907:3202:b0:965:cf39:ed7a with SMTP id
 xg2-20020a170907320200b00965cf39ed7amr44676570ejb.56.1684404865569; Thu, 18
 May 2023 03:14:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230505120936.1097060-1-marcin.juszkiewicz@linaro.org>
 <1d08d306-a4ce-5744-b1d0-90d17aaa4f02@quicinc.com>
In-Reply-To: <1d08d306-a4ce-5744-b1d0-90d17aaa4f02@quicinc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 May 2023 11:14:14 +0100
Message-ID: <CAFEAcA_-bpDfX25tNrtkn+me=jyeqt5p5SZUJwr0NOt2dUo4Lg@mail.gmail.com>
Subject: Re: [PATCH] sbsa-ref: use Bochs graphics card instead of VGA
To: Leif Lindholm <quic_llindhol@quicinc.com>
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Wed, 17 May 2023 at 11:55, Leif Lindholm <quic_llindhol@quicinc.com> wrote:
>
> On 2023-05-05 13:09, Marcin Juszkiewicz wrote:
> > Bochs card is normal PCI Express card so it fits better in system with
> > PCI Express bus. VGA is simple legacy PCI card.
> >
> > Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>
> Reviewed-by: Leif Lindholm <quic_llindhol@quicinc.com>
>



Applied to target-arm.next, thanks.

-- PMM

