Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 4899A709B5F
	for <lists+qemu-devel@lfdr.de>; Fri, 19 May 2023 17:32:24 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1q025L-0004uj-Ss; Fri, 19 May 2023 11:32:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q0259-0004sT-SA
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:31:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1q0257-0007IT-Bb
 for qemu-devel@nongnu.org; Fri, 19 May 2023 11:31:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684510308;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fKNnCBWgNe+EhObsDpBYnFiWlP3r2l9L+1NJnVdzuWg=;
 b=RLCKmhwPWeCQtY490Jn/yltQl0+BtETABmiT5fWnJWDkIKOHFwTJ2254XVy0yioVxo0BmP
 P3uHcHjp/Q+haY0jGtmEn0Qh8y7rD33s8ux4FEvyobVQ7BmsyqG8q5lbmeqBZaM5ex/xg4
 6QPxBvfcjc27ZRaY2cJD2czPksghLY8=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-iiToE1_TM7-JcNqADO4etQ-1; Fri, 19 May 2023 11:31:47 -0400
X-MC-Unique: iiToE1_TM7-JcNqADO4etQ-1
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-559dfab5ad8so2324387b3.1
 for <qemu-devel@nongnu.org>; Fri, 19 May 2023 08:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684510306; x=1687102306;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fKNnCBWgNe+EhObsDpBYnFiWlP3r2l9L+1NJnVdzuWg=;
 b=X39oHTH35HuVaLAUdGRh0TUF6cz3NJdLW58dQDyPnO2xvTg3CCdC/sMZKX1anVk1ZB
 wS+6o3dHZhrqkNS4UZfP4p08c4YwmH7BI/LDoyhBEtt3erz4wGAHrd+F5GGTzVqOTLra
 71Krd7ipmqQNXZcTrvIw/hF0TzVFk6AlW0WzGjzAsHzfjJd+x9SVKYg/Lk1A89kGpErl
 gkmMDOxsJhVfMKISVi4+xSqgGUwcwFVPdNSQBrOYwDgYqzYJ4msNWzF88W4weXV1JlZr
 eQ/4skMCZneLRNI3Oov8DyvvhEe9Q1S/bifqF9l4bez5ntsLkgoWeZFt8zmEfLBXEirE
 5tEw==
X-Gm-Message-State: AC+VfDyIxdEDldbhcYM7pB2pGcIChomUd+GtooEpAaIG2IIiDiCTmOyt
 cm9Cu/gfgRWvewywgsUw3EhRyFAwOyYjwbXq1YTkRz6y1HxZ1ITdfJnDZtkQ12fukLp+ryEEDS1
 qC5KhMAmWTjSHgxo=
X-Received: by 2002:a05:7508:11c8:b0:55:c40a:c91e with SMTP id
 cf8-20020a05750811c800b00055c40ac91emr90707gbb.0.1684510306605; 
 Fri, 19 May 2023 08:31:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5H7WJToKCpaF+vClKLUbhSUaf5Tr9jA2PoQM/ctTLcah3ZnmBEaLpJ0a/Xnm5fFT8yDnNavg==
X-Received: by 2002:a05:7508:11c8:b0:55:c40a:c91e with SMTP id
 cf8-20020a05750811c800b00055c40ac91emr90698gbb.0.1684510306204; 
 Fri, 19 May 2023 08:31:46 -0700 (PDT)
Received: from x1n (bras-base-aurron9127w-grc-62-70-24-86-62.dsl.bell.ca.
 [70.24.86.62]) by smtp.gmail.com with ESMTPSA id
 b15-20020a05620a126f00b0075936b3026fsm1185794qkl.38.2023.05.19.08.31.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 May 2023 08:31:45 -0700 (PDT)
Date: Fri, 19 May 2023 11:31:44 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, quintela@redhat.com,
 lei4.wang@intel.com, qemu-devel@nongnu.org
Subject: Re: [PATCH v1] migration: fail the cap check if it requires the use
 of deferred incoming
Message-ID: <ZGeWYAxayubPceOk@x1n>
References: <20230518160026.57414-1-wei.w.wang@intel.com>
 <ZGZ6Yqx2+dOp+Q73@x1n> <ZGcyr9d2qpYpV5As@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZGcyr9d2qpYpV5As@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, May 19, 2023 at 09:26:23AM +0100, Daniel P. Berrangé wrote:
> On Thu, May 18, 2023 at 03:20:02PM -0400, Peter Xu wrote:
> > On Fri, May 19, 2023 at 12:00:26AM +0800, Wei Wang wrote:
> > > qemu_start_incoming_migration needs to check the number of multifd
> > > channels or postcopy ram channels to configure the backlog parameter (i.e.
> > > the maximum length to which the queue of pending connections for sockfd
> > > may grow) of listen(). So multifd and postcopy-preempt caps require the
> > > use of deferred incoming, that is, calling qemu_start_incoming_migration
> > > should be deferred via qmp or hmp commands after the cap of multifd and
> > > postcopy-preempt are configured.
> > > 
> > > Check if deferred incoming is used when enabling multifd or
> > > postcopy-preempt, and fail the check with error messages if not.
> > > 
> > > Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > 
> > IIUC this will unfortunately break things like:
> > 
> >   -global migration.x-postcopy-preempt=on
> > 
> > where the cap is actually applied before incoming starts even with !defer
> > so it should still work.
> > 
> > Can we just make socket_start_incoming_migration_internal() listen on a
> > static but larger value?
> 
> Why do we need todo that ? I thought we just determined the problem was
> a configuration error, not a code error.

Yes, sorry I just read the other thread for more context.  So it seems my
concern wasn't really a concern anyway, now I'm fine with the current
approach.  Thanks,

-- 
Peter Xu


