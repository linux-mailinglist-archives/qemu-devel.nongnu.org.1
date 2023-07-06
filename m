Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id C70D274A413
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 21:03:52 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHUFJ-0002Lt-Hf; Thu, 06 Jul 2023 15:02:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHUFG-0002Ik-Cg
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:02:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHUFE-0004e3-QC
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 15:02:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688670143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WPz3hzxajAzRFV1nITeeDyoEzUdKTeIUgo1sSR17NA4=;
 b=EDG6BH64DowI410VkOJPFHVwfW8wcUcg0mYWq510HJquM+l1qx5rYxR2gZ9zyMeD2kYSr6
 yUdpHkZ1f3X4aHW8bKlIp6EsOuWgqd50OEmHPMTq65uZVXqIz1wrXoYQMA8kMba18P8Bk8
 FOkYwF+yvqGC2HdxAtdSET0cjWNjmO4=
Received: from mail-yb1-f198.google.com (mail-yb1-f198.google.com
 [209.85.219.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-FMYvG6dnNwOD59qRt3lpbQ-1; Thu, 06 Jul 2023 15:02:22 -0400
X-MC-Unique: FMYvG6dnNwOD59qRt3lpbQ-1
Received: by mail-yb1-f198.google.com with SMTP id
 3f1490d57ef6-c5f47a5724dso125973276.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 12:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688670141; x=1691262141;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WPz3hzxajAzRFV1nITeeDyoEzUdKTeIUgo1sSR17NA4=;
 b=eCzHISlUgqjb+JIUw5EgZKVGkHDnaR6lfJvd8ajIUPVDpE7xGW6xB8Y3eAUXAP4VUe
 KtvHB9XQfgfZhavK0+Ja5spgNmqS2T7lAYi0xZrA+rY+fMS5/+EFkgvo4IpUzLEkfe68
 ohm0fYIHciSoQhxfN3ElucRr3Ucj95+nzGq6DZYqsrpAbUJpgc0kD/UVZ8I6bFQFpHpY
 lYsh+gumDujvozR6/N0ARZyNwC8CJ7HX/JuDq8TCHHKt3mvIVxJyMgSRWJRpgh4eMRtH
 AGzO6pCICFmoehOh1DNrxdELxmVpM0SEaHj/jbxDAqbZ6Ik4rygGu0DiPaAiNB+F1BW5
 zmZw==
X-Gm-Message-State: ABy/qLbs7yHrIlv5/VousDzb4R+hr2YbKoBrH3YSbwO/2NMh7V+yirT7
 7tfkB5kdbStj59sEyvYijXkulBxHNCCbi1+/wv4hlPjomZmwANt1IaRCy3R5niERTI7xkYASokF
 Hkny4SHaEK8liPBE=
X-Received: by 2002:a25:b201:0:b0:c60:8e58:bb80 with SMTP id
 i1-20020a25b201000000b00c608e58bb80mr1492581ybj.1.1688670140875; 
 Thu, 06 Jul 2023 12:02:20 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH632M1/44D6KcMFgxkcg8/HteHrx+UBGTz6q4Pjjux2l1YlZPH7eoVs0SHMH30TelBvZL2Mw==
X-Received: by 2002:a25:b201:0:b0:c60:8e58:bb80 with SMTP id
 i1-20020a25b201000000b00c608e58bb80mr1492560ybj.1.1688670140596; 
 Thu, 06 Jul 2023 12:02:20 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 e24-20020ac84918000000b003f9af049c55sm903218qtq.18.2023.07.06.12.02.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 12:02:20 -0700 (PDT)
Date: Thu, 6 Jul 2023 15:02:07 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Leonardo Bras Soares Passos <leobras@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <ZKcPr3gueuOM4LGY@x1n>
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
 <20230706144844-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230706144844-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
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

On Thu, Jul 06, 2023 at 02:50:20PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jul 06, 2023 at 02:14:37PM -0400, Peter Xu wrote:
> > On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wrote:
> > > > I asked the same question, and I still keep confused: whether there's a
> > > > first bad commit?  Starting from when it fails?
> > > >
> > > > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> > > 
> > > I tested for qemu 6.0, and it still reproduces, but have not pursued
> > > this any further.
> > 
> > I see, thanks!
> > 
> > But then do you know why it's never hit before?  I assume it means this bug
> > has been there for a long time.
> 
> It's a race - you have to migrate after the bit has been set before
> the bit got cleared.
> cmask is exactly for bits that qemu modifies itself.

Michael, do you mean that Leo's patch is wrong?

I just got understood why it got cleared - I think Leo didn't mention that
the device was actually offlined before migration, IIUC that's why the PDS
bit got cleared, if PDS was trying to describe that of the slot.

According to:

    /* Used to enable checks on load. Note that writable bits are
     * never checked even if set in cmask. */
    uint8_t *cmask;

It does sound reasonable to me to have PDS cleared when device offlined.
Since hypervisor doesn't really know what the condition the slot presence
bit would be when migrating, it seems we should just clear the bit in
cmask.

So with the last reply from Leo, the patch looks all right to me.  It's
just that as Leo mentioned, we should mention the offline process if that's
the case, because that's definitely an important step to reproduce the issue.

Thanks,

-- 
Peter Xu


