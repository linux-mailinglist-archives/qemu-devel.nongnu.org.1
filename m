Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 97086743EE6
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 17:30:59 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFG41-00022d-2F; Fri, 30 Jun 2023 11:29:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFG3z-00022S-6K
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:29:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFG3w-0000e7-Vm
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 11:29:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688138971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gXiUqFKJ9izLFYpZpBkwcau7+APSDLrPdz1lFqUxdBw=;
 b=FPllmJc1qq492Cr1U7B4ENOaiq/9Jm2YQG6tHME42ayeCQcON2H2CC1EaTiGyb+CInlvut
 NGOe0MXZAFB/6Avr3uA8xGyu1jI9Ug9Y17yIs2GXPTONGfw7LH5WhlehkxUWJS/AVpu3NZ
 JaS/tchn4g3futk6tRpFp+MwIfhJgNk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-662-wzbk3HD1PxulyqvEF6M9Ew-1; Fri, 30 Jun 2023 11:29:29 -0400
X-MC-Unique: wzbk3HD1PxulyqvEF6M9Ew-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-30e3ee8a42eso1087760f8f.1
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 08:29:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688138968; x=1690730968;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gXiUqFKJ9izLFYpZpBkwcau7+APSDLrPdz1lFqUxdBw=;
 b=TSQgQBjK5gWfYyahcsOSLo4RCaVyHCySPFUXUen6hoTpG8sbeuRm31cjuMDfXeTDp3
 zz2UWNSKK4oF9knAn60xkbIny8VoMLzKErxPIHMVRjiD/rLxuQfhyp1vnRgNpfq7HcMd
 tpTkz/2MdHtRWqmF1A1Ys0kfPYNS+R9EnoQW/nq7UUAa5w8rgL1CHh1mAdUzPa4vrlZo
 HWVzeRmbtTzYKVCuQ/48I1BjGbFNLCtwTy9gMQ4j85palEboIrdlM/c+o8lTqA8mCcfA
 +uZiwz5pZese08i0kbuC9+frHmUHTe6IvM8ya0pnLPurvi5bWu1O1vZFgqqA016iGAQf
 Gh8Q==
X-Gm-Message-State: ABy/qLaYfcE4F9MpsDvAJTnZGbqpSvl8uYbIARdyp+YEMYPO7hSJzNUk
 17FSat82aeTlTXvRe6p9oGzHaxNZBvvPyPjOVbT/MZsqAtFhVkUt514LSzqDQNK9DB0Yd0rS8ks
 +/OVzGB3j2ux9wrM=
X-Received: by 2002:adf:d851:0:b0:314:133a:f04 with SMTP id
 k17-20020adfd851000000b00314133a0f04mr2299769wrl.49.1688138968394; 
 Fri, 30 Jun 2023 08:29:28 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGw5tA3z3Vu/sclPA8R02fp0K49t3jg06i29anjng+/KP32ZKImB5nF4aO5NC/ZeV+FpZMvVw==
X-Received: by 2002:adf:d851:0:b0:314:133a:f04 with SMTP id
 k17-20020adfd851000000b00314133a0f04mr2299755wrl.49.1688138968020; 
 Fri, 30 Jun 2023 08:29:28 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 m3-20020adff383000000b0031417b0d338sm4130164wro.87.2023.06.30.08.29.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 08:29:27 -0700 (PDT)
Date: Fri, 30 Jun 2023 11:29:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Ani Sinha <anisinha@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230630112611-mutt-send-email-mst@kernel.org>
References: <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
 <20230630055717-mutt-send-email-mst@kernel.org>
 <FB764864-ADD3-4017-8313-ED40A833A81B@redhat.com>
 <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a38e0336-58e5-e796-bd29-0dfc5d1d0e46@daynix.com>
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

On Fri, Jun 30, 2023 at 08:36:38PM +0900, Akihiko Odaki wrote:
> On 2023/06/30 19:37, Ani Sinha wrote:
> > 
> > 
> > > On 30-Jun-2023, at 3:30 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > 
> > > On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
> > > > 
> > > > 
> > > > > On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > 
> > > > > On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
> > > > > > 
> > > > > > 
> > > > > > > On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > > > 
> > > > > > > On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
> > > > > > > > > 
> > > > > > > > > Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
> > > > > > > > > 
> > > > > > > > > > Also where do you propose we move the check?
> > > > > > > > > 
> > > > > > > > > In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
> > > > > > > > 
> > > > > > > > Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
> > > > > > > > 
> > > > > > > > -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
> > > > > > > > 
> > > > > > > > The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.
> > > > > > > 
> > > > > > > I think it's allowed because it expects you to hotplug function 0 later,
> > > > > > 
> > > > > > This is about the igb device being plugged into the non-zero slot of the pci-root-port. The guest OS ignores it.
> > > > > 
> > > > > yes but if you later add a device with ARI and with next field pointing
> > > > > slot 2 guest will suddently find both.
> > > > 
> > > > Hmm, I tried this:
> > > > 
> > > > -device pcie-root-port,id=p \
> > > > -device igb,bus=p,addr=0x2.0x0 \
> > > > -device igb,bus=p,addr=0x0.0x0 \
> > > > 
> > > > The guest only found the second igb device not the first. You can try too.
> > > 
> > > Because next parameter in pcie_ari_init does not match.
> > 
> > OK send me a command line that I can test it with. I can’t come up with a case that actually works in practice.
> 
> I don't think there is one because the code for PCI multifunction does not
> care ARI. In my opinion, we need yet another check to make non-SR-IOV
> multifunction and ARI capability mutually exclusive; if a function has the
> ARI capability and it is not a VF, an attempt to assign non-zero function
> number for it should fail.

Why is that? My understanding is that ARI capable devices should also
set the multifunction bit in the header. It's not terribly clear from
the spec though.

> But it should be a distinct check as it will need to check the function
> number bits.
> 
> > 
> > > 
> > > 
> > > > > 
> > > > > > > no?
> > > > > > > 
> > > > > > > I am quite worried about all this work going into blocking
> > > > > > > what we think is disallowed configurations. We should have
> > > > > > > maybe blocked them originally, but now that we didn't
> > > > > > > there's a non zero chance of regressions,
> > > > > > 
> > > > > > Sigh,
> > > > > 
> > > > > There's value in patches 1-4 I think - the last patch helped you find
> > > > > these. so there's value in this work.
> > > > > 
> > > > > > no medals here for being brave :-)
> > > > > 
> > > > > Try removing support for a 3.5mm jack next. Oh wait ...
> > > > 
> > > > Indeed. Everyone uses bluetooth these days. I for one is happy that the jack is gone (and they were bold enough to do it while Samsung and others still carry the useless port ) :-)
> 
> Hello from a guy using a shiny M2 Macbook Air carrying the legacy jack with
> a 100-yen earphone. Even people who ported Linux to this machine spent
> efforts to get the jack to work on Linux ;)
> 
> > > > 
> > > > > 
> > > > > > > and the benefit
> > > > > > > is not guaranteed.
> > > > > > > 
> > > > > > > -- 
> > > > > > > MST
> > 


