Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E3570CEB7
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 01:37:00 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1F4g-0003Me-Az; Mon, 22 May 2023 19:36:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1F4d-0003MU-GI
 for qemu-devel@nongnu.org; Mon, 22 May 2023 19:36:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q1F4Z-0008Ge-Jh
 for qemu-devel@nongnu.org; Mon, 22 May 2023 19:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684798573;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QKlhdXezlQQ7lVZyZzqe/eBNKorSXnFM3jbfqRuA27Q=;
 b=D0TgY0zPk2hJqOeasLtUhwRk7l3+T7bYTAMmZm/N1C40++mAZkTzxO8hzxvkVqA5E1Byi/
 tWyX63bIeeQ5uaXVo9XXsl66bnRR0EuYLHLSoyyDDOVFIgu0DPSoWFMebsPrV24At54ola
 I0H+rdcJA+Y+6FOG3LK6QrCKMcSVE6c=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-wJtJwwyeM86jLDSH4l3dew-1; Mon, 22 May 2023 19:36:12 -0400
X-MC-Unique: wJtJwwyeM86jLDSH4l3dew-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-3f386bb966cso10315751cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 May 2023 16:36:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684798572; x=1687390572;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QKlhdXezlQQ7lVZyZzqe/eBNKorSXnFM3jbfqRuA27Q=;
 b=jdgPjnIUZaTNrRsRrMcbAh1zwlRJLIMEQMeEYaWiTBfXAcMk0XxeB8GeYW7q+/SiUY
 ps6dmKUzAew8UEqBonIRefdQ5YXTcM6s8hIdgGTRshbzyb3um+GcaqN+IwCvV6qkT1N0
 8idRSYBnsoavLf35mwgkEbgqfj56KGjqHgoOVqjUmTjzGthp3KkYoyhTvHlrMTXRHYpT
 whmnb49QjqcGQsRCzXzZiCyMwnX1hpmwpCHEpJsVXaImOtRn8RSoDLJCr9fBPsh/mO6J
 LBNz8WxL0HY64fpLyXb/UOBdldiOrW9/9YwqiXLpIlowT8yM6iS2tdN9uncXbhlwza4D
 ymHQ==
X-Gm-Message-State: AC+VfDzqkQ6G3tCx3fiHt3p0sOym7OOUjTGKZ8KlSKkVVbVk2Kf0QaMl
 P9BMudmro/TbiIk/OKLlPhpcE9RAko6vP8nzQclbu8525BPvMyDgBLy/I4f4nQaA57OrsS6F5si
 C+bi6LclxpsV39KE=
X-Received: by 2002:a05:620a:46a5:b0:75b:23a1:82a2 with SMTP id
 bq37-20020a05620a46a500b0075b23a182a2mr3120172qkb.3.1684798571926; 
 Mon, 22 May 2023 16:36:11 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4a3E+smH1uKE+0+ud2DYC91imvxaqculKBbOLnOHBNkgsXKr8Csh02BB7qsndEyoPTRWGcOA==
X-Received: by 2002:a05:620a:46a5:b0:75b:23a1:82a2 with SMTP id
 bq37-20020a05620a46a500b0075b23a182a2mr3120163qkb.3.1684798571687; 
 Mon, 22 May 2023 16:36:11 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 s27-20020a05620a031b00b00759300a1ef9sm2100842qkm.31.2023.05.22.16.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 May 2023 16:36:10 -0700 (PDT)
Date: Mon, 22 May 2023 19:36:09 -0400
From: Peter Xu <peterx@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Cc: "quintela@redhat.com" <quintela@redhat.com>,
 "Wang, Lei4" <lei4.wang@intel.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGv8adigFYpLD89k@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n>
 <DS0PR11MB637350354B0285ABF3FA1BD9DC7C9@DS0PR11MB6373.namprd11.prod.outlook.com>
 <ZGeWF4lzBldLLH/y@x1n> <ZGeW3R5McptUueJF@x1n>
 <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <DS0PR11MB63736A4AE4A624D2B9EFD19DDC7D9@DS0PR11MB6373.namprd11.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sat, May 20, 2023 at 01:42:06AM +0000, Wang, Wei W wrote:
> On Friday, May 19, 2023 11:34 PM, Peter Xu wrote:
> > > Ah yes indeed it keeps working, because we apply -global bits before
> > > setup sockets. Then it's fine by me since that's the only thing I
> > > would still like to keep it working. :)
> > >
> > > If so, can we reword the error message a bit?  Obviously as you said
> > > we're not really checking against -defer, but established channels.
> > > The problem is if something is established without knowing multifd
> > > being there it may not work for multifd or preempt, not strictly about defer.
> > >
> > > How about:
> > >
> > >   "Multifd/Preempt-Mode cannot be modified if incoming channel has
> > setup"
> > >
> > > ?
> 
> Yes, I'll reword it a bit.
> 
> > 
> > We may also want to trap the channel setups on num:
> > 
> > migrate_params_test_apply():
> > 
> >     if (params->has_multifd_channels) {
> >         dest->multifd_channels = params->multifd_channels;
> >     }
> 
> Didn’t get this one. What do you want to add to above?

I meant after listen() is called with an explicit number in this case,
should we disallow changing of multifd number of channels?

-- 
Peter Xu


