Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id D767E76E4F0
	for <lists+qemu-devel@lfdr.de>; Thu,  3 Aug 2023 11:51:15 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qRUyU-00020b-PM; Thu, 03 Aug 2023 05:50:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRUyS-00020Q-Gg
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 05:50:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1qRUyP-0002Fw-Dv
 for qemu-devel@nongnu.org; Thu, 03 Aug 2023 05:50:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691056224;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a4XAOxbNb7los1HfxxeGBHPrsoM+dVQgEGa0bekyfkE=;
 b=EszE4tapyiIZYpULHTCdgEqo1OiZAwcg7NUhI0nSNpq7gi0aFndCZ21V2rbRRdXzfe4lBf
 vVz7DwVzH3LLLiK0TA2w4l03OW5WVSDek8v5UTKSRP1gg7GYELH0TmlYbq2t9M6v9rCzFQ
 /eUTy5gWuoPMGgkcb6NyQIWYgfv07VY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-XP25Kk61NF-jePoxEeSBEg-1; Thu, 03 Aug 2023 05:50:20 -0400
X-MC-Unique: XP25Kk61NF-jePoxEeSBEg-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-99bd6ea0d9eso53316466b.3
 for <qemu-devel@nongnu.org>; Thu, 03 Aug 2023 02:50:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691056219; x=1691661019;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a4XAOxbNb7los1HfxxeGBHPrsoM+dVQgEGa0bekyfkE=;
 b=gDbI1DbtZoJ6IIdURr2vOIyG3A1jwHqhFR2fpX+mP2yG+tLdHF/cJndIgQfERIWnfa
 R9Y4AwoJ7VF3PzU1vLRdfbNWX80wFPfgOZsVSw8H6HYGQTawiBLpHU5k432rmzr7t4Nk
 vw3qpRxsPUa2nf1X9ZsKtKrAZAL6fh5ZWKBUE26Wn5yj54koruBQDcOr5wcsbM/6pBM/
 BiWE8tURygnFi8lZtztbxZwHxjkMiYu5CiD02YSol5ub2Z/L+KaIr7MM1XXnhd8ZnBFx
 vUDzxf+g7+gBCnJQmkQ+3yLOy4sES2VH9x8j9liSRPWAjoCO1cP1Zdj4x7krmjDDp5zu
 nNgw==
X-Gm-Message-State: ABy/qLYdqPdDdCVy96vO7fZzaR8ofUx8r0iC0vnV7PCztaKt+85BN+ky
 9nYdNoRnzE6ixutouiD8b28gFdJw4Z7P8dyMiYLPyz28UfWyG/wAPaCoZ8qB+tySyQkTUCg8+SS
 fAdRduV+OGQpNGG8=
X-Received: by 2002:a17:906:846d:b0:994:4095:3abf with SMTP id
 hx13-20020a170906846d00b0099440953abfmr6851408ejc.14.1691056219707; 
 Thu, 03 Aug 2023 02:50:19 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEyOADnRnyZswocZLgVuiLIVePIIB3Cjj/YVpLpR1fB3rOrX18DG6qnBXlPgUjOVpNFZAbREA==
X-Received: by 2002:a17:906:846d:b0:994:4095:3abf with SMTP id
 hx13-20020a170906846d00b0099440953abfmr6851393ejc.14.1691056219428; 
 Thu, 03 Aug 2023 02:50:19 -0700 (PDT)
Received: from redhat.com ([2.52.12.104]) by smtp.gmail.com with ESMTPSA id
 rs5-20020a170907036500b009929d998abcsm10251383ejb.209.2023.08.03.02.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Aug 2023 02:50:18 -0700 (PDT)
Date: Thu, 3 Aug 2023 05:50:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Milan Zamazal <mzamazal@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH] hw/virtio: Add a protection against duplicate
 vu_scmi_stop calls
Message-ID: <20230803054946-mutt-send-email-mst@kernel.org>
References: <20230720101037.2161450-1-mzamazal@redhat.com>
 <87edl2sr34.fsf@suse.de> <87o7josisk.fsf@redhat.com>
 <c06a5138-170e-d696-38f1-3060ea164932@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c06a5138-170e-d696-38f1-3060ea164932@redhat.com>
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

On Thu, Aug 03, 2023 at 09:38:20AM +0200, Thomas Huth wrote:
> On 03/08/2023 09.10, Milan Zamazal wrote:
> > Fabiano Rosas <farosas@suse.de> writes:
> > 
> > > Milan Zamazal <mzamazal@redhat.com> writes:
> > > 
> > > > The QEMU CI fails in virtio-scmi test occasionally.  As reported by
> > > > Thomas Huth, this happens most likely when the system is loaded and it
> > > > fails with the following error:
> > > > 
> > > >    qemu-system-aarch64: ../../devel/qemu/hw/pci/msix.c:659:
> > > >    msix_unset_vector_notifiers: Assertion
> > > > `dev->msix_vector_use_notifier && dev->msix_vector_release_notifier'
> > > > failed.
> > > >    ../../devel/qemu/tests/qtest/libqtest.c:200: kill_qemu() detected
> > > > QEMU death from signal 6 (Aborted) (core dumped)
> > > > 
> > > > As discovered by Fabiano Rosas, the cause is a duplicate invocation of
> > > > msix_unset_vector_notifiers via duplicate vu_scmi_stop calls:
> > > > 
> > > >    msix_unset_vector_notifiers
> > > >    virtio_pci_set_guest_notifiers
> > > >    vu_scmi_stop
> > > >    vu_scmi_disconnect
> > > >    ...
> > > >    qemu_chr_write_buffer
> > > > 
> > > >    msix_unset_vector_notifiers
> > > >    virtio_pci_set_guest_notifiers
> > > >    vu_scmi_stop
> > > >    vu_scmi_set_status
> > > >    ...
> > > >    qemu_cleanup
> > > > 
> > > > While vu_scmi_stop calls are protected by vhost_dev_is_started()
> > > > check, it's apparently not enough.  vhost-user-blk and vhost-user-gpio
> > > > use an extra protection, see f5b22d06fb (vhost: recheck dev state in
> > > > the vhost_migration_log routine) for the motivation.  Let's use the
> > > > same in vhost-user-scmi, which fixes the failure above.
> > > > 
> > > > Fixes: a5dab090e142 ("hw/virtio: Add boilerplate for vhost-user-scmi device")
> > > > Signed-off-by: Milan Zamazal <mzamazal@redhat.com>
> > > 
> > > Reviewed-by: Fabiano Rosas <farosas@suse.de>
> > 
> > Please note that this bug fix should IMO definitely go to 8.1, to not
> > have a bug in vhost-user-scmi and to not have broken tests.  Any chance
> > to get it merged?
> 
> If nobody else is planning a pull request with this patch included, I can
> take it for my next PR (since it is fixing the CI, I just saw another
> failure here:
> https://gitlab.com/qemu-project/qemu/-/jobs/4790457938#L4784 )
> 
>  Thomas
> 

I picked it up but if you like I can drop it.

-- 
MST


