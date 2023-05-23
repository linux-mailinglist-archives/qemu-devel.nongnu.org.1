Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E823270E2AE
	for <lists+qemu-devel@lfdr.de>; Tue, 23 May 2023 19:18:28 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q1Ve8-0002iY-KP; Tue, 23 May 2023 13:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q1Ve4-0002hC-FG
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:18:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.williamson@redhat.com>)
 id 1q1Vdx-000475-Qe
 for qemu-devel@nongnu.org; Tue, 23 May 2023 13:18:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684862272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YDOcPGeZtbnrpKBEp7RgLgAeEfVxVFDXfIxNlq710eY=;
 b=GuMpLkHPryOVxsfXbkOcKJi4XnK0efMuD0QcudCJYM3e2IEQtZJzo9p5LmVHLdwIzStBlW
 MXRcwzeOCqhvjcTafj2Zk/ZaYI1ZP4fhC1MpYKTN3jvzjCh8ndYZCO3/Sd/CMlRBx/4x3A
 v50Zoy8FhRKdTmL9V41Kp6U1jyuKd8c=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-paABs9sSPCuznsy0nDFCsQ-1; Tue, 23 May 2023 13:17:50 -0400
X-MC-Unique: paABs9sSPCuznsy0nDFCsQ-1
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-331828cdc2dso7560305ab.3
 for <qemu-devel@nongnu.org>; Tue, 23 May 2023 10:17:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684862270; x=1687454270;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YDOcPGeZtbnrpKBEp7RgLgAeEfVxVFDXfIxNlq710eY=;
 b=GUkZ1dmQ37Irrb463Yb5+GSS9KE+65+/JqTHFuQVoSfJdGVJ/RekqSOmrtpo4gLktp
 7q9WoTO6Z8PtSEPDy638HcSxcU9gUF/LnMQb8i7nCHMrrQyX03RRkT0Yf7GNb5+iyQPr
 W9zffnvWyBF3Ox5iUDif3t43/3wmM61tgg/+JxcK8ECaSsipJUB/69HEjJ8K33EYLehZ
 o8t22t7ytA/IuQ6ZbWwh5yKwE6A4Lc2iuOS5eA0XgmpyZCN2Sg730ftaHS21F/h1QEhR
 0FAFjZ/7gzbdGlVcuTavnvG2kFmtrAZFOMku/NmYQhGbPWon23cwCH57bonrqUTreXyR
 FBXA==
X-Gm-Message-State: AC+VfDzIz0XXxOyjMEuofktqJpWFhsXU+6u6eUguKzupz4zbiU1RrayB
 wbKWXFzT+nKV2woPW1RpmD7DWFCKY3r+HU0wyxkWvi0vqYIE99zIE0NaxKVoK+jnY44adTT1F7V
 31DOXLzYz7rvWERw=
X-Received: by 2002:a92:680b:0:b0:32b:665d:c816 with SMTP id
 d11-20020a92680b000000b0032b665dc816mr8695302ilc.28.1684862269957; 
 Tue, 23 May 2023 10:17:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4hxukjRalLaoZ9TBfLXOuV5DBNOwaWGGQJCmj0aKweQrdtIuKvTjGOuc9rWN6jakvlGMiX/w==
X-Received: by 2002:a92:680b:0:b0:32b:665d:c816 with SMTP id
 d11-20020a92680b000000b0032b665dc816mr8695290ilc.28.1684862269736; 
 Tue, 23 May 2023 10:17:49 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 f2-20020a056e0204c200b0032ca1426ddesm2468357ils.55.2023.05.23.10.17.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 May 2023 10:17:48 -0700 (PDT)
Date: Tue, 23 May 2023 11:17:47 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>, qemu-devel@nongnu.org,
 minwoo.im@samsung.com, clg@redhat.com, chao.p.peng@intel.com
Subject: Re: [PATCH v2] vfio/pci: Fix a use-after-free issue
Message-ID: <20230523111747.747878e5.alex.williamson@redhat.com>
In-Reply-To: <d3e51ee1-b943-07ef-35fa-8cac13705f59@linux.ibm.com>
References: <20230517024651.82248-1-zhenzhong.duan@intel.com>
 <d3e51ee1-b943-07ef-35fa-8cac13705f59@linux.ibm.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=alex.williamson@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Tue, 23 May 2023 13:00:53 -0400
Matthew Rosato <mjrosato@linux.ibm.com> wrote:

> On 5/16/23 10:46 PM, Zhenzhong Duan wrote:
> > vbasedev->name is freed wrongly which leads to garbage VFIO trace log.
> > Fix it by allocating a dup of vbasedev->name and then free the dup.
> > 
> > Fixes: 2dca1b37a7 ("vfio/pci: add support for VF token")
> > Suggested-by: Alex Williamson <alex.williamson@redhat.com>
> > Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>  
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Also verified that this resolves an issue seen on s390, as we were
> seeing not just garbage logs but QEMU crashes in certain cases e.g.
> during device unplug.  Thanks!

Thanks for the testing and reminder, I'll get a pull request out for
this.  Thanks,

Alex

> > ---
> > v2: "toke" -> "token", Cedric
> >     Update with Alex suggested change
> > 
> >  hw/vfio/pci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/vfio/pci.c b/hw/vfio/pci.c
> > index bf27a3990564..73874a94de12 100644
> > --- a/hw/vfio/pci.c
> > +++ b/hw/vfio/pci.c
> > @@ -2994,7 +2994,7 @@ static void vfio_realize(PCIDevice *pdev,
> > Error **errp) qemu_uuid_unparse(&vdev->vf_token, uuid);
> >          name = g_strdup_printf("%s vf_token=%s", vbasedev->name,
> > uuid); } else {
> > -        name = vbasedev->name;
> > +        name = g_strdup(vbasedev->name);
> >      }
> >  
> >      ret = vfio_get_device(group, name, vbasedev, errp);  
> 


