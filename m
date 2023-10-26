Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 3071C7D8979
	for <lists+qemu-devel@lfdr.de>; Thu, 26 Oct 2023 22:09:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qw6e5-00040N-Pt; Thu, 26 Oct 2023 16:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw6e3-0003zE-N2
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:07:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qw6dy-0008NX-Bx
 for qemu-devel@nongnu.org; Thu, 26 Oct 2023 16:07:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698350869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r2l8M2FQ9VajVtf2hM+rOKk+ztvgrZtBTOm6NrOh4Uc=;
 b=Vji2iBWOElpUp1OVr4sVAUBc+csAZLuLK4Xen6yShDheUjc0L6p3HEM+PfnjMVOyqCX4MQ
 pfYWzPkjxrPi4MsnfO5gZ92Dl9FNW9uy2vsbL44uq0WTUg49RMOMVO8WJ7DIVolLJxcTYl
 8NYQkWbpFYZTGQq460h2qDTPoLAzA+E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-464-9SZjo61oNKem8p8BC-ODzQ-1; Thu, 26 Oct 2023 16:07:32 -0400
X-MC-Unique: 9SZjo61oNKem8p8BC-ODzQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41cbafdb4b6so3135921cf.0
 for <qemu-devel@nongnu.org>; Thu, 26 Oct 2023 13:07:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698350852; x=1698955652;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r2l8M2FQ9VajVtf2hM+rOKk+ztvgrZtBTOm6NrOh4Uc=;
 b=LMPVE/yKE7eSytID8aGp1IRli9QZnCiB13i2uZVCY3WHCjloHPtGG+Wd5kfQ3EnO7J
 CYX8rO/HEEp1XO3lUY5Nm719d7ZTbouyCIIjlDLDBa36G9+22kJWI2c9QK2ow7XYCbMK
 uZo4yfMuFGBH+gn1yBGCl31F6hL6w1aC9YiugtUDNniPJAjtMm/OGkcZMAsc1J7ZiQhc
 rogIkPGIolW7Pftg0vN7VdZbDJv17/lSIamQb/RRIG70YEsiKzWXXnYzm5LyIMH/7poQ
 YLWOl/0jJ9jfIpTffw4FyW9FxCDc1AyCVSlpGRhrHQTa5EPBj1woyEsiarfKG9bFtTJ0
 g0iQ==
X-Gm-Message-State: AOJu0YyOzwpVWf7s7BL41EFLcFVIQXBg7rwoHIndfZjKT18GD3MvAGmm
 F8/46eNLhiWcAqcq1IXM2JBwDlE51hkPahECbPgoiEUYjb5P5TW7+PSfdYBdoLv9Sii+K0iWKkm
 f2tHlLNCmlyI4wpg=
X-Received: by 2002:ac8:5b8b:0:b0:412:d46:a8c3 with SMTP id
 a11-20020ac85b8b000000b004120d46a8c3mr593519qta.2.1698350852080; 
 Thu, 26 Oct 2023 13:07:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpNzzFTlPk5g7HCAz8UVl/d9CY5/qEu0Ehbs0UmSMBIatypfF144lTc/iPEHRUr14fE3y3vA==
X-Received: by 2002:ac8:5b8b:0:b0:412:d46:a8c3 with SMTP id
 a11-20020ac85b8b000000b004120d46a8c3mr593502qta.2.1698350851753; 
 Thu, 26 Oct 2023 13:07:31 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 c13-20020ac84e0d000000b0041aff9339a2sm33867qtw.22.2023.10.26.13.07.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Oct 2023 13:07:31 -0700 (PDT)
Date: Thu, 26 Oct 2023 16:07:29 -0400
From: Peter Xu <peterx@redhat.com>
To: Joao Martins <joao.m.martins@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Juan Quintela <quintela@redhat.com>
Subject: Re: [PATCH 0/3] migration: Downtime tracepoints
Message-ID: <ZTrHAbyDxLsDl007@x1n>
References: <20231026155337.596281-1-peterx@redhat.com>
 <c8d16910-a496-410c-9c1c-68661b81f030@oracle.com>
 <ZTqb/XDnwhkTUL3s@x1n> <ZTqtieZo/VaSscp5@x1n>
 <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <778f6c92-221c-41d2-b0ae-4f5f4a208f65@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 26, 2023 at 08:33:13PM +0100, Joao Martins wrote:
> Sure. For the fourth patch, feel free to add Suggested-by and/or a Link,
> considering it started on the other patches (if you also agree it is right). The
> patches ofc are enterily different, but at least I like to believe the ideas
> initially presented and then subsequently improved are what lead to the downtime
> observability improvements in this series.

Sure, I'll add that.

If you like, I would be definitely happy to have Co-developed-by: with you,
if you agree.  I just don't know whether that addressed all your need, and
I need some patch like that for our builds.

Thanks,

-- 
Peter Xu


