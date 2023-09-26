Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B167AEE11
	for <lists+qemu-devel@lfdr.de>; Tue, 26 Sep 2023 15:47:38 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ql8P8-0002yd-I1; Tue, 26 Sep 2023 09:47:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8P5-0002xn-N8
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:47:08 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ql8P3-0000BL-Ie
 for qemu-devel@nongnu.org; Tue, 26 Sep 2023 09:47:07 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-5033918c09eso14130337e87.2
 for <qemu-devel@nongnu.org>; Tue, 26 Sep 2023 06:47:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1695736023; x=1696340823; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CBdJnNg8oJ3UlbN0OeTjzzqqVvDscSG80mH0MUCNic8=;
 b=imHj/MT6Q4etR00ybSTKfq4BDrKV0Ckm5gkf1lfTo2bR0dFfslonO4RmIg9yIBbFN6
 W8mhdO/5fqTYJh5oyALv0JzvcO0zba3IHsmfN2h/egnVlrmBtTjxtaBF0nGY4pNjCoRF
 JvgU8JHOIIx2rk4U9Iy38xIT70rQrOH1UHsyVnGMfxwB1YGvoP955KKLBfK9j6YHT5+4
 R19cydaxV4D+onypEpuFv5zny14IPUyngKTcyPZZrq06asWgo33M6hUiv6Ub5wW8O9A6
 UXYa3J6bKijUbd8SNiuycfjdvQD4suaDE3rYiIC9wtQ5fegtAcnv0S83SjPPnqzQ+BTx
 dbsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695736023; x=1696340823;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CBdJnNg8oJ3UlbN0OeTjzzqqVvDscSG80mH0MUCNic8=;
 b=oKAZfAc5M4OfbXRpYBtgZ5+IvsV6HlKd6sng7LqG1QYEHPERfpYtwqXyBfhv3ebfn6
 77beHKHtzaSOHAm4O08auhnG1Qw/yACaJkzgLqKKxFbKGApN3KXLYDyLbvwYdOSbMM5+
 Y0IHx8iZupsaPHP7IiAsZ3RTVM4WaAPKi4khN91HfLAfp8Sx2NKVomMWuYkjLPXqPh1K
 Y2sWeN0foGgfs5kANT/6tMR1ZMYHQgTeV0AVwS4dYd6Kl2A+LvMIDaCaWXLGwUC6r4Ls
 1PwfcO7EL2bSfbAsGRxs7ZEpYfgBPoVODMpY4XNcdCDMN7YfC86PjOsR2uSOGMtCRdN+
 c+Nw==
X-Gm-Message-State: AOJu0Ywmi8/ImOSdcmP5Gkbd79XFhGOjUD5RVCMB5k384s4wSiBmuNsv
 6p3O/BHV/kHlGK8dCJxU3y5VI4tWutMovPLAMIWWZw==
X-Google-Smtp-Source: AGHT+IE8wcKYfeG8hIqyLgjXoXfBUp0dSzzRvPp1ZFeCudsiqGvUP4bff3ttdRNy11S67YA0BNfm0p+aZKmOMKMC47c=
X-Received: by 2002:a19:4310:0:b0:4ff:70d2:4512 with SMTP id
 q16-20020a194310000000b004ff70d24512mr7562277lfa.23.1695736022410; Tue, 26
 Sep 2023 06:47:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230926102801.512107-1-andrey.drobyshev@virtuozzo.com>
 <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
In-Reply-To: <f27kkumticbgf6m2cvzggtnh5ikcfoexeeo2xs4lrim7muulq6@7kuhh475fffy>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 26 Sep 2023 14:46:44 +0100
Message-ID: <CAFEAcA85LwsFiBxbDiki6-8FAbmZSFFH7Esf+x8stiPDjww_KA@mail.gmail.com>
Subject: Re: [PATCH] mailmap: Fix Andrey Drobyshev author email
To: Eric Blake <eblake@redhat.com>
Cc: andrey.drobyshev@virtuozzo.com, qemu-devel@nongnu.org, kwolf@redhat.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
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

On Tue, 26 Sept 2023 at 14:40, Eric Blake <eblake@redhat.com> wrote:
>
> On Tue, Sep 26, 2023 at 01:28:01PM +0300, andrey.drobyshev@virtuozzo.com wrote:
> > From: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> >
> > This fixes authorship of commits 2848289168, 52b10c9c0c as the mailing
> > list rewrote the "From:" field in the corresponding patches.  See commit
> > 3bd2608db7 ("maint: Add .mailmap entries for patches claiming list
> > authorship") for explanation.
> >
> > Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> > ---
> >  .mailmap | 1 +
> >  1 file changed, 1 insertion(+)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>

Hi Eric -- you wrote commit 3bd2608db72997, which included the
comment for this bit of .mailmap:

+# Next, translate a few commits where mailman rewrote the From: line due
+# to strict SPF, although we prefer to avoid adding more entries like that.

What did you mean by "we prefer to avoid adding more entries" ?
It reads to me like "don't add more entries even if we get more
accidental attributed-to-the-list commits" (and I was actually
thinking about replying to this patch to say "the mailmap file
says we shouldn't add more of these lines"), but presumably since
you've reviewed this patch that wasn't the actual intention.
Maybe the comment could use clarification.

thanks
-- PMM

