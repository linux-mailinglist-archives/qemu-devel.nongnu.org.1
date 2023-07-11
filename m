Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FA6574E5AB
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 06:05:07 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ4bW-0006Uk-Kz; Tue, 11 Jul 2023 00:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ4bU-0006UV-GS
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:03:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ4bS-0005Gf-FV
 for qemu-devel@nongnu.org; Tue, 11 Jul 2023 00:03:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689048232;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LcPHdrWKDPaceAXVpAEFBSEudu2ulxOjvYT6jXuCzKM=;
 b=izvbKTke8F1nBygtNJIbSwwopj9fGMYvhMOIFrbJfGJNPRX1sUunIAeeJQdoMCchHLm/sT
 hAEUHGaWd1db9kLdSkTzXeh3qK1KRFRPGyrhl52jdX2blKrVg0JyFKQPx2b8DMuDo+RntF
 bQw3pPqkkNGBLXH89wAO4YXDHhk78r4=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-tT1UmseYP0y4bnGZFZJz1g-1; Tue, 11 Jul 2023 00:03:50 -0400
X-MC-Unique: tT1UmseYP0y4bnGZFZJz1g-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40354eb76a8so50150521cf.3
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 21:03:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689048230; x=1691640230;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LcPHdrWKDPaceAXVpAEFBSEudu2ulxOjvYT6jXuCzKM=;
 b=fZ2Sq+01idx9qglmNMmgGRvzKa9hxPUTLh9AzpYgKKoY0jr6ZgLJmO0IFWsnDeITnH
 EhT80n6UAQ6OOE2R08guNCvJFmw82cyN4XQy0PxRWbY7lkxOBQRp5PUa3mNh2EqOyrkK
 p9jPYHe+NKCehEX1fsfR1sNZvVRZcbc3Uj+jvGH5ZhzI3zSXjP6HdFKopnWwe5vNB5VA
 BLaM5p6AvDG1lC4nMWgMCoftAEIK59BzfMdd6TOcViGyOIiEVXNFwaXyyqzF3T2hEHm9
 Me1UOgIefPCP7lD3q+a8czr3CvQN61rXkW71qXoVuyTkd8DSquOJyOfVZDBIOSK5Bjee
 yssg==
X-Gm-Message-State: ABy/qLZSNJf0QegQ5criTG/zq72dSmVZZPVKMzT8JP9C6YdKKOctFkj3
 BFcU6C8JZbU+US/kD5p6thQTwpmuJ9vMkIl4JihgYtLik9ssyK4eR2IHEmSbpgAjGundtjTzfXo
 XhKM9nnzO3B+7XUM=
X-Received: by 2002:a05:622a:2c1:b0:400:a2db:747e with SMTP id
 a1-20020a05622a02c100b00400a2db747emr20159351qtx.52.1689048230494; 
 Mon, 10 Jul 2023 21:03:50 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEcg/ytewHLBtK4CNpAE3D+XEK6RvXuQPTcFmyld62FHIeXVJ9suqSU/sxoi7JWasCMHKoJNA==
X-Received: by 2002:a05:622a:2c1:b0:400:a2db:747e with SMTP id
 a1-20020a05622a02c100b00400a2db747emr20159338qtx.52.1689048230272; 
 Mon, 10 Jul 2023 21:03:50 -0700 (PDT)
Received: from smtpclient.apple ([116.73.134.124])
 by smtp.gmail.com with ESMTPSA id
 u18-20020aa78392000000b006827c26f147sm562130pfm.138.2023.07.10.21.03.48
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 21:03:49 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v8 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <9b2935a1-af38-3373-6441-c0179df0cbfb@tls.msk.ru>
Date: Tue, 11 Jul 2023 09:33:46 +0530
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F8856123-70CC-44FF-9E7A-E7E27DD07944@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-7-anisinha@redhat.com>
 <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
 <20230710154155-mutt-send-email-mst@kernel.org>
 <878CC014-DC18-43CC-83D8-B2524EE09373@redhat.com>
 <9b2935a1-af38-3373-6441-c0179df0cbfb@tls.msk.ru>
To: Michael Tokarev <mjt@tls.msk.ru>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



> On 11-Jul-2023, at 9:21 AM, Michael Tokarev <mjt@tls.msk.ru> wrote:
>=20
> 11.07.2023 06:46, Ani Sinha wrote:
>=20
>> Sure. Since this is only a comment addition, should I also CC =
qemu-trivial?
>=20
> A comment change does not mean the change is trivial.  It's a trivial =
in a sense
> the code changes are trivial (actually not-existent), but the meaning =
of the comment
> is not trivial at all. I for one know nothing about this.

This comment was already disucussed in qemu-devel between me, mst and =
Igor. Perhaps you missed it.

=
https://patchwork.kernel.org/project/qemu-devel/patch/20230621024824.3779-=
1-anisinha@redhat.com/


