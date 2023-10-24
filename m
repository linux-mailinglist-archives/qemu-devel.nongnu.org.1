Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 697C77D572A
	for <lists+qemu-devel@lfdr.de>; Tue, 24 Oct 2023 18:00:02 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qvJno-000074-JL; Tue, 24 Oct 2023 11:58:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJnj-0008Nh-Ce
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:58:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qvJnh-0002tw-PE
 for qemu-devel@nongnu.org; Tue, 24 Oct 2023 11:58:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698163116;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Yr8oQ6nhTmDH+9+o225ltfoHWB91gBvPe5ZhvG4EGcE=;
 b=QydvqPUEL6+WAVtazmG7VE5jrGUo2EnUymUa7hphfYbTytTvpab4Y5tygp7IHfCDO8aiHh
 Gp7ZT4s1WUaFaLsw5IhX6EpIkWJ52A0Di7TeqeC/CdHPqPkGljsyJoQdoIeNRARTkm59EK
 Vs/j5NvcxCKXJ+HvjaUq0K86fGQ9i3U=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-V1IwDd7ZOgymg_a5THYe4g-1; Tue, 24 Oct 2023 11:58:35 -0400
X-MC-Unique: V1IwDd7ZOgymg_a5THYe4g-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-41cbafdb4b6so11967111cf.0
 for <qemu-devel@nongnu.org>; Tue, 24 Oct 2023 08:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698163115; x=1698767915;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Yr8oQ6nhTmDH+9+o225ltfoHWB91gBvPe5ZhvG4EGcE=;
 b=eHgTeyojDZ8itFJra8l0ChTpUjkq6EamCjN6VBXtoU8PDhWpo4wAAxi1bP+O3PeAzU
 B6b9AcVXGCyBwjBhqy2lmIBtN7HpGqPDazySf6GX7FaP4Q3l4ROtoTdxYuQXw8Wo1PtM
 mL8Rbbtyt7az0KRtMGsgN1XyAL4Sb6RJAagfT9Xh+8cP3v4XgTmyeejrm3sxR3l9KeS/
 FxFcljLGcMb4CozBeJ+Gxim5W8qF/B7guaQxJ4d8ShCLc++qpqAWFYt2H+jCv8f593m9
 wCjsC4rc16Oqwx5Ov2kDx3jk8UJ2bHlxBS7ZQEnDa4w+QK/Kn02atdrCcySV9PPykLXj
 qQJQ==
X-Gm-Message-State: AOJu0YzCictLx6MqEa6CJbLy9CLA2JOoO1u/E9J0hJJeBO9ld4CEZGS8
 IJf4VEik2XG96gsmxHqEUjx2u9HVMIH/pdVsCxG3nNAo6AGaI6sM3VG6BoBeDMVYuQBsbkkHMid
 Fp2KmtpjuN6c3nes=
X-Received: by 2002:ad4:5907:0:b0:66d:1bbb:e9f8 with SMTP id
 ez7-20020ad45907000000b0066d1bbbe9f8mr12585279qvb.6.1698163114909; 
 Tue, 24 Oct 2023 08:58:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHyB4cGUSP8d9GOThp53VDV9g1trhNXCu6KRCg9hZUtwyED3QZLktg2rOc2SQjOHHAdQF+aXQ==
X-Received: by 2002:ad4:5907:0:b0:66d:1bbb:e9f8 with SMTP id
 ez7-20020ad45907000000b0066d1bbbe9f8mr12585255qvb.6.1698163114566; 
 Tue, 24 Oct 2023 08:58:34 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r13-20020a0cf60d000000b0065b12c7a48dsm3694039qvm.133.2023.10.24.08.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 08:58:34 -0700 (PDT)
Date: Tue, 24 Oct 2023 11:58:32 -0400
From: Peter Xu <peterx@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Zhijian Li <lizhijian@fujitsu.com>,
 Markus Armbruster <armbru@redhat.com>, Juan Quintela <quintela@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] migration: Stop migration immediately in RDMA error paths
Message-ID: <ZTfpqDntHPoYIKFh@x1n>
References: <20231024153313.500783-1-peterx@redhat.com>
 <d4624b9a-ca5c-4576-b86e-a5290de7a81e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d4624b9a-ca5c-4576-b86e-a5290de7a81e@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Tue, Oct 24, 2023 at 05:40:09PM +0200, Thomas Huth wrote:
> > @@ -3240,9 +3242,10 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
> >           ram_flush_compressed_data(rs);
> > -        rdma_reg_ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> > -        if (rdma_reg_ret < 0) {
> > +        ret = rdma_registration_stop(f, RAM_CONTROL_FINISH);
> > +        if (ret < 0) {
> >               qemu_file_set_error(f, rdma_reg_ret);
> 
> I think you have to replace rdma_reg_ret here with ret again?

Yeah.. v2 was sent already, sorry for the noise.

-- 
Peter Xu


