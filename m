Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D4959743746
	for <lists+qemu-devel@lfdr.de>; Fri, 30 Jun 2023 10:33:53 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qF9YA-0006DE-6S; Fri, 30 Jun 2023 04:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qF9Y6-0006D1-EV
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:32:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qF9Y4-0006Yp-97
 for qemu-devel@nongnu.org; Fri, 30 Jun 2023 04:32:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688113931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VlD9fpAlUFt6Mbj72qHXgaMI9mCHjUTC5cGYuutmJS0=;
 b=gGtt2CgzDIa0t9acNVXzbsCYnWbJrwtLpdqzPKcHvZuLV4Xe1bYMv+bfP6B2uqwmzVWBYR
 aI0AbWP52Iii+I7OuvY4+1kSBmIy0xuZOTU0knFS/9+U/PhQ+sH78Gi5GcOKE3ZPfQsMKq
 6dYNWodi/H3cKb0IKzwXDFynjuRzU4Q=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-86MeL1VuNcWpRKR37Y5dmg-1; Fri, 30 Jun 2023 04:32:07 -0400
X-MC-Unique: 86MeL1VuNcWpRKR37Y5dmg-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-314256aedcbso98462f8f.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jun 2023 01:32:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688113926; x=1690705926;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VlD9fpAlUFt6Mbj72qHXgaMI9mCHjUTC5cGYuutmJS0=;
 b=Zhi6OWJ62XqQsPYpB2AZPjYCXwIxPLCY/hOVecV1+xOvFDfdhIX5Tpwl+T53mrH65a
 ofNKpD/K7R+qOhAHzVIox/3HcxD9F51qkig3PDgwdr9dYwlWeku2UCyDa3tFOlZXRI43
 mN9gLnjJNQk9NyE3wciBuUDCfg3tu7r1+VmTYn3EZJ81e4b5+8U1Yk0bEe2XwsrM2xF8
 iHfadin97eqALXzkxfNrPG6enPyUi9tkn5TdvSlSESVo8n/hgIw111Dd9BAJ1LddBQ58
 R2tWADDYpctbO+Ba7dx1m9tHbdtkuYFzdNIDTznGVMXgIuahgZVXMPCjzR/yjRUPW8jr
 wnaw==
X-Gm-Message-State: ABy/qLbO2LSw4cvUELW4RnAhsOUFAQ9sh5doQ24oOp/g9oQ3nIndRk/B
 uMB+f/i3ns9aFQcXaGca9dPBEKb50XxXGtVuvbX7+aWLrryiWKJV7KkqXts5Iv1z8i2i6yWgeBP
 0wT7YtcCSifhfFPw=
X-Received: by 2002:a5d:480b:0:b0:313:e591:a533 with SMTP id
 l11-20020a5d480b000000b00313e591a533mr1945541wrq.41.1688113926469; 
 Fri, 30 Jun 2023 01:32:06 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFRJCuqd7uli8e0G7U94XPFlX+EEeUMXEqCdhywepxm07ROnZ4o/tWqP9bIM447hI/SmkE64w==
X-Received: by 2002:a5d:480b:0:b0:313:e591:a533 with SMTP id
 l11-20020a5d480b000000b00313e591a533mr1945524wrq.41.1688113926138; 
 Fri, 30 Jun 2023 01:32:06 -0700 (PDT)
Received: from redhat.com ([2.52.154.169]) by smtp.gmail.com with ESMTPSA id
 u18-20020a5d6ad2000000b00313e90d1d0dsm15861138wrw.112.2023.06.30.01.32.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jun 2023 01:32:05 -0700 (PDT)
Date: Fri, 30 Jun 2023 04:32:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 qemu-devel <qemu-devel@nongnu.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Julia Suvorova <jusual@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH v6 5/5] hw/pci: ensure PCIE devices are plugged into only
 slot 0 of PCIE port
Message-ID: <20230630041937-mutt-send-email-mst@kernel.org>
References: <20230629040707.115656-1-anisinha@redhat.com>
 <20230629040707.115656-6-anisinha@redhat.com>
 <8d382e8b-088b-f0af-eec4-a85ee513b4ae@daynix.com>
 <CAK3XEhNOJkm13+vxJO9-Adhwq8NJ3TQ1gaOXj8Dn3NtixF_=jQ@mail.gmail.com>
 <8868044c-f61b-7bbb-8cc8-34a14c1490d6@daynix.com>
 <9DDBE75A-C72C-4238-9166-3CBDBEA68188@redhat.com>
 <167eea06-b917-8783-5cd6-8fda56e41331@daynix.com>
 <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A50CA177-0E7E-4828-A036-70EB532FE2B8@redhat.com>
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

On Fri, Jun 30, 2023 at 01:11:33PM +0530, Ani Sinha wrote:
> > 
> > Thus the check for unoccupied function 0 needs to use pci_is_vf() instead of checking ARI capability, and that can happen in do_pci_register_device().
> > 
> >> Also where do you propose we move the check?
> > 
> > In pci_qdev_realize(), somewhere after pc->realize() and before option ROM loading.
> 
> Hmm, I tried this. The issue here is something like this would be now allowed since the PF has ARI capability:
> 
> -device pcie-root-port,id=p -device igb,bus=p,addr=0x2.0x0
> 
> The above should not be allowed and when used, we do not see the igb ethernet device from the guest OS.

I think it's allowed because it expects you to hotplug function 0 later,
no?

I am quite worried about all this work going into blocking
what we think is disallowed configurations. We should have
maybe blocked them originally, but now that we didn't
there's a non zero chance of regressions, and the benefit
is not guaranteed.

-- 
MST


