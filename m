Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4232874E575
	for <lists+qemu-devel@lfdr.de>; Tue, 11 Jul 2023 05:47:47 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qJ4KT-0002zg-RV; Mon, 10 Jul 2023 23:46:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ4KS-0002zX-BD
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:46:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1qJ4KQ-0000ZG-OV
 for qemu-devel@nongnu.org; Mon, 10 Jul 2023 23:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689047175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nexDdEFYfTMxulzyjeptY6r8eHM6YAwfmTIARjIip6Y=;
 b=B+Tv9LBSGz53iRsZ1nkdWKTS+UPfkdJBVFh6qyy88RtOinLmWFo6F9T6RMOVC1Rq1SUF9P
 VKmxPbT1H34Zae5Zg9bFrsywKz1o7uh0LwkeDYgdRZStMzEGCWmyRVB/LxIBVxy8vbRSzj
 5k/qltu4UGPyynB2MZD9Jehw9qTDfmk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-QyYi7fd7Pg6_7NMvt1gqkg-1; Mon, 10 Jul 2023 23:46:14 -0400
X-MC-Unique: QyYi7fd7Pg6_7NMvt1gqkg-1
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-565d30b4311so3954959eaf.1
 for <qemu-devel@nongnu.org>; Mon, 10 Jul 2023 20:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689047173; x=1691639173;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=nexDdEFYfTMxulzyjeptY6r8eHM6YAwfmTIARjIip6Y=;
 b=Zz/pn3/3MyHboWHSYl74Wdkjk0VwtvhaLxGIclsMj37+TI2jykwEliNjhS2JxVUlnN
 Mxg2i5HLVKPWs0m0iUxBqvUreBazeQ0i+sQQZGcpmkV2zs5Q28jczm0DfLdOO31r6A6l
 Nd4vMbhlHYF/nPx7ONpHFmngc+fQdPPKDmQGM+n+cbUQOxFqq2bAV8VABjq6Y7rtQtfO
 NJPo1tHd3PoJ+0kK9eXXTwG4st2UoGbJTRzb/OkM/1GzEKHoF7Ak+GqKCNYokgDTUDOI
 cDkEJweEocc2+weQDp4+N4kfC7LU6wpmv+omwpHOstiW60mKXvvBhg8DiriCvta/2XFm
 QwVA==
X-Gm-Message-State: ABy/qLbfVSTd19yS00Bk/Eq+QF1KR1RFWHYwegkVBQB1H8sFaWEyeKCM
 ykYOiRJSh4Q+K+G27Dcread1wGqeNfjmxHrmMvm8MabVYqmo7oCupr1Wc8YmtbARXQmP6HOYspO
 DwK+mWP59+0c46uc=
X-Received: by 2002:a05:6358:5e0c:b0:133:84c:a085 with SMTP id
 q12-20020a0563585e0c00b00133084ca085mr13278666rwn.1.1689047173430; 
 Mon, 10 Jul 2023 20:46:13 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEsd5ck0bVVscjfEOIBwTEhADH8/vtNkY5QVod/MgsxViCUzaJqGOQxCzipAnP1zFMTf7Vqzw==
X-Received: by 2002:a05:6358:5e0c:b0:133:84c:a085 with SMTP id
 q12-20020a0563585e0c00b00133084ca085mr13278654rwn.1.1689047173091; 
 Mon, 10 Jul 2023 20:46:13 -0700 (PDT)
Received: from smtpclient.apple ([116.73.134.124])
 by smtp.gmail.com with ESMTPSA id
 5-20020a170902c24500b001b016313b1dsm663746plg.86.2023.07.10.20.46.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Jul 2023 20:46:12 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.3\))
Subject: Re: [PATCH v8 6/6] hw/pci: add comment explaining the reason for
 checking function 0 in hotplug
From: Ani Sinha <anisinha@redhat.com>
In-Reply-To: <20230710154155-mutt-send-email-mst@kernel.org>
Date: Tue, 11 Jul 2023 09:16:05 +0530
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <878CC014-DC18-43CC-83D8-B2524EE09373@redhat.com>
References: <20230705115925.5339-1-anisinha@redhat.com>
 <20230705115925.5339-7-anisinha@redhat.com>
 <F99D12E7-135A-4A03-8B9D-1FF384FBCA5A@redhat.com>
 <20230710154155-mutt-send-email-mst@kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: Apple Mail (2.3696.120.41.1.3)
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
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



> On 11-Jul-2023, at 1:13 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
>=20
> On Wed, Jul 05, 2023 at 05:33:31PM +0530, Ani Sinha wrote:
>>=20
>>=20
>>> On 05-Jul-2023, at 5:29 PM, Ani Sinha <anisinha@redhat.com> wrote:
>>>=20
>>> This change is cosmetic. A comment is added explaining why we need =
to check for
>>> the availability of function 0 when we hotplug a device.
>>=20
>> Please ignore this patch. Its a duplicate of one already sent with an =
updated patch summary.
>=20
> I'm not sure which one it is, sorry. Dropped this for now, repost =
later

Sure. Since this is only a comment addition, should I also CC =
qemu-trivial?

> pls.
>=20
>>>=20
>>> CC: mst@redhat.com
>>> Signed-off-by: Ani Sinha <anisinha@redhat.com>
>>> ---
>>> hw/pci/pci.c | 11 ++++++++---
>>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>>=20
>>> diff --git a/hw/pci/pci.c b/hw/pci/pci.c
>>> index 62b393dfb7..7aee3a7f12 100644
>>> --- a/hw/pci/pci.c
>>> +++ b/hw/pci/pci.c
>>> @@ -1181,9 +1181,14 @@ static PCIDevice =
*do_pci_register_device(PCIDevice *pci_dev,
>>>                   PCI_SLOT(devfn), PCI_FUNC(devfn), name,
>>>                   bus->devices[devfn]->name, =
bus->devices[devfn]->qdev.id);
>>>        return NULL;
>>> -    } else if (dev->hotplugged &&
>>> -               !pci_is_vf(pci_dev) &&
>>> -               pci_get_function_0(pci_dev)) {
>>> +    } /*
>>> +       * Populating function 0 triggers a scan from the guest that
>>> +       * exposes other non-zero functions. Hence we need to ensure =
that
>>> +       * function 0 wasn't added yet.
>>> +       */
>>> +    else if (dev->hotplugged &&
>>> +             !pci_is_vf(pci_dev) &&
>>> +             pci_get_function_0(pci_dev)) {
>>>        error_setg(errp, "PCI: slot %d function 0 already occupied by =
%s,"
>>>                   " new func %s cannot be exposed to guest.",
>>>                   PCI_SLOT(pci_get_function_0(pci_dev)->devfn),
>>> --=20
>>> 2.39.1
>>>=20
>=20


