Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E2378F3CF
	for <lists+qemu-devel@lfdr.de>; Thu, 31 Aug 2023 22:18:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qbo6Z-0000uB-FK; Thu, 31 Aug 2023 16:17:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbo6X-0000to-Tg
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:17:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qbo6T-0008FP-TR
 for qemu-devel@nongnu.org; Thu, 31 Aug 2023 16:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693513040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5a/SwKv6GUP+JWqMoj3PY4osU8HvXRNVst9zAGspjno=;
 b=OwZH/EdVqO4Vt62TaqBi8Yw+Fs2bcXxAXDuXmlu6mfWjS4zU6GuwNRPcQ3xjArLun7Ppm3
 pXQNwBG/rxWK0LUb7Op4VDx42auLUmkorOhS0f8QqzdZ+d7LbEnYySdyfHizNJuK6shYX3
 fqapXd2yU7GaTJ/0s+cZmp55SkoP8+Y=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-uocOb71SOGSjgFmffSNgjA-1; Thu, 31 Aug 2023 16:17:19 -0400
X-MC-Unique: uocOb71SOGSjgFmffSNgjA-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-64a4269ca98so3068986d6.0
 for <qemu-devel@nongnu.org>; Thu, 31 Aug 2023 13:17:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693513039; x=1694117839;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5a/SwKv6GUP+JWqMoj3PY4osU8HvXRNVst9zAGspjno=;
 b=S0jEu2HVe35nK2Zg5lbfJb7QziXmdERgSV61u+gG08/OAtOrbs4tkHP25/eYxOXmUn
 3W8tKxaC7ah3/ik0baB45Y8M3pq6Khdvgqr4U1SQA+M3XHK1Sa6qDbzFqWP2v8T5iCDV
 C71l1ENxTRRgoE3Q8tZOfO4Nzgv+WydeHgvwb1XYPPugwL3QiudN3vtkRyh0PEBlVg2z
 vwwh6w27zVVFTf+HU/oApVBZkXeDinY6y5aOCnHVLG3Fci5TrOTj8U0DeQx+D9owBLhi
 I9Ap12+OcrUdc9F+UVdehvhNC6bVwRR6FfQwM78V4QaDSPGyKF8KObOxjRzQdCPc3rKt
 z0JQ==
X-Gm-Message-State: AOJu0YynZZ1I5J//GVPTbLekF16AZ0g95wPsGZE6EWRlJlJcmE/leLEn
 jga6VVKwv2n4n25LEznl2z487F6yHfnnJ22uZtlQVYIQ8BUcScQR0E2eSkLt9mN3h1cUnX6/ZO+
 mq3C7H8fk4fylTO4=
X-Received: by 2002:ad4:5e87:0:b0:616:870c:96b8 with SMTP id
 jl7-20020ad45e87000000b00616870c96b8mr283051qvb.3.1693513038823; 
 Thu, 31 Aug 2023 13:17:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKsmxbV+DJ7b6GRufNNcqu4EXMeqeuic2S33WKPblsBhfVhu2iLfQSsXd6CNYuiszcB6i/5Q==
X-Received: by 2002:ad4:5e87:0:b0:616:870c:96b8 with SMTP id
 jl7-20020ad45e87000000b00616870c96b8mr283012qvb.3.1693513038588; 
 Thu, 31 Aug 2023 13:17:18 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 r20-20020a0cb294000000b0063d152e5d9asm879005qve.120.2023.08.31.13.17.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 31 Aug 2023 13:17:18 -0700 (PDT)
Date: Thu, 31 Aug 2023 16:17:16 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, kwolf@redhat.com, hreitz@redhat.com,
 eblake@redhat.com, vsementsov@yandex-team.ru, jsnow@redhat.com,
 idryomov@gmail.com, pl@kamp.de, sw@weilnetz.de,
 sstabellini@kernel.org, anthony.perard@citrix.com, paul@xen.org,
 pbonzini@redhat.com, marcandre.lureau@redhat.com,
 berrange@redhat.com, thuth@redhat.com, philmd@linaro.org,
 stefanha@redhat.com, fam@euphon.net, quintela@redhat.com,
 leobras@redhat.com, kraxel@redhat.com, qemu-block@nongnu.org,
 xen-devel@lists.xenproject.org, alex.bennee@linaro.org,
 peter.maydell@linaro.org
Subject: Re: [PATCH 1/7] migration/rdma: Fix save_page method to fail on
 polling error
Message-ID: <ZPD1TPNFFVax067G@x1n>
References: <20230831132546.3525721-1-armbru@redhat.com>
 <20230831132546.3525721-2-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230831132546.3525721-2-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Thu, Aug 31, 2023 at 03:25:40PM +0200, Markus Armbruster wrote:
> qemu_rdma_save_page() reports polling error with error_report(), then
> succeeds anyway.  This is because the variable holding the polling
> status *shadows* the variable the function returns.  The latter
> remains zero.
> 
> Broken since day one, and duplicated more recently.
> 
> Fixes: 2da776db4846 (rdma: core logic)
> Fixes: b390afd8c50b (migration/rdma: Fix out of order wrid)
> Signed-off-by: Markus Armbruster <armbru@redhat.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


