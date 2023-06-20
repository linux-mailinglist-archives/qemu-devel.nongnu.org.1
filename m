Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F61673682F
	for <lists+qemu-devel@lfdr.de>; Tue, 20 Jun 2023 11:44:55 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qBXri-0000bL-6m; Tue, 20 Jun 2023 05:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBXrf-0000N0-7O; Tue, 20 Jun 2023 05:41:31 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1qBXrd-0007Bg-Fo; Tue, 20 Jun 2023 05:41:30 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-25e83254ff5so2897742a91.1; 
 Tue, 20 Jun 2023 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1687254087; x=1689846087;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FZmz/Ic++bv42p52NE50sHDdATvyhhRmbkgBYqr9yZw=;
 b=YeOPFQV5dTn7PiiMa/7GVo1lpz3DQ+enTQiHvGlLNfg9pMFLT5sp7wtHONMXsmaqAM
 o6Wo5OpbMpo8bKB0V2tCQktf6AeoMQuv/4Xx6dLqPFU55ydd0oTlLuCLwVioipPzufoc
 55k9dvB7hxhraVHVVjZSbzvWXaZ21TfaNDXpciXXaAnY2+o6FFGMW8cUAv62/yhudu/7
 o/di3S3H7RpRSwvtTDHo2Huh/0Eqfw28b0XCwp2HCfP7SfAPoq6SshG/yEdW5DmwKcu+
 JntWWsc0/lvKYMPMZa27QLfzgBqzDe/Gt3ec3381duwmo12JbK93eaHfYt9UUhN+5Qfe
 xpew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687254087; x=1689846087;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FZmz/Ic++bv42p52NE50sHDdATvyhhRmbkgBYqr9yZw=;
 b=Avugl4sS85du97wBxGb06N+OmLSeTKdRgBhxEgEIahk3PfqfRTpmu/UKIRViXiUAOu
 b+Cop7LM0ZHbF8hUOsmYL0RTiiG/yHaoVuWJDoqEl+n23wdqVzQY87oTfY0VjgttUPvW
 N1XcPuGeASb7XZmvnmkRMvS+QGEdtYjsC1QzKm/J+w1hS6YXZyE3jvEiIrNdqeqCDlnW
 FdSKZuZSOXR3ksAYkh3/3Eqak+3nYneluOajbyWqsov/OANQFRoF8rq7+7D+lB0ZQe0b
 xrdV8zmIYefju9gCGA6YyO/8JuFbslHx1h4DWdyAR52D7QL1DEhpe6E73SUSNpudkBzw
 6hpA==
X-Gm-Message-State: AC+VfDwtSXz/NA7BLqIN8ggPtvWRzzl/8hA678W7khfl6TAiMYShj+cr
 xPYsHnu7FTyoXfFTjfDpB5g=
X-Google-Smtp-Source: ACHHUZ6ACLJ0wEbPVIcqUKmCs2KSfzUoAM8jzVEbVJit+0MlZE0XFbOedtU3330Ga0eyLR5e+giucw==
X-Received: by 2002:a17:90a:6688:b0:25b:e310:ca6 with SMTP id
 m8-20020a17090a668800b0025be3100ca6mr24197023pjj.9.1687254087411; 
 Tue, 20 Jun 2023 02:41:27 -0700 (PDT)
Received: from localhost ([124.170.190.103]) by smtp.gmail.com with ESMTPSA id
 jb18-20020a170903259200b001b552309aedsm1206826plb.192.2023.06.20.02.41.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Jun 2023 02:41:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 20 Jun 2023 19:41:22 +1000
Message-Id: <CTHDNKZRX1TT.2HBN6USDIKCU4@wheely>
Subject: Re: [PATCH 4/4] spapr: Allow up to 8 threads SMT on POWER8 and newer
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>
Cc: <qemu-devel@nongnu.org>, "Daniel Henrique Barboza"
 <dbarboza@ventanamicro.com>, =?utf-8?q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
X-Mailer: aerc 0.14.0
References: <20230605112323.179259-1-npiggin@gmail.com>
 <20230605112323.179259-5-npiggin@gmail.com>
 <374c620b-abc2-a5a0-6cdf-cbc0294137f3@linux.ibm.com>
In-Reply-To: <374c620b-abc2-a5a0-6cdf-cbc0294137f3@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1035.google.com
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

On Tue Jun 20, 2023 at 7:27 PM AEST, Harsh Prateek Bora wrote:
>
>
> On 6/5/23 16:53, Nicholas Piggin wrote:
> > PPC TCG now supports multi-threaded CPU configuration for non-hyperviso=
r
> > state. This requires PIR and TIR be set, because that's how sibling thr=
ead
> > matching is done.
> >=20
> > spapr's nested-HV capability does not currently coexist with SMT. This
> > is quite analogous to LPAR-per-core mode on real hardware which also
> > does not support KVM.
> >=20
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >   hw/ppc/spapr.c          | 16 ++++++++++++----
> >   hw/ppc/spapr_caps.c     | 14 ++++++++++++++
> >   hw/ppc/spapr_cpu_core.c |  7 +++++--
> >   3 files changed, 31 insertions(+), 6 deletions(-)
> >=20
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index dcb7f1c70a..deb8b507e3 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -2524,10 +2524,18 @@ static void spapr_set_vsmt_mode(SpaprMachineSta=
te *spapr, Error **errp)
> >       int ret;
> >       unsigned int smp_threads =3D ms->smp.threads;
> >  =20
> > -    if (!kvm_enabled() && (smp_threads > 1)) {
> > -        error_setg(errp, "TCG cannot support more than 1 thread/core "
> > -                   "on a pseries machine");
> > -        return;
> > +    if (!kvm_enabled()) {
>
> Can we make it a check for tcg_enabled() which would be more appropriate=
=20
> or as Cedric suggested, may be include this one along with your series:
>
> https://lore.kernel.org/qemu-devel/20230620074802.86898-1-philmd@linaro.o=
rg/

Good point, I'll keep it in mind.

Thanks,
Nick

