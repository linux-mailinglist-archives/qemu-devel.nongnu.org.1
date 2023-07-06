Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DAFE74A3DB
	for <lists+qemu-devel@lfdr.de>; Thu,  6 Jul 2023 20:39:12 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1qHTrn-0006he-Io; Thu, 06 Jul 2023 14:38:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTrl-0006hD-In
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:38:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1qHTrk-0005Mq-6g
 for qemu-devel@nongnu.org; Thu, 06 Jul 2023 14:38:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688668687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hjRwF6ebnjFB2OJGwftocCiucIJXWTFR0MoxlGRUOJI=;
 b=FNLBe0qpQ2U1pQljldQIWOymhPbWMBS/603W+/Uk+zDExh86PBqE30ABr6any81stZ+iMv
 ptZGrsTnzcxxmPE4Q1KsO47DNY3ClCT+xMVi5kem59PP0+E18BWVBiRYwUjARfD8tZK+Pf
 pyi78TTCH39XlMGOjhaC6DcMoElskKw=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-LrbMYygUO9W-O8H2F_N5KA-1; Thu, 06 Jul 2023 14:38:06 -0400
X-MC-Unique: LrbMYygUO9W-O8H2F_N5KA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1b3bb17fc7dso251455fac.0
 for <qemu-devel@nongnu.org>; Thu, 06 Jul 2023 11:38:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688668685; x=1689273485;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hjRwF6ebnjFB2OJGwftocCiucIJXWTFR0MoxlGRUOJI=;
 b=BcCawpOwkx9tA1S5+l52cKWvLpUyQJrwcI1yCbaaSw5QW0ZyxOXxmFq7J/zwFz7wXk
 WcdmYNuqV+adphKic+6f5JcK3d12RuLkZ/gtpftD1mT1sBv+cb4z4eE4OJ6Ech5Ypc0k
 9FHW2zdLxUc6h/iSzIztEJm8eRJf2L3aF/VEI7ZlPmWCxZOaWS+YiUVeZic6qz80pmI4
 1GhezBA1pQnEaVWZc7pEQFWozItC8ZxH/XR75xcPrdUAaoo+SCy0l7AAnnPT+ynrRhtU
 j/TMvCtpK8LB/U6MfnNmB+ffPn4JhHItpMx9hpWHYqiDzRCs3559zQlOKMfBZddNlC0l
 5dJQ==
X-Gm-Message-State: ABy/qLZpnI4cMTvNt+kTr981pnBWmM0T+5NFOjp8+GYhmBgt8F4IRaog
 VOJ/59N0s7EP4bOte0amoF6Rncvcy6/k0uKrhLXhvr8D/A1RdNTWO0/LJtxHsidtIr+Gcls8ffC
 NHSTPOWDEg3OU1Lk=
X-Received: by 2002:a05:6870:230a:b0:1b3:afdc:6c08 with SMTP id
 w10-20020a056870230a00b001b3afdc6c08mr2816750oao.0.1688668685653; 
 Thu, 06 Jul 2023 11:38:05 -0700 (PDT)
X-Google-Smtp-Source: APBJJlE1hEls6dvCA9Uqjmnp3yNvlX7HBwcH+bF47VYwd3edcBMEcdRjTnXj97G+xVwPgjvZCwSEAA==
X-Received: by 2002:a05:6870:230a:b0:1b3:afdc:6c08 with SMTP id
 w10-20020a056870230a00b001b3afdc6c08mr2816734oao.0.1688668685385; 
 Thu, 06 Jul 2023 11:38:05 -0700 (PDT)
Received: from x1n (cpe5c7695f3aee0-cm5c7695f3aede.cpe.net.cable.rogers.com.
 [99.254.144.39]) by smtp.gmail.com with ESMTPSA id
 b6-20020ac86786000000b003f9b9d7f319sm860522qtp.70.2023.07.06.11.38.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Jul 2023 11:38:04 -0700 (PDT)
Date: Thu, 6 Jul 2023 14:38:02 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v3 2/6] tests/qtest: migration: Add migrate_incoming_qmp
 helper
Message-ID: <ZKcKCpJk2ypOf5H0@x1n>
References: <20230630212902.19925-1-farosas@suse.de>
 <20230630212902.19925-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230630212902.19925-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Jun 30, 2023 at 06:28:58PM -0300, Fabiano Rosas wrote:
> file-based migration requires the target to initiate its migration after
> the source has finished writing out the data in the file. Currently
> there's no easy way to initiate 'migrate-incoming', allow this by
> introducing migrate_incoming_qmp helper, similarly to migrate_qmp.
> 
> Also make sure migration events are enabled and wait for the incoming
> migration to start before returning. This avoid a race when querying
> the migration status too soon after issuing the command.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


