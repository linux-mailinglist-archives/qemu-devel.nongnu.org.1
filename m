Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 056FE82D36D
	for <lists+qemu-devel@lfdr.de>; Mon, 15 Jan 2024 04:39:33 +0100 (CET)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rPDoW-0003AD-OR; Sun, 14 Jan 2024 22:39:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPDoM-00039u-9z
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:38:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rPDoK-0007bE-Ls
 for qemu-devel@nongnu.org; Sun, 14 Jan 2024 22:38:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705289931;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=82yAsXxGE004DWKrDGBx4JRsEPiQiVLR9FQziLg2tpU=;
 b=NignsONrnAhmEa2/i7hm/15JuxofnGeyo68EHGhqaORFLhkmZ1ZsHCC9xiJThIJ6f7nVXO
 80ORFJ3CL0gENDwmTwBF5sjutDcBIt+zG6IW8IaUZ2wUl/rN12ONNKUCUJeBA8IkHJybQa
 AzzRXoOzmaM+um3HV2hPP2Gv0r8YYbc=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-Ga_FBQLgM6-T1SjG0bGQYw-1; Sun, 14 Jan 2024 22:38:49 -0500
X-MC-Unique: Ga_FBQLgM6-T1SjG0bGQYw-1
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-1d4d6b63051so19169985ad.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jan 2024 19:38:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705289928; x=1705894728;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=82yAsXxGE004DWKrDGBx4JRsEPiQiVLR9FQziLg2tpU=;
 b=Yogww5TGK5Tg93Uz3GTkNn+/O5iRXLgywst7swsKSRU9ap8FVF0Pr8YSJCOLWbwDar
 pU61+C15YMZx7zmXPx4yHHjxQH7rKbV0POKPdoc1whjpO7J8Q1gpamO8a9943/Iis2YA
 duIQr3iyikYVbF1RcA3a83aNWrzVzJD8RaDHDNl5DTIYElGb65jTKOAVWQVvfIDSaB6S
 ARVUJCa74CdH5zCCq1SF7DvJanY5h/JVPhB75X7rLTmavZB6ROi01h204+r13K92wac9
 6m2LdA+TuaKkiEfyZhZkf8v/k1GgMwMagu077tEUqLuhx7DQ7Mh8b2TIR9dm6Z48fNJT
 cvCw==
X-Gm-Message-State: AOJu0YweYYwbZHNtBcuRIcBrSs810QLxpzIetLjFW93q/SujGfczp0Eb
 UdqBjC0a4pmXzeZX1y+TnugOMvHF276H0oKHKL99oElHwuE/by7dtT6jdfk87Zk+2oKGlr6y9Ie
 Yk1IAHoecsFJvQ0HFeLtG/zc=
X-Received: by 2002:a17:902:b68d:b0:1d5:b82a:a53 with SMTP id
 c13-20020a170902b68d00b001d5b82a0a53mr6790692pls.5.1705289927893; 
 Sun, 14 Jan 2024 19:38:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHGFamsoZODJpAyLttdXQlO1dBBj+vKUDcNguAx8/qhv3j+LsGdGybk/QjsnSjukpnCByjl3A==
X-Received: by 2002:a17:902:b68d:b0:1d5:b82a:a53 with SMTP id
 c13-20020a170902b68d00b001d5b82a0a53mr6790679pls.5.1705289927549; 
 Sun, 14 Jan 2024 19:38:47 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 i10-20020a170902c94a00b001d538ee9ff3sm6691359pla.183.2024.01.14.19.38.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jan 2024 19:38:47 -0800 (PST)
Date: Mon, 15 Jan 2024 11:38:38 +0800
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 armbru@redhat.com, Juan Quintela <quintela@redhat.com>,
 Leonardo Bras <leobras@redhat.com>, Claudio Fontana <cfontana@suse.de>
Subject: Re: [RFC PATCH v3 04/30] io: fsync before closing a file channel
Message-ID: <ZaSovnKZ2zym8sW9@x1n>
References: <20231127202612.23012-1-farosas@suse.de>
 <20231127202612.23012-5-farosas@suse.de> <ZZ-qbom2UqEX0uS7@x1n>
 <87wmsfn1xx.fsf@suse.de> <ZaCBYLQd6CT9G9jF@x1n>
 <ZaEXHCsgKOCwrpAm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZaEXHCsgKOCwrpAm@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.758,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SORBS_WEB=1.5, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Fri, Jan 12, 2024 at 10:40:28AM +0000, Daniel P. Berrangé wrote:
> On Fri, Jan 12, 2024 at 08:01:36AM +0800, Peter Xu wrote:
> > On Thu, Jan 11, 2024 at 03:46:02PM -0300, Fabiano Rosas wrote:
> > > > (1) Does this apply to all io channel users, or only migration?
> > > 
> > > All file channel users.
> > 
> > I meant the whole idea of flushing on close, on whether there will be
> > iochannel users that will prefer not do so?  It's a matter of where to put
> > this best.
> 
> IMHO, all users of QIOChannelFile will benefit from flushing, to ensure
> integrity of their saved file upon host crash.

Thanks.  It might be nice to also mention that is for all purpose then in
the commit message (currently, it only mentions "for migration only"), some
description would be even nicer on why it services all purposes.

For example, I think it applies to all as long as we don't have use case
for frequent open/close of iochannels which may require a fast close(), so
all use cases will hope the sync to happen.

Then we could optionally also document above QIOChannelClass.io_close() on
the implied behavior.

When looking at that header, I noticed we used to have io_flush() for
zerocopy.  I'm wondering whether we should also do that for close() when
zerocopy is enabled.  This may mean that file sockets can also implement
io_flush(), then we call io_flush() in close() if ever existed.

Thanks,

-- 
Peter Xu


