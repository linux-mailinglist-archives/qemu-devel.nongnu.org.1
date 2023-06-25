Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD7773CFAE
	for <lists+qemu-devel@lfdr.de>; Sun, 25 Jun 2023 11:21:22 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qDLvY-0004Us-PK; Sun, 25 Jun 2023 05:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDLvW-0004UC-FY; Sun, 25 Jun 2023 05:20:58 -0400
Received: from mail-ot1-x336.google.com ([2607:f8b0:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qDLvU-0004uV-UE; Sun, 25 Jun 2023 05:20:58 -0400
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-6b73b839025so626079a34.1; 
 Sun, 25 Jun 2023 02:20:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687684855; x=1690276855;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rkkZyPFgohN/gSy4X3XlalR0OskQqaGHyQTG4CuBUsc=;
 b=p+GAnOyuGrFjNsEMFzjeEHmkxhuocA/1fEmzvVGRpWmKO8HW3phndcOQvKIfFJ2VtY
 8ZhEfqwqnG1cG4lb+lsSciRQuekrnaQaceV9/xBDyvnWH6wl+peUP/G6qQS8Q6Tm0653
 gcN7e+5rvu1E/6/ySUNhAYQgvJ90T0EYlBpUe6EQGxM0dGiWitETO0dPk9mBAeqN9mQn
 RBCykjRT7PnieHzB7axYleqVX3bmIg7/wt3iXolzyTyAD4lU6FXQIlnWdx6xz8EQqKKM
 XBzOnP0RZtkASh2+8SUqgCBDFd9k2KiYhuZ9eE2ePL6p4Z6L41oLc7kRStyES04rHajG
 6xBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687684855; x=1690276855;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=rkkZyPFgohN/gSy4X3XlalR0OskQqaGHyQTG4CuBUsc=;
 b=hws+gy2suIR9ohoNQFix31dbKacXxSqVpfaruZvj0XVFaLQLzWSVqG7mtnRltjISax
 kyXM25vZ77sTGxqgif42B+6mIgnMdRMQgmUf/Dsz8cg07XMI6WvjvFJnJxU+NOpNH/yX
 KhNjP3Oox6bNir0smtZyFoiFrrFOle9UzWPBKH+jbmLCLU95nSM3n1qvZOeaZUUz4oPE
 ntbcNh36SOp0Apoe4PybPUPypDa8qeeEEgzpP/a4UAHqi/8r806jvoUqkJDX+298JzfV
 sFphFKCnLhcUtOLkTb7OYOcwY8vhhHU+gl5uwHQqj/c2bmkQulkQe+BSgwFvNSdSYkkE
 QKRg==
X-Gm-Message-State: AC+VfDxfk4ShU11dvfY2NWZJl321WObN/kL0YWwqcHeookFqo4BGr8tT
 NiGxWmydEyYeRbEJUEnq4x0AscfS9Rs=
X-Google-Smtp-Source: ACHHUZ4a19+ZxJzcF8WdAh613M9Z8St1wPODhL0LSJZ0ZliwAX1hd8Yz0CpzGudu5ULuIV/UxRdFeA==
X-Received: by 2002:a9d:5e8b:0:b0:6b2:ac44:bf88 with SMTP id
 f11-20020a9d5e8b000000b006b2ac44bf88mr26426371otl.10.1687684855358; 
 Sun, 25 Jun 2023 02:20:55 -0700 (PDT)
Received: from localhost (193-116-198-102.tpgi.com.au. [193.116.198.102])
 by smtp.gmail.com with ESMTPSA id
 o12-20020a170902d4cc00b001b19d14a3d5sm2223044plg.68.2023.06.25.02.20.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Jun 2023 02:20:54 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 25 Jun 2023 19:20:48 +1000
Message-Id: <CTLMCKAEF701.1EU64K055P8A6@wheely>
Cc: <qemu-devel@nongnu.org>, "Christophe Leroy"
 <christophe.leroy@csgroup.eu>, "BALATON Zoltan" <balaton@eik.bme.hu>,
 "Harsh Prateek Bora" <harshpb@linux.ibm.com>, "Daniel Henrique Barboza"
 <danielhb413@gmail.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 "David Gibson" <david@gibson.dropbear.id.au>, "Greg Kurz" <groug@kaod.org>
Subject: Re: [PATCH 3/4] target/ppc: Move common check in machne check
 handlers to a function
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Fabiano Rosas" <farosas@suse.de>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20230623081953.290875-1-npiggin@gmail.com>
 <20230623081953.290875-4-npiggin@gmail.com> <87edm2s4bh.fsf@suse.de>
In-Reply-To: <87edm2s4bh.fsf@suse.de>
Received-SPF: pass client-ip=2607:f8b0:4864:20::336;
 envelope-from=npiggin@gmail.com; helo=mail-ot1-x336.google.com
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

On Fri Jun 23, 2023 at 11:20 PM AEST, Fabiano Rosas wrote:
> Nicholas Piggin <npiggin@gmail.com> writes:
>
> > From: BALATON Zoltan <balaton@eik.bme.hu>
> >
> > All powerpc exception handlers share some code when handling machine
> > check exceptions. Move this to a common function.
> >
>
> Maybe Machine Check is simple enough, but this kind of sharing of code
> has historically caused pain when people want to change something for
> the modern cpus and end up affecting the old cpus by mistake.
>
> There is also the inverse scenario where someone has access to the old
> HW and just want to make an one-off contribution, but the community gets
> insecure about it because it could also affect the new cpus.
>
> Then comes the obvious "solution" which is to bring in an artificial
> identifier (excp. model) to be able to have conditional code inside the
> common function. And that causes problems because no one really knows
> how it maps to actual hardware/ISA.
>
> No objection, just a little cautionary tale. =3D)

Thanks Fabiano, good point. I know you spent a lot of work on untangling
this mess. I'll think a bit more about it. Seems we need to at least make
a few fixes first before we can turn this on for upstream.

Thanks,
Nick

