Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 893EF7B0200
	for <lists+qemu-devel@lfdr.de>; Wed, 27 Sep 2023 12:39:31 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qlRwV-0007aU-O4; Wed, 27 Sep 2023 06:38:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qlRwS-0007a1-Uu
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:38:52 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1qlRwP-0008Ev-HF
 for qemu-devel@nongnu.org; Wed, 27 Sep 2023 06:38:52 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-692eed30152so4708885b3a.1
 for <qemu-devel@nongnu.org>; Wed, 27 Sep 2023 03:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1695811127; x=1696415927; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=blF+IW3pnJulgcvbESgGPMb+9rmsf7LlFzPO6dsc1nU=;
 b=Q+oyA2Jfn0TAaO066PBEankFYMHjFaNf74kDYscPHsWZjsL3qtRBzGfQrE9/3cEsUD
 BQ4i+wwMFT6zl4VBRuGEam7w+HBblUuvCXf6LR27d6owgJ1pTSOVYcX9g+g2Z0zJ0jE5
 LDlg9zJ3PxIcR14Vs4vCA6+I++LvCDcSb8D9A9CzAEdmHccmpNofHIrp5cc9cDub+Or/
 BvsXMKJ7mSBb8Lpm3CDVAQm+XbrHdGwaAPhGqisowjuA7taG4rabndl+nlpIn7WQEr8w
 FemqDGZz8HDJXGBWVLtXhFrb66wjMQ3ZHBWkt1IS8rHf6juDAIeAApM2CQOljTlQtfE2
 KhSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695811127; x=1696415927;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=blF+IW3pnJulgcvbESgGPMb+9rmsf7LlFzPO6dsc1nU=;
 b=qZ6IdqlB6bXCXfavXSHSmibvAEOMD1U9oH3mxSLbvu7knQ8sNs220cTow1/ZvKfofV
 4N5h+3BfabqQVxv9+d5SPgVPsZlFHucoAo1SQ5afeAGOjhX8XeK0W8f4XIxK4c06YQjr
 XvihiFVbrg4zTbWE6ntwI/eCmkvqdWFGGn9R0XX0HdqWjlIM4CyN/b1gpWv7y7ykgpmV
 1c9EQv+EHjYVgtCsRfGo91dt4kilhi+oyR4CkKyFfMVN7gNAWGXv1oZyQefdo2so318E
 hSAI3Jk11J71sQsrX6KU3B7U1sghRnFf8jMxYXSsZJmQGJ/NR1EhqcEd/ZVcxt4j5vEu
 DwWw==
X-Gm-Message-State: AOJu0YzBZfnMIqPNG7FZusZ3uctBsyhYn0Wn3RG2cnOD8Yby1E4ogo9w
 K6bm0EjC7bZTnFD7/A3BuYU=
X-Google-Smtp-Source: AGHT+IHZEBuXB6+CeNG1HDIeZAa3/9KxKXpS1h8XZIwyeUVgDBL7En+vBxEF1LlObfErKHt1uZ0cmQ==
X-Received: by 2002:a05:6a20:1385:b0:14c:c393:402d with SMTP id
 hn5-20020a056a20138500b0014cc393402dmr1388310pzc.34.1695811127571; 
 Wed, 27 Sep 2023 03:38:47 -0700 (PDT)
Received: from localhost ([203.63.110.121]) by smtp.gmail.com with ESMTPSA id
 a5-20020a1709027d8500b001bfd92ec592sm12707529plm.292.2023.09.27.03.38.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Sep 2023 03:38:47 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 27 Sep 2023 20:38:42 +1000
Message-Id: <CVTMVEVPSNT0.1TRMEN1UKYZXT@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Tokarev" <mjt@tls.msk.ru>, "Richard Henderson"
 <richard.henderson@linaro.org>
Cc: "Paolo Bonzini" <pbonzini@redhat.com>, <qemu-devel@nongnu.org>,
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, "Ivan Warren"
 <ivan@vmfacility.fr>
Subject: Re: [PATCH] accel/tcg: mttcg remove false-negative halted assertion
X-Mailer: aerc 0.15.2
References: <20230829010658.8252-1-npiggin@gmail.com>
 <fcadf562-1946-0dc0-9f68-95785aacb2c0@tls.msk.ru>
In-Reply-To: <fcadf562-1946-0dc0-9f68-95785aacb2c0@tls.msk.ru>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Fri Sep 22, 2023 at 4:25 AM AEST, Michael Tokarev wrote:
> 29.08.2023 04:06, Nicholas Piggin wrote:
> > mttcg asserts that an execution ending with EXCP_HALTED must have
> > cpu->halted. However between the event or instruction that sets
> > cpu->halted and requests exit and the assertion here, an
> > asynchronous event could clear cpu->halted.
> >=20
> > This leads to crashes running AIX on ppc/pseries because it uses
> > H_CEDE/H_PROD hcalls, where H_CEDE sets self->halted =3D 1 and
> > H_PROD sets other cpu->halted =3D 0 and kicks it.
> >=20
> > H_PROD could be turned into an interrupt to wake, but several other
> > places in ppc, sparc, and semihosting follow what looks like a similar
> > pattern setting halted =3D 0 directly. So remove this assertion.
> >=20
> > Reported-by: Ivan Warren <ivan@vmfacility.fr>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>
> This one also smells like a stable material, is it not?

Yeah I would say it is.

Thanks,
Nick

>
> Thanks,
>
> /mjt
>
> > diff --git a/accel/tcg/tcg-accel-ops-mttcg.c b/accel/tcg/tcg-accel-ops-=
mttcg.c
> > index b276262007..d0b6f288d9 100644
> > --- a/accel/tcg/tcg-accel-ops-mttcg.c
> > +++ b/accel/tcg/tcg-accel-ops-mttcg.c
> > @@ -98,17 +98,6 @@ static void *mttcg_cpu_thread_fn(void *arg)
> >               case EXCP_DEBUG:
> >                   cpu_handle_guest_debug(cpu);
> >                   break;
> > -            case EXCP_HALTED:
> > -                /*
> > -                 * during start-up the vCPU is reset and the thread is
> > -                 * kicked several times. If we don't ensure we go back
> > -                 * to sleep in the halted state we won't cleanly
> > -                 * start-up when the vCPU is enabled.
> > -                 *
> > -                 * cpu->halted should ensure we sleep in wait_io_event
> > -                 */
> > -                g_assert(cpu->halted);
> > -                break;
> >               case EXCP_ATOMIC:
> >                   qemu_mutex_unlock_iothread();
> >                   cpu_exec_step_atomic(cpu);


