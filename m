Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEA0746ED2
	for <lists+qemu-devel@lfdr.de>; Tue,  4 Jul 2023 12:37:17 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qGdOk-00039r-3o; Tue, 04 Jul 2023 06:36:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGdOi-00039L-93
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:36:40 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qGdOg-0005bi-Ta
 for qemu-devel@nongnu.org; Tue, 04 Jul 2023 06:36:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688466998;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xcYNF/eI37qPLuZ9B+OxTSfkyikvveTwWzfz5KsKNoQ=;
 b=BoiMbdoCNF+02VfbxV3Ffekh7J/wWnPEg+2BB1Q9Eo5MpjmyXcGfPhh9IKDr885g6Y3m2M
 eldOteVraTzbIXry1x7mxVA7ZdEFNrsE+vNn04QvSor318cn/MZRteZOTHrUKBvvMHFwan
 n7IaS4VwdzLozx22prsh6P1vUG+CT18=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-520-rpIdAjXjO3iiTzDpivW0UQ-1; Tue, 04 Jul 2023 06:36:37 -0400
X-MC-Unique: rpIdAjXjO3iiTzDpivW0UQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fbdd5d09b8so8904785e9.1
 for <qemu-devel@nongnu.org>; Tue, 04 Jul 2023 03:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688466996; x=1691058996;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xcYNF/eI37qPLuZ9B+OxTSfkyikvveTwWzfz5KsKNoQ=;
 b=LAtO3JyoEmSIol5H45XNxoMzsAcr++ZHYotOQriyDD05C8j1EM7sKWofsfI+nRgsnw
 pJkeIE+/25c4etQpdzJHZwQyuUILZdzOmi2R7VTjy1qXQZwVKuAA3a69YAmRi9QFMnkP
 brW4/M5ulbfysolGL5hmMGNv2+JAOoEkkOjCLj8rav4ClHF3sRSjFpF4mH4B2E6TH9bD
 u5PEbzDQTqGT9U2IM+jtZj6xpXEE7lYjIIy81ICZmbsYxWR2LVnCAxKodwfjPb+s3zcZ
 a5uCdeeIFo55e6yITYNQD6LNCY5zSP7YM65zW4170W6FvXrXHm9B+w35GDL6D7jWLq+3
 L/uw==
X-Gm-Message-State: AC+VfDy7OiTPP0KS/2Jf57TGdHB6abffKjKdwzzdQ+LP3bqxCZps7XnZ
 ohFdwjrJtq3O4oeLwW6EthyOLY+/9lYkaADGgY7ibNrFSph6PysdDHS1dn6R5N0w1RrnTIFKkNY
 //Sowam1bGsvIewI=
X-Received: by 2002:a05:600c:cf:b0:3fa:95c7:e891 with SMTP id
 u15-20020a05600c00cf00b003fa95c7e891mr13010384wmm.35.1688466995897; 
 Tue, 04 Jul 2023 03:36:35 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5lqhLlKrnteEAZGV/re11blkXSC0ZJDFfyrRDB3zPW+y7L+/z8hjZ56+MJTL/AOIH4Qrx9nQ==
X-Received: by 2002:a05:600c:cf:b0:3fa:95c7:e891 with SMTP id
 u15-20020a05600c00cf00b003fa95c7e891mr13010368wmm.35.1688466995532; 
 Tue, 04 Jul 2023 03:36:35 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 p1-20020a05600c204100b003fbe36a4ce6sm808091wmg.10.2023.07.04.03.36.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jul 2023 03:36:34 -0700 (PDT)
Date: Tue, 4 Jul 2023 06:36:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230704063545-mutt-send-email-mst@kernel.org>
References: <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
 <bf351f8b-1c8a-8a7a-7f44-17c9ba18f179@daynix.com>
 <DFB3B0B7-1F61-4779-9833-2AF1BA3BDFA6@redhat.com>
 <2ffee496-ec63-ad04-a90b-8c2fadbf3657@daynix.com>
 <20230702005916-mutt-send-email-mst@kernel.org>
 <63B46F8F-A52C-4BFC-BAFD-06ACAF2AA6E1@redhat.com>
 <d6368f95-3adf-9d49-82b4-a138a32010a4@daynix.com>
 <D23A8D44-FA51-44C7-8AE3-65B10CDB0976@redhat.com>
 <DC9C1732-B33B-4A09-8CB4-6B02F422DD02@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DC9C1732-B33B-4A09-8CB4-6B02F422DD02@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Tue, Jul 04, 2023 at 04:03:54PM +0530, Ani Sinha wrote:
> 
> 
> > On 04-Jul-2023, at 11:09 AM, Ani Sinha <anisinha@redhat.com> wrote:
> > 
> > 
> > 
> >> On 04-Jul-2023, at 10:31 AM, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >> 
> >> On 2023/07/03 15:08, Ani Sinha wrote:
> >>>> On 02-Jul-2023, at 10:29 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>>> 
> >>>> On Sat, Jul 01, 2023 at 04:09:31PM +0900, Akihiko Odaki wrote:
> >>>>> Yes, I want the slot number restriction to be enforced. If it worries you
> >>>>> too much for regressions, you may implement it as a warning first and then
> >>>>> turn it a hard error when the next development phase starts.
> >>>> 
> >>>> That's not a bad idea.
> >>> If we had not enforced the check strongly, the tests that we fixed would not get noticed.
> >> 
> >> Perhaps so, but we don't have much time before feature freeze. I rather want to see the check implemented as warning in 8.1 instead of delaying the initial implementation of the check after 8.1 (though I worry if it's already too late for 8.1.)
> > 
> > The feature hard freeze window starts from 12th of next week. So I am still debating whether to keep the hard check or just have a warning. If the hard check causes regressions, we can always revert it to a warning later.
> 
> mst?

I'd go for a warning now. Let's see what triggers for users without
actually breaking things too badly for them.

-- 
MST


