Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 253B577D5DD
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 00:20:39 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qW2ON-0005Zc-2P; Tue, 15 Aug 2023 18:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2OL-0005ZU-PL
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:19:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qW2OJ-0008Vd-Gq
 for qemu-devel@nongnu.org; Tue, 15 Aug 2023 18:19:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692137994;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XibMT1U46vHZJcpE31hSn+xI+oGYoG86w2KrjLArPpk=;
 b=Ty9rZAmVh9B2szg1I8WPnxMItLZg15ha9/FQRNFoNJ8aU6eHGcVrRn8dpJkCgPWxzp3+pV
 0rWUY5AbZK5g3I7wt3SN463QYU5mVfGxH20JqlrMOXQ01l9yLTnifkhQZHapX+zPAQ5Xei
 vnRhbZPf4cP2QkfyA7C1ErTBY20Ea6c=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-FCvWS7NGMlGLO2HIB9lq1g-1; Tue, 15 Aug 2023 18:19:52 -0400
X-MC-Unique: FCvWS7NGMlGLO2HIB9lq1g-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76cb292df12so206726185a.0
 for <qemu-devel@nongnu.org>; Tue, 15 Aug 2023 15:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692137992; x=1692742792;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XibMT1U46vHZJcpE31hSn+xI+oGYoG86w2KrjLArPpk=;
 b=OIRlPs/iJHUyrzY/6FtbFAoeUNnBypGRk7X/2+9j48UQdymzGf+6HxEhB+7EO4MYjd
 j64EWcHaSIZeP4XGBgZ2sWhCBJY4PHSjSgZr6+igu8P9NU7FMVzFS7MlDcCYYlRUT0jN
 oC1/e+v6HmKKlg9zcOAmnP1dou4dCNUxZpkftclDOktZqb+QKvjF+lZreyHU9PdqcVvT
 wwcVNjQ1nRJLNJYAyCcivsKZyM4GsoGQgR8d21XfqDWAo8mwkWucUEvk+CZ3cyCvbe3C
 RHlOTeQG6PhbYMdFR81NZ1dnhPO6qbqA5K7qR30v+8f7iOhwmEEQYbPMlrlFUDXNoJMv
 mjvQ==
X-Gm-Message-State: AOJu0Yy1DkLDd8CKBJX5bpAkKS1i20dQK5v//tmxsXVAWoTDW4NuSKnK
 5UyY2W7LGIap97bgNyP3EAr0grZujEziq2SZRsK66LvIMNnwgQUbSR+pvXXmdHCyfUG87QeiqhB
 A0ppxjDuBCDzTS7A=
X-Received: by 2002:a05:620a:2a03:b0:76c:a9eb:90bf with SMTP id
 o3-20020a05620a2a0300b0076ca9eb90bfmr229566qkp.3.1692137992368; 
 Tue, 15 Aug 2023 15:19:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6IjxHmoZyJLhP9dSFkWotIKZOZo0QUvDf63nLVvR3X+mfvdBXwqIBcTpahXOEQj+dHWn3xQ==
X-Received: by 2002:a05:620a:2a03:b0:76c:a9eb:90bf with SMTP id
 o3-20020a05620a2a0300b0076ca9eb90bfmr229546qkp.3.1692137992122; 
 Tue, 15 Aug 2023 15:19:52 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 cr19-20020a05622a429300b00403af2cf825sm4078126qtb.34.2023.08.15.15.19.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Aug 2023 15:19:51 -0700 (PDT)
Date: Tue, 15 Aug 2023 18:19:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: Guoyi Tu <tugy@chinatelecom.cn>, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] migrate/ram: let ram_save_target_page_legacy() return if
 qemu file got error
Message-ID: <ZNv6ABLk7EjaX8dD@x1n>
References: <20ae48e5-006d-4a1b-823e-f2c591ec4fb0@chinatelecom.cn>
 <87h6p0mqk8.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87h6p0mqk8.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.04,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Aug 15, 2023 at 09:35:19AM -0300, Fabiano Rosas wrote:
> Guoyi Tu <tugy@chinatelecom.cn> writes:
> 
> > When the migration process of a virtual machine using huge pages is 
> > cancelled,
> > QEMU will continue to complete the processing of the current huge page
> > through the qemu file object got an error set. These processing, such as
> > compression and encryption, will consume a lot of CPU resources which may
> > affact the the performance of the other VMs.
> >
> > To terminate the migration process more quickly and minimize unnecessary
> > resource occupancy, it's neccessary to add logic to check the error status
> > of qemu file object in the beginning of ram_save_target_page_legacy 
> > function,
> > and make sure the function returns immediately if qemu file got an error.
> >
> > Signed-off-by: Guoyi Tu <tugy@chinatelecom.cn>
> > ---
> >   migration/ram.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/migration/ram.c b/migration/ram.c
> > index 9040d66e61..3e2ebf3004 100644
> > --- a/migration/ram.c
> > +++ b/migration/ram.c
> > @@ -2133,6 +2133,10 @@ static int ram_save_target_page_legacy(RAMState 
> > *rs, PageSearchStatus *pss)
> >       ram_addr_t offset = ((ram_addr_t)pss->page) << TARGET_PAGE_BITS;
> >       int res;
> >
> > +    if (qemu_file_get_error(pss->pss_channel)) {
> > +        return -1;
> > +    }
> 
> Where was the error set? Is this from cancelling via QMP? Or something
> from within ram_save_target_page_legacy? We should probably make the
> check closer to where the error happens. At the very least moving the
> check into the loop.

Fabiano - I think it's in the loop (of all target pages within a same host
page), and IIUC Guoyi mentioned it's part of cancelling.

Guoyi, I assume you just saw qemu cancel too slow over e.g. 1g pages?
The patch looks good here.

Thanks,

-- 
Peter Xu


