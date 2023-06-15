Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C79D9730C76
	for <lists+qemu-devel@lfdr.de>; Thu, 15 Jun 2023 03:01:26 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q9bLE-0002Sw-56; Wed, 14 Jun 2023 21:00:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9bLB-0002SP-DT; Wed, 14 Jun 2023 20:59:57 -0400
Received: from mail-oo1-xc2f.google.com ([2607:f8b0:4864:20::c2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1q9bL9-0001qk-N3; Wed, 14 Jun 2023 20:59:56 -0400
Received: by mail-oo1-xc2f.google.com with SMTP id
 006d021491bc7-55b78f40301so1053280eaf.0; 
 Wed, 14 Jun 2023 17:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686790794; x=1689382794;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MblX7+FiPWLQcEUwjuZdUkBHMD4GoC8mxKbcYUdANk=;
 b=iYovWwWm8A98Ckw/pU0Mq9FFq3Xkprm75aKMBHENgna53uyqCVy/+FUEEjMoF4DC+J
 euY32Rffb8g6BUP56eGaA3kebOJKYp5uvFxSPSM3M/MU8cP8fGDkPsmANoYwdnB5uiNS
 LdaZnNUqfFF4Trp9wyfMLCuA9L5/ZC9gpScexXK4yFyfoyx0pIWf0JqIkbZO+mtxl6wW
 EpDLIlML+kc+MbDvCEuQ9On8mlIJOqhP2jJQM6k/j6c3XAfTNvgbPQJEEKx7q8jXPcTl
 oKYmBrC9xYIdTQam+Rh0qQJZu+5vI6s38vat0a84WhE2ky+3hjBRekPjNCSB29+Rf0uP
 MfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686790794; x=1689382794;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=/MblX7+FiPWLQcEUwjuZdUkBHMD4GoC8mxKbcYUdANk=;
 b=iNZhhlJUQXNYknc5M3AouWRqyX+ZuykAP5ciRzJFXxBxnkHc6p1uBtVteTm0otZQAY
 5pw5wQNWr0wYgkJarfuD63Rt4q5Pqi511cqyW9f2wjdVgaCPx2J3WyT672+FF3ioM7At
 /50BnaOSwXhJ+NsQDuWISPLlCMEBimUvg/UDpsm9HHPfMRKFMzXVIom6fTk6J/yEUFZ8
 rZm2R0dB8idxLKWTdtWx/tTixO+XXr0r1j1lbyDoVGPCP6IZ4lQWyZrAlUm1ml3OFR5D
 mqG9YRNJ8G5JmLrqC+cli958OVhV0vtdumqRAjWbJ61luR0Z1tbvKSAdJNv3UZvjrwRf
 yd6A==
X-Gm-Message-State: AC+VfDxwCDR0/HD/xJrUTLy9Mt01U590ngpOtVPs3Em4396c9vSN348r
 UJEXCR54+YrStZwZpBNZ+Ws=
X-Google-Smtp-Source: ACHHUZ7B73vekQtUAC7G/EiXgJj77im4NX9eXw+/xK81C9NT2HY4lnotJfcUe0RS6VPQimM54OO1hA==
X-Received: by 2002:a54:4f84:0:b0:39c:4563:d23c with SMTP id
 g4-20020a544f84000000b0039c4563d23cmr11901645oiy.46.1686790793750; 
 Wed, 14 Jun 2023 17:59:53 -0700 (PDT)
Received: from localhost (14-203-144-223.static.tpgi.com.au. [14.203.144.223])
 by smtp.gmail.com with ESMTPSA id
 12-20020a17090a004c00b0025bf1ea918asm5959966pjb.55.2023.06.14.17.59.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jun 2023 17:59:53 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 15 Jun 2023 10:59:48 +1000
Message-Id: <CTCTFII272SS.1FS8EBMFYFE5G@wheely>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
Cc: <qemu-devel@nongnu.org>, <qemu-ppc@nongnu.org>, <clg@kaod.org>, "Greg
 Kurz" <groug@kaod.org>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 06/10] target/ppc: Readability improvements in exception
 handlers
X-Mailer: aerc 0.14.0
References: <cover.1686522199.git.balaton@eik.bme.hu>
 <edbb93cb67b72bb948155932767ef989cddc8aa0.1686522199.git.balaton@eik.bme.hu>
 <CTC29HK3ZXQL.2GCE26RLVYS75@wheely>
 <38943a8a-5e25-8336-586a-615716ac1369@eik.bme.hu>
In-Reply-To: <38943a8a-5e25-8336-586a-615716ac1369@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2f;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc2f.google.com
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

On Wed Jun 14, 2023 at 8:07 PM AEST, BALATON Zoltan wrote:
> On Wed, 14 Jun 2023, Nicholas Piggin wrote:
> > On Mon Jun 12, 2023 at 8:42 AM AEST, BALATON Zoltan wrote:
> >> Improve readability by shortening some long comments, removing
> >> comments that state the obvious and dropping some empty lines so they
> >> don't distract when reading the code.
> >
> > Some changes are a matter of taste, but in the interest of having
> > somebody do some spring cleaning of this code I don't want to nitpick
> > it, so I won't :)
>
> Thanks. I prefer functions to be less streched out vertically so more=20
> lines fit in a single screen. Ideally the whole function should be visibl=
e=20
> so it's easier to comprehend than having to scroll around but if there's=
=20
> something really bothering you I can consider changing that. But if you=
=20
> can accept this as it is then that's less work for me.

I don't mind vertical white space, actually like it. I don't like too
much stuff done per line.

Thanks,
Nick

