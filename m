Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id E45E577EC60
	for <lists+qemu-devel@lfdr.de>; Wed, 16 Aug 2023 23:57:32 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qWOUn-0000ys-9b; Wed, 16 Aug 2023 17:56:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWOUi-0000xz-Kw
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:56:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qWOUe-0003ES-PY
 for qemu-devel@nongnu.org; Wed, 16 Aug 2023 17:56:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1692222954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zxuzjgQJF1LS7USEoDFeilAyvzSnCDk4fA04BqbpXTI=;
 b=PMBI4c9ZYchuXlL6etbxqfaIH3bZZwLzUdDtvfq7gjr/8D78cZLHBo9Dbl16vb2cA+FVt1
 hvZZWWsu4XIh8DvT8C7KqQGtd3FkYi+eJfEpE7kd4kNXjMqfZ/7CcXZ9RW6g/G4aCKwcYZ
 rnfHDkFN4iK2mbi9N8Ptwu8g44xqf6A=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-HYERpKdnN8C1rldsXwUmpw-1; Wed, 16 Aug 2023 17:55:52 -0400
X-MC-Unique: HYERpKdnN8C1rldsXwUmpw-1
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-40fe7fa05edso19999111cf.0
 for <qemu-devel@nongnu.org>; Wed, 16 Aug 2023 14:55:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1692222951; x=1692827751;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zxuzjgQJF1LS7USEoDFeilAyvzSnCDk4fA04BqbpXTI=;
 b=broeQZbfouDSd6YH7uWuVPveiaIqYncUCsMcywFNeJbxQ4StOBc/30VwkDM8P65tCV
 l31A4X+J66G3oIW+WSl3zs/tn9vY7cnV0MNMMPm4qO8MQdEn1RLG+gMqseXhgz2M7Qrj
 CvVPgmbg9cvOQ4BbZ6Lb/UnB074qd0EoHmlPjILY36BpKwd7tOjpC5WCp/mFl5bYYICF
 hGeQH5jtulSSaU/WojFRlS0VGaBL+rS3z11EAFhv31ocqLVlUu8jB/nJxrvEOxztEZ64
 i3B+Bl/arIkNEHD3ey+GP4XukGYCeeDDdcIeZq/oPnorDKwqNH2VhpF6i+hWlWlZgrpC
 O6Cw==
X-Gm-Message-State: AOJu0YzkfOmZp/CJplpBlBxAZJv2fcv+CZ64emtacbiw4AaSlpr6tl8N
 5E5DCkqUe4T38XqIspLhB0yevwCDK0C+3Nga7jnYYzCubnrzbOFBdneS8E2dSD1zC2uaaoIuy0q
 Mh/MiMU+OuM4B9DM=
X-Received: by 2002:ac8:5bc4:0:b0:40a:6359:2120 with SMTP id
 b4-20020ac85bc4000000b0040a63592120mr4190441qtb.0.1692222951556; 
 Wed, 16 Aug 2023 14:55:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJZAbf8Bo4aqkvM9OnY08rDuh2O3atry5bn78SZIou+AWPOaXRVOLYlB0m177wyhcLjJwRKA==
X-Received: by 2002:ac8:5bc4:0:b0:40a:6359:2120 with SMTP id
 b4-20020ac85bc4000000b0040a63592120mr4190426qtb.0.1692222951340; 
 Wed, 16 Aug 2023 14:55:51 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 h8-20020ac85148000000b0040ff387de83sm4752325qtn.45.2023.08.16.14.55.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Aug 2023 14:55:51 -0700 (PDT)
Date: Wed, 16 Aug 2023 17:55:49 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH v4 8/8] migration: Add a wrapper to cleanup migration files
Message-ID: <ZN1F5QqKE6Uzlwdk@x1n>
References: <20230816142510.5637-1-farosas@suse.de>
 <20230816142510.5637-9-farosas@suse.de> <ZNzot6bDD15S3U7u@x1n>
 <87leealt8h.fsf@suse.de> <ZN0k/DFQQIeEpgjl@x1n>
 <ZN0lgcI3Ieksdbv/@x1n> <87edk24rb9.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87edk24rb9.fsf@suse.de>
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

On Wed, Aug 16, 2023 at 06:20:58PM -0300, Fabiano Rosas wrote:
> > One more thing to mention is, now I kind of agree probably we should
> > register yank over each qemufile, as you raised the concern in the other
> > thread that otherwise qmp_yank() won't set error for the qemufile, which
> > seems to be unexpected.
> 
> I haven't made up my mind yet, but I think I'd rather stop setting that
> error instead of doing it from other places. A shutdown() is mostly a
> benign operation intended to end the connection. The fact that we use it
> in some cases to kick the thread out of a possible hang doesn't seem
> compelling enough to set -EIO.
> 
> Of course we currently have no other way to indicate that the file was
> shutdown, so the -EIO will have to stay and that's a discussion for
> another day.

Yes, if we can avoid setting -EIO at all when shutdown that'll also be
good, maybe making more sense.  Thanks,

-- 
Peter Xu


