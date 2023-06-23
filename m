Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4373573B8C4
	for <lists+qemu-devel@lfdr.de>; Fri, 23 Jun 2023 15:27:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qCgp4-0001Yd-R7; Fri, 23 Jun 2023 09:27:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgp2-0001TN-J0
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:27:32 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1qCgp0-0003HH-Rz
 for qemu-devel@nongnu.org; Fri, 23 Jun 2023 09:27:32 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2b47a15ca10so10980531fa.1
 for <qemu-devel@nongnu.org>; Fri, 23 Jun 2023 06:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1687526849; x=1690118849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JWnYhIuXt9i/LjXg34lV+Z+xs6p7udyXvWZ5GnrC470=;
 b=Ermn2681P1WCmurC0Io80ftaK7a6efOJ4GPdKR7yhDvV0i5PL5P5b1nb5BnYnTPiHl
 uHBZOrH+YmG4R6R9kjBJJxK/Jbc2l8qo74dlPPJdXyZfMzPxe+zeaZ33fAdgkC/HUELr
 ju12AO5WzzRYpEjdHhH+Dxn9NOogemT8bhKDSaPja/V37VmbUDBiltuDslpadXUX+4l9
 UykTld02/nm/QbFSM1R4O+9/Ab219IJ/c8OBVMW7BfiIfsJplhs6GNd0mmp2yjs1KAtt
 Y3oWWqtREtOkx6J6as0sKquhhaX3iNpOaABsddDwIPhmvbmtQowD/55vvIgJf6vCE2Rd
 apnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687526849; x=1690118849;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JWnYhIuXt9i/LjXg34lV+Z+xs6p7udyXvWZ5GnrC470=;
 b=bn2jOIneivQpJQaE/rRRgvSb3pB2bYl7gMmZao+BtWTggzTiAdHGE1wKckfZKXYgcd
 z8YHtlcisqIOwCURdWPAUPx+8nj87a845q+uuZySUBVg17soiCJv5jjvYHv3vDcKvyzH
 uQUj81BOupwRuBG99vtVBvSUX+6llTvOkVuxcLNsdri5oryYZh3EFpw0+M4Wow0gmjng
 1P0zdBMcipyaS57J/aY0NO/ATViEDX1zqSYcwHqkHEVxqZ6m+63Vfh62f2Ba9dCBQnu1
 XEd9mzyYThC2+gPAY8LNaZxnj4W6SxyvEVMoLcb+fPYxzcs02+wZrVxx26BlfarJrx4/
 345g==
X-Gm-Message-State: AC+VfDyQJmQa9R72fHGGlmMZFezpGq6ole4CPJzZD/mc0M6iTxDb+eca
 71dJNkmttpRvS7h0TWHTMJOloYiGhkX0n6gIAL7Wpzsl2xyJwLXt
X-Google-Smtp-Source: ACHHUZ7MfEcWZcKoCdCEVhzotOvJMBYXYCp0wjMw7H/ehSmddNSjJkK5UNxNwNhveCcN/ZlySvt08RyDFtP2NNcjjxk=
X-Received: by 2002:a2e:9cd1:0:b0:2b4:70c1:b484 with SMTP id
 g17-20020a2e9cd1000000b002b470c1b484mr11642729ljj.38.1687526848758; Fri, 23
 Jun 2023 06:27:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230302123029.153265-1-pbonzini@redhat.com>
 <20230302123029.153265-58-pbonzini@redhat.com>
 <CAFEAcA9j2cnRVtfxyn=hspgoe0FrAVk7hj1Y=jPiosziz=CD9g@mail.gmail.com>
 <4a447dc0967186cb92605eb54209636e9eace8f0.camel@amazon.co.uk>
In-Reply-To: <4a447dc0967186cb92605eb54209636e9eace8f0.camel@amazon.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 23 Jun 2023 14:27:17 +0100
Message-ID: <CAFEAcA9We25NEdzMgF_MXuiM_SHQ+u+DS_VQ4ZXyd=ieM+jhNw@mail.gmail.com>
Subject: Re: [PULL 57/62] hw/xen: Support MSI mapping to PIRQ
To: "Woodhouse, David" <dwmw@amazon.co.uk>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
 "paul@xen.org" <paul@xen.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Thu, 6 Apr 2023 at 17:25, Woodhouse, David <dwmw@amazon.co.uk> wrote:
>
> On Thu, 2023-04-06 at 16:48 +0100, Peter Maydell wrote:
> > On Thu, 2 Mar 2023 at 12:37, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > >
> > > From: David Woodhouse <dwmw@amazon.co.uk>
> > >
> > > The way that Xen handles MSI PIRQs is kind of awful.
> >
> > > Now that this is working we can finally enable XENFEAT_hvm_pirqs and
> > > let the guest use it all.
> > >
> >
> > Hi; Coverity points out a logic error in this code (CID 1507603):
> >
> > > @@ -1638,6 +1877,7 @@ int xen_physdev_unmap_pirq(struct physdev_unmap_pirq *unmap)
> > >
> > >      /* We can only unmap GSI PIRQs */
> > >      if (gsi < 0) {
> > > +        qemu_mutex_unlock(&s->port_lock);
> > >          return -EINVAL;
> > >      }
> >
> > One of the things xen_physdev_unmap_pirq() does early is return
> > if gsi is a negative value...
> >
> > > @@ -1646,6 +1886,12 @@ int xen_physdev_unmap_pirq(struct physdev_unmap_pirq *unmap)
> > >      pirq_inuse_word(s, pirq) &= ~pirq_inuse_bit(pirq);
> > >
> > >      trace_kvm_xen_unmap_pirq(pirq, gsi);
> > > +    qemu_mutex_unlock(&s->port_lock);
> > > +
> > > +    if (gsi == IRQ_MSI_EMU) {
> >
> > ...but then later we try to test to see if it is IRQ_MSI_EMU.
> > IRQ_MSI_EMU is -3, so this condition can never be true.
> >
> > > +        kvm_update_msi_routes_all(NULL, true, 0, 0);
> > > +    }
> >
> > What was the intention here ?
>
>
> Hrm.... the way that Xen automatically maps the MSI to a PIRQ by
> snooping on the (masked) writes to the MSI target is awful, as noted.
>
> I don't think Linux guests ever do unmap the MSI PIRQ but it might be
> possible; I'll have to do some experiments in Xen to see what happens.

Did you ever figure out what the right thing here was ?

thanks
-- PMM

