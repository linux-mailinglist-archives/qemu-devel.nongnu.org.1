Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BDF77BC4D
	for <lists+qemu-devel@lfdr.de>; Mon, 14 Aug 2023 17:03:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qVZ5p-0001Dn-IS; Mon, 14 Aug 2023 11:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qVZ5m-0001CC-Mj
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 11:02:50 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1qVZ5l-0005y3-2j
 for qemu-devel@nongnu.org; Mon, 14 Aug 2023 11:02:50 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-40feecefa84so21873561cf.1
 for <qemu-devel@nongnu.org>; Mon, 14 Aug 2023 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1692025368; x=1692630168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=T2/cSkbTqyL3LKhq1+Jr/6NioX9wmmyfWpEdSYP3e8o=;
 b=HRtkAoyDxphDvQCKXrYLjC5ns+tLkSIaTNE6P6ytFL+tH+ctt3Tc7heoGxCv3E0c+i
 1AO0xm4/EhU8eHtBmWKI9z8pzbhZLy01UZi6NtVRY9hIM5GVxkr00TeXyhlRWYDLjDwZ
 /ALlOIp2Q/Q3BleL1bkrB6hG2mAgDlc2lSq4rTQzb2VY8jizKZDE7qj+b5RB3uiR5LlO
 ssZT8338oUWJjAyklq9Mn6CSW4eAB/k9nxElfc9pntX8qoZCEXOluauWKfvrWNhD5mT4
 090kXsQWy48zUvmg4r+SPKuOxwG82mUlsHnii3wMNhw94zFArRhogrTA5L5LvLUfqgdR
 IThw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692025368; x=1692630168;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=T2/cSkbTqyL3LKhq1+Jr/6NioX9wmmyfWpEdSYP3e8o=;
 b=GVEYOG/pRGoOM+xxO/DU4BDqPDTq7GUq3K2JQu3/GeVJJtylolvLUPxTD7aBTgcxiu
 x5QDHkFxMzNzPZhXRbTmZlKOaMSa5X1RmwaQBEa0txpayvVxDK/ieRnQJX/FIuIdtAm6
 3qHtDqXjCkKIwp51xQiaaTITm7PxE5vlKkHDP1a45qIuJuC9A6vC1nWlioV+nHrwcLXi
 03wYCiqXgnAYRNKddaphGJIwat+LECzNgZ4viHRAs3H5CwcACGfocV+hAwtWDeHCGTLX
 3dB19m3GLKLwWunSjBjkf43lVeGSF2wZlN+ZA1AJOn8MSxpd5gCiIn2OofBLWslcRShD
 MGgw==
X-Gm-Message-State: AOJu0Yxi+QyJj0xJ1z61qqh9XjzU81w4hxYDvSo+iBSdbzmnxe3w1mOC
 o0uXrlZLHl3nXGPpstyNx/lxV1kuU9JktVnt6Ig=
X-Google-Smtp-Source: AGHT+IGhQOwbuKbWm1neAtyJ6cxjjxkfoviF6OOyX6NWqCp96KyAXcu/YZYUWDmyCY5FUUd0BFQ3ROp8ntK2GmdJbi4=
X-Received: by 2002:a05:622a:11c9:b0:406:804b:e0f5 with SMTP id
 n9-20020a05622a11c900b00406804be0f5mr11025471qtk.55.1692025367844; Mon, 14
 Aug 2023 08:02:47 -0700 (PDT)
MIME-Version: 1.0
References: <20230814125802.102160-1-belmouss@redhat.com>
 <CAMxuvawR2qcN51RBC2=CRYYib+=4G76b29X2Jrj_akn-RFp_rw@mail.gmail.com>
 <CALz9GzZwJE2w=dRp96T51K-R6jNoPuY0o_N_Y6wzEH34WFzjfg@mail.gmail.com>
In-Reply-To: <CALz9GzZwJE2w=dRp96T51K-R6jNoPuY0o_N_Y6wzEH34WFzjfg@mail.gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 14 Aug 2023 19:02:36 +0400
Message-ID: <CAJ+F1CLvGMZ+4RByn3cq9UhrT-CGoK_r6Uc4ZApzFiGrk6s6TA@mail.gmail.com>
Subject: Re: [PATCH v2] ui/dbus: implement damage regions for GL
To: Bilal Elmoussaoui <belmouss@redhat.com>
Cc: qemu-devel@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, 
 Christian Hergert <chergert@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x830.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Hi

On Mon, Aug 14, 2023 at 5:08=E2=80=AFPM Bilal Elmoussaoui <belmouss@redhat.=
com> wrote:
>
> That is fine, it is not something we need urgently as we still need a ker=
nel patch to make virtio gpu use the KMS atomic API in Mutter. Am I suppose=
d to send a new patch with the "Reviewed-by" part in the commit message or?
>

That's not necessary. Either the maintainer will add it, or can pick
it from patchew who does that for us (ex:
https://patchew.org/QEMU/20230814125802.102160-1-belmouss@redhat.com/mbox)

thanks

--=20
Marc-Andr=C3=A9 Lureau

