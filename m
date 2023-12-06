Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 0421C807359
	for <lists+qemu-devel@lfdr.de>; Wed,  6 Dec 2023 16:06:45 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rAtSr-0005dG-MG; Wed, 06 Dec 2023 10:05:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAtSa-0005c4-Dc
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:05:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rAtSQ-00031z-0C
 for qemu-devel@nongnu.org; Wed, 06 Dec 2023 10:05:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1701875100;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jJdqQz+j66uuKVQcTJXhfyo35jBHUCQcBJKCdIlZVYk=;
 b=aaksf2TKCmv427CJzFbRI1+3G4mYiqUUZ5V/Fs2hchLP7KpTkquelCT9GPDDsxJY1Txuj4
 O2yJgakuhKWyy162OMwu/rxRwws5cg1hmiF4YvkCRA1VvXsuZlRl9FxnBwjURvtXy3NCa7
 zZRvDN8TBCEgGKNXg7GH+flyY0tqwTo=
Received: from mail-oo1-f69.google.com (mail-oo1-f69.google.com
 [209.85.161.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-n2YSpiGRPdSgavewtNtWRw-1; Wed, 06 Dec 2023 10:04:58 -0500
X-MC-Unique: n2YSpiGRPdSgavewtNtWRw-1
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-58d8e773afaso9554801eaf.1
 for <qemu-devel@nongnu.org>; Wed, 06 Dec 2023 07:04:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701875097; x=1702479897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=jJdqQz+j66uuKVQcTJXhfyo35jBHUCQcBJKCdIlZVYk=;
 b=vGHanIs0DU+zklVa8NOBxBN+EQdt6Bt6yB0aeBYM1mNdgxV4k4tkGV0xYoj5I+cj7k
 EkJt+Ea5uUbS7t7kjDn06i6v82dYawc0ogLdB3P0yTwNtJQCxwz5ur9EGvdc7xQERzhl
 g+zhDJpVSY1liy3Il+qFQsdJ3MC9FA//C2VjLKflDr97RKEhFUKIXZImCeALSGhnHboJ
 /odxRGxnpZCw5DS4LSJbsTQ5dVkxSmM6/hrYrWdkIlejEjRia79EgkCAo/FfqX7LiSyo
 Tn8DM86tbRzdz4sLQdpNL55btJRWo4ZrMFtsK8Gu8sznQsLQyoy2EiHMz17LbYhN6fjX
 QdJA==
X-Gm-Message-State: AOJu0YyLIPdo8X9WDk9ZXCasNiAC1exSDhsGGbW9iHC0mtI8GoR9ppSn
 cCFvCG00nVeq1r8iQIK5w5s+g/fJsqbJOp/O00ctH7g081WBKbvFeNgjBNBOedpOjsTDFAdkbq+
 Yusb2CxpBenkIpVw6j+51qj9A2pMxVnI=
X-Received: by 2002:a05:6358:91e:b0:170:6ed7:3915 with SMTP id
 r30-20020a056358091e00b001706ed73915mr500574rwi.57.1701875097491; 
 Wed, 06 Dec 2023 07:04:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKMm71528Ga8tz7EfKhVM+4FsTdLZHWMBtOB5p3o/0lcUbNOWGvhMWrtqJTy4cGoHG0lWMn7Grm97sF2VcejQ=
X-Received: by 2002:a05:6358:91e:b0:170:6ed7:3915 with SMTP id
 r30-20020a056358091e00b001706ed73915mr500552rwi.57.1701875097139; Wed, 06 Dec
 2023 07:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20231205222816.1152720-1-michael.roth@amd.com>
 <CABgObfb0YmHuw6v9AGK6FpsYA1F3eV2=4RKaxkmVrp97QCDM3A@mail.gmail.com>
 <20231206144605.mwphsaggqumiqh3k@amd.com>
In-Reply-To: <20231206144605.mwphsaggqumiqh3k@amd.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 6 Dec 2023 16:04:43 +0100
Message-ID: <CABgObfaF=rJL-V0vBTnNMGFreRD2cJCjkYHxYBFjZktyd+dH8A@mail.gmail.com>
Subject: Re: [PATCH v2 for-8.2?] i386/sev: Avoid SEV-ES crash due to missing
 MSR_EFER_LMA bit
To: Michael Roth <michael.roth@amd.com>
Cc: qemu-devel@nongnu.org, Marcelo Tosatti <mtosatti@redhat.com>, 
 Tom Lendacky <thomas.lendacky@amd.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Dec 6, 2023 at 3:46=E2=80=AFPM Michael Roth <michael.roth@amd.com> =
wrote:
> > There is no need to check cr0_old or sev_es_enabled(); EFER.LMA is
> > simply EFER.LME && CR0.PG.
>
> Yah, I originally had it like that, but svm_set_cr0() in the kernel only
> sets it in vcpu->arch.efer it when setting CR0.PG, so I thought it might
> be safer to be more selective and mirror that handling on the QEMU side
> so we can leave as much of any other sanity checks on kernel/QEMU side
> intact as possible. E.g., if some other bug in the kernel ends up
> unsetting EFER.LMA while paging is still enabled, we'd still notice that
> when passing it back in via KVM_SET_SREGS*.
>
> But agree it's simpler to just always set it based on CR0.PG and EFER.LMA
> and can send a v3 if that's preferred.

Yeah, in this case I think the chance of something breaking is really,
really small.

The behavior of svm_set_cr0() is more due to how the surrounding code
looks like, than anything else.

> > Alternatively, sev_es_enabled() could be an assertion, that is:
> >
> >     if ((env->efer & MSR_EFER_LME) && (env->cr[0] & CR0_PG_MASK) &&
> >        !(env->efer & MSR_EFER_LMA)) {
> >         /* Workaround for... */
> >         assert(sev_es_enabled());
> >         env->efer |=3D MSR_EFER_LMA;
> >     }
> >
> > What do you think?
>
> I'm a little apprehensive about this approach for similar reasons as
> above

I agree on this. I think it's worth in general to have clear
expectations, though. If you think it's worrisome, we can commit it
without assertion now and add it in 9.0.

Paolo


