Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id B5A707B380C
	for <lists+qemu-devel@lfdr.de>; Fri, 29 Sep 2023 18:39:21 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qmGVA-0006dr-6o; Fri, 29 Sep 2023 12:38:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qmGV5-0006de-LH
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 12:38:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1qmGV3-0002c4-HC
 for qemu-devel@nongnu.org; Fri, 29 Sep 2023 12:37:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696005476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Drzhpz8fd6eyLYaqKa8T9tIji01aqNclbXrVQPnUllM=;
 b=NAuYiyw/6rSSdIfQmAs7qPe5VGSAc7Ux2BMOpqKE4uwdNrr+5hMEZWYcUJ9X3tXHJtL9A/
 Qq2hfGbwzn0vgG48HPLGJ2JdXI2cXIizVdI6hzYyypHG79XCB79bprGyqnbPlBaqcadyej
 M3xlNW761v1tGQxczb/vyeBQKcC8qqo=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-loR3LPWUM527DyB1nfdFbQ-1; Fri, 29 Sep 2023 12:37:54 -0400
X-MC-Unique: loR3LPWUM527DyB1nfdFbQ-1
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-4526abc3c79so7317884137.0
 for <qemu-devel@nongnu.org>; Fri, 29 Sep 2023 09:37:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696005473; x=1696610273;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Drzhpz8fd6eyLYaqKa8T9tIji01aqNclbXrVQPnUllM=;
 b=GU8oUMIwNck4WtFKSPUGbx/LinyaA+/ASeSflFOgPsh3CLrz4Ffs2v9xyLUFVXsqPY
 U5WIj1+k4ThDY1jYgdH3EZXg1AjTH9oBnCydTxXrE025wlDX0+owtPccGWB0nzHLQgEE
 plnbB+UyfJNkYY9FqCshQ0KCJsRyc+zlvZ5R7ZmES8gvloEg5jcw+4eyJ1s6QyLiIFyv
 qF2/MEd6jWMo7IHLCMtr0aW2BSVH8MmKA7Doqx1F0a6aMbeQh8ffRRqgiAvRQrjv/NFq
 RCTLgDlYTeZl8c7GAIo17CadCkK6WfFivNz/K8XUZG4bWpEyrWE47RLAmbtP5o/skXVn
 UOXg==
X-Gm-Message-State: AOJu0YzRcu/m018kACpq//DqjJ9hcquk64JXXL6/YRWLs5WdyfmSQA5J
 gqPwXXcukRX9tobS8cV+f5hH06GNlAolrT5hVXJgEuAMjJ+fr4WPqviiUXsUADPotJDiEKHwEsN
 7hYv9vAZjuV1IBHkt5C4hYWPn+GqHULQ=
X-Received: by 2002:a05:6102:134b:b0:452:77f1:f1e8 with SMTP id
 j11-20020a056102134b00b0045277f1f1e8mr4036114vsl.33.1696005473628; 
 Fri, 29 Sep 2023 09:37:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBuIj/n7YL6TNYoRnFVCXZwOOv8c7ZanKT/1WYF9XFZ1ZuFjG3H39wIdhYWOUWJlFI0MUeXSnna+fISXDXsHA=
X-Received: by 2002:a05:6102:134b:b0:452:77f1:f1e8 with SMTP id
 j11-20020a056102134b00b0045277f1f1e8mr4036104vsl.33.1696005473353; Fri, 29
 Sep 2023 09:37:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230929085112.983957-1-pbonzini@redhat.com>
 <20230929085112.983957-13-pbonzini@redhat.com>
 <0d19d17e-265f-069a-39a5-ff86d1bc5388@eik.bme.hu>
In-Reply-To: <0d19d17e-265f-069a-39a5-ff86d1bc5388@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 29 Sep 2023 18:37:41 +0200
Message-ID: <CABgObfZZS7jOJb2jwZU+w5e+r4eNR9_iUsKsbYgpAXbEMfzVVg@mail.gmail.com>
Subject: Re: [PATCH v3 12/14] audio: forbid mixing default audiodev backend
 and -audiodev
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, 
 Martin Kletzander <mkletzan@redhat.com>
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

On Fri, Sep 29, 2023 at 1:55=E2=80=AFPM BALATON Zoltan <balaton@eik.bme.hu>=
 wrote:
>
> On Fri, 29 Sep 2023, Paolo Bonzini wrote:
> > Now that all callers support setting an audiodev, forbid using the defa=
ult
> > audiodev if any audiodev is defined on the command line.  To make the
> > detection easier make AUD_register_card() return false on error.
>
> So this means that now qemu-system-ppc -M pegasos2 -audiodev sdl,id=3Dau
> will give an error saying that audiodev must be specified but does not sa=
y
> it should be set on the machine so users will not know, as oppsed to now
> just getting a warning but things still working

The plan is to extend -audio with -M audiodev=3D support, so you can use
"-M pegasos2" for the default backend or "-M pegasos2 -audio sdl" for a
specific one. I didn't include it yet because I also want to add support fo=
r
something like "-audio none", removing the current QEMU_AUDIO_DRV
special case that is needed by libqtest.

> This is not helpful. Why
> is this feature deprecated and what does removing bring that justifies
> this? Could we keep the more intuitive current behaviour and drop the
> deprecation instead unless removing this is needed for later patches as
> the current default handling is more convenient for command line users.

There's intuitivity, and there's behavior that is only intuitive if you are
used to it. For example, -audiodev is the only backend that does
something even if its id is never referenced. In that it's completely
different from -blockdev/-chardev and from -object backends.

The idea of this patch is that "-audiodev" means "opt out of all magic",
but I'll drop it for now and wait until I figure out how to handle "-audio"
without a model.

Paolo


