Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id A6C9A83707A
	for <lists+qemu-devel@lfdr.de>; Mon, 22 Jan 2024 19:46:13 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rRzIn-0007EM-MS; Mon, 22 Jan 2024 13:45:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rRzIk-0007E6-AJ
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:45:43 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rRzIi-0007Iu-25
 for qemu-devel@nongnu.org; Mon, 22 Jan 2024 13:45:42 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5cfa71498feso3104674a12.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jan 2024 10:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1705949137; x=1706553937; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Gg6hOHYt9miPKuXDNuoaZKiN//iZaaImFaBzLk0Zhgk=;
 b=nZCvk4mchDI2ptWw8voLga6Xah8zYaX6Ke7/l3+G6vMxGcuaONahA3OvY7692+zARS
 J1KuT5tgIHPsHSqG9Y+KK0s+ppkQ9Sjuv21AhJb2LBhdrXRQTpzCX9gohdH4j6MvuyNF
 eYDnwz34NTER9Dil7xj+7DawPsN6sEx0ohJAgdwwTqFUWWJYs10rY2ptcQ6gMAIcOTbc
 1/vPxUiIKQyh7Gu5EUkZIpmZoNNd/OvIOd4iXPaN6W0KI6eZr68oj3gQFauHDSeeiKwL
 4qw9vTADD8KVOsT0pAYVqi0oxs9dL1aNgHMPp5bW78QELR83ICWc64qsbmhMN/oV5KLW
 PeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705949137; x=1706553937;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Gg6hOHYt9miPKuXDNuoaZKiN//iZaaImFaBzLk0Zhgk=;
 b=LyiS2DhYn0S68Q+HzcbcZbwLQcZtFcB4+NLIdrAWdoB57L+Fy8HD7pIs5SXRfH5Kvn
 3WL9FrMkyfozKUFirWgFEPPOGuWdWR00TOl8SgEcDUMqGYFueZ700gmnh/XZNQADqh7V
 1m5EyYMO7fWTDvVNFFZTE74MYkEFP26IfQilhW4Qj7euA3CXt+TPpKg/X0B0s9w6IyWQ
 H8URHozuwiMSZtbvP79hlxJM6FXBrTmLQuQnJLuBKVugUzfIo4fKYFEENXdEHwJs2mqQ
 BWyYHAZow+lZSvy7AHACArj1gxZFbiBfjmIFHPsogvb4t/gXN7mbzcoSEe8iRv4pibGU
 msng==
X-Gm-Message-State: AOJu0YxdLQV9uEdlGeTzrYdF/l/MN+SroReMHmRLhh7biw5YNA6TTEE6
 uBKnLjJOBGhJ1PiYydSO/9EyegqSdMv+uLHCHmKAkm9fGo8EjZo3+Vm/ckUU07bLHjDbAGOE23Y
 rSxPIv1CveCwKmIFOyDPYsM5jY4U=
X-Google-Smtp-Source: AGHT+IEJ0lNmMIQN9brgKOfq6sCotXKUXT1LFyrEQkQStlbIR8BBTq3tx2GM60ffBXua3/S1rsjUC15yvIItTEWaKh4=
X-Received: by 2002:a17:90a:3ee4:b0:28e:76f5:f9ca with SMTP id
 k91-20020a17090a3ee400b0028e76f5f9camr2082972pjc.62.1705949136688; Mon, 22
 Jan 2024 10:45:36 -0800 (PST)
MIME-Version: 1.0
References: <20240119204608.779541-1-jcmvbkbc@gmail.com>
 <20240119204608.779541-2-jcmvbkbc@gmail.com>
 <CAFEAcA-dSxaseY+w_z-U1pa8XkJ9XTyBWekXvH0q0XkrZJ+jNA@mail.gmail.com>
In-Reply-To: <CAFEAcA-dSxaseY+w_z-U1pa8XkJ9XTyBWekXvH0q0XkrZJ+jNA@mail.gmail.com>
From: Max Filippov <jcmvbkbc@gmail.com>
Date: Mon, 22 Jan 2024 10:45:25 -0800
Message-ID: <CAMo8BfKWg14m9HG+3D9YiGdJ5JZsphU9AF4d6jha-DPbhr8TOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/xtensa: wrap MMU and MPU state into structures
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pg1-x531.google.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.998, HK_RANDOM_FROM=0.998,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Mon, Jan 22, 2024 at 10:29=E2=80=AFAM Peter Maydell <peter.maydell@linar=
o.org> wrote:
>
> On Fri, 19 Jan 2024 at 20:47, Max Filippov <jcmvbkbc@gmail.com> wrote:
> >
> > Make separation of alternative xtensa memory management options state
> > explicit.
> >
> > Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> > ---
> >  target/xtensa/cpu.h        | 18 +++++++++++++----
> >  target/xtensa/mmu_helper.c | 40 +++++++++++++++++++-------------------
> >  2 files changed, 34 insertions(+), 24 deletions(-)
> >
> > diff --git a/target/xtensa/cpu.h b/target/xtensa/cpu.h
> > index 8a423706d8c0..497325466397 100644
> > --- a/target/xtensa/cpu.h
> > +++ b/target/xtensa/cpu.h
> > @@ -326,11 +326,21 @@ typedef struct xtensa_tlb {
> >      unsigned nrefillentries;
> >  } xtensa_tlb;
> >
> > +typedef struct XtensaMMU {
> > +    xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
> > +    xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
> > +    unsigned autorefill_idx;
> > +} XtensaMMU;
> > +
> >  typedef struct xtensa_mpu_entry {
> >      uint32_t vaddr;
> >      uint32_t attr;
> >  } xtensa_mpu_entry;
> >
> > +typedef struct XtensaMPU {
> > +    xtensa_mpu_entry fg[MAX_MPU_FOREGROUND_SEGMENTS];
> > +} XtensaMPU;
> > +
> >  typedef struct XtensaGdbReg {
> >      int targno;
> >      unsigned flags;
> > @@ -526,10 +536,10 @@ struct CPUArchState {
> >      uint32_t exclusive_val;
> >
> >  #ifndef CONFIG_USER_ONLY
> > -    xtensa_tlb_entry itlb[7][MAX_TLB_WAY_SIZE];
> > -    xtensa_tlb_entry dtlb[10][MAX_TLB_WAY_SIZE];
> > -    xtensa_mpu_entry mpu_fg[MAX_MPU_FOREGROUND_SEGMENTS];
> > -    unsigned autorefill_idx;
> > +    union {
> > +        XtensaMMU mmu;
> > +        XtensaMPU mpu;
> > +    };
>
> Is it really worth having this be a union ? I suspect it will
> make adding migration/savevm support later more awkward.

I have a draft implementation of savevm for xtensa and I did this part
using subsections with the .needed callback checking whether the
MMU or MPU option is enabled in the config. I wonder where the
awkwardness is expected.

> Otherwise
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks!

-- Max

