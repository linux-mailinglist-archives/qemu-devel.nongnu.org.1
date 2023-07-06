Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 8232874A3E8
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:51:19 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHU3y-0005fe-Rf; Thu, 06 Jul 2023 14:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHU3h-0005RM-TR
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:50:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qHU3g-0004ld-5d
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688669426;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/Zg1RNmo+OBWtlioQDtmsUi28smmWJ6RU0beR5mVidY=;
 b=dK5CcG2k2b3UAEt4CytpAyaxI0UscsvG3dOcXDCDjhvbczLEHhi1SxvHrjQ19AX14/Kiii
 IH7vvlUjurugDgz4E1jXSKYRLe8AxSgS8k39RHjhOPFYVq23vwc2VKAuneJorM4F1iiQy/
 VHLXr0irb0DvjVIS1xL7gClE6I3nV2c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-I24eeyApMiewe-t_CVo00g-1; Thu, 06 Jul 2023 14:50:25 -0400
X-MC-Unique: I24eeyApMiewe-t_CVo00g-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3fbdf341934so7429565e9.3
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:50:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688669424; x=1691261424;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/Zg1RNmo+OBWtlioQDtmsUi28smmWJ6RU0beR5mVidY=;
 b=FCWYoUT+X9TBm2FG4orhEEVwa0CEaWkEU5S+GiVSNgnA9vzYY5N9o8KFfHt1q4uZ06
 OIowvqBTlKFW1cteF1r5z9RuxWwkLTBevX/vBFh31JiGHXOepDq9edB9aTrvR9pLvHws
 aItzdmqccIUvvi+KYZPEWuCyU2cvNmsWa4aaMrm4GWQjYEbgLyVoY2umIht/Fk+VfFtz
 5PfSq73F0RbtNpvp3uGS8CvoMyaGqz88yjU2hqpTqwdIjEQAat1SbaVQ7pYmjGW5Pmgy
 NsPomTHWr1+SgWJ8OZxjSvkxtq4fEarK3EkcOvWPalGdDQBhZm94+LUGF93cJJjA69bw
 R9wg==
X-Gm-Message-State: ABy/qLZA5wRZ+wNjcrj+XG0ljP4MK7twO5olTGjrzQ4LJRb51h9/Cf8V
 8DlavaZ2AuNlYqSNip9o3G9cEh9T1kQE6RUfYGy7wVMinQEI0ga7HEsmAmtUnQiotwXoq9lngvx
 JkTEKeRCx/TK4Oxk=
X-Received: by 2002:a05:600c:ada:b0:3fb:a100:2581 with SMTP id
 c26-20020a05600c0ada00b003fba1002581mr3163097wmr.14.1688669424054; 
 Thu, 06 Jul 2023 11:50:24 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE+eNLJF9vsWHgHXVGKKzOQCQv4OnAhO6x0YeodaYzadf7SAv7rjArEkvejr2rFzmh6MYWSNw==
X-Received: by 2002:a05:600c:ada:b0:3fb:a100:2581 with SMTP id
 c26-20020a05600c0ada00b003fba1002581mr3163085wmr.14.1688669423739; 
 Thu, 06 Jul 2023 11:50:23 -0700 (PDT)
Received: from redhat.com ([2.52.13.33]) by smtp.gmail.com with ESMTPSA id
 g7-20020a7bc4c7000000b003fbfc9dd928sm178161wmk.23.2023.07.06.11.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:50:23 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:50:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Leonardo Bras Soares Passos <leobras@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] pcie: Add hotplug detect state register to cmask
Message-ID: <20230706144844-mutt-send-email-mst@kernel.org>
References: <20230706045546.593605-3-leobras@redhat.com> <ZKbRRt8ESGsMz+o7@x1n>
 <CAJ6HWG4iUX=+7FTCkXitFfc1zFNJ9aR5PzDRyPLSZVq1Kos8fA@mail.gmail.com>
 <ZKcEjfTDDgDZWu9Q@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZKcEjfTDDgDZWu9Q@x1n>
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

On Thu, Jul 06, 2023 at 02:14:37PM -0400, Peter Xu wrote:
> On Thu, Jul 06, 2023 at 03:07:40PM -0300, Leonardo Bras Soares Passos wrote:
> > > I asked the same question, and I still keep confused: whether there's a
> > > first bad commit?  Starting from when it fails?
> > >
> > > For example, is this broken on 6.0 binaries too with pc-q35-6.0?
> > 
> > I tested for qemu 6.0, and it still reproduces, but have not pursued
> > this any further.
> 
> I see, thanks!
> 
> But then do you know why it's never hit before?  I assume it means this bug
> has been there for a long time.

It's a race - you have to migrate after the bit has been set before
the bit got cleared.
cmask is exactly for bits that qemu modifies itself.

-- 
MST


