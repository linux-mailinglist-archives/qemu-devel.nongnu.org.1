Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 065187CB725
	for <lists+qemu-devel@lfdr.de>; Tue, 17 Oct 2023 01:45:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qsXG8-0008VA-Sp; Mon, 16 Oct 2023 19:44:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qsXG7-0008Uh-Lp
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 19:44:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1qsXG6-0007WI-4J
 for qemu-devel@nongnu.org; Mon, 16 Oct 2023 19:44:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697499864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dpxlt8g5Ojddq8Rd3dSRfnSKOcRnZ4337Zr0WKbHWEY=;
 b=hVNQjHlva0TFm3h5CNissE7pJOP+XEufZxs1LeorOR/8DHxl9Ee2NbDqz4wE6HZiCF1hwo
 AicLkMSudMfHZ/hRnsjzmrGK3eWRbburdDVBZ63RnIUUJ372cB8yESOi+6MgtDLbb5drG/
 blgeDhfJr4XfiSbMb3+Qkas97UMLdro=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-k98GXX1lM7Sl-smelrrHFA-1; Mon, 16 Oct 2023 19:44:18 -0400
X-MC-Unique: k98GXX1lM7Sl-smelrrHFA-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-1e9e17b3269so4850235fac.3
 for <qemu-devel@nongnu.org>; Mon, 16 Oct 2023 16:44:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697499857; x=1698104657;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Dpxlt8g5Ojddq8Rd3dSRfnSKOcRnZ4337Zr0WKbHWEY=;
 b=VCXi8xuj7zsL+ET+B6cKTcDxwpvyc+ofpNIjeZsxDBhK19rzfOrgUjofzXFa9e4hKo
 GuIx+9GaNOnmr1+r1BbKrtpUoF3qc1e1lIe8U+8LmfDaArXkz+9uTlWTpjaxb5/Zss2h
 5qIccDlDR8f7YpqdKhFBqXU/o1ugR11xsqEEZM6ps0Bx90n8Fuuoo0jPKCC3omtUZ6qL
 0cTSurdTnm5J2qtRp7zXkSLOpQ3os8SSA1QkBc7Zx+65VcAYqzJHDLg33HljZoyQBbjQ
 m2PKk2a5riLtFH/0ifQcdjYQ7JVIO3ppieb/xi+6X8ri/16wN+6rCkwhGGZd2RiMU/0K
 JA6Q==
X-Gm-Message-State: AOJu0YxLnEjSpsKVrKmiOx4EX/fLR9Wjp5TFbqaep5Q6cpm/4oWVuKH7
 /y5+dMhKBqkrRgcHabhtU4lUhNx8eLEb21osCTXnjrTzJSMcaXCrF2gmfwCCpLeGKE9dFG93riV
 xzGJI0+E/tRXsvFLskfIg5Z9VmTNsTVc=
X-Received: by 2002:a05:6871:31b2:b0:1bf:77e2:95cc with SMTP id
 lv50-20020a05687131b200b001bf77e295ccmr548396oac.17.1697499857620; 
 Mon, 16 Oct 2023 16:44:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7U62KfDXQTQ66V0ptvZAW3hLKWNdQxRKFhQ6yOT54VgEUPku/RjrmSy5NuXotRL4Ie0+dOsSMitqvwVJ0qh8=
X-Received: by 2002:a05:6871:31b2:b0:1bf:77e2:95cc with SMTP id
 lv50-20020a05687131b200b001bf77e295ccmr548386oac.17.1697499857412; Mon, 16
 Oct 2023 16:44:17 -0700 (PDT)
MIME-Version: 1.0
References: <20231013190941.3699288-1-jsnow@redhat.com>
 <20231016192101.GA161375@fedora>
In-Reply-To: <20231016192101.GA161375@fedora>
From: John Snow <jsnow@redhat.com>
Date: Mon, 16 Oct 2023 19:44:06 -0400
Message-ID: <CAFn=p-aO0ADr-oD3XvQs=8keNs27p3b5LGHzvZxeoMWLbu-KpQ@mail.gmail.com>
Subject: Re: [PULL 00/25] Python patches
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-arm@nongnu.org, 
 Vladimir Sementsov-Ogievskiy <v.sementsov-og@mail.ru>,
 Ani Sinha <anisinha@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Beraldo Leal <bleal@redhat.com>,
 qemu-s390x@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Markus Armbruster <armbru@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Eric Blake <eblake@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 qemu-block@nongnu.org, 
 Eduardo Habkost <eduardo@habkost.net>, Juan Quintela <quintela@redhat.com>, 
 Leonardo Bras <leobras@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Eric Farman <farman@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Halil Pasic <pasic@linux.ibm.com>, Cleber Rosa <crosa@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, Oct 16, 2023 at 3:21=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.co=
m> wrote:
>
> Applied, thanks.
>
> Please update the changelog at https://wiki.qemu.org/ChangeLog/8.2 for an=
y user-visible changes.

Hi Vladimir: all done!

I've created a MR to backport your changes to the standalone repo
here: https://gitlab.com/qemu-project/python-qemu-qmp/-/merge_requests/30
- please give it a quick glance to make sure I didn't butcher anything
in transit.

Thanks,
--js


