Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F4270E411
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:52:51 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1WBO-0004W9-8Q; Tue, 23 May 2023 13:52:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q1WBH-0004UY-3O
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:52:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q1WBE-00041C-A7
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:52:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684864335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YpNh/qmJH1FYlVABzX6UQOA1EFjW8WkiHKMC+WeBtG0=;
 b=T+zQRWd0Km7fv46aWStTRDDQUlle/2NR77egB4yZyB5HSeXrBLzk4FvUetQBHw1KpZv7c1
 FfRLJZyFs5rg2Nm6ivS0B4tEdjZqQ9iQgaLFoTwz34z8yK5OdiP35kjRwcZ5dZ1t2TwC3N
 OFvjKL18a5p2ITVTrU+9ajQlOlD2Xjk=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-281-Lp21-yHaM6SwNIldlBShNg-1; Tue, 23 May 2023 13:52:13 -0400
X-MC-Unique: Lp21-yHaM6SwNIldlBShNg-1
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-772d796bbe5so2399339f.2
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:52:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684864333; x=1687456333;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YpNh/qmJH1FYlVABzX6UQOA1EFjW8WkiHKMC+WeBtG0=;
 b=IQh8ImkkLs3jX4KPmYOYumwvIekTvLy8OH0GRW0LiRvfr9CYo9SJjKaBNqa2Zbvq58
 uoArwdRkOF+douloDGLiZiXZbblORbGizA9yfmJgcTswOh0RzYnd6gUKe7Vl7SLgFWWz
 8xnWfIoEibv2VHWI4tSgIJHTU2bM+WMO4laEsBdIgiZF03zYvpyX2rZkLZpzNiQNmiil
 5kAtQFQlI382FLclhIS9/tOG3T9/lY0ioNWxevz+iJ5QPGcFmeW0Xnld7i7oTIIoZEbR
 EprPdRcyscnUWuw3lJf+aPnWkJY5pJvaLWixWMZN4xUsVfN10r18FWT+qvJKKqyaY/RD
 WDBA==
X-Gm-Message-State: AC+VfDx1jXE04AOWJzYEG5asxtc7feCQ1GHNzWhdDMpP+pQ8H0VqqATR
 X1BmN/Wxv6Oxx8rPc0ZYMYnH/ocjS3XFVQWnurIisK7OkML0/Fx3ZCdZAE76e0JHFeSN/L3d2c/
 /fJ2E5bEy7ETGx1E=
X-Received: by 2002:a5e:890f:0:b0:76c:754d:5f2e with SMTP id
 k15-20020a5e890f000000b0076c754d5f2emr8776535ioj.20.1684864332838; 
 Tue, 23 May 2023 10:52:12 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6h2PdCbuV0K9rDXBkF4pvJ7y0Zql250JWL/vGgnHe+XwPit8JTIfxf/rFzbIVakv+vlaPxxA==
X-Received: by 2002:a5e:890f:0:b0:76c:754d:5f2e with SMTP id
 k15-20020a5e890f000000b0076c754d5f2emr8776523ioj.20.1684864332608; 
 Tue, 23 May 2023 10:52:12 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 e2-20020a5d9242000000b0076f931316b0sm2740693iol.55.2023.05.23.10.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 10:52:11 -0700 (PDT)
Date: Tue, 23 May 2023 11:52:10 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 minwoo.im@samsung.com, clg@redhat.com, chao.p.peng@intel.com
Subject: Re: [PATCH v2] vfio/pci: Fix a use-after-free issue
Message-ID: <20230523115210.6bc526f5.alex.williamson@redhat.com>
In-Reply-To: <20230523111747.747878e5.alex.williamson@redhat.com>
References: <20230517024651.82248-1-zhenzhong.duan@intel.com>
 <d3e51ee1-b943-07ef-35fa-8cac13705f59@linux.ibm.com>
 <20230523111747.747878e5.alex.williamson@redhat.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=alex.williamson@redhat.com;
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

On Tue, 23 May 2023 11:17:47 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> On Tue, 23 May 2023 13:00:53 -0400
> Matthew Rosato <mjrosato@linux.ibm.com> wrote:
> 
> > On 5/16/23 10:46 PM, Zhenzhong Duan wrote:  
> > > vbasedev->name is freed wrongly which leads to garbage VFIO trace log.
> > > Fix it by allocating a dup of vbasedev->name and then free the dup.
> > > 
> > > Fixes: 2dca1b37a7 ("vfio/pci: add support for VF token")
> > > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>    
> > 
> > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > 
> > Also verified that this resolves an issue seen on s390, as we were
> > seeing not just garbage logs but QEMU crashes in certain cases e.g.
> > during device unplug.  Thanks!  
> 
> Thanks for the testing and reminder, I'll get a pull request out for
> this.  Thanks,

Actually Cedric volunteered to bundle this with some pending patches,
so...

Acked-by: Alex Williamson <alex.williamson@redhat.com>

> > > ---
> > > v2: "toke" -> "token", Cedric
> > >     Update with Alex suggested change
> > > 
> > >  hw/vfio/pci.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > > index bf27a3990564..73874a94de12 100644
> > > --- a/hw/vfio/pci.c
> > > +++ b/hw/vfio/pci.c
> > > @@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev,
> > > Error **errp) qemu_uuid_unparse(&vdev->vf_token, uuid);
> > >          name = g_strdup_printf("%s vf_token=%s", vbasedev->name,
> > > uuid); } else {
> > > -        name = vbasedev->name;
> > > +        name = g_strdup(vbasedev->name);
> > >      }
> > >  
> > >      ret = vfio_get_device(group, name, vbasedev, errp);    
> >   
> 


