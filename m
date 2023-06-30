Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E7E074377D
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:37:49 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9cu-0007db-S1; Fri, 30 Jun 2023 04:37:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qF9ct-0007dQ-0M
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:37:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qF9cr-0000M0-B6
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:37:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688114228;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YLGKb/+xVJwAhtuWbuREX2S6YaRmEZY1D/+Y3vRnCek=;
 b=LXaq2uWtmRPGIYq6uXKIy3X0GkqnE5Sn2tHgKav+X18chN86W5MgBEfRc6tF8WsBEogcGF
 nG6vobwrm0HPSkGmvWDxScl8IZ9RpfW+u4j4N0l1mZbstDRW06+oRh3Pzl/v2x7V/ih8I+
 W8M+6eS4ho+W3FtBAz8KrgA7FV453c0=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-QKx8yCZoPk26_u8eWHWVfA-1; Fri, 30 Jun 2023 04:37:05 -0400
X-MC-Unique: QKx8yCZoPk26_u8eWHWVfA-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-6b792b78e53so2055586a34.3
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:37:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688114225; x=1690706225;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YLGKb/+xVJwAhtuWbuREX2S6YaRmEZY1D/+Y3vRnCek=;
 b=a7h6UPeHPyr4Er9VbXVHSOzJEzNtx+RsIBIaBXPY0TU1k2ktMcbqQKjwFwn7jRztaA
 yefSHLP1H+wS2f5VFyyhIw/DCK2RyY92E6Dp0QdGh6qANvdJjAihjjH/C3WHomm9rKIa
 bbZUZiS5uk4uPS4daQrxwDZMVHOhjFsOdHByQyFoDsdA8jP1rQBn0zO5VXyz4mrk37H2
 rTyb9BkKjXZ3zhXwMNG+UpPdxT1xPkS07LAeU85l/zIuksLshmsOupW3Ue+pYkjQ6ASn
 Lytfup1Z4BW2PAAPaPiJexNPxWrzkg+PspW9TVDucG8jQjWp+YUiW8WMtvygX/fXW+Nk
 eX3A==
X-Gm-Message-State: AC+VfDwg8fayFPo/cP1DuN2JGtxN+8Xis//vgORJYpAkNdB18MEssme/
 Q1UDsbgSW+7CBDDpnMRSeZnJjqIbR/oX5FBbXB0m+//4sORZC2yvkAKShNhVwUdYvx2iXkik3i4
 avWVtnbAW+UnfDLE=
X-Received: by 2002:a9d:6646:0:b0:6b8:778f:d67 with SMTP id
 q6-20020a9d6646000000b006b8778f0d67mr2347920otm.27.1688114225106; 
 Fri, 30 Jun 2023 01:37:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5hgObzYD1s7YJd01Mlqm3gsQNFxck4I8GuuSoEkX3w0l1kAqFMM5IyTakSvrGinWzb9+BavQ==
X-Received: by 2002:a9d:6646:0:b0:6b8:778f:d67 with SMTP id
 q6-20020a9d6646000000b006b8778f0d67mr2347909otm.27.1688114224852; 
 Fri, 30 Jun 2023 01:37:04 -0700 (PDT)
Received: from smtpclient.apple ([115.96.128.249])
 by smtp.gmail.com with ESMTPSA id
 q10-20020a65684a000000b0053f06d09725sm9085839pgt.32.2023.06.30.01.37.01
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 30 Jun 2023 01:37:04 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230630041937-mutt-send-email-mst@kernel.org>
Date: Fri, 30 Jun 2023 14:06:59 +0530
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
>>>=20
>>> Thus the check for unoccupied function 0 needs to use pci_is_vf() =
instead of checking ARI capability, and that can happen in =
do_pci_register_device().
>>>=20
>>>> Also where do you propose we move the check?
>>>=20
>>> In pci_qdev_realize(), somewhere after pc->realize() and before =
option ROM loading.
>>=20
>> Hmm, I tried this. The issue here is something like this would be now =
allowed since the PF has ARI capability:
>>=20
>> -device pcie-root-port,id=3Dp -device igb,bus=3Dp,addr=3D0x2.0x0
>>=20
>> The above should not be allowed and when used, we do not see the igb =
ethernet device from the guest OS.
>=20
> I think it's allowed because it expects you to hotplug function 0 =
later,

This is about the igb device being plugged into the non-zero slot of the =
pci-root-port. The guest OS ignores it.

> no?
>=20
> I am quite worried about all this work going into blocking
> what we think is disallowed configurations. We should have
> maybe blocked them originally, but now that we didn't
> there's a non zero chance of regressions,

Sigh, no medals here for being brave :-)

> and the benefit
> is not guaranteed.
>=20
> --=20
> MST
>=20


