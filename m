Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFDE7438D8
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 12:01:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qFAvh-0002pu-Mw; Fri, 30 Jun 2023 06:00:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFAve-0002pQ-HS
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:00:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qFAvc-0007H0-Ou
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 06:00:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688119235;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iSsTXsLzfXoFmwlGJx797LXWxIGQJchjCkQpMDKCUCw=;
 b=e7B9Jc8UZfNskgKLU2sWByffD5VinnAzAFPoeHFW2JkVQ9nhXSH6Hn81hj6mVdc37E6xbm
 Xk5TLPCz/lLEe/d7xq5YMsWtZOm7d5omDIaVbpnVeEk6XQN+tekYeYHQUVsL+h4uYQRSJO
 LmFaWNZyjdYT+ftpAsq9WT+mFLd1J88=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-329-jtH1jAv5MkSXOTuPKGSBvw-1; Fri, 30 Jun 2023 06:00:31 -0400
X-MC-Unique: jtH1jAv5MkSXOTuPKGSBvw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3fb416d7731so8681005e9.2
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 03:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688119230; x=1690711230;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iSsTXsLzfXoFmwlGJx797LXWxIGQJchjCkQpMDKCUCw=;
 b=Nw4Z1I2RM3OFNYksxDkAlcxOBjEHSjTBZA7Izj1EZ6JauO0FmXjrbFiJvgf/AZSIYB
 +fPjWIFbTct3EoB8ZyeTQVoRW4VIPVWfmkXzX1Rz0zRVGbl+aHdiB0Pz2rpBAHozBal4
 yrePRNBQGrG7/TMYfR7i3ots9IhP7lIX77Heeq03OmH2dFmPloQX65FXXqqwBMVYIJJn
 IZJgZ0WoMfyewvQAdwCV/mV2RT88xTD4WyXPzBvHt0kw/YlJ3rd4FiFzBEXNXXueNGzg
 E0OuEl0mEeJUxx4JsjRszWejIHTkZXuvYQeOT9VSSYGO77xYIwRnvU2NddjKlUNtbbIJ
 FQyw==
X-Gm-Message-State: AC+VfDyt/dvaoTdWrk6kw2wEIyyCMpLwt0IonCgr2Q3nXNKYne6NNF0R
 db2jGSq0jVlPKTQGlhGrGiLoGhXwokhWw+jkjnpDxDcd3Z9eqHshJQtKKZwNDUeEPqZN3MpYoJh
 Sc1MMtd9zhrfEqcU=
X-Received: by 2002:a05:600c:cf:b0:3fb:a102:6d7a with SMTP id
 u15-20020a05600c00cf00b003fba1026d7amr1389333wmm.28.1688119230494; 
 Fri, 30 Jun 2023 03:00:30 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6PgIG0ZQi+wt46n1iIA0AqAZLd0R7arJFE0GLVVaWWGCbQZVsnfZd0cyalEdk4+RWVSs8s1Q==
X-Received: by 2002:a05:600c:cf:b0:3fb:a102:6d7a with SMTP id
 u15-20020a05600c00cf00b003fba1026d7amr1389318wmm.28.1688119230116; 
 Fri, 30 Jun 2023 03:00:30 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 y5-20020a05600c364500b003fbc9d178a8sm140875wmq.4.2023.06.30.03.00.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 03:00:29 -0700 (PDT)
Date: Fri, 30 Jun 2023 06:00:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230630055717-mutt-send-email-mst@kernel.org>
References: <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
 <20230630041937-mutt-send-email-mst@kernel.org>
 <4618EAD1-2862-4288-A881-CA860D04ADB0@redhat.com>
 <20230630043734-mutt-send-email-mst@kernel.org>
 <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <49B901C6-4819-4A00-8225-39FAA6678F3E@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
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

On Fri, Jun 30, 2023 at 02:52:52PM +0530, Ani Sinha wrote:
> 
> 
> > On 30-Jun-2023, at 2:13 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> > 
> > On Fri, Jun 30, 2023 at 02:06:59PM +0530, Ani Sinha wrote:
> >> 
> >> 
> >>> On 30-Jun-2023, at 2:02 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> >>> 
> >>> On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
> >>>>> 
> >>>>> Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
> >>>>> 
> >>>>>> Also where do you propose we move the check?
> >>>>> 
> >>>>> In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
> >>>> 
> >>>> Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
> >>>> 
> >>>> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
> >>>> 
> >>>> The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.
> >>> 
> >>> I think it's allowed because it expects you to hotplug function 0 later,
> >> 
> >> This is about the igb device being plugged into the non-zero slot of the pci-root-port. The guest OS ignores it.
> > 
> > yes but if you later add a device with ARI and with next field pointing
> > slot 2 guest will suddently find both.
> 
> Hmm, I tried this:
> 
> -device pcie-root-port,id=p \
> -device igb,bus=p,addr=0x2.0x0 \
> -device igb,bus=p,addr=0x0.0x0 \
> 
> The guest only found the second igb device not the first. You can try too.

Because next parameter in pcie_ari_init does not match.


> > 
> >>> no?
> >>> 
> >>> I am quite worried about all this work going into blocking
> >>> what we think is disallowed configurations. We should have
> >>> maybe blocked them originally, but now that we didn't
> >>> there's a non zero chance of regressions,
> >> 
> >> Sigh,
> > 
> > There's value in patches 1-4 I think - the last patch helped you find
> > these. so there's value in this work.
> > 
> >> no medals here for being brave :-)
> > 
> > Try removing support for a 3.5mm jack next. Oh wait ...
> 
> Indeed. Everyone uses bluetooth these days. I for one is happy that the jack is gone (and they were bold enough to do it while Samsung and others still carry the useless port ) :-)
>  
> > 
> >>> and the benefit
> >>> is not guaranteed.
> >>> 
> >>> -- 
> >>> MST


