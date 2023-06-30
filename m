Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B9E47437AC
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:44:11 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9iw-0001em-QQ; Fri, 30 Jun 2023 04:43:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qF9iu-0001eR-Qo
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:43:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qF9is-0004kJ-Q4
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:43:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688114601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4Tf49fJmoRRxXMtU38LEp/wNgGOw/diK9DtFxsO7Ug=;
 b=PYdF13MROLQGbqKLHwdtfqtX/3mFAlqnnzDvzoRPP7yNt8DIM31xtLLVfJ2KU17bRQvOEN
 +G0GoEOjOE7ISf5DaZvakuvX8Uugjcgu+M0tYJDrSmwziuh88gcYMUOWKSnrpgnk05OLKB
 t6bT2PbghaaoH/B5axJ5SV5a+kkYPfg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-KNLenCSbN2mE6um77JamHA-1; Fri, 30 Jun 2023 04:43:20 -0400
X-MC-Unique: KNLenCSbN2mE6um77JamHA-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3128319d532so1036838f8f.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:43:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688114599; x=1690706599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=z4Tf49fJmoRRxXMtU38LEp/wNgGOw/diK9DtFxsO7Ug=;
 b=M01ST8J4veGBTfMGMtB8kqgK07AlESS78WivQSx6CyfaLClKaQoUNSUxRNXKS7zX/i
 4P69FIY4SyP6khvokNQPpjwSJRRCl2HjM6R2eRXp+6HvUyVKvXEajtPT+PmTIC+R47Y1
 gJYoObeXlWQtEd+l+qUm1E1FIOml0CTCRhcZ4Kmmf6hYdlX87UidfpKZJEYYu66nIfKQ
 n5Yoo8eFTyHILFxnGildTZyqH0X4SeiogWLaKeWKJWp8BA1qUKGAwoXhzypQDCgcTUfX
 N1mn9SGL/OpUHSkKb/cOaxSqoj9/AWVmjRojnkheTGrS5d/u6Zf+YLg5KnwAURsagek9
 c/CQ==
X-Gm-Message-State: AC+VfDx+xnBzBHKuhAclMUpA3650wyIc+r+k3KO6Ex/p6NKFQ8kKkzfA
 oBxABAbpSh10Ng7JFBds2IpE5gSlTZsxNxn8gjHdQNTgrmR+6H6aOusuAHfNV56F2W1VHJVQ9G4
 ZrodlasyOBwXPQw4=
X-Received: by 2002:a05:600c:cf:b0:3fa:95c7:e891 with SMTP id
 u15-20020a05600c00cf00b003fa95c7e891mr1546574wmm.35.1688114598907; 
 Fri, 30 Jun 2023 01:43:18 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6q5vLjzkbRkhOI/gaUaXxWkn153sX9g1z8RHw2l21EOU0DY6GoRp1Do1LKPsAum+GQfcpYsw==
X-Received: by 2002:a05:600c:cf:b0:3fa:95c7:e891 with SMTP id
 u15-20020a05600c00cf00b003fa95c7e891mr1546558wmm.35.1688114598544; 
 Fri, 30 Jun 2023 01:43:18 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 7-20020a05600c230700b003fa968e9c27sm13645300wmo.9.2023.06.30.01.43.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:43:18 -0700 (PDT)
Date: Fri, 30 Jun 2023 04:43:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230630043734-mutt-send-email-mst@kernel.org>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
> 
> 
> > On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
> >>> 
> >>> Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
> >>> 
> >>>> Also where do you propose we move the check?
> >>> 
> >>> In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
> >> 
> >> Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
> >> 
> >> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
> >> 
> >> The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.
> > 
> > I think it's allowed because it expects you to hotplug function 0 later,
> 
> This is about the igb device being plugged into the non-zero slot of the pci-root-port. The guest OS ignores it.

yes but if you later add a device with ARI and with next field pointing
slot 2 guest will suddently find both.

> > no?
> > 
> > I am quite worried about all this work going into blocking
> > what we think is disallowed configurations. We should have
> > maybe blocked them originally, but now that we didn't
> > there's a non zero chance of regressions,
> 
> Sigh,

There's value in patches 1-4 I think - the last patch helped you find
these. so there's value in this work.

> no medals here for being brave :-)

Try removing support for a 3.5mm jack next. Oh wait ...

> > and the benefit
> > is not guaranteed.
> > 
> > -- 
> > MST
> > 


