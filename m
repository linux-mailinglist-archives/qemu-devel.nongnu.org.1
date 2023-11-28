Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id F052E7FAF07
	for <lists+qemu-devel@lfdr.de>; Tue, 28 Nov 2023 01:29:18 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1r7lx4-0004pn-3Y; Mon, 27 Nov 2023 19:27:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7lx1-0004pZ-77
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 19:27:43 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <42.hyeyoo@gmail.com>)
 id 1r7lwz-00028C-D4
 for qemu-devel@nongnu.org; Mon, 27 Nov 2023 19:27:42 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4ac05ca3935so1326329e0c.1
 for <qemu-devel@nongnu.org>; Mon, 27 Nov 2023 16:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701131260; x=1701736060; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wza2sgt13ZiOn+YZ1HTejITdKseBd8v00mtOPrEEqSk=;
 b=TNL3z3IE2gXxiaGpIDAGyqgCjqEfN8ztxa7x8WSEVzv/La3fXXbwAJBg5VIqeyyEGe
 Dm53257p3PzdTgByTVc0J2uz/S4elHh7j+OoXys9RDPf+3JLdJy75SVKo+c4xwo93gVG
 YWG0PFD9eoM0YJBb62EW6QZQmrilxL1DWJK5DMBXvH1Vr/Jn1Sxv+SDD0ckHx9lvVDRi
 GmJcI5de6q/TXQqUDNXo6aBvc6r3R0USV4sS9JVmN3g9gY7aSNYcqpQNUBaIdZ2VQw3T
 N3lnxwqEiqCzpYl5hrqVfzZMVktTcLX+SQX3H9Sgi8l7MG00/oGR74X75fZxp8wZINf8
 i54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701131260; x=1701736060;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wza2sgt13ZiOn+YZ1HTejITdKseBd8v00mtOPrEEqSk=;
 b=NcnOqz10FZBRvJ415onyLxxpH54pkBzKHDKv97gj8tiQUmE2vW985Mne16qZrA2mpB
 Ti0vz20io8d2/YV8cZTprRg05lVUOjYxVpZkJAzkisyWzuY55fJRDuKax5DskIgBoZTQ
 3aOE4JyX9h3nwYjMhC530GTgqa8Ccnm1B0MLQpOt/LDWvJvXivg7PYM0oDcHn4SevyXa
 dfcc3eXPaiasnfemDKsKxMY+KhR6/umFxV9UpNCA7ouD04oQQ9fRg8vkcgU9ABHg+kKE
 g02RhLdW6vM7tZLTB9toA6M3WS4cZ4/eguIvCAD6IV/V19m3a9hpJJ2j1eqvmERrtkCG
 6Z2g==
X-Gm-Message-State: AOJu0YxDY8JRqhfKbdoQZ+/WIeu0Y9LmEgQgb+HgGMYgo95toKnA97BB
 4rCf8h6zaA5OxwBsmTeIc1Ab0ndtp7Z7dYYH9fU=
X-Google-Smtp-Source: AGHT+IEUoyprHyotFEqNuqdPQ3UV2V2mkjsC1M4NOE1wBTNLVjUPEFdWi0YC81g1E3ZEZuy8MJoFD8Imsi/Ozo8mzho=
X-Received: by 2002:a05:6122:168c:b0:495:ec90:997e with SMTP id
 12-20020a056122168c00b00495ec90997emr13537957vkl.7.1701131259885; Mon, 27 Nov
 2023 16:27:39 -0800 (PST)
MIME-Version: 1.0
References: <20231127105830.2104954-1-42.hyeyoo@gmail.com>
 <20231127105830.2104954-3-42.hyeyoo@gmail.com>
 <20231127175322.k3zt65vicd4o2ifv@offworld>
In-Reply-To: <20231127175322.k3zt65vicd4o2ifv@offworld>
From: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Date: Tue, 28 Nov 2023 09:27:28 +0900
Message-ID: <CAB=+i9RkLLXTcKNKw9j1EAHEu8ixCzeum88vsYj3mYW6MsbVgQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] hw/mem/cxl_type3: allocate more vectors for MSI-X
To: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>, Fan Ni <fan.ni@samsung.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-cxl@lore.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=42.hyeyoo@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HK_RANDOM_ENVFROM=0.999, HK_RANDOM_FROM=0.999, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Tue, Nov 28, 2023 at 2:53=E2=80=AFAM Davidlohr Bueso <dave@stgolabs.net>=
 wrote:
>
> On Mon, 27 Nov 2023, Hyeonggon Yoo wrote:
>
> >commit 43efb0bfad2b ("hw/cxl/mbox: Wire up interrupts for background
> >completion") enables notifying background command completion via MSI-X
> >interrupt (vector number 9).
> >
> >However, the commit uses vector number 9 but the maximum number of
> >entries is less thus resulting in error below. Fix it by passing
> >nentries =3D 10 when calling msix_init_exclusive_bar().
>
> Hmm yeah this was already set to 10 in Jonathan's tree, thanks for report=
ing.

Oh, yeah, it's based on the mainline tree. I should have checked Jonathan's=
.

hmm it's already 10 there but vector number 9 is already being used by PCIe=
 DOE.
So I think it should change msix_num =3D 11 and use vector number 10 for
background command completion interrupt instead?

https://gitlab.com/jic23/qemu/-/commit/2823f19188664a6d48a965ea8170c9efa23c=
ddab

Thanks!

--
Hyeonggon

