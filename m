Return-Path: <qemu-devel-bounces+lists+qemu-devel=lfdr.de@nongnu.org>
X-Original-To: lists+qemu-devel@lfdr.de
Delivered-To: lists+qemu-devel@lfdr.de
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2D7B2278C
	for <lists+qemu-devel@lfdr.de>; Tue, 12 Aug 2025 14:58:13 +0200 (CEST)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uloZO-00046S-IS; Tue, 12 Aug 2025 08:57:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uloZJ-00046A-GT
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 08:57:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1uloZB-0003YH-5s
 for qemu-devel@nongnu.org; Tue, 12 Aug 2025 08:57:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755003438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9iNa96K1rabLNX47958kYkEO+RGHNx8CYIS7IVHq8Po=;
 b=dbzmVvfwppD5yKvrq+Q5n8ohCfcJtuhUMSXU7dh9nkQvh3JCYDakitDd6i0BV8RyIG2Pgr
 i/E6agZzXtkQaE/1QWKbkgavLwCkASeUV660CvCNevZFovxINfvDeDtet1hqWVrdVpTppN
 bxKuk/MkGFWwawJGtILJGk8qSTiGlHM=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-3-xJvcaxJBOMymfxS8upKhvA-1; Tue,
 12 Aug 2025 08:57:15 -0400
X-MC-Unique: xJvcaxJBOMymfxS8upKhvA-1
X-Mimecast-MFC-AGG-ID: xJvcaxJBOMymfxS8upKhvA_1755003434
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7CB0A19560B1; Tue, 12 Aug 2025 12:57:14 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.181])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BBAF6180028E; Tue, 12 Aug 2025 12:57:12 +0000 (UTC)
Date: Tue, 12 Aug 2025 14:57:10 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, manos.pitsidianakis@linaro.org, qemu-rust@nongnu.org
Subject: Re: [PATCH] configure: Don't disable Rust for too old meson version
Message-ID: <aJs6JkGsa414_4I7@redhat.com>
References: <20250811142923.89983-1-kwolf@redhat.com>
 <f85bd476-501a-4693-b830-6ab7a7168d94@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f85bd476-501a-4693-b830-6ab7a7168d94@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 12.08.2025 um 08:41 hat Paolo Bonzini geschrieben:
> On 8/11/25 16:29, Kevin Wolf wrote:
> > If the user explicitly specified --enable-rust, don't just fail if meson
> > is too old for Rust support, but do the same thing as if meson was too
> > old for the C code: Just download a newer one.
> > 
> > In order to avoid the additional download for people who aren't
> > intentionally opting in to Rust, keep the automatic disabling based on
> > the meson version as the default if neither --enable-rust nor
> > --disable-rust were given.
> 
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Are you going to submit the patch yourself?

If we want to have it in 10.1 (I don't see why not?), I'm going to send
a pull request today, so I could include it.

Kevin


