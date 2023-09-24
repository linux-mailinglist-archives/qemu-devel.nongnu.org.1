Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DDD97ACAB3
	for <lists+qemu-devel@lfdr.de>; Sun, 24 Sep 2023 18:08:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qkRdB-0002V4-Cg; Sun, 24 Sep 2023 12:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkRd1-0002Uf-FS
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 12:06:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qkRcz-0003Qg-Sr
 for qemu-devel@nongnu.org; Sun, 24 Sep 2023 12:06:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695571596;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8C+Lic89Rg5UnDTYgNOUioDEs73NJ3BNOIy6efhsgik=;
 b=fE2VQaw9hUapMQScLSqD9ox7ToFzzpjWEn2V6OmFEgdUhI4Goa78YWJrWLWhxQj2RVQxou
 O9Fudvmg+RkZTb/Fj54ERgOyraHtT8uTmCxjBIK+r6800ALw4K1J7GF/qRkZuApoHbQ9Qj
 sLBQN/FIWPHmxzaqEJHXs6HHrXtG1do=
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-C4UOvuIQNT6FPPCGw-uClw-1; Sun, 24 Sep 2023 12:06:34 -0400
X-MC-Unique: C4UOvuIQNT6FPPCGw-uClw-1
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-7a2b3c1fb6bso2044207241.1
 for <qemu-devel@nongnu.org>; Sun, 24 Sep 2023 09:06:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695571594; x=1696176394;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8C+Lic89Rg5UnDTYgNOUioDEs73NJ3BNOIy6efhsgik=;
 b=tz+z65IW3rfTZDkTdKx7twusK7FdzNWooJbxa2Wr7xse3HverbOKLFtRgesTtslEbC
 wWRsbU0TFChPCtSg85EnFc0dNmUJ9U1n0G/Nov1ahDopZCs+cXS3UIAuxQUM87WQ2X3q
 wDiW8CaoB66bb/ZpHiM06jnKd3wp1SHnBM91dIaUyGJfQtDQSKw6MD/A5G5M4fn37/D2
 Asy+zUFLYDq+3JBvlfblA7HzDxrzHZylYASeN+h6JTT+PCnkgip7blvKKGFuFUmm9cGu
 386Qw5A58xVcufJzh9lvdlnVw2n3xEBw5K0kwLa2CgSEwklXdy4DK4LShSg4dLi2m592
 9JGw==
X-Gm-Message-State: AOJu0YwArLRZSIDfKwQJH/6h2Gqh+UAXdCrgdKoa3+bF7+6pFzd2+AE+
 062GePh7R3blTvEjmoQ097rk1Pe07fKZvexTRiwd1tpwHiomE8L2CuYXMKjK9BDTXRt4psvDBMa
 goeH2lfzZZKiu01rIHQKZomPMVSEt0Wg=
X-Received: by 2002:a67:fa10:0:b0:452:dae8:df05 with SMTP id
 i16-20020a67fa10000000b00452dae8df05mr2731203vsq.9.1695571593932; 
 Sun, 24 Sep 2023 09:06:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtu+OV520WkeRVm8Ge5II7u0flE7zoOM+9d/XoVGxZ4W0rGCiw6B/eJeGCNy01DhL2hVRni6SHduyaX0km8t8=
X-Received: by 2002:a67:fa10:0:b0:452:dae8:df05 with SMTP id
 i16-20020a67fa10000000b00452dae8df05mr2731191vsq.9.1695571593613; Sun, 24 Sep
 2023 09:06:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230923085507.399260-1-pbonzini@redhat.com>
 <20230923085507.399260-12-pbonzini@redhat.com>
 <8395a8cf-c902-7da6-cb4e-0d4488a2a5dd@eik.bme.hu>
 <CABgObfZeRzae78jKvDzyhWv9oVS_OS8Zo4Mfn7rtnFqG0UqK8A@mail.gmail.com>
 <8a271e94-9762-81ca-70ad-9a0d4fbfaefa@eik.bme.hu>
In-Reply-To: <8a271e94-9762-81ca-70ad-9a0d4fbfaefa@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sun, 24 Sep 2023 18:06:22 +0200
Message-ID: <CABgObfZ5X2_nenFUf4zibki+aKTG=KJ_wa1OOOX+hXA3d44fQA@mail.gmail.com>
Subject: Re: [PATCH 11/13] vt82c686: Support machine-default audiodev with
 fallback
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel <qemu-devel@nongnu.org>, Martin Kletzander <mkletzan@redhat.com>,
 =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Sep 24, 2023 at 2:14=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
> > If you still want a machine audiodev propery then could the device hand=
le
> >> it without needing changes to the machine? Like in via_isa_realize() a=
dd
> >>
> >> if (current_machine->audiodev) {
> >>      qdev_prop_set_string(DEVICE(pci_dev), "audiodev", machine->audiod=
ev);
> >> }
> >>
> >> before qdev_realize(DEVICE(&s->ac97) then no need to change the device
> >> creation in board code.
> >>
> >
> > No, current_machine should not be used at all outside board code.
>
> OK, can you start from pci_bus and walk up the QOM tree then to find the
> machine in vt92686.c so the board code does not have to care about this?

The machine itself should not be used outside board code, neither via
current_machine nor by any other means.  There are so few places where
it happens (most of them in fw_cfg) that I'm not really willing to
compromise on this. The board sets properties on the devices, it's not
the devices that fetch settings from outside.

Paolo


