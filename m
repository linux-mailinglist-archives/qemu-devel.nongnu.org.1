Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BD37472EF
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 15:41:45 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGgHB-0006RD-IV; Tue, 04 Jul 2023 09:41:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGgH9-0006R0-Ob
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:41:03 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qGgH8-0004NK-1g
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 09:41:03 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-51d7e8dd118so7090017a12.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 06:41:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1688478060; x=1691070060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/lg0Whi/bgBckIsuGfUVC+la2EtqrOlrhiSmAojFdd4=;
 b=dmZQnr5iRm6uCZKm8d6ajNZUTn/KQdK0Zky+8pJLAGHprO0OADbck8b3+v199Q6LX8
 Mn6vwIYMpaSP0gkT3IXwqrGZFkPQd5ruLntY9S0A4oyOcXz45UYrlGw+dEO1s5QQEz0k
 DKJUJJlI6PNNENkVucN+eTSu+SaRiBceMNrUPH65juB1Fvf64vvWwfql/66yElQEws6b
 BfNlnE/Qdzet6AB7RjKfcxon8TCRwAsgNxfk4iabfT0lJWy0Urfvxfa4j84yM1GUYI6R
 fnRk2kqmA3h9rCedkHz936gvj9l2v9xFYKe6KLw3nEcnyHDFIUDQV0v9VjA8GfopZOGu
 Z5tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688478060; x=1691070060;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/lg0Whi/bgBckIsuGfUVC+la2EtqrOlrhiSmAojFdd4=;
 b=aLIeikVo9LDvYK2MWgvoRjLOyP9aR7B/BqxBk8nSNsUWzQbiXGnOAFdmRsw/ueqT7y
 HYSdn0NNWe3Q1gyhZLBCOI0jHo4jmV4j/MqvcUVdzFlPyRAwXArLSx3P1aDQLwC9olUG
 ohOYdYO9/WBmbnZGhUiJ7E7mB8I35M/6mdOxeGnJ0jpOyHNdFx64a2xWG2Xz+9F3bMFS
 OxfqViC6K2jKJTF1S280vL8lNbLsy/ZcuKUX0xPE9DXzEPNNySJvC/ONj91PoX6B+B7A
 0TL0DNGwrWgaId8nTuKEmsf1feFqKjbtFTbRc5Dwg/JHo1TkI7/sCtCBi0ar2wFkuat2
 g0TQ==
X-Gm-Message-State: ABy/qLaNGLy+9gXYKaXud4YVidY3guxlkK4VCQKGbfidNyb55l7ZI9kw
 slKycC9gxzWl8yvS+b2u1c+IDD2RftHux9VF5uy3gA==
X-Google-Smtp-Source: APBJJlGdpjI+XAdQQEbO56rBZec1M2jV8oxfU+sgBOUP4+bkTXorxz/2FF9t9PRHIbPlVXgDSKWps1GXlTGCOLA9l+Q=
X-Received: by 2002:a05:6402:1482:b0:51e:22da:186c with SMTP id
 e2-20020a056402148200b0051e22da186cmr1075081edv.35.1688478060412; Tue, 04 Jul
 2023 06:41:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230609172324.982888-1-aaron@os.amperecomputing.com>
 <20230609172324.982888-8-aaron@os.amperecomputing.com>
In-Reply-To: <20230609172324.982888-8-aaron@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Jul 2023 14:40:49 +0100
Message-ID: <CAFEAcA8P=isZWs8kTF+f3OErv5Yt8eRQXZr87kkU2uWYEtw2Kw@mail.gmail.com>
Subject: Re: [PATCH v3 7/8] target/arm: Implement v8.3 FPAC and FPACCOMBINE
To: Aaron Lindsay <aaron@os.amperecomputing.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>,
 Vincent Dehors <vincent.dehors@smile.fr>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Fri, 9 Jun 2023 at 18:23, Aaron Lindsay <aaron@os.amperecomputing.com> wrote:
>
> Signed-off-by: Aaron Lindsay <aaron@os.amperecomputing.com>

Something weird seems to have happened with the different versions
of this series. There is also a "v3" of this patch that was
sent to the list back in March, it's the same text as this one,
and Richard reviewed it:
https://lore.kernel.org/qemu-devel/20230322202541.1404058-8-aaron@os.amperecomputing.com/

For the benefit of the tooling, I'm copying that line here:

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

thanks
-- PMM

