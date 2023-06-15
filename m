Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 54B1D730D8F
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 05:32:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9din-00034F-6u; Wed, 14 Jun 2023 23:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dil-00033c-2h; Wed, 14 Jun 2023 23:32:27 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9dij-0002go-Ip; Wed, 14 Jun 2023 23:32:26 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-666779dcc8aso968229b3a.0; 
 Wed, 14 Jun 2023 20:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686799944; x=1689391944;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=53lgMwcRMauURbOcMZ4TTMgqvuPrLj7rMtWibuRJOnA=;
 b=Y+EXgo/NEZsoFEZ3DNWptHrkiJPo3qzy+pSb5ve11ekANBoKk5WA3cTnVKi5jGUVFn
 ETNS9RNRJXWnGbx2TGftDW6ivQp/ZMj/lOENQWhbFSkp+ilxFJUCk4Sq87MUxXBx95G0
 +tEzyCMHH2h14OI6URKdVPaqOkPVsgLRPkax3ET6tkppOqu/Uy/2ml6U7jXLZmmEkqY7
 OvdVGg+B62pYgYwSNUM4inKbeBmQLPaUzKIY9yWqYIWGxMXjPdyBM2JGCSK7qv6smM8o
 Dt0pvFVcvQbvimAE7It0vORDiA+cySrR6KErD0ObvE0qyw9mwi5g8thffpVN4xxKeVma
 0RUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686799944; x=1689391944;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=53lgMwcRMauURbOcMZ4TTMgqvuPrLj7rMtWibuRJOnA=;
 b=d7P09ieUa/vn2tbj3uwga2JqWwYLalwpKKqCrSLyXVMtk5iRCYUfQ1PR4wS3obp8JA
 ZNAiRTDI6h29bUbJfzdsRv7f7xOskGSGG2D0L1g6SrEE6XBMeK/DyaW6IpOBQ2Xs4/Al
 9iBKLqA2xFYZ74iHt8gzpW3PSJkBl6zh9vnPy0VTzDSCkZSSXwiEDxcpZx7Lroiy/rsQ
 wOy6SHnAlhYR0JZ+6XOPsbtqnni3g4cDVWRXJg3cLilKHnNRnftZxI6RLkD9lvdYhFT1
 bm8JvUiP3fcBazPP27f1mSZsNTBHEuT87Hc2QM6qFlxOgKFavoKG0fFDx/5Pepp82bsc
 Zf+A==
X-Gm-Message-State: AC+VfDz2AzVNknWmkbzF9Z0w3zMLvIoLZYFpU3c/CHzdL+BaQjrrDvmK
 Dyk5JVE5rwK5hllvXGCdkIxJ2UkOZW0=
X-Google-Smtp-Source: ACHHUZ5AoZPs+r/7DwvwKj35QRVR65SGwnxfYmGKp3hrG2i3+OZMjNMEv/YqpDAgMgtHtUgZRiQNKg==
X-Received: by 2002:a05:6a00:194f:b0:643:8496:e41c with SMTP id
 s15-20020a056a00194f00b006438496e41cmr4944922pfk.20.1686799943768; 
 Wed, 14 Jun 2023 20:32:23 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 c9-20020a62e809000000b0064d48d98260sm11022394pfi.156.2023.06.14.20.32.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 20:32:23 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 13:32:18 +1000
Message-Id: <CTCWOA3I3X48.2RZG2THERVO2@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: <clg@kaod.org>, "Greg Kurz" <groug@kaod.org>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>
Subject: Re: [PATCH v2 05/10] target/ppc: Change parameter of
 cpu_interrupt_exittb() to an env pointer
X-Mailer: aerc 0.14.0
References: <cover.1686776990.git.balaton@eik.bme.hu>
 <78ecd505a8b523e236cbeab335aa0621f7834cc5.1686776990.git.balaton@eik.bme.hu>
In-Reply-To: <78ecd505a8b523e236cbeab335aa0621f7834cc5.1686776990.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Thu Jun 15, 2023 at 7:34 AM AEST, BALATON Zoltan wrote:
> Changing the parameter of cpu_interrupt_exittb() from CPUState to env
> allows removing some more local CPUState variables in callers.

I think it's more consistent to keep cs, which is same as
cpu_interrupt().

Thanks,
Nick

